using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using cba;
using Microsoft.Boogie.Houdini;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;

namespace cba
{
    public class Driver
    {

        static int Main(string[] args)
        {
            if (args.Any(f => f == "/catchAll"))
            {
                try
                {
                    return run(args);
                }
                catch (Exception e)
                {
                    if (GlobalConfig.catchAllExceptions)
                    {
                        Console.WriteLine();
                        Console.WriteLine("Stopping: {0}", e.Message);
                        return 1;
                    }
                    else
                    {
                        throw;
                    }
                }
            }
            else
            {
                try
                {
                    return run(args);
                    //return runCompress(args);
                } 
                catch (InvalidInput e)
                {
                    Console.WriteLine();
                    Console.WriteLine("Error, Invalid input: {0}", e.Message);
                    return 1;
                }
                catch (InternalError e)
                {
                    Console.WriteLine();
                    Console.WriteLine("Error, internal bug: {0}", e.Message);
                    return 1;
                }
                catch (UsageError e)
                {
                    Console.WriteLine();
                    Console.WriteLine("Usage error: {0}", e.Message);
                    Configs.usage();
                    return 1;
                }
                catch (NormalExit e)
                {
                    Console.WriteLine();
                    Console.WriteLine("Stopping: {0}", e.Message);
                    return 1;
                } 
                catch (OutOfMemoryException e)
                {
                    Console.WriteLine();
                    Console.WriteLine("Stopping: {0}", e.Message);
                    return 1;
                } 
            }

        }

        public static void Initialize(Configs config)
        {
            // Batch-mode GC is best for performance
            System.Runtime.GCSettings.LatencyMode = System.Runtime.GCLatencyMode.Batch;

            BoogieVerify.useDuality = config.useDuality;

            #region Set global flags
            ////////////////////////////////////////////////////
            // Set global configs

            GlobalConfig.useLocalVariableAbstraction = config.useLocalVariableAbstraction;
            GlobalConfig.genCTrace = config.genCTrace;
            GlobalConfig.useArrayTheory = config.arrayTheory;
            GlobalConfig.printInstrumented = config.printInstrumented;
            GlobalConfig.instrumentedFile = config.instrumentedFile;
            GlobalConfig.addRaiseException = !config.noRaiseException;
            GlobalConfig.memLimit = config.memLimit;
            GlobalConfig.recursionBound = config.recursionBound;
            GlobalConfig.refinementAlgo = config.refinementAlgo.ToArray();
            GlobalConfig.timeOut = config.timeout;
            GlobalConfig.annotations = config.annotations;
            GlobalConfig.catchAllExceptions = config.catchAllExceptions;
            GlobalConfig.printAllTraces = config.printAllTraces;
            GlobalConfig.explainQuantifiers = config.explainQuantifiers;
            ContractInfer.fastRequiresInference = config.fastRequiresInference;
            ContractInfer.useHoudiniLite = config.runHoudiniLite;
            ContractInfer.disableStaticAnalysis = config.disableStaticAnalysis;
            if (config.FwdBckSearch == 1) ContractInfer.inferPreconditions = true;
            if (config.printData == 0 && config.NonUniformUnfolding)
                config.printData = 1;

            GeneralRefinementScheme.printStats = config.printProgress;
            ContractInfer.runHoudini = !config.summaryComputation;
            BoogieVerify.irreducibleLoopUnroll = config.irreducibleLoopUnroll;
            GlobalConfig.addInvariants = 2; // AL

            GlobalConfig.cadeTiming = config.cadeTiming;
            GlobalConfig.staticInlining = config.staticInlining;

            BoogieVerify.assertsPassed = config.assertsPassed;
            BoogieVerify.assertsPassedIsInt = config.assertsPassedIsInt;
            BoogieVerify.ignoreAssertMethods = new HashSet<string>(config.ignoreAssertMethods);

            GeneralRefinementScheme.noInitialPruning = !config.useInitialPruning;

            InstrumentationConfig.cooperativeYield = config.cooperativeYield;

            ProgTransformation.TransformationPass.writeAllFiles = false;
            Log.noDebuggingOutput = true;

            config.specialVars.Iter(s => LanguageSemantics.specialVars.Add(s));
            #endregion

            ConfigManager.Initialize(config);

            string boogieOptions = "";
            boogieOptions += config.boogieOpts;

            boogieOptions += "/extractLoops /errorLimit:1 ";

            boogieOptions += string.Format("/recursionBound:{0} ", config.recursionBound);

            // Initialize Boogie
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Assume;
            CommandLineOptions.Clo.StratifiedInliningVerbose = config.verboseMode;

            // /noRemoveEmptyBlocks is needed for field refinement. It ensures that
            // we get an actual path in the program (so that we can concretize it)
            // noinfer: The inference algorithm of Boogie is slow and should be avoided.
            boogieOptions +=
                "/removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer " +
                //"/z3opt:RELEVANCY=0  " +                
                "/typeEncoding:m " +
                "/vc:i " +
                "/subsumption:0 ";

            InstrumentationConfig.UseOldInstrumentation = false;
            VariableSlicing.UseSimpleSlicing = false;
            InstrumentationConfig.raiseExceptionBeforeAllProcedures = false;

            if (GlobalConfig.useArrayTheory == ArrayTheoryOptions.STRONG)
                boogieOptions += " /useArrayTheory";
            else if (GlobalConfig.useArrayTheory == ArrayTheoryOptions.WEAK)
                boogieOptions += " /useArrayTheory /weakArrayTheory ";

            if (config.printBoogieFlags)
                Console.WriteLine("Using Boogie flags: {0}", boogieOptions);

            if (BoogieUtil.InitializeBoogie(boogieOptions))
                throw new InternalError("Cannot initialize Boogie");

            if (CommandLineOptions.Clo.UseProverEvaluate)
                CommandLineOptions.Clo.StratifiedInliningWithoutModels = true;

            GlobalConfig.corralStartTime = DateTime.Now;
        }

        public static int run(string[] args) 
        {
            ////////////////////////////////////
            // Input and initialization phase
            ////////////////////////////////////

            Configs config = Configs.parseCommandLine(args);
            CommandLineOptions.Install(new CommandLineOptions());

            if (!System.IO.File.Exists(config.inputFile))
            {
                throw new UsageError(string.Format("Input file {0} does not exist", config.inputFile));
            }

            Initialize(config);

            var startTime = DateTime.Now;

            ////////////////////////////////////
            // Initial program rewriting
            ////////////////////////////////////

            #region initial program rewriting

            var inputProg = GetInputProgram(config);
            if (inputProg == null) return 0;

            CorralState.AbsorbPrevState(config, ConfigManager.progVerifyOptions);

            /////
            // Transformations that don't require a mapBack
            /////

            // infer loop bound (assuming program is sequential)
            if (config.maxStaticLoopBound > 0)
            {
                // abstract away globals
                var abs = new VariableSlicePass(new VarSet());
                var lprog = abs.run(inputProg);

                // extract loops
                var el = new ExtractLoopsPass(true);
                lprog = el.run(lprog);

                var LBoptions = ConfigManager.progVerifyOptions.Copy();
                LBoptions.useDI = false;
                LBoptions.useFwdBck = false;
                LBoptions.NonUniformUnfolding = false;
                LBoptions.extraFlags = new HashSet<string>();
                LBoptions.newStratifiedInliningAlgo = "";
                ConfigManager.progVerifyOptions.extraRecBound = new Dictionary<string, int>();

                try
                {
                    var bounds = LoopBound.Compute(lprog.getCBAProgram(), config.maxStaticLoopBound, GlobalConfig.annotations, LBoptions);
                    bounds.Iter(kvp => ConfigManager.progVerifyOptions.extraRecBound.Add(kvp.Key, kvp.Value));
                }
                catch (CoreLib.InsufficientDetailsToConstructCexPath e)
                {
                    Console.WriteLine("Exception: {0}", e.Message);
                    Console.WriteLine("Skipping LB inferrence");
                }

                Console.WriteLine("LB: Took {0} s", LoopBound.timeTaken.TotalSeconds.ToString("F2"));
            }

            if (config.daInst != null)
            {
                var el = new ExtractLoopsPass();
                var ttt = el.run(inputProg);
                var da = new ConcurrentDeepAssertRewrite();                
                ttt = da.run(ttt);
                ttt.writeToFile(config.daInst);

                inputProg = ttt;
                config.mainProcName = da.newMainName;
                config.inputFile = config.daInst;
                config.trackedVars.UnionWith(da.newVars);
            }

            //////
            // Other transformations
            //////

            // Rewrite assert commands
            RewriteAssertsPass apass = new RewriteAssertsPass();
            var curr = apass.run(inputProg);

            // Rewrite call commands 
            RewriteCallCmdsPass rcalls = new RewriteCallCmdsPass(true);
            curr = rcalls.run(curr);

            // Prune
            PruneProgramPass.RemoveUnreachable = true;
            var prune = new PruneProgramPass(false);
            curr = prune.run(curr);
            PruneProgramPass.RemoveUnreachable = false;

            // Sequential instrumentation
            ExtractLoopsPass elPass = null;
            var seqInstr = new SequentialInstrumentation();
            if (GlobalConfig.isSingleThreaded)
            {
                curr = seqInstr.run(curr);
                // Flag settings for sequential programs
                config.trackedVars.Add(seqInstr.assertsPassedName);
                if (config.assertsPassed != "assertsPassed")
                    config.trackedVars.Add(config.assertsPassed);
                VerificationPass.usePruning = false;

                if (!config.useProverEvaluate)
                {
                    ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
                    if (config.NonUniformUnfolding && !config.useProverEvaluate)
                        ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = false;
                    if (config.printData == 0)
                        ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
                }

                // extract loops
                if (GlobalConfig.InferPass != null)
                {
                    elPass = new ExtractLoopsPass(true);
                    curr = elPass.run(curr);
                    CommandLineOptions.Clo.ExtractLoops = false;
                }
            }
            else
            {
                seqInstr = null;
                if (GlobalConfig.InferPass != null)
                {
                    throw new InvalidInput("We currently don't support summaries for concurrent programs");
                }
                if (config.NumCex > 1)
                {
                    throw new InvalidInput("Multiple counterexamples not yet supported for concurrent programs");
                }

                GlobalConfig.InferPass = null;
            }

            ProgTransformation.PersistentProgram.FreeParserMemory();
            #endregion

            // For debugging, create an Action for printing a trace at the source level
            var passes = new List<CompilerPass>(new CompilerPass[] { elPass, seqInstr, prune, rcalls, apass });
            var printTrace = new Action<ErrorTrace, string>((trace, fileName) =>
                {
                    if (!GlobalConfig.genCTrace)
                        return;
                    passes.Where(p => p != null)
                        .Iter(p => trace = p.mapBackTrace(trace));
                    PrintConcurrentProgramPath.printCTrace(inputProg, trace, fileName);
                    apass.reset();
                });

            var cex = config.NumCex;

            do
            {
                ////////////////////////////////////
                // Verification phase
                ////////////////////////////////////

                Log.WriteMemUsage();

                var refinementState = new RefinementState(curr, config.trackedVars, config.useLocalVariableAbstraction);

                ErrorTrace cexTrace = null;
                checkAndRefine(curr, refinementState, printTrace, out cexTrace);

                ////////////////////////////////////
                // Output Phase
                ////////////////////////////////////

                var currTrace = cexTrace == null ? null : cexTrace.Copy();

                if (cexTrace != null && !config.noTrace)
                {
                    if (elPass != null) cexTrace = elPass.mapBackTrace(cexTrace);
                    if (seqInstr != null) cexTrace = seqInstr.mapBackTrace(cexTrace);
                    cexTrace = prune.mapBackTrace(cexTrace);
                    cexTrace = rcalls.mapBackTrace(cexTrace);

                    //PrintProgramPath.print(rcalls.input, cexTrace, "temp0");

                    cexTrace = apass.mapBackTrace(cexTrace);

                    var traceName = "corral_out";
                    if (config.NumCex > 1)
                        traceName += (config.NumCex - cex);

                    if (GlobalConfig.genCTrace)
                    {
                        PrintConcurrentProgramPath.printCTrace(inputProg, cexTrace, config.noTraceOnDisk ? null : traceName);
                    }
                    else
                    {
                        //PrintProgramPath.print(inputProg, cexTrace, "temp0");
                        if(!config.noTraceOnDisk)
                            PrintConcurrentProgramPath.print(inputProg, cexTrace, traceName);

                        var init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);
                        PrintConcurrentProgramPath.print(init, cexTrace, config.inputFile);
                    }

                    apass.reset();
                }

                #region Stats for .NET programs
                if (cexTrace != null && config.verboseMode > 1)
                {
                    CounterexampleDebuggingInfo(config, new HashSet<string>(refinementState.getVars().Variables), cexTrace);
                }
                #endregion

                cex--;
                if (cexTrace == null) cex = 0;

                // Disable the failing assertion in the program
                if (cex > 0)
                    curr = DisableAssert(curr, currTrace, seqInstr.assertsPassedName);

                // Dump state
                CorralState.DumpCorralState(config, ConfigManager.progVerifyOptions.CallTree, refinementState.getVars().Variables);

                // Reset corral state
                ConfigManager.progVerifyOptions.CallTree = new HashSet<string>();

                // print timing information
                Stats.printStats();
                Log.WriteLine(string.Format("Number of procedures inlined: {0}", Stats.ProgCallTreeSize));
                Log.WriteLine(string.Format("Number of variables tracked: {0}", refinementState.getVars().Variables.Count));
                Stats.ProgCallTreeSize = 0;

            } while (cex > 0);

            var endTime = DateTime.Now;

            Log.WriteLine(string.Format("Total Time: {0} s", (endTime - startTime).TotalSeconds));

            // Add our CPU time to Z3's CPU time reported by SMTLibProcess and print it
            Microsoft.Boogie.FixedpointVC.CleanUp(); // make sure to account for FixedPoint Time
            System.TimeSpan TotalUserTime = System.Diagnostics.Process.GetCurrentProcess().UserProcessorTime;
            TotalUserTime += Microsoft.Boogie.SMTLib.SMTLibProcess.TotalUserTime;
            Log.WriteLine(string.Format("Total User CPU time: {0} s", TotalUserTime.TotalSeconds));


            Log.Close();

            return 0;
        }

        private static PersistentCBAProgram DisableAssert(PersistentCBAProgram program, ErrorTrace trace, string assertsPassed)
        {
            var prog = program.getCBAProgram();

            // walk the trace and program in lock step -- find the failing assertion
            var location = ErrorTrace.FindCmd(prog, trace, c => (c is AssumeCmd) && QKeyValue.FindBoolAttribute((c as AssumeCmd).Attributes, RewriteAsserts.AssertIdentificationAttribute));
            Debug.Assert(location != null);

            // Disable assert
            var acmd = location.Item2.Cmds[location.Item3] as AssumeCmd;
            Debug.Assert(acmd != null);
            acmd.Expr = Expr.False;

            // Disable assignment to assertsPassed (for better mod-set invariants)
            for(int i = 0; i < location.Item2.Cmds.Count; i++) 
            {
                var cmd = location.Item2.Cmds[i] as AssignCmd;
                if (cmd == null) continue;
                if (cmd.Lhss.Any(lhs => lhs.DeepAssignedVariable.Name == assertsPassed))
                {
                    location.Item2.Cmds[i] = BoogieAstFactory.MkAssume(Expr.True);
                }
            }

            BoogieUtil.PrintProgram(prog, "next.bpl");

            return new PersistentCBAProgram(prog, prog.mainProcName, prog.contextBound, program.mode);
        }

        private static void CounterexampleDebuggingInfo(Configs config, HashSet<string> trackedVars, ErrorTrace cexTrace)
        {
            Log.WriteLine(string.Format("LOC on trace: {0}", PrintConcurrentProgramPath.LOC));
            // compute number of unique procs inlined
            var procsInlined = BoogieVerify.UniqueProcsInlined();
            procsInlined.Add(config.mainProcName);
            Log.WriteLine(string.Format("Unique procs inlined: {0}", procsInlined.Count));
            var init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);
            BoogieUtil.DoModSetAnalysis(init);
            Log.WriteLine(string.Format("Total number of procs: {0}", init.TopLevelDeclarations.OfType<Implementation>().Count()));

            // Compute LOC on inlined procs and non-trivial procs
            var totalLoc = 0;
            var inlinedLoc = 0;

            var nonTrivialProcs = new HashSet<string>();
            var finalVars = new HashSet<string>();
            trackedVars.Iter(s => { if (s.StartsWith("F$")) finalVars.Add(s); });

            foreach (var impl in init.TopLevelDeclarations.OfType<Implementation>())
            {
                var loc = new HashSet<Tuple<string, int>>();
                foreach (var blk in impl.Blocks)
                {
                    foreach (var cmd in blk.Cmds.OfType<AssertCmd>())
                    {
                        var file = QKeyValue.FindStringAttribute(cmd.Attributes, "sourceFile");
                        var line = QKeyValue.FindIntAttribute(cmd.Attributes, "sourceLine", -1);
                        if (file == null || line == -1) continue;
                        loc.Add(Tuple.Create(file, line));
                    }
                }

                totalLoc += loc.Count;
                if (procsInlined.Contains(impl.Name)) inlinedLoc += loc.Count;
                if (procsInlined.Contains(impl.Name) && loc.Count > 0)
                {
                    foreach (IdentifierExpr m in impl.Proc.Modifies)
                    {
                        if (finalVars.Contains(m.Name)) { nonTrivialProcs.Add(impl.Name); break; }
                    }
                }
            }

            Log.WriteLine(string.Format("LOC inlined: {0} out of {1}", inlinedLoc, totalLoc));
            Log.WriteLine(string.Format("Non-trivial procs: {0}", nonTrivialProcs.Count));

            // Compute number of branches on the trace
            var nameImplMap = BoogieUtil.nameImplMapping(init);
            var branches = new HashSet<int>();
            var tloc = 0;
            TraceStats(cexTrace, nameImplMap, ref tloc, ref branches);
            Log.WriteLine(string.Format("Trace length (LOC): {0}", tloc));
            Log.WriteLine("Trace length (branches): {0}", branches.Print());
        }

        public static PersistentCBAProgram GetInputProgram(Configs config)
        {
            // This is to check the input program for parsing and resolution
            // errors. We check for type errors later
            Program init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);

            #region Early exit options
            if (config.unfoldRecursion != null)
            {
                var urec = new ExtractRecursionPass();
                if (config.mainProcName == null)
                {
                    config.mainProcName = init.TopLevelDeclarations.OfType<NamedDeclaration>()
                        .Where(nd => QKeyValue.FindBoolAttribute(nd.Attributes, "entrypoint"))
                        .Select(nd => nd.Name)
                        .FirstOrDefault();                        
                }
                var ttt = urec.run(new PersistentCBAProgram(init, config.mainProcName, 0));
                ttt.writeToFile(config.unfoldRecursion);
                throw new NormalExit("done");
            }

            if (config.unifyMaps)
            {
                var unify = new CoreLib.TypeUnify(init);
                unify.Unify("unified.bpl");

                throw new NormalExit("Done");
            }

            if (config.siOnly)
            {
                BoogieVerify.removeAsserts = false;
                var err = new List<BoogieErrorTrace>();
                init.Typecheck();

                BoogieVerify.options = new BoogieVerifyOptions();
                BoogieVerify.options.NonUniformUnfolding = config.NonUniformUnfolding;
                BoogieVerify.options.newStratifiedInlining = config.newStratifiedInlining;
                BoogieVerify.options.newStratifiedInliningAlgo = config.newStratifiedInliningAlgo;
                BoogieVerify.options.useDI = config.useDI;
                BoogieVerify.options.extraFlags = config.extraFlags;
                if (config.staticInlining > 0) BoogieVerify.options.StratifiedInlining = 100;
                if (config.useDuality) BoogieVerify.options.newStratifiedInlining = false;
                var rstatus = BoogieVerify.Verify(init, out err, true);
                Console.WriteLine("Return status: {0}", rstatus);
                if (err == null || err.Count == 0)
                    Console.WriteLine("No bugs found");
                else
                {
                    Console.WriteLine("Program has bugs");
                    foreach (var trace in err.OfType<BoogieAssertErrorTrace>())
                    {
                        Console.WriteLine("{0} did not verify", trace.impl.Name);
                        if(!config.noTrace) trace.cex.Print(0, Console.Out);
                    }
                }

                Console.WriteLine(string.Format("Number of procedures inlined: {0}", BoogieVerify.CallTreeSize));
                Console.WriteLine(string.Format("Total Time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

                throw new NormalExit("Done");
            }
            #endregion

            ////////////////////////////////
            // Gather templates for Houdini
            var extraVars = findTemplates(init, config);
            config.trackedVars.UnionWith(extraVars);
            GlobalConfig.InferPass.printHoudiniQuery = config.houdiniQuery;
            ContractInfer.checkStaticAnalysis = config.checkStaticAnalysis;
            if (config.runHoudini == -2 && !config.summaryComputation)
            {
                GlobalConfig.InferPass = null;
            }
            ////////////////////////////////

            ////////////////////////////////
            // Special support for SDV
            if (config.sdvMode)
            {
                runSDVMode(init, config);
                return null;
            }


            #region Check that the input is well-formed

            //////////////////////////////////////////
            // Make sure that the input is well-formed
            if (config.mainProcName == null)
            {
                List<string> entrypoints = EntrypointScanner.FindEntrypoint(init);
                if (entrypoints.Count == 0)
                    throw new InvalidInput("Main procedure not specified");
                config.mainProcName = entrypoints[0];
            }

            if (BoogieUtil.findProcedureImpl(init.TopLevelDeclarations, config.mainProcName) == null)
            {
                throw new InvalidInput("Implementation of main procedure not found");
            }
            
            if (SequentialInstrumentation.isSingleThreadProgram(init, config.mainProcName))
            {
                GlobalConfig.isSingleThreaded = true;
                Console.WriteLine("Single threaded program detected");
            }

            if (!GlobalConfig.isSingleThreaded)
            {
                /* forward/backward approach does not handle multi-threaded programs */
                if (config.FwdBckSearch == 1)
                {
                    Console.WriteLine("Sorry, fwd/bck approach not available for multi-threaded programs. Running fwd approach.");
                    config.FwdBckSearch = 0;
                    ConfigManager.pathVerifyOptions.useFwdBck = false;
                    ConfigManager.progVerifyOptions.useFwdBck = false;
                    ConfigManager.refinementVerifyOptions.useFwdBck = false;
                }

                try
                {
                    WellFormedProg.check(init);
                }
                catch (InvalidInput e)
                {
                    throw new InvalidInput("Input Program not well-formed.\n" + e.Message);
                }
            }

            if (config.explainQuantifiers != null)
            {
                if (!WellFormedProg.checkFunctionsAreInlined(init))
                {
                    throw new InvalidInput("Please add {:inline} attribute to all functions with a body in the program to use /explainQuantifiers");
                }

                if (config.arrayTheory != ArrayTheoryOptions.STRONG && !WellFormedProg.checkMapTypes(init))
                {
                    throw new InvalidInput("Please use the flag /useArrayTheory along with /explainQuantifiers");
                }

            }

            #endregion

            // force inline
            foreach (var impl in init.TopLevelDeclarations.OfType<Implementation>())
            {
                if (BoogieUtil.checkAttrExists("inline", impl.Attributes) || BoogieUtil.checkAttrExists("inline", impl.Proc.Attributes))
                    impl.AddAttribute(CoreLib.StratifiedInlining.ForceInlineAttr);
            }

            // CodeExpr support
            PreProcessCodeExpr(init);

            foreach(var decl in init.TopLevelDeclarations)
                    decl.Attributes = BoogieUtil.removeAttr("inline", decl.Attributes);

            // Add unique ids on calls -- necessary for reusing call trees
            // across stratified inlining queries. The unique ids are used
            // to reliably identify the same procedure calls across queries.
            var addIds = new AddUniqueCallIds();
            addIds.VisitProgram(init);

            // Update mod sets
            BoogieUtil.DoModSetAnalysis(init);

            // Now we can typecheck
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            if (BoogieUtil.TypecheckProgram(init, config.inputFile))
            {
                BoogieUtil.PrintProgram(init, "error.bpl");
                throw new InvalidProg("Cannot typecheck " + config.inputFile);
            }
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            //BoogieUtil.PrintProgram(init, "temp.bpl");

            // thread-local variables are always tracked
            var globals = BoogieUtil.GetGlobalVariables(init);
            foreach (var g in globals)
            {
                if (QKeyValue.FindBoolAttribute(g.Attributes, LanguageSemantics.ThreadLocalAttr))
                    config.trackedVars.Add(g.Name);
            }

            // Gather the set of initially tracked variables
            var initialTrackedVars = getTrackedVars(init, config);
            config.trackedVars.Clear();
            config.trackedVars.UnionWith(initialTrackedVars);

            // Gather source info
            if (GlobalConfig.genCTrace)
            {
                PrintConcurrentProgramPath.printData = config.printData;
                PrintConcurrentProgramPath.gatherCSourceLineInfo(init);
            }

            var inputProg = new PersistentCBAProgram(init, config.mainProcName, GlobalConfig.isSingleThreaded ? 1 : config.contextBound);
            ProgTransformation.PersistentProgram.FreeParserMemory();
            
            return inputProg;
        }

        // Inline procedures call from inside a CodeExpr
        public static void PreProcessCodeExpr(Program program)
        {
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.OriginalBlocks = impl.Blocks;
                impl.OriginalLocVars = impl.LocVars;
            }
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (CommandLineOptions.Clo.UserWantsToCheckRoutine(impl.Name) && !impl.SkipVerification)
                {
                    CodeExprInliner.ProcessImplementation(program, impl);
                }
            }
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.OriginalBlocks = null;
                impl.OriginalLocVars = null;
            }
        }

        // Inline procedures call from inside a CodeExpr
        class CodeExprInliner : Inliner
        {
            Dictionary<Declaration, QKeyValue> declToAnnotations;

            public CodeExprInliner(Program program)
                : base(program, null, -1)
            {
                this.declToAnnotations = new Dictionary<Declaration, QKeyValue>();
                // save annotation
                foreach (var decl in program.TopLevelDeclarations)
                {
                    declToAnnotations.Add(decl, decl.Attributes);
                    decl.Attributes = null;
                }
            }

            new public static void ProcessImplementation(Program program, Implementation impl)
            {
                var ce = new CodeExprInliner(program);
                ProcessImplementation(program, impl, ce);
                ce.RestoreAnnotations();
            }

            public override Expr VisitCodeExpr(CodeExpr node)
            {
                // Install {:inline} annotations
                RestoreAnnotations();

                var ret = base.VisitCodeExpr(node);

                // remove {:inline} annotation
                RemoveAnnotations();

                return ret;
            }

            void RestoreAnnotations()
            {
                foreach (var decl in program.TopLevelDeclarations)
                {
                    if (!declToAnnotations.ContainsKey(decl)) continue;
                    decl.Attributes = declToAnnotations[decl];
                }
            }

            void RemoveAnnotations()
            {
                foreach (var decl in program.TopLevelDeclarations)
                {
                    decl.Attributes = null;
                }
            }

        }

        public static void InlineProcedures(Program program)
        {
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            ExecutionEngine.EliminateDeadVariables(program);
            ExecutionEngine.Inline(program);
            CommandLineOptions.Clo.StratifiedInlining = si;
        }

        // Stats: LOC on trace and number of branches
        public static void TraceStats(ErrorTrace trace, Dictionary<string, Implementation> nameImplMap, ref int loc, ref HashSet<int> branches)
        {
            if (trace == null || !nameImplMap.ContainsKey(trace.procName))
                return;

            var impl = nameImplMap[trace.procName];
            var nb = new HashSet<int>();
            var blockMap = BoogieUtil.labelBlockMapping(impl);
            var first = true;

            foreach (var blk in trace.Blocks)
            {
                if (first)
                {
                    first = false;
                    continue;
                }

                if (blockMap.ContainsKey(blk.blockName))
                {
                    var ablk = blockMap[blk.blockName];
                    foreach (var acmd in ablk.Cmds.OfType<PredicateCmd>())
                    {
                        if (QKeyValue.FindStringAttribute(acmd.Attributes, "sourceFile") != null) loc++;
                        if (QKeyValue.FindIntAttribute(acmd.Attributes, "breadcrumb", -1) != -1)
                            nb.Add(QKeyValue.FindIntAttribute(acmd.Attributes, "breadcrumb", -1));
                    }
                }

                foreach (var ccmd in blk.Cmds.OfType<CallInstr>())
                {
                    TraceStats(ccmd.calleeTrace, nameImplMap, ref loc, ref branches);
                }
            }

            branches.UnionWith(nb);
        }

        // Assumptions: 
        //  -- program is sequential
        //  -- assert is only at the end of main
        // What it does: gives the program to Boogie as soon as possible
        public static void runSDVMode(Program program, Configs config)
        {
            // Save memory by deleting tokens
            ProgTransformation.PersistentProgram.clearTokens = true;
            ProgTransformation.PersistentProgramIO.useDuplicator = true;
            VerificationPass.usePruning = false;

            SetSdvModeOptions(config);
            var progVerifyOptions = ConfigManager.progVerifyOptions;
            var pathVerifyOptions = ConfigManager.pathVerifyOptions;
            var refinementVerifyOptions = ConfigManager.refinementVerifyOptions;

            CorralState.AbsorbPrevState(config, progVerifyOptions);

            var startTime = DateTime.Now;
            var cloopsTime = TimeSpan.Zero;
            var SItime = TimeSpan.Zero;

            #region set up entry point
            if (config.mainProcName != null)
            {
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Attributes));
                var ep = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, config.mainProcName);
                if (ep == null)
                    throw new InvalidInput(string.Format("Entrypoint {0} not found", config.mainProcName));
                ep.AddAttribute("entrypoint");
            }
            else
            {
                var eps = program.TopLevelDeclarations.OfType<Implementation>()
                    .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));
                var epsCount = eps.Count();
                if (epsCount > 1)
                    throw new InvalidInput("Multiple entrypoints specified");

                if (epsCount == 0)
                {
                    // look for procedure
                    var epsp = program.TopLevelDeclarations.OfType<Procedure>()
                        .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"));
                    if (epsp.Count() > 1)
                        throw new InvalidInput("Multiple entrypoints specified");
                    if (epsp.Count() == 0)
                        throw new InvalidInput("No entrypoint specified");
                    config.mainProcName = epsp.First().Name;
                    var ep = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, config.mainProcName);
                    if (ep == null)
                        throw new InvalidInput(string.Format("Entrypoint {0} not found", config.mainProcName));
                    ep.AddAttribute("entrypoint");
                }
                else
                {
                    var ep = eps.First();
                    config.mainProcName = ep.Name;
                }
            }
            #endregion

            // annotate calls with a unique number
            var addIds = new AddUniqueCallIds();
            addIds.VisitProgram(program);

            // Prune mod sets
            BoogieUtil.DoModSetAnalysis(program);

            // Gather the set of initially tracked variables
            var initialTrackedVars = getTrackedVars(program, config);

            // Did we reach the recursion bound?
            var reachedBound = false;

            // Set up refinement state
            var refinementState = new GlobalRefinementState(program, initialTrackedVars);

            // Add a new main (for the assert)
            InsertionTrans mainTrans = null;
            var newMain = config.mainProcName;
            if (!config.deepAsserts && !config.sdvInstrumentAssert)
                newMain = AddFakeMain(program, BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, config.mainProcName), out mainTrans);

            // Capture state
            InsertionTrans captureTrans = new InsertionTrans();
            if (config.printData == 2)
                captureStates(program, out captureTrans);

            var init = new PersistentCBAProgram(program, newMain, 1);
            var curr = init;

            var passes = new List<CompilerPass>();

            // instrument asserts
            if (config.sdvInstrumentAssert)
            {
                var sinstr = new SequentialInstrumentation();
                curr = sinstr.run(curr);
                passes.Add(sinstr);
                refinementState.Add(new AddVarMapping(new VarSet(sinstr.assertsPassedName, "")));
            }

            // extract loops
            var elPass = new ExtractLoopsPass(true);
            curr = elPass.run(curr);
            CommandLineOptions.Clo.ExtractLoops = false;
            passes.Add(elPass);

            var currProg = curr.getCBAProgram();
            var allVars = VarSet.GetAllVars(currProg);

            var correct = false;
            var iterCnt = 0;
            var maxInlined = 0;
            var vcSize = 0;
            VarSet varsToKeep;
            var cLoopHistory = ConstLoopHistory.GetNull();
            ErrorTrace buggyTrace = null;

            // Run refinement loop
            while (true)
            {
                iterCnt++;
                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                // Abstract
                refinementState.setAllVars(allVars);
                varsToKeep = refinementState.getVars();
                var abstraction = new VariableSlicePass(varsToKeep);
                var abs = abstraction.run(curr);

                if (GlobalConfig.printInstrumented)
                {
                    abs.writeToFile(GlobalConfig.instrumentedFile);
                    throw new NormalExit("Printed instrumented file to " + GlobalConfig.instrumentedFile);
                }

                ContractInfer ciPass = null;
                if (iterCnt == 1 && GlobalConfig.InferPass != null)
                {
                    var tmp_abs = abs;

                    ciPass = new ContractInfer(GlobalConfig.InferPass);
                    if (config.houdiniTimeout != -1) ContractInfer.HoudiniTimeout = config.houdiniTimeout; // milliseconds
                    else ContractInfer.HoudiniTimeout = 60000; // milliseconds
                    ciPass.ExtractLoops = false;
                    abs = ciPass.run(abs);
                    Console.WriteLine("Houdini took {0} seconds", ciPass.lastRun.TotalSeconds.ToString("F2"));

                    // add summaries to the original program
                    curr = ciPass.addSummaries(curr);

                    if (config.trainSummaries)
                    {
                        var tmpCiPass = new ContractInfer(GlobalConfig.InferPass);
                        tmpCiPass.trainSummaries(tmp_abs.getCBAProgram());
                    }

                }

                // Infer min. loop bounds
                if (iterCnt == 1)
                {
                    // In SDV mode, the default is 10
                    var maxBound = config.maxStaticLoopBound == 0 ? 10 : config.maxStaticLoopBound;

                    var LBoptions = ConfigManager.progVerifyOptions.Copy();
                    LBoptions.useDI = false;
                    LBoptions.useFwdBck = false;
                    LBoptions.NonUniformUnfolding = false;
                    LBoptions.extraFlags = new HashSet<string>();
                    LBoptions.newStratifiedInliningAlgo = "";

                    var bounds = LoopBound.Compute(abs.getCBAProgram(), maxBound, GlobalConfig.annotations, LBoptions);
                    progVerifyOptions.extraRecBound = new Dictionary<string, int>();
                    bounds.Iter(kvp => progVerifyOptions.extraRecBound.Add(kvp.Key, kvp.Value));
                    Console.WriteLine("LB: Took {0} s", LoopBound.timeTaken.TotalSeconds.ToString("F2"));
                }

                if (config.trackedVarsSecondary.Count > 0)
                {
                    config.trackedVarsSecondary.Iter(s => refinementState.trackVar(s));
                    config.trackedVarsSecondary.Clear();
                    continue;
                }

                DeepAssertRewrite da = null;
                if (config.deepAsserts)
                {
                    DeepAssertRewrite.disableLoops = config.deepAssertsNoLoop;

                    //abs.writeToFile("ttin.bpl");
                    da = new DeepAssertRewrite();
                    abs = da.run(abs);
                    //abs.writeToFile("ttout.bpl");
                }

                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                // Check Program
                BoogieVerify.options = progVerifyOptions;
                BoogieVerify.setTimeOut(GlobalConfig.getTimeLeft());

                Console.WriteLine("Verifying program while tracking: {0}", varsToKeep.Variables.Print());

                //Stats.beginTime();
                BoogieVerify.verificationTime = TimeSpan.Zero;

                var verificationPass = new VerificationPass(true);
                verificationPass.run(abs);

                //Stats.endTime(ref Stats.programVerificationTime);
                Stats.programVerificationTime += BoogieVerify.verificationTime;

                BoogieVerify.setTimeOut(0);
                maxInlined = (BoogieVerify.CallTreeSize > maxInlined) ? BoogieVerify.CallTreeSize : maxInlined;
                maxInlined += (da != null) ? da.procsIncludedInMain : 0;
                vcSize = (BoogieVerify.vcSize > vcSize) ? BoogieVerify.vcSize : vcSize;

                if (verificationPass.success)
                {
                    // program correct
                    correct = true;
                    reachedBound = verificationPass.reachedBound;
                    break;
                }

                Console.Write("Program has a potential bug: ");

                if (config.verboseMode >= 2)
                    verificationPass.trace.printRecBound();

                // Check if counterexample is feasible
                ErrorTrace trace = verificationPass.trace;
                if (ciPass != null) trace = ciPass.mapBackTrace(trace);
                if(da != null) trace = da.mapBackTrace(trace);
                trace = abstraction.mapBackTrace(trace);

                // Restrict the program to the trace
                var tinfo = new InsertionTrans();
                var traceProgCons = new RestrictToTrace(currProg, tinfo);
                traceProgCons.addTrace(trace);

                var ptrace =
                    new PersistentCBAProgram(traceProgCons.getProgram(),
                        traceProgCons.getFirstNameInstance(curr.mainProcName),
                        curr.contextBound, ConcurrencyMode.AnyInterleaving);

                //ptrace.writeToFile("ptrace.bpl");

                if (da != null)
                {
                    refinementState.Push();
                    ptrace = DeepAssertRewrite.InstrumentTrace(ptrace, refinementState);
                }

                //////////////////////////
                // Check concrete trace
                //////////////////////////

                Stats.beginTime();
                BoogieVerify.options = pathVerifyOptions;

                var pverify = new VerificationPass(config.printData != 0);
                pverify.run(ptrace);

                Stats.endTime(ref Stats.pathVerificationTime);

                if (!pverify.success)
                {
                    // Found bug
                    Console.WriteLine("True bug");
                    correct = false;
                    if (pverify.trace == null)
                    {
                        buggyTrace = trace;
                    }
                    else
                    {
                        if (da != null)
                            buggyTrace = da.InstrumentTraceMapBack(pverify.trace);
                        else
                            buggyTrace = pverify.trace;

                        buggyTrace = tinfo.mapBackTrace(buggyTrace);

                    }
                    //PrintProgramPath.print(curr, buggyTrace, "tmp");
                    break;
                }
                Console.WriteLine("False bug");

                //////////////////////////
                // Refinement
                //////////////////////////

                // Before refining, make sure calls don't have globals on calls
                var rcalls = new RewriteCallCmdsPass();
                ptrace = rcalls.run(ptrace);

                //var ul = CommandLineOptions.Clo.UseLabels;
                //CommandLineOptions.Clo.UseLabels = true;

                // Refine
                Stats.beginTime();
                BoogieVerify.options = refinementVerifyOptions;
                refinementState.setAllVars(ptrace.allVars);
                var refinement = new GeneralRefinementScheme(new SequentialProgVerifier(), true,
                    ptrace, refinementState, config.tryDroppingForRefinement);
                refinement.doRefinement();
                Stats.endTime(ref Stats.pathVerificationTime);

                if (da != null)
                    refinementState.Pop();
                
                ProgTransformation.PersistentProgram.FreeParserMemory();

                //CommandLineOptions.Clo.UseLabels = ul;
            }
            var endTime = DateTime.Now;

            Stats.printStats();

            Console.WriteLine("CLoops Time: {0} s", cloopsTime.TotalSeconds.ToString("F2"));
            Console.WriteLine("Num refinements: {0}", iterCnt);
            Console.WriteLine("Number of procedures inlined: {0}", maxInlined);
            Console.WriteLine("VC Size: {0}", vcSize);
            Console.WriteLine("Final tracked vars: {0}", varsToKeep.Variables.Print());
            Console.WriteLine("Total Time: {0} s", (endTime - startTime).TotalSeconds.ToString("F2"));
            
            // Add our CPU time to Z3's CPU time reported by SMTLibProcess and print it
            Microsoft.Boogie.FixedpointVC.CleanUp(); // make sure to account for FixedPoint Time
            System.TimeSpan TotalUserTime = System.Diagnostics.Process.GetCurrentProcess().UserProcessorTime;
            TotalUserTime += Microsoft.Boogie.SMTLib.SMTLibProcess.TotalUserTime;
            Console.WriteLine(string.Format("Total User CPU time: {0} s", TotalUserTime.TotalSeconds.ToString("F2")));



            if (correct)
            {
                Console.WriteLine("No bugs found");
                if (reachedBound)
                {
                    Console.WriteLine("Proof not computed");
                }
                else
                {
                    Console.WriteLine("Proof computed");
                }
            }
            else
            {
                Console.WriteLine("prog.c(1,1): error PF5001: This assertion can fail");
                Console.WriteLine("Program has bugs");

                passes.Reverse<CompilerPass>()
                                   .Iter(cp => buggyTrace = cp.mapBackTrace(buggyTrace));

                buggyTrace = captureTrans.mapBackTrace(buggyTrace);
                if (mainTrans != null)
                {
                    buggyTrace = mainTrans.mapBackTrace(buggyTrace);

                    // knock off fakeMain
                    ErrorTrace tempt = null;
                    buggyTrace.Blocks.Iter(blk =>
                        {
                            var cmain = blk.Cmds.OfType<CallInstr>().Where(ci => ci.callee == config.mainProcName).FirstOrDefault();
                            if (cmain != null) tempt = cmain.calleeTrace;
                        });
                    buggyTrace = tempt;
                }

                //serialize the buggyTrace
                BinaryFormatter serializer = new BinaryFormatter();
                FileStream stream = new FileStream("buggyTrace.serialised", FileMode.Create, FileAccess.Write, FileShare.None);
                serializer.Serialize(stream, buggyTrace);
                stream.Close();
            }

            CorralState.DumpCorralState(config, progVerifyOptions.CallTree, varsToKeep.Variables);
            Log.Close();
        }

        private static void SetSdvModeOptions(Configs config)
        {
            ConfigManager.Initialize(config);

            // program options
            ConfigManager.progVerifyOptions.UseProverEvaluate = false;
            ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
            if (config.NonUniformUnfolding || config.newStratifiedInlining)
                    ConfigManager.progVerifyOptions.UseProverEvaluate = true;

            // path options
            ConfigManager.pathVerifyOptions.UseProverEvaluate = false;
            ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
            if (config.NonUniformUnfolding || config.newStratifiedInlining)
                ConfigManager.pathVerifyOptions.UseProverEvaluate = true;

            if (config.printData == 1)
            {
                if (config.useProverEvaluate)
                    ConfigManager.pathVerifyOptions.UseProverEvaluate = true;
                else
                    ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = false;
            }
            else if (config.printData == 2)
            {
                ConfigManager.pathVerifyOptions.UseProverEvaluate = config.useProverEvaluate;
                ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = false;
            }
        }

        private static void captureStates(Program program, out InsertionTrans tinfo)
        {
            tinfo = new InsertionTrans();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var newcmds = new List<Cmd>();
                    tinfo.addTrans(impl.Name, blk.Label, blk.Label);
                    var incnt = -1;
                    foreach (var cmd in blk.Cmds.OfType<Cmd>())
                    {
                        incnt ++;

                        newcmds.Add(cmd);
                        tinfo.addTrans(impl.Name, blk.Label, incnt, cmd, blk.Label, newcmds.Count - 1, new List<Cmd>{cmd});

                        var acmd = cmd as PredicateCmd;
                        if (acmd == null) continue;

                        if (QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile") != null || BoogieUtil.checkAttrExists("sourceloc", acmd.Attributes))
                        {
                            var par = new List<object>();
                            par.Add("corral_capture");
                            newcmds.Add(
                                new AssumeCmd(Token.NoToken, Expr.True, new QKeyValue(Token.NoToken, "captureState", par, null)));
                        }
                    }
                    blk.Cmds = newcmds;
                }
            }
        }

        // Add a fake main
        private static string AddFakeMain(Program program, Implementation oldMainImpl, out InsertionTrans tinfo)
        {
            var oldMainProc = oldMainImpl.Proc;
            tinfo = new InsertionTrans();

            // Create new local variable "assertVar"
            var assertVarFormal = BoogieAstFactory.MkFormal("dup_assertVar", Microsoft.Boogie.Type.Bool, false);

            // Add formal to old main
            oldMainImpl.OutParams.Add(assertVarFormal);
            oldMainProc.OutParams.Add(assertVarFormal);

            // Instrument asserts in old Main. 
            var newBlocks = new List<Block>();
            foreach (var blk in oldMainImpl.Blocks)
            {
                var currCmds = new List<Cmd>();
                var currLabel = blk.Label;

                tinfo.addTrans(oldMainImpl.Name, blk.Label, blk.Label);
                if (blk.Label == oldMainImpl.Blocks[0].Label)
                {
                    // av := true
                    currCmds.Add(BoogieAstFactory.MkVarEqConst(assertVarFormal, true));
                }

                var incnt = -1;
                foreach (Cmd cmd in blk.Cmds)
                {
                    incnt++;

                    var actualCmd = cmd;
                    if ((cmd is CallCmd) && (cmd as CallCmd).callee == LanguageSemantics.assertNotReachableName())
                    {
                        actualCmd = BoogieAstFactory.MkAssert(Expr.False);
                    }

                    if (!(actualCmd is AssertCmd) || BoogieUtil.isAssertTrue(actualCmd))
                    {
                        currCmds.Add(actualCmd);
                        tinfo.addTrans(oldMainImpl.Name, blk.Label, incnt, cmd, currLabel, currCmds.Count - 1, new List<Cmd>{currCmds.Last() as Cmd});
                        continue;
                    }

                    // av := expr
                    currCmds.Add(BoogieAstFactory.MkVarEqExpr(assertVarFormal, (actualCmd as AssertCmd).Expr));
                    tinfo.addTrans(oldMainImpl.Name, blk.Label, incnt, cmd, currLabel, currCmds.Count - 1, new List<Cmd>{currCmds.Last() as Cmd});

                    // create three blocks
                    var lab1 = BoogieAstFactory.uniqueLabel();
                    var lab2 = BoogieAstFactory.uniqueLabel();
                    var lab3 = BoogieAstFactory.uniqueLabel();

                    // end current block: goto lab1, lab2
                    newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(lab1, lab2)));

                    // lab1: assume !av; return;
                    newBlocks.Add(new Block(Token.NoToken, lab1,
                        new List<Cmd>{BoogieAstFactory.MkAssume(Expr.Not(Expr.Ident(assertVarFormal)))},
                        new ReturnCmd(Token.NoToken)));

                    // lab2: assume av; goto lab3
                    newBlocks.Add(new Block(Token.NoToken, lab2,
                        new List<Cmd>{BoogieAstFactory.MkAssume(Expr.Ident(assertVarFormal))},
                        BoogieAstFactory.MkGotoCmd(lab3)));

                    currLabel = lab3;
                    currCmds = new List<Cmd>();
                }
                newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, blk.TransferCmd));
            }
            oldMainImpl.Blocks = newBlocks;

            // remove "entrypoint" from old main
            oldMainImpl.Attributes = BoogieUtil.removeAttr("entrypoint", oldMainImpl.Attributes);

            // Create new main procedure
            var newMainProc = new Procedure(Token.NoToken, "fakeMain", oldMainProc.TypeParameters,
                oldMainProc.InParams, oldMainProc.OutParams, oldMainProc.Requires,
                oldMainProc.Modifies, oldMainProc.Ensures);

            var newMainImpl = new Implementation(Token.NoToken, "fakeMain", oldMainImpl.TypeParameters,
                oldMainImpl.InParams, oldMainImpl.OutParams, new List<Variable>(), new List<Block>());

            newMainImpl.AddAttribute("entrypoint");

            // call old_main
            // assert assertVar;
            var ins = new List<Expr>();
            var outs = new List<IdentifierExpr>();

            oldMainImpl.InParams.OfType<Variable>()
                .Iter(v => ins.Add(Expr.Ident(v)));

            oldMainImpl.OutParams.OfType<Variable>()
                .Iter(v => outs.Add(Expr.Ident(v)));

            var callMain = new CallCmd(Token.NoToken, oldMainProc.Name, ins, outs);
            callMain.Proc = oldMainProc;

            var cmds = new List<Cmd>{callMain, new AssertCmd(Token.NoToken, Expr.Ident(assertVarFormal))};
            newMainImpl.Blocks.Add(new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken)));
            newMainImpl.Proc = newMainProc;

            program.AddTopLevelDeclaration(newMainProc);
            program.AddTopLevelDeclaration(newMainImpl);

            return newMainImpl.Name;
        }

        public static HashSet<string> findTemplates(Program program, Configs config)
        {
            var templateVarNames = new HashSet<Variable>();
            List<Ensures> ens = new List<Ensures>();
            List<Requires> req = new List<Requires>();
            var extra = new HashSet<string>();

            var newDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (!QKeyValue.FindBoolAttribute(decl.Attributes, "template"))
                {
                    newDecls.Add(decl);
                    continue;
                }
                if (decl is GlobalVariable)
                {
                    templateVarNames.Add((decl as Variable));
                }
                else if (decl is Procedure)
                {
                    var proc = decl as Procedure;
                    var absHoudiniAnnotations = new HashSet<string>(new string[] { "pre", "post", "upper" });

                    proc.Ensures.OfType<Ensures>().Where(e =>
                        (config.runAbsHoudini != null && (e.Free || BoogieUtil.checkAttrExists(absHoudiniAnnotations, e.Attributes))) ||
                        (config.runAbsHoudini == null && !BoogieUtil.checkAttrExists("abshoudini", e.Attributes)))
                        .Iter(e => ens.Add(e));

                    proc.Requires.OfType<Requires>().Where(r =>
                        (config.runAbsHoudini != null && (r.Free || BoogieUtil.checkAttrExists(absHoudiniAnnotations, r.Attributes))) ||
                        (config.runAbsHoudini == null && !BoogieUtil.checkAttrExists("abshoudini", r.Attributes)))
                        .Iter(r => req.Add(r));
                }

            }
            foreach (Ensures en in ens)
            {
                var gu = new GlobalVarsUsed();
                gu.VisitEnsures(en);
                extra.UnionWith(gu.globalsUsed);
            }
            foreach (Requires re in req)
            {
                var gu = new GlobalVarsUsed();
                gu.VisitRequires(re);
                extra.UnionWith(gu.globalsUsed);
            }
            foreach (var t in templateVarNames)
            {
                extra.Remove(t.Name);
            }

            if (config.trainSummaries)
            {
                // Track variables mentioned in the templates
                var trainingProc = program.TopLevelDeclarations.OfType<Procedure>()
                    .Where(proc => BoogieUtil.checkAttrExists("trainingPredicates", proc.Attributes))
                    .FirstOrDefault();
                if (trainingProc != null)
                {
                    var vu = new VarsUsed();
                    trainingProc.Ensures.Iter(e => vu.VisitExpr(e.Condition));
                    extra.UnionWith(vu.globalsUsed);
                }
            }

            program.TopLevelDeclarations = newDecls;
            ContractInfer.runAbsHoudiniConfig = config.runAbsHoudini;
            GlobalConfig.InferPass = new ContractInfer(templateVarNames, req, ens, config.runHoudini, -1);
            return extra;
        }

        // For debugging (printing abstract traces)
        static int traceCounterDbg = 0;

        // Check program "inputProg" using variable abstraction
        public static bool checkAndRefine(PersistentCBAProgram prog, RefinementState refinementState, Action<ErrorTrace, string> printTrace, out ErrorTrace cexTrace)
        {
            cexTrace = null;
            var outcomeSuccess = true;
            var finerCheck = false;
            var lightweight = false;
            var optRefinementLoop = true;

            #region flag setting
            if (GlobalConfig.refinementAlgo[3] == 'f')
                finerCheck = false;
            else 
                finerCheck = GlobalConfig.isSingleThreaded ? false : true;

            if (GlobalConfig.refinementAlgo[2] == 'f')
                lightweight = false;
            else
                lightweight = true;

            if (GlobalConfig.refinementAlgo[1] == 'f')
                GeneralRefinementScheme.useHierarchicalSearch = false;
            else
                GeneralRefinementScheme.useHierarchicalSearch = true;

            if (GlobalConfig.refinementAlgo[0] == 'f')
                optRefinementLoop = false;
            else
                optRefinementLoop = true;
            #endregion

            // This loop exits only under two conditions: 
            //     - The abstracted program had no errors
            //     - The concretized counterexample has an error

            refinementState.Push();

            while (true)
            {
                refinementState.Push();
                PersistentCBAProgram counterexample = null;

                if (GlobalConfig.timeOutReached())
                    throw new InternalError("Timeout reached!");

                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                if (!GlobalConfig.useLocalVariableAbstraction)
                    Log.WriteLine("Verifying program while tracking: {0}", refinementState.getVars().Variables.Print());
                else
                    Log.WriteLine("Verifying program while tracking: {0}", refinementState.getVars().ToString());

                // This records the transformation made when "curr" is
                // transformed to "counterexample"
                InsertionTrans tinfo = null;

                bool success =
                    CBADriver.checkProgram(ref prog, refinementState.getVars(), true, out counterexample, out tinfo, out cexTrace);

                if (success) {
                    Log.WriteLine("Program has no bugs");
                    if (CBADriver.reachedBound)
                    {
                        Log.WriteLine("Reached recursion bound of " + GlobalConfig.recursionBound.ToString());
                    }
                    outcomeSuccess = true;
                    break;
                }

                Log.Write("Program has a potential bug: ");

                if (GlobalConfig.printAllTraces)
                {
                    printTrace(cexTrace, "corral_out" + traceCounterDbg.ToString());
                    traceCounterDbg++;
                }

                if (!lightweight) counterexample.mode = ConcurrencyMode.AnyInterleaving;

                refinementState.Add(new TraceMapping(tinfo));

                //CommandLineOptions.Clo.SimplifyLogFilePath = "log";

                // Check if true bug. Otherwise, gather variables to track                
                if (optRefinementLoop)
                    success = checkAndRefinePathFewPasses(counterexample, refinementState, out cexTrace);
                else
                    success = checkAndRefinePath(counterexample, refinementState, out cexTrace);

                if (!success)
                {
                    // Generate cex in the original program
                    cexTrace = tinfo.mapBackTrace(cexTrace);
                    outcomeSuccess = false;
                    break;
                }

                while (finerCheck)
                {
                    // Expand the check to all possible interleavings contained in counterexample
                    counterexample.mode = ConcurrencyMode.AnyInterleaving;

                    PersistentCBAProgram counterexample2 = null;
                    InsertionTrans tinfo2 = null;
                    ErrorTrace cexTrace2 = null;
                    
                    success =
                        CBADriver.checkPath(counterexample, refinementState.getVars(), true, out counterexample2, out tinfo2, out cexTrace2);

                    // We have enough tracked vars
                    if (success) break;
                    Debug.Assert(counterexample2.mode == ConcurrencyMode.FixedContext);

                    // We don't have enough tracked vars -- track more
                    Log.Write("Program has a potential bug: ");

                    refinementState.Push();
                    refinementState.Add(new TraceMapping(tinfo2));
                    success = checkAndRefinePathFewPasses(counterexample2, refinementState, out cexTrace2);
                    refinementState.Pop();

                    if (!success)
                    {
                        //PrintProgramPath.print(counterexample2, cexTrace2, "cex2");

                        // Generate cex in the original program
                        cexTrace2 = tinfo2.mapBackTrace(cexTrace2);
                        cexTrace = tinfo.mapBackTrace(cexTrace2);
                        outcomeSuccess = false;
                        break;
                    }
                }
                
                refinementState.Pop();

                // We've found a bug
                if (!outcomeSuccess) break;
            }
            
            refinementState.Pop();

            return outcomeSuccess;
        }

        // Does field refinement. It optimizes the flow of CompilerPasses, factoring out the
        // common ones outside the refinement loop
        private static bool checkAndRefinePathFewPasses(PersistentCBAProgram counterexample,
            RefinementState refinementState, out ErrorTrace cexTrace)
        {
            BoogieVerify.setTimeOut(GlobalConfig.getTimeLeft());
            
            // Check if counterexample is valid
            var success = CBADriver.checkPath(counterexample, counterexample.allVars, out cexTrace);

            if (!success)
            {
                Log.WriteLine("True bug");
                return false;
            }
            else
            {
                Log.WriteLine("False bug");
            }

            cexTrace = null;

            StormInstrumentationPass cp1 = null;
            StaticInliningAndUnrollingPass cp2 = null;

            if (!GlobalConfig.isSingleThreaded)
            {
                cp1 = new StormInstrumentationPass();
            }

            /*
            if (!GlobalConfig.useLocalVariableAbstraction)
            {
                cp2 = new StaticInliningAndUnrollingPass(new StaticSettings(-1, 1));
            }
            */

            var prog = counterexample;
            if (cp1 != null) prog = cp1.run(prog);
            if (cp2 != null) prog = cp2.run(prog);

            refinementState.Push();

            if (cp1 != null) refinementState.Add(new InstrMapping(cp1));
            if (cp2 != null) refinementState.Add(new InliningMapping(cp2));

            ConfigManager.beginRefinement();

            // Compute the new set of tracked variables to rule out this counterexample
            var refine = new GeneralRefinementScheme(new SequentialProgVerifier(), true, prog, refinementState);
            if (GlobalConfig.cadeTiming)
            {
                refine.doRefinement1();
            }
            else
            {
                refine.doRefinement();
                if (refine.useZ3Search)
                {
                    Stats.pathVerificationQueries++;
                    Stats.pathVerificationTime += refine.timeTaken;
                }
            }
            ConfigManager.endRefinement();

            refinementState.Pop();

            return true;
        }

        // Does field refinement
        private static bool checkAndRefinePath(PersistentCBAProgram counterexample,
            RefinementState refinementState, out ErrorTrace cexTrace)
        {
            BoogieVerify.setTimeOut(GlobalConfig.getTimeLeft());

            // Check if counterexample is valid
            var success = CBADriver.checkPath(counterexample, counterexample.allVars, out cexTrace);

            if (!success)
            {
                Log.WriteLine("True bug");
                return false;
            }
            else
            {
                Log.WriteLine("False bug");
            }

            cexTrace = null;

            // Compute the new set of tracked variables to rule out this counterexample
            var refine = new GeneralRefinementScheme(new ConcurrentProgVerifier(), counterexample, refinementState);
            refine.doRefinement();

            return true;

        }

        // Returns the set of all global variables in the program, as well as the ones
        // that need to be tracked initially (according to command-line arguments)
        private static HashSet<string> getTrackedVars(Program prog, Configs config)
        {
            var globalVars = BoogieUtil.GetGlobalVariables(prog);
            VarSet allVars = VarSet.GetAllVars(prog);
            HashSet<string> procs = allVars.Procedures;

            if (config.trackAllVars)
            {
                return allVars.Variables;
            }
            else
            {
                // Get wildcard prefixes
                var pref = new HashSet<string>();
                foreach (var v in config.trackedVars)
                {
                    if (v.EndsWith("*"))
                    {
                        pref.Add(v.Substring(0, v.Length - 1));
                    }
                }

                HashSet<string> vs = new HashSet<string>();
                foreach (var x in globalVars)
                {
                    var s = x.Name;
                    if (!LanguageSemantics.isShared(s))
                    {
                        vs.Add(s);
                    }
                    if (config.trackedVars.Contains(s))
                    {
                        vs.Add(s);
                    }
                    foreach (var p in pref)
                    {
                        if (s.StartsWith(p))
                        {
                            vs.Add(s);
                        }
                    }
                }
                return vs;
            }
        }
    }
}
