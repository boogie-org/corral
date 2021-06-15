using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Threading;
using System.Diagnostics;
using DequeNet;
using System.Runtime.InteropServices;


namespace LocalServerInCsharp
{
    public class splitNode
    {
        public long parent;
        public string nodeType;
        public int clientId;
        public List<long> children;
        public string status;
        public DateTime startTime;
        public DateTime endTime;
        public bool isLeading;
        public bool isLeafNode;

        public splitNode(long parentId, string type)
        {
            parent = parentId;
            nodeType = type;
            clientId = -1;
            children = new List<long>();
            status = "PENDING";
            isLeading = true;
            isLeafNode = true;
        }
    }



    class Program
    {
        static HttpListener _httpListener = new HttpListener();
        public static int numClients = 0;
        public static int numFreeClients = 0;
        public static int maxClients;
        public static int maxListeners;
        public static int numRemoteListeners = 0;
        public static double timeout;
        public static int numSplits = 0;
        public static bool startFirstJob = false;
        public static bool setKillFlag = false;
        public static DateTime startTime;
        // Tuple< clientID, httpContext >
        public static List< Queue<Tuple<int, HttpListenerContext> > > clientRequestQueue;
        public static List<bool> isJobGiven;
        public static List<bool> isJobCompleted;
        public static List<double> totalTime;
        public static List<bool> isAnyReachedBound;
        public static List<int> totalSplits;
        public static List<List<int>> algoClientList;
        public static Queue<int> clientPool;
        //public static Queue<HttpListenerContext> clientRequestQueue = new Queue<HttpListenerContext>();
        public static Stack<string> callTreeStack = new Stack<string>();
        public static bool writeLog = false;
        public static bool showTreeLog = false;
        public static bool PortfolioLog = true;
        public static string[] filePaths;
        public static Queue<string> fileQueue;
        public static Queue<HttpListenerContext> waitingListener;
        public static Queue<HttpListenerContext> initListener;
        //public static string outputFolderPath;
        public static string workingFile;
        public static string timeGraph;
        public static string finalOutcome;
        //public static double totalTime;
        public static double resetTime;
        public static double communicationTime;
        private static bool receivedTimeGraph = false;
        public static List<bool> askForResetTime;
        public static List<int> numClientsResetTimeSent;
        public static DateTime lastClientCallAt;
        public static string listenerExecutablePath;
        public static string inputFilesDirectory;
        public static Deque<string>[] clientCalltreeQueue;
        public static double[] clientCommunicationTime;
        public static double[] clientResetTime;
        public static double[] clientInliningTime;
        public static double[] clientSplittingTime;
        public static double[] clientNumInlinings;
        public static double[] clientNumZ3Calls;
        public static double[] clientZ3Time;
        public static double[] clientIdlingTime;
        public static double[] clientNumReset;                           //number of times a client has reset, i.e., stolen calltrees from others 
        public static double[] clientNumForwardPops;                     //number of own calltrees popped
        public static double[] clientNumBackwardPops;                    //number of stolen calltrees from a client
        public static DateTime[] clientCalltreeRequestReceiveTime;
        public static double smallestSplitInterval = 0;
        public static double largestSplitInterval = 0;
        public static double averageSplitInterval = 0;
        public static DateTime lastSplitArrival;
        public static double splitRate = 0;
        public static Config configuration = new Config();
        public static double boogieDumpTime = 0;
        public static DateTime boogieDumpStart;
        public static Dictionary<long, splitNode> tree;
        public static List<int> clientsToKill;
        public static long partitionId = 0;
        public static bool trackCompletedNode = false;
        public static Tuple<int, List<int>> currNodeTrack;
        public static List<Tuple<int, List<int>>> orList;
        public static int numSplitsAnd = 0;
        public static int numSplitsOr = 0;
        public static Dictionary<long, Tuple<DateTime, DateTime>> nodeTimes;
        public static Deque<string> clientCalltreeQueueOr;
        public static Random random;
        public static bool portfolioSplitDone = false;
        public static bool staticAlphaListMode = false;
        public static bool waitForBetterResult = false;
        public static List<int> staticAlphaList = new List<int>();
        public static int totalAlgo = 1;
        public static List<int> algoIdToSplitMode;
        public static int bestAlgo = -1;
        public static int lastAlgoCompleted = -1;
        static void Main(string[] args)
        {
            //Config configuration = new Config();
            setupConfig(args);
            if (configuration.dumpSIBoogieFiles)
            {
                if (!Directory.Exists(configuration.boogieDumpDirectory))
                    Directory.CreateDirectory(configuration.boogieDumpDirectory);
            }
            maxClients = configuration.numMaxClients * configuration.numListeners;
            if (staticAlphaListMode) // To be run with portfolio mode
                totalAlgo = staticAlphaList.Count;
            else
                totalAlgo = 1;

            maxListeners = configuration.numListeners;
            timeout = configuration.timeout;
            waitingListener = new Queue<HttpListenerContext>();
            initListener = new Queue<HttpListenerContext>();
            numClients = 0;
            startFirstJob = false;
            listenerExecutablePath = configuration.listenerExecutablePath;
            //listenerExecutablePath = Directory.GetCurrentDirectory();
            //listenerExecutablePath = listenerExecutablePath.Substring(0, listenerExecutablePath.Length - 49);
            //listenerExecutablePath = listenerExecutablePath + @"Client\Client\bin\Debug\Client.exe";
            //Console.WriteLine(listenerExecutablePath);
            //Console.ReadLine();
            inputFilesDirectory = configuration.inputFilesDirectoryPath;
            //inputFilesDirectory = listenerExecutablePath.Substring(0, listenerExecutablePath.Length - 89);
            //inputFilesDirectory = inputFilesDirectory + @"copyFiles\" ;
            //Console.WriteLine(inputFilesDirectory);
            //Console.ReadLine();
            if (configuration.inputFile == null)
            {
                filePaths = Directory.GetFiles(inputFilesDirectory, "*.bpl");
                //outputFolderPath = @"E:\ExperimentOutput\";
                fileQueue = new Queue<string>(filePaths);
            }
            else
            {
                filePaths = null;
                fileQueue = new Queue<string>();
                fileQueue.Enqueue(configuration.inputFile);
            }
            clientCalltreeQueue = new Deque<string>[maxClients];
            clientCommunicationTime = new double[maxClients];
            clientResetTime = new double[maxClients];
            clientInliningTime = new double[maxClients];
            clientSplittingTime = new double[maxClients];
            clientNumInlinings = new double[maxClients];
            clientNumZ3Calls = new double[maxClients];
            clientZ3Time = new double[maxClients];
            clientIdlingTime = new double[maxClients];
            clientNumReset = new double[maxClients];
            clientNumForwardPops = new double[maxClients];
            clientNumBackwardPops = new double[maxClients];
            clientCalltreeRequestReceiveTime = new DateTime[maxClients];
            tree = new Dictionary<long, splitNode>();
            orList = new List<Tuple<int, List<int>>>();
            nodeTimes = new Dictionary<long, Tuple<DateTime, DateTime>>();
            trackCompletedNode = false;
            clientsToKill = new List<int>();
            random = new Random();
            clientCalltreeQueueOr = new Deque<string>();
            for (int i = 0; i < maxClients; i++)
                clientCalltreeQueue[i] = new Deque<string>();
            //foreach (string s in filePaths)
            //    Console.WriteLine(s);
            //Console.WriteLine("Starting server...");
            //_httpListener.Prefixes.Add("http://localhost:5000/"); // add prefix "http://localhost:5000/"
            //_httpListener.Prefixes.Add("http://10.0.0.7:5000/");
            _httpListener.Prefixes.Add(configuration.serverAddress);
            _httpListener.TimeoutManager.RequestQueue = Timeout.InfiniteTimeSpan;
            _httpListener.TimeoutManager.IdleConnection = Timeout.InfiniteTimeSpan;
            _httpListener.Start(); // start server (Run application as Administrator!)
            //Console.WriteLine("Server started.");
            //Console.WriteLine("Waiting for Listener...");

            string configFilePath = null;
            if (args.Length == 2)
                configFilePath = args[1];
            else
                configFilePath = args[0];

            if (configuration.startLocalListener)
                startListenerService(configFilePath);

            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                if (numRemoteListeners > 0)
                {
                    executeLinuxTerminal("tar", ("-C " + configuration.hydraBin + " -zcvf hydraExecutables.tar.gz ."), true);
                    //executeLinuxTerminal("cd", (configuration.hydraBin + " | -zcvf hydraExecutables.tar.gz *"), true);
                    //Console.WriteLine("Executables Zipped");
                    for (int i = 0; i < numRemoteListeners; i++)
                    {
                        executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'mkdir -p " + configuration.listenerExecutablesLocation[i] + "'"), true);
                        //executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'mkdir -p " + configuration.listenerExecutablesLocation[i] + "inputProgram'"), true);
                        executeLinuxTerminal("scp", ("hydraExecutables.tar.gz " + configuration.listenerAddress[i] + ":" + configuration.listenerExecutablesLocation[i]), true);
                        executeLinuxTerminal("scp", (configFilePath + " " + configuration.listenerAddress[i] + ":" + configuration.listenerExecutablesLocation[i] + "/config.txt"), true);
                        //if (configuration.inputFile != null)
                        //    executeLinuxTerminal("scp", (configuration.inputFile + " " + configuration.listenerAddress[i] + ":" + configuration.listenerExecutablesLocation[i] + "/inputProgram/"), true);
                        executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'tar -C " + configuration.listenerExecutablesLocation[i] + " -xvzf " + configuration.listenerExecutablesLocation[i] + "hydraExecutables.tar.gz'"), true);
                        executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'chmod 700 " + configuration.listenerExecutablesLocation[i] + "'"), true);
                        executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'mono " + configuration.listenerExecutablesLocation[i] + "/Client.exe " + configuration.listenerExecutablesLocation[i] + "/config.txt " + configuration.listenerExecutablesLocation[i] + "'"), false);
                    }
                }
                //Console.ReadLine();
            }
            Thread _responseThread = new Thread(ResponseThread);
            _responseThread.Start(); // start the response thread
        }

        static void executeLinuxTerminal(string cmd, string arguments, bool wait)
        {
            //Console.WriteLine("Running Command : " + cmd + " " + arguments);
            Process p = new Process();
            p.StartInfo.FileName = cmd;
            p.StartInfo.Arguments = arguments;
            p.StartInfo.UseShellExecute = false;
            //p.StartInfo.CreateNoWindow = false;
            //p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
            p.Start();
            if (wait)
                p.WaitForExit();
        }
        
        static void ResponseThread()
        {
            
            while (true)
            {
                HttpListenerContext context = _httpListener.GetContext(); // get a context
                Dictionary<string, string> msgContent = null;
                // parse input msg
                List<string> allKeys = context.Request.QueryString.AllKeys.ToList();
                if (allKeys.Count == 0)
                {
                    if (setKillFlag)
                    {
                        continue;            //Do Not accept any calltree from client while listener is set to kill and restart
                    }
                    lastClientCallAt = DateTime.Now;
                    // message is large, send reply immediately 
                    String body = new StreamReader(context.Request.InputStream).ReadToEnd();
                    //Console.WriteLine(body);
                    body = body.Substring(1, body.Length - 2);
                    string[] parseBody = body.Split('=');
                    int clientID = Int16.Parse(parseBody[0]);
                    string calltree = parseBody[1];
                    if (writeLog)
                        Console.WriteLine("addCalltreeRequest: " + clientID + " : " + calltree);
                    //Console.ReadLine();
                    addCalltree(context, clientID, calltree);
                    if (writeLog)
                        Console.WriteLine("Adding Calltree");
                    //Console.ReadLine();
                    //msgContent = Common.Utils.ParseMsg(body.Replace("\"", ""));
                    //Log.WriteLine(Log.Info, string.Format("Received Large message"));
                }
                else
                {
                    lastClientCallAt = DateTime.Now;
                    msgContent = new Dictionary<string, string>();
                    foreach (var key in allKeys)
                    {
                        msgContent.Add(key, context.Request.QueryString[key].ToString());
                        if (writeLog)
                            Console.WriteLine(string.Format("Received message: " + context.Request.QueryString[key].ToString()));
                        //Console.ReadLine();
                    }
                }
                // Now, you'll find the request URL in context.Request.Url
                //HttpListenerRequest req = context.Request;
                //var body = new System.IO.StreamReader(context.Request.InputStream).ReadToEnd();
                //Dictionary<string, string> msgContent = null;
                // parse input msg
                //List<string> allKeys = req.Headers.AllKeys.ToList();
                //Console.WriteLine("count: " + allKeys.Count);
                //Console.WriteLine(body.ToString());
                //msgContent = new Dictionary<string, string>();
                //foreach (var key in allKeys)
                //{
                //msgContent.Add(key, req.Headers.QueryString[key].ToString());
                //    Console.WriteLine("Received message: " + key.ToString());
                //}
                if (msgContent != null)
                {
                    if (setKillFlag && !msgContent.ContainsKey("start") && !msgContent.ContainsKey("ListenerWaitingForRestart"))    //Do Not accept any message from any client while listener is set to kill and restart
                        continue;
                    //Console.ReadLine();
                    if (msgContent.ContainsKey("start"))
                        startVerification(context);
                    else if (msgContent.ContainsKey("ListenerWaitingForRestart"))
                    {
                        if ((DateTime.Now - startTime).TotalSeconds > timeout || setKillFlag)
                            waitingListener.Enqueue(context);
                        else
                            ResponseHttp(context, "continue");
                    }
                    else if (msgContent.ContainsKey("requestID"))
                        assignIDtoClient(context);
                    else if (msgContent.ContainsKey("startFirstJob"))
                        replyStartOrWaitForCalltree(context, msgContent["startFirstJob"]);
                    else if (msgContent.ContainsKey("requestCalltree"))
                        sendCalltree(context, msgContent["requestCalltree"]);
                    else if (msgContent.ContainsKey("popFromLocalStack"))
                        popCalltree(context, msgContent["popFromLocalStack"]);
                    else if (msgContent.ContainsKey("outcome"))
                        checkOutcome(context, msgContent["outcome"]);
                    else if (msgContent.ContainsKey("ResetTime"))
                        addResetTime(context, msgContent["ResetTime"]);
                    else if (msgContent.ContainsKey("NewPartitionId"))
                        createPartitionId(context, msgContent["NewPartitionId"]);
                    else if (msgContent.ContainsKey("FINISHED"))
                        killRedundantClients(context, msgContent["FINISHED"]);
                    else if (msgContent.ContainsKey("KillThisClient"))
                        handleKillingClients(context, msgContent["KillThisClient"]);
                    else if (msgContent.ContainsKey("performORSplit"))
                        checkPortfolioSplitIsCompleted(context, msgContent["performORSplit"]);
                    else if (msgContent.ContainsKey("SplitNow"))
                        replyYesOrNoForSplitNow(context, msgContent["SplitNow"]);
                    else if (msgContent.ContainsKey("ReachedBound"))
                        handleReachedBound(context, msgContent["ReachedBound"]);
                    //else if (msgContent.ContainsKey("calltree"))
                    //    addCalltree(context, msgContent["calltree"]);
                    else if (msgContent.ContainsKey("TimeGraph"))
                    {
                        timeGraph = msgContent["TimeGraph"];
                        receivedTimeGraph = true;
                        if (writeLog)
                            Console.WriteLine("received timegraph");
                        if (writeLog)
                            Console.WriteLine(timeGraph);
                        bool err = ResponseHttp(context, "receivedTimeGraph");
                        if (err)
                            handleClientCrash();
                    }
                    else if (msgContent.ContainsKey("test"))
                    {
                        Thread.Sleep(10000);
                        ResponseHttp(context, "returned");
                        Console.WriteLine("returning");
                    }                    
                }
                /*else
                {
                    byte[] _responseArray = Encoding.UTF8.GetBytes("<html><head><title>Localhost server -- port 5000</title></head>" +
                        "<body>Welcome to the <strong>Distributed Corral Service</strong> -- <em>port 5000!</em></body></html>"); // get the bytes to response
                    context.Response.OutputStream.Write(_responseArray, 0, _responseArray.Length); // write bytes to the output stream
                    context.Response.KeepAlive = false; // set the KeepAlive bool to false
                    context.Response.Close(); // close the connection
                    Console.WriteLine("Respone given to a request.");
                }*/

                //handling client crash needs BeginGetContext which is asynchronus. Getcontext blocks until receiving a request
                /*Console.WriteLine("Time since last call : " + (DateTime.Now - lastClientCallAt).TotalSeconds);
                if ((DateTime.Now - lastClientCallAt).TotalSeconds > 10)
                    handleClientCrash();
                else
                    lastClientCallAt = DateTime.Now;*/

                //if (clientRequestQueue.Count == maxClients && callTreeStack.Count == 0)
                if (writeLog)
                    Console.WriteLine("Request Queue Count : {0}", clientRequestQueue.Count);
                handleCompletedAlgo();
                bool allCompleted = areAllAlgoCompleted();
                for (int algo = 0; algo < totalAlgo; algo++)
                {
                    if(isJobGiven[algo] && isJobCompleted[algo])
                    {
                        if (bestAlgo == -1)
                        {
                            bestAlgo = algo;
                            finalOutcome = "OK";
                            Console.WriteLine("Outcome OK bestAlgo updated to " + bestAlgo.ToString());
                        }
                        if (clientRequestQueue[algo].Count == algoClientList[algo].Count && !askForResetTime[algo])
                        {
                            askForResetTime[algo] = true;
                            while (clientRequestQueue[algo].Count > 0)
                            {
                                Tuple<int, HttpListenerContext> t = clientRequestQueue[algo].Dequeue();
                                clientIdlingTime[t.Item1] = clientIdlingTime[t.Item1] + (DateTime.Now - clientCalltreeRequestReceiveTime[t.Item1]).TotalSeconds;
                                HttpListenerContext sendToClient = t.Item2;
                                ResponseHttp(sendToClient, "SendResetTime");
                            }
                        }
                    }
                    else
                    {
                        //handle requests
                        if (!isJobGiven[algo] && clientCalltreeQueueOr.Count > 0)
                        {
                            if (clientRequestQueue[algo].Count > 0)
                            {
                                Tuple<int, HttpListenerContext> t = clientRequestQueue[algo].Dequeue();
                                clientNumReset[t.Item1]++;
                                string calltreeToSend;
                                long partitionId;
                                int splitMode = -1;
                                HttpListenerContext sendToClient = t.Item2;
                                calltreeToSend = clientCalltreeQueueOr.PopRight();
                                string[] parse = calltreeToSend.Split(';');
                                partitionId = Int64.Parse(parse[2]);
                                tree[partitionId].isLeading = false;
                                tree[partitionId].startTime = DateTime.Now;
                                Console.WriteLine("Assign partition " + partitionId + " from OR Queue to " + t.Item1);
                                tree[partitionId].clientId = t.Item1;
                                if (clientsToKill.Contains(t.Item1))
                                    clientsToKill.Remove(t.Item1);
                                if (showTreeLog)
                                    showTree("Assigning partition");
                                ResponseHttp(sendToClient, calltreeToSend);
                                clientIdlingTime[t.Item1] = clientIdlingTime[t.Item1] + (DateTime.Now - clientCalltreeRequestReceiveTime[t.Item1]).TotalSeconds;
                                numFreeClients--;
                                isJobGiven[algo] = true;
                                splitMode = Int16.Parse(parse[0]);
                                algoIdToSplitMode[algo] = splitMode;
                                Console.WriteLine("Algo : " + algo.ToString() + " started with splitmode " + splitMode.ToString());
                            }
                        }
                        else
                        {
                            while (clientRequestQueue[algo].Count > 0)
                            {
                                int clientIDOfLargestQueue = findClientIDOfLargestQueue(algo);
                                if (clientIDOfLargestQueue == -1)  // No jobs available at algo queue
                                    break;
                                clientNumBackwardPops[clientIDOfLargestQueue]++;
                                Tuple<int, HttpListenerContext> t = clientRequestQueue[algo].Dequeue();
                                clientNumReset[t.Item1]++;
                                HttpListenerContext sendToClient = t.Item2;
                                Console.WriteLine("clientID of largest queue : " + clientIDOfLargestQueue);
                                if (clientIDOfLargestQueue != -1)
                                    Console.WriteLine("clientCalltreeQueue Count : {0}", clientCalltreeQueue[clientIDOfLargestQueue].Count);
                                if (clientIDOfLargestQueue < 0 || clientIDOfLargestQueue >= clientCalltreeQueue.Count())
                                {
                                    Console.WriteLine("ERROR: clientIdOfLargestQueue is wrong");
                                    Console.ReadLine();
                                }
                                string calltreeToSend = clientCalltreeQueue[clientIDOfLargestQueue].PopRight();
                                string[] parse = calltreeToSend.Split(';');
                                long partitionId = Int64.Parse(parse[2]);
                                Console.WriteLine("Assign partition " + partitionId + " from client " + clientIDOfLargestQueue + " to " + t.Item1);
                                if (clientsToKill.Contains(t.Item1))
                                    clientsToKill.Remove(t.Item1);
                                if (showTreeLog)
                                    showTree("Assigning partition");
                                tree[partitionId].clientId = t.Item1;
                                if (writeLog)
                                {
                                    Console.WriteLine("Sending job from client {0} to client {1}", clientIDOfLargestQueue,
                                        t.Item1);
                                    Console.WriteLine(calltreeToSend);
                                }
                                ResponseHttp(sendToClient, calltreeToSend);
                                clientIdlingTime[t.Item1] = clientIdlingTime[t.Item1] + (DateTime.Now - clientCalltreeRequestReceiveTime[t.Item1]).TotalSeconds;
                                numFreeClients--;
                            }
                        }
                    }
                }

                if ((bestAlgo != -1 && resetTimeCompleted(bestAlgo) && !waitForBetterResult) || (waitForBetterResult && (allResetTimeCompleted() || isAnyAlgoOkOutcome())))
                    setKillFlag = true;
                //Console.ReadLine();
                //if (receivedTimeGraph)
                //Console.WriteLine(setKillFlag + " " + waitingListener.Count);
                if (setKillFlag && waitingListener.Count == maxListeners)
                {
                    writeDetailedOutcome(false);
                    //Console.ReadLine();
                    while (waitingListener.Count > 0)
                        ResponseHttp(waitingListener.Dequeue(), "RESTART");
                    /*if (err)
                        startListenerService();*/
                }
                //Console.WriteLine("TIME TAKEN : " + (DateTime.Now - startTime).TotalSeconds);
                if ((DateTime.Now - startTime).TotalSeconds > timeout && !setKillFlag && waitingListener.Count == maxListeners)
                {
                    //Console.WriteLine("TIMEOUT START");
                    startTime = DateTime.Now; //to fix the waitingListener getting disposed error. Do NOT enter more than once for one program.
                    finalOutcome = "TIMEDOUT";
                    //totalTime = (DateTime.Now - startTime).TotalSeconds;
                    for(int algo = 0; algo < totalAlgo; algo++)
                    {
                        if (!isJobCompleted[algo])
                        {
                            totalTime[algo] = timeout;
                        }
                    }
                    writeDetailedOutcome(true);
                    setKillFlag = true;
                    //ResponseHttp(waitingListener, "RESTART");
                    while (waitingListener.Count > 0)
                        ResponseHttp(waitingListener.Dequeue(), "RESTART");
                    //Console.WriteLine("TIMEOUT END");
                }
            }
        }

        static void distributeClients()
        {
            // Initialization
            clientPool = new Queue<int>();
            algoClientList = new List<List<int>>();
            numClientsResetTimeSent = new List<int>();
            clientRequestQueue = new List<Queue<Tuple<int, HttpListenerContext>>>();
            isJobGiven = new List<bool>();
            isAnyReachedBound = new List<bool>();
            totalSplits = new List<int>();
            algoIdToSplitMode = new List<int>();
            isJobCompleted = new List<bool>();
            totalTime = new List<double>();
            askForResetTime = new List<bool>();
            bestAlgo = -1;
            lastAlgoCompleted = -1;

            for (int client = 1; client < maxClients; client++)
                clientPool.Enqueue(client);
            for (int algo = 0; algo < totalAlgo; algo++)
                algoClientList.Add(new List<int>());

            //1st partition assigned to client 0 for Vanilla OR algorithm
            algoClientList[0].Add(0);
            if(totalAlgo > maxClients)
            {
                Console.WriteLine("ERROR : More type of algo provided than clients");
                Console.ReadLine();
            }
            //Current allocation for client as follows
            for (int algo = 0; algo < totalAlgo; algo++)
            {
                int clientsToAdd = algo == 0 ? ((maxClients / totalAlgo) + (maxClients % totalAlgo)) - 1 : maxClients / totalAlgo;
                bool areAdded = addClientsToAlgo(algo, clientsToAdd);
                if (!areAdded)
                {
                    Console.WriteLine("ERROR : Clients not added to algo " + algo.ToString());
                    Console.ReadLine();
                }

                numClientsResetTimeSent.Add(0);
                isJobGiven.Add(false);
                isJobCompleted.Add(false);
                totalTime.Add(-1);
                isAnyReachedBound.Add(false);
                totalSplits.Add(0);
                algoIdToSplitMode.Add(-1);
                askForResetTime.Add(false);
                clientRequestQueue.Add(new Queue<Tuple<int, HttpListenerContext>>());
                if (PortfolioLog)
                    showClientsOfAlgo(algo);
            }

            //Default Values
            //Job given to algo 0 is true
            isJobGiven[0] = true;
            algoIdToSplitMode[0] = 100; // OR
        }

        static void showClientsOfAlgo(int algoID)
        {
            Console.WriteLine("Algo Client list " + algoID.ToString() + ":  " + string.Join(",", algoClientList[algoID]));
        }

        static bool addClientsToAlgo(int algoId, int clientsToAdd)
        {
            bool areClientsAdded = false;
            if(clientPool.Count < clientsToAdd || clientsToAdd < 0)
            {
                Console.WriteLine("ERROR: cannot add "+ clientsToAdd + " clients to algo " + algoId);
            }
            else
            {
                areClientsAdded = true;
                while(clientsToAdd > 0)
                {
                    int clientID = clientPool.Dequeue();
                    algoClientList[algoId].Add(clientID);
                    clientsToAdd--;
                }
            }
            return areClientsAdded;
        }

        static void setupConfig(string[] args)
        {
            String configPath;
            int listenerAddressCount = 0;
            int listenerPathCount = 0;
            numRemoteListeners = 0;
            if (args.Length == 2)
            {
                configuration.inputFile = args[0];
                configPath = args[1];
            }
            else
                configPath = args[0];
            StreamReader reading = File.OpenText(configPath);
            string str;
            while ((str = reading.ReadLine()) != null)
            {
                string[] configKey = str.Split('=');

                switch (configKey[0])
                {
                    case "numListeners":
                        configuration.numListeners = Int32.Parse(configKey[1]);
                        break;
                    case "numMaxClients":
                        configuration.numMaxClients = Int32.Parse(configKey[1]);
                        break;
                    case "timeout":
                        configuration.timeout = Int32.Parse(configKey[1]);
                        break;
                    case "inputFilesDirectoryPath":
                        configuration.inputFilesDirectoryPath = configKey[1];
                        break;
                    case "serverAddress":
                        configuration.serverAddress = configKey[1];
                        break;
                    case "corralArguments":
                        configuration.corralArguments = configKey[1];
                        if (configKey.Length > 2)
                        {
                            for (int i = 2; i < configKey.Length; i++)
                                configuration.corralArguments = configuration.corralArguments + "=" + configKey[i];
                        }
                        configuration.rawArguments = configuration.corralArguments;
                        configuration.corralDumpArguments = configuration.corralArguments;
                        break;
                    case "hydraArguments":
                        configuration.hydraArguments = configKey[1];
                        if (configKey.Length > 2)
                        {
                            for (int i = 2; i < configKey.Length; i++)
                                configuration.hydraArguments = configuration.hydraArguments + "=" + configKey[i];
                        }
                        break;
                    case "startLocalListener":
                        if (configKey[1] == "true")
                            configuration.startLocalListener = true;
                        else
                            configuration.startLocalListener = false;
                        break;
                    case "listenerExecutablePath":
                        configuration.listenerExecutablePath = configKey[1];
                        break;
                    case "corralExecutablePath":
                        configuration.corralExecutablePath = configKey[1];
                        break;
                    case "writeDetailPerClient":
                        if (configKey[1] == "true")
                            configuration.writeDetailPerClient = true;
                        else
                            configuration.writeDetailPerClient = false;
                        break;
                    case "controlSplitRate":
                        if (configKey[1] == "true")
                            configuration.controlSplitRate = true;
                        else
                            configuration.controlSplitRate = false;
                        break;
                    case "splitInterval":
                        configuration.splitInterval = double.Parse(configKey[1]);
                        break;
                    case "corralDumpBoogie":
                        configuration.corralDumpBoogiePath = configKey[1];
                        break;
                    case "dumpSIBoogieFiles":
                        if (configKey[1] == "true")
                            configuration.dumpSIBoogieFiles = true;
                        else
                            configuration.dumpSIBoogieFiles = false;
                        break;
                    case "boogieDumpDirectory":
                        configuration.boogieDumpDirectory = configKey[1];
                        break;
                    case "ListenerAddress":
                        configuration.listenerAddress[listenerAddressCount] = configKey[1];
                        listenerAddressCount++;
                        break;
                    case "ListenerExecutablesPath":
                        configuration.listenerExecutablesLocation[listenerPathCount] = configKey[1];
                        listenerPathCount++;
                        break;
                    case "hydraBin":
                        configuration.hydraBin = configKey[1];
                        break;
                    case "smackBin":
                        configuration.smackBin = configKey[1];
                        break;
                    default:
                        Console.WriteLine("Invalid Option: " + configKey[0]);
                        break;
                }
            }
            numRemoteListeners = listenerAddressCount;
            configuration.corralArguments = " " + configuration.corralArguments + " /si /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + configuration.serverAddress;
            configuration.corralDumpArguments = " " + configuration.corralDumpArguments + " /printFinalProgOnly /printFinalProg:";
            configuration.hydraArguments = " " + configuration.hydraArguments + " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + configuration.serverAddress;
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                configuration.listenerExecutablePath = configuration.hydraBin + "/Client.exe";
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                configuration.listenerExecutablePath = configuration.hydraBin + "\\Client.exe";
            setupStaticAlphaList();
        }

        static void setupStaticAlphaList()
        {
            if(configuration.hydraArguments != null)
            {
                var sep = new char[1];
                sep[0] = ' ';
                var flags = configuration.hydraArguments.Split(sep);
                foreach(string flag in flags)
                {
                    if (flag.StartsWith("/mixedSplit:"))
                    {
                        staticAlphaListMode = true;
                        var split = flag.Split(':');
                        var values = split[1].Split(',');
                        foreach (var val in values)
                        {
                            staticAlphaList.Add(Int32.Parse(val));
                        }
                        Console.WriteLine("SERVER: static alpha list : " + string.Join(",", staticAlphaList));
                    }
                    else if (flag.StartsWith("/waitForBetterResult"))
                    {
                        waitForBetterResult = true;
                    }
                }
            }
        }


        static void startListenerService(string configPath)
        {
            startTime = DateTime.Now;            
            Process p = new Process();
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                p.StartInfo.FileName = "mono";
                p.StartInfo.Arguments = listenerExecutablePath + " " + configPath + " " + configuration.hydraBin;
                p.StartInfo.UseShellExecute = false;
                //p.StartInfo.CreateNoWindow = false;
                p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                p.Start();
            }
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                p.StartInfo.FileName = listenerExecutablePath;
                p.StartInfo.Arguments = configPath + " " + configuration.hydraBin;
                //    " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3" +
                //    " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1";
                p.StartInfo.UseShellExecute = false;
                //p.StartInfo.CreateNoWindow = false;
                p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                p.Start();
            }
            else
                Console.WriteLine("Cannot Run On This Operating System");
            //corralProcessList.Add(p);
        }

        static void startVerification(HttpListenerContext context)
        {
            initListener.Enqueue(context);
            if (initListener.Count < maxListeners)
            {                
                Console.WriteLine("{0} out of {1} listeners online", initListener.Count, maxListeners);                
            }
            else
            {
                initiateAllListeners();
            }            
        }

        public static void initiateAllListeners()
        {
            //Console.WriteLine("starting verification");
            startTime = DateTime.Now;
            lastSplitArrival = DateTime.Now;
            smallestSplitInterval = 9999;
            largestSplitInterval = 0;
            averageSplitInterval = 0;
            numClients = 0;
            numFreeClients = 4;
            numSplits = 0;
            startFirstJob = false;
            callTreeStack.Clear();
            distributeClients();
            setKillFlag = false;
            receivedTimeGraph = false;
            clientCalltreeQueue = new Deque<string>[maxClients];
            tree.Clear();
            clientsToKill.Clear();
            splitRate = 0;
            boogieDumpTime = 0;
            Array.Clear(clientCommunicationTime, 0, maxClients);
            Array.Clear(clientResetTime, 0, maxClients);
            Array.Clear(clientInliningTime, 0, maxClients);
            Array.Clear(clientSplittingTime, 0, maxClients);
            Array.Clear(clientNumInlinings, 0, maxClients);
            Array.Clear(clientNumZ3Calls, 0, maxClients);
            Array.Clear(clientZ3Time, 0, maxClients);
            Array.Clear(clientIdlingTime, 0, maxClients);
            Array.Clear(clientNumReset, 0, maxClients);
            Array.Clear(clientNumForwardPops, 0, maxClients);
            Array.Clear(clientNumBackwardPops, 0, maxClients);
            Array.Clear(clientCalltreeRequestReceiveTime, 0, maxClients);
            numSplitsOr = 0;
            numSplitsAnd = 0;
            orList.Clear();
            nodeTimes.Clear();
            trackCompletedNode = false;
            portfolioSplitDone = false;
            clientCalltreeQueueOr = new Deque<string>();
            for (int i = 0; i < maxClients; i++)
                clientCalltreeQueue[i] = new Deque<string>();
            //string programToVerify = "61883_completerequeststatuscheck_0.bpl.bpl";
            if (fileQueue.Count == 0)
            {
                //Console.WriteLine("All Finished");
                while (initListener.Count > 0)
                    ResponseHttp(initListener.Dequeue(), "Finished");
                //Console.ReadLine();
                Process.GetCurrentProcess().Kill();
            }
            else
            {
                workingFile = fileQueue.Dequeue();
                string workingFilePath = null;
                string workingFileName = null;
                if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                {
                    workingFilePath = workingFile.Substring(0, workingFile.LastIndexOf('/') + 1);
                    workingFileName = workingFile.Substring(workingFile.LastIndexOf('/') + 1);
                }
                else if(RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                {
                    workingFilePath = workingFile.Substring(0, workingFile.LastIndexOf('\\') + 1);
                    workingFileName = workingFile.Substring(workingFile.LastIndexOf('\\') + 1);
                }
                Console.WriteLine("working on " + workingFileName);
                //Console.ReadLine();
                string inputFileExtension = workingFile.Substring(workingFile.Length - 3);
                if (!(inputFileExtension.ToLower() == "bpl")) //Invoke SMACK to convert given C program to Boogie
                {
                    Process p = new Process();
                    if (configuration.smackBin == null)
                        p.StartInfo.FileName = "smack";
                    else
                        p.StartInfo.FileName = configuration.smackBin;
                    string arguments = "-x svcomp -t " + workingFile + " -bpl " + configuration.boogieDumpDirectory + workingFileName + ".bpl";
                    p.StartInfo.Arguments = arguments;
                    //Console.WriteLine(workingFileName);
                    //Console.WriteLine(workingFilePath);
                    //Console.WriteLine(arguments);
                    //Console.ReadLine();
                    p.StartInfo.UseShellExecute = false;
                    p.Start();
                    p.WaitForExit();
                    workingFile = configuration.boogieDumpDirectory + workingFileName + ".bpl";
                    //Console.WriteLine(workingFile);
                    //Console.ReadLine();
                }
                if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                {
                    if (numRemoteListeners > 0)
                    {
                        for (int i = 0; i < numRemoteListeners; i++)
                        {
                            executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'mkdir -p " + workingFilePath + "'"), true);
                            //executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'mkdir -p " + configuration.listenerExecutablesLocation[i] + "inputProgram'"), true);
                            executeLinuxTerminal("scp", (workingFile + " " + configuration.listenerAddress[i] + ":" + workingFilePath), true);
                            //if (configuration.inputFile != null)
                            //    executeLinuxTerminal("scp", (configuration.inputFile + " " + configuration.listenerAddress[i] + ":" + configuration.listenerExecutablesLocation[i] + "/inputProgram/"), true);
                            //executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'tar -C " + configuration.listenerExecutablesLocation[i] + " -xvzf " + configuration.listenerExecutablesLocation[i] + "hydraExecutables.tar.gz'"), true);
                            //executeLinuxTerminal("ssh", (configuration.listenerAddress[i] + " 'chmod 700 " + configuration.listenerExecutablesLocation[i] + "'"), true);
                        }
                    }

                }
                boogieDumpStart = DateTime.Now;
                while (initListener.Count > 0)
                    ResponseHttp(initListener.Dequeue(), workingFile);
                /*bool err = ResponseHttp(context, workingFile);
                if (err)
                    handleClientCrash();*/
            }
        }

        public static void addResetTime(HttpListenerContext context, string msg)
        {
            string[] parsedMessage = msg.Split(',');
            int id = Int16.Parse(parsedMessage[0]) - 1;
            clientCommunicationTime[id] = double.Parse(parsedMessage[1]);
            clientResetTime[id] = double.Parse(parsedMessage[2]);
            clientNumInlinings[id] = double.Parse(parsedMessage[3]);
            clientNumZ3Calls[id] = double.Parse(parsedMessage[4]);
            clientZ3Time[id] = double.Parse(parsedMessage[5]);
            clientInliningTime[id] = double.Parse(parsedMessage[6]);
            clientSplittingTime[id] = double.Parse(parsedMessage[7]);
            //double communicationTimeByClient = double.Parse(parsedMessage[0]);
            //double resetTimeByClient = double.Parse(parsedMessage[1]);
            resetTime = resetTime + clientResetTime[id];
            communicationTime = communicationTime + clientCommunicationTime[id];
            int algoId = getAlgoID(id);
            numClientsResetTimeSent[algoId]++;
            ResponseHttp(context, "received");
        }

        public static bool noJobLeft()
        {
            bool isNoJobLeft = true;
            for (int i = 0; i < maxClients; i++)
            {
                if (clientCalltreeQueue[i].Count > 0)
                {
                    isNoJobLeft = false;
                    break;
                }
            }
            return isNoJobLeft;
        }

        static int getAlgoClientsCount(int algoId)
        {
            return algoClientList[algoId].Count;
        }

        public static int findClientIDOfLargestQueue(int algoId)
        {
            int switchForSingleClient;
            if (maxClients == 1)
                switchForSingleClient = 0;
            else
                switchForSingleClient = 0;
            int maxQueueSize = switchForSingleClient;
            int clientIDOfLargestQueue = -1;
            //Console.WriteLine(algoId + " : " + start + " - " + end);
            for (int i = 0; i < algoClientList[algoId].Count ; i++)
            {
                if (clientCalltreeQueue[algoClientList[algoId][i]].Count > maxQueueSize && !clientsToKill.Contains(algoClientList[algoId][i]))
                {
                    maxQueueSize = clientCalltreeQueue[algoClientList[algoId][i]].Count;
                    clientIDOfLargestQueue = algoClientList[algoId][i];
                }
            }
            if (maxQueueSize == switchForSingleClient)
                return -1;
            else
                return clientIDOfLargestQueue;
        }


        static void checkOutcome(HttpListenerContext context, string msg)
        {
            if (writeLog)
                Console.WriteLine(msg);
            numFreeClients++;
            string[] parse = msg.Split(';');
            string outcome = parse[0];
            int clientID = Int16.Parse(parse[1]) - 1;
            int algoID = getAlgoID(clientID);
            if (outcome.Equals("NOK"))
            {
                //bool err = ResponseHttp(context, "kill");
                /*bool err = ResponseHttp(waitingListener, "RESTART");
                if (err)
                    startListenerService();*/
                finalOutcome = "NOK";
                bestAlgo = algoID;
                Console.WriteLine("Outcome NOK bestAlgo updated to " + bestAlgo.ToString());
                totalTime[algoID] = (DateTime.Now - startTime).TotalSeconds;
                isJobCompleted[algoID] = true;
                setKillFlag = true;
            }
            else
            {
                //Console.WriteLine("free : {0} | cts avail : {1}", clientRequestQueue.Count, callTreeStack.Count);
                //Console.ReadLine();
                //if (clientRequestQueue.Count == 4 && callTreeStack.Count == 0)
                //{
                //bool err = ResponseHttp(context, "DONE");
                /*bool err = ResponseHttp(waitingListener, "RESTART");
                if (err)
                    startListenerService();*/
                //     finalOutcome = "OK";
                //     totalTime = (DateTime.Now - startTime).TotalSeconds;
                //     setKillFlag = true;
                //}
                //else

                if (outcome.Equals("REACHEDBOUND"))
                    isAnyReachedBound[algoID] = true;
                bool err = ResponseHttp(context, "CONTINUE");
                if (err)
                    handleClientCrash();
            }
            
            /*if (outcome.Equals("OK"))
                ResponseHttp(context, "continue");
            else if (outcome.Equals("NOK"))
            {
                setKillFlag = true;
                ResponseHttp(context, "kill");
            }
            else
                ResponseHttp(context, "continue");*/
        }

        static void assignIDtoClient(HttpListenerContext context)
        {
            numClients = numClients + 1;
            if (numClients == 1)
                boogieDumpTime = (DateTime.Now - boogieDumpStart).TotalSeconds;
            string reply = numClients.ToString();
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
        }

        static void createPartitionId(HttpListenerContext context, string msg)
        {
            string[] parse = msg.Split(';');
            int clientID = Int16.Parse(parse[0]) - 1;
            long parentPartitionID = Int64.Parse(parse[1]);
            if (clientsToKill.Contains(clientID))
            {
                handleKillingClients(context, parse[0]);
            }
            else
            {
                tree[parentPartitionID].isLeafNode = false;
                partitionId = partitionId + 5;  //Assume that 5 partition ids are allocated. Client decides what to do with redundant ids. 
                string reply = partitionId.ToString();
                bool err = ResponseHttp(context, reply);
                if (err)
                    handleClientCrash();
            }
        }        

        static void killRedundantClients(HttpListenerContext context, string msg)
        {
            long finishedPartition = Int64.Parse(msg);
            if (showTreeLog)
            {
                showTree("Received finished partition : " + finishedPartition);
                showKillandRequestQueue("Received finished partition : " + finishedPartition);
            }
            if (!tree.ContainsKey(finishedPartition))
            {
                Console.WriteLine("Cannot find finished partition in tree : " + finishedPartition);
            }
            else
            {
                lastAlgoCompleted = getAlgoID(tree[finishedPartition].clientId);
                handleEntryTracking(finishedPartition);
                handleOK(finishedPartition);
            }
            if (showTreeLog)
            {
                showTree("After removing finished partition : " + finishedPartition);
                showKillandRequestQueue("After removing finished partition : " + finishedPartition);
            }

            string reply = "continue";
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
        }

        static void showKillandRequestQueue(string location)
        {
            Console.WriteLine("showing at location " + location);
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                Console.Write("REQ Q " + algo.ToString() + ":");
                foreach (var req in clientRequestQueue[algo])
                {
                    Console.Write(" ,{0}", req.Item1);
                }
                Console.WriteLine("");
            }
            Console.Write("KILL Q : ");
            foreach (var req in clientsToKill)
            {
                Console.Write(" ,{0}", req);
            }
            Console.WriteLine("");
        }

        static void showTree(string location)
        {
            Console.WriteLine("\nShowing tree at" + location + "\n");
            foreach (long k in tree.Keys)
            {
                Console.Write(k + ": ");
                foreach (long c in tree[k].children)
                    Console.Write(tree[c].nodeType + ":" + c + " ");
                Console.Write(" client => " + tree[k].clientId.ToString());
                if (tree[k].isLeading)
                {
                    Console.Write(" L");
                }
                else
                {
                    Console.Write(" NonL");
                }
                Console.WriteLine("");
            }
            Console.WriteLine("Ending tree display\n");
        }

        static void ShowClientCalltreeQueueOr()
        {
            Console.Write("OR Q: ");
            foreach(var val in clientCalltreeQueueOr)
            {
                Console.Write(", {0}", val.Split(';')[0]);
            }
            Console.WriteLine();
        }

        static void checkTracking(long id)
        {
            if (tree.ContainsKey(id) && trackCompletedNode && currNodeTrack.Item1 != tree[id].clientId && tree[id].isLeading && tree[id].isLeafNode)
                currNodeTrack.Item2.Add(tree[id].clientId);
        }

        static void handleEntryTracking(long id)
        {
            if (!trackCompletedNode && !tree[id].isLeading)
            {
                trackCompletedNode = true;
                currNodeTrack = new Tuple<int, List<int>>(tree[id].clientId, new List<int>());
            }
        }

        static void handleExitTracking()
        {
            if(trackCompletedNode)
            {
                Console.WriteLine("Added New : ");
                orList.Add(currNodeTrack);
                Console.WriteLine(currNodeTrack.Item1.ToString() + " : " + string.Join(",", currNodeTrack.Item2));
                trackCompletedNode = false;
            }
        }

        static void addToNodeTimes(long id)
        {
            if (!nodeTimes.ContainsKey(id) && tree.ContainsKey(id) && tree[id].nodeType.Equals("OR"))
            {
                tree[id].endTime = DateTime.Now;
                nodeTimes[id] = Tuple.Create(tree[id].startTime, tree[id].endTime);
            }
        }

        static void removeFinishedPartitions()
        {
            while(clientCalltreeQueueOr.Count > 0)
            {
                long partitionID = Int64.Parse(clientCalltreeQueueOr.PeekRight().Split(';')[2]);
                if (tree.ContainsKey(partitionID))
                    break;
                clientCalltreeQueueOr.PopRight();
                Console.WriteLine("removing partition " + partitionId.ToString() + " from OR queue as not it is not present in tree");
            }
        }

        static void handleOK(long id)
        {
            long parent = tree[id].parent;

            if (tree[id].nodeType.Equals("OR"))
            {
                if (parent != 0 || !waitForBetterResult)
                {
                    addToNodeTimes(id);
                    tree.Remove(id);
                    Console.WriteLine("\nLOCATION - " + parent + ": " + id);
                    tree[parent].children.Remove(id);
                    if (tree[parent].children.Count > 0)
                    {
                        foreach (long c in tree[parent].children)
                        {
                            killSubTree(c);
                        }
                    }
                    tree[parent].children.Clear();
                }
                else
                {
                    killSubTree(id);
                    tree[parent].children.Remove(id);
                }
            }
            else if (tree[id].nodeType.Equals("AND"))
            {
                checkTracking(id);
                addToNodeTimes(id);
                tree.Remove(id);
                tree[parent].children.Remove(id);
            }

            if ((!waitForBetterResult && parent != -1) || (waitForBetterResult && parent != 0 && parent != -1))
            {
                if (tree[parent].children.Count == 0)
                    handleOK(parent);
                else
                    handleExitTracking();
            }
            else
            {
                handleExitTracking();
                if (!waitForBetterResult)
                {
                    Console.WriteLine("Reached root of partition tree. Verfification Finished.");
                    finalOutcome = "OK";
                    if (bestAlgo == -1)
                    {
                        bestAlgo = lastAlgoCompleted;
                        Console.WriteLine("Reached root bestAlgo updated to " + bestAlgo.ToString());
                        totalTime[bestAlgo] = (DateTime.Now - startTime).TotalSeconds;
                        isJobCompleted[bestAlgo] = true;
                        setKillFlag = true;
                    }
                }
                else
                {
                    finalOutcome = "OK";
                    if (parent == 0)
                    {
                        if (bestAlgo == -1)
                        {
                            bestAlgo = lastAlgoCompleted;
                            Console.WriteLine("Reached root bestAlgo updated to " + bestAlgo.ToString());
                        }
                        Console.WriteLine("Reached root of "+ lastAlgoCompleted.ToString() + " algo. Verfification Finished.");
                        totalTime[lastAlgoCompleted] = (DateTime.Now - startTime).TotalSeconds;
                        isJobCompleted[lastAlgoCompleted] = true;
                        bool allCompleted = areAllAlgoCompleted();
                        if (allCompleted || !isAnyReachedBound[lastAlgoCompleted])
                            setKillFlag = true;
                    }
                    else
                    {
                        Console.WriteLine("Reached root of partition tree. Verfification Finished.");
                        setKillFlag = true;
                    }
                }
            }
        }

        static void killSubTree(long id)
        {
            Console.WriteLine("removing " + id.ToString());
            if (tree[id].children.Count > 0)
            {
                foreach (long c in tree[id].children)
                    killSubTree(c);
            }else if (tree[id].clientId != -1)
            {
                clientsToKill.Add(tree[id].clientId);
            }
            checkTracking(id);
            addToNodeTimes(id);
            tree.Remove(id);
        }

        static void handleKillingClients(HttpListenerContext context, string msg)
        {
            int clientId = Int16.Parse(msg) - 1;
            string reply = null;

            if (clientsToKill.Contains(clientId))
            {
                reply = "KillNow";
                clientsToKill.Remove(clientId);
                while (clientCalltreeQueue[clientId].Count != 0)
                {
                    string calltree = clientCalltreeQueue[clientId].PopLeft();
                    string[] parse = calltree.Split(';');
                    long id = Int64.Parse(parse[2]);
                    if (tree.ContainsKey(id))
                    {
                        long parent = tree[id].parent;
                        tree[parent].children.Remove(id);
                        addToNodeTimes(id);
                        tree.Remove(id);
                    }
                }
            }
            else
                reply = "NO";
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
        }

        static void replyStartOrWaitForCalltree(HttpListenerContext context, string msg)
        {
            int clientId = Int16.Parse(msg) - 1;
            string reply;
            if (!startFirstJob && clientId == 0)
            {
                reply = "YES";
                startFirstJob = true;
                splitNode node = new splitNode(-1, "root");
                tree.Add(0, node);
                //1st partition will be assigned to 0 client
                tree[0].clientId = 0;
                partitionId = 0;
                //startTime = DateTime.Now;
                lastSplitArrival = DateTime.Now;
                resetTime = 0;
                communicationTime = 0;
                bool err = ResponseHttp(context, reply);
                if (err)
                    handleClientCrash();
            }
            else
            {
                reply = "WAITFORCALLTREE";
                bool err = ResponseHttp(context, reply);
                if (err)
                    handleClientCrash();
                //if (callTreeStack.Count == 0)
                //clientRequestQueue.Enqueue(context);
                /*else
                {
                    reply = callTreeStack.Pop();
                    bool err = ResponseHttp(context, reply);
                    if (err)
                        handleClientCrash();
                }*/
            }            
        }

        static void replyYesOrNoForSplitNow(HttpListenerContext context, string msg)
        {
            //Console.WriteLine("replyYesOrNoForSplitNow : " + msg);
            int clientID = Int16.Parse(msg) - 1;
            int algoID = getAlgoID(clientID);
            if (clientsToKill.Contains(clientID))
            {
                handleKillingClients(context, msg);
            }
            else if (clientRequestQueue[algoID].Count > 0)
            {
                //Console.WriteLine("Count : " + clientRequestQueue.Count);
                ResponseHttp(context, "YES");
            }
            else
            {
                //Console.WriteLine("NO");
                ResponseHttp(context, "NO");
            }
        }

        static void handleReachedBound(HttpListenerContext context, string msg)
        {
            int clientID = Int16.Parse(msg) - 1;
            int algoID = getAlgoID(clientID);
            isAnyReachedBound[algoID] = true;   //Outcome will be ReachedBound if not NOK
            ResponseHttp(context, "CONTINUE");
        }

        static void handleCompletedAlgo()
        {
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                if(isJobGiven[algo] && !isJobCompleted[algo])
                {
                    if (isAlgoCompleted(algo))
                    {
                        isJobCompleted[algo] = true;
                        totalTime[algo] = (DateTime.Now - startTime).TotalSeconds;
                    }
                }
            }
        }

        static bool allResetTimeCompleted()
        {
            bool isAllResetTimeCompleted = true;
            for (int algo = 0; algo < totalAlgo; algo++)
            {
                if (!resetTimeCompleted(algo))
                {
                    isAllResetTimeCompleted = false;
                    break;
                }
            }
            return isAllResetTimeCompleted;
        }

        static bool isAnyAlgoOkOutcome()
        {
            bool algoOk = false;
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                if(resetTimeCompleted(algo) && !isAnyReachedBound[algo])
                {
                    algoOk = true;
                    break;
                }
            }
            return algoOk;
        }

        static bool resetTimeCompleted(int algoId)
        {
            if (askForResetTime[algoId] && numClientsResetTimeSent[algoId] == getAlgoClientsCount(algoId))
                return true;
            return false;
        }

        static void checkPortfolioSplitIsCompleted(HttpListenerContext context, string msg)
        {
            //Console.WriteLine("checkPortfolioSplitIsCompleted : " + msg);
            int clientID = Int16.Parse(msg) - 1;
            if (clientsToKill.Contains(clientID))
            {
                handleKillingClients(context, msg);
            }
            else
            {
                string reply = "NO";
                if (!portfolioSplitDone && clientID == 0 && staticAlphaListMode)
                {
                    reply = "YES";
                    portfolioSplitDone = true;
                    Console.WriteLine("Portfolio Split performed!!");
                }
                ResponseHttp(context, reply);
            }
        }


        // Return value: Description
        // -1: No Algo completed
        // int in range(0, totalAlgo): algoId completed 
        static int checkIfAnyAlgoIsCompleted()
        {
            int algoId = -1;
            for(int algo = 0;algo < totalAlgo; algo++)
            {
                if (isJobGiven[algo] && isJobCompleted[algo])
                {
                    algoId = algo;
                    break;
                }
            }
            return algoId;
        }

        static bool areAllAlgoCompleted()
        {
            bool allCompleted = true;
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                if(!isJobGiven[algo] || !isJobCompleted[algo])
                {
                    allCompleted = false;
                    break;
                }
            }
            return allCompleted;
        }

        //Return Value: Description
        // True: Algo is completed
        // False: Algo is not started or not completed
        static bool isAlgoCompleted(int algoID)
        {
            bool isCompleted = false;
            if (isJobGiven[algoID])
            {
                bool noJobPending = true;
                for (int i = 0; i < algoClientList[algoID].Count; i++)
                {
                    if (clientCalltreeQueue[algoClientList[algoID][i]].Count > 0)
                    {
                        noJobPending = false;
                        break;
                    }
                }
                if (noJobPending && algoClientList[algoID].Count == clientRequestQueue[algoID].Count)
                {
                    isCompleted = true;
                }
            }
            return isCompleted;
        }

        static void addCalltree(HttpListenerContext context, int clientID, string calltree)
        {
            if(clientsToKill.Contains(clientID - 1))
            {
                Console.WriteLine("killing client " + (clientID - 1).ToString());
                handleKillingClients(context, clientID.ToString());
            }
            else
            {
                //Console.WriteLine("Adding Tree from " + (clientID - 1).ToString());
                int algoID = getAlgoID(clientID - 1);
                double splitInterval = (DateTime.Now - lastSplitArrival).TotalSeconds;
                //Console.WriteLine(splitInterval);
                if (splitInterval < smallestSplitInterval)
                    smallestSplitInterval = splitInterval;
                if (splitInterval > largestSplitInterval)
                    largestSplitInterval = splitInterval;
                averageSplitInterval = averageSplitInterval + splitInterval;
                string reply;
                if (writeLog)
                    Console.WriteLine("client {0} adding calltree", clientID - 1);
                //callTreeStack.Push(calltree);
                string[] parse = calltree.Split(';');
                long parentId = Int64.Parse(parse[1]);

                if (parse[3].Equals("AND"))
                {
                    if (!portfolioSplitDone)
                    {
                        Console.WriteLine("ERROR: portfolio split not performed " + algoID.ToString() + " algo and client " + (clientID - 1).ToString());
                        Console.ReadLine();
                    }
                    long mustReachId = Int64.Parse(parse[2]);
                    long blockId = Int64.Parse(parse[2]) - 1;
                    string partitionType = parse[3];
                    splitNode blockNode = new splitNode(parentId, partitionType);
                    splitNode mustReachNode = new splitNode(parentId, partitionType);
                    tree.Add(blockId, blockNode);
                    tree[blockId].clientId = clientID - 1;
                    tree.Add(mustReachId, mustReachNode);
                    Console.WriteLine("Added AND Nodes: " + blockId + " " + mustReachId);
                    if (!tree.ContainsKey(parentId))
                    {
                        Console.WriteLine("ERROR: Key not found for parentID : " + parentId);
                        Console.ReadLine();
                    }
                    tree[parentId].children.Add(blockId);
                    tree[parentId].children.Add(mustReachId);
                    if (!tree[parentId].isLeading)
                    {
                        tree[mustReachId].isLeading = false;
                        tree[blockId].isLeading = false;
                    }
                    numSplitsAnd++;
                    totalSplits[algoID]++;
                    clientCalltreeQueue[clientID - 1].PushLeft(calltree);
                }
                else
                {
                    //OR Partition
                    if (!staticAlphaListMode)
                    {
                        long ORId = Int64.Parse(parse[2]);
                        long dummySplitID = Int64.Parse(parse[2]) - 1;
                        string partitionType = parse[3];
                        splitNode dummyNode = new splitNode(parentId, partitionType);
                        splitNode ORNode = new splitNode(parentId, partitionType);
                        tree.Add(dummySplitID, dummyNode);
                        tree[dummySplitID].clientId = clientID - 1;
                        tree[dummySplitID].startTime = DateTime.Now;
                        tree.Add(ORId, ORNode);
                        Console.WriteLine("Added OR Nodes: " + dummySplitID + " " + ORId);
                        if (!tree.ContainsKey(parentId))
                        {
                            Console.WriteLine("ERROR: Key not found for parentID : " + parentId);
                            Console.ReadLine();
                        }
                        tree[parentId].children.Add(dummySplitID);
                        tree[parentId].children.Add(ORId);
                        if (!tree[parentId].isLeading)
                        {
                            tree[dummySplitID].isLeading = false;
                            tree[ORId].isLeading = false;
                        }
                        clientCalltreeQueueOr.PushLeft(calltree);
                        ShowClientCalltreeQueueOr();
                    }
                    else
                    {
                        //Special case to handle portfolio OR partitions
                        long ORId = Int64.Parse(parse[2]);
                        string partitionType = parse[3];
                        long splitMode = Int64.Parse(parse[0]);
                        splitNode ORNode = new splitNode(parentId, partitionType);
                        tree.Add(ORId, ORNode);
                        Console.WriteLine("Added OR Node: " + ORId);
                        if (!tree.ContainsKey(parentId))
                        {
                            Console.WriteLine("ERROR: Key not found for parentID : " + parentId);
                            Console.ReadLine();
                        }
                        tree[parentId].children.Add(ORId);
                        if (!tree[parentId].isLeading)
                            tree[ORId].isLeading = false;
                        if(splitMode != 100) // other than OR
                        {
                            clientCalltreeQueueOr.PushLeft(calltree);
                            ShowClientCalltreeQueueOr();
                        }
                        else
                        {
                            tree[ORId].clientId = clientID - 1;
                            tree[ORId].startTime = DateTime.Now;
                        }
                        if (showTreeLog)
                            showTree("after adding OR node " + ORId);
                    }
                    numSplitsOr++;
                }
                numSplits++;
                if (writeLog)
                    Console.WriteLine("Adding : calltreeStack count: " + callTreeStack.Count);
                int algoId = getAlgoID(clientID - 1);
                if (configuration.controlSplitRate)
                {
                    if (clientRequestQueue[algoId].Count == 0)
                        splitRate = 20.0d;
                    else
                        splitRate = (double)clientCalltreeQueue[clientID - 1].Count / (double)clientRequestQueue[algoId].Count;
                }
                reply = (splitRate * configuration.splitInterval).ToString();
                //Console.WriteLine("{0} {1} {2} {3}",clientCalltreeQueue[clientID - 1].Count, clientRequestQueue.Count, splitRate, (splitRate * configuration.splitInterval));
                bool err = ResponseHttp(context, reply);
                if (err)
                    handleClientCrash();
                lastSplitArrival = DateTime.Now;
            }
        }

        static void popCalltree(HttpListenerContext context, string idNumber)
        {
            //string reply;
            int clientID = Int16.Parse(idNumber);
            if(clientsToKill.Contains(clientID - 1))
            {
                handleKillingClients(context, idNumber);
            }
            else
            {
                string callTree;
                if (writeLog)
                    Console.WriteLine("pop request from client {0}", clientID - 1);
                if (writeLog)
                    Console.WriteLine("Stack Count : " + callTreeStack.Count);
                bool discard = true;    //Discard OR partitions
                while (discard)
                {
                    if (clientCalltreeQueue[clientID - 1].Count != 0)
                    {
                        callTree = clientCalltreeQueue[clientID - 1].PopLeft();
                        string[] parse = callTree.Split(';');
                        if (parse[3].Equals("AND"))
                        {
                            string reply = parse[2].ToString();
                            if (writeLog)
                                Console.WriteLine("Count of {0} is {1}", clientID - 1, clientCalltreeQueue[clientID - 1].Count);
                            //Console.ReadLine();
                            clientNumForwardPops[clientID - 1]++;
                            long partitionID = long.Parse(parse[2]);
                            if (tree.ContainsKey(partitionID))
                            {
                                tree[partitionID].clientId = clientID - 1;
                            }
                            else
                            {
                                //Client is killed but not present in kill queue, kill manually
                                reply = "KillNow";
                            }
                            ResponseHttp(context, reply);
                            discard = false;
                        }
                    }
                    else
                    {
                        string reply = "NO";
                        ResponseHttp(context, reply);
                        //clientNumReset[clientID - 1]++;
                        discard = false;
                    }
                }
                /*if (clientCalltreeQueue[clientID-1].Count != 0)
                {
                    //Console.WriteLine("Reply Pop to client " + clientID);
                    string reply = "YES";
                    clientCalltreeQueue[clientID - 1].PopLeft();
                    if (writeLog)
                        Console.WriteLine("Count of {0} is {1}", clientID-1, clientCalltreeQueue[clientID-1].Count);
                    //Console.ReadLine();
                    ResponseHttp(context, reply);
                    clientNumForwardPops[clientID - 1]++;
                }
                else
                {
                    string reply = "NO";
                    ResponseHttp(context, reply);
                    //clientNumReset[clientID - 1]++;
                }*/
                //if (writeLog)
                //    Console.WriteLine("Enqueue " + clientRequestQueue.Count);
            }
        }

        static int getAlgoID(int clientID)
        {
            int algoID = -1;
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                for(int i = 0; i < algoClientList[algo].Count; i++)
                {
                    if(algoClientList[algo][i] == clientID)
                    {
                        algoID = algo;
                        break;
                    }
                }
                if (algoID != -1)
                    break;
            }
            return algoID;
        }

        static string getFinalOutcome()
        {
            if (finalOutcome == "NOK")
                return finalOutcome;
            if (!waitForBetterResult)
            {
                if (isAnyReachedBound[bestAlgo])
                    finalOutcome = "ReachedBound";
                return finalOutcome;
            }

            // wait for better result
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                if(isJobGiven[algo] && isJobCompleted[algo] && !isAnyReachedBound[algo])
                {
                    bestAlgo = algo;
                    Console.WriteLine("WriteOutcome bestAlgo updated to " + bestAlgo.ToString());
                    finalOutcome = "OK";
                    return finalOutcome;
                }

            }

            finalOutcome = "ReachedBound";

            return finalOutcome;
        }

        static bool areAllTimedOut()
        {
            bool allTimedOut = true;
            for (int algo = 0; algo < totalAlgo; algo++)
            {
                if (isJobGiven[algo] && isJobCompleted[algo])
                {
                    allTimedOut = false;
                    break;
                }
            }
            return allTimedOut;
        }

        static void sendCalltree(HttpListenerContext context, string idNumber)
        {
            int clientID = Int16.Parse(idNumber);
            clientCalltreeRequestReceiveTime[clientID - 1] = DateTime.Now;
            Tuple<int, HttpListenerContext> t = new Tuple<int, HttpListenerContext>(clientID - 1, context);
            if (writeLog)
                Console.WriteLine("Enqueued request from {0}", clientID - 1);
            int algoID = getAlgoID(clientID - 1);
            Console.WriteLine("for clientid : " + (clientID - 1) + " algo id is " + algoID);
            if(algoID < 0 || algoID >= totalAlgo)
            {
                Console.WriteLine("ERROR WRONG algo ID");
            }
            clientRequestQueue[algoID].Enqueue(t);
        }

        public static void writeOutcome(bool timedOut)
        {
            string outFile = workingFile + ".txt";
            string toWrite;
            if (!timedOut)
                //toWrite = finalOutcome + "\n" + totalTime.ToString() + "\n" + timeGraph;
                toWrite = finalOutcome + "\n" + totalTime.ToString() + "\n" +
                    resetTime.ToString() + "\n" + communicationTime.ToString() +
                    "\n" + numSplits.ToString();
            else
                toWrite = "TIMEDOUT";
            File.WriteAllText(outFile, toWrite);
        }

        public static void writeAlgoDetails(string outFile, bool timedOut)
        {
            string toWrite = "#ALGO Details#";
            if(!timedOut)
                toWrite += "\nBest Algo splitMode:" + algoIdToSplitMode[bestAlgo].ToString();
            else
                toWrite += "\nBest Algo splitMode:-1";
            toWrite += "\nSplitMode:totalANDSplits";
            for(int algo = 0; algo < totalAlgo; algo++)
            {
                toWrite += "\n" + algoIdToSplitMode[algo].ToString() + ":" + totalSplits[algo].ToString();
            }
            File.AppendAllText(outFile, toWrite);
            Console.WriteLine("bestAlgo: " + bestAlgo.ToString());
        }

        public static void writetStats(string outFile)
        {
            string statsString = "#stats#";
            statsString += "\nTotalSplitsOR: " + numSplitsOr.ToString();
            statsString += "\nTotalSplitsAND: " + numSplitsAnd.ToString();

            statsString += "\nNon-Leading client : comma seperated leading clients killed";
            foreach (var tup in orList)
                statsString = statsString + "\n" + tup.Item1.ToString() + " : " + string.Join(",", tup.Item2);

            statsString += "\nNode : startTime, EndTime";
            foreach (var id in nodeTimes)
                statsString += "\n" + id.Key.ToString() + " : " + id.Value.Item1.ToString("dd/MM HH:mm:ss.ffffff") + "," + id.Value.Item2.ToString("dd/MM HH:mm:ss.ffffff");

            File.AppendAllText(outFile, statsString);

            Console.WriteLine("TotalSplitsOR: " + numSplitsOr.ToString());
            Console.WriteLine("TotalSplitsAND: " + numSplitsAnd.ToString());
            Console.WriteLine("count => " + orList.Count.ToString());
            Console.WriteLine("Non-Leading client : comma seperated leading clients killed");
            foreach(var tup in orList)
            {
                Console.Write(tup.Item1.ToString() + " : ");
                foreach(var val in tup.Item2)
                {
                    Console.WriteLine("," + val);
                }
                Console.WriteLine("");
            }
            Console.WriteLine("Node : startTime, EndTime");
            foreach (var id in nodeTimes)
            {
                Console.WriteLine(id.Key.ToString() + " : " + id.Value.Item1.ToString() + "," + id.Value.Item2.ToString());
            }
        }

        public static void writeDetailedOutcome(bool timedOut)
        {
            string outFile = workingFile + ".txt";
            string toWrite;
            bool allTimedOut = timedOut;
            if (waitForBetterResult)
                allTimedOut = areAllTimedOut();
            if (!allTimedOut)
            {
                finalOutcome = getFinalOutcome();
                toWrite = finalOutcome + "\n" + totalTime[bestAlgo].ToString() + "\n" + numSplits + "\n" + "Boogie Dump Took : " + boogieDumpTime.ToString() + "\n"
                    + smallestSplitInterval + "\n" + largestSplitInterval + "\n" + (averageSplitInterval/(double)numSplits) + "\n";
                Console.WriteLine("Verification Outcome : " + finalOutcome);
                Console.WriteLine("Time Taken : " + totalTime[bestAlgo].ToString());
                File.WriteAllText(outFile, toWrite);
                for (int i = 0; i < maxClients; i++)
                {
                    string statsPerClient = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}\n",
                        clientCommunicationTime[i], clientResetTime[i], clientInliningTime[i], clientSplittingTime[i], 
                        clientNumInlinings[i], clientNumZ3Calls[i], clientZ3Time[i], clientIdlingTime[i], clientNumReset[i],
                        clientNumForwardPops[i], clientNumBackwardPops[i]);
                    File.AppendAllText(outFile, statsPerClient);
                }
                //writetStats(outFile);
            }
            else
            {
                toWrite = "TIMEDOUT" + "\n" + configuration.timeout + "\n" + numSplits + "\n" + "Boogie Dump Took : " + boogieDumpTime.ToString() + "\n";
                Console.WriteLine("Verification Outcome : TIMEDOUT");
                Console.WriteLine("Time Taken : " + timeout.ToString());
                File.WriteAllText(outFile, toWrite);
                for (int i = 0; i < maxClients; i++)
                {
                    string statsPerClient = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}\n",
                        clientCommunicationTime[i], clientResetTime[i], clientInliningTime[i], clientSplittingTime[i],
                        clientNumInlinings[i], clientNumZ3Calls[i], clientZ3Time[i], clientIdlingTime[i], clientNumReset[i],
                        clientNumForwardPops[i], clientNumBackwardPops[i]);
                    File.AppendAllText(outFile, statsPerClient);
                }
                //writetStats(outFile);
            }
            writeAlgoDetails(outFile, allTimedOut);
        }

        public static bool ResponseHttp(HttpListenerContext context, string msg)
        {
            bool err = false;
            try
            {
                using (HttpListenerResponse response = context.Response)
                {
                    if (writeLog)
                        Console.WriteLine("Sending : " + msg);
                    byte[] outBytes = Encoding.UTF8.GetBytes(msg);
                    response.OutputStream.Write(outBytes, 0, outBytes.Length);
                    if (writeLog)
                        Console.WriteLine("Sent");
                }
            }
            catch (HttpListenerException)
            {
                err = true;
            }
            return err;
        }

        public static void handleClientCrash()
        {
            //NOT IMPLEMETED

            /*if (writeLog)
                Console.WriteLine("Assuming Client Has Crashed");
            fileQueue.Enqueue(workingFile);
            bool err = ResponseHttp(waitingListener, "RESTART");
            if (err)
                startListenerService();*/
        }

    }
}
