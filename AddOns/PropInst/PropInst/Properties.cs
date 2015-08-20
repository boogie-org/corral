using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;

namespace PropInst
{

    class Prop_GlobalDec
    {
        public Prop_GlobalDec(IEnumerable<string> pDecLines)
        {
            Dec = new List<Declaration>();
            foreach (var line in pDecLines)
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
        public readonly List<Cmd> Matches = new List<Cmd>();
        public readonly List<Cmd> ToInsert = new List<Cmd>();
        private enum ParseMode
        {
            Match, Insert, None
        };

        public Prop_InsertCodeAtCmd(IEnumerable<string> lines )
        {
            var mode = ParseMode.None;
            foreach (var line in lines)
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
                                Matches.Add(StringToBoogie.ToCmd(line));
                                mode = ParseMode.None; //matches have exactly one line
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

    class Prop_GiveBodyToStub
    {
        private enum ParseMode
        {
            Stubs, Body, None
        };

        public readonly List<Procedure> Stubs = new List<Procedure>();
        public readonly List<Cmd> Body = new List<Cmd>();

        public Prop_GiveBodyToStub(IEnumerable<string> lines )
        {
            var mode = ParseMode.None;
            foreach (var line in lines)
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

        public Prop_InsertCodeAtProcStart(IEnumerable<string> lines )
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
