using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;

namespace SmackInst
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length != 2)
            {
                Console.WriteLine("usage: SmackInst.exe infile.bpl outfile.bpl");
                return;
            }

            // initialize Boogie
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;


            // Read the input file
            var program = BoogieUtil.ReadAndResolve(args[0]);

            // Process it
            Process(program);

            // write the output
            BoogieUtil.PrintProgram(program, args[1]);
        }

        
        static void Process(Program program)
        {
            // add "allocator" to malloc
            var malloc = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => p.Name == "malloc")
                .FirstOrDefault();
            if (malloc != null)
            {
                malloc.AddAttribute("allocator");
            }

            // Create "null"
            var nil = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "NULL", btype.Int), false);
            nil.AddAttribute("allocated");

            // axiom NULL == 0;
            var ax = new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(nil), Expr.Literal(0)));

            program.AddTopLevelDeclaration(nil);
            program.AddTopLevelDeclaration(ax);

            // Convert 0 to NULL in the program
            ConvertToNull.Convert(program, nil);

            // Add "assert !aliasQ(e, NULL)" for each expression M[e] appearing in the program
            InstrumentMemoryAccesses.Instrument(program, nil);
        }


    }

    // Convert 0 to NULL
    class ConvertToNull : StandardVisitor
    {
        Expr nil;

        public ConvertToNull(Constant nil)
        {
            this.nil = Expr.Ident(nil);
        }

        public static void Convert(Program program, Constant nil)
        {
            var cn = new ConvertToNull(nil);
            cn.VisitProgram(program);
        }

        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            if (node.Val is int && (int)node.Val == 0)
                return nil;
            return base.VisitLiteralExpr(node);
        }
    }


    // Add "assert !aliasQ(e, NULL)" for each expression M[e] appearing in the program
    public class InstrumentMemoryAccesses
    {
        Expr nil;
        List<Function> aliasQfuncs;
        int counter;

        private InstrumentMemoryAccesses(Constant nil)
        {
            this.nil = Expr.Ident(nil);
            this.aliasQfuncs = new List<Function>();
            this.counter = 0;
        }

        public static void Instrument(Program program, Constant nil)
        {
            var im = new InstrumentMemoryAccesses(nil);

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(im.Instrument);

            program.AddTopLevelDeclarations(im.aliasQfuncs);
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


        // assert !aliasQ(e, NULL)
        AssertCmd MkAssert(Expr e)
        {
            var a = BoogieAstFactory.MkFormal("a", btype.Int, true);
            var b = BoogieAstFactory.MkFormal("b", btype.Int, true);
            var f = new Function(Token.NoToken, "aliasQ" + (counter++),
                new List<Variable> { a, b },
                BoogieAstFactory.MkFormal("c", btype.Bool, false));
            f.AddAttribute("aliasingQuery");
            f.AddAttribute("inline");
            f.Body = Expr.Eq(Expr.Ident(a), Expr.Ident(b));

            aliasQfuncs.Add(f);

            return new AssertCmd(Token.NoToken, Expr.Not(new NAryExpr(Token.NoToken, new FunctionCall(f), new List<Expr> { e, nil })));
        }

        List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            var gm = new GatherMemAccesses();
            cmd.Ins.Where(e => e != null).Iter(e => gm.VisitExpr(e));

            foreach (var tup in gm.accesses)
            {
                ret.Add(MkAssert(tup.Item2));
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
                ret.Add(MkAssert(tup.Item2));
            }
            ret.Add(cmd);
            return ret;
        }

        List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();

            var reads = new GatherMemAccesses();

            cmd.Rhss.Iter(e => reads.VisitExpr(e));
            foreach (var tup in reads.accesses)
            {
                ret.Add(MkAssert(tup.Item2));
            }

            var gm = new GatherMemAccesses();
            foreach (var lhs in cmd.Lhss)
            {
                if (lhs is MapAssignLhs)
                {
                    var ma = lhs as MapAssignLhs;
                    ma.Indexes.Iter(e => gm.VisitExpr(e));
                }

            }

            foreach (var tup in gm.accesses)
            {
                ret.Add(MkAssert(tup.Item2));
            }

            ret.Add(cmd);

            return ret;
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
            if (node.Fun is MapSelect && node.Args.Count == 2 && node.Args[0] is IdentifierExpr)
            {
                accesses.Add(Tuple.Create((node.Args[0] as IdentifierExpr).Decl, node.Args[1]));
            }

            return base.VisitNAryExpr(node);
        }
    }

}
