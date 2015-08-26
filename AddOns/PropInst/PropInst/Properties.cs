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

        // we need to use the implementation for matching, because the variable declaration of the 
        // parameter occurences in the body (rhs of the rule) refer to those of the implementation, not
        // declaration of the procedure
        public readonly Dictionary<Implementation, List<Cmd>> ProcedureToMatchToInsertion;

        public InsertAtBeginningRule(string plhs, string prhs, string globalDecls)
            : base(plhs, prhs, globalDecls)
        {
            //ProcedureToMatchToInsertion = new Dictionary<Procedure, List<Cmd>>();
            ProcedureToMatchToInsertion = new Dictionary<Implementation, List<Cmd>>();

            //bit hacky: we need to get the delcaration code for each procedure..
            // .. and we want them preferably without the semicolon..
            var procStrings = new List<string>((plhs.Split(new char[] {';'})));
            procStrings.RemoveAt(procStrings.Count - 1);

            //we need a separate insertion for every progstring because the IdentifierExpression pointing
            // to one of the parameters must refer to the declaration in the procedure declaration..
            foreach (var procString in procStrings)
            {
                Program prog;
                string progString = globalDecls +  procString + "{\n" + prhs + "\n}";
                Parser.Parse(progString, "dummy.bpl", out prog);
                BoogieUtil.ResolveProgram(prog, "dummy.bpl");

                ProcedureToMatchToInsertion.Add(prog.Implementations.First(), prog.Implementations.First().Blocks.First().Cmds);
            }
        }
    }
}
