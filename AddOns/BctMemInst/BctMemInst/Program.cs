using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;
using btype = Microsoft.Boogie.Type;
using System.Diagnostics;

namespace BctMemInst
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("BctMemInst.exe input.bpl output.bpl [args]");
                return;
            }

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.DoModSetAnalysis = true;

            var input = BoogieUtil.ReadAndResolve(args[0]);

            var output = Process(input);

            if(output != null)
                BoogieUtil.PrintProgram(output, args[1]);
        }

        public static GlobalVariable Freed = null;
        public static GlobalVariable Alloc = null;

        static Program Process(Program program)
        {
            // find null
            var nil = program.TopLevelDeclarations.OfType<Constant>().Where(g => g.Name == "null").FirstOrDefault();
            if (nil == null)
            {
                Console.WriteLine("Error: null not found in the input program");
                return null;
            }

            // Add Freed: [Ref] bool;
            Freed = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "FreedRef", new MapType(Token.NoToken, new List<TypeVariable>(), new List<btype> { nil.TypedIdent.Type },
                btype.Bool)));
            program.AddTopLevelDeclaration(Freed);

            // Find "Alloc" and add "assume !Freed[x];"
            var allocProc = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => impl.Name == "Alloc")
                .FirstOrDefault();
            Alloc = program.TopLevelDeclarations.OfType<GlobalVariable>()
                .Where(impl => impl.Name == "$Alloc")
                .FirstOrDefault();

            if (allocProc == null || Alloc == null)
            {
                Console.WriteLine("Error: Alloc procedure not found in the input program");
                return null;
            }
            var x = allocProc.OutParams[0];
            allocProc.Blocks[0].Cmds.Add(new AssumeCmd(Token.NoToken, 
                Expr.Not(BoogieAstFactory.MkMapAccessExpr(Freed, Expr.Ident(x)))));

            // Find System.Heap.Delete, add Freed[x] := true
            var freeProcs = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => impl.Name.StartsWith("System.Heap.Delete")).ToList();
            if (freeProcs.Count != 1)
            {
                Console.WriteLine("Error: Free procedure not found, or multiple found in the input program");
                return null;
            }
            x = freeProcs[0].InParams[0];
            freeProcs[0].Blocks[0].Cmds.Insert(0,
                BoogieAstFactory.MkMapAssign(Freed, Expr.Ident(x), Expr.Literal(true)));

            DesugarIte.Instrument(program);

            InstrumentMemoryAccesses.Instrument(program, nil);            

            return program;
        }

    }

    // Add "assert e != null && !Freed[e]" for each expression M[e] appearing in the program
    public class InstrumentMemoryAccesses
    {
        Expr nil;

        private InstrumentMemoryAccesses(Constant nil)
        {
            this.nil = Expr.Ident(nil);
        }

        public static void Instrument(Program program, Constant nil)
        {
            var im = new InstrumentMemoryAccesses(nil);

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(im.Instrument);
        }

        void Instrument(Implementation impl)
        {
            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (Cmd cmd in block.Cmds)
                {
                    // remove "assume x != null" statements
                    if (IsAssumeNonNull(cmd)) continue;

                    if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd));
                    else if (cmd is AssumeCmd) newcmds.AddRange(ProcessAssume(cmd as AssumeCmd));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    else newcmds.Add(cmd);
                }
                block.Cmds = newcmds;
            }

        }


        // assert e != null && $Alloc[e] && !Freed[e]; assume e != null
        List<Cmd> MkAssert(Expr e)
        {
            return new List<Cmd> {
                new AssertCmd(Token.NoToken, Expr.Neq(e, nil)),
                new AssertCmd(Token.NoToken, BoogieAstFactory.MkMapAccessExpr(Driver.Alloc, e)),
                new AssertCmd(Token.NoToken, Expr.Not(BoogieAstFactory.MkMapAccessExpr(Driver.Freed, e))),
                new AssumeCmd(Token.NoToken, Expr.Neq(e, nil)),
                new AssumeCmd(Token.NoToken, BoogieAstFactory.MkMapAccessExpr(Driver.Alloc, e)),
                new AssumeCmd(Token.NoToken, Expr.Not(BoogieAstFactory.MkMapAccessExpr(Driver.Freed, e))),
            };
        }

        List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            var gm = new GatherMemAccesses();
            cmd.Ins.Where(e => e != null).Iter(e => gm.VisitExpr(e));

            foreach (var tup in gm.accesses)
            {
                ret.AddRange(MkAssert(tup.Item2));
            }
            ret.Add(cmd);

            return ret;
        }

        List<Cmd> ProcessAssume(AssumeCmd cmd)
        {
            var ret = new List<Cmd>();

            var gm = new GatherMemAccesses();
            gm.VisitExpr(cmd.Expr);
            foreach (var tup in gm.accesses)
            {
                ret.AddRange(MkAssert(tup.Item2));
            }
            ret.Add(cmd);
            return ret;
        }

        List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();

            var reads = new GatherMemAccesses();

            cmd.Lhss.Iter(e => reads.VisitExpr(e.AsExpr));
            cmd.Rhss.Iter(e => reads.VisitExpr(e));
            foreach (var tup in reads.accesses)
            {
                ret.AddRange(MkAssert(tup.Item2));
            }

            ret.Add(cmd);

            return ret;
        }

        bool IsAssumeNonNull(Cmd cmd)
        {
            var acmd = cmd as AssumeCmd;
            if (acmd == null) return false;

            if (BoogieUtil.checkAttrExists("partition", acmd.Attributes))
                return false;

            var expr = acmd.Expr as NAryExpr;
            if (expr == null) return false;

            var exprIsNull = new Predicate<Expr>(e =>
            {
                return (e is IdentifierExpr) && (e as IdentifierExpr).Name == "null";
            });

            if (expr.Fun is BinaryOperator && (expr.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Neq &&
                (exprIsNull(expr.Args[0]) || exprIsNull(expr.Args[1])))
            {
                return true;
            }
            return false;

        }
    }


    public class GatherMemAccesses : FixedVisitor
    {
        public List<Tuple<Variable, Expr>> accesses;
        public GatherMemAccesses()
        {
            accesses = new List<Tuple<Variable, Expr>>();
        }

        public override Expr VisitForallExpr(ForallExpr node)
        {
            return node;
        }

        public override Expr VisitExistsExpr(ExistsExpr node)
        {
            return node;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is MapSelect && node.Args.Count == 2 && node.Args[0] is IdentifierExpr &&
                (node.Args[0] as IdentifierExpr).Decl.Name != "$Alloc" &&
                (node.Args[0] as IdentifierExpr).Decl.Name != Driver.Freed.Name &&
                node.Args[1].Type.ToString() == "Ref") 
            {
                accesses.Add(Tuple.Create((node.Args[0] as IdentifierExpr).Decl, node.Args[1]));
            }

            return base.VisitNAryExpr(node);
        }
    }

    public class DesugarIte : StandardVisitor
    {
        int counterVar;
        int counterBlock;
        List<Tuple<Variable, Expr>> IteExprs;
        List<Variable> newVars;

        DesugarIte()
        {
            counterVar = 0;
            counterBlock = 0;
            IteExprs = new List<Tuple<Variable, Expr>>();
            newVars = new List<Variable>();
        }

        void Reset()
        {
            IteExprs = new List<Tuple<Variable, Expr>>();
        }

        public static void Instrument(Program program)
        {
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var obj = new DesugarIte();
                obj.Instrument(impl);
                obj.Desugar(impl);
                impl.LocVars.AddRange(obj.newVars);
            }
        }

        void Instrument(Implementation impl)
        {
            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (Cmd cmd in block.Cmds)
                {
                    if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd));
                    else if (cmd is AssumeCmd) newcmds.AddRange(ProcessAssume(cmd as AssumeCmd));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    else newcmds.Add(cmd);
                }
                block.Cmds = newcmds;
            }
        }

        void Desugar(Implementation impl)
        {
            var newBlocks = new List<Block>();
            var newVars = new List<Variable>();

            foreach (var block in impl.Blocks)
            {
                var currBlock = new Block(Token.NoToken, block.Label, new List<Cmd>(), null);
                var currCmds = new List<Cmd>();

                foreach (var cmd in block.Cmds)
                {
                    var acmd = cmd as AssignCmd;
                    if (acmd == null || !acmd.Lhss[0].DeepAssignedVariable.Name.StartsWith("mem_inst_tmp_"))
                    {
                        currCmds.Add(cmd);
                        continue;
                    }

                    Debug.Assert(acmd.Rhss.Count == 1);
                    var ite = acmd.Rhss[0] as NAryExpr;
                    Debug.Assert(ite != null && ite.Fun is IfThenElse);

                    Desugar((acmd.Lhss[0] as SimpleAssignLhs).AssignedVariable.Decl,
                        ite.Args[0], ite.Args[1], ite.Args[2], ref currCmds, ref currBlock, newBlocks);
                }

                currBlock.Cmds = currCmds;
                currBlock.TransferCmd = block.TransferCmd;
                newBlocks.Add(currBlock);
            }

            impl.Blocks = newBlocks;
            impl.LocVars.AddRange(newVars);
        }

        void Desugar(Variable lhs, Expr cond, Expr then, Expr els, ref List<Cmd> currCmds, ref Block currBlock, List<Block> newBlocks)
        {
            // create three new blocks
            var lab1 = GetNewLabel();
            var lab2 = GetNewLabel();
            var lab3 = GetNewLabel();

            var tmp = CreateTmp(btype.Bool);

            currCmds.Add(BoogieAstFactory.MkVarEqExpr(tmp, cond));

            // end current block
            currBlock.Cmds = currCmds;
            currBlock.TransferCmd = new GotoCmd(Token.NoToken, new List<string> { lab1, lab2 });
            newBlocks.Add(currBlock);


            var blk1 = new Block(Token.NoToken, lab1, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(lab3));
            var blk2 = new Block(Token.NoToken, lab2, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(lab3));

            blk1.Cmds.AddRange(
                new List<Cmd> {
                    BoogieAstFactory.MkAssume(Expr.Ident(tmp)),
                    BoogieAstFactory.MkVarEqExpr(lhs, then)
                });

            blk2.Cmds.AddRange(
                new List<Cmd> {
                    BoogieAstFactory.MkAssume(Expr.Not(Expr.Ident(tmp))),
                    BoogieAstFactory.MkVarEqExpr(lhs, els)
                });

            newBlocks.Add(blk1);
            newBlocks.Add(blk2);

            currBlock = new Block(Token.NoToken, lab3, new List<Cmd>(), null);
            currCmds = new List<Cmd>();
        }


        List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();

            for (int i = 0; i < cmd.Rhss.Count; i++)
            {
                Reset();
                var expr = base.VisitExpr(cmd.Rhss[i]);
                cmd.SetAssignCmdRhs(i, expr);
                ret.AddRange(GetTmpAssignments());
            }

            ret.Add(cmd);

            return ret;
        }

        List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            for (int i = 0; i < cmd.Ins.Count; i++)
            {
                Reset();
                var expr = base.VisitExpr(cmd.Ins[i]);
                cmd.Ins[i] = expr;
                ret.AddRange(GetTmpAssignments());
            }

            ret.Add(cmd);

            return ret;
        }

        List<Cmd> ProcessAssume(AssumeCmd cmd)
        {
            var ret = new List<Cmd>();

            Reset();
            var expr = base.VisitExpr(cmd.Expr);
            ret.AddRange(GetTmpAssignments());
            cmd.Expr = expr;
            ret.Add(cmd);

            return ret;
        }

        List<Cmd> GetTmpAssignments()
        {
            var ret = new List<Cmd>();
            foreach (var tup in IteExprs)
            {
                ret.Add(new AssignCmd(Token.NoToken,
                    new List<AssignLhs> { new SimpleAssignLhs(Token.NoToken, Expr.Ident(tup.Item1)) },
                    new List<Expr> { tup.Item2 }));
            }
            return ret;
        }

        string GetNewLabel()
        { 
            return "mem_inst_blk_" + (counterBlock++);
        }

        Variable CreateTmp(btype type)
        {
            var v = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "mem_inst_tmp_" + (counterVar++), type));
            newVars.Add(v);
            return v;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var rnode = base.VisitNAryExpr(node) as NAryExpr;

            if (rnode.Fun is IfThenElse)
            {
                var tmp = CreateTmp(rnode.Type);
                IteExprs.Add(Tuple.Create(tmp, rnode as Expr));

                return Expr.Ident(tmp);
            }

            return rnode;            
        }
    }
}
