using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommonLib;
using System.Text.RegularExpressions;
using System.IO;

namespace GetCorralFiles
{
    class Program
    {
        static void Main(string[] args)
        {
            var corralflags = new List<string>();
            var timeout = 86400;

            var outfiles = Util.GetFilesForUnion(args);
            if (outfiles != null)
            {
                var cat = new List<string>();
                foreach (var file in outfiles)
                {
                    cat.AddRange(System.IO.File.ReadAllLines(file));
                    cat.Add("=========");
                }
                System.IO.File.WriteAllLines(GlobalConfig.util_result_file, cat);
                return;
            }

            var flagsToRemove = new List<Regex>();
            foreach (var arg in args)
            {
                if (!arg.StartsWith("/remove:"))
                    continue;
                flagsToRemove.Add(
                    new Regex("/" + arg.Substring("/remove:".Length)));
            }

            foreach (var arg in args)
            {
                if (arg.StartsWith("/timeout:"))
                {
                    timeout = Int32.Parse(GetArg(arg, 1));
                    continue;
                }
                if (arg.StartsWith("/remove:"))
                    continue;
                // if (arg.StartsWith("/runHoudini")) // do not run Houdini
                //     continue;

                if (arg.StartsWith("/add:"))
                {
                    corralflags.Add("/" + arg.Substring("/add:".Length));
                    continue;
                }
                if (flagsToRemove.Any(r => r.IsMatch(arg)))
                    continue;
                corralflags.Add(arg);
            }

            //corralflags.Add("/useDuality");
            corralflags.Add("/printFinalProg:f.bpl");

            var output = new StreamWriter("RunCorralOutput.txt");

            var root = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            var wlimitexe = Path.Combine(root, "wlimit.exe");
            var corralexe = Path.Combine(root, "..", "corral", "corral.exe");
            var iz3exe = Path.Combine(root, "..", "iz3", "z3.exe");
            var boogieexe = Path.Combine(root, "..", "boogie", "boogie.exe");

            if (args.Any(arg => arg == "/useDuality"))
                corralflags.Add(string.Format("/bopt:z3exe:{0}", iz3exe));

            output.WriteLine("Found root: {0}", root);
            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, corralexe, corralflags.Concat(" "));

            output.Flush();

            var result1 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, corralexe, corralflags.Concat(" ")));

            var outfile = Environment.CurrentDirectory + "\\f.bpl";
            var tofile = @"..\..\CorralOut\CorralOut_" + System.IO.Path.GetFileName(args[0]);

            if (!System.IO.Directory.Exists(@"..\..\CorralOut"))
            {
                System.IO.Directory.CreateDirectory(@"..\..\CorralOut");
            }

            if (System.IO.File.Exists(outfile))
            {
                try
                {
                    File.Copy(Environment.CurrentDirectory + "\\f.bpl", tofile);
                    Console.WriteLine("Copy " + Environment.CurrentDirectory + "\\f.bpl" + " to " + tofile);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Copy failed:" + e.Message);
                }
            }
            else
            {
                Console.WriteLine("f.bpl not found");
            }

#if false
            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runDualityInitial);

            output.Flush();


            //result1.Iter(s => output.WriteLine("{0}", s));

            var result2 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runDualityInitial));

            result2.Iter(s => output.WriteLine("{0}", s));
            string withoutSummaries = parseDualityOutput(result2);

            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runCollectPredicates);

            output.Flush();

            var result3 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runCollectPredicates));

            result3.Iter(s => output.WriteLine("{0}", s));

            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runDualityWithSummaries);

            output.Flush();

            List<string> result4 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runDualityWithSummaries));

            result4.Iter(s => output.WriteLine("{0}", s));
            string withSummaries = parseDualityOutput(result4);

            StreamWriter f = new StreamWriter(GlobalConfig.util_result_file);
            f.WriteLine("Without Summaries");
            result2.Iter(s => f.WriteLine("{0}", s));
            f.WriteLine("Generating Summaries");
            result3.Iter(s => f.WriteLine("{0}", s));
            f.WriteLine("With Summaries");
            result4.Iter(s => f.WriteLine("{0}", s));
            f.Close();

            Console.WriteLine("{0} {1}", withoutSummaries, withSummaries);
#endif

            output.Close();

        }

        static string GetArg(string str, int n)
        {
            var sp = str.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
            return sp[n];
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
            Regex dualitySummaryFileNotFound = new Regex("Error opening file \"EnvVarsPredAbsInductiveGlobal.bpl\"");

            Regex proverCrash1 = new Regex("Prover error: Prover did not respond");
            Regex proverCrash2 = new Regex("Inconclusive result.");
            Regex proverCrash3 = new Regex("Prover error: unknown symbol");
            Regex proverCrash4 = new Regex("Prover error: (error \"out of memory\")");

            string ct = "0";
            string outcome = "Timeout";
            bool crash = false;

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
                if (dualityResultBug.Match(line).Success)
                {
                    outcome = "Bug";
                    continue;
                }
                if (dualityResultCorrect.Match(line).Success)
                {
                    outcome = "Correct";
                    continue;
                }
                if (dualitySummaryFileNotFound.Match(line).Success)
                {
                    outcome = "NoSummaries";
                    continue;
                }
                if (proverCrash1.Match(line).Success || proverCrash2.Match(line).Success || proverCrash3.Match(line).Success || proverCrash4.Match(line).Success)
                {
                    crash = true;
                    continue;
                }
            }

            if (crash)
            {
                outcome = "Crash";
                ct = "0";
            }

            string final = string.Format("{0} {1}", ct, outcome);
            return final;
        }
    }
}
