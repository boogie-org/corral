Tutorial : How to deploy Hydra

1. Pull this branch, build AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp.sln and copy Z3 4.6.0 to AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\bin\Debug\ on the server and client machines

2. Open AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\config.txt

    Modify the following parameters as per requirement:

    a. numListeners: Set the value to the number of machines on which you want to run Hydra clients
    b. numMaxClients: How many Hydra clients do you want to run per machine
    c. timeout: How long should verification run before timing out (in seconds)            
    d. inputFilesDirectoryPath: Path to the input directory. Hydra will verify each boogie file in the directory. For each boogie file <filename.bpl>, Hydra will write the result (putcome, total time etc.) in <filename.bpl.txt> in the same directory.
    e. corralDumpBoogie: Set this to corral.exe
    f. serverAddress: ip address and port of the Hydra server. You may need to set custom in/out tcp and udp rules in order to enable the server to listen the specified port
    g. corralArguments: set of arguments which corralDumpBoogie will use to dump intermediate SI boogie files
    h. hydraArguments: set of arguments which Hydra will use to verify the intermediate SI boogie files
    i. startLocalListener: setting this to true will let Hydra run clients on the Server machine as well 

3. Run AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\bin\Debug\LocalServerInCsharp.exe <path-to-config.txt> on the server machine
If you are using multiple listener nodes,
4. Run AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\bin\Debug\Client.exe <path-to-config.txt> on each of the client machines