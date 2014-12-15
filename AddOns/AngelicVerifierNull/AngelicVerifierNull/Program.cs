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
using SimpleHoudini = cba.SimpleHoudini;

namespace AngelicVerifierNull
{
    class InputProgramDoesNotMatchExn : Exception
    {
        public InputProgramDoesNotMatchExn(string s) : base(s) { } 
    }

    class Options
    {
        // Reuse tracked variables and explored call tree across corral runs
        public static bool UsePrevCorralState = true;
        // Don't use alias analysis
        public static bool UseAliasAnalysis = true;
        // Don't use context and flow sensitive alias analysis
        public static bool UseCSFSAliasAnalysis = false;
        // Do Houdini pass to remove some assertions
        public static bool HoudiniPass = false;
        // Add unsound options for NULL
        public static bool AddMapSelectNonNullAssumptions = false;
        // Use Corral's DeepAssert instrumentation
        public static bool DeepAsserts = false;
        // Use field non-null assumption
        public static bool FieldNonNull = true;
        // do buffer overrun detection
        public static bool bufferDetect = false;
        // relax environment constraints
        public static bool RelaxEnvironment = false;
        // use procs tagged as {:harness} as potential entrypoints as well
        public static bool useHarnessTag = false;
        // use EBasic?
        public static bool useEbasic = true;
        // Don't use EE to block paths
        public static bool useEE = true;
        // EE option to perform control flow slicing 
        public static bool EEPerformControlSlicing = true;  
        // Output trace slicing
        public static bool TraceSlicing = false;
        // Flags for EE
        public static HashSet<string> EEflags = new HashSet<string>();
        // property: nonnull, typestate
        public static string propertyChecked = "";
        // ExplainError timeout (in seconds)
        public static int eeTimeout = 1000;
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

    public static class AvnAnnotations
    {
        public static readonly string CORRAL_MAIN_PROC = "CorralMain";
        public static readonly string BlockingConstraintAttr = "BlockingConstraint";
        public static readonly string InitialializationProcAttr = "ProgramInitialization";
        public static readonly string EnvironmentAssumptionAttr = "Ebasic";
        public static readonly string ReachableStatesAttr = "ReachableStates";
        public static readonly string RelaxConstraintAttr = "SoftConstraint";
    }

    class Driver
    {
        static cba.Configs corralConfig = null;
        static cba.AddUniqueCallIds addIds = null;
        static HashSet<string> IdentifiedEntryPoints = new HashSet<string>();
        static System.IO.TextWriter ResultsFile = null;
        public static ExplainError.ControlFlowDependency controlFlowDependencyInformation = null;

        static bool useProvidedEntryPoints = false; //making default true
        static string boogieOpts = "";
        static string corralOpts = "";
        static bool disableRoundRobinPrePass = false; //always do round robin with a timeout
        static bool disableAssertRoundRobinPrePass = false;
        static int timeout = 0;
        static int timeoutRoundRobin = 0;
        static int timeoutAssertRoundRobin = 0;
        static int timeoutRelax = 100;
        public static bool allocateParameters = true; //allocating parameters for procedures
        static bool trackAllVars = false; //track all variables
        static bool prePassOnly = false; //only running prepass (for debugging purpose)
        static bool dumpTimedoutCorralQueries = false;
        static bool deadCodeDetect = false; // do dead code detection        

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

            if (args.Any(s => s == "/noAA"))
                Options.UseAliasAnalysis = false;

            if (args.Any(s => s == "/CSFSAA"))
                Options.UseCSFSAliasAnalysis = true;

            if (args.Any(s => s == "/noReuse"))
                Options.UsePrevCorralState = false;

            if (args.Any(s => s == "/houdini"))
                Options.HoudiniPass = true;

            if (args.Any(s => s == "/trackAllVars"))
                trackAllVars = true;

            if (args.Any(s => s == "/useEntryPoints"))
                useProvidedEntryPoints = true;

            if (args.Any(s => s == "/deepAsserts"))
                Options.DeepAsserts = true;

            if (args.Any(s => s == "/disableRoundRobinPrePass"))
                disableRoundRobinPrePass = true;

            if (args.Any(s => s == "/prePassOnly"))
                prePassOnly = true;

            if (args.Any(s => s == "/noEbasic"))
                Options.useEbasic = false;

            if (args.Any(s => s == "/deadCodeDetection"))
                deadCodeDetect = true;

            if (args.Any(s => s == "/bufferDetection"))
                Options.bufferDetect = true;

            if (args.Any(s => s == "/dumpTimedoutCorralQueries"))
                dumpTimedoutCorralQueries = true;

            if (args.Any(s => s == "/noFieldNonNull"))
                Options.FieldNonNull = false;

            if (args.Any(s => s == "/relax"))
                Options.RelaxEnvironment = true;

            if (args.Any(s => s == "/useHarness"))
                Options.useHarnessTag = true;

            if (args.Any(s => s == "/noEE"))
                Options.useEE = false;

            args.Where(s => s.StartsWith("/timeout:"))
                .Iter(s => timeout = int.Parse(s.Substring("/timeout:".Length)));

            args.Where(s => s.StartsWith("/timeoutRoundRobin:"))
                .Iter(s => timeoutRoundRobin = int.Parse(s.Substring("/timeoutRoundRobin:".Length)));

            args.Where(s => s.StartsWith("/timeoutAssertRoundRobin:"))
                .Iter(s => timeoutAssertRoundRobin = int.Parse(s.Substring("/timeoutAssertRoundRobin:".Length)));

            args.Where(s => s.StartsWith("/timeoutEE:"))
                .Iter(s => Options.eeTimeout = int.Parse(s.Substring("/timeoutEE:".Length)));


            if (timeoutAssertRoundRobin == 0)
                disableAssertRoundRobinPrePass = true;

            if (timeoutRoundRobin == 0)
                disableRoundRobinPrePass = true;

            if (args.Any(s => s == "/UseUnsoundMapSelectNonNull"))
                Options.AddMapSelectNonNullAssumptions = true;

            if (args.Any(s => s == "/EEDisableControlSlicing"))
                Options.EEPerformControlSlicing = false;

            if (args.Any(s => s == "/traceSlicing"))
                Options.TraceSlicing = true;

            args.Where(s => s.StartsWith("/property:"))
                .Iter(s => Options.propertyChecked = s.Substring("/property:".Length));

            args.Where(s => s.StartsWith("/EE:"))
                .Iter(s => Options.EEflags.Add("/" + s.Substring("/EE:".Length)));

            string resultsfilename = null;
            args.Where(s => s.StartsWith("/dumpResults:"))
                .Iter(s => resultsfilename = s.Substring("/dumpResults:".Length));
            if (resultsfilename != null)
            {
                ResultsFile = new System.IO.StreamWriter(resultsfilename);
                ResultsFile.WriteLine("Description,Src File,Line,Procedure,EntryPoint"); // result file header
                ResultsFile.Flush();
            }

            
            // Initialize Boogie and Corral
            corralConfig = InitializeCorral();

            // Relax Environment Constraints
            if (Options.RelaxEnvironment)
            {
                var program = BoogieUtil.ReadAndOnlyResolve(args[0]);

                List<string> entrypoints = cba.EntrypointScanner.FindEntrypoint(program);
                if (entrypoints.Count == 0)
                    throw new InvalidInput("Main procedure not specified");

                // deprecated
                var outp = RelaxConstraints(program, entrypoints[0], null);

                Console.Write("Output: ");
                outp.Iter(n => Console.Write("{0} ", n));
                Console.WriteLine();
                return;
            }

            PersistentProgram prog = null;
            try
            {
                Stats.resume("Cpu");

                // Get input program with the harness
                Utils.Print(String.Format("----- Analyzing {0} ------", args[0]), Utils.PRINT_TAG.AV_OUTPUT);
                prog = GetProgram(args[0]);

                Stats.numAssertsBeforeAliasAnalysis = CountAsserts(prog);

                // Run alias analysis
                Stats.resume("alias.analysis");
                Console.WriteLine("Running alias analysis");
                prog = RunAliasAnalysis(prog);
                Stats.stop("alias.analysis");

                prog.writeToFile("alias.bpl");

                // Do dead code detection -- deprecated!
                if (false && deadCodeDetect)
                {
                    Stats.resume("dead.code");
                    Console.WriteLine("Running dead code detection");
                    prog = DeadCodeDetection.Detect(prog, corralConfig);
                    Stats.stop("dead.code");
                }

                Stats.numAssertsAfterAliasAnalysis= CountAsserts(prog);

                if (Options.AddMapSelectNonNullAssumptions)
                {
                    int mapNonNullTotalAsserts, mapNonNullAssertsRemaining;
                    mapNonNullAssertsRemaining = CountAssertsWithAttribute(prog, Instrumentations.AssertMapSelectsNonNull.attrName, out mapNonNullTotalAsserts);
                    Utils.Print(string.Format("#MapReadsPossiblyNullAfterAA = {0}/{1}", mapNonNullAssertsRemaining, mapNonNullTotalAsserts));
                }

                Utils.Print(string.Format("#Procs : {0}",Stats.numProcs),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#EntryPoints : {0}",IdentifiedEntryPoints.Count),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#AssertsBeforeAA : {0}",Stats.numAssertsBeforeAliasAnalysis),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#AssertsAfterAA : {0}",Stats.numAssertsAfterAliasAnalysis),Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("InstrumentTime(ms) : {0}",sw.ElapsedMilliseconds),Utils.PRINT_TAG.AV_STATS);

                HashSet<KeyValuePair<string, string>> inferred_asserts = new HashSet<KeyValuePair<string, string>>();
                // run Houdini pass
                if (Options.HoudiniPass)
                    prog = RunHoudiniPass(prog, out inferred_asserts);

                prog = removeAsserts(inferred_asserts, prog);

                // hook to run the control flow slicing static analysis pre pass
                if (Options.EEPerformControlSlicing)
                {
                    var p1 = prog.getProgram();
                    controlFlowDependencyInformation = new ExplainError.ControlFlowDependency(p1);
                    controlFlowDependencyInformation.Run();

                    // package up the program
                    prog = new PersistentProgram(p1, prog.mainProcName, prog.contextBound);
                    //prog.writeToFile("inst.bpl");
                }

                PrintAssertStats(prog);

                if (prePassOnly) return;
                //Analyze
                RunCorralForAnalysis(prog);

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
                Stats.printStats();
                Utils.Print(string.Format("TotalTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);
                if (ResultsFile != null) ResultsFile.Close();
            }
        }

        private static void PrintAssertStats(PersistentProgram prog)
        {
            Stats.numAssertsAfterHoudiniPass = CountAsserts(prog);
            Utils.Print(string.Format("#AssertsAftHoudini : {0}", Stats.numAssertsAfterHoudiniPass),
                Utils.PRINT_TAG.AV_STATS);

            // count number of assertions per procedure after alias analysis and houdini pass
            foreach (Implementation impl in prog.getProgram().TopLevelDeclarations
                .Where(x => x is Implementation))
            {
                var assertVisitor = new Instrumentations.AssertCountVisitor();
                assertVisitor.Visit(impl);
                Stats.numAssertsPerProc[impl.Name] = assertVisitor.assertCount;
            }
            Debug.Assert(Stats.numAssertsPerProc.Values.Sum() == Stats.numAssertsAfterHoudiniPass);
            Utils.Print(string.Format("#ImplWithAsserts : {0}",
                Stats.numAssertsPerProc.Values.Where(c => c != 0).Count()),
                Utils.PRINT_TAG.AV_STATS);
        }

        // Removes asserts inferred by Houdini pass from the program
        private static PersistentProgram removeAsserts(HashSet<KeyValuePair<string, string>> inferred_asserts, PersistentProgram inp)
        {
            int count = 0;
            string notfalse = null;
            var prog = inp.getProgram();
            foreach (Implementation impl in prog.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (Block b in impl.Blocks)
                {
                    var removal_list = new HashSet<AssertCmd>();
                    foreach (AssertCmd ac in b.Cmds.OfType<AssertCmd>())
                    {
                        if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == notfalse)
                            continue;
                        else
                        {
                            if (inferred_asserts.Contains(new KeyValuePair<string, string>(ac.Expr.ToString(), b.Label)))
                            {
                                removal_list.Add(ac);
                            }
                            count++;
                        }
                    }
                    foreach (AssertCmd ac in removal_list) b.Cmds.Remove(ac);
                }
            }
            return new PersistentProgram(prog, inp.mainProcName, inp.contextBound);
        }

        private static PersistentProgram RunHoudiniPass(PersistentProgram prog, out HashSet<KeyValuePair<string, string>> inferred_asserts)
        {
            Stats.resume("houdini");
            Utils.Print("Start Houdini Pass ...");

            HashSet<Variable> templateVars = new HashSet<Variable>();
            List<Requires> reqs = new List<Requires>();
            List<Ensures> enss = new List<Ensures>();
            SimpleHoudini houdini = new SimpleHoudini(templateVars, reqs, enss, -1, -1);
            houdini.ExtractLoops = true;
            SimpleHoudini.fastRequiresInference = false;
            SimpleHoudini.checkAsserts = true;
            houdini.printHoudiniQuery = "candidates.bpl";
            // turnning on several switches: InImpOutNonNull + InNonNull infer most assertions
            houdini.InImpOutNonNull = false;
            houdini.InImpOutNull = false;
            houdini.InNonNull = false;
            houdini.OutNonNull = false;
            houdini.addContracts = true;
            
            PersistentProgram newP = houdini.run(prog);
            BoogieUtil.PrintProgram(newP.getProgram(), "afterHoudini.bpl");
            Utils.Print("End Houdini Pass ...");
            Stats.stop("houdini");
            inferred_asserts = houdini.inferred_asserts;

            return newP;
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
            //Instrumentations.RemoveAssertNonNull ra = new Instrumentations.RemoveAssertNonNull();
            //BoogieUtil.PrintProgram(ra.VisitProgram(init), "noassert.bpl");
            //Sanity check (currently most of it happens inside HarnessInstrumentation)
            CheckInputProgramRequirements(init);

            // Do some instrumentation for the input program
            if (Options.propertyChecked == "typestate")
            {
                // Mark all assumes as "slic" except non-null ones
                var AddAnnotation = new Action<AssumeCmd>(ac =>
                    {
                        if (QKeyValue.FindBoolAttribute(ac.Attributes, "nonnull"))
                            return;
                        ac.Attributes = new QKeyValue(Token.NoToken, "slic", new List<object>(), ac.Attributes);
                    });
                init.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks
                        .Iter(blk => blk.Cmds.OfType<AssumeCmd>()
                            .Iter(AddAnnotation)));
            }
            else if (Options.propertyChecked == "nonnull")
            {
                // Don't mark anything as slic -- noAssumes for EE!
            }
            else
            {
                // Mark all assumes as "slic"
                var AddAnnotation = new Action<AssumeCmd>(ac =>
                {
                    ac.Attributes = new QKeyValue(Token.NoToken, "slic", new List<object>(), ac.Attributes);
                });
                init.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks
                        .Iter(blk => blk.Cmds.OfType<AssumeCmd>()
                            .Iter(AddAnnotation)));
            }

            if (!Options.useEbasic)
            {
                // strip out {:Ebasic}
                init.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks
                        .Iter(blk =>
                            blk.Cmds.RemoveAll(c => (c is AssumeCmd && 
                                QKeyValue.FindBoolAttribute((c as AssumeCmd).Attributes, AvnAnnotations.EnvironmentAssumptionAttr)))));
            }


            // Inline procedures supplied with {:inline} annotation
            cba.Driver.InlineProcedures(init);
            // Remove {:inline} impls
            init.RemoveTopLevelDeclarations(decl => (decl is Implementation) &&
                (BoogieUtil.checkAttrExists("inline", decl.Attributes) ||
                 BoogieUtil.checkAttrExists("inline", (decl as Implementation).Proc.Attributes)));

            // Add {:entrypoint} to procs with {:harness}
            if (Options.useHarnessTag)
            {
                foreach (var decl in init.TopLevelDeclarations.OfType<NamedDeclaration>()
                    .Where(d => QKeyValue.FindBoolAttribute(d.Attributes, "harness")))
                    decl.AddAttribute("entrypoint");
            }

            // inlining introduces havoc statements; lets just delete them (TODO: make inlining not introduce redundant havoc statements)
            foreach (var impl in init.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.Blocks.Iter(blk =>
                    blk.Cmds.RemoveAll(cmd => cmd is HavocCmd));
            }

            //Instrument to create the harness
            corralConfig.mainProcName = AvnAnnotations.CORRAL_MAIN_PROC;
            harnessInstrumentation = new Instrumentations.HarnessInstrumentation(init, corralConfig.mainProcName, useProvidedEntryPoints);
            harnessInstrumentation.DoInstrument();
            IdentifiedEntryPoints = harnessInstrumentation.entrypoints;

            //resolve+typecheck wo bothering about modSets
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            init = BoogieUtil.ReResolve(init);
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            // Update mod sets
            BoogieUtil.DoModSetAnalysis(init);

            // tag calls to the allocator with a unique ID
            var id = 0;
            init.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Where(cc => BoogieUtil.checkAttrExists("allocator", cc.Proc.Attributes))
                        .Iter(cc => cc.Attributes = new QKeyValue(Token.NoToken, "allocator_call",
                            new List<object> { Expr.Literal(id++) }, cc.Attributes)
                            )));

            //Various instrumentations on the well-formed program
            mallocInstrumentation = new Instrumentations.MallocInstrumentation(init);
            mallocInstrumentation.DoInstrument();
            //(new Instrumentations.AssertGuardInstrumentation(init)).DoInstrument(); //we don't guard asserts as we turn off the assert explicitly

            if (Options.AddMapSelectNonNullAssumptions)
                (new Instrumentations.AssertMapSelectsNonNull()).Visit(init);

            if (deadCodeDetect || Options.propertyChecked == "nonnull")
            {
                // Tag branches as reachable
                init = InstrumentBranches.Run(init, corralConfig.mainProcName, Options.UseAliasAnalysis, false);
            }
        
            //Print the instrumented program
            BoogieUtil.PrintProgram(init, "corralMain.bpl");
            //Console.WriteLine("corralMain written");

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
        private static int CountAssertsWithAttribute(PersistentProgram prog, string attributeName, out int totalCount)
        {
            var assertVisitor = new Instrumentations.AssertWithAttributeCountVisitor(attributeName);
            assertVisitor.Visit(prog.getProgram());
            totalCount = assertVisitor.assertCountAll;
            return assertVisitor.assertsNotRemovedCount;
        }

        #endregion

        #region Corral related
        // Set timeout for Corral
        static void SetCorralTimeout(int corralTimeout)
        {
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
        }

        class ErrorTraceInfo
        {
            public string TraceName; 
            public cba.ErrorTrace Trace;
            public Program TraceProgram;
            public Tuple<string, int> AssertLoc;
            public string FailingEntryPoint;

            public ErrorTraceInfo(string TraceName, cba.ErrorTrace Trace, Program TraceProgram, Tuple<string, int> AssertLoc, string FailingEntryPoint)
            {
                this.TraceName = TraceName;
                this.Trace = Trace;
                this.AssertLoc = AssertLoc;
                this.TraceProgram = TraceProgram;
                this.FailingEntryPoint = FailingEntryPoint;
            }
        }

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

                //prog.writeToFile("c" + iterCount + ".bpl");

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

                // Identify the entrypoint that led to the assertion violation.
                var failingEntryPoint =
                    instr.GetEntryPoint(cex, IdentifiedEntryPoints);

                //get the pathProgram
                CoreLib.SDVConcretizePathPass concretize;
                var pprog = GetPathProgram(cex, prog, out concretize);                

                var ppprog = pprog.getProgram();
                var mainImpl = BoogieUtil.findProcedureImpl(ppprog.TopLevelDeclarations, pprog.mainProcName);          
      
                //call ExplainError 
                BoogieUtil.PrintProgram(ppprog, "ee.bpl");

                Stats.resume("explain.error");
                List<Tuple<string, int, string>> distinctSourceLines = null;
                var eeStatus = CheckWithExplainError(ppprog, mainImpl,concretize, failingEntryPoint, Options.EEflags, out distinctSourceLines);
                if (!Options.TraceSlicing) distinctSourceLines = null;
                Stats.stop("explain.error");

                // print the trace to disk
                var traceName = "Trace" + traceCount;
                Console.WriteLine("Printing trace {0}", traceName);
                var assertLoc = instr.PrintErrorTrace(cex, traceName, distinctSourceLines);
                var stubs = instr.GetStubs(cex);
                Console.WriteLine("Stubs used along the trace: {0}", stubs.Print());
                traceCount++;

                var traceInfo = new ErrorTraceInfo(traceName, cex, pprog.getProgram(), assertLoc, failingEntryPoint);

                if (eeStatus.Item1 == REFINE_ACTIONS.SUPPRESS) {
                    SuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo });
                }
                else if (eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
                {
                    PrintAndSuppressAssert(instr, new List<ErrorTraceInfo> { traceInfo });
                }
                else if (eeStatus.Item1 == REFINE_ACTIONS.BLOCK_PATH)
                {
                    var constraintId = instr.SuppressInput(eeStatus.Item2, failingEntryPoint);
                    pendingTraces.Add(constraintId, traceInfo);
                    Stats.count("blocked.count");

                    // Check inconsistency
                    var inconsistent = CheckInconsistency(instr, failingEntryPoint);                    

                    if (inconsistent.Count != 0)
                    {
                        Debug.Assert(inconsistent.Contains(constraintId));
                        Console.WriteLine("Hard constraint inconsistency detected: ", inconsistent.Print());
                        // drop asserts
                        PrintAndSuppressAssert(instr, pendingTraces.Where(tup => inconsistent.Contains(tup.Key)).Select(tup => tup.Value));
                        // drop constraints
                        inconsistent.Iter(id => instr.RemoveInputSuppression(id, failingEntryPoint));
                        // drop traces
                        inconsistent.Iter(id => pendingTraces.Remove(id));
                    }
                    else
                    {                        
                        // Relax env constraints
                        RelaxEnvironmentConstraints(instr, failingEntryPoint);
                    }

                }

                iterCount++;
            }
            Stats.stop("run.corral.iterative");
            return ret;
        }

        // Relax environment constraints Ebasic
        private static void RelaxEnvironmentConstraints(AvnInstrumentation instr, string entrypoint, bool onlydeadcode = false)
        {
            if (!Options.useEbasic)
                return;

            Console.WriteLine("Relaxing environment constraints");

            // only consider the given entrypoint
            var blocked = false;
            if (!instr.InBlockingMode() && entrypoint != null)
            {
                blocked = true;
                instr.BlockAllButThis(entrypoint);
            }

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

            var reach = Instrumentations.HarnessInstrumentation.FindReachableStatesFunc(program);

            // change assume Reachable(e) to assert !e
            var assertcnt = 0;
            var mutate = new Func<Cmd, Cmd>(cmd =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return cmd;
                var nary = acmd.Expr as NAryExpr;
                if (nary == null) return cmd;
                if (onlydeadcode && !QKeyValue.FindBoolAttribute(acmd.Attributes, "deadcode")) return cmd;
                if (nary.Fun is FunctionCall && (nary.Fun as FunctionCall).FunctionName == reach.Name)
                {
                    assertcnt++;
                    return new AssertCmd(Token.NoToken, Expr.Not(nary.Args[0]));
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
                // remove side-effects
                if (blocked)
                {
                    instr.RemoveBlockingConstraint();
                }
                return;
            }

            // Now, move assertions to the end of main
            var main = program.TopLevelDeclarations.OfType<Implementation>().Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();
            var sI = new cba.SequentialInstrumentation();
            var cprogram = sI.runCBAPass(new cba.CBAProgram(program, main.Name, 1));

            // shallow checking only
            var sd = CommandLineOptions.Clo.StackDepthBound;
            CommandLineOptions.Clo.StackDepthBound = 4;
            //BoogieUtil.PrintProgram(program, "env.bpl");

            var ret = RelaxConstraints(cprogram, cprogram.mainProcName, sI.assertsPassedName);

            CommandLineOptions.Clo.StackDepthBound = sd;

            if(ret != null)
                ret.Iter(n => instr.SuppressEnvironmentConstraint(soft2actual[n]));

            // remove side-effects
            if (blocked)
            {
                instr.RemoveBlockingConstraint();
            }
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

        private static void PrintAndSuppressAssert(AvnInstrumentation instr, IEnumerable<ErrorTraceInfo> traceInfos)
        {
            Stats.count("bug.count");

            var traces = "";
            traceInfos.Iter(info => traces += info.TraceName + " ");
            traces = "{" + traces + "}";
            Utils.Print(String.Format("ANGELIC_VERIFIER_WARNING: Failing traces {0}", traces), Utils.PRINT_TAG.AV_OUTPUT);

            if (Driver.printTraceMode == PRINT_TRACE_MODE.Sdv)
            {
                if (traceInfos.Count() == 1)
                    System.IO.File.Copy(traceInfos.First().TraceName + ".tt", "Angelic" + AngelicCount + ".tt", true);
                else
                {
                    int c = 0;
                    foreach(var t in traceInfos)
                        System.IO.File.Copy(traceInfos.First().TraceName + ".tt", "Angelic" + AngelicCount + "." + (c++) + ".tt", true);
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
                    output = string.Format("Assertion failed in proc {0} in file {1} line {2} with expr {3} and entrypoint {4}",
                        failingProc, traceInfo.AssertLoc.Item1, traceInfo.AssertLoc.Item2, failingAssert.Expr.ToString(), traceInfo.FailingEntryPoint);

                    // result file output
                    // format: Description, Src File, Line, Procedure, EntryPoint
                    if (ResultsFile != null)
                    {
                        ResultsFile.WriteLine("Assertion {0} failed,{1},{2},{3},{4}",
                            failingAssert.Expr.ToString(), traceInfo.AssertLoc.Item1, traceInfo.AssertLoc.Item2, failingProc, traceInfo.FailingEntryPoint);
                        ResultsFile.Flush();
                    }
                }
                else
                {
                    output = string.Format("Assertion failed in proc {0} with expr {1} and entrypoint {2}",
                        failingProc, failingAssert.Expr.ToString(), traceInfo.FailingEntryPoint);
                }

                Console.WriteLine("{0}", output);
                Utils.Print(string.Format("ANGELIC_VERIFIER_WARNING: {0}", output), Utils.PRINT_TAG.AV_OUTPUT);
            }

            //if (eeStatus.Item1 == REFINE_ACTIONS.SHOW_AND_SUPPRESS)
            //    Utils.Print(String.Format("ANGELIC_VERIFIER_WARNING: {0}", output), Utils.PRINT_TAG.AV_OUTPUT);
        }

        private static HashSet<int> CheckInconsistency(AvnInstrumentation instr, string entrypoint)
        {
            Console.WriteLine("Checking inconsistency");

            // only consider the given entrypoint
            var blocked = false;
            if (!instr.InBlockingMode())
            {
                blocked = true;
                instr.BlockAllButThis(entrypoint);
            }

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

            var reach = Instrumentations.HarnessInstrumentation.FindReachableStatesFunc(program);

            // change assume Reachable(e) to assert !e
            var assertcnt = 0;
            var mutate = new Func<Cmd, Cmd>(cmd =>
                {
                    var acmd = cmd as AssumeCmd;
                    if (acmd == null) return cmd;
                    var nary = acmd.Expr as NAryExpr;
                    if (nary == null) return cmd;
                    if (nary.Fun is FunctionCall && (nary.Fun as FunctionCall).FunctionName == reach.Name)
                    {
                        assertcnt++;
                        return new AssertCmd(Token.NoToken, Expr.Not(nary.Args[0]));
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
            var AddAttr = new Action<Cmd>(cmd =>
                {
                    var acmd = cmd as AssumeCmd;
                    if(acmd == null) return;
                    var id = QKeyValue.FindIntAttribute(acmd.Attributes, AvnAnnotations.BlockingConstraintAttr, -1);
                    if (id == -1) return;
                    acmd.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.RelaxConstraintAttr, new List<object> { Expr.Literal(softcnt) }, acmd.Attributes);
                    soft2actual.Add(softcnt, id);
                    softcnt++;
                });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    block.Cmds.Iter(AddAttr);
                }
            }

            // Now, move assertions to the end of main
            var main = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            var sI = new cba.SequentialInstrumentation();
            var cprogram = sI.runCBAPass(new cba.CBAProgram(program, main.Name, 1));
            cprogram = (new cba.CompileRequiresAndEnsures()).runCBAPass(cprogram);

            //BoogieUtil.PrintProgram(cprogram, "relax.bpl");
            Console.WriteLine("CheckInconsistency: {0} soft constraints and {1} assertions", softcnt, assertcnt);

            var sd = CommandLineOptions.Clo.StackDepthBound;
            CommandLineOptions.Clo.StackDepthBound = 4;

            // Relax
            var softret = RelaxConstraints(cprogram, cprogram.mainProcName, sI.assertsPassedName);

            CommandLineOptions.Clo.StackDepthBound = sd;

            // remove side-effects
            if (blocked)
            {
                instr.RemoveBlockingConstraint();
            }

            var ret = new HashSet<int>();
            
            if(softret != null)
                softret.Iter(n => ret.Add(soft2actual[n]));

            return ret;
        }

        //Run RunCorralIterative with only one procedure enabled
        private static void RunCorralAssertRoundRobin(AvnInstrumentation instr, string p)
        {
            Utils.Print("Using assert round robin exploration...", Utils.PRINT_TAG.AV_DEBUG);

            foreach (var proc in instr.GetProcsWithAsserts())
            {
                Utils.Print(string.Format("Analyzing assertions in procedure {0} in round robin mode", proc),
                     Utils.PRINT_TAG.AV_DEBUG);
                Utils.Print(string.Format("number.assertions: {0}", Stats.numAssertsPerProc[proc]),
                    Utils.PRINT_TAG.AV_DEBUG);

                //enable only the procedure corresponding to proc
                var left = instr.SuppressAllButOneProcedure(proc);

                //we give less timeout for the individual procedure
                var startTime = DateTime.Now; // Start time of round robin mode
                var completed = RunCorralIterative(instr, timeoutAssertRoundRobin);
                var endTime = DateTime.Now; // End time of round robin mode

                Utils.Print(string.Format("Time taken: {0} s", (endTime - startTime).TotalSeconds),
                    Utils.PRINT_TAG.AV_DEBUG);

                instr.Unsuppress();

                // Did we prove the assertions?
                if (completed)
                {
                    Utils.Print(string.Format("Suppressing {0} assertions", left.Count),
                        Utils.PRINT_TAG.AV_DEBUG);
                    left.Iter(t => instr.SuppressToken(t));
                }

                Stats.printStats();
            }
        }

        //Run RunCorralIterative with only one procedure enabled
        private static void RunCorralRoundRobin(AvnInstrumentation instr, string p)
        {
            var pprog = instr.GetCurrProgram();

            Utils.Print("Using round robin exploration...", Utils.PRINT_TAG.AV_DEBUG);
            var prog = pprog.getProgram();

            var blockCallConsts = instr.GetRoundRobinBlockingConstants();
            //TODO: iterate for multiple rounds removing procedures once they are verified
            foreach (var bc in blockCallConsts)
            {
                Utils.Print(string.Format("Analyzing procedure {0} in round robin mode", harnessInstrumentation.blockEntryPointConstants[bc.Name]),
                     Utils.PRINT_TAG.AV_DEBUG);
                Utils.Print(string.Format("number.assertions: {0}", Stats.numAssertsPerProc[harnessInstrumentation.blockEntryPointConstants[bc.Name]]),
                    Utils.PRINT_TAG.AV_DEBUG);

                //enable only the procedure corresponding to kv
                instr.BlockAllButThis(bc);

                //we give less timeout for the individual procedure
                var startTime = DateTime.Now; // Start time of round robin mode
                RunCorralIterative(instr, timeoutRoundRobin);
                var endTime = DateTime.Now; // End time of round robin mode

                Utils.Print(string.Format("Time taken: {0} s", (endTime - startTime).TotalSeconds),
                    Utils.PRINT_TAG.AV_DEBUG);
                                
                instr.RemoveBlockingConstraint();

                Stats.printStats();
            }
        }
        //Top-level Corral call
        private static void RunCorralForAnalysis(PersistentProgram prog)
        {
            ////////////////
            // Initial stuff
            ////////////////

            ProgTransformation.PersistentProgramIO.useDuplicator = true;

            // Rewrite program to a more convinient form
            var rc = new cba.RewriteCallCmdsPass(true);
            prog = rc.run(prog);

            var instr = new AvnInstrumentation(harnessInstrumentation);
            prog = instr.run(prog);

            // dead code
            RelaxEnvironmentConstraints(instr, null, true);

            Stats.resume("round.robin");
            //Run Corral in a round robin manner to remove simple procedures/find shallow bugs
            if (!disableRoundRobinPrePass)
                RunCorralRoundRobin(instr, corralConfig.mainProcName);
            Stats.stop("round.robin");

            Stats.resume("assert.round.robin");
            //Run Corral in a round robin manner to remove simple procedures/find shallow bugs
            if (!disableAssertRoundRobinPrePass)
                RunCorralAssertRoundRobin(instr, corralConfig.mainProcName);
            Stats.stop("assert.round.robin");


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
            try
            {
                Stats.count("count.check.refine");
                Stats.resume("check.and.refine");
                cba.Driver.checkAndRefine(inputProg, refinementState, null, out cexTrace);
                Stats.stop("check.and.refine");
            }
            catch (Exception)
            {
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
            CoreLib.SdvUtils.sdvAnnotateDefectTrace(tprog, corralConfig.trackedVars);

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

            // Add Boolean Vars for environment constraints
            var boolVarMap = AddBooleanVariables(program);

            var prevTracked = corralState;
            var iter = 0;
            while (true)
            {
                iter++;
                cba.ErrorTrace cex = null;
                var pprog = new PersistentProgram(program, main, 1); pprog.writeToFile("rl.bpl");
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

            var GetConstraintNum = new Func<AssumeCmd, int>(ac => QKeyValue.FindIntAttribute(ac.Attributes, AvnAnnotations.RelaxConstraintAttr, -1));
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
                        var n = GetConstraintNum(acmd);
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
            ac.Rhss[0] = Expr.True;
            //block.Cmds[currLoc.instrNo] = new AssumeCmd(ac.tok, ac.Expr, ac.Attributes);
        }
        #endregion

        #region ExplainError related
        private enum REFINE_ACTIONS { SHOW_AND_SUPPRESS, SUPPRESS, BLOCK_PATH };
        private const int MAX_REPEATED_FIELDS_IN_BLOCKS = 4;
        private const int MAX_REPEATED_BLOCK_EXPR = 2; // maximum number of repeated block expr
        private static Dictionary<string, int> fieldInBlockCount = new Dictionary<string, int>();
        private static Dictionary<Tuple<string, string>, int> blockExprCount = new Dictionary<Tuple<string, string>, int>(); // count repeated block expr
        private static Tuple<REFINE_ACTIONS,Expr> CheckWithExplainError(Program nprog, Implementation mainImpl, 
            CoreLib.SDVConcretizePathPass concretize, string entrypoint_name, HashSet<string> extraEEflags, out List<Tuple<string, int, string>> distinctSourceLines)
        {
            //Let ee be the result of ExplainError
            // if (ee is SUCCESS && ee is True) ShowWarning; Suppress 
            // else if (ee is SUCCESS(e)) Block(e); 
            // else //inconclusive/timeout/.. Suppress

            distinctSourceLines = null;
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
            nprog.RemoveTopLevelDeclarations(decl => (decl is Axiom) && HasAllocConstant((decl as Axiom).Expr));

            // Add these flags by default
            var eeflags = new List<string>{"/onlySlicAssumes+", "/ignoreAllAssumes-"};
            eeflags.AddRange(extraEEflags);

            Dictionary<string, string> eeComplexExprs;
            // Save commandlineoptions
            var clo = CommandLineOptions.Clo;
            try
            {            
                HashSet<List<Expr>> preDisjuncts;
                
                var explain = ExplainError.Toplevel.Go(mainImpl, nprog, Options.eeTimeout, 1, eeflags.Concat(" "), 
                    controlFlowDependencyInformation,
                    out eeStatus, out eeComplexExprs, out preDisjuncts, out distinctSourceLines);
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

                        /*HACK: supress the assertion when it cannot be blocked*/
                        if (blockExprCount.ContainsKey(Tuple.Create(blockExpr.ToString(), entrypoint_name)))
                        {
                            if (blockExprCount[Tuple.Create(blockExpr.ToString(), entrypoint_name)]++ > MAX_REPEATED_BLOCK_EXPR)
                                throw new Exception("Repeating block expression detected. Not able to block!");
                        }
                        else
                            blockExprCount[Tuple.Create(blockExpr.ToString(), entrypoint_name)] = 1;
                        
                        Utils.Print(String.Format("EXPLAINERROR-BLOCK :: {0}", blockExpr), Utils.PRINT_TAG.AV_OUTPUT);
                        status = Tuple.Create(REFINE_ACTIONS.BLOCK_PATH, blockExpr); 
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

            //AliasAnalysis.AliasAnalysis.dbg = true;
            //AliasAnalysis.AliasConstraintSolver.dbg = true;
            AliasAnalysis.AliasAnalysisResults res = null;
            if (Options.UseAliasAnalysis)
            {
                // Do SSA
                program =
                    SSA.Compute(program, PhiFunctionEncoding.Verifiable, new HashSet<string> { "int" });

                // Make sure that aliasing queries are on identifiers only
                var af =
                    AliasAnalysis.SimplifyAliasingQueries.Simplify(program);

                res =
                  AliasAnalysis.AliasAnalysis.DoAliasAnalysis(program);   
            }
            else
            {
                // Make sure that aliasing queries are on identifiers only
                var af =
                    AliasAnalysis.SimplifyAliasingQueries.Simplify(program);

                res = new AliasAnalysis.AliasAnalysisResults();
                af.Iter(s => res.aliases.Add(s, true));
            }

            var origProgram = inp.getProgram();
            Dictionary<string, bool> csfs_ret = null;
            if (Options.UseCSFSAliasAnalysis)
            {
                csfs_ret = AliasAnalysis.AliasAnalysis.DoCSFSAliasAnalysis(program);
                AliasAnalysis.CSFSAliasAnalysis.removeAsserts(origProgram, csfs_ret);
            }

            AliasAnalysis.PruneAliasingQueries.Prune(origProgram, res);
            PruneRedundantEntryPoints(origProgram);

            return new PersistentProgram(origProgram, inp.mainProcName, inp.contextBound);
        }

        // Prune away EntryPoints that cannot reach an assertion
        static void PruneRedundantEntryPoints(Program program)
        {
            var procs = BoogieUtil.procsThatMaySatisfyPredicate(program, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));
            procs = IdentifiedEntryPoints.Difference(procs);
            Console.WriteLine("Pruning away {0} entry points as they cannot reach an assert", procs.Count);
            harnessInstrumentation.RemoveEntryPoints(program, procs);
            IdentifiedEntryPoints = harnessInstrumentation.entrypoints;
        }

        #endregion
    }
}
