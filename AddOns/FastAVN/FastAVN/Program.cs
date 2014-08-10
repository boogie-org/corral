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
        static int approximationDepth = 0; // k-depth
        static string boogieOpts = "";
        static string corralOpts = "";
        static cba.Configs corralConfig = null;
        static string avnPath = null;
        static string avnArgs = "";

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: FastAVN file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

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
            corralConfig = InitializeCorral();

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

            avnPath = Path.Combine(runDir, avn);
            Utils.Print(String.Format("Found AVN at: {0}", avnPath));
        }

        // Initialization
        static cba.Configs InitializeCorral()
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // Set all defaults for corral
            corralOpts += " doesntExist.bpl /track:alloc /useProverEvaluate /printVerify ";
            var config = cba.Configs.parseCommandLine(corralOpts.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
            config.boogieOpts += boogieOpts;
            cba.Driver.Initialize(config);

            cba.VerificationPass.usePruning = false;

            if (!config.useProverEvaluate)
            {
                cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
                if (config.NonUniformUnfolding && !config.useProverEvaluate)
                    cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = false;
                if (config.printData == 0)
                    cba.ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
            }

            return config;
        }

        private static void pruneImpl(Program prog, int approximationDepth)
        {
            HashSet<string> entrypoints = new HashSet<string>();

            foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
            {
                // skip this impl if it is not marked as an entrypoint
                if (!QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                    continue;
                Stats.count("entry.points");
                impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                entrypoints.Add(impl.Name);

                // slice the program by entrypoints
                Program shallowP = pruneDeepProcs(prog, impl.Name, approximationDepth);
                var pruneFile = string.Format("prune_{0}.bpl", impl.Name);
                BoogieUtil.PrintProgram(shallowP, pruneFile);
                avnArgs = " " + pruneFile + " " + avnArgs;

                Utils.Print(string.Format("Start running AVN: {0}", avnArgs), Utils.PRINT_TAG.AV_DEBUG);
                Process.Start(avnPath, avnArgs);
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
                if (decl is Procedure && toRemove.Contains((decl as Procedure).Name)) continue;
                if (decl is Implementation && toRemove.Contains((decl as Implementation).Name)) continue;
                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;

            return program;
        }

        private static Program GetProgram(string filename)
        {
            Program init = BoogieUtil.ReadAndOnlyResolve(filename);
            return init; 
        }
    }
}
