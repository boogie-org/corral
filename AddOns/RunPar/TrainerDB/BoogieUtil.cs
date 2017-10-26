using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;

namespace Trainer
{
    public class BoogieUtil
    {
        public static void PrintProgram(Program p, string filename)
        {
            var outFile = new TokenTextWriter(filename);
            p.Emit(outFile);
            outFile.Close();
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
    }


    public class GatherLiterals : StandardVisitor
    {
        public List<Tuple<Variable, Expr>> literals;
        bool inOld;

        public GatherLiterals()
        {
            literals = new List<Tuple<Variable, Expr>>();
            inOld = false;
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            var prev = inOld;
            inOld = true;
            var ret = base.VisitOldExpr(node);
            inOld = prev;
            return ret;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (inOld)
                literals.Add(Tuple.Create(node.Decl, new OldExpr(Token.NoToken, node) as Expr));
            else
                literals.Add(Tuple.Create(node.Decl, node as Expr));

            return node;
        }
    }

    public class HasNonOldExpr : StandardVisitor
    {
        bool flag;
        bool inold;

        HasNonOldExpr()
        {
            flag = false;
            inold = false;
        }

        public static bool Process(Expr expr)
        {
            var v = new HasNonOldExpr();
            v.VisitExpr(expr);
            return v.flag;
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            var t = inold;
            inold = true;
            var ret = base.VisitOldExpr(node);
            inold = t;
            return ret;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (!inold)
                flag = true;
            return base.VisitIdentifierExpr(node);
        }
    }

    public class VarsInExpr : StandardVisitor
    {
        public HashSet<string> Vars { get; private set; }

        // To keep track of whether we're in an "old" Expr
        private int inOld;

        public VarsInExpr()
        {
            Vars = new HashSet<string>();
            inOld = 0;
        }

        public void reset()
        {
            Vars = new HashSet<string>();
            inOld = 0;
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            if (inOld > 0)
            {
                //Log.WriteLine(Log.Warning, "Recursive \"old\" expression");
            }

            inOld++;
            Expr ret = base.VisitOldExpr(node);
            inOld--;

            return ret;
        }
        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            Vars.Add(node.Name);

            return base.VisitIdentifierExpr(node);
        }


        public override Variable VisitVariable(Variable node)
        {
            Vars.Add(node.Name);


            return base.VisitVariable(node);

        }
    }

    // Assume that the input formula to visit is in CNF.
    public class LiteralVisitor : StandardVisitor
    {
        public HashSet<string> literalsStr { get; private set; }
        public HashSet<Expr> literals { get; private set; }

        public LiteralVisitor()
        {
            literalsStr = new HashSet<string>();
            literals = new HashSet<Expr>();
        }

        private bool isLiteral(Expr e)
        {
            var expr = e as NAryExpr;
            if (expr == null)
            {
                return true;
            }
            if (expr.Fun is BinaryOperator)
            {
                var bop = (BinaryOperator)expr.Fun;
                if (bop.Op == BinaryOperator.Opcode.And ||
                    bop.Op == BinaryOperator.Opcode.Or ||
                    bop.Op == BinaryOperator.Opcode.Iff ||
                    bop.Op == BinaryOperator.Opcode.Imp)
                    return false;
            }
            else if (expr.Fun is UnaryOperator)
            {
                var e2 = expr.Args[0] as NAryExpr;
                if (expr == null)
                    return true;

                if (e2.Fun is UnaryOperator)
                    return false;
                else if (e2.Fun is BinaryOperator)
                {
                    var bop = (BinaryOperator)e2.Fun;
                    if (bop.Op == BinaryOperator.Opcode.And ||
                        bop.Op == BinaryOperator.Opcode.Or ||
                        bop.Op == BinaryOperator.Opcode.Iff ||
                        bop.Op == BinaryOperator.Opcode.Imp)
                        return false;
                    else
                        return true;
                }
            }
            return true;
        }

        // Pre condition: e is a literal.
        private void add(Expr e)
        {
            var atom = e;

            // If e is a literal of the form !l, then strip !.
            if (e is NAryExpr)
            {
                var ee = (NAryExpr)e;

                if (ee.Fun is UnaryOperator)
                {
                    if (((UnaryOperator)ee.Fun).Op == UnaryOperator.Opcode.Not)
                        atom = ee.Args.ElementAt(0);
                }
            }

            if (!literalsStr.Contains(atom.ToString()) && !atom.ToString().Contains("dup_assertVar"))
            {
                literalsStr.Add(atom.ToString());
                literals.Add(atom);
            }
        }
        public override Ensures VisitEnsures(Ensures ensures)
        {
            if (isLiteral(ensures.Condition))
            {
                add(ensures.Condition);
                return ensures;
            }

            ensures.Condition = VisitExpr(ensures.Condition);
            return base.VisitEnsures(ensures);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is UnaryOperator)
            {
                var op = (UnaryOperator)node.Fun;
                if (op.Op == UnaryOperator.Opcode.Not)
                {
                    if (isLiteral(node.Args[0]))
                        add(node.Args[0]);
                }
                else if (op.Op == UnaryOperator.Opcode.Neg)
                {
                    throw new Exception(string.Format("We should not see any Neg expression during the atom collection: {0}", node.ToString()));
                }
            }
            else if (node.Fun is BinaryOperator)
            {
                var op = (BinaryOperator)node.Fun;
                switch (op.Op)
                {
                    case BinaryOperator.Opcode.And:
                    case BinaryOperator.Opcode.Or:
                    case BinaryOperator.Opcode.Imp:
                    case BinaryOperator.Opcode.Iff:
                        var left = node.Args[0];
                        var right = node.Args[1];
                        if (isLiteral(left))
                            add(left);
                        if (isLiteral(right))
                            add(right);
                        break;
                    default:
                        break;
                }
            }
            else if (node.Fun is MapSelect || node.Fun is MapStore)
            {
                return base.VisitNAryExpr(node);
            }
            else
            {
                throw new Exception(string.Format("This expression is not supported yet during the atom collection: {0}", node.ToString()));
            }
            return base.VisitNAryExpr(node);
        }
    }


    public class VarsUsed : StandardVisitor
    {
        // The set of all local variables used in the expression
        public HashSet<string> localsUsed { get; private set; }

        // The set of all global variables used in the expression
        public HashSet<string> globalsUsed { get; private set; }

        // The set of variables used in the expression
        public HashSet<string> varsUsed { get; private set; }
        public HashSet<Variable> Vars { get; private set; }

        // The set of functions used in the expression
        public HashSet<string> functionsUsed { get; private set; }

        // The set of variables whose "old" versions are used in the expression
        // This can only be for global variables. old(local) doesn't mean anything
        // in Boogie
        public HashSet<string> oldVarsUsed { get; private set; }

        // To keep track of whether we're in an "old" Expr
        private int inOld;

        public VarsUsed()
        {
            localsUsed = new HashSet<string>();
            globalsUsed = new HashSet<string>();
            varsUsed = new HashSet<string>();
            oldVarsUsed = new HashSet<string>();
            Vars = new HashSet<Variable>();
            functionsUsed = new HashSet<string>();
            inOld = 0;
        }

        public void reset()
        {
            localsUsed = new HashSet<string>();
            globalsUsed = new HashSet<string>();
            varsUsed = new HashSet<string>();
            oldVarsUsed = new HashSet<string>();
            Vars = new HashSet<Variable>();
            functionsUsed = new HashSet<string>();
            inOld = 0;
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            if (inOld > 0)
            {
                //Log.WriteLine(Log.Warning, "Recursive \"old\" expression");
            }

            inOld++;
            Expr ret = base.VisitOldExpr(node);
            inOld--;

            return ret;
        }
        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Name != node.Decl.Name || node.Name != node.Decl.TypedIdent.Name)
                throw new Exception("Inconsistent variable/ident naming on " + node.Name + " " + node.Decl.Name + " " + node.Decl.TypedIdent.Name);

            if (node.Decl != null)
            {
                varsUsed.Add(node.Decl.Name);
                Vars.Add(node.Decl);

                if (node.Decl is GlobalVariable)
                {
                    foundGlobal(node.Decl.Name);
                    return node;
                }
                else if (node.Decl is LocalVariable)
                {
                    foundLocal(node.Decl.Name);
                    return node;
                }
            }

            return base.VisitIdentifierExpr(node);
        }


        public override Variable VisitVariable(Variable node)
        {
            varsUsed.Add(node.Name);
            Vars.Add(node);

            if (node is GlobalVariable)
            {
                foundGlobal(node.Name);
                return node;
            }
            else if (node is LocalVariable)
            {
                foundLocal(node.Name);
                return node;
            }

            return base.VisitVariable(node);

        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                functionsUsed.Add((node.Fun as FunctionCall).FunctionName);
            }

            return base.VisitNAryExpr(node);
        }

        private void foundGlobal(string name)
        {
            globalsUsed.Add(name);
            if (inOld > 0)
            {
                oldVarsUsed.Add(name);
            }
        }

        private void foundLocal(string name)
        {
            localsUsed.Add(name);
            if (inOld > 0)
            {
                //Log.WriteLine(Log.Warning, "old(local var) expression used");
            }
        }
    }


    public class VarsFieldsUsed : VarsUsed
    {
        public HashSet<string> funcsUsed;

        public VarsFieldsUsed()
            : base()
        {
            funcsUsed = new HashSet<string>();
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            base.VisitNAryExpr(node);
            var fun = node.Fun as FunctionCall;
            if (fun != null && fun.ArgumentCount == 1)
            {
                funcsUsed.Add(fun.FunctionName);
            }

            return node;
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

    // Gather variables that don't appear inside old
    public class GatherNonOldVariables : StandardVisitor
    {
        public HashSet<string> variables;

        public GatherNonOldVariables()
        {
            variables = new HashSet<string>();
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            return node;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            variables.Add(node.Name);
            return node;
        }

        public override Variable VisitVariable(Variable node)
        {
            variables.Add(node.Name);
            return node;
        }

    }

    public class DummyErrorReporter : ProverInterface.ErrorHandler
    {
        public Model model;

        public DummyErrorReporter()
        {
            model = null;
        }

        public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome)
        {
            if (CommandLineOptions.Clo.PrintErrorModel >= 1 && model != null) model.Write(Console.Out);
            this.model = model;
        }
    }


    public class HashSetExtras<T>
    {
        public static HashSet<T> Difference(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.ExceptWith(b);
            return ret;
        }

        public static HashSet<T> Difference(HashSet<T> a, HashSet<T> b, HashSet<T> c)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.ExceptWith(b);
            ret.ExceptWith(c);
            return ret;
        }

        public static HashSet<T> Union(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.UnionWith(b);
            return ret;
        }

        public static HashSet<T> Intersection(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.IntersectWith(b);
            return ret;
        }

        public static HashSet<T> Singleton(T v)
        {
            var ret = new HashSet<T>();
            ret.Add(v);
            return ret;
        }
    }

    public static class HashSetMethods
    {
        public static HashSet<T> Difference<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Difference(a, b);
        }

        public static HashSet<T> Union<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Union(a, b);
        }

        public static HashSet<T> Intersection<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Intersection(a, b);
        }
    }
}
