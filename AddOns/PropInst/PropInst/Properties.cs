using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using cba.Util;
using Microsoft.Boogie;

namespace PropInst
{
    class Rule
    {
        private string _lhs;
        private string _rhs;
        private string _templateDeclarations;

        public Rule(string plhs, string prhs, string pTemplateDeclarations)
        {
            _lhs = plhs;
            _rhs = prhs;
            _templateDeclarations = pTemplateDeclarations;
        }
    }

    class CmdRule : Rule
    {
        private const string CmdTemplate = "{0}\n" +
                                           "procedure {{:This}} this();" +
            //for our special keyword representing the match
                                           "procedure helperProc1() {{\n" +
                                           "  {1}" +
                                           "}}\n" +
                                           "procedure helperProc2() {{\n" +
                                           "  {2}" +
                                           "}}\n";

        public readonly List<Cmd> CmdsToMatch;

        public readonly List<Cmd> InsertionTemplate;

        private Program _prog;

        public CmdRule(string plhs, string prhs, string pDeclarations)
            : base(plhs, prhs, pDeclarations)
        {
            Program prog;
            string progString = string.Format(CmdTemplate, pDeclarations, plhs, prhs);
            Parser.Parse(progString, "dummy.bpl", out prog);
            BoogieUtil.ResolveProgram(prog, "dummy.bpl");

            CmdsToMatch = new List<Cmd>();
            CmdsToMatch.AddRange(prog.Implementations.ElementAt(0).Blocks.First().Cmds);

            InsertionTemplate = new List<Cmd>();
            InsertionTemplate.AddRange(prog.Implementations.ElementAt(1).Blocks.First().Cmds);
            _prog = prog;
        }

        //public List<Cmd> GetClonedInsertionTemplate()
        //{

        //    var toInsertClone = InsertionTemplate.Map(i => StringToBoogie.ToCmd(i.ToString()));
        //    _prog.Implementations.ElementAt(1).Blocks.Clear();
        //    _prog.Implementations.ElementAt(1).Blocks.Add(BoogieAstFactory.MkBlock(toInsertClone));
        //    //_prog.Resolve();
        //    //BoogieUtil.ResolveProgram(_prog, "dummy.bpl");
        //    BoogieUtil.ReResolve(_prog, "dummy.bpl", false);
        //    return toInsertClone;
        //}
    }

    class InsertAtBeginningRule : Rule
    {
        const string InsertAtBeginningTemplate = "{0}" +
                              "procedure helperProc() {{\n" +
                              "  {1}" +
                              "}}\n";

        public readonly List<Procedure> ProceduresToMatch;

        public readonly List<Cmd> InsertionTemplate;

        public InsertAtBeginningRule(string plhs, string prhs, string pDeclarations)
            : base(plhs, prhs, pDeclarations)
        {
            Program prog;
            string progString = pDeclarations;
            Parser.Parse(progString, "dummy.bpl", out prog);

            ProceduresToMatch = new List<Procedure>();
            ProceduresToMatch.AddRange(prog.Procedures);

            string firstProc = ProceduresToMatch.First().Name; //Convention: we refer to the first

            //TODO


            BoogieUtil.ResolveProgram(prog, "dummy.bpl");
        }
    }
    //class Prop_GlobalDec
    //{
    //    public Prop_GlobalDec(IEnumerable<string> pDecLines)
    //    {
    //        Dec = new List<Declaration>();
    //        foreach (var line in pDecLines)
    //        {
    //            Dec.Add(StringToBoogie.ToDecl(line));
    //        }
    //    }

    //    public readonly List<Declaration> Dec;

    //    public override string ToString()
    //    {
    //        return "Global Declaratio:\n" + Dec;
    //    }
    //} 


    
    //internal class Prop_InsertCodeAtCmd
    //{
    //    public readonly List<Cmd> Matches = new List<Cmd>();
    //    public readonly List<Cmd> ToInsert = new List<Cmd>();
    //    private enum ParseMode
    //    {
    //        Match, Insert, None
    //    };

    //    public Prop_InsertCodeAtCmd(IEnumerable<string> lines )
    //    {
    //        var mode = ParseMode.None;
    //        foreach (var line in lines)
    //        {
    //            switch (line.Trim())
    //            {
    //                case "match:":
    //                    mode = ParseMode.Match;
    //                    break;
    //                case "insert:":
    //                    mode = ParseMode.Insert;
    //                    break;
    //                default:
    //                    switch (mode)
    //                    {
    //                        case ParseMode.Match:
    //                            Matches.Add(StringToBoogie.ToCmd(line));
    //                            mode = ParseMode.None; //matches have exactly one line
    //                            break;
    //                        case ParseMode.Insert:
    //                            ToInsert.Add(StringToBoogie.ToCmd(line));
    //                            break;
    //                        default:
    //                            Debug.Assert(false);
    //                            break;
    //                    }
    //                    break;
    //            }
    //        }
    //    }
    //}

    //class Prop_GiveBodyToStub
    //{
    //    private enum ParseMode
    //    {
    //        Stubs, Body, None
    //    };

    //    public readonly List<Procedure> Stubs = new List<Procedure>();
    //    public readonly List<Cmd> Body = new List<Cmd>();

    //    public Prop_GiveBodyToStub(IEnumerable<string> lines )
    //    {
    //        var mode = ParseMode.None;
    //        foreach (var line in lines)
    //        {
    //            switch (line.Trim())
    //            {
    //                case "stubSignatures:":
    //                    mode = ParseMode.Stubs;
    //                    break;
    //                case "body:":
    //                    mode = ParseMode.Body;
    //                    break;
    //                default:
    //                    switch (mode)
    //                    {
    //                        case ParseMode.Stubs:
    //                            Stubs.Add(StringToBoogie.ToProcedure(line));
    //                            break;
    //                        case ParseMode.Body:
    //                            Body.Add(StringToBoogie.ToCmd(line));
    //                            break;
    //                        default:
    //                            Debug.Assert(false);
    //                            break;
    //                    }
    //                    break;
    //            }
    //        }

    //    }
    //}

    internal class Prop_InsertCodeAtProcStart
    {
        public readonly Procedure ToMatch;
        public readonly List<Cmd> ToInsert = new List<Cmd>();

        private enum ParseMode
        {
            Match,
            Insert,
            None
        };

        public Prop_InsertCodeAtProcStart(IEnumerable<string> lines)
        {
            var mode = ParseMode.None;
            foreach (var line in lines)
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
