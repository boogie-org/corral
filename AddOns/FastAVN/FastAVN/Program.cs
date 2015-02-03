using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using btype = Microsoft.Boogie.Type;
using System.IO;
using System.Threading;
using System.Collections.Concurrent;

namespace FastAVN
{
    class Driver
    {
        public class Utils
        {
            const bool SUPPRESS_DEBUG_MESSAGES = false;
            public enum PRINT_TAG { AV_WARNING, AV_DEBUG, AV_OUTPUT, AV_STATS };
            public static void Print(string msg, PRINT_TAG tag = PRINT_TAG.AV_DEBUG)
            {
                if (tag != PRINT_TAG.AV_DEBUG || !SUPPRESS_DEBUG_MESSAGES)
                    Console.WriteLine("[TAG: {0}] {1}", tag, msg);
            }
        }

        class Stats
        {
            public static int numProcs = -1;
            public static int numAssertsBeforeAliasAnalysis = -1;
            public static int numAssertsAfterAliasAnalysis = -1;
            public static int numAssertsAfterHoudiniPass = -1;

            public static Dictionary<string, int> numAssertsPerProc = new Dictionary<string, int>();
            public static Dictionary<string, double> timeTaken = new Dictionary<string, double>();
            private static Dictionary<string, DateTime> clocks = new Dictionary<string, DateTime>();
            private static Dictionary<string, long> counts = new Dictionary<string, long>();

            public static void resume(string name)
            {
                clocks[name] = DateTime.Now;
            }

            public static void stop(string name)
            {
                Debug.Assert(clocks.ContainsKey(name));
                if (!timeTaken.ContainsKey(name)) timeTaken[name] = 0; // initialize
                timeTaken[name] += (DateTime.Now - clocks[name]).TotalSeconds;
            }

            public static void printStats()
            {
                Utils.Print("*************** STATS ***************", Utils.PRINT_TAG.AV_STATS);
                foreach (string name in timeTaken.Keys)
                {
                    Utils.Print(string.Format("{0}(s) : {1}", name, timeTaken[name]), Utils.PRINT_TAG.AV_STATS);
                }
                foreach (string name in counts.Keys)
                {
                    Utils.Print(string.Format("{0} : {1}", name, counts[name]), Utils.PRINT_TAG.AV_STATS);
                }
                Utils.Print("*************************************", Utils.PRINT_TAG.AV_STATS);
            }

            public static void count(string name)
            {
                if (!counts.ContainsKey(name)) counts[name] = 0;
                counts[name]++;
            }
        }

        static int timeout = 0; // system timeout
        static int avnTimeout = 200; // default AVN timeout
        static int approximationDepth = -1; // k-depth: default infinity
        static int verbose = 1; // default verbosity level
        static string avnPath = null; // path to AVN binary
        static string psexecPath = null; // path to psexec
        static bool dumpSlices = true; // dump sliced program for each entrypoint
        static readonly string bugReportFileName = "results.txt"; // default bug report filename produced by AVN
        static string avnArgs = ""; // default AVN arguments
        static string mergedBugReportName = "bugs.txt";
        static string mergedBugReportCSV = "results.csv";
        static int numThreads = 4; // default number of parallel AVN instances
        private static string CORRAL_EXTRA_INIT = "corralExtraInit";
        static bool fieldNonNull = true; // include angelic field non-null harness
        static bool outputToFile = false; // dump AVN output to disk
        static string angelic = "Angelic";
        static string trace_extension = ".tt";
        static string bug_folder = "Bugs";
        static string bug_filename = "Bug";
        static string angelic_stack = "stack";
        static string stack_extension = ".txt";
        static bool prune = false;
        static string stubsfile = null;
        static bool cleanupDir = true;
        static FastAvnConfig config = null;

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("Usage: FastAVN file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/prune"))
                prune = true;

            args.Where(s => s.StartsWith("/stubPath:"))
                .Iter(s => stubsfile = s.Substring("/stubPath:".Length));

            args.Where(s => s.StartsWith("/aopt:"))
                .Iter(s => avnArgs += " /" + s.Substring("/aopt:".Length) + " ");

            // user definded verbose level
            args.Where(s => s.StartsWith("/verbose:"))
                .Iter(s => verbose = int.Parse(s.Substring("/verbose:".Length)));

            // user defined AVN timeout
            args.Where(s => s.StartsWith("/timeout:"))
                .Iter(s => timeout = int.Parse(s.Substring("/timeout:".Length)));

            // depth k used by implementation pruning
            args.Where(s => s.StartsWith("/depth:"))
                .Iter(s => approximationDepth = int.Parse(s.Substring("/depth:".Length)));

            // user defined path to AVN binary
            args.Where(s => s.StartsWith("/avnPath:"))
                .Iter(s => avnPath = s.Substring("/avnPath:".Length));

            args.Where(s => s.StartsWith("/numThreads:"))
                .Iter(s => numThreads = int.Parse(s.Substring("/numThreads:".Length)));

            // Get config for remote execution
            args.Where(s => s.StartsWith("/config:"))
                .Iter(s => config = FastAvnConfig.DeSerialize(s.Substring("/config:".Length)));

            if (args.Any(s => s == "/noFieldNonNull"))
                fieldNonNull = false;

            if (args.Any(s => s == "/dumpAVNOutput"))
                outputToFile = true;

            if (args.Any(s => s == "/dumpAVNFiles"))
                cleanupDir = false;

            // default args
            avnArgs += " /dumpResults:" + bugReportFileName + " ";

            // Find AVN executable
            findAvn();
            Debug.Assert(avnPath != null);

            Program prog = null;
            try
            {
                Stats.resume("fastavn");
                // Get input program
                Utils.Print(String.Format("----- Run FastAVN on {0} with k={1} ------",
                    args[0], approximationDepth), Utils.PRINT_TAG.AV_OUTPUT);

                // Setup Boogie and corral
                AngelicVerifierNull.Driver.InitializeCorral();

                prog = AngelicVerifierNull.Driver.GetInputProgram(args[0], stubsfile); // get the input program

                if (prune)
                {
                    try
                    {
                        prog = PruneProgram(prog);
                    }    
                    catch (OutOfMemoryException e)
                    {
                        Console.WriteLine("Exception: {0}", e.Message);
                        // recover the program
                        prog = AngelicVerifierNull.Driver.GetInputProgram(args[0], stubsfile);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Exception: {0}", e.Message);
                        // recover the program
                        prog = AngelicVerifierNull.Driver.GetInputProgram(args[0], stubsfile);
                    }
                }

                // do reachability analysis on procedures
                // prune deep (depth > K) implementations: treat as angelic
                sliceAndRunAVN(prog, approximationDepth);

                Stats.stop("fastavn");
                Stats.printStats();
            }
            catch (Exception e)
            {
                //stacktrace containts source locations, confuses regressions that looks for AV_OUTPUT
                Utils.Print(String.Format("FastAVN failed with: {0}", e.Message), Utils.PRINT_TAG.AV_OUTPUT);
                Utils.Print(String.Format("FastAVN failed with: {0}", e.Message + e.StackTrace), Utils.PRINT_TAG.AV_DEBUG);
            }
        }

        // Prune assertions (using AA) and entrypoints
        private static Program PruneProgram(Program prog)
        {
            // Stats
            var start = DateTime.Now;
            Console.WriteLine("FastAVN: Asserts before AA: {0}", AngelicVerifierNull.Instrumentations.AssertCountVisitor.Count(prog));
            Console.WriteLine("FastAVN: EntryPoints before AA: {0}", prog.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                .Count());

            BoogieUtil.DoModSetAnalysis(prog);

            // Take snapshot in a persistent program
            var inputProg = new PersistentProgram(prog, "", 1);

            // Lets add the harness (and stub implementations). These will be used by AA.
            var harnessName = AngelicVerifierNull.AvnAnnotations.CORRAL_MAIN_PROC;
            var harnessInstrumentation =
                new AngelicVerifierNull.Instrumentations.HarnessInstrumentation(prog, harnessName, true);
            harnessInstrumentation.DoInstrument();

            // Re-resolve
            prog = (new PersistentProgram(prog, "", 1)).getProgram();

            // Run AA
            AliasAnalysis.AliasAnalysisResults res = null;

            // Do SSA
            prog =
                SSA.Compute(prog, PhiFunctionEncoding.Verifiable, new HashSet<string> { "int" });

            // Make sure that aliasing queries are on identifiers only
            var af =
                AliasAnalysis.SimplifyAliasingQueries.Simplify(prog);

            // Do AA
            res =
              AliasAnalysis.AliasAnalysis.DoAliasAnalysis(prog);

            // Get back the input program, resolve aliasing queries
            var origProgram = inputProg.getProgram();
            AliasAnalysis.PruneAliasingQueries.Prune(origProgram, res, false);

            // remove unreachable procedures (because of indirect call resolution)
            BoogieUtil.pruneProcs(origProgram, harnessInstrumentation.entrypoints);

            // Put inside a persistent program
            inputProg = new PersistentProgram(origProgram, "", 1);

            // Run Houdini
            var progAfter = AngelicVerifierNull.Driver.RunHoudiniPass(inputProg).getProgram();

            // prune entrypoints
            var canReachAssert = BoogieUtil.procsThatMaySatisfyPredicate(progAfter, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));
            var epCannotReachAssert = harnessInstrumentation.entrypoints.Difference(canReachAssert);
            Console.WriteLine("Pruning away {0} entry points as they cannot reach an assert", epCannotReachAssert.Count);
            progAfter.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => epCannotReachAssert.Contains(impl.Name))
                .Iter(impl =>
                    {
                        impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                        impl.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Attributes);
                    });
            BoogieUtil.pruneProcs(progAfter, harnessInstrumentation.entrypoints.Intersection(canReachAssert));

            // Set flag to stop AA
            avnArgs += " /noAA ";

            // Stats
            Console.WriteLine("FastAvn: AA took {0} seconds", (DateTime.Now - start).TotalSeconds.ToString("F2"));
            Console.WriteLine("FastAVN: Asserts after AA: {0}", AngelicVerifierNull.Instrumentations.AssertCountVisitor.Count(progAfter));
            Console.WriteLine("FastAVN: EntryPoints after AA: {0}", progAfter.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                .Count());

            return progAfter;
        }

        // locate AVN binary in the system
        private static void findAvn()
        {
            if (avnPath != null)
            {
                if (!File.Exists(avnPath))
                    throw new FileNotFoundException("Cannot find executable of AVN: " + avnPath + "!");
                return;
            }
            var avn = "AngelicVerifierNull.exe";
            var runDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            if (!File.Exists(Path.Combine(runDir, avn)))
            {
                var enviromentPath = System.Environment.GetEnvironmentVariable("PATH"); // look up in PATH
                var paths = enviromentPath.Split(';');
                avnPath = paths.Select(x => Path.Combine(x, avn))
                    .Where(x => File.Exists(x))
                    .FirstOrDefault();

                if (string.IsNullOrWhiteSpace(avnPath))
                    throw new FileNotFoundException("Cannot find executable of AVN!");
            }
            else
            {
                avnPath = Path.Combine(runDir, avn);
            }
            Utils.Print(String.Format("Found AVN at: {0}", avnPath));

            if (!File.Exists(Path.Combine(runDir, "psexec.exe")))
                throw new FileNotFoundException("Cannot find PSEXEC!");
            psexecPath = Path.Combine(runDir, "psexec.exe");
        }

        static ConcurrentBag<string> Shuffle(ConcurrentBag<string> bag)
        {
            var b = new List<string>(bag);
            var ret = new ConcurrentBag<string>();
            var rand = new Random();
            while (b.Count != 0)
            {
                var r = rand.Next(b.Count);
                ret.Add(b[r]);
                b.RemoveAt(r);
            }
            return ret;
        }

        public static ConcurrentDictionary<string, int> mergedBugs = new ConcurrentDictionary<string, int>();
        public static Dictionary<string, HashSet<string>> edges = null;
        public static HashSet<string> remotedirs = new HashSet<string>();
        public static string fslock = "FileSystemLock";
        public static readonly bool debug = false;

        /// <summary>
        /// Run AVN binary on sliced programs
        /// </summary>
        /// <param name="prog">Original program</param>
        /// <param name="approximationDepth">Depth k beyond which angelic approximation is applied</param>
        private static void sliceAndRunAVN(Program prog, int approximationDepth)
        {
            edges = buildCallGraph(prog);
            
            // Create a list of resources
            var worklist = new ConcurrentBag<string>();
            
            for (int i = 0; i < numThreads; i++) worklist.Add(Directory.GetCurrentDirectory());
            if (config != null)
            {
                foreach (var r in config.RemoteRoots)
                {
                    remotedirs.Add(r.dir);
                    for (int i = 0; i < r.Threads; i++) worklist.Add(r.dir);
                }
            }

            worklist = Shuffle(worklist);

            // Install FASTAVN
            foreach (var rd in remotedirs)
            {
                Console.WriteLine("Installing on {0}", rd);
                Directory.CreateDirectory(Path.Combine(rd, "fastavn"));
                RemoteExec.CopyFolder(Path.GetDirectoryName(avnPath), Path.Combine(rd, "fastavn"), true);
            }

            // max threads
            var threadsToSpawn = worklist.Count;

            // semaphore for limiting at most numThreads threads running at one time on local machine
            var sem = new Semaphore(numThreads, numThreads);

            // entrypoints
            var entrypoints = new ConcurrentBag<Implementation>(
                prog.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(x => QKeyValue.FindBoolAttribute((x as Implementation).Proc.Attributes, "entrypoint")));
            var epNames = new HashSet<string>(entrypoints.Select(impl => impl.Name));

            var threads = new List<Thread>();
            for (int i = 0; i < threadsToSpawn; i++)
            {
                var w = new Worker(prog, entrypoints, worklist, sem);
                threads.Add(new Thread(new ThreadStart(w.Run)));
            }

            threads.Iter(t => t.Start());
            threads.Iter(t => t.Join());

            /*
            Parallel.ForEach(prog.TopLevelDeclarations.Where(x => x is Implementation && 
                QKeyValue.FindBoolAttribute((x as Implementation).Proc.Attributes, "entrypoint")),
                new ParallelOptions { MaxDegreeOfParallelism = threadsToSpawn }, i =>
            {
                var impl = (Implementation)i;

                var rd = "";
                while (!worklist.TryTake(out rd)) { Thread.Sleep(100);  }

                sem.WaitOne();

                var wd = Path.Combine(rd, impl.Name); // create new directory for each entrypoint

                // slice the program by entrypoints
                Program shallowP = pruneDeepProcs(prog, ref edges, impl.Name, approximationDepth);
                Directory.CreateDirectory(wd); // create new directory for each entrypoint
                RemoteExec.CleanDirectory(wd);
                var pruneFile = Path.Combine(wd, "pruneSlice.bpl");
                BoogieUtil.PrintProgram(shallowP, pruneFile); // dump sliced program

                sem.Release();

                if (!remotedirs.Contains(rd))
                {
                    Console.WriteLine("Running entrypoint {0} locally {{", impl.Name);

                    // spawn the job -- local
                    var output = RemoteExec.run(wd, avnPath, pruneFile + " " + avnArgs);

                    // delete temp files
                    var files = System.IO.Directory.GetFiles(wd, "*.bpl");
                    foreach (var f in files)
                        System.IO.File.Delete(f);

                    using (StreamWriter sw = new StreamWriter(Path.Combine(wd, "stdout.txt")))
                        output.Iter(s => sw.WriteLine("{0}", s));

                    Console.WriteLine("Running entrypoint {0} locally }}", impl.Name);
                }
                else
                {
                    // spawn the job -- remote

                    // find the name of the machine from the remote folder name
                    var machine = "";
                    var remoteroot = RemoteExec.GetRemoteFolder(rd, out machine);

                    Console.WriteLine("Running entrypoint {0} on {1} {{", impl.Name, machine);

                    // psexec machine -w remoteroot\impl remoteroot\fastavn\fastavn.exe remoteroot args
                    wd = Path.Combine(remoteroot, impl.Name);
                    var cmd = string.Format("{0} -w {1} {2} {3} {4}", machine, wd, Path.Combine(remoteroot, "fastavn", "fastavn.exe"),
                        "pruneSlice.bpl", avnArgs);

                    var output = RemoteExec.run(Directory.GetCurrentDirectory(), psexecPath, cmd);

                    // delete temp files
                    var files = System.IO.Directory.GetFiles(wd, "*.bpl");
                    foreach (var f in files)
                        System.IO.File.Delete(f);

                    // copy the results back
                    Directory.CreateDirectory(Path.Combine(Directory.GetCurrentDirectory(), impl.Name));
                    RemoteExec.CopyFolder(rd, Directory.GetCurrentDirectory(), impl.Name, true);

                    using (StreamWriter sw = new StreamWriter(Path.Combine(wd, "stdout.txt")))
                        output.Iter(s => sw.WriteLine("{0}", s));

                    Console.WriteLine("Running entrypoint {0} on {1} }}", impl.Name, machine);
                }

                sem.WaitOne();

                // collect and merge bugs
                var bugs = collectBugs(Path.Combine(Directory.GetCurrentDirectory(), impl.Name, bugReportFileName));
                bugs.Iter(b =>
                {
                    if (!mergedBugs.ContainsKey(b)) mergedBugs[b] = 0;
                    mergedBugs[b] += 1;
                });
                Utils.Print(string.Format("Bugs found so far: {0}", mergedBugs.Count));

                sem.Release();

                worklist.Add(rd);

                /*
                var runAVNargs = " ";
                try
                {
                    Directory.CreateDirectory(impl.Name); // create new directory for each entrypoint
                    var pruneFile = string.Format("{0}\\pruneSlice.bpl", impl.Name);
                    Utils.Print(string.Format("Start running AVN: {0} {1}", pruneFile, avnArgs), Utils.PRINT_TAG.AV_DEBUG);
                    BoogieUtil.PrintProgram(shallowP, pruneFile); // dump sliced program

                    runAVNargs += Path.Combine(Directory.GetCurrentDirectory(), pruneFile) + " " + avnArgs;
                    using (Process p = new Process())
                    {
                        p.StartInfo.FileName = avnPath;
                        p.StartInfo.Arguments = runAVNargs;
                        p.StartInfo.WorkingDirectory = Path.Combine(Directory.GetCurrentDirectory(), impl.Name);
                        p.StartInfo.RedirectStandardOutput = true;
                        p.StartInfo.RedirectStandardError = true;
                        p.StartInfo.UseShellExecute = false;
                        p.StartInfo.CreateNoWindow = true;

                        // redirect output
                        StringBuilder output = new StringBuilder();
                        StringBuilder error = new StringBuilder();
                        using (AutoResetEvent outputWaitHandle = new AutoResetEvent(false))
                        using (AutoResetEvent errorWaitHandle = new AutoResetEvent(false))
                        {
                            p.OutputDataReceived += (sender, e) =>
                            {
                                if (e.Data == null)
                                    outputWaitHandle.Set();
                                else
                                    output.AppendLine(e.Data);
                            };
                            p.ErrorDataReceived += (sender, e) =>
                            {
                                if (e.Data == null)
                                    errorWaitHandle.Set();
                                else
                                    error.AppendLine(e.Data);
                            };

                            p.Start();
                            // asyncronous read of stdout and stderr to avoid deadlock
                            p.BeginOutputReadLine();
                            p.BeginErrorReadLine();

                            p.WaitForExit(); // wait untill AVN terminates
                            outputWaitHandle.WaitOne();
                            errorWaitHandle.WaitOne();
                            // TODO: we can also wait only a predefined amount of time
                            readAVNOutput(output.ToString());

                            if (outputToFile)
                            {
                                // print redirected console output
                                using (StreamWriter sw = new StreamWriter(Path.Combine(p.StartInfo.WorkingDirectory,
                                    "stdout.txt")))
                                    sw.Write(output.ToString());
                                using (StreamWriter sw = new StreamWriter(Path.Combine(p.StartInfo.WorkingDirectory,
                                    "stderr.txt")))
                                    sw.Write(error.ToString());
                            }

                            // collect and merge bugs
                            var bugs = collectBugs(Path.Combine(p.StartInfo.WorkingDirectory,
                                    bugReportFileName));
                            bugs.Iter(b =>
                            {
                                if (!mergedBugs.ContainsKey(b)) mergedBugs[b] = 0;
                                mergedBugs[b] += 1;
                            });
                            Utils.Print(string.Format("Bugs found so far: {0}", mergedBugs.Count));
                        }
                    }

                    var files = System.IO.Directory.GetFiles(impl.Name, "*.bpl");
                    foreach (var f in files)
                    {
                        System.IO.File.Delete(f);
                    }
                }
                catch (Exception e)
                {
                    Utils.Print("Error running: " + avnPath + " " + runAVNargs);
                    Console.WriteLine(e.Message);
                    Console.WriteLine(e.StackTrace);
                }
              
            });
            */

            printBugs(ref mergedBugs, epNames.Count);
            mergeBugs(epNames);
            Utils.Print(string.Format("#EntryPoints : {0}", epNames.Count), Utils.PRINT_TAG.AV_STATS);
            Utils.Print(string.Format("#Bugs : {0}", mergedBugs.Count), Utils.PRINT_TAG.AV_STATS);
        }

        class Worker
        {
            ConcurrentBag<Implementation> impls;
            ConcurrentBag<string> resources;
            Semaphore sem;
            Program program;

            public Worker(Program program, ConcurrentBag<Implementation> impls, ConcurrentBag<string> resources, Semaphore sem)
            {
                this.program = program;
                this.impls = impls;
                this.resources = resources;
                this.sem = sem;
            }

            public void Run()
            {
                Implementation impl;
                var rd = "";

                while (true)
                {
                    if (!impls.TryTake(out impl)) { break; }

                    while (!resources.TryTake(out rd)) { Thread.Sleep(100); }

                    sem.WaitOne();

                    var wd = Path.Combine(rd, impl.Name); // create new directory for each entrypoint

                    // slice the program by entrypoints
                    Program shallowP = pruneDeepProcs(program, ref edges, impl.Name, approximationDepth);
                    Directory.CreateDirectory(wd); // create new directory for each entrypoint
                    RemoteExec.CleanDirectory(wd);
                    var pruneFile = Path.Combine(wd, "pruneSlice.bpl");
                    BoogieUtil.PrintProgram(shallowP, pruneFile); // dump sliced program

                    sem.Release();

                    if (!remotedirs.Contains(rd))
                    {
                        Console.WriteLine("Running entrypoint {0} locally {{", impl.Name);

                        // spawn the job -- local
                        var output = RemoteExec.run(wd, avnPath, pruneFile + " " + avnArgs);

                        lock (fslock)
                        {
                            // delete temp files
                            var files = System.IO.Directory.GetFiles(wd, "*.bpl");
                            foreach (var f in files)
                                System.IO.File.Delete(f);

                            using (StreamWriter sw = new StreamWriter(Path.Combine(wd, "stdout.txt")))
                                output.Iter(s => sw.WriteLine("{0}", s));
                        }

                        Console.WriteLine("Running entrypoint {0} locally }}", impl.Name);
                    }
                    else
                    {
                        // spawn the job -- remote

                        // find the name of the machine from the remote folder name
                        var machine = "";
                        var remoteroot = RemoteExec.GetRemoteFolder(rd, out machine);

                        Console.WriteLine("Running entrypoint {0} on {1} {{", impl.Name, machine);

                        // psexec machine -w remoteroot\impl remoteroot\fastavn\fastavn.exe remoteroot args
                        wd = Path.Combine(remoteroot, impl.Name);
                        var cmd = string.Format("{0} -w {1} {2} {3} {4}", machine, wd, Path.Combine(remoteroot, "fastavn", "AngelicVerifierNull.exe"),
                            "pruneSlice.bpl", avnArgs);
                        //Console.WriteLine("PSEXEC Running: {0}", cmd);
                        
                        var output = RemoteExec.run(Directory.GetCurrentDirectory(), psexecPath, cmd);

                        lock (fslock)
                        {
                            // delete temp files
                            var td = Path.Combine(rd, impl.Name);
                            if(debug) Console.WriteLine("Getting files in directory: {0}", td);
                            var files = System.IO.Directory.GetFiles(td, "*.bpl");
                            foreach (var f in files)
                            {
                                if (debug) Console.WriteLine("Deleting {0}", f);
                                System.IO.File.Delete(f);
                            }

                            // copy the results back
                            var ld = Path.Combine(Directory.GetCurrentDirectory(), impl.Name);
                            Directory.CreateDirectory(ld);
                            RemoteExec.CleanDirectory(ld);
                            RemoteExec.CopyFolder(rd, Directory.GetCurrentDirectory(), impl.Name, true);

                            using (StreamWriter sw = new StreamWriter(Path.Combine(ld, "stdout.txt")))
                                output.Iter(s => sw.WriteLine("{0}", s));
                        }

                        Console.WriteLine("Running entrypoint {0} on {1} }}", impl.Name, machine);
                    }

                    lock (fslock)
                    {

                        // collect and merge bugs
                        var bugs = collectBugs(Path.Combine(Directory.GetCurrentDirectory(), impl.Name, bugReportFileName));
                        bugs.Iter(b =>
                        {
                            if (!mergedBugs.ContainsKey(b)) mergedBugs[b] = 0;
                            mergedBugs[b] += 1;
                        });
                        Utils.Print(string.Format("Bugs found so far: {0}", mergedBugs.Count));

                        resources.Add(rd);
                    }

                    
                }
            }
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            
            lock (RemoteExec.SpawnedProcesses)
            {
                foreach (var p in RemoteExec.SpawnedProcesses)
                    p.Kill();
                RemoteExec.SpawnedProcesses.Clear();
            }
            System.Diagnostics.Process.GetCurrentProcess()
                .Kill();
        }

        private static void mergeBugs(HashSet<string> entryPoints)
        {
            bool dbg = false;
            // failing location -> (metric_val, path_to_tt_file, path_to_stack_file)
            Dictionary<string, Tuple<int, string, string>> shortest_trace = new Dictionary<string, Tuple<int, string, string>>();

            foreach (string impl in entryPoints)
            {
                string result_file = Path.Combine(Directory.GetCurrentDirectory(), impl, bugReportFileName);
                if (dbg) Utils.Print(string.Format("Result File -> {0}", result_file), Utils.PRINT_TAG.AV_DEBUG);
                int traceNum = 0;

                try
                {
                    foreach (string line in File.ReadLines(result_file))
                    {
                        if (line.StartsWith("Description"))
                            continue;
                        // extract line from bug report but ignore the entrypoint info
                        string bug_info = line.Substring(0, line.LastIndexOf(","));
                        string file_name = angelic + traceNum.ToString() + trace_extension;
                        string stack_filename = angelic + traceNum.ToString() + angelic_stack + stack_extension;
                        string trace_file = Path.Combine(Directory.GetCurrentDirectory(), impl, file_name);
                        string stack_file = Path.Combine(Directory.GetCurrentDirectory(), impl, stack_filename);
                        int metric = getMetric(traceNum, trace_file);

                        if (dbg) Utils.Print(string.Format("Bug File -> {0} {1}", bug_info, trace_file), Utils.PRINT_TAG.AV_DEBUG);
                        if (dbg) Utils.Print(string.Format("Metric -> {0}", metric), Utils.PRINT_TAG.AV_DEBUG);

                        if (shortest_trace.ContainsKey(bug_info))
                        {
                            if (metric < shortest_trace[bug_info].Item1) shortest_trace[bug_info] = Tuple.Create(metric, trace_file, stack_file);
                        }
                        else shortest_trace.Add(bug_info, Tuple.Create(metric, trace_file, stack_file));
                        traceNum++;
                    }

                }
                catch (FileNotFoundException)
                {
                    Utils.Print(string.Format("Bug report file not found: {0}", result_file));
                }
                catch (Exception e)
                {
                    Utils.Print(string.Format("Error when processing bug report: {0}", result_file));
                    Console.WriteLine(e.Message);
                    Console.WriteLine(e.StackTrace);
                }
            }

            string trace_path = Path.Combine(Directory.GetCurrentDirectory(), bug_folder);
            int index = 0;
            Directory.CreateDirectory(bug_folder);
            
            foreach (string bug in shortest_trace.Keys)
            {
                string file_name = bug_filename + index.ToString() + trace_extension;
                string stack_filename = bug_filename + index.ToString() + angelic_stack + stack_extension;
                try
                {
                    File.Copy(shortest_trace[bug].Item2, Path.Combine(trace_path, file_name));
                    File.Copy(shortest_trace[bug].Item3, Path.Combine(trace_path, stack_filename));
                }
                catch (FileNotFoundException)
                {
                    Utils.Print(string.Format("Trace file not found: {0}", shortest_trace[bug].Item2));
                }
                index++;
            }

            using (StreamWriter bugReportWriter = new StreamWriter(Path.Combine(Directory.GetCurrentDirectory(), mergedBugReportCSV)))
            {
                bugReportWriter.WriteLine("Description,Src File,Line,Procedure");
                foreach (string bug in shortest_trace.Keys)
                {
                    bugReportWriter.WriteLine(bug);
                }
            }
        }

        private static int getMetric(int traceno, string trace_file)
        {
            int num_lines = 0;

            try
            {
                foreach (string line in File.ReadLines(trace_file)) num_lines++;
            }

            catch (FileNotFoundException)
            {
                Utils.Print(string.Format("Trace file not found: {0}", trace_file));
            }
            catch (Exception e)
            {
                Utils.Print(string.Format("Error while processing trace file: {0}", trace_file));
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }

            return num_lines;
        }

        private static Dictionary<string, HashSet<string>> buildCallGraph(Program prog)
        {
            // build the call graph once
            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;

                Stats.count("impl.count");
                edges.Add(impl.Name, new HashSet<string>());
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<CallCmd>()
                        .Iter(ccmd => edges[impl.Name].Add(ccmd.callee));
                    blk.Cmds.OfType<ParCallCmd>()
                        .Iter(pcmd => pcmd.CallCmds
                            .Iter(ccmd => edges[impl.Name].Add(ccmd.callee)));
                }
            }
            return edges;
        }

        // output merged bug report to console
        private static void printBugs(ref ConcurrentDictionary<string, int> mergedBugs, int numEntries)
        {
            using (StreamWriter bugReport = new StreamWriter(
                Path.Combine(Directory.GetCurrentDirectory(),
                mergedBugReportName)))
            {
                Utils.Print(string.Format("========= Merged Bugs for {0} Entry Points =========", numEntries),
                    Utils.PRINT_TAG.AV_OUTPUT);
                Utils.Print("Description,Src File,Line,Procedure", Utils.PRINT_TAG.AV_OUTPUT);
                bugReport.WriteLine("Description,Src File,Line,Procedure");
                foreach (string bug in mergedBugs.Keys)
                {
                    Utils.Print(string.Format("Bug: {0} Count: {1}", bug, mergedBugs[bug]), Utils.PRINT_TAG.AV_OUTPUT);
                    bugReport.WriteLine(bug);
                }
            }
        }

        // collect bug from the bug report file produce by AVN
        private static HashSet<string> collectBugs(string p)
        {
            HashSet<string> ret = new HashSet<string>();
            try
            {
                foreach (string line in File.ReadLines(p))
                {
                    if (line.StartsWith("Description"))
                        continue;
                    // extract line from bug report but ignore the entrypoint info
                    ret.Add(line.Substring(0, line.LastIndexOf(",")));
                }
            }
            catch (FileNotFoundException)
            {
                Utils.Print(string.Format("Bug report file not found: {0}", p));
            }
            catch (Exception e)
            {
                Utils.Print(string.Format("Error when processing bug report: {0}", p));
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }

            return ret;
        }

        // process AVN console output
        // TODO: collect individual stats for AVN run
        private static void readAVNOutput(string output)
        {
            foreach (string line in output.Split('\n'))
            {
                if (verbose >= 1 && numThreads <= 1)
                    // disable printing when running mutiple threads
                    Console.WriteLine(line);
                if (!line.StartsWith("[TAG: AV_STATS]"))
                    continue;
            }
        }

        /**
         * Prune by removing implementations that are not called within depth k (k>=0)
         * When k < 0, only prune implementations that are never called
         * Leave corralExtraInint alone.
        */
        private static Program pruneDeepProcs(Program origProgram,
            ref Dictionary<string, HashSet<string>> edges,
            string mainProcName, int k)
        {
            if (mainProcName == null)
                return origProgram;


            var boundedDepth = (k >= 0); // do we have a bounded depth

            Program program = (new FixedDuplicator(false)).VisitProgram(origProgram);
            Procedure malloc = FindMalloc(program);

            var reachable = new HashSet<string>();
            reachable.Add(mainProcName);

            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0 && (!boundedDepth || k-- > 0))
            {
                var nf = new HashSet<string>();
                foreach (var n in delta)
                {
                    if (edges.ContainsKey(n)) nf.UnionWith(edges[n]);
                }
                delta = nf.Difference(reachable);
                reachable.UnionWith(nf);
            }

            var allProcs = new HashSet<string>(edges.Keys);
            var toRemove = allProcs.Difference(reachable);

            var newDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                //if (decl is Procedure && toRemove.Contains((decl as Procedure).Name)) continue;
                if (decl is Implementation)
                {
                    var impl = decl as Implementation;
                    if (impl.Name != mainProcName)
                        decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes);
                    if (toRemove.Contains(impl.Name) &&
                        !(fieldNonNull && impl.Name == CORRAL_EXTRA_INIT))
                    // keep instrumentation function
                    {
                        // replace implementations to be removed by
                        // angelic approximations
                        var approxImpl = AngelicImpl(impl, program, malloc);
                        if (approxImpl != null)
                            newDecls.Add(approxImpl);
                        continue;
                    }
                }
                if (decl is Procedure && (decl as Procedure).Name != mainProcName)
                    decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes);

                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;

            return program;
        }

        #region Angelic Approximation
        // Create an angelic implementation to approximate the real one
        private static Implementation AngelicImpl(Implementation impl, Program prog, Procedure mallocProc)
        {
            if (BoogieUtil.checkAttrExists("allocator", impl.Attributes))
                return null;

            List<Cmd> cmds = new List<Cmd>();
            List<Variable> localVars = new List<Variable>();
            foreach (var op in impl.OutParams)
            {
                if (IsPointerVariable(op)) cmds.Add(AllocatePointerAsUnknown(op, mallocProc));
                else cmds.Add(BoogieAstFactory.MkHavocVar(op)); //Corral alias analysis crashes (what is semantics of uninit var for inlining)
            }
            foreach (var ip in impl.InParams)
            {
                if (!BoogieUtil.checkAttrExists("ref", ip.Attributes)) continue;
                string mapName = QKeyValue.FindStringAttribute(ip.Attributes, "ref");
                if (mapName == null)
                {
                    Utils.Print(String.Format("Expecting a map <name> with {:ref <name>} annotation on procedure {0}", impl.Name),
                        Utils.PRINT_TAG.AV_WARNING);
                    continue;
                }
                var mapVars = prog.TopLevelDeclarations.OfType<Variable>().
                    Where(x => x.Name == mapName && x.TypedIdent.Type.IsMap);
                if (mapVars.Count() != 1)
                {
                    Utils.Print(String.Format("Mapname {0} provided in {:ref} for parameter {1} for procedure {2} has {3} matches, expecting exactly 1 match",
                        mapName, ip.Name, impl.Name, mapVars.Count()),
                        Utils.PRINT_TAG.AV_WARNING);
                    continue;
                }
                var tmpVar = BoogieAstFactory.MkLocal("__tmp_" + ip.Name, ip.TypedIdent.Type);
                localVars.Add(tmpVar);
                cmds.Add(AllocatePointerAsUnknown(tmpVar, mallocProc));
                cmds.Add(BoogieAstFactory.MkMapAssign(mapVars.First(), IdentifierExpr.Ident(ip), IdentifierExpr.Ident(tmpVar)));
            }
            if (cmds.Count == 0) return null; //don't create a body if no statements
            var blk = BoogieAstFactory.MkBlock(cmds, new ReturnCmd(Token.NoToken));
            var blks = new List<Block>() { blk };
            //don't insert the proc as it already exists
            var implpair = BoogieAstFactory.MkImpl(impl.Name,
                DropAnnotations(impl.InParams),
                DropAnnotations(impl.OutParams),
                new List<Variable>(), blks);
            Implementation ret = implpair[1] as Implementation;
            ret.LocVars.AddRange(localVars);
            ret.AddAttribute("angelic");
            return ret;
        }
        private static bool IsPointerVariable(Variable x)
        {
            return x.TypedIdent.Type.IsInt &&
                !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
        }
        private static Cmd AllocatePointerAsUnknown(Variable x, Procedure malloc)
        {
            return BoogieAstFactory.MkCall(malloc,
                new List<Expr>() { new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ONE) },
                new List<Variable>() { x });
        }

        // create a copy ofthe variables without annotations
        private static List<Variable> DropAnnotations(List<Variable> vars)
        {
            var ret = new List<Variable>();
            var dup = new Duplicator();
            vars.Select(v => dup.VisitVariable(v)).Iter(v =>
            {
                v.Attributes = null;
                ret.Add(v);
            });
            return ret;
        }
        #endregion

        // locate HAVOC_MALLOC
        private static Procedure FindMalloc(Program prog)
        {
            Procedure mallocProc = null;
            //find the malloc and malloc-full procedures
            foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
            {
                var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                if (attr == null) mallocProc = proc;
            }

            if (mallocProc == null)
            {
                throw new Exception("ABORT: no malloc procedure with {:allocator} declared in the input program");
            }
            return mallocProc;
        }
    }
}