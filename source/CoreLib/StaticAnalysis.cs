using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System.Diagnostics;
using cba.Util;
using Microsoft.Boogie.Houdini;
using cba;

namespace StaticAnalysis
{

    class RHS
    {
        IWeight iw;
        CBAProgram program;
        List<IntraGraph> intraGraphs;
        Dictionary<string, IntraGraph> id2Graph;
        // Call Graph
        Dictionary<string, HashSet<IntraGraph>> Succ;
        Dictionary<string, HashSet<IntraGraph>> Pred;
        public TimeSpan computeTime { get; private set; }

        public RHS(CBAProgram program, IWeight iw)
        {
            this.iw = iw;
            this.program = program;
            intraGraphs = new List<IntraGraph>();
            id2Graph = new Dictionary<string, IntraGraph>();
            Succ = new Dictionary<string, HashSet<IntraGraph>>();
            Pred = new Dictionary<string, HashSet<IntraGraph>>();
            computeTime = TimeSpan.Zero;

            // Make all the graphs
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl => intraGraphs.Add(
                    new IntraGraph(impl, iw, p =>
                        {
                            if (!id2Graph.ContainsKey(p)) return null;
                            else return id2Graph[p].summary;
                        }
            )));

            intraGraphs.Iter(g => id2Graph.Add(g.Id, g));

            intraGraphs.Iter(g =>
            {
                Succ.Add(g.Id, new HashSet<IntraGraph>());
                Pred.Add(g.Id, new HashSet<IntraGraph>());
            });

            intraGraphs.Iter(g =>
                g.Callees
                .Where(s => id2Graph.ContainsKey(s))
                .Iter(s =>
                    {
                        Succ[g.Id].Add(id2Graph[s]);
                        Pred[s].Add(g);
                    }
            ));

            // assign priorities
            var sccs = new StronglyConnectedComponents<IntraGraph>(
                intraGraphs,
                new Adjacency<IntraGraph>(g => Succ[g.Id]),
                new Adjacency<IntraGraph>(g => Pred[g.Id]));
            sccs.Compute();

            var priority = intraGraphs.Count;
            foreach (var scc in sccs)
            {
                /*
                if (scc.Count > 1)
                {
                    Console.WriteLine("SCC size: {0}", scc.Count);
                    scc.Iter(g => Console.WriteLine("{0}", g.Id));
                }
                */
                scc.Iter(g => g.priority = priority);
                priority--;
            }

        }

        public void Compute()
        {
            var begin = DateTime.Now;

            var worklist = new SortedSet<IntraGraph>(intraGraphs.First());
            intraGraphs.Iter(g => worklist.Add(g));

            while (worklist.Any())
            {
                var proc = worklist.First();
                worklist.Remove(proc);

                proc.Compute();
                if (proc.summaryChanged)
                {
                    Pred[proc.Id].Iter(g => worklist.Add(g));
                }
            }

            computeTime = (DateTime.Now - begin);
        }

        public void ComputePreconditions()
        {
            var NameToImpl = new Func<string, Implementation>(name =>
                BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, name));
            var main = id2Graph[program.mainProcName];
            main.UpdatePrecondition(main.precondition.Top(NameToImpl(main.Id)));

            IntraGraph.TopDown = true;
            var worklist = new SortedSet<IntraGraph>(main);
            worklist.Add(main);

            var SetPrecondition = new Action<string, IWeight>((name, weight) =>
                {
                    var g = id2Graph[name];
                    var changed = g.UpdatePrecondition(weight);
                    if(changed) 
                        worklist.Add(g);
                });

            while (worklist.Any())
            {
                var proc = worklist.First();
                worklist.Remove(proc);
                proc.PropagatePrecondition(NameToImpl, SetPrecondition);
            }

            IntraGraph.TopDown = false;
        }

        public IWeight GetSummary(string procName)
        {
            return id2Graph[procName].summary;
        }

        public IWeight GetPrecondition(string procName)
        {
            return id2Graph[procName].precondition;
        }
    }

    class IntraGraph : IComparer<IntraGraph>
    {
        public string Id;
        public List<Node> Nodes;
        public List<Edge> Edges;
        public int priority;
        // Id -> node
        Dictionary<string, Node> idToNode;
        // callee --> src node
        Dictionary<string, HashSet<Node>> calleeToEdgeSrc;
        public IEnumerable<string> Callees {
            get {
                return calleeToEdgeSrc.Keys;
            }
        }

        // placeholder
        IWeight iw;
        // summary
        public IWeight summary { get; private set; }
        // summary changed?
        public bool summaryChanged { get; private set; }

        // precondition
        public IWeight precondition { get; private set; }
        // precondition changed?
        public bool preconditionChanged { get; private set; }

        // List of return nodes
        List<Node> returnNodes;
        // Entry node
        Node entryNode;
        // Implementation
        Implementation impl;
        // Has Compute been run before
        bool computedBefore;
        // Summary of other procedures
        Func<string, IWeight> ProcSummary;

        public IntraGraph(Implementation impl, IWeight iw, Func<string, IWeight> ProcSummary)
        {
            this.impl = impl;
            this.Id = impl.Name;
            this.ProcSummary = ProcSummary;
            priority = 0;
            idToNode = new Dictionary<string, Node>();
            Nodes = new List<Node>();
            Edges = new List<Edge>();
            calleeToEdgeSrc = new Dictionary<string, HashSet<Node>>();
            this.iw = iw;
            this.summary = iw.Zero(impl);
            this.precondition = iw.Zero(impl);

            returnNodes = new List<Node>();
            summaryChanged = false;
            preconditionChanged = false;
            computedBefore = false;

            // Create nodes
            foreach (var block in impl.Blocks)
            {
                var n1 = new Node(block.Label + "::in", iw.Zero(impl));
                var n2 = new Node(block.Label + "::out", iw.Zero(impl));
                Nodes.Add(n1);
                Nodes.Add(n2);

                var edge = new Edge(n1, n2, block.Cmds.OfType<Cmd>());
                n1.AddEdge(edge);
                n2.AddEdge(edge);
                Edges.Add(edge);

                // return nodes
                if (block.TransferCmd is ReturnCmd)
                {
                    returnNodes.Add(n2);
                }

                // calls
                foreach (var callee in edge.Callees)
                {
                    if (!calleeToEdgeSrc.ContainsKey(callee))
                        calleeToEdgeSrc.Add(callee, new HashSet<Node>());
                    calleeToEdgeSrc[callee].Add(n1);
                }

            }

            Nodes.Iter(n => idToNode.Add(n.Id, n));
            entryNode = idToNode[impl.Blocks[0].Label + "::in"];

            // connecting edges
            foreach (var block in impl.Blocks)
            {
                var gc = block.TransferCmd as GotoCmd;
                if (gc == null) continue;

                var src = idToNode[block.Label + "::out"];

                var edges = gc.labelNames
                    .OfType<string>()
                    .Select(s => idToNode[s + "::in"])
                    .Select(tgt => new Edge(src, tgt, new Cmd[] { }));

                edges.Iter(e => { Edges.Add(e); e.src.AddEdge(e); e.tgt.AddEdge(e); });

            }
            
            // Compute priorities
            var sccs = new StronglyConnectedComponents<Node>(Nodes,
                new Adjacency<Node>(n => n.Successors.Select(e => e.tgt)),
                new Adjacency<Node>(n => n.Predecessors.Select(e => e.src)));
            sccs.Compute();

            int p = 0;
            foreach (var scc in sccs)
            {
                scc.Iter(n => n.priority = p);
                p++;
            }
        }

        public void Compute()
        {
            Compute(calleeToEdgeSrc.Keys);
        }

        public void Compute(IEnumerable<string> updatedCallees)
        {
            var worklist = new SortedSet<Node>(entryNode);
            summaryChanged = false;

            if (!computedBefore)
            {
                entryNode.weight = iw.GetInitial(impl);
                worklist.Add(entryNode);
            }
            else
            {
                updatedCallees.Iter(c => calleeToEdgeSrc[c].Iter(n => worklist.Add(n)));
            }
            
            computedBefore = true;

            while (worklist.Any())
            {
                var node = worklist.First();
                worklist.Remove(node);

                foreach (var edge in node.Successors)
                {
                    var c = edge.Propagate(ProcSummary);
                    if (c) worklist.Add(edge.tgt);
                }

            }

            // Compute summary
            foreach (var r in returnNodes)
            {
                var c = summary.Combine(r.weight);
                summaryChanged = summaryChanged || c;
            }

        }

        public void PropagatePrecondition(Func<string, Implementation> NameToImpl, Action<string, IWeight> SetPrecondition)
        {
            foreach (var node in Nodes)
            {
                node.weight = iw.Zero(impl);
            }
            entryNode.weight = precondition;

            var worklist = new SortedSet<Node>(entryNode);
            worklist.Add(entryNode);

            while (worklist.Any())
            {
                var node = worklist.First();
                worklist.Remove(node);

                foreach (var edge in node.Successors)
                {
                    var c = edge.PropagatePrecondition(ProcSummary, NameToImpl, SetPrecondition);
                    if (c) worklist.Add(edge.tgt);
                }

            }
        }

        public bool UpdatePrecondition(IWeight weight)
        {
            return precondition.Combine(weight);
        }

        public override string ToString()
        {
            return Id;
        }


        #region IComparer<IntraGraph> Members

        public static bool TopDown = false;

        public int Compare(IntraGraph x, IntraGraph y)
        {
            if (!TopDown)
            {
                var r = x.priority.CompareTo(y.priority);
                if (r != 0) return r;
                else return x.Id.CompareTo(y.Id);
            }
            else
            {
                var r = y.priority.CompareTo(x.priority);
                if (r != 0) return r;
                else return y.Id.CompareTo(x.Id);
            }
        }

        #endregion
    }

    class Node :IComparer<Node>
    {
        public string Id;
        public IWeight weight;
        public List<Edge> Successors;
        public List<Edge> Predecessors;
        public int priority;

        public Node(string Id, IWeight weight)
        {
            this.Id = Id;
            this.weight = weight;
            this.priority = 0;
            Successors = new List<Edge>();
            Predecessors = new List<Edge>();
        }

        public void AddEdge(Edge edge)
        {
            if (edge.src.Equals(this))
            {
                Successors.Add(edge);
            }
            else if (edge.tgt.Equals(this))
            {
                Predecessors.Add(edge);
            }
            else
            {
                Debug.Assert(false);
            }
        }

        public override string ToString()
        {
            return Id;
        }

        public override bool Equals(object obj)
        {
            var that = obj as Node;
            if(that == null) return false;
            return Id == that.Id;
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }

        #region IComparer<Node> Members

        public int Compare(Node x, Node y)
        {
            var r = x.priority.CompareTo(y.priority);
            if (r != 0) return r;
            else return x.Id.CompareTo(y.Id);
        }

        #endregion
    }

    class Edge
    {
        public Node src, tgt;
        public List<Cmd> cmds;

        public Edge(Node src, Node tgt, IEnumerable<Cmd> cmds)
        {
            this.src = src;
            this.tgt = tgt;
            this.cmds = new List<Cmd>(cmds);
        }

        public bool HasCallCmd
        {
            get
            {
                return cmds.Any(c => c is CallCmd);
            }
        }

        public IEnumerable<string> Callees
        {
            get
            {
                return cmds.OfType<CallCmd>().Select(c => c.callee);
            }
        }

        public bool Propagate(Func<string, IWeight> ProcSummary)
        {
            var weight = src.weight;
            foreach (var cmd in cmds)
            {
                if (cmd is CallCmd)
                {
                    var callee = (cmd as CallCmd).callee;
                    var summary = ProcSummary(callee);
                    if (summary != null)
                    {
                        weight = weight.Extend(cmd as CallCmd, summary);
                        continue;
                    }
                }
                weight = weight.Extend(cmd);
            }
            return tgt.weight.Combine(weight);
        }

        public bool PropagatePrecondition(Func<string, IWeight> ProcSummary, Func<string, Implementation> NameToImpl,
            Action<string, IWeight> SetPrecondition)
        {
            var weight = src.weight;
            foreach (var cmd in cmds)
            {
                if (cmd is CallCmd)
                {
                    var callee = (cmd as CallCmd).callee;
                    var summary = ProcSummary(callee);
                    if (summary != null)
                    {
                        SetPrecondition(callee,
                            weight.ApplyCall(cmd as CallCmd, NameToImpl(callee)));

                        weight = weight.Extend(cmd as CallCmd, summary);
                        continue;
                    }
                }
                weight = weight.Extend(cmd);
            }
            return tgt.weight.Combine(weight);
        }

        public override string ToString()
        {
            return string.Format("{0} --> {1}", src, tgt);
        }
    }

    public interface IWeight
    {
        IWeight Zero(Implementation impl);
        IWeight GetInitial(Implementation impl);
        // Do Join and return if the current weight changed?
        bool Combine(IWeight weight);
        // Apply transformation
        IWeight Extend(Cmd cmd);
        IWeight Extend(CallCmd cmd, IWeight summary);
        // For precondition computation
        IWeight Top(Implementation impl);
        IWeight ApplyCall(CallCmd cmd, Implementation callee);
        // print on console
        void Print();
    }

}
