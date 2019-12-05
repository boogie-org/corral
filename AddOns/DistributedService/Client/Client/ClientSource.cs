
// A C# program for Client 
using System;
using System.Net;
using System.Net.Sockets;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Collections.Generic;

namespace ClientSource
{
    
    class Program
    {
        public static List<Process> corralProcessList;

        // Main Method 
        static void Main(string[] args)
        {
            ExecuteClient();
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
            UriBuilder serverUri = new UriBuilder("http://localhost:5000/");
            
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
            for (int i = 0; i < 1; i++)
            {
                //System.Threading.Tasks.Task.Factory.StartNew(() => runClient());
                runCorral(fileName);
            }
        }

        static void runCorral(string fileName)
        {
            Process p = new Process();
            p.StartInfo.FileName = @"E:\HttpCorral\bin\Debug\corral.exe ";
            p.StartInfo.Arguments = fileName +
                " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3" +
                " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1";
            p.StartInfo.UseShellExecute = true;
            p.StartInfo.CreateNoWindow = false;
            p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
            
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
                p.Kill();
            }
        }

    }

    public class JsonContent : StringContent
    {
        public JsonContent(object obj) :
            base(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json")
        { }
    }
}
