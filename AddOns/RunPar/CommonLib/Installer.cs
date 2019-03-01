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

namespace CommonLib
{
    public static class Installer
    {
        public static void CheckSelfInstall(RunParConfig config)
        {
            var root = config.root;

            CheckFileExists(root, "corral\\corral.exe");
            CheckFileExists(root, "iz3\\z3.exe");
            foreach (var files in config.BoogieFiles)
                CheckFolderExists(
                    System.IO.Path.Combine(config.root, System.IO.Path.GetDirectoryName(files.value)));

            // Get location of RunParClient
            var loc = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            CheckFileExists(loc, "RunParClient.exe");

            // Copy it root\RunParClient
            //Console.WriteLine("Installing Binaries");
            //System.IO.Directory.CreateDirectory(System.IO.Path.Combine(root, "Binaries"));
            //foreach (var f in System.IO.Directory.GetFiles(loc, "*.exe").Concat(
            //    System.IO.Directory.GetFiles(loc, "*.dll")))
            //{
            //    Console.WriteLine("copy {0} {1}", f, System.IO.Path.Combine(root, "Binaries", System.IO.Path.GetFileName(f)));
            //    System.IO.File.Copy(f, System.IO.Path.Combine(root, "Binaries", System.IO.Path.GetFileName(f)), true);
            //}

            foreach (var util in config.Utils)
                CheckFileExists(root, util.value);

            // pstools
            CheckFileExists(root, "pstools\\psexec.exe");
        }

        public static void RemoteInstall(string root, string remote, IEnumerable<string> utils, IEnumerable<string> files, IEnumerable<string> filemaps, bool boogie, bool force)
        {
            // Copy corral
            CopyFolder(root, remote, "corral", force);

            // copy iz3
            CopyFolder(root, remote, "iz3", force);

            // copy utils
            foreach (var u in utils)
                CopyFolder(root, remote, u, force);

            // copy RunParClient
            CopyFolder(root, remote, "Binaries", force);

            if (boogie)
            {
                CopyFolder(root, remote, "boogie1", force);
                CopyFolder(root, remote, "boogie2", force);
            }

            //copy files
            foreach (var src in files)
            {
                var dest = src.Replace(root, remote);
                CopyFile(src, dest);
            }

            // copy files
            foreach (var src in filemaps)
            {
                var dest = src.Replace(root, remote);
                CopyFile(src, dest);
            }

        }

        static void CopyFolder(string root, string remote, string folder, bool force)
        {
            Console.WriteLine("Copying folder {0} to {1}", folder, remote);
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
        }

        public static void CopyFile(string src, string dest)
        {
            if (System.IO.File.Exists(dest) &&
                System.IO.File.GetLastWriteTime(dest) >= System.IO.File.GetLastWriteTime(src))
                return;

            System.IO.Directory.CreateDirectory(System.IO.Path.GetDirectoryName(dest));
            Console.WriteLine("copy {0} {1}", src, dest);
            System.IO.File.Copy(src, dest, true);
        }


        static void CheckFileExists(string folder, string file)
        {
            var fullpath = System.IO.Path.Combine(folder, file);
            if (System.IO.File.Exists(fullpath))
                return;
            throw new Exception(string.Format("Invalid installation; could not find {0}", fullpath));
        }

        static void CheckFolderExists(string folder)
        {
            if (System.IO.Directory.Exists(folder))
                return;
            throw new Exception(string.Format("Invalid installation; could not find {0}", folder));
        }
    }
}