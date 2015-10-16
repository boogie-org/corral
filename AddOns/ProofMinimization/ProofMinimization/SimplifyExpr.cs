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
        public static HashSet<Variable> templateVars = new HashSet<Variable>();

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

        public static Expr Simplify(Expr e)
        {
            var vs = new SimplifyExpr();
            var e1 = vs.VisitExpr(e);
            var e2 = NormalizeExpr(e1);
            return e2;
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
        public static string ExprToTemplate(Expr expr)
        {
            return ExprToTemplateExpr(expr).ToString();
        }

        public static Expr ExprToTemplateExpr(Expr expr)
        {
             var GetFin = new Func<btype, Variable>(ty =>
                BoogieAstFactory.MkFormal("v_fin_" + ty.ToString(), ty, true));
            var GetFout = new Func<btype, Variable>(ty =>
                BoogieAstFactory.MkFormal("v_fout_" + ty.ToString(), ty, false));

            var ret =
                Substituter.Apply(new Substitution(v =>
                {
                    if (v is Formal && (v as Formal).InComing)
                    {
                        var nVar = GetFin(v.TypedIdent.Type);
                        templateVars.Add(nVar);
                        return Expr.Ident(nVar);
                    }
                    if (v is Formal && !(v as Formal).InComing)
                    {
                        var nVar = GetFout(v.TypedIdent.Type);
                        templateVars.Add(nVar);
                        return Expr.Ident(nVar);
                    }
                    return Expr.Ident(v);
                }), expr);

            return ret;
        }



        public static Expr NormalizeExpr(Expr expr)
        {
            var nexpr = normalizeExpr(expr);
            nexpr = ConvertToCNF(nexpr);
            //Console.WriteLine("Normalization from {0} to {1}", expr.ToString(), nexpr.ToString());
            //Debug.Assert(IsCleanFolCNF(nexpr));
            return nexpr;
        }

        static Expr normalizeExpr(Expr expr)
        {
            var disj = GetExprDisjuncts(expr);
            if (disj.Count != 1)
            {
                disj = disj.Map(e => normalizeExpr(e));
                disj.Sort(new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString()))));
                var ret = disj[0];
                for (int i = 1; i < disj.Count; i++)
                    ret = Expr.Or(ret, disj[i]);
                return ret;
            }

            var conj = GetExprConjunctions(expr);
            if (conj.Count != 1)
            {
                conj = conj.Map(e => normalizeExpr(e));
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

                normalizeOperator((naryexpr.Fun as BinaryOperator), naryexpr.Args[0], naryexpr.Args[1], out nexpr, out applyNeg);

                if (applyNeg) return Expr.Not(nexpr);
                return nexpr;
            }

            
            return expr;
        }

        static void normalizeOperator(BinaryOperator op, Expr arg1, Expr arg2, out NAryExpr expr, out bool applyNeg)
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


        // Checks whether a given expression is in a CNF form. Also, the formula should not have conjucts
        // that are conjucts for themselves, which can happen due to weird use of parenthesis. The same goes
        // for disjuncts. Assumes the implication and equivalences are resolved, as well as that negations 
        // are pushed inwards.
        public static bool IsCleanCNF(Expr expr)
        {
            // This basically checks if the given expression is a CNF formula.
            // Not needed as we expect this will happen.
            var conjucts = GetExprConjunctions(expr);
            if (conjucts.Count == 0)
            {
                //Console.WriteLine("Not a CNF formula at all.");
                return false;
            }

            // Now check that each conjcut is a clause.
            foreach (var conjuct in conjucts)
            {
                // First check that each conjunct is not a conjunct by itself, i.e., that each
                // form
                var cconjucts = GetExprConjunctions(conjuct);
                if (cconjucts.Count > 1)
                {
                    //Console.WriteLine("Not a CNF formula since conjuct {0} has conjucts.", conjuct.ToString());
                    return false;
                }

                // Now check that each 
                var disjuncts = GetExprDisjuncts(conjuct);
                foreach (var disjunct in disjuncts)
                {
                    // Now check that each disjunct is not a disjunction itself. 
                    var ddisjuncts = GetExprDisjuncts(disjunct);
                    if (ddisjuncts.Count > 1)
                    {
                        //Console.WriteLine("Not a CNF formula since disjunct {0} has disjuncts.", disjunct.ToString());
                        return false;
                    }

                    // Now check that each disjunct is not a conjuction.
                    var dconjucts = GetExprConjunctions(disjunct);
                    if (dconjucts.Count > 1)
                    {
                        //Console.WriteLine("Not a CNF formula since disjunct {0} has conjucts.", disjunct.ToString());
                        return false;
                    }
                }
            }

            //Console.WriteLine("{0} is a CNF FOL formula", expr.ToString());
            return true;
        }


        // Convert a FOL formula that was passed through normalize(Expr expr) to a CNF formula.
        public static Expr ConvertToCNF(Expr expr)
        {
            // Case where we have conjunction (P^Q). Inductively, we have that
            // P is a conjunction itself as well as Q. So just conjunct them together.
            if (expr is NAryExpr && (expr as NAryExpr).Fun is BinaryOperator &&
                ((expr as NAryExpr).Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
            {
                var f = GetExprConjunctions(ConvertToCNF((expr as NAryExpr).Args[0]));
                var s = GetExprConjunctions(ConvertToCNF((expr as NAryExpr).Args[1]));

                List<Expr> conjucts = new List<Expr>();
                conjucts.AddRange(f); conjucts.AddRange(s);
                return Reduce(conjucts, BinaryOperator.Opcode.And);
            }

            // Case where we have disjunction (PvQ). Inductively, we have that
            // P is a conjunction itself as well as Q, when passsed to convertToCNF. 
            // So make a distributive cross product where we have conjuctions of disjunctions. 
            if (expr is NAryExpr && (expr as NAryExpr).Fun is BinaryOperator &&
               ((expr as NAryExpr).Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or)
            {
                var f = GetExprConjunctions(ConvertToCNF((expr as NAryExpr).Args[0]));
                var s = GetExprConjunctions(ConvertToCNF((expr as NAryExpr).Args[1]));

                if (f.Count == 1 && s.Count == 1)
                    return expr;

                List<Expr> disjuncts = new List<Expr>();
                for (int i = 0; i < f.Count; i++)
                {
                    for (int j = 0; j < s.Count; j++)
                    {
                        var disjunct = new NAryExpr(Token.NoToken, new BinaryOperator(Token.NoToken, BinaryOperator.Opcode.Or), new List<Expr> {f[i], s[j]});
                        disjuncts.Add(disjunct);
                    }
                }
                return Reduce(disjuncts, BinaryOperator.Opcode.And);
            }

            // We've encountered a literal because all negations are pushed inwards by normalize
            // and implication and equivalences are resolved.
            return expr;
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


        public static Expr Reduce(List<Expr> exprs, BinaryOperator.Opcode op)
        {
            if (exprs.Count == 0)
            {
                return null;
            }
            else if (exprs.Count == 1)
            {
                return exprs[0];
            }

            Expr expr = new NAryExpr(Token.NoToken, new BinaryOperator(Token.NoToken, op), new List<Expr> {exprs[exprs.Count - 2], exprs[exprs.Count - 1]});
            for (int i = 3; (exprs.Count - i) >= 0; i++)
            {
                var c = exprs[exprs.Count - i];
                expr = new NAryExpr(Token.NoToken, new BinaryOperator(Token.NoToken, op), new List<Expr> {c, expr});
            }
            return expr;
        }

    }
}