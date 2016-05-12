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
        public static readonly HashSet<string> MallocNames = new HashSet<string>{ "malloc", "$alloc" };
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
            CommandLineOptions.Clo.DoModSetAnalysis = true;


            // Read the input file
            var program = BoogieUtil.ReadAndResolve(args[0], false);
            // SMACK does not add globals to modify clauses
            //BoogieUtil.DoModSetAnalysis(program);

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
            program = BoogieUtil.ReResolveInMem(program, false);

			// Remove literal constants
			var CE = new ConstantElimination ();
			CE.Run (program);
			// inline functions
			InlineFunctions(program);

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
                //alloc.AddAttribute("scalar");
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

		// Inline functions with {:inline true} attribute
		// borrow code from Symbooglix transform passes
		static void InlineFunctions(Program prog)
		{
			Predicate<Function> Condition = f => QKeyValue.FindBoolAttribute(f.Attributes, "inline");
			var functionInlingVisitor = new FunctionInlingVisitor(Condition);

			// Apply to axioms
			foreach (var axiom in prog.TopLevelDeclarations.OfType<Axiom>())
			{
				functionInlingVisitor.Visit(axiom);
			}

			// Apply to each Procedure's requires and ensures
			foreach (var procedure in prog.TopLevelDeclarations.OfType<Procedure>())
			{
				foreach (var ensures in procedure.Ensures)
				{
					functionInlingVisitor.Visit(ensures);
				}

				foreach (var requires in procedure.Requires)
				{
					functionInlingVisitor.Visit(requires);
				}
			}

			// Apply to functions too, is this correct??
			foreach (var function in prog.TopLevelDeclarations.OfType<Function>())
			{
				if (function.Body != null)
				{
					function.Body = functionInlingVisitor.Visit(function.Body) as Expr;
				}
			}

			// Apply to Commands in basic blocks
			foreach (var basicBlock in prog.Blocks())
			{
				functionInlingVisitor.Visit(basicBlock);
			}
		}

        static void InitMemory(Program program)
        {
            // find curraddr
            var alloc = program.TopLevelDeclarations.OfType<GlobalVariable>().Where(g => g.Name == allocVar)
                .FirstOrDefault();
            if (alloc == null) return;

            // create alloc_init
            //var allocinit = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
            //    alloc.Name + "_init", alloc.TypedIdent.Type), false);

            // malloc ensures ret > alloc_init
            //program.TopLevelDeclarations.OfType<Procedure>()
            //    .Where(p => MallocNames.Contains(p.Name))
            //    .Iter(p => p.Ensures.Add(new Ensures(false, Expr.Gt(Expr.Ident(p.OutParams[0]), Expr.Ident(allocinit)))));

            // forall x : int :: { M[x] } M[x] >= 0 && M[x] < alloc_init
            //var initM = new Func<Variable, Expr>(M =>
            //    { 
            //        var x = new BoundVariable(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Int));
            //        var mx = BoogieAstFactory.MkMapAccessExpr(M, Expr.Ident(x));
			//
            //        return new ForallExpr(Token.NoToken, new List<TypeVariable>(),
            //            new List<Variable> { x }, null, new Trigger(Token.NoToken, true, new List<Expr> { mx }),
            //            Expr.And(Expr.Ge(mx, Expr.Literal(0)), Expr.Lt(mx, Expr.Ident(allocinit))));
            //    });

            //var cmds = new List<Cmd>(
            //    program.TopLevelDeclarations.OfType<GlobalVariable>()
            //    .Where(g => g.Name.StartsWith("$M"))
            //    .Where(g => g.TypedIdent.Type.IsMap && (g.TypedIdent.Type as MapType).Result.IsInt)
            //    .Select(g => initM(g))
            //    .Select(e => new AssumeCmd(Token.NoToken, e)));

            // alloc_init > 0 && alloc > alloc_init
            //cmds.Insert(0, new AssumeCmd(Token.NoToken,
            //    Expr.And(Expr.Gt(Expr.Ident(allocinit), Expr.Literal(0)), Expr.Gt(Expr.Ident(alloc), Expr.Ident(allocinit)))));

			var cmds = new List<Cmd>();
			cmds.Add(new AssumeCmd(Token.NoToken, Expr.Gt (Expr.Ident (alloc), Expr.Literal (0))));
            var blk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
                    
            // create init proc
            var initproc = new Procedure(Token.NoToken, "SmackExtraInit", new List<TypeVariable>(), new List<Variable>(),
                new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
            initproc.AddAttribute(AvUtil.AvnAnnotations.InitialializationProcAttr);
			//initproc.Ensures.Add(new Ensures(true, Expr.Gt(Expr.Ident(alloc), Expr.Literal (0))));
            var initimpl = new Implementation(Token.NoToken, initproc.Name, new List<TypeVariable>(), new List<Variable>(),
                new List<Variable>(), new List<Variable>(), new List<Block>{ blk });

            program.AddTopLevelDeclaration(initproc);
            program.AddTopLevelDeclaration(initimpl);
            //program.AddTopLevelDeclaration(allocinit);
        }
    }

	public class FunctionInlingVisitor : StandardVisitor
	{
		private Predicate<Function> Condition;
		public int InlineCounter
		{
			get;
			private set;
		}
		public FunctionInlingVisitor(Predicate<Function> condition)
		{
			this.Condition = condition;
			InlineCounter = 0;
		}

		public override Expr VisitNAryExpr(NAryExpr node)
		{
			if (!(node.Fun is FunctionCall))
				return base.VisitNAryExpr(node);

			var FC = node.Fun as FunctionCall;

			// Can't inline SMTLIBv2 functions
			if (QKeyValue.FindStringAttribute(FC.Func.Attributes, "bvbuiltin") != null)
				return base.VisitNAryExpr(node);

			if (Condition(FC.Func))
			{
				if (FC.Func.Body == null)
					throw new InvalidOperationException("Can't inline a function without a body");

				// Compute mapping
				var varToExprMap = new Dictionary<Variable,Expr>();
				foreach (var parameterArgumentPair in FC.Func.InParams.Zip(node.Args))
				{
					varToExprMap.Add(parameterArgumentPair.Item1, parameterArgumentPair.Item2);
				}

				// Using Closure :)
				Substitution sub = delegate(Variable v)
				{
					try
					{
						return varToExprMap[v];
					}
					catch (KeyNotFoundException)
					{
						// The substituter seems to expect null being
						// returned if we don't want to change the variable
						return null;
					}
				};

				// Return the Function expression with variables substituted for function arguments.
				// This is basically inling
				++InlineCounter;
				var result= Substituter.Apply(sub, FC.Func.Body);

				// Make sure we visit the result because it may itself contain function calls
				return (Expr) base.Visit(result);
			}
			else
				return base.VisitNAryExpr(node);
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

	// Literal constants elimination pass
	class ConstantElimination: StandardVisitor
	{
		private Dictionary<String, Expr> consts;

		public ConstantElimination()
		{
			consts = new Dictionary<string, Expr> ();
		}

		public override Expr VisitIdentifierExpr (IdentifierExpr node)
		{
			if (node.Decl is Constant && consts.ContainsKey(node.Name))
			    return consts[node.Name];
			else
			    return base.VisitIdentifierExpr(node);
		}
	
		public void Run(Program prog)
		{
			HashSet<string> constNames = new HashSet<string>(prog.TopLevelDeclarations.OfType<Constant>().Select(c => c.Name));
			HashSet<Axiom> axiomsToDelete = new HashSet<Axiom>();
			HashSet<string> constsToDelete = new HashSet<string>();
			foreach (var ax in prog.TopLevelDeclarations.OfType<Axiom>().Where(axi => axi.Expr is NAryExpr && (axi.Expr as NAryExpr).Fun.FunctionName == "==")) {
				var axExpr = ax.Expr as NAryExpr;
				var lhsName = axExpr.Args[0].ToString();
				var rhs = axExpr.Args[1];
				if (constNames.Contains(lhsName) && rhs is LiteralExpr) {
					consts [lhsName] = rhs;
					axiomsToDelete.Add (ax);
					constsToDelete.Add (lhsName);
				}
			}
			prog.RemoveTopLevelDeclarations(x => x is Constant && constsToDelete.Contains((x as Constant).Name));
			prog.RemoveTopLevelDeclarations(ax => ax is Axiom && axiomsToDelete.Contains(ax as Axiom));
			VisitProgram (prog);
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
			var varDecls = new Dictionary<string, string>();
			var cb = new CollectBasePointer(varDecls);
			cb.VisitImplementation(impl);
            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (Cmd cmd in block.Cmds)
                {
                    if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd, varDecls));
                    else if (cmd is AssumeCmd) newcmds.AddRange(ProcessAssume(cmd as AssumeCmd, varDecls));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd, varDecls));
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

		List<Cmd> ProcessCall(CallCmd cmd, Dictionary<string, string> varDecls)
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

		List<Cmd> ProcessAssume(AssumeCmd cmd, Dictionary<string, string> varDecls)
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

		List<Cmd> ProcessAssign(AssignCmd cmd, Dictionary<string, string> varDecls)
        {
            var ret = new List<Cmd>();

            var reads = new GatherMemAccesses();

			cmd.Lhss.Iter(e => reads.VisitExpr(e.AsExpr));
			cmd.Rhss.Iter(e => reads.VisitExpr(e));
            foreach (var tup in reads.accesses)
            {
				var ptr = tup.Item2;
				string basePtr;
				if (varDecls.TryGetValue(ptr.ToString(), out basePtr))
					ret.Add (MkAssert (Expr.Ident(BoogieAstFactory.MkFormal (basePtr, btype.Int, true))));
				else
					ret.Add(MkAssert(ptr));
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
            // we have two forms of map operation to take care
            // the first is map select
            // the second is map store
            if (((node.Fun is MapSelect && node.Args.Count == 2) || (node.Fun is MapStore && node.Args.Count == 3)) && node.Args[0] is IdentifierExpr)
            {
                // All memory regions are in form of $M.d+
                if (node.Args[0].ToString().Contains("$M"))
                  accesses.Add(Tuple.Create((node.Args[0] as IdentifierExpr).Decl, node.Args[1]));
            }

            return base.VisitNAryExpr(node);
        }
    }

	public class CollectBasePointer : FixedVisitor
	{
		public Dictionary<string, string> varDecls;

		public CollectBasePointer(Dictionary<string, string> varDecls)
		{
			this.varDecls = varDecls;
		}

		public override LocalVariable VisitLocalVariable (LocalVariable node)
		{
			if (node.FindStringAttribute ("base") != null) {
				varDecls [node.Name] = node.FindStringAttribute ("base");
				// TODO: figure out how to remove attributes
				//node.Attributes = node.Attributes.Next;
			}
 			return node;
		}
	}

}
