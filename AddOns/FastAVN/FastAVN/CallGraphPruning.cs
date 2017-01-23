using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using btype = Microsoft.Boogie.Type;
using Microsoft.Boogie.GraphUtil;
using System.IO;
using System.Threading;
using System.Collections.Concurrent;

namespace FastAVN
{
    static class CallGraphPruning
    {
        static HashSet<string> Nodes;
        static Dictionary<string, HashSet<string>> Successors;
        static Dictionary<string, HashSet<string>> Predecessors;

        public static HashSet<string> FindPrunedEntryPoints(Graph<string> callGraph, int k)
        {
            // initialize static data
            Nodes = new HashSet<string>(callGraph.Nodes);

            Successors = new Dictionary<string, HashSet<string>>();
            Nodes.Iter(n => Successors[n] = new HashSet<string>(callGraph.Successors(n)));

            Predecessors = new Dictionary<string, HashSet<string>>();
            Nodes.Iter(n => Predecessors[n] = new HashSet<string>(callGraph.Predecessors(n)));

            var nodesCount = Nodes.Count;
            //Console.WriteLine("total = {0}", nodesCount);

            // start computation
            var ret = new HashSet<string>();
            var skip = new HashSet<string>();

            while(ret.Count + skip.Count != nodesCount)
            {
                //Console.WriteLine("included: {0}", ret.Count);
                //Console.WriteLine("excluded: {0}", skip.Count);

                // start at the roots
                var frontier = new HashSet<string>(
                    Nodes.Where(n => Predecessors[n].Count == 0));

                // if none, then pick highest out-degree guys
                if(frontier.Count == 0)
                {
                    var degrees = new List<Tuple<int, string>>(
                        Nodes.Select(n => Tuple.Create(-1 * Successors[n].Count, n)));
                    degrees.Sort();

                    frontier.Add(degrees[0].Item2);
                    if (degrees.Count > 1) frontier.Add(degrees[1].Item2);
                }

                // pick the frontier
                ret.UnionWith(frontier);

                // skip everything close to what we've picked
                var close = NodesWithinDistance(ret.Intersection(Nodes), k);
                close.ExceptWith(ret);

                skip.UnionWith(close);

                // delete the picked nodes
                close.Iter(n => DeleteNode(n));
                frontier.Iter(n => DeleteNode(n));
            }

            return ret;
        }

        public static int DisplayPruning(Graph<string> callGraph, int k, string filename)
        {
            var pruned = FindPrunedEntryPoints(callGraph, k);
            var str = callGraph.ToDot(null, n => pruned.Contains(n) ? "[color=red]" : "[color=blue]");

            var file = new StreamWriter(filename);
            file.Write(str);
            file.Close();

            return pruned.Count;
        }

        static void DeleteNode(string node)
        {
            var pred = new HashSet<string>(Predecessors[node]);
            var succ = new HashSet<string>(Successors[node]);
            pred.Remove(node);
            succ.Remove(node);

            pred.Iter(n => Successors[n].Remove(node));
            succ.Iter(n => Predecessors[n].Remove(node));

            Nodes.Remove(node);
        }

        // Find all nodes that are strictly within distance k from the roots
        static HashSet<string> NodesWithinDistance(HashSet<string> roots, int k)
        {
            var frontier = new HashSet<string>(roots);
            var within = new HashSet<string>(frontier);

            for(int i = 0; i < k; i++)
            {
                var next = new HashSet<string>();
                frontier.Iter(n => next.UnionWith(Successors[n]));

                frontier = next;
                frontier.ExceptWith(within);

                within.UnionWith(frontier);                
            }

            var close = new HashSet<string>();
            within.Where(n => Predecessors[n].IsSubsetOf(within))
                .Iter(n => close.Add(n));

            return close;
        }
    }

}