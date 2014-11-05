using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Microsoft.Basetypes;
using BType = Microsoft.Boogie.Type;
using Microsoft.Boogie.GraphUtil;

namespace ExplainError
{
    /// <summary>
    /// Calculates the set of variables modified inside the two branches of a conditional block
    /// </summary>
    public class ControlFlowDependency
    {
        Program prog;
        //a null block indicates returnBlock
        //impl -> {(b,j,S) | b is branch,j is join and S is the modset between b and j}
        Dictionary<string, HashSet<Tuple<Block,Block,HashSet<Variable>>>> branchJoinPairModSet; 
        public ControlFlowDependency(Program prog)
        {
            this.prog = prog;
            branchJoinPairModSet = new Dictionary<string,HashSet<Tuple<Block,Block,HashSet<Variable>>>>();
        }
        public void Run()
        {
            //perform interprocedural modset analysis
            (new ModSetCollector()).DoModSetAnalysis(prog);
            prog.Implementations.Iter(impl => (new IntraProcModSetComputerPerImpl(this, impl)).Run());
            // Add place holders
            prog.TopLevelDeclarations.OfType<Implementation>()
                .Iter(InstrumentImplementation);
        }

        // Instrument:
        //    assume {:basicblock "proc", "label"} true;
        //    assume {:beginproc "proc"} true;
        //    assume {:endproc "proc"} true;
        //    var {:originallocal "proc", "l"} l;
        void InstrumentImplementation(Implementation impl)
        {
            var beg = new AssumeCmd(Token.NoToken, Expr.True,
                new QKeyValue(Token.NoToken, "beginproc", new List<object> { impl.Name }, null));
            var end = new AssumeCmd(Token.NoToken, Expr.True,
                new QKeyValue(Token.NoToken, "endproc", new List<object> { impl.Name }, null));
            var blockstart = new Func<Block, AssumeCmd>(blk =>
                {
                    return new AssumeCmd(Token.NoToken, Expr.True,
                        new QKeyValue(Token.NoToken, "basicblock", new List<object> { impl.Name, blk.Label }, null));
                });

            foreach (var blk in impl.Blocks)
            {
                blk.Cmds.Insert(0, blockstart(blk));
                if (blk.TransferCmd is ReturnCmd)
                    blk.Cmds.Add(end);
            }
            impl.Blocks[0].Cmds.Insert(0, beg);

            foreach (var loc in impl.LocVars)
            {
                loc.AddAttribute("originallocal",  impl.Name, loc.Name);
            }
            // for out params, the attributes need to go on the procedure decl
            foreach (var loc in impl.Proc.OutParams)
            {
                loc.AddAttribute("originallocal", impl.Name, loc.Name);
            }
        }

        /// <summary>
        /// The class that actually does the hard work of computing pairwiseBlockModSet
        /// </summary>
        private class IntraProcModSetComputerPerImpl
        {
            ControlFlowDependency parent;
            Implementation impl;
            HashSet<Tuple<Block, Block>> workList;
            Dictionary<Tuple<Block, Block>, HashSet<Variable>> intraProcPairBlockModSet;
            Dictionary<Block, HashSet<Block>> successorBlocks;
            HashSet<Tuple<Block, Block>> branchJoinPairs;
            public IntraProcModSetComputerPerImpl(ControlFlowDependency cfd, Implementation impl) 
            { 
                parent = cfd;
                this.impl = impl;
                workList = new HashSet<Tuple<Block, Block>>();
                intraProcPairBlockModSet = new Dictionary<Tuple<Block, Block>, HashSet<Variable>>();
                successorBlocks = new Dictionary<Block, HashSet<Block>>();
                branchJoinPairs = new HashSet<Tuple<Block, Block>>();
            }
            public void Run()
            {
                impl.Blocks.Iter
                    (b =>
                        {
                            successorBlocks[b] = new HashSet<Block>();
                            if (b.TransferCmd is GotoCmd)
                                ((GotoCmd)b.TransferCmd).labelTargets.ForEach(c => successorBlocks[b].Add(c));
                            if (b.TransferCmd is ReturnCmd)
                                successorBlocks[b].Add(null);
                        }
                    );
                //initialize the WL
                InitializeModSets();
                //run the fixed point
                ComputeTransitiveModSets();
                //find the (branch,join) pairs
                FindBranchJoinPairs();
                //populate the modsets for every branch/join pair
                parent.branchJoinPairModSet[impl.Name] = new HashSet<Tuple<Block,Block,HashSet<Variable>>>();
                branchJoinPairs.Iter(x => parent.branchJoinPairModSet[impl.Name].Add(Tuple.Create(x.Item1, x.Item2, intraProcPairBlockModSet[x])));
                Print();
            }
            /// <summary>
            /// For each branch node, finds the corresponding join node
            /// </summary>
            private void FindBranchJoinPairs()
            {
                impl.ComputePredecessorsForBlocks();
                var blockGraph = parent.prog.ProcessLoops(impl);
                //(branch node) n -> all nodes for which n is the immediate dominator (then, else, join-if-not-return)
                var immDomMap = blockGraph.ImmediateDominatorMap;
                #region Other dominator datastructures, not used
                //(branch node) n -> ??
                //var ctrlDep = blockGraph.ControlDependence();
                //(all node)    n -> all nodes (including itself) that (pre) dominates it from entry
                //var domMap = blockGraph.DominatorMap;
                #endregion


                //immPostDominates: (branch node) n -> earliest join node or return
                // - x = (immDom(n) \ {n.b1, n.b2, ..n.bn}) in 
                //   if (x == {}) then null //return 
                //   if (x == {m}) then m
                //   else DONT KNOW //goto A, B; B: s; goto A;  A: join; --> not allowed for deterministic branches                
                foreach(var map in immDomMap)
                {
                    var branchNode = map.Key;
                    Debug.Assert(branchNode.TransferCmd is GotoCmd,
                        "(Internal error) Expecting a branch node in the domain of ImmdiateDominatorMap from Boogie");
                    if (((GotoCmd)branchNode.TransferCmd).labelTargets.Count <= 1) continue; //not really a branch
                    Block joinNode = null; //by default return/null is the join node
                    foreach (var node in map.Value)
                    {
                        if (successorBlocks[branchNode].Contains(node)) continue;
                        Debug.Assert(joinNode == null, "Expecting at most one node in ImmediateDominatorMap that is not a branch target");
                        joinNode = node;
                    }
                    branchJoinPairs.Add(Tuple.Create(branchNode, joinNode));
                }
            }
            private void InitializeModSets()
            {
                var ModSetOfABlock = new Func<Block, HashSet<Variable>>(b =>
                {
                    var modVars = new HashSet<Variable>();
                    foreach (var cmd in b.Cmds)
                    {
                        if (cmd is AssignCmd)
                        {
                            var ac = cmd as AssignCmd;
                            ac.Lhss.ForEach(x => modVars.Add(x.DeepAssignedVariable));
                        }
                        if (cmd is HavocCmd)
                        {
                            var hc = cmd as HavocCmd;
                            hc.Vars.ForEach(x => modVars.Add(x.Decl));
                        }
                        if (cmd is CallCmd)
                        {
                            var cc = cmd as CallCmd;
                            cc.Outs.ForEach(x => modVars.Add(x.Decl));
                            cc.Proc.Modifies.ForEach(x => modVars.Add(x.Decl));
                        }
                    }
                    return modVars;
                });

                impl.Blocks.Iter
                    (b =>
                    {
                        HashSet<Variable> modBl = ModSetOfABlock(b);
                        successorBlocks[b].Iter(c =>
                                {
                                    workList.Add(Tuple.Create(b, c));
                                    intraProcPairBlockModSet[Tuple.Create(b, c)] = modBl;
                                }
                                );
                    }
                    );
            }
            private void ComputeTransitiveModSets()
            {
                var UpdateTransitiveEdge = new Action<Block, Block, Block>((b1, b2, b3) =>
                    {
                        var vs1 = intraProcPairBlockModSet[Tuple.Create(b1, b2)];
                        var vs2 = intraProcPairBlockModSet[Tuple.Create(b2, b3)];
                        HashSet<Variable> vs3;
                        var present = intraProcPairBlockModSet.TryGetValue(Tuple.Create(b1, b3), out vs3);
                        if (!present) vs3 = new HashSet<Variable>();
                        var newvs = new HashSet<Variable>();
                        vs1.Union(vs2.Union(vs3)).Iter(x => newvs.Add(x));
                        if (!present || newvs.Count > vs3.Count) //add if previously not present or weight has changed
                        {
                            intraProcPairBlockModSet[Tuple.Create(b1, b3)] = newvs;
                            if (!workList.Contains(Tuple.Create(b1, b3))) workList.Add(Tuple.Create(b1, b3));
                        }
                    }
                    );

                while(workList.Count() > 0)
                {
                    var blkPair = workList.ElementAt(0);
                    workList.Remove(blkPair);
                    var start = blkPair.Item1;
                    var end = blkPair.Item2;
                    foreach (var succ in successorBlocks)
                    {
                        if (succ.Value.Contains(start))
                            UpdateTransitiveEdge(succ.Key, start, end);
                        if (succ.Key == end)
                            succ.Value.Iter(d => UpdateTransitiveEdge(start, end, d));
                    }
                }
            }
            private void Print()
            {
                var printReturnNode = new Func<Block, string>(x => x != null ? x.ToString() : "returnNode");
                var printModSetBtwn = new Func<Tuple<Block,Block>, string> (x =>
                    string.Format("Modified Variables ({0}, {1}) ==> {2}",
                            x.Item1.ToString(), printReturnNode(x.Item2),
                            string.Join(",", intraProcPairBlockModSet[x])
                            ));

                Console.WriteLine("\n#### CONTROL FLOW DEPENDENCY STATIC ANALYSIS#####\n");
                Console.WriteLine("---- Implementation  {0} ------", impl.Name);
                intraProcPairBlockModSet
                    .Keys
                    .Iter(x => Console.WriteLine(printModSetBtwn(x)));
                Console.WriteLine("--- Branch/Join pairs and their modsets ---\n\n{0}\n\n",
                    string.Join("\n", branchJoinPairs.Select(x => printModSetBtwn(x))));
            }
        }

        internal bool IsJoinBlock(Tuple<string, string> blockInfo, out string branchBlockName, out HashSet<string> modSet)
        {
            branchBlockName = null;
            modSet = null;
            var matches = 
                branchJoinPairModSet[blockInfo.Item1]
                .Where(x => (x.Item2 == null && blockInfo.Item2 == null) || (x.Item2.ToString() == blockInfo.Item2));
            if (matches.Count() > 0)
            {
                branchBlockName = matches.First().Item1.ToString();
                var tmpSet = new HashSet<string>();
                matches.First().Item3.Select(x => x.ToString()).Iter(y => tmpSet.Add(y));
                modSet = tmpSet;
                return true;
            }
            return false; 
        }

        internal bool IsBranchBlock(Tuple<string, string> blockInfo)
        {
            return branchJoinPairModSet[blockInfo.Item1].Where(x => x.Item1.ToString() == blockInfo.Item2).Count() == 1;
        }
    }
}
