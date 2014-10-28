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

namespace AngelicVerifierNull
{

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    public class Instrumentations
    {
        public static Implementation GetEnvironmentAssumptionsProc(Program program)
        {
            return program.TopLevelDeclarations
                .OfType<Implementation>()
                .FirstOrDefault(impl => QKeyValue.FindBoolAttribute(impl.Attributes, AvnAnnotations.InitialializationProcAttr)
                    || QKeyValue.FindBoolAttribute(impl.Proc.Attributes, AvnAnnotations.InitialializationProcAttr));
        }

        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;
            Procedure mallocProcedure = null;
            Procedure mallocProcedureFull = null;
            bool useProvidedEntryPoints = false;
            public Dictionary<string, string> blockEntryPointConstants; //they guard assume false before calling e_i in the harness 
            public Dictionary<string, Constant> impl2BlockingConstant; //inverse of the above map
            public HashSet<string> entrypoints; // set of entrypoints identified
            List<Variable> globalParams = new List<Variable>(); // parameters as global variables

            public HarnessInstrumentation(Program program, string corralName, bool useProvidedEntryPoints)
            {
                prog = program;
                mainName = corralName;
                this.useProvidedEntryPoints = useProvidedEntryPoints;
                this.impl2BlockingConstant = new Dictionary<string, Constant>();
                blockEntryPointConstants = new Dictionary<string,string>();
                entrypoints = new HashSet<string>();
            }
            public void DoInstrument()
            {
                FindMalloc();
                FindNULL();
                var reach = FindReachableStatesFunc(prog);
                if (Options.bufferDetect)
                {
                    //DisableNonNullAsserts();
                    AddSystemModels(); // TODO: add system models for buffer detection
                }
                CreateMainProcedure();
                ChangeStubsIntoUnkowns();
                EntryPointsReachable(reach);
                if (Options.bufferDetect)
                {
                    BufferInstrumentations();
                }
            }

            // The beginning of an entry point must be reachable
            private void EntryPointsReachable(Function reach)
            {
                foreach (var impl in prog.TopLevelDeclarations.OfType<Implementation>())
                {
                    if (!entrypoints.Contains(impl.Name))
                        continue;
                    // assume reach(true);
                    impl.Blocks[0].Cmds.Insert(0,
                        new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken,
                            new FunctionCall(reach), new List<Expr> { Expr.True })));
                }
            }

            private void BufferInstrumentations()
            {
                Console.WriteLine("Doing buffer instrumentation");
                prog = DefaultModels.BufferInstrument(ref prog);
            }

            private void DisableNonNullAsserts()
            {
                RemoveAssertNonNull rn = new RemoveAssertNonNull();
                prog = rn.VisitProgram(prog);
            }

            private void AddSystemModels()
            {
                // Add System Models
                Console.WriteLine("Adding system models");
                prog = DefaultModels.AddModels(ref prog);
            }
            
            private void CreateMainProcedure()
            {
                //blocks 
                List<Block> mainBlocks = new List<Block>();
                List<Variable> locals = new List<Variable>();
                Stats.numProcs = prog.TopLevelDeclarations.Where(x => x is Implementation).Count();
                Stats.numProcsAnalyzed = 0;
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

                    Stats.numProcsAnalyzed++;
                    impl.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Attributes);
                    impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                    entrypoints.Add(impl.Name);

                    //allocate params
                    var args = new List<Variable>();
                    var rets = new List<Variable>();

                    
                    impl.OutParams.ForEach(v => rets.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    if (Driver.allocateParameters)
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
                    if (Driver.allocateParameters) // allocate parameters if option is enabled
                    {
                        var argMallocCmds = AllocatePointersAsUnknowns(args);
                        cmds.AddRange(argMallocCmds);
                    }

                    var callCmd = new CallCmd(Token.NoToken, impl.Name, args.ConvertAll(x => (Expr)IdentifierExpr.Ident(x)),
                        rets.ConvertAll(x => IdentifierExpr.Ident(x)));                
                    
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
                var initCmd = (AssumeCmd) BoogieAstFactory.MkAssume(Expr.True);
                //TODO: find a reusable API to add attributes to cmds
                initCmd.Attributes = new QKeyValue(Token.NoToken, ExplainError.Toplevel.CAPTURESTATE_ATTRIBUTE_NAME, new List<Object>() {"Start"}, null);
                var globalCmds = new List<Cmd>() { initCmd };
                //add call to corralExtraInit
                var init = Instrumentations.GetEnvironmentAssumptionsProc(prog);
                if (init != null && Options.FieldNonNull)
                    globalCmds.Add(BoogieAstFactory.MkCall(init.Proc, new List<Expr>(), new List<Variable>()));

                // initialize globals
                globalCmds.AddRange(AllocatePointersAsUnknowns(prog.GlobalVariables.Select(x => (Variable)x).ToList()));

                // globals for parameters
                prog.AddTopLevelDeclarations(globalParams);

                //first block
                var transferCmd =
                    mainBlocks.Count > 0 ? (TransferCmd)(new GotoCmd(Token.NoToken, mainBlocks)) : (TransferCmd) (new ReturnCmd(Token.NoToken));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalCmds, transferCmd);
                var blocks = new List<Block>();
                blocks.Add(blkStart);
                blocks.AddRange(mainBlocks);
                var mainProcImpl = BoogieAstFactory.MkImpl("CorralMain", new List<Variable>(), new List<Variable>(), locals, blocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.AddTopLevelDeclarations(mainProcImpl);
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
                foreach (var op in p.OutParams)
                {
                    if (IsPointerVariable(op)) cmds.Add(AllocatePointerAsUnknown(op));
                    else cmds.Add(BoogieAstFactory.MkHavocVar(op)); //Corral alias analysis crashes (what is semantics of uninit var for inlining)
                }
                foreach (var ip in p.InParams)
                {
                    if (!BoogieUtil.checkAttrExists("ref", ip.Attributes)) continue;
                    string mapName = QKeyValue.FindStringAttribute(ip.Attributes, "ref");
                    if (mapName == null) {
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
                return BoogieAstFactory.MkCall(mallocProcedureFull, 
                    new List<Expr>(){new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ONE)}, 
                    new List<Variable>() {x});
            }
            private List<Cmd> AllocatePointersAsUnknowns(List<Variable> vars)
            {
                return GetPointerVars(vars)
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
            private void FindMalloc()
            {
                //find the malloc and malloc-full procedures
                foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                    .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
                {
                    var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                    if (attr == null) mallocProcedure = proc;
                    else if (attr == "full") mallocProcedureFull = proc;
                }

                if (mallocProcedure == null)
                {
                    throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator} declared in the input program");
                }

                if (mallocProcedureFull == null)
                {
                    throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator \"full\"} declared in the input program");
                }

                if (mallocProcedure.InParams.Count != 1 || mallocProcedureFull.InParams.Count != 1)
                {
                    throw new InputProgramDoesNotMatchExn(String.Format("ABORT: malloc procedure {0} should have exactly 1 argument, found {1}",
                        mallocProcedure.Name, mallocProcedure.InParams.Count));
                }

                if (Options.bufferDetect)
                    BufferInstrument(mallocProcedure);

                // Drop annotations on mallocProcedureFull. We will use it 
                // as our "unknown" theory
                mallocProcedureFull.Requires = new List<Requires>();
                mallocProcedureFull.Ensures = new List<Ensures>();
                mallocProcedureFull.Modifies = new List<IdentifierExpr>();
            }
            private void FindNULL()
            {
                //find the malloc procedure
                var nulls = prog.TopLevelDeclarations
                    .Where(x => x is Constant && x.ToString().Equals("NULL"));
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
                sizeFun.AddAttribute("buffer", new Object[]{"size"});

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
                return x.TypedIdent.Type.IsInt &&
                    !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
            }
        }

        public class MallocInstrumentation
        {
            Program prog;

            public const string mallocTriggerFuncName = "mallocTrigger_";
            // allocator_call -> trigger function
            public Dictionary<int, string> mallocTriggersLocation; //don't keep any objects (e.g. Function) since program changes

            public MallocInstrumentation(Program program)
            {
                prog = program;
            }
            public void DoInstrument()
            {
                var mi = new MallocInstrumentVisitor(this)
                    .Visit(prog);                
            }

            private class MallocInstrumentVisitor : StandardVisitor
            {
                public Block currBlock = null;
                public Implementation currImpl = null;
                MallocInstrumentation instance;
                public Dictionary<CallCmd, Function> mallocTriggers;
                public MallocInstrumentVisitor(MallocInstrumentation mi)
                {
                    instance = mi;
                    mallocTriggers = new Dictionary<CallCmd, Function>();
                    instance.mallocTriggersLocation = new Dictionary<int, string>();
                }
                public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
                {
                    int callCmdCount = -1; 
                    var newCmdSeq = new List<Cmd>();
                    foreach (Cmd c in cmdSeq)
                    {
                        newCmdSeq.Add(c);
                        var callCmd = c as CallCmd;
                        if (callCmd != null) callCmdCount++;
                        if (callCmd != null && BoogieUtil.checkAttrExists("allocator", callCmd.Proc.Attributes))
                        {
                            var retCall = callCmd.Outs[0];
                            var mallocTriggerFn = new Function(Token.NoToken, mallocTriggerFuncName + mallocTriggers.Count,
                                new List<Variable>() { BoogieAstFactory.MkFormal("a", btype.Int, false) },
                                BoogieAstFactory.MkFormal("r", btype.Bool, false));
                            mallocTriggers[callCmd] = mallocTriggerFn;
                            var callId = QKeyValue.FindIntAttribute(callCmd.Attributes, "allocator_call", -1);
                            Debug.Assert(callId != -1, "Calls to the allocator must be tagged with a unique ID");
                            instance.mallocTriggersLocation[callId] = mallocTriggerFn.Name;
                            instance.prog.AddTopLevelDeclaration(mallocTriggerFn);
                            var fnApp = new NAryExpr(Token.NoToken,
                                new FunctionCall(mallocTriggerFn),
                                new List<Expr> () {retCall});
                            newCmdSeq.Add(BoogieAstFactory.MkAssume(fnApp)); 
                        }
                    }
                    return base.VisitCmdSeq(newCmdSeq);
                }
                public override Block VisitBlock(Block node)
                {
                    currBlock = node;    
                    return base.VisitBlock(node);
                }
                public override Implementation VisitImplementation(Implementation node)
                {
                    currImpl = node;
                    return base.VisitImplementation(node);
                }
            }
        }

        public class AssertGuardInstrumentation
        {
            Program prog;

            public AssertGuardInstrumentation(Program program)
            {
                prog = program;
            }
            public void DoInstrument()
            {
                new AssertGuardInstrumentVisitor(this)
                    .Visit(prog);
            }

            private class AssertGuardInstrumentVisitor : StandardVisitor
            {
                AssertGuardInstrumentation instance;
                public Dictionary<AssertCmd, Constant> assertGuardConsts;
                public AssertGuardInstrumentVisitor(AssertGuardInstrumentation agi)
                {
                    instance = agi;
                    assertGuardConsts = new Dictionary<AssertCmd, Constant>();
                }
                public override Cmd VisitAssertCmd(AssertCmd node)
                {
                    if (assertGuardConsts.ContainsKey(node)) return node;
                    if (node.Expr.ToString().Equals(Expr.True.ToString())) return node;
                    var guardConst = new Constant(Token.NoToken, 
                        new TypedIdent(Token.NoToken, "_assert_guard_" + assertGuardConsts.Count(), btype.Bool), false);
                    node.Expr = Expr.Imp(IdentifierExpr.Ident(guardConst), node.Expr);
                    assertGuardConsts[node] = guardConst;
                    instance.prog.AddTopLevelDeclaration(guardConst);
                    return base.VisitAssertCmd(node);
                }
            }
        }

        public class AssertCountVisitor : StandardVisitor
        {
            public int assertCount = 0;
            public string notfalse = null;

            public AssertCountVisitor()
            {
                notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
            }

            public override Cmd VisitAssertCmd(AssertCmd node)
            {
                // disregard true and !false
                if (node.Expr.ToString() == Expr.True.ToString() ||
                    node.Expr.ToString() == notfalse)
                    return node;

                assertCount++;
                return base.VisitAssertCmd(node);
            }
        }

        public class AssertWithAttributeCountVisitor : StandardVisitor
        {
            public int assertCountAll = 0;
            public int assertsNotRemovedCount = 0;
            public string notfalse = null;
            private string attrName;

            public AssertWithAttributeCountVisitor(string attributeName)
            {
                attrName = attributeName;
                notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
            }

            public override Cmd VisitAssertCmd(AssertCmd node)
            {
                if (QKeyValue.FindExprAttribute(node.Attributes, attrName) == null) 
                    return base.VisitAssertCmd(node);
                assertCountAll++;
                // disregard true and !false
                if (node.Expr.ToString() == Expr.True.ToString() ||
                    node.Expr.ToString() == notfalse)
                    return base.VisitAssertCmd(node);

                assertsNotRemovedCount++;
                return base.VisitAssertCmd(node);
            }
        }


        /// <summary>
        /// Useful for rewriting an expr (with only constants) from one PersistentProgram to another
        /// TODO: Is there a cleaner way to achieve this?
        /// </summary>
        public class RewriteConstants : StandardVisitor
        {
            Dictionary<string,Variable> newConstantsMap;
            public RewriteConstants(HashSet<Variable> newConstants)
            {
                this.newConstantsMap = new Dictionary<string, Variable>();
                newConstants.Iter(x => this.newConstantsMap[x.Name] = x);
            }
            public override Variable VisitVariable(Variable node)
            {
                if (newConstantsMap.ContainsKey(node.Name))
                    return base.VisitVariable(newConstantsMap[node.Name]);
                else
                {
                    Utils.Print("WARNING!!: Cannot find constant " + node.Name + " in the set of constants");
                    return base.VisitVariable(node);
                }
            }
        }


        /// <summary>
        /// Introduces assume M[x] != null, for any x := op(M[x], ..) 
        /// </summary>
        public class AssertMapSelectsNonNull : StandardVisitor
        {
            public const string attrName = "MapValuesNonNull";
            public string notfalse = null;

            public AssertMapSelectsNonNull() {
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

        public class AssumeMapSelectsNonNull : StandardVisitor
        {
            public string notfalse = null;
            public AssumeMapSelectsNonNull()
            {
                notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
            }
            public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
            {
                var newCmdSeq = new List<Cmd>();
                foreach (Cmd c in cmdSeq)
                {
                    if (c is AssertCmd)
                    {
                        var ac = c as AssertCmd;
                        var e = QKeyValue.FindExprAttribute(ac.Attributes, AssertMapSelectsNonNull.attrName);
                        if (e == null) { newCmdSeq.Add(c); continue; }
                        if (ac.Expr.ToString() == Expr.True.ToString() || ac.Expr.ToString() == notfalse)
                        {
                            var expr = Expr.Neq(e, new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(0)));
                            var assumeCmd = new AssumeCmd(Token.NoToken, expr);
                            newCmdSeq.Add(assumeCmd);
                        }
                        //don't add the assert otherwise
                    } else
                    {
                        newCmdSeq.Add(c);
                    }
                }
                return base.VisitCmdSeq(newCmdSeq);
            }
        }

        public class RemoveAssertNonNull : StandardVisitor
        {
            public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
            {
                var newCmdSeq = new List<Cmd>();
                foreach (Cmd c in cmdSeq)
                {
                    if (c is AssertCmd)
                    {
                        var ac = c as AssertCmd;
                        if (BoogieUtil.checkAttrExists("nonnull", ac.Attributes)) continue;
                        newCmdSeq.Add(c);
                    }
                    else
                    {
                        newCmdSeq.Add(c);
                    } 
                }
                return base.VisitCmdSeq(newCmdSeq);
            }
        }
    }

    // Tokens represent assertions
    class AssertToken
    {
        public int id {get; private set;}
        static int idCounter = 0;
        public AssertToken(int id)
        {
            this.id = id;
        }
        internal static AssertToken GetNextToken()
        {
            return new AssertToken(idCounter++);
        }
        public override bool Equals(object obj)
        {
            return (obj as AssertToken).id == id;
        }
        public override int GetHashCode()
        {
            return id.GetHashCode();
        }
    }

    /* Initial instrumentation done before running corral.
     * It gets rid of source line annotation and print commands (because
     * there are too many of them).
     * It also instruments assertions.
     */
    class AvnInstrumentation : cba.CompilerPass
    {
        // Information for mapping back traces
        cba.ModifyTrans sourceInfo;
        cba.ModifyTrans printInfo;
        cba.CompressBlocks compressBlocks;
        cba.InsertionTrans assertInstrInfo;
        cba.InsertionTrans blanksInfo;
        cba.DeepAssertRewrite da;
        List<cba.InsertionTrans> suppressInfo;

        // The harness instrumentation (kept here for
        // round-robin mode)
        Instrumentations.HarnessInstrumentation harnessInstr;

        // Token -> assertion representing that token
        Dictionary<AssertToken, AssertCmd> originalAssertions;

        // Token -> (procedure,block) where the assertion came from
        Dictionary<AssertToken, Tuple<string, string>> tokenLocation;

        // procedure -> its set of tokens
        Dictionary<string, HashSet<AssertToken>> procToTokens;

        // tokens suppressed so far; this only monotonically grows
        HashSet<AssertToken> suppressedTokens;
        // temporarily suppress tokens
        HashSet<AssertToken> tempSuppressedTokens;

        // The program that is constantly updated with blocked assertions
        // or input constraints.
        Program currProg;

        // Name of the harness procedure
        string origMainName;

        // Assertion instrumentation
        public readonly string assertsPassedName = "assertsPassed";
        GlobalVariable assertsPassed;

        // are we in blocking mode
        bool blockingMode;

        // Ebasic assumptions
        public HashSet<string> procsWithEnvAssumptions { get; private set; }


        public AvnInstrumentation(Instrumentations.HarnessInstrumentation harnessInstr)
        {
            passName = "SequentialInstrumentation"; 
            assertInstrInfo = new cba.InsertionTrans();
            blanksInfo = new cba.InsertionTrans();
            assertsPassed = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "assertsPassed", Microsoft.Boogie.Type.Bool));
            compressBlocks = new cba.CompressBlocks();
            originalAssertions = new Dictionary<AssertToken, AssertCmd>();
            tokenLocation = new Dictionary<AssertToken, Tuple<string, string>>();
            procToTokens = new Dictionary<string, HashSet<AssertToken>>();
            suppressedTokens = new HashSet<AssertToken>();
            tempSuppressedTokens = new HashSet<AssertToken>();
            currProg = null;
            this.harnessInstr = harnessInstr;
            origMainName = null;
            blockingMode = false;
            procsWithEnvAssumptions = new HashSet<string>();
            suppressInfo = new List<cba.InsertionTrans>();
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Add blanks
            blanksInfo = AddBlanks(program);

            // Remove unreachable procedures
            BoogieUtil.pruneProcs(program, program.mainProcName);

            // Remove source line annotations
            sourceInfo = cba.PrintSdvPath.DeleteSourceInfo(program);

            // Remove print info
            //printInfo = cba.PrintSdvPath.DeletePrintCmds(program);

            // Compress
            compressBlocks.VisitProgram(program);

            // name Ebasic
            NameEnvironmentConstraints(program);

            // Instrument assertions
            int tokenId = 0;

            origMainName = program.mainProcName;

            CBAProgram ret = null;

            if (!Options.DeepAsserts)
            {
                // Do error-bit instrumentation
                var impls = BoogieUtil.nameImplMapping(program);
                var pwa = cba.SequentialInstrumentation.procsWithAsserts(program);

                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var instrumented = new List<Block>();
                    foreach (var blk in impl.Blocks)
                    {
                        var currCmds = new List<Cmd>();
                        var currLabel = blk.Label;

                        assertInstrInfo.addTrans(impl.Name, blk.Label, blk.Label);
                        var incnt = -1;
                        foreach (Cmd cmd in blk.Cmds)
                        {
                            incnt++;

                            // instrument assert
                            if (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd))
                            {
                                currCmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, (cmd as AssertCmd).Expr));

                                var token = new AssertToken(tokenId);
                                originalAssertions.Add(token, cmd as AssertCmd);
                                tokenLocation.Add(token, Tuple.Create(impl.Name, currLabel));
                                procToTokens.InitAndAdd(impl.Name, token);

                                addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                                currLabel = addInstr(instrumented, currCmds, currLabel, tokenId);
                                tokenId++;
                                currCmds = new List<Cmd>();

                                continue;
                            }

                            // procedure call 
                            if (cmd is CallCmd && pwa.Contains((cmd as CallCmd).callee))
                            {
                                currCmds.Add(cmd);
                                addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);
                                currLabel = addInstr(instrumented, currCmds, currLabel, -1);
                                currCmds = new List<Cmd>();
                                continue;
                            }

                            currCmds.Add(cmd);
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                        }

                        instrumented.Add(new Block(Token.NoToken, currLabel, currCmds, blk.TransferCmd));

                    }

                    impl.Blocks = instrumented;
                }

                program.AddTopLevelDeclaration(assertsPassed);
                var newMain = addMain(program);

                BoogieUtil.DoModSetAnalysis(program);

                // Set inline attribute
                // free requires assertsPassed == true;
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    impl.Proc.Requires.Add(new Requires(true, Expr.Ident(assertsPassed)));
                }

                // convert free ensures e to:
                //  free ensures assertsPassed == false || e
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>()
                    .Where(impl => pwa.Contains(impl.Name)))
                {
                    foreach (Ensures ens in impl.Proc.Ensures)
                        ens.Condition = Expr.Or(Expr.Not(Expr.Ident(assertsPassed)), ens.Condition);
                }

                currProg = program;
                ret = new CBAProgram(program, newMain, 0);
            }
            else
            {
                // Use Deep-assert instrumentation
                da = new cba.DeepAssertRewrite();

                // First, tag assertions with tokens
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    foreach (var blk in impl.Blocks)
                    {
                        foreach (var cmd in blk.Cmds.OfType<AssertCmd>())
                        {
                            if (BoogieUtil.isAssertTrue(cmd)) continue;

                            var token = new AssertToken(tokenId);
                            cmd.Attributes = new QKeyValue(Token.NoToken, "avn", new List<object> { Expr.Literal(tokenId) },
                                cmd.Attributes);
                            originalAssertions.Add(token, cmd);
                            tokenLocation.Add(token, Tuple.Create(impl.Name, blk.Label));
                            procToTokens.InitAndAdd(impl.Name, token);
                            tokenId++;
                        }
                    }
                }

                // Second, do the rewrite
                var t1 = new PersistentProgram(program, program.mainProcName, program.contextBound);
                var t2 = da.run(t1);
                var daprog = t2.getCBAProgram();

                // Third, revisit the assertions and remember their location
                // in the output program. This is a bit of a hack. The "tokenLocation"
                // of a token is the pair (p1,b1) where p1 is the procedure the assertion
                // originally came from and b1 is the block in the new main that contains
                // that assertion.
                var main = BoogieUtil.findProcedureImpl(daprog.TopLevelDeclarations, daprog.mainProcName);
                foreach (var block in main.Blocks)
                {
                    foreach (var cmd in block.Cmds.OfType<AssertCmd>())
                    {
                        var tok = QKeyValue.FindIntAttribute(cmd.Attributes, "avn", -1);
                        if (tok < 0) continue;
                        var token = new AssertToken(tok);

                        Debug.Assert(tokenLocation.ContainsKey(token));
                        var oldloc = tokenLocation[token];
                        tokenLocation[token] = Tuple.Create(oldloc.Item1, block.Label);
                    }

                }

                currProg = daprog;
                ret = daprog;
            }

            return ret;
        }

        // convert {:Ebasic} to {:Ebasic n}
        void NameEnvironmentConstraints(Program program)
        {
            procsWithEnvAssumptions = new HashSet<string>();

            var cnt = 0;
            var AddAttr = new Action<Implementation, Cmd>((impl,cmd) =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return;
                if (!QKeyValue.FindBoolAttribute(acmd.Attributes, AvnAnnotations.EnvironmentAssumptionAttr))
                    return;

                acmd.Attributes = BoogieUtil.removeAttr(AvnAnnotations.EnvironmentAssumptionAttr, acmd.Attributes);
                acmd.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.EnvironmentAssumptionAttr, new List<object> { Expr.Literal(cnt) }, acmd.Attributes);
                cnt++;
                procsWithEnvAssumptions.Add(impl.Name);
            });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach(var block in impl.Blocks) 
                    block.Cmds.Iter(c => AddAttr(impl, c));
            }
        }

        public void SuppressEnvironmentConstraint(int n)
        {
            var suppressed = false;

            var Mutate = new Action<Cmd>(cmd =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return;
                var id = QKeyValue.FindIntAttribute(acmd.Attributes, AvnAnnotations.EnvironmentAssumptionAttr, -1);
                if (id == -1 || id != n) return;
                suppressed = true;
                Console.WriteLine("Suppresing environment constraint: {0}", acmd.Expr);
                acmd.Expr = Expr.True;
            });

            foreach (var impl in currProg.TopLevelDeclarations.OfType<Implementation>())
            {
                if (!procsWithEnvAssumptions.Contains(impl.Name))
                    continue;

                foreach (var block in impl.Blocks)
                    block.Cmds.Iter(Mutate);
            }
            Debug.Assert(suppressed);
        }

        // This is to avoid a corner-case with ModifyTrans where some statements
        // that are deleted by the transformation are picked up at the end of the 
        // trace while mapping back. 
        // We avoid this by adding "assume true" right after procedure calls
        private cba.InsertionTrans AddBlanks(Program program)
        {
            var tinfo = new cba.InsertionTrans();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var currCmds = new List<Cmd>();

                    tinfo.addTrans(impl.Name, blk.Label, blk.Label);
                    var incnt = -1;
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        incnt++;

                        // procedure call 
                        if (cmd is CallCmd)
                        {
                            currCmds.Add(cmd);
                            tinfo.addTrans(impl.Name, blk.Label, incnt, cmd, blk.Label, currCmds.Count - 1, new List<Cmd>{ currCmds.Last() });
                            currCmds.Add(BoogieAstFactory.MkAssume(Expr.True));
                            continue;
                        }

                        currCmds.Add(cmd);
                        tinfo.addTrans(impl.Name, blk.Label, incnt, cmd, blk.Label, currCmds.Count - 1, new List<Cmd> { currCmds.Last() });
                    }
                    blk.Cmds = currCmds;
                }
            }

            return tinfo;
        }

        public override cba.ErrorTrace mapBackTrace(cba.ErrorTrace trace)
        {
            cba.ErrorTrace ptrace = null;
            if (!Options.DeepAsserts)
            {
                // knock off top-level procedure
                var OldMainName = (input as PersistentProgram).mainProcName;
                
                foreach (var blk in trace.Blocks)
                {
                    var c = blk.Cmds.OfType<cba.CallInstr>().First(cmd => cmd.callee == OldMainName);
                    if (c == null) continue;
                    ptrace = c.calleeTrace;
                    break;
                }
                Debug.Assert(ptrace != null);
            }
            else
            {
                ptrace = da.mapBackTrace(trace);
            }

            trace = ptrace;
            (suppressInfo as IEnumerable<cba.InsertionTrans>)
                .Reverse().Iter(tinfo => trace = tinfo.mapBackTrace(trace));

            trace = assertInstrInfo.mapBackTrace(trace);
            trace = compressBlocks.mapBackTrace(trace);
            //trace = printInfo.mapBackTrace(trace);
            trace = sourceInfo.mapBackTrace(trace);
            trace = blanksInfo.mapBackTrace(trace);
            return trace;
        }

        // Return the set of constaints for round-robin blocking
        public IEnumerable<Constant> GetRoundRobinBlockingConstants()
        {
            var blockConstNames = harnessInstr.blockEntryPointConstants.Keys;
            var blockCallConsts = currProg.TopLevelDeclarations
                .OfType<Constant>()
                .Where(x => blockConstNames.Contains(x.Name));
            return blockCallConsts;
        }

        // Have we blocked entrypoints?
        public bool InBlockingMode()
        {
            return blockingMode;
        }

        // Block all entrypoints but one
        public void BlockAllButThis(string impl)
        {
            BlockAllButThis(harnessInstr.impl2BlockingConstant[impl]);
        }

        // Block all entrypoints but one
        public void BlockAllButThis(Constant constant)
        {
            blockingMode = true;

            var blockCallConsts = GetRoundRobinBlockingConstants();
            var tmp = new HashSet<Constant>(blockCallConsts);
            tmp.Remove(constant);
            var blockExpr = tmp.Aggregate((Expr)Expr.True, (x, y) => (Expr.And(x, Expr.Not(IdentifierExpr.Ident(y)))));
            var mainProc = currProg.TopLevelDeclarations.OfType<Procedure>()
                .Where(x => x.Name == (output as PersistentProgram).mainProcName).FirstOrDefault();
            mainProc.Requires.Add(new Requires(Token.NoToken, false, blockExpr, null, 
                new QKeyValue(Token.NoToken, "RRBlocking", new List<object>(), null))); 
        }

        // Unblock entrypoints
        public void RemoveBlockingConstraint()
        {
            blockingMode = false;
            var mainProc = currProg.TopLevelDeclarations.OfType<Procedure>()
                .Where(x => x.Name == (output as PersistentProgram).mainProcName).FirstOrDefault();

            mainProc.Requires.RemoveAll(x => QKeyValue.FindBoolAttribute(x.Attributes, "RRBlocking"));
        }

        // Returns file and line of the failing assert. Dumps
        // error trace to disk.
        public Tuple<string, int> PrintErrorTrace(cba.ErrorTrace trace, string filename)
        {
            trace = mapBackTrace(trace);
            
            if (Driver.printTraceMode == Driver.PRINT_TRACE_MODE.Boogie)
            {
                cba.PrintProgramPath.print(input, trace, filename + ".txt");
                return null;
            }
            else
            {
                cba.PrintSdvPath.Print(input.getProgram(), trace, new HashSet<string>(), "",
                    filename + ".tt", "stack.txt");
                //if (cba.PrintSdvPath.lastDriverLocation == null) // TODO: error trace for buffer asserts
                //    return Tuple.Create(".//models.c", 1);
                return Tuple.Create(cba.PrintSdvPath.lastDriverLocation.Item1, cba.PrintSdvPath.lastDriverLocation.Item3);
            }
        }

        // Get the current program (with blocked assertions and input constraints)
        public PersistentProgram GetCurrProgram()
        {
            return new PersistentProgram(currProg, (output as PersistentProgram).mainProcName,
                (output as PersistentProgram).contextBound);
        }

        // The assertion corresponding to the given token
        public AssertCmd GetFailingAssert(AssertToken token)
        {
            return originalAssertions[token];

        }

        // Location where the assertion lived
        public string GetFailingAssertProcName(AssertToken token)
        {
            return tokenLocation[token].Item1;
        }

        // Procs with at least one assertion
        public HashSet<string> GetProcsWithAsserts()
        {
            var ret = new HashSet<string>();
            procToTokens.Where(kvp => kvp.Value.Count != 0)
                .Iter(kvp => ret.Add(kvp.Key));
            return ret;
        }

        // Suppress assertions in all but one procedure.
        // Returns the ones left.
        public HashSet<AssertToken> SuppressAllButOneProcedure(string procName)
        {
            Debug.Assert(tempSuppressedTokens.Count == 0);
            tempSuppressedTokens = new HashSet<AssertToken>();
            procToTokens.Where(kvp => kvp.Key != procName)
                .Iter(kvp => tempSuppressedTokens.UnionWith(kvp.Value));

            tempSuppressedTokens.Iter(t => SuppressToken(t));

            var ret = new HashSet<AssertToken>(procToTokens[procName]);
            ret.ExceptWith(suppressedTokens);

            return ret;
        }

        // Unsuppress assertions (inverse of SuppressAllButOneProcedure)
        public void Unsuppress()
        {
            foreach (var token in tempSuppressedTokens)
            {
                if (suppressedTokens.Contains(token))
                    continue;
                UnsuppressToken(token);
            }
            tempSuppressedTokens = new HashSet<AssertToken>();

            BoogieUtil.DoModSetAnalysis(currProg);
        }


        // precondition: pathProgram has a single implementation
        // Suppress an assertion (that failed in the pathProgram) and
        // return its token
        public AssertToken SuppressAssert(Program pathProgram)
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
            
            SuppressToken(token);

            BoogieUtil.DoModSetAnalysis(currProg);

            suppressedTokens.Add(token);

            return token;
        }

        public void SuppressToken(AssertToken token)
        {
            var location = tokenLocation[token];

            if (Options.DeepAsserts)
                location = Tuple.Create((output as PersistentProgram).mainProcName, location.Item2);

            var p = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations, location.Item1);
            var block = p.Blocks.Where(blk => blk.Label == location.Item2).FirstOrDefault();

            // disable assignment to assertsPassed
            var ncmds = new List<Cmd>();
            foreach (var cmd in block.Cmds)
            {
                if (!Options.DeepAsserts && (cmd is AssignCmd) && (cmd as AssignCmd).Lhss[0].DeepAssignedVariable.Name == assertsPassedName)
                {
                    var acmd = BoogieAstFactory.MkAssume((cmd as AssignCmd).Rhss[0]) as AssumeCmd;
                    acmd.Attributes = new QKeyValue(Token.NoToken, "suppressAssert",
                        new List<object> { Expr.Literal(token.id) }, null);
                    ncmds.Add(acmd);
                }
                else if (Options.DeepAsserts && (cmd is AssertCmd)
                  && QKeyValue.FindIntAttribute((cmd as AssertCmd).Attributes, "avn", -1) == token.id)
                {
                    var acmd = new AssumeCmd(Token.NoToken, (cmd as AssertCmd).Expr, (cmd as AssertCmd).Attributes);
                    ncmds.Add(acmd);
                }
                else
                    ncmds.Add(cmd);
            }
            block.Cmds = ncmds;
        }

        private void UnsuppressToken(AssertToken token)
        {
            var location = tokenLocation[token];
            var p = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations, location.Item1);
            var block = p.Blocks.Where(blk => blk.Label == location.Item2).FirstOrDefault();

            // disable assignment to assertsPassed
            var ncmds = new List<Cmd>();
            foreach (var cmd in block.Cmds)
            {
                if (!Options.DeepAsserts && cmd is AssumeCmd && QKeyValue.FindIntAttribute((cmd as AssumeCmd).Attributes, "suppressAssert", -1) == token.id)
                {
                    ncmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, (cmd as AssumeCmd).Expr));
                }
                else if (Options.DeepAsserts && cmd is AssumeCmd &&
                  QKeyValue.FindIntAttribute((cmd as AssumeCmd).Attributes, "avn", -1) == token.id)
                {
                    ncmds.Add(new AssertCmd(Token.NoToken, (cmd as AssertCmd).Expr, (cmd as AssertCmd).Attributes));
                }
                else
                    ncmds.Add(cmd);
            }
            block.Cmds = ncmds;
        }

        static int SuppressionCount = 0;

        // Suppress an input constraint
        public int SuppressInput(Expr input, string entrypoint)
        {
            // find main
            var main = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations,
                origMainName);

            // construct the assume
            var ret = SuppressionCount++;
            var req = new AssumeCmd(Token.NoToken, input);
            req.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.BlockingConstraintAttr, 
                new List<object> { Expr.Literal(ret) }, req.Attributes);

            // For mapback
            var tinfo = new cba.InsertionTrans();
            
            // find the call to the entrypoint and put the assume there
            var added = false;
            foreach (var block in main.Blocks)
            {
                tinfo.addTrans(main.Name, block.Label, block.Label);

                var ncmds = new List<Cmd>();
                var cnt = -1;
                foreach (var cmd in block.Cmds)
                {
                    var ccmd = cmd as CallCmd;
                    cnt++;
                    if (ccmd == null || ccmd.callee != entrypoint)
                    {
                        ncmds.Add(cmd);
                        tinfo.addTrans(main.Name, block.Label, cnt, cmd, 
                            block.Label, ncmds.Count - 1, new List<Cmd> { cmd });
                        continue;
                    }

                    added = true;
                    ncmds.Add(req);
                    ncmds.Add(cmd);
                    tinfo.addTrans(main.Name, block.Label, cnt, cmd,
                        block.Label, ncmds.Count - 1, new List<Cmd> { cmd });

                }
                block.Cmds = ncmds;
            }
            Debug.Assert(added);
            suppressInfo.Add(tinfo);
            return ret;
        }

        // Adds a new main:
        //   assertsPassed := true;
        //   call main();
        //   assert assertsPassed;
        string addMain(CBAProgram program)
        {
            var dup = new FixedDuplicator();
            var origMain = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            var newMain = dup.VisitImplementation(origMain);
            var newProc = dup.VisitProcedure(origMain.Proc);

            newMain.Name += "_SeqInstr";
            newProc.Name += "_SeqInstr";
            newMain.Proc = newProc;

            var mainIns = new List<Expr>();
            foreach (Variable v in newMain.InParams)
            {
                mainIns.Add(Expr.Ident(v));
            }
            var mainOuts = new List<IdentifierExpr>();
            foreach (Variable v in newMain.OutParams)
            {
                mainOuts.Add(Expr.Ident(v));
            }

            var callMain = new CallCmd(Token.NoToken, program.mainProcName, mainIns, mainOuts);
            callMain.Proc = origMain.Proc;

            var cmds = new List<Cmd>();
            cmds.Add(BoogieAstFactory.MkVarEqConst(assertsPassed, true));
            cmds.Add(callMain);
            cmds.Add(new AssertCmd(Token.NoToken, Expr.Ident(assertsPassed)));

            var blk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
            newMain.Blocks = new List<Block>();
            newMain.Blocks.Add(blk);

            program.AddTopLevelDeclaration(newProc);
            program.AddTopLevelDeclaration(newMain);

            program.mainProcName = newMain.Name;

            // Set entrypoint
            origMain.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Attributes);
            origMain.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Proc.Attributes);

            newMain.AddAttribute("entrypoint");

            return newMain.Name;
        }

       
        // goto label1, label2;
        //
        // label1:
        //   assume {:avn tok} !assertsPassed;
        //   return;
        //
        // label2:
        //   assume assertsPassed;
        //   goto lab;
        //
        // lab:
        //
        // Inputs: the list of blocks being constructed; the current block being constructed.
        // End current block and adds two new blocks.
        // Returns "lab".

        private string addInstr(List<Block> instrumented, List<Cmd> curr, string curr_label, int token)
        {
            string lbl1 = getNewLabel();
            string lbl2 = getNewLabel();

            List<String> ssp = new List<String> { lbl1, lbl2 };
            instrumented.Add(new Block(Token.NoToken, curr_label, curr, new GotoCmd(Token.NoToken, ssp)));

            string common_label = getNewLabel();
            // assume (!assertsPassed)
            AssumeCmd cmd1 = new AssumeCmd(Token.NoToken, Expr.Not(Expr.Ident(assertsPassed)));
            if(token >= 0)
                cmd1.Attributes = new QKeyValue(Token.NoToken, "avn", new List<object> { Expr.Literal(token) }, cmd1.Attributes);

            // assume (assertsPassed)
            AssumeCmd cmd2 = new AssumeCmd(Token.NoToken, Expr.Ident(assertsPassed));

            curr = new List<Cmd>();
            curr.Add(cmd1);
            instrumented.Add(new Block(Token.NoToken, lbl1, curr, new ReturnCmd(Token.NoToken)));

            curr = new List<Cmd>();
            curr.Add(cmd2);
            instrumented.Add(new Block(Token.NoToken, lbl2, curr, BoogieAstFactory.MkGotoCmd(common_label)));

            return common_label;
        }

        static int labelCnt = 0;

        static string getNewLabel()
        {
            labelCnt++;
            return "SeqInstr_" + labelCnt.ToString();
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last()); 
            assertInstrInfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }

        // Return the entrypoint (procedure called by harness)
        public string GetEntryPoint(cba.ErrorTrace cex, HashSet<string> IdentifiedEntryPoints)
        {
            if (Options.DeepAsserts)
            {
                foreach (var blk in cex.Blocks)
                {
                    var ep = da.EntryBlockToProc(blk.blockName);
                    if (ep != null && IdentifiedEntryPoints.Contains(ep)) return ep;
                }
                Debug.Assert(false);
            }

            // knock off top-level main, and then see what is called
            var OldMainName = (input as PersistentProgram).mainProcName;
            cba.ErrorTrace ptrace = null;
            foreach (var blk in cex.Blocks)
            {
                var c = blk.Cmds.OfType<cba.CallInstr>().FirstOrDefault(cmd => cmd.callee == OldMainName);
                if (c == null) continue;
                ptrace = c.calleeTrace;
                break;
            }
            Debug.Assert(ptrace != null);

            return
                ptrace.Blocks.Select(blk => blk.Cmds.OfType<cba.CallInstr>()).Aggregate((a, b) => a.Concat(b))
                .Where(ci => IdentifiedEntryPoints.Contains(ci.callee))
                .Select(ci => ci.callee)
                .FirstOrDefault();

        }
    }

    // Replace "assume x == NULL" with "assume x == NULL; assert false;"
    // provided x can indeed alias NULL
    public class InstrumentBranches
    {
        Program program;
        Dictionary<int, Function> id2Func;
        List<Function> queries;
        Function nullQuery;
        int id;

        InstrumentBranches(Program program)
        {
            this.program = program;
            queries = new List<Function>();
            id2Func = new Dictionary<int, Function>();
            nullQuery = null;
        }

        // Replace "assume x == NULL" with "assume x == NULL; assert false;"
        // provided x can indeed alias NULL
        public static PersistentProgram Run(PersistentProgram inp)
        {
            var program = inp.getProgram();
            var ib = new InstrumentBranches(program);
            ib.instrument(inp.mainProcName);

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

            // add the assert false
            var assertFlase = BoogieAstFactory.MkAssert(Expr.False);
            (assertFlase as AssertCmd).Attributes = new QKeyValue(Token.NoToken,
                "deadcode", new List<object>() { }, null);
            program = inp.getProgram();
            var id = 0;
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
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
                        if (!ib.id2Func.ContainsKey(id))
                            continue;
                        var asites = res.allocationSites[ib.id2Func[id].Name];
                        if (!asites.Contains(nil) && asites.Count  != 0)
                            ncmds.Add(assertFlase);
                    }
                    blk.Cmds = ncmds;

                }
            }

            return new PersistentProgram(program, inp.mainProcName, 0);
        }

        void instrument(string main)
        {
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

                    var func = GetQueryFunc();
                    id2Func.Add(id, func);
                    ncmds.Add(GetQuery(func, x));
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
            return new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr> { arg }));
        }
    }
}
