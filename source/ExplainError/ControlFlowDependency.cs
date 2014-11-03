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

namespace ExplainError
{
    /// <summary>
    /// Calculates the set of variables modified inside the two branches of a conditional block
    /// </summary>
    public class ControlFlowDependency
    {
        Program prog;
        //a null block indicates returnBlock
        Dictionary<Tuple<Implementation, Block, Block>, HashSet<Variable>> pairBlockModSet; //modset between a pair of reachable blocks in a procedure
        public ControlFlowDependency(Program prog)
        {
            this.prog = prog;
        }
        public void Run()
        {
            //perform interprocedural modset analysis
            (new ModSetCollector()).DoModSetAnalysis(prog);
            prog.Implementations.Iter(impl => (new IntraProcModSetComputerPerImpl(this, impl)).Run());
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
            public IntraProcModSetComputerPerImpl(ControlFlowDependency cfd, Implementation impl) 
            { 
                parent = cfd;
                this.impl = impl;
                workList = new HashSet<Tuple<Block, Block>>();
                intraProcPairBlockModSet = new Dictionary<Tuple<Block, Block>, HashSet<Variable>>();
                successorBlocks = new Dictionary<Block, HashSet<Block>>();
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
                Print();
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
                        if (newvs.Count > vs3.Count)
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
                Console.WriteLine("---- Implementation  {0} ------", impl.Name);
                intraProcPairBlockModSet
                    .Keys
                    .Iter(x =>
                    {
                        Console.WriteLine("ModBtwn({0}, {1}) ==> {2}",
                            x.Item1.Label, x.Item2 != null? x.Item2.Label: "return",
                            string.Join(",", intraProcPairBlockModSet[x])
                            );
                    });
            }
        }

        /// <summary>
        /// Computes the set of (branch,join) blocks for a program
        /// </summary>
        private class BranchJoinComputer
        {

        }
    }
}
