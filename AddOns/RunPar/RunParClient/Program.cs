using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommonLib;
using System.IO;
using System.Threading;

namespace RunParClient
{
    class Program
    {
        static System.Collections.Concurrent.ConcurrentQueue<WorkItem> work = new System.Collections.Concurrent.ConcurrentQueue<WorkItem>();
        static Dictionary<string, string> fileToResult = new Dictionary<string, string>();
        static long counter = 0;
        static StreamWriter log = null;
        static StreamWriter worklog = null;
        static RunParConfig config = null;
        static string resultsdir = "";
        static bool resume = false;

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("Usage: RunParClient.exe rootfolder");
                return;
            }

            var test = false;

            var root = args[0];
            if (args.Any(a => a == "/break"))
                System.Diagnostics.Debugger.Launch();
            if (args.Any(a => a == "/resume"))
                resume = true;
            if (args.Any(a => a == "/test"))
                test = true;

            // Get the config
            var configfile = Path.Combine(root, "config-client.xml");
            if (!File.Exists(configfile))
            {
                Console.WriteLine("Config file doesn't exist");
                return;
            }

            config = RunParConfig.DeSerialize(configfile);
            log = new StreamWriter("client.log", resume);
            log.AutoFlush = true;

            // Are we already running?
            var procs =
                System.Diagnostics.Process.GetProcessesByName(System.Diagnostics.Process.GetCurrentProcess().ProcessName);
            if (procs.Count() > 1)
            {
                log.WriteLine("Detected another instance of RunParClient running on the machine, aborting");
                log.Close();
                return;
            }

            var workcompleted = new Dictionary<string, string>();
            if (resume)
            {
                log.WriteLine("Resuming work from where we left off!");
                // Find the work that we've completed already
                // Format:
                // workitem1
                // result1
                // workitem2
                // result2
                // ...
                if (File.Exists("client.work.log"))
                {
                    var lines = new List<string>(File.ReadAllLines("client.work.log"));
                    lines.RemoveAll(s => s == "" || s == " ");
                    
                    for (int i = 0; i < lines.Count - 1; i+=2)
                    {
                        workcompleted[lines[i]] = lines[i + 1];
                    }
                }
            }

            worklog = new StreamWriter("client.work.log", resume);

            // Get the files
            var bpls = new List<Tuple<string, string>>();
            var filemaps = new List<string>();
            Util.ReadFiles(config, out bpls, out filemaps);

            // load up the work
            foreach (var u in config.Utils)
            {
                for (int i = 0; i < bpls.Count; i++)
                {
                    var key = string.Format("{0}\t{1}", u.name, Util.GetFileName(bpls[i].Item1, config.root));
                    var wi = new WorkItem(key, u.name, Path.Combine(config.root, u.value), bpls[i].Item1 + " " + u.arguments + " " + bpls[i].Item2);
                    if (workcompleted.ContainsKey(wi.ToString()))
                    {
                        fileToResult.Add(key, workcompleted[wi.ToString()]);
                        continue;
                    }
                    work.Enqueue(wi);
                    fileToResult.Add(key, null);
                }
            }

            log.WriteLine("Got {0} workitems", work.Count);

            #region Debugging
            if (test)
            {
                // Drop half the workitems -- for debugging
                var q = new System.Collections.Concurrent.ConcurrentQueue<WorkItem>();
                var n = (work.Count / 2) + 1;
                if(n > work.Count) n = work.Count;

                for (int i = 0; i < n; i++)
                {
                    WorkItem wi;
                    work.TryDequeue(out wi);
                    q.Enqueue(wi);
                }

                work = q;
            }
            #endregion

            resultsdir = Path.Combine(Environment.CurrentDirectory, "RunParResults");

            // delete the results directory, if one exists
            if(!resume && Directory.Exists(resultsdir))
                Directory.Delete(resultsdir, true);

            // create a results directory for each util
            foreach (var util in config.Utils)
            {
                var ud = Path.Combine(resultsdir, util.name);
                if(!resume && Directory.Exists(ud))  Util.CleanDirectory(ud);
                else Directory.CreateDirectory(ud);
            }
            log.WriteLine("Directories are in place");

            var threads = new List<Thread>();
            var numthreads = config.MaxThreads == 0 ? Environment.ProcessorCount - 1 : config.MaxThreads;
            for (int i = 0; i < numthreads; i++)
            {
                var worker = new Worker(i);
                threads.Add(new Thread(new ThreadStart(worker.Run)));
            }

            var outputThread = new Thread(new ThreadStart(DumpResults));

            // start threads
            threads.ForEach(t => t.Start());
            outputThread.Start();

            threads.ForEach(t => t.Join());

            outputThread.Interrupt();
            outputThread.Join();
            
            // put results together
            foreach (var util in config.Utils)
            {
                var ud = Path.Combine(resultsdir, util.name);
                if (!Directory.Exists(ud)) continue;

                log.WriteLine("Putting together results for {0}", util.name);

                Util.run(ud, Path.Combine(config.root, util.value),
                    util.arguments + " " + GlobalConfig.merge_flag + " " + ud);

                if (File.Exists(Path.Combine(ud, GlobalConfig.util_result_file)))
                    File.Move(Path.Combine(ud, GlobalConfig.util_result_file),
                        Path.Combine(Environment.CurrentDirectory, util.name + ".db"));
                else
                    log.WriteLine("Merge failed!");
            }

            worklog.Close();

            log.WriteLine("Parallel computation finished");
            log.Close(); 
        }

        static void DumpResults()
        {
            var done = false;

            while (!done)
            {
                try
                {
                    // sleep for 10 min
                    Thread.Sleep(10 * 60 * 1000);
                }
                catch (ThreadInterruptedException)
                {
                    done = true;
                }

                var output = new StreamWriter("results.txt");
                lock (fileToResult)
                {
                    foreach (var kvp in fileToResult)
                    {
                        if (kvp.Value == null) continue;
                        output.WriteLine("{0} {1}", kvp.Key, kvp.Value);
                    }
                }
                output.Close();
            }
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
            int id;

            public Worker(int id)
            {
                this.id = id;
            }

            public void Run()
            {
                var pwd = "build" + (id.ToString());
                if (!System.IO.Directory.Exists(pwd))
                    System.IO.Directory.CreateDirectory(pwd);
                
                while (true)
                {
                    WorkItem wi;
                    if (!work.TryDequeue(out wi))
                        break;

                    Util.CleanDirectory(pwd);

                    lock (log)
                    {
                        log.WriteLine("Thread {0} running {1} {2}", id, wi.cmd, wi.args);
                    }

                    var output = Util.run(Path.Combine(Environment.CurrentDirectory, pwd), wi.cmd, wi.args);

                    lock (fileToResult)
                    {
                        var ex = File.Exists(Path.Combine(pwd, GlobalConfig.util_result_file));

                        lock (log)
                        {
                            log.WriteLine("Thread {0} output:", id);
                            output.Iter(s => log.WriteLine("{0}", s));
                            if (!ex) log.WriteLine("Did not find a results file");
                        }

                        fileToResult[wi.key] = output.Concat(Environment.NewLine);
                        var result = fileToResult[wi.key];
                        if (result == "" || result.All(c => c == ' ')) result = "empty";
                        worklog.WriteLine("{0}{1}{2}", wi.ToString(), Environment.NewLine, result);
                        worklog.Flush();

                        if (ex)
                        {
                            counter++;
                            var target = Path.Combine("RunParResults", wi.utilname, string.Format("f{0}.db", counter));
                            while (resume && File.Exists(target))
                                target = Path.Combine("RunParResults", wi.utilname, string.Format("f{0}.db", ++counter));

                            File.Copy(Path.Combine(pwd, GlobalConfig.util_result_file), target);
                        }
                    }
                }

            }
        }


        class WorkItem
        {
            public string cmd;
            public string args;
            public string key;
            public string utilname;

            public WorkItem(string key, string utilname, string cmd, string args)
            {
                this.key = key;
                this.cmd = cmd;
                this.args = args;
                this.utilname = utilname;
            }

            public override string ToString()
            {
                return string.Format("{0}###{1}###{2}###{3}", cmd, args, key, utilname);
            }
        }
    }
}
