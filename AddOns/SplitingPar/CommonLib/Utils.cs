using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace CommonLib
{ 
    public class Utils
    {
        // communication messages
        public static string PingMsg = "Are you ready?";
        public static string ReadyMsg = "Yes";
        public static string NotReadyMsg = "No";
        public static string CorrectMsg = "Correct";
        public static string ErrorMsg = "Error";
        public static string TimedoutMsg = "OutOfResource";
        public static string OutOfResourceMsg = "OutOfMemory";
        public static string OutOfMemoryMsg = "Inconclusive";
        public static string ReachedBoundMsg = "ReachedBound";
        public static string CompletionMsg = "Complete";
        public static string DoingMsg = "Doing";
        public static string ResultFile = "result.txt";
        public static int MsgSize = 1024;
        public static int ServerPort = 11000;
        public static int CorralPort = 12000;

        // paths
        public static string DataDir = "data";
        public static string RunDir = "run";
        public static string CorralDir = "..\\..\\bin\\Debug";
        public static string CorralExe = "corral.exe";
        public static string SplitParClientDir = "SplitParClient\\bin\\Debug";
        public static string SplitParClientExe = "SplitParClient.exe";
        public static string SplitParServerExe = "SplitParServer.exe";
        public static string PsToolsDir = "pstools";
        public static string PsToolsExe = "psexec.exe";
        public static string ClientConfig = "config-client.xml";

        // other
        public static string ServerLog = "ServerLog.out";
        public static string ClientLog = "ClientLog.out";

        public enum CurrentState { AVAIL, BUSY };

        public static HashSet<Process> SpawnedProcesses = new HashSet<Process>();
        static bool debugOutput = true;
        
        public static SplitParConfig LoadConfig(string configFile)
        {
            return SplitParConfig.DeSerialize(configFile);
        }

        public static byte[] EncodeStr(string msg)
        {
            return Encoding.ASCII.GetBytes(msg);
        }

        public static string Indent(int n)
        {
            var ret = "";
            int i = n;
            while (i > 0) { i--; ret += " "; }
            return ret;
        }

        public static string LocalIP ()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            return null;
        }

        public static void runAndSkipOutput(string dir, string cmd, string args)
        {
            var ret = new List<string>();

            if (debugOutput)
            {
                Console.WriteLine("-----------------------------------");
                Console.WriteLine("Running: " + cmd + " " + args);
            }

            var proc = new System.Diagnostics.Process();
            proc.StartInfo.UseShellExecute = true; // turn it off
            proc.StartInfo.CreateNoWindow = !debugOutput;
            proc.StartInfo.FileName = cmd;
            proc.StartInfo.Arguments = args;
            proc.StartInfo.WorkingDirectory = dir;
            Debug.Assert(System.IO.Path.IsPathRooted(dir));
            //proc.StartInfo.RedirectStandardOutput = true;

            lock (SpawnedProcesses)
            {
                SpawnedProcesses.Add(proc);
            }

            proc.Start(); 
            proc.WaitForExit();


            lock (SpawnedProcesses)
            {
                SpawnedProcesses.Remove(proc);
            }            
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

        public static string GetRemoteMachineName(string folder)
        {
            var tokens = folder.Split(new char[] { '\\' }, StringSplitOptions.RemoveEmptyEntries);
            return tokens[0];
        }

        public static string GetRemoteFolder(string folder, out string machine)
        {
            var tokens = folder.Split(new char[] { '\\' }, StringSplitOptions.RemoveEmptyEntries);
            if (tokens.Length < 3)
                Console.WriteLine("Failed to parse folder name {0}", folder);

            machine = string.Format(@"\\{0}", tokens[0]);
            var driveletter = tokens[1][0];
            var path = "";
            for (int i = 2; i < tokens.Length; i++)
                path += tokens[i] + ((i == tokens.Length - 1) ? "" : "\\");

            return string.Format(@"{0}:\{1}", driveletter, path);
        }

        public static void SpawnClient(string root, params string[] args)
        {
            var loc = System.IO.Path.Combine(root, Utils.SplitParClientDir, Utils.SplitParClientExe);

            var tmp = System.IO.Path.Combine(root, Utils.RunDir);
            System.IO.Directory.CreateDirectory(tmp);

            var flags = args.Aggregate("", ((s1, s2) => s1 + " " + s2));

            if (debugOutput)
            {
                Console.WriteLine("Running local client");
                Console.WriteLine(string.Format("Running {0} {1} {2}", tmp, loc, flags));
            }

            var outp = Utils.run(tmp, loc, flags);

            var resultsfile = System.IO.Path.Combine(tmp, Utils.ResultFile);
            var ex = System.IO.File.Exists(resultsfile);

            if (debugOutput)
            {
                Console.WriteLine(string.Format("Local client:"));
                if (!ex)
                    Console.WriteLine(string.Format("Did not find a {0} file", Utils.ResultFile));
            }
        }

        public static void SpawnClientRemote(string root, params string[] args)
        {
            // find the name of the machine from the remote folder name
            var machine = "";
            var remoteroot = Utils.GetRemoteFolder(root, out machine);

            var tmp = System.IO.Path.Combine(root, Utils.RunDir);
            var remotetmp = System.IO.Path.Combine(remoteroot, Utils.RunDir);

            System.IO.Directory.CreateDirectory(tmp);

            // psexec machine -w remoteroot\run remoteroot\Binaries\RunParClient.exe remoteroot args
            var cmd = System.IO.Path.Combine(root, Utils.PsToolsDir, Utils.PsToolsExe);
            var flags = string.Format("{0} -w {1} {2} {3} {4}",
                machine, remotetmp, System.IO.Path.Combine(remoteroot, Utils.SplitParClientDir, Utils.SplitParClientExe), remoteroot, args.Aggregate("", (s1, s2) => s1 + " " + s2));

            if (debugOutput)
            {
                Console.WriteLine(string.Format("Running remote client on {0}", root));
                Console.WriteLine(string.Format("Running {0} {1} {2}", root, cmd, flags));
            }
            
            Utils.runAndSkipOutput(root, cmd, flags);

            var resultsfile = System.IO.Path.Combine(tmp, Utils.ResultFile);
            var ex = System.IO.File.Exists(resultsfile);

            if (debugOutput)
            {
                Console.WriteLine(string.Format("Remote client {0}:", root));
                if (!ex)
                    Console.WriteLine(string.Format("Did not find a {0} file", Utils.ResultFile));
            }
        }

    }
}
