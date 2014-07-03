using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;

namespace AngelicVerifierNull
{
    class InputProgramDoesNotMatchExn : Exception
    {
        public InputProgramDoesNotMatchExn(string s) : base(s) { } 
    }

    class Options
    {
        // Reuse tracked variables and explored call tree across corral runs
        public static readonly bool UsePrevCorralState = true;
    }

    class Stats
    {
        public static int numProcs = -1;
        public static int numProcsAnalyzed = -1;
        public static int numAssertsBeforeAliasAnalysis = -1;
        public static int numAssertsAfterAliasAnalysis = -1;
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

    public class Utils
    {
        //TODO: merge with Log class in Corral
        const bool SUPPRESS_DEBUG_MESSAGES = false;
        public enum PRINT_TAG { AV_WARNING, AV_DEBUG, AV_OUTPUT, AV_STATS };
        public static void Print(string msg, PRINT_TAG tag=PRINT_TAG.AV_DEBUG)
        {
            if (tag != PRINT_TAG.AV_DEBUG || !SUPPRESS_DEBUG_MESSAGES)
                Console.WriteLine("[TAG: {0}] {1}", tag, msg);
        }
    }
    class Driver
    {
        static cba.Configs corralConfig = null;
        static cba.AddUniqueCallIds addIds = null;
        static HashSet<string> IdentifiedEntryPoints = new HashSet<string>();
        static System.IO.TextWriter ResultsFile = null;

        const string CORRAL_MAIN_PROC = "CorralMain";

        static bool useProvidedEntryPoints = false; //making default true
        static string boogieOpts = "";
        static string corralOpts = "";
        static bool disableRoundRobinPrePass = false; //always do round robin with a timeout
        static int timeout = 0;
        static int timeoutRoundRobin = 0;
        public static bool allocateParameters = true; //allocating parameters for procedures

        public enum PRINT_TRACE_MODE { Boogie, Sdv };
        public static PRINT_TRACE_MODE printTraceMode = PRINT_TRACE_MODE.Boogie;


        static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: AngelicVerifierNull file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/sdv"))
                printTraceMode = PRINT_TRACE_MODE.Sdv;

            args.Where(s => s.StartsWith("/bopt:"))
                .Iter(s => boogieOpts += " \"/" + s.Substring("/bopt:".Length) + "\" ");
            args.Where(s => s.StartsWith("/copt:"))
                .Iter(s => corralOpts += " /" + s.Substring("/copt:".Length) + " ");
                //.Iter(s => corralOpts += " \"/" + s.Substring("/copt:".Length) + "\" ");

            if (args.Any(s => s == "/noAllocation"))
                allocateParameters = false;

            if (args.Any(s => s == "/useEntryPoints"))
                useProvidedEntryPoints = true;

            if (args.Any(s => s == "/disableRoundRobinPrePass"))
                disableRoundRobinPrePass = true;

            args.Where(s => s.StartsWith("/timeout:"))
                .Iter(s => timeout = int.Parse(s.Substring("/timeout:".Length)));

            args.Where(s => s.StartsWith("/timeoutRoundRobin:"))
                .Iter(s => timeoutRoundRobin = int.Parse(s.Substring("/timeoutRoundRobin:".Length)));

            if (timeoutRoundRobin == 0)
                disableRoundRobinPrePass = true;

            string resultsfilename = null;
            args.Where(s => s.StartsWith("/dumpResults:"))
                .Iter(s => resultsfilename = s.Substring("/dumpResults:".Length));
            if (resultsfilename != null) ResultsFile = new System.IO.StreamWriter(resultsfilename);
            ResultsFile.WriteLine("Description,Src File,Line,Procedure,EntryPoint"); // result file header
            ResultsFile.Flush();

            // Initialize Boogie and Corral
            corralConfig = InitializeCorral();

            PersistentProgram prog = null;
            try
            {
                // Get input program with the harness
                Utils.Print(String.Format("----- Analyzing {0} ------", args[0]), Utils.PRINT_TAG.AV_OUTPUT);
                prog = GetProgram(args[0]);
                
                Stats.numAssertsBeforeAliasAnalysis = CountAsserts(prog);
                
                // Run alias analysis
                Stats.resume("alias.analysis");
                Console.WriteLine("Running alias analysis");
                prog = RunAliasAnalysis(prog);
                Stats.stop("alias.analysis");
                
                Stats.numAssertsAfterAliasAnalysis= CountAsserts(prog);

                Utils.Print(string.Format("#Procs : {0}",Stats.numProcs),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#EntryPoints : {0}",Stats.numProcsAnalyzed),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#AssertsBeforeAA : {0}",Stats.numAssertsBeforeAliasAnalysis),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#AssertsAfterAA : {0}",Stats.numAssertsAfterAliasAnalysis),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("InstrumentTime(ms) : {0}",sw.ElapsedMilliseconds),Utils.PRINT_TAG.AV_STATS);

                // count number of assertions per procedure after alias analysis
                foreach (Implementation impl in prog.getProgram().TopLevelDeclarations
                    .Where(x => x is Implementation))
                {
                    var assertVisitor = new Instrumentations.AssertCountVisitor();
                    assertVisitor.Visit(impl);
                    Stats.numAssertsPerProc[impl.Name] = assertVisitor.assertCount;
                }
                Debug.Assert(Stats.numAssertsPerProc.Values.Sum() == Stats.numAssertsAfterAliasAnalysis);

                //Analyze
                RunCorralForAnalysis(prog);
            }
            catch (Exception e)
            {
                Utils.Print(String.Format("AnglelicVerifier failed with: {0}", e.Message + e.StackTrace), Utils.PRINT_TAG.AV_OUTPUT);
            }
            finally
            {
                Stats.printStats();
                Utils.Print(string.Format("TotalTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);
                if (ResultsFile != null) ResultsFile.Close();
            }
        }

        #region Instrumentatations
        //globals
        static Instrumentations.MallocInstrumentation mallocInstrumentation = null;
        static Instrumentations.HarnessInstrumentation harnessInstrumentation = null;
        /// <summary>
        /// TODO: Check that the input program satisfies some sanity requirements
        /// NULL is declared as constant
        /// malloc is declared as a procedure, with alloc
        /// each parameter/global/map is annotated with "pointer/ref/data"
        /// </summary>
        /// <param name="init"></param>
        private static void CheckInputProgramRequirements(Program init)
        {
            return;
        }
        static PersistentProgram GetProgram(string filename)
        {
            Program init = BoogieUtil.ReadAndOnlyResolve(filename);

            //Sanity check (currently most of it happens inside HarnessInstrumentation)
            CheckInputProgramRequirements(init);

            //Instrument to create the harness
            corralConfig.mainProcName = CORRAL_MAIN_PROC;
            harnessInstrumentation = new Instrumentations.HarnessInstrumentation(init, corralConfig.mainProcName, useProvidedEntryPoints);
            harnessInstrumentation.DoInstrument();
            IdentifiedEntryPoints = harnessInstrumentation.entrypoints;

            //resolve+typecheck wo bothering about modSets
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            init = BoogieUtil.ReResolve(init);
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            // Update mod sets
            BoogieUtil.DoModSetAnalysis(init);

            //TODO: Perform alias analysis here and prune a subset of asserts

            //Various instrumentations on the well-formed program

            mallocInstrumentation = new Instrumentations.MallocInstrumentation(init);
            mallocInstrumentation.DoInstrument();
            //(new Instrumentations.AssertGuardInstrumentation(init)).DoInstrument(); //we don't guard asserts as we turn off the assert explicitly

            //Print the instrumented program
            BoogieUtil.PrintProgram(init, "corralMain.bpl");

            //Do corral specific passes
            GlobalCorralSpecificPass(init);
            var inputProg = new PersistentProgram(init, corralConfig.mainProcName, 1);
            ProgTransformation.PersistentProgram.FreeParserMemory();

            return inputProg;
        }
        private static int CountAsserts(PersistentProgram prog)
        {
            var assertVisitor = new Instrumentations.AssertCountVisitor();
            assertVisitor.Visit(prog.getProgram());
            return assertVisitor.assertCount;
        }
        #endregion

        #region Corral related
        // Set timeout for Corral
        static void SetCorralTimeout(int corralTimeout)
        {
            if (corralTimeout == 0)
                return;

            Console.WriteLine("Setting Corral timeout to {0} seconds", corralTimeout);
            cba.GlobalConfig.timeOut = corralTimeout;
            cba.GlobalConfig.corralStartTime = DateTime.Now;

        }

        // Initialization
        static cba.Configs InitializeCorral()
        {
            // 
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
        // Make a pass to ensure the whole program created is well formed
        private static void GlobalCorralSpecificPass(Program init)
        {
            // Find main
            List<string> entrypoints = cba.EntrypointScanner.FindEntrypoint(init);
            if (entrypoints.Count == 0)
                throw new InvalidInput("Main procedure not specified");
            corralConfig.mainProcName = entrypoints[0];

            if (BoogieUtil.findProcedureImpl(init.TopLevelDeclarations, corralConfig.mainProcName) == null)
            {
                throw new InvalidInput("Implementation of main procedure not found");
            }

            Debug.Assert(cba.SequentialInstrumentation.isSingleThreadProgram(init, corralConfig.mainProcName));
            cba.GlobalConfig.isSingleThreaded = true;

            // Massage the input program
            addIds = new cba.AddUniqueCallIds();
            addIds.VisitProgram(init);
        }
        //Run Corral over different assertions (modulo errorLimit)
        private static PersistentProgram RunCorralIterative(PersistentProgram prog, string p, int corralTimeout)
        {
            Stats.resume("run.corral.iterative");
            int iterCount = 0;
            //We are not using the guards to turn the asserts, we simply rewrite the assert
            while (true)
            {
                Stats.count("corral.count");
                Tuple<cba.ErrorTrace, cba.AssertLocation> cex = null;
                
                try
                {
                    Stats.resume("run.corral");
                    cex = RunCorral(prog, corralConfig.mainProcName, corralTimeout);
                    Stats.stop("run.corral");
                }
                catch (Exception e)
                {
                    Console.WriteLine("Corral call terminates inconclusively with {0}...", e.Message);
                    break;
                }
                var traceType = "";

                if (cex == null)
                {
                    Console.WriteLine("No more counterexamples found, Corral returns verified...");
                    break;
                }

                // Identify the entrypoint that led to the assertion violation.
                // It will be the entrypoint that main calls
                var failingEntryPoint =
                    cex.Item1.Blocks.Select(blk => blk.Cmds.OfType<cba.CallInstr>()).Aggregate((a, b) => a.Concat(b))
                    .Where(ci => IdentifiedEntryPoints.Contains(ci.callee))
                    .Select(ci => ci.callee)
                    .FirstOrDefault();

                //get the pathProgram
                cba.SDVConcretizePathPass concretize;
                var pprog = GetPathProgram(cex.Item1, prog, out concretize);
                //pprog.writeToFile("path" + iterCount + ".bpl");
                var ppprog = pprog.getProgram(); //don't do getProgram on pprog anymore
                var mainImpl = BoogieUtil.findProcedureImpl(ppprog.TopLevelDeclarations, pprog.mainProcName);                
                //call ExplainError 
                Stats.resume("explain.error");
                var eeStatus = CheckWithExplainError(ppprog, mainImpl,concretize);
                Stats.stop("explain.error");
                //get the program once 
                var nprog = prog.getProgram();
                
                if (eeStatus.Item1 == REFINE_ACTIONS.SUPPRESS ||
                    eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
                {
                    traceType = (eeStatus.Item1 == REFINE_ACTIONS.SUPPRESS) ? "Suppressed" : "Angelic";

                    var ret = SupressFailingAssert(nprog, cex.Item2);
                    if (ret == null)
                    {
                        Console.WriteLine("Failure is not an assert, skipping...");
                        Debug.Assert(false);
                        continue;
                    }
                    else
                    {
                        // screen output
                        var output = string.Format("Assertion failed in proc {0} at line {1} with expr {2} and entrypoint {3}", 
                            cex.Item2.procName, ret.Line, ret.Expr.ToString(), failingEntryPoint);
                        if (printTraceMode == PRINT_TRACE_MODE.Sdv)
                        {
                            // Print assertion location in terms of source file
                            //BoogieUtil.PrintProgram(ppprog, "ppprog.bpl");
                            var loc = GetFailingLocation(ppprog, string.Format("Assertion failed in proc {0} in file {{0}} line {{1}} with expr {1} and entrypoint {2}", cex.Item2.procName, ret.Expr.ToString(), failingEntryPoint));
                            if (loc != null) output = loc;                            
                        }

                        Console.WriteLine(output);
                        // result file output
                        // format: Description, Src File, Line, Procedure, EntryPoint
                        var resultLine = GetFailingLocation(ppprog, string.Format("Assertion {0} failed,{{0}},{{1}},{1},{2}",
                            ret.Expr.ToString(), cex.Item2.procName, failingEntryPoint));
                        if (ResultsFile != null && resultLine != null)
                        {
                            Stats.count("bug.count");
                            ResultsFile.WriteLine(resultLine);
                            ResultsFile.Flush();
                        }
                        if (eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
                            Utils.Print(String.Format("ANGELIC_VERIFIER_WARNING: {0}", output),Utils.PRINT_TAG.AV_OUTPUT);
                    }
                }
                else if (eeStatus.Item1 == REFINE_ACTIONS.BLOCK_PATH)
                {
                    traceType = "Blocked";
                    var mainProc = nprog.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == corralConfig.mainProcName).FirstOrDefault();
                    if (mainProc == null)
                        throw new Exception(String.Format("Cannot find the main procedure {0} to add blocking requires", corralConfig.mainProcName));
                    mainProc.Requires.Add(new Requires(false, eeStatus.Item2)); //add the blocking condition and iterate

                    Stats.count("blocked.count");
                }

                // print the trace to disk
                Console.WriteLine("Printing trace {0}", traceType + traceCount);
                PrintTrace(cex.Item1, prog, traceType + traceCount);
                traceCount++;

                prog = new PersistentProgram(nprog, corralConfig.mainProcName, 1);
                
                iterCount++;
                //Print the instrumented program
                //BoogieUtil.PrintProgram(prog.getProgram(), "corralMain_after_iteration_" + iterCount + ".bpl");
            }
            Stats.stop("run.corral.iterative");
            return prog;
        }

        // precondition: prog had a single implementation with a single block
        private static string GetFailingLocation(Program prog, string format)
        {
            var impl = prog.TopLevelDeclarations.OfType<Implementation>().FirstOrDefault();
            if (impl == null) return null;
            var block = impl.Blocks[0];
            foreach (var cmd in block.Cmds.OfType<PredicateCmd>().Reverse())
            {
                if (!BoogieUtil.checkAttrExists("sourcefile", cmd.Attributes)) continue;
                var file = QKeyValue.FindStringAttribute(cmd.Attributes, "sourcefile");
                var line = QKeyValue.FindIntAttribute(cmd.Attributes, "sourceline", -1);
                if (file == null || line == -1) continue;
                return string.Format(format, file, line);
            }
            return null;
        }

        //Run RunCorralIterative with only one procedure enabled
        private static PersistentProgram RunCorralRoundRobin(PersistentProgram pprog, string p)
        {
            Utils.Print("Using round robin exploration...", Utils.PRINT_TAG.AV_DEBUG);
            var prog = pprog.getProgram();
            var blockConstNames = harnessInstrumentation.blockEntryPointConstants.Keys;
            var blockCallConsts = prog.TopLevelDeclarations
                .OfType<Constant>()
                .Where(x => blockConstNames.Contains(x.Name));
            //TODO: iterate for multiple rounds removing procedures once they are verified
            foreach (var bc in blockCallConsts)
            {
                Utils.Print(string.Format("Analyzing procedure {0} in round robin mode", harnessInstrumentation.blockEntryPointConstants[bc.Name]),
                     Utils.PRINT_TAG.AV_DEBUG);
                Utils.Print(string.Format("number.assertions: {0}", Stats.numAssertsPerProc[harnessInstrumentation.blockEntryPointConstants[bc.Name]]),
                    Utils.PRINT_TAG.AV_DEBUG);

                //enable only the procedure corresponding to kv
                var tmp = new HashSet<Constant>(blockCallConsts);
                tmp.Remove(bc);
                var blockExpr = tmp.Aggregate((Expr)Expr.True, (x, y) => (Expr.And(x, Expr.Not(IdentifierExpr.Ident(y))))); 
                var mainProc = prog.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == corralConfig.mainProcName).FirstOrDefault();
                if (mainProc == null)
                    throw new Exception(String.Format("Cannot find the main procedure {0} to add blocking requires", corralConfig.mainProcName));
                mainProc.Requires.Add(new Requires(false, blockExpr)); //add the blocking condition and iterate
                pprog = new PersistentProgram(prog, corralConfig.mainProcName, 1);
                //we give less timeout for the individual procedure

                var startTime = DateTime.Now; // Start time of round robin mode
                pprog = RunCorralIterative(pprog, corralConfig.mainProcName, timeoutRoundRobin);
                var endTime = DateTime.Now; // End time of round robin mode
                Utils.Print(string.Format("Time taken: {0} s", (endTime - startTime).TotalSeconds),
                    Utils.PRINT_TAG.AV_DEBUG);
                
                //TODO: need to remove the requires corresponding to the blockExpr, but the program has changed 
                //      and more requires corresponding to blockign clauses may have been added
                //find the mainProc in the new program
                prog = pprog.getProgram();
                mainProc = prog.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == corralConfig.mainProcName).FirstOrDefault();
                if (mainProc == null)
                    throw new Exception(String.Format("Cannot find the main procedure {0} to add blocking requires", corralConfig.mainProcName));
                mainProc.Requires.RemoveAll(x => x.Condition.ToString() == blockExpr.ToString());

                Stats.printStats();
            }
            return new PersistentProgram(prog, corralConfig.mainProcName, 1);
        }
        //Top-level Corral call
        private static void RunCorralForAnalysis(PersistentProgram prog)
        {
            Stats.resume("round.robin");
            //Run Corral in a round robin manner to remove simple procedures/find shallow bugs
            if (!disableRoundRobinPrePass)
                prog = RunCorralRoundRobin(prog, corralConfig.mainProcName);
            Stats.stop("round.robin");

            // Run Corral outer loop
            RunCorralIterative(prog, corralConfig.mainProcName,timeout);
        }

        // print trace to disk
        public static void PrintTrace(cba.ErrorTrace trace, PersistentProgram program, string name)
        {
            if(printTraceMode == PRINT_TRACE_MODE.Boogie) 
                cba.PrintProgramPath.print(program, trace, name);
            else
                cba.PrintSdvPath.Print(program.getProgram(), trace, new HashSet<string>(), null, name + ".tt", "stack.txt");
        }

        // Returns the failing assertion, and supresses it in the input program
        private static AssertCmd SupressFailingAssert(Program program, cba.AssertLocation aloc)
        {
            // find procedure
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, aloc.procName);
            // find block
            var block = impl.Blocks.Where(blk => blk.Label == aloc.blockName).First();
            // find instruction
            Debug.Assert(block.Cmds[aloc.instrNo] is AssertCmd);
            var ret = block.Cmds[aloc.instrNo] as AssertCmd;
            // block assert
            block.Cmds[aloc.instrNo] = new AssumeCmd(ret.tok, ret.Expr, ret.Attributes);

            return ret;
        }
        static cba.CorralState corralState = null;
        static int corralIterationCount = 0;
        static int traceCount = 0;

        // Run Corral on a sequential Boogie Program
        // Returns the error trace and the failing assert location
        static Tuple<cba.ErrorTrace, cba.AssertLocation> RunCorral(PersistentProgram inputProg, string main, int corralTimeout)
        {
            Debug.Assert(cba.GlobalConfig.isSingleThreaded);
            Debug.Assert(cba.GlobalConfig.InferPass == null);
            corralIterationCount ++;
            SetCorralTimeout(corralTimeout);
            CommandLineOptions.Clo.SimplifyLogFilePath = null;

            //inputProg.writeToFile("corralinp" + corralIterationCount + ".bpl");

            // Reuse previous corral state
            if (corralState != null && Options.UsePrevCorralState)
            {
                corralConfig.trackedVars.UnionWith(corralState.TrackedVariables);
                cba.ConfigManager.progVerifyOptions.CallTree = corralState.CallTree;
            }

            // Rewrite assert commands
            var apass = new cba.RewriteAssertsPass();
            var curr = apass.run(inputProg);

            // Rewrite call commands 
            var rcalls = new cba.RewriteCallCmdsPass(true);
            curr = rcalls.run(curr);

            // Prune
            cba.PruneProgramPass.RemoveUnreachable = true;
            var prune = new cba.PruneProgramPass(false);
            curr = prune.run(curr);
            cba.PruneProgramPass.RemoveUnreachable = false;

            // Sequential instrumentation
            var seqInstr = new cba.SequentialInstrumentation();
            curr = seqInstr.run(curr);

            ProgTransformation.PersistentProgram.FreeParserMemory();

            // For debugging, create an Action for printing a trace at the source level
            var passes = new List<cba.CompilerPass>(new cba.CompilerPass[] { seqInstr, prune, rcalls, apass });
            var printTrace = new Action<cba.ErrorTrace, string>((trace, fileName) =>
            {
                if (!cba.GlobalConfig.genCTrace)
                    return;
                passes.Where(p => p != null)
                    .Iter(p => trace = p.mapBackTrace(trace));
                cba.PrintConcurrentProgramPath.printCTrace(inputProg, trace, fileName);
                apass.reset();
            });


            ////////////////////////////////////
            // Verification phase
            ////////////////////////////////////

            var refinementState = new cba.RefinementState(curr, new HashSet<string>(corralConfig.trackedVars.Union(new string[] { seqInstr.assertsPassedName })), false);

            cba.ErrorTrace cexTrace = null;
            try
            {
                cba.Driver.checkAndRefine(curr, refinementState, printTrace, out cexTrace);
            }
            catch (Exception)
            {
                // dump corral state for next iteration
                corralState = new cba.CorralState();
                corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
                corralState.TrackedVariables = refinementState.getVars().Variables;
                throw;
            }

            // dump corral state for next iteration
            corralState = new cba.CorralState();
            corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
            corralState.TrackedVariables = refinementState.getVars().Variables;

            ////////////////////////////////////
            // Output Phase
            ////////////////////////////////////

            if (cexTrace != null)
            {
                cexTrace = seqInstr.mapBackTrace(cexTrace);
                cexTrace = prune.mapBackTrace(cexTrace);
                cexTrace = rcalls.mapBackTrace(cexTrace);
                //PrintProgramPath.print(rcalls.input, cexTrace, "temp0");
                cexTrace = apass.mapBackTrace(cexTrace);
                return Tuple.Create(cexTrace, apass.getFailingAssertLocation());
            }

            return null;
        }
        // Given a counterexample trace 'trace' through a program 'program', return the
        // path program for that trace. The path program has a single implementation 
        // with straightline code, and all non-determinism is concretized
        static PersistentProgram GetPathProgram(cba.ErrorTrace trace, PersistentProgram program, out cba.SDVConcretizePathPass concretize)
        {
            BoogieVerify.options = cba.ConfigManager.pathVerifyOptions;

            // convert trace to a path program
            cba.RestrictToTrace.convertNonFailingAssertsToAssumes = true;
            var tinfo = new cba.InsertionTrans();
            var traceProgCons = new cba.RestrictToTrace(program.getProgram(), tinfo);
            traceProgCons.addTrace(trace);
            var tprog = traceProgCons.getProgram();
            cba.RestrictToTrace.convertNonFailingAssertsToAssumes = false;

            // mark some annotations (that enable optimizations) along the path program
            cba.Driver.sdvAnnotateDefectTrace(tprog, corralConfig);

            // convert to a persistent program
            var witness = new cba.PersistentCBAProgram(tprog, traceProgCons.getFirstNameInstance(program.mainProcName), 0);
            // rewrite asserts back to main
            witness = cba.DeepAssertRewrite.InstrumentTrace(witness);

            witness.writeToFile("trace_prog.bpl");

            // Concretize non-determinism
            BoogieVerify.options = cba.ConfigManager.pathVerifyOptions;
            concretize = new cba.SDVConcretizePathPass(addIds.callIdToLocation);

            // TODO: set a reasonable timeout here
            BoogieVerify.setTimeOut(0);
            witness = concretize.run(witness); 

            if (concretize.success)
            {
                // Something went wrong, fail 
                throw new Exception("Path program concretization failed");
            }

            // optinally, dump the witness to a file
            // witness.writeToFile("corral_witness.bpl");

            return witness;
        }
        #endregion

        #region ExplainError related
        private enum REFINE_ACTIONS { SHOW_AND_SUPPRESS, SUPPRESS, BLOCK_PATH };
        private const int MAX_REPEATED_FIELDS_IN_BLOCKS = 4;
        private static Dictionary<string, int> fieldInBlockCount = new Dictionary<string, int>();
        private static Tuple<REFINE_ACTIONS,Expr> CheckWithExplainError(Program nprog, Implementation mainImpl, 
            cba.SDVConcretizePathPass concretize)
        {
            //Let ee be the result of ExplainError
            // if (ee is SUCCESS && ee is True) ShowWarning; Suppress 
            // else if (ee is SUCCESS(e)) Block(e); 
            // else //inconclusive/timeout/.. Suppress
            var status = Tuple.Create(REFINE_ACTIONS.SUPPRESS, (Expr)Expr.True); //default is SUPPRESS (angelic)
            ExplainError.STATUS eeStatus = ExplainError.STATUS.INCONCLUSIVE;

            Dictionary<string, string> eeComplexExprs;
            try
            {
                HashSet<List<Expr>> preDisjuncts;
                var explain = ExplainError.Toplevel.Go(mainImpl, nprog, 1000, 1, out eeStatus, out eeComplexExprs, out preDisjuncts, "suggestions.bpl");
                Utils.Print(String.Format("The output of ExplainError => Status = {0} Exprs = ({1})",
                    eeStatus, explain != null ? String.Join(", ", explain) : ""));
                if (eeStatus == ExplainError.STATUS.SUCCESS)
                {
                    if (explain.Count == 1 && explain[0].TrimEnd(new char[]{' ', '\t'}) == Expr.True.ToString())
                        status = Tuple.Create(REFINE_ACTIONS.SHOW_AND_SUPPRESS, (Expr) Expr.True);
                    else if (explain.Count > 0)
                    {
                        var blockExpr = Expr.Not(ExplainError.Toplevel.ExprListSetToDNFExpr(preDisjuncts));
                        blockExpr = MkBlockExprFromExplainError(nprog, blockExpr, concretize.allocConstants);
                        Utils.Print(String.Format("EXPLAINERROR-BLOCK :: {0}", blockExpr), Utils.PRINT_TAG.AV_OUTPUT);
                        status = Tuple.Create(REFINE_ACTIONS.BLOCK_PATH, blockExpr); 
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("ExplainError failed with {0}", e);
            }
            return status;
        }
        private static Expr MkBlockExprFromExplainError(Program  nprog, Expr expr, Dictionary<string, Tuple<string, string, int>> allocConsts)
        {
            //- given expr, allocConsts (string)
            //- usedVars = varsUsedIn(expr)
            //- newUsedVars = Lookup(usedVars, pprog)  // subset of newAllocConsts U NULL     
            //- newAllocConsts= Lookup(allocConsts, pprog)
            //- allocToBv: newAllocConsts -> bv 
            //- allocToTriggers: newAllocConsts -> triggers (all in pprog)

            //- forallBV = newUsedVars \intersect newAllocConsts
            //  forallPre = \wedge_i (trigger(bv) | bv \in forallBV)
            //  forallPost = expr[newUsedVars/usedVars][allocToBV/newAllocConsts]
            //- forall forallBV :: forallPre => forallPost

            Utils.Print(String.Format("The list of allocConsts along trace = {0}", String.Join(", ",
                        allocConsts
                        .Select(x => "(" + x.Key + " -> [" + x.Value.Item1 + ", " + x.Value.Item2 + ", " + x.Value.Item3 + "])"))
            ));
            Dictionary<string, Tuple<Variable, Expr>> allocToBndVarAndTrigger = new Dictionary<string, Tuple<Variable, Expr>>();
            int allocConstCount = 0;
            allocConsts.ToList()
                .ForEach(x =>
                    {
                        var xConst = nprog.TopLevelDeclarations.OfType<Constant>().Where(y => y.Name == x.Key).FirstOrDefault();
                        if (xConst == null)
                            throw new Exception(String.Format("WARNING!!: Cannot find constant with the name {0}", x.Key));
                        allocConstCount++;
                        string mallocTrigger;
                        //sometimes Corral creates an alloc_k variable for non ":allocator" calls, skip them
                        if (!mallocInstrumentation.mallocTriggersLocation.TryGetValue(x.Value, out mallocTrigger))
                            throw new Exception(String.Format("WARNING!!: allocConst {0} has no mallocTrigger", x.Key));
                        var mallocTriggerFn = nprog.TopLevelDeclarations.OfType<Function>().Where(y => y.Name == mallocTrigger).FirstOrDefault();
                        if (mallocTriggerFn == null)
                            throw new Exception(String.Format("WARNING!!: Current program has no mallocTrigger with name", mallocTrigger));
                        //create a new bound variable for quantified expr later
                        var bvar =  new BoundVariable(Token.NoToken, 
                                        new TypedIdent(Token.NoToken, "x_" +  allocConstCount, Microsoft.Boogie.Type.Int));
                        //make an expr mallocFn(x_i) for alloc_i
                        var fnApp = (Expr) new NAryExpr(Token.NoToken,
                                new FunctionCall(mallocTriggerFn),
                                new List<Expr> () {IdentifierExpr.Ident(bvar)});
                        allocToBndVarAndTrigger[xConst.Name] = Tuple.Create((Variable) bvar,  fnApp);
                    });

            var usedVarsCollector = new VariableCollector();
            usedVarsCollector.Visit(expr);
            Utils.Print(string.Format("List of used vars in {0} => {1}", expr, String.Join(", ", usedVarsCollector.usedVars)));

            var nexpr = (new Instrumentations.RewriteConstants(usedVarsCollector.usedVars)).VisitExpr(expr); //get the expr in scope of pprog
            Debug.Assert(expr.ToString() == nexpr.ToString(), "Unexpected difference introduced during porting expression to current program");

            var aexpr = AbstractRepeatedMapsInBlock(expr, usedVarsCollector.usedVars);
            if (aexpr != null)
            {
                Utils.Print(string.Format("Generalizing field block expression for {0} to {1}", expr, aexpr));
                return aexpr;
            }

            var substMap = new Dictionary<Variable, Expr>();
            var forallPre = new List<Expr>();
            List<Variable> bvarList = new List<Variable>(); //only bound variables used in the expression
            usedVarsCollector.usedVars.Iter(x =>
            {
                if (allocToBndVarAndTrigger.ContainsKey(x.Name))
                {
                    substMap[x] = (Expr) IdentifierExpr.Ident(allocToBndVarAndTrigger[x.Name].Item1);
                    forallPre.Add(allocToBndVarAndTrigger[x.Name].Item2);
                    bvarList.Add(allocToBndVarAndTrigger[x.Name].Item1);
                }
            });
            Substitution subst = Substituter.SubstitutionFromHashtable(substMap);
            nexpr = Substituter.Apply(subst, nexpr);
            Utils.Print(string.Format("The substituted expression for {0} is {1}", expr, nexpr));

            //create the forall (forall x_i..: malloc_Trigger_i(x_i) .. => expr')
            var forallPreExpr = forallPre.Aggregate(
                                        (Expr) Expr.True,
                                        (x, y) => ExplainError.Toplevel.ExprUtil.And(x, y));
            var forallBody = Expr.Imp(forallPreExpr, nexpr);
            //Utils.Print(string.Format("The body of forall {0}", forallBody));

            Expr forallExpr;
            if (bvarList.Count == 0)
            {
                Utils.Print(String.Format("The expression has no free allocated variables {0}", forallBody), Utils.PRINT_TAG.AV_WARNING);
                forallExpr = forallBody;
            }
            else
            {
                forallExpr = new ForallExpr(Token.NoToken, bvarList, forallBody);
            }
            return forallExpr;
        }

        private static Expr AbstractRepeatedMapsInBlock(Expr expr, HashSet<Variable> supportVars)
        {
            var repeatedFields = new HashSet<Variable>();
            //once a field has been generalized, we should not see blocks over it
            supportVars.Iter(x =>
                {
                    if (x.TypedIdent.Type.IsMap && x.TypedIdent.Type.MapArity == 1)
                    {
                        var xstr = x.ToString();
                        if (fieldInBlockCount.ContainsKey(xstr))
                            fieldInBlockCount[xstr]++;
                        else
                            fieldInBlockCount[xstr] = 1;
                        if (fieldInBlockCount[xstr] > MAX_REPEATED_FIELDS_IN_BLOCKS)
                            repeatedFields.Add(x);
                    }
                }
                );
            if (repeatedFields.Count == 0) return null;
            Expr returnExpr = null; 
            foreach (var m in repeatedFields)
            {
                var bvar = new BoundVariable(Token.NoToken, new TypedIdent(Token.NoToken, "_z", m.TypedIdent.Type.AsMap.Arguments[0]));
                var fexpr = Expr.Gt(BoogieAstFactory.MkMapAccessExpr(m, IdentifierExpr.Ident(bvar)), 
                    new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(0)));
                var forallExpr = new ForallExpr(Token.NoToken, new List<Variable>() { bvar }, fexpr);
                if (returnExpr == null)
                    returnExpr = forallExpr;
                else
                    returnExpr = Expr.And(returnExpr, forallExpr);
            }
            return returnExpr;
        }

        //private static void AbstractAndRecordBlock(Expr expr, HashSet<Variable> supportVars)
        //{
        //    var substMap = new Dictionary<Variable, Expr>();
        //    var forallPre = new List<Expr>();
        //    List<Variable> bvarList = new List<Variable>(); //only bound variables used in the expression
        //    int cnt = 0; 
        //    supportVars.Iter(x =>
        //    {
        //        if (x.TypedIdent.Type.IsInt && !(x is Constant)) //exclude NULL
        //        {
        //            var bvar =                                                 
        //                new BoundVariable(Token.NoToken, new TypedIdent(Token.NoToken, "_z" + (cnt++), x.TypedIdent.Type));
        //            substMap[x] = (Expr)IdentifierExpr.Ident(bvar);
        //            bvarList.Add(bvar);
        //        }
        //    });
        //    Substitution subst = Substituter.SubstitutionFromHashtable(substMap);
        //    var nexpr = Substituter.Apply(subst, expr);
        //    nexpr = new ForallExpr(Token.NoToken, bvarList, nexpr);
        //    Utils.Print(string.Format("The abstracted block expression for {0} is {1}", expr, nexpr));
        //}
        #endregion

        #region Alias analysis

        // Run Alias Analysis on a sequential Boogie program
        // and returned the pruned program
        static PersistentProgram RunAliasAnalysis(PersistentProgram inp)
        {
            var program = inp.getProgram();

            // Make sure that aliasing queries are on identifiers only
            AliasAnalysis.SimplifyAliasingQueries.Simplify(program);

            // Do SSA
            program =
              SSA.Compute(program, PhiFunctionEncoding.Verifiable, new HashSet<string> { "int" });

            //AliasAnalysis.AliasAnalysis.dbg = true;
            //AliasAnalysis.AliasConstraintSolver.dbg = true;
            var ret =
              AliasAnalysis.AliasAnalysis.DoAliasAnalysis(program);

            //foreach (var tup in ret)
            //    Console.WriteLine("{0}: {1}", tup.Key, tup.Value);

            var origProgram = inp.getProgram();
            AliasAnalysis.PruneAliasingQueries.Prune(origProgram, ret);

            return new PersistentProgram(origProgram, inp.mainProcName, inp.contextBound);
        }
        #endregion
    }
}
