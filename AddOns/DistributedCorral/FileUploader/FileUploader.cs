using System;
using System.Collections.Generic;
using System.Fabric; 
using System.Threading;
using System.Threading.Tasks;
using Microsoft.ServiceFabric.Services.Communication.Runtime;
using Microsoft.ServiceFabric.Services.Runtime;
using System.Fabric.Description; 
using Common;

namespace FileUploader
{
    /// <summary>
    /// An instance of this class is created for each service instance by the Service Fabric runtime.
    /// </summary>
    internal sealed class FileUploader : StatelessService
    {
        public FileUploader(StatelessServiceContext context)
            : base(context)
        { }

        /// <summary>
        /// Optional override to create listeners (e.g., TCP, HTTP) for this service replica to handle client or user requests.
        /// </summary>
        /// <returns>A collection of listeners.</returns>
        protected override IEnumerable<ServiceInstanceListener> CreateServiceInstanceListeners()
        {
            return new[] 
            {
                new ServiceInstanceListener(initParams => new WebCommunicationListener("fileuploader", initParams), "httpListener"),
                new ServiceInstanceListener(context => this.FileUploadSaveListener(context))
            };
        }
        private ICommunicationListener FileUploadSaveListener(ServiceContext context)
        {
            // Service instance's URL is the node's IP & desired port
            EndpointResourceDescription inputEndpoint = context.CodePackageActivationContext.GetEndpoint(Utils.WebAPIServiceEndpoint); 
            string uriPrefix = String.Format("{0}://+:{1}/save/", inputEndpoint.Protocol, inputEndpoint.Port); 
            string uriPublished = uriPrefix.Replace("+", FabricRuntime.GetNodeContext().IPAddressOrFQDN);

            return new FileUploadListener(uriPrefix, uriPublished);
        }

        /// <summary>
        /// This is the main entry point for your service instance.
        /// </summary>
        /// <param name="cancellationToken">Canceled when Service Fabric needs to shut down this service instance.</param>
        protected override async Task RunAsync(CancellationToken cancellationToken)
        { 
            while (true)
            {
                cancellationToken.ThrowIfCancellationRequested(); 

                await Task.Delay(TimeSpan.FromSeconds(1), cancellationToken);
            }
        }
    }
}