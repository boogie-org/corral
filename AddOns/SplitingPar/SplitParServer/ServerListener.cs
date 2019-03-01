using System;
using System.Collections.Generic;
using System.Diagnostics;
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
        public Socket connection = null;
        public string clientAddress;
        public string currentResult = "OK"; 

        public ServerListener(Socket sk, string clientAddress)
        {
            connection = sk;
            this.clientAddress = clientAddress;
        }

        public void Listen()
        {
            var sep = new char[1];
            sep[0] = ':';
            var sep01 = new char[1];
            sep01[0] = ';';

            if (connection != null)
            {
                string msg = "";
                while (!msg.Contains(Utils.DoneMsg))
                {
                    msg = "";
                    try
                    {
                        //Wait for the data from client
                        byte[] data = new byte[Utils.MsgSize];
                        int receivedDataLength = connection.Receive(data);
                        msg = Encoding.ASCII.GetString(data, 0, receivedDataLength);  
                    }
                    catch (Exception e)
                    {
                        lock (SplitParServer.ClientStates)
                        {
                            SplitParServer.ClientStates[clientAddress] = Utils.CurrentState.AVAIL;
                        }
                        LogWithAddress.WriteLine(string.Format("{0} close because of {1}", clientAddress, e.ToString()));
                        Finish();
                        break;
                    }

                    if (msg.Contains(Utils.ErrorMsg))
                    {
                        LogWithAddress.WriteLine(string.Format("{0}: {1}", clientAddress, msg));
                        Debug.Assert(false);
                    }
                    else if (msg.Contains(Utils.CompletionMsg))
                    {
                        // clean the task list 
                        lock (SplitParServer.BplTasks)
                        {
                            SplitParServer.BplTasks.RemoveAll(task => task.author.Equals(clientAddress));
                        }

                        // parse client message: Complete:OK|NOK|RB 
                        if (msg.Contains(":NOK"))
                        {
                            // kill all clients if they are running
                            SplitParServer.ForceClose();
                            currentResult = "NOK";
                            lock (SplitParServer.timeGraph)
                            {
                                SplitParServer.timeGraph.AddEdgeDone(Utils.GetRemoteMachineName(clientAddress), currentResult);
                            }
                            break;
                        }
                        else if (msg.Contains(":RB"))
                            currentResult = "RB";
                        else if (msg.Contains(":OK"))
                            currentResult = "OK";
                        else
                            Debug.Assert(false);

                        lock (SplitParServer.timeGraph)
                        {
                            SplitParServer.timeGraph.AddEdgeDone(Utils.GetRemoteMachineName(clientAddress), currentResult);
                        }


                        // client completed his job
                        lock (SplitParServer.ClientStates)
                        {
                            SplitParServer.ClientStates[clientAddress] = Utils.CurrentState.AVAIL;
                        }

                        LogWithAddress.WriteLine(string.Format("Client {0} completed", clientAddress));
                        if (SplitParServer.areTasksAvail())
                        {
                            SplitParServer.DeliverOneTask();
                        }
                        else if (!SplitParServer.areClientsWorking())
                        {
                            SplitParServer.SendDoneMsg();
                        }
                    }
                    else if (msg.Contains(Utils.DoneMsg))
                    {
                        lock (SplitParServer.ClientStates)
                        {
                            SplitParServer.ClientStates[clientAddress] = Utils.CurrentState.AVAIL;
                        }
                        LogWithAddress.WriteLine(string.Format("{0}: {1}", clientAddress, msg));
                        // clients & server completed their job
                        Finish();
                        break;
                    } 

                    var sepMsg = msg.Split(sep01);
                    foreach (var s in sepMsg)
                    {
                        if (s.Contains(Utils.DoingMsg))
                        {
                            // task to remove
                            var split = s.Split(sep);
                            LogWithAddress.WriteLine(string.Format("{0}: {1}", clientAddress, s));
                            if (split.Length > 1)
                            {
                                var fileName = split[1];
                                if (fileName.Contains(Utils.CallTreeSuffix))
                                {
                                    fileName = fileName.Substring(0, fileName.IndexOf(Utils.CallTreeSuffix)) + Utils.CallTreeSuffix;
                                    lock (SplitParServer.BplTasks)
                                    {
                                        for (int i = 0; i < SplitParServer.BplTasks.Count; ++i)
                                            if (SplitParServer.BplTasks[i].callTreeDir.Equals(fileName))
                                            {
                                                SplitParServer.BplTasks.RemoveAt(i);
                                                break;
                                            }
                                    }
                                }
                            }
                        }
                        else
                        {
                            // new task is available
                            var split = s.Split(sep);
                            if (split.Length > 1)
                            {
                                var fileName = split[1];
                                if (fileName.Contains(Utils.CallTreeSuffix))
                                {
                                    fileName = fileName.Substring(0, fileName.IndexOf(Utils.CallTreeSuffix)) + Utils.CallTreeSuffix;
                                    BplTask newTask = new BplTask(clientAddress, fileName, int.Parse(split[0]));
                                    LogWithAddress.WriteLine(string.Format("{0}: {1}", clientAddress, s));

                                    // add a new task
                                    lock (SplitParServer.BplTasks)
                                    {
                                        SplitParServer.BplTasks.Add(newTask);
                                    }
                                    if (SplitParServer.areClientsAvail() && SplitParServer.areTasksAvail())
                                        SplitParServer.DeliverOneTask();
                                }
                            }
                        }
                    }
                }
            }
        }

        public void Finish()
        {
            if (connection != null)
            {
                //connection.Shutdown(SocketShutdown.Both);
                connection.Close();
            }
        }
    }
}
