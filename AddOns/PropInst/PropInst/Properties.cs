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
            //for our special keyword representing the match:
                                           "procedure {{:This}} #this();" +
                                           "procedure helperProc1() {{\n" +
                                           "  {1}" +
                                           "}}\n" +
                                           "procedure helperProc2() {{\n" +
                                           "  {2}" +
                                           "}}\n";

        public readonly List<Cmd> CmdsToMatch;

        public readonly List<Cmd> InsertionTemplate;

        public Program Prog;

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
            Prog = prog;
        }
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
