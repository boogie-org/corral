using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Microsoft.Boogie;
using cba.Util;

namespace PropInst
{
    internal class Driver
    {
        public HashSet<IToken> ProcsThatHaveBeenInstrumented = new HashSet<IToken>();

        private enum ReadMode { Toplevel, RuleLhs, RuleRhs, Decls, BoogieCode, RuleArrow };

        //TODO: collect some stats about the instrumentation, mb some debugging output??

        private static void Main(string[] args)
        {
            if (args.Length < 3)
            {
                Console.WriteLine("usage: PropInst.exe propertyFile.avp boogieInputFile.bpl boogieOutputFile.bpl");
                return;
            }

            // initialize Boogie
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // read the boogie program that is to be instrumented
            var boogieProgram = BoogieUtil.ReadAndResolve(args[1], false);

            // parse the property file
            var propLines = File.ReadLines(args[0]);
            string globalDeclarations;
            List<Rule> rules;
            ParseProperty(propLines, out globalDeclarations, out rules);

            // GlobalDeclarations: add the global declarations from the property to the Boogie program
            Program dummyProg;
            Parser.Parse(globalDeclarations, "dummy.bpl", out dummyProg);
            boogieProgram.AddTopLevelDeclarations(dummyProg.TopLevelDeclarations);

            // CmdRule: find insertions sites (Commands), insert code there
            InstrumentCmdRule.Instrument(boogieProgram, rules.OfType<CmdRule>());

            // InsertAtBeginningRule: find insertion sites (Procedures), insert code there
            InstrumentProcedureRule.Instrument(boogieProgram, rules.OfType<InsertAtBeginningRule>());

            string outputFile = args[2];
            BoogieUtil.PrintProgram(boogieProgram, outputFile);

            Stats.printStats();
        }

        private static void ParseProperty(IEnumerable<string> propLines, out string globalDeclarations, out List<Rule> rules)
        {
            var ruleTriples = new List<Tuple<string, string, string>>();

            string templateVariables = "";
            globalDeclarations = "";

            var pCounter = 0;
            var boogieLines = "";
            var mode = ReadMode.Toplevel;
            string ruleLhs = "";
            string currentRuleOrDecl = "";

            foreach (var line1 in propLines)
            {
                //deal with the curly braces that belong to the property language (not to Boogie)
                var line = line1;
                if (pCounter == 0 && line.LastIndexOf('{') != -1)
                    line = line.Substring(line.IndexOf('{') + 1);
                pCounter += CountChar(line1, '{') - CountChar(line1, '}');
                if (pCounter == 0 && line.LastIndexOf('}') != -1)
                    line = line.Substring(0, line.LastIndexOf('}'));

                // allow line comments on the top level (inside the parentheses, Boogie parsing is used anyway..)
                if (pCounter == 0 && line.Contains("//"))
                    line = line.Substring(0, line.IndexOf("//", System.StringComparison.Ordinal));

                switch (mode)
                {
                    case ReadMode.Toplevel:
                        currentRuleOrDecl = line.Trim();
                        if (line.Trim() == "GlobalDeclarations")
                        {
                            mode = ReadMode.Decls;
                        }
                        if (line.Trim() == "TemplateVariables")
                        {
                            mode = ReadMode.Decls;
                        }
                        if (line.Trim() == "CmdRule")
                        {
                            mode = ReadMode.RuleLhs;
                        }
                        if (line.Trim() == "InsertAtBeginningRule")
                        {
                            mode = ReadMode.RuleLhs;
                        }
                        break;
                    case ReadMode.RuleLhs:
                        boogieLines += line + "\n";
                        if (pCounter == 0)
                        {
                            mode = ReadMode.RuleArrow;
                            ruleLhs = boogieLines;
                            boogieLines = "";
                            continue;
                        }
                        break;
                    case ReadMode.RuleArrow:
                        Debug.Assert(line.Trim() == "-->");
                        mode = ReadMode.RuleRhs;
                        break;
                    case ReadMode.RuleRhs:
                        boogieLines += line + "\n";
                        if (pCounter == 0)
                        {
                            mode = ReadMode.Toplevel;
                            var ruleRhs = boogieLines;
                            ruleTriples.Add(new Tuple<string, string, string>(currentRuleOrDecl, ruleLhs, ruleRhs));
                            boogieLines = "";
                            continue;
                        }
                        break;
                    case ReadMode.Decls:
                        boogieLines += line + "\n";
                        if (pCounter == 0)
                        {
                            switch (currentRuleOrDecl)
                            {
                                case "GlobalDeclarations":
                                    mode = ReadMode.Toplevel;
                                    globalDeclarations = boogieLines;
                                    break;
                                case "TemplateVariables":
                                    mode = ReadMode.Toplevel;
                                    templateVariables = boogieLines;
                                    break;
                            }
                            boogieLines = "";
                            continue;
                        }
                        break;
                    case ReadMode.BoogieCode:
                        boogieLines += line + "\n";
                        break;
                    default:
                        throw new Exception();
                }
            }

            rules = new List<Rule>();
            foreach (var triple in ruleTriples)
            {
                if (triple.Item1 == "CmdRule")
                {
                    rules.Add(new CmdRule(triple.Item2, triple.Item3, globalDeclarations + templateVariables));
                    Stats.count("No CmdRule");
                }
                if (triple.Item1 == "InsertAtBeginningRule")
                {
                    rules.Add(new InsertAtBeginningRule(triple.Item2, triple.Item3, globalDeclarations));
                    Stats.count("No InsertAtBeginningRule");
                }
            }
        }

        private static int CountChar(string line, char p1)
        {
            var result = 0;
            foreach (var c in line)
                if (c == p1)
                    result++;
            return result;
        }

        public static bool AreAttributesASubset(QKeyValue left, QKeyValue right)
        {
            for (; left != null; left = left.Next) //TODO: make a reference copy of left to work on??
            {
                //need to filter out keyword attributes
                if (KeyWords.AllKeywords.Contains(left.Key))
                {
                    continue;
                }

                if (!BoogieUtil.checkAttrExists(left.Key, right))
                {
                    return false;
                }
            }
            return true;
        }
    }

    class InstrumentProcedureRule
    {
        private readonly IEnumerable<InsertAtBeginningRule> _rules;
        private readonly Program _program;

        public InstrumentProcedureRule(IEnumerable<InsertAtBeginningRule> pins, Program pProg)
        {
            _program = pProg;
            _rules = pins;
        }


        public static void Instrument(Program program, IEnumerable<InsertAtBeginningRule> ins)
        {
            var iiap = new InstrumentProcedureRule(ins, program);

            //for procedures with an implementation we insert our code at the beginning of that
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(iiap.Instrument);

            //for procedures without an implementation we add one and insert our code there
            //need to iterate separately, because this changes ToplevelDeclarations on a match
            var stubs = new List<Procedure>();
            program.TopLevelDeclarations
                .OfType<Procedure>()
                .Where(p => program.Implementations.All(i => i.Name != p.Name))
                .Iter(stubs.Add);
            stubs.Iter(iiap.Instrument);
        }

        private void Instrument(DeclWithFormals dwf)
        {
            foreach (var rule in _rules)
            {
                foreach (var procSig in rule.ProcedureToMatchToInsertion.Keys)
                {
                    int anyParamsPosition;
                    QKeyValue anyParamsAttributes;
                    Dictionary<Declaration, Expr> paramSubstitution;
                    if (ProcedureSigMatcher.MatchSig(procSig, dwf, _program, out anyParamsAttributes, out anyParamsPosition, out paramSubstitution))
                    {
                        Implementation impl = null;
                        if (dwf is Implementation)
                        {
                            impl = (Implementation) dwf;
                        }
                        else if (dwf is Procedure)
                        {
                            var proc = (Procedure)dwf;

                            var newInParams = new List<Variable>();
                            foreach (var v in proc.InParams)
                                newInParams.Add(new LocalVariable(v.tok, v.TypedIdent));
                            var newOutParams = new List<Variable>();
                            foreach (var v in proc.OutParams)
                                newOutParams.Add(new LocalVariable(v.tok, v.TypedIdent));

                            impl = new Implementation(proc.tok, proc.Name, proc.TypeParameters, newInParams, newOutParams, new List<Variable>(), new List<Block>());


                            _program.AddTopLevelDeclaration(impl);
                        }
                        InjectCode(impl, anyParamsPosition, anyParamsAttributes, procSig, rule, paramSubstitution);
                        Stats.count("Times InsertAtBeginningRule injected code");
                        //only take the first match
                        return;
                    }
                }
            }
        }

        private static void InjectCode(Implementation impl, int anyParamsPosition, QKeyValue anyParamsAttributes,
            Implementation procSig, InsertAtBeginningRule rule, Dictionary<Declaration, Expr> paramSubstitution)
        {
            var doesAnyParamOccurInRhs = false;
            if (anyParamsPosition != int.MaxValue)
            {
                var anyParam = procSig.InParams[anyParamsPosition];
                var oiv = new OccursInVisitor(anyParam);
                oiv.VisitCmdSeq(rule.ProcedureToMatchToInsertion[procSig]);
                doesAnyParamOccurInRhs = oiv.Success;
            }

            //if (anyParamsPosition != int.MaxValue)
            if (doesAnyParamOccurInRhs)
            {
                for (int i = anyParamsPosition; i < impl.InParams.Count; i++)
                {
                    var p = impl.InParams[i];
                    // If attributes for the ##anyparams in the toMatch are given, we only insert code for those parameters of impl 
                    // with matching (subset) attributes
                    // we look both in the implementation's and the procedure declaration's signature
                    if (anyParamsAttributes == null
                        //|| Driver.AreAttributesASubset(anyParamsAttributes, p.Attributes)
                        || Driver.AreAttributesASubset(anyParamsAttributes, impl.Proc.InParams[i].Attributes))
                    {
                        var id = new IdentifierExpr(Token.NoToken, p.Name, p.TypedIdent.Type, true);
                        var substitution = new Dictionary<Declaration, Expr> {{procSig.InParams[anyParamsPosition], id}};
                        foreach (var kvp in paramSubstitution)
                            substitution.Add(kvp.Key, kvp.Value);

                        var sv = new SubstitionVisitor(substitution);
                        var newCmds = sv.VisitCmdSeq(rule.ProcedureToMatchToInsertion[procSig]);
                        if (impl.Blocks.Count > 0)
                        {
                            impl.Blocks.Insert(0,
                                BoogieAstFactory.MkBlock(newCmds,
                                    BoogieAstFactory.MkGotoCmd(impl.Blocks.First().Label)));
                        }
                        else
                        {
                            impl.Blocks.Add(
                                BoogieAstFactory.MkBlock(newCmds));
                        }
                    }
                }
            }
            else
            {
                var sv = new SubstitionVisitor(paramSubstitution);
                var newCmds = sv.VisitCmdSeq(rule.ProcedureToMatchToInsertion[procSig]);
                if (impl.Blocks.Count > 0)
                {
                    impl.Blocks.Insert(0,
                        BoogieAstFactory.MkBlock(newCmds,
                            BoogieAstFactory.MkGotoCmd(impl.Blocks.First().Label)));
                }
                else
                {
                    impl.Blocks.Add(
                        BoogieAstFactory.MkBlock(newCmds));
                }
            }
        }
    }


    class InstrumentCmdRule
    {
        private readonly IEnumerable<CmdRule> _rules;

        private InstrumentCmdRule(IEnumerable<CmdRule> pRules)
        {
            _rules = pRules;
        }

        public static void Instrument(Program program, IEnumerable<CmdRule> ins)
        {
            var im = new InstrumentCmdRule(ins);

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(im.Instrument);
        }

        private void Instrument(Implementation impl)
        {
            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (var cmd in block.Cmds)
                {
                    //if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd));
                    //else if (cmd is PredicateCmd) newcmds.AddRange(ProcessPredicateCmd(cmd as PredicateCmd));
                    //else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    //else newcmds.Add(cmd);
                    newcmds.AddRange(ProcessCmd(cmd));
                }
                block.Cmds = newcmds;
            }
        }
        private List<Cmd> ProcessCmd(Cmd cmd)
        {
            foreach (var rule in _rules)
            {
                foreach (var toMatch in rule.CmdsToMatch)
                {
                    if (!(toMatch.GetType() == cmd.GetType()))
                        continue;
                    //var toMatch = (CallCmd) m;

                    List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions = null;
                    var match = false;
                    if (cmd is CallCmd)
                    {
                        match = MatchCallCmd((CallCmd) cmd, rule, (CallCmd) toMatch, out substitutions);
                    }
                    else if (cmd is AssignCmd)
                    {
                        match = MatchAssignCmd((AssignCmd) cmd, (AssignCmd) toMatch, out substitutions);
                    }
                    else if (cmd is AssumeCmd)
                    {
                        match = MatchPredicateCmd((AssumeCmd) cmd, (AssumeCmd) toMatch, out substitutions);
                    }
                    else if (cmd is AssertCmd)
                    {
                        match = MatchPredicateCmd((AssertCmd) cmd, (AssertCmd) toMatch, out substitutions);
                    }
                    else if (cmd is ReturnCmd)
                    {
                        throw new NotImplementedException();
                    }

                    if (match)
                    {
                        var ret = new List<Cmd>();
                        foreach (var subsPair in substitutions)
                        {
                            var sv = new SubstitionVisitor(subsPair.Item1, subsPair.Item2, cmd);
                            ret.AddRange(sv.VisitCmdSeq(rule.InsertionTemplate));
                        }
                        //the rule yielded a match --> done
                        Stats.count("Times CmdRule injected code");
                        return ret;
                    }
                }
            }
            return new List<Cmd>() { cmd };
        }
        //private List<Cmd> ProcessCall(CallCmd cmd)
        //{
        //    foreach (var rule in _rules)
        //    {
        //        foreach (var m in rule.CmdsToMatch)
        //        {
        //            if (!(m is CallCmd))
        //                continue;
        //            var toMatch = (CallCmd) m;

        //            List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions;
        //            var match = MatchCallCmd(cmd, rule, toMatch, out substitutions);

        //            if (match)
        //            {
        //                var ret = new List<Cmd>();
        //                foreach (var subsPair in substitutions)
        //                {
        //                    var sv = new SubstitionVisitor(subsPair.Item1, subsPair.Item2, cmd); //TODO go over
        //                    ret.AddRange(sv.VisitCmdSeq(rule.InsertionTemplate));
        //                }
        //                //the rule yielded a match --> done
        //                Stats.count("Times CmdRule injected code");
        //                return ret;
        //            }
        //        }
        //    }
        //    return new List<Cmd>() { cmd };
        //}

        private static bool MatchCallCmd(CallCmd cmd, CmdRule rule, CallCmd toMatch, out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions)
        {
            // question:    why do we have a list of substitutions, here?
            // answer:      the reason (right now) is AnyArgs: many arguments may match, the current semantics 
            //              is that we want to make the insertion for every match (example: memory accesses)
            substitutions = new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>();
            var match = false;

            #region match procedure name

            //if (toMatch.callee == KeyWords.AnyProcedure)
            var matchCallee = rule.Prog.Procedures.First(p => p.Name == toMatch.callee);
            if (matchCallee != null)
            {
                // do nothing
            }
            else if (toMatch.callee.StartsWith("##"))
            {
                //TODO: implement, probably: remember the real identifier..
            }
            else if (toMatch.callee == cmd.Proc.Name)
            {
                // do nothing
            }
            else
            {
                //no match
                return match;
            }

            #endregion

            #region match out parameters ("the things assigned to")

            //if (toMatch.Outs.Count == 1
            //    && toMatch.Outs[0].Name == KeyWords.AnyLhss)
            //{
            //    //matches anything --> do nothing/go on
            //}
            //else 
            if (toMatch.Outs.Count == cmd.Outs.Count)
            {
                //TODO.. --> match, make substitution..
            }
            else
            {
                //TODO.. --> match, make substitution..
            }

            #endregion

            #region match arguments

            if (BoogieUtil.checkAttrExists(KeyWords.AnyArgs, matchCallee.Attributes))
            {
                var anyArgsExpr = (NAryExpr) toMatch.Ins[0];


                var atLeastOneMatch = false;

                foreach (var arg in cmd.Ins)
                {
                    var emv = new ExprMatchVisitor(new List<Expr>() {anyArgsExpr});
                    emv.VisitExpr(arg);

                    if (emv.Matches)
                    {
                        atLeastOneMatch = true;
                        substitutions.Add(
                            new Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>(
                                emv.Substitution, emv.FunctionSubstitution));
                        match = true;
                    }
                }
                if (!atLeastOneMatch)
                    return match;
            }
            else
            {
                //match them one by one
                //TODO
                //if they don't match:
                return match;
            }

            #endregion

            return match;
        }

        //private List<Cmd> ProcessPredicateCmd(PredicateCmd cmd)
        //{
        //    foreach (var rule in _rules)
        //    {
        //        foreach (var m in rule.CmdsToMatch)
        //        {
        //            if (!((m is AssertCmd && cmd is AssertCmd) || (m is AssumeCmd && cmd is AssumeCmd)))
        //                continue;

        //            var toMatch = (PredicateCmd) m;

        //            Dictionary<Declaration, Expr> substitution;
        //            Dictionary<string, IAppliable> functionSubstitution;
        //            var match = MatchPredicateCmd(cmd, toMatch, out substitution, out functionSubstitution);

        //            if (match)
        //            {
        //                Stats.count("Times CmdRule injected code");
        //                var sv = new SubstitionVisitor(substitution, functionSubstitution, cmd);
        //                return sv.VisitCmdSeq(rule.InsertionTemplate);
        //            }
        //        }
        //    }
        //    return new List<Cmd>() { cmd };
        //}

        private static bool MatchPredicateCmd(PredicateCmd cmd, PredicateCmd toMatch, out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions)
            //out Dictionary<Declaration, Expr> substitution,
            //out Dictionary<string, IAppliable> functionSubstitution)
        {
            var match = false;
            //substitution = null;
            //functionSubstitution = null;
            substitutions = null;

            if (!Driver.AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
            {
                return match;
            }

            var mv = new ExprMatchVisitor(new List<Expr>() {toMatch.Expr});
            mv.VisitExpr(cmd.Expr);

            if (mv.Matches)
            {
                match = true;
                //substitution = mv.Substitution;
                //functionSubstitution = mv.FunctionSubstitution;
                substitutions = 
                    new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>() 
                    { new Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>(mv.Substitution, mv.FunctionSubstitution) };
            }
            return match;
        }

        //private List<Cmd> ProcessAssign(AssignCmd cmd)
        //{
        //    //var ret = new List<Cmd>();
        //    foreach (var rule in _rules)
        //    {
        //        foreach (var m in rule.CmdsToMatch)
        //        {
        //            if (!(m is AssignCmd))
        //                continue;
        //            var toMatchCmd = (AssignCmd) m;

        //            Dictionary<Declaration, Expr> substitution;
        //            Dictionary<string, IAppliable> funcSubstitution;
        //            var match = MatchAssignCmd(cmd, toMatchCmd, out substitution, out funcSubstitution);

        //            if (match)
        //            {
        //                var sv = new SubstitionVisitor(substitution, funcSubstitution, cmd);
        //                var substitutedCmds = sv.VisitCmdSeq(rule.InsertionTemplate);

        //                Stats.count("Times CmdRule injected code");
        //                return substitutedCmds;
        //            }
        //        }
        //    }
        //    return new List<Cmd>() { cmd };
        //}

        private static bool MatchAssignCmd(AssignCmd cmd, AssignCmd toMatchCmd,  
           out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>  substitutions)
            //out Dictionary<Declaration, Expr> substitution,
            //out Dictionary<string, IAppliable> funcSubstitution)
        {
            bool match = false;
            var substitution = new Dictionary<Declaration, Expr>();
            var funcSubstitution = new Dictionary<string, IAppliable>();
            substitutions = null;

            //CONVENTION: x := e matches  x1, x2 := e1, e2;  (the first match is taken, as usual)
            //  --> i.e., we treat a multi-assign as if it were several assignments for matching purposes
            //     but we make at most one insertion for a multi-assign --> TODO: revise
            Debug.Assert(toMatchCmd.Lhss.Count == 1);

            for (int i = 0; i < cmd.Lhss.Count; i++)
            {
                var lhs = cmd.Lhss[i].AsExpr;
                var lEmv = new ExprMatchVisitor(new List<Expr> {toMatchCmd.Lhss[0].AsExpr});
                lEmv.VisitExpr(lhs);

                var rhs = cmd.Rhss[i];
                var rEmv = new ExprMatchVisitor(new List<Expr> {toMatchCmd.Rhss[0]});
                rEmv.VisitExpr(rhs);

                if (lEmv.Matches && rEmv.Matches)
                {
                    foreach (var kvp in lEmv.Substitution)
                        substitution.Add(kvp.Key, kvp.Value);
                    foreach (var kvp in lEmv.FunctionSubstitution)
                        funcSubstitution.Add(kvp.Key, kvp.Value);
                    foreach (var kvp in rEmv.Substitution)
                        substitution.Add(kvp.Key, kvp.Value);
                    foreach (var kvp in rEmv.FunctionSubstitution)
                        funcSubstitution.Add(kvp.Key, kvp.Value);

                    substitutions = 
                        new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>() 
                        { new Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>(substitution, funcSubstitution) };
                    match = true;
                    break;
                }
            }
            return match;
        }
    }
  
    internal class KeyWords
    {
        // arbitrary list of parameters (at a procedure declaration)
        public const string AnyParams = "#AnyParameters";
        // arbitrary list of arguments (at a procedure call)
        // may be used as a function: argument is an expression, we choose those where the expression matches
        public const string AnyArgs = "#AnyArguments";
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

        public static string[] AllKeywords = new string[] { AnyParams, AnyArgs, AnyLhss, AnyType, AnyProcedure, IdExpr, NameMatches, NoImplementation};
    }
}
