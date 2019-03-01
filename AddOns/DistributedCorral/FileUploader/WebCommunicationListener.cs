using Microsoft.ServiceFabric.Services.Communication.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using Microsoft.Owin.Hosting;
using System.Fabric.Description;
using System.Fabric;
using System.Globalization;
using Common;

namespace FileUploader
{
    public class WebCommunicationListener : ICommunicationListener
    {
        private readonly string appRoot;
        private readonly ServiceContext serviceInitializationParameters;
        private string listeningAddress;
        private string publishAddress;

        // OWIN server handle.
        private IDisposable webApp;

        public WebCommunicationListener(string appRoot, ServiceContext serviceInitializationParameters)
        {
            this.appRoot = appRoot;
            this.serviceInitializationParameters = serviceInitializationParameters;
        }

        public void Abort()
        {
            this.StopAll();
        }

        public Task CloseAsync(CancellationToken cancellationToken)
        {
            this.StopAll();
            return Task.FromResult(true);
        }

        public Task<string> OpenAsync(CancellationToken cancellationToken)
        {
            ServiceEventSource.Current.Message("Initialize");

            EndpointResourceDescription serviceEndpoint = this.serviceInitializationParameters.CodePackageActivationContext.GetEndpoint(Utils.WebServiceEndpoint);
            int port = serviceEndpoint.Port;

            this.listeningAddress = string.Format(
                CultureInfo.InvariantCulture,
                "http://+:{0}/{1}",
                port,
                string.IsNullOrWhiteSpace(this.appRoot)
                    ? string.Empty
                    : this.appRoot.TrimEnd('/') + '/');

            this.publishAddress = this.listeningAddress.Replace("+", FabricRuntime.GetNodeContext().IPAddressOrFQDN);

            ServiceEventSource.Current.Message("Starting web server on {0}", this.listeningAddress);

            this.webApp = WebApp.Start<Startup>(this.listeningAddress);

            return Task.FromResult(this.publishAddress);
        }
        /// <summary>
        /// Stops, cancels, and disposes everything.
        /// </summary>
        private void StopAll()
        {
            try
            {
                if (this.webApp != null)
                {
                    ServiceEventSource.Current.Message("Stopping web server.");
                    this.webApp.Dispose();
                }
            }
            catch (ObjectDisposedException)
            {
            }
        }
    }
}