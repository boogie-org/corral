using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.ExceptionServices;
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
            if (args.Length < 2)
            {
                Console.WriteLine("usage: blabla");
                return;
            }

            var globalDecs = new List<GlobalDec>();
            var insertionsAtCmd = new List<Prop_InsertCodeAtCmd>();
            var giveBodyToStubs = new List<GiveBodyToStub>();
            var insertionsAtProcStart = new List<Prop_InsertCodeAtProcStart>();

            #region parse the property file

            var propString = File.ReadAllText(args[0]);
            var singleInstructions = propString.Split(new string[] { "####" }, StringSplitOptions.None);
            foreach (var s in singleInstructions)
            {
                var instruction = s.Trim();
                var lines = instruction.Split(new char[] { '\n' }, 2);

                var instructionType = lines[0].Trim();
                var instructionData = lines[1].Trim();


                switch (instructionType)
                {
                    case "globalDec:":
                        {
                            var globDec = new GlobalDec(instructionData);
                            globalDecs.Add(globDec);
                            Console.WriteLine("added global declaration:");
                            Console.WriteLine(globDec);
                        }
                        break;
                    case "insertionBefore:":
                        insertionsAtCmd.Add(new Prop_InsertCodeAtCmd(instructionData));
                        break;
                    case "giveBodyToStub:":
                        giveBodyToStubs.Add(new GiveBodyToStub(instructionData));
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

            #region Property: insert global declarations

            foreach (var gd in globalDecs)
            {
                boogieProgram.AddTopLevelDeclarations(gd.Dec);
            }

            #endregion

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

            #region Property: find insertions sites (Commands), insert code there
            //InstrumentInsertionAtCmd.Instrument(boogieProgram, insertions.First());
            insertionsAtCmd.Iter(i => InstrumentInsertionAtCmd.Instrument(boogieProgram, i));
            #endregion

            //Property: find insertion sites (Procedures), insert code there

            
            insertionsAtProcStart.Iter(i => InstrumentInsertionAtProc.Instrument(boogieProgram, i));


            // write the output
            BoogieUtil.PrintProgram(boogieProgram, "result.bpl");
        }
        private class InstrumentInsertionAtProc
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

                var fpv = new FindParamsVisitor();
                fpv.VisitCmdSeq(_property.ToInsert);
                IdentifierExpr anyP = fpv.Idexs.First(i => i.Name == "##ANYPARAMS");
                if (anyP != null)
                {
                    foreach (var p in impl.InParams)
                    {
                        var id = new IdentifierExpr(Token.NoToken, p.Name, p.TypedIdent.Type, immutable: true);
                        var substitution = new Dictionary<IdentifierExpr, Expr> {{anyP, id}};
                        var sv = new SubstitionVisitor(substitution);
                        var toInsertClone = _property.ToInsert.Map(i => StringToBoogie.ToCmd(i.ToString()));//hack to get a deepcopy
                        var newCmds = sv.VisitCmdSeq(toInsertClone);
                        impl.Blocks.Insert(0, BoogieAstFactory.MkBlock(newCmds));
                    }
                }
            }
        }

        class FindParamsVisitor : FixedVisitor
        {
            public List<IdentifierExpr> Idexs = new List<IdentifierExpr>();
            public override Expr VisitIdentifierExpr(IdentifierExpr node)
            {
                Idexs.Add(node);
                return base.VisitIdentifierExpr(node);
            }
        }

        private class InstrumentInsertionAtCmd
        {
            private readonly Prop_InsertCodeAtCmd _propInsertCodeAtCmd;
            private InstrumentInsertionAtCmd(Prop_InsertCodeAtCmd ins)
            {
                _propInsertCodeAtCmd = ins;
            }

            public static void Instrument(Program program, Prop_InsertCodeAtCmd ins)
            {
                var im = new InstrumentInsertionAtCmd(ins);

                program.TopLevelDeclarations
                    .OfType<Implementation>()
                    .Iter(im.Instrument);

                //program.AddTopLevelDeclarations(im.aliasQfuncs);
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

                return ret;
            }

            private List<Cmd> ProcessAssume(AssumeCmd cmd)
            {
                var ret = new List<Cmd>();

                var toMatch = (AssumeCmd) _propInsertCodeAtCmd.Match;

                if (!AreAttributesASubset(toMatch.Attributes, cmd.Attributes))
                    return new List<Cmd>() { cmd }; //not all attributs of toMatch are in cmd --> do nothing

                //check if the Expression matches
                var mv = new ExprMatchVisitor(new List<Expr>() { toMatch.Expr });
                mv.VisitExpr(cmd.Expr);

                if (mv.MayStillMatch)
                {
                    var sv = new SubstitionVisitor(mv.Substitution);
                    var toInsertClone = _propInsertCodeAtCmd.ToInsert.Map(i => StringToBoogie.ToCmd(i.ToString()));//hack to get a deepcopy
                    ret.AddRange(sv.VisitCmdSeq((List<Cmd>) toInsertClone));
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



                ret.Add(cmd);
                return ret;
            }
        }

        class SubstitionVisitor : FixedVisitor
        {
            private readonly Dictionary<IdentifierExpr, Expr> sub;
            public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub)
            {
                sub = psub;
            }

            public override Expr VisitIdentifierExpr(IdentifierExpr node)
            {
                if (sub.ContainsKey(node))
                {
                    var replacement = sub[node];
                    return replacement;
                }
                return base.VisitIdentifierExpr(node);
            }
        }

        class ExprMatchVisitor : FixedVisitor
        {
            private List<Expr> _toConsume;
            public bool MayStillMatch = true;
            public readonly Dictionary<IdentifierExpr, Expr> Substitution = new Dictionary<IdentifierExpr, Expr>();

            public ExprMatchVisitor(List<Expr> pToConsume)
            {
                _toConsume = pToConsume;
            }

            public override Expr VisitNAryExpr(NAryExpr node)
            {
                var nae = _toConsume.First() as NAryExpr;
                if (MayStillMatch 
                    && _toConsume.Count > 0  
                    && nae != null
                    && nae.Fun.Equals(node.Fun))
                {
                    _toConsume = new List<Expr>(nae.Args);
                }
                else
                {
                    MayStillMatch = false;
                }
                return base.VisitNAryExpr(node);
            }

            public override Expr VisitIdentifierExpr(IdentifierExpr node)
            {
                var idex = _toConsume.First() as IdentifierExpr;
                if (MayStillMatch 
                    && _toConsume.Count > 0 
                    && idex != null
                    && (idex.Name.StartsWith("##") || idex.Name == node.Name))
                {
                    if (idex.Name.StartsWith("##"))
                        Substitution.Add(idex, node);
                    _toConsume.RemoveAt(0);
                }
                else
                {
                    MayStillMatch = false;
                }
                return base.VisitIdentifierExpr(node);
            }
        }

        private static bool MatchStubs(Procedure toMatchStub, Procedure boogieStub)
        {
            //paramsToSubstitute = new Dictionary<Variable, Variable>();
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
            for (; left != null; left = left.Next)//TODO: make a reference copy of left to work on??
            {
                if (!BoogieUtil.checkAttrExists(left.Key, right))
                {
                    return false;
                }
            }
            return true;
        }

        /* public static string[] GetStringInOuterMostParentheses(string s)
        {
            //var result = new string[2];
            var counter = 0;
            var strInParen = "";
            var rest = "";
            var sawFirstOpenPar = false;
            var finishedStrInParen = false;
            foreach (var c in s)
            {
                if (finishedStrInParen)
                {
                    rest += c;
                    continue;
                }
                switch (c)
                {
                    case '{':
                        if (!sawFirstOpenPar){
                            sawFirstOpenPar = true;
                        }
                        else {
                            strInParen += c;
                            counter++;
                        }
                        break;
                    case '}':
                        if (counter > 0)
                        {
                            strInParen += c;
                            counter--;
                        }
                        else
                        {
                            finishedStrInParen = true;
                            //return strInParen;
                        }
                        break;
                    default:
                        if (sawFirstOpenPar)
                        {
                            strInParen += c;
                        }
                        break;
                }
            }
            return new string[] { strInParen, rest };
        }*/
    }

    internal class ProcedureSigMatcher
    {
        private Procedure _toMatch;
        private Implementation _impl;

        public ProcedureSigMatcher(Procedure toMatch, Implementation impl)
        {
            _impl = impl;
            _toMatch = toMatch;
        }

        public bool MatchSig()
        {

            if (!Driver.AreAttributesASubset(_toMatch.Attributes, _impl.Attributes))
                return false;

            if (_toMatch.Name.StartsWith("##"))
            {

            }
            else if (_toMatch.Name != _impl.Name)
            {
                return false;
            }


            if (_toMatch.InParams.Count == 1 && _toMatch.InParams[0].Name == "##ANYPARAMS")
            {
                
            }
            else if (_toMatch.InParams.Count != _impl.InParams.Count)
            {
                return false;
            }
            else
            {
                for (int i = 0; i < _toMatch.InParams.Count; i++)
                {
                    if (_toMatch.InParams[i].GetType() != _impl.InParams[i].GetType())
                        return false;
                }
            }

            if (_toMatch.OutParams.Count == 1 && _toMatch.OutParams[0].Name == "##ANYPARAMS")
            {
                
            }
            else if (_toMatch.OutParams.Count != _impl.OutParams.Count)
                return false;
            return true;
        }
    }

    class GlobalDec
    {
        public GlobalDec(string pDec)
        {
            Dec = new List<Declaration>();
            foreach (var line in pDec.Split(new char[] { '\n' }))
            {
                Dec.Add(StringToBoogie.ToDecl(line));
            }
        }

        public readonly List<Declaration> Dec;

        public override string ToString()
        {
            return "Global Declaratio:\n" + Dec;
        }
    }

    internal class Prop_InsertCodeAtCmd
    {
        public readonly Cmd Match;
        public readonly List<Cmd> ToInsert = new List<Cmd>();
        private enum ParseMode
        {
            Match, Insert, None
        };

        public Prop_InsertCodeAtCmd(string s)
        {
            var mode = ParseMode.None;
            foreach (var line in s.Split('\n'))
            {
                switch (line.Trim())
                {
                    case "match:":
                        mode = ParseMode.Match;
                        break;
                    case "insert:":
                        mode = ParseMode.Insert;
                        break;
                    default:
                        switch (mode)
                        {
                            case ParseMode.Match:
                                Debug.Assert(Match == null);
                                Match = StringToBoogie.ToCmd(line);
                                break;
                            case ParseMode.Insert:
                                ToInsert.Add(StringToBoogie.ToCmd(line));
                                break;
                            default:
                                Debug.Assert(false);
                                break;
                        }
                        break;
                }
            }
        }
    }

    class GiveBodyToStub
    {
        private enum ParseMode
        {
            Stubs, Body, None
        };

        public readonly List<Procedure> Stubs = new List<Procedure>();
        public readonly List<Cmd> Body = new List<Cmd>();

        public GiveBodyToStub(string s)
        {
            var mode = ParseMode.None;
            foreach (var line in s.Split('\n'))
            {
                switch (line.Trim())
                {
                    case "stubSignatures:":
                        mode = ParseMode.Stubs;
                        break;
                    case "body:":
                        mode = ParseMode.Body;
                        break;
                    default:
                        switch (mode)
                        {
                            case ParseMode.Stubs:
                                Stubs.Add(StringToBoogie.ToProcedure(line));
                                break;
                            case ParseMode.Body:
                                Body.Add(StringToBoogie.ToCmd(line));
                                break;
                            default:
                                Debug.Assert(false);
                                break;
                        }
                        break;
                }
            }

        }
    }

    class Prop_InsertCodeAtProcStart
    {
        public readonly Procedure ToMatch;
        public readonly List<Cmd> ToInsert = new List<Cmd>();
        private enum ParseMode
        {
            Match, Insert, None
        };

        public Prop_InsertCodeAtProcStart(string s)
        {
            var mode = ParseMode.None;
            foreach (var line in s.Split('\n'))
            {
                switch (line.Trim())
                {
                    case "procedureSignature:":
                        mode = ParseMode.Match;
                        break;
                    case "code:":
                        mode = ParseMode.Insert;
                        break;
                    default:
                        switch (mode)
                        {
                            case ParseMode.Match:
                                Debug.Assert(ToMatch == null);
                                ToMatch = StringToBoogie.ToProcedure(line);
                                break;
                            case ParseMode.Insert:
                                ToInsert.Add(StringToBoogie.ToCmd(line));
                                break;
                            default:
                                Debug.Assert(false);
                                break;
                        }
                        break;
                }
            }
        }
    }
}
