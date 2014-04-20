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
        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;
            Procedure mallocProcedure = null;

            public HarnessInstrumentation(Program program, string corralName)
            {
                prog = program;
                mainName = corralName;
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
                foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
                {
                    //allocate params
                    var args = new List<Variable>();
                    var rets = new List<Variable>();
                    impl.InParams.ForEach(v => args.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    impl.OutParams.ForEach(v => rets.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    locals.AddRange(args);
                    locals.AddRange(rets);
                    //call 
                    var argMallocCmds = AllocatePointersAsUnknowns(args);
                    var callCmd = new CallCmd(Token.NoToken, impl.Name, args.ConvertAll(x => (Expr)IdentifierExpr.Ident(x)),
                        rets.ConvertAll(x => IdentifierExpr.Ident(x)));
                    var cmds = argMallocCmds;
                    cmds.Add(callCmd);
                    //succ
                    var txCmd = new ReturnCmd(Token.NoToken);
                    var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                    mainBlocks.Add(blk);
                }
                //TODO: get globals of type refs/pointers
                var initCmd = (AssumeCmd) BoogieAstFactory.MkAssume(Expr.True);
                //TODO: find a reusable API to add attributes to cmds
                initCmd.Attributes = new QKeyValue(Token.NoToken, ExplainError.Toplevel.CAPTURESTATE_ATTRIBUTE_NAME, new List<Object>() {"Start"}, null);
                var globalCmds = new List<Cmd>() { initCmd };
                globalCmds.AddRange(AllocatePointersAsUnknowns(prog.GlobalVariables().ConvertAll(x => (Variable)x)));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalCmds, new GotoCmd(Token.NoToken, mainBlocks));
                var blocks = new List<Block>();
                blocks.Add(blkStart);
                blocks.AddRange(mainBlocks);
                var mainProcImpl = BoogieAstFactory.MkImpl("CorralMain", new List<Variable>(), new List<Variable>(), locals, blocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.TopLevelDeclarations.AddRange(mainProcImpl);
            }

            //Change the body of any stub that returns a pointer into calling malloc()
            //TODO: only do this for procedures with a single return with a pointer type
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
                    if (p.OutParams.Count == 1 &&
                        IsPointerVariable(p.OutParams[0]))
                    {
                        var retMallocCmds = AllocatePointersAsUnknowns(p.OutParams);
                        var blk = BoogieAstFactory.MkBlock(retMallocCmds, new ReturnCmd(Token.NoToken));
                        var blks = new List<Block>() { blk };
                        var impl = BoogieAstFactory.MkImpl(p.Name, p.InParams, p.OutParams, new List<Variable>(), blks);
                        //don't insert the proc as it already exists
                        stubImpls.Add((Implementation) impl[1]);
                    }
                }
                prog.TopLevelDeclarations.AddRange(stubImpls);
            }
            private List<Cmd> AllocatePointersAsUnknowns(List<Variable> vars)
            {
                return GetPointerVars(vars)
                    .ConvertAll(x => BoogieAstFactory.MkCall(mallocProcedure, new List<Expr>(), new List<Variable>() { x }));
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
                    #region deprecated
                    //mallocProcedure = (Procedure)BoogieAstFactory.MkProc("malloc",
                    //    new List<Variable>(),
                    //    new List<Variable>() { BoogieAstFactory.MkFormal("ret", btype.Int, false) });
                    //mallocProcedure.AddAttribute("allocator");
                    //prog.TopLevelDeclarations.Add(mallocProcedure);
                    #endregion
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
                    !BoogieUtil.checkAttrExists("non-pointer", x.Attributes); //to reduce clutter, perhaps only a few ints are non-pointers
            }
        }

        public class MallocInstrumentation
        {
            Program prog;

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
                MallocInstrumentation instance;
                public Dictionary<CallCmd, Function> mallocTriggers;
                public MallocInstrumentVisitor(MallocInstrumentation mi)
                {
                    instance = mi;
                    mallocTriggers = new Dictionary<CallCmd, Function>();
                }
                public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
                {
                    var newCmdSeq = new List<Cmd>();
                    foreach (Cmd c in cmdSeq)
                    {
                        var callCmd = c as CallCmd;
                        if (callCmd != null && BoogieUtil.checkAttrExists("allocator", callCmd.Proc.Attributes))
                        {
                            var retCall = callCmd.Outs[0];
                            var mallocTriggerFn = new Function(Token.NoToken, "mallocTrigger_" + mallocTriggers.Count,
                                new List<Variable>() { BoogieAstFactory.MkFormal("a", btype.Int, false) },
                                BoogieAstFactory.MkFormal("r", btype.Bool, false));
                            mallocTriggers[callCmd] = mallocTriggerFn;
                            instance.prog.TopLevelDeclarations.Add(mallocTriggerFn);
                            var fnApp = new NAryExpr(Token.NoToken,
                                new FunctionCall(mallocTriggerFn),
                                new List<Expr> () {retCall});
                            newCmdSeq.Add(BoogieAstFactory.MkAssume(fnApp)); //TODO: change it to a predicate
                        }
                        newCmdSeq.Add(c);
                    }
                    return base.VisitCmdSeq(newCmdSeq);
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
    }
}
