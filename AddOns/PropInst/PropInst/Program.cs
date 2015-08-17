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
                            var globDec = new Prop_GlobalDec(instructionData);
                            globalDecs.Add(globDec);
                            Console.WriteLine("added global declaration:");
                            Console.WriteLine(globDec);
                        }
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
                                new List<Variable>(),  //local variables not necessary for now, may be part of the body in the future
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

                var fpv = new FindIdentifiersVisitor();
                fpv.VisitCmdSeq(_property.ToInsert);
                if (fpv.Identifiers.Exists(i => i.Name == "##ANYPARAMS"))
                {
                    IdentifierExpr anyP = fpv.Identifiers.First(i => i.Name == "##ANYPARAMS");
                    for (int i = 0; i < impl.InParams.Count; i++)
                    {
                        var p = impl.InParams[i];
                        // If attributes for the ##anyparams in the toMatch are given, we only insert code for those parameters of impl 
                        // with matching (subset) attributes
                        if (psm.ToMatchAnyParamsAttributes == null
                            || Driver.AreAttributesASubset(psm.ToMatchAnyParamsAttributes, p.Attributes)
                            || Driver.AreAttributesASubset(psm.ToMatchAnyParamsAttributes, impl.Proc.InParams[i].Attributes))
                        {
                            var id = new IdentifierExpr(Token.NoToken, p.Name, p.TypedIdent.Type, immutable: true);
                            var substitution = new Dictionary<IdentifierExpr, Expr> { { anyP, id } };
                            var sv = new SubstitionVisitor(substitution);
                            var toInsertClone = _property.ToInsert.Map(x => StringToBoogie.ToCmd(x.ToString()));//hack to get a deepcopy
                            //var toInsertClone = BoogieAstFactory.CloneCmdSeq(_property.ToInsert);//does not seem to work as I expect..
                            var newCmds = sv.VisitCmdSeq(toInsertClone);
                            impl.Blocks.Insert(0, BoogieAstFactory.MkBlock(newCmds, BoogieAstFactory.MkGotoCmd(impl.Blocks.First().Label)));
                        }
                    }
                }
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
                    //var toInsertClone = BoogieAstFactory.CloneCmdSeq(_propInsertCodeAtCmd.ToInsert);//does not seem to work as I expect..
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
            for (; left != null; left = left.Next)//TODO: make a reference copy of left to work on??
            {
                if (!BoogieUtil.checkAttrExists(left.Key, right))
                {
                    return false;
                }
            }
            return true;
        }
    }



}
