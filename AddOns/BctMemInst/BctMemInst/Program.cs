using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;
using btype = Microsoft.Boogie.Type;

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
                new AssertCmd(Token.NoToken, Expr.And(new List<Expr> {
                    Expr.Neq(e, nil),
                    BoogieAstFactory.MkMapAccessExpr(Driver.Alloc, e),
                    Expr.Not(BoogieAstFactory.MkMapAccessExpr(Driver.Freed, e))
                })),
                new AssumeCmd(Token.NoToken, Expr.Neq(e, nil))
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

}
