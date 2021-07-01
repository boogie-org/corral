using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Threading;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace ListenerDriver
{
    class LDriver
    {
        public static Config configuration = new Config();
        static void Main(string[] args)
        {
            setupConfig(args);
            string listenerExecutablePath = configuration.listenerExecutablePath;
            string configPath = args[0];

            while (true)
            {
                Console.WriteLine("Driver Spawning Listener");
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
                p.WaitForExit();
                Thread.Sleep(60000);    //Wait for cleanup
            }
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
                        Console.WriteLine("Not Needed For Driver: " + configKey[0]);
                        break;
                }
            }
        }
    }
}
