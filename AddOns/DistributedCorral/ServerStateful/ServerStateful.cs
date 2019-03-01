using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Fabric;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using cba.Util;
using Common;
using Microsoft.ServiceFabric.Data.Collections;
using Microsoft.ServiceFabric.Services.Client;
using Microsoft.ServiceFabric.Services.Communication.Runtime;
using Microsoft.ServiceFabric.Services.Runtime;  
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Sandboxable.Microsoft.WindowsAzure.Storage;
using Sandboxable.Microsoft.WindowsAzure.Storage.Blob;

namespace ServerStateful
{ 
    internal sealed class ServerStateful : StatefulService
    {
        public const string ServiceEventSourceName = "ServerService";
        private readonly ServicePartitionResolver servicePartitionResolver = ServicePartitionResolver.GetDefault();
        private readonly HttpClient httpClient = new HttpClient();
        private List<Int64RangePartitionInformation> partitionInfo = null;
        private Uri serviceUri = new Uri(Common.Utils.ClientStatefulService);
        private bool verificationFinished = false; 
        private string workingFile = ""; 
        private CloudStorageAccount csa = null;
        private CloudBlobContainer blobContainer = null;
        private TimeGraph tg = null;
         
        public ServerStateful(StatefulServiceContext context)
            : base(context)
        {
            ServiceEventSource.Current.ServiceInstanceConstructed(ServiceEventSourceName);
        } 

        protected override IEnumerable<ServiceReplicaListener> CreateServiceReplicaListeners()
        {
            return new[] {
                new ServiceReplicaListener(context => new HttpCommunicationListener(Common.Utils.ServerServiceEndpoint, context, RecevingController)),
            }; 
        }

        private async Task RecevingController(HttpListenerContext context, CancellationToken cancellationToken)
        {
            Dictionary<string, string> msgContent = null; 
            // parse input msg
            List<string> allKeys = context.Request.QueryString.AllKeys.ToList();
            if (allKeys.Count == 0)
            {
                // message is large, send reply immediately 
                var body = new StreamReader(context.Request.InputStream).ReadToEnd();
                msgContent = Common.Utils.ParseMsg(body.Replace("\"", ""));
            }
            else
            {
                msgContent = new Dictionary<string, string>();
                foreach (var key in allKeys)
                {
                    msgContent.Add(key, context.Request.QueryString[key].ToString());
                }
            }

            //  handle msg
            if (msgContent.ContainsKey(HttpUtil.InputFile) && !msgContent.ContainsKey(HttpUtil.VerificationOutcome) && !msgContent.ContainsKey(HttpUtil.Restart)) 
                await AddInputFile(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.Avail))
                await CheckAvailability(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.AskStatus))
                await AskStatus(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.NewCallSites) && msgContent.ContainsKey(HttpUtil.SplitNodes))
                await AddNewCallTree(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.NewCallSite))
                await ReceiveCallSite(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.SplitNodes))
                await AddSplitNodes(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.VerificationOutcome))
                await ReceiveVerificationResult(context, msgContent, cancellationToken);

            else if (msgContent.ContainsKey(HttpUtil.Stats))
                ReceiveStats(context, msgContent, cancellationToken);

            if (msgContent.ContainsKey(HttpUtil.InputFile) && msgContent.ContainsKey(HttpUtil.Restart))
                await ReceiveResetRequest(context, msgContent);
        }

        /**
         * 
         */
        private async Task ReceiveResetRequest(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string inputFile = "";
            if (msgContent.ContainsKey(HttpUtil.InputFile))
                inputFile = msgContent[HttpUtil.InputFile];
            else
                inputFile = workingFile;
            string inputCallTree = msgContent[HttpUtil.Server2ClientInput]; 

            string sender = "";
            if (msgContent.ContainsKey(HttpUtil.Sender))
            {
                sender = msgContent[HttpUtil.Sender];
            }
            Log.WriteLine(string.Format("Get restart request from {0}: {1}", sender, inputCallTree));
            Common.Utils.ResponseHttp(context);
        }

        /**
         * 
         */
        private async Task AddInputFile(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string fileDir = msgContent[HttpUtil.InputFile];
            Log.WriteLine(string.Format("Input file: {0}", fileDir)); 

            IReliableConcurrentQueue<string> inputQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<string>>(Common.Utils.InputQueue);
            while (true)
            {
                try
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        await inputQueue.EnqueueAsync(tx, fileDir.Replace("\"", ""));
                        await tx.CommitAsync();
                        break;
                    }
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            Common.Utils.ResponseHttp(context);
        }

        /**
         * Client asks if the task is available
         */
        private async Task CheckAvailability(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string taskID = msgContent[HttpUtil.Avail]; 
            Log.WriteLine(string.Format("Checking availability of {0}", taskID));
            var result = await ActiveCheckAvailability(taskID);

            if (result)
            { 
                Common.Utils.ResponseHttp(context, HttpUtil.Yes);
            }
            else
            { 
                Common.Utils.ResponseHttp(context, HttpUtil.No);
            }
        }

        /**
         * Server removes the task without asking client-task owner
         */
        private async Task<bool> ActiveCheckAvailability(string taskID)
        {
            IReliableDictionary<string, bool> callTreeDictionary = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.CallTreeDictionary);
            bool result = true;
            //bool senderAvailable = await CheckSenderStatus(taskID);
            bool senderAvailable = !verificationFinished;
            while (true)
            {
                try
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        var contained = await callTreeDictionary.ContainsKeyAsync(tx, taskID);
                        if (contained)
                        {
                            var status = await callTreeDictionary.TryGetValueAsync(tx, taskID);
                            if (status.HasValue && status.Value)
                            {
                                // remove the task
                                await callTreeDictionary.AddOrUpdateAsync(tx, taskID, false, (key, oldVal) => false);
                                result = true;
                            }
                            else
                            {
                                result = false;
                            }
                        }
                        else
                        {
                            // sender is availabe && calltree has not been added --> on its way to be added --> add it as a picked one == remove the task
                            Log.WriteLine(string.Format(">> Special case: {0} not arrived", taskID));
                            await callTreeDictionary.AddOrUpdateAsync(tx, taskID, false, (key, oldVal) => false);
                            result = senderAvailable ? true : false;
                        }
                        await tx.CommitAsync();
                        break;
                    }
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            return result;
        }

        /**
         * Server asks client if the task is available
         */
        private async Task<bool> PassiveCheckAvailability(string taskID, CancellationToken cancellationToken)
        {
            string sender = await GetSenderID(taskID);
            foreach (var p in partitionInfo)
            {
                if (p.Id.ToString().Equals(sender))
                {
                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                    var address = GetClientAddress(tmp, cancellationToken);
                    UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
                    primaryReplicaUriBuilder.Query = string.Format("{0}={1}", HttpUtil.Avail, taskID);
                    var rep = await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
                    if (rep.Equals(HttpUtil.Yes))
                        return true;
                    else
                        return false;                    
                }
            }
            return false;
        }

        private async Task<bool> PassiveAskAvailability(string taskID, CancellationToken cancellationToken)
        {
            string sender = await GetSenderID(taskID);
            foreach (var p in partitionInfo)
            {
                if (p.Id.ToString().Equals(sender))
                {
                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                    var address = GetClientAddress(tmp, cancellationToken);
                    UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
                    primaryReplicaUriBuilder.Query = string.Format("{0}={1}", HttpUtil.AskAvail, taskID);
                    var rep = await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
                    if (rep.Equals(HttpUtil.Yes))
                        return true;
                    else
                        return false;
                }
            }
            return false;
        }

        private async Task ReceiveVerificationResult(HttpListenerContext context, Dictionary<string, string> msgContent, CancellationToken cancellationToken)
        {
            string inputFile = "";
            if (msgContent.ContainsKey(HttpUtil.InputFile))
                inputFile = msgContent[HttpUtil.InputFile];
            else
                inputFile = workingFile;
            string inputCallTree = msgContent[HttpUtil.Server2ClientInput];
            string outcome = msgContent[HttpUtil.VerificationOutcome];

            string sender = "";
            if (msgContent.ContainsKey(HttpUtil.Sender))
            {
                sender = msgContent[HttpUtil.Sender];
            }
            else
            {
                // find Sender
                sender = await GetWorkerID(inputCallTree);
            }

            if (!Common.Utils.GetInputFileName(inputFile).Equals(Common.Utils.GetInputFileName(workingFile)) && workingFile.Length > 0)
            {
                Log.WriteLine(string.Format("Wrong input file: {0} != {1}", Common.Utils.GetInputFileName(inputFile), workingFile));
                Common.Utils.ResponseHttp(context);
                return;
            }

            tg.AddEdgeDone(sender);
            
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);
            IReliableDictionary<string, string> supporterMap = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.Supporter);

            bool loadOrWork = false;
            BoogieVerify.ReturnStatus result = Common.Utils.DecodeResult(Int32.Parse(outcome));
             
            // mark the client and his supporter to be available
            while (true)
            {
                try
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        var isLoading = await clientState.TryGetValueAsync(tx, sender);
                        if (isLoading.HasValue)
                        {
                            loadOrWork = isLoading.Value.Item1;
                        }
                        await clientState.AddOrUpdateAsync(tx, sender, new Tuple<bool, string>(false, ""), (key, oldValue) => new Tuple<bool, string>(false, ""));
                        Log.WriteLine(string.Format(">>> {0}: completed {1}", Common.Utils.ShortenStr(sender), inputCallTree));

                        bool hasSupporter = await supporterMap.ContainsKeyAsync(tx, sender);
                        if (hasSupporter)
                        {
                            var supporter = await supporterMap.TryGetValueAsync(tx, sender);
                            // TODO: send cancelling loading task
                            if (supporter.HasValue && supporter.Value.Length > 0)
                            {
                                string address = await GetClientAddress(supporter.Value, cancellationToken);
                                if (address == null)
                                    Log.WriteLine(Log.Error, string.Format("Address of {0} cannot be null.", sender));
                                else
                                    SendRequest(httpClient, address, HttpUtil.CancelLoadingCT);
                            }
                        }
                        await tx.CommitAsync();
                    }
                    break;
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, string.Format("Error at Calltree {0} | {1} | {2}", inputCallTree, inputFile, e.ToString()));
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }

            Common.Utils.ResponseHttp(context);
            
            if (loadOrWork && inputCallTree.Length > 0)
            {
                // two clients doing same work
                foreach (var p in partitionInfo)
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        var work = await clientState.ContainsKeyAsync(tx, p.Id.ToString());
                        if (work)
                        {
                            var workValue = await clientState.TryGetValueAsync(tx, p.Id.ToString());
                            if (workValue.HasValue)
                            {
                                if (workValue.Value.Item2.Equals(inputCallTree))
                                {
                                    await clientState.AddOrUpdateAsync(tx, p.Id.ToString(), new Tuple<bool, string>(false, ""), (key, oldValue) => new Tuple<bool, string>(false, ""));

                                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                                    var address = GetClientAddress(tmp, cancellationToken);
                                    SendRequest(httpClient, address, HttpUtil.CancelLoadingCT); 
                                }
                            }
                        }
                        await tx.CommitAsync();
                    }

                }
            }

            if (loadOrWork)
            {
                bool completed = false;
                switch (result)
                {
                    case BoogieVerify.ReturnStatus.NOK:
                        completed = true;
                        break;
                    default:
                        if (!verificationFinished)
                            completed = await CheckCompletion();
                        break;
                }


                if (completed)
                {
                    if (verificationFinished != true)
                    {
                        verificationFinished = true; 
                        Log.WriteLine(Log.Important, string.Format(">>> Verification: {0}: {1}", inputFile, Common.Utils.DecodeStatus(result)));
                        await CleanVerification();
                        await SendStopMsgs(cancellationToken);
                        if (Config.GenGraph)
                            WriteDotFile();
                    }
                }
            }
        }

        private void ReceiveStats(HttpListenerContext context, Dictionary<string, string> msgContent, CancellationToken cancellationToken)
        {
            string stats = msgContent[HttpUtil.Stats];
            string inputFile = "";
            if (msgContent.ContainsKey(HttpUtil.InputFile))
                inputFile = msgContent[HttpUtil.InputFile];
            else
                inputFile = workingFile;

            Log.WriteLine(Log.Info, string.Format("Input: {0} | Stats: {1}", inputFile, stats));
            Common.Utils.ResponseHttp(context); 
        }

        /*
         * 
         */
        private async Task AskStatus(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string taskID = msgContent[HttpUtil.AskStatus];
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue =
                await StateManager.GetOrAddAsync<IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            if (callTreeQueue.Count < Config.CallTreeQueueSize)            
            { 
                Common.Utils.ResponseHttp(context);
            }
            else
            {
                Common.Utils.ResponseHttp(context, HttpUtil.NotAdded);
            }
        }

        private async Task AddNewCallTree(HttpListenerContext context, Dictionary<string, string> msgContent)
        { 
            string callTreeName = msgContent[HttpUtil.NewCallTree];
            string fileName = msgContent[HttpUtil.FileName];
            if (!Common.Utils.GetInputFileName(fileName).Equals(Common.Utils.GetInputFileName(workingFile)) && workingFile.Length > 0)
            {
                Common.Utils.ResponseHttp(context);
                Log.WriteLine(string.Format("Not add CT{0}: wrong input {1} != {2}", callTreeName, fileName, workingFile));
                return;
            }

            //bool senderAvailable = await CheckSenderStatus(callTreeName);
            bool senderAvailable = !verificationFinished;
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue =
                await StateManager.GetOrAddAsync<IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue); 

            string parentTask = Common.Utils.GetParentTask(callTreeName);

            long ctCount = callTreeQueue.Count;
            if (senderAvailable && ctCount < Config.CallTreeQueueSize)
            {
                
                IReliableDictionary<string, bool> callTreeDictionary = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.CallTreeDictionary);

                string callSitesMsg = msgContent[HttpUtil.NewCallSites];
                string splitNodesMsg = msgContent[HttpUtil.SplitNodes];
                HashSet<string> callSites = Common.Utils.ParseCallSitesMsg(callSitesMsg);
                List<Tuple<string, int>> splitNodes = Common.Utils.ParseSplitNodesMsg(splitNodesMsg);
                var senderID = await GetSenderID(callTreeName);
                var newCallTree = new BoogieVerifyOptions.SplitState(senderID, callTreeName, callSites, splitNodes); 
                while (true)
                {
                    try
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            var exists = await callTreeDictionary.ContainsKeyAsync(tx, callTreeName);
                            if (!exists)
                            {
                                await callTreeQueue.EnqueueAsync(tx, newCallTree);
                                await callTreeDictionary.AddOrUpdateAsync(tx, callTreeName, true, (key, oldValue) => false); 

                                await tx.CommitAsync();
                                Log.WriteLine(string.Format("New CT: {0} | {1} CTs avail",
                                    callTreeName, 
                                    callTreeQueue.Count
                                    ));
                            }
                            else
                            {
                                // repeatedly receive a calltree 
                                Log.WriteLine(string.Format("Network error: receive calltree: {0}", callTreeName));
                                await tx.CommitAsync();
                            }
                        }
                        break;
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(Log.Error, e.ToString());
                    }
                    await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
                }

                if (ctCount <= 1)
                    Common.Utils.ResponseHttp(context, HttpUtil.FastSplit); 
                else
                    Common.Utils.ResponseHttp(context, HttpUtil.SlowSplit);
            }
            else
            {
                Log.WriteLine(string.Format("Not add new calltree: {0} because sender is not available || calltreeQueue reaches limits {1}", callTreeName, ctCount));
                Common.Utils.ResponseHttp(context, HttpUtil.NotAdded);
            } 
        }

        private async Task ReceiveCallSite(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            Debug.Assert(false);
            IReliableDictionary<string, BoogieVerifyOptions.SplitState> incomingCallTreeDic =
                await StateManager.GetOrAddAsync<IReliableDictionary<string, BoogieVerifyOptions.SplitState>>(Common.Utils.IncomingCallTrees);
            string callTreeName = msgContent[HttpUtil.NewCallTree];
            string callSiteMsg = msgContent[HttpUtil.NewCallSite];
            while (true)
            {
                try
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        var currentValue = await incomingCallTreeDic.TryGetValueAsync(tx, callTreeName);
                        if (currentValue.HasValue)
                        {
                            currentValue.Value.CallTree.Add(callSiteMsg);
                            await incomingCallTreeDic.TryUpdateAsync(tx, callTreeName, currentValue.Value, currentValue.Value);
                        }
                        else
                        {
                            var tmpHash = new HashSet<string>();
                            tmpHash.Add(callSiteMsg);
                            await incomingCallTreeDic.TryAddAsync(tx, callTreeName, new BoogieVerifyOptions.SplitState(callTreeName, tmpHash, new List<Tuple<string, int>>()));
                        }
                        await tx.CommitAsync();
                    }
                    break;

                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            Common.Utils.ResponseHttp(context);
        }

        private async Task AddSplitNodes(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            Debug.Assert(false);
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue =
                await StateManager.GetOrAddAsync<IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            IReliableDictionary<string, bool> callTreeDictionary = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.CallTreeDictionary);

            IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState> incomingCallTreeDic =
                await StateManager.GetOrAddAsync<IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.IncomingCallTrees);

            string callTreeName = msgContent[HttpUtil.NewCallTree];
            string splitNodesMsg = msgContent[HttpUtil.SplitNodes];
            List<Tuple<string, int>> splitNodes = Common.Utils.ParseSplitNodesMsg(splitNodesMsg);
            while (true)
            {
                try
                {
                    using (var tx = this.StateManager.CreateTransaction())
                    {
                        var currentValue = await incomingCallTreeDic.TryGetValueAsync(tx, callTreeName);
                        if (currentValue.HasValue)
                        {
                            currentValue.Value.SplitingNodes = splitNodes;
                            await callTreeQueue.EnqueueAsync(tx, currentValue.Value);
                            await callTreeDictionary.TryAddAsync(tx, callTreeName, true);
                            Log.WriteLine(string.Format("New calltree: {0}", callTreeName));
                        }
                        else
                        {
                            Log.WriteLine(string.Format("Skip calltree: {0}", callTreeName));
                        }
                        await tx.CommitAsync();                        
                    }
                    break;
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            Common.Utils.ResponseHttp(context);
        }

        /// <summary>
        /// This is the main entry point for your service replica.
        /// This method executes when this replica of your service becomes primary and has write status.
        /// </summary>
        /// <param name="cancellationToken">Canceled when Service Fabric needs to shut down this service replica.</param>
        protected override async Task RunAsync(CancellationToken cancellationToken)
        {
            var fabricClient = new FabricClient();
            System.Fabric.Query.ServicePartitionList partitionList = await fabricClient.QueryManager.GetPartitionListAsync(serviceUri);
            partitionInfo = new List<Int64RangePartitionInformation>();
            
            foreach (var client in partitionList)
            {
                partitionInfo.Add((Int64RangePartitionInformation)client.PartitionInformation);
            }

            List<string> clientNames = new List<string>();
            partitionList.ToList().ForEach(e => clientNames.Add(e.PartitionInformation.Id.ToString()));
            tg = new TimeGraph(clientNames);

            Config.CallTreeQueueSize = partitionList.Count * Config.CallTreeQueueRate;
             
            IReliableConcurrentQueue<string> inputQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<string>>(Common.Utils.InputQueue);
            IReliableConcurrentQueue<BoogieVerifyOptions.SplitState> callTreeQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);
            IReliableDictionary<string, string> taskMapper = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.TaskMapper);
            IReliableDictionary<string, string> supporterMap = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.Supporter);
            IReliableDictionary<string, BoogieVerifyOptions.SplitState> handledCallTrees = await StateManager.GetOrAddAsync<IReliableDictionary<string, BoogieVerifyOptions.SplitState>>(Common.Utils.HandledCallTrees); 

            await CleanVerification();
            csa = CloudStorageAccount.Parse(Common.Utils.BlobAddress);
            var blobClient = csa.CreateCloudBlobClient();
            blobContainer = blobClient.GetContainerReference(Common.Utils.BlobFolder);
            
            var rand = new Random();
            bool fileLoaded = false;
            verificationFinished = false; 
            var startTime = DateTime.Now;

            BoogieVerifyOptions.SplitState calltree = null;
            string callTreeSupporter = null;
            bool reserved = false;

            var ResetSelection = new Action(() =>
            {
                calltree = null;
                callTreeSupporter = null;
                reserved = false;
            });

            var prtCnt = 0;
            int timeout = 0; 
            int total = 0;
            int finished = 0; 

            Log.WriteLine(Log.Important, string.Format("Input files: {0}", inputQueue.Count));
            bool isTimedout = false; 

            // set  of tests that got running error or took > 500s
            List<string> errorTests = new List<string>();

            // prepare list inputs: collect all inputs from server
            if (Config.RunningExperiment)
            {
                if (inputQueue.Count == 0)
                {
                    var fileList = InitFileList();
                    foreach (var file in fileList)
                    { 
                        {
                            Debug.WriteLine(file);
                            using (var tx = this.StateManager.CreateTransaction())
                            {
                                await inputQueue.EnqueueAsync(tx, file);
                                await tx.CommitAsync();
                            }
                        }
                    }
                }
            }

            while (true)
            { 
                if (cancellationToken.IsCancellationRequested)
                {
                    if (Config.AutoRerunningExperiment)
                        errorTests.Add(workingFile); 
                    Log.WriteLine(string.Format("Server got restarts"));
                }

                if (inputQueue.Count == 0 && errorTests.Count > 0 && Config.AutoRerunningExperiment)
                {
                    // reload the error tests into input queue
                    foreach (var file in errorTests)
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            await inputQueue.EnqueueAsync(tx, Common.Utils.GetInputFileName(file));
                            await tx.CommitAsync();
                        }
                    }
                    errorTests.Clear();
                } 

                if (fileLoaded && (TimedOut(startTime) || verificationFinished))
                {
                    await CleanVerification();
                    var stats = await SendStopMsgs(cancellationToken);
                    await CleanCallTreeQueue();
                    if (prtCnt % Config.DefaultInterval == 0 && !verificationFinished)
                        Log.WriteLine(Log.Warning, string.Format("Timeout"));
                    if (!verificationFinished)
                        isTimedout = true;
                }

                // if it doesnt split after some time
                if ((callTreeQueue.Count == 0 && fileLoaded) || verificationFinished)
                { 
                    var timeUsed = (DateTime.Now - startTime).TotalSeconds;
                    if (timeUsed > Config.FirstSplitDeadline || verificationFinished)
                    { 
                        bool completed = await CheckCompleteCompletion(prtCnt++, cancellationToken);
                        if (completed || verificationFinished)
                        { 
                            if (timeUsed > 500 && Config.AutoRerunningExperiment)
                                errorTests.Add(workingFile);
                            await CleanVerification();
                            var stats = await SendStopMsgs(cancellationToken);                           

                            if (completed)
                            {
                                var tmp = await SendFinishMsgs(cancellationToken);
                                if (tmp)
                                {
                                    fileLoaded = false;
                                    verificationFinished = false; 
                                    total++;
                                    if (timeUsed < Config.TimeLimit)
                                        finished++;
                                    else
                                        timeout++;

                                    Log.WriteLine(Log.Important, string.Format("Time used: {0} | {1}", timeUsed.ToString("F2"), workingFile));
                                    Log.WriteLine(Log.Important, string.Format("Stats {0}: {1}", workingFile, stats));
                                    Log.WriteLine(Log.Important, string.Format("Finished: {0} | Timeout: {1} | Total: {2}", finished, timeout, total));
                                    if (Config.EnableFileRemoval)
                                        DeleteFile(workingFile);
                                    isTimedout = false;
                                }
                            }
                            await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime * 50), cancellationToken);
                        }
                        else if (prtCnt % Config.DefaultInterval == 0 && !verificationFinished)
                        {
                            SendFastSplitMsgs(cancellationToken);
                        }
                    }
                }  

                if (!isTimedout)
                {
                    try
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            bool committed = false;
                            ResolvedServicePartition partition = null;
                            bool foundClient = false;
                            bool delivered = false;
                            Int64RangePartitionInformation backupClient = null;
                            Int64RangePartitionInformation backupClient02 = null;
                            string loadingTask = null;
                            // find an available partition
                            foreach (var client in partitionInfo)
                            {
                                var status = await clientState.TryGetValueAsync(tx, client.Id.ToString());
                                if (!status.HasValue || !status.Value.Item1)
                                {
                                    foundClient = true;
                                    if (!status.HasValue || status.Value.Item2 == null || status.HasValue && status.Value.Item2.Length == 0)
                                        backupClient = client;
                                    else if (status.HasValue && status.Value.Item2 != null && status.HasValue && status.Value.Item2.Length > 0)
                                    {
                                        backupClient02 = client;
                                        loadingTask = status.Value.Item2;
                                    }
                                    partition = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(client.LowKey), cancellationToken);
                                    string address = GetClientAddress(partition, cancellationToken);

                                    #region find an available callTree in queue
                                    if (calltree == null || reserved == false)
                                    {
                                        if (calltree != null)
                                        {
                                            var available = true;
                                            if (HttpUtil.ActiveServer)
                                                available = await PassiveCheckAvailability(calltree.Name, cancellationToken);
                                            else
                                                available = await ActiveCheckAvailability(calltree.Name);
                                            if (!available)
                                                ResetSelection();
                                            else
                                                reserved = true;
                                        }

                                        while (calltree == null && callTreeQueue.Count > 0)
                                        {
                                            var value = await callTreeQueue.TryDequeueAsync(tx);

                                            if (value.HasValue)
                                            {
                                                var available = true;
                                                if (HttpUtil.ActiveServer)
                                                    available = await PassiveCheckAvailability(value.Value.Name, cancellationToken);
                                                else
                                                    available = await ActiveCheckAvailability(value.Value.Name);
                                                if (available)
                                                {
                                                    calltree = value.Value.Clone();
                                                    reserved = true;
                                                    if (Config.OptimizationMode == 2)
                                                    {
                                                        // find calltree supporter
                                                        string parentTask = Common.Utils.GetParentTask(calltree.Name);
                                                        bool supporterAvail = await supporterMap.ContainsKeyAsync(tx, parentTask);
                                                        if (supporterAvail)
                                                        {
                                                            var supporterID = await supporterMap.TryGetValueAsync(tx, parentTask);
                                                            if (supporterID.HasValue)
                                                                callTreeSupporter = supporterID.Value;
                                                        }
                                                        else
                                                            callTreeSupporter = null;
                                                    }
                                                } 
                                            }
                                            if (Config.ShortTransaction)
                                                break;
                                        }
                                    }
                                    #endregion

                                    if (calltree != null)
                                    {
                                        #region send the calltree to selected client
                                        if (Config.OptimizationMode == 2)
                                        {
                                            if (callTreeSupporter != null && callTreeSupporter.Length > 0)
                                            {
                                                if (!callTreeSupporter.Equals(partition.Info.Id.ToString()))
                                                    continue;
                                            }
                                            else
                                            {
                                                if (status.HasValue && status.Value.Item2 != null && status.Value.Item2.Length > 0)
                                                    continue;
                                            }
                                        }
                                        if (callTreeSupporter == null)
                                            callTreeSupporter = "";
                                        delivered = true;
                                        await handledCallTrees.TryAddAsync(tx, calltree.Name, calltree);
                                        // send the callTree to the partition
                                        if (Config.OptimizationMode == 2)
                                            Log.WriteLine(Log.Info, string.Format("{0}-({1}) runs {2} | {3} CTs left", 
                                                        Common.Utils.ShortenStr(partition.Info.Id.ToString()),
                                                        callTreeSupporter,
                                                        calltree.Name,
                                                        callTreeQueue.Count));
                                        else
                                            Log.WriteLine(Log.Info, string.Format("random-{0} run {1} | {2} CTs left", 
                                                        Common.Utils.ShortenStr(partition.Info.Id.ToString()), calltree.Name,
                                                        callTreeQueue.Count));

                                        if (Config.OptimizationMode == 2)
                                        {
                                            string parentTask = Common.Utils.GetParentTask(calltree.Name);
                                            if (parentTask != null)
                                                await supporterMap.AddOrUpdateAsync(tx, parentTask, "", (key, oldValue) => "");
                                        }
                                        await clientState.AddOrUpdateAsync(tx, partition.Info.Id.ToString(), new Tuple<bool, string>(true, calltree.Name), (key, oldValue) => new Tuple<bool, string>(true, calltree.Name));
                                        await taskMapper.AddOrUpdateAsync(tx, calltree.Name, partition.Info.Id.ToString(), (key, oldValue) => partition.Info.Id.ToString());
                                        tg.AddEdge(calltree.Author, partition.Info.Id.ToString(), calltree.Name);
                                        await tx.CommitAsync();
                                        committed = true;
                                        await SendCallTree(this.httpClient, address, calltree);
                                        ResetSelection();
                                        #endregion
                                    }
                                    else if (callTreeQueue.Count == 0 && fileLoaded)
                                    {

                                        #region preload a calltree
                                        // optimization 2: supportion mode
                                        if (Config.OptimizationMode == 2 && status.HasValue && status.Value.Item2.Length > 0)
                                            continue;

                                        // preloading mode  
                                        bool clientLoaded = false;

                                        if (Config.OptimizationMode == 1)
                                        {
                                            // get common work
                                            List<string> workList = new List<string>();
                                            Tuple<bool, string> partitionStatus = new Tuple<bool, string>(false, "");
                                            foreach (var p in partitionInfo)
                                            {
                                                var statusTmp = await clientState.TryGetValueAsync(tx, p.Id.ToString());
                                                if (statusTmp.HasValue)
                                                {
                                                    if (statusTmp.Value.Item1)
                                                        workList.Add(statusTmp.Value.Item2);
                                                    else if (p.Id.ToString().Equals(partition.Info.Id.ToString()))
                                                        partitionStatus = statusTmp.Value;
                                                }
                                            }

                                            string commonWork = GetCommonWork(workList); 
                                            while (commonWork.Length > 0 && !(commonWork + SocketUtil.MsgSuffix).Equals(partitionStatus.Item2))
                                            {
                                                var taskAvail = await handledCallTrees.ContainsKeyAsync(tx, commonWork + SocketUtil.MsgSuffix);
                                                if (taskAvail)
                                                {
                                                    var callTree = await handledCallTrees.TryGetValueAsync(tx, commonWork + SocketUtil.MsgSuffix);
                                                    if (callTree.HasValue)
                                                    {
                                                        partitionStatus = new Tuple<bool, string>(false, callTree.Value.Name);
                                                        await clientState.AddOrUpdateAsync(tx, partition.Info.Id.ToString(), partitionStatus, (key, oldValue) => partitionStatus);
                                                        clientLoaded = true;
                                                        SendLoadCallTree(httpClient, address, callTree.Value);
                                                    }
                                                    break;
                                                }
                                                else
                                                {
                                                    if (commonWork.Contains("_"))
                                                    {
                                                        commonWork = commonWork.Substring(0, commonWork.LastIndexOf("_"));
                                                    }
                                                    else
                                                        commonWork = "";
                                                    //Log.WriteLine(string.Format("{0} finding loading work {1}", Common.Utils.ShortenStr(partition.Info.Id.ToString()), commonWork + SocketUtil.MsgSuffix));
                                                }
                                            }

                                            if (!clientLoaded && commonWork.Length > 0)
                                                continue;
                                        }
                                        else if (Config.OptimizationMode == 2)
                                        {
                                            // supportion mode
                                            // get first work that has not been supported
                                            Tuple<bool, string> partitionStatus = new Tuple<bool, string>(false, "");
                                            string workID = "";
                                            foreach (var p in partitionInfo)
                                            {
                                                var statusTmp = await clientState.TryGetValueAsync(tx, p.Id.ToString());
                                                if (statusTmp.HasValue)
                                                {
                                                    if (statusTmp.Value.Item1)
                                                    {
                                                        bool hasSupported = await supporterMap.ContainsKeyAsync(tx, statusTmp.Value.Item2);
                                                        if (!hasSupported)
                                                        {
                                                            workID = statusTmp.Value.Item2;
                                                            break;
                                                        }
                                                        else
                                                        {
                                                            var supporter = await supporterMap.TryGetValueAsync(tx, statusTmp.Value.Item2);
                                                            if (supporter.HasValue && supporter.Value.Length == 0)
                                                            {
                                                                workID = statusTmp.Value.Item2;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                            // cancel if not task was found
                                            if (workID.Length == 0)
                                                continue;

                                            var taskAvail = await handledCallTrees.ContainsKeyAsync(tx, workID);
                                            if (taskAvail)
                                            {
                                                var callTree = await handledCallTrees.TryGetValueAsync(tx, workID);
                                                if (callTree.HasValue)
                                                {
                                                    partitionStatus = new Tuple<bool, string>(false, callTree.Value.Name);
                                                    await clientState.AddOrUpdateAsync(tx, partition.Info.Id.ToString(), partitionStatus, (key, oldValue) => partitionStatus);
                                                    await supporterMap.AddOrUpdateAsync(tx, workID, partition.Info.Id.ToString(), (key, oldValue) => partition.Info.Id.ToString());
                                                    tg.AddEdge(callTree.Value.Author, partition.Info.Id.ToString(), "Load " + callTree.Value.Name);
                                                    clientLoaded = true;
                                                    Log.WriteLine(Log.Info, string.Format("{1} loads calltree {0}", callTree.Value.Name, Common.Utils.ShortenStr(partition.Info.Id.ToString())));
                                                    SendLoadCallTree(httpClient, address, callTree.Value);
                                                }
                                                break;
                                            }
                                        }
                                        #endregion
                                    }
                                    else if (callTreeQueue.Count == 0 && !fileLoaded && inputQueue.Count > 0)
                                    {
                                        #region load a new input file
                                        
                                        var input = await inputQueue.TryDequeueAsync(tx, cancellationToken);
                                        
                                        if (input.HasValue)
                                        {
                                            Log.WriteLine(Log.Important, string.Format("Solving {0} | Input remaining: {1}", input.Value, inputQueue.Count));

                                            workingFile = input.Value;
                                            // all client start simultaneously, except the choosen one
                                            foreach (var p in partitionInfo)
                                            {
                                                if (!p.Id.ToString().Equals(partition.Info.Id.ToString()))
                                                {
                                                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                                                    var tmpAddress = GetClientAddress(tmp, cancellationToken);
                                                    await SendRequest(httpClient, tmpAddress, HttpUtil.LoadFile, input.Value);
                                                }
                                            }
                                            var state = new Tuple<bool, string>(true, "");
                                            await SendRequest(this.httpClient, address, HttpUtil.LoadFile, input.Value);
                                            await clientState.AddOrUpdateAsync(tx, partition.Info.Id.ToString(), state, (key, oldValue) => state);
                                            await taskMapper.AddOrUpdateAsync(tx, "", partition.Info.Id.ToString(), (key, oldValue) => partition.Info.Id.ToString());
                                            await tx.CommitAsync();
                                            committed = true;
                                            tg = new TimeGraph(clientNames);
                                            await SendRequest(this.httpClient, address, HttpUtil.StartVerification, workingFile);
                                            fileLoaded = true;
                                            verificationFinished = false;
                                            startTime = DateTime.Now;
                                        } 
                                        #endregion
                                    }
                                    break;
                                }
                            }

                            if (Config.OptimizationMode == 2 && foundClient && !delivered && calltree != null && backupClient != null)
                            {
                                partition = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(backupClient.LowKey), cancellationToken);
                                string address = GetClientAddress(partition, cancellationToken);
                                // give the task to backup client
                                await handledCallTrees.TryAddAsync(tx, calltree.Name, calltree);
                                // send the callTree to the partition
                                Log.WriteLine(Log.Info, string.Format(">>> server {0} cannot find the supporter --> random-{1} to run the calltree: {2} | {3} calltrees left",
                                                        Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString()),
                                                        Common.Utils.ShortenStr(partition.Info.Id.ToString()), calltree.Name,
                                                        callTreeQueue.Count));

                                await clientState.AddOrUpdateAsync(tx, partition.Info.Id.ToString(), new Tuple<bool, string>(true, calltree.Name), (key, oldValue) => new Tuple<bool, string>(true, calltree.Name));
                                await taskMapper.AddOrUpdateAsync(tx, calltree.Name, partition.Info.Id.ToString(), (key, oldValue) => partition.Info.Id.ToString());
                                await tx.CommitAsync();
                                committed = true;
                                await SendCallTree(this.httpClient, address, calltree);
                                ResetSelection();
                            }
                            else if (Config.OptimizationMode == 2 && foundClient && !delivered && calltree != null && backupClient02 != null)
                            {
                                Debug.Assert(loadingTask != null);
                                partition = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(backupClient02.LowKey), cancellationToken);
                                await supporterMap.AddOrUpdateAsync(tx, loadingTask, "", (key, oldValue) => "");
                                string address = GetClientAddress(partition, cancellationToken);
                                SendRequest(this.httpClient, address, HttpUtil.CancelLoadingCT);
                            }

                            if (!foundClient)
                            {
                                #region prepare an available callTree in queue
                                if (calltree != null)
                                {
                                    var available = true;
                                    if (HttpUtil.ActiveServer)
                                        available = await PassiveAskAvailability(calltree.Name, cancellationToken);
                                    if (!available)
                                        ResetSelection();
                                }

                                if (calltree == null && callTreeQueue.Count > 0)
                                {
                                    var value = await callTreeQueue.TryDequeueAsync(tx);
                                    if (value.HasValue)
                                    {
                                        var available = true;
                                        if (HttpUtil.ActiveServer)
                                            available = await PassiveAskAvailability(value.Value.Name, cancellationToken);
                                        if (available)
                                        {
                                            calltree = value.Value.Clone();
                                            if (Config.OptimizationMode == 2)
                                            {
                                                // find calltree supporter
                                                string parentTask = Common.Utils.GetParentTask(calltree.Name);
                                                bool supporterAvail = await supporterMap.ContainsKeyAsync(tx, parentTask);
                                                if (supporterAvail)
                                                {
                                                    var supporterID = await supporterMap.TryGetValueAsync(tx, parentTask);
                                                    if (supporterID.HasValue)
                                                        callTreeSupporter = supporterID.Value;
                                                }
                                            } 
                                        } 
                                    }
                                }
                                #endregion
                            }

                            // If an exception is thrown before calling CommitAsync, the transaction aborts, all changes are 
                            // discarded, and nothing is saved to the secondary replicas.
                            if (!committed)
                            {
                                await tx.CommitAsync();
                            }
                        }
                        await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime), cancellationToken);
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(Log.Error, e.ToString());
                    }
                }
            }
        }

        private bool TimedOut(DateTime startTime)
        {
            return (DateTime.Now - startTime).TotalSeconds > Config.TimeLimit;
        }

        private List<string> InitFileList()
        {
            List<string> fileList = new List<string>();
            try
            {
                if (this.csa == null)
                {
                    csa = CloudStorageAccount.Parse(Common.Utils.BlobAddress);
                    var blobClient = csa.CreateCloudBlobClient();
                    blobContainer = blobClient.GetContainerReference(Common.Utils.BlobFolder);
                }

                blobContainer.CreateIfNotExists();

                var list = blobContainer.ListBlobs(useFlatBlobListing: true);
                var listOfFileNames = new List<string>();

                foreach (var blob in list)
                {
                    CloudBlob blobFile = blobContainer.GetBlobReference(blob.Uri.AbsoluteUri);
                    fileList.Add(blob.Uri.AbsoluteUri);
                }
            }
            catch (Exception e)
            {
                Log.WriteLine(Log.Error, e.ToString());
            }
            return fileList;
        }

        private void WriteDotFile()
        {
            try
            {
                CloudStorageAccount csa = CloudStorageAccount.Parse(Common.Utils.BlobAddress);
                var tmpName = Path.GetFileName(workingFile.Substring(workingFile.LastIndexOf("\\") + 1)) + ".dot";
                var blobName = new FileInfo(tmpName).Name;

                var blobClient = csa.CreateCloudBlobClient();
                var container = blobClient.GetContainerReference(Common.Utils.DotFolder);
                container.CreateIfNotExists();
                var uploadName = blobName;
                CloudBlockBlob blockBlob = container.GetBlockBlobReference(uploadName);

                byte[] byteArray = Encoding.ASCII.GetBytes(tg.ToString());
                MemoryStream dataStream = new MemoryStream(byteArray);

                blockBlob.UploadFromStream(dataStream); 
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.ToString());
            }
        }

        private void DeleteFile(string fileName)
        {
            this.AssertBlobContainer();
            try
            {
                var blob = this.blobContainer.GetBlockBlobReference(Path.GetFileName(fileName));
                blob.DeleteIfExists();
            }
            catch (Exception e)
            {
                Log.WriteLine(string.Format("{0}", e.ToString()));
            }
        }

        private void AssertBlobContainer()
        {
            // only do once
            if (this.blobContainer == null)
            {
                var client = this.csa.CreateCloudBlobClient();

                this.blobContainer = client.GetContainerReference(Common.Utils.BlobFolder);

                if (!this.blobContainer.Exists())
                {
                    Log.WriteLine(Log.Error, string.Format("Container {0} does not exist in azure account", Common.Utils.BlobFolder));
                    throw new Exception(string.Format("Container {0} does not exist in azure account", Common.Utils.BlobFolder));
                }
            }

            if (this.blobContainer == null) throw new NullReferenceException("Blob Empty");
        }

        private string GetCommonWork(List<string> workList)
        {
            if (workList.Count == 0)
                return "";
            else {
                try
                {
                    // parse nodes
                    var sep01 = new char[1];
                    sep01[0] = '_';

                    if (workList[0].Length == 0)
                        return "";
                    var ret = workList[0].Substring(0, workList[0].Length - SocketUtil.MsgSuffix.Length).Split(sep01);
                    int pos = ret.Length;
                    foreach (var s in workList)
                    {
                        if (s.Length == 0)
                            return "";
                        var ss = s.Substring(0, s.Length - SocketUtil.MsgSuffix.Length);
                        var tokens = ss.Split(sep01);
                        int tmpPos = 0;
                        for (int i = 0; i < Math.Min(pos, tokens.Length); ++i)
                            if (ret[i].Equals(tokens[i]))
                                tmpPos++;
                            else
                                break;
                        pos = tmpPos;
                    }

                    string result = "";
                    for (int i = 0; i < pos; ++i)
                        result = result + ret[i] + "_";
                    if (result.Length > 0)
                        return result.Substring(0, result.Length - 1);
                    else
                        return "";
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
            }
            return "";
        }

        private async Task SendCallTree(HttpClient httpClient, string address, cba.Util.BoogieVerifyOptions.SplitState state)
        {
            string callSitesMsg = "";
            foreach (var ct in state.CallTree)
            {
                callSitesMsg = callSitesMsg + ct + ";";
            }
            callSitesMsg = callSitesMsg.Substring(0, callSitesMsg.Length - 1);

            string splitNodesMsg = "";
            foreach (var node in state.SplitingNodes)
            {
                splitNodesMsg = splitNodesMsg + node.Item1 + ";" + node.Item2 + ";";
            }
            splitNodesMsg = splitNodesMsg.Substring(0, splitNodesMsg.Length - 1); 
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            JsonContent tmp = new JsonContent(string.Format("{0}={1}&{2}={3}&{4}={5}&{6}={7}", 
                                            HttpUtil.NewCallTree, state.Name, 
                                            HttpUtil.NewCallSites, callSitesMsg, 
                                            HttpUtil.SplitNodes, splitNodesMsg,
                                            HttpUtil.InputFile, workingFile));
            await httpClient.PostAsync(address, tmp);
        }

        private async Task SendLoadCallTree(HttpClient httpClient, string address, cba.Util.BoogieVerifyOptions.SplitState state)
        {
            string callSitesMsg = "";
            foreach (var ct in state.CallTree)
            {
                callSitesMsg = callSitesMsg + ct + ";";
            }
            callSitesMsg = callSitesMsg.Substring(0, callSitesMsg.Length - 1);

            string splitNodesMsg = "";
            foreach (var node in state.SplitingNodes)
            {
                splitNodesMsg = splitNodesMsg + node.Item1 + ";" + node.Item2 + ";";
            }
            splitNodesMsg = splitNodesMsg.Substring(0, splitNodesMsg.Length - 1);

            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            JsonContent tmp = new JsonContent(string.Format("{0}={1}&{2}={3}&{4}={5}&{6}={7}&{8}={9}", 
                                                        HttpUtil.NewCallTree, state.Name, 
                                                        HttpUtil.NewCallSites, callSitesMsg, 
                                                        HttpUtil.SplitNodes, splitNodesMsg,
                                                        HttpUtil.LoadCallTree, HttpUtil.LoadCallTree,
                                                        HttpUtil.InputFile, workingFile));
            
            var rep = await httpClient.PostAsync(address, tmp); 
        } 

        private async Task<string> SendStopMsgs(CancellationToken cancellationToken)
        {
            string stats = "";
            Log.WriteLine(Log.Info, string.Format("Send stop requests"));
            int cnt = 0;
            while (cnt < partitionInfo.Count)
            {  
                var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(partitionInfo[cnt].LowKey), cancellationToken);
                var address = GetClientAddress(tmp, cancellationToken);
                var tmpStats = await SendRequest(httpClient, address, HttpUtil.StopVerification, workingFile);
                stats = stats + partitionInfo[cnt].LowKey.ToString() + ": " + tmpStats + Environment.NewLine;
                cnt++;
            }
            return stats;
        }

        private async Task CleanVerification()
        {
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);
            IReliableDictionary<string, bool> callTreeDictionary = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.CallTreeDictionary); 
            IReliableDictionary<string, string> taskMapper = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.TaskMapper);
            IReliableDictionary<string, string> supporter = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.Supporter);
            IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState> handledCallTrees = await StateManager.GetOrAddAsync<IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.HandledCallTrees);
            IReliableDictionary<string, bool> activeCallTree = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.ActiveCT); 

            await callTreeDictionary.ClearAsync(); 
            await taskMapper.ClearAsync();
            await handledCallTrees.ClearAsync();
            await supporter.ClearAsync();
            await clientState.ClearAsync();
            await activeCallTree.ClearAsync();
            await CleanCallTreeQueue();
        }
         
        private async Task CleanCallTreeQueue()
        {
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            while (true)
            {
                try
                {
                    while (callTreeQueue.Count > 0)
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            await callTreeQueue.TryDequeueAsync(tx);
                            await tx.CommitAsync();
                        }
                    }
                    break;
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            } 
        }

        private async Task<bool> CheckCompletion()
        {
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);

            if (callTreeQueue.Count > 0)
            { 
                return false;
            }
            else 

            foreach (var client in partitionInfo)
            {
                var id = client.Id.ToString();
                while (true)
                {
                    try
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            var status = await clientState.TryGetValueAsync(tx, id);
                            if (status.HasValue)
                            {
                                if (status.Value.Item1)
                                {
                                    await tx.CommitAsync(); 
                                    return false;
                                } 
                            }
                            await tx.CommitAsync();
                        }
                        break;
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(Log.Error, e.ToString());
                    }
                    await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
                }
            }
            return true;
        }

        private async Task<bool> CheckCompleteCompletion(int prtCnt, CancellationToken cancellationToken)
        {
            IReliableConcurrentQueue<cba.Util.BoogieVerifyOptions.SplitState> callTreeQueue = await StateManager.GetOrAddAsync<IReliableConcurrentQueue<BoogieVerifyOptions.SplitState>>(Common.Utils.CallTreeQueue);
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);
            IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState> handledCallTrees = await StateManager.GetOrAddAsync<IReliableDictionary<string, cba.Util.BoogieVerifyOptions.SplitState>>(Common.Utils.HandledCallTrees);
            IReliableDictionary<string, string> taskMapper = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.TaskMapper);
            IReliableDictionary<string, bool> activeCallTree = await StateManager.GetOrAddAsync<IReliableDictionary<string, bool>>(Common.Utils.ActiveCT);

            string allCTs = "";
            
            List<Tuple<string, string>> workingClients = new List<Tuple<string, string>>();
            List<Tuple<string, string>> loadingClients = new List<Tuple<string, string>>();
            foreach (var client in partitionInfo)
            {
                var id = client.Id.ToString();
                while (true)
                {
                    try
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            var status = await clientState.TryGetValueAsync(tx, id);
                            if (status.HasValue)
                            { 
                                if (status.Value.Item1 || status.Value.Item2.Length > 0)
                                {
                                    if (status.Value.Item1)
                                        workingClients.Add(new Tuple<string, string>(id, status.Value.Item2));
                                    else
                                        loadingClients.Add(new Tuple<string, string>(id, status.Value.Item2));
                                    if (prtCnt % Config.DefaultInterval == 0)
                                    {
                                        // getting calltree
                                        if (status.Value.Item1)
                                        {
                                            allCTs = allCTs + "running-" + status.Value.Item2 + " | ";
                                        }
                                        else
                                        {
                                            allCTs = allCTs + "loading-" + status.Value.Item2 + " | ";
                                        }
                                    }
                                } 
                            }
                            await tx.CommitAsync();
                        }
                        break;
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(Log.Error, e.ToString());
                    }
                    await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
                }
            } 
            if (workingClients.Count == 0)
            {
                // resend stop msg
                if (prtCnt % Config.DefaultInterval == 0)
                {
                    await CleanVerification();
                    await SendStopMsgs(cancellationToken);
                }
            }
            else
            {
                List<string> mustCancel = new List<string>();
                foreach(var client in loadingClients)
                {
                    bool found = workingClients.Any(work => work.Item2.Equals(client.Item2));
                    if (!found)
                        mustCancel.Add(client.Item1);
                }

                foreach (var client in mustCancel)
                {
                    //Log.WriteLine(string.Format("{0} is cancelled", client));
                    string address = await GetClientAddress(client, cancellationToken); 
                    await SendRequest(httpClient, address, HttpUtil.CancelLoadingCT);
                }

                if (mustCancel.Count == 0)
                {
                    if (callTreeQueue.Count > partitionInfo.Count && 
                        loadingClients.Count + workingClients.Count == partitionInfo.Count &&
                        loadingClients.Count > 0)
                    {
                        Log.WriteLine(string.Format("{0} is cancelled to do another work", loadingClients[0].Item1));
                        string address = await GetClientAddress(loadingClients[0].Item1, cancellationToken);
                        await SendRequest(httpClient, address, HttpUtil.CancelLoadingCT);
                    }
                }

                if (Config.BackupClient)
                {
                    // one client works too long, other clients are free
                    if ((loadingClients.Count + workingClients.Count <= partitionInfo.Count / 2 &&
                        loadingClients.Count == workingClients.Count && mustCancel.Count == 0 &&
                        prtCnt % Config.DefaultInterval == 0) || 
                        (workingClients.Count == 1 && loadingClients.Count == 0 && partitionInfo.Count > 1 && prtCnt % Config.DefaultInterval == 0))
                    {
                        List<BoogieVerifyOptions.SplitState> errCT = new List<BoogieVerifyOptions.SplitState>();
                        foreach (var client in workingClients)
                        {
                            using (var tx = this.StateManager.CreateTransaction())
                            {
                                var contains = await handledCallTrees.ContainsKeyAsync(tx, client.Item2);
                                
                                if (contains)
                                {
                                    var ct = await handledCallTrees.TryGetValueAsync(tx, client.Item2);
                                    if (ct.HasValue)
                                    {
                                        var active = await activeCallTree.ContainsKeyAsync(tx, ct.Value.Name);
                                        if (!active)
                                        { 
                                            errCT.Add(ct.Value); 
                                        }
                                    } 
                                } 
                                await tx.CommitAsync();
                            }
                        }

                        List<string> busyClients = new List<string>();
                        foreach (var client in workingClients)
                            busyClients.Add(client.Item1);
                        foreach (var client in loadingClients)
                            busyClients.Add(client.Item1);
                        foreach (var ct in errCT)
                        {
                            foreach (var client in partitionInfo)
                            {
                                if (!busyClients.Contains(client.Id.ToString()))
                                {
                                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(client.LowKey), cancellationToken);
                                    var address = GetClientAddress(tmp, cancellationToken);
                                    await SendCallTree(httpClient, address, ct);
                                    Log.WriteLine(Log.Important, string.Format("Extra support on {0}", ct.Name));

                                    using (var tx = this.StateManager.CreateTransaction())
                                    {
                                        await clientState.AddOrUpdateAsync(tx, client.Id.ToString(), new Tuple<bool, string>(true, ct.Name), (key, oldValue) => new Tuple<bool, string>(true, ct.Name));
                                        await taskMapper.AddOrUpdateAsync(tx, ct.Name, client.Id.ToString(), (key, oldValue) => client.Id.ToString());
                                        await tx.CommitAsync();
                                    }
                                    busyClients.Add(client.Id.ToString());
                                    break;
                                }
                            }
                        }
                    }
                }
            }

            if (callTreeQueue.Count > 0)
            {
                return false;
            }
            else
            {
                if (loadingClients.Count == 0 && workingClients.Count == 0)
                    return true;
                else
                {
                    if (prtCnt % Config.DefaultInterval == 0)
                        Log.WriteLine(string.Format("Not finished: {0}", allCTs));
                    return false;
                }
            }
        }

        private async Task ContinuousReminder(int prtCnt)
        {
            IReliableDictionary<string, Tuple<bool, string>> clientState = await StateManager.GetOrAddAsync<IReliableDictionary<string, Tuple<bool, string>>>(Common.Utils.ClientStates);
            IReliableDictionary<string, BoogieVerifyOptions.SplitState> handledCallTrees = await StateManager.GetOrAddAsync<IReliableDictionary<string, BoogieVerifyOptions.SplitState>>(Common.Utils.HandledCallTrees);

            foreach (var client in partitionInfo)
            {
                var id = client.Id.ToString();
                while (true)
                {
                    try
                    {
                        using (var tx = this.StateManager.CreateTransaction())
                        {
                            var status = await clientState.TryGetValueAsync(tx, id);
                            if (status.HasValue)
                            {
                                if (status.Value.Item1 || status.Value.Item2.Length > 0)
                                { 
                                    if (prtCnt % Config.DefaultInterval == 0)
                                    {
                                        // getting calltree
                                        var contains = await handledCallTrees.ContainsKeyAsync(tx, status.Value.Item2);
                                        BoogieVerifyOptions.SplitState calltree = null;
                                        if (contains)
                                        {
                                            var ct = await handledCallTrees.TryGetValueAsync(tx, status.Value.Item2);
                                            if (ct.HasValue)
                                            {
                                                calltree = ct.Value.Clone();
                                            }

                                            if (status.Value.Item1)
                                            { 
                                                if (calltree != null)
                                                {
                                                    if (calltree.Name.Length > 0)
                                                        await SendCallTree(httpClient, id, calltree); 
                                                }
                                                else if (status.Value.Item2.Length == 0)
                                                    await SendRequest(this.httpClient, id, HttpUtil.StartVerification, workingFile);
                                            }
                                            else
                                            { 
                                                if (calltree != null)
                                                {
                                                    if (calltree.Name.Length > 0)
                                                        await SendLoadCallTree(httpClient, id, calltree);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            await tx.CommitAsync();
                        }
                        break;
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(Log.Error, e.ToString());
                    }
                    await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
                }
            }
        }

        private async Task<string> GetSenderID(string callTreeName)
        {
            IReliableDictionary<string, string> taskMapper = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.TaskMapper);
            string ret = "";
            string sender = Common.Utils.GetParentTask(callTreeName); 
            while (true)
            {
                try
                {
                    using (var ts = this.StateManager.CreateTransaction())
                    {
                        var tmp = await taskMapper.ContainsKeyAsync(ts, sender);
                        if (tmp)
                        {
                            var tmpRet = await taskMapper.TryGetValueAsync(ts, sender);
                            if (tmpRet.HasValue)
                                ret = tmpRet.Value;
                        }
                        await ts.CommitAsync();
                    }
                    break;
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            return ret;
        }

        private async Task<string> GetWorkerID(string callTreeName)
        {
            IReliableDictionary<string, string> taskMapper = await StateManager.GetOrAddAsync<IReliableDictionary<string, string>>(Common.Utils.TaskMapper);
            string ret = ""; 
            while (true)
            {
                try
                {
                    using (var ts = this.StateManager.CreateTransaction())
                    {
                        var tmp = await taskMapper.ContainsKeyAsync(ts, callTreeName);
                        if (tmp)
                        {
                            var tmpRet = await taskMapper.TryGetValueAsync(ts, callTreeName);
                            if (tmpRet.HasValue)
                                ret = tmpRet.Value;
                        }
                        await ts.CommitAsync();
                    }
                    break;
                }
                catch (Exception e)
                {
                    Log.WriteLine(Log.Error, e.ToString());
                }
                await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime));
            }
            return ret;
        }

        private async Task SendFastSplitMsgs(CancellationToken cancellationToken)
        {
            Log.WriteLine(Log.Info, string.Format("Send FastSplit"));
            foreach (var p in partitionInfo)
            {
                var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                var address = GetClientAddress(tmp, cancellationToken);
                await SendRequest(httpClient, address, HttpUtil.FastSplit);
            }
        }

        private async Task<bool> SendFinishMsgs(CancellationToken cancellationToken)
        { 
            foreach (var p in partitionInfo)
            {
                var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(p.LowKey), cancellationToken);
                var address = GetClientAddress(tmp, cancellationToken);
                var rep = await SendRequest(httpClient, address, HttpUtil.FinishVerification, workingFile);
                if (rep.Equals(HttpUtil.No))
                    return false;
            }
            return true;
        }

        private async Task<string> GetClientAddress(string clientID, CancellationToken cancellationToken)
        {
            for (int i = 0; i < partitionInfo.Count; ++i)
            {
                if (partitionInfo[i].Id.ToString().Equals(clientID))
                {
                    var tmp = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(partitionInfo[i].LowKey), cancellationToken);
                    var address = GetClientAddress(tmp, cancellationToken);
                    return address;
                }
            }
            return null;
        }

        private string GetClientAddress(ResolvedServicePartition partition, CancellationToken cancellationToken)
        {
            ResolvedServiceEndpoint endPoint = partition.GetEndpoint();
            string strEndpointAddress = endPoint.Address;
            JObject addresses = JObject.Parse(strEndpointAddress);
            return (string)addresses["Endpoints"].First();
        }

        private async Task<string> SendRequest(HttpClient httpClient, string address, string param)
        {
            var rep = await SendRequest(httpClient, address, param, param);
            return rep;
        }

        private async Task<string> SendRequest(HttpClient httpClient, string address, string param, string msg)
        {
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            primaryReplicaUriBuilder.Query = string.Format("{0}={1}", param, msg);
            if (!param.Equals(HttpUtil.StartVerification) && 
                !param.Equals(HttpUtil.StopVerification) &&
                !param.Equals(HttpUtil.CancelLoadingCT) &&
                !param.Equals(HttpUtil.FastSplit) &&
                !param.Equals(HttpUtil.FinishVerification) &&
                !param.Equals(HttpUtil.InputFile) &&
                !param.Equals(HttpUtil.LoadFile))
                Log.WriteLine(Log.Info, string.Format("Send request {0}:{1} to {2}", param, msg, address));

            var rep = await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
            return rep;
        }
    }
}
