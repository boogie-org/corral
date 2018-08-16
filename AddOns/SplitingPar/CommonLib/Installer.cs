using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommonLib
{
    public static class Installer
    {
        public static void CheckSelfInstall(SplitParConfig config)
        {
            var root = config.root;

            //foreach (var files in config.BoogieFiles)
            //    CheckFolderExists(
            //        System.IO.Path.Combine(config.root, System.IO.Path.GetDirectoryName(files.value)));

            // Get location of SplitParClient
            // var loc = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
            var loc = System.IO.Path.Combine(root, Utils.SplitParClientDir); 
            CheckFileExists(root, System.IO.Path.Combine(Utils.CorralDir, Utils.CorralExe));
            CheckFileExists(root, System.IO.Path.Combine(Utils.SplitParClientDir, Utils.SplitParClientExe));

            // Copy it root\splitParClient
            //Console.WriteLine("Installing Binaries");
            //System.IO.Directory.CreateDirectory(System.IO.Path.Combine(root, splitParClientDir));
            //foreach (var f in System.IO.Directory.GetFiles(loc, "*.exe").Concat(
            //    System.IO.Directory.GetFiles(loc, "*.dll")))
            //{
            //    System.IO.File.Copy(f, System.IO.Path.Combine(root, splitParClientDir, System.IO.Path.GetFileName(f)), true);
            //}

            foreach (var util in config.Utils)
                CheckFileExists(root, util.value);

            // pstools
            CheckFileExists(root, System.IO.Path.Combine(Utils.PsToolsDir, Utils.PsToolsExe));
        }

        public static void RemoteInstall(string root, string remote, IEnumerable<string> utils, bool force, List<Files> files)
        {
            // Copy corral
            string remoteCorralDir = System.IO.Path.Combine(remote, Utils.CorralDir, Utils.CorralExe);
            if (!System.IO.File.Exists(remoteCorralDir))
                CopyFolder(root, remote, Utils.CorralDir, force);

            // copy splitpar client
            foreach (var util in utils)
            {
                string remoteSplitParClient = System.IO.Path.Combine(remote, Utils.SplitParClientDir, Utils.SplitParClientExe);
                if (!System.IO.File.Exists(remoteSplitParClient))
                    CopyFolder(root, remote, util, force);
            }

            // copy pstools
            string remotePSToolDir = System.IO.Path.Combine(remote, Utils.PsToolsDir, Utils.PsToolsExe);
            if (!System.IO.File.Exists(remotePSToolDir))
                CopyFolder(root, remote, Utils.PsToolsDir, force);

            // copy files
            foreach (var src in files)
            {          
                CopyFile(System.IO.Path.Combine(root, src.value), System.IO.Path.Combine(remote, Utils.DataDir, System.IO.Path.GetFileName(src.value)));
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
