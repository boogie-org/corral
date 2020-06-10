
// A C# program for Client 
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Collections.Generic;
using LocalServerInCsharp;


namespace ClientSource
{
    
    class Program
    {
        public static List<Process> corralProcessList;
        public static string corralExecutablePath;
        public static int maxClients;
        public static Config configuration = new Config();
        // Main Method 
        static void Main(string[] args)
        {
            setupConfig(args[0]);
            ExecuteClient();
        }

        static void setupConfig(string configPath)
        {
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
                    default:
                        Console.WriteLine("Invalid Option");
                        break;
                }
            }
            configuration.corralArguments = " " + configuration.corralArguments + " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + configuration.serverAddress;
        }

        // ExecuteClient() Method 
        static void ExecuteClient()
        {
            while (true)
            {
                SendToServerAsync();
            }
        }

        static void SendToServerAsync()
        {
            HttpClient newClient = new HttpClient();
            newClient.Timeout = System.Threading.Timeout.InfiniteTimeSpan;
            //Config configuration = new Config();
            //UriBuilder serverUri = new UriBuilder("http://10.0.0.4:5000/");
            UriBuilder serverUri = new UriBuilder(configuration.serverAddress);
            
            maxClients = configuration.numMaxClients;
            corralExecutablePath = configuration.corralExecutablePath;
            //UriBuilder serverUri = new UriBuilder("http://172.27.18.129:5000/");
            Console.WriteLine("Listener Started");
            //string requestKey = Console.ReadLine();
            //string requestKeyValue = Console.ReadLine();
            string requestKey = "start";
            string requestKeyValue = "newJob";                                          //Value is placeholder. Not used anywhere
            serverUri.Query = string.Format("{0}={1}", requestKey, requestKeyValue);
            string replyFromServer = newClient.GetStringAsync(serverUri.Uri).Result;
            //serverUri.Query = string.Format(requestKey);
            //JsonContent tmp = new JsonContent(string.Format(requestKeyValue));
            //var rep = newClient.PostAsync(serverUri.Uri, tmp).Result;
            //string replyFromServer = rep.Content.ReadAsStringAsync().Result;
            Console.WriteLine(replyFromServer);
            if (replyFromServer.EndsWith(".bpl"))
                startVerification(replyFromServer);
            else if (replyFromServer.Equals("continue"))
                continueVerification();
            else if (replyFromServer.Equals("kill"))
                RestartVerification();
            else if (replyFromServer.Equals("returned"))
                Console.WriteLine(replyFromServer);
            else
                Console.WriteLine("No Action Taken");

            requestKey = "ListenerWaitingForRestart";
            requestKeyValue = "WaitForReply";                                            //Value is placeholder. Not used anywhere
            serverUri.Query = string.Format("{0}={1}", requestKey, requestKeyValue);
            replyFromServer = newClient.GetStringAsync(serverUri.Uri).Result;
            if (replyFromServer.Equals("RESTART"))
            {
                RestartVerification();
            }
            //JsonContent tmp = new JsonContent(string.Format("{0}={1}", "Start", "this"));
            //var rep = sendStart.PostAsync(address, tmp).Result;
            //string repStr = rep.Content.ReadAsStringAsync().Result;
            //return repStr;
            //string myJson = "{'Username': 'myusername','Password':'pass'}";
            /*using (var client = new HttpClient())
            {
                //var response = await client.PostAsync(
                //    "http://localhost:5000/",
                //     new StringContent(myJson, Encoding.UTF8, "application/json"));
                var response = await client.PostAsync("http://localhost:5000/", tmp);
                //Console.WriteLine(response.ToString());
                Console.WriteLine(response.Content.ReadAsStringAsync().Result);
                //return response;
            }*/
            //Thread.Sleep(1000);
        }

        static void startVerification(string fileName)
        {
            //corralProcessList.Clear();
            corralProcessList = new List<Process>();
            Console.WriteLine("Starting Verification of : " + fileName);
            for (int i = 0; i < maxClients; i++)
            {
                //System.Threading.Tasks.Task.Factory.StartNew(() => runClient());
                runCorral(fileName);
            }
        }

        static void runCorral(string fileName)
        {
            //corralExecutablePath = Directory.GetCurrentDirectory();
            //corralExecutablePath = corralExecutablePath.Substring(0, corralExecutablePath.Length-75);
            //corralExecutablePath = corralExecutablePath + @"bin\Debug\corral.exe";
            //Console.WriteLine(corralExecutablePath);
            //Console.ReadLine();
            //Config configuration = new Config();
            Process p = new Process();
            p.StartInfo.FileName = corralExecutablePath;
            p.StartInfo.Arguments = fileName + configuration.corralArguments;
            p.StartInfo.UseShellExecute = false;
            //p.StartInfo.CreateNoWindow = false;
            //p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
            //p.StartInfo.CreateNoWindow = true;
            //p.StartInfo.UseShellExecute = false;
            //p.StartInfo.RedirectStandardOutput = true;
            p.Start();
            corralProcessList.Add(p);
            //Process.Start(@"F:\00ResearchWork\HTTPCorral\client.exe");

        }

        static void continueVerification()
        {
            Console.WriteLine("Continuing Verification ");
        }

        static void RestartVerification()
        {
            Console.WriteLine("Kill All Clients And Restart Verification");
            //Thread.Sleep(1000);
            //Process.GetCurrentProcess().Kill();
            Console.WriteLine(corralProcessList.Count);
            foreach (Process p in corralProcessList)
            {
                //p.CancelOutputRead();
                //p.Close();
                //p.CloseMainWindow();
                //p.StandardInput.Close();
                if (!p.HasExited)
                    p.Kill();
            }
            Process killAllZ3Instances = new Process();
            killAllZ3Instances.StartInfo.FileName = "taskkill.exe";
            killAllZ3Instances.StartInfo.Arguments = "/F /IM z3.exe /T";
            killAllZ3Instances.Start();
            killAllZ3Instances.WaitForExit();
        }

    }

    public class JsonContent : StringContent
    {
        public JsonContent(object obj) :
            base(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json")
        { }
    }
}
