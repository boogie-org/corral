using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;

namespace cba
{
    // This defines language-specific information.

    public class LanguageSemantics
    {
        // special variables ("alloc")
        public static HashSet<string> specialVars = new HashSet<string>(new string[] { "alloc" });

        public static readonly string tidName = "corral_tid";
        public static readonly string ThreadLocalAttr = "thread_local";

        // Name of the atomic_begin and atomic_end procedures
        public static string atomicBeginProcName()
        {
            return "corral_atomic_begin";
        }

        public static string atomicEndProcName()
        {
            return "corral_atomic_end";
        }

        // The procedure that returns the current thread ID
        public static string getThreadIDName()
        {
            return "corral_getThreadID";
        }

        // The procedure that returns the child thread ID
        public static string getChildThreadIDName()
        {
            return "corral_getChildThreadID";
        }

        // Name of the "is_reachable" procedure
        public static string assertNotReachableName()
        {
            return "corral_assert_not_reachable";
        }

        // Is this global variable potentially shared by threads?
        // (If so, CBA instruments this variable)
        // This is to give special treatment to variables like alloc
        public static bool isShared(string varName)
        {
            if (specialVars.Contains(varName)) return false;
            return true;
        }

        public static void print()
        {
            Console.WriteLine("Begin atomic block: \"call {0}();\"", atomicBeginProcName());
            Console.WriteLine("End atomic block  : \"call {0}();\"", atomicEndProcName());
            Console.WriteLine("Get thread id     : \"call n := {0}();\"", getThreadIDName());
            Console.WriteLine("Target            : \"call {0}();\"", assertNotReachableName());
        }

    }

    public class TidArithmetic
    {
        public static bool useIntArithmetic;

        public Microsoft.Boogie.Type getType()
        {
            if (useIntArithmetic)
            {
                return Microsoft.Boogie.Type.Int;
            }
            else
            {
                return Microsoft.Boogie.Type.GetBvType(32);
            }
        }

        private static Function BvAdd = null;
        private static Function BvGt = null;

        public static Function getBvAdd()
        {
            if (BvAdd != null) return BvAdd;
            var args = new List<Variable>();

            args.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.GetBvType(32)), true));
            args.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "y", Microsoft.Boogie.Type.GetBvType(32)), true));
            var res = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "z", Microsoft.Boogie.Type.GetBvType(32)), false);

            BvAdd = new Function(Token.NoToken, "CORRAL_BV32_ADD", args, res);
            var par = new List<object>();
            par.Add("bvadd");
            BvAdd.Attributes = new QKeyValue(Token.NoToken, "bvbuiltin", par, null);

            return BvAdd;
        }

        public static Function getBvGt()
        {
            if (BvGt != null) return BvGt;
            var args = new List<Variable>();

            args.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.GetBvType(32)), true));
            args.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "y", Microsoft.Boogie.Type.GetBvType(32)), true));
            var res = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "z", Microsoft.Boogie.Type.Bool), false);

            BvGt = new Function(Token.NoToken, "CORRAL_BV32_GT", args, res);
            var par = new List<object>();
            par.Add("bvsgt");
            BvGt.Attributes = new QKeyValue(Token.NoToken, "bvbuiltin", par, null);

            return BvGt;
        }

        public static void reset()
        {
            BvAdd = null;
            BvGt = null;
        }

        public static Expr assumeGt(Variable v1, Variable v2)
        {
            if (useIntArithmetic)
            {
                return Expr.Gt(Expr.Ident(v1), Expr.Ident(v2));
            }
            else
            {
                var args = new List<Expr>();
                args.Add(Expr.Ident(v1));
                args.Add(Expr.Ident(v2));

                return new NAryExpr(Token.NoToken,
                    new FunctionCall(getBvGt()), args);
            }
        }

        public static Expr assumeGt(Variable v1, int c)
        {
            if (useIntArithmetic)
            {
                return Expr.Gt(Expr.Ident(v1), Expr.Literal(c));
            }
            else
            {
                var args = new List<Expr>();
                args.Add(Expr.Ident(v1));
                args.Add(new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(c), 32));

                return new NAryExpr(Token.NoToken,
                    new FunctionCall(getBvGt()), args);
            }
        }

        public static LiteralExpr getLiteral(int c)
        {
            if (useIntArithmetic) return Expr.Literal(c);
            return new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(c), 32);
        }

        public static Expr increment(Variable v1)
        {
            if (useIntArithmetic)
            {
                return Expr.Add(Expr.Ident(v1), Expr.Literal(1));
            }
            else
            {
                var args = new List<Expr>();
                args.Add(Expr.Ident(v1));
                args.Add(new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(1), 32));
                
                return new NAryExpr(Token.NoToken,
                    new FunctionCall(getBvAdd()), args);
            }
        }
    }
}
