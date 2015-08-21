using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.ExceptionServices;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;

namespace PropInst
{
    internal class Driver
    {
        public HashSet<IToken> ProcsThatHaveBeenInstrumented = new HashSet<IToken>();

        private static void Main(string[] args)
        {
            if (args.Length < 3)
            {
                Console.WriteLine("usage: PropInst.exe propertyFile.avp boogieInputFile.bpl boogieOutputFile.bpl");
                return;
            }

            var globalDecs = new List<Prop_GlobalDec>();
            var insertionsAtCmd = new List<Prop_InsertCodeAtCmd>();
            var giveBodyToStubs = new List<Prop_GiveBodyToStub>();
            var insertionsAtProcStart = new List<Prop_InsertCodeAtProcStart>();

            #region parse the property file

            var propString = File.ReadAllText(args[0]);
            var singleInstructions = propString.Split(new string[] {Constants.RuleSeparator}, StringSplitOptions.None);
            foreach (var s in singleInstructions)
            {
                var instruction = s.Trim();
                var lines = instruction.Split(new char[] {'\n'}, 2);

                var instructionType = lines[0].Trim();
                var instructionData = lines[1].Split(new char[] {'\n'}).Where(line => !(line.StartsWith("//") || line.Trim() == ""));

                switch (instructionType)
                {
                    case "globalDec:":
                        globalDecs.Add(new Prop_GlobalDec(instructionData));
                        break;
                    case "insertionBefore:":
                        insertionsAtCmd.Add(new Prop_InsertCodeAtCmd(instructionData));
                        break;
                    case "giveBodyToStub:":
                        giveBodyToStubs.Add(new Prop_GiveBodyToStub(instructionData));
                        break;
                    case "insertCodeAtProcedureStart:":
                        insertionsAtProcStart.Add(new Prop_InsertCodeAtProcStart(instructionData));
                        break;
                }

            }

            #endregion

            #region initialize Boogie, parse input boogie program

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            var boogieProgram = BoogieUtil.ReadAndResolve(args[1], false);

            #endregion

            //Property: insert global declarations
            globalDecs.Iter(gd => boogieProgram.AddTopLevelDeclarations(gd.Dec));

            #region Property: replace stubs with implementations

            var toReplace = new Dictionary<Procedure, List<Declaration>>();
            foreach (var boogieStub in boogieProgram.TopLevelDeclarations.OfType<Procedure>())
            {
                foreach (var gbts in giveBodyToStubs)
                {
                    foreach (var toMatchStub in gbts.Stubs)
                    {
                        if (MatchStubs(toMatchStub, boogieStub))
                        {
                            var newProc = BoogieAstFactory.MkImpl(
                                boogieStub.Name,
                                toMatchStub.InParams, //just take the names that match the body..
                                toMatchStub.OutParams, //just take the names that match the body..
                                new List<Variable>(),
                                //local variables not necessary for now, may be part of the body in the future
                                gbts.Body);

                            toReplace.Add(boogieStub, newProc);
                        }
                    }
                }
            }
            foreach (var kvp in toReplace)
            {
                boogieProgram.RemoveTopLevelDeclaration(kvp.Key);
                boogieProgram.AddTopLevelDeclarations(kvp.Value);
            }

            #endregion

            // Property: find insertions sites (Commands), insert code there
            insertionsAtCmd.Iter(i => InstrumentInsertionAtCmd.Instrument(boogieProgram, i));

            //Property: find insertion sites (Procedures), insert code there
            insertionsAtProcStart.Iter(i => InstrumentInsertionAtProc.Instrument(boogieProgram, i));


            // write the output
            var outputFile = args[2];
            BoogieUtil.PrintProgram(boogieProgram, outputFile);
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
        private Prop_InsertCodeAtProcStart _property;

        public InstrumentInsertionAtProc(Prop_InsertCodeAtProcStart pins)
        {
            _property = pins;
        }

        private static HashSet<IToken> _procsThatHaveBeenInstrumented = new HashSet<IToken>();

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
                        var substitution = new Dictionary<IdentifierExpr, Expr> { { anyP, id } };
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
        private readonly Prop_InsertCodeAtCmd _propInsertCodeAtCmd;
        private readonly Program _program; // exists for debugging purposes

        private InstrumentInsertionAtCmd(Prop_InsertCodeAtCmd ins, Program prog)
        {
            _propInsertCodeAtCmd = ins;
            _program = prog;
        }

        public static void Instrument(Program program, Prop_InsertCodeAtCmd ins)
        {
            var im = new InstrumentInsertionAtCmd(ins, program);

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
                //Debug.Assert(BoogieUtil.ResolveProgram(_program, "C:\\Users\\t-alnu\\Desktop\\try\\out.bpl"));
                //Debug.Assert(BoogieUtil.ReResolve(_program) != null);
                //Debug.Assert(BoogieUtil.TypecheckProgram(_program, "C:\\Users\\t-alnu\\Desktop\\try\\out.bpl"));
                //BoogieUtil.ReResolve(_program);
                //BoogieUtil.PrintProgram(_program, "C:\\Users\\t-alnu\\Desktop\\try\\out.bpl");
            }
        }

        private List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            foreach (var m in _propInsertCodeAtCmd.Matches)
            {
                if (!(m is CallCmd))
                    continue;
                var toMatch = (CallCmd) m;

                var identifierSubstitution = new Dictionary<IdentifierExpr, Expr>();
                var functionSubstitution = new Dictionary<string, IAppliable>();
                var substitution = new Dictionary<IdentifierExpr, Expr>();

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
                    && toMatch.Outs[0].Name == Constants.AnyResults)
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

                    List<Expr> matchingExprs = new List<Expr>();

                    foreach (var arg in cmd.Ins)
                    {
                        //List<Cmd> ret = new List<Cmd>();

                        var toMatchNae = anyArgsExpr;

                        Debug.Assert(toMatchNae.Args.Count == 1,
                            "we expect Constants.AnyArgs to have at most one argument, " +
                            "which is the matching pattern expression");
                        if (toMatchNae.Args[0] is NAryExpr
                            && ((NAryExpr)toMatchNae.Args[0]).Fun.FunctionName == Constants.MemAccess)
                        {
                            //special case: we want to match anything that is a memory access 
                            //i.e. someting like MemT.sometypename[someExpression]
                            //and get out someExpression
                            //TODO: this is the current case --> generalize such that someExpression may be a complex match, too??
                            var memAccessExpr = (NAryExpr)toMatchNae.Args[0];

                            Debug.Assert(memAccessExpr.Args.Count == 1);
                            //TODO above --> generalize to other matches..");

                            var memAccessToMatchExpr = memAccessExpr.Args[0];

                            var gma = new GatherMemAccesses();
                            gma.Visit(arg);

                            if (gma.accesses.Count == 0)
                            {
                                // there's no memory access in this argument --> do nothing for it
                                return ret;
                            }

                            // we have a memory access
                            foreach (var access in gma.accesses)
                            {
                                var emv = new ExprMatchVisitor(new List<Expr>() { memAccessToMatchExpr });
                                emv.Visit(access.Item2);

                                // here we have all we need to make a new command:
                                // for each arg of the anyargs, for each memoryAccess in that arg:
                                // instantiate the ToInsert accordingly
                                if (emv.MayStillMatch)
                                {

                                    identifierSubstitution = MergeSubstitutions(emv.IdentifierSubstitution, identifierSubstitution);
                                    functionSubstitution = MergeSubstitutions(emv.FunctionSubstitution, functionSubstitution);
                                    substitution = MergeSubstitutions(emv.Substitution, substitution);
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
                #endregion

                //hack to get a deepcopy
                var toInsertClone = _propInsertCodeAtCmd.ToInsert.Map(i => StringToBoogie.ToCmd(i.ToString()));
                var sv = new SubstitionVisitor(identifierSubstitution, functionSubstitution, substitution); 
                ret.AddRange(sv.VisitCmdSeq(toInsertClone));
            }
            ret.Add(cmd);
            return ret;
        }

        private Dictionary<string, IAppliable> MergeSubstitutions(Dictionary<string, IAppliable> sub1, Dictionary<string, IAppliable> sub2)
        {
            var result = new Dictionary<string, IAppliable>();
            foreach (var kvp in sub1)
            {
                result.Add(kvp.Key, kvp.Value);
            }
            foreach (var kvp in sub2)
            {
                result.Add(kvp.Key, kvp.Value);
            }
            return result;
        }

        private Dictionary<IdentifierExpr, Expr> MergeSubstitutions(Dictionary<IdentifierExpr, Expr> sub1, Dictionary<IdentifierExpr, Expr> sub2)
        {
            var result = new Dictionary<IdentifierExpr, Expr>();
            foreach (var kvp in sub1)
            {
                result.Add(kvp.Key, kvp.Value);
            }
            foreach (var kvp in sub2)
            {
                result.Add(kvp.Key, kvp.Value);
            }
            return result;
        }


        private List<Cmd> ProcessAssume(AssumeCmd cmd)
        {
            var ret = new List<Cmd>();

            //var toMatchNae = (AssumeCmd) _propInsertCodeAtCmd.Match;
            foreach (var m in _propInsertCodeAtCmd.Matches)
            {
                if (!(m is AssumeCmd))
                    continue;
                var toMatch = (AssumeCmd)m;

                if (!Driver.AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
                    continue;
                //return new List<Cmd>() {cmd}; //not all attributs of toMatchNae are in cmd --> do nothing

                //check if the Expression matches
                var mv = new ExprMatchVisitor(new List<Expr>() { toMatch.Expr });
                mv.VisitExpr(cmd.Expr);

                if (mv.MayStillMatch)
                {
                    var sv = new SubstitionVisitor(mv.IdentifierSubstitution);
                    //hack to get a deepcopy
                    var toInsertClone = _propInsertCodeAtCmd.ToInsert.Map(i => StringToBoogie.ToCmd(i.ToString()));
                    //var toInsertClone = BoogieAstFactory.CloneCmdSeq(_propInsertCodeAtCmd.ToInsert);//does not seem to work as I expect..
                    ret.AddRange(sv.VisitCmdSeq((List<Cmd>)toInsertClone));
                }

            }
            ret.Add(cmd);
            return ret;
        }

        private List<Cmd> ProcessAssert(AssertCmd cmd)
        {
            var ret = new List<Cmd>();

            ret.Add(cmd);
            return ret;
        }

        private List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();
            foreach (var m in _propInsertCodeAtCmd.Matches)
            {
                if (!(m is AssignCmd))
                    continue;
                var toMatchCmd = (AssignCmd) m;

                Debug.Assert(toMatchCmd.Lhss.Count == 1, "--> have to adapt to multi-assignments..");
                var toMatchLhs = toMatchCmd.Lhss.First().AsExpr;
                var toMatchRhs = toMatchCmd.Rhss.First();

                Debug.Assert(cmd.Lhss.Count == 1, "--> have to adapt to multi-assignments..");
                //var lhsEmv = new ExprMatchVisitor(new List<Expr>() { toMatchLhs});
                //lhsEmv.VisitExpr(cmd.Lhss.First().AsExpr);
                //var rhsEmv = new ExprMatchVisitor(new List<Expr>() { toMatchRhs});
                //rhsEmv.VisitExpr(cmd.Rhss.First());

            }


            ret.Add(cmd);
            return ret;
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
        public const string AnyResults = "$$ANYRESULTS";
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
