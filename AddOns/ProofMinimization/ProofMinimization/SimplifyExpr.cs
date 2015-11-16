using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using PersistentProgram = ProgTransformation.PersistentProgram;
using System.Text.RegularExpressions;
using btype = Microsoft.Boogie.Type;

namespace ProofMinimization
{
    // remove implications, push negation inside
    public class SimplifyExpr : StandardVisitor
    {
        private SimplifyExpr() { }

        public static void SimplifyEnsures(Ensures ens, Dictionary<string, Constant> CandidateConstants)
        {
            if (ens.Free) return;

            string constantName = null;
            Expr expr = null;

            var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                ens.Condition, CandidateConstants.Keys, out constantName, out expr);

            if (!match) return;

            ens.Condition = Expr.Imp(Expr.Ident(CandidateConstants[constantName]), Simplify(expr));
        }

        static int SimplifyCnt = 0;

        public static List<Ensures> SimplifyEnsures(List<Ensures> ens, Dictionary<string, Constant> CandidateConstants)
        {
            var ret = new List<Ensures>();
            var newConstants = new List<Constant>();

            var GetExistentialConstant = new Func<Constant>(() =>
            {
                var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                    "CnfConst" + (SimplifyCnt++), Microsoft.Boogie.Type.Bool), false);
                c.AddAttribute("existential");
                newConstants.Add(c);
                return c;
            });

            foreach (var en in ens)
            {
                if (en.Free)
                {
                    ret.Add(en);
                    continue;
                }

                string constantName = null;
                Expr expr = null;

                var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                    en.Condition, CandidateConstants.Keys, out constantName, out expr);

                if (!match)
                {
                    ret.Add(en);
                    continue;
                }

                var conjs = GetExprConjunctions(Simplify(expr));
                if (conjs.Count == 1)
                {
                    en.Condition = Expr.Imp(Expr.Ident(CandidateConstants[constantName]), conjs.First());
                    ret.Add(en);
                    continue;
                }

                foreach (var conj in conjs)
                {
                    var c = GetExistentialConstant();
                    ret.Add(new Ensures(false, Expr.Imp(Expr.Ident(c), conj)));
                }
            }
            newConstants.Iter(c => CandidateConstants.Add(c.Name, c));
            return ret;
        }

        public static bool SimplifyToCNF = false;

        public static Expr Simplify(Expr e)
        {
            var vs = new SimplifyExpr();
            var e1 = vs.VisitExpr(e);
            var e2 = SimplifyToCNF ? Expr.And(MakeCNF(e1)) : e1;
            var e3 = NormalizeExpr(e2);
            return e3;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            Expr ret = node;

            // Remove implies
            if (node.Fun is BinaryOperator && (node.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Imp)
            {
                ret = Expr.Or(Expr.Not(node.Args[0]), node.Args[1]);
                return base.VisitNAryExpr(ret as NAryExpr);
            }

            // Push negation inside
            if (node.Fun is UnaryOperator && (node.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
            {
                ret = PushNegationInside(node.Args[0]);
                if (ret is NAryExpr) return base.VisitNAryExpr(ret as NAryExpr);
                return base.VisitExpr(ret);
            }

            return base.VisitNAryExpr(node);
        }


        // push negations inside
        static Expr PushNegationInside(Expr expr)
        {
            var nary = expr as NAryExpr;
            if (nary == null)
                return Expr.Not(expr);

            if (nary.Fun is UnaryOperator && (nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                return nary.Args[0];

            if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
                return Expr.Or(PushNegationInside(nary.Args[0]), PushNegationInside(nary.Args[1]));

            if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or)
                return Expr.And(PushNegationInside(nary.Args[0]), PushNegationInside(nary.Args[1]));

            return Expr.Not(expr);
        }

        // replace formal-ins and outs with a unique variable
        public static string ExprToTemplateGeneral(Expr expr)
        {
            var GetFin = new Func<btype, Variable>(ty =>
                BoogieAstFactory.MkFormal("v_fin_" + ty.ToString(), ty, true));
            var GetFout = new Func<btype, Variable>(ty =>
                BoogieAstFactory.MkFormal("v_fout_" + ty.ToString(), ty, true));

            var ret =
                Substituter.Apply(new Substitution(v =>
                {
                    if (v is Formal && (v as Formal).InComing)
                        return Expr.Ident(GetFin(v.TypedIdent.Type));
                    if (v is Formal && !(v as Formal).InComing)
                        return Expr.Ident(GetFout(v.TypedIdent.Type));
                    return Expr.Ident(v);
                }), expr);

            return ret.ToString();
        }

        public static string ExprToTemplateSpecific(Expr expr, bool loop)
        {
            int cnt = 0;
            var inCache = new Dictionary<string, Expr>();
            var outCache = new Dictionary<string, Expr>();
            var inToOut = new Func<string, string>(s => s.StartsWith("in_") ? "out_" + s.Substring("in_".Length) : "");
            var outToIn = new Func<string, string>(s => s.StartsWith("out_") ? "in_" + s.Substring("out_".Length) : "");

            var GetFin = new Func<Variable, Expr>(v =>
                {
                    if (inCache.ContainsKey(v.Name))
                        return inCache[v.Name];
                    if (loop && outCache.ContainsKey(inToOut(v.Name)))
                        return new OldExpr(Token.NoToken, outCache[inToOut(v.Name)]);

                    var prefix = loop ? "v_loop_" : "v_fin_";
                    prefix += v.TypedIdent.Type.ToString();
                    prefix += string.Format("_{0}", cnt++);
                    var outv = BoogieAstFactory.MkFormal(prefix, v.TypedIdent.Type, true);
                    var outexpr = loop ? (Expr)(new OldExpr(Token.NoToken, Expr.Ident(outv))) : Expr.Ident(outv);
                    inCache[v.Name] = outexpr;
                    return outexpr;
                });

            var GetFout = new Func<Variable, Expr>(v =>
            {
                if (outCache.ContainsKey(v.Name))
                    return outCache[v.Name];
                if (loop && inCache.ContainsKey(outToIn(v.Name)) && inCache[outToIn(v.Name)] is OldExpr)
                    return (inCache[outToIn(v.Name)] as OldExpr).Expr;

                var prefix = loop ? "v_loop_" : "v_fout_";
                prefix += v.TypedIdent.Type.ToString();
                prefix += string.Format("_{0}", cnt++);
                var outv = BoogieAstFactory.MkFormal(prefix, v.TypedIdent.Type, false);
                var outexpr = Expr.Ident(outv);
                outCache[v.Name] = outexpr;
                return outexpr;
            });

            var ret =
                Substituter.Apply(new Substitution(v =>
                {
                    if (v is Formal && (v as Formal).InComing)
                        return GetFin(v);
                    if (v is Formal && !(v as Formal).InComing)
                        return GetFout(v);
                    return Expr.Ident(v);
                }), expr);

            return ret.ToString();
        }


        // Returns clauses of the CNF formula
        static List<Expr> MakeCNF(Expr expr)
        {
            var nary = expr as NAryExpr;
            if (nary == null)
                return new List<Expr>{expr};

            if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
            {
                var c1 = MakeCNF(nary.Args[0]);
                var c2 = MakeCNF(nary.Args[1]);
                return new List<Expr>(c1.Concat(c2));
            }

            if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or)
            {
                var c1 = MakeCNF(nary.Args[0]);
                var c2 = MakeCNF(nary.Args[1]);
                var ret = new List<Expr>();
                foreach (var a in c1)
                {
                    foreach (var b in c2)
                    {
                        ret.Add(Expr.Or(a, b));
                    }
                }
                return ret;
            }

            return new List<Expr> { expr };
        }

        static Expr NormalizeExpr(Expr expr)
        {
            var disj = GetExprDisjuncts(expr);
            if (disj.Count != 1)
            {
                disj = disj.Map(e => NormalizeExpr(e));
                disj.Sort(new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString()))));
                var ret = disj[0];
                for (int i = 1; i < disj.Count; i++)
                    ret = Expr.Or(ret, disj[i]);
                return ret;
            }

            var conj = GetExprConjunctions(expr);
            if (conj.Count != 1)
            {
                conj = conj.Map(e => NormalizeExpr(e));
                conj.Sort(new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString()))));

                return Expr.And(conj);
            }

            var naryexpr = expr as NAryExpr;
            if (naryexpr == null)
                return expr;

            if (naryexpr.Fun is BinaryOperator)
            {
                NAryExpr nexpr;
                bool applyNeg;

                NormalizeOperator((naryexpr.Fun as BinaryOperator), naryexpr.Args[0], naryexpr.Args[1], out nexpr, out applyNeg);

                if (applyNeg) return Expr.Not(nexpr);
                return nexpr;
            }

            return expr;
        }

        static void NormalizeOperator(BinaryOperator op, Expr arg1, Expr arg2, out NAryExpr expr, out bool applyNeg)
        {
            expr = null;
            applyNeg = false;

            BinaryOperator.Opcode newop = op.Op;

            if (op.Op == BinaryOperator.Opcode.Lt)
                newop = BinaryOperator.Opcode.Ge;
            else if (op.Op == BinaryOperator.Opcode.Le)
                newop = BinaryOperator.Opcode.Gt;
            else if (op.Op == BinaryOperator.Opcode.Neq)
                newop = BinaryOperator.Opcode.Eq;

            var comp = new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString())));
            var constructExpr = new Func<BinaryOperator, Expr, Expr, NAryExpr>((o, e1, e2) =>
            {
                if (o.Op == BinaryOperator.Opcode.Eq && comp(e1, e2) > 0)
                    return new NAryExpr(Token.NoToken, o, new List<Expr> { e2, e1 });
                return new NAryExpr(Token.NoToken, o, new List<Expr> { e1, e2 });
            });

            if (newop == op.Op)
            {
                expr = constructExpr(op, arg1, arg2);
                applyNeg = false;
            }
            else
            {
                expr = constructExpr(new BinaryOperator(Token.NoToken, newop), arg1, arg2);
                applyNeg = true;
            }
        }

        // returns all possible sub-disjunctions, except empty and all
        public static List<Expr> GetPowSetDisjunctions(List<Expr> disjuncts)
        {
            var n = disjuncts.Count;
            var count = new int[n];
            for (int i = 0; i < n; i++) count[i] = 0;
            count[0] = 1; // exclude empty

            var Next = new Func<bool>(() =>
                {
                    // find the first 0 (while flipping 1s)
                    int i = 0;
                    while (i < n && count[i] == 1)
                    {
                        count[i] = 0;
                        i++;
                    }
                    if (i >= n)
                        return false;
                    count[i] = 1;
                    return true;
                });

            var ret = new List<Expr>();
            do
            {
                Expr curr = Expr.False;
                var all = true;
                for (int i = 0; i < n; i++)
                {
                    if (count[i] == 1)
                    {
                        curr = Expr.Or(curr, disjuncts[i]);
                    }
                    else
                    {
                        all = false;
                    }
                }
                if(!all) ret.Add(curr);
            } while (Next());
            return ret;
        }

        public static List<Expr> GetExprConjunctions(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.And);
        }

        public static List<Expr> GetExprDisjuncts(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.Or);
        }

        // Return the set of conjuncts of the expr
        public static List<Expr> GetSubExprs(Expr expr, BinaryOperator.Opcode op)
        {
            var conjuncts = new List<Expr>();
            if (expr is NAryExpr && (expr as NAryExpr).Fun is BinaryOperator &&
                ((expr as NAryExpr).Fun as BinaryOperator).Op == op)
            {
                var c0 = GetSubExprs((expr as NAryExpr).Args[0], op);
                var c1 = GetSubExprs((expr as NAryExpr).Args[1], op);
                conjuncts.AddRange(c0);
                conjuncts.AddRange(c1);
            }
            else
            {
                conjuncts.Add(expr);
            }

            return conjuncts;
        }

        // Break (a && b) || (c && d) to {a, b, c, d}
        public static List<Expr> BreakDownExpr(Expr expr)
        {
            var ret = new List<Expr>();
            var disj = GetExprDisjuncts(expr);
            disj.Iter(d => ret.AddRange(GetExprConjunctions(d)));
            return ret;
        }

        public static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            // get variables
            var gv = (new GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);
            // resolve
            program.Resolve();

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }
    }

    // Gather variables in an unresolved program
    public class GatherVariables : StandardVisitor
    {
        public HashSet<string> variables;

        public GatherVariables()
        {
            variables = new HashSet<string>();
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            variables.Add(node.Name);
            return node;
        }
    }
}