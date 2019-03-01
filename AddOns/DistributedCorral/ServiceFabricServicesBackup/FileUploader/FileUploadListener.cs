using System;
using System.Fabric;
using System.Fabric.Description;
using System.Globalization;
using System.Net;
using System.Net.WebSockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ServiceFabric.Services.Communication.Runtime;
using Microsoft.WindowsAzure.Storage;
using System.IO;
using Microsoft.WindowsAzure.Storage.Blob;

namespace FileUploader
{
    public class FileUploadListener : ICommunicationListener
    {
        private readonly string publishUri;
        private readonly HttpListener httpListener;
        private readonly CancellationTokenSource processRequestsCancellation = new CancellationTokenSource();

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
            String output = null;

            var dataStream = context.Request.InputStream;
            await MultipartParser.ParseFiles(dataStream, context.Request.ContentType, MyProcessMethod);

            output = "";

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

        private void MyProcessMethod(string originalFileName, Stream dataStream)
        {
            CloudStorageAccount csa = CloudStorageAccount.Parse("");

            var blobName = new FileInfo(originalFileName.Replace("\"", "")).Name;

            var blobClient = csa.CreateCloudBlobClient();

            var container = blobClient.GetContainerReference("fileuploads");

            container.CreateIfNotExists();

            var uploadName = blobName;
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(uploadName);
            blockBlob.UploadFromStream(dataStream);

        }
    }
}