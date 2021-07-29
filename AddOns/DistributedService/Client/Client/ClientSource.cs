
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
using System.Linq;
using System.Runtime.InteropServices;

namespace ClientSource
{
    
    class Program
    {
        public static List<Process> corralProcessList;
        public static string corralExecutablePath;
        public static string hydraBin;
        public static int maxClients;        
        public static Config configuration = new Config();
        public static double boogieDumpTime;
        // Main Method 
        static void Main(string[] args)
        {
            hydraBin = args[1];
            setupConfig(args[0]);
            configuration.corralExecutablePath = hydraBin + "/corral.exe";
            configuration.corralDumpBoogiePath = hydraBin + "/corral.exe";
            configuration.listenerExecutablePath = hydraBin + "/Client.exe";
            if (configuration.dumpSIBoogieFiles)
            {
                if (!Directory.Exists(configuration.boogieDumpDirectory))
                    Directory.CreateDirectory(configuration.boogieDumpDirectory);
            }
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
                    default:
                        Debug.WriteLine("Not Necessary For Listener: " + configKey[0]);
                        break;
                }
            }
            configuration.corralArguments = " " + configuration.corralArguments + " /si /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + configuration.serverAddress;
            configuration.corralDumpArguments = " " + configuration.corralDumpArguments + " /hydraServerURI:" + configuration.serverAddress + " /killAfter:" + configuration.timeout + " /printFinalProgOnly /printFinalProg:";
            //configuration.corralDumpArguments = " " + configuration.corralDumpArguments + " /killAfter:180 /printFinalProg:";
            configuration.hydraArguments = " " + configuration.hydraArguments + " /enableUnSatCoreExtraction:1 /hydraServerURI:" + configuration.serverAddress;
        }

        // ExecuteClient() Method 
        static void ExecuteClient()
        {
            while (true)
            {
                try
                {
                    SendToServerAsync();
                    break;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Server Has Not Yet Started.");
                    RestartVerification();
                    return;
                }
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
            //Console.WriteLine("Listener Started");
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
            //Console.WriteLine(replyFromServer);
            if (replyFromServer.EndsWith(".bpl"))
                startVerification(replyFromServer);
            else if (replyFromServer.Equals("continue"))
                continueVerification();
            else if (replyFromServer.Equals("kill"))
                RestartVerification();
            else if (replyFromServer.Equals("returned"))
                Debug.WriteLine(replyFromServer);
            else if (replyFromServer.Equals("Finished"))
                Process.GetCurrentProcess().Kill();
            else
                Debug.WriteLine("No Action Taken");
            while (true)
            {
                requestKey = "ListenerWaitingForRestart";
                requestKeyValue = "WaitForReply";                                            //Value is placeholder. Not used anywhere
                serverUri.Query = string.Format("{0}={1}", requestKey, requestKeyValue);
                replyFromServer = newClient.GetStringAsync(serverUri.Uri).Result;
                if (replyFromServer.Equals("RESTART"))
                    break;
            }
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
            boogieDumpTime = 0;
            corralProcessList = new List<Process>();
            //Console.WriteLine("Starting Verification of : " + fileName);
            string fileToRun;
            string siFilename = null;
            
            if (configuration.dumpSIBoogieFiles)
            {
                DateTime boogieDumpStart = DateTime.Now;
                Process p = new Process();
                if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                {
                    p.StartInfo.FileName = configuration.corralDumpBoogiePath;
                    //Console.WriteLine(configuration.corralDumpBoogiePath);
                    string origFilename;
                    if (fileName.Contains('\\'))
                    {
                        origFilename = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                    }
                    else if (fileName.Contains('/'))
                    {
                        origFilename = fileName.Substring(fileName.LastIndexOf('/') + 1);
                    }
                    else
                        origFilename = fileName;
                    siFilename = origFilename + ".bpl";
                    p.StartInfo.Arguments = fileName + configuration.corralDumpArguments + origFilename + ".bpl";
                    //Console.WriteLine(origFilename);
                    //Console.WriteLine(p.StartInfo.Arguments);
                    //Console.ReadLine();
                    p.StartInfo.UseShellExecute = false;
                }
                else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                {
                    p.StartInfo.FileName = "mono";
                    //Console.WriteLine(configuration.corralDumpBoogiePath);
                    string origFilename;
                    if (fileName.Contains('\\'))
                    {
                        origFilename = fileName.Substring(fileName.LastIndexOf('\\') + 1);
                    }
                    else if (fileName.Contains('/'))
                    {
                        origFilename = fileName.Substring(fileName.LastIndexOf('/') + 1);
                    }
                    else
                        origFilename = fileName;
                    siFilename = origFilename + ".bpl";
                    p.StartInfo.Arguments = configuration.corralDumpBoogiePath + " " + fileName + configuration.corralDumpArguments + origFilename + ".bpl";
                    //Console.WriteLine(origFilename);
                    //Console.WriteLine(p.StartInfo.Arguments);
                    //Console.ReadLine();
                    p.StartInfo.UseShellExecute = false;
                }
                else
                    Console.WriteLine("Cannot Run On This Operating System");
                p.Start();
                p.WaitForExit();
                //Console.WriteLine("SI Boogie File Dumped");
                string siFilePath = configuration.boogieDumpDirectory + siFilename;
                if (File.Exists(siFilePath))
                    File.Delete(siFilePath);
                File.Move(siFilename, siFilePath);
                fileToRun = siFilePath;
                boogieDumpTime = (DateTime.Now - boogieDumpStart).TotalSeconds;
            }
            else
                fileToRun = fileName;
            /*if ((configuration.timeout - boogieDumpTime) < 10)
                configuration.timeout = 10;
            else
                configuration.timeout = (configuration.timeout - boogieDumpTime);
            configuration.hydraArguments = configuration.hydraArguments + " /killAfter:" + (int)Math.Round(configuration.timeout);*/
            //Console.WriteLine(siFilePath);
            //Console.ReadLine();
            for (int i = 0; i < maxClients; i++)
            {
                //System.Threading.Tasks.Task.Factory.StartNew(() => runClient());
                runCorral(fileToRun);
                //runCorral(fileName);
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
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                p.StartInfo.FileName = corralExecutablePath;
                p.StartInfo.Arguments = fileName + configuration.hydraArguments;
                //Console.WriteLine(p.StartInfo.Arguments);
                p.StartInfo.UseShellExecute = false;
            }
            else if(RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                p.StartInfo.FileName = "mono"; 
                p.StartInfo.Arguments = corralExecutablePath + " " + fileName + configuration.hydraArguments;
                //Console.WriteLine(p.StartInfo.Arguments);
                p.StartInfo.UseShellExecute = false;
            }
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
            Debug.WriteLine("Continuing Verification ");
        }

        static void RestartVerification()
        {
            //Console.WriteLine("Kill All Clients And Restart Verification");
            //Thread.Sleep(1000);
            //Process.GetCurrentProcess().Kill();
            //Console.WriteLine(corralProcessList.Count);
            foreach (Process p in corralProcessList)
            {
                //p.CancelOutputRead();
                //p.Close();
                //p.CloseMainWindow();
                //p.StandardInput.Close();
                killProcessSubTree(p);
                if (!p.HasExited)
                    p.Kill();
            }
            /*Process killAllZ3Instances = new Process();
            killAllZ3Instances.StartInfo.FileName = "taskkill.exe";
            killAllZ3Instances.StartInfo.Arguments = "/F /IM z3.exe /T";
            killAllZ3Instances.Start();
            killAllZ3Instances.WaitForExit();*/
            /*
            foreach (var process in Process.GetProcessesByName("z3"))
            {
                if (!process.HasExited)
                    process.Kill();
            }*/
            //Console.ReadLine();
        }

        static void killProcessSubTree(Process p)
        {
            TimeSpan timeout = new TimeSpan();
            timeout = TimeSpan.FromMilliseconds(2000);
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                string stdout;
                RunProcessAndWaitForExit("taskkill", $"/T /F /PID {p.Id}", timeout, out stdout);
            }
            else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
            {
                HashSet<int> z3Process = new HashSet<int>();
                getZ3ProcessIds(p.Id, z3Process, timeout);
                foreach (var pid in z3Process)
                {
                    killProcess(pid, timeout);
                }
            }
            else
                Console.WriteLine("Cannot Run On This Operating System");
        }

        static void getZ3ProcessIds(int pid, ISet<int> z3Process, TimeSpan timeout)
        {
            string stdout;
            var exitCode = RunProcessAndWaitForExit("pgrep", $"-P {pid}", timeout, out stdout);

            if (exitCode == 0 && !string.IsNullOrEmpty(stdout))
            {
                using (var reader = new StringReader(stdout))
                {
                    while (true)
                    {
                        var text = reader.ReadLine();
                        if (text == null)
                        {
                            return;
                        }

                        int id;
                        if (int.TryParse(text, out id))
                        {
                            z3Process.Add(id);
                            // Recursively get the children                            
                        }
                    }
                }
            }
        }        

        static void killProcess(int pid, TimeSpan timeout)
        {
            string stdout;
            RunProcessAndWaitForExit("kill", $"-TERM {pid}", timeout, out stdout);
        }

        static int RunProcessAndWaitForExit(string fileName, string arguments, TimeSpan timeout, out string stdout)
        {
            var startInfo = new ProcessStartInfo
            {
                FileName = fileName,
                Arguments = arguments,
                RedirectStandardOutput = true,
                UseShellExecute = false
            };

            var process = Process.Start(startInfo);

            stdout = null;
            if (process.WaitForExit((int)timeout.TotalMilliseconds))
            {
                stdout = process.StandardOutput.ReadToEnd();
            }
            else
            {
                Console.WriteLine("Process did not finish");
                process.Kill();
                while (!process.WaitForExit(1000));
                Console.WriteLine("Process killed");
            }

            return process.ExitCode;
        }
    }

    public class JsonContent : StringContent
    {
        public JsonContent(object obj) :
            base(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json")
        { }
    }
}
