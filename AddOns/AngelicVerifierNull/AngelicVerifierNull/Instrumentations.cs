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
                CreateMainProcedure();
                ChangeStubsIntoFunkyMalloc();
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
                    var argMallocCmds = FunkyAllocatePointers(args);
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
                var globalMallocCmds = FunkyAllocatePointers(prog.GlobalVariables().ConvertAll(x => (Variable)x));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalMallocCmds, new GotoCmd(Token.NoToken, mainBlocks));
                mainBlocks.Add(blkStart);
                var mainProcImpl = BoogieAstFactory.MkImpl("CorralMain", new List<Variable>(), new List<Variable>(), locals, mainBlocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.TopLevelDeclarations.AddRange(mainProcImpl);
            }

            //Change the body of any stub that returns a pointer into calling malloc()
            //TODO: only do this for procedures with a single return with a pointer type
            private void ChangeStubsIntoFunkyMalloc()
            {
                var procsWithImpl = prog.TopLevelDeclarations.OfType<Implementation>()
                    .Select(x => x.Proc);
                var procs = prog.TopLevelDeclarations.OfType<Procedure>();
                //TODO: this can be almost quadratic in the size of |Procedures|, cleanup
                var procsWithoutImpl = procs.Where(x => !procsWithImpl.Contains(x));
                var stubImpls = new List<Implementation>();
                foreach (var p in procsWithoutImpl)
                {
                    if (QKeyValue.FindBoolAttribute(p.Attributes, "allocator")) continue; 
                    if (p.OutParams.Count == 1 &&
                        IsPointerVariable(p.OutParams[0]))
                    {
                        var retMallocCmds = FunkyAllocatePointers(p.OutParams);
                        var blk = BoogieAstFactory.MkBlock(retMallocCmds, new ReturnCmd(Token.NoToken));
                        var blks = new List<Block>() { blk };
                        var impl = BoogieAstFactory.MkImpl(p.Name, p.InParams, p.OutParams, new List<Variable>(), blks);
                        //don't insert the proc as it already exists
                        stubImpls.Add((Implementation) impl[1]);
                    }
                }
                prog.TopLevelDeclarations.AddRange(stubImpls);
            }
            private List<Cmd> FunkyAllocatePointers(List<Variable> vars)
            {
                return GetPointerVars(vars)
                    .ConvertAll(x => BoogieAstFactory.MkCall(mallocProcedure, new List<Expr>(), new List<Variable>() { x }));
            }
            private void FindMalloc()
            {
                //find the malloc procedure
                mallocProcedure = (Procedure)prog.TopLevelDeclarations
                    .Where(x => x is Procedure && QKeyValue.FindBoolAttribute(x.Attributes, "allocator"))
                    .FirstOrDefault();
                if (mallocProcedure == null)
                {
                    mallocProcedure = (Procedure)BoogieAstFactory.MkProc("malloc",
                        new List<Variable>(),
                        new List<Variable>() { BoogieAstFactory.MkFormal("ret", btype.Int, false) });
                    mallocProcedure.AddAttribute("allocator");
                    prog.TopLevelDeclarations.Add(mallocProcedure);
                }
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
                return x.TypedIdent.Type.IsInt;
            }
        }

    }
}
