using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Threading;
using System.Diagnostics;
using System.ComponentModel;
using System.Xml.Serialization;
using System.IO;
using System.Text.RegularExpressions;

namespace CommonLib
{
    public static class LinqExtender
    {
        public static void Iter<T>(this IEnumerable<T> coll, Action<T> fn)
        {
            foreach (var e in coll) fn(e);
        }

        public static string Concat(this IEnumerable<string> strings, string separator)
        {
            var sb = new StringBuilder();
            var first = true;
            foreach (var s in strings)
            {
                if (!first)
                    sb.Append(separator);
                first = false;
                sb.Append(s);
            }
            return sb.ToString();
        }
    }

    public static class Util
    {
        public static bool debugOutput = false;

        public static void ReadFiles(RunParConfig config, out List<Tuple<string, string>> bpls, out List<string> filemaps)
        {
            bpls = new List<Tuple<string, string>>();
            filemaps = new List<string>();
            var filemapMap = new Dictionary<string, Dictionary<string, Tuple<string, string>>>();

            // get negative files first
            var negativeFiles = new HashSet<string>();
            foreach (var f in config.BoogieFiles)
            {
                if (!f.IsNegative()) continue;
                negativeFiles.UnionWith(System.IO.Directory.GetFiles(config.root, f.value));
            }

            foreach (var f in config.BoogieFiles)
            {
                if (f.IsNegative()) continue;

                var files =
                    System.IO.Directory.GetFiles(config.root, f.value);

                var map1 = new Dictionary<string, string>();
                files.Where(s => !negativeFiles.Contains(s))
                    .Iter(s => map1.Add(System.IO.Path.GetFileName(s), s));

                // find the file_map.txt
                var d = System.IO.Path.Combine(config.root, f.value);
                while (true)
                {
                    d = System.IO.Path.GetDirectoryName(d);
                    if (d.Length < config.root.Length)
                        break;
                    if (!System.IO.File.Exists(System.IO.Path.Combine(d, "file_map.txt")))
                        continue;

                    if (!filemaps.Contains(System.IO.Path.Combine(d, "file_map.txt")))
                    {
                        var contents = System.IO.File.ReadAllLines(System.IO.Path.Combine(d, "file_map.txt"));
                        var map2 = new Dictionary<string, Tuple<string, string>>();
                        foreach (var line in contents)
                        {
                            var tokens = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                            var key = System.IO.Path.GetFileName(tokens[0]);
                            var prop = tokens[2];
                            var a = "";
                            for (int i = 3; i < tokens.Length; i++)
                                a += tokens[i] + " ";
                            map2.Add(key, Tuple.Create(prop, a));
                        }
                        filemapMap.Add(System.IO.Path.Combine(d, "file_map.txt"), map2);
                        filemaps.Add(System.IO.Path.Combine(d, "file_map.txt"));
                    }

                    var mapf = filemapMap[System.IO.Path.Combine(d, "file_map.txt")];
                    foreach (var kvp in map1)
                    {
                        if (!mapf.ContainsKey(kvp.Key))
                            continue;
                        var prop = mapf[kvp.Key].Item1;
                        var a = mapf[kvp.Key].Item2;
                        if (!config.HasProperty(prop))
                            continue;
                        bpls.Add(Tuple.Create(kvp.Value, a));
                    }
                }

            }

        }

        public static string GetRemoteFolder(string folder)
        {
            string machine;
            return GetRemoteFolder(folder, out machine);
        }

        public static string GetRemoteFolder(string folder, out string machine)
        {
            var tokens = folder.Split(new char[] { '\\' }, StringSplitOptions.RemoveEmptyEntries);
            if (tokens.Length < 3)
                Console.WriteLine("Failed to parse folder name {0}", folder);

            machine = string.Format(@"\\{0}", tokens[0]);
            var driveletter = tokens[1][0];
            var path = "";
            for(int i = 2; i < tokens.Length; i++)
                path += tokens[i] + ((i == tokens.Length - 1) ? "" : "\\");

            return string.Format(@"{0}:\{1}", driveletter, path);
        }

        // chop off root from in front of file
        public static string GetFileName(string file, string root)
        {
            return file.Substring(root.Length + 1);
        }

        // Get files for union
        public static IEnumerable<string> GetFilesForUnion(string[] args)
        {
            if (args.All(s => s != GlobalConfig.merge_flag))
                return null;

            var ret = new List<string>();
            var found = false;
            for (int i = 0; i < args.Length; i++)
            {
                if (!found && args[i] == GlobalConfig.merge_flag)
                {
                    found = true;
                    continue;
                }

                if (Directory.Exists(args[i]))
                    ret.AddRange(Directory.GetFiles(args[i]));
                else if (File.Exists(args[i]))
                    ret.Add(args[i]);
            }
            return ret;
        }

        public static bool CleanDirectory(string dir)
        {
            var trycount = 0;
            var success = false;
            while (trycount < 5)
            {
                trycount++;
                try
                {
                    foreach (var f in System.IO.Directory.GetFiles(dir))
                    {
                        System.IO.File.Delete(f);
                    }
                    success = true;
                    break;
                }
                catch (System.IO.IOException)
                {
                    Thread.Sleep(1000);
                }
            }
            return success;
        }

        public static List<string> run(string dir, string cmd, string args)
        {
            var ret = new List<string>();

            if (debugOutput)
            {
                Console.WriteLine("-----------------------------------");
                Console.WriteLine("Running: " + cmd + " " + args);
            }

            var proc = new System.Diagnostics.Process();
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.CreateNoWindow = !debugOutput;
            proc.StartInfo.FileName = cmd;
            proc.StartInfo.Arguments = args;
            proc.StartInfo.WorkingDirectory = dir;
            Debug.Assert(System.IO.Path.IsPathRooted(dir));
            proc.StartInfo.RedirectStandardOutput = true;

            lock (SpawnedProcesses)
            {
                SpawnedProcesses.Add(proc);
            }

            proc.Start();
            var str = proc.StandardOutput.ReadToEnd();
            proc.WaitForExit();


            lock (SpawnedProcesses)
            {
                SpawnedProcesses.Remove(proc);
            }

            foreach (var s in str.Split(new string[] { System.Environment.NewLine, "\n" }, StringSplitOptions.None))
            {
                ret.Add(s);
            }

            if (debugOutput)
            {
                Console.WriteLine("-----------------------------------");
            }

            return ret;
        }

        public static HashSet<Process> SpawnedProcesses = new HashSet<Process>();
        
        // corral time, houdini time, SI time, Procs Inlined, Stack depth, Refinements, Outcome
        public static string parseOutput(IEnumerable<string> lines, bool writeToConsole=true)
        {
            Regex corralTime = new Regex("Total Time: (.*) s");
            Regex houdiniTime = new Regex("Houdini took (.*) seconds");
            Regex siTime = new Regex("Time spent checking a program .*: (.*) s");
            Regex corralProcs = new Regex("Number of procedures inlined: (.*)");
            Regex stackDepth = new Regex("Stack depth: (.*)");
            Regex refinements = new Regex("Num refinements: (.*)");

            Regex corralResultBug1 = new Regex("Program has bugs");
            Regex corralResultBug2 = new Regex("Program has a potential bug: True bug");

            Regex corralResultCorrect1 = new Regex("No bugs found");
            Regex corralResultCorrect2 = new Regex("Reached recursion bound of .*");

            Regex corralResultProof1 = new Regex("Proof computed");
            Regex corralResultProof2 = new Regex("Program has no bugs");

            Regex proverCrash1 = new Regex("Prover error: Prover did not respond");
            Regex proverCrash2 = new Regex("Inconclusive result.");
            Regex fileCrash1 = new Regex("Stopping: Cannot resolve .*");

            string ct = "0";
            string ht = "0";
            string st = "0";
            string sd = "0";
            string pi = "0";
            string rf = "0";
            string outcome = "Timeout";
            bool crash = false;

            foreach (var line in lines)
            {
                var match = corralTime.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    ct = match.Groups[1].Value;
                    continue;
                }
                match = houdiniTime.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    ht = match.Groups[1].Value;
                    continue;
                }
                match = siTime.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    st = match.Groups[1].Value;
                    continue;
                }
                if (line.StartsWith("SplitSearch:"))
                {
                    st = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries).Last();
                    continue;
                }
                match = corralProcs.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    pi = match.Groups[1].Value;
                    continue;
                }
                match = stackDepth.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    sd = match.Groups[1].Value;
                    continue;
                }
                match = refinements.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    rf = match.Groups[1].Value;
                    continue;
                }
                if (corralResultBug1.Match(line).Success || corralResultBug2.Match(line).Success)
                {
                    outcome = "Bug";
                    continue;
                }
                if (corralResultProof1.Match(line).Success || corralResultProof2.Match(line).Success)
                {
                    outcome = "Proof";
                    continue;
                }
                if (corralResultCorrect1.Match(line).Success || corralResultCorrect2.Match(line).Success)
                {
                    outcome = "Correct";
                    continue;
                }
                if (proverCrash1.Match(line).Success || proverCrash2.Match(line).Success || fileCrash1.Match(line).Success)
                {
                    crash = true;
                    continue;
                }
            }

            if (crash)
            {
                outcome = "Crash";
                ct = ht = st = pi = "0";
            }

            string output = String.Format("{0} {1} {2} {3} {4} {5} {6} ", ct, ht, st, sd, pi, rf, outcome);

            if (writeToConsole)
                Console.WriteLine(output);

            return output;
        }

        public static bool CorralOutcomeHasBugs(IEnumerable<string> lines)
        {
            Regex corralResultBug1 = new Regex("Program has bugs");
            Regex corralResultBug2 = new Regex("Program has a potential bug: True bug");

            foreach (var line in lines)
            {
                if (corralResultBug1.Match(line).Success || corralResultBug2.Match(line).Success)
                {
                    return true;
                }
            }

            return false;
        }


        public static int CorralNumRefinements(IEnumerable<string> lines)
        {
            Regex refinements = new Regex("Num refinements: (.*)");
            var ret = 0;

            foreach (var line in lines)
            {
                var match = refinements.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    int rf = 0;
                    if (Int32.TryParse(match.Groups[1].Value, out rf))
                        ret = rf;
                    continue;
                }

            }
            return ret;
        }

        public static HashSet<string> CorralFinalTrackedVars(IEnumerable<string> lines)
        {
            var finaltv = new Regex(@"Final tracked vars: \{(.*)\}");

            foreach (var line in lines)
            {
                var match = finaltv.Match(line);
                if (match.Success && match.Groups.Count == 2)
                {
                    var tv = match.Groups[1].Value.Split(new char[] { ' ', ',' }, StringSplitOptions.RemoveEmptyEntries);
                    return new HashSet<string>(tv);
                }

            }
            return new HashSet<string>();
        }


    }

}