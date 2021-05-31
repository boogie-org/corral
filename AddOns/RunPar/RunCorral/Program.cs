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
        public static bool collectDualityProof = false;
        public static bool collectSIfiles = false;
        public static readonly string siFilesDir = @"d:\sifiles";

        static void Main(string[] args)
        {
            var corralflags = new List<string>();
            var timeout = 10000;
            var memout = 10 * 1024; // in MB

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
            var flagsToAdd = new List<string>();
            foreach (var arg in args)
            {
                if (arg.StartsWith("/remove:"))
                {
                    flagsToRemove.Add(new Regex("/" + arg.Substring("/remove:".Length)));
                    continue;
                }
                if (arg.StartsWith("/add:"))
                {
                    flagsToAdd.Add("/" + arg.Substring("/add:".Length));
                    continue;
                }
            }

            foreach (var arg in args)
            {
                if (arg.StartsWith("/timeout:"))
                {
                    timeout = Int32.Parse(GetArg(arg, 1));
                    continue;
                }
                if (arg.StartsWith("/memout:"))
                {
                    memout = Int32.Parse(GetArg(arg, 1));
                    continue;
                }
                if (arg.StartsWith("/remove:") || arg.StartsWith("/add:"))
                    continue;
                if (arg == "/collectProof")
                {
                    collectDualityProof = true;
                    corralflags.Add("/bopt:printFixedPoint:fp.bpl");
                    continue;
                }
                if (arg == "/collectSI")
                {
                    collectSIfiles = true;
                    corralflags.Add("/printFinalProg:si.bpl");
                    continue;
                }
                if (flagsToRemove.Any(r => r.IsMatch(arg)))
                    continue;
                corralflags.Add(arg);
            }
            corralflags.AddRange(flagsToAdd);

            var output = new StreamWriter("RunCorralOutput.txt");

            var root = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            var wlimitexe = Path.Combine(root, "wlimit.exe");
            var corralexe = Path.Combine(root, "..", "corral", "corral.exe");
            var iz3exe = Path.Combine(root, "..", "iz3", "z3.exe");

            if(args.Any(arg => arg == "/useDuality"))
                corralflags.Add(string.Format("/bopt:z3exe:{0}", iz3exe));                

            output.WriteLine("Found root: {0}", root);
            output.WriteLine("Running {0} /w {1} /m {2} {3} {4}", wlimitexe, timeout, memout, corralexe, corralflags.Concat(" "));

            output.Flush();

            var result =
                Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} /m {1} {2} {3}", timeout, memout, corralexe, corralflags.Concat(" ")));

            result.Iter(s => output.WriteLine("{0}", s));

            Util.parseOutput(result);
            if (collectSIfiles && File.Exists("si.bpl"))
            {
                var fname = args.Where(a => a.EndsWith(".bpl")).First();
                fname = Path.GetFileName(fname);
                output.WriteLine("Found SI file, copying to {0}", Path.Combine(siFilesDir, fname));
                File.Copy("si.bpl", Path.Combine(siFilesDir, fname), true);
            }
            else
            {
                output.WriteLine("collectSI is off");
            }

            if (collectDualityProof && File.Exists("fp.bpl"))
            {
                result.Add("======");
                result.AddRange(File.ReadAllLines("fp.bpl"));
                result.Add("======");
            }
            File.WriteAllLines(GlobalConfig.util_result_file, result);

            output.Close();
        }

        static string GetArg(string str, int n)
        {
            var sp = str.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
            return sp[n];
        }


    }
}
