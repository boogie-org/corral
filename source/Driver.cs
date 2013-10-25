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
    class Driver
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

        static int run(string[] args) 
        {
            ////////////////////////////////////
            // Input and initialization phase
            ////////////////////////////////////

            Configs config = Configs.parseCommandLine(args);
            CommandLineOptions.Install(new CommandLineOptions());

            #region Set global flags
            ////////////////////////////////////////////////////
            // Set global configs

            GlobalConfig.useLocalVariableAbstraction = config.useLocalVariableAbstraction;
            GlobalConfig.genCTrace = config.genCTrace;
            GlobalConfig.useArrayTheory = config.useArrayTheory;
            GlobalConfig.printInstrumented = config.printInstrumented;
            GlobalConfig.instrumentedFile = config.instrumentedFile;
            GlobalConfig.addRaiseException = !config.noRaiseException;
            GlobalConfig.memLimit = config.memLimit;
            GlobalConfig.recursionBound = config.recursionBound;
            GlobalConfig.refinementAlgo = config.refinementAlgo.ToArray();
            GlobalConfig.timeOut = config.timeout;
            GlobalConfig.detectConstantLoops = config.detectConstantLoops;
            GlobalConfig.annotations = config.annotations;
            GlobalConfig.catchAllExceptions = config.catchAllExceptions;
            GlobalConfig.printAllTraces = config.printAllTraces;
            if (config.printData == 0 && config.NonUniformUnfolding)
                config.printData = 1;

            GeneralRefinementScheme.printStats = config.printProgress;
            ContractInfer.runHoudini = !config.summaryComputation;
            GlobalConfig.addInvariants = 1;

            GlobalConfig.cadeTiming = config.cadeTiming;

            BoogieVerify.fwdBck = config.FwdBckSearch;
            BoogieVerify.assertsPassed = config.assertsPassed;
            BoogieVerify.assertsPassedIsInt = config.assertsPassedIsInt;
            BoogieVerify.fwdBckInRef = config.fwdBckInRef;
            BoogieVerify.ignoreAssertMethods = new HashSet<string>(config.ignoreAssertMethods);

            GeneralRefinementScheme.noInitialPruning = !config.useInitialPruning;

            InstrumentationConfig.cooperativeYield = config.cooperativeYield;

            ProgTransformation.TransformationPass.writeAllFiles = false;
            Log.noDebuggingOutput = false;

            config.specialVars.Iter(s => LanguageSemantics.specialVars.Add(s));
            #endregion

            ConfigManager.Initialize(config);

            string boogieOptions = "";
            boogieOptions += config.boogieOpts;

            boogieOptions += "/stratifiedInline:1 /extractLoops ";

            boogieOptions += string.Format("/recursionBound:{0} ", config.recursionBound);

            #region Coverage reporter
            string cr = null;
            if (config.printCoverage > 0)
            {
                cr = System.Environment.GetEnvironmentVariable("POIROT_COVERAGE_REPORTER");
                if (cr == null)
                {
                    throw new UsageError("Must set the environment variable POIROT_COVERAGE_REPORTER to the coverage reporter directory");
                }
                cr = cr + @"\CoverageGraph.exe";
                if (!System.IO.File.Exists(cr))
                {
                    throw new UsageError("Coverage reporter not found at location:" + cr);
                }
            }

            // create a process for displaying coverage information
            Process coverageProcess = null;
            ProcessStartInfo coverageProcessInfo = null;

            if (cr != null)
            {
                coverageProcess = new Process();
                coverageProcessInfo = new ProcessStartInfo();
                coverageProcessInfo.CreateNoWindow = true;
                coverageProcessInfo.FileName = cr;
                coverageProcessInfo.RedirectStandardInput = true;
                coverageProcessInfo.RedirectStandardOutput = true;
                coverageProcessInfo.RedirectStandardError = false;
                coverageProcessInfo.UseShellExecute = false;
                if (config.printCoverage == 2)
                {
                    coverageProcessInfo.Arguments = "interactive";
                }
                coverageProcess.StartInfo = coverageProcessInfo;
                try
                {
                    coverageProcess.Start();
                }
                catch (System.ComponentModel.Win32Exception)
                {
                    coverageProcess.Dispose();
                    coverageProcess = null;
                }
            }
            if (coverageProcess != null)
            {
                CommandLineOptions.Clo.coverageReporter = coverageProcess;
            }
            #endregion

            var startTime = DateTime.Now;

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
            
            if (GlobalConfig.useArrayTheory)
                boogieOptions += " /useArrayTheory";
            else
                boogieOptions += " /useArrayTheory /z3opt:ARRAY_WEAK=true /z3opt:ARRAY_EXTENSIONAL=false ";

            if (config.printBoogieFlags)
                Console.WriteLine("Using Boogie flags: {0}", boogieOptions);

            if (BoogieUtil.InitializeBoogie(boogieOptions))
                throw new InternalError("Cannot initialize Boogie");

            GlobalConfig.corralStartTime = DateTime.Now;

            ////////////////////////////////////
            // Initial program rewriting
            ////////////////////////////////////

            #region initial program rewriting

            var inputProg = GetInputProgram(config);
            if (inputProg == null) return 0;

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
                    elPass = new ExtractLoopsPass();
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

            if (cexTrace != null && !config.noTrace)
            {
                if (elPass != null) cexTrace = elPass.mapBackTrace(cexTrace);
                if (seqInstr != null) cexTrace = seqInstr.mapBackTrace(cexTrace);
                cexTrace = prune.mapBackTrace(cexTrace);
                cexTrace = rcalls.mapBackTrace(cexTrace);

                //PrintProgramPath.print(rcalls.input, cexTrace, "temp0");

                cexTrace = apass.mapBackTrace(cexTrace);

                if (GlobalConfig.genCTrace)
                {
                    PrintConcurrentProgramPath.printCTrace(inputProg, cexTrace, "corral_out");
                }
                else
                {
                    //PrintProgramPath.print(inputProg, cexTrace, "temp0");
                    PrintConcurrentProgramPath.print(inputProg, cexTrace, "corral_out");

                    var init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);
                    PrintConcurrentProgramPath.print(init, cexTrace, config.inputFile);

                }
                
            }

            var endTime = DateTime.Now;

            /////////////////////////////
            // print timing information
            /////////////////////////////
            Stats.printStats();
            Log.WriteLine(string.Format("Number of procedures inlined: {0}", Stats.ProgCallTreeSize));
            Log.WriteLine(string.Format("Number of variables tracked: {0}", refinementState.getVars().Variables.Count));

            //Log.WriteLine(string.Format("Time spent inside refinement class: {0} s", refinementState.timeSpent.TotalSeconds));
            //Log.WriteLine(string.Format("Path verify time1: {0} s", BoogieVerify.tempTime.TotalSeconds));
            //Log.WriteLine(string.Format("Path verify time2: {0} s", VerificationPass.tempTime.TotalSeconds));

            Log.WriteLine(string.Format("Total Time: {0} s", (endTime - startTime).TotalSeconds));

            #region Stats for .NET programs
            if (config.verboseMode > 1)
            {
                Log.WriteLine(string.Format("LOC on trace: {0}", PrintConcurrentProgramPath.LOC));
                // compute number of unique procs inlined
                var procsInlined = BoogieVerify.UniqueProcsInlined();
                procsInlined.Add(config.mainProcName);
                Log.WriteLine(string.Format("Unique procs inlined: {0}", procsInlined.Count));
                var init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);
                ModSetCollector.DoModSetAnalysis(init);
                Log.WriteLine(string.Format("Total number of procs: {0}", init.TopLevelDeclarations.OfType<Implementation>().Count()));
                
                // Compute LOC on inlined procs and non-trivial procs
                var totalLoc = 0;
                var inlinedLoc = 0;

                var nonTrivialProcs = new HashSet<string>();
                var finalVars = new HashSet<string>();
                refinementState.getVars().Variables.Iter(s => { if(s.StartsWith("F$")) finalVars.Add(s); });

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
            #endregion

            Log.Close();

            #region Coverage reporter
            if (coverageProcess != null)
            {
                coverageProcess.StandardInput.WriteLine("done");

                do
                {
                    coverageProcess.WaitForExit(100);
                    coverageProcess.StandardInput.WriteLine();
                } while (!coverageProcess.HasExited);
            }
            #endregion

            return 0;
        }

        private static PersistentCBAProgram GetInputProgram(Configs config)
        {
            // This is to check the input program for parsing and resolution
            // errors. We check for type errors later
            Program init = BoogieUtil.ReadAndOnlyResolve(config.inputFile);

            #region Early exit options
            if (config.unfoldRecursion)
            {
                var urec = new ExtractRecursionPass();
                var ttt = urec.run(new PersistentCBAProgram(init, config.mainProcName, 0));
                ttt.writeToFile("unfolded.bpl");
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
                /*
                CommandLineOptions.Install(new CommandLineOptions());
                CommandLineOptions.Clo.PrintInstrumented = true;
                CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Assume;
                CommandLineOptions.Clo.StratifiedInliningVerbose = config.verboseMode;
                CommandLineOptions.Clo.RunningBoogieFromCommandLine = true;
                CommandLineOptions.Clo.ExpandLambdas = false;
                CommandLineOptions.Clo.Parse(new string[] { "/stratifiedInline:1", "/extractLoops", "/noinfer",
                "/recursionBound:1", "/useArrayTheory", "/vc:i",
                "/z3opt:ARRAY_WEAK=true", "/z3opt:ARRAY_EXTENSIONAL=false", "/proverLog:out1"
                });
                ExecutionEngine.printer = new ConsolePrinter();
                //ExecutionEngine.ProcessFiles(new List<string> { config.inputFile }, false);
                //throw new NormalExit("Done");
                init = ExecutionEngine.ParseBoogieProgram(new List<string> { config.inputFile }, false);
                LinearTypechecker lt;
                ExecutionEngine.ResolveAndTypecheck(init, config.inputFile, out lt);
                ExecutionEngine.EliminateDeadVariablesAndInline(init);

                var checkers = new List<Checker>();
                var vcgen = new VC.StratifiedVCGen(init, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, checkers);
                var errors = new List<Counterexample>();
                var outcome = vcgen.VerifyImplementation(BoogieUtil.findProcedureImpl(init.TopLevelDeclarations, "main_SeqInstr"), out errors, "unknown");
                if (errors == null || errors.Count == 0) Console.WriteLine("Verified");
                else Console.WriteLine("Errors");
                throw new NormalExit("Done"); */

                BoogieVerify.options = new BoogieVerifyOptions();
                BoogieVerify.options.NonUniformUnfolding = config.NonUniformUnfolding;
                BoogieVerify.Verify(init, out err);
                if (err == null || err.Count == 0)
                    Console.WriteLine("All entrypoints verified");
                else
                {
                    foreach (var trace in err.OfType<BoogieAssertErrorTrace>())
                    {
                        Console.WriteLine("{0} did not verify", trace.impl.Name);
                        trace.cex.Print(0, Console.Out);
                    }
                }

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
                if (BoogieVerify.fwdBck == 1)
                {
                    Console.WriteLine("Sorry, fwd/bck approach not available for multi-threaded programs. Running fwd approach.");
                    BoogieVerify.fwdBck = 0;
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

            #endregion

            // Add unique ids on calls -- necessary for reusing call trees
            // across stratified inlining queries. The unique ids are used
            // to reliably identify the same procedure calls across queries.
            var addIds = new AddUniqueCallIds();
            addIds.VisitProgram(init);

            // Update mod sets
            ModSetCollector.DoModSetAnalysis(init);

            // Now we can typecheck
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            if (BoogieUtil.TypecheckProgram(init, config.inputFile))
            {
                BoogieUtil.PrintProgram(init, "error.bpl");
                throw new InvalidProg("Cannot typecheck " + config.inputFile);
            }
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            // inline procedures that have that annotation
            InlineProcedures(init);
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

        private static void InlineProcedures(Program program)
        {
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            ExecutionEngine.EliminateDeadVariablesAndInline(program);
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
            Debug.Assert(config.contextBound == 1);
            //GC.AddMemoryPressure(1500 * 1024 * 1024);

            // Save memory by deleting tokens
            ProgTransformation.PersistentProgram.clearTokens = true;

            SetSdvModeOptions(config);
            var progVerifyOptions = ConfigManager.progVerifyOptions;
            var pathVerifyOptions = ConfigManager.pathVerifyOptions;
            var refinementVerifyOptions = ConfigManager.refinementVerifyOptions;

            ProgTransformation.PersistentProgramIO.useDuplicator = true;
            VerificationPass.usePruning = false;

            PersistentCBAProgram inputProg = null;
            if (config.printData == 2)
            {
                // save the input program
                inputProg = new PersistentCBAProgram(program, "", 0);
            }

            var startTime = DateTime.Now;
            var cloopsTime = TimeSpan.Zero;

            // annotate calls with a unique number
            var addIds = new AddUniqueCallIds();
            addIds.VisitProgram(program);

            // Prune mod sets
            ModSetCollector.DoModSetAnalysis(program);
            // Gather the set of initially tracked variables
            var initialTrackedVars = getTrackedVars(program, config);
            // Did we reach the recursion bound?
            var reachedBound = false;

            // Set up refinement state
            var refinementState = new GlobalRefinementState(program, initialTrackedVars);

            // Add a new main (for the assert)
            InsertionTrans mainTrans;
            var newMain = AddFakeMain(program, BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, config.mainProcName), out mainTrans);

            // Capture state
            InsertionTrans captureTrans = new InsertionTrans();
            if (config.printData == 2)
                captureStates(program, out captureTrans);

            if (config.debugMemAccesses)
            {
                CoreLib.RecordMemoryAccesses.Instrument(program, "start_irql", "sdv_irql_current");
                BoogieUtil.PrintProgram(program, "recorded.bpl");
            }

            // Save program; remove source info (because there can be lots of it)
            var programForDefectTrace = (new FixedDuplicator(true)).VisitProgram(program);
            var sinfo = new ModifyTrans();
            if(config.rootCause < 0)
                sinfo = PrintSdvPath.DeleteSourceInfo(program);

            var init = new PersistentCBAProgram(program, newMain, 1);
            var curr = init;

            var passes = new List<CompilerPass>();

            // prune
            PruneProgramPass.RemoveUnreachable = true;
            PruneProgramPass.normalizeStatements = true;
            var prune = new PruneProgramPass();
            curr = prune.run(curr);
            PruneProgramPass.RemoveUnreachable = false;
            passes.Add(prune);

            // extract loops
            if (GlobalConfig.InferPass != null)
            {
                var elPass = new ExtractLoopsPass(true);
                curr = elPass.run(curr);
                CommandLineOptions.Clo.ExtractLoops = false;
                passes.Add(elPass);

                if (GlobalConfig.detectConstantLoops)
                {
                    List<ConstLoop> cloops;
                    curr = PruneConstLoops(curr, out cloops);
                    cloops.Iter(c => cloopsTime += c.lastRun);
                    passes.AddRange(cloops);
                }
            }

            // Delete print commands, so they are not part of the
            // abstraction refinement and SI loop.
            var progWithPrintCmds = curr;
            var currProg = curr.getCBAProgram();
            var printinfo = PrintSdvPath.DeletePrintCmds(currProg);

            var allVars = VarSet.GetAllVars(currProg);
            curr = new PersistentCBAProgram(currProg, curr.mainProcName, curr.contextBound);

            var correct = false;
            var iterCnt = 0;
            var maxInlined = 0;
            VarSet varsToKeep;
            var cLoopHistory = ConstLoopHistory.GetNull();
            ErrorTrace buggyTrace = null;

            // Run refinement loop
            while (true)
            {
                BoogieVerify.refinementRun = false; // D
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
                    if (config.disableStaticAnalysis)
                        ContractInfer.disableStaticAnalysis = true;

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

                    // Infer min. loop bounds
                    var bounds = LoopBound.Compute(abs.getCBAProgram(), config.maxStaticLoopBound);
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

                var cloops = new List<ConstLoop>();
                if (ConstLoop.aggressive)
                {
                    abs = PruneConstLoopsNoCounter(abs, ref cLoopHistory, out cloops);
                    cloops.Iter(c => cloopsTime += c.lastRun);                   
                }

                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                // Check Program
                BoogieVerify.options = progVerifyOptions;
                BoogieVerify.setTimeOut(GlobalConfig.getTimeLeft());

                Console.WriteLine("Verifying program while tracking: {0}", varsToKeep.Variables.Print());
                
                Stats.beginTime();
                var verificationPass = new VerificationPass(true);
                verificationPass.run(abs);
                Stats.endTime(ref Stats.programVerificationTime);

                BoogieVerify.setTimeOut(0);
                maxInlined = (BoogieVerify.CallTreeSize > maxInlined) ? BoogieVerify.CallTreeSize : maxInlined;

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
                cloops.Reverse<ConstLoop>().Iter(c => trace = c.mapBackTrace(trace));
                if (ciPass != null) trace = ciPass.mapBackTrace(trace);
                trace = abstraction.mapBackTrace(trace);

                // Restrict the program to the trace
                var tinfo = new InsertionTrans();
                var traceProgCons = new RestrictToTrace(currProg, tinfo);
                traceProgCons.addTrace(trace);

                var ptrace =
                    new PersistentCBAProgram(traceProgCons.getProgram(),
                        traceProgCons.getFirstNameInstance(curr.mainProcName),
                        curr.contextBound, ConcurrencyMode.AnyInterleaving);

                //////////////////////////
                // Check concrete trace
                //////////////////////////
                BoogieVerify.refinementRun = !BoogieVerify.fwdBckInRef;

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
                        buggyTrace = tinfo.mapBackTrace(pverify.trace);
                    }
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

                ProgTransformation.PersistentProgram.FreeParserMemory();

                //CommandLineOptions.Clo.UseLabels = ul;
            }
            var endTime = DateTime.Now;
            
            Stats.printStats();

            Console.WriteLine("CLoops Time: {0} s", cloopsTime.TotalSeconds.ToString("F2"));
            Console.WriteLine("Num refinements: {0}", iterCnt);
            Console.WriteLine("Number of procedures inlined: {0}", maxInlined);
            Console.WriteLine("Final tracked vars: {0}", varsToKeep.Variables.Print());
            Console.WriteLine("Total Time: {0} s", (endTime - startTime).TotalSeconds.ToString("F2"));

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

                //PrintProgramPath.print(curr, buggyTrace, "temp0");
                var sw = new Stopwatch();
                sw.Start();

                // Bring back print cmds
                buggyTrace = printinfo.mapBackTrace(buggyTrace);

                if (config.rootCause >= 0)
                {
                    // Inline to trace
                    Program rc = progWithPrintCmds.getCBAProgram();
                    InlineToTrace.Inline(rc, buggyTrace);
                    rc = BoogieUtil.ReResolve(rc, "rootcause.bpl");

                    // Inline depth
                    var idepth = CommandLineOptions.Clo.InlineDepth;
                    var ioptions = CommandLineOptions.Clo.ProcedureInlining;

                    CommandLineOptions.Clo.InlineDepth = config.rootCause;
                    CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Assume;
                    InliningPass.InlineToDepth(rc);
                    
                    CommandLineOptions.Clo.InlineDepth = idepth;
                    CommandLineOptions.Clo.ProcedureInlining = ioptions;

                    // Remove extra impls
                    rc.TopLevelDeclarations = rc.TopLevelDeclarations.Filter(decl =>
                        !(decl is Implementation) || QKeyValue.FindBoolAttribute((decl as Implementation).Attributes, "entrypoint"));

                    // change "assert dup_var" to "if(dup_var) { assert false }"
                    var impl = rc.TopLevelDeclarations.OfType<Implementation>().FirstOrDefault();
                    Debug.Assert(impl != null && QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));
                    //   Find the assert
                    var nblks = new List<Block>();
                    foreach (var blk in impl.Blocks)
                    {
                        if (blk.Cmds.OfType<AssertCmd>().All(BoogieUtil.isAssertTrue))
                        {
                            nblks.Add(blk);
                            continue;
                        }

                        // Found the assert, now let's break it into an if-branch
                        var lab1 = "at$block$new1";
                        var lab2 = "at$block$new2";
                        var lab3 = "at$block$new3";

                        var ncmds = new List<Cmd>();
                        foreach (var cmd in blk.Cmds.OfType<Cmd>())
                        {
                            var acmd = cmd as AssertCmd;
                            if (acmd != null && !BoogieUtil.isAssertTrue(acmd))
                            {
                                var expr = acmd.Expr;
                                // finish current block
                                var currBlock = new Block(Token.NoToken, blk.Label, ncmds, BoogieAstFactory.MkGotoCmd(lab1, lab2));
                                nblks.Add(currBlock);

                                var blk1 = new Block(Token.NoToken, lab1, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(lab3));
                                var blk2 = new Block(Token.NoToken, lab2, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(lab3));

                                blk1.Cmds.Add(BoogieAstFactory.MkAssume(Expr.Not(expr)));
                                blk1.Cmds.Add(BoogieAstFactory.MkAssert(Expr.False));

                                blk2.Cmds.Add(BoogieAstFactory.MkAssume(expr));

                                nblks.Add(blk1);
                                nblks.Add(blk2);

                                ncmds = new List<Cmd>();
                            }
                            else
                            {
                                ncmds.Add(cmd);
                            }
                        }

                        nblks.Add(new Block(Token.NoToken, lab3, ncmds, blk.TransferCmd));                        
                    }
                    impl.Blocks = nblks;

                    // delete "assert {:sourcefile "?"} true;"
                    foreach (var im in rc.TopLevelDeclarations.OfType<Implementation>())
                    {
                        foreach (var blk in im.Blocks)
                        {
                            var FilterCmd = new Predicate<Cmd>(cmd =>
                                BoogieUtil.isAssertTrue(cmd) &&
                                QKeyValue.FindStringAttribute((cmd as AssertCmd).Attributes, "sourcefile") != null &&
                                QKeyValue.FindStringAttribute((cmd as AssertCmd).Attributes, "sourcefile") == "?"
                                );
                            blk.Cmds = new List<Cmd>(blk.Cmds.OfType<Cmd>().Where(cmd => !FilterCmd(cmd)).ToArray());
                        }
                    }

                    BoogieUtil.PrintProgram(rc, "rootcause.bpl");
                }

                // Restrict the program to the trace
                var tinfo = new InsertionTrans();
                var traceProgCons = new RestrictToTrace(progWithPrintCmds.getCBAProgram(), tinfo);
                traceProgCons.addTrace(buggyTrace);
                var tprog = traceProgCons.getProgram();
                var witness = new PersistentCBAProgram(tprog, traceProgCons.getFirstNameInstance(newMain), 0);

                // make sure variables to record are scalar and globals
                var toRecord = new HashSet<string>();
                tprog.TopLevelDeclarations.OfType<Variable>()
                    .Where(g => config.recordValues.Contains(g.Name) && g.TypedIdent.Type.IsBasic)
                    .Iter(g => toRecord.Add(g.Name));

                // Query Z3, asking for values
                if (config.useProverEvaluate)
                    ConfigManager.pathVerifyOptions.UseProverEvaluate = true;
                else
                    ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = false;

                Console.Write("Generating data values ...");
                BoogieVerify.options = ConfigManager.pathVerifyOptions;
                var getValuePass = new VerificationPass(true, toRecord);
                getValuePass.run(witness);
                
                if (!getValuePass.success)
                {
                    buggyTrace = tinfo.mapBackTrace(getValuePass.trace);
                    Console.WriteLine("Done");
                    //PrintProgramPath.print(progWithPrintCmds, buggyTrace, "temp1");
                }
                else
                {
                    // something went wrong; ignore silently
                    Console.WriteLine("Failed");
                }

                var aliasingExplanation = "";

                try
                {
                    if (config.explainError > 0)
                    {
                        // Annotate program
                        tprog = witness.getCBAProgram();
                        sdvAnnotateDefectTrace(tprog, config);
                        witness = new PersistentCBAProgram(tprog, traceProgCons.getFirstNameInstance(newMain), 0);

                        BoogieVerify.options = ConfigManager.pathVerifyOptions;
                        var concretize = new SDVConcretizePathPass();
                        witness = concretize.run(witness);

                        if (concretize.success)
                        {
                            // Something went wrong, fail silently
                            throw new NormalExit("ExplainError set up failed");
                        }

                        if (config.explainError > 1)
                            witness.writeToFile("corral_witness.bpl");

                        tprog = witness.getCBAProgram();

                        ExplainError.STATUS status;
                        Dictionary<string, string> complexObj;

                        var explain = ExplainError.Toplevel.Go(tprog.TopLevelDeclarations.OfType<Implementation>()
                            .Where(impl => impl.Name == witness.mainProcName).FirstOrDefault(), tprog, config.explainErrorTimeout, config.explainErrorFilters,
                            out status, out complexObj);
                        
                        if (status == ExplainError.STATUS.TIMEOUT)
                        {
                            Console.WriteLine("ExplainError timed out");
                            aliasingExplanation = "^====Pre=====^___(Timeout)";
                        }
                        else if (status != ExplainError.STATUS.SUCCESS)
                        {
                            Console.WriteLine("ExplainError didn't return SUCCESS");
                            aliasingExplanation = "^====Pre=====^___(Inconclusive)";
                        }

                        if (status == ExplainError.STATUS.SUCCESS && explain.Count > 0)
                        {
                            aliasingExplanation = "^====Pre=====";

                            // gather all constants that represent memory addresses
                            var allocConstants = new HashSet<string>();
                            var allocRe = new System.Text.RegularExpressions.Regex(@"\b(alloc_\d*)\b");
                            var gatherAllocConstants = new Action<string>(s =>
                                {
                                    var matches = allocRe.Match(s);
                                    if (matches.Success)
                                        for (int ai = 1; ai < matches.Groups.Count; ai++)
                                            allocConstants.Add(matches.Groups[ai].Value);

                                });

                            for (int i = 0; i < explain.Count; i++)
                            {
                                if (i == 0) aliasingExplanation += "^____";
                                else aliasingExplanation += "^or__";
                                gatherAllocConstants(explain[i]);

                                aliasingExplanation += explain[i].TrimEnd(' ', '\t').Replace(' ', '_').Replace("\t", "_and_");
                            }

                            if (complexObj.Any())
                            {
                                aliasingExplanation += "^where";
                                foreach (var tup in complexObj)
                                {
                                    gatherAllocConstants(tup.Key);
                                    var str = string.Format("   {0} = {1}", tup.Value, tup.Key);
                                    aliasingExplanation += "^" + str.Replace(' ', '_');
                                }
                            }
                            foreach (var s in allocConstants.Where(a => concretize.allocConstants.ContainsKey(a)))
                            {
                                var str = string.Format("^   {0} was allocated in {1}", s, concretize.allocConstants[s]);
                                Console.WriteLine("{0}", str);
                                aliasingExplanation += str.Replace(' ', '_');
                            }
                        }

                    }
                }
                catch (Exception e)
                {
                    // Fail silently
                    aliasingExplanation = "";
                    Console.WriteLine("ExplainError failed: {0}", e.Message);
                }

                sw.Stop();
                Console.WriteLine("Data value generation took: {0} s", sw.Elapsed.TotalSeconds.ToString("F2"));

                passes.Reverse<CompilerPass>()
                                   .Iter(cp => buggyTrace = cp.mapBackTrace(buggyTrace));

                buggyTrace = sinfo.mapBackTrace(buggyTrace);

                if (config.printData == 2)
                {
                    var bugT = buggyTrace.Copy();
                    //PrintProgramPath.print(init, bug, "temp0");

                    bugT = captureTrans.mapBackTrace(bugT);
                    bugT = mainTrans.mapBackTrace(bugT);
                    // knock off fakeMain
                    ErrorTrace tempt = null;
                    bugT.Blocks.Iter(blk =>
                        {
                            var cmain = blk.Cmds.OfType<CallInstr>().Where(ci => ci.callee == config.mainProcName).FirstOrDefault();
                            if (cmain != null) tempt = cmain.calleeTrace;
                        });
                    bugT = tempt;
                    PrintProgramPath.print(inputProg, bugT, "input");

                    PrintSdvPath.PrintStackTrace(inputProg.getCBAProgram(), bugT, "defect.stktrace");

                    //serialize the buggyTrace
                    BinaryFormatter serializer = new BinaryFormatter();
                    FileStream stream = new FileStream("buggyTrace.serialised", FileMode.Create, FileAccess.Write, FileShare.None);
                    serializer.Serialize(stream, bugT);
                    stream.Close();
                }

                //var ttpp = new PersistentCBAProgram(programForDefectTrace, config.mainProcName, 0);
                //PrintProgramPath.print(ttpp, buggyTrace, "temp2");

                PrintSdvPath.Print(programForDefectTrace, buggyTrace, toRecord, aliasingExplanation, "defect.tt", "stack.txt");
                var am = new TokenTextWriter("defect.txt");
                var message = PrintSdvPath.abortMessage;
                if (message == null) message = "None";
                am.WriteLine(message);
                am.Close();
            }

            Log.Close();
        }

        // Mark "slic" assume statements
        // Insert captureState for driver methods and start
        // Mark "indirect" call assume statements
        private static void sdvAnnotateDefectTrace(Program trace, Configs config)
        {
            var slicVars = new HashSet<string>(config.trackedVars);
            slicVars.Remove("alloc");

            var isSlicExpr = new Predicate<Expr>(expr =>
                {
                    var vused = new VarsUsed();
                    vused.VisitExpr(expr);
                    if (vused.varsUsed.Any(v => slicVars.Contains(v)))
                        return true;
                    return false;
                });
            var isSlicAssume = new Func<AssumeCmd, Implementation, bool>((ac, impl) =>
                {
                    if (impl.Name.Contains("SLIC_") || impl.Name.Contains("sdv_")) return true;
                    if (isSlicExpr(ac.Expr)) return true;
                    return false;
                });
            var tagAssume = new Action<AssumeCmd, Implementation>((ac, impl) =>
                {
                    if (isSlicAssume(ac, impl)) ac.Attributes =
                          new QKeyValue(Token.NoToken, "slic", new List<object>(), ac.Attributes);
                });

            var isDriverImpl = new Predicate<Implementation>(impl =>
                {
                    return !impl.Name.Contains("sdv") && !impl.Name.Contains("SLIC");
                });


            foreach (var impl in trace.TopLevelDeclarations
                .OfType<Implementation>())
            {
                // Tag entry points of the driver
                if (isDriverImpl(impl))
                {
                    var ac = new AssumeCmd(Token.NoToken, Expr.True);
                    ac.Attributes = new QKeyValue(Token.NoToken, "captureState", new List<object>(), null);
                    ac.Attributes.Params.Add(impl.Name);

                    var nc = new List<Cmd>();
                    nc.Add(ac);
                    nc.AddRange(impl.Blocks[0].Cmds);
                    impl.Blocks[0].Cmds = nc;
                }

                // Insert "slic" annotation
                impl.Blocks.Iter(blk =>
                    blk.Cmds.OfType<AssumeCmd>()
                    .Iter(cmd => tagAssume(cmd, impl)));

                // Insert "indirect" annotation
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count - 1; i++)
                    {
                        var c1 = blk.Cmds[i] as AssumeCmd;
                        var c2 = blk.Cmds[i + 1] as AssumeCmd;
                        if (c1 == null || c2 == null) continue;
                        if (!QKeyValue.FindBoolAttribute(c1.Attributes, "IndirectCall")) continue;
                        c2.Attributes = new QKeyValue(Token.NoToken, "indirect", new List<object>(), c2.Attributes);
                    }
                }

                // Start captureState
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<AssumeCmd>()
                        .Where(ac => QKeyValue.FindBoolAttribute(ac.Attributes, "mainInitDone"))
                        .Iter(ac => { ac.Attributes = new QKeyValue(Token.NoToken, "captureState", new List<object>(new string[] { "Start" }), ac.Attributes); });
                }
            }
                
            // Mark malloc
            foreach (var impl in trace.TopLevelDeclarations
                .OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        ncmds.Add(cmd);

                        var ccmd = cmd as CallCmd;
                        if (ccmd == null || !ccmd.callee.Contains("HAVOC_malloc"))
                            continue;
                        var ac = new AssertCmd(Token.NoToken, Expr.True);
                        ac.Attributes = new QKeyValue(Token.NoToken, "malloc", new List<object>(), null);
                        ncmds.Add(ac);
                    }
                    blk.Cmds = ncmds;
                }
            }


                
        }

        private static void SetSdvModeOptions(Configs config)
        {
            ConfigManager.Initialize(config);

            // program options
            ConfigManager.progVerifyOptions.UseProverEvaluate = false;
            ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
            if (config.NonUniformUnfolding)
                    ConfigManager.progVerifyOptions.UseProverEvaluate = true;

            // path options
            ConfigManager.pathVerifyOptions.UseProverEvaluate = false;
            ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
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

                        var acmd = cmd as AssertCmd;
                        if (acmd == null) continue;

                        if (QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile") != null)
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

            program.TopLevelDeclarations.Add(newMainProc);
            program.TopLevelDeclarations.Add(newMainImpl);

            return newMainImpl.Name;
        }


        private static PersistentCBAProgram PruneConstLoops(PersistentCBAProgram prog, out List<ConstLoop> cloops)
        {
            cloops = new List<ConstLoop>();
            var noTry = new HashSet<string>();

            var noTryFunc = new Func<Implementation, int>(impl =>
                {
                    if (noTry.Contains(impl.Name)) return 0;
                    return 2;
                });

            while (true)
            {
                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                var cloop = new ConstLoop(noTryFunc);
                prog = cloop.run(prog);
                cloops.Add(cloop);

                noTry.UnionWith(cloop.currHistory.semanticallyFailedLoops);
                noTry.UnionWith(cloop.currHistory.globalsUsed.Keys);
                
                if (cloop.cLoops.Count == 0) break;
                if (!ConstLoop.aggressive) break;
            }

            return prog;
        }

        private static PersistentCBAProgram PruneConstLoopsNoCounter(
            PersistentCBAProgram prog, ref ConstLoopHistory history, out List<ConstLoop> cloops)
        {
            cloops = new List<ConstLoop>();
            var noTry = new HashSet<string>();
            var inHistory = history;
            var outHistory = new ConstLoopHistory();

            var summary = new Func<Implementation, int>(impl =>
            {
                if (noTry.Contains(impl.Name)) return 0;
                if (inHistory.definiteFail(impl)) return 0;
                if (inHistory.definiteSuccess(impl)) return 1;
                return 2;
            });

            var constLoopsFound = new HashSet<string>();

            while (true)
            {
                var cloop = new ConstLoop(true, false, summary);
                prog = cloop.run(prog);
                cloops.Add(cloop);

                noTry.UnionWith(cloop.currHistory.semanticallyFailedLoops);
                noTry.UnionWith(cloop.currHistory.globalsUsed.Keys);

                outHistory.staticallyFailedLoops = cloop.currHistory.staticallyFailedLoops;
                outHistory.semanticallyFailedLoops.UnionWith(cloop.currHistory.semanticallyFailedLoops);
                cloop.currHistory.globalsUsed.Iter(kvp =>
                    outHistory.globalsUsed.Add(kvp.Key, kvp.Value));

                constLoopsFound.UnionWith(cloop.cLoops);
                if (cloop.cLoops.Count == 0) break;
                if (!ConstLoop.aggressive) break;
            }

            outHistory.semanticallyFailedLoops.UnionWith(inHistory.semanticallyFailedLoops);
            foreach (var c in constLoopsFound)
            {
                if (!outHistory.globalsUsed.ContainsKey(c) &&
                    inHistory.globalsUsed.ContainsKey(c))
                {
                    outHistory.globalsUsed.Add(c, inHistory.globalsUsed[c]);
                }
            }

            history = outHistory;
            return prog;
        }

        private static HashSet<string> findTemplates(Program program, Configs config)
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

            program.TopLevelDeclarations = newDecls;
            ContractInfer.runAbsHoudiniConfig = config.runAbsHoudini;
            GlobalConfig.InferPass = new ContractInfer(templateVarNames, req, ens, config.runHoudini, -1);
            return extra;
        }

        // For debugging (printing abstract traces)
        static int traceCounterDbg = 0;

        // Check program "inputProg" using variable abstraction
        private static bool checkAndRefine(PersistentCBAProgram prog, RefinementState refinementState, Action<ErrorTrace, string> printTrace, out ErrorTrace cexTrace)
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
                BoogieVerify.refinementRun = false; // D
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
                BoogieVerify.refinementRun = !BoogieVerify.fwdBckInRef;

                if (GlobalConfig.printAllTraces)
                {
                    printTrace(cexTrace, "corral_out" + traceCounterDbg.ToString());
                    traceCounterDbg++;
                }

                if (!lightweight) counterexample.mode = ConcurrencyMode.AnyInterleaving;

                refinementState.Add(new TraceMapping(tinfo));
                
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
            List<GlobalVariable> globalVars = BoogieUtil.GetGlobalVariables(prog);
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
