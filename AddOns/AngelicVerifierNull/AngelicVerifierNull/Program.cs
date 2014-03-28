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

    class Driver
    {
        static cba.Configs corralConfig;

        const string CORRAL_MAIN_PROC = "CorralMain";

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: AngelicVerifierNull file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            // Initialize Boogie and Corral
            corralConfig = InitializeCorral();

            PersistentProgram prog = null;
            try
            {
                // Get input program with the harness
                prog = GetProgram(args[0]);
            }
            catch (InputProgramDoesNotMatchExn e)
            {
                Console.WriteLine("Input program does not satisfy sanity checks" + e.Message);
            }

            // Run Corral outer loop
            RunCorralIterative(prog, corralConfig.mainProcName);
        }

        // Initialization
        static cba.Configs InitializeCorral()
        {
            // 
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // Set all defaults for corral
            var config = cba.Configs.parseCommandLine(new string[] { "doesntExist.bpl" });
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

        //Run Corral over different assertions (modulo errorLimit)
        private static void RunCorralIterative(PersistentProgram prog, string p)
        {
            //We are not using the guards to turn the asserts, we simply rewrite the assert
            while (true)
            {
                var cex = RunCorral(prog, corralConfig.mainProcName);
                if (cex == null)
                {
                    //TODO (how do I distinguish inconclusive results)
                    Console.WriteLine("No more counterexamples found, Corral returns verified...");
                    break;
                }
                var nprog = prog.getProgram();
                var ret = SupressFailingAssert(nprog, cex.Item2);

                if (ret == null)
                {
                    Console.WriteLine("Failure is not an assert, skipping...");
                    Debug.Assert(false);
                    continue;
                }
                else
                {
                    Console.WriteLine("Assertion failed at line {0} with expr {1}", ret.Line, ret.ToString());
                }

                prog = new PersistentProgram(nprog, corralConfig.mainProcName, 1);
            }

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

        // Run Corral on a sequential Boogie Program
        // Returns the error trace and the failing assert location
        static Tuple<cba.ErrorTrace, cba.AssertLocation> RunCorral(PersistentProgram inputProg, string main)
        {
            Debug.Assert(cba.GlobalConfig.isSingleThreaded);
            Debug.Assert(cba.GlobalConfig.InferPass == null);

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

            var refinementState = new cba.RefinementState(curr, new HashSet<string>(corralConfig.trackedVars.Union(new string [] {seqInstr.assertsPassedName})), false);

            cba.ErrorTrace cexTrace = null;
            cba.Driver.checkAndRefine(curr, refinementState, printTrace, out cexTrace);

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
        
        static PersistentProgram GetProgram(string filename)
        {
            Program init = BoogieUtil.ReadAndOnlyResolve(filename);

            //Sanity check (currently most of it happens inside HarnessInstrumentation)
            CheckInputProgramRequirements(init); 

            //Instrument to create the harness
            corralConfig.mainProcName = CORRAL_MAIN_PROC;
            (new Instrumentations.HarnessInstrumentation(init, corralConfig.mainProcName)).DoInstrument();

            //resolve+typecheck wo bothering about modSets
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            init = BoogieUtil.ReResolve(init);
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            // Update mod sets
            ModSetCollector.DoModSetAnalysis(init);

            //TODO: Perform alias analysis here and prune a subset of asserts

            //Various instrumentations on the well-formed program
            (new Instrumentations.MallocInstrumentation(init)).DoInstrument();
            (new Instrumentations.AssertGuardInstrumentation(init)).DoInstrument();

            //Print the instrumented program
            BoogieUtil.PrintProgram(init, "corralMain.bpl");

            //Do corral specific passes
            GlobalCorralSpecificPass(init);
            var inputProg = new PersistentProgram(init, corralConfig.mainProcName, 1);
            ProgTransformation.PersistentProgram.FreeParserMemory();

            return inputProg;
        }

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
            var addIds = new cba.AddUniqueCallIds();
            addIds.VisitProgram(init);
        }

        // Given an ordinary looking program, massage it to
        // satisfy preconditions for an alias analysis
        static PersistentProgram SetupAliasAnalysis(PersistentProgram program)
        {
            // TODO
            return program;
        }


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

            var ret =
              AliasAnalysis.AliasAnalysis.DoAliasAnalysis(program);

            foreach (var tup in ret)
                Console.WriteLine("{0}: {1}", tup.Key, tup.Value);

            var origProgram = inp.getProgram();
            AliasAnalysis.PruneAliasingQueries.Prune(origProgram, ret);

            return new PersistentProgram(origProgram, inp.mainProcName, inp.contextBound);
        }
    }
}
