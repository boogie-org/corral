using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class TimeGraph
    {
        Dictionary<int, string> Nodes;
        Dictionary<string, int> MachineMaps = new Dictionary<string, int>();
        Dictionary<string, string> MachineTaskMaps = new Dictionary<string, string>();
        List<Tuple<int, string>> SelfLoadTasks = new List<Tuple<int, string>>();
        Dictionary<string, DateTime> TimeMaps = new Dictionary<string, DateTime>();
        Dictionary<int, HashSet<Tuple<int, string, double>>> Edges; 
        DateTime startTime;
        int clientNo = 0;
        public TimeGraph(List<string> clients)
        { 
            Nodes = new Dictionary<int, string>();
            Edges = new Dictionary<int, HashSet<Tuple<int, string, double>>>();
            startTime = DateTime.Now;
            foreach (var client in clients)
            {
                MachineMaps[client] = Nodes.Count;
                Nodes.Add(Nodes.Count, client);
                TimeMaps[client] = DateTime.Now;
            }
            clientNo = clients.Count;
        } 

        private void AddEdge(int n1, int n2, string label1, double label2)
        {
            if (!Edges.ContainsKey(n1))
                Edges.Add(n1, new HashSet<Tuple<int, string, double>>());
            Edges[n1].Add(Tuple.Create(n2, label1, label2));
        }  

        public override string ToString()
        {
            string result = "";
            result += "digraph TG {";
            string tmp = "{rank = same;";
            for (int i = 1; i < clientNo/2; ++i) 
                tmp = tmp + i.ToString() + "->" + (i + 1).ToString() + "[style=invis];";
            tmp = tmp + (clientNo / 2).ToString() + "-> 0[style=invis];";
            tmp = tmp + "0" + "-> " + (clientNo / 2 + 1).ToString() + "[style=invis];"; 
            for (int i = clientNo / 2 + 1; i < clientNo - 1; ++i)
                tmp = tmp + i.ToString() + "->" + (i + 1).ToString() + "[style=invis];";
            tmp = tmp + "}";
            result += tmp;

            for (int i = 0; i < clientNo; ++i)
                result += string.Format("{0} [label=\"Client-{1}\"]", i, i);
            for (int i = clientNo; i < Nodes.Count; ++i)
            {
                var tup = Nodes[i];
                if (tup.EndsWith("split.txt"))
                {
                    tup = "CT" + tup.Substring(0, tup.IndexOf("split.txt"));
                }

                if (tup.Length > 10)
                    tup = ".." + tup.Substring(tup.Length - 8);

                if (Nodes[i].Length == 0)
                    result += string.Format("{0} [label=\"{1}\", width = 0.1, height = 0.1]", i, "");
                else
                    result += string.Format("{0} [label=\"{1}\"]", i, tup);
            }
            
            foreach (var tup in Edges)
            {
                foreach (var tgt in tup.Value)
                {
                    string label = tgt.Item2;
                    if (label.EndsWith("split.txt"))
                    {
                        label = "CT" + label.Substring(0, label.IndexOf("split.txt"));
                    }
                    if (tgt.Item3 > 0)
                    {
                        if (Nodes[tup.Key].Equals("Done"))
                            result = result + (string.Format("{0} -> {1} [style=dotted, label=\"{2} {3}\"]", tup.Key, tgt.Item1, label, tgt.Item3.ToString("F2") + "s"));
                        else
                            result = result + string.Format("{0} -> {1} [label=\"{2} {3}\"]", tup.Key, tgt.Item1, label, tgt.Item3.ToString("F2") + "s");
                    }
                    else if (!tgt.Item2.Equals("Done"))
                    {
                        if (!SelfLoadTasks.Contains(new Tuple<int, string>(tup.Key, tgt.Item2)))
                        {
                            
                            if (tgt.Item2.StartsWith("Load "))
                            {
                                result = result + string.Format("{{rank = same; {0} -> {1}[style=dotted, label=\"{2}\", constraint=false];}}", tup.Key, tgt.Item1, label);
                            }
                            else
                            {
                                result = result + string.Format("{{rank = same; {0} -> {1}[label=\"{2}\", constraint=false];}}", tup.Key, tgt.Item1, label);
                            }
                        }
                        else
                        {
                            result = result + string.Format("{0} -> {1} [style=dotted, label=\"{2}\"]", tup.Key, tgt.Item1, tgt.Item2);
                        }
                    }
                }
            } 

            result += "}";
            return result;
        }

        public void AddEdge(string n1, string n2, string label)
        {
            Debug.Assert(MachineMaps.Keys.Contains(n1));
            Debug.Assert(MachineMaps.Keys.Contains(n2));
            lock (MachineMaps)
            {
                bool selfLoading = false;
                if (n1 == n2)
                {
                    SelfLoadTasks.Add(new Tuple<int, string>(MachineMaps[n1], label));
                    selfLoading = true;
                }

                if (!selfLoading)
                {
                    int currentWork01 = MachineMaps[n1];
                    Nodes.Add(Nodes.Count, "");
                    AddEdge(currentWork01, Nodes.Count - 1, "", (DateTime.Now - TimeMaps[n1]).TotalSeconds);
                    MachineMaps[n1] = Nodes.Count - 1;

                    int currentWork02 = MachineMaps[n2];
                    Nodes.Add(Nodes.Count, label);
                    AddEdge(currentWork02, Nodes.Count - 1, "", (DateTime.Now - TimeMaps[n2]).TotalSeconds);
                    MachineMaps[n2] = Nodes.Count - 1;

                    TimeMaps[n2] = DateTime.Now;
                    TimeMaps[n1] = DateTime.Now;

                    AddEdge(Nodes.Count - 2, Nodes.Count - 1, label, 0);
                }
                else
                {
                    int currentWork01 = MachineMaps[n1];
                    Nodes.Add(Nodes.Count, label);
                    AddEdge(currentWork01, Nodes.Count - 1, label, (DateTime.Now - TimeMaps[n1]).TotalSeconds);
                    MachineMaps[n1] = Nodes.Count - 1;
                    TimeMaps[n1] = DateTime.Now;
                }
            }
        }

        public void AddEdgeDone(string client)
        {
            Debug.Assert(MachineMaps.Keys.Contains(client));
            var tgtnode = Nodes.Count;
            Nodes.Add(tgtnode, "Done");

            AddEdge(MachineMaps[client], tgtnode, "", (DateTime.Now - TimeMaps[client]).TotalSeconds);
            MachineMaps[client] = Nodes.Count - 1;
            TimeMaps[client] = DateTime.Now;
        } 
    }
}
