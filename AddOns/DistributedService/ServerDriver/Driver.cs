using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Threading;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace ServerDriver
{
    class Driver
    {
        public static Config configuration = new Config();
        
        static void Main(string[] args)
        {
            string inputFilesDirectory;
            string[] filePaths;
            Queue<string> fileQueue;
            int numProgramsToVerify;
            string workingFile;
            HttpListener _httpListener = new HttpListener();
            HttpListenerContext context;
            string configFilePath = args[0];
            setupConfig(args);
            int count = 1;
            string filename = "test";
            if (configuration.cloudDeployment)
            {
                _httpListener.Prefixes.Add(configuration.cloudAddress);
                _httpListener.Start();
                Console.WriteLine("Wainting for file upload");
                context = _httpListener.GetContext();                
                //Console.WriteLine(context.Request.QueryString["client"].ToString());
                String body = new StreamReader(context.Request.InputStream).ReadToEnd();
                Console.WriteLine("Received file");
                //Console.WriteLine(body);
                //Console.ReadLine();
                string[] parseBody = body.Split('\n');
                //Console.WriteLine(parseBody[0]);
                //Console.WriteLine(parseBody[1]);
                //Console.WriteLine(parseBody[2]);
                //Console.WriteLine(parseBody[3]);
                //Console.WriteLine(parseBody[4]);
                //Console.ReadLine();
                filename = configuration.inputFilesDirectoryPath + filename + count.ToString() + ".bpl";
                //Console.WriteLine(filename);
                string filebody = null;
                for (int i = 3; i < (parseBody.Length - 2); i++)
                {
                    filebody = filebody + parseBody[i] + "\n";
                }
                if (!Directory.Exists(configuration.inputFilesDirectoryPath))
                    Directory.CreateDirectory(configuration.inputFilesDirectoryPath);
                Console.WriteLine("Writing File");
                File.WriteAllText(filename, filebody);
                Console.WriteLine("Writing File Finished");
                fileQueue = new Queue<string>();
                fileQueue.Enqueue(filename);
                //Console.ReadLine();
                Console.WriteLine("Deploying Hydra");
                deployHydra(fileQueue, configFilePath);
                string resultFile = filename + ".txt";
                string result = File.ReadAllText(resultFile);
                Console.WriteLine(result);
                ResponseHttp(context, result);
                Thread.Sleep(60000);
                count++;
            }
            else
            {
                inputFilesDirectory = configuration.inputFilesDirectoryPath;
                filePaths = Directory.GetFiles(inputFilesDirectory, "*.bpl");
                fileQueue = new Queue<string>(filePaths);
                deployHydra(fileQueue, configFilePath);
            }            

        }

        static void deployHydra(Queue<string> fileQueue, string configFilePath)
        {
            int numProgramsToVerify = fileQueue.Count;
            string workingFile;

            for (int i = 0; i < numProgramsToVerify; i++)
            {
                workingFile = fileQueue.Dequeue();
                if (configuration.resume)
                {
                    string resultFileName = workingFile + ".txt";
                    if (File.Exists(resultFileName))
                    {
                        Console.WriteLine("Skipping " + workingFile);
                        continue;
                    }
                }
                Process p = new Process();
                if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                {
                    p.StartInfo.FileName = "mono";
                    p.StartInfo.Arguments = "LocalServerInCsharp.exe" + " " + workingFile + " " + configFilePath;
                    p.StartInfo.UseShellExecute = false;
                    //p.StartInfo.CreateNoWindow = false;
                    p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                    p.Start();
                }
                else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                {
                    p.StartInfo.FileName = "LocalServerInCsharp.exe";
                    p.StartInfo.Arguments = workingFile + " " + configFilePath;
                    //    " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3" +
                    //    " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1";
                    p.StartInfo.UseShellExecute = false;
                    //p.StartInfo.CreateNoWindow = false;
                    p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                    p.Start();
                }
                else
                    Console.WriteLine("Cannot Run On This Operating System");
                p.WaitForExit();
                Thread.Sleep(60000);    //Wait for cleanup
            }
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
            catch (Exception e)
            {
                Console.WriteLine("Server Could Not Send Message");
                Console.WriteLine("MESSAGE : ");
                Console.WriteLine(msg);
                Console.WriteLine(e);
                err = true;                
            }
            return err;
        }

        static void setupConfig(string[] args)
        {
            String configPath;
            int listenerAddressCount = 0;
            int listenerPathCount = 0;
            
            if (args.Length == 2)
            {
                Console.WriteLine("Driver requires only config");
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
                    case "cloudAddress":
                        configuration.cloudAddress = configKey[1];
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
                    case "cloudDeployment":
                        if (configKey[1] == "true")
                            configuration.cloudDeployment = true;
                        else
                            configuration.cloudDeployment = false;
                        break;
                    case "resume":
                        if (configKey[1] == "false")
                            configuration.resume = false;
                        else
                            configuration.resume = true;
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
                        Console.WriteLine("Not Needed For Driver: " + configKey[0]);
                        break;
                }
            }
        }
    }
    
}
