
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using SimpleHoudini = cba.SimpleHoudini;
using AvUtil;
using PropInstUtils;

namespace AngelicVerifierNull
{
    class Options
    {
        // Reuse tracked variables and explored call tree across corral runs
        public static bool UsePrevCorralState = true;
        // Use Corral's DeepAssert instrumentation
        public static bool DeepAsserts = false;
        // use EBasic?
        public static bool useEbasic = true;
        // Don't use EE to block paths
        public static bool useEE = true;
        // Perform trace slicing
        public static bool TraceSlicing = false;
        // Flags for EE
        public static HashSet<string> EEflags = new HashSet<string>();
        // ExplainError timeout (in seconds)
        public static int eeTimeout = 1000;
        // Flag for generalization
        public static bool generalize = true;
        // Max num. of attempts at blocking
        public static int MAX_REPEATED_BLOCK_EXPR = 2;
        // Remove axioms on alloc constants
        public static bool RemoveAllocConstantAxioms = true;
        // disable optimized deadcode detection
        public static bool disbleDeadcodeOpt = false;
        // Flag for reporting assertion when MAX_ASSERT_BLOCK_COUNT is reached
        public static bool reportOnMaxBlockCount = false;
        // Suppress when blocking on free variables?
        public static bool blockOnFreeVars = false;
        // File containing the filters for ExplainError
        public static string eeFilters = "";
        // Don't use the duplicator for cloning programs -- BCT programs seem to crash as a result
        public static bool UseDuplicator
        { set { ProgTransformation.PersistentProgramIO.useDuplicator = value; } }
    }

    public class Driver
    {
        static cba.Configs corralConfig = null;
        static cba.AddUniqueCallIds addIds = null;
        static HashSet<string> IdentifiedEntryPoints = new HashSet<string>();
        static System.IO.TextWriter ResultsFile = null;
        public static ExplainError.ControlFlowDependency controlFlowDependencyInformation = null;

        static string boogieOpts = "";
        static string corralOpts = "";
        static int timeout = 0;
        static int timeoutRelax = 100;
        public static bool allocateParameters = true; //allocating parameters for procedures
        static bool trackAllVars = false; //track all variables
        static bool dumpTimedoutCorralQueries = false;
        static bool runHoudini = false;

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

            SetOptions(args);

            // Initialize Boogie and Corral
            corralConfig = InitializeCorral();
            ProgTransformation.PersistentProgramIO.useStrings = true; 

            try
            {
                Stats.resume("Cpu");

                // Get input program with the harness
                Utils.Print(String.Format("----- Analyzing {0} ------", args[0]), Utils.PRINT_TAG.AV_OUTPUT);

                var prog = BoogieUtil.ReadAndOnlyResolve(args[0]);
                cba.PrintSdvPath.SaveSourceInfo(prog);
                GlobalCorralSpecificPass(prog);
                Debug.Assert(corralConfig.mainProcName != null);

                // Print Stats
                Utils.Print(string.Format("#Procs : {0}",prog.TopLevelDeclarations.OfType<Implementation>().Count()),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#Asserts : {0}",AssertCountVisitor.Count(prog)),Utils.PRINT_TAG.AV_STATS);

                // Install unknownTriggers
                mallocInstrumentation = new Instrumentations.MallocInstrumentation(prog);
                mallocInstrumentation.DoInstrument();

                // remove Ebasic
                if (!Options.useEbasic)
                {
                    // strip out {:Ebasic}
                    prog.TopLevelDeclarations.OfType<Implementation>()
                        .Iter(impl => impl.Blocks
                            .Iter(blk =>
                                blk.Cmds.RemoveAll(c => (c is AssumeCmd &&
                                    QKeyValue.FindBoolAttribute((c as AssumeCmd).Attributes, AvnAnnotations.EnvironmentAssumptionAttr)))));
                }

                // remove {:inline} attributes on procedures without a body; its confusing
                var impls = new HashSet<string>(prog.TopLevelDeclarations.OfType<Implementation>().Select(impl => impl.Name));
                foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>().Where(p => !impls.Contains(p.Name)))
                    proc.Attributes = BoogieUtil.removeAttr("inline", proc.Attributes);

                var program = new PersistentProgram(prog, corralConfig.mainProcName, 0);

                // hook to run the control flow slicing static analysis pre pass
                if (Options.TraceSlicing)
                {
                    controlFlowDependencyInformation = new ExplainError.ControlFlowDependency(prog);
                    controlFlowDependencyInformation.Run();

                    // package up the program
                    program = new PersistentProgram(prog, program.mainProcName, program.contextBound);
                    
                }
                program.writeToFile(args[0].Substring(0, args[0].Length - ".bpl".Length) + "_inst.bpl");

                //Analyze
                RunCorralForAnalysis(program);

                Stats.stop("Cpu");
            }
            catch (Exception e)
            {
                //stacktrace containts source locations, confuses regressions that looks for AV_OUTPUT
                Utils.Print(String.Format("AngelicVerifier failed with: {0}", e.Message), Utils.PRINT_TAG.AV_OUTPUT); 
                Utils.Print(String.Format("AngelicVerifier failed with: {0}", e.Message + e.StackTrace), Utils.PRINT_TAG.AV_DEBUG);
            }
            finally
            {
                Console.WriteLine("Final tracked vars: {0}", corralState.TrackedVariables.Print());
                Stats.printStats();
                Utils.Print(string.Format("TotalTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);
                if (ResultsFile != null) ResultsFile.Close();
            }
        }

        public static void SetOptions(string[] args)
        {
            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/sdv"))
                printTraceMode = PRINT_TRACE_MODE.Sdv;

            if (args.Any(s => s == "/runHoudini"))
                runHoudini = true;

            args.Where(s => s.StartsWith("/bopt:"))
                .Iter(s => boogieOpts += " \"/" + s.Substring("/bopt:".Length) + "\" ");
            args.Where(s => s.StartsWith("/copt:"))
                .Iter(s => corralOpts += " /" + s.Substring("/copt:".Length) + " ");

            if (args.Any(s => s == "/noReuse"))
                Options.UsePrevCorralState = false;

            if (args.Any(s => s == "/trackAllVars"))
                trackAllVars = true;

            if (args.Any(s => s == "/deepAsserts"))
                Options.DeepAsserts = true;

            if (args.Any(s => s == "/noEbasic"))
                Options.useEbasic = false;

            if (args.Any(s => s == "/dumpTimedoutCorralQueries"))
                dumpTimedoutCorralQueries = true;

            if (args.Any(s => s == "/noEE"))
                Options.useEE = false;

            if (args.Any(s => s == "/dontGeneralize"))
                Options.generalize = false;

            if (args.Any(s => s == "/retainAxioms"))
                Options.RemoveAllocConstantAxioms = false;

            if (args.Any(s => s == "/reportOnMaxBlock"))
                Options.reportOnMaxBlockCount = true;

            if (args.Any(s => s == "/blockOnFreeVars"))
                Options.blockOnFreeVars = true;

            args.Where(s => s.StartsWith("/timeout:"))
                .Iter(s => timeout = int.Parse(s.Substring("/timeout:".Length)));

            args.Where(s => s.StartsWith("/timeoutEE:"))
                .Iter(s => Options.eeTimeout = int.Parse(s.Substring("/timeoutEE:".Length)));

            if (args.Any(s => s == "/traceSlicing"))
                Options.TraceSlicing = true;

            args.Where(s => s.StartsWith("/EE:"))
                .Iter(s => Options.EEflags.Add("/" + s.Substring("/EE:".Length)));

            args.Where(s => s.StartsWith("/EEfilters:"))
                .Iter(s => Options.eeFilters = s.Substring("/EEfilters:".Length));

            args.Where(s => s.StartsWith("/maxTries:"))
                .Iter(s => Options.MAX_REPEATED_BLOCK_EXPR = int.Parse(s.Substring("/maxTries:".Length)));

            string resultsfilename = null;
            args.Where(s => s.StartsWith("/dumpResults:"))
                .Iter(s => resultsfilename = s.Substring("/dumpResults:".Length));

            Options.UseDuplicator = true;
            if (args.Any(s => s == "/nodup"))
                Options.UseDuplicator = false;

            if (resultsfilename != null)
            {
                ResultsFile = new System.IO.StreamWriter(resultsfilename);
                ResultsFile.WriteLine("Description,Src File,Line,Procedure,Fail Status"); // result file header
                ResultsFile.Flush();
            }
        }


        //globals
        static Instrumentations.MallocInstrumentation mallocInstrumentation = null;
        static Dictionary<int, HashSet<int>> DeadCodeBranchesDependencyInfo = null; // unknown -> set of affected branches

        #region Corral related
        // Set timeout for Corral
        static void SetCorralTimeout(int corralTimeout)
        {
            Console.WriteLine("Setting Corral timeout to {0} seconds", corralTimeout);
            cba.GlobalConfig.timeOut = corralTimeout;
            cba.GlobalConfig.corralStartTime = DateTime.Now;

        }

        // Initialization
        public static cba.Configs InitializeCorral()
        {
            // 
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            
            // Set all defaults for corral
            corralOpts += " doesntExist.bpl /track:alloc /track:$Alloc /useProverEvaluate /printVerify ";
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
            // Find some entrypoint
            var ep = init.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint") ||
                    QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                .Select(impl => impl.Name)
                .FirstOrDefault();
            corralConfig.mainProcName = ep;

            //if (BoogieUtil.findProcedureImpl(init.TopLevelDeclarations, corralConfig.mainProcName) == null)
            //{
            //    throw new InvalidInput("Implementation of main procedure not found");
            //}

            //Debug.Assert(cba.SequentialInstrumentation.isSingleThreadProgram(init, corralConfig.mainProcName));
            cba.GlobalConfig.isSingleThreaded = true;

            addIds = new cba.AddUniqueCallIds();
            addIds.VisitProgram(init);

            var extraVars = cba.Driver.findTemplates(init, corralConfig);
            corralConfig.trackedVars.UnionWith(extraVars);
            cba.GlobalConfig.InferPass.printHoudiniQuery = corralConfig.houdiniQuery;
            if(!runHoudini) cba.GlobalConfig.InferPass = null;
        }

        class ErrorTraceInfo
        {
            public string TraceName; 
            public cba.ErrorTrace Trace;
            public Program TraceProgram;
            public Tuple<string, int> AssertLoc;

            public ErrorTraceInfo(string TraceName, cba.ErrorTrace Trace, Program TraceProgram, Tuple<string, int> AssertLoc)
            {
                this.TraceName = TraceName;
                this.Trace = Trace;
                this.AssertLoc = AssertLoc;
                this.TraceProgram = TraceProgram;
            }
        }

        // How many times an assertion has been blocked for an entrypoint
        static Dictionary<string, int> AssertionBlockedCount = new Dictionary<string, int>();

        static int eecnt = 0;

        //Run Corral over different assertions (modulo errorLimit)
        // Returns true if the call finishes conclusively
        private static bool RunCorralIterative(AvnInstrumentation instr, int corralTimeout)
        {
            Stats.resume("run.corral.iterative");
            var corralIterativeStartTime = DateTime.Now;

            int iterCount = 0;
            var ret = true;         
 
            // Pending traces; contraint id -> trace
            var pendingTraces = new Dictionary<int, ErrorTraceInfo>();

            //We are not using the guards to turn the asserts, we simply rewrite the assert
            while (true)
            {
                var prog = instr.GetCurrProgram();

                // Don't reuse the call-tree 
                if(corralState != null)
                    corralState.CallTree = new HashSet<string>();

                Utils.Print(string.Format("Recursion Bound: {0}", CommandLineOptions.Clo.RecursionBound), Utils.PRINT_TAG.AV_DEBUG);
                
                Stats.count("corral.count");
                cba.ErrorTrace cex = null;
                
                try
                {
                    Stats.resume("run.corral");
                    cex = RunCorral(prog, instr.assertsPassedName, corralTimeout);
                    Stats.stop("run.corral");

                    cba.Stats.printStats();
                    Console.WriteLine("Number of procedures inlined: {0}", cba.Stats.ProgCallTreeSize);
                    cba.Stats.ProgCallTreeSize = 0;
                    Console.WriteLine("Time elapsed so far: {0}", (DateTime.Now - corralIterativeStartTime).TotalSeconds);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Corral call terminates inconclusively with {0}...", e.Message);
                    ret = false;
                    break;
                }
                

                if (cex == null)
                {
                    Console.WriteLine("No more counterexamples found, Corral returns verified...");
                    break;
                }

                //get the pathProgram
                CoreLib.SDVConcretizePathPass concretize;
                var pprog = GetPathProgram(cex, prog, out concretize);

                var ppprog = pprog.getProgram();
                var mainImpl = BoogieUtil.findProcedureImpl(ppprog.TopLevelDeclarations, pprog.mainProcName);

                // find failing assert cmd from path program
                var failingAssert = GetFailingAssertFromTraceProg(instr, ppprog);
                //Console.WriteLine("Assert -> {0}", failingAssert);
                var failStatus = BoogieUtil.checkAttrExists(AliasAnalysis.MarkMustAliasQueries.mustNULL, failingAssert.Attributes) ? cba.PrintSdvPath.mustFail : cba.PrintSdvPath.notmustFail; 
      
                //call ExplainError 
                BoogieUtil.PrintProgram(ppprog, string.Format("ee{0}.bpl", eecnt++));

                Stats.resume("explain.error");
                List<Tuple<string, int, string>> eeSlicedSourceLines = null;
                var eeStatus = CheckWithExplainError(ppprog, mainImpl,concretize, "", Options.EEflags, out eeSlicedSourceLines);
                if (!Options.TraceSlicing) eeSlicedSourceLines = null;
                Stats.stop("explain.error");

                // print the trace to disk
                var traceName = "Trace" + traceCount;
                Console.WriteLine("Printing trace {0}", traceName);
                var stubs = instr.GetStubs(cex);
                if (stubs.Count == 0) failStatus = cba.PrintSdvPath.notmustFail;
                var assertLoc = instr.PrintErrorTrace(cex, traceName, eeSlicedSourceLines, failStatus);
                Console.WriteLine("Stubs used along the trace: {0}", stubs.Print());
                traceCount++;

                var traceInfo = new ErrorTraceInfo(traceName, cex, pprog.getProgram(), assertLoc);

                if (eeStatus.Item1 == REFINE_ACTIONS.SUPPRESS) {
                    SuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo });
                }
                else if (eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
                {
                    PrintAndSuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo }, failStatus);
                }
                else if (eeStatus.Item1 == REFINE_ACTIONS.BLOCK_PATH)
                {
                    // check how many times we've blocked this guy
                    var done = false;
                    if (assertLoc != null)
                    {
                        var key = assertLoc.ToString();
                        if (!AssertionBlockedCount.ContainsKey(key))
                            AssertionBlockedCount[key] = 0;
                        AssertionBlockedCount[key]++;

                        if (AssertionBlockedCount[key] > MAX_ASSERT_BLOCK_COUNT)
                        {
                            Console.WriteLine("Unable to block {0} after {1} tries; hence suppressing", assertLoc, MAX_ASSERT_BLOCK_COUNT);
                            if (Options.reportOnMaxBlockCount)
                            {
                                PrintAndSuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo }, failStatus);
                                done = false;
                            }
                            else
                            {
                                SuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo });
                                done = true;
                            }
                        }
                    }

                    if (!done)
                    {
                        var constraintId = instr.SuppressInput(eeStatus.Item2);
                        pendingTraces.Add(constraintId, traceInfo);
                        Stats.count("blocked.count");

                        // Check inconsistency
                        Console.WriteLine("Checking inconsistency"); var startTime = DateTime.Now;
                        var inconsistent = CheckInconsistency(instr, BranchesAffected(eeStatus.Item2));
                        Console.WriteLine("Inconsistency check took: {0} seconds", (DateTime.Now - startTime).TotalSeconds.ToString("F2"));

                        if (inconsistent.Count != 0)
                        {
                            Debug.Assert(inconsistent.Contains(constraintId));
                            Console.WriteLine("Hard constraint inconsistency detected: ", inconsistent.Print());
                            // drop asserts
                            PrintAndSuppressAssert(instr, pendingTraces.Where(tup => inconsistent.Contains(tup.Key)).Select(tup => tup.Value), failStatus);
                            // drop constraints
                            inconsistent.Iter(id => instr.RemoveInputSuppression(id));
                            // drop traces
                            inconsistent.Iter(id => pendingTraces.Remove(id));
                        }
                        else
                        {
                            // Relax env constraints
                            RelaxEnvironmentConstraints(instr, null, false);
                        }
                    }

                }

                iterCount++;
            }
            Stats.stop("run.corral.iterative");
            return ret;
        }

        private static AssertCmd GetFailingAssertFromTraceProg(AvnInstrumentation instr, Program pathProgram)
        {
            var tok = GetToken(instr, pathProgram);
            var failingAssert = instr.GetFailingAssert(tok);
            return failingAssert;
        }

        private static AssertToken GetToken(AvnInstrumentation instr, Program pathProgram)
        {
            var impl = pathProgram.TopLevelDeclarations.OfType<Implementation>()
                .First();

            var tokenId = -1;
            foreach (var acmd in impl.Blocks[0].Cmds.OfType<PredicateCmd>())
            {
                tokenId = QKeyValue.FindIntAttribute(acmd.Attributes, "avn", -1);
                if (tokenId == -1) continue;
                break;
            }

            Debug.Assert(tokenId != -1);
            var token = new AssertToken(tokenId);

            return token;
        }

        // Given the EE blocking condition, find the deadcode branches that are possibly affected
        // TODO: Populate DeadCodeBranchesDependencyInfo somehow
        static HashSet<int> BranchesAffected(Expr expr)
        {
            // null means all
            if (Options.disbleDeadcodeOpt || DeadCodeBranchesDependencyInfo == null) return null;

            // find the set of triggers used in the Expr, get their allocation sites
            var asites = new HashSet<int>();
            var vu = new VarsUsed();
            vu.VisitExpr(expr);
            vu.functionsUsed.Where(f => mallocInstrumentation.mallocTriggerToAllocationSite.ContainsKey(f))
                .Iter(f => asites.Add(mallocInstrumentation.mallocTriggerToAllocationSite[f]));

            //Console.WriteLine("Blocking condition has triggers: {0}", asites.Print());

            var ret = new HashSet<int>();
            asites.Where(a => DeadCodeBranchesDependencyInfo.ContainsKey(a))
                .Iter(a => ret.UnionWith(DeadCodeBranchesDependencyInfo[a]));

            //Console.WriteLine("Blocking condition can potentially affect branches: {0}", ret.Print());

            return ret;
        }

        // Relax environment constraints Ebasic
        private static void RelaxEnvironmentConstraints(AvnInstrumentation instr, HashSet<int> branchesToInstrument, bool onlydeadcode)
        {
            if (!Options.useEbasic)
                return;

            Console.WriteLine("Relaxing environment constraints");

            // Get program
            var program = instr.GetCurrProgram().getProgram();

            // disable assertions in the program
            var assertToAssume = new Func<Cmd, Cmd>(cmd =>
            {
                var acmd = cmd as AssertCmd;
                if (acmd == null || BoogieUtil.isAssertTrue(cmd)) return cmd;
                return new AssumeCmd(cmd.tok, acmd.Expr, acmd.Attributes);
            });
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                foreach (var block in impl.Blocks)
                    block.Cmds = new List<Cmd>(block.Cmds.Map(c => assertToAssume(c)));

            // Name the soft constraints
            var softcnt = 0;
            var soft2actual = new Dictionary<int, int>();
            var AddAttr = new Action<Cmd>(cmd =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return;
                var id = QKeyValue.FindIntAttribute(acmd.Attributes, AvnAnnotations.EnvironmentAssumptionAttr, -1);
                if (id == -1) return;
                acmd.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.RelaxConstraintAttr, new List<object> { Expr.Literal(softcnt) }, acmd.Attributes);
                soft2actual.Add(softcnt, id);
                softcnt++;
            });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (!instr.procsWithEnvAssumptions.Contains(impl.Name))
                    continue;
                foreach (var block in impl.Blocks)
                {
                    block.Cmds.Iter(AddAttr);
                }
            }

            var reach = FindReachableStatesFunc(program);

            // change assume Reachable(e) to assert !e
            var assertcnt = 0;
            var mutate = new Func<Cmd, Cmd>(cmd =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return cmd;
                var nary = acmd.Expr as NAryExpr;
                if (nary == null) return cmd;
                if (onlydeadcode && !BoogieUtil.checkAttrExists("deadcode", acmd.Attributes)) return cmd;
                if (nary.Fun is FunctionCall && (nary.Fun as FunctionCall).FunctionName == reach.Name)
                {
                    var id = QKeyValue.FindIntAttribute(acmd.Attributes, "deadcode", -1);
                    if (id == -1 || branchesToInstrument == null ||
                        branchesToInstrument.Contains(id))
                    {
                        assertcnt++;
                        return new AssertCmd(Token.NoToken, Expr.Not(nary.Args[0]));
                    }
                    else
                    {
                        return new AssumeCmd(Token.NoToken, Expr.True);
                    }
                }
                else
                    return cmd;
            });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                foreach (var block in impl.Blocks)
                    block.Cmds = new List<Cmd>(block.Cmds.Select(c => mutate(c)));

            Console.WriteLine("RelaxEnvironment: {0} env constraints and {1} assertions", softcnt, assertcnt);

            if (softcnt == 0 || assertcnt == 0)
            {
                return;
            }

            // Now, move assertions to the end of main
            var main = program.TopLevelDeclarations.OfType<Implementation>().Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();
            var sI = new cba.SequentialInstrumentation();
            var cprogram = sI.runCBAPass(new cba.CBAProgram(program, main.Name, 1));

            // shallow checking only
            var sd = CommandLineOptions.Clo.StackDepthBound;
            CommandLineOptions.Clo.StackDepthBound = AvnAnnotations.RelaxConstraintsStackDepthBound;
            //BoogieUtil.PrintProgram(program, "env.bpl");

            var ret = RelaxConstraints(cprogram, cprogram.mainProcName, sI.assertsPassedName);

            CommandLineOptions.Clo.StackDepthBound = sd;

            if(ret != null)
                ret.Iter(n => instr.SuppressEnvironmentConstraint(soft2actual[n]));
        }

        public static Function FindReachableStatesFunc(Program program)
        {
            var ret = program.TopLevelDeclarations.OfType<Function>()
                .Where(f => QKeyValue.FindBoolAttribute(f.Attributes, AvnAnnotations.ReachableStatesAttr))
                .FirstOrDefault();

            if (ret != null)
                return ret;

            ret = new Function(Token.NoToken, "MustReach", new List<Variable>{
                    BoogieAstFactory.MkFormal("x", btype.Bool, true)},
                BoogieAstFactory.MkFormal("y", btype.Bool, false));
            ret.AddAttribute(AvnAnnotations.ReachableStatesAttr);

            program.AddTopLevelDeclaration(ret);
            return ret;
        }

        private static void SuppressAssert(AvnInstrumentation instr, IEnumerable<ErrorTraceInfo> traceInfos)
        {

            var traces = "";
            traceInfos.Iter(info => traces += info.TraceName + " ");
            traces = "{" + traces + "}";

            foreach (var traceInfo in traceInfos)
            {
                var tok = instr.SuppressAssert(traceInfo.TraceProgram);
            }
        }

        static int AngelicCount = 0;

        private static void PrintAndSuppressAssert(AvnInstrumentation instr, IEnumerable<ErrorTraceInfo> traceInfos, string failStatus)
        {
            Stats.count("bug.count");

            var traces = "";
            traceInfos.Iter(info => traces += info.TraceName + " ");
            traces = "{" + traces + "}";
            Utils.Print(String.Format("ANGELIC_VERIFIER_WARNING: Failing traces {0}", traces), Utils.PRINT_TAG.AV_OUTPUT);

            if (Driver.printTraceMode == PRINT_TRACE_MODE.Sdv)
            {
                if (traceInfos.Count() == 1)
                {
                    System.IO.File.Copy(traceInfos.First().TraceName + ".tt", "Angelic" + AngelicCount + ".tt", true);
                    System.IO.File.Copy(traceInfos.First().TraceName + ".txt", "Angelic" + AngelicCount + ".txt", true);
                    System.IO.File.Copy(traceInfos.First().TraceName + "stack.txt", "Angelic" + AngelicCount + "stack.txt", true);
                }
                else
                {
                    int c = 0;
                    foreach (var t in traceInfos)
                    {
                        System.IO.File.Copy(traceInfos.First().TraceName + ".tt", "Angelic" + AngelicCount + "." + (c) + ".tt", true);
                        System.IO.File.Copy(traceInfos.First().TraceName + ".txt", "Angelic" + AngelicCount + "." + (c) + ".txt", true);
                        System.IO.File.Copy(traceInfos.First().TraceName + "stack.txt", "Angelic" + AngelicCount + "." + (c) + "stack.txt", true);
                        c++;
                    }
                }
            }

            AngelicCount++;

            foreach (var traceInfo in traceInfos)
            {
                var tok = instr.SuppressAssert(traceInfo.TraceProgram);
                var failingAssert = instr.GetFailingAssert(tok);

                var failingProc = instr.GetFailingAssertProcName(tok);

                var output = "";
                // screen output
                if (traceInfo.AssertLoc != null)
                {
                    output = string.Format("Assertion failed in proc {0} in file {1} line {2} with expr {3}",
                        failingProc, traceInfo.AssertLoc.Item1, traceInfo.AssertLoc.Item2, failingAssert.Expr.ToString());

                    // result file output
                    // format: Description, Src File, Line, Procedure, EntryPoint
                    if (ResultsFile != null)
                    {
                        ResultsFile.WriteLine("Assertion {0} failed,{1},{2},{3},{4}",
                            failingAssert.Expr.ToString(), traceInfo.AssertLoc.Item1, traceInfo.AssertLoc.Item2, failingProc, failStatus);
                        ResultsFile.Flush();
                    }
                }
                else
                {
                    output = string.Format("Assertion failed in proc {0} with expr {1}",
                        failingProc, failingAssert.Expr.ToString());
                }

                Console.WriteLine("{0}", output);
                Utils.Print(string.Format("ANGELIC_VERIFIER_WARNING: {0}", output), Utils.PRINT_TAG.AV_OUTPUT);
            }

            //if (eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
            //    Utils.Print(String.Format("ANGELIC_VERIFIER_WARNING: {0}", output), Utils.PRINT_TAG.AV_OUTPUT);
        }

        private static HashSet<int> CheckInconsistency(AvnInstrumentation instr, HashSet<int> deadcodeBranches)
        {
            // Get program
            var program = instr.GetCurrProgram().getProgram();

            // disable assertions in the program
            var assertToAssume = new Func<Cmd, Cmd>(cmd =>
            {
                var acmd = cmd as AssertCmd;
                if (acmd == null || BoogieUtil.isAssertTrue(cmd)) return cmd;
                return new AssumeCmd(cmd.tok, acmd.Expr, acmd.Attributes);
            });
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                foreach (var block in impl.Blocks)
                    block.Cmds = new List<Cmd>(block.Cmds.Map(c => assertToAssume(c)));

            // Remove Ebasic
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    block.Cmds.RemoveAll(cmd => (cmd is AssumeCmd) && QKeyValue.FindBoolAttribute((cmd as AssumeCmd).Attributes, AvnAnnotations.EnvironmentAssumptionAttr));
                }
            }

            var reach = FindReachableStatesFunc(program);

            // change assume Reachable(e) to assert !e
            var assertcnt = 0;
            var prunedassert = 0;
            var mutate = new Func<Cmd, Cmd>(cmd =>
                {
                    var acmd = cmd as AssumeCmd;
                    if (acmd == null) return cmd;
                    var nary = acmd.Expr as NAryExpr;
                    if (nary == null) return cmd;
                    if (nary.Fun is FunctionCall && (nary.Fun as FunctionCall).FunctionName == reach.Name)
                    {
                        var id = QKeyValue.FindIntAttribute(acmd.Attributes, "deadcode", -1);
                        if (id == -1 || deadcodeBranches == null ||
                            deadcodeBranches.Contains(id))
                        {
                            assertcnt++;
                            return new AssertCmd(Token.NoToken, Expr.Not(nary.Args[0]));
                        }
                        else
                        {
                            prunedassert++;
                            return new AssumeCmd(Token.NoToken, Expr.True);
                        }
                    }
                    else
                        return cmd;
                });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                foreach (var block in impl.Blocks)
                    block.Cmds = new List<Cmd>(block.Cmds.Select(c => mutate(c)));


            // name the soft constraints
            var softcnt = 0;
            var soft2actual = new Dictionary<int, int>();
            var AddAttrAssume = new Action<Cmd>(cmd =>
                {
                    var acmd = cmd as AssumeCmd;
                    if(acmd == null) return;
                    var id = QKeyValue.FindIntAttribute(acmd.Attributes, AvnAnnotations.BlockingConstraintAttr, -1);
                    if (id == -1) return;
                    acmd.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.RelaxConstraintAttr, new List<object> { Expr.Literal(softcnt) }, acmd.Attributes);
                    soft2actual.Add(softcnt, id);
                    softcnt++;
                });

            var AddAttrRequires = new Action<Requires>(req =>
            {
                var id = QKeyValue.FindIntAttribute(req.Attributes, AvnAnnotations.BlockingConstraintAttr, -1);
                if (id == -1) return;
                req.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.RelaxConstraintAttr, new List<object> { Expr.Literal(softcnt) }, req.Attributes);
                soft2actual.Add(softcnt, id);
                softcnt++;
            });


            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                foreach (var block in impl.Blocks)
                    block.Cmds.Iter(AddAttrAssume);

            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(p => p.Requires.Iter(AddAttrRequires));

            // Now, move assertions to the end of main
            var main = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            var sI = new cba.SequentialInstrumentation();
            var cprogram = sI.runCBAPass(new cba.CBAProgram(program, main.Name, 1));
            cprogram = (new cba.CompileRequiresAndEnsures()).runCBAPass(cprogram);

            //BoogieUtil.PrintProgram(cprogram, "relax.bpl");
            Console.WriteLine("CheckInconsistency: {0} soft constraints and {1} assertions ({2} pruned)", softcnt, assertcnt, prunedassert);

            var sd = CommandLineOptions.Clo.StackDepthBound;
            CommandLineOptions.Clo.StackDepthBound = AvnAnnotations.RelaxConstraintsStackDepthBound;

            // Relax
            var softret = RelaxConstraints(cprogram, cprogram.mainProcName, sI.assertsPassedName);

            CommandLineOptions.Clo.StackDepthBound = sd;

            var ret = new HashSet<int>();
            
            if(softret != null)
                softret.Iter(n => ret.Add(soft2actual[n]));

            return ret;
        }

        //Top-level Corral call
        private static void RunCorralForAnalysis(PersistentProgram prog)
        {
            ////////////////
            // Initial stuff
            ////////////////

            // Rewrite program to a more convinient form
            var rc = new cba.RewriteCallCmdsPass(true);
            prog = rc.run(prog);

            // prune
            var prune = new cba.PruneProgramPass();
            prog = prune.run(prog);

            // Run Houdini
            if (cba.GlobalConfig.InferPass != null)
            {
                //Console.WriteLine("Running Houdini");
                prog = cba.GlobalConfig.InferPass.run(prog);
                cba.GlobalConfig.InferPass = null;
            }

            // TODO: populate the set of stubs
            var instr = new AvnInstrumentation(new HashSet<string>());
            prog = instr.run(prog);

            // dead code
            RelaxEnvironmentConstraints(instr, null, true);

            // Run Corral outer loop
            RunCorralIterative(instr, timeout);
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
        static cba.CorralState corralState = new cba.CorralState();
        static int corralIterationCount = 0;
        static int traceCount = 0;

        // Run Corral on a sequential Boogie Program
        // Returns the error trace and the failing assert location
        static cba.ErrorTrace RunCorral(PersistentProgram inputProg, string assertsPassedName, int corralTimeout)
        {
            corralIterationCount ++;
            SetCorralTimeout(corralTimeout);
            CommandLineOptions.Clo.SimplifyLogFilePath = null;

            var trackedVars = new HashSet<string>(corralConfig.trackedVars);
            if (assertsPassedName != null) trackedVars.Add(assertsPassedName);

            // Reuse previous corral state
            if (corralState != null && Options.UsePrevCorralState)
            {
                trackedVars.UnionWith(corralState.TrackedVariables);
                cba.ConfigManager.progVerifyOptions.CallTree = corralState.CallTree;
            }

            ////////////////////////////////////
            // Verification phase
            ////////////////////////////////////
            var refinementState = new cba.RefinementState(inputProg,
                Driver.trackAllVars ?
                /*track all variables*/inputProg.allVars.Variables :
                /*do variable refinement*/trackedVars, 
                false);

            //inputProg.writeToFile("cquery" + corralIterationCount + ".bpl");

            cba.ErrorTrace cexTrace = null;
            var corralStart = DateTime.Now;
            try
            {
                Stats.count("count.check.refine");
                Stats.resume("check.and.refine");
                cba.Driver.checkAndRefine(inputProg, refinementState, null, out cexTrace);
                Stats.stop("check.and.refine");
            }
            catch (Exception)
            {
                Console.WriteLine("Corral took: {0} seconds", (DateTime.Now - corralStart).TotalSeconds.ToString("F2"));

                // dump corral state for next iteration
                corralState = new cba.CorralState();
                corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
                corralState.TrackedVariables = refinementState.getVars().Variables;
                cba.ConfigManager.progVerifyOptions.CallTree = null;

                if(dumpTimedoutCorralQueries)
                    DumpProgWithAsserts(inputProg.getProgram(), inputProg.mainProcName, 
                        "corralinp" + corralIterationCount + ".bpl");
                throw;
            }
            Console.WriteLine("Corral took: {0} seconds", (DateTime.Now - corralStart).TotalSeconds.ToString("F2"));

            // dump corral state for next iteration
            corralState = new cba.CorralState();
            corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
            corralState.TrackedVariables = refinementState.getVars().Variables;
            cba.ConfigManager.progVerifyOptions.CallTree = null;

            return cexTrace;
        }

        // Dump program (corral query) after putting the asserts back in.
        // Used only for debugging
        static void DumpProgWithAsserts(Program program, string mainProcName, string filename)
        {
            var ap = "assertsPassed";

            // Delete assignment and assertion of assertsPased in the main procedure.
            var main = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, mainProcName);
            foreach (var block in main.Blocks)
            {
                block.Cmds.RemoveAll(cmd =>
                    {
                        var vu = new VarsUsed();
                        vu.Visit(cmd);
                        if (vu.globalsUsed.Contains(ap))
                            return true;
                        return false;
                    });
            }

            // convert assertsPassed := e to assert e
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (impl.Name == mainProcName)
                    continue;
                foreach (var block in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (var cmd in block.Cmds)
                    {
                        var acmd = cmd as AssignCmd;
                        if (acmd == null)
                        {
                            ncmds.Add(cmd);
                            continue;
                        }
                        if (acmd.Lhss[0].DeepAssignedVariable.Name == ap)
                        {
                            ncmds.Add(new AssertCmd(Token.NoToken, acmd.Rhss[0]));
                        }
                        else
                        {
                            ncmds.Add(cmd);
                        }
                    }
                    block.Cmds = ncmds;
                }
            }
            
            // rename assertsPassed to assertsPassedConst and make it a constant equal to true
            program.RemoveTopLevelDeclarations(decl => decl is GlobalVariable &&
                (decl as GlobalVariable).Name == ap);

            var substD = new Dictionary<string, Variable>();
            var apC = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                ap + "const", btype.Bool));
            substD.Add(ap, apC);
            var subst = new VarSubstituter(substD, new Dictionary<string, Variable>());
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                subst.VisitImplementation(impl);
            }
            program.AddTopLevelDeclaration(apC);
            program.AddTopLevelDeclaration(new Axiom(Token.NoToken,
                Expr.Eq(Expr.Ident(apC), Expr.Literal(true))));

            BoogieUtil.PrintProgram(program, filename);
        }


        // Given a counterexample trace 'trace' through a program 'program', return the
        // path program for that trace. The path program has a single implementation 
        // with straightline code, and all non-determinism is concretized
        public static PersistentProgram GetPathProgram(cba.ErrorTrace trace, PersistentProgram program, out CoreLib.SDVConcretizePathPass concretize)
        {
            BoogieVerify.options = cba.ConfigManager.pathVerifyOptions;

            // convert trace to a path program
            //cba.RestrictToTrace.convertNonFailingAssertsToAssumes = true;
            var tinfo = new cba.InsertionTrans();
            var traceProgCons = new cba.RestrictToTrace(program.getProgram(), tinfo);
            traceProgCons.addTrace(trace);
            var tprog = traceProgCons.getProgram();
            //cba.RestrictToTrace.convertNonFailingAssertsToAssumes = false;

            // mark some annotations (that enable optimizations) along the path program
            CoreLib.SdvUtils.sdvAnnotateDefectTrace(tprog, corralConfig.trackedVars, false);

            // convert to a persistent program
            var witness = new cba.PersistentCBAProgram(tprog, traceProgCons.getFirstNameInstance(program.mainProcName), 0);
            // rewrite asserts back to main
            //witness = cba.DeepAssertRewrite.InstrumentTrace(witness);

            witness.writeToFile("trace_prog.bpl");

            // Concretize non-determinism
            BoogieVerify.options = cba.ConfigManager.pathVerifyOptions;
            concretize = new CoreLib.SDVConcretizePathPass();

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

        // Function takes in a Program and returns a list of integers corresponding to the assumes which have to be removed
        // The integers are present as {:SoftConstraint n}
        private static HashSet<int> RelaxConstraints(Program program, string main, string ap)
        {
            bool conclusive = true;
            var ret = new HashSet<int>();

            // move requires to assumes
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var newcmds = new List<Cmd>();
                foreach (var req in impl.Proc.Requires)
                    newcmds.Add(new AssumeCmd(req.tok, req.Condition, req.Attributes));

                impl.Proc.Requires = new List<Requires>();

                newcmds.AddRange(impl.Blocks[0].Cmds);
                impl.Blocks[0].Cmds = newcmds;
            }


            // Add Boolean Vars for environment constraints
            var boolVarMap = AddBooleanVariables(program);

            var prevTracked = corralState;
            var iter = 0;
            while (true)
            {
                iter++;
                cba.ErrorTrace cex = null;
                var pprog = new PersistentProgram(program, main, 1); // pprog.writeToFile("rl.bpl");
                corralState = new cba.CorralState();
                if(ap != null) corralState.TrackedVariables.Add(ap);

                try
                {
                    cex = RunCorral(pprog, null, timeoutRelax);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Corral call terminates inconclusively with {0}...", e.Message);
                    conclusive = false;
                    break;
                }

                if (cex == null)
                {
                    break;
                }

                //Console.WriteLine("Printing tt{0}", iter);
                //cba.PrintProgramPath.print(pprog, cex, "tt" + iter);

                // Suppress the assertion from the error trace
                SuppressAssertion(program, cex, ap);
            }

            if (!conclusive)
            {
                corralState = prevTracked;
                return null;
            }

            corralState.TrackedVariables
                .Where(tv => boolVarMap.ContainsKey(tv))
                .Iter(tv => ret.Add(boolVarMap[tv]));
            corralState = prevTracked;

            return ret;
        }

        // Used by RelaxConstraints.
        // Replace "assume {:SoftConstraint n} e" by
        //    assume e and b; assume b; 
        // for a fresh b
        // And returns the map {b -> n}
        private static Dictionary<string, int> AddBooleanVariables(Program program)
        {
            var map = new Dictionary<string, int>();

            var GetConstraintNum = new Func<QKeyValue, int>(ac => QKeyValue.FindIntAttribute(ac, AvnAnnotations.RelaxConstraintAttr, -1));
            var counter = 0;

            var newDecls = new List<Declaration>();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    var newcmds = new List<Cmd>();
                    foreach (var cmd in block.Cmds)
                    {
                        newcmds.Add(cmd);

                        var acmd = cmd as AssumeCmd;
                        if (acmd == null) continue;
                        var n = GetConstraintNum(acmd.Attributes);
                        if (n >= 0)
                        {
                            var lv = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "envTmp" + (counter++).ToString(), Microsoft.Boogie.Type.Bool));
                            acmd.Expr = (Expr.And(Expr.Ident(lv), acmd.Expr));
                            newDecls.Add(lv);
                            newcmds.Add(new AssumeCmd(Token.NoToken, Expr.Ident(lv)));
                            map.Add(lv.Name, n);
                        }
                    }
                    block.Cmds = newcmds;
                }
            }
            program.AddTopLevelDeclarations(newDecls);
            return map;
        }

        // Find failing assignment to err bit
        private static cba.AssertLocation findFailingAssert(Program program, cba.ErrorTrace trace, string ap)
        {
            if (trace == null) return null;

            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, trace.procName);
            var l2b = BoogieUtil.labelBlockMapping(impl);

            foreach (var tblk in trace.Blocks)
            {
                var pblk = l2b[tblk.blockName];
                for (int i = 0; i < tblk.Cmds.Count; i++)
                {
                    var ccmd = pblk.Cmds[i] as CallCmd;
                    if (ccmd != null)
                    {
                        var ret = findFailingAssert(program, tblk.Cmds[i].CalleeTrace, ap);
                        if (ret != null) return ret;
                    }
                    var cmd = pblk.Cmds[i] as AssignCmd;
                    if (cmd == null) continue;
                    if (cmd.Lhss[0].DeepAssignedVariable.Name != ap) continue;
                    var le = cmd.Rhss[0] as LiteralExpr;
                    if (le != null && le.IsTrue) continue;
                    return new cba.AssertLocation(impl.Name, tblk.blockName, i);
                }
            }
            return null;
        }

        private static void SuppressAssertion(Program program, cba.ErrorTrace trace, string ap)
        {
            cba.AssertLocation currLoc = findFailingAssert(program, trace, ap);
            Debug.Assert(currLoc != null);

            Console.WriteLine("{0} {1} {2}", currLoc.procName, currLoc.blockName, currLoc.instrNo);

            // find procedure
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, currLoc.procName);
            // find block
            var block = impl.Blocks.Where(blk => blk.Label == currLoc.blockName).First();
            // find instruction
            Debug.Assert(block.Cmds[currLoc.instrNo] is AssignCmd);
            var ac = block.Cmds[currLoc.instrNo] as AssignCmd;
            // block assert
            ac.SetAssignCmdRhs(0, Expr.True);
            //block.Cmds[currLoc.instrNo] = new AssumeCmd(ac.tok, ac.Expr, ac.Attributes);
        }
        #endregion

        #region ExplainError related
        private enum REFINE_ACTIONS { SHOW_AND_SUPPRESS, SUPPRESS, BLOCK_PATH };
        private const int MAX_REPEATED_FIELDS_IN_BLOCKS = 4;
        private const int MAX_ASSERT_BLOCK_COUNT = 3; // maximum times we try to block an assertion
        private static Dictionary<string, int> fieldInBlockCount = new Dictionary<string, int>();
        private static Dictionary<Tuple<string, string>, int> blockExprCount = new Dictionary<Tuple<string, string>, int>(); // count repeated block expr

        private static bool filterFileHasBeenRead = false;

        private static Tuple<REFINE_ACTIONS,Expr> CheckWithExplainError(Program nprog, Implementation mainImpl, 
            CoreLib.SDVConcretizePathPass concretize, string entrypoint_name, HashSet<string> extraEEflags, out List<Tuple<string, int, string>> eeSlicedSourceLines)
        {
            //Let ee be the result of ExplainError
            // if (ee is SUCCESS && ee is True) ShowWarning; Suppress 
            // else if (ee is SUCCESS(e)) Block(e); 
            // else //inconclusive/timeout/.. Suppress

            /////////
            //read the filter file
            if (!filterFileHasBeenRead && Options.eeFilters != "")
            {
                IEnumerable<string> filterFileLines;
                try
                {
                    filterFileLines = File.ReadLines(Options.eeFilters);
                }
                catch (Exception)
                {
                    Console.WriteLine("--- Error reading filter file! ---");
                    throw;
                }

                string templateVariables;
                List<string> negativeFilterStrings;
                List<string> positiveFilterStrings;
                PropertyParser.ParseProperty(filterFileLines, out templateVariables, out negativeFilterStrings,
                    out positiveFilterStrings);

                Console.WriteLine("Succeeded parsing filter file");
                Console.WriteLine("negative filters: " + String.Join(" ", negativeFilterStrings));
                Console.WriteLine("positive filters: " + String.Join(" ", positiveFilterStrings));

                var negativeFilters = new List<Expr>();
                var positiveFilters = new List<Expr>();
                negativeFilterStrings.Iter(nfs => negativeFilters.Add(createFilterFromString(templateVariables, nfs)));
                positiveFilterStrings.Iter(nfs => positiveFilters.Add(createFilterFromString(templateVariables, nfs)));

                ExplainError.Toplevel.useFiltersFromFile = true;
                ExplainError.Toplevel.negativeFilters = negativeFilters;
                ExplainError.Toplevel.positiveFilters = positiveFilters;

                filterFileHasBeenRead = true;
            }
            /////////

            eeSlicedSourceLines = null;
            var status = Tuple.Create(REFINE_ACTIONS.SUPPRESS, (Expr)Expr.True); //default is SUPPRESS (angelic)
            if (!Options.useEE) return Tuple.Create(REFINE_ACTIONS.SHOW_AND_SUPPRESS, (Expr)Expr.True); ;
            ExplainError.STATUS eeStatus = ExplainError.STATUS.INCONCLUSIVE;
            

            // Remove axioms on alloc constants
            var HasAllocConstant = new Func<Expr, bool>(e =>
            {
                var vu = new VarsUsed();
                vu.VisitExpr(e);
                if (vu.varsUsed.Intersect(concretize.allocConstants.Keys).Any())
                    return true;
                return false;
            });
            if(Options.RemoveAllocConstantAxioms)
                nprog.RemoveTopLevelDeclarations(decl => (decl is Axiom) && HasAllocConstant((decl as Axiom).Expr));

            // Add these flags by default (nothing right now)
            var eeflags = new List<string>(); // {"/onlySlicAssumes+", "/ignoreAllAssumes-"};
            eeflags.AddRange(extraEEflags);

            Dictionary<string, string> eeComplexExprs;
            // Save commandlineoptions
            var clo = CommandLineOptions.Clo;
            try
            {            
                HashSet<List<Expr>> preDisjuncts;

                //First compute a control slice (soundly irrespective of EE assume filters)
                var skipAssumes = new HashSet<AssumeCmd>();
                if (Options.TraceSlicing)
                    skipAssumes = ExplainError.Toplevel.TrueTraceSlicing(mainImpl, nprog, Options.eeTimeout, controlFlowDependencyInformation, out eeSlicedSourceLines);

                //Now perform the precondition generation, taking skipAssumes into account
                List<Tuple<string, int, string>> tmpEESlicedSourceLines; //don't overwrite the sound slice if the error is displayed
                var explain = ExplainError.Toplevel.Go(mainImpl, nprog, Options.eeTimeout, 1, eeflags.Concat(" "), 
                    controlFlowDependencyInformation,
                    skipAssumes,
                    out eeStatus, out eeComplexExprs, out preDisjuncts, out tmpEESlicedSourceLines);
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
                        
                        /* HACK: We should existentially quantify demonic non-determinism, but currently we just
                         * avoiding blocking */
                        var vu = new VarsUsed(); vu.Visit(blockExpr);
                        var demonicVars = vu.Vars.Where(v => concretize.allocConstants.ContainsKey(v.Name) || (!(v is BoundVariable) && !(v is Constant) && !v.TypedIdent.Type.IsMap));
                        if (demonicVars.Any())
                        {
                            // blocking expression has a scalar that is not bound by an unknownTrigger
                            Utils.Print(String.Format("Found free variables :: {0}", demonicVars.Select(v => v.Name).Concat(" ")), Utils.PRINT_TAG.AV_OUTPUT);
                            if (demonicVars.Any(v => v.Name.StartsWith(string.Format("alloc_{0}_", CoreLib.SDVConcretizePathPass.LocalVarInitValueAttr))))
                            {
                                Utils.Print(String.Format("Some free variable is an initial value of a local; cannot block or treat demonic"), Utils.PRINT_TAG.AV_OUTPUT);
                                status = Tuple.Create(REFINE_ACTIONS.SUPPRESS, (Expr)Expr.True);
                            }
                            else if (Options.blockOnFreeVars)
                            {
                                Utils.Print(String.Format("User option blockOnFreeVars set, thus blocking"), Utils.PRINT_TAG.AV_OUTPUT);
                                status = Tuple.Create(REFINE_ACTIONS.SUPPRESS, (Expr)Expr.True);
                            }
                            else
                            {
                                status = Tuple.Create(REFINE_ACTIONS.SHOW_AND_SUPPRESS, (Expr)Expr.True);
                            }
                        }
                        else
                        {
                            /*HACK: supress the assertion when it cannot be blocked*/
                            if (blockExprCount.ContainsKey(Tuple.Create(blockExpr.ToString(), entrypoint_name)))
                            {
                                if (blockExprCount[Tuple.Create(blockExpr.ToString(), entrypoint_name)]++ > Options.MAX_REPEATED_BLOCK_EXPR)
                                    throw new Exception("Repeating block expression detected. Not able to block!");
                            }
                            else
                                blockExprCount[Tuple.Create(blockExpr.ToString(), entrypoint_name)] = 1;

                            Utils.Print(String.Format("EXPLAINERROR-BLOCK :: {0}", blockExpr), Utils.PRINT_TAG.AV_OUTPUT);
                            status = Tuple.Create(REFINE_ACTIONS.BLOCK_PATH, blockExpr);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("ExplainError failed with {0}", e);
            }
            CommandLineOptions.Install(clo);
            return status;
        }

        private static Expr createFilterFromString(string templateVariables, string nfs)
        {
            Expr filterExpr = null;

            //string templateString = "{0}\n {1}\n procedure foo() {{\n assume {2};\n }}\n";
            string templateString = "{0}\n procedure foo() {{\n assume {1};\n }}\n";
            try
            {
                Program dummyProg;
                var progString = string.Format(templateString, templateVariables, nfs);
                Parser.Parse(progString, "dummy.bpl", out dummyProg);
                BoogieUtil.ResolveProgram(dummyProg, "dummy.bpl");
                filterExpr = ((AssumeCmd) dummyProg.Implementations.First().Blocks.First().Cmds.First()).Expr;
            }
            catch (Exception)
            {
            }
            return filterExpr;
        }

        private static Expr MkBlockExprFromExplainError(Program  nprog, Expr expr, Dictionary<string, int> allocConsts)
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

            //Utils.Print(String.Format("The list of allocConsts along trace = {0}", String.Join(", ",
            //            allocConsts
            //            .Select(x => "(" + x.Key + " -> " + x.Value + ")"))
            //));
            Dictionary<string, Tuple<Variable, Expr>> allocToBndVarAndTrigger = new Dictionary<string, Tuple<Variable, Expr>>();
            int allocConstCount = 0;
            allocConsts.ToList()
                // triggers for unknown are created by mallocInstrumentation, and each is tagged with ConcretizeCallIdAttr;
                // Others should be skipped
                .Where(x => x.Value >= 0)
                .Iter(x =>
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
                                        new TypedIdent(Token.NoToken, "x_" +  allocConstCount, mallocTriggerFn.InParams[0].TypedIdent.Type));
                        //make an expr mallocFn(x_i) for alloc_i
                        var fnApp = (Expr) new NAryExpr(Token.NoToken,
                                new FunctionCall(mallocTriggerFn),
                                new List<Expr> () {IdentifierExpr.Ident(bvar)});
                        allocToBndVarAndTrigger[xConst.Name] = Tuple.Create((Variable) bvar,  fnApp);
                    });

            var usedVarsCollector = new VariableCollector();
            usedVarsCollector.Visit(expr);
            Utils.Print(string.Format("List of used vars in {0} => {1}", expr, String.Join(", ", usedVarsCollector.usedVars)));

            var nexpr = (new Instrumentations.RewriteConstants(new HashSet<Variable>(usedVarsCollector.usedVars))).VisitExpr(expr); //get the expr in scope of pprog
            Debug.Assert(expr.ToString() == nexpr.ToString(), "Unexpected difference introduced during porting expression to current program");

            var aexpr = Options.generalize? AbstractRepeatedMapsInBlock(expr, new HashSet<Variable>(usedVarsCollector.usedVars)) : null;
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

    }
}
