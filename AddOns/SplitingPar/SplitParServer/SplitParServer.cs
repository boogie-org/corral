using CommonLib;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SplitParServer
{
    class SplitParServer
    {
        static SplitParConfig config;
        static List<Socket> clients = new List<Socket>();
        static int maxClients = 1;

        static string remoteSystem = "RSE-SERVER-14"; 
        static string procSearch = "Notepad";

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

        enum CurrentState { AVAIL, BUSY };
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

        static void CloseConnection()
        {
            LogWithAddress.WriteLine(string.Format(Utils.CompletionMsg)); 
            foreach (var client in clients)
            {
                if (client != null)
                {
                    client.Send(Utils.EncodeStr(Utils.CompletionMsg));
                    client.Close();
                }
            }
        }

        static void InstallingClients()
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
            LogWithAddress.WriteLine(string.Format("Done"));

            // Do remote installation
            LogWithAddress.WriteLine(string.Format("Doing remote installation")); 
            foreach (var remote in config.RemoteRoots)
            {
                LogWithAddress.WriteLine(string.Format("Installing {0}", remote.value));
                Installer.RemoteInstall(config.root, remote.value, config.Utils.Select(u => u.dir).Distinct(), force, config.BoogieFiles); 
            }
            LogWithAddress.WriteLine(string.Format("Done"));
        }

        static void RunClients()
        {
            var threads = new List<Thread>();
            var workers = new List<CommonLib.Worker>();

            var starttime = DateTime.Now;
            Console.WriteLine("Spawning clients");

            // spawn client on own machine
            config.DumpClientConfig(config.root, System.IO.Path.Combine(config.root, Utils.RunDir, Utils.ClientConfig));
            var w0 = new Worker(config.root, false, Utils.ClientConfig);
            workers.Add(w0);
            threads.Add(new Thread(new ThreadStart(w0.Run)));

            // spawn client on remote machines
            foreach (var client in config.RemoteRoots)
            {
                config.DumpClientConfig(client.value, System.IO.Path.Combine(client.value, Utils.RunDir, Utils.ClientConfig));
                var w1 = new CommonLib.Worker(client.value, true, Utils.ClientConfig);
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
                    listener.Send(Utils.EncodeStr("Hi " + listener.RemoteEndPoint.ToString()));
                    clients.Add(listener);
                }
                catch (ArgumentNullException ane)
                {
                    LogWithAddress.WriteLine(string.Format("ArgumentNullException : {0}", ane.ToString()));
                }
                catch (SocketException se)
                {
                    LogWithAddress.WriteLine(string.Format("SocketException : {0}", se.ToString()));
                }
                catch (Exception e)
                {
                    LogWithAddress.WriteLine(string.Format("Unexpected exception : {0}", e.ToString()));
                }

            }
            catch
            {
                LogWithAddress.WriteLine(string.Format("Cannot connect to Server"));
            }

        }

        static void CreateConnection()
        {
            lock (LogWithAddress.debugOut)
            {
                LogWithAddress.WriteLine(string.Format("Set up connections"));
            }
            IPHostEntry ipHostInfo = Dns.Resolve(Dns.GetHostName());
            IPAddress ipAddress = ipHostInfo.AddressList[0];
            IPEndPoint localEndPoint = new IPEndPoint(ipAddress, Utils.ServerPort);


            Socket listener = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
             
            try
            {
                listener.Bind(localEndPoint);
                listener.Listen(10);

                while (clients.Count < maxClients)
                {
                    lock (LogWithAddress.debugOut)
                    {
                        LogWithAddress.WriteLine(string.Format("Waiting for a connection..."));
                    }
                    clients.Add(listener.Accept());
                    lock (LogWithAddress.debugOut)
                    {
                        LogWithAddress.WriteLine(string.Format("Connected"));
                    }
                    clients.ElementAt(clients.Count - 1).Send(Utils.EncodeStr("Hello " + clients.ElementAt(clients.Count - 1).RemoteEndPoint.ToString()));

                    // wait for the reply message
                    byte[] data = new byte[Utils.MsgSize];
                    int receivedDataLength = clients.ElementAt(clients.Count - 1).Receive(data); //Wait for the data
                    string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received

                    lock (LogWithAddress.debugOut)
                    {
                        LogWithAddress.WriteLine(string.Format("{0}", stringData)); //Write the data on the screen
                    }
                }
            }
            catch
            {
                lock (LogWithAddress.debugOut)
                {
                    LogWithAddress.WriteLine(string.Format("Error"));
                }
            }
        }

        static void MonitoringClients()
        {
            var threads = new List<Thread>();
            var workers = new List<ServerListener>();

            var starttime = DateTime.Now;
            LogWithAddress.WriteLine(string.Format("Spawning clients"));
            //Worker localWorker = new Worker(config.root, false);
            //localWorker.Run(); 

            // spawn client on own machine
            //config.DumpClientConfig(config.root, machineToFiles[0].Select(f => Util.GetFileName(f, config.root)), System.IO.Path.Combine(config.root, "config-client.xml"));
            //var w0 = new Worker(false, config.root, resume ? "/resume" : "", test ? "/test" : "");
            //workers.Add(w0);
            //threads.Add(new Thread(new ThreadStart(w0.Run)));


            //// spawn clients on remote machines 
            //foreach (var r in config.RemoteRoots)
            //{ 
            //    if (machineToFiles[rm].Count == 0)
            //        continue;
            //    config.DumpClientConfig(Util.GetRemoteFolder(r.value), machineToFiles[rm].Select(f => Util.GetFileName(f, config.root)), System.IO.Path.Combine(r.value, "config-client.xml"));
            //    var w1 = new Worker(true, r.value, resume ? "/resume" : "", test ? "/test" : "");
            //    threads.Add(new Thread(new ThreadStart(w1.Run)));
            //    workers.Add(w1);
            //}

            // start threads
            threads.ForEach(t => t.Start());
            threads.ForEach(t => t.Join());

            Console.WriteLine("Time taken = {0} seconds", (DateTime.Now - starttime).TotalSeconds.ToString("F2"));
        }

        static void MonitoringCorral()
        {
            var sep = new char[1];
            sep[0] = ':';
            var indent = new Func<int, string>(i =>
            {
                var ret = "";
                while (i > 0) { i--; ret += " "; }
                return ret;
            }); 

            string msg = "";
            while (!msg.Equals(Utils.CompletionMsg))
            {
                byte[] data = new byte[Utils.MsgSize];
                int receivedDataLength = clients.ElementAt(0).Receive(data); //Wait for the data
                msg = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received
                if (msg.Equals(Utils.CompletionMsg))
                    break;
                var split = msg.Split(sep);
                if (split.Length > 1)
                {
                    LogWithAddress.WriteLine(string.Format(indent(int.Parse(split[0])) + ">>> " + split[1])); //Write the data on the screen
                }
            }
            LogWithAddress.WriteLine(string.Format("{0}", msg));
        }

        static void ServerController()
        {            
            InstallingClients();
            RunClients();
            if (true)
            {
                string localIP = Utils.LocalIP();
                if (localIP != null)
                {
                    ConnectClient(localIP);
                    foreach (var client in config.RemoteRoots)
                    {
                        string tmp = Utils.GetRemoteMachineName(client.value);
                        LogWithAddress.WriteLine(string.Format("Machine name: {0}", tmp));
                        //ConnectClient(tmp);
                    }
                }
                else
                    new Exception(string.Format("Cannot get local IP"));
            }
            else
            {
                CreateConnection();
            }
            //MonitoringClients();
            CloseConnection();
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            LogWithAddress.Close();
            lock (Utils.SpawnedProcesses)
            {
                foreach (var p in Utils.SpawnedProcesses)
                    p.Kill();
                Utils.SpawnedProcesses.Clear();
            }
            System.Diagnostics.Process.GetCurrentProcess().Kill();
        }

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;
            Debug.Assert(args.Length > 0);
            config = Utils.LoadConfig(args[0]);
            ServerController();
            LogWithAddress.Close();
            Console.ReadKey();
        }
    }
}
