using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using CommonLib;

namespace SplitParServer
{
    public class ServerListener
    {
        Socket connection = null;
        string rootDir;
        bool remote;
        string[] args;

        //public Worker(Socket sk, string root, bool remote, params string[] args)
        //{
        //    connection = sk;
        //    rootDir = root;
        //    this.remote = remote;
        //    this.args = args;
        //}

        public ServerListener(string root, bool remote, params string[] args)
        {
            rootDir = root;
            this.remote = remote;
            this.args = args;
        }

        public void Listen()
        {
            var sep = new char[1];
            sep[0] = ':';

            if (connection != null)
            {
                string msg = "";
                while (!msg.Equals(Utils.CompletionMsg))
                {
                    byte[] data = new byte[Utils.MsgSize];
                    int receivedDataLength = connection.Receive(data); //Wait for the data
                    msg = Encoding.ASCII.GetString(data, 0, receivedDataLength); //Decode the data received
                    if (msg.Equals(Utils.CompletionMsg))
                    {
                        connection.Send(Utils.EncodeStr(Utils.CompletionMsg));
                        Finish();
                        break;
                    }
                    var split = msg.Split(sep);
                    LogWithAddress.WriteLine(string.Format("{0}", msg));
                }
            }
        }        

        public void Finish()
        {
            if (connection != null)
            {
                connection.Send(Utils.EncodeStr(Utils.CompletionMsg));
                connection.Close();
            }
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
