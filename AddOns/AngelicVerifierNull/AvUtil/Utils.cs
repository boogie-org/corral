using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;

namespace AvUtil
{
    public class InputProgramDoesNotMatchExn : Exception
    {
        public InputProgramDoesNotMatchExn(string s) : base(s) { }
    }


    public static class AvnAnnotations
    {
        public static readonly string CORRAL_MAIN_PROC = "CorralMain";
        public static readonly string BlockingConstraintAttr = "BlockingConstraint";
        public static readonly string InitialializationProcAttr = "ProgramInitialization";
        public static readonly string EnvironmentAssumptionAttr = "Ebasic";
        public static readonly string ReachableStatesAttr = "ReachableStates";
        public static readonly string RelaxConstraintAttr = "SoftConstraint";
        public static readonly string AngelicUnknownCall = "AngelicUnknown";
        public static int RelaxConstraintsStackDepthBound = 6;
    }

    public class Utils
    {
        //TODO: merge with Log class in Corral
        const bool SUPPRESS_DEBUG_MESSAGES = false;
        public enum PRINT_TAG { AV_WARNING, AV_DEBUG, AV_OUTPUT, AV_STATS };
        public static void Print(string msg, PRINT_TAG tag = PRINT_TAG.AV_DEBUG)
        {
            if (tag != PRINT_TAG.AV_DEBUG || !SUPPRESS_DEBUG_MESSAGES)
                Console.WriteLine("[TAG: {0}] {1}", tag, msg);
        }
    }

    public class AssertCountVisitor : StandardVisitor
    {
        public int assertCount = 0;
        public string notfalse = null;

        public AssertCountVisitor()
        {
            notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
        }

        public static int Count(Program program)
        {
            var v = new AssertCountVisitor();
            v.VisitProgram(program);
            return v.assertCount;
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            // disregard true and !false
            if (node.Expr.ToString() == Expr.True.ToString() ||
                node.Expr.ToString() == notfalse)
                return node;

            assertCount++;
            return base.VisitAssertCmd(node);
        }
    }

    public class AssertWithAttributeCountVisitor : StandardVisitor
    {
        public int assertCountAll = 0;
        public int assertsNotRemovedCount = 0;
        public string notfalse = null;
        private string attrName;

        public AssertWithAttributeCountVisitor(string attributeName)
        {
            attrName = attributeName;
            notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            if (QKeyValue.FindExprAttribute(node.Attributes, attrName) == null)
                return base.VisitAssertCmd(node);
            assertCountAll++;
            // disregard true and !false
            if (node.Expr.ToString() == Expr.True.ToString() ||
                node.Expr.ToString() == notfalse)
                return base.VisitAssertCmd(node);

            assertsNotRemovedCount++;
            return base.VisitAssertCmd(node);
        }
    }


}
