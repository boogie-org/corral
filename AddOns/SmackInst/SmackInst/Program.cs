using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using System.Text.RegularExpressions;

namespace SmackInst
{
    class Driver
    {
        public static readonly HashSet<string> MallocNames = new HashSet<string>{ "malloc", "$alloc" };
        public static readonly string allocVar = "$CurrAddr";

        public static bool initMem = false;

        public static string oldRoot = "";
        public static string newRoot = "";
        public static bool replaceRoot = false;

        public static bool count = false;
        public static bool onlyCount = false;
        public static bool checkNULL = false;
        public static bool checkUAF = false;
        public static bool printCallGraph = false;

        public static bool detectDeadCode = false;

        public static bool checkMemSafety = false;

        public static bool visualizeHeap = false;
        public static string chakraTypeConfusionAnnotsFile = null;
   

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

            if (args.Any(a => a == "/replaceRoot"))
                replaceRoot = true;

            args.Where(a => a.StartsWith("/oldRoot:"))
                .Iter(a => oldRoot = a.Substring("/oldRoot:".Length));

            args.Where(a => a.StartsWith("/newRoot:"))
                .Iter(a => newRoot = a.Substring("/newRoot:".Length));

            args.Where(a => a.StartsWith("/chakraTypeConfusionFile:"))
                .Iter(a => chakraTypeConfusionAnnotsFile = a.Substring("/chakraTypeConfusionFile:".Length));

            if (args.Any(a => a == "/count"))
                count = true;

            if (args.Any(a => a == "/onlyCount"))
                onlyCount = true;

            if (args.Any(a => a == "/checkNULL"))
                checkNULL = true;

            if (args.Any(a => a == "/checkUAF"))
                checkUAF = true;

            if (args.Any(a => a == "/printCallGraph"))
                printCallGraph = true;

            if (args.Any(a => a == "/detectDeadCode"))
                detectDeadCode = true;

            if (args.Any(a => a == "/checkMemorySafety"))
                checkMemSafety = true;

            if (args.Any(a => a == "/visualizeHeap"))
                visualizeHeap = true;
            // initialize Boogie
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.DoModSetAnalysis = true;


            // Read the input file
            var program = BoogieUtil.ReadAndResolve(args[0], false);

            // SMACK does not add globals to modify clauses
            //BoogieUtil.DoModSetAnalysis(program);

            if (checkMemSafety) {
                Procedure checkProc = program.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == "__SMACK_check_memory_safety").FirstOrDefault();
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    if (impl.Name == "__SMACK_check_memory_safety")
                        continue;
                    if (impl.Name.StartsWith("__SMACK_static_init"))
                        continue;
                    foreach (var block in impl.Blocks)
                    {
                        //var block = impl.Blocks.FirstOrDefault();
                        var newCmds = new List<Cmd>();
                        foreach (var cmd in block.cmds)
                        {
                            if (cmd is AssignCmd)
                            {
                                var asnCmd = cmd as AssignCmd;
                                var rhs = asnCmd.Rhss.FirstOrDefault();
                                if (rhs is NAryExpr)
                                {
                                    var fcExpr = rhs as NAryExpr;
                                    if (fcExpr.Fun.FunctionName.StartsWith("$load") || fcExpr.Fun.FunctionName.StartsWith("$store"))
                                    {
                                        char[] delim = { '.' };
                                        var type = fcExpr.Fun.FunctionName.Split(delim)[1];
                                        var size = 0;
                                        if (type == "ref")
                                            size = 8;
                                        else
                                            size = Int32.Parse(type.Substring(1)) / 8;
                                        var ptr = fcExpr.Args[1];
                                        //Console.WriteLine(ptr.ToString());
                                        var sizeExpr = Expr.Ident(size.ToString(), btype.Int);
                                        var paramList = new List<Expr>();
                                        paramList.Add(ptr);
                                        paramList.Add(sizeExpr);
                                        var callCmd = new CallCmd(Token.NoToken, "__SMACK_check_memory_safety", paramList, new List<IdentifierExpr>());
                                        newCmds.Add(callCmd);
                                    }
                                }
                            }
                            if (cmd is CallCmd)
                            {
                                var callCmd = cmd as CallCmd;
                                if (callCmd.callee.StartsWith("corral_fix_context_"))
                                    continue;
                            }
                            if (cmd is AssertCmd)
                            {
                                continue;
                            }
                            newCmds.Add(cmd);
                        }
                        block.cmds = newCmds;
                    }
                }
                BoogieUtil.PrintProgram(program, args[1]);
                return;
            }

            if (visualizeHeap)
            {
                Procedure printProc = program.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == "boogie_si_record_ref").FirstOrDefault();
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    if (impl.Name.StartsWith("__SMACK_static_init"))
                        continue;
                    foreach (var block in impl.Blocks)
                    {
                        //var block = impl.Blocks.FirstOrDefault();
                        var newCmds = new List<Cmd>();
                        foreach (var cmd in block.cmds)
                        {
                            if (cmd is AssignCmd)
                            {
                                var asnCmd = cmd as AssignCmd;
                                var rhs = asnCmd.Rhss.FirstOrDefault();
                                if (rhs is NAryExpr)
                                {
                                    var fcExpr = rhs as NAryExpr;
                                    if (fcExpr.Fun.FunctionName.StartsWith("$load"))
                                    {
                                        var region = fcExpr.Args[0];
                                        if (region.ToString().Equals("$M.0"))
                                        {
                                            var val = asnCmd.Lhss.FirstOrDefault().AsExpr;
                                            var ptr = fcExpr.Args[1];
                                            List<Expr> paramList = new List<Expr>();
                                            paramList.Add(val);
                                            var callCmd = new CallCmd(Token.NoToken, "boogie_si_record_ref", paramList, new List<IdentifierExpr>());
                                            List<Object> attrib = new List<Object>();
                                            attrib.Add(val.ToString());
                                            callCmd.Attributes = new QKeyValue(Token.NoToken, "cexpr", attrib, callCmd.Attributes);
                                            newCmds.Add(cmd);
                                            newCmds.Add(callCmd);
                                            continue;
                                        }
                                    }
                                    if (fcExpr.Fun.FunctionName.StartsWith("$store"))
                                    {
                                        var region = fcExpr.Args[0];
                                        if (region.ToString().Equals("$M.0"))
                                        {
                                            var val = fcExpr.Args[2];
                                            List<Expr> paramList = new List<Expr>();
                                            paramList.Add(val);
                                            var callCmd = new CallCmd(Token.NoToken, "boogie_si_record_ref", paramList, new List<IdentifierExpr>());
                                            List<Object> attrib = new List<Object>();
                                            attrib.Add(val.ToString());
                                            callCmd.Attributes = new QKeyValue(Token.NoToken, "cexpr", attrib, callCmd.Attributes);
                                            newCmds.Add(callCmd);
                                        }
                                    }
                                }
                            }
                            newCmds.Add(cmd);
                        }
                        block.cmds = newCmds;
                    }
                }
                BoogieUtil.PrintProgram(program, args[1]);
                return;
            }

            if (printCallGraph)
            {
                PrintCallGraphToDot(program, "i386_immediate", "callgraph.dot");
                return;
            }

            // Preprocess program: count lines + replace Root
            program = preProcess(program, count || onlyCount, oldRoot, newRoot);

            if (onlyCount)
                return;

            // Process it
            program = Process(program);

            // write the output
            BoogieUtil.PrintProgram(program, args[1]);
        }

        static void PrintCallGraphToDot(Program program, string root, string filename)
        {
            var dotty = new System.IO.StreamWriter(filename);
            var graph = BoogieUtil.GetCallGraph(program);

            if (!program.Implementations.Any(impl => impl.Proc.Name.Equals(root)))
            {
                Console.WriteLine("Warning: specified root is not found");
                Console.WriteLine("Get all non-trivial roots:");
                // ignore recursion
                var roots = graph.Nodes.Where(n => graph.Predecessors(n).Count() == 0 && graph.Successors(n).Count() > 0);
                Console.WriteLine(String.Join(", ", roots.ToArray()));
                Console.WriteLine("Print the whole graph with all roots");
                dotty.Write(graph.ToDot());
                dotty.Close();
                return;
            }

            dotty.WriteLine("digraph \"Call graph\" {");
            dotty.WriteLine("  label=\"Call graph\";");
          
            var visited = new HashSet<string>{root};
            var worklist = new HashSet<string>{root};
            var depth = 0;
            // do BFS
            while (worklist.Count != 0 && depth < 50)
            {
                depth++;
                // print all edges from this level to next
                worklist.Where(w => !Regex.IsMatch(w, @"^devirtbounce\d*$")).Iter(w => graph.Successors(w).Where(q => !Regex.IsMatch(q, @"^devirtbounce\d*$")).Iter(s => dotty.WriteLine(string.Format("  \"{0}\" -> \"{1}\";", w, s))));
                // expand worklist to next level
                var nl = new HashSet<string>();
                worklist.Iter(w => nl.UnionWith(graph.Successors(w).Where(x => !Regex.IsMatch(x, @"^devirtbounce\d*$"))));
                // break circle
                worklist = nl.Difference(visited);
                // add next level to visited
                visited.UnionWith(nl);
            }
            dotty.WriteLine("}");
            dotty.Close();
        }

        static Program preProcess(Program program, bool count, string oldRoot, string newRoot)
        {
            if (count || (oldRoot.Length > 0 && newRoot.Length > 0))
            {
                var cr = new CountAndReplaceVistor(count, oldRoot, newRoot);
                cr.Run(program);
            }
            return program;
        }

        static Program Process(Program program)
        {
            // Get rid of Synonyms
            RemoveTypeSynonyms.Remove(program);
            //BoogieUtil.PrintProgram(program, "tt.bpl");
            program = BoogieUtil.ReResolveInMem(program, false);

            // Create "null"
            var nil = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "NULL", btype.Int), false);
            nil.AddAttribute("allocated");

            // axiom NULL == 0;
            //var ax = new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(nil), Expr.Literal(0)));

            program.AddTopLevelDeclaration(nil);
            //program.AddTopLevelDeclaration(ax);

            // add "allocator" to malloc
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => MallocNames.Contains(p.Name))
                .Iter(p => p.AddAttribute("allocator"));

			// inline functions
			InlineFunctions(program);

            // Add attribute {:fpcondition} to assume cmds in charge of branching in function pointer dispatch procs
            var fpAt = new AnnotateFPDispatchProcVisitor();
            fpAt.Run(program);

            // Add MustReach function calls to the begining of each procedure and upon returns
            if (detectDeadCode) {
                var ddc = new SimpleDeadcodeDectectionVisitor();
                ddc.Run(program);
            }

            if (chakraTypeConfusionAnnotsFile != null)
                (new InstrumentTypeConfusionChakra(chakraTypeConfusionAnnotsFile, program)).InstrumentCode();

            // if we don't check NULL, stop here
            if (!checkNULL && !checkUAF)
                return program;

            if (checkUAF) {
                var iu = new InstrumentUAF();
                iu.Instrument(program, nil);
                program.AddTopLevelDeclaration(new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(nil), Expr.Literal(0))));
                return program;
            }
			// Remove literal constants
			var CE = new ConstantElimination();
			CE.Run (program);

            // Convert 0 to NULL in the program
            ConvertToNull.Convert(program, nil);

            // Add NULL axiom here such that ConvertToNULL doesn't lead to dumb axiom
            var ax = new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(nil), Expr.Literal(0)));
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

    public class SimpleDeadcodeDectectionVisitor : FixedVisitor
    {
        Function f;
        // stupid
        int returnCount;

        public void Run(Program program)
        {
            // First add a MustReach function
            f = new Function(Token.NoToken, "ProcedureMustReach", new List<Variable>{
                BoogieAstFactory.MkFormal("x", btype.Bool, true)},
                BoogieAstFactory.MkFormal("y", btype.Bool, false));
            f.AddAttribute("ReachableStates");
            program.AddTopLevelDeclaration(f);
            // Then add function calls to the beginning and end of each non-stub procedure
            program.Implementations.Iter(impl => VisitImplementation(impl));
        }

        AssumeCmd getAssumeReach()
        {
            return new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken, new FunctionCall(f), new List<Expr> { Expr.True }));
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            // get first block and inject call to MustReach function
            var blk = node.Blocks[0];
            blk.Cmds.Insert(0, getAssumeReach());
            returnCount = 0;
            node.Blocks.Iter(b => VisitBlock(b));
            //Debug.Assert(returnCount <= 1, "Doesn't SMACK only has one return?");
            if (returnCount != 1)
                Console.WriteLine(string.Format("Got a return function with not one exits: {0}:{1}", node.Proc.Name, returnCount));
            return node;
        }

        public override Block VisitBlock(Block node)
        {
            List<Cmd> newCmds = new List<Cmd>();
            foreach (var cmd in node.Cmds) 
            {
                newCmds.Add(cmd);
                if (isAboutToReturn(cmd))
                { 
                    // Hack: SMACK always set a global variable to false before return
                    newCmds.Add(getAssumeReach());
                    returnCount++;
                }
            }
            node.Cmds = newCmds;
            return node;
        }

        bool isAboutToReturn(Cmd cmd)
        {
            if (cmd is AssignCmd)
            {
                var ac = cmd as AssignCmd;
                if (ac.Lhss[0].AsExpr.ToString().Equals("$exn") && ac.Rhss[0].ToString().Equals(Expr.False.ToString()))
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
    }

    // Add attribute {:fpcondition} to assume cmds in charge of branching in function pointer dispatch procs
    public class AnnotateFPDispatchProcVisitor : FixedVisitor
    {
        string pattern = @"^devirtbounce\d*$";
        List<Function> aliasQfuncs = new List<Function>();
        Procedure specialPtrFunc = null;
        Procedure specialScalarFunc = null;
        Procedure currProc;
        int counter = 0;
        //List<Procedure> angelicDispatch = new List<Procedure>();

        public void Run(Program program)
        {
            program.Implementations.Where(impl => Regex.IsMatch(impl.Proc.Name, pattern))
                .Iter(impl => VisitImplementation(impl));
            program.AddTopLevelDeclarations(aliasQfuncs);
            if (specialPtrFunc != null)
                program.AddTopLevelDeclaration(specialPtrFunc);
            if (specialScalarFunc != null)
                program.AddTopLevelDeclaration(specialScalarFunc);
        }

        //public override Cmd VisitAssumeCmd(AssumeCmd node)
        //{
        //    if (BoogieUtil.checkAttrExists("partition", node.Attributes))
        //    {
        //        node.Attributes = new QKeyValue(Token.NoToken, "fpcondition", new List<object>(), node.Attributes);
        //    }
        //    return node;
        //}
        public override Implementation VisitImplementation(Implementation node)
        {
            currProc = node.Proc;
            return base.VisitImplementation(node);
        }

        AssumeCmd MkAssume(Expr funcPtr, Expr callee)
        {
            var a = BoogieAstFactory.MkFormal("a", btype.Int, true);
            var b = BoogieAstFactory.MkFormal("b", btype.Int, true);
            var f = new Function(Token.NoToken, "FPAliasQ" + (counter++),
                new List<Variable> { a, b },
                BoogieAstFactory.MkFormal("c", btype.Bool, false));
            f.AddAttribute("aliasingQuery");
            //f.AddAttribute("inline");
            //f.Body = Expr.Eq(Expr.Ident(a), Expr.Ident(b));

            aliasQfuncs.Add(f);

            return new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken, new FunctionCall(f), new List<Expr> { funcPtr, callee }));
        }

        public override Block VisitBlock(Block node)
        {
            List<Cmd> newCmds = new List<Cmd>();
            foreach (Cmd cmd in node.Cmds)
            {
                if (cmd is AssumeCmd)
                {
                    if (!(cmd as AssumeCmd).Expr.ToString().Equals(Expr.False.ToString()))
                        newCmds.Add(VisitAssumeCmd(cmd as AssumeCmd));
                    else
                    {
                        //node.TransferCmd = new ReturnCmd(Token.NoToken);
                        // create a stub
                        //newCmds.Add(cmd);
                        // we want to add a call to a stub procedure in case AA decides that the function pointer never gets any address
                        // we need to create three types of stub procedures:
                        // 1) no returning value (actually just let it return)
                        // 2) returning a pointer
                        // 3) returning a scalar
                        if (currProc.OutParams.Count > 0)
                        {
                            Variable procRet = currProc.OutParams[0];
                            if (BoogieUtil.checkAttrExists("scalar", procRet.Attributes))
                            {
                                if (specialScalarFunc == null)
                                {
                                    // make a procedure
                                    specialScalarFunc = new Procedure(Token.NoToken, "$devirtbounce_special_scalar", new List<TypeVariable>(), new List<Variable>(), currProc.OutParams, new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                                }
                                CallCmd callCmd = new CallCmd(Token.NoToken, specialScalarFunc.Name, new List<Expr>(), new List<IdentifierExpr>() { Expr.Ident(procRet) });
                                newCmds.Add(callCmd);
                            }
                            else
                            {
                                if (specialPtrFunc == null)
                                {
                                    // make a procedure
                                    specialPtrFunc = new Procedure(Token.NoToken, "$devirtbounce_special_pointer", new List<TypeVariable>(), new List<Variable>(), currProc.OutParams, new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                                }
                                CallCmd callCmd = new CallCmd(Token.NoToken, specialPtrFunc.Name, new List<Expr>(), new List<IdentifierExpr>() { Expr.Ident(procRet) });
                                newCmds.Add(callCmd);
                            }
                        }
                        node.TransferCmd = new ReturnCmd(Token.NoToken);
                    }
                }
                else if (cmd is CallCmd)
                {
                    // add assume(aliasing(funcPtr, calledProc))
                    var callCmd = cmd as CallCmd;
                    var callee = callCmd.callee;
                    // watch out: varg functions have trailing arg types in function name
                    callee = callee.Split('.')[0];
                    var aaCmd = MkAssume(Expr.Ident("funcPtr", btype.Int), Expr.Ident(callee, btype.Int));
                    aaCmd.Attributes = new QKeyValue(Token.NoToken, "partition", new List<object>(),
                        new QKeyValue(Token.NoToken, "slic", new List<object>(), aaCmd.Attributes));
                    newCmds.Add(aaCmd);
                    //newCmds.Add(MkAssume(Expr.Ident("funcPtr", btype.Int), Expr.Ident(callee, btype.Int)));
                    newCmds.Add(cmd);
                }
                else
                    newCmds.Add(cmd);
            }
            node.Cmds = newCmds;
            return node;
        }

    }

    public class CountAndReplaceVistor : FixedVisitor
    {
        HashSet<string> lines = new HashSet<string>();
        HashSet<string> files = new HashSet<string>();
        bool count;
        string oldRoot;
        string newRoot;

        public CountAndReplaceVistor(bool count, string oldRoot, string newRoot)
        {
            this.count = count;
            this.oldRoot = oldRoot;
            this.newRoot = newRoot;
        }

        public void Run(Program program)
        {
            VisitProgram(program);
            Console.WriteLine("#Procs:" + program.Implementations.Count());
            Console.WriteLine("Unique line count: " + lines.Count);
            files.Iter(f => Console.WriteLine(f));
            Console.WriteLine("Line count of all files contained: " + OpenAndCount());
        }

        public int OpenAndCount()
        {
            int totalloc = 0;
            Console.WriteLine("The current directory is {0}", Directory.GetCurrentDirectory());
            foreach (var file in files)
            {
                try
                {
                    var fileloc = File.ReadLines(file).Count();
                    totalloc += fileloc;
                    Console.WriteLine(string.Format("{0}:{1}", file, fileloc));
                }
                catch (FileNotFoundException)
                {
                    Console.WriteLine(string.Format("{0}:not found", file));
                }
                catch (DirectoryNotFoundException)
                {
                    Console.WriteLine(string.Format("{0}:not found", file));
                }
            }
            return totalloc;
        }

        public override Cmd VisitAssumeCmd(AssumeCmd node)
        {
            // Not good: only one attribute is assumed here, could be broken
            if (node.Attributes != null && node.Attributes.Key.Equals("sourceloc"))
            {
                Debug.Assert(node.Attributes.Params.Count == 3, "Source location should contain three elements");
                var file = node.Attributes.Params[0].ToString();
                //Console.WriteLine(file);
                if (!file.Contains("smack.c"))
                {
                    if (count)
                    {
                        var line = node.Attributes.Params[1].ToString();
                        lines.Add(file + ":" + line);
                        files.Add(file);
                    }
                    if (oldRoot.Length > 0)
                    {
                        //Debug.Assert(file.StartsWith(oldRoot), "File path should start with old root (implies an absolute path)");
                        if (file.StartsWith(oldRoot))
                        {
                            file = file.Replace(oldRoot, newRoot);
                            file = file.Replace(@"/", @"\");
                            var newParams = new List<object>();
                            newParams.Add(file);
                            newParams.Add(node.Attributes.Params[1]);
                            newParams.Add(node.Attributes.Params[2]);
                            node.Attributes.ClearParams();
                            node.Attributes.AddParams(newParams);                           
                        }
                        else
                            Console.WriteLine(string.Format("Not under root dir: {0}", file));
                    }
                }
            }
            return base.VisitAssumeCmd(node);
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
			HashSet<string> constNames = new HashSet<string>(prog.TopLevelDeclarations.OfType<Constant>().Where(c => c.Name != "NULL").Select(c => c.Name));
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
                    if (cmd is AssumeCmd && BoogieUtil.checkAttrExists("nonnull", (cmd as AssumeCmd).Attributes))
                    {
                      continue;
                    }
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

    public class InstrumentUAF : FixedVisitor
    {
        Expr nil;
        public void Instrument(Program program, Constant nil)
        {
            this.nil = Expr.Ident(nil);
            Visit(program);
        }

        public AssumeCmd MkAssume(Expr e)
        {
            return new AssumeCmd(Token.NoToken, Expr.Neq(e, nil), new QKeyValue(Token.NoToken, "nonnull", new List<object>() { }, null));
        }
        public override Implementation VisitImplementation(Implementation node)
        {
            var varDecls = new Dictionary<string, string>();
            var cb = new CollectBasePointer(varDecls);
            cb.VisitImplementation(node);
            foreach (var b in node.Blocks)
            {
                var newCmds = new List<Cmd>();
                foreach (var c in b.Cmds)
                {
                    if (c is AssumeCmd) {
                        var asmCmd = c as AssumeCmd;
                        if (BoogieUtil.checkAttrExists("nonnull", asmCmd.Attributes)) {
                            var expr = asmCmd.Expr as NAryExpr;
                            expr.Args[1] = nil;
                            newCmds.Add(c);
                            continue;
                        }
                    }
                    if (c is AssignCmd) {
                        var asnCmd = c as AssignCmd;
                        var reads = new GatherMemAccesses();
                        asnCmd.Rhss.Iter(e => reads.VisitExpr(e));
                        foreach (var tup in reads.accesses)
                        {
                            var ptr = tup.Item2;
                            string basePtr;
                            if (varDecls.TryGetValue(ptr.ToString(), out basePtr))
                                newCmds.Add(MkAssume(Expr.Ident(BoogieAstFactory.MkFormal(basePtr, btype.Int, true))));
                            else
                                newCmds.Add(MkAssume(ptr));
                        }
                    }
                    newCmds.Add(c);
                }
                b.cmds = newCmds;
            }
            return node;
        }
    }


    /// <summary>
    /// Adds special functions by parsing a text file generated by CLANG
    /// TODO: will be replaced by performing this directly at the CLANG level
    /// </summary>
    public class InstrumentTypeConfusionChakra
    {
        string typeFile;
        Program prog;
        HashSet<Tuple<string, HashSet<int>>> upcallFuncs;
        HashSet<Tuple<string, int>> isTypeFuncs;
        HashSet<Tuple<string, int, int>> typePreCondFuncs;
        HashSet<string> getTypeIdFuncs; 

        const string upcallFuncName = "ThisIsAnUpcallArg";
        const string isTypeFuncName = "IsJSArrayType";
        const string typePreCondFuncName = "TemplateSpecializedProc";
        const string getTypeIdFuncName = "ThisIsGetTypeIdProc";

        public InstrumentTypeConfusionChakra(string fname, Program pr)
        {
            typeFile = fname;
            prog = pr;
            ParseFuncAnnotations();
        }

        private void ParseFuncAnnotations()
        {
            upcallFuncs = new HashSet<Tuple<string, HashSet<int>>>();
            isTypeFuncs = new HashSet<Tuple<string, int>>();
            typePreCondFuncs = new HashSet<Tuple<string, int, int>>();
            getTypeIdFuncs = new HashSet<string>();

            using (var iStream = new StreamReader(typeFile))
            {
                string line;
                while((line = iStream.ReadLine())!= null)
                {
                    ParseLine(line);
                }
            }
        }

        private void ParseLine(string line)
        {
            //remove the string after "//"
            var lineWoComments = line.Contains("//")? line.Substring(0, line.IndexOf("//")) : line;
            var strArr = lineWoComments.Split(new char[] { ':', ',', ' ' }).Where(x => x != "").ToArray();
            if (strArr.Count() < 2) return;
            if (strArr[0] == "Upcall")
            {
                var pArgs = new HashSet<int>();
                for(int i = 2; i < strArr.Length; ++i)
                {
                    pArgs.Add(Int32.Parse(strArr[i])); //ignoring exception
                }
                upcallFuncs.Add(new Tuple<string, HashSet<int>>(strArr[1], pArgs));                
            }
            else if (strArr[0] == "FromVar" || strArr[0] == "IS")
            {
                isTypeFuncs.Add(new Tuple<string, int>(strArr[1], Int32.Parse(strArr[2]))); //ignoring exception
            }
            else if (strArr[0] == "SpecTemp")
            {
                typePreCondFuncs.Add(new Tuple<string, int, int>(strArr[1], Int32.Parse(strArr[2]), Int32.Parse(strArr[3])));
            }
            else if (strArr[0] == "GetTypeID")
            {
                getTypeIdFuncs.Add(strArr[1]);
            }
        }

        public void InstrumentCode()
        {
            ParseFuncAnnotations();

            //declare the funcs
            var iVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Int), true);
            var tVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "t", btype.Int), true);
            var rVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "r", btype.Int), true);

            prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, typePreCondFuncName, 
                new List<TypeVariable>(), new List<Variable>() { iVar, tVar }, new List<Variable>(), 
                new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
            prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, isTypeFuncName,
                new List<TypeVariable>(), new List<Variable>() { iVar, tVar, rVar }, new List<Variable>(),
                new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
            prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, upcallFuncName,
                new List<TypeVariable>(), new List<Variable>() { iVar }, new List<Variable>(),
                new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
            prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, getTypeIdFuncName,
                new List<TypeVariable>(), new List<Variable>() { iVar,tVar }, new List<Variable>(),
                new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));

            foreach (var impl in prog.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach(var bl in impl.Blocks)
                {
                    var newCmds = new List<Cmd>();
                    foreach(var cmd in bl.cmds)
                    {
                        var callCmd = cmd as CallCmd;
                        if (callCmd == null)
                        {
                            newCmds.Add(cmd);
                            continue;
                        }
                        HashSet<int> pArgs;
                        int argPos;
                        int typeId;
                        if (IsUpCall(callCmd.callee, out pArgs))
                            newCmds.AddRange(InstrumentUpcall(callCmd, pArgs));
                        else if (IsIsType(callCmd.callee, out typeId))
                            newCmds.AddRange(InstrumentIsTypeCall(callCmd, typeId));
                        else if (IsTypePrecondFuncs(callCmd.callee, out argPos, out typeId))
                            newCmds.AddRange(InstrumentIsTypePrecondCall(callCmd, argPos, typeId));
                        else if (IsGetTypeId(callCmd.callee))
                            newCmds.AddRange(InstrumentGetTypeCall(callCmd));
                        else newCmds.Add(callCmd);                    
                    }
                    bl.Cmds = newCmds;
                }
            }
        }

        private IEnumerable<Cmd> InstrumentIsTypePrecondCall(CallCmd callCmd, int pos, int typeId)
        {
            var retCmds = new List<Cmd>();
            Debug.Assert(callCmd.Ins.Count > pos, "Illegal argument count for IsTypePrecond function " + callCmd.Proc.Name);
            var nCmd = new CallCmd(Token.NoToken, typePreCondFuncName, 
                new List<Expr>() {callCmd.Ins[pos],Expr.Literal(typeId) },  new List<IdentifierExpr>());
            retCmds.Add(nCmd); //adding a precondition, so should appear before the call
            retCmds.Add(callCmd);
            return retCmds;
        }

        private bool IsTypePrecondFuncs(string pName, out int pos, out int typeId)
        {
            pos = -1; typeId = -1;
            var found = typePreCondFuncs.Where(x => x.Item1 == pName);
            if (found.Count() > 0)
            {
                pos = found.First().Item2;
                typeId = found.First().Item3;
                return true;
            }
            return false;
        }

        private IEnumerable<Cmd> InstrumentIsTypeCall(CallCmd callCmd, int typeId)
        {
            var retCmds = new List<Cmd>();
            var retExprs = callCmd.Outs;
            Debug.Assert(retExprs.Count == 1, "Expecting exactly one return variable for isType function " + callCmd.Proc.Name);
            var nCmd = new CallCmd(Token.NoToken, isTypeFuncName, new List<Expr>() {retExprs[0], callCmd.Ins[0], Expr.Literal(typeId) }, 
                new List<IdentifierExpr>());
            retCmds.Add(callCmd);
            retCmds.Add(nCmd);
            return retCmds;
        }

        private bool IsIsType(string pName, out int typeId)
        {
            typeId = -1;
            var found = isTypeFuncs.Where(x => x.Item1 == pName);
            if (found.Count() > 0)
            {
                typeId = found.First().Item2;
                return true;
            }
            return false;
        }

        private IEnumerable<Cmd> InstrumentUpcall(CallCmd callCmd, HashSet<int> pArgs)
        {
            var retCmds = new List<Cmd>();
            retCmds.Add(callCmd);
            foreach (var pos in pArgs)
            {
                Debug.Assert(callCmd.Ins.Count > pos, "Illegal argument count for IsUpcall function " + callCmd.Proc.Name);
                var nCmd = new CallCmd(Token.NoToken, upcallFuncName, new List<Expr>() {callCmd.Ins[pos]},
                    new List<IdentifierExpr>());
                retCmds.Add(nCmd);
            }
            return retCmds;
            throw new NotImplementedException();
        }

        private bool IsUpCall(string pName, out HashSet<int> pArgs)
        {
            pArgs = new HashSet<int>();
            var found = upcallFuncs.Where(x => x.Item1 == pName);
            if (found.Count() > 0)
            {
                pArgs = new HashSet<int>(found.First().Item2);
                return true;
            }
            return false;
        }

        private bool IsGetTypeId(string pName)
        {
            return getTypeIdFuncs.Where(x => x == pName).Count() > 0;
        }
        private IEnumerable<Cmd> InstrumentGetTypeCall(CallCmd callCmd)
        {
            var retCmds = new List<Cmd>();
            var retExprs = callCmd.Outs;
            Debug.Assert(retExprs.Count == 1, "Expecting exactly one return variable for isType function " + callCmd.Proc.Name);
            var nCmd = new CallCmd(Token.NoToken, getTypeIdFuncName, new List<Expr>() {callCmd.Ins[0], retExprs[0]},
                new List<IdentifierExpr>());
            retCmds.Add(callCmd);
            retCmds.Add(nCmd);
            return retCmds;
        }

    }

}
