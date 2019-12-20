using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Threading;
using System.Diagnostics;
using DequeNet;

namespace LocalServerInCsharp
{
    class Program
    {
        static HttpListener _httpListener = new HttpListener();
        public static int numClients = 0;
        public static int numFreeClients = 0;
        public static int maxClients;
        public static int maxListeners;
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
        public static string outputFolderPath;
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

        static void Main(string[] args)
        {
            Config configuration = new Config();
            maxClients = configuration.numMaxClients * configuration.numListeners;
            maxListeners = configuration.numListeners;
            waitingListener = new Queue<HttpListenerContext>();
            initListener = new Queue<HttpListenerContext>();
            numClients = 0;
            startFirstJob = false;
            listenerExecutablePath = Directory.GetCurrentDirectory();
            listenerExecutablePath = listenerExecutablePath.Substring(0, listenerExecutablePath.Length - 49);
            listenerExecutablePath = listenerExecutablePath + @"Client\Client\bin\Debug\Client.exe";
            //Console.WriteLine(listenerExecutablePath);
            //Console.ReadLine();
            inputFilesDirectory = listenerExecutablePath.Substring(0, listenerExecutablePath.Length - 89);
            inputFilesDirectory = inputFilesDirectory + @"copyFiles\" ;
            //Console.WriteLine(inputFilesDirectory);
            //Console.ReadLine();
            filePaths = Directory.GetFiles(inputFilesDirectory, "*.bpl");
            outputFolderPath = @"E:\ExperimentOutput\";
            fileQueue = new Queue<string>(filePaths);
            clientCalltreeQueue = new Deque<string>[maxClients];
            for (int i = 0; i < maxClients; i++)
                clientCalltreeQueue[i] = new Deque<string>();
            
            //foreach (string s in filePaths)
            //    Console.WriteLine(s);
            Console.WriteLine("Starting server...");
            //_httpListener.Prefixes.Add("http://localhost:5000/"); // add prefix "http://localhost:5000/"
            _httpListener.Prefixes.Add("http://10.0.0.4:5000/");
            _httpListener.Start(); // start server (Run application as Administrator!)
            Console.WriteLine("Server started.");
            Console.WriteLine("Waiting for Listener...");
            if (configuration.startLocalListener)
                startListenerService();
            Thread _responseThread = new Thread(ResponseThread);
            _responseThread.Start(); // start the response thread
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
                    //Console.ReadLine();
                    if (msgContent.ContainsKey("start"))
                        startVerification(context);
                    else if (msgContent.ContainsKey("ListenerWaitingForRestart"))
                        waitingListener.Enqueue(context);
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
                            Tuple<int, HttpListenerContext> t = clientRequestQueue.Dequeue();
                            HttpListenerContext sendToClient = t.Item2;
                            string calltreeToSend = clientCalltreeQueue[clientIDOfLargestQueue].PopRight();
                            if (writeLog)
                            {
                                Console.WriteLine("Sending job from client {0} to client {1}", clientIDOfLargestQueue,
                                    t.Item1);
                                Console.WriteLine(calltreeToSend);
                            }
                            ResponseHttp(sendToClient, calltreeToSend);
                            numFreeClients--;
                        }
                    }
                }

                if (askForResetTime && numClientsResetTimeSent == maxClients)
                    setKillFlag = true;
                //Console.ReadLine();
                //if (receivedTimeGraph)
                if (setKillFlag)
                {
                    writeOutcome(false);
                    //Console.ReadLine();
                    while (waitingListener.Count > 0)
                        ResponseHttp(waitingListener.Dequeue(), "RESTART");
                    /*if (err)
                        startListenerService();*/
                }                

                if ((DateTime.Now - startTime).TotalSeconds > 3600)
                {
                    startTime = DateTime.Now; //to fix the waitingListener getting disposed error. Do NOT enter more than once for one program.
                    writeOutcome(true);
                    //ResponseHttp(waitingListener, "RESTART");
                    while (waitingListener.Count > 0)
                        ResponseHttp(waitingListener.Dequeue(), "RESTART");
                }
            }
        }

        static void startListenerService()
        {
            startTime = DateTime.Now;
            Process p = new Process();
            p.StartInfo.FileName = listenerExecutablePath;
            //p.StartInfo.Arguments = fileName +
            //    " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3" +
            //    " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1";
            p.StartInfo.UseShellExecute = true;
            p.StartInfo.CreateNoWindow = false;
            p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;

            p.Start();
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
            Console.WriteLine("starting verification");
            startTime = DateTime.Now;
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
            for (int i = 0; i < maxClients; i++)
                clientCalltreeQueue[i] = new Deque<string>();
            //string programToVerify = "61883_completerequeststatuscheck_0.bpl.bpl";
            if (fileQueue.Count == 0)
            {
                Console.WriteLine("All Finished");
                Console.ReadLine();
            }
            else
            {
                workingFile = fileQueue.Dequeue();
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
            double communicationTimeByClient = double.Parse(parsedMessage[0]);
            double resetTimeByClient = double.Parse(parsedMessage[1]);
            resetTime = resetTime + resetTimeByClient;
            communicationTime = communicationTime + communicationTimeByClient; 
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
                switchForSingleClient = 1;
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
                startTime = DateTime.Now;
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
            string reply;
            if (writeLog)
                Console.WriteLine("client {0} adding calltree", clientID - 1);
            //callTreeStack.Push(calltree);
            clientCalltreeQueue[clientID-1].PushLeft(calltree);
            numSplits++;
            if (writeLog)
                Console.WriteLine("Adding : calltreeStack count: " + callTreeStack.Count);
            reply = "added";
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
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
            }
            else
            {
                string reply = "NO";
                ResponseHttp(context, reply);
                
            }                
            //if (writeLog)
            //    Console.WriteLine("Enqueue " + clientRequestQueue.Count);
        }

        static void sendCalltree(HttpListenerContext context, string idNumber)
        {
            int clientID = Int16.Parse(idNumber);
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
