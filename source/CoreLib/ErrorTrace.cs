using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using System.IO;
using ProgTransformation;
using System.Runtime.Serialization;
using System.Diagnostics.Contracts;

namespace cba
{
    /*
     
    // A class that only keeps basic block labels along a trace
    // (and the call-return structure)
    // This class is kept in this simple form by design. It is the responsibility
    // of the user to ensure that this trace is paired along with the program in which
    // it represents a valid path.
    public class ErrorTraceLabels
    {
        // A trace is a sequence of labels in a single procedure. Along with each
        // label, one may have traces associated with procedures called from that block

        // The procedure
        public string procName { get; private set; }
        // The blocks
        public List<string> labels { get; private set; }
        // Called procedures
        public List<List<ErrorTraceLabels>> calledTraces { get; private set; }
        // Does this trace return from this procedure
        public bool returns { get; private set; }

        public ErrorTraceLabels(string pName)
        {
            procName = pName;
            returns = false;
            labels = new List<string>();
            calledTraces = new List<List<ErrorTraceLabels>>();
        }

        public void addSucc(string succ)
        {
            Debug.Assert(returns == false);

            // Where do we add succ?
            ErrorTraceLabels currTrace = getCurrTrace();

            if (currTrace == null)
            {
                // It is an intra succ in the current procedure
                labels.Add(succ);
                calledTraces.Add(new List<ErrorTraceLabels>());
            }
            else
            {
                currTrace.addSucc(succ);
            }

        }

        public void addReturn()
        {
            Debug.Assert(returns == false);
            Debug.Assert(labels.Count != 0);

            // Where do we add succ?
            ErrorTraceLabels currTrace = getCurrTrace();

            if (currTrace == null)
            {
                returns = true;
            }
            else
            {
                currTrace.addReturn();
            }

        }

        public void addCall(string callee)
        {
            Debug.Assert(returns == false);
            Debug.Assert(labels.Count != 0);

            // Where do we add succ?
            ErrorTraceLabels currTrace = getCurrTrace();

            if (currTrace == null)
            {
                ErrorTraceLabels curr = new ErrorTraceLabels(callee);
                calledTraces[labels.Count - 1].Add(curr);
            }
            else
            {
                currTrace.addCall(callee);
            }
        }

        public void addCall(ErrorTraceLabels trace)
        {
            Debug.Assert(trace.returns);
            Debug.Assert(returns == false);
            Debug.Assert(labels.Count != 0);
            
            // Where do we add succ?
            ErrorTraceLabels currTrace = getCurrTrace();

            if (currTrace == null)
            {
                calledTraces[labels.Count - 1].Add(trace);
            }
            else
            {
                currTrace.addCall(trace);
            }
        }

        // Return the trace that hasn't returned: either it is this one
        // (return null) or the last called trace
        private ErrorTraceLabels getCurrTrace()
        {
            if (labels.Count == 0) return null;
            int n = labels.Count;

            var ls = calledTraces[n - 1];
            if (ls.Count == 0) return null;

            n = ls.Count;

            if (ls[n - 1].returns == false)
            {
                return ls[n - 1];
            }

            return null;
        }

        // Return true if the trace has no called traces
        public bool isIntra()
        {
            for (int i = 0; i < labels.Count; i++)
            {
                if (calledTraces[i].Count != 0)
                    return false;
            }
            return true;
        }

        public void printTrace(TokenTextWriter ttw)
        {
            printTrace(ttw, 0);
        }

        private void printTrace(TokenTextWriter ttw, int indent)
        {
            for (int i = 0; i < labels.Count; i++)
            {
                printIndent(ttw, indent); ttw.WriteLine(procName + ":" + labels[i]);

                for (int j = 0; j < calledTraces[i].Count; j++)
                {
                    calledTraces[i][j].printTrace(ttw, indent + 1);
                    if (calledTraces[i][j].returns)
                    {
                        printIndent(ttw, indent); ttw.WriteLine(procName + ":" + labels[i]);
                    }
                }
            }
        }

        private void printIndent(TokenTextWriter ttw, int indent)
        {
            for (int i = 0; i < indent; i++)
            {
                ttw.Write(" ");
            }
        }
    }
    */

    // Represents an interprocedural path through a program. It does not store
    // the control-transfer instructions (goto, return). Should add these once
    // there is some use for them.
    [Serializable]
    public class ErrorTrace
    {
        // The procedure
        public string procName { get; private set; }

        // The blocks
        public List<ErrorTraceBlock> Blocks { get; private set; }

        // A map from labels to blocks
        private Dictionary<string, ErrorTraceBlock> blockMap;

        // Does this trace return from this procedure
        public bool returns { get; private set; }

        // Does the trace end by raisingException?
        public bool raisesException { get; private set; }

        public ErrorTrace(string _procName)
        {
            procName = _procName;
            Blocks = new List<ErrorTraceBlock>();
            returns = false;
            raisesException = false;
            blockMap = null;
        }

        public ErrorTrace(string _procName, string _startingBlockName)
        {
            procName = _procName;
            Blocks = new List<ErrorTraceBlock>();
            returns = false;
            raisesException = false;
            blockMap  = null;
            Blocks.Add(new ErrorTraceBlock(_startingBlockName));
        }

        // A location identifier for an instruction
        public static string getInstructionLabel(string procName, string blockName, int instrNumber)
        {
            return procName + ":" + blockName + ":" + instrNumber.ToString();
        }

        public bool isIntra()
        {
            foreach (var blk in Blocks)
            {
                if (!blk.isIntra())
                    return false;
            }
            return true;
        }

        // Return the list of blocks in the trace (only in the current procedure)
        public List<string> getBlockLabels()
        {
            var ret = new List<string>();
            Blocks.Iter(blk => ret.Add(blk.blockName));
            return ret;
        }

        public ErrorTraceBlock getBlock(string blkName)
        {
            cacheBlockLabelMap();
            return blockMap[blkName];
        }

        private void cacheBlockLabelMap()
        {
            if (blockMap != null) return;
            blockMap = new Dictionary<string, ErrorTraceBlock>();
            Blocks.Iter(blk => blockMap.Add(blk.blockName, blk));
        }

        // Return the set of procedures that the trace passes through
        public HashSet<string> getProcs()
        {
            var ret = new HashSet<string>();
            ret.Add(procName);

            foreach (var blk in Blocks)
            {
                foreach (var cmd in blk.Cmds)
                {
                    if (cmd.CalleeTrace != null)
                    {
                        ret.UnionWith(cmd.CalleeTrace.getProcs());
                    }
                }
            }
            return ret;
        }

        // Add a block at the end of the trace
        public void addBlock(ErrorTraceBlock blk)
        {
            Debug.Assert(returns == false);

            // Where do we add succ?
            ErrorTrace currTrace = getCurrTrace();

            if (currTrace == null)
            {
                // It is an intra succ in the current procedure
                Blocks.Add(blk);
            }
            else
            {
                currTrace.addBlock(blk);
            }
        }

        // Add an (non-return) instruction at the end of the trace
        public void addInstr(ErrorTraceInstr instr)
        {
            Debug.Assert(returns == false);
            Debug.Assert(Blocks.Count != 0);

            // Where do we add instr?
            ErrorTrace currTrace = getCurrTrace();

            if (currTrace == null)
            {
                // It is an intra succ in the current procedure
                Blocks[Blocks.Count -1].addInstr(instr);
            }
            else
            {
                currTrace.addInstr(instr);
            }
        }

        // Add a return at the end of the trace
        public void addReturn()
        {
            addReturn(false);
        }

        public void addReturn(bool withException)
        {
            Debug.Assert(returns == false);
            Debug.Assert(Blocks.Count != 0);

            // Where do we add succ?
            ErrorTrace currTrace = getCurrTrace();

            if (currTrace == null)
            {
                returns = true;
                raisesException = withException;
            }
            else
            {
                currTrace.addReturn(withException);
            }

        }

        // Trace ends by raising exception
        public void setRaiseException()
        {
            raisesException = true;
        }

        // Add a procedure call at the end of the trace
        public void addCall(string callee)
        {
            var et = new ErrorTrace(callee);
            var instr = new CallInstr(et);
            addInstr(instr);
        }

        public bool checkSanity()
        {
            var calleeAllReturn = true;
            for(int j = 0; j < Blocks.Count; j++)
            {
                var blk = Blocks[j];
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var cinst = blk.Cmds[i] as CallInstr;
                    if (cinst == null || cinst.calleeTrace == null) continue;
                    if (!cinst.calleeTrace.checkSanity())
                        return false;
                    if (!cinst.calleeTrace.returns && (i != blk.Cmds.Count - 1 || j != Blocks.Count - 1))
                        return false;
                    if (!cinst.calleeTrace.returns)
                        calleeAllReturn = false;
                }
            }
            if (returns && !calleeAllReturn)
                return false;

            return true;
        }

        public ErrorTrace findTrace(string callee)
        {
            if (procName == callee) return this;
            foreach (var blk in Blocks)
            {
                foreach (var inst in blk.Cmds.OfType<CallInstr>().Where(i => i.calleeTrace != null))
                {
                    if (inst.callee == callee)
                        return inst.calleeTrace;
                    var ret = inst.calleeTrace.findTrace(callee);
                    if (ret != null) return ret;
                }
            }
            return null;
        }

        public void printTrace(TokenTextWriter ttw)
        {
            if (ttw == null)
                return;

            printTrace(ttw, 0);
        }

        public void printTrace(TokenTextWriter ttw, int indent)
        {
            for (int i = 0; i < Blocks.Count; i++)
            {
                printIndent(ttw, indent); ttw.WriteLine(procName + ":" + Blocks[i].blockName);
                Blocks[i].printCalledTraces(ttw, procName, indent);
            }
        }

        public void printRecBound()
        {
            var stack = new Stack<string>();
            var bound = new Dictionary<string, int>();
            computeRecBound(this, stack, bound);
            foreach (var kvp in bound)
            {
                if (kvp.Value <= 1) continue;
                Console.WriteLine("RB for {0}: {1}", kvp.Key, kvp.Value);
            }
        }

        private static void computeRecBound(ErrorTrace trace, Stack<string> stack, Dictionary<string, int> bound)
        {
            if (trace == null) return;

            // compute bound for procName
            var rb = stack.Where(str => str == trace.procName).Count() + 1;
            if (!bound.ContainsKey(trace.procName))
            {
                bound.Add(trace.procName, 0);
            }
            var oldb = bound[trace.procName];
            if (rb > oldb) bound[trace.procName] = rb;

            stack.Push(trace.procName);
            foreach (var blk in trace.Blocks)
            {
                foreach (var cmd in blk.Cmds.OfType<CallInstr>())
                {
                    computeRecBound(cmd.calleeTrace, stack, bound);
                }
            }
            stack.Pop();
        }

        public ErrorTrace Copy()
        {
            var ret = new ErrorTrace(procName);

            foreach (var blk in Blocks)
            {
                ret.addBlock(blk.Copy());
            }

            if (returns)
            {
                ret.addReturn(raisesException);
            }

            return ret;
        }

        public override string ToString()
        {
            return procName;
        }

        // Return the trace that hasn't returned: either it is this one
        // (return null) or the last called trace
        private ErrorTrace getCurrTrace()
        {
            if (Blocks.Count == 0) return null;
            return Blocks[Blocks.Count - 1].getCurrTrace();
        }

        public static void printIndent(TokenTextWriter ttw, int indent)
        {
            for (int i = 0; i < indent; i++)
            {
                ttw.Write(" ");
            }
        }

        // Normalize tid values. Returns false if no tid information
        // (normalized or unnormalized) was found in the trace
        public static bool normalizeTid(ErrorTrace trace)
        {
            // fetch all tid values
            var vals = new HashSet<int>();
            collectTidInfo(trace, vals);

            // Sort values
            var vlist = new List<int>();
            vals.Iter(v => vlist.Add(v));
            vlist.Sort();

            // Build map to new values
            var newVal = new Dictionary<int, int>();
            int cnt = 1;
            foreach (var v in vlist)
            {
                newVal.Add(v, cnt);
                cnt++;
            }

            // Update values
            updateTidInfo(trace, newVal);

            return (newVal.Count != 0);
        }

        private static void updateTidInfo(ErrorTrace trace,Dictionary<int, int> newVal)
        {
            if (trace == null) return;
            foreach (var blk in trace.Blocks)
            {
                updateTid(blk.info, newVal);
                foreach (var inst in blk.Cmds)
                {
                    updateTid(inst.info, newVal);
                    if (inst.isCall())
                    {
                        updateTidInfo(inst.CalleeTrace, newVal);
                    }
                }
            }
        }


        private static void collectTidInfo(ErrorTrace trace, HashSet<int> vals)
        {
            if (trace == null) return;
            foreach (var blk in trace.Blocks)
            {
                fetchTid(blk.info, vals);
                foreach (var inst in blk.Cmds)
                {
                    fetchTid(inst.info, vals);
                    if (inst.isCall())
                    {
                        collectTidInfo(inst.CalleeTrace, vals);
                    }
                }
            }
        }

        public static void fillInContextSwitchInfo(ErrorTrace trace)
        {
            // We start with (k == 0, tid == 1) and push these down the trace, changing 
            // their values according to what is present in trace. We over-write
            // invalid info. Thread ID counter starts at 1 (0 is reserved for "no thread")
            tidCounter = 0;
            fillInContextSwitchInfo(trace, 0, getTid());
        }

        private static int fillInContextSwitchInfo(ErrorTrace trace, int k, int tid)
        {
            foreach (var blk in trace.Blocks)
            {
                fetchInfo(blk.info, ref k, ref tid);
                updateInfo(ref blk.info, k, tid);

                foreach (var inst in blk.Cmds)
                {
                    fetchInfo(inst.info, ref k, ref tid);
                    updateInfo(ref inst.info, k, tid);

                    if (inst.isCall())
                    {
                        CallInstr cinst = inst as CallInstr;
                        if (cinst.hasCalledTrace)
                        {
                            var oldk = k;

                            k = fillInContextSwitchInfo(cinst.calleeTrace, k,
                                cinst.asyncCall ? getTid() : tid);

                            if (cinst.asyncCall && cinst.calleeTrace.returns)
                            {
                                k = oldk;
                            }
                        }
                    }
                }
            }
            return k;
        }

        private static int tidCounter = 0;
        private static int getTid()
        {
            return ++tidCounter;
        }

        /*
        // Correct tid information so that "tid" is incremented only after 
        // a procedure call
        public static void correctTidInfoAtCalls(ErrorTrace trace)
        {
            int tid = 1;

            foreach (var blk in trace.Blocks)
            {
                if (blk.info != null && blk.info.tid >= 0)
                    tid = blk.info.tid;

                foreach (var c in blk.Cmds)
                {
                    if (!c.isCall() || (c.isCall() && !(c as CallInstr).asyncCall))
                    {
                        if (c.info != null && c.info.tid >= 0)
                            tid = c.info.tid;
                        continue;
                    }

                    var cc = c as CallInstr;
                    Debug.Assert(cc.asyncCall);
                    cc.info.tid = tid;

                    if (cc.calleeTrace != null)
                    {
                        correctTidInfoAtCalls(cc.calleeTrace);
                    }
                }
            }

        }
         */

        private static void fetchInfo(InstrInfo info, ref int k, ref int tid) {
            if (info == null)
                return;

            if(info.executionContext >= 0) {
                k = info.executionContext;
            }
            if(info.tid >= 0) {
                tid = info.tid;
            }
        }

        private static void updateInfo(ref InstrInfo info, int k, int tid)
        {
            if (info == null)
            {
                info = new InstrInfo(k, tid);
            }
            else
            {
                info.executionContext = k;
                info.tid = tid;
            }
        }

        private static void fetchTid(InstrInfo info, HashSet<int> vals)
        {
            if (info == null) return;
            if (info.tid >= 0) vals.Add(info.tid);
        }

        private static void updateTid(InstrInfo info, Dictionary<int, int> newVal)
        {
            if (info == null) return;
            if (info.tid < 0) return;
            info.tid = newVal[info.tid];
        }

        // Find the first occurance of "pred" along the trace
        public static Tuple<Implementation, Block, int> FindCmd(Program program, ErrorTrace trace, Predicate<Cmd> pred)
        {
            if(trace == null) return null;

            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, trace.procName);
            var l2b = BoogieUtil.labelBlockMapping(impl);

            foreach (var tb in trace.Blocks)
            {
                var block = l2b[tb.blockName];
                for (int i = 0; i < Math.Min(block.Cmds.Count, tb.Cmds.Count); i++)
                {
                    if (pred(block.Cmds[i]))
                        return Tuple.Create(impl, block, i);
                }

                foreach (var ct in tb.Cmds.OfType<CallInstr>().Select(cc => cc.calleeTrace))
                {
                    var ret = FindCmd(program, ct, pred);
                    if (ret != null) return ret;
                }
            }

            return null;
        }
    }

    // A sequence of instruction through a basic block
    [Serializable]
    public class ErrorTraceBlock
    {
        // The block label
        public string blockName {get; private set;}

        // The sequence of instructions in the block
        public List<ErrorTraceInstr> Cmds {get; private set;}

        // Info for the block header
        public InstrInfo info;

        public ErrorTraceBlock(string name)
        {
            blockName = name;
            Cmds = new List<ErrorTraceInstr>();
            info = null;
        }

        // A block with the same instruction repeated a number of times
        public ErrorTraceBlock(string name, ErrorTraceInstr instr, int len)
        {
            blockName = name;
            Cmds = new List<ErrorTraceInstr>();
            for (int i = 0; i < len; i++)
            {
                Cmds.Add(instr);
            }
        }

        public override string ToString()
        {
            return blockName;
        }

        public bool isIntra()
        {
            foreach (var instr in Cmds)
            {
                if (instr.isCall())
                {
                    var cinstr = instr as CallInstr;
                    if (cinstr.hasCalledTrace)
                        return false;
                }
            }
            return true;
        }

        public void addInstr(ErrorTraceInstr instr)
        {
            Cmds.Add(instr);
        }

        public ErrorTraceBlock Copy()
        {
            var ret = new ErrorTraceBlock(blockName);
            if(info != null) ret.info = info.Copy();
            foreach (var inst in Cmds)
            {
                ret.addInstr(inst.Copy());
            }
            return ret;
        }

        // Delete the i^th instruction
        public ErrorTraceInstr delete(int i)
        {
            Debug.Assert(i >= 0 && i < Cmds.Count);
            var ret = Cmds[i];
            Cmds.RemoveAt(i);
            return ret;
        }

        public void printCalledTraces(TokenTextWriter ttw, string procName, int indent)
        {
            foreach (ErrorTraceInstr instr in Cmds)
            {
                if (instr.isCall())
                {
                    CallInstr cinstr = instr as CallInstr;
                    if (cinstr.hasCalledTrace)
                    {
                        cinstr.calleeTrace.printTrace(ttw, indent + 1);
                        if (cinstr.calleeTrace.returns)
                        {
                            ErrorTrace.printIndent(ttw, indent);
                            ttw.WriteLine(procName + ":" + blockName);
                        }
                    }
                }
            }
        }

        // Return the trace that hasn't returned: either it is this one
        // (return null) or the last called trace
        public ErrorTrace getCurrTrace()
        {
            if (Cmds.Count == 0) return null;
            var instr = Cmds[Cmds.Count - 1];

            if (instr.isCall())
            {
                var cinstr = instr as CallInstr;
                if (cinstr.Returns)
                    return null;
                return cinstr.calleeTrace;
            }
            else
            {
                return null;
            }
        }
    }

    // Interface for an instruction in an error trace. 
    [Serializable]
    abstract public class ErrorTraceInstr 
    {
        [NonSerialized]
        public InstrInfo info;
        public virtual ErrorTrace CalleeTrace
        {
            get
            {
                return null;
            }
        }

        public ErrorTraceInstr()
        {
            info = new InstrInfo();
        }

        public ErrorTraceInstr(InstrInfo _info)
        {
            Debug.Assert(_info != null);
            info = _info;
        }

        abstract public ErrorTraceInstr Copy();
        abstract public bool isCall();
    }

    // A Call instruction
    [Serializable]
    public class CallInstr : ErrorTraceInstr
    {
        // This can be null -- indicating that a trace through
        // the callee is not available (possibly because it
        // has no implementation)
        public ErrorTrace calleeTrace { get; private set; }

        // Name of the called procedure
        public string callee;

        public override ErrorTrace CalleeTrace
        {
            get
            {
                return calleeTrace;
            }
        }

        // Is it an async call?
        public bool asyncCall { get; private set; }

        public static bool HwswSpecial = false;

        // Does the called trace return?
        public bool Returns
        {
            get
            {
                if (calleeTrace == null)
                    return true;
                return calleeTrace.returns;
            }
        }

        public bool hasCalledTrace
        {
            get
            {
                return (calleeTrace != null);
            }
        }

        public CallInstr(string callee)
            : this(callee, null, false, null)
        {

        }

        public CallInstr(ErrorTrace et)
            : this(et.procName, et, false, null)
        {

        }

        public CallInstr(ErrorTrace et, InstrInfo _info)
            : this(et.procName, et, false, _info)
        {
        }

        public CallInstr(ErrorTrace et, bool async, InstrInfo _info)
            : this(et.procName, et, async, _info)
        {
        }

        public CallInstr(string callee, ErrorTrace et, bool async, InstrInfo _info)
            : base()
        {
            if(_info != null) base.info = _info;
            this.callee = callee;
            calleeTrace = et;
            asyncCall = async;
            if (calleeTrace != null && !HwswSpecial)
            {
                Debug.Assert(calleeTrace.procName == callee);
            }
        }

        public override bool isCall()
        {
            return true;
        }

        public void SetErrorTrace(ErrorTrace ctrace)
        {
            calleeTrace = ctrace;
            if(calleeTrace != null)
                Debug.Assert(callee == calleeTrace.procName);
        }

        public override ErrorTraceInstr Copy()
        {
            InstrInfo ninfo = null;
            if (info != null) ninfo = info.Copy();

            if (calleeTrace == null)
                return new CallInstr(callee, null, asyncCall, ninfo);
            else
                return new CallInstr(callee, calleeTrace.Copy(), asyncCall, ninfo);
        }

        public override string ToString()
        {
            if (hasCalledTrace)
            {
                return string.Format("{0}call({1})", asyncCall ? "async " : "", calleeTrace.ToString());
            }
            else
            {
                return "call " + callee;
            }
        }
    }

    // A non-call instruction
    [Serializable]
    public class IntraInstr : ErrorTraceInstr
    {
        public IntraInstr() : base() { }

        public IntraInstr(InstrInfo _info)
            : base(_info)
        {
        }

        public override bool isCall()
        {
            return false;
        }

        public override ErrorTraceInstr Copy()
        {
            InstrInfo ninfo = null;
            if (info != null) ninfo = info.Copy();

            return new IntraInstr(ninfo);
        }

        public override string ToString()
        {
            return "Intra";
        }
    }

    // Some information attached to an instruction
    [Serializable]
    public class InstrInfo
    {
        // The execution context under which the instruction fires.
        public int executionContext
        {
            get
            {
                return (int)varToVal["k"];
            }
            set
            {
                varToVal["k"] = value;
            }
        }

        // The thread ID under which the instruction fires.
        public int tid
        {
            get
            {
                return (int)varToVal[LanguageSemantics.tidName];
            }
            set
            {
                varToVal[LanguageSemantics.tidName] = value;
            }
        }

        // Variable name to value 
        protected Dictionary<string, object> varToVal;

        public bool isValid
        {
            get
            {
                return (executionContext >= 0) || (tid >= 0);
            }
        }

        public InstrInfo()
        {
            varToVal = new Dictionary<string, object>();
            varToVal.Add("k", -1);
            varToVal.Add(LanguageSemantics.tidName, -1);
        }

        public InstrInfo(InstrInfo c)
        {
            if (c == null)
            {
                varToVal = new Dictionary<string, object>();
                varToVal.Add("k", -1);
                varToVal.Add(LanguageSemantics.tidName, -1);
            }
            else
            {
                varToVal = new Dictionary<string, object>(c.varToVal);
            }
        }

        public InstrInfo(int _executionContext, int _tid) :
            this()
        {
            executionContext = _executionContext;
            tid = _tid;
        }

        public void addVal(string var, object val)
        {
            if (var == "k" || var == LanguageSemantics.tidName)
            {
                if (val is Microsoft.Basetypes.BigNum)
                {
                    val = BoogieUtil.BigNumToIntForce((Microsoft.Basetypes.BigNum)val);
                }
            }

            if (varToVal.ContainsKey(var))
            {
                varToVal[var] = val;
            }
            else
            {
                varToVal.Add(var, val);
            }
        }

        public object getVal(string var)
        {
            Debug.Assert(varToVal.ContainsKey(var));
            return varToVal[var];
        }

        public int getIntVal(string var)
        {
            var val = getVal(var);
            if (val is int) return (int)val;
            if (val is Model.Integer) return ((Model.Integer)val).AsInt();
            if (val is Microsoft.Basetypes.BigNum) return BoogieUtil.BigNumToIntForce((Microsoft.Basetypes.BigNum)val);
            Debug.Assert(false);
            return 0;
        }

        public bool getBoolVal(string var)
        {
            var val = getVal(var);
            if (val is bool) return (bool)val;
            if (val is Model.Boolean) return ((Model.Boolean)val).Value;
            Debug.Assert(false);
            return false;
        }

        public Microsoft.Basetypes.BigNum getBigNumVal(string var)
        {
            var val = getVal(var);
            if (val is int) return Microsoft.Basetypes.BigNum.FromInt((int)val);
            if (val is Model.Integer) return Microsoft.Basetypes.BigNum.FromString(((Model.Integer)val).Numeral);
            if (val is Microsoft.Basetypes.BigNum) return (Microsoft.Basetypes.BigNum)val;
            Debug.Assert(false);
            return Microsoft.Basetypes.BigNum.FromInt(0);
        }


        public bool hasVar(string var)
        {
            return varToVal.ContainsKey(var);
        }

        public bool hasIntVar(string var)
        {
            if (!hasVar(var)) return false;
            var v = varToVal[var];
            return ((v is int) || (v is Microsoft.Boogie.Model.Integer) ||
                (v is Microsoft.Basetypes.BigNum));
        }

        public bool hasBoolVar(string var)
        {
            if (!hasVar(var)) return false;
            var v = varToVal[var];
            return ((v is bool) || (v is Microsoft.Boogie.Model.Boolean));
        }

        public override string ToString()
        {
            var ret = "";
            foreach (var tp in varToVal)
            {
                if (tp.Key == "k" && ((int)tp.Value) == -1) continue;
                if (tp.Key == LanguageSemantics.tidName && ((int)tp.Value) == -1) continue;
                ret += string.Format("{0}={1} ", tp.Key, tp.Value.ToString());
            }
            return ret;
        }

        public virtual InstrInfo Copy()
        {
            var ret = new InstrInfo();
            ret.varToVal = new Dictionary<string, object>(varToVal);
            return ret;
        }

        public void removeVar(string varName)
        {
            if(varToVal.ContainsKey(varName)) varToVal.Remove(varName);
        }
    }

    // Marks a failing assert
    [Serializable]
    public class AssertFailInstrInfo : InstrInfo
    {
        public AssertFailInstrInfo() : base() { }
        public AssertFailInstrInfo(InstrInfo info) : base(info) { }

        public override InstrInfo Copy()
        {
            var ret = new AssertFailInstrInfo();
            ret.varToVal = new Dictionary<string, object>(varToVal);
            return ret;
        }
    }

    // Marks a failing requires
    [Serializable]
    public class RequiresFailInstrInfo : AssertFailInstrInfo
    {
        public RequiresFailInstrInfo() : base() { }
        public RequiresFailInstrInfo(InstrInfo info) : base(info) { }

        public override InstrInfo Copy()
        {
            var ret = new RequiresFailInstrInfo();
            ret.varToVal = new Dictionary<string, object>(varToVal);
            return ret;
        }
    }

    // Marks a failing ensures
    [Serializable]
    public class EnsuresFailInstrInfo : AssertFailInstrInfo
    {
        public EnsuresFailInstrInfo() : base() { }
        public EnsuresFailInstrInfo(InstrInfo info) : base(info) { }

        public override InstrInfo Copy()
        {
            var ret = new EnsuresFailInstrInfo();
            ret.varToVal = new Dictionary<string, object>(varToVal);
            return ret;
        }
    }

    // For storing data values
    [Serializable]
    public class ModelInstrInfo : InstrInfo,ISerializable
    {
        public int index {get; private set;}
        public Model model { get; private set; }
        // a pointer to model.States[index]
        Model.CapturedState state;

        public ModelInstrInfo() : base() {
            index = -1;
        }

        public ModelInstrInfo(InstrInfo info) : base(info) { }

        public ModelInstrInfo(Model model, int index)
            : base()
        {
            this.index = index;
            this.model = model;
            this.state = model.States.ElementAt(index);
            this.state.ChangeName("CorralState_" + index.ToString());
        }

        public override InstrInfo Copy()
        {
            var ret = new ModelInstrInfo(model, index);
            ret.varToVal = new Dictionary<string, object>(varToVal);
            return ret;
        }

        public override string ToString()
        {
            //var st = base.ToString();
            return "CorralState_" + index.ToString();
        }
        #region Serializability Members
        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue("index", index);
        }
        /*
         * 
         *The deserializer is only used in traceAnalyser and we dont need the model and state there!
         */
        public ModelInstrInfo(SerializationInfo info, StreamingContext context)
        {
            index = info.GetInt32("index");
            model = null;
            state = null;
        }
        #endregion
    }

    // If one wants the info to be printed in an error trace
    [Serializable]
    public class PrintInstrInfo : InstrInfo
    {
        public PrintInstrInfo(InstrInfo info) :
            base(info) { }

        public override InstrInfo Copy()
        {
            return new PrintInstrInfo(base.Copy());
        }
    }

    public static class PrintSdvPath
    {
        private static Dictionary<string, Implementation> nameImplMap;
        private static TokenTextWriter pathFile;
        private static TokenTextWriter stackFile;
        private static Program program;
        private static int gcnt = 0;
        public static string abortMessage = null;
        public static string abortMessageLocation = null;
        public static string aliasingPre = null;
        public static Tuple<string, string, int> lastDriverLocation = null;
        private static int captureStateIndex = 0;
        private static Dictionary<int, SourceInfo> sourceInfo;
        private static System.Text.RegularExpressions.Regex callRegEx  = 
            new System.Text.RegularExpressions.Regex(@"Call \\""(.*)\\"" \\""(.*)\\""");

        public static string dataValuesCurrent = "";
        public static Dictionary<string, string> dataValuesPermanent = new Dictionary<string, string>();
        public static HashSet<string> permanentVars;

        public static Dictionary<int, HashSet<string>> memReads;
        public static Dictionary<int, HashSet<string>> memWrites;
        public static Dictionary<int, HashSet<int>> memReadsCS;
        public static Dictionary<int, HashSet<int>> memWritesCS;
        public static Dictionary<int, HashSet<string>> scalarWrites; // CS -> "scalar value written"

        // relevant lines (trace slicing)
        public static HashSet<Tuple<string, int>> relevantLines = null;

        public static Tuple<string, int> failingLocation = null;
        // failing status (mustFail or notmustFail)
        public static string failStatus = null;

        // Address -> the type with which it is accessed
        public static Dictionary<int, HashSet<string>> memType;

        private static List<PrintProgramPath.WorkItem> stack;
        private static bool recordStack =false;

        public static string mustFail = "mustFail";
        public static string notmustFail = "notmustFail";

        class SourceInfo
        {
            public int line;
            public string file;
            public string extra;
            public string am;
        }

        public static void PrintStackTrace(Program p, ErrorTrace trace, string filename)
        {
            stack = new List<PrintProgramPath.WorkItem>();
            program = p;
            nameImplMap = BoogieUtil.nameImplMapping(program);
            pathFile = new TokenTextWriter(filename);
            gcnt = 1;
            abortMessage = null;

            printStkTrace(trace,0);

            pathFile.Close();
            nameImplMap = null;
            program = null;
        }

        // Prints stack trace  as required by AssertionInjector by recursively calling itself on calleeTraces
        private static void printStkTrace(ErrorTrace trace,int depth)
        {
            Debug.Assert(trace.Blocks.Count != 0);
            Implementation impl = nameImplMap[trace.procName];
            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);
            stack.Insert(0, new PrintProgramPath.WorkItem(trace.procName, null));
            string sourceFile = null;
            int sourceLine = -1;

            // Walk through trace and impl in lock step
            foreach (var tblk in trace.Blocks)
            {
                Block pblk = nameBlockMap[tblk.blockName];
                int pcnt = 0;
                foreach (var tcmd in tblk.Cmds)
                {
                    AssertCmd assertCmd = pblk.Cmds[pcnt] as AssertCmd;
                    if (assertCmd != null)
                    {
                        sourceFile = QKeyValue.FindStringAttribute(assertCmd.Attributes, "sourcefile");
                        sourceLine = QKeyValue.FindIntAttribute(assertCmd.Attributes, "sourceline", -1);
                        if (sourceFile != null && !sourceFile.Equals("?") && sourceLine != -1)
                        {
                           stack[0].tok = new Token(sourceLine, 0);
                           stack[0].tok.filename = sourceFile;
                        }
                    }
                    if (tcmd.CalleeTrace != null)
                    {
                        CallCmd callcmd = pblk.Cmds[pcnt] as CallCmd;
                        if (callcmd.callee.Equals("SLIC_ERROR_ROUTINE"))
                            recordStack = true;

                        printStkTrace(tcmd.CalleeTrace,depth+1);

                        if (!recordStack)
                            stack.RemoveAt(0);
                    }
                    pcnt++;
                }
            }
            if (depth == 0 && recordStack)
            {
                for(int i=0;i<stack.Count - 1 ;i++)
                {
                    var stkelem = stack[i + 1];
                    String filename = "?";
                    int line = 0;
                    if (stkelem.tok != null)
                    {
                        if (stkelem.tok.filename != null)
                        {
                            filename = stkelem.tok.filename;
                            line = stkelem.tok.line;
                        }
                    }
                    pathFile.WriteLine("1\t{0}\t{1}\t{2}", filename, stack[i].procName, line);
                }
            }
        }

        public static ModifyTrans DeleteSourceInfo(Program program)
        {
            var tinfo = new ModifyTrans();
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    var newcmds = new List<Cmd>();
                    foreach (Cmd cmd in block.Cmds)
                    {
                        if (BoogieUtil.isAssertTrue(cmd))
                        {
                            tinfo.add(impl.Name, block.Label, new InstrTrans(cmd, new List<Cmd>()));
                        }
                        else
                        {
                            tinfo.add(impl.Name, block.Label, new InstrTrans(cmd, cmd));
                            newcmds.Add(cmd);
                        }

                    }
                    block.Cmds = newcmds;
                }
            }
            return tinfo;
        }

        public static ModifyTrans DeletePrintCmds(Program program)
        {
            var isPrintCmd = new Predicate<Cmd>(cmd =>
                {
                    var ccmd = cmd as CallCmd;
                    if (ccmd != null && ccmd.callee.StartsWith("boogie_si_record_li2bpl_")) return true;
                    return false;
                }
            );

            var tinfo = new ModifyTrans();
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    var newcmds = new List<Cmd>();
                    foreach (Cmd cmd in block.Cmds)
                    {
                        if (isPrintCmd(cmd))
                        {
                            tinfo.add(impl.Name, block.Label, new InstrTrans(cmd, new List<Cmd>()));
                        }
                        else
                        {
                            tinfo.add(impl.Name, block.Label, new InstrTrans(cmd, cmd));
                            newcmds.Add(cmd);
                        }

                    }
                    block.Cmds = newcmds;
                }
            }
            return tinfo;
        }

        public static void SaveSourceInfo(Program p)
        {
            var index = 0;
            sourceInfo = new Dictionary<int, SourceInfo>();
            var attrs = new HashSet<string>(
                new string[] { "sourcefile", "sourceFile", "sourceLine", "sourceline",
                    "print", "abortM"});

            foreach (var impl in p.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        var acmd = blk.Cmds[i] as AssertCmd;
                        if (acmd == null) continue;
                        var si = new SourceInfo();

                        si.file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourceFile");
                        if (si.file == null) si.file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile");
                        if (si.file == null) continue;

                        si.line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceLine", -1);
                        if (si.line == -1) si.line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceline", -1);

                        si.extra = QKeyValue.FindStringAttribute(acmd.Attributes, "print");
                        si.am = QKeyValue.FindStringAttribute(acmd.Attributes, "abortM");

                        sourceInfo.Add(index, si);
                        acmd.Attributes = BoogieUtil.removeAttrs(attrs, acmd.Attributes);
                        var par = new List<object>(); par.Add(Expr.Literal(index));
                        acmd.Attributes = new QKeyValue(Token.NoToken, "sI",
                            par, acmd.Attributes);

                        index++;
                    }
                }
            }
        }

        public static void Print(Program p, ErrorTrace trace, HashSet<string> recorded, string aliasingExplanation, string filename, string stackFileName)
        {
            program = p;
            nameImplMap = BoogieUtil.nameImplMapping(program);
            pathFile = new TokenTextWriter(filename);
            stackFile = new TokenTextWriter(stackFileName);
            gcnt = 1;
            abortMessage = null;
            abortMessageLocation = null;
            aliasingPre = aliasingExplanation;
            lastDriverLocation = null;
            captureStateIndex = 0;
            memReads = new Dictionary<int, HashSet<string>>();
            memWrites = new Dictionary<int, HashSet<string>>();
            memReadsCS = new Dictionary<int, HashSet<int>>();
            memWritesCS = new Dictionary<int, HashSet<int>>();
            scalarWrites = new Dictionary<int, HashSet<string>>();

            memType = new Dictionary<int, HashSet<string>>();

            dataValuesCurrent = "";
            permanentVars = recorded;
            dataValuesPermanent = new Dictionary<string, string>();

            pathFile.WriteLine("0 \"?\" 0 false ^ Call \"OS\" \"main\"");
            stackFile.WriteLine("Driver is entered:");

            printProcTrace(trace);

            pathFile.WriteLine("Error {0}", abortMessage == null ? "" : abortMessage);            
            stackFile.WriteLine("Error {0}", abortMessage == null ? "" : abortMessage);
            pathFile.Close();
            stackFile.Close();

            abortMessage = string.Format("{0}{1}{2}", abortMessage == null ? "" : abortMessage, Environment.NewLine, 
                abortMessageLocation == null ? "" : abortMessageLocation);
            
            nameImplMap = null;
            program = null;

            if (scalarWrites.Count > 0)
            {
                var scalarFile = new TokenTextWriter("scalars.txt");
                scalarWrites.Iter(kvp =>
                    {
                        scalarFile.Write("{0}: ", kvp.Key);
                        kvp.Value.Iter(s => scalarFile.Write("{0}", s));
                        scalarFile.Write("\n");
                    });
                scalarFile.Close();
            }

            if (memReads.Count + memWrites.Count > 0)
            {
                // Possible type unification needed
                foreach (var kvp in memType)
                {
                    if (kvp.Value.Count < 2) continue;
                    Console.Write("Possible type-unification needed ({0}):", kvp.Key);
                    kvp.Value.Iter(s => Console.Write(" {0}", s));
                    Console.WriteLine();
                }

                // Per line info
                var lineReads = new Dictionary<string, HashSet<int>>();
                var lineWrites = new Dictionary<string, HashSet<int>>();

                memReads.Iter(kvp =>
                    kvp.Value.Iter(line => lineReads.InitAndAdd(line, kvp.Key)));

                memWrites.Iter(kvp =>
                    kvp.Value.Iter(line => lineWrites.InitAndAdd(line, kvp.Key)));

                var memFile = new TokenTextWriter("mem1.txt");
                
                var lines = new HashSet<string>();
                lineReads.Keys.Iter(line => lines.Add(line));
                lineWrites.Keys.Iter(line => lines.Add(line));

                foreach (var line in lines)
                {
                    memFile.WriteLine("{0}:", line);
                    if(lineReads.ContainsKey(line) && lineReads[line].Count > 0)
                        memFile.WriteLine("  Reads : {0}", lineReads[line].Print());
                    if (lineWrites.ContainsKey(line) && lineWrites[line].Count > 0)
                        memFile.WriteLine("  Writes: {0}", lineWrites[line].Print());
                }

                memFile.Close();

                memFile = new TokenTextWriter("mem2.txt");

                var addresses = new HashSet<int>();
                memReads.Keys.Iter(a => addresses.Add(a));

                foreach (var add in addresses)
                {
                    memFile.WriteLine("{0}:", add);
                    if (memReads[add].Count > 0)
                    {
                        memReads[add].Iter(rd => memFile.WriteLine("  Read : {0}", rd));
                        if (memWrites.ContainsKey(add) && memWrites[add].Count > 0)
                            memWrites[add].Iter(wr => memFile.WriteLine("  Write: {0}", wr));
                    }
                }

                memFile.Close();


                // per capture state info
                var stateReads = new Dictionary<int, HashSet<int>>();
                var stateWrites = new Dictionary<int, HashSet<int>>();
                memReadsCS.Iter(kvp =>
                    kvp.Value.Iter(cs => stateReads.InitAndAdd(cs, kvp.Key)));
                memWritesCS.Iter(kvp =>
                    kvp.Value.Iter(cs => stateWrites.InitAndAdd(cs, kvp.Key)));

                memFile = new TokenTextWriter("mem3.txt");

                var states = new HashSet<int>();
                stateReads.Keys.Iter(s => states.Add(s));
                stateWrites.Keys.Iter(s => states.Add(s));

                foreach (var state in states)
                {
                    memFile.WriteLine("{0}:", state);
                    if (stateReads.ContainsKey(state) && stateReads[state].Count > 0)
                        memFile.WriteLine("  Reads : {0}", stateReads[state].Print());
                    if (stateWrites.ContainsKey(state) && stateWrites[state].Count > 0)
                        memFile.WriteLine("  Writes: {0}", stateWrites[state].Print());
                }

                memFile.Close();

                memFile = new TokenTextWriter("mem4.txt");

                foreach (var add in addresses)
                {
                    memFile.WriteLine("{0}:", add);
                    if (memReadsCS[add].Count > 0)
                    {
                        memReadsCS[add].Iter(rd => memFile.WriteLine("  Read : {0}", rd));
                        if (memWritesCS.ContainsKey(add) && memWritesCS[add].Count > 0)
                            memWritesCS[add].Iter(wr => memFile.WriteLine("  Write: {0}", wr));
                    }
                }

                memFile.Close();
            }
        }

        // Prints trace by recursively calling itself on calleeTraces
        private static void printProcTrace(ErrorTrace trace)
        {
            Debug.Assert(trace.Blocks.Count != 0);
            Implementation impl = nameImplMap[trace.procName];
            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);
            var currLine = getStartingLine(trace);

            // original name of this procedure
            var origName = QKeyValue.FindStringAttribute(impl.Attributes, "origName");
            if (origName == null) origName = impl.Name;

            // Walk through trace and impl in lock step
            foreach (var tblk in trace.Blocks)
            {
                updatePermanentVars(tblk.info);

                Block pblk = nameBlockMap[tblk.blockName];

                int pcnt = 0;
                foreach (var tcmd in tblk.Cmds)
                {
                    printInfo(pblk.Cmds[pcnt], tcmd.info, origName);
                    
                    gatherMemAccess(pblk.Cmds[pcnt], currLine, tcmd.info);
                    var templ = getLineInfo(pblk.Cmds[pcnt]);
                    if (templ != null) currLine = templ;

                    if (tcmd.CalleeTrace != null)
                    {
                        printProcTrace(tcmd.CalleeTrace);
                    }

                    pcnt++;
                }
            }

            dataValuesCurrent = "";
        }

        private static void gatherMemAccess(Cmd incmd, string line, InstrInfo info)
        {
            var cmd = incmd as CallCmd;
            if (info == null || cmd == null || cmd.callee != CoreLib.RecordMemoryAccesses.recordProc)
                return;

            var value = info.getIntVal("si_arg");
            var typeRead = QKeyValue.FindStringAttribute(cmd.Attributes, "read");
            if (typeRead != null)
            {
                memReads.InitAndAdd(value, line);                
                memReadsCS.InitAndAdd(value, captureStateIndex - 1);
                memType.InitAndAdd(value, typeRead);
            }
            var typeWritten = QKeyValue.FindStringAttribute(cmd.Attributes, "write");
            if (typeWritten != null)
            {
                memWrites.InitAndAdd(value, line);
                memWritesCS.InitAndAdd(value, captureStateIndex - 1);
                memType.InitAndAdd(value, typeWritten);
            }
            var scalarWritten = QKeyValue.FindStringAttribute(cmd.Attributes, "scalar");
            if (scalarWritten != null)
            {
                scalarWrites.InitAndAdd(captureStateIndex - 1, 
                    string.Format("{0} := {1}; ", scalarWritten, value));
            }
        }

        private static void printInfo(Cmd cmd, InstrInfo info, string procName)
        {
            var file = "?";
            var line = 0;
            var extra = "Atomic Continuation";
            string am = null;

            updatePermanentVars(info);

            var ccmd = cmd as CallCmd;
            if (ccmd != null && ccmd.callee == "boogie_si_record_li2bpl_int")
            {
                var cexpr = QKeyValue.FindStringAttribute(ccmd.Attributes, "cexpr");
                if (cexpr == null || cexpr == "") return;
                if (info == null || !info.hasIntVar("si_arg")) return;
                dataValuesCurrent += string.Format("^{0}={1}", cexpr.Replace(' ', '_'), info.getIntVal("si_arg"));
                return;
            }
            if (ccmd != null && ccmd.callee == "boogie_si_record_li2bpl_bv32")
            {
                var cexpr = QKeyValue.FindStringAttribute(ccmd.Attributes, "cexpr");
                if (cexpr == null || cexpr == "") return;
                if (info == null || !info.hasVar("si_arg")) return;
                dataValuesCurrent += string.Format("^{0}={1}", cexpr.Replace(' ', '_'), info.getVal("si_arg"));
                return;
            }

            var acmd = cmd as PredicateCmd;
            if (acmd == null)
            {
                return;
            }

            var index = QKeyValue.FindIntAttribute(acmd.Attributes, "sI", -1);
            if (index != -1)
            {
                var si = sourceInfo[index];
                file = si.file;
                line = si.line;
                extra = si.extra;
                am = si.am;
            }
            else
            {
                var attr = BoogieUtil.getAttr("sourceloc", acmd.Attributes);

                if (attr != null && attr.Count == 3)
                {
                    file = attr[0] as string;
                    var tt = attr[1] as LiteralExpr;
                    if (tt != null && (tt.Val is Microsoft.Basetypes.BigNum))
                        line = ((Microsoft.Basetypes.BigNum)(tt.Val)).ToInt;
                }
                else
                {
                    file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourceFile");
                    if (file == null) file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile");
                    line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceLine", -1);
                    if (line == -1) line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceline", -1);
                    extra = QKeyValue.FindStringAttribute(acmd.Attributes, "print");
                    am = QKeyValue.FindStringAttribute(acmd.Attributes, "abortM");
                }
            }

            if (file == null || line == -1) return;
            if (extra == null) extra = "Atomic Continuation";

            if (!file.EndsWith(".slic") && file != "?" && !file.EndsWith("sdv-harness.c"))
                lastDriverLocation = Tuple.Create(file, procName, line);

            if (am != null)
            {
                abortMessage = am;
                abortMessageLocation = lastDriverLocation == null ? null :
                    string.Format("\"{0}\" {1} {2}", lastDriverLocation.Item1, lastDriverLocation.Item2, lastDriverLocation.Item3);
            }

            // TODO: this stuff for stack file should be done in li2bpl
            if (extra != null && extra.StartsWith("Call") && !file.EndsWith(".slic") && file != "?" && !file.EndsWith("sdv-harness.c"))
            {
                var match = callRegEx.Match(extra);
                if (match.Success && match.Groups.Count == 3 && !match.Groups[1].Value.StartsWith("SLIC_"))
                {
                    stackFile.WriteLine("{0,-25} {1}", 
                        string.Format("[{0}@{1}]", Path.GetFileName(file), line), 
                        string.Format("{0} calls {1}", match.Groups[1].Value, match.Groups[2].Value));
                }

            }

            var permVars = printPermanentVars();
            var extraMsg = extra.Replace("\\\"", "\"");
            if (extraMsg.StartsWith("Call \"main\" "))
                permVars += aliasingPre;

            if (relevantLines != null)
            {
                if (relevantLines.Contains(Tuple.Create(file, line)))
                    dataValuesCurrent += "_sdvRelevantTraceLine_";
                else
                    dataValuesCurrent += "_sdvIrrelevantTraceLine_";
            }

            if (failingLocation != null)
            {
                if (failingLocation.Equals(Tuple.Create(file, line)))
                {
                    if (failStatus.Equals(mustFail))
                        dataValuesCurrent += "_sdvMustFailLocation_";
                    else if (failStatus.Equals(notmustFail))
                        dataValuesCurrent += "_sdvNotMustFailLocation_";
                }
            }

            pathFile.WriteLine("{0} \"{1}\" {2} true {3}^====Auto====={4} {5}", gcnt, file, line, dataValuesCurrent, permVars, extraMsg);
            gcnt++;
            captureStateIndex++;
            dataValuesCurrent = "";
        }

        private static void updatePermanentVars(InstrInfo info)
        {
            if (info == null) return;
            foreach (var v in permanentVars)
            {
                if (!info.hasVar(v)) continue;
                dataValuesPermanent[v] = info.getVal(v).ToString();
            }
        }

        private static string printPermanentVars()
        {
            var ret = "";
            foreach (var kvp in dataValuesPermanent)
            {
                ret += string.Format("^{0}={1}", kvp.Key.Replace(' ', '_'), kvp.Value.Replace(' ', '_'));
            }
            return ret;
        }

        private static string getStartingLine(ErrorTrace trace)
        {
            Implementation impl = nameImplMap[trace.procName];
            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);

            // Walk through trace and impl in lock step
            foreach (var tblk in trace.Blocks)
            {
                Block pblk = nameBlockMap[tblk.blockName];

                int pcnt = 0;
                foreach (var tcmd in tblk.Cmds)
                {
                    var inf = getLineInfo(pblk.Cmds[pcnt]);
                    if (inf != null) return inf;
                    pcnt++;
                }
            }

            return "?";
        }

        private static string getLineInfo(Cmd cmd)
        {
            var file = "?";
            var line = 0;

            var acmd = cmd as AssertCmd;
            if (acmd == null)
            {
                return null;
            }

            file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourceFile");
            if (file == null) file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile");
            line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceLine", -1);
            if (line == -1) line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceline", -1);

            if (file == null || line == -1) return null;
            if (file == "?") return null;

            return file + " " + line;
        }

        
    }

    // For printing a program and a path in it. The output can be pulled in by
    // concurrency explorer.
    public static class PrintProgramPath
    {
        private static List<WorkItem> stack;
        private static string fileName;
        private static Dictionary<string, Implementation> nameImplMap;
        private static TokenTextWriter pathFile;
        private static int eventID;

        public static void print(PersistentProgram program, ErrorTrace trace, string file)
        {
            setupPrint(program, trace, file);
            printProcTrace(trace);
            pathFile.Close();
        }

        private static void setupPrint(PersistentProgram program, ErrorTrace trace, string file)
        {
            // Set output files
            pathFile = new TokenTextWriter(file + "_trace.txt");
            program.writeToFile(file + ".bpl");
            Program prog = program.getProgram();

            // Initialization
            fileName = file + ".bpl";
            nameImplMap = BoogieUtil.nameImplMapping(prog);
            stack = new List<WorkItem>();
            eventID = 1;

            pathFile.WriteLine("s");
            pathFile.WriteLine("#");
        }

        // Prints trace by recursively calling itself on calleeTraces
        private static void printProcTrace(ErrorTrace trace) {
            Debug.Assert(trace.Blocks.Count != 0);
            Implementation impl = nameImplMap[trace.procName];
            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);
            stack.Insert(0, new WorkItem(trace.procName, null));

            // Walk through trace and impl in lock step
            foreach (var tblk in trace.Blocks)
            {
                Block pblk = nameBlockMap[tblk.blockName];
                stack[0].tok = pblk.tok as Token;
                printLine();
                
                int pcnt = 0;
                foreach (var tcmd in tblk.Cmds)
                {
                    stack[0].tok = pblk.Cmds[pcnt].tok as Token;

                    if (tcmd.isCall())
                    {
                        Debug.Assert(pblk.Cmds[pcnt] is CallCmd);
                        CallInstr cc = tcmd as CallInstr;

                        printLine(tcmd.info, cc.asyncCall ? "FORK" : "");
                        if (cc.hasCalledTrace)
                        {
                            printProcTrace(cc.calleeTrace);
                            if (cc.calleeTrace.returns) printLine();
                        }
                    }
                    else
                    {
                        printLine(tcmd.info);
                    }

                    pcnt++;
                }
            }
            stack.RemoveAt(0);
        }

        public class WorkItem
        {
            public string procName;
            public Token tok;

            public WorkItem(string p, Token t)
            {
                procName = p;
                tok = t;
            }
        }

        private static void printLine()
        {
            printLine("");
        }

        private static void printLine(InstrInfo info)
        {
            printLine(info, "");
        }

        private static void printLine(InstrInfo info, string extra)
        {
            var str = "";
            if (info != null && info is AssertFailInstrInfo)
            {
                str += "Assert Failed! ";
            }

            if (info != null)
            {
                str += info.ToString();
            }

            printLine(str + extra);
        }

        private static void printLine(string extra)
        {
            var stk = printStack();
            pathFile.WriteLine("1 " + eventID.ToString() + " 3 1 c");
            pathFile.WriteLine("1 " + eventID.ToString() + " 6 " + stk.Length.ToString() + " " + stk);
            if (extra != "")
            {
                pathFile.WriteLine("1 " + eventID.ToString() + " 4 " + extra.Length.ToString() + " " + extra);
            }
            eventID++;
        }

        // Convert stack to a string
        private static string printStack()
        {
            string ret = "";

            foreach (var wi in stack)
            {
                ret += wi.procName + "|" + fileName + "|" + wi.tok.line + "|";
            }

            return ret;
        }
    }

    public class InlineToTrace : Inliner
    {
        private static Stack<Dictionary<int, ErrorTrace>> traceStack = new Stack<Dictionary<int, ErrorTrace>>();

        public InlineToTrace(Program program, InlineCallback cb)
            :base(program, cb, -1)
        { }

        // Return callCmd -> callee trace
        static Dictionary<int, ErrorTrace> FindCallsOnTrace(Implementation impl, ErrorTrace trace)
        {
            Debug.Assert(impl.Name == trace.procName);
            var ret = new Dictionary<int, ErrorTrace>();
            var labelToBlock = BoogieUtil.labelBlockMapping(impl);
            foreach (var blk in trace.Blocks)
            {
                var pblk = labelToBlock[blk.blockName];
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var cc = blk.Cmds[i] as CallInstr;
                    if (cc == null || cc.calleeTrace == null)
                        continue;
                    
                    Debug.Assert(pblk.Cmds[i] is CallCmd && QKeyValue.FindIntAttribute((pblk.Cmds[i] as CallCmd).Attributes, "InlineToTraceUniqueId", -1) != -1);
                    ret.Add(QKeyValue.FindIntAttribute((pblk.Cmds[i] as CallCmd).Attributes, "InlineToTraceUniqueId", -1), cc.calleeTrace);
                }
            }

            return ret;
        }

        static int uniqueId = 0;

        static void AnnotateUniqueId(Implementation impl)
        {
            impl.Blocks
                .Iter(blk => blk.Cmds.OfType<CallCmd>()
                    .Iter(c => 
                        c.Attributes = new QKeyValue(Token.NoToken, "InlineToTraceUniqueId", 
                            new object[] { Expr.Literal(uniqueId++) }.ToList(), c.Attributes)));
        }

        public static void Inline(Program program, ErrorTrace trace)
        {
            var TopLevelDeclarations = program.TopLevelDeclarations;

            foreach (var d in TopLevelDeclarations)
            {
                var impl = d as Implementation;
                if (impl != null)
                {
                    impl.OriginalBlocks = impl.Blocks;
                    impl.OriginalLocVars = impl.LocVars;
                    AnnotateUniqueId(impl);
                }
            }
            var entry = 
            TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));
            if (entry.Count() != 1)
                throw new InternalError("InlineToTrace requires a unique entry poiny");
            var entryPoint = entry.First();
            if (entryPoint.Name != trace.procName)
                throw new InternalError("InlineToTrace didn't find the entry point for the given trace properly");

            var inliner = new InlineToTrace(program, null);

            traceStack.Push(FindCallsOnTrace(entryPoint, trace));
            Inliner.ProcessImplementation(program, entryPoint, inliner);

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.OriginalBlocks = null;
                impl.OriginalLocVars = null;

                // rename blocks and variables to avoid future naming conflicts with inlining
                var rename = new RenameLabelsAndVariables();
                impl.LocVars.Iter(v => rename.VisitVariable(v));
                rename.VisitBlockList(impl.Blocks);
            }
        }
        
        public override List<Block> DoInlineBlocks(List<Block> blocks, ref bool inlinedSomething)
        {
            var ret = base.DoInlineBlocks(blocks, ref inlinedSomething);
            traceStack.Pop();
            return ret;
        }

        protected override int GetInlineCount(CallCmd callCmd, Implementation impl)
        {
            var id = QKeyValue.FindIntAttribute(callCmd.Attributes, "InlineToTraceUniqueId", -1);
            if (id == -1) return -1;
            var loc = traceStack.Peek();
            if (!loc.ContainsKey(id)) return -1;
            traceStack.Push(FindCallsOnTrace(impl, loc[id]));
            recursiveProcUnrollMap[impl.Name] = 1;
            return 1;

        }
        
        // Change "inline$" to "itt$inline$" in block labels and 
        class RenameLabelsAndVariables : FixedVisitor
        {
            public RenameLabelsAndVariables() { }
            
            public override Expr VisitIdentifierExpr(IdentifierExpr node)
            {
                if (node.Name.StartsWith("inline$"))
                {
                    node.Name = "itt$" + node.Name;
                }
                return base.VisitIdentifierExpr(node);
            }
            
            public override LocalVariable VisitLocalVariable(LocalVariable node)
            {
                if (node.Name.StartsWith("inline$"))
                {
                    node.Name = "itt$" + node.Name;
                }
                node.TypedIdent.Name = node.Name;

                return base.VisitLocalVariable(node);
            }


            public override Block VisitBlock(Block node)
            {
                if (node.Label.StartsWith("inline$"))
                {
                    node.Label = "itt$" + node.Label;
                }

                return base.VisitBlock(node);
            }

            public override GotoCmd VisitGotoCmd(GotoCmd node)
            {
                var ss = node.labelNames;
                node.labelNames = new List<String>();
                ss.OfType<string>().Iter(s =>
                    {
                        if (s.StartsWith("inline$"))
                            node.labelNames.Add("itt$" + s);
                        else
                            node.labelNames.Add(s);
                    });
                return base.VisitGotoCmd(node);
            }
        }
    }
}
