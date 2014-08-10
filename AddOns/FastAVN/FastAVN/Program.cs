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
        static int approximationDepth = 0; // k-depth
        //static string boogieOpts = "";
        //static string corralOpts = "";
        //static cba.Configs corralConfig = null;
        static string avnPath = null;
        static bool dumpSlices = false;
        static readonly string bugReportFileName = "results.txt";
        static string avnArgs = "/sdv /useEntryPoints /dumpResults:" + bugReportFileName
            + " /timeout:" + avnTimeout;
        

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: FastAVN file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/dumpSlices"))
                dumpSlices = true;

            args.Where(s => s.StartsWith("/timeout:"))
                .Iter(s => timeout = int.Parse(s.Substring("/timeout:".Length)));

            args.Where(s => s.StartsWith("/depth:"))
                .Iter(s => approximationDepth = int.Parse(s.Substring("/depth:".Length)));

            args.Where(s => s.StartsWith("/avn:"))
                .Iter(s => avnPath = s.Substring("/avn:".Length));

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

        private static void pruneImpl(Program prog, int approximationDepth)
        {
            HashSet<string> entrypoints = new HashSet<string>();
            HashSet<Tuple<string, int>> mergedBugs = new HashSet<Tuple<string, int>>();

            foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
            {
                // skip this impl if it is not marked as an entrypoint
                if (!QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                    continue;
                Stats.count("entry.points");
                entrypoints.Add(impl.Name);

                // slice the program by entrypoints
                Program shallowP = pruneDeepProcs(prog, impl.Name, approximationDepth);
                
                var runAVNargs = " ";
                try
                {
                    Directory.CreateDirectory(impl.Name);
                    var pruneFile = dumpSlices ? string.Format("{0}\\pruneSlice.bpl", impl.Name) : "pruneSlice.bpl";
                    Utils.Print(string.Format("Start running AVN: {0} {1}", pruneFile, avnArgs), Utils.PRINT_TAG.AV_DEBUG);
                    BoogieUtil.PrintProgram(shallowP, pruneFile);

                    runAVNargs += Path.Combine(Directory.GetCurrentDirectory(), pruneFile) + " " + avnArgs;
                    using (Process p = new Process())
                    {
                        p.StartInfo.FileName = avnPath;
                        p.StartInfo.Arguments = runAVNargs;
                        p.StartInfo.WorkingDirectory = Path.Combine(Directory.GetCurrentDirectory(), impl.Name);
                        p.StartInfo.RedirectStandardOutput = false;
                        p.StartInfo.RedirectStandardError = false;
                        p.StartInfo.UseShellExecute = false;
                        p.StartInfo.CreateNoWindow = true;

                        //StringBuilder output = new StringBuilder();
                        //StringBuilder error = new StringBuilder();

                        //using (AutoResetEvent outputWaitHandle = new AutoResetEvent(false))
                        //using (AutoResetEvent errorWaitHandle = new AutoResetEvent(false))
                        //{
                        //    p.OutputDataReceived += (sender, e) =>
                        //    {
                        //        if (e.Data == null)
                        //            outputWaitHandle.Set();
                        //        else
                        //            output.AppendLine(e.Data);
                        //    };
                        //    p.ErrorDataReceived += (sender, e) =>
                        //    {
                        //        if (e.Data == null)
                        //            errorWaitHandle.Set();
                        //        else
                        //            error.AppendLine(e.Data);
                        //    };

                        //    p.Start();

                        //    p.BeginOutputReadLine();
                        //    p.BeginErrorReadLine();
                        //    if (p.WaitForExit(avnTimeout) && outputWaitHandle.WaitOne(avnTimeout) &&
                        //            errorWaitHandle.WaitOne(avnTimeout))
                        //    {
                        //        readAVNOutput(output.ToString());
                        //        //Utils.Print("Looking at bug report: " + Path.Combine(p.StartInfo.WorkingDirectory, bugReportFileName));
                        //        mergedBugs = mergedBugs.Union(
                        //            collectBugs(Path.Combine(p.StartInfo.WorkingDirectory, 
                        //            bugReportFileName)));
                        //        Utils.Print("Bugs found so far: " + mergedBugs.Count);
                        //    }
                        //    else
                        //        Utils.Print("Timeout on: " + impl.Name);
                        //}
                        p.Start();
                        p.WaitForExit();

                        mergedBugs = mergedBugs.Union(
                                    collectBugs(Path.Combine(p.StartInfo.WorkingDirectory,
                                    bugReportFileName)));
                        Utils.Print("Bugs found so far: " + mergedBugs.Count);
                    }
                        
                    
                        
                }
                catch (Exception e)
                {
                    Utils.Print("Error running: " + avnPath + " " + runAVNargs);
                    Console.WriteLine(e.Message);
                    Console.WriteLine(e.StackTrace);
                }
            }

            printBugs(mergedBugs);
        }

        private static void printBugs(HashSet<Tuple<string, int>> mergedBugs)
        {
            Utils.Print("========= Merged Bugs =========", Utils.PRINT_TAG.AV_OUTPUT);
            foreach (Tuple<string, int> bug in mergedBugs)
            {
                Utils.Print(string.Format("Bug: ({0}, {1})", bug.Item1, bug.Item2),Utils.PRINT_TAG.AV_OUTPUT);
            }
        }

        private static HashSet<Tuple<string, int>> collectBugs(string p)
        {
            HashSet<Tuple<string, int>> ret = new HashSet<Tuple<string, int>>();
            try
            {
                foreach (string line in File.ReadLines(p))
                {
                    if (line.StartsWith("Description"))
                        continue;
                    var entries = line.Split(',');
                    ret.Add(new Tuple<string, int>(entries[1].Trim(), int.Parse(entries[2].Trim())));
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

        private static void readAVNOutput(string output)
        {
            foreach (string line in output.Split('\n'))
            {
                Console.WriteLine(line);
                if (!line.StartsWith("[TAG: AV_STATS]"))
                    continue;
            }
        }

        // Prune by removing procedures that are not called
        private static Program pruneDeepProcs(Program origProgram, string mainProcName, int k)
        {
            if (mainProcName == null)
                return origProgram;

            var boundedDepth = (k > 0);

            Program program = (new FixedDuplicator(false)).VisitProgram(origProgram);

            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var decl in program.TopLevelDeclarations)
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
            var reachable = new HashSet<string>();
            reachable.Add(mainProcName);

            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0 && (!boundedDepth  || k-- > 0))
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
                if (decl is Implementation && toRemove.Contains((decl as Implementation).Name)) continue;
                if (decl is Procedure && ((Procedure)decl).Name != mainProcName)
                    decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes); // leave single entrypoint
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
