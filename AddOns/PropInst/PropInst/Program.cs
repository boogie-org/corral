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

        private enum ReadMode { Toplevel, RuleLhs, RuleRhs, Decls, BoogieCode,
            RuleArrow
        };

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
            //var boogieProgram = BoogieUtil.ReadAndResolve(args[1], true);

            #region parse the property file
            var propLines = File.ReadLines(args[0]);

            var mode = ReadMode.Toplevel;
            string boogieLines = "";
            var pCounter = 0;

            string currentRuleOrDecl = "";
            string ruleLhs = "";

            string globalDeclarations = "";
            string templateVariables = "";
            var ruleTriples = new List<Tuple<string, string, string>>();

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

            var rules = new List<Rule>();
            foreach (var triple in ruleTriples)
            {
                if (triple.Item1 == "CmdRule")
                {
                    rules.Add(new CmdRule(triple.Item2, triple.Item3, globalDeclarations + templateVariables));
                }
                if (triple.Item1 == "InsertAtBeginningRule")
                {
                    rules.Add(new InsertAtBeginningRule(triple.Item2, triple.Item3, globalDeclarations));
                }
            }
            #endregion

            //Property: add the global declarations from the property to the Boogie program
            {
                Program prog;
                Parser.Parse(globalDeclarations, "dummy.bpl", out prog);
                boogieProgram.AddTopLevelDeclarations(prog.TopLevelDeclarations);
            }

            // Property: find insertions sites (Commands), insert code there
            InstrumentInsertionAtCmd.Instrument(boogieProgram, rules.OfType<CmdRule>());

            //Property: find insertion sites (Procedures), insert code there
            InstrumentInsertionAtProc.Instrument(boogieProgram, rules.OfType<InsertAtBeginningRule>());


            string outputFile = args[2];
            BoogieUtil.PrintProgram(boogieProgram, outputFile);
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

    class InstrumentInsertionAtProc
    {
        private readonly IEnumerable<InsertAtBeginningRule> _rules;
        private readonly Program _program;

        public InstrumentInsertionAtProc(IEnumerable<InsertAtBeginningRule> pins, Program pProg)
        {
            _program = pProg;
            _rules = pins;
        }


        public static void Instrument(Program program, IEnumerable<InsertAtBeginningRule> ins)
        {
            var iiap = new InstrumentInsertionAtProc(ins, program);

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


    class InstrumentInsertionAtCmd
    {
        private readonly IEnumerable<CmdRule> _rules;

        private InstrumentInsertionAtCmd(IEnumerable<CmdRule> pRules)
        {
            _rules = pRules;
        }

        public static void Instrument(Program program, IEnumerable<CmdRule> ins)
        {
            var im = new InstrumentInsertionAtCmd(ins);

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(im.Instrument);
        }

        private void Instrument(Implementation impl)
        {
            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (Cmd cmd in block.Cmds)
                {
                    if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd));
                    else if (cmd is PredicateCmd) newcmds.AddRange(ProcessPredicateCmd(cmd as PredicateCmd));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    else newcmds.Add(cmd);
                }
                block.Cmds = newcmds;
            }
        }

        private List<Cmd> ProcessCall(CallCmd cmd)
        {
            foreach (var rule in _rules)
            {
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!(m is CallCmd))
                        continue;
                    var toMatch = (CallCmd) m;

                    var substitutions =
                        new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>();

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
                        continue;
                    }

                    #endregion

                    #region match out parameters ("the things assigned to")

                    if (toMatch.Outs.Count == 1
                        && toMatch.Outs[0].Name == KeyWords.AnyLhss)
                    {
                        //matches anything --> do nothing/go on
                    }
                    else if (toMatch.Outs.Count == cmd.Outs.Count)
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
                            }
                        }
                        if (!atLeastOneMatch)
                            continue;
                    }
                    else
                    {
                        //match them one by one
                        //TODO
                        //if they don't match:
                        continue;
                    }

                    #endregion

                    var ret = new List<Cmd>();
                    foreach (var subsPair in substitutions)
                    {
                        var sv = new SubstitionVisitor(subsPair.Item1, subsPair.Item2, cmd); //TODO go over
                        ret.AddRange(sv.VisitCmdSeq(rule.InsertionTemplate));
                    }
                    //the rule yielded a match --> done
                    return ret;
                }
            }
            return new List<Cmd>() { cmd };
        }

        private List<Cmd> ProcessPredicateCmd(PredicateCmd cmd)
        {
             foreach (var rule in _rules)
            {
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!((m is AssertCmd && cmd is AssertCmd) || (m is AssumeCmd && cmd is AssumeCmd)))
                        continue;

                    var toMatch = (PredicateCmd) m;

                    if (!Driver.AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
                        continue;

                    var mv = new ExprMatchVisitor(new List<Expr>() {toMatch.Expr});
                    mv.VisitExpr(cmd.Expr);

                    if (!mv.Matches) continue;

                    var sv = new SubstitionVisitor(mv.Substitution, mv.FunctionSubstitution, cmd);
                    return sv.VisitCmdSeq(rule.InsertionTemplate);
                }
            }
            return new List<Cmd>() { cmd };
        }

        private List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            //var ret = new List<Cmd>();
            foreach (var rule in _rules)
            {
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!(m is AssignCmd))
                        continue;
                    var toMatchCmd = (AssignCmd) m;

                    var substitution = new Dictionary<Declaration, Expr>();
                    var funcSubstitution = new Dictionary<string, IAppliable>();//TODO: move from string to IAppliable?


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

                            var sv = new SubstitionVisitor(substitution, funcSubstitution, cmd);
                            var substitutedCmds = sv.VisitCmdSeq(rule.InsertionTemplate);

                            return substitutedCmds;
                        }
                    }
                }
            }
            return new List<Cmd>() { cmd };
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
