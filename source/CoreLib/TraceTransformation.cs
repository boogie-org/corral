using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Microsoft.Boogie;
using cba.Util;

namespace cba
{
    public enum InstrTypeEnum { CALL, ASYNC, INTRA };

    public class InstrType
    {
        public InstrTypeEnum type;
        public string callee;

        public InstrType(InstrTypeEnum type, string callee)
        {
            this.type = type;
            this.callee = callee;
            Debug.Assert(type == InstrTypeEnum.INTRA || callee != null);
        }

        public InstrType()
        {
            this.type = InstrTypeEnum.INTRA;
            this.callee = null;
        }
    }

    /*
    // A generic interface to a class that stores how program transformation
    // was carried out
    public abstract class ProgramTrans
    {
        // A map from src Cmd to dest Cmds
        protected Dictionary<Cmd, List<Cmd>> srcDestMap;

        // The set of all Cmds in Dest
        HashSet<Cmd> allDestCmds;

        // A duplicator for making copies of Cmds
        FixedDuplicator dup;

        // Have all the transformations been processed -- can only be done once
        bool processed;

        public ProgramTrans()
        {
            srcDestMap = new Dictionary<Cmd, List<Cmd>>();
            allDestCmds = new HashSet<Cmd>();
            dup = new FixedDuplicator(true);
            processed = false;
        }

        // Store a program transformation. It makes sure that
        // all Cmd in dest are unaliased to anything before
        // inserted into the destination program
        public void addTrans(Cmd src, ref List<Cmd> dest)
        {
            // Make dest unaliased
            for (int i = 0; i < dest.Length; i++)
            {
                if (allDestCmds.Contains(dest[i]))
                {
                    dest[i] = dup.Visit(dest[i]);
                }
            }

            Debug.Assert(!srcDestMap.ContainsKey(src));

            srcDestMap.Add(src, dest);
        }

        public ErrorTrace reverseTrans(ErrorTrace trace)
        {
            Debug.Assert(processed);
            return mapBackTrace(trace);
        }

        abstract public ErrorTrace mapBackTrace(ErrorTrace trace);

        // Does some pre-processing, given the final dest program
        // This procedure should set "processed" to true.
        abstract public void processAllTrans(Program dest);
    }
    */

    // This class is used to store information as to how a program
    // was transformed. It essentially stores a map:
    //   instruction -> number of instructions it is transformed to
    // This is useful only when the transformation acts on a per
    // instruction basis, and does not modify the control flow at all.
    public class ModifyTrans /* : ProgramTrans */
    {
        private Dictionary<Duple<string, string>, BlockTrans> dict;

        public ModifyTrans()
        {
            dict = new Dictionary<Duple<string, string>, BlockTrans>();
        }

        public void add(string procName, string blockName, InstrTrans itrans)
        {
            var key = new Duple<string, string>(procName, blockName);
            if (!dict.ContainsKey(key))
            {
                dict.Add(key, new BlockTrans());
            }
            dict[key].addInstrTrans(itrans);
        }

        public void setIdentity(string procName, string blockName, List<Cmd> cmds)
        {
            var key = new Duple<string, string>(procName, blockName);
            if (dict.ContainsKey(key))
            {
                dict.Add(key, new BlockTrans());
            }
            dict[key].setIdentity(cmds);
        }

        public int getNumTrans(string procName, string blockName)
        {
            var bt = getBlockTrans(procName, blockName);
            if (bt == null)
                return 0;
            return bt.getNumTrans();
        }

        private BlockTrans getBlockTrans(string procName, string blockName)
        {
            var key = new Duple<string, string>(procName, blockName);
            if (dict.ContainsKey(key))
            {
                return dict[key];
            }
            else
            {
                return null;
            }
        }

        // map back "trace" through this transformation
        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            var ret = new ErrorTrace(trace.procName);
            foreach (var blk in trace.Blocks)
            {
                var blkTrans = getBlockTrans(trace.procName, blk.blockName);
                if (blkTrans == null)
                {
                    // We don't have a transformation for this block: means identity
                    // We just have to recurse on the callee traces and copy the rest.
                    ret.addBlock(BlockTrans.mapBackTraceIdentity(blk, this));
                }
                else
                {
                    ret.addBlock(blkTrans.mapBackTrace(blk, this));
                }
            }
            if (trace.returns)
            {
                ret.addReturn(trace.raisesException);
            }

            return ret;
        }
    }

    public class BlockTrans
    {
        private List<InstrTrans> trans;

        public BlockTrans()
        {
            trans = new List<InstrTrans>();
        }

        public void addInstrTrans(InstrTrans n)
        {
            trans.Add(n);
        }

        // set to the identity transformation
        public void setIdentity(List<Cmd> cmds)
        {
            trans.Clear();
            foreach (Cmd c in cmds)
            {
                InstrTrans it = new InstrTrans(c, c);
                trans.Add(it);
            }
        }

        public int getNumTrans()
        {
            return trans.Count;
        }

        // map back through an identity transformation (basically just recurse
        // on the callee traces)
        public static ErrorTraceBlock mapBackTraceIdentity(ErrorTraceBlock tblock, ModifyTrans tinfo)
        {
            var ret = new ErrorTraceBlock(tblock.blockName);
            ret.info = tblock.info;

            for(int i=0;i<tblock.Cmds.Count;i++)
            {
                var tp = new InstrType();
                if (tblock.Cmds[i] is CallInstr)
                {
                    var ci = tblock.Cmds[i] as CallInstr;
                    if (ci.asyncCall)
                    {
                        tp = new InstrType(InstrTypeEnum.ASYNC, ci.callee);
                    }
                    else
                    {
                        tp = new InstrType(InstrTypeEnum.CALL, ci.callee);
                    }
                }
                
                var it = new InstrTrans(tp);
                ret.addInstr(it.mapBackTrace(tblock.Cmds, i, tinfo));
            }

            return ret;
            
        }

        // map back "trace" through this transformation. tinfo is the parent
        // transformation info for the whole program -- it is used for recursively
        // calling the mapBack procedure on callee traces
        public ErrorTraceBlock mapBackTrace(ErrorTraceBlock tblock, ModifyTrans tinfo)
        {
            var ret = new ErrorTraceBlock(tblock.blockName);
            ret.info = tblock.info;

            // This is the number of instructions in tblock that we've processed
            int count = 0;
            // This is an index into trans
            int trans_index = 0;

            while (trans_index < trans.Count)
            {
                var it = trans[trans_index];

                // Does tblock have enough instructions for this transformation to apply?
                if (count + it.Size > tblock.Cmds.Count)
                    break;

                var inst = it.mapBackTrace(tblock.Cmds, count, tinfo);
                ret.addInstr(inst);
                
                // Are we done?
                if(inst is CallInstr && (inst as CallInstr).calleeTrace != null && (
                    !(inst as CallInstr).calleeTrace.returns || (
                       (inst as CallInstr).calleeTrace.raisesException && !(inst as CallInstr).asyncCall
                    )
                   ))
                    break;

                count += it.Size;
                trans_index++;
            }

            return ret;
        }
    }

    // How a single instruction was transformed
    public class InstrTrans
    {
        private InstrType from;
        private List<InstrType> to;

        // This is the instruction in "to" that "from" directly
        // corresponds to. It is used to borrow over InstrInfo.
        // (-1) means none.
        private int correspondingInstr;

        public int Size
        {
            get
            {
                return to.Count;
            }
        }

        public InstrTrans(Cmd _from, List<Cmd> _to, int ci)
        {
            initialize(_from, _to, ci);
        }

        public InstrTrans(Cmd _from, List<Cmd> _to)
        {
            initialize(_from, _to, -1);
        }

        public InstrTrans(Cmd _from, Cmd _to)
        {
            var temp = new List<Cmd>();
            temp.Add(_to);
            initialize(_from, temp, 0);
        }

        public InstrTrans(InstrType _from)
        {
            from = _from;
            to = new List<InstrType>();
            to.Add(from);
            correspondingInstr = 0;
        }

        private void initialize(Cmd _from, List<Cmd> _to, int ci) 
        {
            to = new List<InstrType>();
            correspondingInstr = ci;
            from = getType(_from);

            foreach (Cmd c in _to)
            {
                to.Add(getType(c));
            }

            // Must give the corresponding instruction for a
            // call instruction (unless "to" is empty)
            if (from.type == InstrTypeEnum.CALL || from.type == InstrTypeEnum.ASYNC)
            {
                if (correspondingInstr < 0)
                {
                    // If there is exactly one call instruction in "to"
                    // then that is the one we pick by default
                    for (int i = 0; i < to.Count; i++)
                    {
                        if (to[i].type == InstrTypeEnum.CALL || to[i].type == InstrTypeEnum.ASYNC)
                        {
                            Debug.Assert(correspondingInstr < 0);
                            correspondingInstr = i;
                        }
                    }
                }

                Debug.Assert((to.Count > 0) ? correspondingInstr >= 0 : true);
            }

            Debug.Assert(correspondingInstr < to.Count);
        }

        private InstrType getType(Cmd c)
        {
            if (c is CallCmd)
            {
                var cc = c as CallCmd;
                if (cc.IsAsync)
                {
                    return new InstrType(InstrTypeEnum.ASYNC, cc.callee);
                }
                else
                {
                    return new InstrType(InstrTypeEnum.CALL, cc.callee);
                }
            }
            else
            {
                return new InstrType();
            }
        }

        // map back "trace[start, start + to.size - 1]" through this transformation.
        //
        // tinfo is the parent
        // transformation info for the whole program -- it is used for recursively
        // calling the mapBack procedure on callee traces
        public ErrorTraceInstr mapBackTrace(List<ErrorTraceInstr> trace, int start, ModifyTrans tinfo)
        {
            Debug.Assert(start >= 0);
            Debug.Assert(start + to.Count - 1 < trace.Count);

            // Find the "info" for "from". It is obtained from the 
            // corresponding instruction, if one is provided. Else
            // we search through "to" to find (any) valid info.
            InstrInfo info = null;
            if (correspondingInstr >= 0)
            {
                info = trace[start + correspondingInstr].info;
            }
            else
            {
                // Default info (invalid)
                info = new InstrInfo();
                for (int i = start; i < start + to.Count; i++)
                {
                    if (trace[i].info.isValid)
                    {
                        info = trace[i].info;
                        break;
                    }
                }
            }

            Debug.Assert(info != null);

            ErrorTraceInstr ret = null;

            if (from.type == InstrTypeEnum.CALL || from.type == InstrTypeEnum.ASYNC)
            {
                // check if the corresponding instruction is also a call
                if (correspondingInstr >= 0 && trace[start + correspondingInstr].isCall())
                {
                    var calleeTrace = (trace[start + correspondingInstr] as CallInstr).calleeTrace;
                    if (calleeTrace != null)
                    {
                        // Recurse on the callee trace
                        calleeTrace = tinfo.mapBackTrace(calleeTrace);
                    }

                    ret = new CallInstr(from.callee, calleeTrace, (from.type == InstrTypeEnum.ASYNC ? true : false), info);
                }
                else
                {
                    // no corresponding callee trace
                    ret = new CallInstr(from.callee, null, (from.type == InstrTypeEnum.ASYNC ? true : false), info);
                }
            }
            else
            {
                ret = new IntraInstr(info);
            }
            Debug.Assert(ret != null);

            return ret;
        }

    }

    // This stores the program transformation performed, where only insertions
    // were performed. Thus, every instruction in the output corresponds to at most
    // one instruction. Moreover, every instruction in input corresponds to at least one
    // instruction in the output. 
    // This does not assume that basic blocks are preserved, but it
    // does assume that procedures are preserved, i.e., corresponding instructions belong
    // to the same procedure (but maybe not the same block)
    //
    // The mapBack procedure of this class works by walking over the "dest" trace and
    // for each instruction that corresponds to one in the source, maps it to that 
    // instruction. This works fine, except when the source has empty basic blocks
    // (because control instructions are not stored in the trace). Extra mapping information
    // between corresponding blocks is maintained for this purpose.
    //
    // TODO: Merge this class with ModifyTrans to expose a common interface
    public class InsertionTrans
    {
        private Dictionary<string, InsertionTransProc> dict;
        // dest proc name -> src proc name
        public Dictionary<string, string> procNameMap;
        // src proc name -> set of dest proc names
        public Dictionary<string, HashSet<string>> invProcNameMap;

        public InsertionTrans()
        {
            dict = new Dictionary<string, InsertionTransProc>();
            procNameMap = new Dictionary<string, string>();
            invProcNameMap = new Dictionary<string, HashSet<string>>();
        }

        public void addTrans(string procName,
            string fromBlock, int fromNum, Cmd from,
            string toBlock, int toNum, List<Cmd> to)
        {
            Debug.Assert(to.Count == 1);

            if (!dict.ContainsKey(procName))
            {
                dict.Add(procName, new InsertionTransProc());
            }

            dict[procName].addTrans(new InstrLocation(fromBlock, fromNum, from), new InstrLocation(toBlock, toNum, to[0]));
        }

        // fromBlock <--> toBlock are correlated in the transformation.
        // Note that this mapping must be bijective
        public void addTrans(string procName, string fromBlock, string toBlock)
        {
            if (!dict.ContainsKey(procName))
            {
                dict.Add(procName, new InsertionTransProc());
            }

            dict[procName].addTrans(fromBlock, toBlock);
        }

        public void addProcNameTrans(string srcName, string destName)
        {
            if (procNameMap.ContainsKey(destName))
            {
                Debug.Assert(procNameMap[destName] == srcName);
            }
            else
            {
                procNameMap.Add(destName, srcName);

                if (!invProcNameMap.ContainsKey(srcName))
                {
                    invProcNameMap.Add(srcName, new HashSet<string>());
                }
                invProcNameMap[srcName].Add(destName);
            }
        }

        public string getSrcProcName(string destName)
        {
            if (!procNameMap.ContainsKey(destName))
            {
                return destName;
            }

            return procNameMap[destName];
        }

        public HashSet<string> getDestProcNames(string srcName)
        {
            if (!invProcNameMap.ContainsKey(srcName))
            {
                HashSet<string> t = new HashSet<string>();
                t.Add(srcName);
                return t;
            }
            return invProcNameMap[srcName];
        }

        // We added instructions at the beginning of this block. Update the affected
        // tranformations (by updating the instruction locations accordingly)
        public void addedInstrToBeg(string procName, string blockName, int num)
        {
            if (!dict.ContainsKey(procName))
            {
                return;
            }
            dict[procName].addedInstrToBeg(blockName, num);
        }

        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if (!dict.ContainsKey(trace.procName))
            {
                // missing transformations are assumed to be identity
                var ret = new ErrorTrace(getSrcProcName(trace.procName));

                foreach (var blk in trace.Blocks)
                {
                    ret.addBlock(new ErrorTraceBlock(blk.blockName));
                    foreach (var c in blk.Cmds)
                    {
                        if (c.isCall())
                        {
                            CallInstr cc = c as CallInstr;
                            if (cc.calleeTrace != null)
                            {
                                var t = mapBackTrace(cc.calleeTrace);
                                ret.addInstr(new CallInstr(t, cc.asyncCall, cc.info));
                                continue;
                            }
                        }
                        ret.addInstr(c);
                    }
                }

                if (trace.returns)
                {
                    ret.addReturn(trace.raisesException);
                }

                return ret;
            }
            return dict[trace.procName].mapBackTrace(trace, this);
        }
    }

    public class InsertionTransProc
    {
        // target -> source instruction
        Dictionary<InstrLocation, InstrLocation> toFromMap;
        // target block -> source block. This mapping must be bijective.
        Dictionary<string, string> toFromBlockMap;

        public InsertionTransProc()
        {
            toFromMap = new Dictionary<InstrLocation, InstrLocation>(new InstrLocationComparer());
            toFromBlockMap = new Dictionary<string, string>();
        }

        public void addTrans(InstrLocation from, InstrLocation to)
        {
            Debug.Assert(!toFromMap.ContainsKey(to));
            toFromMap.Add(to, from);
        }

        public void addTrans(string fromBlock, string toBlock)
        {
            if (toFromBlockMap.ContainsKey(toBlock))
            {
                Debug.Assert(toFromBlockMap[toBlock] == fromBlock);
            }
            else
            {
                toFromBlockMap.Add(toBlock, fromBlock);
            }
        }

        // We added instructions at the beginning of this block. Update the affected
        // tranformations (by updating the instruction locations accordingly)
        public void addedInstrToBeg(string blockName, int delta)
        {
            var updates = new Dictionary<InstrLocation, InstrLocation>(new InstrLocationComparer());
            var rmv = new List<InstrLocation>();

            foreach (var kv in toFromMap)
            {
                if (kv.Key.blockName == blockName)
                {
                    rmv.Add(kv.Key);
                    var newloc = new InstrLocation(blockName, kv.Key.num + delta, kv.Key.type);
                    updates.Add(newloc, kv.Value);
                }
            }

            // Delete old values from the map
            foreach (var k in rmv)
            {
                toFromMap.Remove(k);
            }

            // Add new values
            foreach (var kv in updates)
            {
                toFromMap.Add(kv.Key, kv.Value);
            }
        }

        private ErrorTraceInstr getCorrespondingInst(InstrLocation from, ErrorTraceInstr toInstr, InsertionTrans tinfo)
        {

            if (from.type.type == InstrTypeEnum.CALL || from.type.type == InstrTypeEnum.ASYNC)
            {
                // Get callee trace
                ErrorTrace calleeTrace = null;
                if (toInstr.isCall())
                {
                    calleeTrace = (toInstr as CallInstr).calleeTrace;
                }
                // recursively mapBack the callee trace
                if (calleeTrace != null)
                {
                    calleeTrace = tinfo.mapBackTrace(calleeTrace);
                }

                return new CallInstr(from.type.callee, calleeTrace, (from.type.type == InstrTypeEnum.ASYNC ? true : false), toInstr.info);
            }
            else
            {
                return new IntraInstr(toInstr.info);
            }
        }


        public ErrorTrace mapBackTrace(ErrorTrace trace, InsertionTrans tinfo)
        {
            // Output to be constructed
            var ret = new ErrorTrace(tinfo.getSrcProcName(trace.procName));

            // The current block being constructed
            ErrorTraceBlock curr = null;

            foreach (var blk in trace.Blocks)
            {
                if (toFromBlockMap.ContainsKey(blk.blockName))
                {
                    // This "blk" corresponds to some block in the source program,
                    // then start a new block here.
                    if (curr != null)
                    {
                        ret.addBlock(curr);
                    }

                    curr = new ErrorTraceBlock(toFromBlockMap[blk.blockName]);
                    if(blk.info != null) curr.info = blk.info.Copy();
                }

                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var toType = InstrTypeEnum.INTRA;
                    string callee = null;
                    if (blk.Cmds[i].isCall())
                    {
                        var cc = (blk.Cmds[i] as CallInstr);
                        callee = cc.callee;
                        if (cc.asyncCall)
                            toType = InstrTypeEnum.ASYNC;
                        else
                            toType = InstrTypeEnum.CALL;
                    }

                    var to = new InstrLocation(blk.blockName, i, new InstrType(toType, callee));

                    // Is there a corresponding source instruction?
                    if (!toFromMap.ContainsKey(to))
                        continue;

                    // This is the location of the corresponding source instruction
                    var from = toFromMap[to];

                    // This is the source instruction
                    var inst = getCorrespondingInst(from, blk.Cmds[i], tinfo);

                    // Now we have to place "inst" in "ret"
                    addToTrace(inst, from, ref curr, ret);
                }
            }

            if (curr != null)
            {
                ret.addBlock(curr);
            }

            if (trace.returns)
            {
                ret.addReturn(trace.raisesException);
            }

            return ret;

        }

        private void addToTrace(ErrorTraceInstr inst, InstrLocation loc, ref ErrorTraceBlock curr, ErrorTrace trace)
        {
            if (curr == null)
            {
                curr = new ErrorTraceBlock(loc.blockName);
                Debug.Assert(loc.num == 0);
                curr.addInstr(inst);
                return;
            }

            // curr != null. We need to see if inst should be put inside curr or start a new block?

            if (loc.num == curr.Cmds.Count && loc.blockName == curr.blockName)
            {
                curr.addInstr(inst);
            }
            else
            {
                // start a new block
                Debug.Assert(loc.num == 0);
                trace.addBlock(curr);
                curr = new ErrorTraceBlock(loc.blockName);
                curr.addInstr(inst);
            }

        }
        
    }

    public class InstrLocation
    {
        public string blockName;
        public int num;
        public InstrType type;

        public InstrLocation(string _blockName, int _num, Cmd c)
        {
            initialize(_blockName, _num, getType(c));
        }

        public InstrLocation(string _blockName, int _num, InstrType _type)
        {
            initialize(_blockName, _num, _type);
        }

        private void initialize(string _blockName, int _num, InstrType _type)
        {
            blockName = _blockName;
            num = _num;
            type = _type;
        }

        private InstrType getType(Cmd c)
        {
            if (c is CallCmd)
            {
                var cc = c as CallCmd;
                if (cc.IsAsync)
                {
                    return new InstrType(InstrTypeEnum.ASYNC, cc.callee);
                }
                else
                {
                    return new InstrType(InstrTypeEnum.CALL, cc.callee);
                }
            }
            else
            {
                return new InstrType();
            }
        }

        public void print(TokenTextWriter ttw)
        {
            ttw.Write(blockName + ":" + num.ToString() + 
                (type.type == InstrTypeEnum.CALL 
                ? ":call" :
                (type.type == InstrTypeEnum.ASYNC
                ? ":async" :
                "")));
        }

        public bool Equals(InstrLocation loc)
        {
            return (blockName == loc.blockName && num == loc.num && type.type == loc.type.type && type.callee == loc.type.callee);
        }
    }

    public class InstrLocationComparer : IEqualityComparer<InstrLocation>
    {

        public bool Equals(InstrLocation loc1, InstrLocation loc2)
        {
            return loc1.Equals(loc2);
        }

        public int GetHashCode(InstrLocation loc)
        {
            return (loc.blockName + loc.num.ToString()).GetHashCode();
        }
    }


}
