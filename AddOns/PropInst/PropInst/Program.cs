using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
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

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            //read the boogie program that is to be instrumented
            var boogieProgram = BoogieUtil.ReadAndResolve(args[1], true);

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
                var pChange = countChar(line, '{') - countChar(line, '}');
                if (pCounter == 0 && pChange > 0)
                    line = line.Substring(line.IndexOf('{') + 1);
                pCounter = pCounter + pChange;
                if (pCounter == 0 && pChange < 0)
                    line = line.Substring(0, line.LastIndexOf('}'));

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
                        boogieLines += line;
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
                        boogieLines += line;
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
                        boogieLines += line;
                        if (pCounter == 0)
                        {
                            if (currentRuleOrDecl == "GlobalDeclarations")
                            {
                                mode = ReadMode.Toplevel;
                                globalDeclarations = boogieLines;
                            } 
                            else if (currentRuleOrDecl == "TemplateVariables")
                            {
                                mode = ReadMode.Toplevel;
                                templateVariables = boogieLines;
                            }
                            boogieLines = "";
                            continue;
                        }
                        break;
                    case ReadMode.BoogieCode:
                        boogieLines += line;
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
                    rules.Add(new InsertAtBeginningRule(triple.Item2, triple.Item3, globalDeclarations + templateVariables));
                }
            }
            #endregion

            //add the global declarations from the property to the Boogie program
            {
                Program prog;
                Parser.Parse(globalDeclarations, "dummy.bpl", out prog);
                boogieProgram.AddTopLevelDeclarations(prog.TopLevelDeclarations);
            }

            // Property: find insertions sites (Commands), insert code there
            InstrumentInsertionAtCmd.Instrument(boogieProgram, rules.OfType<CmdRule>());
            //insertionsAtCmd.Iter(i => InstrumentInsertionAtCmd.Instrument(boogieProgram, i));

            //Property: find insertion sites (Procedures), insert code there
            //rules.OfType<InsertAtBeginningRule>()>
            //insertionsAtProcStart.Iter(i => InstrumentInsertionAtProc.Instrument(boogieProgram, i));





            string outputFile = args[2];
            BoogieUtil.PrintProgram(boogieProgram, outputFile);

            //Console.WriteLine("any to exit");
            //Console.ReadKey();
        }

        private static int countChar(string line, char p1)
        {
            var result = 0;
            foreach (var c in line)
                if (c == p1)
                    result++;
            return result;
        }




        private static bool MatchStubs(Procedure toMatchStub, Procedure boogieStub)
        {
            if (toMatchStub.Name != boogieStub.Name)
                return false;
            if (toMatchStub.InParams.Count != boogieStub.InParams.Count)
                return false;
            if (toMatchStub.OutParams.Count != boogieStub.OutParams.Count)
                return false;
            for (int i = 0; i < toMatchStub.InParams.Count; i++)
            {
                if (toMatchStub.InParams[i].GetType() != boogieStub.InParams[i].GetType())
                    return false;
            }

            return true;
        }

        public static bool AreAttributesASubset(QKeyValue left, QKeyValue right)
        {
            for (; left != null; left = left.Next) //TODO: make a reference copy of left to work on??
            {
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
        private readonly Prop_InsertCodeAtProcStart _property;

        public InstrumentInsertionAtProc(Prop_InsertCodeAtProcStart pins)
        {
            _property = pins;
        }

        private static readonly HashSet<IToken> _procsThatHaveBeenInstrumented = new HashSet<IToken>();

        public static void Instrument(Program program, Prop_InsertCodeAtProcStart ins)
        {
            var im = new InstrumentInsertionAtProc(ins);

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(im.Instrument);
        }

        private void Instrument(Implementation impl)
        {
            var psm = new ProcedureSigMatcher(_property.ToMatch, impl);
            if (!psm.MatchSig())
            {
                return;
            }

            Debug.Assert(!_procsThatHaveBeenInstrumented.Contains(impl.tok),
                "trying to instrument a procedure that has been instrumented already " +
                "--> behaviour of resulting boogie program is not well-defined," +
                " i.e., it may depend on the order of the instrumentations in the property");
            _procsThatHaveBeenInstrumented.Add(impl.tok);

            var fpv = new FindIdentifiersVisitor();
            fpv.VisitCmdSeq(_property.ToInsert);
            if (fpv.Identifiers.Exists(i => i.Name == Constants.AnyParams))
            {
                IdentifierExpr anyP = fpv.Identifiers.First(i => i.Name == Constants.AnyParams);
                for (int i = 0; i < impl.InParams.Count; i++)
                {
                    var p = impl.InParams[i];
                    // If attributes for the ##anyparams in the toMatch are given, we only insert code for those parameters of impl 
                    // with matching (subset) attributes
                    if (psm.ToMatchAnyParamsAttributes == null
                        || Driver.AreAttributesASubset(psm.ToMatchAnyParamsAttributes, p.Attributes)
                        ||
                        Driver.AreAttributesASubset(psm.ToMatchAnyParamsAttributes, impl.Proc.InParams[i].Attributes))
                    {
                        var id = new IdentifierExpr(Token.NoToken, p.Name, p.TypedIdent.Type, immutable: true);
                        var substitution = new Dictionary<Declaration, Expr> { { anyP.Decl, id } }; //TODO go over (doing any way, right?..)
                        var sv = new SubstitionVisitor(substitution);
                        var toInsertClone = _property.ToInsert.Map(x => StringToBoogie.ToCmd(x.ToString()));
                        //hack to get a deepcopy
                        //var toInsertClone = BoogieAstFactory.CloneCmdSeq(_property.ToInsert);//does not seem to work as I expect..
                        var newCmds = sv.VisitCmdSeq(toInsertClone);
                        impl.Blocks.Insert(0,
                            BoogieAstFactory.MkBlock(newCmds, BoogieAstFactory.MkGotoCmd(impl.Blocks.First().Label)));
                    }
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
                    else if (cmd is AssumeCmd) newcmds.AddRange(ProcessAssume(cmd as AssumeCmd));
                    else if (cmd is AssertCmd) newcmds.AddRange(ProcessAssert(cmd as AssertCmd));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    else newcmds.Add(cmd);
                }
                block.Cmds = newcmds;
            }
        }

        private List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            foreach (var rule in _rules)
            {
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!(m is CallCmd))
                        continue;
                    var toMatch = (CallCmd) m;

                    var substitutions =
                        new List<Tuple<Dictionary<IdentifierExpr, Expr>, Dictionary<string, IAppliable>>>();

                    #region match procedure name

                    if (toMatch.callee == Constants.AnyProcedure)
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
                        && toMatch.Outs[0].Name == Constants.AnyLhss)
                    {
                        //matches anything --> do nothing/go on
                    }
                    else
                    {
                        throw new NotImplementedException();
                    }

                    #endregion


                    #region match arguments

                    if (toMatch.Ins.Count == 1
                        && toMatch.Ins[0] is IdentifierExpr
                        && (toMatch.Ins[0] as IdentifierExpr).Name == Constants.AnyArgs)
                    {
                        //TODO: implement 
                    }
                    else if (toMatch.Ins.Count == 1
                             && toMatch.Ins[0] is NAryExpr
                             && ((NAryExpr) toMatch.Ins[0]).Fun.FunctionName == Constants.AnyArgs)
                    {
                        var anyArgsExpr = (NAryExpr) toMatch.Ins[0];

                        var matchingExprs = new List<Expr>();

                        foreach (var arg in cmd.Ins)
                        {

                            Debug.Assert(anyArgsExpr.Args.Count == 1,
                                "we expect Constants.AnyArgs to have at most one argument, " +
                                "which is the matching pattern expression");
                            UpdateSubstitutionsAccordingToMatchAndTargetExpr(anyArgsExpr.Args[0], arg, substitutions);
                        }
                    }

                    #endregion

                    foreach (var subsPair in substitutions)
                    {
                        //hack to get a deepcopy
                        var toInsertClone = rule.InsertionTemplate.Map(i => StringToBoogie.ToCmd(i.ToString()));

                        //var sv = new SubstitionVisitor(subsPair.Item1, subsPair.Item2); //TODO go over
                        //ret.AddRange(sv.VisitCmdSeq(toInsertClone));
                    }
                }
            }
            ret.Add(cmd);
            return ret;
        }


        private List<Cmd> ProcessAssume(AssumeCmd cmd)
        {
            var ret = new List<Cmd>();
            foreach (var rule in _rules)
            {
                //var toMatchNae = (AssumeCmd) _propInsertCodeAtCmd.Match;
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!(m is AssumeCmd))
                        continue;
                    var toMatch = (AssumeCmd) m;

                    if (!Driver.AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
                        continue;
                    //return new List<Cmd>() {cmd}; //not all attributs of toMatchNae are in cmd --> do nothing

                    //check if the Expression matches
                    var mv = new ExprMatchVisitor(new List<Expr>() {toMatch.Expr});
                    mv.VisitExpr(cmd.Expr);

                    if (mv.MayStillMatch)
                    {
                        var sv = new SubstitionVisitor(mv.Substitution);
                        //hack to get a deepcopy
                        var toInsertClone = rule.InsertionTemplate.Map(i => StringToBoogie.ToCmd(i.ToString()));
                        //var toInsertClone = BoogieAstFactory.CloneCmdSeq(_propInsertCodeAtCmd.ToInsert);//does not seem to work as I expect..
                        ret.AddRange(sv.VisitCmdSeq((List<Cmd>) toInsertClone));
                    }

                }
            }
            ret.Add(cmd);
            return ret;
        }

        private List<Cmd> ProcessAssert(AssertCmd cmd)
        {
            var ret = new List<Cmd>();
            //TODO..
            ret.Add(cmd);
            return ret;
        }

        private List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();
            foreach (var rule in _rules)
            {
                foreach (var m in rule.CmdsToMatch)
                {
                    if (!(m is AssignCmd))
                        continue;
                    var toMatchCmd = (AssignCmd) m;

                    var substitution = new Dictionary<Declaration, Expr>();
                    var funcSubstitution = new Dictionary<string, IAppliable>();//TODO: move from string to IAppliable?

                    //match each Lhs together with the corresponding rhs

                    //CONVENTION: x := e matches  x1, x2 := e1, e2;  (the first match is taken, as usual)
                    //  --> i.e., we treat a multi-assign as if it were several assignments
                    Debug.Assert(toMatchCmd.Lhss.Count == 1);


                    for (int i = 0; i < cmd.Lhss.Count; i++)
                    {
                        var lhs = cmd.Lhss[i].AsExpr;
                        var lEmv = new ExprMatchVisitor(new List<Expr> {toMatchCmd.Lhss[0].AsExpr});
                        lEmv.VisitExpr(lhs);

                        var rhs = cmd.Rhss[i];
                        var rEmv = new ExprMatchVisitor(new List<Expr> {toMatchCmd.Rhss[0]});
                        rEmv.VisitExpr(rhs);


                        if (lEmv.MayStillMatch && rEmv.MayStillMatch)
                        {
                            foreach (var kvp in lEmv.Substitution)
                                substitution.Add(kvp.Key, kvp.Value);
                            foreach (var kvp in lEmv.FunctionSubstitution)
                                funcSubstitution.Add(kvp.Key, kvp.Value);
                            foreach (var kvp in rEmv.Substitution)
                                substitution.Add(kvp.Key, kvp.Value);
                            foreach (var kvp in rEmv.FunctionSubstitution)
                                funcSubstitution.Add(kvp.Key, kvp.Value);

                            var sv = new SubstitionVisitor(substitution, funcSubstitution);
                            var substitutedCmds = sv.VisitCmdSeq(rule.InsertionTemplate);
                            ret.AddRange(substitutedCmds);

                            return ret;
                        }

                    }

                }
            }
            return ret;
        }

        private static void UpdateSubstitutionsAccordingToMatchAndTargetExpr(Expr toMatch, Expr expr, List<Tuple<Dictionary<IdentifierExpr, Expr>, Dictionary<string, IAppliable>>> substitutions)
        {

            if (toMatch is NAryExpr
                && ((NAryExpr)toMatch).Fun.FunctionName == Constants.MemAccess)
            {
                //special case: we want to match anything that is a memory access 
                //i.e. someting like MemT.sometypename[someExpression]
                //and get out someExpression
                //TODO: this is the current case --> generalize such that someExpression may be a complex match, too??
                var memAccessExpr = (NAryExpr)toMatch;

                Debug.Assert(memAccessExpr.Args.Count == 1);
                //TODO above --> generalize to other matches..");

                var memAccessToMatchExpr = memAccessExpr.Args[0];

                var gma = new GatherMemAccesses();
                gma.Visit(expr);

                if (gma.accesses.Count == 0)
                {
                    // there's no memory access in this argument --> do nothing for it
                    //return ret;
                    return;
                }

                // we have a memory access
                foreach (var access in gma.accesses)
                {
                    var emv = new ExprMatchVisitor(new List<Expr>() { memAccessToMatchExpr });
                    emv.Visit(access.Item2);

                    // here we have all we need to make a new command:
                    // for each expr of the anyargs, for each memoryAccess in that expr:
                    // instantiate the ToInsert accordingly
                    if (emv.MayStillMatch)
                    {
                        //TODO: right now, we get a substitution (pair) for each match. 
                        //TODO: In the future we may need to several substitutions for example because
                        //TODO: there are many memaccesses, args that match anyargs, and so on.. --> right??
                        //substitutions.Add(
                        //    new Tuple<Dictionary<IdentifierExpr, Expr>, Dictionary<string, IAppliable>>(emv.Substitution,
                        //        emv.FunctionSubstitution));//TODO go over
                    }
                }
            }
            else
            {
                //TODO: other matches of anyargs than memAccess
                throw new NotImplementedException();
            }
        }

    }
  
    internal class Constants
    {
        // arbitrary list of parameters (at a procedure declaration)
        public const string AnyParams = "$$ANYPARAMS";
        // arbitrary list of arguments (at a procedure call)
        // may be used as a function: argument is an expression, we choose those where the expression matches
        public const string AnyArgs = "$$ANYARGUMENTS";
        //arbitrary list of results of a call
        // these are always IdentifierExprs
        //public const string AnyResults = "$$ANYRESULTS";
        //nicer instead of AnyResults:
        public const string AnyLhss = "$$ANYLEFTHANDSIDES";
        public const string AnyType = "$$ANYTYPE";
        public const string AnyProcedure = "$$ANYPROC";
        public const string AnyExpr = "$$ANYEXP";
        // matches a sum, i.e. a (possibly nested) naryExpr with function '+'
        // also matches a sum with only one summand, i.e. matches anything that matches the expression within
        public const string AnySum = "$$ANYSUM";
        // any IdentifierExpr, if used as a function (with a single argument), 
        // the identifier found can be referred to by that argument
        public const string IdExpr = "$$IDEXPR";
        public const string MemAccess = "$$MEMACCESS";
        public static string RuleSeparator = "####";
    }
}
