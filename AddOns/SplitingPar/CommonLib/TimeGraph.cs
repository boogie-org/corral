using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
using System.Diagnostics;

namespace CommonLib
{
    public class TimeGraph
    {
        Dictionary<int, string> Nodes;
        Dictionary<string, string> MachineMaps = new Dictionary<string, string>();
        Dictionary<string, DateTime> TimeMaps = new Dictionary<string, DateTime>();
        Dictionary<int, HashSet<Tuple<int, string, double>>> Edges;
        Stack<int> currNodeStack;
        DateTime startTime;
        static int dmpCnt = 0;
        string root = "";

        public TimeGraph()
        {
            currNodeStack = new Stack<int>();
            Nodes = new Dictionary<int, string>();
            Edges = new Dictionary<int, HashSet<Tuple<int, string, double>>>();
            startTime = DateTime.Now;

            Nodes.Add(0, "server");
            Push(0);
        }

        public TimeGraph(string name, string root)
        {
            currNodeStack = new Stack<int>();
            Nodes = new Dictionary<int, string>();
            Edges = new Dictionary<int, HashSet<Tuple<int, string, double>>>();
            startTime = DateTime.Now;
            this.root = root;
            MachineMaps[name] = "";
            Nodes.Add(0, name + "_");
            TimeMaps[name] = DateTime.Now;
            Push(0);
        }

        public int Count()
        {
            return Nodes.Count;
        }


        private void AddEdge(int n1, int n2, string label1, double label2)
        {
            if (!Edges.ContainsKey(n1))
                Edges.Add(n1, new HashSet<Tuple<int, string, double>>());
            Edges[n1].Add(Tuple.Create(n2, label1, label2));
        }

        public void ToDot()
        {
            string path = System.IO.Path.Combine(root, Utils.RunDir, "server" + (dmpCnt++) + ".dot");
            using (var fs = new System.IO.StreamWriter(path, false))
            {
                fs.WriteLine("digraph TG {");

                foreach (var tup in Nodes)
                {
                    fs.WriteLine("{0} [label=\"{1}\"]", tup.Key, tup.Value);
                }

                foreach (var tup in Edges)
                {
                    foreach (var tgt in tup.Value)
                        fs.WriteLine("{0} -> {1} [label=\"{2} {3}\"]", tup.Key, tgt.Item1, tgt.Item2, tgt.Item3.ToString("F2"));
                }

                fs.WriteLine("}");

            }
        }

        public void ToDot(string fileName)
        {
            using (var fs = new System.IO.StreamWriter("server_" + fileName + ".dot", false))
            {
                fs.WriteLine("digraph TG {");

                foreach (var tup in Nodes)
                {
                    fs.WriteLine("{0} [label=\"{1}\"]", tup.Key, tup.Value);
                }

                foreach (var tup in Edges)
                {
                    foreach (var tgt in tup.Value)
                        fs.WriteLine("{0} -> {1} [label=\"{2} {3}\"]", tup.Key, tgt.Item1, tgt.Item2, tgt.Item3.ToString("F2"));
                }

                fs.WriteLine("}");

            }
        }

        void Push(int node)
        {
            currNodeStack.Push(node);
        }

        public void Pop(int n)
        {
            while (n > 0) { n--; currNodeStack.Pop(); }
            startTime = DateTime.Now;
        } 

        public void AddEdge(string n1, string n2, string label, DateTime startTime)
        {
            Debug.Assert(MachineMaps.Keys.Contains(n1));
            string currentWork = MachineMaps[n1];
            string sender = n1 + "_" + currentWork;
            Debug.Assert(Nodes.Values.Contains(sender));
            var index01 = Nodes.First(n => n.Value.Equals(sender));

            string receiver = n2 + "_" + label;
            MachineMaps[n2] = label;

            var index02 = Nodes.Count;
            Nodes.Add(index02, receiver);
            TimeMaps[n2] = DateTime.Now;

            AddEdge(index01.Key, index02, label, (DateTime.Now - startTime).TotalSeconds); 
        }

        public void AddEdgeDone(string label)
        {
            var tgtnode = Nodes.Count;
            Nodes.Add(tgtnode, "Done");

            AddEdge(currNodeStack.Peek(), tgtnode, label, (DateTime.Now - startTime).TotalSeconds);
            startTime = DateTime.Now;
        }

        public void AddEdgeDone(string node, string label)
        {
            Debug.Assert(MachineMaps.Keys.Contains(node));
            string currentWork = MachineMaps[node];
            string sender = node + "_" + currentWork;
            Debug.Assert(Nodes.Values.Contains(sender));
            Debug.Assert(TimeMaps.Keys.Contains(node));

            var tgtnode = Nodes.Count;
            Nodes.Add(tgtnode, "Done");

            var index01 = Nodes.First(n => n.Value.Equals(sender));
            AddEdge(index01.Key, tgtnode, label, (DateTime.Now - TimeMaps[node]).TotalSeconds);
        }

        public double ComputeTimes(int nthreads)
        {
            // First, construct the time graph properly with times on nodes (not edges)
            var nodeToTime = new Dictionary<int, double>();
            var nodeToChildren = new Dictionary<int, HashSet<int>>();

            // Nodes
            foreach (var tup in Edges)
                foreach (var e in tup.Value)
                    nodeToTime.Add(e.Item1, e.Item3);

            foreach (var n in nodeToTime.Keys)
                nodeToChildren.Add(n, new HashSet<int>());
            //nodeToTime.Keys.Iter(n => nodeToChildren.Add(n, new HashSet<int>()));

            // Edges
            foreach (var tup in Edges)
                foreach (var e in tup.Value)
                {
                    var n1 = tup.Key;
                    var n2 = e.Item1;
                    if (!nodeToTime.ContainsKey(n1) || !nodeToTime.ContainsKey(n2))
                        continue;
                    nodeToChildren[n1].Add(n2);
                }

            var rand = new Random((int)DateTime.Now.Ticks);

            var root = Edges[0].First().Item1;
            var isZero = new Func<double, bool>(d => d < 0.00001);
            var isNull = new Func<Tuple<int, double>, bool>(t => t.Item1 < 0);

            var threads = new Tuple<int, double>[nthreads];
            for (int i = 0; i < nthreads; i++)
                threads[i] = Tuple.Create(-1, 0.0);

            var totaltime = 0.0;
            var available = new List<int>();
            available.Add(root);

            while (true)
            {
                // Allocate to idle threads
                for (int i = 0; i < nthreads; i++)
                {
                    if (!isNull(threads[i])) continue;
                    if (!available.Any()) continue;
                    var index = rand.Next(available.Count);
                    threads[i] = Tuple.Create(available[index], nodeToTime[available[index]]);
                    available.RemoveAt(index);
                }
                if (threads.All(t => isNull(t))) break;

                // Run
                var min = threads.Where(t => !isNull(t)).Min(t => t.Item2);
                totaltime += min;
                for (int i = 0; i < nthreads; i++)
                {
                    if (isNull(threads[i])) continue;
                    var tleft = threads[i].Item2 - min;
                    if (isZero(tleft))
                    {
                        foreach (var n in nodeToChildren[threads[i].Item1])
                            available.Add(n);
                        //nodeToChildren[threads[i].Item1].Iter(n => available.Add(n));
                        threads[i] = Tuple.Create(-1, 0.0);
                    }
                    else
                        threads[i] = Tuple.Create(threads[i].Item1, tleft);
                }
            }

            return totaltime;
        }
    }

}
