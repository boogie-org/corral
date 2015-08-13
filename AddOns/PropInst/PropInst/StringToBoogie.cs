using System;
using System.Linq;
using Microsoft.Boogie;

namespace PropInst
{
    internal class StringToBoogie
    {
        public static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = String.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }

        public static Cmd ToCmd(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = String.Format("procedure foo() {{ {0} }}", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            return program.TopLevelDeclarations.OfType<Implementation>().First().Blocks.First().Cmds.First();
        }

        public static Declaration ToDecl(string str)
        {
            Program program;
            Parser.Parse(str, "dummy.bpl", out program);
            return program.TopLevelDeclarations.First();
        }

        public static Procedure ToProcedure(string str)
        {
            Program program;
            Parser.Parse(str, "dummy.bpl", out program);
            return program.TopLevelDeclarations.OfType<Procedure>().First();

        }

        internal static Variable ToVariable(string str)
        {
            Program program;
            Parser.Parse(str, "dummy.bpl", out program);
            return program.TopLevelDeclarations.OfType<Variable>().First();
        }
    }
}