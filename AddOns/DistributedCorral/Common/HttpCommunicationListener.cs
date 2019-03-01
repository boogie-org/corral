using Microsoft.ServiceFabric.Services.Communication.Runtime;
using System;
using System.Fabric;
using System.Fabric.Description; 
using System.Net; 
using System.Threading;
using System.Threading.Tasks;

namespace Common
{
    public sealed class HttpCommunicationListener : ICommunicationListener
    {
        private readonly string publishUri;
        private readonly HttpListener httpListener;
        private readonly Func<HttpListenerContext, CancellationToken, Task> processRequest;
        private readonly CancellationTokenSource processRequestsCancellation = new CancellationTokenSource();

        public HttpCommunicationListener(string serviceEndPoint, ServiceContext serviceContext, Func<HttpListenerContext, CancellationToken, Task> processRequest)
        {
            EndpointResourceDescription internalEndpoint = serviceContext.CodePackageActivationContext.GetEndpoint(serviceEndPoint);
            string uriPrefix = String.Format(
                "{0}://+:{1}/{2}/{3}-{4}/",
                internalEndpoint.Protocol,
                internalEndpoint.Port,
                serviceContext.PartitionId,
                serviceContext.ReplicaOrInstanceId,
                Guid.NewGuid());

            string nodeIP = FabricRuntime.GetNodeContext().IPAddressOrFQDN;

            this.publishUri = uriPrefix.Replace("+", nodeIP);
            this.processRequest = processRequest;
            this.httpListener = new HttpListener();
            this.httpListener.Prefixes.Add(uriPrefix);
        }

        public HttpCommunicationListener(string uriPrefix, string uriPublished, Func<HttpListenerContext, CancellationToken, Task> processRequest)
        {
            this.publishUri = uriPublished;
            this.processRequest = processRequest;
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
            while (!processRequests.IsCancellationRequested)
            {
                HttpListenerContext request = await this.httpListener.GetContextAsync();

                // The ContinueWith forces rethrowing the exception if the task fails.
                Task requestTask = this.processRequest(request, this.processRequestsCancellation.Token)
                    .ContinueWith(async t => await t /* Rethrow unhandled exception */, TaskContinuationOptions.OnlyOnFaulted);
            }
        }
    }
}
