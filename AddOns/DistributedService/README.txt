Tutorial : How to deploy Hydra

1. Open AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\Config

    Modify the following parameters as per requirement:

    a. numListeners: Set the value to the number of machines on which you want to run Hydra clients
    b. numMaxClients: How many Hydra clients do you want to run per machine
    c. timeout: How long should verification run before timing out (in seconds)            
    d. inputFilesDirectoryPath: Path to the input directory. Hydra will verify each boogie file in the directory. For each boogie file <filename.bpl>, Hydra will write the result (putcome, total time etc.) in <filename.bpl.txt> in the same directory.
    e. serverAddress: ip address and port of the Hydra server. You may need to set custom in/out tcp and udp rules in order to enable the server to listen the specified port
    f. corralArguments: set of arguments which Hydra will use to verift programs
    g. startLocalListener: setting this to true will let Hydra run clients on the Server machine as well 

2. Build AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp.sln and cba.sln on the server and client machines
3. Run AddOns\DistributedService\LocalServerInCsharp\LocalServerInCsharp\bin\Debug\LocalServerInCsharp.exe on the server machine
4. Run AddOns\DistributedService\Client\Client\bin\Debug\Client.exe on each of the client machines