using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LocalServerInCsharp
{
    public class Config
    {
        public int numMaxClients;
        public int numListeners;
        public bool startLocalListener;
        public Config()
        {
            startLocalListener = false;
            numMaxClients = 35;
            numListeners = 1;
        }
    }
}
