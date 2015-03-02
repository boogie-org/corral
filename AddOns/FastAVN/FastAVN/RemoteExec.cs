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
    [XmlType(TypeName = "FastAvnConfig")]
    [Serializable]
    public class FastAvnConfig
    {
        [XmlArrayItemAttribute("RemoteFolder", typeof(RemoteFolder))]
        public RemoteFolder[] RemoteRoots { get; set; }

        public static FastAvnConfig DeSerialize(string file)
        {
            var x = new XmlSerializer(typeof(FastAvnConfig));
            using (FileStream fsr = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                var ret = (FastAvnConfig)x.Deserialize(fsr);
                return ret;
            }
        }

    }

    [XmlRootAttribute("RemoteFolder", Namespace = "")]
    public class RemoteFolder
    {
        [XmlAttributeAttribute()]
        public string dir { get; set; }

        [XmlAttributeAttribute()]
        public string threads { get; set; }

        public int Threads
        {
            get
            {
                return Int32.Parse(threads);
            }
        }
    }

    public static class RemoteExec
    {
        public static bool debugOutput = false;

        public static void CopyFolder(string root, string remote, string folder, bool force)
        {
            //Console.WriteLine("Copying folder {0} to {1}", System.IO.Path.Combine(root, folder), System.IO.Path.Combine(remote, folder));
            var files = System.IO.Directory.GetFiles(System.IO.Path.Combine(root, folder));
            foreach (var file in files)
            {
                var remotefile = System.IO.Path.Combine(remote, folder, System.IO.Path.GetFileName(file));
                if (force || !System.IO.File.Exists(remotefile))
                {
                    System.IO.Directory.CreateDirectory(System.IO.Path.Combine(remote, folder));
                    //Console.WriteLine("copy {0} {1}", file, remotefile);
                    System.IO.File.Copy(file, remotefile, true);
                }
            }
            //Console.WriteLine("Done! Copying folder {0} to {1}", System.IO.Path.Combine(root, folder), System.IO.Path.Combine(remote, folder));
        }

        public static void CopyFolder(string root, string remote, bool force)
        {
            //Console.WriteLine("Copying folder {0} to {1}", System.IO.Path.Combine(root, folder), System.IO.Path.Combine(remote, folder));
            var files = System.IO.Directory.GetFiles(root);
            foreach (var file in files)
            {
                var remotefile = System.IO.Path.Combine(remote, System.IO.Path.GetFileName(file));
                if (force || !System.IO.File.Exists(remotefile))
                {
                    System.IO.Directory.CreateDirectory(remote);
                    //Console.WriteLine("copy {0} {1}", file, remotefile);
                    System.IO.File.Copy(file, remotefile, true);
                }
            }
            //Console.WriteLine("Done! Copying folder {0} to {1}", System.IO.Path.Combine(root, folder), System.IO.Path.Combine(remote, folder));
        }

        public static void CopyFile(string src, string dest)
        {
            if (!System.IO.File.Exists(dest))
            {
                System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(dest));
                Console.WriteLine("copy {0} {1}", src, dest);
                System.IO.File.Copy(src, dest);
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
            for (int i = 2; i < tokens.Length; i++)
                path += tokens[i] + ((i == tokens.Length - 1) ? "" : "\\");

            return string.Format(@"{0}:\{1}", driveletter, path);
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
