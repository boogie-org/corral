using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
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
        private static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("usage: blabla");
                return;
            }

            var globalDecs = new List<GlobalDec>();
            var insertions = new List<Insertion>();
            var giveBodyToStubs = new List<GiveBodyToStub>();

            #region parse the property file

            var propString = System.IO.File.ReadAllText(args[0]);
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
                        insertions.Add(new Insertion(instructionData));
                        break;
                    case "giveBodyToStub:":
                        giveBodyToStubs.Add(new GiveBodyToStub(instructionData));
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

                        if (Matches(toMatchStub, boogieStub))
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

            //Property: find insertions sites (Commands), insert code there
            InstrumentInsertion.Instrument(boogieProgram, insertions.First());



            // write the output
            BoogieUtil.PrintProgram(boogieProgram, "result.bpl");
        }


        private class InstrumentInsertion
        {
            private Insertion _insertion;
            private InstrumentInsertion(Insertion ins)
            {
                _insertion = ins;
            }


            public static void Instrument(Program program, Insertion ins)
            {
                var im = new InstrumentInsertion(ins);

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
                        //else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                        //if (cmd.GetType() == _insertion.GetType())
                        //{
                        //    newcmds.AddRange(ProcessCmd(cmd));
                        //}
                        else newcmds.Add(cmd);
                    }
                    block.Cmds = newcmds;
                }

            }
                        private List<Cmd> ProcessCall(CallCmd cmd)
            {
                var ret = new List<Cmd>();

                //var gm = new GatherMemAccesses();
                //var gm = null
                //cmd.Ins.Where(e => e != null).Iter(e => gm.VisitExpr(e));

                //foreach (var tup in gm.accesses)
                //{
                //    ret.Add(MkAssert(tup.Item2));
                //}
                //ret.Add(cmd);

                return ret;
            }

            private List<Cmd> ProcessAssume(AssumeCmd cmd)
            {
                var ret = new List<Cmd>();

                var toMatch = _insertion.Match as AssumeCmd;

                //check if the attributes in the match are a subset of the attributs in cmd
                var matches = true;
                var attr = toMatch.Attributes;
                for (; attr != null; attr = attr.Next)
                {
                    if (!BoogieUtil.checkAttrExists(attr.Key, cmd.Attributes))
                    {
                        return new List<Cmd>() { cmd }; //no subset --> do nothing
                    }
                }





                //check if the Expression matches
                MatchVisitor mv = new MatchVisitor(new List<Expr>() { toMatch.Expr });
                mv.VisitExpr(cmd.Expr);

                if (mv.MayStillMatch)
                {
                    var sv = new SubstitionVisitor(mv.Substitution);

                    ret.AddRange(sv.VisitCmdSeq(_insertion.ToInsert));

                    //make hashtable with variables..
                    //var ht = new Dictionary<Variable, Expr>();

                    //foreach (var p in mv.Substitution)
                    //{
                    //    string varDecStr = string.Format("var {0} : int;", p.Key.Name);
                    //    var vd = Driver.ToVariable(varDecStr);
                    //    ht.Add(vd, p.Value);
                    //}

                    //var sub = Substituter.SubstitutionFromHashtable(ht);

                    //foreach (var c in _insertion.ToInsert)
                    //{
                    //    ret.Add(Substituter.Apply(sub, c));
                    //}



                }

                //var gm = new GatherMemAccesses();
                //gm.VisitExpr(cmd.Expr);
                //foreach (var tup in gm.accesses)
                //{
                //    ret.Add(MkAssert(tup.Item2));
                //}
                //ret.Add(cmd);
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

                //var reads = new GatherMemAccesses();

                //cmd.Lhss.Iter(e => reads.VisitExpr(e.AsExpr));
                //cmd.Rhss.Iter(e => reads.VisitExpr(e));
                //foreach (var tup in reads.accesses)
                //{
                //    ret.Add(MkAssert(tup.Item2));
                //}

                //ret.Add(cmd);

                ret.Add(cmd);
                return ret;
            }
        }

        class SubstitionVisitor : FixedVisitor
        {
            private Dictionary<IdentifierExpr, IdentifierExpr> sub;
            public SubstitionVisitor(Dictionary<IdentifierExpr, IdentifierExpr> psub)
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

        class MatchVisitor : FixedVisitor
        {
            private List<Expr> _toConsume;
            public bool MayStillMatch = true;
            public readonly Dictionary<IdentifierExpr, IdentifierExpr> Substitution = new Dictionary<IdentifierExpr, IdentifierExpr>();

            public MatchVisitor(List<Expr> pToConsume)
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


            public override Expr VisitExpr(Expr node)
            {
                return base.VisitExpr(node);
            }
        }

        private static bool Matches(Procedure toMatchStub, Procedure boogieStub)
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
            //for (int i = 0; i < toMatchStub.InParams.Count; i++)
            //{
            //    var p = toMatchStub.InParams[i];
            //    if (p.Name.StartsWith("##"))
            //    {
            //        paramsToSubstitute.Add(p, boogieStub.InParams[i]);
            //    }
            //}
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

        public static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }

        public static Cmd ToCmd(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo() {{ {0} }}", str);
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

    class GlobalDec
    {
        public GlobalDec(string pDec)
        {
            Dec = new List<Declaration>();
            foreach (var line in pDec.Split(new char[] { '\n' }))
            {
                Dec.Add(Driver.ToDecl(line));
            }
        }

        public readonly List<Declaration> Dec;

        public override string ToString()
        {
            return "Global Declaratio:\n" + Dec;
        }
    }

    internal class Insertion
    {
        public readonly Cmd Match;
        public readonly List<Cmd> ToInsert = new List<Cmd>();
        private enum ParseMode
        {
            Match, Insert, None
        };

        public Insertion(string s)
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
                                Match = Driver.ToCmd(line);
                                break;
                            case ParseMode.Insert:
                                ToInsert.Add(Driver.ToCmd(line));
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
                                Stubs.Add(Driver.ToProcedure(line));
                                break;
                            case ParseMode.Body:
                                Body.Add(Driver.ToCmd(line));
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
