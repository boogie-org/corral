using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;

namespace ClientSource
{
    public class Config
    {
        public int numMaxClients;
        public int numListeners;
        public bool startLocalListener;
        public int timeout;
        public string listenerExecutablePath;
        public string corralExecutablePath;
        public string inputFilesDirectoryPath;
        public string serverAddress;
        public string corralArguments;
        public bool writeDetailPerClient;
        public bool controlSplitRate;
        public double splitInterval;
        public Config()
        {
            //The following values are set by default if the corresponding flag is not present in the configuration file

            numListeners = 1;
            numMaxClients = 3;
            timeout = 3600;
            inputFilesDirectoryPath = @"F:\00ResearchWork\SVCOMP\timeoutSICorrected\";
            serverAddress = "http://localhost:5000/";
            corralArguments = " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3 /bopt:proverOpt:O:smt.qi.eager_threshold=100";
            startLocalListener = true;

            //Modify The Following Flags Only If Necessary 

            // /newStratifiedInlining:ucsplitparallel runs the original heuristic
            // /newStratifiedInlining:ucsplitparallel2 enables the balanced heuristic
            corralArguments = corralArguments + " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + serverAddress;

            listenerExecutablePath = @"..\..\..\..\Client\Client\bin\Debug\Client.exe";
            corralExecutablePath = "corral.exe";
            writeDetailPerClient = true;
            controlSplitRate = true;
            splitInterval = 0.5;

            //string hostName = Dns.GetHostName(); // Retrive the Name of HOST  
            //Console.WriteLine(hostName);
            // Get the IP  
            //serverAddress = Dns.GetHostByName(hostName).AddressList[0].ToString();            
            //serverAddress = "http://" + serverAddress + ":5000/";
            //Console.WriteLine("My IP Address is :" + serverAddress);
        }
    }
}
