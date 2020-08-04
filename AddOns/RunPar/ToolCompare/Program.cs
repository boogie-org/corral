using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;
using CommonLib;

namespace ToolCompare
{
    class Program
    {
        public static int toolSelect = -1;
        public static string bplfile;

        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: generator file.[c|bpl]");
                return;
            }

            for (int i = 0; i < args.Count(); i++)
                ProcessArg(args[i]);

            string SI_flags = "/stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes";
            string Duality_flags = "/z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes";
            string Tool_flags = "/z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes";

            var timeout = 2000;

            var root = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            var wlimitexe = Path.Combine(root, "wlimit.exe");
            string SI_exe = Path.Combine(root, "..", "boogie1", "boogie.exe");
            string Duality_exe = SI_exe;
            string Tool_exe = Path.Combine(root, "..", "boogie2", "boogie.exe");

            var output = new StreamWriter("RunCompareOutput.txt");

            string filename = System.IO.Path.GetFileName(args[0]);
            string execution_output = "";

            if (toolSelect == 1)
            {
                ///////////// SI Run /////////////////////////////////

                var result1 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, SI_exe, SI_flags, args[0]));

                result1.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result1);
            }
            else if (toolSelect == 2)
            {
                ///////////// Duality Run /////////////////////////////////

                var result2 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Duality_exe, Duality_flags, args[0]));

                result2.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result2);
            }
            else if (toolSelect == 3)
            {
                ///////////// Tool-Single Threaded Run /////////////////////////////////

                var result3 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Tool_exe, " /configSetting:2 " + Tool_flags, args[0]));

                result3.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result3);
            }
            else if (toolSelect == 4)
            {
                ///////////// Tool-Multi Threaded Run /////////////////////////////////

                var result4 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Tool_exe, " /configSetting:8 " + Tool_flags, args[0]));

                result4.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result4);
            }
            else if (toolSelect == 5)
            {
                ///////////// Tool-Multi Threaded Run /////////////////////////////////

                var result4 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Tool_exe, " /configSetting:4 " + Tool_flags, args[0]));

                result4.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result4);
            }
            else if (toolSelect == 6)
            {
                ///////////// Tool-Multi Threaded Run /////////////////////////////////

                var result4 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Tool_exe, " /configSetting:6 " + Tool_flags, args[0]));

                result4.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result4);
            }
            else if (toolSelect == 7)
            {
                ///////////// Tool-Multi Threaded Run /////////////////////////////////

                var result4 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2} {3}", timeout, Tool_exe, " /configSetting:7 " + Tool_flags, args[0]));

                result4.Iter(s => output.WriteLine("{0}", s));
                execution_output = parseDualityOutput(result4);
            }
            else
            {
                execution_output = "Wrong choice";
            }

            ///////////// Output Results ///////////////////////////////////////////

            Console.WriteLine("{0}", execution_output);

            output.Close();
        }

        public static string parseDualityOutput(IEnumerable<string> lines)
        {
            //Regex corralTime = new Regex(">>> Finished implementation verification   \x5b(.*) s\x5d");
            Regex corralTime = new Regex(">>> Finished implementation verification(.*)");
            //Regex houdiniTime = new Regex("Houdini took (.*) seconds");
            //Regex siTime = new Regex("Time spent checking a program .*: (.*) s");
            //Regex corralProcs = new Regex("Number of procedures inlined: (.*)");
            //Regex stackDepth = new Regex("Stack depth: (.*)");
            //Regex refinements = new Regex("Num refinements: (.*)");

            Regex dualityResultBug = new Regex("Counterexample found.");
            Regex dualityResultCorrect = new Regex("Procedure is correct.");
            //Regex corralResultProof = new Regex("Procedure is correct.");
            Regex dualitySummaryFileNotFound = new Regex("Error opening file");

            Regex proverCrash1 = new Regex("Prover error: Prover did not respond");
            Regex proverCrash2 = new Regex("Inconclusive result.");
            Regex proverCrash3 = new Regex("Prover error: unknown symbol");
            Regex proverCrash4 = new Regex("Prover error: (error \"out of memory\")");

            Regex iz3Crash = new Regex("iz3 Crashed!");

            Regex boogieCorrect = new Regex("Boogie program verifier finished with 1 verified, 0 error");
            Regex boogieBug = new Regex("Boogie program verifier finished with 0 verified, 1 error");

            Regex toolCorrect = new Regex("Correct under recursion bound!");
            Regex toolProof = new Regex("Proof Found!");
            Regex toolUnsound = new Regex("Unsound heuristics used!");

            Regex toolDecisionUsedSI = new Regex("StratifiedInlining decision used.");
            Regex toolDecisionUsedOurTool = new Regex("OurTool decision used.");
            Regex toolCrash = new Regex("Crash");

            //Regex boogieProof = new Regex("Procs that reached bound:");

            string ct = "0";
            string outcome = "Timeout";
            bool crash = false;
            string remarks = "none";

            foreach (var line in lines)
            {
                var match = corralTime.Match(line);
                if (match.Success/* && match.Groups.Count == 2*/)
                {
                    string str = match.Groups[0].Value;
                    //Console.WriteLine("Matched: " + str);
                    ct = str.Substring(str.IndexOf("[") + 1, str.IndexOf(" s]") - str.IndexOf("["));
                    continue;
                }
                if (dualityResultBug.Match(line).Success || boogieBug.Match(line).Success)
                {
                    outcome = "Bug";
                    continue;
                }
                if (dualityResultCorrect.Match(line).Success || boogieCorrect.Match(line).Success || toolCorrect.Match(line).Success || toolProof.Match(line).Success)
                {
                    outcome = "Correct";
                    continue;
                }

                if (iz3Crash.Match(line).Success)
                {
                    remarks = "iz3Crash";
                    continue;
                }

                if (toolUnsound.Match(line).Success)
                {
                    remarks += ",Incomplete";
                    continue;
                }

                if (toolDecisionUsedSI.Match(line).Success)
                {
                    remarks += ",SIDecision";
                    continue;
                }

                if (toolDecisionUsedOurTool.Match(line).Success)
                {
                    remarks += ",OurToolDecision";
                    continue;
                }

                if (toolCrash.Match(line).Success)
                {
                    remarks += ",Crash";
                    continue;
                }
#if false
                if (dualitySummaryFileNotFound.Match(line, 0, Math.Min("Error opening file".Length, line.Length)).Success)
                {
                    outcome = "NoSummaries";
                    continue;
                }
#endif
                if (proverCrash1.Match(line).Success || 
                    proverCrash2.Match(line).Success || 
                    proverCrash3.Match(line).Success || 
                    proverCrash4.Match(line).Success)
                {
                    crash = true;
                    outcome = "Crash";
                    ct = "0";

                    if (proverCrash3.Match(line).Success)
                        remarks = "SymbolBug";

                    continue;
                }
            }

            if (crash)
            {
                outcome = "Crash";
                ct = "0";
            }

            string final = string.Format("{0} {1} {2}", ct, outcome, remarks);
            return final;
        }


        static void ProcessArg(string arg)
        {
            if (arg == "/break")
            {
                System.Diagnostics.Debugger.Launch();
                return;
            }

            if (arg.StartsWith("/toolselect:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                toolSelect = Int32.Parse(sp[1]);
                return;
            }

            if (arg.EndsWith(".bpl"))
            {
                bplfile = arg;
                return;
            }

            //flags.Add(arg);
        }
    }
}
