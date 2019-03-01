using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Fabric;
using System.Fabric.Description;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using cba;
using cba.Util;
using Common;
using Microsoft.ServiceFabric.Data.Collections;
using Microsoft.ServiceFabric.Services.Client;
using Microsoft.ServiceFabric.Services.Communication.Runtime;
using Microsoft.ServiceFabric.Services.Runtime;
using Newtonsoft.Json.Linq;
using Sandboxable.Microsoft.WindowsAzure.Storage;
using Sandboxable.Microsoft.WindowsAzure.Storage.Blob;

namespace ClientStateful
{
    /// <summary>
    /// An instance of this class is created for each service replica by the Service Fabric runtime.
    /// </summary>
    internal sealed class ClientStateful : StatefulService
    {
        private static readonly Uri serviceUri = new Uri(Common.Utils.ServerService);
        private readonly ServicePartitionResolver servicePartitionResolver = ServicePartitionResolver.GetDefault();
        private readonly HttpClient httpClient = new HttpClient();
        private List<string> calltreeList = new List<string>();
        private string address = null;
        private string inputFile = null;
        private BoogieVerifyOptions.SplitState callTree = null; 
        public ClientStateful(StatefulServiceContext context)
            : base(context)
        { }

        /// <summary>
        /// Optional override to create listeners (e.g., HTTP, Service Remoting, WCF, etc.) for this service replica to handle client or user requests.
        /// </summary>
        /// <remarks>
        /// For more information on service communication, see https://aka.ms/servicefabricservicecommunication
        /// </remarks>
        /// <returns>A collection of listeners.</returns>
        protected override IEnumerable<ServiceReplicaListener> CreateServiceReplicaListeners()
        {
            return new[] { new ServiceReplicaListener(context => new HttpCommunicationListener(Common.Utils.ClientServiceEndpoint, context, ReceivingController)) };
            //return new[] { new ServiceReplicaListener(context => this.CreateInternalListener(context)) };
        }

        private async Task ReceivingController(HttpListenerContext context, CancellationToken cancellationToken)
        {
            Dictionary<string, string> msgContent = null;

            // parse input msg
            List<string> allKeys = context.Request.QueryString.AllKeys.ToList();
            if (allKeys.Count == 0)
            {
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

            // handle the msg
            if (msgContent.ContainsKey(HttpUtil.StartVerification))
                StartVerification(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.LoadFile) && !msgContent.ContainsKey(HttpUtil.SplitNodes))
                LoadProgram(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.NewCallSites) && msgContent.ContainsKey(HttpUtil.SplitNodes) && !msgContent.ContainsKey(HttpUtil.LoadCallTree))
                ReceiveCallTree(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.NewCallSites) && msgContent.ContainsKey(HttpUtil.SplitNodes) && msgContent.ContainsKey(HttpUtil.LoadCallTree))
                ReceiveLoadCallTree(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.NewCallSite))
                await ReceiveCallSite(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.SplitNodes))
                await ReceiveSplitNodes(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.StopVerification))
                ReceiveStopVerification(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.CancelLoadingCT))
                ReceiveCancelLoadingCT(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.FinishVerification))
                ReceiveFinishVerification(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.FastSplit))
                ReceiveFastSplit(context, msgContent);

            else if (msgContent.ContainsKey(HttpUtil.Avail))
                CheckAvailability(context, msgContent, true);

            else if (msgContent.ContainsKey(HttpUtil.AskAvail))
                CheckAvailability(context, msgContent, false); 
        }

        private void StartVerification(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            
            Log.WriteLine(string.Format("{0}-client starts", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString())));

            callTree = new BoogieVerifyOptions.SplitState();
            Common.Utils.ResponseHttp(context);
        }

        private void LoadProgram(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            inputFile = msgContent[HttpUtil.LoadFile];
            inputFile = GetDir(inputFile); 
            string[] args = { inputFile, "/useProverEvaluate", "/di", "/doNotUseLabels", Config.InliningAlgorithm, "/recursionBound:" + Common.Config.RecursionBound.ToString(), "/si", Config.ConnectionType, "/httpAddress:" + address };
            try
            {
                cba.Driver.run(args);
            }
            catch (Exception e)
            {
                Log.WriteLine(string.Format("Exception {0}", e.ToString()));
            }
            Log.WriteLine(string.Format("{0}-client loaded {1}", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString()), inputFile));
            BoogieVerify.DistributedConfig.ContinueSearch = true;
            Common.Utils.ResponseHttp(context);
        }

        private string GetDir(string blobName)
        {
            try
            { 
                CloudStorageAccount csa = CloudStorageAccount.Parse(Common.Utils.BlobAddress);

                var blobClient = csa.CreateCloudBlobClient();
                var container = blobClient.GetContainerReference(Common.Utils.BlobFolder);
                CloudBlob blobFile = container.GetBlobReference(Path.GetFileName(blobName));
                int cnt = 0;
                using (var stream = blobFile.OpenRead())
                {
                    using (StreamReader reader = new StreamReader(stream))
                    {
                        while (!reader.EndOfStream && cnt++ < 0)
                        {
                            Log.WriteLine(reader.ReadLine());
                        }
                    }
                }
                return blobFile.Uri.AbsoluteUri.ToString(); 
            }
            catch (Exception e)
            {
                Log.WriteLine(e.ToString());
            }
            return "";
        }

        private void ReceiveCallTree(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string callTreeName = msgContent[HttpUtil.NewCallTree];
            string callSitesMsg = msgContent[HttpUtil.NewCallSites];
            string splitNodesMsg = msgContent[HttpUtil.SplitNodes];
            
            if (msgContent.ContainsKey(HttpUtil.InputFile))
            {
                var inputFileTmp = msgContent[HttpUtil.InputFile];
                if (!Common.Utils.GetInputFileName(inputFile).Equals(Common.Utils.GetInputFileName(inputFileTmp)))
                {
                    Common.Utils.ResponseHttp(context);
                    SendVerificationResult(httpClient, address, callTreeName, BoogieVerify.ReturnStatus.OK);
                    return;
                }
            } 

            if (BoogieVerify.options.prevSIState != null &&
                BoogieVerify.options.prevSIState.Name != null &&
                BoogieVerify.options.prevSIState.Name.Equals(callTreeName))
            {
                Common.Utils.ResponseHttp(context);
                return;
            }

            Log.WriteLine(string.Format(">>> {0}-client receives calltree to run {1}", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString()), callTreeName));
            Common.Utils.ResponseHttp(context);

            HashSet<string> callSites = Common.Utils.ParseCallSitesMsg(callSitesMsg);
            List<Tuple<string, int>> splitNodes = Common.Utils.ParseSplitNodesMsg(splitNodesMsg);            
            if (callTree == null)
                callTree = new BoogieVerifyOptions.SplitState(callTreeName, callSites, splitNodes);
            else
            {
                BoogieVerify.options.prevSIState = new BoogieVerifyOptions.SplitState(callTreeName, callSites, splitNodes);
            }
            BoogieVerify.options.loadOnly = false;
        }

        private void ReceiveLoadCallTree(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            string callTreeName = msgContent[HttpUtil.NewCallTree];
            string callSitesMsg = msgContent[HttpUtil.NewCallSites];
            string splitNodesMsg = msgContent[HttpUtil.SplitNodes];
            if (msgContent.ContainsKey(HttpUtil.InputFile))
            {
                var inputFileTmp = msgContent[HttpUtil.InputFile];
                if (!Common.Utils.GetInputFileName(inputFile).Equals(Common.Utils.GetInputFileName(inputFileTmp)))
                {
                    Common.Utils.ResponseHttp(context);
                    SendVerificationResult(httpClient, address, callTreeName, BoogieVerify.ReturnStatus.OK);
                    return;
                }
            }

            if (BoogieVerify.options.prevSIState != null &&
                BoogieVerify.options.prevSIState.Name != null &&
                BoogieVerify.options.prevSIState.Name.Equals(callTreeName))
            {
                Common.Utils.ResponseHttp(context);
                return;
            }

            Log.WriteLine(string.Format(">>> {0}-client receives calltree to load {1}", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString()), callTreeName));
            Common.Utils.ResponseHttp(context);

            HashSet<string> callSites = Common.Utils.ParseCallSitesMsg(callSitesMsg);
            List<Tuple<string, int>> splitNodes = Common.Utils.ParseSplitNodesMsg(splitNodesMsg);
            BoogieVerify.options.loadOnly = true;
            if (callTree == null)
            {
                callTree = new BoogieVerifyOptions.SplitState(callTreeName, callSites, splitNodes);
            }
            else
                BoogieVerify.options.prevSIState = new BoogieVerifyOptions.SplitState(callTreeName, callSites, splitNodes);
        }

        private async Task ReceiveCallSite(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            return; 
        }

        private async Task ReceiveSplitNodes(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            return; 
        }

        /**
         * Close Z3 and print stats
         */
        private void ReceiveFinishVerification(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            Log.WriteLine(string.Format("{0} is closing Z3", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString())));
            if (Common.Utils.GetInputFileName(inputFile).Equals(Common.Utils.GetInputFileName(msgContent[HttpUtil.FinishVerification])))
                if (callTree == null)
                {
                    cba.Driver.Close();
                    Common.Utils.ResponseHttp(context, HttpUtil.Yes);
                    return;
                }
            Common.Utils.ResponseHttp(context, HttpUtil.No);
        }

        private void ReceiveFastSplit(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            BoogieVerify.DistributedConfig.SplitSpeed = 2;
            Common.Utils.ResponseHttp(context);
        }

        private void ReceiveStopVerification(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            Common.Utils.ResponseHttp(context, BoogieVerify.AccumulatedStats.ToStringStats());
            if (!Common.Utils.GetInputFileName(inputFile).Equals(Common.Utils.GetInputFileName(msgContent[HttpUtil.StopVerification])))
                return;

            Log.WriteLine(string.Format("{0} received the stop signal", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString())));
            BoogieVerify.DistributedConfig.ContinueSearch = false;
            BoogieVerify.options.loadOnly = false;

            KillZ3();
        }

        private void ReceiveCancelLoadingCT(HttpListenerContext context, Dictionary<string, string> msgContent)
        {
            Log.WriteLine(string.Format("{0} received the cancel signal", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString())));
            BoogieVerify.DistributedConfig.ContinueSearch = false;
            BoogieVerify.options.loadOnly = false; 
            Common.Utils.ResponseHttp(context);
        }

        /**
         * In the case of PassiveServer, server will ask if task is available.
         * If it is, client then removes and informs server the task is available 
         */
        private void CheckAvailability(HttpListenerContext context, Dictionary<string, string> msgContent, bool toRemove)
        {

            string taskID = "";
            if (toRemove)
                taskID = msgContent[HttpUtil.Avail];
            else
                taskID = msgContent[HttpUtil.AskAvail];
            bool ret = false;
            int pos = 0;
            lock (BoogieVerify.decisions)
            {
                while (pos < BoogieVerify.decisions.Count)
                {
                    var tmp = BoogieVerify.decisions[pos];
                    if (tmp.taskID.StartsWith(taskID))
                    {
                        if (!tmp.taskID.EndsWith("__rm"))
                        {
                            Debug.Assert(tmp.taskID.Equals(taskID));

                            // task is available
                            ret = true;
                            if (toRemove)
                                BoogieVerify.decisions[pos] = new BoogieVerify.Decision(tmp.decisionType, tmp.num, tmp.cs, tmp.taskID + "__rm");
                        }
                        break;
                    }
                    ++pos;
                }
            }

            if (ret)
            {
                Common.Utils.ResponseHttp(context, HttpUtil.Yes);
            }
            else
            {
                Common.Utils.ResponseHttp(context, HttpUtil.No);
            }

        } 

        /// <summary>
        /// This is the main entry point for your service replica.
        /// This method executes when this replica of your service becomes primary and has write status.
        /// </summary>
        /// <param name="cancellationToken">Canceled when Service Fabric needs to shut down this service replica.</param>
        protected override async Task RunAsync(CancellationToken cancellationToken)
        {
            //IReliableConcurrentQueue<string> inputQueue = await this.StateManager.GetOrAddAsync<IReliableConcurrentQueue<string>>(Common.Utils.ClientQueue);
            var rand = new Random();

            // prepare address 
            ServicePartitionKey partitionKey = new ServicePartitionKey(rand.Next(10));
            ResolvedServicePartition partition = await this.servicePartitionResolver.ResolveAsync(serviceUri, partitionKey, cancellationToken);
            ResolvedServiceEndpoint ep = partition.GetEndpoint();

            JObject addresses = JObject.Parse(ep.Address);

            address = (string)addresses["Endpoints"].First();
            while (true)
            {
                if (cancellationToken.IsCancellationRequested)
                {
                    SendRestartRequest(httpClient, address, callTree.Name);
                }

                if (callTree != null)
                {
                    try
                    {
                        if (callTree.Name.Length == 0)
                        {
                            BoogieVerify.ReturnStatus result = Driver.HttpController();
                            string callTreeName = callTree.Name;
                            BoogieVerify.options.prevSIState = null;
                            callTree = null;
                            await SendVerificationResult(httpClient, address, "", result);
                        }
                        else
                        {
                            BoogieVerify.ReturnStatus result = Driver.HttpController(callTree);
                            if (BoogieVerify.options.prevSIState != null)
                            {
                                var cloneCT = BoogieVerify.options.prevSIState.Clone();
                                string callTreeName = cloneCT.Name;
                                BoogieVerify.options.prevSIState = null;
                                callTree = null;
                                var rep = await SendVerificationResult(httpClient, address, callTreeName, result);
                                if (rep.Equals(HttpUtil.Redo))
                                {
                                    BoogieVerify.options.loadOnly = false;
                                    callTree = cloneCT.Clone();
                                    Log.WriteLine(string.Format(">>> {0}-client redo calltree {1}", Common.Utils.ShortenStr(this.Partition.PartitionInfo.Id.ToString()), callTreeName));
                                }
                            }
                        }
                    }
                    catch (Exception e)
                    {
                        Log.WriteLine(string.Format("{0}", e.ToString()));
                    }
                }
                else
                {
                    await Task.Delay(TimeSpan.FromMilliseconds(Common.Utils.DelayTime), cancellationToken);
                }
            }
        }



        private async Task InformServerNewCT(string calltree)
        {
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            primaryReplicaUriBuilder.Query = string.Format("{0}={1}", HttpUtil.NewCallTree, calltree);

            await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
        }

        private void InformServerRemoveCT(string calltree)
        {
            // dont need to do anything
        }

        public async Task<string> SendVerificationResult(HttpClient httpClient, string address, string input, BoogieVerify.ReturnStatus result)
        {
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            int ret = Common.Utils.EncodeResult(result);
            primaryReplicaUriBuilder.Query = string.Format("{0}={1}&{2}={3}&{4}={5}&{6}={7}",
                                                        HttpUtil.Sender, this.Partition.PartitionInfo.Id.ToString(),
                                                        HttpUtil.InputFile, inputFile,
                                                        HttpUtil.Server2ClientInput, input,
                                                        HttpUtil.VerificationOutcome, ret);

            var tmp = await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
            return tmp;
        }

        public void SendRestartRequest(HttpClient httpClient, string address, string callTreeName)
        {
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address); 
            primaryReplicaUriBuilder.Query = string.Format("{0}={1}&{2}={3}&{4}={5}&{6}={7}",
                                                        HttpUtil.Sender, this.Partition.PartitionInfo.Id.ToString(),
                                                        HttpUtil.InputFile, inputFile,
                                                        HttpUtil.Server2ClientInput, callTreeName,
                                                        HttpUtil.Restart, HttpUtil.Restart);

            httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
        }

        public void KillZ3()
        {
            try
            {
                foreach (var process in Process.GetProcessesByName("z3"))
                {
                    process.Kill();
                    break;
                }
            }
            catch (Exception e)
            {
                Log.WriteLine(string.Format("{0}", e.ToString()));
            }
        }
    }
}
