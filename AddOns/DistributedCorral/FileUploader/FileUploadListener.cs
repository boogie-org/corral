using System;
using System.Fabric; 
using System.Net; 
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ServiceFabric.Services.Communication.Runtime;
using Microsoft.WindowsAzure.Storage;
using System.IO;
using Microsoft.WindowsAzure.Storage.Blob;
using System.Collections.Generic;
using System.Linq;
using System.Diagnostics;
using Common;
using System.Net.Http;
using Microsoft.ServiceFabric.Services.Client;
using Newtonsoft.Json.Linq;

namespace FileUploader
{
    public class FileUploadListener : ICommunicationListener
    {
        private readonly string publishUri;
        private readonly HttpListener httpListener;
        private readonly CancellationTokenSource processRequestsCancellation = new CancellationTokenSource();
        private readonly ServicePartitionResolver servicePartitionResolver = ServicePartitionResolver.GetDefault();

        /// <summary>
        /// , Func<HttpListenerContext, CancellationToken, Task> processRequest
        /// </summary>
        /// <param name="uriPrefix"></param>
        /// <param name="uriPublished"></param>
        public FileUploadListener(string uriPrefix, string uriPublished)
        {
            this.publishUri = uriPublished;
            this.httpListener = new HttpListener();
            this.httpListener.Prefixes.Add(uriPrefix);
        }

        public void Abort()
        {
            this.processRequestsCancellation.Cancel();
            this.httpListener.Abort();
        }

        public Task CloseAsync(CancellationToken cancellationToken)
        {
            this.processRequestsCancellation.Cancel();
            this.httpListener.Close();
            return Task.FromResult(true);
        }

        public Task<string> OpenAsync(CancellationToken cancellationToken)
        {
            this.httpListener.Start();

            Task openTask = this.ProcessRequestsAsync(this.processRequestsCancellation.Token);

            return Task.FromResult(this.publishUri);
        }

        private async Task ProcessRequestsAsync(CancellationToken processRequests)
        {
            while(!processRequests.IsCancellationRequested)
            {
                HttpListenerContext request = await this.httpListener.GetContextAsync();

                Task requestTask = this.ProcessInputRequest(request, this.processRequestsCancellation.Token)
                    .ContinueWith(async t => await t, TaskContinuationOptions.OnlyOnFaulted);
            }
        }



        private async Task ProcessInputRequest(HttpListenerContext context, CancellationToken cancelRequest)
        {
            Log.WriteLine(string.Format(" ProcessInputRequest: file uploading"));
            String output = null;

            var dataStream = context.Request.InputStream;
            var fileNames = await MultipartParser.ParseFiles(dataStream, context.Request.ContentType, BlobProcessMethod);

            if (fileNames.Count > 0)
            {
                // get address
                ResolvedServicePartition partition = null;
                var fabricClient = new FabricClient();
                Uri serviceUri = new Uri(Utils.ServerService);
                var partitionList = await fabricClient.QueryManager.GetPartitionListAsync(serviceUri);

                foreach (var client in partitionList)
                {
                    var id = client.PartitionInformation.Id.ToString();
                    var info = (Int64RangePartitionInformation)client.PartitionInformation;
                    partition = await this.servicePartitionResolver.ResolveAsync(serviceUri, new ServicePartitionKey(info.LowKey), cancelRequest);
                    break;
                }
                ResolvedServiceEndpoint ep = partition.GetEndpoint();
                string endpointAddress = ep.Address;
                JObject addresses = JObject.Parse(endpointAddress);

                await SendFilePath((string)addresses["Endpoints"].First(), fileNames[0]);
            }

            output = "Upload Completed";

            using (HttpListenerResponse response = context.Response)
            {

                if (output != null)
                {
                    response.ContentType = "text/plain";

                    byte[] outBytes = Encoding.UTF8.GetBytes(output);
                    response.OutputStream.Write(outBytes, 0, outBytes.Length);
                }
            } 
        }

        private async Task SendFilePath(string address, string dir)
        {
            HttpClient httpClient = new HttpClient();
            UriBuilder primaryReplicaUriBuilder = new UriBuilder(address);
            primaryReplicaUriBuilder.Query = string.Format("file={0}", dir);
            await httpClient.GetStringAsync(primaryReplicaUriBuilder.Uri);
        }

        private void BlobProcessMethod(string originalFileName, Stream dataStream)
        {
            try
            {
                CloudStorageAccount csa = CloudStorageAccount.Parse(Utils.BlobAddress);

                var blobName = new FileInfo(originalFileName.Replace("\"", "")).Name;

                var blobClient = csa.CreateCloudBlobClient();
                var container = blobClient.GetContainerReference(Utils.BlobFolder);
                container.CreateIfNotExists();
                var uploadName = blobName;
                CloudBlockBlob blockBlob = container.GetBlockBlobReference(uploadName);
                blockBlob.UploadFromStream(dataStream);

                var list = container.ListBlobs(useFlatBlobListing: true);
                var listOfFileNames = new List<string>();

                //foreach (var blob in list)
                //{
                //    CloudBlob blobFile = container.GetBlobReference(Path.GetFileName(blob.Uri.LocalPath));

                //    using (var stream = blobFile.OpenRead())
                //    {
                //        using (StreamReader reader = new StreamReader(stream))
                //        {
                //            while (!reader.EndOfStream)
                //            {
                //                Debug.WriteLine(reader.ReadLine());
                //            }
                //        }
                //    }
                //}
                
            }
            catch (Exception e) {
                Debug.WriteLine(e.ToString());
            }

        }


    }
}