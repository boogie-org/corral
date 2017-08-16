using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using Microsoft.Boogie.GraphUtil;

namespace cba
{
    // Main storm instrumentation pass.
    // TODO: Split into multiple passes
    public class StormInstrumentationPass : CompilerPass
    {
        ProgramInfo pinfo;
        InstrumentationPolicy policy;
        public VariableManager vmgr { get; private set; }
        Instrumenter inst;

        // This pass does two transformations. We record both.
        InsertionTrans tinfo_instrument, tinfo_async;

        // A map of blocks to the value of k that they imply: if a block b
        // in procedure p has assume(k == i) command then (p::b,i) is inserted into the map
        Dictionary<string, int> blockExecutionContextMap;

        // A map from context switch location to the instruction in the original program
        // that caused its insertion
        public Dictionary<int, Triple<string, string, int>> csLocationMap
        {
            get
            {
                return inst.contextSwitchLocation;
            }
        }

        // A map from context switch location to the globals used in the
        // instruction that caused its insertion
        public Dictionary<int, HashSet<string>> csLocationGlobalsMap
        {
            get
            {
                return inst.contextSwitchLocationGlobalsRead;
            }
        }


        public string varKName
        {
            get
            {
                return vmgr.vark.Name;
            }
        }

        public string tidVarName
        {
            get
            {
                return vmgr.tidVar.Name;
            }
        }

        public string contextSwitchName
        {
            get
            {
                return vmgr.csProcName;
            }
        }

        public StormInstrumentationPass()
        {
            passName = "Storm instrumentation";
            pinfo = null;
            policy = null;
            vmgr = null;
            inst = null;
            tinfo_instrument = new InsertionTrans();
            tinfo_async = new InsertionTrans();
            blockExecutionContextMap = new Dictionary<string, int>();
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            if (p.mode == ConcurrencyMode.FixedContext)
            {
                InstrumentationConfig.addRaiseException = false;
            }

            // Step1: Gather program information
            pinfo = new ProgramInfo(p.mainProcName, p, LanguageSemantics.assertNotReachableName());

            TidArithmetic.reset();
            if (pinfo.threadIdType.IsBv)
            {
                TidArithmetic.useIntArithmetic = false;
                p.AddTopLevelDeclaration(TidArithmetic.getBvAdd());
                p.AddTopLevelDeclaration(TidArithmetic.getBvGt());
            }
            else
            {
                TidArithmetic.useIntArithmetic = true;
            }
            
            // Step2: Set up a variable manager
            vmgr = new VariableManager(pinfo);

            // Step3: Set up the instrumentation policy

            // The globals not to instrument are: 
            //   -- ones not modified by any procedure
            //   -- ones not shared
            //   -- ones to treat as thread-local
            HashSet<string> globalsToInstrument = new HashSet<string>();

            foreach (var g in pinfo.declaredGlobals)
            {
                string name = g.Key;
                if (!pinfo.modifiedGlobals.ContainsKey(name))
                    continue;
                if (!LanguageSemantics.isShared(name))
                    continue;
                if (pinfo.threadLocalGlobals.ContainsKey(name))
                    continue;
                globalsToInstrument.Add(name);
            }

            var rprocs = findRecursiveProcs(p);
            //foreach (var be in rprocs) Console.WriteLine("{0} -> {1}", be.Item1, be.Item2);

            policy =
                new InstrumentationPolicy(p.contextBound, globalsToInstrument, pinfo.procsWithImplementation, pinfo.asyncProcs, rprocs, p.mode);

            //policy.print(Log.getWriter(Log.Debug));

            // Step4: Split program declarations based on the instrumentation policy

            // skipping this step (not needed for basic CBA reduction)

            // Step5: Carry out the K-split instrumentation
            inst = new Instrumenter(policy, vmgr, pinfo, tinfo_instrument);
            List<Declaration> newDecls = inst.instrument(p.TopLevelDeclarations.ToList());
            foreach (var trp in inst.blocksWithFixedK)
            {
                blockExecutionContextMap.Add(trp.fst + "::" + trp.snd, trp.trd);
            }

            // Step6: Instrument main with initialization and the Checker
            Implementation mainProcImpl = BoogieUtil.findProcedureImpl(newDecls, p.mainProcName);
            inst.instrumentGivenMainImpl(mainProcImpl);

            // Step7: Instrument Async calls
            bool instrumentedAsync = false;
            InstrumentAsyncCalls ainst = new InstrumentAsyncCalls(vmgr, pinfo, tinfo_async);
            foreach (var decl in newDecls)
            {
                if (decl is Implementation)
                {
                    ainst.VisitImplementation(decl as Implementation);
                    instrumentedAsync = instrumentedAsync || ainst.hasAsync;
                }
            }

            if (!instrumentedAsync)
            {
                Log.WriteLine(Log.Debug, "Warning: Did not find any async call");
            }

            // Step8: Set entrypoint
            mainProcImpl.AddAttribute("entrypoint");

            // Step9: Add new variable declarations
            newDecls.AddRange(vmgr.getNewDeclarations(policy.executionContextBound));
            newDecls.AddRange(BoogieAstFactory.newDecls);
            BoogieAstFactory.newDecls.Clear();

            // Thats it.

            Program ret = new Program();
            ret.TopLevelDeclarations = newDecls;

            if (InstrumentationConfig.printInstrumented)
            {
                // Re-resolve ret
                ProgTransformation.PersistentProgram tprog = new ProgTransformation.PersistentProgram(ret);
                var instrumented = tprog.getProgram();

                // Re-do the modsets -- make them as concise as possible. 
                BoogieUtil.DoModSetAnalysis(instrumented);

                // Temporary fix for Boogie's bug while inlining calls
                // that have don't care expressions. 
                RewriteCallDontCares rdc = new RewriteCallDontCares();
                rdc.VisitProgram(instrumented);

                BoogieUtil.PrintProgram(instrumented, InstrumentationConfig.instrumentedFile);

                throw new NormalExit("Printed " + InstrumentationConfig.instrumentedFile);
            }

            // Resolve the program (Do not typecheck because that does inlining).
            //BoogieUtil.PrintProgram(ret, "instrumented.bpl");
            //ret = BoogieUtil.ReadAndOnlyResolve("instrumented.bpl");
            if (p.mode == ConcurrencyMode.FixedContext)
            {
                InstrumentationConfig.addRaiseException = true;
            }

            p = new CBAProgram(ret, p.mainProcName, p.contextBound);

            return p;
        }


        // Returns all backedges of the call graph (i.e., a cutset in terms of edges)
        private HashSet<Tuple<string,string>> findRecursiveProcs(CBAProgram p)
        {
            var ret = new HashSet<Tuple<string, string>>();
            
            Graph<string> callGraph = new Graph<string>();
            callGraph.AddSource(p.mainProcName);
            foreach (var decl in p.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                foreach (var blk in impl.Blocks)
                {
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd == null) continue;
                        callGraph.AddEdge(impl.Name, ccmd.callee);
                    }
                }
            }

            // Do DFS to find a cutset
            
            // 0: white, 1: gray, 2: black
            var color = new Dictionary<string, int>();
            foreach (var n in callGraph.Nodes) color.Add(n, 0);

            dfs(callGraph, p.mainProcName, color, ret);
            return ret;
        }

        // From [CLR, pg. 483]
        private void dfs(Microsoft.Boogie.GraphUtil.Graph<string> callGraph, string node, Dictionary<string, int> color, HashSet<Tuple<string, string>> ret)
        {
            Debug.Assert(color[node] == 0);

            // gray
            color[node] = 1;

            foreach (var s in callGraph.Successors(node))
            {
                // backedge
                if (color[s] == 1)
                   ret.Add(Tuple.Create(node, s));

                if(color[s] == 0)
                  dfs(callGraph, s, color, ret);
            }

            // black
            color[node] = 2;
        }

        // Return the set of variables that the instrumentation pass added because of the
        // given global variable g. (Its the K copies if g is modified, or it's g itself)
        public HashSet<string> getInstrumentedVars(string g)
        {
            return inst.getInstrumentedVars(g);
        }

        public HashSet<string> getInstrumentedProcedures()
        {
            var t = new HashSet<string>();
            t.Add(inst.getContextSwitchProcedure().Name);
            return t;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            trace = trace.Copy();

            // delete tid info
            deleteTidInfo(trace);

            // Map back across async call instrumentation
            trace = tinfo_async.mapBackTrace(trace);

            // insert context switch info according to blockExecutionContextMap
            insertContextSwitchInfo(trace);

            // Propagate the context switch info to other places -- this is
            // necessary to get the context info to the Cmds that actually
            // access global variables
            ErrorTrace.fillInContextSwitchInfo(trace);

            return tinfo_instrument.mapBackTrace(trace);
        }

        // insert context switch info according to blockExecutionContextMap
        private void insertContextSwitchInfo(ErrorTrace trace)
        {
            if (trace.Blocks.Count == 0) return;

            foreach (var blk in trace.Blocks)
            {
                if (blockExecutionContextMap.ContainsKey(trace.procName + "::" + blk.blockName))
                {
                    var k = blockExecutionContextMap[trace.procName + "::" + blk.blockName];
                    if (blk.Cmds.Count != 0)
                    {
                        blk.Cmds[0].info.executionContext = k;
                    }
                }

                foreach (var c in blk.Cmds)
                {
                    if (c.CalleeTrace != null)
                    {
                        insertContextSwitchInfo(c.CalleeTrace);
                    }
                }
            }

            var exitblk = trace.Blocks.Last();
            if (inst.blocksThatRaiseException.Contains(exitblk.blockName))
            {
                trace.setRaiseException();
            }
        }

        // delete tid info 
        private void deleteTidInfo(ErrorTrace trace)
        {
            if (trace.Blocks.Count == 0) return;

            foreach (var blk in trace.Blocks)
            {
                if (blk.info != null)
                    blk.info.tid = -1;

                foreach (var c in blk.Cmds)
                {
                    if (c.info != null) c.info.tid = -1;
                    if(c.CalleeTrace != null) deleteTidInfo(c.CalleeTrace);
                }
            }
        }

        // insert context switch info according to blockExecutionContextMap
        // Also, it sets raiseException
        private void checkContextSwitchInfo(ErrorTrace trace)
        {
            if (trace.Blocks.Count == 0) return;

            foreach (var blk in trace.Blocks)
            {
                if (blockExecutionContextMap.ContainsKey(trace.procName + "::" + blk.blockName))
                {
                    var k = blockExecutionContextMap[trace.procName + "::" + blk.blockName];
                    if (blk.Cmds.Count != 0)
                    {
                        Debug.Assert(blk.Cmds[0].info.executionContext == k);
                    }
                }

                foreach (var c in blk.Cmds)
                {
                    if (c.CalleeTrace != null)
                    {
                        checkContextSwitchInfo(c.CalleeTrace);
                    }
                }
            }

            var exitblk = trace.Blocks.Last();
            if (inst.blocksThatRaiseException.Contains(exitblk.blockName))
            {
                trace.setRaiseException();
            }
        }

    }

    // Delete implementations that do not modify any global variable
    public class RemoveProcsWithEmptyModSet : CompilerPass
    {
        bool aggressive;

        public RemoveProcsWithEmptyModSet(bool aggressive)
        {
            passName = "Remove Procs with Empty Mod Sets";
            this.aggressive = aggressive;
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            if (!aggressive)
                return null;

            var procsWithAsserts = procsWithAssertions(p);
            HashSet<string> procsToDelete = new HashSet<string>();

            // Gather the set of procedures to delete
            foreach (Declaration d in p.TopLevelDeclarations)
            {
                if (d is Procedure)
                {
                    var proc = d as Procedure;

                    if (proc.Name.Equals(p.mainProcName))
                        continue;

                    if (procsWithAsserts.Contains(proc.Name))
                        continue;

                    if (proc.OutParams.Count > 0)
                        continue;

                    var modifiesShared = false;
                    foreach (IdentifierExpr ie in proc.Modifies)
                    {
                        if (LanguageSemantics.isShared(ie.Decl.Name))
                        {
                            modifiesShared = true;
                            break;
                        }
                    }

                    if (!modifiesShared)
                    {
                        procsToDelete.Add(proc.Name);
                    }
                }
            }

            // Delete the implementations
            CBAProgram ret = new CBAProgram(new Program(), p.mainProcName, p.contextBound);
            foreach (Declaration d in p.TopLevelDeclarations)
            {
                if (d is Implementation)
                {
                    Implementation impl = d as Implementation;
                    if (procsToDelete.Contains(impl.Name) && !BoogieUtil.hasAssert(impl))
                    {
                        Log.WriteLine(Log.Debug, "Deleting " + impl.Name);
                        continue;
                    }
                    ret.AddTopLevelDeclaration(d);
                }
                else
                {
                    ret.AddTopLevelDeclaration(d);
                }
            }

            Log.WriteLine(Log.Debug, "Empty Mod Sets: Deleted " + (p.TopLevelDeclarations.Count() - ret.TopLevelDeclarations.Count()).ToString() +
                " implementations");
            return ret;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return trace;
        }

        // Return the set of all procedures that can trasitively reach 
        // an assertion, or another procedure's requires
        private HashSet<string> procsWithAssertions(Program program)
        {
            // Build a call graph and mark procedures with assertions in them
            Dictionary<string, HashSet<string>> callSucc = new Dictionary<string, HashSet<string>>();
            Dictionary<string, HashSet<string>> callPred = new Dictionary<string, HashSet<string>>();
            HashSet<string> hasAssert = new HashSet<string>();

            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    var impl = decl as Implementation;
                    callSucc.Add(impl.Name, new HashSet<string>());

                    foreach (var block in impl.Blocks)
                    {
                        foreach (var cmd in block.Cmds)
                        {
                            if (cmd is AssertCmd)
                            {
                                hasAssert.Add(impl.Name);
                            }
                            if (cmd is CallCmd)
                            {
                                var ccmd = cmd as CallCmd;
                                callSucc[impl.Name].Add(ccmd.Proc.Name);
                                if (LanguageSemantics.assertNotReachableName() == ccmd.Proc.Name)
                                    hasAssert.Add(impl.Name);
                            }
                        }
                    }
                }
            }

            // Build the predecessor map
            foreach (var kvp in callSucc)
            {
                if (!callPred.ContainsKey(kvp.Key))
                {
                    callPred.Add(kvp.Key, new HashSet<string>());
                }

                foreach (var tgt in kvp.Value)
                {
                    if (!callPred.ContainsKey(tgt))
                    {
                        callPred.Add(tgt, new HashSet<string>());
                    }
                    callPred[tgt].Add(kvp.Key);
                }
            }

            // Requires become asserts on the caller.
            // (No need to bother about ensures because if we're not interested
            // in a procedure, then we don't care about verifying its ensures either)
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure)
                {
                    var proc = decl as Procedure;

                    foreach (Requires re in proc.Requires)
                    {
                        if (re.Free)
                            continue;
                        if (!callPred.ContainsKey(proc.Name))
                            continue;

                        foreach (var pred in callPred[proc.Name])
                        {
                            hasAssert.Add(pred);
                        }
                    }
                }
            }

            // Now propagate hasAssert to all its predecessors
            var done = false;
            while (!done)
            {
                var newproc = new HashSet<string>();
                foreach (var proc in hasAssert)
                {
                    foreach (var pred in callPred[proc])
                    {
                        newproc.Add(pred);
                    }
                }

                if (newproc.Any(x => !hasAssert.Contains(x)))
                {
                    hasAssert.UnionWith(newproc);
                }
                else
                {
                    done = true;
                }

            }
            return hasAssert;
        }

    }

    // This is used for pre-processing of the input program. We rewrite calls
    // so that they only operate on local variables.
    public class RewriteCallCmdsPass : CompilerPass
    {
        RewriteCallCmds rcc;

        public RewriteCallCmdsPass()
        {
            rcc = new RewriteCallCmds(false);
            passName = "Rewriting calls";
        }

        public RewriteCallCmdsPass(bool rewriteAll)
        {
            rcc = new RewriteCallCmds(!rewriteAll);
            passName = "Rewriting calls";
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            rcc.VisitProgram(p as Program);
            return p;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return rcc.tinfo.mapBackTrace(trace);
        }
    }

    // This is used for pre-processing of the input program. We rewrite asserts
    // so that we know which one of them failed.
    public class RewriteAssertsPass : CompilerPass
    {
        RewriteAsserts rcc;

        public RewriteAssertsPass()
        {
            rcc = new RewriteAsserts();
            passName = "Rewriting asserts";
        }

        public RewriteAssertsPass(bool shouldFindAssert)
        {
            rcc = new RewriteAsserts(shouldFindAssert);
            passName = "Rewriting asserts";
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            rcc.VisitProgram(p as Program);
            return p;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return rcc.mapBackTrace(trace);
        }

        public AssertLocation getFailingAssertLocation()
        {
            return rcc.failingAssert;
        }

        // found assert?
        public bool foundAssert
        {
            get
            {
                return rcc.assertFound;
            }
        }

        // For allowing multiple traces to be mapped back
        public void reset()
        {
            rcc.reset();
        }

    }

    public class AddUniqueCallIds
    {
        private static int counter = 0;
        public static bool useGlobalCounter = true;
        // (caller, callee, int) -> (block label, cnt)
        public Dictionary<Tuple<string, string, int>, Tuple<string, int>> callIdToLocation;

        public AddUniqueCallIds()
        {
            callIdToLocation = new Dictionary<Tuple<string, string, int>, Tuple<string, int>>();
        }

        public void VisitProgram(Program program)
        {
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                VisitImplementation(impl);
        }

        public void VisitImplementation(Implementation impl)
        {
            // callee -> id
            var cnt = new Dictionary<string, int>();

            foreach (var block in impl.Blocks)
            {
                var callcnt = 0;
                for (int i = 0; i < block.Cmds.Count; i++)
                {
                    var cc = block.Cmds[i] as CallCmd;
                    if (cc == null) continue;

                    if (!cnt.ContainsKey(cc.callee))
                        cnt[cc.callee] = 0;

                    var uniqueId = useGlobalCounter ? counter : cnt[cc.callee];
                    var attr = new List<object>();
                    attr.Add(new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(uniqueId)));

                    cc.Attributes = BoogieUtil.removeAttr("si_old_unique_call", cc.Attributes);
                    var oldAttr = BoogieUtil.getAttr("si_unique_call", cc.Attributes);
                    if (oldAttr != null)
                    {
                        cc.Attributes = BoogieUtil.removeAttr("si_unique_call", cc.Attributes);
                        var newattr = new QKeyValue(Token.NoToken, "si_old_unique_call", oldAttr, null);
                        if(cc.Attributes == null)
                            cc.Attributes = newattr;
                        else 
                            cc.Attributes.AddLast(newattr);
                    }

                    cc.Attributes = new QKeyValue(Token.NoToken, "si_unique_call", attr, cc.Attributes);
                    callIdToLocation.Add(Tuple.Create(impl.Name, cc.callee, uniqueId), Tuple.Create(block.Label, callcnt));

                    cnt[cc.callee]++;

                    callcnt++;
                    counter++;
                }
            }

        }

    }

    public class ExtractRecursionPass : CompilerPass
    {
        public bool foundRecursion;

        public ExtractRecursionPass()
        {
            foundRecursion = false;
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            var nameImplMap = BoogieUtil.nameImplMapping(program);

            // Construct call graph, compute SCCs
            var graph = new Graph<string>();
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.Blocks.Iter(block =>
                    block.Cmds.OfType<CallCmd>().Iter(cmd =>
                        graph.AddEdge(impl.Name, cmd.callee)));
            }
            graph.AddSource(program.mainProcName);
            var preds = new Adjacency<string>(st => graph.Predecessors(st));
            var succs = new Adjacency<string>(st => graph.Successors(st));
            var sccs = new StronglyConnectedComponents<string>(graph.Nodes, preds, succs);
            sccs.Compute();

            //var dotFileCnt = 1;

            // For each SCC, compute backedges
            foreach (var scc in sccs)
            {
                if (scc.Count == 1)
                {
                    var onlyProc = scc.First();
                    if (nameImplMap.ContainsKey(onlyProc) && QKeyValue.FindBoolAttribute(nameImplMap[onlyProc].Attributes, "LoopProcedure"))
                        continue;

                    if (graph.Successors(onlyProc).All(callee => callee != onlyProc))
                        continue;
                }

                Console.Write("Considering SCC: ");
                scc.Iter(s => Console.Write("{0} ", s));
                Console.WriteLine();

                foundRecursion = true;

                // pick source
                var sccProcs = new HashSet<string>(scc);
                var src = scc.FirstOrDefault(proc => graph.Predecessors(proc).Any(pred => !sccProcs.Contains(pred)));
                if (src == null) src = scc.First();

                var grey = new HashSet<string>();
                var black = new HashSet<string>();
                grey.Add(src);

                backedges = new HashSet<Tuple<string, string>>();
                dfsTreeParent = new Dictionary<string, string>();
                someCycles = new List<HashSet<string>>();

                dfs(graph, src, sccProcs, grey, black);

                InferWhatToCut(graph, scc);

                // create copies
                var procCopies = new Dictionary<Tuple<string, int>, Procedure>();
                var implCopies = new Dictionary<Tuple<string, int>, Implementation>();
                foreach (var name in scc)
                {
                    var impl = nameImplMap[name];
                    program.RemoveTopLevelDeclaration(impl);
                    program.RemoveTopLevelDeclaration(impl.Proc);

                    for (int i = 0; i < CommandLineOptions.Clo.RecursionBound; i++)
                    {
                        var dup = new FixedDuplicator(true);
                        var nimpl = dup.VisitImplementation(impl);
                        var nproc = dup.VisitProcedure(impl.Proc);

                        nimpl.Name += string.Format("#{0}", i);
                        nproc.Name += string.Format("#{0}", i);
                        nimpl.Proc = nproc;

                        program.AddTopLevelDeclaration(nimpl);
                        program.AddTopLevelDeclaration(nproc);

                        procCopies.Add(Tuple.Create(impl.Name, i), nproc);
                        implCopies.Add(Tuple.Create(impl.Name, i), nimpl);
                    }
                }

                // redirect calls
                foreach (var name in scc)
                {
                    foreach (var pred in graph.Predecessors(name))
                    {
                        if (sccProcs.Contains(pred)) continue;
                        var pimpl = nameImplMap[pred];
                        foreach (var blk in pimpl.Blocks)
                        {
                            var newcmds = new List<Cmd>();
                            foreach (var cmd in blk.Cmds)
                            {
                                var ccmd = cmd as CallCmd;
                                if (ccmd == null || !sccProcs.Contains(ccmd.callee))
                                {
                                    newcmds.Add(cmd);
                                    continue;
                                }
                                newcmds.Add(
                                    new CallCmd(ccmd.tok, ccmd.callee + string.Format("#{0}", CommandLineOptions.Clo.RecursionBound - 1),
                                        ccmd.Ins, ccmd.Outs, ccmd.Attributes, ccmd.IsAsync));
                            }
                            blk.Cmds = newcmds;
                        }
                    }

                    for (int i = 0; i < CommandLineOptions.Clo.RecursionBound; i++)
                    {
                        var impl = implCopies[Tuple.Create(name, i)];
                        foreach (var blk in impl.Blocks)
                        {
                            var newcmds = new List<Cmd>();
                            foreach (var cmd in blk.Cmds)
                            {
                                var ccmd = cmd as CallCmd;
                                if (ccmd == null || !sccProcs.Contains(ccmd.callee))
                                {
                                    newcmds.Add(cmd);
                                    continue;
                                }
                                var cnt = i;
                                if (CutEdge(name, ccmd.callee))
                                    cnt--;

                                if (cnt < 0)
                                {
                                    newcmds.Add(new AssumeCmd(Token.NoToken, Expr.False));
                                }
                                else
                                {
                                    newcmds.Add(new CallCmd(ccmd.tok, ccmd.callee + string.Format("#{0}", cnt),
                                        ccmd.Ins, ccmd.Outs, ccmd.Attributes, ccmd.IsAsync));
                                }
                            }
                            blk.Cmds = newcmds;
                        }
                    }

                }

            }

            return program;
        }

        private bool isAcyclic(Graph<string> graph, HashSet<string> domain)
        {
            var oldb = backedges;
            var oldd = dfsTreeParent;
            var olds = someCycles;

            var ret = true;
            var black = new HashSet<string>();

            foreach (var d in domain)
            {
                if (black.Contains(d)) continue;

                backedges = new HashSet<Tuple<string, string>>();
                dfsTreeParent = new Dictionary<string, string>();
                someCycles = new List<HashSet<string>>();

                var grey = new HashSet<string>();
                grey.Add(d);
                dfs(graph, d, domain, grey, black);

                if (backedges.Any())
                {
                    ret = false;
                    break;
                }
            }

            backedges = oldb;
            dfsTreeParent = oldd;
            someCycles = olds;

            return ret;
        }

        private void PrintDot(Graph<string> graph, IEnumerable<string> scc, string src, string filename)
        {
            var dotty = new System.IO.StreamWriter(filename);
            dotty.WriteLine("digraph SCC {");
            dotty.WriteLine("node [shape=box];");                

            var red = new HashSet<string>();
            var sccProcs = new HashSet<string>(scc);

            // print nodes
            foreach (var s in scc)
            {
                var color = "black";
                var ins = graph.Nodes.Where(n => !sccProcs.Contains(n))
                    .Where(n => graph.Successors(n).Any(ns => ns == s));
                var insInstance = ins.FirstOrDefault();

                if (insInstance != null)
                    color = "red";

                if (s == src && color == "black")
                    color = "green";
                if (s == src && color == "red")
                    color = "blue";

                var label = s;
                label += (insInstance == null) ? "" : ("  " + insInstance);

                if (color == "red") red.Add(s);

                dotty.WriteLine("{0} [label = \"{1}\", color={2}]", s, label, color);
            }

            foreach (var s in scc)
            {
                foreach (var sp in graph.Successors(s).Where(t => sccProcs.Contains(t)))
                {
                    var label = "";
                    if (backedges.Contains(Tuple.Create(s, sp)))
                        label = "backedge";
                    dotty.WriteLine("{0} -> {1} [ label = \"{2}\" color=black ]", s, sp, label);
                }
            }

            dotty.WriteLine("};");
            dotty.WriteLine();
            dotty.Close();
        }

        HashSet<Tuple<string, string>> backedges;
        Dictionary<string, string> dfsTreeParent;
        List<HashSet<string>> someCycles;
        HashSet<string> smallcutset;

        private void InferWhatToCut(Graph<string> graph, IEnumerable<string> scc)
        {
            Debug.Assert(backedges != null);
            smallcutset = null;

            //someCycles.Iter(c => Console.WriteLine("Cycle: {0}", c.Print()));

            // If small number of backedges, then done
            if (backedges.Count <= 2)
                return;

            var cutset = new HashSet<string>();
            var weight = new Dictionary<int, HashSet<string>>();
            backedges.Iter(tup => cutset.Add(tup.Item2));
 
            // how many cycles does s appear in?
            foreach (var s in cutset)
            {
                var cnt = 0;
                someCycles.Where(c => c.Contains(s)).Iter(c => cnt++);
                if (!weight.ContainsKey(cnt))
                    weight.Add(cnt, new HashSet<string>());
                weight[cnt].Add(s);
            }


            // take the highest-weight nodes

            smallcutset = new HashSet<string>();
            var cycleCnt = someCycles.Count;

            // Is there a cutset of size 1?
            if (weight.ContainsKey(cycleCnt) && weight[cycleCnt].Count > 0)
            {
                smallcutset.Add(weight[cycleCnt].First());
            }
            else
            {
                // Is there a cutset of size 2?
                for (int i = cycleCnt; i >= 0; i++)
                {
                    if (!weight.ContainsKey(i)) continue;
                    foreach (var s in weight[i])
                    {
                        if (smallcutset.Contains(s)) continue;
                        if (smallcutset.Count >= 2) continue;
                        smallcutset.Add(s);
                    }
                }
            }

            // Is smallcutset a cutset?
            var domain = new HashSet<string>(scc);
            domain.ExceptWith(smallcutset);
            if (isAcyclic(graph, domain))
            {
                Console.WriteLine("Found small cutset: {0}", smallcutset.Print());
                backedges = null;
            }
            else
            {
                smallcutset = null;
                Console.WriteLine("Using {0} backedges to cut cycles", backedges.Count);
            }
        }

        private bool CutEdge(string src, string tgt)
        {
            Debug.Assert(backedges == null || smallcutset == null);

            if (backedges == null)
                return smallcutset.Contains(tgt);
            else
                return backedges.Contains(Tuple.Create(src, tgt));
        }

        public void dfs(Graph<string> graph, string src, 
            HashSet<string> domain, HashSet<string> grey, HashSet<string> black)
        {
            foreach (var succ in graph.Successors(src))
            {
                if (!domain.Contains(succ)) continue;
                if (black.Contains(succ)) continue;
                if (grey.Contains(succ))
                {
                    backedges.Add(Tuple.Create(src, succ));
                    // add cycle
                    var cycle = new HashSet<string>();
                    var p = src;
                    while (p != succ)
                    {
                        cycle.Add(p);
                        p = dfsTreeParent[p];
                    }
                    cycle.Add(succ);
                    someCycles.Add(cycle);
                    continue;
                }
                grey.Add(succ);
                dfsTreeParent.Add(succ, src);
                dfs(graph, succ, domain, grey, black);
                grey.Remove(succ);
                black.Add(succ);
            }
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            throw new NotImplementedException();
        }
    }

    public class ExtractLoopsPass : LoopUnrollingPass
    {
        // proc name -> new block name -> orig block name
        Dictionary<string, Dictionary<string, string>> info;

        HashSet<string> allProcs;
        HashSet<string> loopProcs;

        bool addUniqueCallLabels;

        public ExtractLoopsPass()
            :base(-1)
        {
            info = null;
            addUniqueCallLabels = false;
        }

        public ExtractLoopsPass(bool addUniqueCallLabels)
            : base(-1)
        {
            info = null;
            this.addUniqueCallLabels = addUniqueCallLabels;
        }


        public ExtractLoopsPass(int n)
            : base(n)
        {
            info = null;
            this.addUniqueCallLabels = false;
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            if (unrollNum >= 0)
            {
                return base.runCBAPass(p);
            }
            
            foreach (var impl in BoogieUtil.GetImplementations(p))
            {
                impl.PruneUnreachableBlocks();
            }

            // save RB
            var rb = CommandLineOptions.Clo.RecursionBound;
            if (BoogieVerify.irreducibleLoopUnroll >= 0)
                CommandLineOptions.Clo.RecursionBound = BoogieVerify.irreducibleLoopUnroll;

            var procsWithIrreducibleLoops = new HashSet<string>();
            var passInfo = p.ExtractLoops(out procsWithIrreducibleLoops);

            // restore RB
            CommandLineOptions.Clo.RecursionBound = rb;

            // no loops found, then this transformation is identity
            if (passInfo.Count == 0 && procsWithIrreducibleLoops.Count == 0)
                return null;

            if (addUniqueCallLabels)
            {
                // annotate calls with a unique number
                var addIds = new AddUniqueCallIds();

                // Loop unrolling is done for procs with irreducible loops.
                // This simply copies Cmd objects. Duplicate them to remove
                // aliasing
                foreach (var impl in p.TopLevelDeclarations
                    .OfType<Implementation>()
                    .Where(impl => procsWithIrreducibleLoops.Contains(impl.Name)))
                {
                    var dup = new FixedDuplicator(true);
                    foreach (var blk in impl.Blocks)
                    {
                        blk.Cmds = dup.VisitCmdSeq(blk.Cmds);
                    }
                }

                // Add labels again to all procedures
                foreach (var impl in p.TopLevelDeclarations
                    .OfType<Implementation>())
                    addIds.VisitImplementation(impl);                    
            }

            info = new Dictionary<string, Dictionary<string, string>>();
            passInfo.Iter(kvp =>
                {
                    info.Add(kvp.Key, new Dictionary<string, string>());
                    kvp.Value.Iter(sb => info[kvp.Key].Add(sb.Key, sb.Value.Label));
                });
            
            // Construct the set of procs in the original program
            // and the loop procedures
            allProcs = new HashSet<string>();
            loopProcs = new HashSet<string>();
            foreach (var decl in p.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if(impl == null) continue;
                allProcs.Add(impl.Name);
                if(impl.Proc is LoopProcedure) {
                    loopProcs.Add(impl.Name);
                    impl.Proc.AddAttribute("LoopProcedure");
                }
            }
            
            //foreach (var impl in BoogieUtil.GetImplementations(p))
            //{
                //removeAssumeFalseBlocks(impl);
            //}


            // Optimization: if no loop is found, then no need to print
            // out a new program
            if (loopProcs.Count == 0)
                return null;

            // Remove vars from attributes that are not in scope anymore
            RemoveVarsFromAttributes.Prune(p);

            return p;
        }

        private void removeAssumeFalseBlocks(Implementation impl)
        {
            // Identify "assume false" blocks
            var afBlocks = new HashSet<string>();
            foreach (var blk in impl.Blocks)
            {
                if (blk.Cmds.Count == 0) continue;
                var acmd = blk.Cmds[0] as AssumeCmd;
                if (acmd == null) continue;
                var le = acmd.Expr as LiteralExpr;
                if (le == null) continue;
                if (le.IsFalse) { afBlocks.Add(blk.Label); }
            }

            var newBlocks = new List<Block>();
            foreach (var blk in impl.Blocks)
            {
                if (afBlocks.Contains(blk.Label)) continue;
                newBlocks.Add(blk);
                var gc = blk.TransferCmd as GotoCmd;
                if (gc == null) continue;
                var ss = new List<String>();
                foreach (var t in gc.labelNames)
                {
                    if (afBlocks.Contains(t)) continue;
                    ss.Add(t);
                }
                if (ss.Count > 0)
                {
                    blk.TransferCmd = new GotoCmd(gc.tok, ss);
                }
                else
                {
                    blk.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.False));
                    blk.TransferCmd = new ReturnCmd(Token.NoToken);
                }

            }
            impl.Blocks = newBlocks;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if (unrollNum >= 0) return base.mapBackTrace(trace);

            var ret = new ErrorTrace(trace.procName);
            var firstInfo = trace.Blocks[0].info;
            ErrorTraceBlock lastBlk = null;

            foreach (var blk in trace.Blocks)
            {
                var rblkLabel = elGetBlock(trace.procName, blk.blockName);
                if (rblkLabel != null)
                {
                    lastBlk = new ErrorTraceBlock(rblkLabel);
                    lastBlk.info = blk.info;
                    if (ret.Blocks.Count == 0 && lastBlk.info == null) lastBlk.info = firstInfo;
                    ret.addBlock(lastBlk);
                }

                foreach (var cmd in blk.Cmds)
                {
                    var ccmd = cmd as CallInstr;
                    if (ccmd == null || ccmd.calleeTrace == null)
                    {
                        if(lastBlk != null) lastBlk.addInstr(cmd);
                        continue;
                    }
                    var ctrace = mapBackTrace(ccmd.calleeTrace);
                    if (isLoop(ctrace.procName))
                    {
                        // absorb trace
                        ret.Blocks.AddRange(ctrace.Blocks);
                        lastBlk = null;
                    }
                    else
                    {
                        if(lastBlk != null) lastBlk.addInstr(new CallInstr(ctrace.procName, ctrace, ccmd.asyncCall, cmd.info));
                        continue;
                    }
                }
                
            }
            if (trace.returns && ret.Blocks.Count > 0)
            {
                ret.addReturn(trace.raisesException);
            }
            return ret;
        }

        private bool isLoop(string procName)
        {
            return loopProcs.Contains(procName);
        }

        private string elGetBlock(string procname, string block)
        {
            if (!info.ContainsKey(procname))
                return block;

            if (!info[procname].ContainsKey(block))
                return null;

            return info[procname][block];
        }

    }

}
