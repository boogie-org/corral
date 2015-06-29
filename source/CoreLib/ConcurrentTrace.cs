using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using System.IO;

namespace cba
{
    // For printing a program and a  concurrent  path in it. The output can be pulled in by
    // concurrency explorer.
    public static class PrintConcurrentProgramPath
    {
        private static string fileName;
        private static Dictionary<string, Implementation> nameImplMap;
        private static TokenTextWriter pathFile;
        private static List<Event> events;
        private static Dictionary<int, List<WorkItem>> threadStacks;
        private static int tidCounter = 0;
        public static Dictionary<Duple<string, string>, Tuple<string, string, string>> mapCTrace = null;

        // Print data values
        public static int printData = 0;

        // Number of LOC on the trace
        public static int LOC = 0;

        // Printing on console or for concurrency explorer
        private static bool printConsole = true;


        // Print an interleaved trace, using the execution context information present
        // in trace
        public static void print(PersistentCBAProgram program, ErrorTrace trace, string file)
        {
            trace = trace.Copy();
            ErrorTrace.fillInContextSwitchInfo(trace);

            printConsole = false;
            setupPrint(program, trace, file);
            collectAllEvents(trace);
            arrangeEvents();

            // compute LOC
            var stks = new HashSet<string>();
            foreach (var ev in events)
            {
                stks.Add(ev.filename + "::" + ev.lineno.ToString());
            }
            LOC = stks.Count;

            // Print the failing assert
            foreach (var ev in events)
            {
                if (ev.extra.Contains("ASSERTION FAILS"))
                {
                    Console.WriteLine("{0}({1},1): error PF5001: This assertion can fail", sanitizeFileName(ev.filename), ev.lineno);
                }
            }
            Console.WriteLine();

            foreach (var ev in events)
            {
                ev.printEvent();
            }

            if(pathFile != null) pathFile.Close();
        }

        // Print an interleaved trace, using the execution context information present
        // in trace
        public static void print(Program program, ErrorTrace trace, string file)
        {
            ErrorTrace.fillInContextSwitchInfo(trace);

            printConsole = true;
            initialize(program, trace, file);
            collectAllEvents(trace);
            arrangeEvents();

            // Print the failing assert
            foreach (var ev in events)
            {
                if (ev.extra.Contains("ASSERTION FAILS"))
                {
                    Console.WriteLine("{0}({1},1): error PF5001: This assertion can fail", sanitizeFileName(ev.filename), ev.lineno);
                }
            }
            Console.WriteLine();

            Console.WriteLine("Execution trace:");
            Console.WriteLine("Format: (tid,k)  filename(line,col): blockName   (extra info)");
            foreach (var ev in events)
            {
                if (!ev.committed)
                {
                    continue;
                }

                if (ev.extra != "")
                {
                    ev.extra = "(" + ev.extra + ")";
                }

                Console.WriteLine("({0},{1})  {2}  {3}", ev.tid, ev.k, ev.stk, ev.extra);
            }
        }

        private static string sanitizeFileName(string fname)
        {
            var split = fname.Split('\\');
            return split[split.Length - 1];
        }

        // Gathers source info from "assert {:sourcefile "file"} {:sourceline n} true;"
        // Strips out the source info and breaks blocks to that each block corresponds to one source line.
        public static void gatherCSourceLineInfo(Program program)
        {
            // Read the orignal file gathering a mapping: 
            //   {bpl proc name, bpl block name} -> {C file, line num}
            mapCTrace = new Dictionary<Duple<string, string>, Tuple<string, string, string>>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    splitBlocksForSourceInfo(decl as Implementation);
                    gatherCSourceLineInfoImpl(decl as Implementation);
                }
            }
            //BoogieUtil.PrintProgram(program, "src.bpl");
        }

        static int blockCounter = 0;

        private static string getNewLabel()
        {
            blockCounter++;
            return "corral_source_split_" + blockCounter.ToString();
        }

        private static void splitBlocksForSourceInfo(Implementation impl)
        {
            var newBlocks = new List<Block>();
            foreach (var blk in impl.Blocks)
            {
                newBlocks.AddRange(splitBlockForSourceInfo(blk));
            }
            impl.Blocks = newBlocks;
        }

        private static List<Block> splitBlockForSourceInfo(Block block)
        {
            var ret = new List<Block>();

            var curr = new List<Cmd>();
            var label = block.Label;

            var origCmds = block.Cmds;
            var origTransfer = block.TransferCmd;

            if (origCmds.Count == 0)
            {
                ret.Add(block);
                return ret;
            }

            // Lets construct the list of cmds for the input block -- this is 
            // the list of cmds up to (and excluding):
            //   -- The first cmd with source info that is not the 0^th cmd
            var cnt = 0;
            for (cnt = 0; cnt < origCmds.Count; cnt++)
            {
                if (hasSourceInfo(origCmds[cnt]) && cnt != 0) break;
                curr.Add(origCmds[cnt]);
            }

            if (cnt == origCmds.Count)
            {
                ret.Add(block);
                return ret;
            }

            block.Cmds = curr;
            label = getNewLabel();
            block.TransferCmd = BoogieAstFactory.MkGotoCmd(label);
            ret.Add(block);

            curr = new List<Cmd>();
            
            // Now for the rest of the cmds
            while (cnt < origCmds.Count)
            {
                Debug.Assert(hasSourceInfo(origCmds[cnt]));
                curr.Add(origCmds[cnt]);
                cnt++;

                for (; cnt < origCmds.Count; cnt++)
                {
                    if (hasSourceInfo(origCmds[cnt])) break;
                    curr.Add(origCmds[cnt]);
                }
                var next = getNewLabel();
                ret.Add(new Block(Token.NoToken, label, curr, BoogieAstFactory.MkGotoCmd(next)));

                label = next;
                curr = new List<Cmd>();
            }

            ret.Last().TransferCmd = origTransfer;

            return ret;
        }

        private static void gatherCSourceLineInfoImpl(Implementation implementation)
        {
            foreach (var blk in implementation.Blocks)
            {
                List<Cmd> nseq = new List<Cmd>();
                foreach (Cmd cmd in blk.Cmds)
                {
                    string file;
                    int line, col;
                    bool keepCmd;

                    var hasInfo = getSourceInfo(cmd, out file, out line, out col, out keepCmd);

                    if (keepCmd)
                    {
                        nseq.Add(cmd);
                    }

                    if(hasInfo)
                    {
                        var key = new Duple<string, string>(implementation.Name, blk.Label);
                        var value = new Tuple<string, string, string>(file, line.ToString(), col.ToString()); 
                        mapCTrace.Add(key, value);
                        if (printData == 2)
                        {
                            var capture = new AssumeCmd(Token.NoToken, Expr.True);
                            var par = new List<object>();
                            par.Add("corral_capture");
                            capture.Attributes = new QKeyValue(Token.NoToken, "captureState", par, null);
                            nseq.Add(capture);
                        }
                    }
                }
                blk.Cmds = nseq;
            }
        }

        private static bool hasSourceInfo(Cmd cmd)
        {
            string file;
            int line, col;
            bool kc;
            return getSourceInfo(cmd, out file, out line, out col, out kc);
        }

        public static bool getSourceInfo(Cmd cmd, out string file, out int line, out int column, out bool keepCmd)
        {
            file = null;
            line = -1;
            column = -1;
            keepCmd = true;

            var acmd = cmd as PredicateCmd;
            if (acmd == null)
            {
                return false;
            }

            var attr = BoogieUtil.getAttr("sourceloc", acmd.Attributes);

            if (attr != null && attr.Count == 3)
            {
                file = attr[0] as string;
                var tt = attr[1] as LiteralExpr;
                if (tt != null && (tt.Val is Microsoft.Basetypes.BigNum))
                    line = ((Microsoft.Basetypes.BigNum)(tt.Val)).ToInt;
                tt = attr[2] as LiteralExpr;
                if (tt != null && (tt.Val is Microsoft.Basetypes.BigNum))
                    column = ((Microsoft.Basetypes.BigNum)(tt.Val)).ToInt;                

            }
            else
            {
                file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourceFile");
                if (file == null) file = QKeyValue.FindStringAttribute(acmd.Attributes, "sourcefile");
                line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceLine", -1);
                if (line == -1) line = QKeyValue.FindIntAttribute(acmd.Attributes, "sourceline", -1);
            }

            if (file == null || line == -1)
                return false;            

            if (acmd.Expr is LiteralExpr && (acmd.Expr as LiteralExpr).IsTrue)
                keepCmd = false;

            return true;
        }

        // Print an interleaved trace, using the execution context information present
        // in trace. Link the trace to the original C files from which the bpl file was obtained
        public static void printCTrace(PersistentCBAProgram program, ErrorTrace trace, string file)
        {
            printCTrace(program, trace, file, true);
        }

        public static void printCTrace(PersistentCBAProgram program, ErrorTrace trace, string file, bool printConsole)
        {
            //gatherCSourceLineInfo(origInFile);
            Debug.Assert(mapCTrace != null);
            LOC = 0;

            print(program, trace, file);

            if (!printConsole)
                return;

            Console.WriteLine("Execution trace:");
            //Console.WriteLine("Format:  filename(line,col): threadid, k");
            var prev = "";
            foreach (var ev in events)
            {
                if (!ev.committed)
                {
                    continue;
                }

                if (ev.extra != "")
                {
                    ev.extra = "(" + ev.extra + ")";
                }

                var filename = sanitizeFileName(ev.filename);
                if (filename != null && filename != "")
                {
                    //var str = string.Format("{0}({1},{2}):  Thread={3}  K={4}:  {5}", filename, ev.lineno, 1, ev.tid, ev.k, ev.extra);
                    var str = string.Format("{0}({1},{2}): Trace: Thread={3}  {4}", filename, ev.lineno, ev.col == -1? 1 : ev.col, ev.tid, ev.extra);
                    if (str != prev)
                    {
                        Console.WriteLine(str);
                    }
                    prev = str;
                }
            }

        }

        private static void setupPrint(PersistentCBAProgram program, ErrorTrace trace, string file)
        {
            // Set output files
            pathFile = file == null ? null : new TokenTextWriter(file + "_trace.txt");
            if(pathFile != null) program.writeToFile(file + ".bpl");
            Program prog = program.getProgram();

            // Initialization
            initialize(prog, trace, file == null ? null : file + ".bpl");

            if (pathFile != null) pathFile.WriteLine("s");
            if (pathFile != null) pathFile.WriteLine("#");
        }

        private static void initialize(Program program, ErrorTrace trace, string filename)
        {
            // Initialization
            fileName = filename == null ? "null" : filename;
            nameImplMap = BoogieUtil.nameImplMapping(program);
            events = new List<Event>();
            threadStacks = new Dictionary<int, List<WorkItem>>();
            tidCounter = 0;

            varNamesChanged = false;
            varNameMap = new Dictionary<string, string>();
            var globals = BoogieUtil.GetGlobalVariables(program);
            globals.Iter(g => varNameMap.Add(g.Name + "__0", g.Name));
        }

        // Model variable names changed?
        private static bool varNamesChanged = false;
        private static Dictionary<string, string> varNameMap;

        // Prints trace by recursively calling itself on calleeTraces. This assumes
        // that info in each of the ErrorTraceInstr is valid.
        // Returns the value of k at the end of the trace
        private static int collectAllEvents(ErrorTrace trace)
        {
            Debug.Assert(trace.Blocks.Count != 0);
            int k = 0, tid = 1;

            Implementation impl = nameImplMap[trace.procName];
            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);
            lastCLocation = null;

            var first_block = true;
            // Walk through trace and impl in lock step
            foreach (var tblk in trace.Blocks)
            {
                Block pblk = nameBlockMap[tblk.blockName];
                fetchInfo(tblk.info, out k, out tid);

                if (first_block)
                {
                    pushWI(tid, new WorkItem(trace.procName, null, null));
                }
                first_block = false;

                updateWI(tid, pblk.tok as Token);
                updateWI(tid, pblk.Label);

                updateCLocation(tid);

                var assertFails = "";
                if (tblk.info is AssertFailInstrInfo)
                {
                    var extra = (tblk.info is RequiresFailInstrInfo) ? ": Requires" :
                        (tblk.info is EnsuresFailInstrInfo) ? ": Ensures" : "";
                    assertFails = "ASSERTION FAILS" + extra;
                }

                events.Add(new Event(k, tid, printStack(tid), getFileName(tid), getLineNo(tid), getColNo(tid), assertFails, true));

                int pcnt = 0;
                int tcnt = 0;
                foreach (var tcmd in tblk.Cmds)
                {
                    fetchInfo(tcmd.info, out k, out tid);
                    updateWI(tid, pblk.Cmds[pcnt].tok as Token);

                    assertFails = "";
                    if (tcmd.info is AssertFailInstrInfo)
                    {
                        var extra = (tcmd.info is RequiresFailInstrInfo) ? ": Requires" :
                            (tcmd.info is EnsuresFailInstrInfo) ? ": Ensures" : "";
                        assertFails = "ASSERTION FAILS " + (pblk.Cmds[pcnt].ToString()) + " " + extra;
                    }

                    if (tcmd.info is ModelInstrInfo)
                    {
                        assertFails = tcmd.info.ToString();
                        changeVarNames((tcmd.info as ModelInstrInfo).model);
                    }

                    if (tcmd.info is PrintInstrInfo)
                    {
                        assertFails += tcmd.info.ToString();
                    }
                   
                    if (tcmd.isCall())
                    {
                        Debug.Assert(pblk.Cmds[pcnt] is CallCmd);
                        
                        CallInstr cc = tcmd as CallInstr;
                        string callstr = string.Format("{0} {1}", cc.asyncCall ? "FORK" : "CALL", (pblk.Cmds[pcnt] as CallCmd).Proc.Name);
                        if (!cc.hasCalledTrace)
                        {
                            callstr = "";
                            if (cc.callee.StartsWith(VerificationPass.recordArgProcPrefix))
                            {
                                var cmd = pblk.Cmds[pcnt] as CallCmd;
                                Debug.Assert(cmd.Ins.Count == 1);
                                var prefix = QKeyValue.FindStringAttribute(cmd.Attributes, "cexpr");
                                if (prefix == null) prefix = "v";
                                prefix += " = ";
                                if (cc.info.hasVar("si_arg"))
                                {
                                    callstr += prefix + cc.info.getVal("si_arg").ToString();
                                }
                            }
                        }

                        var leftOverForReturn = "";
                        if (assertFails != "" && callstr != "")
                        {
                            // This can only be because of a failed requires/ensures
                            leftOverForReturn = assertFails;
                        }
                        else
                        {
                            callstr = callstr + assertFails;
                        }

                        events.Add(new Event(k, tid, printStack(tid), getFileName(tid), getLineNo(tid), getColNo(tid), callstr, true));

                        if (cc.hasCalledTrace)
                        {
                            int oldk = k;
                            k = collectAllEvents(cc.calleeTrace);
                            if (cc.asyncCall)
                            {
                                k = oldk;
                            }

                            if (cc.calleeTrace.returns)
                            {
                                var extra = "";
                                if (!cc.asyncCall)
                                {
                                    extra = "RETURN from " + (pblk.Cmds[pcnt] as CallCmd).Proc.Name;
                                    extra += " " + leftOverForReturn;
                                }
                                events.Add(new Event(k, tid, printStack(tid), getFileName(tid), getLineNo(tid), getColNo(tid), extra, true));
                            }
                        }
                    }
                    else
                    {
                        events.Add(new Event(k, tid, printStack(tid), getFileName(tid), getLineNo(tid), getColNo(tid), "" + assertFails, true));
                    }

                    pcnt++;
                    tcnt++;
                }
            }
            if (first_block == false)
            {
                popWI(tid);
            }
            return k;
        }

        private static void changeVarNames(Model model)
        {
            if (varNamesChanged) return;
            // Drop "__0" from variables
            model.ChangeVariableNames(varNameMap);
            varNamesChanged = true;

            // print the model
            var wr = new StreamWriter("corral_out_data.bvd", false);
            model.Write(wr);
            wr.Close();
        }

        private static void fetchInfo(InstrInfo info, out int k, out int tid)
        {
            Debug.Assert(info.executionContext >= 0);
            Debug.Assert(info.tid >= 0);
            k = info.executionContext;
            tid = info.tid;
        }

        private static int getNewTid()
        {
            return ++tidCounter;
        }

        private class Event
        {
            public int k;
            public int tid;
            public string stk;
            public string extra;
            public bool committed; // true -> committed; false -> pre-empted
            public int eid;
            public int lineno;
            public int col;
            public string filename;
            private static string lastEvent = "";

            public Event(int k, int tid, string stk, string filename, int lineno, int col, string extra, bool committed)
            {
                this.k = k;
                this.tid = tid;
                this.stk = stk;
                this.filename = filename;
                this.lineno = lineno;
                this.col = col;
                this.extra = extra;
                this.committed = committed;
                eid = -1;
            }

            public Event Copy()
            {
                var ev = new Event(k, tid, stk, filename, lineno, col, extra, committed);
                ev.eid = eid;
                return ev;
            }

            public static int compareEvents(Event a, Event b)
            {
                if (a.eid < b.eid) return -1;
                if (a.eid > b.eid) return 1;
                return 0;
            }

            public void printEvent()
            {
                if (stk == "")
                {
                    return;
                }

                // If this event is the same as the last one (without looking at eid), then
                // don't print it
                var check = getString(0, extra);
                if (check == lastEvent)
                {
                    return;
                }
                lastEvent = check;

                if(pathFile != null) pathFile.Write(getString(eid, extra));
            }

            private void printToFile(string str)
            {
                if(pathFile != null) pathFile.Write(str);
            }

            private string getString(int eid, string extra)
            {
                var toPrint = "";
                toPrint += tid.ToString() + " " + eid.ToString() + " 3 1 " + (committed ? "c" : "p") + "\n";
                if (committed)
                {
                    toPrint += tid.ToString() + " " + eid.ToString() + " 6 " + stk.Length.ToString() + " " + stk + "\n";
                    if (extra != "")
                    {
                        toPrint += tid.ToString() + " " + eid.ToString() + " 4 " + extra.Length.ToString() + " " + extra + "\n";
                    }
                }
                return toPrint;
            }

        }
        /*
        private static void arrangeEventsOld()
        {
            // Check that all events are valid
            events.Iter(ev => Debug.Assert(ev.tid > 0 && ev.k >= 0));

            // Split the list of events based on tid and k
            var conEvents = new Dictionary<int, Dictionary<int, List<Event>>>();
            foreach (var ev in events)
            {
                if (!conEvents.ContainsKey(ev.tid))
                {
                    conEvents.Add(ev.tid, new Dictionary<int, List<Event>>());
                }

                if (!conEvents[ev.tid].ContainsKey(ev.k))
                {
                    conEvents[ev.tid].Add(ev.k, new List<Event>());
                }

                conEvents[ev.tid][ev.k].Add(ev);
            }

            // Add "finished" events to every thread
            foreach (var tp in conEvents)
            {
                var tid = tp.Key;
                // Find last event of the thread
                if (tp.Value.Count == 0)
                    continue;
                var levent = tp.Value.Last();
                var ev = levent.Value.Last();

                // Make a copy of it and insert it in the end
                ev = ev.Copy();
                ev.extra = "Done";
                levent.Value.Add(ev);
            }

            // Event ID counter
            int eid = 1;
            // Current execution context to print
            int k = 0;
            // Number of events printed
            int printed = 0;

            var newEvents = new List<Event>();

            while (printed < events.Count)
            {
                foreach (var tp in conEvents)
                {
                    if (!tp.Value.ContainsKey(k))
                        continue;

                    var ls = tp.Value[k];

                    foreach (var ev in ls)
                    {
                        ev.eid = eid;
                        newEvents.Add(ev);
                        eid++;
                        printed++;
                    }
                }
                k++;
            }

            events = newEvents;
        }
        */
        private static void arrangeEvents()
        {
            // Check that all events are valid
            events.Iter(ev => Debug.Assert(ev.tid > 0 && ev.k >= 0));

            // Split the list of events based on k. 
            // Also construct a map from k to the set of threads that
            // have their last event at that k
            var conEvents = new Dictionary<int, List<Event>>(); // k -> List<Event>
            var lastEventTemp = new Dictionary<int, int>(); // tid -> k
            var lastEvent = new Dictionary<int, HashSet<int>>(); // k -> HashSet<tid>
            foreach (var ev in events)
            {
                if (!conEvents.ContainsKey(ev.k))
                {
                    conEvents.Add(ev.k, new List<Event>());
                }

                conEvents[ev.k].Add(ev);

                if (!lastEventTemp.ContainsKey(ev.tid))
                {
                    lastEventTemp.Add(ev.tid, ev.k);
                }
                else
                {
                    lastEventTemp[ev.tid] = ev.k;
                }

            }

            foreach (var tp in lastEventTemp)
            {
                if (!lastEvent.ContainsKey(tp.Value))
                {
                    lastEvent.Add(tp.Value, new HashSet<int>());
                }
                lastEvent[tp.Value].Add(tp.Key);
            }

            // Add "finished" events to every thread
            foreach (var tp in lastEvent)
            {
                var ls = conEvents[tp.Key];
                var tids = new HashSet<int>();
                tids.UnionWith(tp.Value);

                var newls = new List<Event>();
                for (int i = ls.Count - 1; i >= 0; i--)
                {
                    if (tids.Contains(ls[i].tid))
                    {
                        // We're at the last event of thread ls[i].tid
                        var ev = ls[i].Copy();
                        ev.extra = "Done";
                        newls.Add(ev);
                        newls.Add(ls[i]);
                        tids.Remove(ls[i].tid);
                    }
                    else
                    {
                        newls.Add(ls[i]);
                    }
                }

                newls.Reverse();

                conEvents[tp.Key] = newls;
            }

            // Event ID counter
            int eid = 1;

            var newEvents = new List<Event>();

            foreach (var tp in conEvents)
            {
                foreach (var ev in tp.Value)
                {
                    ev.eid = eid;
                    newEvents.Add(ev);
                    eid++;
                }
            }

            events = newEvents;
        }


        private class WorkItem
        {
            public string procName;
            public string blockName;
            public Token tok;

            public WorkItem(string p, string b, Token t)
            {
                procName = p;
                blockName = b;
                tok = t;
            }
        }

        private static void pushWI(int tid, WorkItem wi)
        {
            if (!threadStacks.ContainsKey(tid))
            {
                threadStacks.Add(tid, new List<WorkItem>());
            }
            threadStacks[tid].Insert(0, wi);
        }

        private static void updateWI(int tid, Token tok)
        {
            Debug.Assert(threadStacks.ContainsKey(tid));
            threadStacks[tid][0].tok = tok;
        }

        private static void updateWI(int tid, string _blockName)
        {
            Debug.Assert(threadStacks.ContainsKey(tid));
            threadStacks[tid][0].blockName = _blockName;
        }

        private static WorkItem popWI(int tid)
        {
            Debug.Assert(threadStacks.ContainsKey(tid));
            Debug.Assert(threadStacks[tid].Count != 0);
            var ret = threadStacks[tid][0];
            threadStacks[tid].RemoveAt(0);
            return ret;
        }

        private static Tuple<string, string, string> lastCLocation = null;

        private static void updateCLocation(int tid)
        {
            if (mapCTrace == null) return;

            var wi = threadStacks[tid][0];
            var key = new Duple<string, string>(wi.procName, wi.blockName);
            if (!mapCTrace.ContainsKey(key))
            {
                if (lastCLocation != null)
                    mapCTrace.Add(key, lastCLocation);
            }
            else
            {
                lastCLocation = mapCTrace[key];
            }
        }

        // Convert stack to a string
        private static string printStack(int tid)
        {
            string ret = "";
            Debug.Assert(threadStacks.ContainsKey(tid));

            if (printConsole)
            {
                // Calculate indent
                var indent = threadStacks[tid].Count + 1;
                for (int i = 0; i < indent; i++)
                {
                    ret = " " + ret;
                }
                var token = threadStacks[tid][0].tok;

                ret += string.Format("{0}({1},{2}): {3}", fileName, token.line, token.col, threadStacks[tid][0].blockName);
                return ret;
            }

            if (mapCTrace == null)
            {
                foreach (var wi in threadStacks[tid])
                {
                    ret += wi.procName + "|" + fileName + "|" + wi.tok.line + "|";
                }
            }
            else
            {
                var fstwi = threadStacks[tid][0];
                if (!mapCTrace.ContainsKey(new Duple<string, string>(fstwi.procName, fstwi.blockName)))
                {
                    return "";
                }

                foreach (var wi in threadStacks[tid])
                {
                    var key = new Duple<string, string>(wi.procName, wi.blockName);
                    if (!mapCTrace.ContainsKey(key))
                    {
                        continue;
                    }

                    var file = mapCTrace[key].Item1;
                    var line = mapCTrace[key].Item2;
                    //var col = mapCTrace[key].Item3;

                    if (file.Contains("corral_do_not_print"))
                    {
                        return "";
                    }

                    ret += wi.procName + "|" + file + "|" + line + "|";
                }
            }

            return ret;
        }

        private static int getLineNo(int tid)
        {
            int a,c;
            string b;
            getLineAndFile(tid, out a, out c, out b);
            return a;
        }

        private static int getColNo(int tid)
        {
            int a,c;
            string b;
            getLineAndFile(tid, out a, out c, out b);
            return c;
        }

        private static string getFileName(int tid)
        {
            int a,c;
            string b;
            getLineAndFile(tid, out a, out c, out b);
            return b;
        }

        private static void getLineAndFile(int tid, out int lineno, out int col, out string filename)
        {
            Debug.Assert(threadStacks.ContainsKey(tid));

            lineno = threadStacks[tid][0].tok.line;
            col = threadStacks[tid][0].tok.col;
            filename = threadStacks[tid][0].tok.filename;

            if (printConsole)
            {
                return;
            }

            if (mapCTrace != null)
            {
                var wi = threadStacks[tid][0];
                var key = new Duple<string, string>(wi.procName, wi.blockName);
                if (!mapCTrace.ContainsKey(key))
                {
                    filename = "";
                    lineno = 1;
                    return;
                }

                filename = mapCTrace[key].Item1;
                lineno = Int32.Parse(mapCTrace[key].Item2);
                col = Int32.Parse(mapCTrace[key].Item3);

                if (filename.Contains("corral_do_not_print"))
                {
                    filename = "";
                    lineno = 1;
                    col = 1;
                }
            }

        }

    }

}
