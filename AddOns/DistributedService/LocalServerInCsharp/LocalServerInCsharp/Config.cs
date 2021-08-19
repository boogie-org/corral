using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;

namespace LocalServerInCsharp
{
    public class Config
    {
        public int numMaxClients;
        public int numListeners;
        public bool startLocalListener;
        public double timeout;
        public string listenerExecutablePath;
        public string corralExecutablePath;
        public string inputFile;
        public string inputFilesDirectoryPath;
        public string serverAddress;
        public string rawArguments;
        public string corralArguments;
        public string hydraArguments;
        public string corralDumpArguments;
        public string corralDumpBoogiePath;
        public string boogieDumpDirectory;
        public string hydraBin;
        public string smackBin;
        public bool dumpSIBoogieFiles;
        public bool writeDetailPerClient;
        public bool controlSplitRate;
        public double splitInterval;
        public string[] listenerAddress;
        public string[] listenerExecutablesLocation;
        public List<int> clientPoolSize;
        public Config()
        {
            //The following values are set by default if the corresponding flag is not present in the configuration file
            listenerAddress = new string[100];
            listenerExecutablesLocation = new string[100];
            numListeners = 2;
            numMaxClients = 3;
            timeout = 3600;
            inputFile = null;
            hydraBin = null;
            smackBin = null;
            inputFilesDirectoryPath = @"F:\00ResearchWork\SVCOMP\timeoutSICorrected\";
            serverAddress = "http://localhost:5000/";
            corralArguments = " /useProverEvaluate /di /si /doNotUseLabels /recursionBound:3 /bopt:proverOpt:O:smt.qi.eager_threshold=100";
            corralDumpArguments = " /useProverEvaluate /di /doNotUseLabels /recursionBound:3 /bopt:proverOpt:O:smt.qi.eager_threshold=100";
            rawArguments = " /useProverEvaluate /di /doNotUseLabels /recursionBound:3 /bopt:proverOpt:O:smt.qi.eager_threshold=100";
            hydraArguments = " /useProverEvaluate /di /doNotUseLabels /recursionBound:3 /bopt:proverOpt:O:smt.qi.eager_threshold=100";
            startLocalListener = true;
            dumpSIBoogieFiles = false;
            clientPoolSize = new List<int>();
            //Modify The Following Flags Only If Necessary 

            // /newStratifiedInlining:ucsplitparallel runs the original heuristic
            // /newStratifiedInlining:ucsplitparallel2 enables the balanced heuristic
            corralArguments = corralArguments + " /newStratifiedInlining:ucsplitparallel /enableUnSatCoreExtraction:1 /hydraServerURI:" + serverAddress;

            listenerExecutablePath = "Client.exe";
            corralExecutablePath = "corral.exe";
            corralDumpBoogiePath = "corral.exe";
            boogieDumpDirectory = inputFilesDirectoryPath + @"\boogieDump\";
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
