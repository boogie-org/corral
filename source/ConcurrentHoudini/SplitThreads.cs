using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using bpl = Microsoft.Boogie;

namespace ConcurrentHoudini
{
    /**
     * Given the raw input program, 
     * (1) Identifies thread entries
     * (2) Identifies the procedures belonging to each thread entry
     * (3) Clones procedures such that each procedure belongs to one thread only.
     * (4) Labels procedures with their thread.
     **/
    class SplitThreads
    {
        public SplitThreads(Context con, bool dbg = false)
        {
            this.con = con;
            this.dbg = dbg;
        }

        public bpl.Program split(bpl.Program prog)
        {
            originalProgram = prog;
            ////////////////// First identify the thread entries in the program ////////////////////
            // A procedure is a thread entry if there is any async call to it
            HashSet<string> threadEntries = new HashSet<string>();
            var impls = new Func<bpl.Program, IEnumerable<bpl.Implementation>>(p => from impl in p.TopLevelDeclarations where impl is bpl.Implementation select impl as bpl.Implementation);

            foreach (var impl in impls(originalProgram))
            {
                var cmdsRaw = from blk in impl.Blocks select blk.Cmds;
                var cmds = cmdsRaw.Aggregate(new List<bpl.Cmd>(), (curCmds, nextList) => { curCmds.AddRange(nextList); return curCmds; });
                var asyncCalls = from cmd in cmds where  con.isAsyncCall(cmd as bpl.Cmd) select cmd;
                foreach (bpl.Cmd asyncCall in asyncCalls)
                    threadEntries.Add((asyncCall as bpl.CallCmd).callee);
            }
            // Finally add the entry function also as a thread entry.
            threadEntries.Add(con.entryFunc);

            //////////////// Next, identify all the procedures belonging to each thread ////////////
            Dictionary<string, HashSet<string>> threadToProcs = new Dictionary<string, HashSet<string>>();
            // This is done in two steps.
            // First step: Find all non-async calls in each procedure.
            var procToCalls = new Dictionary<string, HashSet<string>>();
            //impls = from impl in prog.TopLevelDeclarations where impl is bpl.Implementation select impl as bpl.Implementation;
            foreach (var impl in impls(originalProgram))
            {
                procToCalls[impl.Name] = new HashSet<string>();
                var cmdsRaw = from blk in impl.Blocks select blk.Cmds;
                var cmds = cmdsRaw.Aggregate(new List<bpl.Cmd>(), (curCmds, nextList) => { curCmds.AddRange(nextList); return curCmds; });
                var syncCalls = from cmd in cmds where con.isSyncCall(cmd as bpl.Cmd) select cmd;
                foreach (bpl.Cmd syncCall in syncCalls)
                    procToCalls[impl.Name].Add((syncCall as bpl.CallCmd).callee);
            }
            // Second step: Find all procedures in each thread.
            foreach (var thr in threadEntries)
                threadToProcs[thr] = new HashSet<string>();
            foreach (var thr in threadEntries)
                findReachable(procToCalls, thr, threadToProcs[thr]);
            //DEBUGGING
            if (dbg)
            {
                System.Console.WriteLine("Threads in the original program:");
                foreach(var iter in threadToProcs)
                {
                    System.Console.Write(iter.Key + ": ");
                    foreach (var proc in iter.Value)
                        System.Console.Write(proc + " ");
                    System.Console.WriteLine();
                }
            }


            // [Optional]
            // Remove unreachable procs.
            // These procedures are neither reachable from Main, nor from a thread entry. They can obviously not be called in any execution.
            var reachableProcs = new HashSet<string>();
            foreach (var vals in threadToProcs.Values)
                foreach (var proc in vals)
                    reachableProcs.Add(proc);
            foreach (var val in threadToProcs.Keys)
                reachableProcs.Add(val);
            removeUnreachable(reachableProcs);

 

            //////////////// Finally, Actually split the procedures when needed //////////////////
            // For every procedure, find out how many threads contain it. We need as many copies of 
            // that procedure.
            // Note: We do not want to duplicate procedures without implementation. 
            //impls = from impl in prog.TopLevelDeclarations where impl is bpl.Implementation select impl as bpl.Implementation;
            var implNames = from impl in impls(originalProgram) select impl.Name;
            Dictionary<string, int> procCopies = new Dictionary<string,int>();
            var procs = from proc in originalProgram.TopLevelDeclarations where proc is bpl.Procedure select proc as bpl.Procedure;
            foreach (var proc in procs) procCopies[proc.Name] = 0;
            foreach (var iter in threadToProcs) 
                foreach (var proc in iter.Value) 
                    if(implNames.Contains(proc))
                        procCopies[proc]++;
            
            // Now duplicate
            // The new procedures and implementations for each thread
            // thread name --> (old procedure name --> new procedure)
            var newProcsPerThread = new Dictionary<string, Dictionary<string, bpl.Procedure>>();
            // thread name --> (old procedure name --> new implementation)
            var newImplsPerThread = new Dictionary<string, Dictionary<string, bpl.Implementation>>();
            // old name --> proc, old name --> impl
            var oldNameToImpl = new Dictionary<string, bpl.Implementation>();
            foreach (var impl in impls(originalProgram)) oldNameToImpl[impl.Name] = impl;
            var oldNameToProc = new Dictionary<string, bpl.Procedure>();
            foreach(var proc in procs) oldNameToProc[proc.Name] = proc;
            foreach (var elem in threadToProcs)
            {
                string threadName = elem.Key;
                newProcsPerThread[threadName] = new Dictionary<string, bpl.Procedure>();
                newImplsPerThread[threadName] = new Dictionary<string, bpl.Implementation>();
                foreach (var procName in elem.Value)
                {
                    if (procCopies[procName] > 1)
                    {
                        // We will duplicate this procedure.
                        // Make a copy of the procedure and implementation
                        var dup = new cba.Util.FixedDuplicator();
                        var impl = (bpl.Implementation)dup.VisitDeclaration(oldNameToImpl[procName]);
                        var proc = (bpl.Procedure)dup.VisitDeclaration(oldNameToProc[procName]);
                        impl.Proc = proc;

                        // Rename the new instances using thread id.
                        impl.Name = con.getSplitProcName(procName);
                        proc.Name = con.getSplitProcName(procName);
                        var origProcAttr = con.originalProcAttr(procName);
                        origProcAttr.Next = proc.Attributes;
                        proc.Attributes = origProcAttr;

                        // Also add an attribute to the definition specifying the thread.
                        var threadAttr = con.getThreadAttr(threadName);
                        threadAttr.Next = proc.Attributes;
                        proc.Attributes = threadAttr;
                        
                        //add to duplicated procedures/impls
                        newProcsPerThread[threadName][procName] = proc;
                        newImplsPerThread[threadName][procName] = impl;

                        //Add to the program
                        originalProgram.AddTopLevelDeclaration(proc);
                        originalProgram.AddTopLevelDeclaration(impl);

                        var s1 = new HashSet<string>();
                        var s2 = new HashSet<string>();
                        foreach (var im in originalProgram.TopLevelDeclarations.OfType<bpl.Implementation>())
                            s1.Add(im.Name);
                        foreach (var im in impls(originalProgram))
                            s2.Add(im.Name);

                        // We have split away the procedure calls for one thread.
                        procCopies[procName]--;
                    }
                    else if (procCopies[procName] == 1)
                    {
                        //We still need to rename this procedure 
                        var impl = oldNameToImpl[procName];
                        var proc = oldNameToProc[procName];

                        //rename the new instances using thread id.
                        impl.Name = con.getSplitProcName(procName);
                        proc.Name = con.getSplitProcName(procName);
                        var origProcAttr = con.originalProcAttr(procName);
                        origProcAttr.Next = proc.Attributes;
                        proc.Attributes = origProcAttr;

                        // Also add an attribute to the definition specifying the thread.
                        var threadAttr = con.getThreadAttr(threadName);
                        threadAttr.Next = proc.Attributes;
                        proc.Attributes = threadAttr;

                        //add to duplicated procedures/impls
                        newProcsPerThread[threadName][procName] = proc;
                        newImplsPerThread[threadName][procName] = impl;

                        // We have split away the procedure calls for one thread.
                        procCopies[procName]--;
                    }
                }
                // Tell con that we're done with one thread.
                con.nextThread();
            }

            // New re-route procedure calls as needed
            // First async calls.
            foreach (var impl in impls(originalProgram))
            {
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        bpl.Cmd cmd = blk.Cmds[i];
                        if (con.isAsyncCall(cmd))
                        {
                            var callCmd = cmd as bpl.CallCmd;
                            var newCallCmd = new bpl.CallCmd(bpl.Token.NoToken, newProcsPerThread[callCmd.callee][callCmd.callee].Name, callCmd.Ins, callCmd.Outs, callCmd.Attributes, callCmd.IsAsync);
                            newCallCmd.TypeParameters = callCmd.TypeParameters;
                            newCallCmd.Proc = newProcsPerThread[callCmd.callee][callCmd.callee];
                            blk.Cmds[i] = newCallCmd;
                        }
                    }
                }
            }
            // Now sync calls.
            foreach (var elem in newImplsPerThread)
            {
                string threadName = elem.Key;
                var newImpls = newImplsPerThread[threadName];
                foreach (var implTuple in newImpls)
                {
                    var impl = implTuple.Value;
                    foreach (var blk in impl.Blocks)
                    {
                        for (int i = 0; i < blk.Cmds.Count; ++i)
                        {
                            bpl.Cmd cmd = blk.Cmds[i];
                            if (con.isSyncCall(cmd) && newProcsPerThread[threadName].ContainsKey((cmd as bpl.CallCmd).callee))
                            {
                                var callCmd = cmd as bpl.CallCmd;
                                var newCallCmd = new bpl.CallCmd(bpl.Token.NoToken, newProcsPerThread[threadName][callCmd.callee].Name, callCmd.Ins, callCmd.Outs, callCmd.Attributes, callCmd.IsAsync);
                                newCallCmd.TypeParameters = callCmd.TypeParameters;
                                newCallCmd.Proc = newProcsPerThread[threadName][callCmd.callee];
                                blk.Cmds[i] = newCallCmd;
                            }
                        }
                    }
                }
            }

            // Finally, label the entry of each thread as thread entry.
            foreach (var elem in newProcsPerThread)
            {
                var proc = elem.Value[elem.Key];
                var threadEntryAttr = con.getThreadEntryAttr();
                threadEntryAttr.Next = proc.Attributes;
                proc.Attributes = threadEntryAttr;
            }

            return originalProgram;    
        }

        // Given the adjencency matrix (adj) for a digraph and a root node (r), this 
        // tail recursive procedure computes the set of reachable nodes from r in (reach).
        private void findReachable(Dictionary<string, HashSet<string>> adj, string r, HashSet<string> reach)
        {
            if (reach.Contains(r))
                return;
            // The current procedure may not have an implementation. We ignore such procedures.
            var impl = from i in originalProgram.TopLevelDeclarations
                       where i is bpl.Implementation && (i as bpl.Implementation).Name == r
                       select i;
            if (impl.Count() == 0)
                return;

            reach.Add(r);
            foreach (var next in adj[r])
                findReachable(adj, next, reach);
        }

        private void removeUnreachable(HashSet<string> reachable)
        {
            var toplvls = originalProgram.TopLevelDeclarations;
            originalProgram.TopLevelDeclarations = new List<bpl.Declaration>();
            var unreachableImpls = new HashSet<string>();

            foreach (var impl in toplvls.Where(decl => decl is bpl.Implementation)
                .Select(decl => decl as bpl.Implementation)
                .Where(im => !reachable.Contains(im.Name)))
            {
                unreachableImpls.Add(impl.Name);
            }
                
            foreach (var toplvl in toplvls)
            {
                if (!(toplvl is bpl.Implementation) && !(toplvl is bpl.Procedure))
                {
                    originalProgram.AddTopLevelDeclaration(toplvl);
                    continue;
                }
                var name = (toplvl as bpl.NamedDeclaration).Name;
                if (unreachableImpls.Contains(name))
                    System.Console.WriteLine("Removing Uncreachable Implementation " + name);
                else
                    originalProgram.AddTopLevelDeclaration(toplvl);
            }
        }

        Context con;
        bpl.Program originalProgram;
        bool dbg;
    }
}
