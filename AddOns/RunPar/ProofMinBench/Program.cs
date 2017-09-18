using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

/////////
// Generate ProofMinimization benchmarks for multiple rules
// and stash the results in a directory.
// This is a wrapper around RunParServer invoked on "ProofMin" util
//
//
//
//<?xml version="1.0" encoding="utf-8" ?>
//<RunParConfig xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
//  <Root>D:\train</Root>
//  <Utils>
//      <Util name="ProofMin" dir="Binaries" exe="ProofMin.exe" arguments="/timeout:3000 "/> 
//  </Utils>
//  <RemoteRoots>
//    <RemoteFolder value="\\rse-server-8\f$\tmp\train"/>
//    <RemoteFolder value="\\rse-server-9\f$\tmp\train"/>
//    <RemoteFolder value="\\rse-server-10\f$\tmp\train"/>
//    <RemoteFolder value="\\rse-server-11\f$\tmp\train"/>
//  </RemoteRoots>
//  <Properties>
//     <SLIC value="RuleName"/>
//  </Properties>
//  <BoogieFiles>
//     <Files value="data\drivers\*.bpl"/>
//  </BoogieFiles>

//</RunParConfig>


/////////


namespace ProofMinBench
{
    class Program
    {
        public static readonly string baseDir = "d:\\pmin_nohoudini";
        public static readonly string typeDir = "rts";

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("ProofMinBench.exe config-template.xml [options]");
                return;
            }
            var resume = false;
            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/resume")
                    resume = true;
                if (args[i] == "/break")
                    System.Diagnostics.Debugger.Launch();
            }

            var exe = @"c:\Users\akashl\Documents\work\rse\cba\RunPar\Binaries\RunParServer.exe";
            var remoted = new List<string> { @"\\rse-server-8\f$\tmp\pmin", @"\\rse-server-9\f$\tmp\pmin", @"\\rse-server-10\f$\tmp\pmin", @"\\rse-server-11\f$\tmp\pmin", @"\\rse-server-12\f$\tmp\pmin", @"\\rse-server-13\d$\tmp\pmin", @"\\rse-server-14\d$\tmp\pmin" };
            
            var sw = new System.Diagnostics.Stopwatch();
            sw.Start();

            var file_rule_map = GetRules();
            var allrules = new HashSet<string>(file_rule_map.Values);
            Console.WriteLine("Found {0} rules total", allrules.Count);

            // Clear remote directoties
            if (!resume)
            {
                Console.WriteLine("Cleaning remote directories");
                foreach (var d in remoted)
                {
                    var res = CommonLib.Util.CleanDirectory(d);
                    if (!res) { Console.WriteLine("Unable to clean directory {0}", d); return; }
                }
            }
            else
            {
                Console.WriteLine("Resuming execution");
            }


            Console.WriteLine("Running: {0} {1}", exe, string.Format("{0} {1}", args[0], resume ? "/resume" : ""));

            var output = CommonLib.Util.run(Environment.CurrentDirectory, exe, string.Format("{0} {1}", args[0], resume ? "/resume" : ""));

            output.ForEach(s => Console.WriteLine("{0}", s));
            Console.WriteLine();

            var mapfile = new List<string>();
            var rules = new HashSet<string>();
            foreach (var d in remoted)
            {
                var bpls = Directory.GetFiles(d, "*.bpl");
                Console.WriteLine("Diretory {0} has {1} bpls", d, bpls.Length);

                if (!File.Exists(Path.Combine(d, "file_map.txt")))
                {
                    Console.WriteLine("    and no file_map.txt");
                    continue;
                }

                var map = GetFileMap(Path.Combine(d, "file_map.txt"));
                mapfile.AddRange(map.Select(tup => string.Format("{0}\t{1}", tup.Key, tup.Value)));

                foreach (var bpl in bpls)
                {
                    if (!map.ContainsKey(Path.GetFileName(bpl))) continue; // duplicate
                    rules.Add(file_rule_map[map[Path.GetFileName(bpl)]]);
                }
            }

            // Create rule directories
            Console.WriteLine("Found files for {0} rules", rules.Count);
            foreach (var rule in rules)
            {                
                var dir = Path.Combine(baseDir, rule, typeDir);
                if (Directory.Exists(dir))
                {
                    CommonLib.Util.CleanDirectory(dir);
                }
                else
                {
                    Directory.CreateDirectory(dir);
                }
            }

            // Copy files to the right directory
            foreach (var d in remoted)
            {
                if (!File.Exists(Path.Combine(d, "file_map.txt")))
                    continue;

                var bpls = Directory.GetFiles(d, "*.bpl");
                var map = GetFileMap(Path.Combine(d, "file_map.txt"));

                foreach (var bpl in bpls)
                {
                    if (!map.ContainsKey(Path.GetFileName(bpl))) continue; // duplicate
                    var rule = file_rule_map[map[Path.GetFileName(bpl)]];
                    var dir = Path.Combine(baseDir, rule, typeDir);

                    var from = bpl;
                    var to = Path.Combine(dir, Path.GetFileName(bpl));
                    //Console.WriteLine("move {0} {1}", from, to);
                    File.Copy(from, to);
                }
            }

            var mainmapfile = new StreamWriter(Path.Combine(baseDir, "file_map.txt"), false);
            mapfile.ForEach(s => mainmapfile.WriteLine("{0}", s));
            mainmapfile.Close();

            Console.WriteLine("Elapsed time: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));
        }

        // Return file to rule mapping
        static Dictionary<string, string> GetRules()
        {
            var pwd = Environment.CurrentDirectory;
            var lines = File.ReadAllLines(Path.Combine(pwd, "data", typeDir, "file_map.txt"));
            var ret = new Dictionary<string, string>();
            foreach(var tok in lines.Select(line => line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries)))
                ret.Add(Path.GetFileName(tok[0]),tok[2]);
            return ret;
        }

        static Dictionary<string, string> GetFileMap(string file)
        {
            var seen = new HashSet<string>();
            var lines = File.ReadAllLines(file);
            var ret = new Dictionary<string, string>();
            foreach (var tok in lines.Select(line => line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries)))
            {
                if (seen.Contains(tok[1])) continue; // duplicate
                ret.Add(Path.GetFileName(tok[0]), tok[1]);
                seen.Add(tok[1]);
            }
            return ret;
        }
    }
}
