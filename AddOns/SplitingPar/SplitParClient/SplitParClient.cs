using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using CommonLib;
using System.Threading.Tasks;
using System.Threading;

namespace SplitParClient
{
    enum CurrentState { AVAIL, BUSY };
    class SplitParClient
    {
        static System.Collections.Concurrent.ConcurrentQueue<WorkItem> work = new System.Collections.Concurrent.ConcurrentQueue<WorkItem>();
        static CurrentState state = CurrentState.AVAIL;
        static Socket serverConnection;
        static Socket corralConnection;
        static HashSet<string> jobList = new HashSet<string>();
        static SplitParConfig config;
        static bool testWithoutServer = false;
        static bool testWithoutCorral = false;

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            #region for testing purposes
            for (int i = 0; i < args.Length; ++i)
                if (args[i].Equals(Utils.NoServer))
                    testWithoutServer = true;
                else if (args[i].Equals(Utils.NoCorral))
                    testWithoutCorral = true;
            #endregion

            config = Utils.LoadConfig(args[0]);
            LogWithAddress.init(System.IO.Path.Combine(config.root, Utils.RunDir));
            ClientController(args);
            LogWithAddress.Close();
        }

        static void ClientController(params string[] args)
        {
            double workingTime = 0;

            if (false)
            {
                #region do not use it
                //Debug.Assert(args.Length > 0);
                //ConnectServer(args[0]);
                #endregion
            }
            else
            {
                if (!testWithoutServer)
                    ConnectServer();
            }

            if (!testWithoutCorral)
            {
                if (!Utils.SocketConnected(corralConnection))
                {
                    StartCorral();
                }
                Thread.Sleep(Utils.SleepTime);
            }

            ConnectCorral();
            var startClientTime = DateTime.Now;

            string msg = Utils.StartWithCallTreeMsg + "10split.txt";
            int cnt = 0;
            while (msg != Utils.DoneMsg)
            {
                cnt = cnt + 1;
                // wait for a message
                if (!testWithoutServer)
                {
                    // wait for the data from server
                    byte[] data = new byte[Utils.MsgSize];
                    int receivedDataLength = serverConnection.Receive(data);
                    msg = Encoding.ASCII.GetString(data, 0, receivedDataLength);
                    LogWithAddress.WriteLine(LogWithAddress.Debug, string.Format("{0}", msg));
                }

                if (msg.Contains(Utils.DoneMsg))
                {
                    // receive a shutdown signal                       
                    // tell server that he doesnt need to wait
                    LogWithAddress.WriteLine(LogWithAddress.Debug, string.Format("Total tasks: {0}", cnt - 1));
                    if (!testWithoutServer)
                        serverConnection.Send(Utils.EncodeStr(Utils.DoneMsg));
                    corralConnection.Send(Utils.EncodeStr(Utils.DoneMsg));
                }
                else if (msg.Contains(Utils.StartMsg))
                {
                    var startTime = DateTime.Now;
                    // receive a working signal
                    if (!msg.Equals(Utils.StartMsg))
                    {
                        // start with call tree
                        var sep = new char[1];
                        sep[0] = ':';
                        var split = msg.Split(sep);

                        if (split.Length > 1)
                        {
                            Debug.Assert(config.Utils.Count == 1);
                            config.Utils[0].arguments = config.Utils[0].arguments;
                            //config.Utils[0].arguments = config.Utils[0].arguments + " /prevSIState:" + split[1];
                        }
                    }
                    LogWithAddress.WriteLine(string.Format("Received a task."));

                    // give corral a task
                    SendTask(msg);
                    string result = MonitorCorral();
                    workingTime += (DateTime.Now - startTime).TotalSeconds;

                    // send completion msg to server 
                    if (!testWithoutServer)
                        serverConnection.Send(Utils.EncodeStr(result));
                    else
                    {
                        // testing purpose
                        switch (cnt)
                        {
                            case 3:
                                msg = Utils.StartWithCallTreeMsg + "12_4_5split.txt";
                                break;
                            case 1:
                                msg = Utils.StartWithCallTreeMsg + "12split.txt";
                                break;
                            case 2:
                                msg = Utils.StartWithCallTreeMsg + "12_4_5split.txt";
                                break;
                            case 4:
                                msg = Utils.StartWithCallTreeMsg + "9split.txt";
                                break;
                            case 6:
                                msg = Utils.StartWithCallTreeMsg + "90split.txt";
                                break;
                            case 7:
                                msg = Utils.StartWithCallTreeMsg + "98split.txt";
                                break;
                            default:
                                msg = Utils.DoneMsg;
                                corralConnection.Send(Utils.EncodeStr(Utils.DoneMsg));
                                break;
                        }
                    }
                }
            }

            double runningTime = (DateTime.Now - startClientTime).TotalSeconds;
            AppendStats(workingTime, runningTime - workingTime, runningTime);
            if (corralConnection != null && corralConnection.Connected)
            {
                corralConnection.Close();
            }
            LogWithAddress.Close();
        }

        static void ConnectServer()
        {
            LogWithAddress.WriteLine(string.Format("Connecting server"));
            IPHostEntry ipHostInfo = Dns.Resolve(Dns.GetHostName());
            IPAddress ipAddress = ipHostInfo.AddressList[0];
            IPEndPoint localEndPoint = new IPEndPoint(ipAddress, Utils.ServerPort);


            serverConnection = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            try
            {
                serverConnection.Bind(localEndPoint);
                serverConnection.Listen(10);

                LogWithAddress.WriteLine(string.Format("Waiting for a connection..."));
                serverConnection = serverConnection.Accept();
                LogWithAddress.WriteLine(string.Format("Connected"));
                serverConnection.Send(Utils.EncodeStr("Hello " + serverConnection.RemoteEndPoint.ToString() + " from " + Dns.GetHostName().ToString()));

                // wait for the reply message
                byte[] data = new byte[Utils.MsgSize];
                int receivedDataLength = serverConnection.Receive(data);
                string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength);
                LogWithAddress.WriteLine(string.Format("{0}", stringData));
            }
            catch
            {
                LogWithAddress.WriteLine(string.Format("Error"));
            }
        }

        static void ConnectServer(string ipHost)
        {
            try
            {

                IPHostEntry ipHostInfo = Dns.Resolve(ipHost);
                IPAddress ipAddress = ipHostInfo.AddressList[0];
                IPEndPoint remoteEP = new IPEndPoint(ipAddress, Utils.ServerPort);


                serverConnection = new Socket(AddressFamily.InterNetwork,
                    SocketType.Stream, ProtocolType.Tcp);
                try
                {
                    serverConnection.Connect(remoteEP);

                    LogWithAddress.WriteLine(string.Format("Socket connected {0}", serverConnection.RemoteEndPoint.ToString()));

                    byte[] data = new byte[Utils.MsgSize];
                    int receivedDataLength = serverConnection.Receive(data); //Wait for the data
                    string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength);
                    LogWithAddress.WriteLine(string.Format("{0}", stringData));

                    // reply the server
                    serverConnection.Send(Utils.EncodeStr("Hi " + serverConnection.RemoteEndPoint.ToString()));
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

        static string MonitorCorral()
        {
            var sep = new char[1];
            sep[0] = ':';

            var sep01 = new char[1];
            sep01[0] = ';';

            string msg = "";
            string refinedMsg = "";
            while (!msg.Contains(Utils.CompletionMsg))
            {
                //Wait for the data from corral
                byte[] data = new byte[Utils.MsgSize];
                int receivedDataLength = corralConnection.Receive(data);
                msg = Encoding.ASCII.GetString(data, 0, receivedDataLength);
                refinedMsg = "";

                if (msg.Contains(Utils.ErrorMsg))
                {
                    serverConnection.Send(Utils.EncodeStr(msg));
                    Debug.Assert(false);
                }
                else if (msg.Contains(Utils.CompletionMsg))
                {
                    // we dont close because it will be used for future msg 
                    refinedMsg = msg;
                    jobList.Clear();
                    break;
                } 

                var sepMsg = msg.Split(sep01);
                
                foreach (var s in sepMsg)
                {
                    var split = s.Split(sep);

                    if (split.Length > 1)
                    {
                        if (split[0].Contains(Utils.DoingMsg))
                        {
                            LogWithAddress.WriteLine(string.Format(Utils.DoingMsg + ":" + split[1]));
                            if (jobList.Contains(split[1]))
                            {
                                // seems to be redundant
                                refinedMsg = refinedMsg + Utils.DoingMsg + ":" + split[1] + ";";
                                jobList.Remove(split[1]);
                            }
                        }
                        else
                        { 
                            // seems to be redundant
                            refinedMsg = refinedMsg + split[0] + ":" + split[1] + ";";

                            // log data
                            LogWithAddress.WriteLine(string.Format(Utils.Indent(int.Parse(split[0])) + ">>> " + split[1]));
                            jobList.Add(split[1]);
                        }
                    }
                }

                if (!testWithoutServer && refinedMsg.Length > 0)
                    serverConnection.Send(Utils.EncodeStr(refinedMsg));
            }
            LogWithAddress.WriteLine(string.Format("{0}", refinedMsg));
            return refinedMsg;
        }

        void SpawnCorral()
        {
            var loc = System.IO.Path.Combine(config.root, Utils.CorralDir, Utils.CorralExe);

            var tmp = System.IO.Path.Combine(config.root, Utils.RunDir);
            System.IO.Directory.CreateDirectory(tmp);

            var flags = "";// config.Utils.ar.Aggregate("", ((s1, s2) => s1 + " " + s2)); 

            var outp = Utils.run(tmp, loc, flags);

            //var resultsfile = System.IO.Path.Combine(tmp, Utils.ResultFile);
            //var ex = System.IO.File.Exists(resultsfile); 
        }

        static void StartCorral()
        {
            var threads = new List<Thread>();
            var workers = new List<WorkItem>();

            var starttime = DateTime.Now;
            Console.WriteLine("Spawning Corral");

            // spawn client on own machine            
            Debug.Assert(config.Utils.Count == 1);
            foreach (var util in config.Utils)
            {
                // pick the first file in BoogieFiles to handle
                Debug.Assert(config.BoogieFiles.Count > 0);
                var file = System.IO.Path.Combine(config.root, Utils.DataDir, config.BoogieFiles.ElementAt(0).value);

                var args = file + " " + util.arguments;
                var w0 = new WorkItem("local", config.root, args);
                workers.Add(w0);
                threads.Add(new Thread(new ThreadStart(w0.Run)));
            }
            // start threads
            threads.ForEach(t => t.Start());
        }

        static void PongServer()
        {

            switch (state)
            {
                case CurrentState.AVAIL:
                    serverConnection.Send(Utils.EncodeStr(Utils.ReadyMsg));
                    break;
                case CurrentState.BUSY:
                    serverConnection.Send(Utils.EncodeStr(Utils.NotReadyMsg));
                    break;
                default:
                    Debug.Assert(false);
                    break;
            }
        }

        static void InformServerWhenCompleted()
        {
            state = CurrentState.AVAIL;
            serverConnection.Send(Utils.EncodeStr(Utils.CompletionMsg));
        }

        static bool CheckIfWorking(string taskName)
        {
            // Are we already running?
            //System.Diagnostics.Process.GetCurrentProcess().ProcessName
            var procs =
                System.Diagnostics.Process.GetProcessesByName(taskName);
            if (procs.Count() > 1)
            {
                //return;
            }
            return false;
        }

        static void SendTask(string msg)
        {
            if (Utils.SocketConnected(corralConnection))
            {
                // give corral a task
                corralConnection.Send(Utils.EncodeStr(msg));

                // corral will reply "working"
                byte[] data = new byte[Utils.MsgSize];
                int receivedDataLength = corralConnection.Receive(data); //Wait for the data
                string stringData = Encoding.ASCII.GetString(data, 0, receivedDataLength);
                LogWithAddress.WriteLine(string.Format("{0}", stringData));
            }
        }

        static void ConnectCorral()
        {
            LogWithAddress.WriteLine(string.Format("Connecting Corral"));

            try
            {
                IPHostEntry ipHostInfo = Dns.Resolve(Dns.GetHostName());
                IPAddress ipAddress = ipHostInfo.AddressList[0];
                IPEndPoint remoteEP = new IPEndPoint(ipAddress, Utils.CorralPort);

                while (true)
                {
                    corralConnection = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                    try
                    {
                        corralConnection.Connect(remoteEP);

                        LogWithAddress.WriteLine(string.Format("Socket connected {0}", corralConnection.RemoteEndPoint.ToString()));
                        break;
                    }
                    catch (SocketException se)
                    {
                        LogWithAddress.WriteLine(string.Format("Corral is not connected yet."));
                        Thread.Sleep(Utils.SleepTime);
                    }
                    catch (Exception e)
                    {
                        LogWithAddress.WriteLine(string.Format("Unexpected exception : {0}", e.ToString()));
                    }
                }

            }
            catch
            {
                LogWithAddress.WriteLine(string.Format("Cannot connect to Corral"));
            }
        }


        static void AppendStats(double workingTime, double waitingTime, double runningTime)
        {
            List<string> lines = new List<string>();
            System.IO.StreamReader file = new System.IO.StreamReader(Utils.ClientStats);
            string line = "";
            while ((line = file.ReadLine()) != null)
            {
                lines.Add(line);
            }
            file.Close();

            // read file
            ClientStats stats = ClientStats.DeSerialize(Utils.ClientStats);
            stats.TotalTime.WaitingTime = waitingTime;
            stats.TotalTime.WorkingTime = workingTime;
            stats.TotalTime.Total = runningTime;

            stats.DumpStats();
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            LogWithAddress.Close();
            lock (Utils.SpawnedProcesses)
            {
                foreach (var p in Utils.SpawnedProcesses)
                {
                    p.Kill();
                }
                Utils.SpawnedProcesses.Clear();
            }
            System.Diagnostics.Process.GetCurrentProcess().Kill();
        }
    }
}
