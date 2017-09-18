using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Text.RegularExpressions;
using CommonLib;

namespace RunCorral
{
    class Driver
    {
        static void Main(string[] args)
        {
            var corralflags = new List<string>();
            var timeout = 10000;

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
                if (arg.StartsWith("/runHoudini")) // do not run Houdini
                    continue;

                if (arg.StartsWith("/add:"))
                {
                    corralflags.Add("/" + arg.Substring("/add:".Length));
                    continue;
                }
                if (flagsToRemove.Any(r => r.IsMatch(arg)))
                    continue;
                corralflags.Add(arg);
            }

            corralflags.Add("/useDuality");
            corralflags.Add("/printFinalProg:f.bpl");

            var output = new StreamWriter("RunCorralOutput.txt");

            var root = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            var wlimitexe = Path.Combine(root, "wlimit.exe");
            var corralexe = Path.Combine(root, "..", "corral", "corral.exe");
            var iz3exe = Path.Combine(root, "..", "iz3", "z3.exe");
            var boogieexe = Path.Combine(root, "..", "boogie", "boogie.exe");

            string boogieflags_runDualityInitial = "/fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes f.bpl";
            string boogieflags_runCollectPredicates1 = "/onlyEmitBplWithSummaries:4 /fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes f.bpl";
            string boogieflags_runCollectPredicates2 = " /fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes f.bpl";
            string boogieflags_runDualityWithSummaries1 = " /fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries1.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes EnvVarsPredAbsInductiveGlobal.bpl";
            string boogieflags_runDualityWithSummaries2 = " /fixedPointEngine:duality /fixedPointInfer:corral /printFixedPoint:DualitySummaries2.bpl /stratifiedInline:1 /siVerbose:0 /extractLoops /printAssignment /recursionBound:3 /noinfer /removeEmptyBlocks:0 /coalesceBlocks:0 /noinfer /typeEncoding:m /vc:i /subsumption:0 /traceTimes EnvVarsPredAbsInductiveTemplates.bpl";

            if (args.Any(arg => arg == "/useDuality"))
                corralflags.Add(string.Format("/bopt:z3exe:{0}", iz3exe));

            output.WriteLine("Found root: {0}", root);
            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, corralexe, corralflags.Concat(" "));

            output.Flush();

            var result1 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, corralexe, corralflags.Concat(" ")));

            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runDualityInitial);

            output.Flush();

            ///////////// Initial Duality Run /////////////////////////////////

            var result2 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runDualityInitial));

            result2.Iter(s => output.WriteLine("{0}", s));
            string withoutSummaries = parseDualityOutput(result2);


            //result1.Iter(s => output.WriteLine("{0}", s));
            /////////////  Run the GlobalInductiveSummaries /////////////////////////////

            
            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runCollectPredicates1);

            output.Flush();

            var result31 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runCollectPredicates1));

            result31.Iter(s => output.WriteLine("{0}", s));

            output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runDualityWithSummaries1);

            output.Flush();

            var result41 =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runDualityWithSummaries1));
            
            result41.Iter(s => output.WriteLine("{0}", s));

            string withSummaries1 = parseDualityOutput(result41);

            /////////////// Print results ////////////////////

            File.WriteAllText(GlobalConfig.util_result_file, "Without Summaries");
            File.AppendAllLines(GlobalConfig.util_result_file, result2);

            File.AppendAllText(GlobalConfig.util_result_file, "Generating SummariesGlobal");
            File.AppendAllLines(GlobalConfig.util_result_file, result31);
            File.AppendAllText(GlobalConfig.util_result_file, "With SummariesGlobal");
            File.AppendAllLines(GlobalConfig.util_result_file, result41);

            
            /////////////  Run the LearntInductiveSummaries /////////////////////////////

            string[] withSummaries2 = new string[20];
            for (int i = 5; i <= 7; i++)
            {
                string cmdLine = String.Format("/onlyEmitBplWithSummaries:{0} {1}", i, boogieflags_runCollectPredicates2);
                output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runCollectPredicates2);

                output.Flush();

                var result32 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2}", timeout, boogieexe, cmdLine));

                result32.Iter(s => output.WriteLine("{0}", s));

                output.WriteLine("Running {0} /w {1} {2} {3}", wlimitexe, timeout, boogieexe, boogieflags_runDualityWithSummaries2);

                output.Flush();

                var result42 =
                    Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2}", timeout, boogieexe, boogieflags_runDualityWithSummaries2));

                result42.Iter(s => output.WriteLine("{0}", s));
                withSummaries2[i] = parseDualityOutput(result42);

                /////////////// Print results ////////////////////

                File.AppendAllText(GlobalConfig.util_result_file, "Generating SummariesLearnt");
                File.AppendAllLines(GlobalConfig.util_result_file, result32);
                File.AppendAllText(GlobalConfig.util_result_file, "With SummariesLearnt");
                File.AppendAllLines(GlobalConfig.util_result_file, result42);
            }

            /////////////// Copy files ///////////////////////
            string filename = System.IO.Path.GetFileName(args[0]);
            string dirpath = @"F:\Data_subhajit\train\out\" + filename;
            System.IO.Directory.CreateDirectory(dirpath);
            string[] copyfiles = { "f.bpl", 
                                     "EnvVarsPredAbsInductiveGlobal.bpl", 
                                     "EnvVarsPredAbsInductiveTemplates.bpl",
                                     "DualitySummaries.bpl", 
                                     "DualitySummaries1.bpl", 
                                     "DualitySummaries2.bpl",
                                     "Templates.txt" }; 
            copyfiles.Iter<string>(n => System.IO.File.Copy(n, dirpath + "\\" + n));

            Console.WriteLine("{0} {1} {2} {3} {4}", withoutSummaries, withSummaries1, withSummaries2[5], withSummaries2[6], withSummaries2[7]);

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
            Regex dualitySummaryFileNotFound = new Regex("Error opening file");

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
#if false
                if (dualitySummaryFileNotFound.Match(line, 0, Math.Min("Error opening file".Length, line.Length)).Success)
                {
                    outcome = "NoSummaries";
                    continue;
                }
#endif
                if (proverCrash1.Match(line).Success || proverCrash2.Match(line).Success || proverCrash3.Match(line).Success || proverCrash4.Match(line).Success)
                {
                    crash = true;
                    outcome = "Crash";
                    ct = "0";
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
