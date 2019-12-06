using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Threading;
using System.Diagnostics;

namespace LocalServerInCsharp
{
    class Program
    {
        static HttpListener _httpListener = new HttpListener();
        public static int numClients = 0;
        public static int numFreeClients = 0;
        public static int numSplits = 0;
        public static bool startFirstJob = false;
        public static bool setKillFlag = false;
        public static DateTime startTime;
        public static Queue<HttpListenerContext> clientRequestQueue = new Queue<HttpListenerContext>();
        public static Stack<string> callTreeStack = new Stack<string>();
        public static bool writeLog = false;
        public static string[] filePaths;
        public static Queue<string> fileQueue;
        public static HttpListenerContext waitingListener;
        public static string outputFolderPath;
        public static string workingFile;
        public static string timeGraph;
        public static string finalOutcome;
        public static double totalTime;
        private static bool receivedTimeGraph = false;
        public static DateTime lastClientCallAt;
        static void Main(string[] args)
        {
            numClients = 0;
            startFirstJob = false;
            filePaths = Directory.GetFiles(@"E:\copyFiles\", "*.bpl");
            outputFolderPath = @"E:\ExperimentOutput\";
            fileQueue = new Queue<string>(filePaths);
            //foreach (string s in filePaths)
            //    Console.WriteLine(s);
            Console.WriteLine("Starting server...");
            _httpListener.Prefixes.Add("http://localhost:5000/"); // add prefix "http://localhost:5000/"
            _httpListener.Start(); // start server (Run application as Administrator!)
            Console.WriteLine("Server started.");
            Console.WriteLine("Starting Listener...");
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
                    addCalltree(context, body.Substring(1, body.Length - 2));
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
                        waitingListener = context;
                    else if (msgContent.ContainsKey("requestID"))
                        assignIDtoClient(context);
                    else if (msgContent.ContainsKey("startFirstJob"))
                        replyStartOrWaitForCalltree(context);
                    else if (msgContent.ContainsKey("requestCalltree"))
                        sendCalltree(context);
                    else if (msgContent.ContainsKey("outcome"))
                        checkOutcome(context, msgContent["outcome"]);
                    else if (msgContent.ContainsKey("calltree"))
                        addCalltree(context, msgContent["calltree"]);
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

                if (receivedTimeGraph) 
                {
                    writeOutcome(false);
                    bool err = ResponseHttp(waitingListener, "RESTART");
                    if (err)
                        startListenerService();
                }

                if ((DateTime.Now - startTime).TotalSeconds > 7200)
                {
                    writeOutcome(true);
                    //ResponseHttp(waitingListener, "RESTART");
                    bool err = ResponseHttp(waitingListener, "RESTART");
                    if (err)
                        startListenerService();
                }
            }
        }

        static void startListenerService()
        {
            startTime = DateTime.Now;
            Process p = new Process();
            p.StartInfo.FileName = @"E:\HttpCorral\AddOns\DistributedService\Client\Client\bin\Debug\Client.exe";
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
            startTime = DateTime.Now;
            numClients = 0;
            numFreeClients = 0;
            numSplits = 0;
            startFirstJob = false;
            callTreeStack.Clear();
            clientRequestQueue.Clear();
            setKillFlag = false;
            receivedTimeGraph = false;
            //string programToVerify = "61883_completerequeststatuscheck_0.bpl.bpl";
            if (fileQueue.Count == 0)
            {
                Console.WriteLine("All Finished");
                Console.ReadLine();
            }
            else
            {
                workingFile = fileQueue.Dequeue();
                bool err = ResponseHttp(context, workingFile);
                if (err)
                    handleClientCrash();
            }
        }

        static void checkOutcome(HttpListenerContext context, string outcome)
        {
            if (writeLog)
                Console.WriteLine(outcome);
            numFreeClients++;
            if (outcome.Equals("NOK"))
            {
                bool err = ResponseHttp(context, "kill");
                if (err)
                    handleClientCrash();
                finalOutcome = "NOK";
                totalTime = (DateTime.Now - startTime).TotalSeconds;
            }
            else
            {
                if (numFreeClients == numClients && callTreeStack.Count == 0)
                {
                    bool err = ResponseHttp(context, "DONE");
                    if (err)
                        handleClientCrash();
                    finalOutcome = "OK";
                    totalTime = (DateTime.Now - startTime).TotalSeconds;
                }
                else
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
                bool err = ResponseHttp(context, reply);
                if (err)
                    handleClientCrash();
            }
            else
            {
                if (callTreeStack.Count == 0)
                    clientRequestQueue.Enqueue(context);
                else
                {
                    reply = callTreeStack.Pop();
                    bool err = ResponseHttp(context, reply);
                    if (err)
                        handleClientCrash();
                }
            }            
        }

        static void addCalltree(HttpListenerContext context, string calltree)
        {
            string reply;
            
            callTreeStack.Push(calltree);
            numSplits++;
            if (writeLog)
                Console.WriteLine("Adding : calltreeStack count: " + callTreeStack.Count);
            reply = "added";
            bool err = ResponseHttp(context, reply);
            if (err)
                handleClientCrash();
        }

        static void sendCalltree(HttpListenerContext context)
        {
            string reply;
            if (writeLog)
                Console.WriteLine("Stack Count : " + callTreeStack.Count);

            /*if (setKillFlag)
            {
                ResponseHttp(context, "kill");
                finalOutcome = "NOK";
                totalTime = (DateTime.Now - startTime).TotalSeconds;
                while (!receivedTimeGraph)
                {//Wait for timeGraph to Arrive
                }
                writeOutcome();
                //Console.WriteLine("Verification Finished : Outcome NOK");
                //Console.WriteLine("Number of Splits : " + numSplits);
                //Console.WriteLine("Time Taken : " + (DateTime.Now - startTime).TotalSeconds);
                ResponseHttp(waitingListener, "RESTART");
            }*/
            //else
            {
                if (callTreeStack.Count == 0)
                {
                    clientRequestQueue.Enqueue(context);
                    numFreeClients++;
                    //ResponseHttp(context, "UNAVAILABLE");
                    /*if (clientRequestQueue.Count == numClients)
                    {
                        ResponseHttp(context, "DONE");
                        finalOutcome = "OK";
                        totalTime = (DateTime.Now - startTime).TotalSeconds;
                        while (!receivedTimeGraph)
                        {//Wait for timeGraph to Arrive
                        }
                        writeOutcome();
                        //Console.WriteLine("Verification Finished : Outcome OK");
                        //Console.WriteLine("Number of Splits : " + numSplits);
                        //Console.WriteLine("Time Taken : " + (DateTime.Now - startTime).TotalSeconds);
                        ResponseHttp(waitingListener, "RESTART");
                    }*/
                }
                else
                {
                    numFreeClients--;
                    reply = callTreeStack.Pop();
                    if (writeLog)
                        Console.WriteLine("Removing : calltreeStack count: " + callTreeStack.Count);
                    bool err = ResponseHttp(context, reply);
                    if (err)
                        handleClientCrash();
                }
            }
        }

        public static void writeOutcome(bool timedOut)
        {
            string outFile = workingFile + ".txt";
            string toWrite;
            if (!timedOut)
                toWrite = finalOutcome + "\n" + totalTime.ToString() + "\n" + timeGraph;
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
                    byte[] outBytes = Encoding.UTF8.GetBytes(msg);
                    response.OutputStream.Write(outBytes, 0, outBytes.Length);
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
            Console.WriteLine("Assuming Client Has Crashed");
            fileQueue.Enqueue(workingFile);
            bool err = ResponseHttp(waitingListener, "RESTART");
            if (err)
                startListenerService();
        }

    }
}
