using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropInstUtils
{
    public class KeyWords
    {
        // arbitrary list of parameters (at a procedure declaration)
        public const string AnyParams = "#AnyParameters";
        // arbitrary list of arguments (at a procedure call)
        // may be used as a function: argument is an expression, we choose those where the expression matches
        public const string AnyArgs = "#AnyArguments";

        public const string AnyExpr = "#AnyExpr";
        //arbitrary list of results of a call
        // these are always IdentifierExprs
        //public const string AnyResults = "$$ANYRESULTS";
        //nicer instead of AnyResults:
        public const string AnyLhss = "$$ANYLEFTHANDSIDES";
        public const string AnyType = "$$ANYTYPE";
        public const string AnyProcedure = "#AnyProcedure";
        // any IdentifierExpr
        public const string IdExpr = "#IdentifierExpr";
        // matching a name with a regex
        public const string NameMatches = "#NameMatches";
        // procedure must be declared but not implemented
        public const string NoImplementation = "#NoImplementation";

        public static string[] AllKeywords = { AnyParams, AnyArgs, AnyLhss, AnyType, AnyProcedure, IdExpr, NameMatches, NoImplementation, AnyExpr };
    }
}
