using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LocalServerInCsharp
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
        public bool writeDetailPerClient;
        public bool controlSplitRate;
        public double splitInterval;
        public bool spawnCorralWindows;
        public bool allowPopFromLocalStack;
        public Config()
        {
            startLocalListener = true;
            numMaxClients = 32;
            numListeners = 1;
            timeout = 3600;
            listenerExecutablePath = @"C:\HttpCorralMultiCLientRandom\AddOns\DistributedService\Client\Client\bin\Debug\Client.exe";
            corralExecutablePath = @"C:\HttpCorralMultiCLientRandom\bin\Debug\corral.exe";
            inputFilesDirectoryPath = @"C:\copyFiles\";
            serverAddress = "http://localhost:5000/";
            writeDetailPerClient = true;
            controlSplitRate = true;
            splitInterval = 0.5;
            spawnCorralWindows = false;
            allowPopFromLocalStack = true;
        }
    }
}
