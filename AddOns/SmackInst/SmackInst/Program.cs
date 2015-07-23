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
        public static readonly HashSet<string> MallocNames = new HashSet<string>{ "$malloc", "$alloca" };
        public static readonly string allocVar = "$CurrAddr";

        public static bool initMem = false;

        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("usage: SmackInst.exe infile.bpl outfile.bpl [options]");
                return;
            }

            if (args.Any(a => a == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(a => a == "/initMem"))
                initMem = true;


            // initialize Boogie
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;


            // Read the input file
            var program = BoogieUtil.ReadAndResolve(args[0]);

            // Process it
            program = Process(program);

            // write the output
            BoogieUtil.PrintProgram(program, args[1]);
        }

        
        static Program Process(Program program)
        {
            // Get rid of Synonyms
            RemoveTypeSynonyms.Remove(program);
            //BoogieUtil.PrintProgram(program, "tt.bpl");
            program = BoogieUtil.ReResolve(program);

            // add "allocator" to malloc
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => MallocNames.Contains(p.Name))
                .Iter(p => p.AddAttribute("allocator"));

            // Create "null"
            var nil = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "NULL", btype.Int), false);
            nil.AddAttribute("allocated");

            // axiom NULL == 0;
            var ax = new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(nil), Expr.Literal(0)));

            // Convert 0 to NULL in the program
            ConvertToNull.Convert(program, nil);

            program.AddTopLevelDeclaration(nil);
            program.AddTopLevelDeclaration(ax);

            // Add "assert !aliasQ(e, NULL)" for each expression M[e] appearing in the program
            InstrumentMemoryAccesses.Instrument(program, nil);

            // Put {:scalar} {:AllocatorVar}  on $CurrAddr
            var alloc = program.TopLevelDeclarations.OfType<GlobalVariable>().Where(g => g.Name == allocVar)
                .FirstOrDefault();
            if (alloc != null)
            {
                alloc.AddAttribute("scalar");
                alloc.AddAttribute(AvUtil.AvnAnnotations.AllocatorVarAttr);
            }
            else
            {
                Console.WriteLine("Warning: Global variable $CurrAddr not found");
            }

            if (initMem)
                InitMemory(program);

            return program;
        }

        static void InitMemory(Program program)
        {
            // find curraddr
            var alloc = program.TopLevelDeclarations.OfType<GlobalVariable>().Where(g => g.Name == allocVar)
                .FirstOrDefault();
            if (alloc == null) return;

            // create alloc_init
            var allocinit = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                alloc.Name + "_init", alloc.TypedIdent.Type), false);

            // malloc ensures ret > alloc_init
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => MallocNames.Contains(p.Name))
                .Iter(p => p.Ensures.Add(new Ensures(false, Expr.Gt(Expr.Ident(p.OutParams[0]), Expr.Ident(allocinit)))));

            // forall x : int :: { M[x] } M[x] >= 0 && M[x] < alloc_init
            var initM = new Func<Variable, Expr>(M =>
                { 
                    var x = new BoundVariable(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Int));
                    var mx = BoogieAstFactory.MkMapAccessExpr(M, Expr.Ident(x));

                    return new ForallExpr(Token.NoToken, new List<TypeVariable>(),
                        new List<Variable> { x }, null, new Trigger(Token.NoToken, true, new List<Expr> { mx }),
                        Expr.And(Expr.Ge(mx, Expr.Literal(0)), Expr.Lt(mx, Expr.Ident(allocinit))));
                });

            var cmds = new List<Cmd>(
                program.TopLevelDeclarations.OfType<GlobalVariable>()
                .Where(g => g.Name.StartsWith("$M"))
                .Where(g => g.TypedIdent.Type.IsMap && (g.TypedIdent.Type as MapType).Result.IsInt)
                .Select(g => initM(g))
                .Select(e => new AssumeCmd(Token.NoToken, e)));

            // alloc_init > 0 && alloc > alloc_init
            cmds.Insert(0, new AssumeCmd(Token.NoToken,
                Expr.And(Expr.Gt(Expr.Ident(allocinit), Expr.Literal(0)), Expr.Gt(Expr.Ident(alloc), Expr.Ident(allocinit)))));

            var blk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
                    
            // create init proc
            var initproc = new Procedure(Token.NoToken, "SmackExtraInit", new List<TypeVariable>(), new List<Variable>(),
                new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
            initproc.AddAttribute(AvUtil.AvnAnnotations.InitialializationProcAttr);

            var initimpl = new Implementation(Token.NoToken, initproc.Name, new List<TypeVariable>(), new List<Variable>(),
                new List<Variable>(), new List<Variable>(), new List<Block>{ blk });

            program.AddTopLevelDeclaration(initproc);
            program.AddTopLevelDeclaration(initimpl);
            program.AddTopLevelDeclaration(allocinit);
        }
    }

    // Remove type synonyms of int
    class RemoveTypeSynonyms : StandardVisitor
    {
        HashSet<string> syns;

        private RemoveTypeSynonyms(HashSet<string> syns)
        {
            this.syns = syns;
        }

        public static void Remove(Program program)
        {
            var syns = FindSyn(program);
            var vs = new RemoveTypeSynonyms(syns);
            vs.VisitProgram(program);
        }

        static HashSet<string> FindSyn(Program program)
        {
            var syn = new HashSet<string>();
            foreach (var ty in program.TopLevelDeclarations.OfType<TypeSynonymDecl>())
            {
                if (ty.Body.IsInt)
                    syn.Add(ty.Name);
            }
            return syn;
        }

        public override Variable VisitVariable(Variable node)
        {
            if (syns.Contains(node.TypedIdent.Type.ToString()))
                node.TypedIdent.Type = btype.Int;

            return base.VisitVariable(node);
        }

    }

    // Convert 0 to NULL
    class ConvertToNull : StandardVisitor
    {
        Expr nil;
        HashSet<string> Zeros;

        public ConvertToNull(Constant nil, HashSet<string> Zeros)
        {
            this.nil = Expr.Ident(nil);
            this.Zeros = Zeros;
        }

        public static void Convert(Program program, Constant nil)
        {
            var cn = new ConvertToNull(nil, new HashSet<string>(FindZeros(program).Select(c => c.Name)));
            cn.VisitProgram(program);
        }

        static HashSet<Constant> FindZeros(Program program)
        {
            var ret = new HashSet<Constant>();
            var constants = program.TopLevelDeclarations.OfType<Constant>().ToList();
            foreach (var c in constants)
            {
                if (!c.Name.StartsWith("$0")) continue;
                var e = Expr.Eq(Expr.Ident(c), Expr.Literal(0));
                if (program.TopLevelDeclarations.OfType<Axiom>()
                    .Any(a => a.Expr.ToString() == e.ToString()))
                    ret.Add(c);
            }
            return ret;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl is Constant && Zeros.Contains((node.Decl as Constant).Name))
            {
                return nil;
            }

            return base.VisitIdentifierExpr(node);
        }

        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            if (node.Val is int && (int)node.Val == 0)
                return nil;
            if (node.Val is Microsoft.Basetypes.BigNum && ((Microsoft.Basetypes.BigNum)(node.Val)).IsZero)
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

			cmd.Lhss.Iter(e => reads.VisitExpr(e.AsExpr));
			cmd.Rhss.Iter(e => reads.VisitExpr(e));
            foreach (var tup in reads.accesses)
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
