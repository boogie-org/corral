using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using CommonLib;

namespace CommonLib
{
    public class Worker
    { 
        string rootDir;
        bool remote;
        string[] args; 

        public Worker(string root, bool remote, params string[] args)
        {
            rootDir = root;
            this.remote = remote;
            this.args = args;
        } 

        public void Run()
        { 
            if (remote)
                Utils.SpawnClientRemote(rootDir, args);
            else
            {
                Utils.SpawnClient(rootDir, args);
            }
        }  
    }
}
