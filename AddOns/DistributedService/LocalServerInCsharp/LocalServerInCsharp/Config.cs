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
        public Config()
        {
            startLocalListener = true;
            numMaxClients = 1;
            numListeners = 1;
            timeout = 3600;
            listenerExecutablePath = @"E:\HttpCorralMultiCLientDEQueue\AddOns\DistributedService\Client\Client\bin\Debug\Client.exe";
            corralExecutablePath = @"E:\HttpCorralMultiCLientDEQueue\bin\Debug\corral.exe";
            inputFilesDirectoryPath = @"E:\copyFiles\";
            serverAddress = "http://localhost:5000/";
        }
    }
}
