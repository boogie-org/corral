using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    // Compresses basic blocks. This is a destructive operation.
    // If there are two basic blocks b1 and b2, such that the only successor of b1 
    // is b2 and the only predecessor of b2 is b1, then merge the blocks into a single
    // block.
    // Note: one needs to re-resolve a program after this transformation. The
    // reason is that Block.labelTargets needs to be recomputed
    public class CompressBlocks
    {
        Dictionary<string, Block> locationBlockMap;
        Dictionary<string, HashSet<string>> succBlocks;
        Dictionary<string, HashSet<string>> predBlocks;
        HashSet<string> deletedBlocks;
        string startingLabel;

        // Stores how the blocks have been merged.
        Dictionary<string, MergingInfo> tinfo;

        public CompressBlocks() {
            locationBlockMap = new Dictionary<string, Block>();
            succBlocks = new Dictionary<string, HashSet<string>>();
            predBlocks = new Dictionary<string, HashSet<string>>();
            deletedBlocks = new HashSet<string>();
            startingLabel = "";
            tinfo = new Dictionary<string, MergingInfo>();
        }

        private void clear()
        {
            locationBlockMap.Clear();
            succBlocks.Clear();
            predBlocks.Clear();
            deletedBlocks.Clear();
            startingLabel = "";
        }

        public void VisitProgram(Program prog)
        {
            foreach (var decl in prog.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    VisitImplementation(decl as Implementation);
                }
            }
        }

        public void VisitImplementation(Implementation node)
        {
            List<Block> blocks = node.Blocks;
            
            clear();
            tinfo.Add(node.Name, new MergingInfo());

            startingLabel = blocks[0].Label;

            // Construct a map from labels to blocks and also the set of 
            // predecessors and successors
            foreach (Block b in blocks)
            {
                locationBlockMap.Add(b.Label, b);
                if (b.TransferCmd is GotoCmd)
                {
                    var gt = b.TransferCmd as GotoCmd;
                    foreach (string lab in gt.labelNames)
                    {
                        addEdges(b.Label, lab);
                    }
                }
            }

            // The new set of blocks
            var newBlocks = new List<Block>();

            // Now, go through the list of blocks.
            // For each block b, if it has in-degree 1, go backwards if pred
            // has out-degree 1. Repeat (making sure that the original block is not repeated).
            // Then go forward to collect all the blocks that can be merged.
            // Merge the blocks, and delete all but the first block.
            foreach (Block b in blocks)
            {
                if (isDeleted(b)) continue;

                var start = goBackwards(b);
                var curr = start;
                tinfo[node.Name].Add(start.Label, new List<Duple<string, int>>());

                List<Cmd> newCmds = new List<Cmd>();
                TransferCmd newtc = null;

                do
                {
                    deletedBlocks.Add(curr.Label);

                    newCmds.AddRange(curr.Cmds);
                    tinfo[node.Name][start.Label].Add(new Duple<string, int>(curr.Label, curr.Cmds.Count));

                    if (hasOneSucc(curr))
                    {
                        var temp = locationBlockMap[succBlocks[curr.Label].ElementAt(0)];
                        if (hasOnePred(temp))
                        {
                            curr = temp;
                        }
                        else
                        {
                            break;
                        }
                    }
                    else
                    {
                        break;
                    }
                } while (true);

                newtc = curr.TransferCmd;
                start.Cmds = newCmds;
                start.TransferCmd = newtc;

                newBlocks.Add(start);
            }

            // assert that the starting block hasn't changed
            Debug.Assert(newBlocks[0].Label == blocks[0].Label);
            node.Blocks = newBlocks;
            node.OriginalBlocks = null;
        }

        private void addEdges(string src, string tgt)
        {
            HashSet<string> val = null;
            if (succBlocks.TryGetValue(src, out val))
            {
                val.Add(tgt);
            }
            else
            {
                val = new HashSet<string>();
                val.Add(tgt);
                succBlocks.Add(src, val);
            }

            val = null;
            if (predBlocks.TryGetValue(tgt, out val))
            {
                val.Add(src);
            }
            else
            {
                val = new HashSet<string>();
                val.Add(src);
                predBlocks.Add(tgt, val);
            }


        }

        private bool isDeleted(Block block)
        {
            return isDeleted(block.Label);
        }

        private bool isDeleted(string label)
        {
            return deletedBlocks.Contains(label);
        }

        private bool hasOnePred(Block block)
        {
            return hasOnePred(block.Label);
        }

        private bool hasOnePred(string label)
        {
            if (label == startingLabel) return false;
            HashSet<string> val = null;
            if (predBlocks.TryGetValue(label, out val))
            {
                return val.Count == 1;
            }
            return false;
        }

        private bool hasOneSucc(Block block)
        {
            return hasOneSucc(block.Label);
        }

        private bool hasOneSucc(string label)
        {
            HashSet<string> val = null;
            if (succBlocks.TryGetValue(label, out val))
            {
                return val.Count == 1;
            }
            return false;
        }

        // For each block b, if it has in-degree 1, go backwards if pred
        // has out-degree 1. Repeat (making sure that the original block is not repeated).
        private Block goBackwards(Block block)
        {
            // The starting block is assumed to have in-degree 2
            if (block.Label == startingLabel)
            {
                return block;
            }

            string orig = block.Label;
            string curr = orig;

            do
            {
                Debug.Assert(curr != startingLabel);

                if (hasOnePred(curr))
                {
                    string temp = predBlocks[curr].ElementAt(0);
                    if (hasOneSucc(temp))
                    {
                        curr = temp;
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    break;
                }

                if (curr == orig || curr == startingLabel || isDeleted(locationBlockMap[curr]))
                    break;

            } while (true);

            return locationBlockMap[curr];
        }

        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            Debug.Assert(tinfo.ContainsKey(trace.procName));

            var ret = new ErrorTrace(trace.procName);
            var info = tinfo[trace.procName];

            foreach (var blk in trace.Blocks)
            {
                var peices = info[blk.blockName];
                Debug.Assert(peices.Count != 0);

                // This is an index into blk.Cmds
                var cnt = 0;
                var done = false;
                var lastInf = blk.info;

                for (int i = 0; !done && i < peices.Count; i++)
                {
                    // Do we have enough in blk.Cmds for peices[i]?
                    if (cnt + peices[i].snd - 1 >= blk.Cmds.Count)
                    {
                        done = true;
                    }

                    var eblk = new ErrorTraceBlock(peices[i].fst);
                    eblk.info = lastInf;

                    int j = 0;
                    while (j < peices[i].snd && cnt < blk.Cmds.Count)
                    {
                        var inst = blk.Cmds[cnt];
                        lastInf = inst.info;
                        if (inst is CallInstr)
                        {
                            var cinst = inst as CallInstr;
                            if (cinst.hasCalledTrace)
                            {
                                inst = new CallInstr(cinst.callee, mapBackTrace(cinst.calleeTrace), cinst.asyncCall, cinst.info);
                                if (!(inst as CallInstr).calleeTrace.returns)
                                    done = true;
                            }
                        }

                        eblk.addInstr(inst);
                        cnt++;
                        j++;
                    }
                    ret.addBlock(eblk);
                }
            }
            if (trace.returns)
            {
                ret.addReturn();
            }
            return ret;
        }
    }

    // Stores how blocks were merged in a procedure
    public class MergingInfo : Dictionary<string, List<Duple<string, int>>>
    {
    }

}
