using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Text.RegularExpressions;
using System.IO;
using CommonLib;

namespace RunPar
{
    class Program
    {
        static RunParConfig config;
        static StreamWriter log = null;
        static bool resume = false;

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("Usage: RunParServer.exe file.xml");
                return;
            }

            var force = true;
            var boogie = false;
            var debug = false;
            var test = false;

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();
            if (args.Any(s => s == "/debug"))
                debug = true;
            if (args.Any(s => s == "/noforce"))
                force = false;
            if (args.Any(s => s == "/resume"))
            {
                force = false;
                resume = true;
            }
            if (args.Any(s => s == "/test"))
                test = true;
            if (args.Any(s => s == "/boogie"))
                boogie = true;

            // Read in the config
            config = RunParConfig.DeSerialize(args[0]);
            config.Dump();
            log = new StreamWriter("server.log");

            // Check install
            Console.WriteLine("Checking self installation");
            try
            {
                Installer.CheckSelfInstall(config);
            }
            catch (Exception e)
            {
                Console.WriteLine("{0}", e.Message);
                return;
            }
            Console.WriteLine("Done");

            // Find the files and their arguments
            var bpls = new List<Tuple<string, string>>();
            var filemaps = new List<string>();
            Util.ReadFiles(config, out bpls, out filemaps);

            Console.WriteLine("Found {0} files", bpls.Count);

            var machineToFiles = new Dictionary<int, List<string>>();

            // Split across machines
            var M = config.RemoteRoots.Length + 1;
            for (int i = 0; i < M; i++)
                machineToFiles.Add(i, new List<string>());

            for (int i = 0; i < bpls.Count; i++)
                machineToFiles[i % M].Add(bpls[i].Item1);

            // Do remote installation
            Console.WriteLine("Doing remote installation");
            var rm = 1;
            foreach (var r in config.RemoteRoots)
            {
                Console.WriteLine("Installing {0} files on {1}", machineToFiles[rm].Count, r.value);
                if(machineToFiles[rm].Count != 0)
                    Installer.RemoteInstall(config.root, r.value, config.Utils.Select(u => u.dir).Distinct(), machineToFiles[rm], filemaps, boogie, force);
                rm++;
            }
            Console.WriteLine("Done");

            if(debug)
                Util.debugOutput = true;

            var threads = new List<Thread>();
            var workers = new List<Worker>();

            var starttime = DateTime.Now;
            Console.WriteLine("Spawning clients");

            // spawn client on own machine
            config.DumpClientConfig(config.root, machineToFiles[0].Select(f => Util.GetFileName(f, config.root)), System.IO.Path.Combine(config.root, "config-client.xml"));
            var w0 = new Worker(false, config.root, resume ? "/resume" : "", test ? "/test" : "");
            workers.Add(w0);
            threads.Add(new Thread(new ThreadStart(w0.Run)));
            

            // spawn clients on remote machines
            rm = 0;
            foreach (var r in config.RemoteRoots)
            {
                rm++;
                if(machineToFiles[rm].Count == 0)
                    continue;
                config.DumpClientConfig(Util.GetRemoteFolder(r.value), machineToFiles[rm].Select(f => Util.GetFileName(f, config.root)), System.IO.Path.Combine(r.value, "config-client.xml"));
                var w1 = new Worker(true, r.value, resume ? "/resume" : "", test ? "/test" : "");
                threads.Add(new Thread(new ThreadStart(w1.Run)));
                workers.Add(w1);
            }

            // start threads
            threads.ForEach(t => t.Start());
            threads.ForEach(t => t.Join());

            Console.WriteLine("Time taken = {0} seconds", (DateTime.Now - starttime).TotalSeconds.ToString("F2"));

            Console.WriteLine("Collating results");

            // put the results together
            foreach (var u in config.Utils)
            {
                MergeResults(u, workers, u.name + ".db");
            }

            // text result
            var output = new System.IO.StreamWriter(System.IO.Path.Combine(config.root, "results.txt"));
            
            // file -> util -> output
            var resdict = new Dictionary<string, Dictionary<string, string>>();
            var defaultDelim = 0;

            foreach (var w in workers)
                foreach (var line in w.textresult)
                {
                    var tokens = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                    if (tokens.Length < 2) continue;

                    if (!resdict.ContainsKey(tokens[1]))
                        resdict.Add(tokens[1], new Dictionary<string, string>());

                    var result = "";
                    for (int i = 2; i < tokens.Length; i++)
                        result += tokens[i] + "\t";

                    defaultDelim = (tokens.Length - 2); // Ideally, this should be the most frequest distribution of this number

                    resdict[tokens[1]][tokens[0]] = result;
                }

            var defaultStr = "";
            for (int i = 0; i < defaultDelim; i++)
                defaultStr += "XXX\t";

            foreach (var file in bpls)
            {
                var key = Util.GetFileName(file.Item1, config.root);
                if (!resdict.ContainsKey(key))
                    continue;

                output.Write("{0}\t", key);
                foreach (var u in config.Utils)
                {
                    if (!resdict[key].ContainsKey(u.name))
                        output.Write("{0}", defaultStr);
                    else
                        output.Write("{0}", resdict[key][u.name]);
                }
                output.WriteLine();
            }

            output.Close();
            log.Close();
            Console.WriteLine("Done");
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            log.Close();
            lock (Util.SpawnedProcesses)
            {
                foreach (var p in Util.SpawnedProcesses)
                    p.Kill();
                Util.SpawnedProcesses.Clear();
            }
            System.Diagnostics.Process.GetCurrentProcess()
                .Kill();
        }

        class Worker
        {
            public IEnumerable<string> textresult;
            public IEnumerable<string> fileresult;
            string[] args;
            string root;
            bool remote;

            public Worker(bool remote, string root, params string[] args)
            {
                textresult = new List<string>();
                fileresult = new List<string>();
                this.root = root;
                this.args = args;
                this.remote = remote;
            }

            public void Run()
            {
                textresult = remote ?
                    SpawnClientRemote(root, out fileresult, args) :
                    SpawnClient(root, out fileresult, args);
            }
        }

        static IEnumerable<string> SpawnClient(string root, out IEnumerable<string> fileresult, params string[] args)
        {
            var loc = System.IO.Path.Combine(root, "Binaries", "RunParClient.exe");

            var tmp = System.IO.Path.Combine(root, "run");
            if (!resume) Util.CleanDirectory(tmp);
            else System.IO.Directory.CreateDirectory(tmp);

            var flags =  root + " " + args.Aggregate("", ((s1, s2) => s1 + " " + s2));

            lock (log)
            {
                log.WriteLine("Running local client");
                log.WriteLine("Running {0} {1} {2}", tmp, loc, flags);
            }

            var outp =
                Util.run(tmp, loc, flags);

            fileresult = System.IO.Directory.GetFiles(tmp, "*.db");
            var resultsfile = System.IO.Path.Combine(tmp, "results.txt");
            var ex = System.IO.File.Exists(resultsfile);

            lock (log)
            {
                log.WriteLine("Local client:");
                outp.Iter(s => log.WriteLine("{0}", s));
                log.WriteLine("Found {0} *.db result files", fileresult.Count());
                if(!ex) log.WriteLine("Did not find a results.txt file");
            }
            
            if (!ex)
                return new List<string>();

            return System.IO.File.ReadAllLines(resultsfile);
        }

        static IEnumerable<string> SpawnClientRemote(string root, out IEnumerable<string> fileresult, params string[] args)
        {
            // find the name of the machine from the remote folder name
            var machine = "";
            var remoteroot = Util.GetRemoteFolder(root, out machine);

            var tmp = System.IO.Path.Combine(root, "run");
            var remotetmp = System.IO.Path.Combine(remoteroot, "run");
            if (!resume) Util.CleanDirectory(tmp); 
            else System.IO.Directory.CreateDirectory(tmp);
            
            // psexec machine -w remoteroot\run remoteroot\Binaries\RunParClient.exe remoteroot args
            var cmd = System.IO.Path.Combine(config.root, "pstools", "psexec.exe");
            var flags = string.Format("{0} -w {1} {2} {3} {4}",
                machine, remotetmp, System.IO.Path.Combine(remoteroot, "Binaries", "RunParClient.exe"), remoteroot, args.Aggregate("", (s1, s2) => s1 + " " + s2));

            lock (log)
            {
                log.WriteLine("Running remote client on {0}", root);
                log.WriteLine("Running {0} {1} {2}", config.root, cmd, flags);
            }


            var outp =
                Util.run(config.root, cmd, flags);

            fileresult = System.IO.Directory.GetFiles(tmp, "*.db");
            var resultsfile = System.IO.Path.Combine(tmp, "results.txt");
            var ex = System.IO.File.Exists(resultsfile);

            lock (log)
            {
                log.WriteLine("Remote client {0}:", root);
                outp.Iter(s => log.WriteLine("{0}", s));
                log.WriteLine("Found {0} *.db result files", fileresult.Count());
                if (!ex) log.WriteLine("Did not find a results.txt file");
            }
            
            if(!ex)
                return new List<string>();
            return System.IO.File.ReadAllLines(resultsfile);
        }

        static IEnumerable<string> GetResultFiles(string utilname, IEnumerable<Worker> workers)
        {
            var ret = new List<string>();
            foreach (var w in workers)
            {
                if (w.fileresult == null)
                    continue;
                ret.AddRange(w.fileresult.Where(s => System.IO.Path.GetFileName(s).StartsWith(utilname)));
            }
            return ret;
        }

        static void MergeResults(RunParUtil u, IEnumerable<Worker> workers, string outfile)
        {
            if (System.IO.File.Exists(outfile))
                System.IO.File.Delete(outfile);

            var files = GetResultFiles(u.name, workers);
            if (files.Count() == 0)
                return;

            Console.WriteLine("Merging results for {0} into {1}", u.name, outfile);
            // call the util
            Util.run(Environment.CurrentDirectory, System.IO.Path.Combine(config.root, u.value),
                u.arguments + " " + GlobalConfig.merge_flag + " " + files.Concat(" "));
            System.IO.File.Move(GlobalConfig.util_result_file, outfile);
        }
    }
}
