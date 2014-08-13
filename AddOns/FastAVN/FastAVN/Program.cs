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

        //static string boogieOpts = "";
        //static string corralOpts = "";
        //static cba.Configs corralConfig = null;
        static int timeout = 0; // system timeout
        static int avnTimeout = 200; // default AVN timeout
        static int approximationDepth = 0; // k-depth
        static int verbose = 1; // default verbosity level
        static string avnPath = null; // path to AVN binary
        static bool dumpSlices = true; // dump sliced program for each entrypoint
        static readonly string bugReportFileName = "results.txt"; // default bug report filename produced by AVN
        static string avnArgs = "/sdv /useEntryPoints /dumpResults:" + bugReportFileName
            + " /timeout:" + avnTimeout; // default AVN arguments
        static string mergedBugReportName = "bugs.txt";
        static int numThreads = 4; // default number of parallel AVN instances


        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: FastAVN file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/noDumpSlices"))
                dumpSlices = false;

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

            // Find AVN executable
            findAvn();
            Debug.Assert(avnPath != null);
            // Initialize Boogie and Corral
            //corralConfig = InitializeCorral();

            Program prog = null;
            try
            {
                Stats.resume("fastavn");
                // Get input program
                Utils.Print(String.Format("----- Run FastAVN on {0} with k={1} ------",
                    args[0], approximationDepth), Utils.PRINT_TAG.AV_OUTPUT);
                prog = GetProgram(args[0]); // get the input program

                // do reachability analysis on procedures
                // prune deep (depth > K) implementations: treat as angelic
                pruneImpl(prog, approximationDepth);

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
        }

        // Initialization
        //static cba.Configs InitializeCorral()
        //{
        //    CommandLineOptions.Install(new CommandLineOptions());
        //    CommandLineOptions.Clo.PrintInstrumented = true;

        //    // Set all defaults for corral
        //    corralOpts += " doesntExist.bpl /track:alloc /useProverEvaluate /printVerify ";
        //    var config = cba.Configs.parseCommandLine(corralOpts.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
        //    config.boogieOpts += boogieOpts;
        //    cba.Driver.Initialize(config);

        //    cba.VerificationPass.usePruning = false;

        //    if (!config.useProverEvaluate)
        //    {
        //        cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
        //        if (config.NonUniformUnfolding && !config.useProverEvaluate)
        //            cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = false;
        //        if (config.printData == 0)
        //            cba.ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
        //    }

        //    return config;
        //}

        // run AVN binary on pruned programs
        private static void pruneImpl(Program prog, int approximationDepth)
        {
            HashSet<string> entrypoints = new HashSet<string>();
            //HashSet<string> mergedBugs = new HashSet<string>();
            ConcurrentDictionary<string, int> mergedBugs = new ConcurrentDictionary<string, int>();

            // build the call graph
            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
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

            Parallel.ForEach (prog.TopLevelDeclarations.Where(x => x is Implementation), 
                new ParallelOptions { MaxDegreeOfParallelism = numThreads }, i =>
            {
                var impl = (Implementation)i;
                // skip this impl if it is not marked as an entrypoint
                if (!QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                    return;
                Stats.count("entry.points");
                entrypoints.Add(impl.Name);

                // slice the program by entrypoints
                Program shallowP = pruneDeepProcs(prog, ref edges, impl.Name, approximationDepth);

                var runAVNargs = " ";
                try
                {
                    Directory.CreateDirectory(impl.Name); // create new directory for each entrypoint
                    var pruneFile = dumpSlices ? string.Format("{0}\\pruneSlice.bpl", impl.Name) : "pruneSlice.bpl";
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

                            var bugs = collectBugs(Path.Combine(p.StartInfo.WorkingDirectory,
                                    bugReportFileName));
                            bugs.Iter(b =>
                            {
                                if (!mergedBugs.ContainsKey(b))
                                    mergedBugs[b] = 1;
                                else
                                    mergedBugs[b] += 1;
                            });
                            Utils.Print("Bugs found so far: " + mergedBugs.Count);
                        }
                    }
                }
                catch (Exception e)
                {
                    Utils.Print("Error running: " + avnPath + " " + runAVNargs);
                    Console.WriteLine(e.Message);
                    Console.WriteLine(e.StackTrace);
                }
            });

            printBugs(ref mergedBugs);
        }

        // output merged bug report to console
        private static void printBugs(ref ConcurrentDictionary<string, int> mergedBugs)
        {
            using (StreamWriter bugReport = new StreamWriter(
                Path.Combine(Directory.GetCurrentDirectory(),
                mergedBugReportName)))
            {
                Utils.Print("========= Merged Bugs =========", Utils.PRINT_TAG.AV_OUTPUT);
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

        // Prune by removing implementations that are not called within depth k (k>0)
        // When k <= 0, only prune implementations that are never called.
        private static Program pruneDeepProcs(Program origProgram, 
            ref Dictionary<string, HashSet<string>> edges,
            string mainProcName, int k)
        {
            if (mainProcName == null)
                return origProgram;

            var boundedDepth = (k > 0); // do we have a bounded depth

            Program program = (new FixedDuplicator(false)).VisitProgram(origProgram);

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
                    if ((decl as Implementation).Name != mainProcName)
                        decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes);
                    if (toRemove.Contains((decl as Implementation).Name) &&
                        (decl as Implementation).Name != "corralExtraInit") // keep instrumentation function
                        continue;
                }
                if (decl is Procedure && (decl as Procedure).Name != mainProcName)
                    decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes);

                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;

            return program;
        }

        private static Program GetProgram(string filename)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            //Program init = BoogieUtil.ReadAndOnlyResolve(filename);
            Program init = BoogieUtil.ParseProgram(filename);
            init.Resolve();
            return init;
        }
    }
}