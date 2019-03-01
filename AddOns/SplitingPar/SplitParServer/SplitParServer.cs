using CommonLib;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Management;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SplitParServer
{
    public class SplitParServer
    {
        public static Dictionary<string, Utils.CurrentState> ClientStates = new Dictionary<string, Utils.CurrentState>();
        public static List<BplTask> BplTasks = new List<BplTask>();
        static Dictionary<string, int> socketMap = new Dictionary<string, int>();
        static SplitParConfig config;
        static List<Socket> clients = new List<Socket>();

        static int numberOfClients = 1;
        static bool testWithoutServer = false;
        static bool testWithoutCorral = false;
        static bool useLocalMachine = false;
        static bool started = false;
        static bool saveLog = false;
        public static TimeGraph timeGraph;

        public static double totalQueryTime = 0;

        public enum Outcome
        {
            Correct,
            Errors,
            TimedOut,
            OutOfResource,
            OutOfMemory,
            Inconclusive,
            ReachedBound
        }

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            #region for testing purposes
            for (int i = 0; i < args.Length; ++i)
            {
                if (args[i].Equals(Utils.NoServer))
                    testWithoutServer = true;
                else if (args[i].Equals(Utils.NoCorral))
                    testWithoutCorral = true;
                else if (args[i].Equals(Utils.UseLocal))
                    useLocalMachine = true;
                else if (args[i].Equals(Utils.SaveResult))
                    saveLog = true;
            }
            #endregion

            config = Utils.LoadConfig(args[0]);
            LogWithAddress.init(System.IO.Path.Combine(config.root, Utils.RunDir));
            ServerController();
            LogWithAddress.Close();
            //Console.ReadKey();
        }

        static void ServerController()
        {
            var startTime = DateTime.Now;
            numberOfClients = config.RemoteRoots.Count;
            timeGraph = new TimeGraph(Utils.Server, config.root);
            InstallClients();
            RefreshClients();
            SpawnClients();

            string localIP = Utils.LocalIP();
            if (localIP != null)
            {
                if (useLocalMachine)
                {
                    // connect local client
                    ConnectClient(localIP);
                    socketMap[config.root] = clients.Count - 1;
                }
                // connect remote clients
                foreach (var client in config.RemoteRoots)
                {
                    string tmp = Utils.GetRemoteMachineName(client.value);
                    ConnectClient(tmp);
                    socketMap[client.value] = clients.Count - 1;
                    LogWithAddress.WriteLine(string.Format("Machine name: {0}", tmp));
                }

                if (!started)
                {
                    started = true;
                    if (useLocalMachine)
                    {
                        SendFirstMsgToLocalClient();
                    }
                    else
                    {
                        SendFirstMsgToRemoteClient();
                    }
                }
            }
            else
                new Exception(string.Format("Cannot get local IP"));

            double setupTime = (DateTime.Now - startTime).TotalSeconds;
            Console.WriteLine("Setting up time = {0} seconds", setupTime.ToString("F2"));

            startTime = DateTime.Now;
            string result = MonitorClients();
            double runningTime = (DateTime.Now - startTime).TotalSeconds;

            if (saveLog)
                WriteStatistics(config.BoogieFiles[0].value, runningTime, ClientStates.Count, result);
            LogWithAddress.WriteLine(string.Format("Total query files time: {0}", totalQueryTime.ToString("F2")));
            LogWithAddress.Close();
            timeGraph.ToDot();
        }


        static void InstallClients()
        {
            var force = true;
            LogWithAddress.WriteLine(string.Format("Checking self installation"));
            try
            {
                Installer.CheckSelfInstall(config);
            }
            catch (Exception e)
            {
                LogWithAddress.WriteLine(string.Format("{0}", e.Message));
                return;
            }

            // local machine
            if (useLocalMachine)
                ClientStates[config.root] = Utils.CurrentState.AVAIL;

            // Do remote installation
            LogWithAddress.WriteLine(string.Format("Doing remote installation"));
            for (int i = 0; i < config.RemoteRoots.Count; ++i)
            {
                ClientStates[config.RemoteRoots[i].value] = Utils.CurrentState.AVAIL;
                LogWithAddress.WriteLine(string.Format("Installing {0}", config.RemoteRoots[i].value));
                Installer.RemoteInstall(config.root, config.RemoteRoots[i].value, config.Utils.Select(u => u.dir).Distinct(), force, config.BoogieFiles);
            }
            LogWithAddress.WriteLine(string.Format("Installation Finished."));
        }

        static void RefreshClients()
        {
            ForceClose();
        }

        static void SpawnClients()
        {
            var threads = new List<Thread>();
            var workers = new List<Worker>();

            var starttime = DateTime.Now;
            Console.WriteLine("Spawning clients");


            var configDir = System.IO.Path.Combine(config.root, Utils.RunDir, Utils.ClientConfig);
            if (useLocalMachine)
            {
                // spawn client on own machine 
                config.DumpClientConfig(config.root, configDir, config.BoogieFiles);
                var w0 = new Worker(config.root, false, configDir);
                workers.Add(w0);
                threads.Add(new Thread(new ThreadStart(w0.Run)));
            }

            // spawn client on remote machines
            for (int i = 0; i < config.RemoteRoots.Count; ++i)
            {
                string clientRoot = config.RemoteRoots[i].value;
                configDir = System.IO.Path.Combine(clientRoot, Utils.RunDir, Utils.ClientConfig);
                config.DumpClientConfig(clientRoot, configDir, config.BoogieFiles);
                var w1 = new Worker(clientRoot, true, configDir);
                threads.Add(new Thread(new ThreadStart(w1.Run)));
                workers.Add(w1);
            }
            // start threads
            threads.ForEach(t => t.Start());
        }

        static void ConnectClient(string hostName)
        {
            try
            {
                IPHostEntry ipHostInfo = Dns.Resolve(hostName);
                IPAddress ipAddress = ipHostInfo.AddressList[0];
                IPEndPoint remoteEP = new IPEndPoint(ipAddress, Utils.ServerPort);

                while (true)
                {
                    Socket listener = new Socket(AddressFamily.InterNetwork,
                        SocketType.Stream, ProtocolType.Tcp);
                    try
                    {
                        listener.Connect(remoteEP);

                        LogWithAddress.WriteLine(string.Format("Socket connected {0}", listener.RemoteEndPoint.ToString()));

                        byte[] data = new byte[Utils.MsgSize];
                        int receivedDataLength = listener.Receive(data); //Wait for the data
                        string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received
                        LogWithAddress.WriteLine(string.Format("{0}", stringData)); //Write the data on the screen

                        // reply the client
                        listener.Send(Utils.EncodeStr("Welcome " + listener.RemoteEndPoint.ToString()));

                        clients.Add(listener);
                        break;
                    }
                    catch (SocketException se)
                    {
                        LogWithAddress.WriteLine(string.Format("Not connected yet."));
                        Thread.Sleep(Utils.SleepTime);
                    }
                    catch (Exception e)
                    {
                        LogWithAddress.WriteLine(string.Format("Unexpected exception : {0}", e.ToString()));
                    }
                }
            }
            catch (Exception e)
            {
                LogWithAddress.WriteLine(string.Format("Cannot connect to SplitParClient {0}", e.ToString()));
            }

        }

        static void CreateConnection()
        {
            LogWithAddress.WriteLine(string.Format("Set up connections"));
            IPHostEntry ipHostInfo = Dns.Resolve(Dns.GetHostName());
            IPAddress ipAddress = ipHostInfo.AddressList[0];
            IPEndPoint localEndPoint = new IPEndPoint(ipAddress, Utils.ServerPort);


            Socket listener = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            try
            {
                listener.Bind(localEndPoint);
                listener.Listen(10);

                while (clients.Count < numberOfClients)
                {
                    LogWithAddress.WriteLine(string.Format("Waiting for a connection..."));
                    clients.Add(listener.Accept());
                    LogWithAddress.WriteLine(string.Format("Connected"));
                    clients.ElementAt(clients.Count - 1).Send(Utils.EncodeStr("Hello " + clients.ElementAt(clients.Count - 1).RemoteEndPoint.ToString()));

                    // wait for the reply message
                    byte[] data = new byte[Utils.MsgSize];
                    int receivedDataLength = clients.ElementAt(clients.Count - 1).Receive(data); //Wait for the data
                    string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received

                    LogWithAddress.WriteLine(string.Format("{0}", stringData)); //Write the data on the screen
                }
            }
            catch
            {
                LogWithAddress.WriteLine(string.Format("Error"));
            }
        }

        static string MonitorClients()
        {
            var threads = new List<Thread>();
            var workers = new List<ServerListener>();

            var starttime = DateTime.Now;
            LogWithAddress.WriteLine(string.Format("Monitoring clients"));

            for (int i = 0; i < clients.Count; ++i)
            {
                if (useLocalMachine)
                {
                    if (i == 0)
                    {
                        var listener = new ServerListener(clients[i], config.root);
                        threads.Add(new Thread(new ThreadStart(listener.Listen)));
                        workers.Add(listener);
                    }
                    else
                    {
                        var listener = new ServerListener(clients[i], config.RemoteRoots[i - 1].value);
                        threads.Add(new Thread(new ThreadStart(listener.Listen)));
                        workers.Add(listener);

                    }
                }
                else
                {
                    var listener = new ServerListener(clients[i], config.RemoteRoots[i].value);
                    threads.Add(new Thread(new ThreadStart(listener.Listen)));
                    workers.Add(listener);
                }
            }

            //threads.Add(new Thread(new ThreadStart(TaskDelivery)));
            // start threads & join
            threads.ForEach(t => t.Start());
            threads.ForEach(t => t.Join());

            string bugAddress = "";
            string result = ExtractResult(workers, out bugAddress);

            if (bugAddress.Length > 0)
                Console.WriteLine("Return status: {0} @ {1}", result, bugAddress);
            else
                Console.WriteLine("Return status: {0}", result);
            Console.WriteLine("Verification time = {0} seconds", (DateTime.Now - starttime).TotalSeconds.ToString("F2"));
            return result;
        }

        static string ExtractResult(List<ServerListener> workers, out string bugAddress)
        {
            string result = "OK";
            bugAddress = "";
            foreach (var worker in workers)
            {
                if (worker.currentResult.Equals("NOK"))
                {
                    result = worker.currentResult;
                    bugAddress = worker.clientAddress;
                    break;
                }
                else if (worker.currentResult.Equals("RB"))
                {
                    result = worker.currentResult;
                    bugAddress = worker.clientAddress;
                }
            }
            return result;
        }

        static void WriteStatistics(string fileName, double runningTime, int clients, string result)
        {
            Thread.Sleep(5000);
            var path = System.IO.Path.Combine(config.root, Utils.RunDir, Utils.TableResult);
            using (StreamWriter sw = File.AppendText(path))
            {
                List<ClientStats> allStats = new List<ClientStats>();
                foreach (var client in ClientStates)
                {
                    // copy log file
                    try
                    {
                        Installer.CopyFile(System.IO.Path.Combine(client.Key, Utils.RunDir, Utils.ClientStats), System.IO.Path.Combine(config.root, Utils.RunDir, Utils.ClientStats));

                        // read file
                        ClientStats stats = ClientStats.DeSerialize(System.IO.Path.Combine(config.root, Utils.RunDir, Utils.ClientStats));
                        stats.Name = Utils.GetRemoteMachineName(client.Key);
                        allStats.Add(stats);

                        // remove log file
                        File.Delete(System.IO.Path.Combine(config.root, Utils.RunDir, Utils.ClientStats));
                    }
                    catch (Exception)
                    {
                    }
                }

                double z3Time = 0, waitingTime = 0, inliningTime = 0, decisionTime = 0;
                foreach (var stats in allStats)
                {
                    z3Time += stats.MustReachParallelTime.Z3Time;
                    decisionTime += stats.MustReachParallelTime.SIDecisionsTime;
                    waitingTime += stats.TotalTime.WaitingTime;
                    inliningTime += stats.InliningCallTreesTime;
                }
                sw.WriteLine(string.Format("{0}, {1, 50}, {2, 10}, {3, 15}, {4, 10}, {5, 10}, {6, 10}, {7, 10}, {8, 10}",
                            DateTime.Now.ToString(), fileName, runningTime.ToString("F2") + "s", clients + " clients", result,
                            z3Time.ToString("F2"),
                            waitingTime.ToString("F2"),
                            decisionTime.ToString("F2"),
                            inliningTime.ToString("F2")
                            ));
                foreach (var stats in allStats)
                {
                    sw.WriteLine(string.Format("{0}, {1, 50}, {2, 10}, {3, 15}, {4, 10}, {5, 10}, {6, 10}, {7, 10}, {8, 10}, {9, 10}, {10}",
                            "", "", "", "", "",
                            stats.MustReachParallelTime.Z3Time.ToString("F2"),
                            stats.TotalTime.WaitingTime.ToString("F2"),
                            stats.MustReachParallelTime.SIDecisionsTime.ToString("F2"),
                            stats.InliningCallTreesTime.ToString("F2"),
                            stats.TotalTasks,
                            stats.Name));
                }
            }
        }

        static void SendFirstMsgToLocalClient()
        {
            lock (ClientStates)
            {
                ClientStates[config.root] = Utils.CurrentState.BUSY;
            }

            // local client is working
            clients[0].Send(Utils.EncodeStr(Utils.StartMsg));

        }

        static void SendFirstMsgToRemoteClient()
        {
            timeGraph.AddEdge(Utils.Server,
                                Utils.GetRemoteMachineName(config.RemoteRoots[config.RemoteRoots.Count - 1].value),
                                "",
                                DateTime.Now);
            lock (ClientStates)
            {
                ClientStates[config.RemoteRoots[config.RemoteRoots.Count - 1].value] = Utils.CurrentState.BUSY;
            }

            clients[clients.Count - 1].Send(Utils.EncodeStr(Utils.StartMsg));
        }

        static void TransferFiles(string folderDir, string folder, string remoteFolder)
        {
            LogWithAddress.WriteLine(string.Format("Copying folder {0} to {1}", folder, remoteFolder));
            var files = System.IO.Directory.GetFiles(System.IO.Path.Combine(folderDir, folder));
            foreach (var file in files)
            {
                var remotefile = System.IO.Path.Combine(remoteFolder, folder, System.IO.Path.GetFileName(file));
                if (!System.IO.File.Exists(remotefile))
                {
                    System.IO.Directory.CreateDirectory(System.IO.Path.Combine(remoteFolder, folder));
                    System.IO.File.Copy(file, remotefile, true);
                    File.SetAttributes(remotefile, FileAttributes.Normal);
                }
            }
        }

        static bool PingClient(int clientID)
        {
            clients.ElementAt(clientID).Send(Utils.EncodeStr(Utils.PingMsg));

            // wait for the reply message
            byte[] data = new byte[1024];
            int receivedDataLength = clients.ElementAt(clientID).Receive(data); //Wait for the data
            string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received
            if (stringData.Equals(Utils.ReadyMsg))
                return true;
            else
                return false;
        }

        static Outcome ListenToCompletion(int clientID)
        {
            byte[] data = new byte[1024];
            int receivedDataLength = clients.ElementAt(clientID).Receive(data); //Wait for the data
            string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received
            if (stringData.Contains(Utils.CorrectMsg))
                return Outcome.Correct;
            else if (stringData.Contains(Utils.ErrorMsg))
                return Outcome.Errors;
            else if (stringData.Contains(Utils.ReachedBoundMsg))
                return Outcome.ReachedBound;
            else if (stringData.Contains(Utils.TimedoutMsg))
                return Outcome.TimedOut;
            else if (stringData.Contains(Utils.OutOfMemoryMsg))
                return Outcome.OutOfMemory;
            else
                return Outcome.OutOfResource;
        }

        public static void TaskDelivery()
        {
            while (true)
            {
                int taskCount = 0;
                lock (BplTasks)
                {
                    taskCount = BplTasks.Count;
                }
                if (taskCount > 0)
                {
                    Dictionary<string, Utils.CurrentState> localClientStates;
                    lock (ClientStates)
                    {
                        localClientStates = new Dictionary<string, Utils.CurrentState>(ClientStates);
                    }
                    foreach (var client in localClientStates)
                        if (client.Value == Utils.CurrentState.AVAIL &&
                            !BplTasks[0].author.Equals(client.Key))
                        {
                            lock (BplTasks)
                            {
                                BplTask topTask = BplTasks[0];
                                string callTreeDir = System.IO.Path.Combine(topTask.author, Utils.RunDir, System.IO.Path.GetFileName(topTask.callTreeDir));
                                // let him do the first task
                                if (System.IO.File.Exists(callTreeDir))
                                {
                                    LogWithAddress.WriteLine(string.Format("Transfer {0} to {1}", topTask.ToString(), client.Key));

                                    // pick the task from a client
                                    // if localClient is the one

                                    if (client.Key.Equals(config.root))
                                    {
                                        string dir = System.IO.Path.Combine(config.root, Utils.RunDir, System.IO.Path.GetFileName(callTreeDir));
                                        if (System.IO.File.Exists(dir))
                                            System.IO.File.Delete(dir);
                                        System.IO.File.Move(callTreeDir, dir);
                                    }
                                    else
                                    {
                                        if (System.IO.File.Exists(callTreeDir))
                                        {
                                            string dir = System.IO.Path.Combine(client.Key, Utils.RunDir, System.IO.Path.GetFileName(callTreeDir));
                                            // find remote client
                                            if (System.IO.File.Exists(dir))
                                                System.IO.File.Delete(dir);
                                            System.IO.File.Move(callTreeDir, dir);
                                        }
                                    }

                                    // mark him busy
                                    lock (ClientStates)
                                    {
                                        ClientStates[client.Key] = Utils.CurrentState.BUSY;
                                    }

                                    // remove the task
                                    BplTasks.RemoveAt(0);

                                    // send the task to client
                                    clients[socketMap[client.Key]].Send(Utils.EncodeStr(Utils.StartWithCallTreeMsg + System.IO.Path.GetFileName(callTreeDir)));
                                }
                                else
                                {
                                    // remove the task
                                    BplTasks.RemoveAt(0);
                                }
                            }


                        }
                }
                lock (ClientStates)
                {
                    if (!ClientStates.Any(client => client.Value == Utils.CurrentState.BUSY))
                        break;
                }
            }
            foreach (var c in clients)
            {
                c.Send(Utils.EncodeStr(Utils.DoneMsg));
            }
        }

        public static bool areClientsAvail()
        {
            lock (ClientStates)
            {
                if (ClientStates.Any(client => client.Value == Utils.CurrentState.AVAIL))
                    return true;
            }

            return false;
        }

        public static bool areClientsWorking()
        {
            lock (ClientStates)
            {
                if (ClientStates.Any(client => client.Value == Utils.CurrentState.BUSY))
                    return true;
            }

            return false;
        }

        public static bool areTasksAvail()
        {
            lock (BplTasks)
            {
                if (BplTasks.Count > 0)
                    return true;
            }

            return false;
        }

        public static void SendDoneMsg()
        {
            foreach (var c in clients)
            {
                if (Utils.SocketConnected(c))
                    c.Send(Utils.EncodeStr(Utils.DoneMsg));
            }
        }

        static bool CheckIfRunning(string remoteMachine, string app)
        {
            return System.Diagnostics.Process.GetProcessesByName(app, remoteMachine).Length > 0 ? true : false;
        }

        static void StopProcess(string remoteMachine, string processName)
        {
            ManagementScope scope = new ManagementScope(string.Format("\\\\{0}\\root\\cimv2", remoteMachine));
            scope.Connect();

            // WMI query
            var query = new SelectQuery("select * from Win32_process where name = '" + processName + "'");

            using (var searcher = new ManagementObjectSearcher(scope, query))
            {
                foreach (ManagementObject process in searcher.Get())
                {
                    try
                    {
                        process.InvokeMethod("Terminate", null);
                    }
                    catch (Exception)
                    {
                        LogWithAddress.WriteLine(LogWithAddress.Debug, "Cannot terminate {0} at {1}", remoteMachine, processName);
                    }
                }
            }
        }

        public static void ForceClose()
        {
            lock (ClientStates)
            {
                foreach (var c in ClientStates)
                {
                    string remoteMachine = Utils.GetRemoteMachineName(c.Key);
                    // kill Z3
                    StopProcess(remoteMachine, "Z3.exe");
                    // kill Corral        
                    StopProcess(remoteMachine, "corral.exe");
                    // kill SplitParClient
                    StopProcess(remoteMachine, "SplitParClient.exe");
                    // kill pstool
                    StopProcess(remoteMachine, "PsExec Service");
                }
            }
        }

        public static void DeliverOneTask()
        {
            LogWithAddress.WriteLine(string.Format("Task size: {0}", BplTasks.Count));
            lock (ClientStates)
            {
                foreach (var client in ClientStates.ToList())
                {
                    if (client.Value == Utils.CurrentState.AVAIL)
                    {
                        var startTime = DateTime.Now;
                        string callTreeName = "";
                        BplTask topTask = null;
                        while (true)
                        {
                            lock (BplTasks)
                            {
                                if (BplTasks.Count > 0)
                                {
                                    topTask = BplTasks[0];
                                    BplTasks.RemoveAt(0);
                                }
                                else
                                    break;
                            }

                            callTreeName = Path.GetFileName(topTask.callTreeDir);
                            string callTreeDir = System.IO.Path.Combine(topTask.author, Utils.RunDir, callTreeName);
                            // let him do the first task
                            if (System.IO.File.Exists(callTreeDir))
                            {
                                // pick the task from a client
                                // if localClient is the one
                                if (client.Key.Equals(config.root))
                                {
                                    // all calltree files have different names
                                    string dir = System.IO.Path.Combine(config.root, Utils.RunDir, callTreeName);
                                    try
                                    {
                                        System.IO.File.Move(callTreeDir, dir);
                                        LogWithAddress.WriteLine(string.Format("Transfer {0} to {1}", topTask.ToString(), client.Key));
                                        break;
                                    }
                                    catch (Exception)
                                    {
                                        LogWithAddress.WriteLine(string.Format("Cannot move file {0} to {1}", callTreeDir, dir));
                                        callTreeName = "";
                                    }
                                }
                                else
                                {
                                    var queryFileStart = DateTime.Now;
                                    if (System.IO.File.Exists(callTreeDir))
                                    {
                                        // all calltree files have different names
                                        string dir = System.IO.Path.Combine(client.Key, Utils.RunDir, callTreeName);
                                        try
                                        {
                                            System.IO.File.Move(callTreeDir, dir);
                                            LogWithAddress.WriteLine(string.Format("Transfer {0} to {1}", topTask.ToString(), client.Key));
                                            break;
                                        }
                                        catch (Exception)
                                        {
                                            LogWithAddress.WriteLine(string.Format("Cannot move file {0} t0 {1}", topTask.ToString(), dir));
                                            callTreeName = "";
                                        }
                                    }
                                    totalQueryTime += (DateTime.Now - queryFileStart).TotalSeconds;
                                }
                            }
                        }

                        if (callTreeName.Length > 0 && System.IO.File.Exists(System.IO.Path.Combine(client.Key, Utils.RunDir, callTreeName)))
                        {
                            // mark him busy 
                            ClientStates[client.Key] = Utils.CurrentState.BUSY;

                            // send the task to client
                            if (Utils.SocketConnected(clients[socketMap[client.Key]]))
                            {
                                clients[socketMap[client.Key]].Send(Utils.EncodeStr(Utils.StartWithCallTreeMsg + callTreeName));
                                LogWithAddress.WriteLine(string.Format("Request sent to {0}: {1}", client.Key, callTreeName));
                            }

                            string sender = Utils.GetRemoteMachineName(topTask.author);
                            string receiver = Utils.GetRemoteMachineName(client.Key);
                            lock (SplitParServer.timeGraph)
                            {
                                SplitParServer.timeGraph.AddEdge(sender, receiver, callTreeName, startTime);
                            }
                        }

                        if (BplTasks.Count == 0)
                            break;
                    }
                }
            }

        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            LogWithAddress.Close();
            lock (Utils.SpawnedProcesses)
            {
                ForceClose();
                Utils.SpawnedProcesses.Clear(); 
            }
            System.Diagnostics.Process.GetCurrentProcess().Kill();
        }
    }
}
