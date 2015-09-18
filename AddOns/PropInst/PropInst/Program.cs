using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using Microsoft.Boogie;
using cba.Util;
using PropInstUtils;

namespace PropInst
{
    internal class Driver
    {
        public HashSet<IToken> ProcsThatHaveBeenInstrumented = new HashSet<IToken>();

      
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
            CreateRulesFromProperty(propLines, out globalDeclarations, out rules);

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

        private static void CreateRulesFromProperty(IEnumerable<string> propLines, out string globalDeclarations, out List<Rule> rules)
        {
            List<Tuple<string, string, string>> ruleTriples;
            string templateVariables;
            PropertyParser.ParseProperty(propLines, out globalDeclarations, out ruleTriples, out templateVariables);

            rules = new List<Rule>();
            foreach (var triple in ruleTriples)
            {
                if (triple.Item1 == PropertyKeyWords.CmdRule)
                {
                    rules.Add(new CmdRule(triple.Item2, triple.Item3, globalDeclarations + templateVariables));
                    Stats.count("No " + PropertyKeyWords.CmdRule);
                }
                if (triple.Item1 == PropertyKeyWords.ProcedureRule)
                {
                    rules.Add(new InsertAtBeginningRule(triple.Item2, triple.Item3, globalDeclarations));
                    Stats.count("No " + PropertyKeyWords.ProcedureRule);
                }
            }
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
                    int anyParamsPositionOut;
                    QKeyValue anyParamsAttributesOut;
                    Dictionary<Declaration, Expr> paramSubstitution;
                    if (ProcedureSigMatcher.MatchSig(procSig, dwf, _program, out anyParamsAttributes, out anyParamsPosition, out anyParamsAttributesOut, out anyParamsPositionOut, out paramSubstitution))
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
                        InjectCode(impl, anyParamsPosition, anyParamsAttributes, anyParamsPositionOut, anyParamsAttributesOut, procSig, rule, paramSubstitution);
                        Stats.count("Times " + PropertyKeyWords.ProcedureRule + " injected code");
                        //only take the first match
                        return;
                    }
                }
            }
        }

        private static void InjectCode(Implementation impl, int anyParamsPosition, QKeyValue anyParamsAttributes, int anyParamsPositionOut, QKeyValue anyParamsAttributesOut,
            Implementation procSig, InsertAtBeginningRule rule, Dictionary<Declaration, Expr> paramSubstitution)
        {
            //TODO handle anyParams in the OutParam case
            var doesAnyParamOccurInRhs = false;
            if (anyParamsPosition != int.MaxValue)
            {
                var anyParam = procSig.InParams[anyParamsPosition];
                var oiv = new OccursInVisitor(anyParam);
                oiv.VisitCmdSeq(rule.ProcedureToMatchToInsertion[procSig]);
                doesAnyParamOccurInRhs = oiv.Success;
            }

            if (doesAnyParamOccurInRhs)
            {
                for (int i = anyParamsPosition; i < impl.InParams.Count; i++)
                {
                    var p = impl.InParams[i];
                    // If attributes for the ##anyparams in the toMatch are given, we only insert code for those parameters of impl 
                    // with matching (subset) attributes
                    // we look both in the implementation's and the procedure declaration's signature
                    if (anyParamsAttributes == null
                        || ExprMatchVisitor.AreAttributesASubset(anyParamsAttributes, impl.Proc.InParams[i].Attributes))
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
                    else
                    {
                        // no match
                    }

                    if (match)
                    {
                        var ret = new List<Cmd>();
                        if (substitutions.Count == 0)
                        {
                            var sv = new SubstitionVisitor(new Dictionary<Declaration, Expr>(), new Dictionary<string, IAppliable>(), cmd);
                            ret.AddRange(sv.VisitCmdSeq(rule.InsertionTemplate));
                        }
                        else
                        {
                            foreach (var subsPair in substitutions)
                            {
                                var sv = new SubstitionVisitor(subsPair.Item1, subsPair.Item2, cmd);
                                ret.AddRange(sv.VisitCmdSeq(rule.InsertionTemplate));
                            }
                        }
                        //the rule yielded a match --> done
                        Stats.count("Times " + PropertyKeyWords.CmdRule + " injected code");
                        return ret;
                    }
                }
            }
            return new List<Cmd>() { cmd };
        }

        private static bool MatchCallCmd(CallCmd cmd, CmdRule rule, CallCmd toMatch, out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions)
        {
            // question:    why do we have a list of substitutions, here?
            // answer:      the reason (right now) is AnyArgs: many arguments may match, the current semantics 
            //              is that we want to make the insertion for every match (example: memory accesses)
            substitutions = new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>();

            #region match procedure name

            //if (toMatch.callee == BoogieKeyWords.AnyProcedure)
            var matchCallee = rule.Prog.Procedures.FirstOrDefault(p => p.Name == toMatch.callee);
            if (matchCallee != null)
            {
                // procedure is declared in TemplateVariables
            }
            else if (toMatch.callee == cmd.Proc.Name)
            {
                // procedure matches by name
            }
            else
            {
                //no match
                return false;
            }

            #endregion

            #region match out parameters

            //if (toMatch.Outs.Count == 1
            //    && toMatch.Outs[0].Name == BoogieKeyWords.AnyLhss)
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

            if (matchCallee != null && BoogieUtil.checkAttrExists(ExprMatchVisitor.BoogieKeyWords.AnyArgs, matchCallee.Attributes))
            {
                var anyArgsExpr = (NAryExpr) toMatch.Ins[0];


                var atLeastOneMatch = false;

                foreach (var arg in cmd.Ins)
                {
                    var emv = new ExprMatchVisitor(anyArgsExpr);
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
                    return false;
            }
            else
            {
                if (toMatch.Ins.Count != cmd.Ins.Count)
                    return false;


                for (var i = 0; i < cmd.Ins.Count; i++)
                {
                    var arg = cmd.Ins[i];

                    var emv = new ExprMatchVisitor(toMatch.Ins[i]);

                    emv.VisitExpr(arg);
                    if (emv.Matches)
                    {
                        if (substitutions.Count == 0) {
                            substitutions.Add(new Tuple<Dictionary<Declaration,Expr>,Dictionary<string,IAppliable>>(new Dictionary<Declaration,Expr>(), new Dictionary<string,IAppliable>()));
                        }
                        foreach (var kvp in emv.Substitution)
                            substitutions.First().Item1.Add(kvp.Key, kvp.Value);
                        foreach (var kvp in emv.FunctionSubstitution)
                            substitutions.First().Item2.Add(kvp.Key, kvp.Value);
                    }
                    else 
                    { 
                        return false;
                    }
                }
            }

            #endregion

            return true;
        }

        private static bool MatchPredicateCmd(PredicateCmd cmd, PredicateCmd toMatch, out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>> substitutions)
        {
            var match = false;
            substitutions = null;

            if (!ExprMatchVisitor.AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
            {
                return match;
            }

            var mv = new ExprMatchVisitor(toMatch.Expr);
            mv.VisitExpr(cmd.Expr);

            if (mv.Matches)
            {
                match = true;
                substitutions = 
                    new List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>() 
                    { new Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>(mv.Substitution, mv.FunctionSubstitution) };
            }
            return match;
        }

        private static bool MatchAssignCmd(AssignCmd cmd, AssignCmd toMatchCmd,  
           out List<Tuple<Dictionary<Declaration, Expr>, Dictionary<string, IAppliable>>>  substitutions)
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
                var lEmv = new ExprMatchVisitor(toMatchCmd.Lhss[0].AsExpr);
                lEmv.VisitExpr(lhs);

                var rhs = cmd.Rhss[i];
                var rEmv = new ExprMatchVisitor(toMatchCmd.Rhss[0]);
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
  
}
