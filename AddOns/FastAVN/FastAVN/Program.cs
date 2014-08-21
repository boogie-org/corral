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
        static bool dumpSlices = true; // dump sliced program for each entrypoint
        static readonly string bugReportFileName = "results.txt"; // default bug report filename produced by AVN
        static string avnArgs = "/sdv /useEntryPoints /dumpResults:" + bugReportFileName
            + " /timeout:" + avnTimeout; // default AVN arguments
        static string mergedBugReportName = "bugs.txt";
        static int numThreads = 4; // default number of parallel AVN instances
        private static string CORRAL_EXTRA_INIT = "corralExtraInit";
        static bool fieldNonNull = true; // include angelic field non-null harness


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

            if (args.Any(s => s == "/noFieldNonNull"))
                fieldNonNull = false;

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
                prog = GetProgram(args[0]); // get the input program

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

        // run AVN binary on sliced programs
        private static void sliceAndRunAVN(Program prog, int approximationDepth)
        {
            ConcurrentBag<string> entryPoints = new ConcurrentBag<string>();
            //HashSet<string> mergedBugs = new HashSet<string>();
            ConcurrentDictionary<string, int> mergedBugs = new ConcurrentDictionary<string, int>();

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

            Parallel.ForEach(prog.TopLevelDeclarations.Where(x => x is Implementation),
                new ParallelOptions { MaxDegreeOfParallelism = numThreads }, i =>
            {
                var impl = (Implementation)i;
                // skip this impl if it is not marked as an entrypoint
                if (!QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                    return;

                entryPoints.Add(impl.Name);
                // slice the program by entrypoints
                Program shallowP = pruneDeepProcs(prog, ref edges, impl.Name, approximationDepth);

                var runAVNargs = " ";
                try
                {
                    Directory.CreateDirectory(impl.Name); // create new directory for each entrypoint
                    var pruneFile = (dumpSlices || numThreads > 1) ?
                        string.Format("{0}\\pruneSlice.bpl", impl.Name) : "pruneSlice.bpl";
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
                            Utils.Print(string.Format("Bugs found so far: {0}", mergedBugs.Count));
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

            printBugs(ref mergedBugs, entryPoints.Count);
            Utils.Print(string.Format("#EntryPoints : {0}", entryPoints.Count), Utils.PRINT_TAG.AV_STATS);
            Utils.Print(string.Format("#Bugs : {0}", mergedBugs.Count), Utils.PRINT_TAG.AV_STATS);
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

        // read program from the disk
        private static Program GetProgram(string filename)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            //Program init = BoogieUtil.ReadAndOnlyResolve(filename);
            Program init = BoogieUtil.ParseProgram(filename);
            init.Resolve();

            return init;
        }

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