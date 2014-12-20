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
        Dictionary<string, HashSet<Tuple<string,string,HashSet<Variable>>>> branchJoinPairModSet;
        bool coarseProcedureLevelOnly; //if this flag is on, only consider branch/join as beginproc/endproc for a procedure with entire modset
        public ControlFlowDependency(Program prog, bool coarseProcedureLevelOnly=false)
        {
            this.prog = prog;
            branchJoinPairModSet = new Dictionary<string,HashSet<Tuple<string,string,HashSet<Variable>>>>();
            this.coarseProcedureLevelOnly = coarseProcedureLevelOnly;
        }
        public void Run()
        {
            //perform interprocedural modset analysis
            (new ModSetCollector()).DoModSetAnalysis(prog);
            prog.Implementations.Iter(impl => (new SplitBranchBlocks(impl)).Run());
            prog.Implementations.Iter(impl => (new IntraProcModSetComputerPerImpl(this, impl)).Run());
            // Add place holders
            prog.TopLevelDeclarations.OfType<Implementation>()
                .Iter(InstrumentImplementation);
        }

        /// <summary>
        /// We need to split a block {B: ... goto B1, B2;} into {B: ...; goto B';} and {B': goto B1, B2;}
        /// </summary>
        private class SplitBranchBlocks
        {
            Implementation impl;
            public SplitBranchBlocks(Implementation impl) { this.impl = impl; }
            public void Run()
            {
                var newBlks = new HashSet<Block>();
                foreach(var blk in impl.Blocks)
                {
                    var gotoCmd = blk.TransferCmd as GotoCmd;
                    if (gotoCmd == null) continue;
                    if (gotoCmd.labelTargets.Count < 2) continue; //not a branch node
                    if (blk.Cmds.Count == 0) continue; //no command
                    var b = new Block(Token.NoToken, "__split__xxx_" + blk.Label, new List<Cmd>(), blk.TransferCmd);
                    blk.TransferCmd = new GotoCmd(Token.NoToken, new List<Block>() { b });
                    newBlks.Add(b);
                }
                impl.Blocks.AddRange(newBlks);
            }
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
            Stopwatch sw;
            int TIME_PER_IMPL = 5; //max per implementation
            public IntraProcModSetComputerPerImpl(ControlFlowDependency cfd, Implementation impl) 
            { 
                parent = cfd;
                this.impl = impl;
                workList = new HashSet<Tuple<Block, Block>>();
                intraProcPairBlockModSet = new Dictionary<Tuple<Block, Block>, HashSet<Variable>>();
                successorBlocks = new Dictionary<Block, HashSet<Block>>();
                branchJoinPairs = new HashSet<Tuple<Block, Block>>();
                sw = new Stopwatch();
            }
            public void Run()
            {
                sw.Restart();
                //populate the modsets for every branch/join pair
                parent.branchJoinPairModSet[impl.Name] = new HashSet<Tuple<string, string, HashSet<Variable>>>();
                if (!parent.coarseProcedureLevelOnly)
                {
                    try
                    {
                        PerformFineGrainedControlDependency();
                    } catch(TimeoutException e)
                    {
                        Console.WriteLine(e.Message);
                        parent.branchJoinPairModSet[impl.Name].Clear(); //remove any partial computation
                    }
                }
                //only add the procedure level modset (currently undoing all the work of block/join)
                var modsetImpl = new HashSet<Variable> (impl.Proc.Modifies.Select(x => x.Decl).Union(impl.Proc.OutParams));
                parent.branchJoinPairModSet[impl.Name]
                    .Add(Tuple.Create("beginproc", "endproc", modsetImpl));
                //Print();
            }
            private void PerformFineGrainedControlDependency()
            {
                Console.WriteLine("Entered PerformFineGrained for {0}", impl.Name);
                //Perform fine grained block level analysis
                impl.Blocks.Iter
                    (b =>
                    {
                        successorBlocks[b] = new HashSet<Block>();
                        if (b.TransferCmd is GotoCmd)
                            ((GotoCmd)b.TransferCmd).labelTargets.ForEach(c => successorBlocks[b].Add(c));
                        //if (b.TransferCmd is ReturnCmd)
                        //    successorBlocks[b].Add(null);
                    }
                    );
                //initialize the WL
                InitializeModSets();
                //run the fixed point
                Console.WriteLine("Before Transitivemodsets");
                ComputeTransitiveModSets();
                Console.WriteLine("After Transitivemodsets");
                //find the (branch,join) pairs
                FindBranchJoinPairs();
                Console.WriteLine("After FindBranchJoinPairs");
                branchJoinPairs
                    .Iter(x => parent.branchJoinPairModSet[impl.Name]
                        .Add(Tuple.Create(x.Item1.ToString(), ReturnNodeString(x.Item2),
                        intraProcPairBlockModSet[x])));
                Console.WriteLine("Exit from PerformFineGrained");
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
                HashSet<Block> allJoinNodes = new HashSet<Block>();
                foreach(var map in immDomMap)
                {
                    var branchNode = map.Key;
                    Debug.Assert(branchNode.TransferCmd is GotoCmd,
                        "(Internal error) Expecting a branch node in the domain of ImmdiateDominatorMap from Boogie");
                    if (((GotoCmd)branchNode.TransferCmd).labelTargets.Count <= 1) continue; //not really a branch
                    HashSet<Block> joinNodes = new HashSet<Block>(); //by default return/null is the join node
                    foreach (var node in map.Value)
                    {
                        if (node == null) continue; 
                        if (successorBlocks[branchNode].Contains(node)) continue; //remove the successor nodes
                        joinNodes.Add(node);
                        Debug.Assert(!allJoinNodes.Contains(node), string.Format("ERROR!! Multiple branch nodes for the same join node {0} in {1}", node, impl.Name));
                        allJoinNodes.Add(node);
                    }
                    if (joinNodes.Count > 1)
                        Console.WriteLine("WARNING!! Unstructured control flow: Multiple joins from a branch in proc {0} branch {1} joins {2}",
                            impl.Name, branchNode,
                            string.Join(",", joinNodes));
                    joinNodes.Iter(j => branchJoinPairs.Add(Tuple.Create(branchNode, j)));
                }
                //TODO: remove all entries (b1,n), (b2,n), (b3, n) .. with the same join node
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
                        CheckTimeout();
                        Debug.Assert(b1 != null && b2 != null && b3 != null);
                        var vs1 = intraProcPairBlockModSet[Tuple.Create(b1, b2)];
                        var vs2 = intraProcPairBlockModSet[Tuple.Create(b2, b3)];
                        int prevCount = 0; 
                        var b1b3 = Tuple.Create(b1,b3);
                        if (intraProcPairBlockModSet.ContainsKey(b1b3))
                            prevCount = intraProcPairBlockModSet[b1b3].Count;
                        else
                            intraProcPairBlockModSet[b1b3] = new HashSet<Variable>();
                        var newvs = new HashSet<Variable>();
                        vs1.Union(vs2.Union(intraProcPairBlockModSet[b1b3])).Iter(x => newvs.Add(x));
                        if (newvs.Count > prevCount) //add if previously not present or weight has changed
                        {
                            newvs.Iter(x => intraProcPairBlockModSet[b1b3].Add(x));
                            if (!workList.Contains(b1b3)) workList.Add(b1b3);
                        }
                    }
                    );

                int i = 1;
                //hash the lookups
                Dictionary<Block, HashSet<Block>> predStart = new Dictionary<Block, HashSet<Block>>();
                Dictionary<Block, HashSet<Block>> succEnd = new Dictionary<Block, HashSet<Block>>();
                int skippedCount = 0;
                while(workList.Count() > 0)
                {
                    var blkPair = workList.ElementAt(0);
                    workList.Remove(blkPair);
                    var start = blkPair.Item1;
                    var end = blkPair.Item2;
                    bool addPredStart = false, addSuccEnd = false;
                    //check if we have already seen this pair or not
                    if (!predStart.ContainsKey(start)) { addPredStart = true; predStart[start] = new HashSet<Block>(); }
                    if (!succEnd.ContainsKey(end)) { addSuccEnd = true; succEnd[end] = new HashSet<Block>(); }
                    if (addPredStart || addSuccEnd)
                    {
                        foreach (var succ in successorBlocks)
                        {
                            //succ->start + start->end --> succ->end
                            if (succ.Value.Contains(start) && addPredStart)
                                predStart[start].Add(succ.Key);
                                //UpdateTransitiveEdge(succ.Key, start, end); //update them later now
                            //start->end + end->d      --> start->d
                            if (succ.Key == end && addSuccEnd)
                                succ.Value.Iter(d => succEnd[end].Add(d));
                                //succ.Value.Iter(d => UpdateTransitiveEdge(start, end, d)); //update them later
                        }
                    } else
                    {
                        skippedCount++;
                    }
                    predStart[start].Iter(x => UpdateTransitiveEdge(x, start, end));
                    succEnd[end].Iter(x => UpdateTransitiveEdge(start, end, x));
                    i++;
                    if ((i % 10000) == 0)
                        Console.Write("i = {0}, |intraProcModSet| = {1}",i, intraProcPairBlockModSet.Count);
                }
                Console.WriteLine("|WL| = {0}, |succBlocks| = {1}, SkippedCount = {2}", i, successorBlocks.Count, skippedCount);
            }
            private string ReturnNodeString(Block x)
            {
                return x != null ? x.ToString() : "returnNode"; 
            }
            private void CheckTimeout()
            {
                if (sw.ElapsedMilliseconds > TIME_PER_IMPL * 1000)
                    throw new TimeoutException("PerformFineGrainedControlDependency timed out in [" + impl.Name + "]" + sw.ElapsedMilliseconds/1000 + "sec");
            }

            private void Print()
            {
                var printModSetBtwn = new Func<Tuple<Block,Block>, string> (x =>
                    string.Format("Modified Variables ({0}, {1}) ==> {2}",
                            x.Item1.ToString(), ReturnNodeString(x.Item2),
                            string.Join(",", intraProcPairBlockModSet[x])
                            ));

                Console.WriteLine("\n#### CONTROL FLOW DEPENDENCY STATIC ANALYSIS#####\n");
                Console.WriteLine("---- Implementation  {0} ------", impl.Name);
                //intraProcPairBlockModSet
                //    .Keys
                //    .Iter(x => Console.WriteLine(printModSetBtwn(x)));
                //Console.WriteLine("--- Branch/Join pairs and their modsets ---\n\n{0}\n\n",
                //    string.Join("\n", branchJoinPairs.Select(x => printModSetBtwn(x))));
                Console.WriteLine("---Branch/Join pairs and modsets ---\n\n{0}\n\n",
                    string.Join("\n", 
                    parent.branchJoinPairModSet[impl.Name].Select(x => 
                    string.Format("{0} {1} => {2}", x.Item1, x.Item2, string.Join(",", x.Item3)))));
            }
        }

        internal bool IsJoinBlock(Tuple<string, string> blockInfo, out string branchBlockName, out HashSet<string> modSet)
        {
            if (branchJoinPairModSet.ContainsKey(blockInfo.Item1) && blockInfo.Item2 == "endproc")
            {
                branchBlockName = "beginproc";
                modSet = new HashSet<string>(
                    branchJoinPairModSet[blockInfo.Item1]
                    .Where(x => x.Item1 == "beginproc" && x.Item2 == "endproc")
                    .First()
                    .Item3.Select(y => y.ToString()));
                return true;
            }

            branchBlockName = null;
            modSet = null;
            var matches = 
                branchJoinPairModSet[blockInfo.Item1]
                .Where(x => /*(x.Item2 == null && blockInfo.Item2 == null) ||*/ (x.Item2 != null && x.Item2.ToString() == blockInfo.Item2));
            if (matches.Count() > 0)
            {
                Debug.Assert(matches.Count() == 1, 
                    string.Format("Expecting exactly 1 branch for a join node {0}, found {1}", blockInfo.Item1,
                    string.Join(",", matches.Select(x => x.Item1))));
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
            //a beginproc is always a branch node when we want to consider procedure level mods only
            if (branchJoinPairModSet.ContainsKey(blockInfo.Item1) && blockInfo.Item2 == "beginproc") return true; 
            //we can have same branch for different joins (b1,j1) and (b1,j2)
            return branchJoinPairModSet[blockInfo.Item1].Where(x => x.Item1.ToString() == blockInfo.Item2).Count() >= 1;
        }
    }
}
