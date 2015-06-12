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
using AvUtil;

namespace AvHarnessInstrumentation
{
    class Options
    {
        // Don't use alias analysis
        public static bool UseAliasAnalysisForAssertions = true;
        // Don't use alias analysis for deadcode
        public static bool UseAliasAnalysisForAngelicAssertions = true;
        // Don't use context and flow sensitive alias analysis
        public static bool UseCSFSAliasAnalysis = false;
        // Do Houdini pass to remove some assertions
        public static bool HoudiniPass = false;
        // Add unsound options for NULL
        public static bool AddMapSelectNonNullAssumptions = false;
        // Use field non-null assumption
        public static bool FieldNonNull = true;
        // use procs tagged as {:harness} as potential entrypoints as well
        public static bool useHarnessTag = false;
        // property: nonnull, typestate
        public static string propertyChecked = "";
        // Use only provided entrypoints
        public static bool useProvidedEntryPoints = false;
        // do deadcode detection
        public static bool deadCodeDetect = false;
        // allocate parameters for procedures
        public static bool allocateParameters = true; 
        // add initializations for uninitialized local variables and output parameters
        public static bool addInitialization = false;
    }

    class Driver
    {
        // Globals
        static Dictionary<int, HashSet<int>> DeadCodeBranchesDependencyInfo = null; // unknown -> set of affected branches
        static Instrumentations.HarnessInstrumentation harnessInstrumentation = null;
        static string local_initialization = "LocalInitialization"; // attribute for initialization of local variables
        static string out_initialization = "OutParamInitialization"; // attribute for initialization of output parameters

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

        public static Program GetInputProgram(string filename, string stubs)
        {
            Program init = BoogieUtil.ParseProgram(filename);
            //Instrumentations.RemoveAssertNonNull ra = new Instrumentations.RemoveAssertNonNull();
            //BoogieUtil.PrintProgram(ra.VisitProgram(init), "noassert.bpl");
            //Sanity check (currently most of it happens inside HarnessInstrumentation)
            CheckInputProgramRequirements(init);

            // Adding impl for stubs
            if (stubs != null)
            {
                try
                {
                    Program stubProg = BoogieUtil.ParseProgram(stubs);

                    var procs = new Dictionary<string, Procedure>();
                    init.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procs.Add(proc.Name, proc));

                    var impls = new HashSet<string>();
                    init.TopLevelDeclarations.OfType<Implementation>().Iter(impl => impls.Add(impl.Name));

                    foreach (var impl in stubProg.TopLevelDeclarations.OfType<Implementation>())
                    {
                        // Add the model if there is a procedure declaration but no implementation
                        if (procs.ContainsKey(impl.Name) && !impls.Contains(impl.Name))
                        {
                            init.AddTopLevelDeclaration(impl);
                            //impl.Proc = procs[impl.Name];
                        }
                    }


                }
                catch (System.IO.FileNotFoundException)
                {
                    Utils.Print(string.Format("Stub file not found : {0}", stubs));
                }
            }

            init.Resolve();

            return init;
        }

        static HashSet<string> GetReadVars(Cmd cmd)
        {
            if (cmd is PredicateCmd)
            {
                var expr = (cmd as PredicateCmd).Expr;
                var vu = new VarsUsed();
                vu.VisitExpr(expr);
                return vu.localsUsed;
            }
            else if (cmd is AssignCmd)
            {
                var ret = new HashSet<string>();
                var acmd = cmd as AssignCmd;

                foreach (var expr in acmd.Rhss)
                {
                    var vu = new VarsUsed();
                    vu.VisitExpr(expr);
                    vu.localsUsed.Iter(v => ret.Add(v));
                }

                foreach (var lhs in acmd.Lhss)
                {
                    if (lhs is MapAssignLhs)
                    {
                        var mlhs = lhs as MapAssignLhs;

                        foreach (var expr in mlhs.Indexes)
                        {
                            var vu = new VarsUsed();
                            vu.VisitExpr(expr);
                            vu.localsUsed.Iter(v => ret.Add(v));
                        }
                    }
                }

                return ret;
            }
            else if (cmd is CallCmd)
            {
                var ret = new HashSet<string>();
                var ccmd = cmd as CallCmd;

                foreach (var expr in ccmd.Ins)
                {
                    var vu = new VarsUsed();
                    vu.VisitExpr(expr);
                    vu.localsUsed.Iter(v => ret.Add(v));
                }

                return ret;
            }
            else
            {
                Console.WriteLine("Unable to process cmd - neither predicate, nor assign or call");
                throw new NotImplementedException();
            }
        }

        static HashSet<string> GetWriteVars(Cmd cmd)
        {
            if (cmd is PredicateCmd)
            {
                return new HashSet<string>();
            }
            else if (cmd is AssignCmd)
            {
                var ret = new HashSet<string>();
                var acmd = cmd as AssignCmd;

                foreach (AssignLhs lhs in acmd.Lhss)
                {
                    if (lhs.DeepAssignedVariable is LocalVariable) ret.Add(lhs.DeepAssignedVariable.Name);
                }

                return ret;
            }
            else if (cmd is CallCmd)
            {
                var ret = new HashSet<string>();
                var ccmd = cmd as CallCmd;

                foreach (var expr in ccmd.Outs)
                {
                    if (expr.Decl is LocalVariable) ret.Add(expr.Decl.Name);
                }

                return ret;
            }
            else
            {
                Console.WriteLine("Unable to process cmd - neither predicate, nor assign or call");
                throw new NotImplementedException();
            }
        }

        static void ComputeandInitializeUninitializedLocals(Program program)
        {
            var mallocFull = FindMalloc(program);

            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.ComputePredecessorsForBlocks(); // will be used for uninitialized variable analysis

                // set of local variables in implementation
                HashSet<string> locVars = new HashSet<string>(impl.LocVars.Where(v => !v.TypedIdent.Type.IsMap).Select(v => v.Name));
                
                // we will initialize these variables in the end
                HashSet<string> uninitializedVars = new HashSet<string>();

                // will be used to perform fixed point iteration on blocks, CFG traversal is DFS
                Dictionary<string, bool> changedBlocks = new Dictionary<string, bool>();
                impl.Blocks.Iter(b => changedBlocks[b.Label] = false);

                // blk -> variables uninitialized at the end of blk
                Dictionary<string, HashSet<string>> LIVE_out = new Dictionary<string, HashSet<string>>();
                impl.Blocks.Iter(b => LIVE_out[b.Label] = new HashSet<string>());

                Block entry = impl.Blocks[0];

                Func<Cmd, HashSet<string>, HashSet<string>> ProcessCmd = new Func<Cmd, HashSet<string>, HashSet<string>>((cmd, variables) =>
                {
                    HashSet<string> readVars = GetReadVars(cmd);
                    HashSet<string> writeVars = GetWriteVars(cmd);

                    // variable being read before written
                    readVars.IntersectWith(variables);
                    uninitializedVars.UnionWith(readVars);

                    // remove written variables from variables
                    variables.ExceptWith(writeVars);

                    return variables;
                });

                Action<Block> ProcessBlock = new Action<Block>(b =>
                {
                    var live_vars = new HashSet<string>();

                    // taking union of all predecessors
                    if (b.Label.Equals(entry.Label))
                    {
                        locVars.Iter(v => live_vars.Add(v));
                    }
                    else b.Predecessors.Iter(block => live_vars.UnionWith(LIVE_out[block.Label]));

                    foreach (Cmd c in b.Cmds)
                    {
                        live_vars = ProcessCmd(c, live_vars);
                    }

                    if (!live_vars.SetEquals(LIVE_out[b.Label])) changedBlocks[b.Label] = true;
                    else changedBlocks[b.Label] = false;

                    LIVE_out[b.Label] = live_vars;
                });

                Stack<Block> blockList = new Stack<Block>();
                blockList.Push(entry);

                while (blockList.Count > 0)
                {
                    var blk = blockList.Pop();
                    
                    ProcessBlock(blk);

                    if (blk.TransferCmd is GotoCmd && changedBlocks[blk.Label])
                    {
                        var gtc = blk.TransferCmd as GotoCmd;
                        foreach (Block succ in gtc.labelTargets)
                        {
                            blockList.Push(succ);
                        }
                    }
                }

                // list of variables to be initialized completed
                IEnumerable<Variable> tobeInitialized = impl.LocVars.Where(v => uninitializedVars.Contains(v.Name));
                tobeInitialized = tobeInitialized.Union(impl.OutParams);

                // now initializing
                List<Cmd> cmds = new List<Cmd>();

                foreach (Variable v in tobeInitialized)
                {
                    Cmd cmd = AllocatePointerAsUnknown(mallocFull, v);
                    cmds.Add(cmd);
                }

                Block init = new Block(Token.NoToken, "init", cmds, new GotoCmd(Token.NoToken, new List<Block> { entry }));

                List<Block> newblocks = new List<Block>();
                newblocks.Add(init);
                impl.Blocks.Iter(blk => newblocks.Add(blk));

                impl.Blocks = newblocks;
            }
        }

        private static Cmd AllocatePointerAsUnknown(Procedure mallocProcedureFull, Variable x)
        {
            var cc = BoogieAstFactory.MkCall(mallocProcedureFull,
                    new List<Expr>() { new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ONE) },
                    new List<Variable>() { x }) as CallCmd;
            cc.Attributes = new QKeyValue(Token.NoToken, x is LocalVariable? local_initialization : out_initialization, new List<object> { x.Name }, cc.Attributes);
            return cc;
        }

        private static Procedure FindMalloc(Program prog)
        {
            Procedure mallocProcedure = null, mallocProcedureFull = null;

            //find the malloc and malloc-full procedures
            foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
            {
                var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                if (attr == null) mallocProcedure = proc;
                else if (attr == "full") mallocProcedureFull = proc;
            }

            if (mallocProcedureFull == null)
            {
                throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator \"full\"} declared in the input program");
            }

            return mallocProcedureFull;
        }

        static Program GetProgram(string filename, string stubsfile)
        {
            var init = GetInputProgram(filename, stubsfile);

            if (Options.addInitialization) ComputeandInitializeUninitializedLocals(init);

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
            harnessInstrumentation = new Instrumentations.HarnessInstrumentation(init, AvnAnnotations.CORRAL_MAIN_PROC, Options.useProvidedEntryPoints);
            harnessInstrumentation.DoInstrument();

            //resolve+typecheck wo bothering about modSets
            CommandLineOptions.Clo.DoModSetAnalysis = true;
            init = BoogieUtil.ReResolve(init);
            CommandLineOptions.Clo.DoModSetAnalysis = false;

            // Update mod sets
            BoogieUtil.DoModSetAnalysis(init);

            if (Options.AddMapSelectNonNullAssumptions)
                (new Instrumentations.AssertMapSelectsNonNull()).Visit(init);

            BoogieUtil.pruneProcs(init, AvnAnnotations.CORRAL_MAIN_PROC);

            if (Options.deadCodeDetect || Options.propertyChecked == "nonnull")
            {
                // Tag branches as reachable
                var tup = InstrumentBranches.Run(init, AvnAnnotations.CORRAL_MAIN_PROC, Options.UseAliasAnalysisForAngelicAssertions, false);
                init = tup.Item1;
                // TODO: inject this information into the program itself
                DeadCodeBranchesDependencyInfo = tup.Item2;
            }

            return init;
        }


        static void Main(string[] args)
        {
            if (args.Length < 2 || !args[0].EndsWith(".bpl") || !args[1].EndsWith(".bpl"))
            {
                Console.WriteLine("Usage: AvHarnessInstrumentation infile.bpl outfile.bpl [options]");
                return;
            }

            string stubsfile = null;

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/noAllocation"))
                Options.allocateParameters = false;

            if (args.Any(s => s == "/noAA"))
            {
                Options.UseAliasAnalysisForAssertions = false;
                Options.UseAliasAnalysisForAngelicAssertions = false;
            }

            if (args.Any(s => s == "/noAA:0"))
                Options.UseAliasAnalysisForAngelicAssertions = false;

            if (args.Any(s => s == "/noAA:1"))
                Options.UseAliasAnalysisForAssertions = false;

            if (args.Any(s => s == "/CSFSAA"))
                Options.UseCSFSAliasAnalysis = true;

            if (args.Any(s => s == "/houdini"))
                Options.HoudiniPass = true;

            if (args.Any(s => s == "/useEntryPoints"))
                Options.useProvidedEntryPoints = true;

            if (args.Any(s => s == "/deadCodeDetection"))
                Options.deadCodeDetect = true;

            if (args.Any(s => s == "/useHarness"))
                Options.useHarnessTag = true;

            if (args.Any(s => s == "/UseUnsoundMapSelectNonNull"))
                Options.AddMapSelectNonNullAssumptions = true;

            if (args.Any(s => s == "/addInitialization"))
                Options.addInitialization = true;

            args.Where(s => s.StartsWith("/property:"))
                .Iter(s => Options.propertyChecked = s.Substring("/property:".Length));

            args.Where(s => s.StartsWith("/stubPath:"))
                .Iter(s => stubsfile = s.Substring("/stubPath:".Length));

            // Initialize Boogie
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            ProgTransformation.PersistentProgramIO.useDuplicator = true;

            var sw = new Stopwatch();

            try
            {
                // Get the program, install the harness and do basic instrumentation
                var inprog = GetProgram(args[0], stubsfile);
                var program = new PersistentProgram(inprog, AvnAnnotations.CORRAL_MAIN_PROC, 0);

                Utils.Print(string.Format("#Procs : {0}", inprog.TopLevelDeclarations.OfType<Implementation>().Count()), Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#EntryPoints : {0}", harnessInstrumentation.entrypoints.Count), Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("#Asserts : {0}", AssertCountVisitor.Count(inprog)), Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("InstrumentTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);

                // Run alias analysis
                Stats.resume("alias.analysis");
                Console.WriteLine("Running alias analysis");
                program = RunAliasAnalysis(program);
                Stats.stop("alias.analysis");

                Utils.Print(string.Format("#Asserts : {0}", AssertCountVisitor.Count(program.getProgram())), Utils.PRINT_TAG.AV_STATS);
                Utils.Print(string.Format("InstrumentTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);

                // run Houdini pass
                if (Options.HoudiniPass)
                {
                    Utils.Print("Running Houdini Pass");
                    program = RunHoudiniPass(program);
                    Utils.Print(string.Format("#Asserts : {0}", AssertCountVisitor.Count(program.getProgram())), Utils.PRINT_TAG.AV_STATS);
                    Utils.Print(string.Format("InstrumentTime(ms) : {0}", sw.ElapsedMilliseconds), Utils.PRINT_TAG.AV_STATS);
                }

                program.writeToFile(args[1]);
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
            }
        }


        public static PersistentProgram RunHoudiniPass(PersistentProgram prog)
        {
            Stats.resume("houdini");
            
            HashSet<Variable> templateVars = new HashSet<Variable>();
            List<Requires> reqs = new List<Requires>();
            List<Ensures> enss = new List<Ensures>();
            SimpleHoudini houdini = new SimpleHoudini(templateVars, reqs, enss, -1, -1);
            houdini.ExtractLoops = true;
            SimpleHoudini.fastRequiresInference = false;
            //SimpleHoudini.checkAsserts = true;
            houdini.printHoudiniQuery = null; // "candidates.bpl";
            // turnning on several switches: InImpOutNonNull + InNonNull infer most assertions
            houdini.InImpOutNonNull = false;
            houdini.InImpOutNull = false;
            houdini.InNonNull = false;
            houdini.OutNonNull = false;
            houdini.addContracts = false;

            prog.writeToFile("beforeHoudini.bpl");
            PersistentProgram newP = houdini.run(prog);
            newP.writeToFile("afterHoudini.bpl");

            //BoogieUtil.PrintProgram(newP.getProgram(), "afterHoudini.bpl");
            Utils.Print("End Houdini Pass ...");
            Stats.stop("houdini");

            return newP;
        }


        #region Alias analysis

        // Run Alias Analysis on a sequential Boogie program
        // and returned the pruned program
        public static PersistentProgram RunAliasAnalysis(PersistentProgram inp, bool pruneEP = true)
        {
            var program = inp.getProgram();

            //AliasAnalysis.AliasAnalysis.dbg = true;
            //AliasAnalysis.AliasConstraintSolver.dbg = true;
            AliasAnalysis.AliasAnalysisResults res = null;
            if (Options.UseAliasAnalysisForAssertions)
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
            if (pruneEP) PruneRedundantEntryPoints(origProgram);

            return new PersistentProgram(origProgram, inp.mainProcName, inp.contextBound);
        }

        // Prune away EntryPoints that cannot reach an assertion
        static void PruneRedundantEntryPoints(Program program)
        {
            var procs = BoogieUtil.procsThatMaySatisfyPredicate(program, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));
            procs = harnessInstrumentation.entrypoints.Difference(procs);
            Console.WriteLine("Pruning away {0} entry points as they cannot reach an assert", procs.Count);
            harnessInstrumentation.PruneEntryPoints(program, procs);
        }

        #endregion

    }



}
