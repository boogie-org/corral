using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System.Diagnostics;

namespace Microsoft.Boogie
{
    public class BoogieUtil
    {
        public static bool InitializeBoogie(string clo)
        {
            CommandLineOptions.Clo.RunningBoogieFromCommandLine = true;

            var quotes = clo.Split(new char[] { '\"' }, StringSplitOptions.RemoveEmptyEntries);
            var args = new List<string>();
            for (int i = 0; i < quotes.Length; i++)
            {
                if (i == 0 || i == quotes.Length - 1)
                    args.AddRange(quotes[i].Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
                else
                    args.Add(quotes[i]);
            }

            CommandLineOptions.Clo.Parse(args.ToArray());

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
                    if (v.Decl is GlobalVariable) ret.Add(v.Decl.Name);
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
            reachable.Add(mainProcName);

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
                    if (v != null) ret.Add(v.Decl.Name);
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
        public static List<object> getAttr(string name, QKeyValue attr)
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

        public static Program ReadAndResolve(string filename)
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
            if (TypecheckProgram(p, filename))
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
        public static Program ReResolve(Program p)
        {
            return ReResolve(p, "temp_rar.bpl");
        }

        // Prints the program into a file, reads it back in, parses it,
        // resolves it and typechecks it
        public static Program ReResolve(Program p, string filename)
        {
            PrintProgram(p, filename);
            return ReadAndResolve(filename);
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

        public static List<GlobalVariable> GetGlobalVariables(Program p)
        {
            return p.TopLevelDeclarations.Filter(x => x is GlobalVariable).Map(x => x as GlobalVariable);
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

        public static List<Procedure> GetProcedures(Program p)
        {
            return p.TopLevelDeclarations.Filter(x => x is Procedure).Map(x => x as Procedure);
        }

        public static HashSet<string> GetAllProcNames(Program p)
        {
            var ret = new HashSet<string>();
            p.TopLevelDeclarations.Filter(x => x is Procedure).ForEach(x => ret.Add((x as Procedure).Name));
            return ret;
        }

        public static HashSet<string> GetAllImplNames(Program p)
        {
            var ret = new HashSet<string>();
            p.TopLevelDeclarations.Filter(x => x is Implementation).ForEach(x => ret.Add((x as Implementation).Name));
            return ret;
        }

        public static List<Implementation> GetImplementations(Program p)
        {
            return p.TopLevelDeclarations.Filter(x => x is Implementation).Map(x => x as Implementation);
        }

        public static GlobalVariable findVarDecl(List<Declaration> decls, string varname)
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

        public static Procedure findProcedureDecl(List<Declaration> decls, string procname)
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

        public static Implementation findProcedureImpl(List<Declaration> decls, string procname)
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

        public static Cmd MkAssert(Expr e)
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
                new List<Variable>(rets).Map<Variable, IdentifierExpr>(v =>
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
                    new List<String>(new String[] { cs.First().Label }));
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
                for (int i = 0; i < nexpr.Args.Count; i++)
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

        private SSA(Program program, PhiFunctionEncoding encoding, HashSet<string> typesToInstrument)
        {
            this.program = program;
            this.encoding = encoding;
            this.phiProcsDecl = new List<Procedure>();
            this.typesToInstrument = typesToInstrument;
            if (encoding == PhiFunctionEncoding.Passifiable)
                throw new NotImplementedException();
        }

        public static Program Compute(Program program, PhiFunctionEncoding encoding, HashSet<string> typesToInstrument)
        {
            var ssa = new SSA(program, encoding, typesToInstrument);
            ssa.Compute();
            return program;
        }

        private bool instrumentType(Microsoft.Boogie.Type type)
        {
            if (type.IsMap) return false;
            if (typesToInstrument.Count == 0) return true;
            return typesToInstrument.Contains(type.ToString());
        }

        private void Compute()
        {
            var irreducible = new HashSet<string>();

            var op = CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible;
            CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible = false;

            // Extract loops, we don't want cycles in the CFG            
            program.ExtractLoops(out irreducible);
            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => !irreducible.Contains(impl.Name))
                .Iter(SSARename);

            program.TopLevelDeclarations.AddRange(phiProcsDecl);

            CommandLineOptions.Clo.ExtractLoopsUnrollIrreducible = op;
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
                    blk.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { exitBlock });
                }
                impl.Blocks.Add(exitBlock);
            }
            else
            {
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
                    var ret = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, v.Name + "_" + i, v.TypedIdent.Type));
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

                #region Assert_Assume_Cmds
                int index = 0;
                List<int> add_index = new List<int>();
                List<Cmd> add_cmd = new List<Cmd>();
                foreach (Cmd cmd in blk.Cmds)
                {
                    index++;
                    if (cmd is AssumeCmd)
                    {
                        var ac = cmd as AssumeCmd;
                        if (CleanAssert.validAssume(ac))
                        {
                            Variable v = CleanAssert.getVarFromAssume(ac).Decl;
                            add_cmd.Add(BoogieAstFactory.MkVarEqVar(v, v));
                            add_index.Add(index);
                        }
                    }
                    else if (cmd is AssertCmd)
                    {
                        var ac = cmd as AssertCmd;
                        if (CleanAssert.validAssert(ac))
                        {
                            Variable v = CleanAssert.getVarFromAssert(ac).Decl;
                            add_cmd.Add(BoogieAstFactory.MkVarEqVar(v, v));
                            add_index.Add(index);
                        }
                    }
                }
                for (int i = 0; i < add_index.Count; i++) blk.Cmds.Insert(add_index[i] + i, add_cmd[i]);
                #endregion

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
                    if (!d.ContainsKey(v)) return Expr.Ident(v);
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
                        acmd.Lhss[i] = new SimpleAssignLhs(lhs.tok, Expr.Ident(varInstances(v, defsOut[v])));
                    }
                    else if (lhs is MapAssignLhs)
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

    public class CleanAssert
    {
        Program program;
        Dictionary<KeyValuePair<Implementation, Block>, HashSet<string>> live_var_dictionary;   // implementation, block -> live variables in block
        Dictionary<Implementation, HashSet<int>> non_null_funcs;    // Functions which return non-null variables

        private CleanAssert(Program program)
        {
            this.program = program;
        }

        public static Program CleanAssertStmt(Program program)
        {
            var ca = new CleanAssert(program);
            ca.Clean();
            return ca.program;
        }

        // Check if an expression is NULL expression
        public static bool checkIfNull(Expr expr)
        {
            return (expr as IdentifierExpr).ToString().Equals("NULL");
        }

        // Check if AssertCmd is assert (var != NULL)
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

        // Extracting variable name from AssertCmd
        public static IdentifierExpr getVarFromAssert(AssertCmd ac)
        {
            return ((NAryExpr)(((NAryExpr)ac.Expr).Args).First()).Args.OfType<IdentifierExpr>().First();
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

        // Extract variable name from AssumeCmd
        public static IdentifierExpr getVarFromAssume(AssumeCmd asc)
        {
            return (IdentifierExpr)(((NAryExpr)asc.Expr).Args.OfType<IdentifierExpr>().First());
        }


        // Get variable name from argument index of an implementation
        private string getArgFromCaller(int index, KeyValuePair<Implementation, Block> ibp, string impl_name)
        {
            foreach (CallCmd cc in ibp.Value.Cmds.OfType<CallCmd>().Where(ccmd => ccmd.callee.Equals(impl_name)))
            {
                return cc.Ins[index].ToString();
            }
            return null;
        }

        // Check from all callers if a variable is coming from an argument 
        private bool checkAllParents(bool dbg, string var_name, Dictionary<string, HashSet<KeyValuePair<Implementation, Block>>> callers, Implementation impl, Block b, Dictionary<KeyValuePair<Implementation, string>, Variable> varsfromargs, Dictionary<Implementation, HashSet<Implementation>> impl2set, bool first)
        {
            if (dbg) Console.WriteLine("Analyzing variable " + var_name + " in " + impl.Name + " " + b.Label);

            // If variable is contained in live_var_dictionary, return true
            if (live_var_dictionary[new KeyValuePair<Implementation, Block>(impl, b)].Contains(var_name) && !first)
            {
                if (dbg) Console.WriteLine(var_name + " is live");
                return true;
            }

            // Irreducible procedure, return false
            if (!callers.ContainsKey(impl.Name))
            {
                if (dbg) Console.WriteLine("impl -> " + impl.Name + " not found in callers");
                return false;
            }

            // If no callers, return false
            if (callers[impl.Name].Count == 0)
            {
                if (dbg) Console.WriteLine("No parent found for " + impl.Name);
                return false;
            }

            // If variable not coming from argument, return false
            if (!varsfromargs.ContainsKey(new KeyValuePair<Implementation, string>(impl, var_name)))
            {
                if (dbg) Console.WriteLine(var_name + " not coming from argument");
                return false;
            }

            bool allparentslive;
            // Go to each caller, and recursively check if variable is live or not
            foreach (var ibp in callers[impl.Name])
            {
                if (dbg) Console.WriteLine("Caller :- " + ibp.Key + " " + ibp.Value);
                if (impl2set[ibp.Key].Equals(impl2set[impl]))
                {
                    if (dbg) Console.WriteLine("Same SCC as callee");
                    return false;
                }
                int index = impl.InParams.IndexOf(varsfromargs[new KeyValuePair<Implementation, string>(impl, var_name)]);
                if (dbg) Console.WriteLine("Argument " + varsfromargs[new KeyValuePair<Implementation, string>(impl, var_name)].Name + " found at " + index);

                if (!live_var_dictionary.ContainsKey(ibp))
                {
                    if (dbg) Console.WriteLine("Caller not found in live_var_dictionary");
                    return false;
                }
                if (!live_var_dictionary[ibp].Contains(getArgFromCaller(index, ibp, impl.Name)))
                {
                    if (dbg) Console.WriteLine("Caller dead variable :- " + getArgFromCaller(index, ibp, impl.Name));
                    allparentslive = checkAllParents(dbg, getArgFromCaller(index, ibp, impl.Name), callers, ibp.Key, ibp.Value, varsfromargs, impl2set, false);
                    if (!allparentslive) return false;
                }
                else
                {
                    if (dbg) Console.WriteLine("Caller live variable :- " + getArgFromCaller(index, ibp, impl.Name));
                }
            }

            // If variable is live, add to live_var_dictionary
            live_var_dictionary[new KeyValuePair<Implementation, Block>(impl, b)].Add(var_name);
            if (dbg) Console.WriteLine("Making " + var_name + " live in " + impl.Name + " " + b.Label);
            return true;
        }

        /*
         * Arguments - None
         * Return Value - None
         * Implementation :- Prunes aliasing queries based on two specific optimizations
         * 1. Removing duplicate aliasing queries on every execution path
         * 2. Removing asserts based on assume commands
         */
        private void Clean()
        {
            live_var_dictionary = new Dictionary<KeyValuePair<Implementation, Block>, HashSet<string>>();
            bool dbg = false;
            int asserts_removed_count = 0;  // Counting the number of asserts removed
            string notfalse = null;
            bool exists, var_exists, valid_assume_cmd, valid_assert_cmd;
            int count_predecessors, var_frequency;

            /*
             * Go to each implementation
             * Sort the blocks in topological order. (needed for computing live variables in predecessors)
             */
            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (dbg) Console.WriteLine("Implementation :- " + impl.ToString());
                IEnumerable<Block> sortedBlocks;
                Dictionary<string, HashSet<string>> assume_flow = new Dictionary<string, HashSet<string>>();
                // Dictionary from Block_Name -> Live variables in block (variables for which !NULL is implied)

                // Computing predecessors, constructing CFG and topological sorting of blocks
                impl.ComputePredecessorsForBlocks();
                Graph<Block> dag = Microsoft.Boogie.Program.GraphFromImpl(impl);
                sortedBlocks = dag.TopologicalSort();

                /*
                 * Go to each block
                 * Compute live variables present in all predecessors
                 */
                foreach (Block b in sortedBlocks)
                {
                    HashSet<string> current_live_vars = new HashSet<string>();  // Live variables in current block
                    if (dbg) Console.WriteLine("Block :- " + b.ToString());

                    List<AssertCmd> removal_list_ac = new List<AssertCmd>();    // List of assert commands to be removed from block
                    HashSet<string> live_vars;  // Live variables in predecessor block
                    Dictionary<string, int> intersection_vars = new Dictionary<string, int>();  // Live variables in all predecessor blocks

                    count_predecessors = 0;

                    /*
                     * Go to each predecessor of a block, and compute the live variables in the block using assume_flow dictionary
                     */
                    foreach (Block blk in b.Predecessors)
                    {
                        if (dbg) Console.WriteLine("Analyzing predecessor block :- " + blk.ToString());

                        count_predecessors++;
                        exists = assume_flow.TryGetValue(blk.ToString(), out live_vars);    // Get the live variables of predecessor block in live_vars
                        Debug.Assert(exists);   // Computation of predecessor should be done because of topological sorting

                        /*
                         * Go to each live variable in the predecessor
                         * If variable exists in intersection_vars, increment its count
                         * Else, add variable to intersection_vars with count 1
                         */
                        foreach (string var_name in live_vars)
                        {
                            if (dbg) Console.WriteLine("\tLive variable :- " + var_name);
                            var_exists = intersection_vars.TryGetValue(var_name, out var_frequency);    // Taking count in var_frequency
                            if (var_exists)
                            {
                                var_frequency++;                                    // Increment frequency
                                intersection_vars.Remove(var_name);                 // Remove from variable from intersection_vars
                                intersection_vars.Add(var_name, var_frequency);     // Add with incremented frequency
                            }
                            else intersection_vars.Add(var_name, 1);                // Add with frequency 1
                        }
                    }

                    /*
                     * Go to each variable in intersection_vars
                     * The variables present in each predecessor should have count = count_predecessors
                     * Add these variables to current_live_vars
                     */
                    foreach (KeyValuePair<string, int> pair in intersection_vars)
                    {
                        if (pair.Value == count_predecessors)
                        {
                            if (dbg) Console.WriteLine("Adding variable to current live variable :- " + pair.Key);
                            current_live_vars.Add(pair.Key);
                        }
                    }

                    /*
                     * Go to each command in block
                     * If command is assert, check if variable is in current_live_vars
                     * If yes, remove the assert
                     * Else, add the variable to current_live_vars
                     * If command is assume, add variable to current_live_vars
                     */
                    foreach (Cmd c in b.Cmds)
                    {
                        if (c is AssertCmd)
                        {
                            var ac = c as AssertCmd;

                            // Check asserts which are not true
                            if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == notfalse)
                                continue;
                            else
                            {
                                Expr id = null;
                                string var_name = null;

                                // Extracting variable name from assert command
                                if (validAssert(ac)) valid_assert_cmd = true;
                                else valid_assert_cmd = false;
                                if (valid_assert_cmd)
                                {
                                    id = getVarFromAssert(ac);
                                    var_name = id.ToString();

                                    if (dbg) Console.WriteLine("Analyzing Var_AssertCmd :- " + var_name);

                                    // Check if variable is already contained in current_live_vars
                                    if (current_live_vars.Contains(var_name))
                                    {
                                        removal_list_ac.Add(ac);
                                        if (dbg) Console.WriteLine("Removing " + ac.ToString());
                                    }
                                    else current_live_vars.Add(var_name);   // Add variable to current_live_vars
                                }

                            }
                        }
                        else if (c is AssumeCmd)
                        {
                            var asc = c as AssumeCmd;
                            Expr id = null;
                            string var_name = null;

                            // Extracting variable name from assume command
                            if (validAssume(asc)) valid_assume_cmd = true;
                            else valid_assume_cmd = false;
                            if (valid_assume_cmd && dbg) Console.WriteLine("Hey, found it!");
                            if (valid_assume_cmd)
                            {
                                id = getVarFromAssume(asc);
                                var_name = id.ToString();
                                if (dbg) Console.WriteLine("Adding Var_AssumeCmd :- " + var_name);
                                if (dbg) Console.WriteLine(asc.ToString());
                                current_live_vars.Add(var_name);        // Add variable to current_live_vars
                            }
                        }
                        else if (c is CallCmd)
                        {
                            var cc = c as CallCmd;
                            if (cc.callee.Equals("__HAVOC_malloc") || cc.callee.Equals("__HAVOC_malloc_full"))
                            {
                                foreach (var nonnull_vars in cc.Outs) current_live_vars.Add(nonnull_vars.ToString());
                            }
                        }
                    }

                    // Remove the assert commands contained in removal_list_ac
                    foreach (AssertCmd ac in removal_list_ac)
                    {
                        b.Cmds.Remove(ac);
                        asserts_removed_count++;
                    }
                    assume_flow.Add(b.ToString(), current_live_vars);
                    live_var_dictionary.Add(new KeyValuePair<Implementation, Block>(impl, b), current_live_vars);
                }
            }
            if (dbg) Console.WriteLine("#Asserts Removed by Optimizations :- " + asserts_removed_count);

            //BoogieUtil.PrintProgram(program, "test.bpl");

            CleanGlobal();

        }

        /*
         * Arguments - None
         * Return Value - None
         * Implementation :- Prunes assert statements based on the following optimization
         * 1. Check if assert is on a variable coming from the argument
         * 2. If yes, go to each caller and check if the argument being passed is null or not
         * 3. If the argument is not null at all callers, remove the assert statement
        */
        private void CleanGlobal()
        {
            bool dbg = false;
            var callers = new Dictionary<string, HashSet<KeyValuePair<Implementation, Block>>>();   // Gives the <implementation, block> pair where a function is called


            // Construct the call graph and compute strongly connected components
            var name2Impl = new Dictionary<string, Implementation>();
            name2Impl = BoogieUtil.nameImplMapping(program);
            var Succ = new Dictionary<Implementation, HashSet<Implementation>>();
            var Pred = new Dictionary<Implementation, HashSet<Implementation>>();
            name2Impl.Values.Iter(impl => Succ.Add(impl, new HashSet<Implementation>()));
            name2Impl.Values.Iter(impl => Pred.Add(impl, new HashSet<Implementation>()));

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    foreach (var cmd in blk.Cmds.OfType<CallCmd>())
                    {
                        if (!name2Impl.ContainsKey(cmd.callee)) continue;
                        Succ[impl].Add(name2Impl[cmd.callee]);
                        Pred[name2Impl[cmd.callee]].Add(impl);
                        if (callers.ContainsKey(cmd.callee)) callers[cmd.callee].Add(new KeyValuePair<Implementation, Block>(impl, blk));
                        else
                        {
                            callers.Add(cmd.callee, new HashSet<KeyValuePair<Implementation, Block>>());
                            callers[cmd.callee].Add(new KeyValuePair<Implementation, Block>(impl, blk));
                        }
                    }
                }
            }

            // Build SCC
            var sccs = new StronglyConnectedComponents<Implementation>(name2Impl.Values,
                new Adjacency<Implementation>(n => Succ[n]),
                new Adjacency<Implementation>(n => Pred[n]));
            sccs.Compute();

            Graph<HashSet<Implementation>> impl_dag = new Graph<HashSet<Implementation>>();     // Construct a new graph where each SCC is reduced to a point, and each node is a set of implementations, which belong to the same SCC
            Dictionary<Implementation, HashSet<Implementation>> impl2set = new Dictionary<Implementation, HashSet<Implementation>>();   // implementation -> SCC containing implementation
            foreach (var scc in sccs)
            {
                var impl_set = new HashSet<Implementation>();
                foreach (var impl in scc)
                {
                    impl_set.Add(impl);
                    impl2set.Add(impl, impl_set);
                }
                impl_dag.AddSource(impl_set);
            }

            foreach (Implementation impl in Succ.Keys)
            {
                foreach (Implementation succ_impl in Succ[impl])
                {
                    if (!impl2set[impl].Equals(impl2set[succ_impl]) && !impl_dag.Edge(impl2set[impl], impl2set[succ_impl])) impl_dag.AddEdge(impl2set[impl], impl2set[succ_impl]);
                }
            }

            // Run topological sort on the reduced call graph
            IEnumerable<HashSet<Implementation>> sortedImplSet;
            sortedImplSet = impl_dag.TopologicalSort();

            Dictionary<KeyValuePair<Implementation, string>, Variable> varsfromargs = new Dictionary<KeyValuePair<Implementation, string>, Variable>();     // Dictionary variable name -> argument from where the variable is coming, if at all the variable is coming from the argument

            foreach (var implset in sortedImplSet)
            {
                if (dbg) Console.WriteLine("ImplSet :- ");
                foreach (Implementation impl in implset)
                {
                    // Add all arguments to varsfromargs
                    foreach (var par in impl.InParams) varsfromargs.Add(new KeyValuePair<Implementation, string>(impl, par.ToString()), par);
                    if (dbg) Console.WriteLine("impl -> " + impl.ToString());
                    if (dbg)
                    {
                        Console.Write("Parameters :- ");
                        foreach (var par in impl.InParams) Console.Write(par.ToString() + " ");
                        Console.WriteLine();
                    }
                    IEnumerable<Block> sortedBlocks;

                    // Computing predecessors, constructing CFG and topological sorting of blocks
                    impl.ComputePredecessorsForBlocks();
                    Graph<Block> dag = Microsoft.Boogie.Program.GraphFromImpl(impl);
                    sortedBlocks = dag.TopologicalSort();


                    // Go to each block and compute variables coming from the arguments, and if an assert cmd is encountered, check at all callers to remove the assertion
                    foreach (Block b in sortedBlocks)
                    {
                        if (dbg) Console.WriteLine("Block :- " + b.ToString());
                        List<AssertCmd> removal_list_ac = new List<AssertCmd>();
                        foreach (Cmd c in b.Cmds)
                        {
                            if (c is AssignCmd)
                            {
                                var asc = c as AssignCmd;
                                if (dbg) Console.Write("AssignCmd :- " + asc.ToString());
                                for (int i = 0; i < asc.Lhss.Count; i++)
                                {
                                    if (asc.Rhss[i] is IdentifierExpr && asc.Lhss[i].AsExpr is IdentifierExpr)
                                    {
                                        string var_name = null;
                                        var_name = asc.Rhss[i].ToString();
                                        if (varsfromargs.ContainsKey(new KeyValuePair<Implementation, string>(impl, var_name)))
                                        {
                                            if (dbg) Console.WriteLine(var_name + " present in varsfromargs");
                                            if (varsfromargs.ContainsKey(new KeyValuePair<Implementation, string>(impl, asc.Lhss[i].AsExpr.ToString())))
                                            {
                                                if (dbg) Console.WriteLine(asc.Lhss[i].AsExpr.ToString() + " present in varsfromargs");
                                                if (varsfromargs[new KeyValuePair<Implementation, string>(impl, asc.Lhss[i].AsExpr.ToString())].Equals(varsfromargs[new KeyValuePair<Implementation, string>(impl, var_name)])) continue;
                                                else
                                                {
                                                    if (dbg) Console.WriteLine(asc.Lhss[i].AsExpr.ToString() + " removed from varsfromargs");
                                                    varsfromargs.Remove(new KeyValuePair<Implementation, string>(impl, asc.Lhss[i].AsExpr.ToString()));
                                                    continue;
                                                }
                                            }

                                            varsfromargs.Add(new KeyValuePair<Implementation, string>(impl, asc.Lhss[i].AsExpr.ToString()), varsfromargs[new KeyValuePair<Implementation, string>(impl, var_name)]);
                                            if (dbg)
                                            {
                                                Console.WriteLine("Variable " + asc.Lhss[i].AsExpr.ToString() + " -> " + varsfromargs[new KeyValuePair<Implementation, string>(impl, asc.Lhss[i].AsExpr.ToString())].Name);
                                                Console.WriteLine();
                                            }
                                        }
                                    }
                                }
                            }
                            else if (c is AssertCmd)
                            {
                                string var_name = null;
                                AssertCmd ac = c as AssertCmd;
                                if (validAssert(ac))
                                {
                                    if (dbg) Console.WriteLine("Analyzing AssertCmd :- " + ac.ToString());
                                    var_name = getVarFromAssert(ac).ToString();
                                    bool allparentslive = checkAllParents(dbg, var_name, callers, impl, b, varsfromargs, impl2set, true);
                                    if (allparentslive) removal_list_ac.Add(ac);
                                }
                            }
                        }
                        foreach (AssertCmd ac in removal_list_ac)
                        {
                            if (dbg) Console.WriteLine("Removing AssertCmd :- " + ac.ToString());
                            b.Cmds.Remove(ac);
                        }
                    }
                }
            }
        }

        // Optimization -> Add assert for return variables, and let alias analysis figure out if assert can be removed. FAIL.
        private void CleanReturnAsserts()
        {
            bool dbg = true;
            non_null_funcs = new Dictionary<Implementation, HashSet<int>>();
            int freq;

            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (dbg) Console.WriteLine("impl -> " + impl.Name);
                HashSet<int> non_null_vars = new HashSet<int>();
                Dictionary<Variable, int> return_vars = new Dictionary<Variable, int>();
                int final_block_count = 0;
                foreach (Block b in impl.Blocks)
                {
                    if (b.TransferCmd is ReturnCmd)
                    {
                        final_block_count++;
                        foreach (Variable v in impl.OutParams)
                        {
                            if (live_var_dictionary[new KeyValuePair<Implementation, Block>(impl, b)].Contains(v.Name))
                            {
                                bool exists = return_vars.TryGetValue(v, out freq);
                                if (exists)
                                {
                                    freq++;
                                    return_vars.Remove(v);
                                    return_vars.Add(v, freq);
                                }
                                else return_vars.Add(v, 1);
                            }
                        }
                    }
                }
                foreach (Variable v in return_vars.Keys)
                {
                    if (return_vars[v] == final_block_count)
                    {
                        if (dbg) Console.WriteLine(v.Name);
                        non_null_vars.Add(impl.OutParams.IndexOf(v));
                    }
                }
                non_null_funcs.Add(impl, non_null_vars);
            }

            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (Block b in impl.Blocks)
                {
                    foreach (Cmd c in b.Cmds)
                    {
                        if (c is CallCmd)
                        {
                            CallCmd cc = c as CallCmd;
                            Console.WriteLine(cc.ToString());
                        }
                    }
                }
            }
        }

    }
}
