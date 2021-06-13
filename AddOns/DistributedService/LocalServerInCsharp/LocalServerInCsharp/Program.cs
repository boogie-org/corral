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
        public static Queue<Tuple<int, HttpListenerContext>> clientRequestQueue = new Queue<Tuple<int, HttpListenerContext>>();
        //public static Queue<HttpListenerContext> clientRequestQueue = new Queue<HttpListenerContext>();
        public static Stack<string> callTreeStack = new Stack<string>();
        public static bool writeLog = false;
        public static string[] filePaths;
        public static Queue<string> fileQueue;
        public static Queue<HttpListenerContext> waitingListener;
        public static Queue<HttpListenerContext> initListener;
        //public static string outputFolderPath;
        public static string workingFile;
        public static string timeGraph;
        public static string finalOutcome;
        public static double totalTime;
        public static double resetTime;
        public static double communicationTime;
        private static bool receivedTimeGraph = false;
        public static bool askForResetTime = false;
        public static int numClientsResetTimeSent = 0;
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
            for (int i = 0; i < maxClients; i++)
                clientCalltreeQueue[i] = new Deque<string>();
            
            //foreach (string s in filePaths)
            //    Console.WriteLine(s);
            //Console.WriteLine("Starting server...");
            //_httpListener.Prefixes.Add("http://localhost:5000/"); // add prefix "http://localhost:5000/"
            //_httpListener.Prefixes.Add("http://10.0.0.7:5000/");
            _httpListener.Prefixes.Add(configuration.serverAddress);
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
                        replyStartOrWaitForCalltree(context);
                    else if (msgContent.ContainsKey("requestCalltree"))
                        sendCalltree(context, msgContent["requestCalltree"]);
                    else if (msgContent.ContainsKey("popFromLocalStack"))
                        popCalltree(context, msgContent["popFromLocalStack"]);
                    else if (msgContent.ContainsKey("outcome"))
                        checkOutcome(context, msgContent["outcome"]);
                    else if (msgContent.ContainsKey("ResetTime"))
                        addResetTime(context, msgContent["ResetTime"]);
                    else if (msgContent.ContainsKey("SplitNow"))
                    {
                        if (clientRequestQueue.Count > 0)
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
                if (clientRequestQueue.Count == maxClients && noJobLeft() && !askForResetTime)   //If all the clients are waiting, then none of them has any job left at queue
                {
                    if (writeLog)
                        Console.WriteLine("all clients waiting and no job left");
                    //bool err = ResponseHttp(context, "DONE");
                    /*bool err = ResponseHttp(waitingListener, "RESTART");
                    if (err)
                        startListenerService();*/
                     finalOutcome = "OK";
                     totalTime = (DateTime.Now - startTime).TotalSeconds;
                    //setKillFlag = true;
                    askForResetTime = true;
                    while(clientRequestQueue.Count > 0)
                    {
                        Tuple<int, HttpListenerContext> t = clientRequestQueue.Dequeue();
                        clientIdlingTime[t.Item1] = clientIdlingTime[t.Item1] + (DateTime.Now - clientCalltreeRequestReceiveTime[t.Item1]).TotalSeconds;
                        HttpListenerContext sendToClient = t.Item2;
                        ResponseHttp(sendToClient, "SendResetTime");
                    }
                }
                else
                {
                    //Console.WriteLine("Request Queue Count : {0}", clientRequestQueue.Count);
                    while (clientRequestQueue.Count > 0)
                    {
                        if (writeLog)
                            Console.WriteLine("Deque and Pop : free : {0}", clientRequestQueue.Count);                  
                        int clientIDOfLargestQueue = findClientIDOfLargestQueue();
                        if (clientIDOfLargestQueue == -1)  // No jobs available at any queue
                            break;
                        else
                        {
                            clientNumBackwardPops[clientIDOfLargestQueue]++;
                            Tuple<int, HttpListenerContext> t = clientRequestQueue.Dequeue();
                            clientNumReset[t.Item1]++;
                            HttpListenerContext sendToClient = t.Item2;
                            string calltreeToSend = clientCalltreeQueue[clientIDOfLargestQueue].PopRight();
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

                if (askForResetTime && numClientsResetTimeSent == maxClients)
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
                    totalTime = (DateTime.Now - startTime).TotalSeconds;
                    writeDetailedOutcome(true);
                    setKillFlag = true;
                    //ResponseHttp(waitingListener, "RESTART");
                    while (waitingListener.Count > 0)
                        ResponseHttp(waitingListener.Dequeue(), "RESTART");
                    //Console.WriteLine("TIMEOUT END");
                }
            }
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
            clientRequestQueue.Clear();
            setKillFlag = false;
            receivedTimeGraph = false;
            askForResetTime = false;
            numClientsResetTimeSent = 0;
            clientCalltreeQueue = new Deque<string>[maxClients];
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
                Console.WriteLine(workingFile);
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
            numClientsResetTimeSent++;
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

        public static int findClientIDOfLargestQueue()
        {
            int switchForSingleClient;
            if (maxClients == 1)
                switchForSingleClient = 0;
            else
                switchForSingleClient = 0;
            int maxQueueSize = switchForSingleClient;
            int clientIDOfLargestQueue = -1;
            for (int i = 0; i < clientCalltreeQueue.Length; i++)
            {
                if (clientCalltreeQueue[i].Count > maxQueueSize)
                {
                    maxQueueSize = clientCalltreeQueue[i].Count;
                    clientIDOfLargestQueue = i;
                }
            }
            if (maxQueueSize == switchForSingleClient)
                return -1;
            else
                return clientIDOfLargestQueue;
        }
        static void checkOutcome(HttpListenerContext context, string outcome)
        {
            if (writeLog)
                Console.WriteLine(outcome);
            numFreeClients++;
            if (outcome.Equals("NOK"))
            {
                //bool err = ResponseHttp(context, "kill");
                /*bool err = ResponseHttp(waitingListener, "RESTART");
                if (err)
                    startListenerService();*/
                finalOutcome = "NOK";
                totalTime = (DateTime.Now - startTime).TotalSeconds;
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
                {
                    bool err = ResponseHttp(context, "CONTINUE");
                    if (err)
                        handleClientCrash();
                }
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

        static void replyStartOrWaitForCalltree(HttpListenerContext context)
        {
            string reply;
            if (!startFirstJob)
            {
                reply = "YES";
                startFirstJob = true;
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

        static void addCalltree(HttpListenerContext context, int clientID, string calltree)
        {
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
            clientCalltreeQueue[clientID-1].PushLeft(calltree);
            numSplits++;
            if (writeLog)
                Console.WriteLine("Adding : calltreeStack count: " + callTreeStack.Count);
            if (configuration.controlSplitRate)
            {
                if (clientRequestQueue.Count == 0)
                    splitRate = 20.0d;
                else
                    splitRate = (double)clientCalltreeQueue[clientID - 1].Count / (double)clientRequestQueue.Count;
            }
            reply = (splitRate * configuration.splitInterval).ToString();
            //Console.WriteLine("{0} {1} {2} {3}",clientCalltreeQueue[clientID - 1].Count, clientRequestQueue.Count, splitRate, (splitRate * configuration.splitInterval));
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
            lastSplitArrival = DateTime.Now;
        }

        static void popCalltree(HttpListenerContext context, string idNumber)
        {
            //string reply;
            int clientID = Int16.Parse(idNumber);
            if (writeLog)
                Console.WriteLine("pop request from client {0}", clientID-1);
            if (writeLog)
                Console.WriteLine("Stack Count : " + callTreeStack.Count);
            if (clientCalltreeQueue[clientID-1].Count != 0)
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
            }                
            //if (writeLog)
            //    Console.WriteLine("Enqueue " + clientRequestQueue.Count);
        }

        static void sendCalltree(HttpListenerContext context, string idNumber)
        {
            int clientID = Int16.Parse(idNumber);
            clientCalltreeRequestReceiveTime[clientID - 1] = DateTime.Now;
            Tuple<int, HttpListenerContext> t = new Tuple<int, HttpListenerContext>(clientID - 1, context);
            if (writeLog)
                Console.WriteLine("Enqueued request from {0}", clientID - 1);
            clientRequestQueue.Enqueue(t);
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

        public static void writeDetailedOutcome(bool timedOut)
        {
            string outFile = workingFile + ".txt";
            string toWrite;
            if (!timedOut)
            {
                toWrite = finalOutcome + "\n" + totalTime.ToString() + "\n" + numSplits + "\n" + "Boogie Dump Took : " + boogieDumpTime.ToString() + "\n"
                    + smallestSplitInterval + "\n" + largestSplitInterval + "\n" + (averageSplitInterval/(double)numSplits) + "\n";
                Console.WriteLine("Verification Outcome : " + finalOutcome);
                Console.WriteLine("Time Taken : " + totalTime.ToString());
                File.WriteAllText(outFile, toWrite);
                for (int i = 0; i < maxClients; i++)
                {
                    string statsPerClient = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}\n",
                        clientCommunicationTime[i], clientResetTime[i], clientInliningTime[i], clientSplittingTime[i], 
                        clientNumInlinings[i], clientNumZ3Calls[i], clientZ3Time[i], clientIdlingTime[i], clientNumReset[i],
                        clientNumForwardPops[i], clientNumBackwardPops[i]);
                    File.AppendAllText(outFile, statsPerClient);
                }
            }
            else
            {
                totalTime = configuration.timeout;
                toWrite = "TIMEDOUT" + "\n" + configuration.timeout + "\n" + numSplits + "\n" + "Boogie Dump Took : " + boogieDumpTime.ToString() + "\n";
                Console.WriteLine("Verification Outcome : TIMEDOUT");
                Console.WriteLine("Time Taken : " + totalTime.ToString());
                File.WriteAllText(outFile, toWrite);
                for (int i = 0; i < maxClients; i++)
                {
                    string statsPerClient = string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}\n",
                        clientCommunicationTime[i], clientResetTime[i], clientInliningTime[i], clientSplittingTime[i],
                        clientNumInlinings[i], clientNumZ3Calls[i], clientZ3Time[i], clientIdlingTime[i], clientNumReset[i],
                        clientNumForwardPops[i], clientNumBackwardPops[i]);
                    File.AppendAllText(outFile, statsPerClient);
                }
            }
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
