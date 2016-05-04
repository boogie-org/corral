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
using CBAProgram = cba.CBAProgram;
using AvUtil;

namespace AvHarnessInstrumentation
{

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    public class Instrumentations
    {
        public static Procedure GetEnvironmentAssumptionsProc(Program program)
        {
            return program.TopLevelDeclarations
                .OfType<Procedure>()
                .FirstOrDefault(proc => QKeyValue.FindBoolAttribute(proc.Attributes, AvnAnnotations.InitialializationProcAttr));
        }

        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;
            Dictionary<string, Procedure> unknownGenProcs = new Dictionary<string, Procedure>();
            bool useProvidedEntryPoints = false;
            public Dictionary<string, string> blockEntryPointConstants; //they guard assume false before calling e_i in the harness 
            public Dictionary<string, Constant> impl2BlockingConstant; //inverse of the above map
            public HashSet<string> entrypoints; // set of entrypoints identified
            public HashSet<string> stubs; // set of stubs identified
            List<Variable> globalParams = new List<Variable>(); // parameters as global variables

            public HarnessInstrumentation(Program program, string corralName, bool useProvidedEntryPoints)
            {
                prog = program;
                mainName = corralName;
                this.useProvidedEntryPoints = useProvidedEntryPoints;
                this.impl2BlockingConstant = new Dictionary<string, Constant>();
                blockEntryPointConstants = new Dictionary<string, string>();
                entrypoints = new HashSet<string>();
                stubs = new HashSet<string>();
            }
            public void DoInstrument(bool addMain = true)
            {
                FindUnknown();
                FindNULL();
                var reach = FindReachableStatesFunc(prog);

                if(addMain) CreateMainProcedure(reach);
                ChangeStubsIntoUnkowns();
            }
            private void CreateMainProcedure(Function reach)
            {
                //blocks 
                List<Block> mainBlocks = new List<Block>();
                List<Variable> locals = new List<Variable>();

                HashSet<Constant> blockCallConsts = new HashSet<Constant>();
                foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
                {
                    // skip this impl if it is not marked as an entrypoint
                    if (useProvidedEntryPoints && !QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                        continue;
                    // skip initialization procedure
                    if (QKeyValue.FindBoolAttribute(impl.Attributes, AvnAnnotations.InitialializationProcAttr) ||
                        QKeyValue.FindBoolAttribute(impl.Proc.Attributes, AvnAnnotations.InitialializationProcAttr))
                        continue;


                    impl.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Attributes);
                    impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                    entrypoints.Add(impl.Name);

                    //allocate params
                    var args = new List<Variable>();
                    var rets = new List<Variable>();


                    impl.OutParams.ForEach(v => rets.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    if (Options.allocateParameters)
                    {
                        // use impl.Proc here to pickup scalar/pointer attributes
                        impl.Proc.InParams.ForEach(v =>
                        {
                            var l = BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type);
                            // We are delibrately dropping the attributes so that
                            // all parameters are initialized by allocation
                            //l.Attributes = v.Attributes;
                            args.Add(l);
                        });
                        locals.AddRange(args);
                    }
                    else
                    {
                        impl.Proc.InParams.ForEach(v =>
                        {
                            var g = BoogieAstFactory.MkGlobal(v.Name + "_" + impl.Name, v.TypedIdent.Type);
                            //g.Attributes = v.Attributes;
                            args.Add(g);
                        });
                        globalParams.AddRange(args);
                    }


                    locals.AddRange(rets);

                    //call 
                    var blockCallConst = new Constant(Token.NoToken,
                        new TypedIdent(Token.NoToken, "__block_call_" + impl.Name, btype.Bool), false);
                    blockCallConsts.Add(blockCallConst);
                    blockEntryPointConstants[blockCallConst.Name] = impl.Name;
                    impl2BlockingConstant[impl.Name] = blockCallConst;
                    var blockCallAssumeCmd = new AssumeCmd(Token.NoToken, IdentifierExpr.Ident(blockCallConst));

                    var cmds = new List<Cmd>();
                    cmds.Add(blockCallAssumeCmd);
                    if (Options.allocateParameters) // allocate parameters if option is enabled
                    {
                        var argMallocCmds = AllocatePointersAsUnknowns(args);
                        cmds.AddRange(argMallocCmds);
                    }

                    // The beginning of an entry point must be reachable: assume reach(true);
                    cmds.Add(new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken,
                            new FunctionCall(reach), new List<Expr> { Expr.True })));

                    var callCmd = new CallCmd(Token.NoToken, impl.Name, args.ConvertAll(x => (Expr)IdentifierExpr.Ident(x)),
                        rets.ConvertAll(x => IdentifierExpr.Ident(x)));
                    callCmd.Attributes = new QKeyValue(Token.NoToken, AvUtil.AvnAnnotations.AvhEntryPointAttr, new List<object>(), callCmd.Attributes);

                    cmds.Add(callCmd);
                    //succ
                    var txCmd = new ReturnCmd(Token.NoToken);
                    var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                    mainBlocks.Add(blk);
                }
                foreach (Procedure proc in prog.TopLevelDeclarations.OfType<Procedure>())
                {
                    proc.Attributes = BoogieUtil.removeAttr("entrypoint", proc.Attributes);
                }
                // add global variables to prog
                // globals.Iter(x => prog.AddTopLevelDeclaration(x)); 
                //add the constants to the prog
                blockCallConsts.Iter(x => prog.AddTopLevelDeclaration(x));
                //TODO: get globals of type refs/pointers and maps
                var initCmd = (AssumeCmd)BoogieAstFactory.MkAssume(Expr.True);
                //TODO: find a reusable API to add attributes to cmds
                //initCmd.Attributes = new QKeyValue(Token.NoToken, ExplainError.Toplevel.CAPTURESTATE_ATTRIBUTE_NAME, new List<Object>() { "Start" }, null);

                var globalCmds = new List<Cmd>() { initCmd };
                //add call to corralExtraInit
                var init = Instrumentations.GetEnvironmentAssumptionsProc(prog);
                if (init != null)
                    globalCmds.Add(BoogieAstFactory.MkCall(init, new List<Expr>(), new List<Variable>()));

                // initialize globals
                prog.GlobalVariables
                    .Where(g => g.Name != "alloc" && !BoogieUtil.checkAttrExists(AvnAnnotations.AllocatorVarAttr, g.Attributes))
                    .Iter(g => g.Attributes = BoogieUtil.removeAttrs(new HashSet<string> { "scalar", "pointer" }, g.Attributes));

                globalCmds.AddRange(AllocatePointersAsUnknowns(prog.GlobalVariables.Select(x => (Variable)x).ToList()));

                // globals for parameters
                prog.AddTopLevelDeclarations(globalParams);

                //first block
                var transferCmd =
                    mainBlocks.Count > 0 ? (TransferCmd)(new GotoCmd(Token.NoToken, mainBlocks)) : (TransferCmd)(new ReturnCmd(Token.NoToken));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalCmds, transferCmd);
                var blocks = new List<Block>();
                blocks.Add(blkStart);
                blocks.AddRange(mainBlocks);
                var mainProcImpl = BoogieAstFactory.MkImpl(AvnAnnotations.CORRAL_MAIN_PROC, new List<Variable>(), new List<Variable>(), locals, blocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.AddTopLevelDeclarations(mainProcImpl);
            }

            // Remove the dispatch to certain entrypoints
            public static void RemoveEntryPoints(Program program, HashSet<string> procs)
            {
                var mainImpl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, AvnAnnotations.CORRAL_MAIN_PROC);
                foreach (var block in mainImpl.Blocks)
                {
                    if (block.Cmds.OfType<CallCmd>().Any(cc => procs.Contains(cc.callee)))
                        block.Cmds.Clear();
                }
                BoogieUtil.pruneProcs(program, mainImpl.Name);
            }

            // Remove the dispatch to certain entrypoints
            public void PruneEntryPoints(Program program, HashSet<string> procs)
            {
                RemoveEntryPoints(program, procs);

                // Get other information in sync
                entrypoints.ExceptWith(procs);
                var bc = new HashSet<string>(impl2BlockingConstant.Where(tup => procs.Contains(tup.Key)).Select(tup => tup.Value.Name));
                bc.Iter(b => blockEntryPointConstants.Remove(b));
                procs.Iter(p => impl2BlockingConstant.Remove(p));
            }

            // create a copy ofthe variables without annotations
            private List<Variable> DropAnnotations(List<Variable> vars)
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

            private void ChangeStubsIntoUnkowns()
            {
                var procsWithImpl = prog.TopLevelDeclarations.OfType<Implementation>()
                    .Select(x => x.Proc);
                var procs = prog.TopLevelDeclarations.OfType<Procedure>();
                //TODO: this can be almost quadratic in the size of |Procedures|, cleanup
                var procsWithoutImpl = procs.Where(x => !procsWithImpl.Contains(x));
                var stubImpls = new List<Implementation>();
                foreach (var p in procsWithoutImpl)
                {
                    if (BoogieUtil.checkAttrExists("allocator", p.Attributes)) continue;
                    MkStubImplementation(stubImpls, p);
                }
                prog.AddTopLevelDeclarations(stubImpls);
            }
            //Change the body of any stub that returns a pointer into calling malloc()
            //TODO: only do this for procedures with a single return with a pointer type            
            private void MkStubImplementation(List<Implementation> stubImpls, Procedure p)
            {
                List<Cmd> cmds = new List<Cmd>();
                List<Variable> localVars = new List<Variable>();
                stubs.Add(p.Name);
                foreach (var op in p.OutParams)
                {
                    if (IsPointerVariable(op)) cmds.Add(AllocatePointerAsUnknown(op));
                    else
                    {
                        // Avoid using Havoc -- we'll let this fall on the floor as an
                        // uninitialized variable. AVN will take care of concretizing it
                        //cmds.Add(BoogieAstFactory.MkHavocVar(op)); 
                    }
                }
                foreach (var v in p.Modifies.Select(ie => ie.Decl))
                {
                    if (IsPointerVariable(v))
                    {
                        cmds.Add(AllocatePointerAsUnknown(v));
                    }
                    else
                    {
                        // unsupported
                        Console.WriteLine("Warning: demonic havoc of globals; probably unsupported");
                    }
                }
                foreach (var ip in p.InParams)
                {
                    if (!BoogieUtil.checkAttrExists("ref", ip.Attributes)) continue;
                    string mapName = QKeyValue.FindStringAttribute(ip.Attributes, "ref");
                    if (mapName == null)
                    {
                        Utils.Print(String.Format("Expecting a map <name> with {:ref <name>} annotation on procedure {0}", p.Name),
                            Utils.PRINT_TAG.AV_WARNING);
                        continue;
                    }
                    var mapVars = prog.TopLevelDeclarations.OfType<Variable>().Where(x => x.Name == mapName && x.TypedIdent.Type.IsMap);
                    if (mapVars.Count() != 1)
                    {
                        Utils.Print(String.Format("Mapname {0} provided in {:ref} for parameter {1} for procedure {2} has {3} matches, expecting exactly 1 match",
                            mapName, ip.Name, p.Name, mapVars.Count()),
                            Utils.PRINT_TAG.AV_WARNING);
                        continue;
                    }
                    var tmpVar = BoogieAstFactory.MkLocal("__tmp_" + ip.Name, ip.TypedIdent.Type);
                    localVars.Add(tmpVar);
                    cmds.Add(AllocatePointerAsUnknown(tmpVar));
                    cmds.Add(BoogieAstFactory.MkMapAssign(mapVars.First(), IdentifierExpr.Ident(ip), IdentifierExpr.Ident(tmpVar)));
                }
                if (cmds.Count == 0) return; //don't create a body if no statements
                var blk = BoogieAstFactory.MkBlock(cmds, new ReturnCmd(Token.NoToken));
                var blks = new List<Block>() { blk };
                //don't insert the proc as it already exists
                var impl = BoogieAstFactory.MkImpl(p.Name,
                    DropAnnotations(p.InParams),
                    DropAnnotations(p.OutParams),
                    new List<Variable>(), blks);
                ((Implementation)impl[1]).LocVars.AddRange(localVars);
                stubImpls.Add((Implementation)impl[1]);
            }
            private Cmd AllocatePointerAsUnknown(Variable x)
            {
                var cc = BoogieAstFactory.MkCall(unknownGenProcs[x.TypedIdent.Type.ToString()],
                    new List<Expr>(),
                    new List<Variable>() { x }) as CallCmd;
                cc.Attributes = new QKeyValue(Token.NoToken, cba.RestrictToTrace.ConcretizeConstantNameAttr, new List<object> { x.Name }, cc.Attributes);
                return cc;

            }
            private List<Cmd> AllocatePointersAsUnknowns(List<Variable> vars)
            {
                return GetPointerVars(vars)
                    .Where(v => !QKeyValue.FindBoolAttribute(v.Attributes, "guardvar")) // HACK!!
                    .Select(x => AllocatePointerAsUnknown(x)).ToList();
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
            private string SanitizeTypeName(btype type)
            {
                return type.ToString().Replace("[", "$$").Replace("]", "$$");
            }

            private void FindUnknown()
            {
                // Which {:unknown} already exist?
                foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                    .Where(p => QKeyValue.FindBoolAttribute(p.Attributes, AvnAnnotations.AngelicUnknownCall)))
                {
                    if (proc.OutParams.Count != 1 || proc.InParams.Count != 0)
                        continue;
                        //throw new InputProgramDoesNotMatchExn(string.Format("Unknown-generating procs should have exactly one out parameter and no input parameters: {0}", proc.Name));
                    unknownGenProcs.Add(proc.OutParams[0].TypedIdent.Type.ToString(), proc);
                }


                foreach (var ty in Options.unknownTypes)
                {                    
                    // Find the type
                    btype type = null;
                    if (ty == "int") type = btype.Int;
                    else if (ty == "bool") type = btype.Bool;
                    else if (ty == "[int]int") type = new MapType(Token.NoToken, new List<TypeVariable>(), new List<btype> { btype.Int }, btype.Int);
                    else
                    {
                        // lookup user types
                        type = prog.TopLevelDeclarations.OfType<TypeCtorDecl>()
                            .Where(t => t.Name == ty)
                            .Select(t => new CtorType(Token.NoToken, t, new List<btype>()))
                            .FirstOrDefault();
                    }
                    if (type == null)
                    {
                        Console.WriteLine("Error: type {0} not found", type);
                        throw new InputProgramDoesNotMatchExn("Invalid unknown type given");
                    }

                    if (unknownGenProcs.ContainsKey(ty)) continue;

                    // create a new procedure
                    var proc = new Procedure(Token.NoToken, "unknown_" + SanitizeTypeName(type), new List<TypeVariable>(), new List<Variable>(),
                        new List<Variable> { new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "r", type), false) },
                        new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                    proc.AddAttribute(AvnAnnotations.AngelicUnknownCall);
                    unknownGenProcs.Add(ty, proc);
                    prog.AddTopLevelDeclaration(proc);
                }

                // Remove extra ones
                var extra = new HashSet<string>(unknownGenProcs.Keys);
                extra.ExceptWith(Options.unknownTypes);
                extra.Iter(s => unknownGenProcs.Remove(s));
                
                foreach (var proc in unknownGenProcs.Values)
                {
                    // Add {:allocator "full"} annotation
                    var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                    if (attr != null && attr == "full") continue;
                    proc.AddAttribute("allocator", "full");

                    // Drop Requires/Ensures
                    proc.Requires = new List<Requires>();
                    proc.Ensures = new List<Ensures>();
                    proc.Modifies = new List<IdentifierExpr>();
                }

                // Extra annotations for user-defined unknowns
                prog.TopLevelDeclarations.OfType<Procedure>()
                    .Where(p => Options.unknownProcs.Contains(p.Name))
                    .Iter(p => p.AddAttribute(AvnAnnotations.AngelicUnknownCall));
            }

            private void FindNULL()
            {
                //find the malloc procedure
                var nulls = prog.TopLevelDeclarations
                    .Where(x => x is Constant && x.ToString().ToLower().Equals("null"));
                if (!nulls.Any())
                    throw new InputProgramDoesNotMatchExn("ABORT: no NULL constant declared in the input program");

                var nil = nulls.First();
                // make NULL an "allocated" constant, if it isn't one already
                if (!QKeyValue.FindBoolAttribute(nil.Attributes, "allocated"))
                    nil.AddAttribute("allocated");
            }
            // instrumentation functions for buffer overflow detection
            private void BufferInstrument(Procedure mallocProcedure)
            {
                var sizeFun = new Function(Token.NoToken, "Size",
                    new List<Variable>() { BoogieAstFactory.MkFormal("x", btype.Int, false) },
                    BoogieAstFactory.MkFormal("r", btype.Int, false));
                sizeFun.AddAttribute("buffer", new Object[] { "size" });

                var baseFun = new Function(Token.NoToken, "Base",
                    new List<Variable>() { BoogieAstFactory.MkFormal("x", btype.Int, false) },
                    BoogieAstFactory.MkFormal("r", btype.Int, false));
                baseFun.AddAttribute("buffer", new Object[] { "base" });

                var allocMap = BoogieAstFactory.MkGlobal("nonfree",
                    BoogieAstFactory.MkMapType(btype.Int, btype.Bool));
                allocMap.AddAttribute("buffer", new Object[] { "free" });

                prog.AddTopLevelDeclaration(sizeFun);
                prog.AddTopLevelDeclaration(baseFun);
                prog.AddTopLevelDeclaration(allocMap);

                var mallocRet = Expr.Ident(mallocProcedure.OutParams[0]);
                mallocProcedure.Ensures.Add(new Ensures(true, Expr.Eq(
                    new NAryExpr(Token.NoToken, new FunctionCall(baseFun),
                        new List<Expr>() { mallocRet }), mallocRet)));
                var mallocIn = Expr.Ident(mallocProcedure.InParams[0]);
                mallocProcedure.Ensures.Add(new Ensures(true, Expr.Eq(
                    new NAryExpr(Token.NoToken, new FunctionCall(sizeFun),
                        new List<Expr>() { mallocRet }), mallocIn)));
                //mallocProcedure.Ensures.Add(new Ensures(true, 
                //    BoogieAstFactory.MkMapAccessExpr(allocMap, mallocRet)));
            }
            private List<Variable> GetPointerVars(List<Variable> vars)
            {
                return vars.Where(x => IsPointerVariable(x)).ToList();
            }
            /// <summary>
            /// TODO: Refine this to only return variables of type pointers
            /// </summary>
            /// <param name="x"></param>
            /// <returns></returns>
            private bool IsPointerVariable(Variable x)
            {
                return unknownGenProcs.ContainsKey(x.TypedIdent.Type.ToString()) &&
                    !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
            }
        }

        /// <summary>
        /// Introduces assume M[x] != null, for any x := op(M[x], ..) 
        /// </summary>
        public class AssertMapSelectsNonNull : StandardVisitor
        {
            public const string attrName = "MapValuesNonNull";
            public string notfalse = null;

            public AssertMapSelectsNonNull()
            {
            }
            public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
            {
                var newCmdSeq = new List<Cmd>();
                foreach (Cmd c in cmdSeq)
                {
                    newCmdSeq.Add(c);
                    if (c is AssignCmd)
                    {
                        var ac = c as AssignCmd;
                        var lookups = new List<Expr>();
                        for (int i = 0; i < ac.Lhss.Count; ++i)
                        {
                            var x = ac.Rhss[i];
                            if (x is NAryExpr && (x as NAryExpr).Fun is MapSelect)
                                lookups.Add(x);
                        }
                        if (lookups.Count() > 0)
                            lookups.Iter(x =>
                            {
                                //newCmdSeq.Add(new AssumeCmd(Token.NoToken, Expr.Neq(x, new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(0)))));
                                var expr = Expr.Neq(x, new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(0)));
                                AssertCmd assertCmd = new AssertCmd(Token.NoToken, expr);
                                assertCmd.Attributes = new QKeyValue(Token.NoToken, attrName, new List<object> { expr }, null);
                                newCmdSeq.Add(assertCmd);
                            });
                    }
                }
                return base.VisitCmdSeq(newCmdSeq);
            }
        }

    }

    // Replace "assume x == NULL" with 
    //     "assume x == NULL; assert false;" OR
    //     "assume x == NULL; assume Reach(true);"
    // provided x can indeed alias NULL
    public class InstrumentBranches
    {
        Program program;
        Dictionary<int, Function> id2Func;
        Dictionary<int, Function> allocationSite2Func;
        List<Function> queries;
        Function nullQuery;
        public Function reach;
        int id;
        bool useAA;
        bool injectAssert;
        int assertsAdded;

        InstrumentBranches(Program program, bool useAA, bool injectAssert)
        {
            this.program = program;
            queries = new List<Function>();
            id2Func = new Dictionary<int, Function>();
            allocationSite2Func = new Dictionary<int, Function>();
            nullQuery = null;
            this.useAA = useAA;
            this.injectAssert = injectAssert;
            reach = Instrumentations.HarnessInstrumentation.FindReachableStatesFunc(program);
            assertsAdded = 0;
        }

        // Replace "assume x == NULL" with "assume x == NULL; assert false;"
        // provided x can indeed alias NULL
        // Also returns a map from allocation_site to possible branches affected by it
        public static Tuple<Program, Dictionary<int, HashSet<int>>> Run(Program program, string ep, bool useAA, bool injectAssert)
        {
            var ib = new InstrumentBranches(program, useAA, injectAssert);
            ib.instrument(ep);

            if (!useAA)
            {
                Console.WriteLine("For deadcode detection, we added {0} angelic assertions", ib.assertsAdded);
                return Tuple.Create<Program, Dictionary<int, HashSet<int>>>(program, null);
            }

            var inp = new PersistentProgram(program, ep, 1);
            //inp.writeToFile("progbefore.bpl");

            // Make sure that aliasing queries are on identifiers only
            var af =
                AliasAnalysis.SimplifyAliasingQueries.Simplify(program);

            // Do SSA
            program =
                SSA.Compute(program, PhiFunctionEncoding.Verifiable, new HashSet<string> { "int" });

            //BoogieUtil.PrintProgram(program, "b3.bpl");

            // Run AA
            AliasAnalysis.AliasAnalysisResults res =
                  AliasAnalysis.AliasAnalysis.DoAliasAnalysis(program);

            // allocation site of null
            var nil = res.allocationSites[ib.nullQuery.Name].FirstOrDefault();
            Debug.Assert(nil != null);

            var deadcodeAssertId = 0;

            // add the assert false OR assume reach(true)
            var MkAssertFalse = new Func<int, PredicateCmd>(i =>
            {
                var acmd = injectAssert ? BoogieAstFactory.MkAssert(Expr.False) as PredicateCmd :
                    new AssumeCmd(Token.NoToken,
                            new NAryExpr(Token.NoToken, new FunctionCall(ib.reach), new List<Expr> { Expr.True })) as PredicateCmd;

                acmd.Attributes = new QKeyValue(Token.NoToken,
                    "deadcode", new List<object> { Expr.Literal(i) }, null);

                return acmd;
            });

            // build a map from AA allocation sites to allocation_site id
            var as2id = new Dictionary<string, HashSet<int>>();
            foreach (var tup in ib.allocationSite2Func)
            {
                var asites = res.allocationSites[tup.Value.Name];
                asites.Where(s => !as2id.ContainsKey(s)).Iter(s => as2id.Add(s, new HashSet<int>()));
                asites.Iter(s => as2id[s].Add(tup.Key));
            }

            if (AliasAnalysis.AliasConstraintSolver.environmentPointersUnroll != 0)
            {
                Console.WriteLine("AA Warning: EnvironmentPointersUnroll is non-zero, which means that the dependency information for deadcode branches is not sound.");
                Console.WriteLine("AA Warning: We currently rely on: forall unknown allocation sites that return a, ReachableAllocationSitesViaFields(a) = {a}.");
            }

            // map from allocation_site to possible branches affected by it
            var depInfo = new Dictionary<int, HashSet<int>>();

            program = inp.getProgram();
            var id = 0; var added = 0;
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.RemoveAll(c => (c is AssumeCmd) && QKeyValue.FindBoolAttribute((c as AssumeCmd).Attributes, "ForDeadCodeDetection"));

                    var ncmds = new List<Cmd>();
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        ncmds.Add(blk.Cmds[i]);
                        var acmd = blk.Cmds[i] as AssumeCmd;
                        if (acmd == null)
                            continue;

                        id++;
                        if (!ib.id2Func.ContainsKey(id))
                            continue;

                        var asites = res.allocationSites[ib.id2Func[id].Name];
                        //if (!Options.disbleDeadcodeOpt || !asites.Contains(nil) && asites.Count != 0)
                        {
                            var assertid = deadcodeAssertId++;
                            ncmds.Add(MkAssertFalse(assertid));

                            // compute dependent allocations for this branch
                            var dep = new HashSet<int>();
                            asites.Where(a => as2id.ContainsKey(a))
                                .Iter(a => dep.UnionWith(as2id[a]));

                            dep.Where(d => !depInfo.ContainsKey(d))
                                .Iter(d => depInfo.Add(d, new HashSet<int>()));

                            dep.Iter(d => depInfo[d].Add(assertid));

                            added++;
                        }
                        //i++;
                    }
                    blk.Cmds = ncmds;
                }
            }
            //BoogieUtil.PrintProgram(program, "progafter.bpl");

            Console.WriteLine("For deadcode detection, we added {0} angelic assertions", added);
            return Tuple.Create(program, depInfo);
        }

        void instrument(string main)
        {
            if (!useAA)
            {
                // Instrument branches
                id = 0;
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => instrument(impl));
                return;
            }

            // find the entrypoint
            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => impl.Name == main)
                .FirstOrDefault();
            Debug.Assert(ep != null);

            // find NULL
            var nil = program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => c.Name == "NULL")
                .First();

            // Instrument branches
            id = 0;
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => instrument(impl));

            // Get the allocation site for NULL
            nullQuery = GetQueryFunc();
            ep.Blocks[0].Cmds.Add(GetQuery(nullQuery, Expr.Ident(nil)));

            // Instrumentation allocation sites
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (var cmd in blk.Cmds)
                    {
                        ncmds.Add(cmd);
                        var ccmd = cmd as CallCmd;
                        if (ccmd == null) continue;
                        var aid = QKeyValue.FindIntAttribute(ccmd.Attributes, "allocator_call", -1);
                        if (aid == -1) continue;
                        var func = GetQueryFunc();
                        ncmds.Add(GetQuery(func, ccmd.Outs[0]));
                        allocationSite2Func.Add(aid, func);
                    }
                    blk.Cmds = ncmds;
                }
            }

            program.AddTopLevelDeclarations(queries);
        }

        void instrument(Implementation impl)
        {
            foreach (var blk in impl.Blocks)
            {
                var ncmds = new List<Cmd>();
                foreach (var cmd in blk.Cmds)
                {
                    ncmds.Add(cmd);
                    var acmd = cmd as AssumeCmd;
                    if (acmd == null) continue;
                    id++;

                    if (!(acmd.Expr is NAryExpr))
                        continue;
                    var expr = acmd.Expr as NAryExpr;
                    if (!(expr.Fun is BinaryOperator) || (expr.Fun as BinaryOperator).Op != BinaryOperator.Opcode.Eq)
                        continue;
                    Expr x = null;
                    if (expr.Args[0].ToString() == "NULL")
                        x = expr.Args[1];
                    else if (expr.Args[1].ToString() == "NULL")
                        x = expr.Args[0];
                    if (x == null) continue;

                    if (useAA)
                    {
                        var func = GetQueryFunc();
                        id2Func.Add(id, func);
                        ncmds.Add(GetQuery(func, x));
                    }
                    else
                    {
                        assertsAdded++;

                        if (injectAssert)
                        {
                            // assert false
                            ncmds.Add(new AssertCmd(Token.NoToken, Expr.False));
                        }
                        else
                        {
                            // assume reach(true);
                            ncmds.Add(new AssumeCmd(Token.NoToken,
                                new NAryExpr(Token.NoToken, new FunctionCall(reach), new List<Expr> { Expr.True })));
                        }
                    }
                }
                blk.Cmds = ncmds;
            }
        }

        Function GetQueryFunc()
        {
            var f = new Function(Token.NoToken, "ASquery" + queries.Count,
                new List<Variable> { BoogieAstFactory.MkFormal("x", btype.Int, true) },
                BoogieAstFactory.MkFormal("y", btype.Bool, false));
            f.AddAttribute("aliasingQuery", "allocationsites");
            queries.Add(f);
            return f;
        }

        AssumeCmd GetQuery(Function func, Expr arg)
        {
            var ret = new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr> { arg }));
            ret.Attributes = new QKeyValue(Token.NoToken, "ForDeadCodeDetection", new List<object>(), ret.Attributes);
            return ret;
        }
    }
}
