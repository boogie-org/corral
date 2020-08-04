using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Xml.Serialization;
using System.IO;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Threading;

namespace FastAVN
{
     public static class RemoteExec
    {
        public static bool debugOutput = false;

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

        public static void CleanDirectory(string dir)
        {
            var trycount = 0;
            while (trycount < 5)
            {
                trycount++;
                try
                {
                    foreach (var f in System.IO.Directory.GetFiles(dir))
                    {
                        System.IO.File.Delete(f);
                    }
                    break;
                }
                catch (System.IO.IOException)
                {
                    Thread.Sleep(1000);
                }
            }
        }

        public static HashSet<Process> SpawnedProcesses = new HashSet<Process>();
    }
}
