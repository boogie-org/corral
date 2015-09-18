using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropInstUtils
{
    public class PropertyParser
    {
        private enum ReadMode { Toplevel, RuleLhs, RuleRhs, SingleItem, BoogieCode, RuleArrow };

        public static void ParseProperty(IEnumerable<string> propLines, out string templateVariables, out List<string> negativeFilters, out List<string> positiveFilters)
        {
            string globalDeclarations;
            List<Tuple<string, string, string>> ruleTriples;
            ParseProperty(propLines, out globalDeclarations, out ruleTriples, out templateVariables, out negativeFilters, out positiveFilters);
        }

        public static void ParseProperty(IEnumerable<string> propLines, out string globalDeclarations,
            out List<Tuple<string, string, string>> ruleTriples,
            out string templateVariables)
        {
            List<string> negativeFilters;
            List<string> positiveFilters;
            ParseProperty(propLines, out globalDeclarations, out ruleTriples, out templateVariables, out negativeFilters, out positiveFilters);
        }

        private static void ParseProperty(IEnumerable<string> propLines, out string globalDeclarations, out List<Tuple<string, string, string>> ruleTriples,
            out string templateVariables, out List<string> negativeFilters, out List<string> positiveFilters)
        {
            ruleTriples = new List<Tuple<string, string, string>>();
            negativeFilters = new List<string>();
            positiveFilters= new List<string>();

            templateVariables = "";
            globalDeclarations = "";

            var pCounter = 0;
            var boogieLines = "";
            var mode = ReadMode.Toplevel;
            string ruleLhs = "";
            string currentRuleOrDecl = "";

            foreach (var line1 in propLines)
            {
                var line = line1;
                // allow line comments on the top level (inside the parentheses, Boogie parsing is used anyway..)
                if (pCounter == 0 && line.Contains("//"))
                    line = line.Substring(0, line.IndexOf("//", System.StringComparison.Ordinal));

                // just skip empty lines
                if (line.Trim() == "")
                    continue;

                //deal with the curly braces that belong to the property language (not to Boogie)
                if (pCounter == 0 && line.LastIndexOf('{') != -1)
                    line = line.Substring(line.IndexOf('{') + 1);
                pCounter += CountChar(line1, '{') - CountChar(line1, '}');
                if (pCounter == 0 && line.LastIndexOf('}') != -1)
                    line = line.Substring(0, line.LastIndexOf('}'));

                switch (mode)
                {
                    case ReadMode.Toplevel:
                        currentRuleOrDecl = line.Trim();
                        switch (line.Trim())
                        {
                            case PropertyKeyWords.GlobalDeclarations:
                                mode = ReadMode.SingleItem;
                                break;
                            case PropertyKeyWords.TemplateVariables:
                                mode = ReadMode.SingleItem;
                                break;
                            case PropertyKeyWords.NegativeFilter:
                                mode = ReadMode.SingleItem;
                                break;
                            case PropertyKeyWords.PositiveFilter:
                                mode = ReadMode.SingleItem;
                                break;
                            case PropertyKeyWords.CmdRule:
                                mode = ReadMode.RuleLhs;
                                break;
                            case PropertyKeyWords.ProcedureRule:
                                mode = ReadMode.RuleLhs;
                                break;
                            default:
                                throw new Exception("ERROR: keyword " + line.Trim() + " is not known in line: " + line1);
                        }
                        break;
                    case ReadMode.RuleLhs:
                        boogieLines += line + "\n";
                        if (pCounter == 0)
                        {
                            mode = ReadMode.RuleArrow;
                            ruleLhs = boogieLines;
                            boogieLines = "";
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
                        }
                        break;
                    case ReadMode.SingleItem:
                        boogieLines += line + "\n";
                        if (pCounter == 0)
                        {
                            switch (currentRuleOrDecl)
                            {
                                case PropertyKeyWords.GlobalDeclarations:
                                    globalDeclarations = boogieLines;
                                    break;
                                case PropertyKeyWords.TemplateVariables:
                                    templateVariables = boogieLines;
                                    break;
                                case PropertyKeyWords.NegativeFilter:
                                    negativeFilters.Add(boogieLines.Trim());
                                    break;
                                case PropertyKeyWords.PositiveFilter:
                                    positiveFilters.Add(boogieLines.Trim());
                                    break;
                            }
                            mode = ReadMode.Toplevel;
                            boogieLines = "";
                        }
                        break;
                    case ReadMode.BoogieCode:
                        boogieLines += line + "\n";
                        break;
                    default:
                        throw new Exception();
                }
            }
        }

        private static int CountChar(string line, char p1)
        {
            var result = 0;
            foreach (var c in line)
                if (c == p1)
                    result++;
            return result;
        }
    }
}
