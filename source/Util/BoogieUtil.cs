using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System.Diagnostics;

namespace cba.Util
{
    public static class BoogieAstExtensions
    {
        public static void SetAssignCmdRhs(this AssignCmd ac, int index, Expr expr)
        {
            var ls = new List<Expr>(ac.Rhss);
            ls[index] = expr;
            ac.Rhss = ls;
        }

        public static void SetAssignCmdLhs(this AssignCmd ac, int index, AssignLhs expr)
        {
            var ls = new List<AssignLhs>(ac.Lhss);
            ls[index] = expr;
            ac.Lhss = ls;
        }
    }

    public class BoogieUtil
    {
        public static bool InitializeBoogie(string clo)
        {
            CommandLineOptions.Clo.RunningBoogieFromCommandLine = true;

            var quotes = (" " + clo + " ").Split(new char[] { '\"' }, StringSplitOptions.RemoveEmptyEntries);
            var args = new List<string>();
            // for every odd i, quotes[i] appears inside quotes
            for (int i = 0; i < quotes.Length; i++)
            {
                if (i % 2 == 0)
                    args.AddRange(quotes[i].Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
                else
                    args.Add(quotes[i]);
            }

            CommandLineOptions.Clo.Parse(args.ToArray());

            // No Max: avoids theorem prover restarts
            CommandLineOptions.Clo.MaxProverMemory = 0;

            return false;
        }

        public static void DoModSetAnalysis(Program p)
        {
            (new ModSetCollector()).DoModSetAnalysis(p);
        }

        public static void PrintProgram(Program p, string filename)
        {
            var outFile = new TokenTextWriter(filename);
            p.Emit(outFile);
            outFile.Close();
        }

        public static bool ResolveProgram(Program p, string filename)
        {
            int errorCount = p.Resolve();
            if (errorCount != 0)
                Console.WriteLine(errorCount + " name resolution errors in " + filename);
            return errorCount != 0;
        }

        public static bool TypecheckProgram(Program p, string filename)
        {
            int errorCount = p.Typecheck();
            if (errorCount != 0)
            {
                PrintProgram(p, "error.bpl");
                Console.WriteLine(errorCount + " type checking errors in " + filename);
            }
            return errorCount != 0;
        }

        public static HashSet<string> getGlobalVarsModified(Cmd cmd, HashSet<string> procsWithImpl)
        {
            var ret = new HashSet<string>();

            if (cmd is HavocCmd)
            {
                var hcmd = cmd as HavocCmd;
                foreach (IdentifierExpr v in hcmd.Vars)
                {
                    if (v.Decl is GlobalVariable)
                    {
                        ret.Add(v.Decl.Name);
                    }
                }
                return ret;
            }
            else if (cmd is CallCmd)
            {
                var ccmd = cmd as CallCmd;
                foreach (IdentifierExpr v in ccmd.Outs)
                {
                    if(v.Decl is GlobalVariable) ret.Add(v.Decl.Name);
                }
                
                if (procsWithImpl.Contains(ccmd.Proc.Name))
                    return ret;

                foreach (IdentifierExpr v in ccmd.Proc.Modifies)
                {
                    if (v.Decl is GlobalVariable)
                    {
                        ret.Add(v.Decl.Name);
                    }
                }
                return ret;
            }
            else if (cmd is AssignCmd)
            {
                var acmd = cmd as AssignCmd;
                Debug.Assert(acmd.Lhss.Count == 1);
                var v = acmd.Lhss[0].DeepAssignedVariable;
                if (v is GlobalVariable)
                    ret.Add(v.Name);
                return ret;
            }
            else
            {
                return ret;
            }
        }

        // Prune by removing procedures that are not called
        public static void pruneProcs(Program program, string mainProcName)
        {
            if (mainProcName == null)
                return;

            pruneProcs(program, new HashSet<string> { mainProcName });
        }

        public static void pruneProcs(Program program, HashSet<string> mains)
        {
            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                edges.Add(impl.Name, new HashSet<string>());
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<CallCmd>()
                        .Iter(ccmd => edges[impl.Name].Add(ccmd.callee));
                    blk.Cmds.OfType<ParCallCmd>()
                        .Iter(pcmd => pcmd.CallCmds
                            .Iter(ccmd => edges[impl.Name].Add(ccmd.callee)));
                }
            }
            var reachable = new HashSet<string>();
            reachable.UnionWith(mains);

            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0)
            {
                var nf = new HashSet<string>();
                foreach (var n in delta)
                {
                    if (edges.ContainsKey(n)) nf.UnionWith(edges[n]);
                }
                delta = nf.Difference(reachable);
                reachable.UnionWith(nf);
            }

            var allProcs = new HashSet<string>(edges.Keys);
            var toRemove = allProcs.Difference(reachable);

            var newDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure && toRemove.Contains((decl as Procedure).Name)) continue;
                if (decl is Implementation && toRemove.Contains((decl as Implementation).Name)) continue;
                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;
        }

        // Return the set of procedures that may reach a cmd that satisfies pred
        public static HashSet<string> procsThatMaySatisfyPredicate(Program program, Predicate<Cmd> pred)
        {
            // target procedures
            var targets = new HashSet<string>();

            // call graph
            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<CallCmd>()
                        .Iter(ccmd => edges.InitAndAdd(ccmd.callee, impl.Name)); 
                    blk.Cmds.OfType<ParCallCmd>()
                        .Iter(pcmd => pcmd.CallCmds
                            .Iter(ccmd => edges.InitAndAdd(ccmd.callee, impl.Name)));
                    if (blk.Cmds.Any(c => pred(c)))
                        targets.Add(impl.Name);
                }
            }
            var reachable = new HashSet<string>(targets);

            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0)
            {
                var nf = new HashSet<string>();
                foreach (var n in delta)
                {
                    if (edges.ContainsKey(n)) nf.UnionWith(edges[n]);
                }
                delta = nf.Difference(reachable);
                reachable.UnionWith(nf);
            }

            return reachable;
        }

        // Call graph over implementations
        public static Graph<string> GetCallGraph(Program program)
        {
            var graph = new Graph<string>();
            var impls = new HashSet<string>(program.TopLevelDeclarations.OfType<Implementation>().Select(impl => impl.Name));
            impls.Iter(p => graph.Nodes.Add(p));

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.Blocks
                    .Iter(blk => blk.Cmds
                        .OfType<CallCmd>()
                        .Where(cc => impls.Contains(cc.callee))
                        .Iter(cc => graph.AddEdge(impl.Name, cc.callee)));
            }
            return graph;
        }

        // Return nodes on some cycle
        public static HashSet<Node> GetCyclicNodes<Node>(Graph<Node> graph) where Node: class
        {
            var ret = new HashSet<Node>();
            var scc = new StronglyConnectedComponents<Node>(graph.Nodes,
                new Adjacency<Node>(n => graph.Predecessors(n)), new Adjacency<Node>(n => graph.Successors(n)));
            scc.Compute();

            foreach (var s in scc)
            {
                if(s.Count == 0) continue;

                if (s.Count > 1 || graph.Successors(s.First()).Contains(s.First()))
                {
                    ret.UnionWith(s);
                }
            }

            return ret;
        }

        // Get reachable nodes
        public static HashSet<Node> GetReachableNodes<Node>(Node n, Graph<Node> graph) where Node : class
        {
            var ret = new HashSet<Node>{ n };
            var frontier = new HashSet<Node> { n };

            while (frontier.Count > 0)
            {
                var next = new HashSet<Node>();
                frontier.Iter(v => next.UnionWith(graph.Successors(v)));
                next.ExceptWith(ret);
                ret.UnionWith(next);
                frontier = next;
            }
            return ret;
        }

        public static HashSet<string> getVarsModified(Cmd cmd, HashSet<string> procsWithImpl)
        {
            var ret = new HashSet<string>();

            if (cmd is HavocCmd)
            {
                var hcmd = cmd as HavocCmd;
                foreach (IdentifierExpr v in hcmd.Vars)
                {
                        ret.Add(v.Decl.Name);
                }
                return ret;
            }
            else if (cmd is CallCmd)
            {
                var ccmd = cmd as CallCmd;
                foreach (IdentifierExpr v in ccmd.Outs)
                {
                    if(v != null) ret.Add(v.Decl.Name);
                }

                if (procsWithImpl.Contains(ccmd.Proc.Name))
                    return ret;

                foreach (IdentifierExpr v in ccmd.Proc.Modifies)
                {
                        ret.Add(v.Decl.Name);
                }
                return ret;
            }
            else if (cmd is AssignCmd)
            {
                var acmd = cmd as AssignCmd;
                foreach (var ae in acmd.Lhss)
                {
                    var v = ae.DeepAssignedVariable;
                    ret.Add(v.Name);
                }
                return ret;
            }
            else
            {
                return ret;
            }
        }

        public static int BigNumToIntForce(Microsoft.Basetypes.BigNum num)
        {
            if (num.InInt32) return num.ToInt;
            if (num > Microsoft.Basetypes.BigNum.FromInt(0)) return int.MaxValue;
            return int.MinValue;
        }

        // Remove attribute "name" from the list
        public static QKeyValue removeAttr(string name, QKeyValue attr)
        {
            if (attr == null) return null;
            var tail = removeAttr(name, attr.Next);
            if (attr.Key == name) return tail;
            return new QKeyValue(attr.tok, attr.Key, attr.Params, tail);
        }

        // Remove attributes "name" from the list
        public static QKeyValue removeAttrs(HashSet<string> name, QKeyValue attr)
        {
            if (attr == null) return null;
            var tail = removeAttrs(name, attr.Next);
            if (name.Contains(attr.Key)) return tail;
            return new QKeyValue(attr.tok, attr.Key, attr.Params, tail);
        }

        // Is there a Key called "name"
        public static IList<object> getAttr(string name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (attr.Key == name) return attr.Params;
            }
            return null;
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(string name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (attr.Key == name) return true;
            }
            return false;
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(HashSet<string> name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (name.Contains(attr.Key)) return true;
            }
            return false;
        }


        public static Program ParseProgram(string f)
        {
            Program p = new Program();

            try
            {
                if (Parser.Parse(f, new List<string>(), out p) != 0)
                {
                    Console.WriteLine("Failed to read " + f);
                    return null;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return null;
            }
            return p;
        }

        public static Program ReadAndResolve(string filename, bool doTypecheck = true)
        {
            Program p = ParseProgram(filename);

            if (p == null)
            {
                throw new InvalidProg("Parse errors in " + filename);
            }

            if (ResolveProgram(p, filename))
            {
                throw new InvalidProg("Cannot resolve " + filename);
            }
            if (doTypecheck && TypecheckProgram(p, filename))
            {
                throw new InvalidProg("Cannot typecheck " + filename);
            }

            return p;
        }

        public static Program ReadAndOnlyResolve(string filename)
        {
            Program p = ParseProgram(filename);

            if (p == null)
            {
                throw new InvalidProg("Parse errors in " + filename);
            }

            if (ResolveProgram(p, filename))
            {
                throw new InvalidProg("Cannot resolve " + filename);
            }

            return p;
        }
        // Prints the program into a file, reads it back in, parses it,
        // resolves it and typechecks it
        public static Program ReResolve(Program p, bool doTypecheck = true)
        {
            return ReResolve(p, "temp_rar.bpl", doTypecheck);
        }

        public static Program ReResolveInMem(Program p, bool doTypecheck = true)
        {
            Program output;
            using (var writer = new System.IO.MemoryStream())
            {
                var st = new System.IO.StreamWriter(writer);
                var tt = new TokenTextWriter(st);
                p.Emit(tt);
                writer.Flush();
                st.Flush();
                
                writer.Seek(0, System.IO.SeekOrigin.Begin);
                var s = ParserHelper.Fill(writer, new List<string>());

                var v = Parser.Parse(s, "ReResolveInMem", out output);
                if (ResolveProgram(output, "ReResolveInMem"))
                {
                    throw new InvalidProg("Cannot resolve " + "ReResolveInMem");
                }
                if (doTypecheck && TypecheckProgram(output, "ReResolveInMem"))
                {
                    throw new InvalidProg("Cannot typecheck " + "ReResolveInMem");
                }
            }
            return output;
        }

        // Prints the program into a file, reads it back in, parses it,
        // resolves it and typechecks it
        public static Program ReResolve(Program p, string filename, bool doTypecheck = true)
        {
            PrintProgram(p, filename);
            return ReadAndResolve(filename, doTypecheck);
        }

        public static void PrintGlobalVariables(Program p)
        {
            TokenTextWriter log = new TokenTextWriter(Console.Out);
            foreach (Declaration d in p.TopLevelDeclarations)
            {
                if (d is GlobalVariable)
                    d.Emit(log, 0);
            }
        }

        public static IEnumerable<GlobalVariable> GetGlobalVariables(Program p)
        {
            return p.TopLevelDeclarations.OfType<GlobalVariable>();
        }

        public static List<GlobalVariable> GetModifiedGlobalVariables(Program p)
        {
            var ret = new List<GlobalVariable>();
            var seen = new HashSet<string>();
            foreach (var proc in GetProcedures(p))
            {
                foreach (IdentifierExpr ie in proc.Modifies)
                {
                    var v = ie.Decl as GlobalVariable;
                    if (!seen.Contains(v.Name))
                    {
                        ret.Add(v);
                        seen.Add(v.Name);
                    } 
                }
            }
            return ret;
        }

        public static IEnumerable<Procedure> GetProcedures(Program p)
        {
            return p.TopLevelDeclarations.OfType<Procedure>();
        }

        public static HashSet<string> GetAllProcNames(Program p)
        {
            var ret = new HashSet<string>();
            p.TopLevelDeclarations.OfType<Procedure>().Iter(x => ret.Add((x as Procedure).Name));
            return ret;
        }

        public static HashSet<string> GetAllImplNames(Program p)
        {
            var ret = new HashSet<string>();
            p.TopLevelDeclarations.OfType<Implementation>().Iter(x => ret.Add((x as Implementation).Name));
            return ret;
        }

        public static IEnumerable<Implementation> GetImplementations(Program p)
        {
            return p.TopLevelDeclarations.OfType<Implementation>();
        }

        public static GlobalVariable findVarDecl(IEnumerable<Declaration> decls, string varname)
        {
            foreach (Declaration d in decls)
            {
                if (d is GlobalVariable)
                {
                    if ((d as GlobalVariable).Name.Equals(varname))
                        return (d as GlobalVariable);
                }
            }
            return null;
        }

        public static Procedure findProcedureDecl(IEnumerable<Declaration> decls, string procname)
        {
            foreach (Declaration d in decls)
            {
                if (d is Procedure)
                {
                    if ((d as Procedure).Name.Equals(procname))
                        return (d as Procedure);
                }
            }
            return null;
        }

        public static Implementation findProcedureImpl(IEnumerable<Declaration> decls, string procname)
        {
            foreach (Declaration d in decls)
            {
                if (d is Implementation)
                {
                    if ((d as Implementation).Name.Equals(procname))
                        return (d as Implementation);
                }
            }

            return null;
        }

        // Constructs a mapping from labels to blocks of an implementation
        public static Dictionary<string, Block> labelBlockMapping(Implementation impl)
        {
            var blocks = new Dictionary<string, Block>();
            foreach (Block b in impl.Blocks)
            {
                blocks.Add(b.Label, b);
            }

            return blocks;
        }

        // Constructs a mapping from procedure names to the implementation
        public static Dictionary<string, Implementation> nameImplMapping(Program p)
        {
            var m = new Dictionary<string, Implementation>();
            foreach (Declaration d in p.TopLevelDeclarations)
            {
                if (d is Implementation)
                {
                    Implementation impl = d as Implementation;
                    m.Add(impl.Name, impl);
                }
            }

            return m;
        }

        // Constructs a mapping from procedure names to the Procedure
        public static Dictionary<string, Procedure> nameProcMapping(Program p)
        {
            var m = new Dictionary<string, Procedure>();
            foreach (Declaration d in p.TopLevelDeclarations)
            {
                if (d is Procedure)
                {
                    Procedure proc = d as Procedure;
                    m.Add(proc.Name, proc);
                }
            }

            return m;
        }

        public static double GetMemUsage()
        {
            var p = System.Diagnostics.Process.GetCurrentProcess();
            return p.VirtualMemorySize64 / (1024.0 * 1024.0); 
        }

        
        // is this a non-trivial assert? 
        public static bool isAssert(Cmd cmd)
        {
            var acmd = cmd as AssertCmd;
            if (acmd == null || isAssertTrue(cmd)) return false;
            return true;
        }

        // is "assert true"?
        public static bool isAssertTrue(Cmd cmd)
        {
            var acmd = cmd as AssertCmd;
            if (acmd == null) return false;
            var le = acmd.Expr as LiteralExpr;
            if (le == null) return false;
            if (le.IsTrue) return true;
            return false;
        }

        // is "assume false"?
        public static bool isAssumeFalse(Cmd cmd)
        {
            var acmd = cmd as AssumeCmd;
            if (acmd == null) return false;
            var le = acmd.Expr as LiteralExpr;
            if (le == null) return false;
            if (le.IsFalse) return true;
            return false;
        }

        // check if the command cmd is "call name(...)"
        public static bool checkIsCall(string name, Cmd cmd)
        {
            if (name.Equals(""))
                return false;

            if (cmd is CallCmd)
            {
                CallCmd ccmd = (CallCmd)cmd;
                if (ccmd.Proc.Name.Equals(name))
                    return true;
            }

            return false;
        }

        // Does the implementation have an assert command
        public static bool hasAssert(Implementation impl)
        {
            foreach (Block blk in impl.Blocks)
            {
                foreach (Cmd cmd in blk.Cmds)
                {
                    if (cmd is AssertCmd)
                        return true;
                }
            }
            return false;
        }
    }

    public class BoogieAstFactory
    {
        public static List<Declaration> newDecls = new List<Declaration>();

        static int uniqueInt = 0;
        public static string uniqueLabel() 
        {
            return "L_BAF_" + (uniqueInt++);
        }

        static Dictionary<Duple<string, int>, Function> BVOperations = new Dictionary<Duple<string, int>, Function>();

        public static Function getBVOperation(string op, int bits)
        {
            var key = new Duple<string, int>(op, bits);
            if (BVOperations.ContainsKey(key))
            {
                return BVOperations[key];
            }
            var bvtype = Microsoft.Boogie.Type.GetBvType(bits);

            var arg1 = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "a", bvtype), true);
            var arg2 = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "b", bvtype), true);
            var args = new List<Variable>();
            args.Add(arg1);
            args.Add(arg2);

            var res = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "c", Microsoft.Boogie.Type.Bool), false);
            var ret = new Function(Token.NoToken, string.Format("Corral_bv_{0}_{1}", op, bits), args, res);
            
            var aval = new List<object>();
            aval.Add(op);
            ret.Attributes = new QKeyValue(Token.NoToken, "bvbuiltin", aval, null);

            BVOperations.Add(key, ret);
            newDecls.Add(ret);

            return ret;
        }

        // var := const
        public static AssignCmd MkVarEqConst(Variable v, int c)
        {
            
            AssignLhs lhs = new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(v.tok, v));
            Expr rhs = Expr.Literal(c);
            var temp1 = new List<AssignLhs>();
            var temp2 = new List<Expr>();
            temp1.Add(lhs);
            temp2.Add(rhs);
            return new AssignCmd(Token.NoToken, temp1, temp2);
        }

        // var := expr
        public static AssignCmd MkVarEqExpr(Variable v, Expr rhs)
        {
            AssignLhs lhs = new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(v.tok, v));

            var temp1 = new List<AssignLhs>();
            var temp2 = new List<Expr>();
            temp1.Add(lhs);
            temp2.Add(rhs);
            return new AssignCmd(Token.NoToken, temp1, temp2);
        }

        // var1 := var2
        public static AssignCmd MkVarEqVar(Variable v1, Variable v2)
        {
            AssignLhs lhs = new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(v1.tok, v1));

            var temp1 = new List<AssignLhs>();
            var temp2 = new List<Expr>();
            temp1.Add(lhs);
            temp2.Add(Expr.Ident(v2));
            return new AssignCmd(Token.NoToken, temp1, temp2);
        }

        // var := const
        public static AssignCmd MkVarEqConst(Variable v, bool c)
        {

            AssignLhs lhs = new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(v.tok, v));
            Expr rhs = Expr.Literal(c);
            var temp1 = new List<AssignLhs>();
            var temp2 = new List<Expr>();
            temp1.Add(lhs);
            temp2.Add(rhs);
            return new AssignCmd(Token.NoToken, temp1, temp2);
        }

        // var := var && acmd
        public static AssignCmd instrumentAssert(Variable v, AssertCmd acmd)
        {
            AssignLhs lhs = new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(v.tok, v));
            Expr rhs = Expr.And(Expr.Ident(v), acmd.Expr);

            var temp1 = new List<AssignLhs>();
            var temp2 = new List<Expr>();
            temp1.Add(lhs);
            temp2.Add(rhs);
            return new AssignCmd(Token.NoToken, temp1, temp2);
        }

        // assume c --->  assume (k == i) => c
        public static AssumeCmd instrumentAssume(AssumeCmd acmd, Variable k, int i)
        {
            var temp1 = Expr.Eq(Expr.Ident(k), Expr.Literal(i));
            var temp2 = Expr.Imp(temp1, acmd.Expr);
            return new AssumeCmd(acmd.tok, temp2);
        }

        // var < const
        public static AssumeCmd MkAssumeVarLtConst(Variable v, int c)
        {
            Expr temp1 = Expr.Ident(v);
            Expr temp2 = Expr.Literal(c);
            return new AssumeCmd(Token.NoToken, Expr.Lt(temp1, temp2));
        }

        // var >= const
        public static AssumeCmd MkAssumeVarGeConst(Variable v, int c)
        {
            Expr temp1 = Expr.Ident(v);
            Expr temp2 = Expr.Literal(c);
            return new AssumeCmd(Token.NoToken, Expr.Ge(temp1, temp2));
        }

        // var > const
        public static AssumeCmd MkAssumeVarGtConst(Variable v, int c)
        {
            Expr temp1 = Expr.Ident(v);
            Expr temp2 = Expr.Literal(c);
            return new AssumeCmd(Token.NoToken, Expr.Gt(temp1, temp2));
        }

        // var1 > var2
        public static AssumeCmd MkAssumeVarGtVar(Variable v1, Variable v2)
        {
            if (v1.TypedIdent.Type.IsInt)
            {
                Expr temp1 = Expr.Ident(v1);
                Expr temp2 = Expr.Ident(v2);
                //var t = new NAryExpr(Token.NoToken, new FunctionCall(), 
                return new AssumeCmd(Token.NoToken, Expr.Gt(temp1, temp2));
            }
            else if (v1.TypedIdent.Type.IsBv)
            {
                Expr temp1 = Expr.Ident(v1);
                Expr temp2 = Expr.Ident(v2);
                var args = new List<Expr>();
                args.Add(temp1);
                args.Add(temp2);
                var fun = getBVOperation("bvugt", v1.TypedIdent.Type.BvBits);
                var funcall = new FunctionCall(fun);

                return new AssumeCmd(Token.NoToken, new NAryExpr(Token.NoToken, funcall, args));
            }
            else
            {
                Debug.Assert(false);
                return null;
            }
        }

        // var1 > var2
        public static Expr MkExprVarGtVar(Variable v1, Variable v2)
        {
            return MkAssumeVarGtVar(v1, v2).Expr;
        }

        // var1 >= var2
        public static Expr MkExprVarGeVar(Variable v1, Variable v2)
        {
            return Expr.Ge(Expr.Ident(v1), Expr.Ident(v2));
        }


        public static Expr MkExprAnd(params Expr[] e)
        {
            Expr ret = Expr.True;
            e.Iter(expr => { ret = Expr.And(ret, expr); });
            return ret;
        }

        // old(var1) <= var2
        public static AssumeCmd MkAssumeOldVarLeVar(Variable v1, Variable v2)
        {
            var temp2 = Expr.Ident(v2);
            var temp1 = new OldExpr(Token.NoToken, Expr.Ident(v1));
            return new AssumeCmd(Token.NoToken, Expr.Le(temp1, temp2));

        }

        // var1 == const
        public static AssumeCmd MkAssumeVarEqConst(Variable v, int c)
        {
            Expr temp1 = Expr.Ident(v);
            Expr temp2 = Expr.Literal(c);
            return new AssumeCmd(Token.NoToken, Expr.Eq(temp1, temp2));
        }

        // var1 == const
        public static AssumeCmd MkAssumeVarEqConst(Variable v, bool c)
        {
            Expr temp1 = Expr.Ident(v);
            if (c)
            {
                return new AssumeCmd(Token.NoToken, temp1);
            }
            else
            {
                return new AssumeCmd(Token.NoToken, Expr.Not(temp1));
            }

        }

        public static AssumeCmd MkAssumeVarLeVar(Variable v1, Variable v2)
        {
            Expr temp1 = Expr.Ident(v1);
            Expr temp2 = Expr.Ident(v2);
            return new AssumeCmd(Token.NoToken, Expr.Le(temp1, temp2));
        }

        // var1 == var2
        public static AssumeCmd MkAssumeVarEqVar(Variable v1, Variable v2)
        {
            Expr temp1 = Expr.Ident(v1);
            Expr temp2 = Expr.Ident(v2);
            return new AssumeCmd(Token.NoToken, Expr.Eq(temp1, temp2));
        }

        // var1 == var2
        public static Expr MkExprVarEqVar(Variable v1, Variable v2)
        {
            return MkAssumeVarEqVar(v1, v2).Expr;
        }

        // var1 == const
        public static AssertCmd MkAssertVarEqConst(Variable v, bool c)
        {
            Expr temp1 = Expr.Ident(v);
            Expr temp2 = Expr.Literal(c);
            return new AssertCmd(Token.NoToken, Expr.Eq(temp1, temp2));
        }

        // havoc v
        public static HavocCmd MkHavocVar(Variable v)
        {
            List<IdentifierExpr> tmp = new List<IdentifierExpr>();
            tmp.Add(Expr.Ident(v));
            return new HavocCmd(Token.NoToken, tmp);
        }

        //assume(inAtomicBlock => (old(k) == k && not(raiseException)))
        public static AssumeCmd MkAssumeInAtomic(Variable inAtomicBlock, Variable k, Variable raiseException)
        {
            Expr tempA = Expr.Ident(inAtomicBlock);
            Expr tempK = Expr.Ident(k);
            Expr tempOK = new OldExpr(Token.NoToken, Expr.Ident(k));
            Expr tempR = Expr.Ident(raiseException);

            Expr e1 = Expr.Eq(tempK, tempOK);
            Expr e2 = Expr.Not(tempR);
            Expr e3 = Expr.And(e1, e2);
            Expr e4 = Expr.Imp(tempA, e3);

            return new AssumeCmd(Token.NoToken, e4);
        }

        // goto lbl
        public static GotoCmd MkGotoCmd(string lab)
        {
            List<String> ss = new List<String>();
            ss.Add(lab);
            return new GotoCmd(Token.NoToken, ss);
        }

        // goto lab1, lab2
        public static GotoCmd MkGotoCmd(string lab1, string lab2)
        {
            List<String> ss = new List<String>();
            ss.Add(lab1);
            ss.Add(lab2);
            return new GotoCmd(Token.NoToken, ss);
        }

        // assume (forall x:int :: map[x] == v)
        public static AssumeCmd MkMapConstant(Variable map, bool v)
        {
            BoundVariable x = new BoundVariable(Token.NoToken, 
                new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int));

            List<Variable> vs = new List<Variable>();
            vs.Add(x);

            List<Expr> args = new List<Expr>();
            args.Add(Expr.Ident(x));

            Expr cond = new ForallExpr(Token.NoToken, vs,
                Expr.Eq(Expr.Select(Expr.Ident(map), args), Expr.Literal(v)));

            return new AssumeCmd(Token.NoToken, cond);
        }

        // assume (forall x:int :: map[x] == v)
        public static AssumeCmd MkMapConstant(Variable map, int v)
        {
            BoundVariable x = new BoundVariable(Token.NoToken,
                new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int));

            List<Variable> vs = new List<Variable>();
            vs.Add(x);

            List<Expr> args = new List<Expr>();
            args.Add(Expr.Ident(x));

            Expr cond = new ForallExpr(Token.NoToken, vs,
                Expr.Eq(Expr.Select(Expr.Ident(map), args), Expr.Literal(v)));

            return new AssumeCmd(Token.NoToken, cond);
        }

        // assume (forall x:int :: (x != v1) => map[x])
        public static AssumeCmd MkJoinAllCmd1(Variable map, Variable v1)
        {
            BoundVariable x = new BoundVariable(Token.NoToken,
                new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int));

            List<Variable> vs = new List<Variable>();
            vs.Add(x);

            List<Expr> args = new List<Expr>();
            args.Add(Expr.Ident(x));

            Expr cond = new ForallExpr(Token.NoToken, vs,
                Expr.Imp(Expr.Neq(Expr.Ident(x), Expr.Ident(v1)),
                         Expr.Select(Expr.Ident(map), args)));

            return new AssumeCmd(Token.NoToken, cond);
        }

        // assume (forall x:int :: (x != v1) => map[x] <= v2)
        public static AssumeCmd MkJoinAllCmd2(Variable map, Variable v1, Variable v2)
        {
            BoundVariable x = new BoundVariable(Token.NoToken,
                new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int));

            List<Variable> vs = new List<Variable>();
            vs.Add(x);

            List<Expr> args = new List<Expr>();
            args.Add(Expr.Ident(x));

            Expr cond = new ForallExpr(Token.NoToken, vs,
                Expr.Imp(Expr.Neq(Expr.Ident(x), Expr.Ident(v1)),
                         Expr.Le(Expr.Select(Expr.Ident(map), args), Expr.Ident(v2))));

            return new AssumeCmd(Token.NoToken, cond);
        }




        // map[v] := rhs
        public static AssignCmd MkMapAssign(Variable map, Expr v, Expr rhs)
        {
            AssignLhs alhs = new SimpleAssignLhs(Token.NoToken, 
                new IdentifierExpr(Token.NoToken, map));

            var indices = new List<Expr>();
            indices.Add(v);

            MapAssignLhs lhs = new MapAssignLhs(Token.NoToken, alhs, indices);

            List<AssignLhs> lhss = new List<AssignLhs>();
            List<Expr> rhss = new List<Expr>();

            lhss.Add(lhs);
            rhss.Add(rhs);

            return new AssignCmd(Token.NoToken, lhss, rhss);
        }

        // map[v] 
        public static Expr MkMapAccessExpr(Variable map, Expr v)
        {
            var indices = new List<Expr>();
            indices.Add(v);

            return Expr.Select(Expr.Ident(map), indices);
        }

        // Factory methods added by mje -- I hope these are non redundant.

        public static Microsoft.Boogie.Type MkMapType(
            Microsoft.Boogie.Type src, Microsoft.Boogie.Type dest)
        {
            return new MapType(Token.NoToken, new List<TypeVariable>(),
                new List<Microsoft.Boogie.Type>(new Microsoft.Boogie.Type[] { src }), dest);
        }

        public static Declaration MkProc(string name, List<Variable> ins, List<Variable> outs)
        {
            return new Procedure(
                Token.NoToken, name, new List<TypeVariable>(), ins, outs, 
                new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
        }
        public static Declaration MkProc(string name, 
            IEnumerable<Variable> ins, IEnumerable<Variable> outs)
        {
            return MkProc(name, 
                new List<Variable>(ins.ToArray()),
                new List<Variable>(outs.ToArray()));
        }

        public static List<Declaration> MkImpl(string name, List<Variable> ins, List<Variable> outs, 
            List<Variable> locals, IEnumerable<Block> blocks)
        {
            var pr = MkProc(name, ins, outs);
            var im = new Implementation(
                Token.NoToken, name, new List<TypeVariable>(),
                ins, outs, locals, new List<Block>(blocks));
            im.Proc = pr as Procedure;
            return new List<Declaration>(new Declaration[] { pr, im });
        }

        //public static Implementation MkImpl(Procedure proc, List<Variable> ins, List<Variable> outs,
        //    List<Variable> locals, IEnumerable<Block> blocks)
        //{
        //    var im = new Implementation(
        //        Token.NoToken, proc.Name, new List<TypeVariable>(),
        //        ins, outs, locals, new List<Block>(blocks));
        //    im.Proc = proc;
        //    return im;
        //}

        public static List<Declaration> MkImpl(string name, List<Variable> ins, List<Variable> outs,
            List<Variable> locals, IEnumerable<Cmd> cs)
        {
            return MkImpl(name, ins, outs, locals, new Block[] { MkBlock(cs) });
        }

        public static Variable MkGlobal(string name, Microsoft.Boogie.Type t)
        {
            return new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, name, t));
        }

        public static Variable MkLocal(string name, Microsoft.Boogie.Type t)
        {
            return new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, name, t));
        }

        public static Variable MkFormal(string name, Microsoft.Boogie.Type t, bool incoming)
        {
            return new Formal(Token.NoToken, new TypedIdent(Token.NoToken, name, t), incoming);
        }

        public static Variable MkVarCopy(string name, Variable v)
        {
            if (v is GlobalVariable)
                return MkGlobal(name, v.TypedIdent.Type);
            if (v is LocalVariable)
                return MkLocal(name, v.TypedIdent.Type);
            if (v is Formal)
                return MkFormal(name, v.TypedIdent.Type, (v as Formal).InComing);
            if (v is Constant)
                return new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                    name, v.TypedIdent.Type));
            Debug.Assert(false);
            return null;
        }

        public static Expr MkEqual(Variable v, int n)
        {
            return Expr.Eq(Expr.Ident(v), Expr.Literal(n));
        }

        public static Expr MkConj(List<Expr> es)
        {
            if (es.Count < 1) return Expr.True;
            else
            {
                var e = es[0];
                es.RemoveAt(0);
                foreach (var f in es)
                    e = Expr.And(e, f);
                return e;
            }
        }

        public static Cmd MkAssume(Expr e)
        {
            return new AssumeCmd(Token.NoToken, e);
        }

        public static AssertCmd MkAssert(Expr e)
        {
            return new AssertCmd(Token.NoToken, e);
        }

        /**
         * Assignment constructors.
         **/
        public static Cmd MkAssign(Variable v, Expr e)
        {
            var lhs = new List<AssignLhs>();
            var rhs = new List<Expr>();
            lhs.Add(new SimpleAssignLhs(Token.NoToken, Expr.Ident(v)));
            rhs.Add(e);
            return new AssignCmd(Token.NoToken, lhs, rhs);
        }
        public static Cmd MkAssign(Variable v, Variable w)
        {
            return MkAssign(v, Expr.Ident(w));
        }
        public static Cmd MkAssign(Variable v, bool b)
        {
            return MkAssign(v, Expr.Literal(b));
        }
        public static Cmd MkAssign(Variable v, int i)
        {
            return MkAssign(v, Expr.Literal(i));
        }

        /**
         * Call constructors.
         **/
        public static Cmd MkCall(string proc, IEnumerable<Expr> args, IEnumerable<Variable> rets)
        {
            return new CallCmd(Token.NoToken, proc, new List<Expr>(args),
                new List<Variable>(rets).Map<Variable,IdentifierExpr>(v => 
                    Expr.Ident(v.Name, v.TypedIdent.Type)),
                null);
        }
        public static Cmd MkCall(Procedure p, IEnumerable<Expr> args, IEnumerable<Variable> rets)
        {
            return MkCall(p.Name, args, rets);
        }
        public static Cmd MkAsync(int level, string proc, IEnumerable<Expr> args)
        {
            var vs = new List<object>();
            if (level >= 0)
            {
                vs.Add(Expr.Literal(level));
            }
            else vs.Add("same");

            var attrs = new QKeyValue(Token.NoToken, "level", vs, null);
            var ret = new CallCmd(Token.NoToken, proc, new List<Expr>(args), 
                new List<IdentifierExpr>(), attrs);
            ret.IsAsync = true;

            return ret;
        }

        /**
         * Block constructors.
         */
        public static Block MkBlock(List<Cmd> cs, TransferCmd tx)
        {
            return new Block(Token.NoToken, uniqueLabel(), cs, tx);
        }
        public static Block MkBlock(IEnumerable<Cmd> cs, IEnumerable<String> tx)
        {
            return MkBlock(
                new List<Cmd>(cs.ToArray()), 
                new GotoCmd(Token.NoToken, new List<String>(tx.ToArray())));
        }        
        public static Block MkBlock(List<Cmd> cs)
        {
            return MkBlock(cs, new ReturnCmd(Token.NoToken));
        }
        public static Block MkBlock(IEnumerable<Cmd> cs)
        {
            return MkBlock(new List<Cmd>(cs.ToArray()));
        }
        public static Block MkBlock(Cmd c)
        {
            return MkBlock(new Cmd[] { c });
        }
        public static Block MkBlock()
        {
            return MkBlock(new List<Cmd>());
        }

        /*
         * Clone a block
         */
        public static Block CloneBlock(Block blk)
        {
            Block result = new Block();
            result.tok = CloneToken(blk.tok);
            result.Label = blk.Label.Clone() as String;
            result.TransferCmd = CloneTransferCmd(blk.TransferCmd);
            result.Cmds = CloneCmdSeq(blk.Cmds);
            return result;
        }

        public static List<Cmd> CloneCmdSeq(List<Cmd> cmdseq)
        {
            List<Cmd> result = new List<Cmd>(cmdseq);
            return result;
        }
        public static TransferCmd CloneTransferCmd(TransferCmd cmd)
        {
            if (cmd is GotoCmd)
                return CloneGotoCmd(cmd as GotoCmd);
            else if (cmd is ReturnCmd)
                return CloneReturnCmd(cmd as ReturnCmd);
            else
                return null;
        }
        public static GotoCmd CloneGotoCmd(GotoCmd cmd)
        {
            return new GotoCmd(CloneToken(cmd.tok), CloneStringSeq(cmd.labelNames));
        }
        public static ReturnCmd CloneReturnCmd(ReturnCmd cmd)
        {
            return new ReturnCmd(CloneToken(cmd.tok));
        }

        public static List<String> CloneStringSeq(List<String> seq)
        {
            List<String> result = new List<String>();
            foreach (string str in seq)
                result.Add(str.Clone() as String);
            return result;
        }
        public static Token CloneToken(Token tok)
        {
            return new Token(tok.line, tok.col);
        }
        public static IToken CloneToken(IToken tok)
        {
            if (tok == Token.NoToken)
                return Token.NoToken;
            else
                return CloneToken(tok as Token);
        }


        /**
         * Block sequencing.
         * Connects the last block of the first enumeration to the first block of the second.
         **/
        public static void Sequence(IEnumerable<Block> bs, IEnumerable<Block> cs)
        {
            if (bs.Count() < 1 || cs.Count() < 1) return;

            bs.Last().TransferCmd = 
                new GotoCmd(Token.NoToken, 
                    new List<String>(new String[]{cs.First().Label}));
        }

        /**
         * MkNondetSwitch( cmds1, cmds2, .., cmdsN )
         * 
         * A non-deterministic switch statement.
         * 
         * goto L1, L2, .., Ln;
         * L1: cmds1; goto L;
         * L2: cmds2; goto L;
         * ..
         * Ln: cmdsN; goto L;
         * L: skip;
         * 
         **/
        public static List<Block> MkNondetSwitch(IEnumerable<IEnumerable<Cmd>> css)
        {
            var tail = MkBlock();
            var ls = new List<String>();

            var ds = new List<Block>();
            foreach (var cs in css) 
            {
                var b = MkBlock(cs, new String[] { tail.Label });
                ls.Add(b.Label);
                ds.Add(b);
            }

            var head = MkBlock(new Cmd[] { }, ls);
            
            var bs = new List<Block>();
            bs.Add(head);
            bs.AddRange(ds);
            bs.Add(tail);
            return bs;
        }


        private static List<String> extractVars(Cmd cmd, bool getLhs, bool getRhs)
        {
            if (cmd is AssertCmd)
                return extractVars((cmd as AssertCmd).Expr);
            if (cmd is AssumeCmd)
                return extractVars((cmd as AssumeCmd).Expr);
            if (cmd is HavocCmd)
            {
                List<String> ret = new List<string>();
                foreach (IdentifierExpr v in (cmd as HavocCmd).Vars)
                {
                    ret.Add(v.Decl.Name);
                }
                return ret;
            }
            else if (cmd is CallCmd)
            {
                List<String> ret = new List<string>();
                CallCmd ccmd = cmd as CallCmd;
                if (getRhs)
                {
                    foreach (IdentifierExpr v in ccmd.Outs)
                    {
                        if (v != null) ret.Add(v.Decl.Name);
                    }
                }
                return ret;
            }
            else if (cmd is AssignCmd)
            {
                List<String> ret = new List<string>();
                var acmd = cmd as AssignCmd;
                if (getLhs)
                {
                    foreach (var ae in acmd.Lhss)
                    {
                        var v = ae.DeepAssignedVariable;
                        ret.Add(v.Name);
                    }
                }
                if (getRhs)
                {
                    foreach (var ae in acmd.Rhss)
                    {
                        ret.AddRange(extractVars(ae));
                    }
                }
                return ret;
            }

            throw new NotImplementedException("call cmd in extractvars nnot handled");

        }

        public static List<String> extractVars(Expr expr)
        {
            List<string> ret = new List<string>();
            if (expr is IdentifierExpr)
            {
                IdentifierExpr iexpr = expr as IdentifierExpr;
                ret.Add(iexpr.Decl.Name);
                return ret;
            }
            else if (expr is LiteralExpr)
            {
                return ret;
            }
            else if (expr is NAryExpr)
            {
                NAryExpr nexpr = expr as NAryExpr;
                for (int i=0;i<nexpr.Args.Count;i++)
                {
                    ret.AddRange(extractVars(nexpr.Args[i]));
                }
                return ret;
            }
            throw new NotImplementedException(expr.ToString());
        }

        public static List<String> extractRHSVars(Cmd wcmd)
        {
            return extractVars(wcmd, false, true);
        }
        public static List<String> extractLHSVars(Cmd wcmd)
        {
            return extractVars(wcmd, true, false);
        }
        public static List<String> extractVars(Cmd cmd)
        {
            return extractVars(cmd, true, true);
        }
    }

    public class NonnullInstrumentation
    {
        Program program;
        public static Dictionary<string, Dictionary<string, Expr>> cseTmpVar2Expr = new Dictionary<string, Dictionary<string, Expr>>();

        NonnullInstrumentation(Program prog)
        {
            program = prog;
        }

        public static Program Do(Program prog)
        {
            NonnullInstrumentation nni = new NonnullInstrumentation(prog);
            nni.Instrument();
            return nni.program;
        }

        // assert (expr != NULL); --> cseTmp := expr;
        // assume (expr != NULL); --> cseTmp := expr;
        private void Instrument()
        {
            // name -> implementation required for getVarsModified
            HashSet<string> impl_names = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>().Iter(impl => impl_names.Add(impl.Name));

            // FixedDuplicator to keep a copy of the old expressions in the dictionaries built in each implementation
            FixedDuplicator dup = new FixedDuplicator();


            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                int counter = 0;
                cseTmpVar2Expr.Add(impl.Name, new Dictionary<string, Expr>());

                foreach (Block b in impl.Blocks)
                {
                    List<Cmd> newCmds = new List<Cmd>();

                    foreach (Cmd c in b.Cmds)
                    {
                        newCmds.Add(c);

                        if (c is AssertCmd)
                        {
                            var ac = c as AssertCmd;
                            if (CleanAssert.validAssertCmd(ac))
                            {
                                LocalVariable lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "cseTmp" + (counter++).ToString(), Microsoft.Boogie.Type.Int));
                                impl.LocVars.Add(lv);

                                Expr expr = CleanAssert.getExprFromAssertCmd(ac);
                                cseTmpVar2Expr[impl.Name].Add(lv.Name, expr);
                                AssignCmd asc = BoogieAstFactory.MkVarEqExpr(lv, expr);
                                newCmds.Add(asc);
                            }
                        }
                        else if (c is AssumeCmd)
                        {
                            var ac = c as AssumeCmd;
                            if (CleanAssert.validAssumeCmd(ac))
                            {
                                LocalVariable lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "cseTmp" + (counter++).ToString(), Microsoft.Boogie.Type.Int));
                                impl.LocVars.Add(lv);

                                Expr expr = CleanAssert.getExprFromAssumeCmd(ac);
                                cseTmpVar2Expr[impl.Name].Add(lv.Name, expr);
                                AssignCmd asc = BoogieAstFactory.MkVarEqExpr(lv, expr);
                                newCmds.Add(asc);
                            }
                        }
                    }

                    b.Cmds = newCmds;
                }
            }
        }
    }

    // Type of phi function encoding "x3 = phi(x1,x2)"
    // Modeled: left as an uninterpreted function such that (x3 == x1 || x3 == x2)
    // Verifiable: x3 := x2 and x3 := x1 pushed up towards the definitions of x2 and x1
    // Passifiable: one after which assignments can be converted to assumes. This is
    //              currently not implemented. It requires appropriate placement
    //              of assignments for the phi function
    public enum PhiFunctionEncoding { Verifiable, Modeled, Passifiable };

    public class SSA
    {
        Program program;
        PhiFunctionEncoding encoding;
        List<Procedure> phiProcsDecl;
        HashSet<string> typesToInstrument;
        public static bool dbg = false;

        private SSA(Program program, PhiFunctionEncoding encoding, HashSet<string> typesToInstrument)
        {
            this.program = program;
            this.encoding = encoding;
            this.phiProcsDecl = new List<Procedure>();
            this.typesToInstrument = typesToInstrument;
            if (encoding == PhiFunctionEncoding.Passifiable)
                throw new NotImplementedException();
        }


        /*
         * We go to every implementation, and look at assert (expr != NULL) and assume (expr != NULL)
         * Now, we introduce a temporary variable and assignment cseTmp{i} := expr;
         * Now, as long as this temporary variable is available, we replace expr by cseTmp{i}
         * When the same expr is available from multiple vars from different predecessors, we introduce a new cseTmp{i} var := expr
         * We now perform SSA, and then do the alias analysis
         * This improves the precision of alias analysis, since these cseTmp vars are always non null, and hence, NULL cannot flow through these vars
         */
        

        public static Program Compute(Program program, PhiFunctionEncoding encoding, HashSet<string> typesToInstrument)
        {
            var irreducible = new HashSet<string>();

            var op = CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible;
            CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible = false;

            // Extract loops, we don't want cycles in the CFG            
            program.ExtractLoops(out irreducible);

            if (GVN.doGVN)
            {
                // Non null instrumentation
                program = NonnullInstrumentation.Do(program);

                // Global Value Numbering
                Stats.resume("gvn");
                program = GVN.Do(program);
                Stats.stop("gvn");

                // Writing and reading back
                Stats.resume("read.write");
                program = BoogieUtil.ReResolve(program, false);
                Stats.stop("read.write");
            }

            // Static Single Assignment
            Stats.resume("ssa");
            var ssa = new SSA(program,encoding, typesToInstrument);
            ssa.Compute(irreducible);
            Stats.stop("ssa");

            CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible = op;

            return program;
        }

        private bool instrumentType(Microsoft.Boogie.Type type)
        {
            if (type.IsMap) return false;
            if (typesToInstrument.Count == 0) return true;
            return typesToInstrument.Contains(type.ToString());
        }

        private void Compute(HashSet<string> irreducible)
        {
            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => !irreducible.Contains(impl.Name))
                .Iter(SSARename);

            program.AddTopLevelDeclarations(phiProcsDecl);
        }

        private void SSARename(Implementation impl)
        {
            // Make a unified exit block
            
            Block exitBlock = null;
            if (impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd).Count() != 1)
            {
                exitBlock = new Block(Token.NoToken, "exit$block$ssa", new List<Cmd>(), new ReturnCmd(Token.NoToken));
                foreach (var blk in impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd))
                {
                    blk.TransferCmd = new GotoCmd(Token.NoToken, new List<Block>{exitBlock});
                }
                impl.Blocks.Add(exitBlock);
            } else {
                exitBlock = impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd).First();
            }

            // Remove unreachble blocks
            impl.PruneUnreachableBlocks();

            // create CFG graph
            var graph = new Graph<Block>();

            var labelToBlock = BoogieUtil.labelBlockMapping(impl);
            foreach (var blk in impl.Blocks.Where(blk => blk.TransferCmd is GotoCmd))
            {
                var gc = blk.TransferCmd as GotoCmd;
                gc.labelNames.OfType<string>().Iter(s => graph.AddEdge(blk, labelToBlock[s]));
            }
            graph.AddSource(impl.Blocks[0]);

            /*
            Console.WriteLine("------IDOM------");
            foreach (var blk in impl.Blocks)
            {
                Console.WriteLine("{0}:", blk.Label);
                foreach (var b in graph.ImmediatelyDominatedBy(blk))
                    Console.WriteLine("    {0}", b.Label);

            }

            // Find out where phi functions are needed
            var phiBlocks = new HashSet<Block>();
            var DF = new Dictionary<Block, HashSet<Block>>();
            var idom = new Dictionary<Block, Block>();

            impl.Blocks.Iter(blk => DF.Add(blk, new HashSet<Block>()));
            impl.Blocks.Iter(blk => graph.ImmediatelyDominatedBy(blk).Iter(blk2 => idom[blk2] = blk));

            foreach (var blk in impl.Blocks)
            {
                if (graph.Predecessors(blk).Count() < 2)
                    continue;
                foreach (var pred in graph.Predecessors(blk))
                {
                    var runner = pred;
                    while (runner != idom[blk])
                    {
                        DF[runner].Add(blk);
                        runner = idom[runner];
                    }
                }
            }

            Console.WriteLine("------DF------");
            foreach (var blk in impl.Blocks)
            {
                Console.WriteLine("{0}:", blk.Label);
                foreach (var b in DF[blk])
                    Console.WriteLine("    {0}", b.Label);
            }

            DF.Values.Iter(hs => phiBlocks.UnionWith(hs));
            */

            // Lets do reaching definitions on a DAG
            var sortedBlockList = graph.TopologicalSort();
            var variables = new HashSet<Variable>();
            variables.UnionWith(impl.LocVars);
            variables.UnionWith(impl.OutParams);
            

            variables = new HashSet<Variable>(variables.Where(v => instrumentType(v.TypedIdent.Type)));

            // block -> variable -> version
            var reachDefIn = new Dictionary<Block, Dictionary<Variable, int>>();
            var reachDefOut = new Dictionary<Block, Dictionary<Variable, int>>();

            // current max version
            var maxVersion = new Dictionary<Variable, int>();
            variables.OfType<LocalVariable>().Iter(v => maxVersion[v] = 0);
            variables.OfType<Formal>().Iter(v => maxVersion[v] = 1);

            // block -> Variable -> [out-version, in-versions]
            var phiNodes = new Dictionary<Block, Dictionary<Variable, List<int>>>();
            impl.Blocks.Iter(blk => phiNodes[blk] = new Dictionary<Variable, List<int>>());

            var newVars = new Dictionary<string, LocalVariable>();

            // Variable -> int -> Variable_int
            var varInstances = new Func<Variable, int, Variable>((v, i) =>
              {
                  if (i == 0) return v;
                  if (v is LocalVariable || v is Formal)
                  {
                      var ret = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, v.Name + "_ssa_" + i, v.TypedIdent.Type));
                      if (!newVars.ContainsKey(ret.Name))
                          newVars.Add(ret.Name, ret);
                      return ret;
                  }
                  else
                  {
                      Debug.Assert(false);
                      return null;
                  }
              }
                );

            foreach (var blk in sortedBlockList)
            {
                // compute reachDefIn
                if (blk == impl.Blocks[0])
                {
                    // entry block
                    reachDefIn[blk] = new Dictionary<Variable, int>();
                    variables.OfType<LocalVariable>().Iter(v => reachDefIn[blk].Add(v, 0));
                    variables.OfType<Formal>().Iter(v => reachDefIn[blk].Add(v, 1));
                }
                else
                {
                    if (graph.Predecessors(blk).Count() == 0)
                        // unreachable block
                        Debug.Assert(false);

                    reachDefIn[blk] = new Dictionary<Variable, int>();
                    if (graph.Predecessors(blk).Count() == 1)
                        reachDefIn[blk] = new Dictionary<Variable, int>(reachDefOut[graph.Predecessors(blk).First()]);
                    else
                    {
                        // union
                        foreach (var v in variables)
                        {
                            var versions = new HashSet<int>(graph.Predecessors(blk).Select(pred => reachDefOut[pred][v]));
                            Debug.Assert(versions.Count() != 0);
                            if (versions.Count() == 1)
                            {
                                reachDefIn[blk][v] = versions.First();
                            }
                            else
                            {
                                var max = maxVersion[v] + 1;
                                maxVersion[v] = max;
                                reachDefIn[blk][v] = max;
                                // create phi node
                                phiNodes[blk].Add(v, new List<int>());
                                phiNodes[blk][v].Add(max);
                                phiNodes[blk][v].AddRange(versions);
                            }
                        }
                    }
                }

                // Now that we have reachDefIn, compute reachDefOut
                var defsOut = new Dictionary<Variable, int>(reachDefIn[blk]);

                foreach (Cmd cmd in blk.Cmds)
                {
                    defsOut = ProcessCmd(cmd, defsOut, maxVersion, varInstances);
                }
                reachDefOut[blk] = defsOut;


            }

            // Assign formals to their last version in the exit block
            foreach (var f in impl.OutParams)
            {
                if (!maxVersion.ContainsKey(f)) continue;
                exitBlock.Cmds.Add(BoogieAstFactory.MkAssign(f, varInstances(f, maxVersion[f])));
            }

            // Implement phi nodes
            ImplementPhiNodes(impl, phiNodes, varInstances);

            // Add the new local variables
            impl.LocVars.AddRange(newVars.Values);

        }

        // phiNodes: block -> Variable -> (out-version :: [in-versions])
        private void ImplementPhiNodes(Implementation impl, Dictionary<Block, Dictionary<Variable, List<int>>> phiNodes, Func<Variable, int, Variable> varInstances)
        {
            // Variable (inversion) -> Set of out-versions that it flows to
            var assignments = new Dictionary<string, HashSet<string>>();
            // string -> Variable
            var nameToVar = new Dictionary<string, Variable>();

            foreach (var tup in phiNodes)
            {
                var blk = tup.Key;
                var dict = tup.Value;
                if (dict == null || dict.Count() == 0)
                    continue;

                var ncmds = new List<Cmd>();
                foreach (var vtup in dict)
                {
                    var v = vtup.Key;
                    Debug.Assert(vtup.Value.Count() > 2);
                    var outVersion = vtup.Value[0];
                    var inVersions = new List<int>(vtup.Value);
                    inVersions.RemoveAt(0);

                    ncmds.Add(ImplementPhiNode(v, outVersion, inVersions, varInstances, assignments, nameToVar));
                }

                ncmds.AddRange(blk.Cmds);
                blk.Cmds = ncmds;
            }

            if (encoding == PhiFunctionEncoding.Modeled)
                return;

            // For x_3 := phi(x_1, x_2), push "x_3 := x_1" and "x_3 := x_2" to the definitions of x_1 and x_2
            foreach (var blk in impl.Blocks)
            {
                var ncmds = new List<Cmd>();
                foreach (Cmd cmd in blk.Cmds)
                {
                    ncmds.Add(cmd);

                    var defined = VarsDefined(cmd);
                    foreach (var inV in defined)
                    {
                        if (!assignments.ContainsKey(inV))
                            continue;
                        foreach (var outV in assignments[inV])
                            ncmds.Add(BoogieAstFactory.MkVarEqVar(nameToVar[outV], nameToVar[inV]));
                    }
                }
                blk.Cmds = ncmds;
            }

            // Delete the calls to phiNode
            foreach (var blk in impl.Blocks)
            {
                var isPhi = new Predicate<Cmd>(cmd =>
                    {
                        if (!(cmd is CallCmd)) return false;
                        var ccmd = cmd as CallCmd;
                        if (QKeyValue.FindBoolAttribute(ccmd.Attributes, "phi"))
                            return true;
                        return false;
                    });

                blk.Cmds = new List<Cmd>(blk.Cmds.OfType<Cmd>().Where(c => !isPhi(c)).ToArray());
            }

            phiProcsDecl.Clear();
        }

        // Return the set of variables assigned to by this cmd
        private HashSet<string> VarsDefined(Cmd cmd)
        {
            var ret = new HashSet<string>();

            if (cmd is AssignCmd)
            {
                var acmd = cmd as AssignCmd;
                acmd.Lhss.Iter(lhs => ret.Add(lhs.DeepAssignedVariable.Name));
                return ret;
            }
            else if (cmd is CallCmd)
            {
                var ccmd = cmd as CallCmd;
                ccmd.Outs.Iter(ie => ret.Add(ie.Name));
                return ret;
            }
            else
            {
                return new HashSet<string>();
            }

        }

        private Cmd ImplementPhiNode(Variable v, int outVersion, List<int> inVersions, Func<Variable, int, Variable> varInstances, Dictionary<string, HashSet<string>> assignments, Dictionary<string, Variable> nameToVar)
        {
            var outV = varInstances(v, outVersion);
            var inVersionVars = inVersions.Select(i => varInstances(v, i));

            var attr = new QKeyValue(Token.NoToken, "phi", new List<object>(), null);

            var inParams = inVersions.Select(i => new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x_" + i, outV.TypedIdent.Type), true));
            var outParam = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x_" + outVersion, outV.TypedIdent.Type), false);

            var proc = new Procedure(Token.NoToken, "phiNode$" + phiProcsDecl.Count, new List<TypeVariable>(),
                new List<Variable>(inParams.ToArray()), new List<Variable>(new Variable[] { outParam }), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
            phiProcsDecl.Add(proc);

            Expr expr = Expr.False;
            inParams.Iter(i => expr = Expr.Or(expr, Expr.Eq(Expr.Ident(outParam), Expr.Ident(i))));
            proc.Ensures.Add(new Ensures(true, expr));

            var callCmd = new CallCmd(Token.NoToken, proc.Name, new List<Expr>(inVersionVars.Select(x => Expr.Ident(x)).ToArray()), new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(outV) }));
            callCmd.Proc = proc;
            callCmd.Attributes = attr;

            // fill the map assignments (inv -> outV)
            foreach (var inV in inVersionVars)
            {
                if (!assignments.ContainsKey(inV.Name))
                    assignments.Add(inV.Name, new HashSet<string>());
                assignments[inV.Name].Add(outV.Name);

                nameToVar[inV.Name] = inV;
            }
            nameToVar[outV.Name] = outV;

            return callCmd;
        }

        private Dictionary<Variable, int> ProcessCmd(Cmd cmd, Dictionary<Variable, int> defsIn, Dictionary<Variable, int> maxVersion, Func<Variable, int, Variable> varInstances)
        {
            var renamer = new Func<Expr, Dictionary<Variable, int>, Expr>((e, d) =>
                Substituter.Apply(new Substitution(v => 
                {
                    if(!d.ContainsKey(v)) return Expr.Ident(v);
                    else return Expr.Ident(varInstances(v, d[v]));
                }), e)
                );

            var defsOut = new Dictionary<Variable, int>();
            if (cmd is PredicateCmd)
            {
                defsOut = new Dictionary<Variable, int>(defsIn);
                // rename variables
                (cmd as PredicateCmd).Expr = renamer((cmd as PredicateCmd).Expr, defsIn);
            }
            else if (cmd is HavocCmd)
            {
                var hvars = new HashSet<Variable>((cmd as HavocCmd).Vars.OfType<IdentifierExpr>().Select(ie => ie.Decl).Where(v => defsIn.ContainsKey(v)));
                foreach (var tup in defsIn)
                {
                    var v = tup.Key;
                    if (hvars.Contains(v))
                    {
                        var max = maxVersion[v] + 1;
                        maxVersion[v] = max;
                        defsOut[v] = max;
                    }
                    else
                    {
                        defsOut[v] = defsIn[v];
                    }
                }
                var nhvars = new List<IdentifierExpr>();
                foreach (var ie in (cmd as HavocCmd).Vars.OfType<IdentifierExpr>())
                {
                    if (defsOut.ContainsKey(ie.Decl))
                    {
                        nhvars.Add(Expr.Ident(varInstances(ie.Decl, defsOut[ie.Decl])));
                    }
                    else
                    {
                        nhvars.Add(ie);
                    }
                }

            }
            else if (cmd is AssignCmd)
            {
                var acmd = cmd as AssignCmd;
                var assignedVars = new HashSet<Variable>();
                acmd.Lhss.Iter(lhs => assignedVars.Add(lhs.DeepAssignedVariable));

                foreach (var tup in defsIn)
                {
                    var v = tup.Key;
                    if (assignedVars.Contains(v))
                    {
                        var max = maxVersion[v] + 1;
                        maxVersion[v] = max;
                        defsOut[v] = max;
                    }
                    else
                    {
                        defsOut[v] = defsIn[v];
                    }
                }

                // Note: here we use the assumption that SSA is only done for scalar variables
                // Hence, we only need to worry about SimpleAssignLhs
                acmd.Rhss = new List<Expr>(acmd.Rhss.Select(e => renamer(e, defsIn)));
                for (int i = 0; i < acmd.Lhss.Count; i++) 
                {
                    var lhs = acmd.Lhss[i];
                    if (lhs is SimpleAssignLhs && defsIn.ContainsKey((lhs as SimpleAssignLhs).AssignedVariable.Decl))
                    {
                        var v = (lhs as SimpleAssignLhs).AssignedVariable.Decl;
                        acmd.SetAssignCmdLhs(i, new SimpleAssignLhs(lhs.tok, Expr.Ident(varInstances(v, defsOut[v]))));
                    }
                    else if(lhs is MapAssignLhs)
                    {
                        var mlhs = lhs as MapAssignLhs;
                        mlhs.Indexes = new List<Expr>(mlhs.Indexes.Select(e => renamer(e, defsIn)));
                    }
                }
            }
            else if (cmd is CallCmd)
            {
                var ccmd = cmd as CallCmd;
                var assignedVars = new HashSet<Variable>();
                ccmd.Outs.Iter(ie => assignedVars.Add(ie.Decl));

                foreach (var tup in defsIn)
                {
                    var v = tup.Key;
                    if (assignedVars.Contains(v))
                    {
                        var max = maxVersion[v] + 1;
                        maxVersion[v] = max;
                        defsOut[v] = max;
                    }
                    else
                    {
                        defsOut[v] = defsIn[v];
                    }
                }

                ccmd.Ins = new List<Expr>(ccmd.Ins.Select(e => renamer(e, defsIn)));
                ccmd.Outs = new List<IdentifierExpr>(ccmd.Outs.Select(e => renamer(e, defsOut) as IdentifierExpr));
            }
            else
            {
                Debug.Assert(false);
            }

            return defsOut;
        }
    }

    public class GVN
    {
        Program program;
        public static bool doGVN = true;

        // Track the non-null exprs in each block
        public static Dictionary<string, HashSet<Term>> non_null_exprs;

        // operator -> (t1, t2) -> t3
        public static Dictionary<string, Dictionary<Terms, Term>> hash_function;
        
        // default variable for a term cseTemp:= expr --> default_var(t_expr) = cseTmp
        // block -> term -> cseTmp variable
        public static Dictionary<string, Dictionary<Term, Variable>> default_var;

        // block -> var -> term
        public static Dictionary<string, Dictionary<string, Term>> hash_value;
        
        // current block
        public static string currBlock;
        public static bool dbg = false;
        public static HashSet<string> impl_names = new HashSet<string>();

        // Abstract representation of Expr
        public class Term
        {
            int u_id;
            static int VALUE = 0;

            public Term(int u = 0)
            {
                u_id = u;
            }

            public Term()
            {
                u_id = VALUE++;
            }

            public static void resetVal()
            {
                VALUE = 0;
            }

            public override bool Equals(object obj)
            {
                if ((obj is Term) && (u_id == (obj as Term).u_id)) return true;
                else return false;
            }

            public override int GetHashCode()
            {
                return u_id;
            }
            
            public override string ToString()
            {
                return "Term_" + u_id.ToString();
            }
        }

        // Abstract representation of arguments of NAryExpr
        public class Terms
        {
            List<Term> args;

            public Terms(List<Term> ts)
            {
                args = ts;
            }

            public Terms()
            {
                args = new List<Term>();
            }

            public override bool Equals(object obj)
            {
                if (obj is Terms)
                {
                    var ts = obj as Terms;
                    if (args.Count == ts.args.Count)
                    {
                        for (int i = 0 ; i < args.Count ; i++)
                        {
                            if (!args[i].Equals(ts.args[i])) return false;
                        }
                        return true;
                    }
                    return false;
                }
                return false;
            }

            public override int GetHashCode()
            {
                int sum = 0;
                foreach (Term t in args) sum += t.GetHashCode();
                return sum;
            }

            public override string ToString()
            {
                string st;
                st = "(";
                foreach (Term t in args)
                {
                    st = st + t.ToString() + ", ";
                }
                st = st + ")";
                return st;
            }

            public void Add(Term t)
            {
                args.Add(t);
            }
        }

        // Perform substitution
        private class GVNVisitor : StandardVisitor
        {
            Expr currExpr;

            GVNVisitor()
            {

            }

            public static Expr getExpr(Expr given_expr)
            {
                if (given_expr == null) return null;
                var gvn = new GVNVisitor();
                gvn.currExpr = gvn.VisitExpr(given_expr);
                return gvn.currExpr;
            }

            // Compute hash value and perform subsitution if possible
            public override Expr VisitExpr(Expr node)
            {
                Term t = ComputeHash(node);
                if (non_null_exprs[currBlock].Contains(t)) return Expr.Ident(default_var[currBlock][t]);
                else return base.VisitExpr(node);
            }

            // Compute hash value
            // x -> hash_value[x];
            // foo(y,z) -> hash_function[foo][{y,z}]
            // y + z -> hash_function[+][{y,z}]
            public static Term ComputeHash(Expr expr)
            {
                if (expr is IdentifierExpr)
                {
                    IdentifierExpr id = expr as IdentifierExpr;
                    if (!hash_value[currBlock].ContainsKey(id.Decl.Name)) hash_value[currBlock].Add(id.Decl.Name, new Term());
                    if (dbg) Console.WriteLine("{0} -> {1}", id.Decl.Name, hash_value[currBlock][id.Decl.Name].ToString());
                    return hash_value[currBlock][id.Decl.Name];
                }
                else if (expr is NAryExpr)
                {
                    NAryExpr nexpr = expr as NAryExpr;
                    string op = nexpr.Fun.FunctionName;
                    if (!hash_function.ContainsKey(op)) hash_function.Add(op, new Dictionary<Terms, Term>());
                    Terms t_args = new Terms();
                    foreach (Expr arg in nexpr.Args)
                    {
                        Term t = ComputeHash(arg);
                        t_args.Add(t);
                    }
                    if (!hash_function[op].ContainsKey(t_args)) hash_function[op].Add(t_args, new Term());

                    if (dbg) Console.WriteLine("{2} => {0} -> {1}", t_args.ToString(), hash_function[op][t_args].ToString(), op);
                    return hash_function[op][t_args];
                }
                else if (expr is LiteralExpr)
                {
                    LiteralExpr le = expr as LiteralExpr;
                    if (!hash_value[currBlock].ContainsKey(le.Val.ToString())) hash_value[currBlock].Add(le.Val.ToString(), new Term());
                    if (dbg) Console.WriteLine("{0} -> {1}", le.Val.ToString(), hash_value[currBlock][le.Val.ToString()].ToString());
                    return hash_value[currBlock][le.Val.ToString()];
                }
                else if (expr is OldExpr)
                {
                    return new Term();
                }
                else if (expr is QuantifierExpr)
                {
                    return new Term();
                }
                else
                {
                    Debug.Assert(false);
                    return new Term();
                }
            }
        }

        private GVN(Program program)
        {
            this.program = program;
            non_null_exprs = new Dictionary<string, HashSet<Term>>();
            hash_function = new Dictionary<string, Dictionary<Terms, Term>>();
            default_var = new Dictionary<string, Dictionary<Term, Variable>>();
            hash_value = new Dictionary<string, Dictionary<string, Term>>();
        }

        // Perform GVN
        private void DoGVN()
        {
            program.TopLevelDeclarations.OfType<Implementation>().Iter(impl => impl_names.Add(impl.Name));


            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                IEnumerable<Block> sortedBlocks;
                if (dbg) Console.WriteLine("Impl : {0} =>", impl.Name);
                Term.resetVal();
                int counter = 0;

                // Computing predecessors, constructing CFG and topological sorting of blocks
                impl.ComputePredecessorsForBlocks();
                Graph<Block> dag = Microsoft.Boogie.Program.GraphFromImpl(impl);
                sortedBlocks = dag.TopologicalSort();

                non_null_exprs.Clear();
                hash_function.Clear();
                default_var.Clear();
                hash_value.Clear();

                foreach (Block blk in sortedBlocks)
                {
                    // nonnull terms available from all predecessors
                    Dictionary<Term, int> nonnull_pred_count = new Dictionary<Term, int>();
                    // terms available from all predecessors
                    Dictionary<string, Tuple<int, Term>> var_pred_count = new Dictionary<string, Tuple<int, Term>>();

                    // initializations for the current block
                    non_null_exprs.Add(blk.Label, new HashSet<Term>());
                    hash_value.Add(blk.Label, new Dictionary<string, Term>());
                    default_var.Add(blk.Label, new Dictionary<Term, Variable>());

                    if (dbg) Console.WriteLine("Block : {0}", blk.Label);

                    // expr available from all predecessors
                    foreach (Block b in blk.Predecessors)
                    {
                        foreach (Term t in non_null_exprs[b.Label])
                        {
                            if (!nonnull_pred_count.ContainsKey(t)) nonnull_pred_count.Add(t, 0);
                            nonnull_pred_count[t]++;
                        }

                        // if same variable available from multiple predecessors via different terms, add a new term for variable
                        // else carry over the same term
                        foreach (string var in hash_value[b.Label].Keys)
                        {
                            if (!var_pred_count.ContainsKey(var))
                            {
                                var_pred_count[var] = new Tuple<int, Term>(1, hash_value[b.Label][var]);
                            }
                            else if (var_pred_count.ContainsKey(var) && var_pred_count[var].Item2 == null)
                            {
                                var_pred_count[var] = new Tuple<int, Term>(var_pred_count[var].Item1 + 1, null);
                            }
                            else if (var_pred_count.ContainsKey(var) && !var_pred_count[var].Item2.Equals(hash_value[b.Label][var]))
                            {
                                var_pred_count[var] = new Tuple<int, Term>(var_pred_count[var].Item1 + 1, null);
                            }
                            else
                            {
                                var_pred_count[var] = new Tuple<int, Term>(var_pred_count[var].Item1 + 1, var_pred_count[var].Item2);
                            }
                        }
                    }
                    currBlock = blk.Label;

                    foreach (Term t in nonnull_pred_count.Keys)
                    {
                        if (nonnull_pred_count[t] == blk.Predecessors.Count) non_null_exprs[blk.Label].Add(t);
                    }

                    // bool denotes multiple occurences
                    Dictionary<Term, Tuple<Variable, bool>> default_var_preds = new Dictionary<Term, Tuple<Variable, bool>>();

                    foreach (Term t in non_null_exprs[blk.Label])
                    {
                        foreach (Block b in blk.Predecessors)
                        {
                            if (!default_var_preds.ContainsKey(t))
                            {
                                default_var_preds.Add(t, new Tuple<Variable, bool>(default_var[b.Label][t], false));
                            }
                            else if (default_var_preds[t] != null)
                            {
                                if (!default_var[b.Label][t].Name.Equals(default_var_preds[t].Item1.Name))
                                {
                                    default_var_preds[t] = new Tuple<Variable, bool>(default_var_preds[t].Item1, true);
                                }
                            }
                        }
                    }

                    List<Cmd> newCmds = new List<Cmd>();

                    foreach (Term t in default_var_preds.Keys)
                    {
                        if (default_var_preds[t].Item2 == false)
                        {
                            default_var[blk.Label].Add(t, default_var_preds[t].Item1);
                        }
                        else
                        {
                            LocalVariable lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "cseTmpGVN" + (counter++).ToString(), Microsoft.Boogie.Type.Int));
                            impl.LocVars.Add(lv);
                            default_var[blk.Label].Add(t, lv);

                            AssignCmd asc = BoogieAstFactory.MkVarEqExpr(lv, NonnullInstrumentation.cseTmpVar2Expr[impl.Name][default_var_preds[t].Item1.Name]);
                            NonnullInstrumentation.cseTmpVar2Expr[impl.Name].Add(lv.Name, NonnullInstrumentation.cseTmpVar2Expr[impl.Name][default_var_preds[t].Item1.Name]);

                            newCmds.Add(asc);
                        }
                    }

                    foreach (string var in var_pred_count.Keys)
                    {
                        if (var_pred_count[var].Item1 == blk.Predecessors.Count)
                        {
                            // carrying over same term
                            if (var_pred_count[var].Item2 != null)
                                hash_value[blk.Label].Add(var, var_pred_count[var].Item2);
                            // introducing a new term
                            else
                                hash_value[blk.Label].Add(var, new Term());
                        }
                    }

                    if (dbg)
                    {
                        Console.WriteLine("HASH VALUES");
                        hash_value[blk.Label].Keys.Iter(k => Console.WriteLine("{0} -> {1}", k, hash_value[blk.Label][k]));
                    }

                    // ProcessCmd
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        if (dbg) Console.WriteLine(cmd.ToString());
                        Cmd cmd_out = ProcessCmd(cmd);
                        if (dbg) Console.WriteLine(cmd_out.ToString());
                        newCmds.Add(cmd_out);

                        if (cmd is AssignCmd)
                        {
                            var acmd = cmd as AssignCmd;
                            if (CleanAssert.validAssignCmd(acmd))
                            {
                                Term t = GVNVisitor.ComputeHash(acmd.Rhss[0]);
                                non_null_exprs[blk.Label].Add(t);
                                if (!default_var[blk.Label].ContainsKey(t)) default_var[blk.Label].Add(t, (acmd.Lhss[0] as SimpleAssignLhs).DeepAssignedVariable);
                                if (dbg) Console.WriteLine("Non-NULL {0} -> {1}", acmd.Rhss[0], t.ToString());
                            }
                        }
                    }
                    blk.Cmds = newCmds;
                }
            }
        }

        // Find expr and perform substitution
        private Cmd ProcessCmd(Cmd c)
        {
            if (c is AssumeCmd)
            {
                var ac = c as AssumeCmd;
                ac.Expr = GVNVisitor.getExpr(ac.Expr);
                return c;
            }
            else if (c is AssertCmd)
            {
                var ac = c as AssertCmd;
                ac.Expr = GVNVisitor.getExpr(ac.Expr);
                return c;
            }
            else if (c is CallCmd)
            {
                var cc = c as CallCmd;

                for (int i = 0; i < cc.Ins.Count; i++)
                {
                    Expr rhs = cc.Ins[i];
                    cc.Ins[i] = GVNVisitor.getExpr(rhs);
                }

                HashSet<string> vars_modified = BoogieUtil.getVarsModified(c, impl_names);
                foreach (string s in vars_modified)
                {
                    if (!hash_value[currBlock].ContainsKey(s)) hash_value[currBlock].Add(s, new Term(-1));
                    hash_value[currBlock][s] = new Term();
                    if (dbg) Console.WriteLine("{0} -> {1}", s, hash_value[currBlock][s]);
                }
                return c;
            }
            else if (c is AssignCmd)
            {
                var ac = c as AssignCmd;
                for (int i = 0; i < ac.Rhss.Count; i++)
                {
                    Expr rhs = ac.Rhss[i];
                    ac.SetAssignCmdRhs(i, GVNVisitor.getExpr(rhs));
                    AssignLhs lhs = ac.Lhss[i];
                    if (lhs is SimpleAssignLhs)
                    {
                        var slhs = lhs as SimpleAssignLhs;
                        if (!hash_value[currBlock].ContainsKey(slhs.DeepAssignedVariable.Name)) hash_value[currBlock].Add(slhs.DeepAssignedVariable.Name, new Term(-1));
                        hash_value[currBlock][slhs.DeepAssignedVariable.Name] = GVNVisitor.ComputeHash(rhs);
                        if (dbg) Console.WriteLine("{0} -> {1}", slhs.DeepAssignedVariable.Name, hash_value[currBlock][slhs.DeepAssignedVariable.Name]);
                    }
                    else if (lhs is MapAssignLhs)
                    {
                        HashSet<string> vars_modified = BoogieUtil.getVarsModified(c, impl_names);
                        foreach (string s in vars_modified)
                        {
                            if (!hash_value[currBlock].ContainsKey(s)) hash_value[currBlock].Add(s, new Term(-1));
                            hash_value[currBlock][s] = new Term();
                            if (dbg) Console.WriteLine("{0} -> {1}", s, hash_value[currBlock][s]);
                        }

                        var mlhs = lhs as MapAssignLhs;
                        List<Expr> newlhs = new List<Expr>();
                        foreach (Expr expr in mlhs.Indexes)
                        {
                            Expr newExpr = GVNVisitor.getExpr(expr);
                            newlhs.Add(newExpr);
                        }
                        mlhs.Indexes = newlhs;
                    }
                }
                return c;
            }
            else
            {
                Debug.Assert(false);
                return c;
            }
        }

        public static Program Do(Program program)
        {
            GVN gvn = new GVN(program);
            gvn.DoGVN();
            return gvn.program;
        }

    }

    public class CleanAssert
    {
        // Check if an expression is NULL expression
        public static bool checkIfNull(Expr expr)
        {
            if (expr is IdentifierExpr)
            {
                return (expr as IdentifierExpr).ToString().Equals("NULL");
            }
            return false;
        }

        private static bool checkIfNot(IAppliable fun)
        {
            if (fun is UnaryOperator &&
                (fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                return true;
            else return false;
        }

        private static bool checkIfAliasingQuery(IAppliable fun)
        {
            if (fun is FunctionCall &&
                BoogieUtil.checkAttrExists("aliasingQuery", (fun as FunctionCall).Func.Attributes))
                return true;
            else return false;
        }

        // Check if assert cmd is assert !aliasQnull(var, NULL) or assert !aliasQnull(M[x], NULL)
        public static bool validAssertCmd(AssertCmd ac)
        {
            if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == null) return false;
            if (ac.Expr != null &&
                ac.Expr is NAryExpr &&
                checkIfNot(((NAryExpr)ac.Expr).Fun) &&
                ((NAryExpr)ac.Expr).Args != null &&
                (((NAryExpr)ac.Expr).Args).First() is NAryExpr &&
                checkIfAliasingQuery(((NAryExpr)((NAryExpr)ac.Expr).Args[0]).Fun) &&
                ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args != null &&
                ((NAryExpr)((NAryExpr)ac.Expr).Args[0]).Args.Count >= 2 &&
                checkIfNull(((NAryExpr)((NAryExpr)ac.Expr).Args[0]).Args[1]))
                return true;
            else return false;
        }

        // Check if AssertCmd is assert !aliasQnull(var, NULL)
        public static bool validAssert(AssertCmd ac)
        {
            if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == null) return false;
            if (ac.Expr != null &&
                ac.Expr is NAryExpr &&
                ((NAryExpr)ac.Expr).Args != null &&
                (((NAryExpr)ac.Expr).Args).First() is NAryExpr &&
                ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args != null)
                return true;
            else return false;
        }

        public static bool validAssignCmd(AssignCmd ac)
        {
            if (ac.Lhss.Count == 1 && ac.Lhss[0] is SimpleAssignLhs && (ac.Lhss[0] as SimpleAssignLhs).DeepAssignedVariable.Name.StartsWith("cseTmp")) return true;
            else return false;
        }

        // Extracting variable name from AssertCmd
        public static IdentifierExpr getVarFromAssert(AssertCmd ac)
        {
            return ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args.OfType<IdentifierExpr>().First();
        }

        // Get expression from assert cmd, assert (expr != NULL)
        public static Expr getExprFromAssert(AssertCmd ac)
        {
            return ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args.First();
        }

        // Get "NULL" from assertion
        public static string getNULLFromAssert(AssertCmd ac)
        {
            return ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args[1].ToString();
        }

        // Get expression from assume cmd, assume (expr != NULL)
        public static Expr getExprFromAssume(AssumeCmd ac)
        {
            return (((NAryExpr)ac.Expr).Args.First());
        }

        // Get "NULL" from assume cmd
        public static string getNULLFromAssume(AssumeCmd ac)
        {
            return (((NAryExpr)ac.Expr).Args[1]).ToString();
        }

        public static string getQueryFromAssert(AssertCmd ac)
        {
            return ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Fun.FunctionName;
        }

        // Check if AssumeCmd is assume (var != NULL)
        public static bool validAssume(AssumeCmd asc)
        {
            if (asc.Expr is NAryExpr)
            {
                NAryExpr asc_expr = (NAryExpr)asc.Expr;
                if (asc_expr.Fun != null &&
                    asc_expr.Fun is BinaryOperator &&
                    ((BinaryOperator)asc_expr.Fun).Op == BinaryOperator.Opcode.Neq &&
                    asc_expr.Args.Count == 2 &&
                    asc_expr.Args[0] is IdentifierExpr &&
                    asc_expr.Args[1] is IdentifierExpr &&
                    checkIfNull(asc_expr.Args[1])) return true;
                else return false;
            }
            else return false;
        }


        // Check if assume cmd is assume (M[expr] != NULL) or assume (var != NULL)
        public static bool validAssumeCmd(AssumeCmd asc)
        {
            if (asc.Expr is NAryExpr)
            {
                NAryExpr asc_expr = (NAryExpr)asc.Expr;
                if (asc_expr.Fun != null &&
                    asc_expr.Fun is BinaryOperator &&
                    ((BinaryOperator)asc_expr.Fun).Op == BinaryOperator.Opcode.Neq &&
                    asc_expr.Args.Count == 2 &&
                    ((asc_expr.Args[0] is IdentifierExpr) || (asc_expr.Args[0] is NAryExpr &&
                    (asc_expr.Args[0] as NAryExpr).Fun is MapSelect)) &&
                    asc_expr.Args[1] is IdentifierExpr &&
                    checkIfNull(asc_expr.Args[1])) return true;
                else return false;
            }
            else return false;
        }

        // Check if AssumeCmd is assume (M[x] != NULL)
        public static bool validMapAssume(AssumeCmd asc)
        {
            if (asc.Expr is NAryExpr)
            {
                NAryExpr asc_expr = (NAryExpr)asc.Expr;
                if (asc_expr.Fun != null &&
                    asc_expr.Fun is BinaryOperator &&
                    ((BinaryOperator)asc_expr.Fun).Op == BinaryOperator.Opcode.Neq &&
                    asc_expr.Args.Count == 2 &&
                    asc_expr.Args[0] is NAryExpr &&
                    (asc_expr.Args[0] as NAryExpr).Fun is MapSelect &&
                    asc_expr.Args[1] is IdentifierExpr &&
                    checkIfNull(asc_expr.Args[1])) return true;
                else return false;
            }
            else return false;
        }

        // Extract variable name from AssumeCmd
        public static IdentifierExpr getVarFromAssume(AssumeCmd asc)
        {
            return (IdentifierExpr)(((NAryExpr)asc.Expr).Args.OfType<IdentifierExpr>().First());
        }

        // Returns true if ac.Expr is !(expr == NULL)
        public static bool isNullAssertCmd(AssertCmd ac)
        {
            if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == null) return false;

            if (ac.Expr != null &&
                ac.Expr is NAryExpr &&
                checkIfNot((ac.Expr as NAryExpr).Fun))
            {
                Expr expr = (ac.Expr as NAryExpr).Args[0];
                if (expr is NAryExpr)
                {
                    var nexpr = expr as NAryExpr;
                    if (nexpr.Fun is BinaryOperator &&
                        (nexpr.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Eq &&
                        checkIfNull(nexpr.Args[1])) 
                            return true;
                }
            }
            return false;
        }

        public static Expr getExprFromAssertCmd(AssertCmd ac)
        {
            var expr = (ac.Expr as NAryExpr).Args[0];
            return (expr as NAryExpr).Args[0];
        }

        public static string getNULLFromAssertCmd(AssertCmd ac)
        {
            var expr = (ac.Expr as NAryExpr).Args[0];
            return (expr as NAryExpr).Args[1].ToString();
        }

        // Returns true if ac.Expr is (expr != NULL)
        public static bool isNullAssumeCmd(AssumeCmd ac)
        {
            if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == null) return false;

            if (ac.Expr != null &&
                ac.Expr is NAryExpr)
            {
                var expr = ac.Expr as NAryExpr;
                if (expr.Fun is BinaryOperator &&
                    (expr.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Neq &&
                    checkIfNull(expr.Args[1])) 
                        return true;
            }
            return false;
        }

        public static Expr getExprFromAssumeCmd(AssumeCmd ac)
        {
            return (ac.Expr as NAryExpr).Args[0];
        }

        public static string getNULLFromAssumeCmd(AssumeCmd ac)
        {
            return (ac.Expr as NAryExpr).Args[1].ToString();
        }
    }
}
