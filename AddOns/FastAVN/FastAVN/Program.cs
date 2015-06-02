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

        static int approximationDepth = -1; // k-depth: default infinity
        static int verbose = 1; // default verbosity level
        static string avnPath = null; // path to AVN binary
        static string avHarnessInstrPath = null; // path to AVN harness instrumentation binary
        static string psexecPath = null; // path to psexec
        static readonly string bugReportFileName = "results.txt"; // default bug report filename produced by AVN
        static string avnArgs = ""; // AVN arguments
        static string avHarnessInstrArgs = ""; // harness instrumentation arguments
        static string mergedBugReportName = "bugs.txt";
        static string mergedBugReportCSV = "results.csv";
        static int numThreads = 4; // default number of parallel AVN instances
        private static string CORRAL_EXTRA_INIT = "corralExtraInit";
        static string angelic = "Angelic";
        static string trace_extension = ".tt";
        static string bug_folder = "Bugs";
        static string bug_filename = "Bug";
        static string angelic_stack = "stack";
        static string stack_extension = ".txt";
        static FastAvnConfig config = null;

        static DateTime startingTime = DateTime.Now;
        static volatile bool deadlineReached = false;
        static bool printingOutput = false;
        static int deadline = 0;

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

            args.Where(s => s.StartsWith("/aopt:"))
                .Iter(s => avnArgs += " /" + s.Substring("/aopt:".Length) + " ");

            args.Where(s => s.StartsWith("/hopt:"))
                .Iter(s => avHarnessInstrArgs += " /" + s.Substring("/hopt:".Length) + " ");

            // user definded verbose level
            args.Where(s => s.StartsWith("/verbose:"))
                .Iter(s => verbose = int.Parse(s.Substring("/verbose:".Length)));

            // depth k used by implementation pruning
            args.Where(s => s.StartsWith("/depth:"))
                .Iter(s => approximationDepth = int.Parse(s.Substring("/depth:".Length)));

            args.Where(s => s.StartsWith("/numThreads:"))
                .Iter(s => numThreads = int.Parse(s.Substring("/numThreads:".Length)));

            // Get config for remote execution
            args.Where(s => s.StartsWith("/config:"))
                .Iter(s => config = FastAvnConfig.DeSerialize(s.Substring("/config:".Length)));

            args.Where(s => s.StartsWith("/killAfter:"))
                .Iter(s => deadline = int.Parse(s.Substring("/killAfter:".Length)));

            // default args
            avnArgs += " /dumpResults:" + bugReportFileName + " ";
            avnArgs += " /EE:onlySlicAssumes+ /EE:ignoreAllAssumes- ";

            // Find AVN executable
            avnPath = findExe("AngelicVerifierNull.exe");
            avHarnessInstrPath = findExe("AvHarnessInstrumentation.exe");

            psexecPath = findExe("psexec.exe");

            Debug.Assert(avnPath != null && avHarnessInstrPath != null);

            try
            {
                Stats.resume("fastavn");
                // Get input program
                Utils.Print(String.Format("----- Run FastAVN on {0} with k={1} ------",
                    args[0], approximationDepth), Utils.PRINT_TAG.AV_OUTPUT);

                // initialize corral and boogie for fastAVN
                InitializeCorralandBoogie();

                // identify entrypoints
                var origprog = BoogieUtil.ReadAndOnlyResolve(args[0]);
                var orig_entrypoints = new HashSet<string>();
                var entrypoints = new HashSet<string>();

                origprog.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(x => QKeyValue.FindBoolAttribute((x as Implementation).Proc.Attributes, "entrypoint"))
                .Iter(x => orig_entrypoints.Add(x.Name));

                // Run harness instrumentation
                var resultfile = Path.Combine(Directory.GetCurrentDirectory(), "hinst.bpl");
                RemoteExec.run(Directory.GetCurrentDirectory(), avHarnessInstrPath, string.Format("{0} {1} {2}", args[0], resultfile, avHarnessInstrArgs));

                if (!File.Exists(resultfile))
                    throw new Exception("Error running harness instrumentation");

                var prog = BoogieUtil.ReadAndOnlyResolve(resultfile);

                // Do a run on instrumented program, filter out entrypoints
                Procedure entrypoint_proc = prog.TopLevelDeclarations.OfType<Procedure>().Where(proc => BoogieUtil.checkAttrExists("entrypoint", proc.Attributes)).FirstOrDefault();

                Debug.Assert(entrypoint_proc != null);

                Implementation entrypoint_impl = prog.TopLevelDeclarations.OfType<Implementation>().Where(impl => impl.Name.Equals(entrypoint_proc.Name)).FirstOrDefault();

                // other entrypoints can never reach an assertion, don't run AVN on them
                foreach (Block b in entrypoint_impl.Blocks)
                {
                    foreach (Cmd c in b.Cmds)
                    {
                        if (c is CallCmd)
                        {
                            var cc = c as CallCmd;
                            if (orig_entrypoints.Contains(cc.callee)) entrypoints.Add(cc.callee);
                        }
                    }
                }

                // do reachability analysis on procedures
                // prune deep (depth > K) implementations: treat as angelic
                sliceAndRunAVN(prog, approximationDepth, entrypoints);

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

        private static void InitializeCorralandBoogie()
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
        }

        // locate binary in the system
        private static string findExe(string exe)
        {
            string ret = null;
            var runDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            if (!File.Exists(Path.Combine(runDir, exe)))
            {
                var enviromentPath = System.Environment.GetEnvironmentVariable("PATH"); // look up in PATH
                var paths = enviromentPath.Split(';');
                ret = paths.Select(x => Path.Combine(x, exe))
                    .Where(x => File.Exists(x))
                    .FirstOrDefault();

                if (string.IsNullOrWhiteSpace(avnPath))
                    throw new FileNotFoundException("Cannot find executable: " + exe);
            }
            else
            {
                ret = Path.Combine(runDir, exe);
            }
            Utils.Print(String.Format("Found {0} at: {1}", exe, ret));

            return ret;
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
        private static void sliceAndRunAVN(Program prog, int approximationDepth, HashSet<string> epNames)
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
            var entrypoints = new ConcurrentBag<Implementation>(prog.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => epNames.Contains(impl.Name)));

            // deadline
            if (deadline > 0)
            {
                deadline = deadline - (int)((DateTime.Now - startingTime).TotalSeconds + 0.5);
                if (deadline < 0) deadline = 1;
            }

            if (deadline > 100)
            {
                var timeouttask = new System.Threading.Tasks.Task(() =>
                {
                    System.Threading.Thread.Sleep((deadline - 100) * 1000);
                    Console.WriteLine("FastAvn deadline reached; consolidating results");

                    deadlineReached = true;
                    KillSpawnedProcesses();

                    // Sleep for 2 seconds
                    System.Threading.Thread.Sleep(2 * 1000);

                    // collate bugs
                    lock (fslock)
                    {
                        if (printingOutput) return;
                        printingOutput = true;
                        printBugs(ref mergedBugs, epNames.Count);
                        mergeBugs(epNames);
                    }

                    // Kill self
                    Process.GetCurrentProcess().Kill();
                });
                timeouttask.Start();
            }
            else if (deadline != 0)
            {
                Console.WriteLine("Ignoring small deadline of {0} seconds", deadline);
            }

            var threads = new List<Thread>();
            for (int i = 0; i < threadsToSpawn; i++)
            {
                var w = new Worker(prog, entrypoints, worklist, sem);
                threads.Add(new Thread(new ThreadStart(w.Run)));
            }

            threads.Iter(t => t.Start());
            threads.Iter(t => t.Join());

            lock (fslock)
            {
                if (printingOutput) return;
                printingOutput = true;
                printBugs(ref mergedBugs, epNames.Count);
                mergeBugs(epNames);
            }
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

                HashSet<string> implNames = new HashSet<string>();
                impls.Iter(im => implNames.Add(im.Name));

                while (true)
                {
                    if (!impls.TryTake(out impl)) { break; }

                    while (!resources.TryTake(out rd)) { Thread.Sleep(100); }

                    sem.WaitOne();

                    var wd = Path.Combine(rd, impl.Name); // create new directory for each entrypoint

                    Directory.CreateDirectory(wd); // create new directory for each entrypoint
                    RemoteExec.CleanDirectory(wd);
                    var pruneFile = Path.Combine(wd, "pruneSlice.bpl");
                    BoogieUtil.PrintProgram(program, pruneFile); // dump original program (so that each entrypoint has its own copy of program)

                    program = BoogieUtil.ReadAndOnlyResolve(pruneFile); // entrypoint's copy of the program

                    // slice the program by entrypoints
                    Program shallowP = pruneDeepProcs(program, ref edges, impl.Name, approximationDepth, implNames);
                    File.Delete(pruneFile);
                    BoogieUtil.PrintProgram(shallowP, pruneFile); // dump sliced program

                    sem.Release();

                    if (!remotedirs.Contains(rd))
                    {
                        Console.WriteLine("Running entrypoint {0} locally {{", impl.Name);

                        if (deadlineReached) return;

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
                        if(psexecPath == null)
                            throw new FileNotFoundException("Cannot find PSEXEC!");

                        // find the name of the machine from the remote folder name
                        var machine = "";
                        var remoteroot = RemoteExec.GetRemoteFolder(rd, out machine);

                        Console.WriteLine("Running entrypoint {0} on {1} {{", impl.Name, machine);

                        // psexec machine -w remoteroot\impl remoteroot\fastavn\fastavn.exe remoteroot args
                        wd = Path.Combine(remoteroot, impl.Name);
                        var cmd = string.Format("{0} -w {1} {2} {3} {4}", machine, wd, Path.Combine(remoteroot, "fastavn", "AngelicVerifierNull.exe"),
                            "pruneSlice.bpl", avnArgs);
                        //Console.WriteLine("PSEXEC Running: {0}", cmd);

                        if (deadlineReached) return;

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

            KillSpawnedProcesses();

            System.Diagnostics.Process.GetCurrentProcess()
                .Kill();
        }

        public static void KillSpawnedProcesses()
        {
            lock (RemoteExec.SpawnedProcesses)
            {
                foreach (var p in RemoteExec.SpawnedProcesses)
                    p.Kill();
                RemoteExec.SpawnedProcesses.Clear();
            }
        }

        private static void mergeBugs(HashSet<string> entryPoints)
        {
            bool dbg = false;
            // failing location -> (metric_val, path_to_tt_file, path_to_stack_file)
            Dictionary<string, Tuple<int, string, string>> shortest_trace = new Dictionary<string, Tuple<int, string, string>>();

            foreach (string impl in entryPoints)
            {
                if (!Directory.Exists(Path.Combine(Directory.GetCurrentDirectory(), impl))) continue;

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
                bugReportWriter.WriteLine("Description,Src File,Line,Procedure,Fail Status");
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
                Utils.Print("Description,Src File,Line,Procedure,Fail Status", Utils.PRINT_TAG.AV_OUTPUT);
                bugReport.WriteLine("Description,Src File,Line,Procedure,Fail Status");
                foreach (string bug in mergedBugs.Keys)
                {
                    Utils.Print(string.Format("Bug: {0} Count: {1}", bug, mergedBugs[bug]), Utils.PRINT_TAG.AV_OUTPUT);
                    if (bug.Contains("mustFail") && !bug.Contains("notmustFail")) Stats.count("mustfail.report.count");
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
            string mainProcName, int k, HashSet<string> implNames)
        {
            if (mainProcName == null)
                return origProgram;

            // delete all calls in CorralMain other than mainProcName
            mainProcName = sliceMainForProc(origProgram, mainProcName, implNames);

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
                    if (toRemove.Contains(impl.Name) &&
                        !(impl.Name == CORRAL_EXTRA_INIT))
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
                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;

            return program;
        }

        // deletes calls to all entrypoints except mainproc, returns CorralMain since that this is the entrypoint
        private static string sliceMainForProc(Program program, string mainproc, HashSet<string> otherEPs)
        {
            Procedure entrypoint_proc = program.TopLevelDeclarations.OfType<Procedure>().Where(proc => BoogieUtil.checkAttrExists("entrypoint", proc.Attributes)).FirstOrDefault();

            Debug.Assert(entrypoint_proc != null);

            Implementation entrypoint_impl = program.TopLevelDeclarations.OfType<Implementation>().Where(impl => impl.Name.Equals(entrypoint_proc.Name)).FirstOrDefault();

            foreach (Block b in entrypoint_impl.Blocks)
            {
                var newCmds = new List<Cmd>();
                foreach (Cmd c in b.Cmds)
                {
                    if (c is CallCmd)
                    {
                        var cc = c as CallCmd;
                        if (cc.callee.Equals(mainproc))
                        {
                            cc.Attributes = new QKeyValue(Token.NoToken, "CalledEntryPoint", new List<object>(), cc.Attributes);
                            newCmds.Add(cc);
                        }
                        else if (otherEPs.Contains(cc.callee))
                        {
                            AssumeCmd ac = new AssumeCmd(Token.NoToken, Expr.False);
                            ac.Attributes = new QKeyValue(Token.NoToken, "SlicedEntryPoint", new List<object>(), ac.Attributes);
                            newCmds.Add(ac);
                        }
                        else newCmds.Add(cc);
                    }
                    else newCmds.Add(c);
                }
                b.Cmds = newCmds;
            }

            return entrypoint_proc.Name;
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