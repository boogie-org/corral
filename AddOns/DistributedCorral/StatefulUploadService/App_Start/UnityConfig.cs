using Microsoft.ServiceFabric.Data;
using System.Web.Http;
using Unity;
using Unity.Injection;
using Unity.Lifetime;
using Unity.WebApi;

namespace StatefulUploadService
{
    public static class UnityConfig
    {
        public static void RegisterComponents(HttpConfiguration config, IReliableStateManager stateManager)
        {
            UnityContainer container = new UnityContainer();

            // The default controller needs a state manager to perform operations.
            // Using the DI container, we can inject it as a dependency.
            // This allows use to write unit tests against the controller using a mock state manager.
            container.RegisterType<DefaultController>(
                new TransientLifetimeManager(),
                new InjectionConstructor(stateManager));

            config.DependencyResolver = new UnityDependencyResolver(container);
        }
    }
}