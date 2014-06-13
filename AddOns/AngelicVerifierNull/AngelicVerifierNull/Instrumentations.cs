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

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    class Instrumentations
    {
        const string CORRAL_EXTRA_INIT_PROC = "corralExtraInit";

        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;
            Procedure mallocProcedure = null;
            bool useProvidedEntryPoints = false;
            public Dictionary<string, string> blockEntryPointConstants; //they guard assume false before calling e_i in the harness 
            public HashSet<string> entrypoints; // set of entrypoints identified

            public HarnessInstrumentation(Program program, string corralName, bool useProvidedEntryPoints)
            {
                prog = program;
                mainName = corralName;
                this.useProvidedEntryPoints = useProvidedEntryPoints;
                blockEntryPointConstants = new Dictionary<string,string>();
                entrypoints = new HashSet<string>();
            }
            public void DoInstrument()
            {
                FindMalloc();
                FindNULL();
                CreateMainProcedure();
                ChangeStubsIntoUnkowns();
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
                    Stats.numProcsAnalyzed++;
                    impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                    entrypoints.Add(impl.Name);

                    //allocate params
                    var args = new List<Variable>();
                    var rets = new List<Variable>();
                    impl.InParams.ForEach(v => args.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    impl.OutParams.ForEach(v => rets.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    locals.AddRange(args);
                    locals.AddRange(rets);
                    //call 
                    var blockCallConst = new Constant(Token.NoToken,
                        new TypedIdent(Token.NoToken, "__block_call_" + impl.Name, btype.Bool), false);
                    blockCallConsts.Add(blockCallConst);
                    blockEntryPointConstants[blockCallConst.Name] = impl.Name;
                    var blockCallAssumeCmd = new AssumeCmd(Token.NoToken, IdentifierExpr.Ident(blockCallConst)); 
                    var argMallocCmds = AllocatePointersAsUnknowns(args);
                    var callCmd = new CallCmd(Token.NoToken, impl.Name, args.ConvertAll(x => (Expr)IdentifierExpr.Ident(x)),
                        rets.ConvertAll(x => IdentifierExpr.Ident(x)));
                    var cmds = new List<Cmd>();
                    cmds.Add(blockCallAssumeCmd);
                    cmds.AddRange(argMallocCmds);
                    cmds.Add(callCmd);
                    //succ
                    var txCmd = new ReturnCmd(Token.NoToken);
                    var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                    mainBlocks.Add(blk);
                }
                //add the constants to the prog
                blockCallConsts.Iter(x => prog.TopLevelDeclarations.Add(x));
                //TODO: get globals of type refs/pointers and maps
                var initCmd = (AssumeCmd) BoogieAstFactory.MkAssume(Expr.True);
                //TODO: find a reusable API to add attributes to cmds
                initCmd.Attributes = new QKeyValue(Token.NoToken, ExplainError.Toplevel.CAPTURESTATE_ATTRIBUTE_NAME, new List<Object>() {"Start"}, null);
                var globalCmds = new List<Cmd>() { initCmd };
                globalCmds.AddRange(AllocatePointersAsUnknowns(prog.GlobalVariables().ConvertAll(x => (Variable)x)));
                //add call to corralExtraInit
                var inits = prog.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == CORRAL_EXTRA_INIT_PROC);
                if (inits.Count() > 0)
                    globalCmds.Add(BoogieAstFactory.MkCall(inits.First(), new List<Expr>(), new List<Variable>()));
                //first block
                var transferCmd =
                    mainBlocks.Count > 0 ? (TransferCmd)(new GotoCmd(Token.NoToken, mainBlocks)) : (TransferCmd) (new ReturnCmd(Token.NoToken));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalCmds, transferCmd);
                var blocks = new List<Block>();
                blocks.Add(blkStart);
                blocks.AddRange(mainBlocks);
                var mainProcImpl = BoogieAstFactory.MkImpl("CorralMain", new List<Variable>(), new List<Variable>(), locals, blocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.TopLevelDeclarations.AddRange(mainProcImpl);
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
                prog.TopLevelDeclarations.AddRange(stubImpls);
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
                return BoogieAstFactory.MkCall(mallocProcedure, 
                    new List<Expr>(){new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ONE)}, 
                    new List<Variable>() {x});
            }
            private List<Cmd> AllocatePointersAsUnknowns(List<Variable> vars)
            {
                return GetPointerVars(vars)
                    .Select(x => AllocatePointerAsUnknown(x)).ToList();
            }
            private void FindMalloc()
            {
                //find the malloc procedure
                mallocProcedure = (Procedure)prog.TopLevelDeclarations
                    .Where(x => x is Procedure && BoogieUtil.checkAttrExists("allocator", x.Attributes))
                    .FirstOrDefault();
                if (mallocProcedure == null)
                {
                    throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator} declared in the input program");
                }
                if (mallocProcedure.InParams.Count != 1)
                {
                    throw new InputProgramDoesNotMatchExn(String.Format("ABORT: malloc procedure {0} should have exactly 1 argument, found {1}",
                        mallocProcedure.Name, mallocProcedure.InParams.Count));
                }
            }
            private void FindNULL()
            {
                //find the malloc procedure
                var nulls = prog.TopLevelDeclarations
                    .Where(x => x is Constant && x.ToString().Equals("NULL"));
                if (!nulls.Any())
                    throw new InputProgramDoesNotMatchExn("ABORT: no NULL constant declared in the input program");
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
            public Dictionary<Tuple<string, string, int>, string> mallocTriggersLocation; //don't keep any objects (e.g. Function) since program changes

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
                    instance.mallocTriggersLocation = new Dictionary<Tuple<string, string, int>, string>();
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
                            instance.mallocTriggersLocation[Tuple.Create(currImpl.Name, currBlock.Label, callCmdCount)] = mallocTriggerFn.Name;
                            instance.prog.TopLevelDeclarations.Add(mallocTriggerFn);
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
                    instance.prog.TopLevelDeclarations.Add(guardConst);
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
    }
}
