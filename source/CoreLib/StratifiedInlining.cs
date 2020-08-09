﻿﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Outcome = VC.VCGen.Outcome;
using cba.Util;
using Microsoft.Boogie.GraphUtil;
using Microsoft.Boogie.SMTLib;
using System.Net.Http;
using Newtonsoft.Json;
using System.Threading;
//using LocalServerInCsharp;

namespace CoreLib
{
    /****************************************
    *           Pseudo macros               *
    ****************************************/

    // TODO: replace this with conventional functions

    using Bpl = Microsoft.Boogie;

    public class MacroSI
    {
        public static void PRINT(int lvl, string s, params object[] args)
        {
            if (CommandLineOptions.Clo.StratifiedInliningVerbose >= lvl)
                Console.WriteLine(s, args);
        }

        public static void PRINT(string s, params object[] args) { PRINT(0, s, args); }

        public static void PRINT_DETAIL(string s, params object[] args) { PRINT(1, s, args); }

        public static void PRINT_DEBUG(string s, params object[] args) { PRINT(2, s, args); }
    }

    /****************************************
    * Classes for diverse program analyses *
    ****************************************/

    /* locates (user-) assertions in the code */
    class LocateAsserts
    {

        public LocateAsserts()
            : base()
        {
        }

        public List<Procedure> VisitIt(Program node)
        {
            var assertLocations = new List<Procedure>();
            foreach (var impl in node.TopLevelDeclarations.OfType<Implementation>())
            {
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                    continue;
                if (cba.Util.BoogieVerify.ignoreAssertMethods.Contains(impl.Name))
                    continue;

                impl.Blocks.Iter(block =>
                    block.Cmds.OfType<AssignCmd>()
                    .Iter(cmd =>
                    {
                        foreach (var lhs in cmd.Lhss)
                            if (lhs.DeepAssignedVariable.Name == cba.Util.BoogieVerify.assertsPassed)
                                assertLocations.Add(impl.Proc);

                    }));
            }
            return assertLocations;
        }
    }

    /* builds the call-graph */
    public class BuildCallGraph : cba.Util.FixedVisitor
    {
        public BuildCallGraph()
        {
            graph = new CallGraph();
        }

        /* callgraph */
        public class CallGraph
        {
            public CallGraph()
            {
                callers = new Dictionary<Procedure, List<Procedure>>();
                callees = new Dictionary<Procedure, List<Procedure>>();
            }

            public Dictionary<Procedure, List<Procedure>> callers;
            public Dictionary<Procedure, List<Procedure>> callees;

            public void AddCallerCallee(Procedure caller, Procedure callee)
            {
                if (callers.All(x => x.Key.Name != callee.Name))//!callers.ContainsKey(callee))
                    callers.Add(callee, new List<Procedure>());

                if (callers[callee].All(x => x.Name != caller.Name))
                    callers[callee].Add(caller);

                if (callees.All(x => x.Key.Name != caller.Name))//!callees.ContainsKey(caller))
                    callees.Add(caller, new List<Procedure>());

                if (callees[caller].All(x => x.Name != callee.Name))
                    callees[caller].Add(callee);
            }

            public void PrintOut(System.IO.TextWriter output)
            {
                output.WriteLine("digraph G {");
                foreach (var pair in callers)
                    foreach (var second in pair.Value)
                        output.WriteLine("\"" + pair.Key.Name + "\"->\"" + second.Name + "\";");
                output.WriteLine("}");
            }
        }

        public CallGraph graph;
        protected Procedure currentProc;

        public override Implementation VisitImplementation(Implementation node)
        {
            currentProc = node.Proc;
            return base.VisitImplementation(node);
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            graph.AddCallerCallee(currentProc, node.Proc);
            return base.VisitCallCmd(node);
        }
    }


    /****************************************
    * Class for statistical analysis        *
    ****************************************/

    public class Stats
    {
        public int numInlined = 0;
        public int vcSize = 0;
        public int bck = 0;
        public int stacksize = 0;
        public int calls = 0;
        public long time = 0;

        public void print()
        {
            Console.WriteLine("--------- Stats ---------");
            Console.WriteLine("number of functions inlined: " + numInlined);
            Console.WriteLine("number of backtracking: " + bck);
            Console.WriteLine("total number of assertions in Z3 stack: " + stacksize);
            Console.WriteLine("total number of Z3 calls: " + calls);
            Console.WriteLine("total time spent in Z3: (tick) " + time);
            Console.WriteLine("-------------------------");
        }
    }


    /****************************************
    *          Stratified Inlining          *
    ****************************************/
    public class JsonContent : StringContent
    {
        public JsonContent(object obj) :
            base(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json")
        { }
    }
    /* stratified inlining technique */
    public class StratifiedInlining : StratifiedVCGenBase
    {
        public static readonly string ForceInlineAttr = "ForceInline";

        public Stats stats;
        
        /* call-site to VC map -- used for trace construction */
        public Dictionary<StratifiedCallSite, StratifiedVC> attachedVC;
        public Dictionary<StratifiedVC, StratifiedCallSite> attachedVCInv;

        /* VC of main */
        private StratifiedVC mainVC;

        /*  Parent linking -- used only for computing the recursion depth */
        public Dictionary<StratifiedCallSite, StratifiedCallSite> parent;        

        // Set of implementations
        HashSet<string> implementations;

        /* results of the initial program analyses */
        private List<Procedure> assertMethods;
        private BuildCallGraph.CallGraph callGraph;

        /* main procedure (fake main) */
        private Procedure mainProc;

        /* Call Tree after VerifyImplementation */
        private HashSet<string> CallTree;

        /* An extra Boolean associated with each VC */
        private Dictionary<StratifiedVC, VCExpr> controlBoolean;

        /* extra Recursion bound */
        public Dictionary<string, int> extraRecBound;

        /* Procedures that hit the recursion bound */
        public HashSet<string> procsHitRecBound;

        /* Variables for distributed service*/
        public DI di;
        public string clientID;
        HttpClient callServer;
        UriBuilder serverUri;
        int numPush;
        public HashSet<string> previousSplitSites;
        string calltreeToSend;
        bool isProgramSafe;
        int parentNodeInTimegraph;
        int childNodeInTimegraph;
        Stack<Tuple<int, int>> emulateServerStack;
        public static double communicationTime = 0;
        public static double inliningTime = 0;
        public static double proverTime = 0;
        public static double splittingTime = 0;
        public DateTime proverStartTime;
        public DateTime inliningStartTime;
        public DateTime splittingStartTime;
        public DateTime lastSplitAt;
        public double nextSplitInterval = 0;

        //public Config configuration;
        /* Forced inline procs */
        HashSet<string> forceInlineProcs;
        public HashSet<string> proofSites;
        // verification start time
        DateTime startTime;

        public HashSet<string> GetCallTree()
        {
            return CallTree;
        }

        /* initial analyses */
        public void RunInitialAnalyses(Program prog)
        {
            //TokenTextWriter file = new TokenTextWriter("tmp1_"+DateTime.Now.Millisecond.ToString()+".bpl");
            //prog.Emit(file);
            //file.Close();

            LocateAsserts locate = new LocateAsserts();
            assertMethods = locate.VisitIt(prog);
            mainProc = prog.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .Select(impl => impl.Proc)
                .FirstOrDefault();

            Debug.Assert(mainProc != null);

            /* if no asserts in methods, we don't need fwd/bck, neither callgraph and the associated transformations */
            if (assertMethods.Count <= 0)
            {
                MacroSI.PRINT_DETAIL("No assert detected in the methods -- use foward approach instead.");
                return;
            }
            else
            {
                MacroSI.PRINT_DETAIL(assertMethods.Count + " methods containing asserts detected");
                if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1)
                    foreach (var method in assertMethods)
                        Console.WriteLine("-> " + method.Name);
            }

            BuildCallGraph builder = new BuildCallGraph();
            builder.Visit(prog);
            callGraph = builder.graph;

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 3)
                callGraph.PrintOut(Console.Out);
        }

        public StratifiedInlining(Program program, string logFilePath, bool appendLogFile, Action<Implementation> PassiveImplInstrumentation) :
            base(program, logFilePath, appendLogFile, new List<Checker>(), PassiveImplInstrumentation)
        {
            stats = new Stats();

            this.extraRecBound = new Dictionary<string, int>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl =>
                {
                    var b = QKeyValue.FindIntAttribute(impl.Attributes, BoogieVerify.ExtraRecBoundAttr, -1);
                    if (b != -1) extraRecBound.Add(impl.Name, b);
                });

            if (cba.Util.BoogieVerify.options.useFwdBck)
            {
                RunInitialAnalyses(program);
            }

            attachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>();
            attachedVCInv = new Dictionary<StratifiedVC, StratifiedCallSite>();
            parent = new Dictionary<StratifiedCallSite, StratifiedCallSite>();
            implementations = new HashSet<string>(implName2StratifiedInliningInfo.Keys);

            forceInlineProcs = new HashSet<string>();

            controlBoolean = new Dictionary<StratifiedVC, VCExpr>();
            di = new DI(this, true);

            if (BoogieVerify.options.extraFlags.Contains("do") || BoogieVerify.options.extraFlags.Contains("doslow"))
            {
                Console.WriteLine("============= DAG Oracle ============");
                
                var sttime = DateTime.Now;
                DagOracle dago = null;
                var treesize = 0;
                
                if (BoogieVerify.options.extraFlags.Contains("doslow"))
                {
                    dago = DagOracle.ConstructCallDag(program, extraRecBound);
                    dago.Dump("tree.dot");
                    treesize = dago.ComputeSize();
                    dago.Compress();
                }
                else
                {
                    dago = new DagOracle(program, extraRecBound);
                    treesize = dago.ConstructCallDagOnTheFly(false, DI.PickStrategy());
                }
                var compresstime = (DateTime.Now - sttime);

                Console.WriteLine("Compression: {0} {1}", dago.ComputeSize(), treesize == 0 ? dago.ComputeDagSizes() : treesize);
                Console.WriteLine("Compression time: {0} seconds", compresstime.TotalSeconds.ToString("F2"));

                dago.Dump("dag.dot");
                Debug.Assert(treesize == 0 || treesize == dago.ComputeDagSizes());
                dago.CheckSanity();
                Console.WriteLine("Compressed dag sanity confirmed");
                Console.WriteLine("=====================================");
                throw new NormalExit("Done");
            }
            callServer = new HttpClient();
            callServer.Timeout = System.Threading.Timeout.InfiniteTimeSpan;
            //configuration = new Config();
            //serverUri = new UriBuilder("http://localhost:5000/");
            //serverUri = new UriBuilder("http://10.0.0.7:5000/");
            //serverUri = new UriBuilder(BoogieVerify.options.hydraServerURI);
            serverUri = new UriBuilder(cba.Util.HydraConfig.hydraServerURI);
            previousSplitSites = new HashSet<string>();
            calltreeToSend = "";
            communicationTime = 0;
            lastSplitAt = DateTime.Now;
            proofSites = new HashSet<string>();
        }

        /* depth in the call tree */
        public int StackDepth(StratifiedCallSite cs)
        {
            int i = 1;
            StratifiedCallSite iter = cs;
            while (parent.ContainsKey(iter))
            {
                iter = parent[iter]; /* previous callsite */
                i++;
            }
            return i;
        }

        /* depth of the recursion inlined so far */
        public int RecursionDepth(StratifiedCallSite cs)
        {
            int i = 1;
            StratifiedCallSite iter = cs;
            while (parent.ContainsKey(iter))
            {
                iter = parent[iter]; /* previous callsite */
                if (iter.callSite.calleeName == cs.callSite.calleeName)
                    i++; /* recursion */
            }
            return i;
        }

        /* Has this call-site reached the bound, given extraRecBound */
        public bool HasExceededRecursionDepth(StratifiedCallSite cs, int bound) {

            var i = RecursionDepth(cs);

            // Usual
            if (!extraRecBound.ContainsKey(cs.callSite.calleeName))
                return (i > bound);

            // Support extraRecBound
            return i > (bound + extraRecBound[cs.callSite.calleeName]);
        }

        /* for measuring Z3 stack */
        protected void Push()
        {
            stats.stacksize++;
            numPush++;
            prover.Push();
        }

        /* for measuring Z3 stack */
        protected void Pop()
        {
            stats.stacksize--;
            numPush--;
            prover.Pop();

        }

        public struct SiState
        {
            public Dictionary<StratifiedCallSite, StratifiedVC> attachedVC;
            public Dictionary<StratifiedVC, StratifiedCallSite> attachedVCInv;
            public Dictionary<StratifiedCallSite, StratifiedCallSite> parent;
            public HashSet<StratifiedCallSite> openCallSites;
            public DI di;
            //public HashSet<StratifiedCallSite> previousSplitSites;
            public HashSet<string> previousSplitSites;
            public string calltreeToSend;

            public static SiState SaveState(StratifiedInlining SI, HashSet<StratifiedCallSite> openCallSites)
            {
                var ret = new SiState();
                ret.attachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>(SI.attachedVC);
                ret.attachedVCInv = new Dictionary<StratifiedVC, StratifiedCallSite>(SI.attachedVCInv);
                ret.parent = new Dictionary<StratifiedCallSite, StratifiedCallSite>(SI.parent);
                ret.openCallSites = new HashSet<StratifiedCallSite>(openCallSites);
                ret.di = SI.di.Copy();
                return ret;
            }

            public static SiState SaveState(StratifiedInlining SI, HashSet<StratifiedCallSite> openCallSites, HashSet<string> previousSplitSites)
            {
                var ret = new SiState();
                ret = SiState.SaveState(SI, openCallSites);
                ret.previousSplitSites = new HashSet<string>(previousSplitSites);
                return ret;
            }

            public static SiState SaveState(StratifiedInlining SI, HashSet<StratifiedCallSite> openCallSites,
                HashSet<string> previousSplitSites, string calltree)
            {
                var ret = new SiState();
                ret = SiState.SaveState(SI, openCallSites);
                ret.previousSplitSites = new HashSet<string>(previousSplitSites);
                ret.calltreeToSend = calltree;
                return ret;
            }

            public void ApplyState(StratifiedInlining SI, ref HashSet<StratifiedCallSite> openCallSites)
            {
                SI.attachedVC = attachedVC;
                SI.attachedVCInv = attachedVCInv;
                SI.parent = parent;
                SI.di = di;
                openCallSites = this.openCallSites;
            }

            public void ApplyState(StratifiedInlining SI, ref HashSet<StratifiedCallSite> openCallSites, ref HashSet<string> previousSplitSites)
            {               
                ApplyState(SI, ref openCallSites);
                previousSplitSites = this.previousSplitSites;
            }

            public void ApplyState(StratifiedInlining SI, ref HashSet<StratifiedCallSite> openCallSites,
                ref HashSet<string> previousSplitSites, ref string calltreeToSend)
            {
                ApplyState(SI, ref openCallSites);
                previousSplitSites = this.previousSplitSites;
                calltreeToSend = this.calltreeToSend;
            }
        }

        public enum DecisionType { MUST_REACH, BLOCK };
        public class Decision : Tuple<DecisionType, int, StratifiedCallSite>
        {
            public Decision(DecisionType dt, int num, StratifiedCallSite cs)
                : base(dt, num, cs) { }

            public DecisionType decisionType
            {
                get { return Item1; }
            }

            public int num
            {
                get { return Item2; }
            }

            public StratifiedCallSite cs
            {
                get { return Item3; }
            }
        }

        public class TimeGraph 
        {
            public Dictionary<int, string> Nodes;
            Dictionary<int, HashSet<Tuple<int, string, double>>> Edges;
            Stack<int> currNodeStack;
            public DateTime startTime;
            static int dmpCnt = 0;
            public int numPartitions;

            public TimeGraph()
            {
                currNodeStack = new Stack<int>();
                Nodes = new Dictionary<int, string>();
                Edges = new Dictionary<int, HashSet<Tuple<int, string, double>>>();
                startTime = DateTime.Now;
                numPartitions = 0;
                //Nodes.Add(0, "main");
                Push(0);
            }

            public int Count()
            {
                return Nodes.Count;
            }


            public void AddEdge(int n1, int n2, string label1, double label2)
            {
                //Console.WriteLine(string.Format("EDGE : {0} {1} {2}", n1, n2, label2));
                if (!Nodes.ContainsKey(n1))
                    Nodes.Add(n1, "");
                if (!Nodes.ContainsKey(n2))
                    Nodes.Add(n2, "");
                if (!Edges.ContainsKey(n1))
                    Edges.Add(n1, new HashSet<Tuple<int, string, double>>());
                Edges[n1].Add(Tuple.Create(n2, label1, label2));
            }

            public void ToDot()
            {
                using (var fs = new System.IO.StreamWriter("tg" + (dmpCnt++) + ".dot"))
                {
                    fs.WriteLine("digraph TG {");

                    foreach (var tup in Nodes)
                    {
                        fs.WriteLine("{0} [label=\"{1}\"]", tup.Key, tup.Value);
                    }

                    foreach (var tup in Edges)
                    {
                        foreach (var tgt in tup.Value)
                            fs.WriteLine("{0} -> {1} [label=\"{2} {3}\"]", tup.Key, tgt.Item1, tgt.Item2, tgt.Item3.ToString("F2"));
                    }
                        
                    fs.WriteLine("}");

                }
            }

            void Push(int node)
            {
                currNodeStack.Push(node);
            }

            public void Pop(int n)
            {
                while (n > 0) { n--; currNodeStack.Pop(); }
                startTime = DateTime.Now;
            }

            public void AddEdge(string tgt, string label)
            {
                numPartitions++;
                var tgtnode = Nodes.Count;
                Nodes.Add(tgtnode, tgt);

                AddEdge(currNodeStack.Peek(), tgtnode, label, (DateTime.Now - startTime).TotalSeconds);
                Push(tgtnode);
                startTime = DateTime.Now;
            }

            public void AddEdgeDone(string label)
            {
                numPartitions++;
                var tgtnode = Nodes.Count;
                Nodes.Add(tgtnode, "Done");

                AddEdge(currNodeStack.Peek(), tgtnode, label, (DateTime.Now - startTime).TotalSeconds);
                startTime = DateTime.Now;
            }

            public double ComputeTimes(int nthreads)
            {
                // First, construct the time graph properly with times on nodes (not edges)
                var nodeToTime = new Dictionary<int, double>();
                var nodeToChildren = new Dictionary<int, HashSet<int>>();

                // Nodes
                foreach (var tup in Edges)
                    foreach (var e in tup.Value)
                        nodeToTime.Add(e.Item1, e.Item3);

                nodeToTime.Keys.Iter(n => nodeToChildren.Add(n, new HashSet<int>()));

                // Edges
                foreach (var tup in Edges)
                    foreach (var e in tup.Value)
                    {
                        var n1 = tup.Key;
                        var n2 = e.Item1;
                        if (!nodeToTime.ContainsKey(n1) || !nodeToTime.ContainsKey(n2))
                            continue;
                        nodeToChildren[n1].Add(n2);
                    }

                var rand = new Random((int)DateTime.Now.Ticks);

                var root = Edges[1].First().Item1;
                var isZero = new Func<double, bool>(d => d < 0.00001);
                var isNull = new Func<Tuple<int, double>, bool>(t => t.Item1 < 0);

                var threads = new Tuple<int, double>[nthreads];
                for (int i = 0; i < nthreads; i++)
                    threads[i] = Tuple.Create(-1, 0.0);

                var totaltime = 0.0;
                var available = new List<int>();
                available.Add(root);

                while (true)
                {
                    // Allocate to idle threads
                    for (int i = 0; i < nthreads; i++)
                    {
                        if (!isNull(threads[i])) continue;
                        if (!available.Any()) continue;
                        var index = rand.Next(available.Count);
                        threads[i] = Tuple.Create(available[index], nodeToTime[available[index]]);
                        available.RemoveAt(index);
                    }
                    if (threads.All(t => isNull(t))) break;

                    // Run
                    var min = threads.Where(t => !isNull(t)).Min(t => t.Item2);
                    totaltime += min;
                    for (int i = 0; i < nthreads; i++)
                    {
                        if (isNull(threads[i])) continue;
                        var tleft = threads[i].Item2 - min;
                        if (isZero(tleft))
                        {
                            nodeToChildren[threads[i].Item1].Iter(n => available.Add(n));
                            threads[i] = Tuple.Create(-1, 0.0);
                        }
                        else
                            threads[i] = Tuple.Create(threads[i].Item1, tleft);
                    }
                }

                return totaltime;
            }
        }

        // Comment TODO
        public Outcome MustReachSplitStyle(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter)
        {
            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;

            int treesize = 0;
            var backtrackingPoints = new Stack<SiState>();
            var decisions = new Stack<Decision>();
            var prevMustAsserted = new Stack<List<Tuple<StratifiedVC, Block>>>();

            var timeGraph = new TimeGraph();
            
            var indent = new Func<int, string>(i =>
            {
                var ret = "";
                while (i > 0) { i--; ret += " "; }
                return ret;
            });

            var PrevAsserted = new Func<HashSet<Tuple<StratifiedVC, Block>>>(() =>
            {
                var ret = new HashSet<Tuple<StratifiedVC, Block>>();
                prevMustAsserted.ToList().Iter(ls =>
                    ls.Iter(tup => ret.Add(tup)));
                return ret;
            });

            var applyDecisionToDI = new Action<DecisionType, StratifiedVC>( (d,n) =>
                {
                    if (d == DecisionType.BLOCK)
                    {
                        di.DeleteNode(n);
                    }
                    if (d == DecisionType.MUST_REACH)
                    {
                        var disj = di.DisjointNodes(n);

                        disj.Iter(m => di.DeleteNode(m));
                    }
                });

            var containingVC = new Func<StratifiedCallSite, StratifiedVC>(scs => attachedVC[parent[scs]]);

            var rand = new Random();
            var reachedBound = false;

            var tt = TimeSpan.Zero;

            while (true)
            {
                // Lets split when the tree has become big enough
                var size = di.ComputeSize(); 
                
                if ( (treesize == 0 && size > 2) || (treesize != 0 && size > treesize + 2))
                {
                    var st = DateTime.Now;

                    // find a node to split on
                    StratifiedVC maxVc = null;
                    int maxVcScore = 0;

                    var toRemove = new HashSet<StratifiedVC>();
                    var sizes = di.ComputeSubtrees();
                    var disj = di.ComputeNumDisjoint();

                    foreach (var vc in attachedVCInv.Keys)
                    {
                        if (!di.VcExists(vc))
                        {
                            toRemove.Add(vc);
                            continue;
                        }

                        var score = Math.Min(sizes[vc].Count, disj[vc]);
                        if (score >= maxVcScore)
                        {
                            maxVc = vc;
                            maxVcScore = score;
                        }
                    }
                    toRemove.Iter(vc => attachedVCInv.Remove(vc));

                    var scs = attachedVCInv[maxVc];
                    Debug.Assert(!openCallSites.Contains(scs));

                    var desc = sizes[maxVc];
                    var cnt = 0;
                    openCallSites.Iter(cs => cnt += desc.Contains(containingVC(cs)) ? 1 : 0);
                    
                    // Push & Block
                    MacroSI.PRINT("{0}>>> Pushing Block({1}, {2}, {3}, {4}, {5})", indent(decisions.Count), scs.callSite.calleeName, sizes[maxVc].Count, disj[maxVc], size, stats.numInlined);

                    var tgNode = string.Format("{0}__{1}", scs.callSite.calleeName, maxVcScore);
                    timeGraph.AddEdge(tgNode, decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());

                    Push();
                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites));
                    prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                    decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                    applyDecisionToDI(DecisionType.BLOCK, maxVc);


                    prover.Assert(scs.callSiteExpr, false);
                    treesize = di.ComputeSize();

                    tt += (DateTime.Now - st);
                }

                MacroSI.PRINT_DEBUG("  - overapprox");

                // Find cex
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        reachedBound = true;
                    }
                }
                MacroSI.PRINT_DEBUG("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);

                MacroSI.PRINT_DEBUG("    - checked: " + outcome);

                if (outcome != Outcome.Correct && outcome != Outcome.Errors)
                {
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (T/O)
                }

                if (outcome == Outcome.Errors && reporter.callSitesToExpand.Count == 0)
                {
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (error found)
                }

                if (outcome == Outcome.Errors)
                {
                    foreach (var scs in reporter.callSitesToExpand)
                    {
                        openCallSites.Remove(scs);
                        var svc = Expand(scs, null, true, true);
                        if (svc != null) openCallSites.UnionWith(svc.CallSites);
                        Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                    }
                }
                else
                {
                    // outcome == Outcome.Correct
                    Decision topDecision = null;
                    SiState topState = SiState.SaveState(this, openCallSites);
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    var doneBT = false;
                    var npops = 0;
                    do
                    {
                        if (decisions.Count == 0)
                        {
                            doneBT = true;
                            break;
                        }

                        topDecision = decisions.Peek();
                        topState = backtrackingPoints.Peek();

                        // Pop
                        Pop();
                        decisions.Pop();
                        backtrackingPoints.Pop();
                        prevMustAsserted.Pop();
                        npops++;
                        MacroSI.PRINT("{0}>>> Pop", indent(decisions.Count));
                    } while (topDecision.num == 1);

                    if (doneBT)
                        break;

                    topState.ApplyState(this, ref openCallSites);
                    timeGraph.Pop(npops - 1);

                    // flip the decision

                    Push();
                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites));

                    if (topDecision.decisionType == DecisionType.MUST_REACH)
                    {
                        // Block
                        prover.Assert(topDecision.cs.callSiteExpr, false);
                        MacroSI.PRINT("{0}>>> Pushing Block({1})", indent(decisions.Count), topDecision.cs.callSite.calleeName);
                        decisions.Push(new Decision(DecisionType.BLOCK, 1, topDecision.cs));
                        applyDecisionToDI(DecisionType.BLOCK, attachedVC[topDecision.cs]);
                        prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                        treesize = di.ComputeSize();
                    }
                    else
                    {
                        // Must Reach
                        MacroSI.PRINT("{0}>>> Pushing Must-Reach({1})", indent(decisions.Count), topDecision.cs.callSite.calleeName);
                        decisions.Push(new Decision(DecisionType.MUST_REACH, 1, topDecision.cs));
                        applyDecisionToDI(DecisionType.MUST_REACH, attachedVC[topDecision.cs]);
                        prevMustAsserted.Push(
                           AssertMustReach(attachedVC[topDecision.cs], PrevAsserted()));
                        treesize = di.ComputeSize();
                    }
                }
                
            }
            reporter.reportTraceIfNothingToExpand = false;

            Console.WriteLine("Time spent taking decisions: {0} s", tt.TotalSeconds.ToString("F2"));

            timeGraph.ToDot();
            Console.Write("SplitSearch: ");
            for (int i = 1; i <= 16; i++)
            {
                var sum = 0.0;
                for (int j = 0; j < 5; j++) sum += timeGraph.ComputeTimes(i);
                sum = sum / 5;

                Console.Write("{0}\t", sum.ToString("F2"));                
            }
            Console.WriteLine();

            if (outcome == Outcome.Correct && reachedBound) return Outcome.ReachedBound;
            return outcome;
        }

        public Outcome UnSatCoreSplitStyle(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter)
        {
            //flags to set - /newStratifiedInlining:ucsplit /enableUnSatCoreExtraction:1

            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;
            var boundHit = false;
            int treesize = 0;
            var backtrackingPoints = new Stack<SiState>();
            var decisions = new Stack<Decision>();
            var prevMustAsserted = new Stack<List<Tuple<StratifiedVC, Block>>>();
            List<string> ucore = null;
            List<StratifiedCallSite> CallSitesInUCore = new List<StratifiedCallSite>();
            var timeGraph = new TimeGraph();
            int numSplits = 0;
            int UCsplit = 0;
            HashSet<string> previousSplitSites = new HashSet<string>();
            
            var indent = new Func<int, string>(i =>
            {
                var ret = "";
                while (i > 0) { i--; ret += " "; }
                return ret;
            });

            var PrevAsserted = new Func<HashSet<Tuple<StratifiedVC, Block>>>(() =>
            {
                var ret = new HashSet<Tuple<StratifiedVC, Block>>();
                prevMustAsserted.ToList().Iter(ls =>
                    ls.Iter(tup => ret.Add(tup)));
                return ret;
            });

            var applyDecisionToDI = new Action<DecisionType, StratifiedVC>((d, n) =>
            {
                if (d == DecisionType.BLOCK)
                {
                    di.DeleteNode(n);
                }
                if (d == DecisionType.MUST_REACH)
                {
                    var disj = di.DisjointNodes(n);
                    disj.Iter(m => di.DeleteNode(m));
                }
            });

            var containingVC = new Func<StratifiedCallSite, StratifiedVC>(scs => attachedVC[parent[scs]]);

            var reachedBound = false;

            var tt = TimeSpan.Zero;

            while (true)
            {
                // Lets split when the tree has become big enough
                var size = di.ComputeSize();
                int splitFlag = 0;
                Dictionary<StratifiedCallSite, int> UCoreChildrenCount = new Dictionary<StratifiedCallSite, int>();
                if (CallSitesInUCore.Count != 0)
                {
                    foreach (StratifiedCallSite cs in CallSitesInUCore)
                    {
                        if (!previousSplitSites.Contains(GetPersistentID(cs)))
                        {
                            splitFlag = 1;
                            break;
                        }
                    }
                }
                if (CallSitesInUCore.Count != 0 && splitFlag == 1)
                {
                    foreach (StratifiedCallSite cs in CallSitesInUCore)
                    {
                        if (UCoreChildrenCount.ContainsKey(cs))
                        {
                            UCoreChildrenCount[cs] = UCoreChildrenCount[cs] + 1;
                        }
                        else
                        {
                            UCoreChildrenCount.Add(cs, 1);
                        }
                        StratifiedCallSite parentOfCs = cs;
                        while (parent.ContainsKey(parentOfCs))
                        {
                            parentOfCs = parent[parentOfCs];
                            if (UCoreChildrenCount.ContainsKey(parentOfCs))
                            {
                                UCoreChildrenCount[parentOfCs] = UCoreChildrenCount[parentOfCs] + 1;
                            }
                            else
                            {
                                UCoreChildrenCount.Add(parentOfCs, 1);
                            }
                        }
                    }
                }
                if (((treesize == 0 && size > 2) || (treesize != 0 && size > treesize + 2)) && splitFlag == 1)
                {
                    var st = DateTime.Now;

                    // find a node to split on
                    StratifiedVC maxVc = null;
                    double maxVcScore = 0;
                    var toRemove = new HashSet<StratifiedVC>();
                    var sizes = di.ComputeSubtrees();
                    var disj = di.ComputeNumDisjoint();
                    foreach (var vc in attachedVCInv.Keys)
                    {
                        if (!di.VcExists(vc))
                        {
                            toRemove.Add(vc);
                            continue;
                        }
                        var score = 0;
                        StratifiedCallSite cs = attachedVCInv[vc];
                        if (UCoreChildrenCount.ContainsKey(cs))
                        {
                            score = UCoreChildrenCount[cs];
                        } 
                        if (!previousSplitSites.Contains(GetPersistentID(cs)) && CallSitesInUCore.Contains(cs) && score >= maxVcScore)
                        { 
                                maxVc = vc;
                                maxVcScore = score;
                        }
                    }
                    if (maxVc != null)
                    {
                        toRemove.Iter(vc => attachedVCInv.Remove(vc));
                        UCsplit += 1;
                        StratifiedCallSite scs = attachedVCInv[maxVc];
                        previousSplitSites.Add(GetPersistentID(scs));
                        Debug.Assert(!openCallSites.Contains(scs));
                        numSplits = numSplits + 1;
                        var desc = sizes[maxVc];
                        var cnt = 0;
                        openCallSites.Iter(cs => cnt += desc.Contains(containingVC(cs)) ? 1 : 0);
                        // Push & Block
                        var tgNode = string.Format("{0},{1}", scs.callSite.calleeName, maxVcScore);
                        timeGraph.AddEdge(tgNode, decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                        Push();
                        backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));
                        prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                        decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                        applyDecisionToDI(DecisionType.BLOCK, maxVc);
                        prover.Assert(scs.callSiteExpr, false);
                        treesize = di.ComputeSize();
                        tt += (DateTime.Now - st);
                    }
                }
                ucore = null;
                boundHit = false;
                // underapproximate query
                Push();
                foreach (StratifiedCallSite cs in openCallSites)
                {

                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false); // Do assert without the label (not caught in UNSAT core)
                        procsHitRecBound.Add(cs.callSite.calleeName);
                        boundHit = true;
                    }
                    // Non-uniform unfolding
                    if (BoogieVerify.options.NonUniformUnfolding && RecursionDepth(cs) > 1)
                        Debug.Assert(false, "Non-uniform unfolding not handled in UW!");

                    prover.Assert(cs.callSiteExpr, false, name: "label_" + cs.callSiteExpr.ToString());

                    continue;

                }
                reporter.reportTrace = true;
                outcome = CheckVC(reporter);
                if (outcome != Outcome.Correct)
                {
                    //Console.WriteLine("EtUC");
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (error found)
                }
                if (outcome == Outcome.Correct)
                {
                    ucore = prover.UnsatCore();
                }
                Pop();
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        reachedBound = true;
                    }
                }
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                reporter.reportTrace = false;
                outcome = CheckVC(reporter);
                if (outcome != Outcome.Correct && outcome != Outcome.Errors)
                {
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (T/O)
                }

                /*if (outcome == Outcome.Errors && reporter.callSitesToExpand.Count == 0)
                {
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (error found)
                }*/
                if (outcome == Outcome.Errors)
                {
                    foreach (var scs in reporter.callSitesToExpand)
                    {

                        openCallSites.Remove(scs);
                        var svc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                        if (svc != null)
                        {
                            openCallSites.UnionWith(svc.CallSites);
                            Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                        }
                    }
                    if (ucore != null || ucore.Count != 0)
                    {

                        foreach (StratifiedCallSite cs in attachedVC.Keys)
                        {
                            if (ucore.Contains("label_" + cs.callSiteExpr.ToString()))
                            {
                                CallSitesInUCore.Add(cs);  
                            }
                        }
                    }

                }
                else
                {
                    Decision topDecision = null;
                    SiState topState = SiState.SaveState(this, openCallSites, previousSplitSites);
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    var doneBT = false;
                    var npops = 0;
                    do
                    {
                        if (decisions.Count == 0)
                        {
                            doneBT = true;
                            break;
                        }

                        topDecision = decisions.Peek();
                        topState = backtrackingPoints.Peek();

                        // Pop
                        Pop();
                        decisions.Pop();
                        backtrackingPoints.Pop();
                        prevMustAsserted.Pop();
                        npops++;

                    } while (topDecision.num == 1);

                    if (doneBT)
                        break;

                    topState.ApplyState(this, ref openCallSites, ref previousSplitSites);
                    timeGraph.Pop(npops - 1);

                    // flip the decision

                    Push();
                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));

                    if (topDecision.decisionType == DecisionType.MUST_REACH)
                    {
                        // Block
                        prover.Assert(topDecision.cs.callSiteExpr, false);
                        decisions.Push(new Decision(DecisionType.BLOCK, 1, topDecision.cs));
                        applyDecisionToDI(DecisionType.BLOCK, attachedVC[topDecision.cs]);
                        prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                        treesize = di.ComputeSize();
                    }
                    else
                    {
                        // Must Reach
                        decisions.Push(new Decision(DecisionType.MUST_REACH, 1, topDecision.cs));
                        applyDecisionToDI(DecisionType.MUST_REACH, attachedVC[topDecision.cs]);
                        prevMustAsserted.Push(
                           AssertMustReach(attachedVC[topDecision.cs], PrevAsserted()));
                        treesize = di.ComputeSize();
                    }
                }
            }
            reporter.reportTraceIfNothingToExpand = false;

            Console.WriteLine("Time spent taking decisions: {0} s", tt.TotalSeconds.ToString("F2"));

            Console.Write("SplitSearch: ");
            double singleCoreTime = 0;
            double sixteenCoreTime = 0;
            for (int i = 1; i <= 100; i++)
            {
                var sum = 0.0;
                for (int j = 0; j < 5; j++) sum += timeGraph.ComputeTimes(i);
                sum = sum / 5;
                if (i == 1)
                    singleCoreTime = sum;
                if (i == 16)
                    sixteenCoreTime = sum;
                Console.Write("{0}\t", sum.ToString("F2"));
            }
            Console.WriteLine(" :end");
            timeGraph.ToDot();
            Console.WriteLine("splitInfo: " + UCsplit + "," + timeGraph.numPartitions + " :infoEnd");
            if (outcome == Outcome.Correct && reachedBound) return Outcome.ReachedBound;
            return outcome;
        }

        int checkSplit(List<StratifiedCallSite> CallSitesInUCore, HashSet<string> previousSplitSites, bool splitOnDemand)
        {
            int splitFlag = 0;
            if (CallSitesInUCore.Count != 0)
            {
                foreach (StratifiedCallSite cs in CallSitesInUCore)
                {
                    if (!previousSplitSites.Contains(GetPersistentID(cs)))
                    {
                        splitFlag = 1;
                        break;
                    }
                }
                if (splitOnDemand)
                {
                    string reply = sendRequestToServer("SplitNow", "IsThereAnyWaitingClient");
                    if (reply.Equals("NO"))
                        splitFlag = 0;
                }
            }
            return splitFlag;
        }

        public Outcome UnSatCoreSplitStyleParallel(HashSet<StratifiedCallSite> openCallSites,
            StratifiedInliningErrorReporter reporter, TimeGraph timeGraph,
            Stack<List<Tuple<StratifiedVC, Block>>> prevMustAssertedSoFar, 
            Stack<SiState> backtrack, Stack<Decision> dc)
        {
            //flags to set - /newStratifiedInlining:ucsplit /enableUnSatCoreExtraction:1

            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;
            var boundHit = false;
            int treesize = 0;
            Stack<SiState> backtrackingPoints = new Stack<SiState>(backtrack);
            Stack<Decision> decisions = new Stack<Decision>(dc);
            var prevMustAsserted = new Stack<List<Tuple<StratifiedVC, Block>>>(prevMustAssertedSoFar);
            List<string> ucore = null;
            List<StratifiedCallSite> CallSitesInUCore = new List<StratifiedCallSite>();
            //var timeGraph = new TimeGraph();
            int numSplits = 0;
            int UCsplit = 0;
            //bool startFirstJob = false;
            string replyFromServer;
            //string calltreeToSend = "";
            numPush = 0;
            bool pauseForDebug = false;
            bool writeLog = false;
            bool makeTimeGraph = false;
            string lastCalltreeSent = string.Empty;
            bool splitOnDemand = false;
            bool learnProofs = false;
            bool newCallSiteFound = false;
            bool decisionBlockFound = false;
            int maxSplitPerIteration = cba.Util.HydraConfig.maxSplitPerIteration;
            int numSplitThisIteration = 0;
            int aggressiveSplitQueryBound = 5;
            string verificationAlgorithm = cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower();
            //Console.WriteLine("recursion bound : " + CommandLineOptions.Clo.RecursionBound);
            //Console.ReadLine();
            //HashSet<string> previousSplitSites = new HashSet<string>();
            /*Console.WriteLine("Requesting ID");
            replyFromServer = sendRequestToServer("requestID", "What Is My ID");
            clientID = replyFromServer;
            Console.WriteLine("Client ID is : " + clientID);*/
            var indent = new Func<int, string>(i =>
            {
                var ret = "";
                while (i > 0) { i--; ret += " "; }
                return ret;
            });

            var PrevAsserted = new Func<HashSet<Tuple<StratifiedVC, Block>>>(() =>
            {
                var ret = new HashSet<Tuple<StratifiedVC, Block>>();
                prevMustAsserted.ToList().Iter(ls =>
                    ls.Iter(tup => ret.Add(tup)));
                return ret;
            });

            var applyDecisionToDI = new Action<DecisionType, StratifiedVC>((d, n) =>
            {
                if (d == DecisionType.BLOCK)
                {
                    di.DeleteNode(n);
                }
                if (d == DecisionType.MUST_REACH)
                {
                    var disj = di.DisjointNodes(n);
                    disj.Iter(m => di.DeleteNode(m));
                }
            });

            var containingVC = new Func<StratifiedCallSite, StratifiedVC>(scs => attachedVC[parent[scs]]);

            var reachedBound = false;

            var tt = TimeSpan.Zero;

            //Reset Variables
            /*HashSet<StratifiedCallSite> initOpenCallSites = new HashSet<StratifiedCallSite>();
            foreach (StratifiedCallSite cs in openCallSites)
                initOpenCallSites.Add(cs);
            Dictionary<StratifiedCallSite, StratifiedVC> initAttachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>(attachedVC);
            Dictionary<StratifiedVC, StratifiedCallSite> initAttachedVCInv = new Dictionary<StratifiedVC, StratifiedCallSite>(attachedVCInv);
            Dictionary<StratifiedCallSite, StratifiedCallSite> initParent = new Dictionary<StratifiedCallSite, StratifiedCallSite>(parent);
            DI initDi = di.Copy();
            ProverInterface initProver = prover;
            Console.WriteLine("initial state: ");
            Console.WriteLine(initOpenCallSites.Count + " " + initAttachedVC.Count + " " + initAttachedVCInv.Count + " " + initParent.Count + " " + numPush);
            */
            /*Console.WriteLine("Start First Job?");
            replyFromServer = sendRequestToServer("startFirstJob", "Start Job 0?");
            Console.WriteLine("Reply : " + replyFromServer);
            if (replyFromServer.Equals("YES"))
                startFirstJob = true;
            else
            {
                startFirstJob = false;
                Console.WriteLine("Request Calltree");
                replyFromServer = sendRequestToServer("Calltree", clientID);
            }*/

            while (true)
            {
                //Pre-inline proofSites
                if (learnProofs)
                {
                    if (proofSites.Count != 0)
                    {
                        HashSet<StratifiedCallSite> temp = new HashSet<StratifiedCallSite>(openCallSites);
                        foreach (var scs in temp)
                        {
                            if (proofSites.Contains(GetPersistentID(scs)))
                            {
                                calltreeToSend = calltreeToSend + GetPersistentID(scs) + ",";

                                openCallSites.Remove(scs);
                                var svc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                                if (svc != null)
                                {
                                    openCallSites.UnionWith(svc.CallSites);
                                    Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                                }
                            }
                        }
                    }
                }
                // Lets split when the tree has become big enough
                splittingStartTime = DateTime.Now;
                var size = di.ComputeSize();
                int splitFlag = 0;
                Dictionary<StratifiedCallSite, int> UCoreChildrenCount = new Dictionary<StratifiedCallSite, int>();
                if (verificationAlgorithm == "ucsplitparallel" || verificationAlgorithm == "ucsplitparallel2" || verificationAlgorithm == "ucsplitparallel5")
                {
                    splitFlag = checkSplit(CallSitesInUCore, previousSplitSites, splitOnDemand);
                    if (CallSitesInUCore.Count != 0 && splitFlag == 1)
                    {
                        foreach (StratifiedCallSite cs in CallSitesInUCore)
                        {
                            if (UCoreChildrenCount.ContainsKey(cs))
                            {
                                UCoreChildrenCount[cs] = UCoreChildrenCount[cs] + 1;
                            }
                            else
                            {
                                UCoreChildrenCount.Add(cs, 1);
                            }
                            StratifiedCallSite parentOfCs = cs;
                            while (parent.ContainsKey(parentOfCs))
                            {
                                parentOfCs = parent[parentOfCs];
                                if (UCoreChildrenCount.ContainsKey(parentOfCs))
                                {
                                    UCoreChildrenCount[parentOfCs] = UCoreChildrenCount[parentOfCs] + 1;
                                }
                                else
                                {
                                    UCoreChildrenCount.Add(parentOfCs, 1);
                                }
                            }
                        }
                    }
                    if (((treesize == 0 && size > 2) || (treesize != 0 && size > treesize + 2)) && splitFlag == 1
                    && (DateTime.Now - lastSplitAt).TotalSeconds >= nextSplitInterval)
                    {
                        var st = DateTime.Now;

                        // find a node to split on
                        StratifiedVC maxVc = null;
                        double maxVcScore = 0;
                        var toRemove = new HashSet<StratifiedVC>();
                        var sizes = di.ComputeSubtrees();
                        var disj = di.ComputeNumDisjoint();
                        /*if (splitFlag == 1)
                            Console.WriteLine("Splitting On UNSATCORE");
                        else
                            Console.WriteLine("Splitting On MUSTREACH");*/
                        foreach (var vc in attachedVCInv.Keys)
                        {
                            if (!di.VcExists(vc))
                            {
                                toRemove.Add(vc);
                                continue;
                            }
                            if (verificationAlgorithm == "ucsplitparallel" || verificationAlgorithm == "ucsplitparallel5")
                            {
                                //Console.WriteLine("SPLITTING ON UNSAT CORE");
                                var score = 0;
                                StratifiedCallSite cs = attachedVCInv[vc];
                                if (UCoreChildrenCount.ContainsKey(cs))
                                {
                                    score = UCoreChildrenCount[cs];
                                }
                                if (!previousSplitSites.Contains(GetPersistentID(cs)) && CallSitesInUCore.Contains(cs) && score >= maxVcScore)
                                {
                                    maxVc = vc;
                                    maxVcScore = score;
                                }
                            }
                            else if (verificationAlgorithm == "ucsplitparallel2")
                            {
                                double score = 0;
                                double numUnsatNodesInOwnSubtree = 0;
                                double numUnsatNodesInSiblingSubtree = 0;
                                StratifiedCallSite cs = attachedVCInv[vc];
                                if (UCoreChildrenCount.ContainsKey(cs))
                                {
                                    numUnsatNodesInOwnSubtree = UCoreChildrenCount[cs];
                                }
                                var disjointNodes = di.DisjointNodes(vc);
                                foreach (StratifiedVC v in disjointNodes)
                                {
                                    if (CallSitesInUCore.Contains(attachedVCInv[v]))
                                        numUnsatNodesInSiblingSubtree++;
                                }
                                score = Math.Min(numUnsatNodesInOwnSubtree, numUnsatNodesInSiblingSubtree) / Math.Max(numUnsatNodesInOwnSubtree, numUnsatNodesInSiblingSubtree);
                                if (!previousSplitSites.Contains(GetPersistentID(cs)) && CallSitesInUCore.Contains(cs) && score >= maxVcScore)
                                {
                                    maxVc = vc;
                                    maxVcScore = score;
                                }
                            }
                        }

                        if (maxVc != null)
                        {
                            //Console.WriteLine("SCORE : {0}, INTERVAL : {1}, TIME : {2}", maxVcScore, nextSplitInterval, (DateTime.Now - lastSplitAt).TotalSeconds);
                            toRemove.Iter(vc => attachedVCInv.Remove(vc));
                            UCsplit += 1;
                            StratifiedCallSite scs = attachedVCInv[maxVc];
                            previousSplitSites.Add(GetPersistentID(scs));
                            Debug.Assert(!openCallSites.Contains(scs));
                            numSplits = numSplits + 1;
                            var desc = sizes[maxVc];
                            var cnt = 0;
                            openCallSites.Iter(cs => cnt += desc.Contains(containingVC(cs)) ? 1 : 0);
                            // Push & Block
                            //var tgNode = string.Format("{0},{1}", scs.callSite.calleeName, maxVcScore);
                            //timeGraph.AddEdge(tgNode, decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                            if (makeTimeGraph)
                            {
                                timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                                parentNodeInTimegraph = childNodeInTimegraph;
                                childNodeInTimegraph = timeGraph.Count() + 1;
                                if (!timeGraph.Nodes.ContainsKey(parentNodeInTimegraph))
                                    timeGraph.Nodes.Add(parentNodeInTimegraph, "");
                                if (!timeGraph.Nodes.ContainsKey(childNodeInTimegraph))
                                    timeGraph.Nodes.Add(childNodeInTimegraph, "");
                                Tuple<int, int> saveStateTimegraph = new Tuple<int, int>(parentNodeInTimegraph, childNodeInTimegraph);
                                if (writeLog)
                                    Console.WriteLine("SaveState " + parentNodeInTimegraph + " " + childNodeInTimegraph);
                                emulateServerStack.Push(saveStateTimegraph);
                                childNodeInTimegraph = childNodeInTimegraph + 1;
                                if (!timeGraph.Nodes.ContainsKey(childNodeInTimegraph))
                                    timeGraph.Nodes.Add(childNodeInTimegraph, "");
                                timeGraph.startTime = DateTime.Now;
                            }
                            Push();
                            //backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));
                            //prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                            //decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                            //applyDecisionToDI(DecisionType.BLOCK, maxVc);

                            if (writeLog)
                                Console.WriteLine("splitting on : " + GetPersistentID(scs));
                            if (writeLog)
                                Console.WriteLine(calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",");
                            lastCalltreeSent = calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",";
                            replyFromServer = sendCalltreeToServer(calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",");
                            backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites, lastCalltreeSent));
                            prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                            decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                            prover.Assert(scs.callSiteExpr, false, name: "block_" + GetPersistentID(scs));
                            treesize = di.ComputeSize();
                            tt += (DateTime.Now - st);
                            if (writeLog)
                                Console.WriteLine(replyFromServer);
                            if (pauseForDebug)
                                Console.ReadLine();
                            calltreeToSend = calltreeToSend + "BLOCK," + GetPersistentID(scs) + ",";
                        }

                    }
                }
                else if (verificationAlgorithm == "ucsplitparallel3")
                {
                    List<StratifiedCallSite> candidates = new List<StratifiedCallSite>();
                    List<StratifiedCallSite> checkedCandidates = new List<StratifiedCallSite>();
                    //while (numSplitThisIteration <= maxSplitPerIteration)
                    int numAggressiveSplitQueries = 0;
                    while (true)
                    {
                        //Console.WriteLine("CANDIDATES : " + candidates.Count);
                        //Console.WriteLine("CHECKED CANDIDATES : " + checkedCandidates.Count);

                        StratifiedCallSite toRemoveCs = null;
                        // find a node to split on
                        StratifiedVC maxVc = null;
                        double maxVcScore = 0;

                        ucore = null;
                        boundHit = false;
                        foreach (StratifiedCallSite cs in candidates)
                        {
                            if (!checkedCandidates.Contains(cs))
                            {
                                toRemoveCs = cs;
                                checkedCandidates.Add(toRemoveCs);
                                break;
                            }
                        }
                        if (toRemoveCs == null && checkedCandidates.Count != 0)
                            break;

                        // underapproximate query
                        //Console.WriteLine("Underapprox Begin");
                        Push();
                        foreach (StratifiedCallSite cs in openCallSites)
                        {
                            if (toRemoveCs != null && GetPersistentID(cs) == GetPersistentID(toRemoveCs))
                                continue;
                            //Console.WriteLine(GetPersistentID(cs));
                            if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                                (CommandLineOptions.Clo.StackDepthBound > 0 &&
                                StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                            {
                                prover.Assert(cs.callSiteExpr, false); // Do assert without the label (not caught in UNSAT core)
                                procsHitRecBound.Add(cs.callSite.calleeName);
                                boundHit = true;
                            }
                            // Non-uniform unfolding
                            if (BoogieVerify.options.NonUniformUnfolding && RecursionDepth(cs) > 1)
                                Debug.Assert(false, "Non-uniform unfolding not handled in UW!");

                            prover.Assert(cs.callSiteExpr, false, name: "label_" + cs.callSiteExpr.ToString());
                        }
                        reporter.reportTrace = true;
                        DateTime uqStartTimein = DateTime.Now;
                        outcome = CheckVC(reporter);
                        Debug.WriteLine("UNDERAPPROX QUERY TIME = " + (DateTime.Now - uqStartTimein).TotalSeconds);
                        /*if (outcome == Outcome.Errors)
                        {
                            //Console.WriteLine("EtUC");
                            //timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                            if (makeTimeGraph)
                                timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                            //sendRequestToServer("outcome", "NOK");
                            Pop();
                            break; // done (error found)
                        }*/
                        ucore = null;
                        if (outcome == Outcome.Correct)
                        {
                            ucore = prover.UnsatCore();
                            if (ucore != null)
                                Debug.WriteLine("UCORE COUNT : " + ucore.Count);
                        }
                        Pop();
                        if (ucore != null && ucore.Count != 0)
                        {
                            foreach (StratifiedCallSite cs in attachedVC.Keys)
                            {
                                if (ucore.Contains("label_" + cs.callSiteExpr.ToString()))
                                {
                                    if (!CallSitesInUCore.Contains(cs))
                                        CallSitesInUCore.Add(cs);
                                    if (!candidates.Contains(cs))
                                        candidates.Add(cs);
                                }
                            }
                        }
                        //Console.WriteLine(ucore.Count + " " + candidates.Count);
                        //Console.ReadLine();
                        numAggressiveSplitQueries++;
                        if (candidates.Count == 0 || numAggressiveSplitQueries >= aggressiveSplitQueryBound)
                            break;
                    }
                    if (candidates.Count != 0 && splitFlag == 1)
                    {
                        foreach (StratifiedCallSite cs in candidates)
                        {
                            if (UCoreChildrenCount.ContainsKey(cs))
                            {
                                UCoreChildrenCount[cs] = UCoreChildrenCount[cs] + 1;
                            }
                            else
                            {
                                UCoreChildrenCount.Add(cs, 1);
                            }
                            StratifiedCallSite parentOfCs = cs;
                            while (parent.ContainsKey(parentOfCs))
                            {
                                parentOfCs = parent[parentOfCs];
                                if (UCoreChildrenCount.ContainsKey(parentOfCs))
                                {
                                    UCoreChildrenCount[parentOfCs] = UCoreChildrenCount[parentOfCs] + 1;
                                }
                                else
                                {
                                    UCoreChildrenCount.Add(parentOfCs, 1);
                                }
                            }
                        }
                    }
                    //Console.WriteLine("EXITED LOOP");
                    //Console.ReadLine();
                    foreach (StratifiedCallSite cs in candidates)
                    {
                        Debug.WriteLine(GetPersistentID(cs) + " " + attachedVC.ContainsKey(cs));
                    }
                    //Console.ReadLine();
                    while (candidates.Count != 0)
                    {
                        var toRemove = new HashSet<StratifiedVC>();
                        var sizes = di.ComputeSubtrees();
                        var disj = di.ComputeNumDisjoint();
                        var st = DateTime.Now;
                        //TODO: sort candidates by their score
                        StratifiedVC maxVc = null;
                        StratifiedCallSite maxNonInlinedCallsite = null;
                        double maxVcScore = 0;
                        double maxNonInlinedCallsiteScore = 0;
                        //Console.WriteLine("HERE1");
                        //Console.ReadLine();
                        foreach (var vc in attachedVCInv.Keys)
                        {
                            if (!di.VcExists(vc))
                            {
                                toRemove.Add(vc);
                                continue;
                            }
                            double score = 0;
                            StratifiedCallSite cs = attachedVCInv[vc];
                            //Console.WriteLine("HERE2");
                            //Console.ReadLine();
                            if (UCoreChildrenCount.ContainsKey(cs))
                            {
                                score = UCoreChildrenCount[cs];
                            }
                            if (candidates.Contains(cs) && !previousSplitSites.Contains(GetPersistentID(cs)) && score >= maxVcScore)
                            {
                                maxVc = vc;
                                maxVcScore = score;
                            }
                        }
                        foreach (StratifiedCallSite cs in openCallSites)
                        {
                            double score = 0;
                            if (UCoreChildrenCount.ContainsKey(cs))
                            {
                                score = UCoreChildrenCount[cs];
                            }
                            if (candidates.Contains(cs) && !previousSplitSites.Contains(GetPersistentID(cs)) && score >= maxNonInlinedCallsiteScore)
                            {
                                maxNonInlinedCallsite = cs;
                                maxNonInlinedCallsiteScore = score;
                            }
                        }
                        if (maxNonInlinedCallsiteScore > maxVcScore)
                        {
                            //Console.WriteLine("SPLITTING ON NON-INLINED CALLSITE");
                            //Console.ReadLine();
                            StratifiedCallSite scs = maxNonInlinedCallsite;
                            calltreeToSend = calltreeToSend + GetPersistentID(scs) + ",";

                            openCallSites.Remove(scs);
                            var svc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                            if (svc != null)
                            {
                                openCallSites.UnionWith(svc.CallSites);
                                Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                            }
                            maxVc = attachedVC[scs];
                        }
                        //Console.WriteLine("HERE3");
                        //Console.ReadLine();
                        if (maxVc != null)
                        {
                            StratifiedCallSite cs = attachedVCInv[maxVc];
                            //StratifiedVC maxVc = vc;
                            //Console.WriteLine("IN SPLIT : " + GetPersistentID(cs) + " " + candidates.Contains(cs) + " " + previousSplitSites.Count);
                            //if (candidates.Contains(cs))
                            {
                                candidates.Remove(cs);
                                //if (!previousSplitSites.Contains(GetPersistentID(cs)))
                                {
                                    toRemove.Iter(vc2 => attachedVCInv.Remove(vc2));
                                    UCsplit += 1;
                                    StratifiedCallSite scs = attachedVCInv[maxVc];
                                    previousSplitSites.Add(GetPersistentID(scs));
                                    Debug.Assert(!openCallSites.Contains(scs));
                                    numSplits = numSplits + 1;
                                    var desc = sizes[maxVc];
                                    var cnt = 0;
                                    openCallSites.Iter(cs2 => cnt += desc.Contains(containingVC(cs2)) ? 1 : 0);
                                    // Push & Block
                                    //var tgNode = string.Format("{0},{1}", scs.callSite.calleeName, maxVcScore);
                                    //timeGraph.AddEdge(tgNode, decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                                    if (makeTimeGraph)
                                    {
                                        timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                                        parentNodeInTimegraph = childNodeInTimegraph;
                                        childNodeInTimegraph = timeGraph.Count() + 1;
                                        if (!timeGraph.Nodes.ContainsKey(parentNodeInTimegraph))
                                            timeGraph.Nodes.Add(parentNodeInTimegraph, "");
                                        if (!timeGraph.Nodes.ContainsKey(childNodeInTimegraph))
                                            timeGraph.Nodes.Add(childNodeInTimegraph, "");
                                        Tuple<int, int> saveStateTimegraph = new Tuple<int, int>(parentNodeInTimegraph, childNodeInTimegraph);
                                        if (writeLog)
                                            Console.WriteLine("SaveState " + parentNodeInTimegraph + " " + childNodeInTimegraph);
                                        emulateServerStack.Push(saveStateTimegraph);
                                        childNodeInTimegraph = childNodeInTimegraph + 1;
                                        if (!timeGraph.Nodes.ContainsKey(childNodeInTimegraph))
                                            timeGraph.Nodes.Add(childNodeInTimegraph, "");
                                        timeGraph.startTime = DateTime.Now;
                                    }
                                    Push();
                                    //backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));
                                    //prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                                    //decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                                    //applyDecisionToDI(DecisionType.BLOCK, maxVc);

                                    //if (writeLog)
                                    //Console.WriteLine("splitting on : " + GetPersistentID(scs));
                                    if (writeLog)
                                        Console.WriteLine(calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",");
                                    lastCalltreeSent = calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",";
                                    replyFromServer = sendCalltreeToServer(calltreeToSend + "MUSTREACH," + GetPersistentID(scs) + ",");
                                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites, lastCalltreeSent));
                                    prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                                    decisions.Push(new Decision(DecisionType.BLOCK, 0, scs));
                                    //prover.Assert(scs.callSiteExpr, true);
                                    treesize = di.ComputeSize();
                                    tt += (DateTime.Now - st);
                                    if (writeLog)
                                        Console.WriteLine(replyFromServer);
                                    if (pauseForDebug)
                                        Console.ReadLine();
                                    calltreeToSend = calltreeToSend + "BLOCK," + GetPersistentID(scs) + ",";
                                    numSplitThisIteration++;
                                }
                            }
                        }
                        if (numSplitThisIteration == maxSplitPerIteration || maxVc == null)
                            break;
                    }
                }
                
                numSplitThisIteration = 0;
                splittingTime = splittingTime + (DateTime.Now - splittingStartTime).TotalSeconds;
                ucore = null;
                boundHit = false;
                // underapproximate query
                //Console.WriteLine("Underapprox Begin");
                Push();
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    //Console.WriteLine(GetPersistentID(cs));
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false); // Do assert without the label (not caught in UNSAT core)
                        procsHitRecBound.Add(cs.callSite.calleeName);
                        boundHit = true;
                    }
                    // Non-uniform unfolding
                    if (BoogieVerify.options.NonUniformUnfolding && RecursionDepth(cs) > 1)
                        Debug.Assert(false, "Non-uniform unfolding not handled in UW!");

                    prover.Assert(cs.callSiteExpr, false, name: "label_" + cs.callSiteExpr.ToString());

                    continue;

                }
                //Console.WriteLine("Underapprox end");
                reporter.reportTrace = true;
                if (writeLog)
                    Console.WriteLine("point 0.1");
                DateTime uqStartTime = DateTime.Now;
                outcome = CheckVC(reporter);
                Debug.WriteLine("UNDERAPPROX QUERY TIME = " + (DateTime.Now - uqStartTime).TotalSeconds);
                if (writeLog)
                    Console.WriteLine("point 0.2");

                if (outcome == Outcome.Errors)
                {
                    //Console.WriteLine("EtUC");
                    //timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    if (makeTimeGraph)
                        timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                    //sendRequestToServer("outcome", "NOK");
                    break; // done (error found)
                }
                if (writeLog)
                    Console.WriteLine("point 1");
                if (outcome == Outcome.Correct)
                {
                    ucore = prover.UnsatCore();
                }
                if (writeLog)
                    Console.WriteLine("point 2");
                Pop();
                if (writeLog)
                    Console.WriteLine("point 3");
                //Push();
                //var softAssumptions = new List<VCExpr>();
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        reachedBound = true;
                    }
                    //if (BoogieVerify.options.NonUniformUnfolding && RecursionDepth(cs) > 1)
                    //    softAssumptions.Add(prover.VCExprGen.Not(cs.callSiteExpr));
                }
                if (writeLog)
                    Console.WriteLine("point 4");
                if (writeLog && ucore == null && outcome == Outcome.Correct)
                    Console.WriteLine("CORE is NULL");
                else if (writeLog && outcome == Outcome.Correct)
                    Console.WriteLine("ALL GooD");

                newCallSiteFound = false;
                decisionBlockFound = false;

                //UNDERAPPROX WIDENING : Inline all Callsites present in UNSAT core which are not inlined already
                if (verificationAlgorithm == "ucsplitparallel5" && ucore != null && outcome == Outcome.Correct)
                {
                    var toAdd = new HashSet<StratifiedCallSite>();
                    var toRemove = new HashSet<StratifiedCallSite>();
                    if (false && writeLog)
                        Console.WriteLine("UNSAT CORE Inlined Callsites");
                    foreach (var scs in openCallSites)
                    {
                        if (ucore.Contains("label_" + scs.callSiteExpr.ToString()))
                        {
                            calltreeToSend = calltreeToSend + GetPersistentID(scs) + ",";
                            if (false && writeLog)
                                Console.WriteLine(scs.callSite.calleeName);
                            toRemove.Add(scs);
                            newCallSiteFound = true;
                            var svc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                            //prover.Assert(scs.callSiteExpr, true, name: "label_" + scs.callSiteExpr.ToString());
                            if (svc != null)
                                toAdd.UnionWith(svc.CallSites);
                        }
                        //Check for reach/block label in UNSAT Core
                        if (!decisionBlockFound && (ucore.Contains("block_" + GetPersistentID(scs)) || ucore.Contains("mustreach_" + GetPersistentID(scs))))
                        {
                            decisionBlockFound = true;
                        }
                    }
                    //Update OpenCallSites
                    openCallSites.ExceptWith(toRemove);
                    openCallSites.UnionWith(toAdd);

                    if (ucore != null || ucore.Count != 0)
                    {
                        if (writeLog)
                            Console.WriteLine("All Callsites in UNSAT CORE");
                        foreach (StratifiedCallSite cs in attachedVC.Keys)
                        {
                            if (ucore.Contains("label_" + cs.callSiteExpr.ToString()))
                            {
                                CallSitesInUCore.Add(cs);
                                if (writeLog)
                                    Console.WriteLine("label : " + cs.callSite.calleeName);
                            }
                            if (writeLog && ucore.Contains("block_" + GetPersistentID(cs)))
                                Console.WriteLine("block : " + cs.callSite.calleeName);
                            if (writeLog && ucore.Contains("mustreach_" + GetPersistentID(cs)))
                                Console.WriteLine("mustreach : " + cs.callSite.calleeName);

                            //Check for reach/block label in UNSAT Core
                            if (!decisionBlockFound && (ucore.Contains("block_" + GetPersistentID(cs)) || ucore.Contains("mustreach_" + GetPersistentID(cs))))
                            {
                                decisionBlockFound = true;
                            }
                        }
                        if (writeLog)
                            Console.WriteLine("-------------------------");
                    }
                }

                if (verificationAlgorithm == "ucsplitparallel5" && !newCallSiteFound && !decisionBlockFound)
                {
                    //Program is SAFE
                    //TODO : Kill all clients and return PROGRAM as safe.
                    if (writeLog)
                        Console.WriteLine("PROGRAM IS SAFE");
                    outcome = Outcome.Correct;
                    isProgramSafe = true;
                    reachedBound = false;
                    break;
                }

                if (verificationAlgorithm != "ucsplitparallel5")
                {
                    reporter.callSitesToExpand = new List<StratifiedCallSite>();
                    reporter.reportTrace = false;
                    DateTime oqStartTime = DateTime.Now;
                    outcome = CheckVC(reporter);
                    Debug.WriteLine("OVERAPPROX QUERY TIME = " + (DateTime.Now - oqStartTime).TotalSeconds);
                    Debug.WriteLine(outcome.ToString());
                    //Pop();
                    if (outcome != Outcome.Correct && outcome != Outcome.Errors)
                    {
                        //timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                        //sendRequestToServer("outcome", "OK");
                        //timeGraph.AddEdgeDone("split");
                        if (makeTimeGraph)
                            timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                        break; // done (T/O)
                    }

                    if (outcome == Outcome.Errors)
                    {
                        foreach (var scs in reporter.callSitesToExpand)
                        {
                            calltreeToSend = calltreeToSend + GetPersistentID(scs) + ",";

                            openCallSites.Remove(scs);
                            var svc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                            if (svc != null)
                            {
                                openCallSites.UnionWith(svc.CallSites);
                                Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                            }
                        }
                        if (ucore != null || ucore.Count != 0)
                        {

                            foreach (StratifiedCallSite cs in attachedVC.Keys)
                            {
                                if (ucore.Contains("label_" + cs.callSiteExpr.ToString()))
                                {
                                    CallSitesInUCore.Add(cs);
                                }
                            }
                        }
                    }
                }


                /*if (outcome == Outcome.Errors && reporter.callSitesToExpand.Count == 0)
                {
                    timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                    break; // done (error found)
                }*/

                if ((verificationAlgorithm != "ucsplitparallel5" && outcome != Outcome.Errors) || (verificationAlgorithm == "ucsplitparallel5" && !newCallSiteFound))
                {
                    if (learnProofs)
                    {
                        if (outcome == Outcome.Correct)
                        {
                            var proofCore = prover.UnsatCore();
                            if (proofCore != null)
                            {
                                foreach (StratifiedCallSite cs in attachedVC.Keys)
                                {
                                    if (proofCore.Contains("label_" + cs.callSiteExpr.ToString()))
                                    {
                                        if (!proofSites.Contains(GetPersistentID(cs)))
                                            proofSites.Add(GetPersistentID(cs));
                                    }
                                }
                            }
                        }
                    }
                    if (writeLog)
                        Console.WriteLine("block finished");
                    if (makeTimeGraph)
                        timeGraph.AddEdge(parentNodeInTimegraph, childNodeInTimegraph, "split", (DateTime.Now - timeGraph.startTime).TotalSeconds);
                    if (writeLog)
                    {
                        Console.WriteLine("Before popping last:");
                        Console.WriteLine(calltreeToSend);
                    }
                    //calltreeToSend = popLastPartitionFromCalltree(calltreeToSend);
                    if (writeLog)
                    {
                        Console.WriteLine("After popping last:");
                        Console.WriteLine(calltreeToSend);
                    }
                    //Console.ReadLine();
                    replyFromServer = sendRequestToServer("popFromLocalStack", clientID);
                    if (replyFromServer.Equals("YES"))
                    //if (false)
                    {
                        //calltreeToSend = lastCalltreeSent;
                        Decision topDecision = null;
                        SiState topState = SiState.SaveState(this, openCallSites, previousSplitSites, calltreeToSend);
                        //timeGraph.AddEdgeDone(decisions.Count == 0 ? "" : decisions.Peek().decisionType.ToString());
                        var doneBT = false;
                        var npops = 0;
                        do
                        {
                            if (decisions.Count == 0)
                            {
                                doneBT = true;
                                break;
                            }

                            topDecision = decisions.Peek();
                            topState = backtrackingPoints.Peek();

                            // Pop
                            Pop();
                            decisions.Pop();
                            backtrackingPoints.Pop();
                            prevMustAsserted.Pop();
                            npops++;

                        } while (topDecision.num == 1);

                        if (doneBT)
                            break;

                        topState.ApplyState(this, ref openCallSites, ref previousSplitSites, ref calltreeToSend);
                        //timeGraph.Pop(npops - 1);

                        // flip the decision

                        Push();
                        backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites, calltreeToSend));

                        if (topDecision.decisionType == DecisionType.MUST_REACH)
                        {
                            // Block
                            prover.Assert(topDecision.cs.callSiteExpr, false, name: "block_" + GetPersistentID(topDecision.cs));
                            decisions.Push(new Decision(DecisionType.BLOCK, 1, topDecision.cs));
                            //applyDecisionToDI(DecisionType.BLOCK, attachedVC[topDecision.cs]);
                            prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                            treesize = di.ComputeSize();
                        }
                        else
                        {
                            // Must Reach
                            decisions.Push(new Decision(DecisionType.MUST_REACH, 1, topDecision.cs));
                            //applyDecisionToDI(DecisionType.MUST_REACH, attachedVC[topDecision.cs]);
                            prevMustAsserted.Push(
                               AssertMustReach(attachedVC[topDecision.cs], PrevAsserted()));
                            treesize = di.ComputeSize();
                        }
                    }
                    else
                    {
                        calltreeToSend = "";
                        break;
                    }
                }
            }
            reporter.reportTraceIfNothingToExpand = false;
            if (writeLog)
                Console.WriteLine("Time spent taking decisions: {0} s", tt.TotalSeconds.ToString("F2"));

            /*Console.Write("SplitSearch: ");
            double singleCoreTime = 0;
            double sixteenCoreTime = 0;
            for (int i = 1; i <= 100; i++)
            {
                var sum = 0.0;
                for (int j = 0; j < 5; j++) sum += timeGraph.ComputeTimes(i);
                sum = sum / 5;
                if (i == 1)
                    singleCoreTime = sum;
                if (i == 16)
                    sixteenCoreTime = sum;
                Console.Write("{0}\t", sum.ToString("F2"));
            }
            Console.WriteLine(" :end");
            timeGraph.ToDot();
            Console.WriteLine("splitInfo: " + UCsplit + "," + timeGraph.numPartitions + " :infoEnd");*/

            //if (outcome == Outcome.Correct && reachedBound)
            //    sendRequestToServer("outcome", "ReachedBound");
            //else if (outcome == Outcome.Correct)
            //    sendRequestToServer("outcome", "OK");

            if (outcome == Outcome.Correct && reachedBound) return Outcome.ReachedBound;
            //Console.ReadLine();
            return outcome;
        }

        public string popLastPartitionFromCalltree(string calltree)
        {
            string calltreeToSend = "";
            string[] splitCalltree = calltree.Split(',');
            int lastDecisionLocation = 0;

            for (int i = splitCalltree.Length-1; i > 0; i--)
            {
                if (splitCalltree[i].Equals("BLOCK") || splitCalltree[i].Equals("MUSTREACH"))
                {
                    lastDecisionLocation = i;
                    break;
                }
                //Console.WriteLine(splitCalltree[i]);
            }
            for (int i = 0; i < lastDecisionLocation; i++)
                calltreeToSend = calltreeToSend + splitCalltree[i] + ",";
            //Console.WriteLine(calltreeToSend);
            if (splitCalltree[lastDecisionLocation].Equals("BLOCK"))
                calltreeToSend = calltreeToSend + "MUSTREACH," + splitCalltree[lastDecisionLocation + 1] + ",";
            else if (splitCalltree[lastDecisionLocation].Equals("MUSTREACH"))
                calltreeToSend = calltreeToSend + "BLOCK," + splitCalltree[lastDecisionLocation + 1] + ",";
            else
                Console.WriteLine("Some Error During Popping calltreeToSend");
            //Console.WriteLine(calltreeToSend);
            return calltreeToSend;
        }

        public string sendRequestToServer(string request, string requestContent)
        {
            serverUri.Query = string.Format("{0}={1}", request, requestContent);
            //Console.WriteLine(string.Format("{0}={1}", request, requestContent));
            DateTime communicationStartTime = DateTime.Now;
            string replyFromServer = callServer.GetStringAsync(serverUri.Uri).Result;
            communicationTime =  communicationTime + (DateTime.Now - communicationStartTime).TotalSeconds;
            return replyFromServer;
        }

        public string sendCalltreeToServer(string calltree)
        {
            serverUri.Query = string.Empty;
            JsonContent tmp = new JsonContent(string.Format("{0}={1}", clientID, calltree));
            DateTime communicationStartTime = DateTime.Now;
            var rep = callServer.PostAsync(serverUri.Uri, tmp).Result;
            string replyFromServer = rep.Content.ReadAsStringAsync().Result;
            lastSplitAt = DateTime.Now;
            nextSplitInterval = double.Parse(replyFromServer);
            communicationTime = communicationTime + (DateTime.Now - communicationStartTime).TotalSeconds;
            return replyFromServer;
        }

        // Comment TODO
        public Outcome MustReachStyle(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter)
        {
            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;

            var backtrackingPoints = new Stack<SiState>();
            var decisions = new Stack<Decision>();
            var prevMustAsserted = new Stack<List<Tuple<StratifiedVC, Block>>>();

            var indent = new Func<int, string>(i =>
            {
                var ret = "";
                while (i > 0) { i--; ret += " "; }
                return ret;
            });

            var PrevAsserted = new Func<HashSet<Tuple<StratifiedVC, Block>>>(() =>
                {
                    var ret = new HashSet<Tuple<StratifiedVC, Block>>();
                    prevMustAsserted.ToList().Iter(ls =>
                        ls.Iter(tup => ret.Add(tup)));
                    return ret;
                });
            
            var rand = new Random();
            var reachedBound = false;

            var decideToInline = new Func<bool>(() =>
                {
                    return false; // rand.Next(100) != 0;
                });

            while (true)
            {
                MacroSI.PRINT_DEBUG("  - overapprox");

                // Find cex
                foreach (StratifiedCallSite cs in openCallSites)
                {                    
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        reachedBound = true;
                    }
                }
                MacroSI.PRINT_DEBUG("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);

                MacroSI.PRINT_DEBUG("    - checked: " + outcome);

                if (outcome != Outcome.Correct && outcome != Outcome.Errors)
                {
                    break; // done (T/O)
                }

                if (outcome == Outcome.Errors && reporter.callSitesToExpand.Count == 0)
                {
                    return Outcome.Errors; // done (error found)
                }

                if (outcome == Outcome.Errors)
                {
                    // pick one to inline
                    while (reporter.callSitesToExpand.Count != 0)
                    {
                        var rand_choice = rand.Next(reporter.callSitesToExpand.Count);
                        var scs = reporter.callSitesToExpand[rand_choice];
                        openCallSites.Remove(scs);
                        reporter.callSitesToExpand.Remove(scs);

                        // make a decision 
                        if (decideToInline())
                        {
                            Console.WriteLine("{0}>>> Inlining({1})", indent(decisions.Count), scs.callSite.calleeName);
                            // Inline
                            var svc = Expand(scs);
                            if (svc != null) openCallSites.UnionWith(svc.CallSites);
                        }
                        else
                        {
                            Console.WriteLine("{0}>>> Pushing Must-Reach({1})", indent(decisions.Count), scs.callSite.calleeName);
                            decisions.Push(new Decision(DecisionType.MUST_REACH, 0, scs));
                            backtrackingPoints.Push(SiState.SaveState(this, openCallSites));
                            Push();

                            // Inline
                            var svc = Expand(scs);
                            if (svc != null) openCallSites.UnionWith(svc.CallSites);
                            // Assert MustReach
                            prevMustAsserted.Push(
                                AssertMustReach(svc, PrevAsserted()));
                        }
                    }
                }
                else
                {
                    // outcome == Outcome.Correct
                    Decision topDecision = null;
                    SiState topState = SiState.SaveState(this, openCallSites);
                    var doneBT = false;
                    do
                    {
                        if (decisions.Count == 0)
                        {
                            doneBT = true;
                            break;
                        }

                        topDecision = decisions.Peek();
                        topState = backtrackingPoints.Peek();

                        // Pop
                        Pop();
                        decisions.Pop();
                        backtrackingPoints.Pop();
                        prevMustAsserted.Pop();
                        Console.WriteLine("{0}>>> Pop", indent(decisions.Count));
                    }while (topDecision.num == 1);

                    if (doneBT)
                        break;

                    topState.ApplyState(this, ref openCallSites);

                    // flip the decision
                    
                    Push();
                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites));

                    if (topDecision.decisionType == DecisionType.MUST_REACH)
                    {
                        // Block
                        prover.Assert(topDecision.cs.callSiteExpr, false);
                        Console.WriteLine("{0}>>> Pushing Block({1})", indent(decisions.Count), topDecision.cs.callSite.calleeName);
                        decisions.Push(new Decision(DecisionType.BLOCK, 1, topDecision.cs));
                        prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                    }
                    else
                    {
                        // Must Reach
                        Console.WriteLine("{0}>>> Pushing Must-Reach({1})", indent(decisions.Count), topDecision.cs.callSite.calleeName);
                        decisions.Push(new Decision(DecisionType.MUST_REACH, 1, topDecision.cs));
                        var svc = Expand(topDecision.cs);
                        if (svc != null) openCallSites.UnionWith(svc.CallSites);
                        prevMustAsserted.Push(
                           AssertMustReach(svc, PrevAsserted()));
                    }


                }
            }
            reporter.reportTraceIfNothingToExpand = false;

            if (outcome == Outcome.Correct && reachedBound) return Outcome.ReachedBound;
            return outcome;
        }

        // Does not make under-approx queries; doesn't do push/pop
        public Outcome FwdNoUnder(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter)
        {
            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;

            // candidates that are pinned to false because they hit the recursion bound
            var boundAsserted = new HashSet<StratifiedCallSite>();

            while (true)
            {
                MacroSI.PRINT_DEBUG("  - overapprox");

                // overapproximate query
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, CommandLineOptions.Clo.RecursionBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        if (!boundAsserted.Contains(cs))
                        {
                            prover.Assert(cs.callSiteExpr, false);
                            boundAsserted.Add(cs);
                        }
                    }
                }
                MacroSI.PRINT_DEBUG("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);

                MacroSI.PRINT_DEBUG("    - checked: " + outcome);
                if (outcome != Outcome.Errors)
                {
                    if (boundAsserted.Count > 0 && outcome == Outcome.Correct)
                        outcome = Outcome.ReachedBound;

                    break; // done
                }
                if (reporter.callSitesToExpand.Count == 0)
                    return Outcome.Errors;

                foreach (var scs in reporter.callSitesToExpand)
                {
                    Debug.Assert(!boundAsserted.Contains(scs));
                    openCallSites.Remove(scs);
                    var svc = Expand(scs);
                    if(svc != null) openCallSites.UnionWith(svc.CallSites);
                    Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                }
            }
            reporter.reportTraceIfNothingToExpand = false;
            return outcome;
        }

        // Duality style depth-first search with backtracking
        public Outcome DepthFirstStyle(Implementation main, VerifierCallback callback)
        {
            Outcome outcome = Outcome.Inconclusive;

            var boundHit = false;
            var decisions = new Stack<HashSet<StratifiedCallSite>>();
            var blocked = new HashSet<StratifiedCallSite>();
            var pushed = new Stack<HashSet<StratifiedVC>>();

            var name_counter = 0;
            var GetNewName = new Func<string, string>(v => v + (name_counter++).ToString());
            var name2vc = new Dictionary<string, StratifiedVC>();
            var vc2name = new Dictionary<StratifiedVC, string>();
            var backgroundnames = new HashSet<string>();

            Push();

            // Push main
            StratifiedVC mainVC = new StratifiedVC(implName2StratifiedInliningInfo[main.Name], implementations); ;
            HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(mainVC.CallSites);
            var mainName = GetNewName("background");
            prover.AssertNamed(mainVC.vcexpr, true, mainName);

            var reporter = new StratifiedInliningErrorReporter(callback, this, mainVC);
            reporter.reportTraceIfNothingToExpand = true;

            while (true)
            {
                boundHit = false;
                foreach (var cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (RecursionDepth(cs) > CommandLineOptions.Clo.RecursionBound ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        blocked.Add(cs);
                    }
                }


                Push();
                backgroundnames = new HashSet<string>();

                foreach (var cs in blocked)
                {
                    var bn = GetNewName("background");
                    prover.AssertNamed(cs.callSiteExpr, false, bn);
                    backgroundnames.Add(bn);
                }

#if false
                // underapproximate query
                MacroSI.PRINT_DETAIL("  - underapprox");
                Push();

                foreach (var cs in openCallSites)
                    prover.Assert(cs.callSiteExpr, false);

                MacroSI.PRINT_DETAIL("    - check");
                reporter.reportTrace = true;
                outcome = CheckVC(reporter);
                Pop();
                MacroSI.PRINT_DETAIL("    - checked: " + outcome);
                if (outcome != Outcome.Correct) break;

#endif
                MacroSI.PRINT_DEBUG("  - overapprox");
                // overapproximate query

                MacroSI.PRINT_DEBUG("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);

                MacroSI.PRINT_DEBUG("    - checked: " + outcome);

                // timeout?
                if (outcome != Outcome.Errors && outcome != Outcome.Correct)
                {
                    Pop();
                    break;
                }

                if (outcome == Outcome.Correct)
                {
                    if (decisions.Count == 0)
                    {
                        if (boundHit) outcome = Outcome.ReachedBound;
                        Pop();
                        break;
                    }

                    // compute interpolants
                    var leaves = pushed.Peek().Select(svc => vc2name[svc]).ToList();
                    var root = vc2name.Where(tup => !pushed.Peek().Contains(tup.Key))
                        .Select(tup => tup.Value).ToList();
                    root.AddRange(backgroundnames);
                    root.Add(mainName);

                    var summaries = prover.GetTreeInterpolant(root, leaves);
                    prover.LogComment(Environment.NewLine);

                    for (int i = 0; i < summaries.Count; i++)
                    {
                        Console.WriteLine("Summary of {0}: {1}", name2vc[leaves[i]].info.impl.Name, summaries[i]);
                    }

                    // backtrack
                    openCallSites.UnionWith(decisions.Peek());
                    blocked.ExceptWith(decisions.Peek());
                    decisions.Pop();
                    pushed.Pop();

                    Pop();
                    continue;
                }

                Pop();

                Debug.Assert(outcome == Outcome.Errors);
                Debug.Assert(reporter.callSitesToExpand.Count > 0);

                var block = new HashSet<StratifiedCallSite>(openCallSites);
                block.ExceptWith(reporter.callSitesToExpand);
                decisions.Push(block);

                var newvcs = new HashSet<StratifiedVC>();
                foreach (var scs in reporter.callSitesToExpand)
                {
                    openCallSites.Remove(scs);
                    var name = GetNewName(scs.callSite.calleeName);
                    var svc = Expand(scs, name, false, true);

                    name2vc.Add(name, svc);
                    vc2name.Add(svc, name);
                    openCallSites.UnionWith(svc.CallSites);
                    newvcs.Add(svc);
                    Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                }
                pushed.Push(newvcs);
            }

            Pop();

            return outcome;
        }

        public Outcome Fwd(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter, bool main, int recBound)
        {
            Outcome outcome = Outcome.Inconclusive;

            ForceInline(openCallSites, recBound);

            var boundHit = false;
            while (true)
            {
                // Check timeout
                if (CommandLineOptions.Clo.ProverKillTime != -1)
                {
                    if ((DateTime.UtcNow - startTime).TotalSeconds > CommandLineOptions.Clo.ProverKillTime)
                    {
                        return Outcome.TimedOut;
                    }
                }

                // Bound on max procs inlined
                if (BoogieVerify.options.maxInlinedBound != 0 &&
                    stats.numInlined > BoogieVerify.options.maxInlinedBound)
                {
                    return Outcome.ReachedBound;
                }

                MacroSI.PRINT_DEBUG("  - underapprox");
                boundHit = false;

                // underapproximate query
                Push();


                foreach (StratifiedCallSite cs in openCallSites)
                {
                    prover.Assert(cs.callSiteExpr, false);
                }

                MacroSI.PRINT_DEBUG("    - check");
                reporter.reportTrace = main;
                outcome = CheckVC(reporter);
                Pop();
                MacroSI.PRINT_DEBUG("    - checked: " + outcome);
                if (outcome != Outcome.Correct) break;

                MacroSI.PRINT_DEBUG("  - overapprox");
                // overapproximate query
                Push();
                var softAssumptions = new List<VCExpr>();
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (HasExceededRecursionDepth(cs, recBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        procsHitRecBound.Add(cs.callSite.calleeName);
                        //Console.WriteLine("Proc {0} hit rec bound of {1}", cs.callSite.calleeName, recBound);
                        boundHit = true;
                    }
                    // Non-uniform unfolding
                    if (BoogieVerify.options.NonUniformUnfolding && RecursionDepth(cs) > 1)
                        softAssumptions.Add(prover.VCExprGen.Not(cs.callSiteExpr));
                }
                MacroSI.PRINT_DEBUG("    - check");
                reporter.reportTrace = false;
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = BoogieVerify.options.NonUniformUnfolding ? CheckVC(softAssumptions, reporter) :
                    CheckVC(reporter);
                Pop();
                MacroSI.PRINT_DEBUG("    - checked: " + outcome);
                if (outcome != Outcome.Errors)
                {
                    if (boundHit && outcome == Outcome.Correct)
                        outcome = Outcome.ReachedBound;

                    break; // done
                }
                if (reporter.callSitesToExpand.Count == 0)
                    return Outcome.Inconclusive;

                var toExpand = reporter.callSitesToExpand;
                if (BoogieVerify.options.extraFlags.Contains("SiStingy"))
                {
                    var min = toExpand.Select(cs => RecursionDepth(cs)).Min();
                    toExpand = toExpand.Where(cs => RecursionDepth(cs) == min).ToList();
                }
                foreach (var scs in toExpand)
                {
                    openCallSites.Remove(scs);
                    var svc = Expand(scs);
                    if (svc != null)
                    {
                        openCallSites.UnionWith(svc.CallSites);
                        if (cba.Util.BoogieVerify.options.useFwdBck) MustNotFail(scs, svc);
                    }
                }

                ForceInline(openCallSites, recBound);
            }
            return outcome;
        }

        void ForceInline(HashSet<StratifiedCallSite> openCallSites, int recBound)
        {
            do
            {
                // force inline
                var toExpand = new HashSet<StratifiedCallSite>(openCallSites.Where(cs => forceInlineProcs.Contains(cs.callSite.calleeName)));
                // filter away ones that have reached the bound
                toExpand.RemoveWhere(cs => HasExceededRecursionDepth(cs, recBound) ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound));
                if (toExpand.Count == 0) break;

                foreach (var scs in toExpand)
                {
                    openCallSites.Remove(scs);
                    var svc = Expand(scs);
                    if (svc != null)
                    {
                        openCallSites.UnionWith(svc.CallSites);
                        if (cba.Util.BoogieVerify.options.useFwdBck) MustNotFail(scs, svc);
                    }
                }

            } while (true);
        }

        // Assert that we must reach this VC; returns the list of call sites asserted
        public List<Tuple<StratifiedVC, Block>> AssertMustReach(StratifiedVC svc, HashSet<Tuple<StratifiedVC, Block>> prevAsserted)
        {
            var ret = new List<Tuple<StratifiedVC, Block>>();
            var vcgen = svc.info.vcgen;
            var gen = vcgen.prover.VCExprGen;

            var v = vcgen.CreateNewVar(Bpl.Type.Bool); ;
            // This is most likely redundant
            prover.Assert(svc.MustReach(svc.info.impl.Blocks[0]), true, name: "mustreach_" + GetPersistentID(attachedVCInv[svc]));

            if (!attachedVCInv.ContainsKey(svc))
                return ret;

            var iter = attachedVCInv[svc]; 
            while (parent.ContainsKey(iter))
            {
                var vc = attachedVC[parent[iter]];
                var callblock = vc.callSites.First(tup => tup.Value.Contains(iter)).Key;
                
                var key = Tuple.Create(vc, callblock);
                if (prevAsserted != null && !prevAsserted.Contains(key))
                {
                    prover.Assert(vc.MustReach(callblock), true);
                    ret.Add(key);
                }
                iter = parent[iter];
            }
            prover.Assert(mainVC.MustReach(mainVC.callSites.First(tup => tup.Value.Contains(iter)).Key), true);
            return ret;
        }

        public Outcome Bck(StratifiedVC svc, HashSet<StratifiedCallSite> openCallSites,
            StratifiedInliningErrorReporter reporter, Dictionary<string, int> backboneRecDepth)
        {
            var outcome = Fwd(openCallSites, reporter, svc.info.impl.Name == mainProc.Name, CommandLineOptions.Clo.RecursionBound);
            if (outcome != Outcome.Errors)
                return outcome;
            if (svc.info.impl.Name == mainProc.Name)
                return outcome;

            outcome = Outcome.Correct;
            var boundHit = false;

            foreach (var caller in callGraph.callers[svc.info.impl.Proc])
            {
                if (backboneRecDepth[caller.Name] == CommandLineOptions.Clo.RecursionBound)
                {
                    boundHit = true;
                    continue;
                }

                // DFS: already exploring the assertMethods elsewhere
                //if (assertMethods.Contains(caller))
                //    continue;

                var callerVC = new StratifiedVC(implName2StratifiedInliningInfo[caller.Name], implementations);
                backboneRecDepth[caller.Name]++;
                var callerReporter = new StratifiedInliningErrorReporter(reporter.callback, this, callerVC);
                var callerOpenCallSites = new HashSet<StratifiedCallSite>(openCallSites);
                callerOpenCallSites.UnionWith(callerVC.CallSites);
                //Console.WriteLine("Adding call-sites: {0}", callerVC.CallSites.Select(s => s.callSiteExpr.ToString()).Concat(" "));

                foreach (var cs in callerVC.CallSites.Where(s => s.callSite.calleeName == svc.info.impl.Name))
                {
                    Push();

                    prover.Assert(AttachByEquality(cs, svc), true);
                    prover.Assert(cs.callSiteExpr, true);
                    prover.Assert(callerVC.vcexpr, true);
                    MustFail(callerVC);

                    attachedVC[cs] = svc;
                    foreach (var s in svc.CallSites)
                        parent[s] = cs;

                    var ccs = new HashSet<StratifiedCallSite>(callerOpenCallSites);
                    ccs.Remove(cs);

                    MacroSI.PRINT_DEBUG("    ~ bck to " + caller.Name);

                    outcome = Bck(callerVC, ccs, callerReporter, backboneRecDepth);

                    MacroSI.PRINT_DEBUG("    ~ bck to " + caller.Name + " Done");

                    foreach (var s in svc.CallSites)
                        parent.Remove(s);

                    callerOpenCallSites.Iter(ocs => attachedVC.Remove(ocs));

                    Pop();

                    if (outcome == Outcome.Errors)
                        break;
                    if (outcome != Outcome.ReachedBound && outcome != Outcome.Correct)
                        break;
                    if (outcome == Outcome.ReachedBound)
                        boundHit = true;
                }

                backboneRecDepth[caller.Name]--;

                if (outcome == Outcome.Errors)
                    break;
                if (outcome != Outcome.ReachedBound && outcome != Outcome.Correct)
                    break;
            }

            if (boundHit && outcome == Outcome.Correct)
                return Outcome.ReachedBound;

            return outcome;
        }

        public Outcome FwdBckVerify(Implementation impl, VerifierCallback callback)
        {
            MacroSI.PRINT_DETAIL("Starting forward/backward approach...");
            Outcome outcome = Outcome.Correct;
            var backbonedepth = new Dictionary<string, int>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(proc => backbonedepth.Add(proc.Name, 0));
            mainProc = impl.Proc;

            var boundHit = false;
            /* is there a method with assert leading to a real counter-example? */
            foreach (Procedure assertMethod in assertMethods)
            {
                /* if the method is not in the call-graph, it is the fake main initially added */
                if (!callGraph.callers.ContainsKey(assertMethod))
                    continue;

                Push();

                attachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>();
                parent = new Dictionary<StratifiedCallSite, StratifiedCallSite>();

                StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[assertMethod.Name], implementations); ;
                HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
                prover.Assert(svc.vcexpr, true);

                var reporter = new StratifiedInliningErrorReporter(callback, this, svc);
                MustFail(svc);

                outcome = Bck(svc, openCallSites, reporter, backbonedepth);

                Pop();

                /* a bug is found */
                if (outcome == Outcome.Errors)
                    return outcome;

                /* something went wrong */
                if (outcome != Outcome.ReachedBound && outcome != Outcome.Correct)
                    return outcome;

                if (outcome == Outcome.ReachedBound)
                    boundHit = true;

                MacroSI.PRINT_DETAIL("No bug starting from " + assertMethod.Name + ". Selecting next method (if existing)...");
            }

            /* none of the methods containing an assert reaches successfully the main -- the program is safe */
            return boundHit ? Outcome.ReachedBound : Outcome.Correct;
        }

        void MustFail(StratifiedVC svc)
        {
            Debug.Assert(svc.info.interfaceExprVars.Exists(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed)));

            var indexFirst = svc.info.interfaceExprVars.FindIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));
            var indexLast = svc.info.interfaceExprVars.FindLastIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));

            var AssertVar = new Action<int, bool>((index, b) =>
                {
                    if (cba.Util.BoogieVerify.assertsPassedIsInt)
                    {
                        Microsoft.Basetypes.BigNum zero = Microsoft.Basetypes.BigNum.FromInt(0);
                        prover.Assert(prover.VCExprGen.Eq(svc.interfaceExprVars[index], prover.VCExprGen.Integer(zero)), b);
                    }
                    else
                        prover.Assert(svc.interfaceExprVars[index], b);
                });

            // assertVar[First] is not set
            AssertVar(indexFirst, true);

            // assertVar[Last] is set
            AssertVar(indexLast, false);
        }

        void MustNotFail(StratifiedCallSite scs, StratifiedVC svc)
        {
            if (!svc.info.interfaceExprVars.Exists(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed)))
                return;

            var index = svc.info.interfaceExprVars.FindLastIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));
            VCExpr assertsPass = null;
            if (cba.Util.BoogieVerify.assertsPassedIsInt)
            {
                Microsoft.Basetypes.BigNum zero = Microsoft.Basetypes.BigNum.FromInt(0);
                assertsPass = prover.VCExprGen.Eq(scs.interfaceExprs[index], prover.VCExprGen.Integer(zero));
            }
            else
                assertsPass = scs.interfaceExprs[index];

            prover.Assert(prover.VCExprGen.Implies(scs.callSiteExpr, assertsPass), true);
        }

        // TODO: add this to BoogieVerifyOptions
        static string prevMain = null;
        static DagOracle prevDag = null;


        /* verification */

        public override Outcome VerifyImplementation(Implementation impl, VerifierCallback callback)
        {
            Outcome outcome;
            if (cba.Util.HydraConfig.startHydra)
                outcome = VerifyImplementationHydra(impl, callback);
            else
                outcome = VerifyImplementationCorral(impl, callback);
            return outcome;
        }

        public Outcome VerifyImplementationCorral(Implementation impl, VerifierCallback callback)
        {
            startTime = DateTime.UtcNow;

            procsHitRecBound = new HashSet<string>();

            // Find all procedures that are "forced inline"
            forceInlineProcs.UnionWith(program.TopLevelDeclarations.OfType<Implementation>()
                .Where(p => BoogieUtil.checkAttrExists(ForceInlineAttr, p.Attributes) || BoogieUtil.checkAttrExists(ForceInlineAttr, p.Proc.Attributes))
                .Select(p => p.Name));

            // assert true to flush all one-time axioms, decls, etc
            prover.Assert(VCExpressionGenerator.True, true);

            /* the forward/backward approach can only be applied for programs with asserts in calls
            * and single-threaded (multi-threaded programs contain a final assert in the main).
            * Otherwise, use forward approach */
            if (cba.Util.BoogieVerify.options.useFwdBck && assertMethods.Count > 0)
            {
                return FwdBckVerify(impl, callback);
            }
            else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "duality")
            {
                return DepthFirstStyle(impl, callback);
            }

            MacroSI.PRINT_DEBUG("Starting forward approach...");

            di = new DI(this, BoogieVerify.options.useFwdBck || !BoogieVerify.options.useDI);

            Push();

            StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[impl.Name], implementations);
            mainVC = svc;
            di.RegisterMain(svc);
            HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
            prover.Assert(svc.vcexpr, true);

            Outcome outcome;
            var reporter = new StratifiedInliningErrorReporter(callback, this, svc);


            #region Eager inlining
            // Eager inlining 
            for (int i = 1; i < cba.Util.BoogieVerify.options.StratifiedInlining && openCallSites.Count > 0; i++)
            {
                var nextOpenCallSites = new HashSet<StratifiedCallSite>();
                foreach (StratifiedCallSite scs in openCallSites)
                {
                    if (HasExceededRecursionDepth(scs, CommandLineOptions.Clo.RecursionBound)) continue;

                    var ss = Expand(scs);
                    if (ss != null) nextOpenCallSites.UnionWith(ss.CallSites);
                }
                openCallSites = nextOpenCallSites;
            }
            #endregion

            #region Repopulate Call Tree
            if (cba.Util.BoogieVerify.options.CallTree != null && di.disabled)
            {
                while (true)
                {
                    var toAdd = new HashSet<StratifiedCallSite>();
                    var toRemove = new HashSet<StratifiedCallSite>();
                    foreach (StratifiedCallSite scs in openCallSites)
                    {
                        if (!cba.Util.BoogieVerify.options.CallTree.Contains(GetPersistentID(scs))) continue;
                        toRemove.Add(scs);
                        var ss = Expand(scs);
                        if (ss != null) toAdd.UnionWith(ss.CallSites);
                        MacroSI.PRINT_DETAIL(string.Format("Eagerly inlining: {0}", scs.callSite.calleeName), 2);
                    }
                    openCallSites.ExceptWith(toRemove);
                    openCallSites.UnionWith(toAdd);
                    if (toRemove.Count == 0) break;
                }
            }

            // Repopulate the dag
            if (!di.disabled && prevDag != null && prevMain != null && prevMain == impl.Name)
            {
                var vcNodeMap = new BijectiveDictionary<StratifiedVC, DagOracle.DagNode>();
                vcNodeMap.Add(svc, prevDag.GetRoot());

                var stack = new Queue<DagOracle.DagNode>();
                var expanded = new HashSet<DagOracle.DagNode>();

                stack.Enqueue(prevDag.GetRoot());
                expanded.Add(prevDag.GetRoot());

                while (stack.Any())
                {
                    var n1 = stack.Dequeue();
                    Debug.Assert(expanded.Contains(n1));

                    foreach (var e in prevDag.Children[n1])
                    {
                        var n2 = e.Target;

                        // Find call site
                        var vc1 = vcNodeMap[n1];
                        var cs =
                            vc1.CallSites.FirstOrDefault(s =>
                                GetSiCallId(s) == e.CallSite && s.callSite.calleeName == n2.ImplName);
                        Debug.Assert(cs != null);
                        openCallSites.Remove(cs);

                        if (expanded.Contains(n2))
                        {
                            // Merge
                            var vc2 = vcNodeMap[n2];
                            Merge(cs, vc2);
                        }
                        else
                        {
                            // Expand
                            var vc2 = Expand(cs, null, true, true);
                            openCallSites.UnionWith(vc2.CallSites);
                            vcNodeMap.Add(vc2, n2);
                            expanded.Add(n2);
                            stack.Enqueue(n2);
                        }

                    }

                }
            }

            #endregion

            // Stratified Search
            if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "nounder")
            {
                outcome = FwdNoUnder(openCallSites, reporter);
            }
            else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "mustreach")
            {
                outcome = MustReachStyle(openCallSites, reporter);
            }
            else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "split" && !di.disabled)
            {
                outcome = MustReachSplitStyle(openCallSites, reporter);
            }
            else
            {
                int currRecursionBound = (BoogieVerify.options.extraFlags.Contains("MaxRec") || BoogieVerify.options.NonUniformUnfolding) ? CommandLineOptions.Clo.RecursionBound :
                    1;
                while (true)
                {
                    procsHitRecBound = new HashSet<string>();

                    outcome = Fwd(openCallSites, reporter, true, currRecursionBound);

                    // timeout?
                    if (outcome == Outcome.Inconclusive || outcome == Outcome.OutOfMemory || outcome == Outcome.TimedOut)
                        break;

                    // reached bound?
                    if (outcome == Outcome.ReachedBound && currRecursionBound < CommandLineOptions.Clo.RecursionBound)
                    {
                        if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                            Console.WriteLine("SI: Exhausted recursion bound of {0}", currRecursionBound);
                        currRecursionBound++;
                        continue;
                    }

                    //Console.WriteLine("Concluding verdict at rec bound {0}", currRecursionBound);

                    // outcome is either ReachedBound with currRecBound == Max or
                    // Errors or Correct
                    break;
                }
            }

            Pop();

            if (BoogieVerify.options.extraFlags.Contains("DiCheckSanity"))
                di.CheckSanity();

            if (!di.disabled)
                Console.WriteLine("Time spent inside DI: {0} sec", di.timeTaken.TotalSeconds.ToString("F2"));

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0 ||
                BoogieVerify.options.extraFlags.Contains("DumpDag"))
                di.Dump("ct" + (dumpCnt++) + ".dot");

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1)
                stats.print();

            #region Stash call tree
            if (cba.Util.BoogieVerify.options.CallTree != null)
            {
                CallTree = new HashSet<string>();
                var callsites = new HashSet<StratifiedCallSite>();
                callsites.UnionWith(parent.Keys);
                callsites.UnionWith(parent.Values);
                callsites.ExceptWith(openCallSites);
                callsites.Iter(scs => CallTree.Add(GetPersistentID(scs)));

                prevMain = impl.Name;
                prevDag = di.GetDag();
            }
            #endregion

            return outcome;
        }

        public Outcome VerifyImplementationHydra(Implementation impl, VerifierCallback callback)
        {
            bool startFirstJob = false;
            bool writeLog = false;
            bool continueVerification = true;
            bool makeTimeGraph = false;
            isProgramSafe = false;
            string replyFromServer;
            string receivedCalltree = null;
            Outcome outcome = Outcome.Correct;
            TimeGraph timeGraph = new TimeGraph();
            double resetTime = 0;
            DateTime resetStart;
            emulateServerStack = new Stack<Tuple<int, int>>();
            Stack<SiState> backtrackingPoints = new Stack<SiState>();
            Stack<Decision> decisions = new Stack<Decision>();
            Stack<List<Tuple<StratifiedVC, Block>>> prevMustAsserted = new Stack<List<Tuple<StratifiedVC, Block>>>();
            DI initialDI = new DI(this, BoogieVerify.options.useFwdBck || !BoogieVerify.options.useDI);
            DagOracle initialDAG = initialDI.currentDag.Copy();
            Dictionary<string, StratifiedCallSite> persistentIDToCallsiteMap = new Dictionary<string, StratifiedCallSite>();
            var PrevAsserted = new Func<HashSet<Tuple<StratifiedVC, Block>>>(() =>
            {
                var ret = new HashSet<Tuple<StratifiedVC, Block>>();
                prevMustAsserted.ToList().Iter(ls =>
                    ls.Iter(tup => ret.Add(tup)));
                return ret;
            });
            if (writeLog)
                Console.WriteLine("Requesting ID");
            replyFromServer = sendRequestToServer("requestID", "What Is My ID");
            clientID = replyFromServer;
            if (writeLog)
                Console.WriteLine("Client ID is : " + clientID);
            if (writeLog)
                Console.WriteLine("Start First Job?");
            replyFromServer = sendRequestToServer("startFirstJob", "Start Job 0?");
            if (writeLog)
                Console.WriteLine("Reply : " + replyFromServer);
            if (replyFromServer.Equals("YES"))
                startFirstJob = true;
            /*else
            {
                startFirstJob = false;
                Console.WriteLine("Request Calltree");
                replyFromServer = sendRequestToServer("Calltree", clientID);
                receivedCalltree = replyFromServer;
            }*/

            var applyDecisionToDI = new Action<DecisionType, StratifiedVC>((d, n) =>
            {
                if (d == DecisionType.BLOCK)
                {
                    di.DeleteNode(n);
                }
                if (d == DecisionType.MUST_REACH)
                {
                    var disj = di.DisjointNodes(n);
                    disj.Iter(m => di.DeleteNode(m));
                }
            });

            while (continueVerification)
            {                
                startTime = DateTime.UtcNow;
                //Outcome outcome = Outcome.Correct;
                //sendRequestToServer("outcome", "NOK");
                //sendRequestToServer("requestCalltree", clientID.ToString());
                //Console.ReadLine();
                //return outcome;
                if (startFirstJob) //If this is first job, continue but toggle flag so that a new calltree is requested in the next iteration            
                {
                    startFirstJob = false;
                    if (makeTimeGraph)
                    {
                        parentNodeInTimegraph = 1;
                        childNodeInTimegraph = parentNodeInTimegraph + 1;
                    }
                }
                else
                {
                    if (writeLog)
                        Console.WriteLine("Request Calltree here from client {0}", clientID);
                    replyFromServer = null;
                    receivedCalltree = null;
                    replyFromServer = sendRequestToServer("requestCalltree", clientID);
                    if (writeLog)
                        Console.WriteLine("received reply : " + replyFromServer + " : END");
                    if (writeLog)
                        Console.WriteLine("after reply");
                    if (replyFromServer.Equals("UNAVAILABLE"))
                    {
                        if (writeLog)
                            Console.WriteLine(replyFromServer);
                        CallTree = null;
                        continue;
                    }
                    if (replyFromServer.Equals("SendResetTime"))
                    {
                        //double timeSpentInProverCalls = (double)stats.time / Stopwatch.Frequency;
                        sendRequestToServer("ResetTime", string.Format("{0},{1},{2},{3},{4},{5},{6},{7}", clientID, 
                            communicationTime, resetTime, stats.numInlined, stats.calls, proverTime, inliningTime, splittingTime));
                    }
                    /*if (replyFromServer.Equals("DONE") || replyFromServer.Equals("kill"))
                    {
                        CallTree = null;
                        string sendTimeGraph = "";
                        //Console.Write("SplitSearch: ");
                        sendTimeGraph = sendTimeGraph + "SplitSearch: \n";
                        double singleCoreTime = 0;
                        double sixteenCoreTime = 0;
                        for (int i = 1; i <= 100; i++)
                        {
                            var sum = 0.0;
                            for (int j = 0; j < 5; j++) sum += timeGraph.ComputeTimes(i);
                            sum = sum / 5;
                            if (i == 1)
                                singleCoreTime = sum;
                            if (i == 16)
                                sixteenCoreTime = sum;
                            //Console.Write("{0}\t", sum.ToString("F2"));
                            sendTimeGraph = sendTimeGraph + string.Format("{0}\t", sum.ToString("F2"));
                        }
                        //Console.WriteLine(" :end");
                        sendTimeGraph = sendTimeGraph + " :end";
                        Console.WriteLine(sendTimeGraph);
                        //Console.ReadLine();
                        sendRequestToServer("TimeGraph", sendTimeGraph);
                        sendRequestToServer("requestCalltree", clientID.ToString());                        //Since it has received "DONE", on the next calltree request Listener will kill it
                        Console.ReadLine();
                        return outcome;
                        //break;
                        //timeGraph.ToDot();
                        //Console.WriteLine("splitInfo: " + UCsplit + "," + timeGraph.numPartitions + " :infoEnd");
                    }*/
                    //else
                    {
                        receivedCalltree = replyFromServer;
                        if (writeLog)
                            Console.WriteLine("Received Calltree:");
                        if (writeLog)
                            Console.WriteLine(receivedCalltree);
                    }
                }
                resetStart = DateTime.Now;
                attachedVC.Clear();
                attachedVCInv.Clear();
                parent.Clear();
                previousSplitSites.Clear();
                prevMustAsserted.Clear();
                backtrackingPoints.Clear();
                decisions.Clear();
                persistentIDToCallsiteMap.Clear();
                isProgramSafe = false;
                //prover.Reset(prover.VCExprGen);
                //prover.FullReset(prover.VCExprGen);
                while (stats.stacksize > 1)
                    Pop();
                procsHitRecBound = new HashSet<string>();

                // Find all procedures that are "forced inline"
                forceInlineProcs.UnionWith(program.TopLevelDeclarations.OfType<Implementation>()
                    .Where(p => BoogieUtil.checkAttrExists(ForceInlineAttr, p.Attributes) || BoogieUtil.checkAttrExists(ForceInlineAttr, p.Proc.Attributes))
                    .Select(p => p.Name));

                // assert true to flush all one-time axioms, decls, etc
                //prover.Assert(VCExpressionGenerator.True, true);

                /* the forward/backward approach can only be applied for programs with asserts in calls
                * and single-threaded (multi-threaded programs contain a final assert in the main).
                * Otherwise, use forward approach */
                if (cba.Util.BoogieVerify.options.useFwdBck && assertMethods.Count > 0)
                {
                    return FwdBckVerify(impl, callback);
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "duality")
                {
                    return DepthFirstStyle(impl, callback);
                }

                MacroSI.PRINT_DEBUG("Starting forward approach...");

                //di = new DI(this, BoogieVerify.options.useFwdBck || !BoogieVerify.options.useDI);
                di = initialDI.Copy();
                
                Push();

                StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[impl.Name], implementations);
                mainVC = svc;
                di.RegisterMain(svc);
                HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
                prover.Assert(svc.vcexpr, true);

                
                var reporter = new StratifiedInliningErrorReporter(callback, this, svc);


                #region Eager inlining
                // Eager inlining 
                for (int i = 1; i < cba.Util.BoogieVerify.options.StratifiedInlining && openCallSites.Count > 0; i++)
                {
                    var nextOpenCallSites = new HashSet<StratifiedCallSite>();
                    foreach (StratifiedCallSite scs in openCallSites)
                    {
                        if (HasExceededRecursionDepth(scs, CommandLineOptions.Clo.RecursionBound)) continue;

                        var ss = Expand(scs);
                        if (ss != null) nextOpenCallSites.UnionWith(ss.CallSites);
                    }
                    openCallSites = nextOpenCallSites;
                }
                #endregion

                #region Repopulate Call Tree
                if (cba.Util.BoogieVerify.options.CallTree != null && di.disabled)
                {
                    while (true)
                    {
                        var toAdd = new HashSet<StratifiedCallSite>();
                        var toRemove = new HashSet<StratifiedCallSite>();
                        foreach (StratifiedCallSite scs in openCallSites)
                        {
                            if (!cba.Util.BoogieVerify.options.CallTree.Contains(GetPersistentID(scs))) continue;
                            toRemove.Add(scs);
                            var ss = Expand(scs);
                            if (ss != null) toAdd.UnionWith(ss.CallSites);
                            MacroSI.PRINT_DETAIL(string.Format("Eagerly inlining: {0}", scs.callSite.calleeName), 2);
                        }
                        openCallSites.ExceptWith(toRemove);
                        openCallSites.UnionWith(toAdd);
                        if (toRemove.Count == 0) break;
                    }
                }

                // Repopulate the dag
                if (!di.disabled && prevDag != null && prevMain != null && prevMain == impl.Name)
                {
                    var vcNodeMap = new BijectiveDictionary<StratifiedVC, DagOracle.DagNode>();
                    vcNodeMap.Add(svc, prevDag.GetRoot());

                    var stack = new Queue<DagOracle.DagNode>();
                    var expanded = new HashSet<DagOracle.DagNode>();

                    stack.Enqueue(prevDag.GetRoot());
                    expanded.Add(prevDag.GetRoot());

                    while (stack.Any())
                    {
                        var n1 = stack.Dequeue();
                        Debug.Assert(expanded.Contains(n1));

                        foreach (var e in prevDag.Children[n1])
                        {
                            var n2 = e.Target;

                            // Find call site
                            var vc1 = vcNodeMap[n1];
                            var cs =
                                vc1.CallSites.FirstOrDefault(s =>
                                    GetSiCallId(s) == e.CallSite && s.callSite.calleeName == n2.ImplName);
                            Debug.Assert(cs != null);
                            openCallSites.Remove(cs);

                            if (expanded.Contains(n2))
                            {
                                // Merge
                                var vc2 = vcNodeMap[n2];
                                Merge(cs, vc2);
                            }
                            else
                            {
                                // Expand
                                var vc2 = Expand(cs, null, true, true);
                                openCallSites.UnionWith(vc2.CallSites);
                                vcNodeMap.Add(vc2, n2);
                                expanded.Add(n2);
                                stack.Enqueue(n2);
                            }

                        }

                    }
                }

                #endregion

                // Inline receivedCalltree and push split decisions
                if (receivedCalltree != null)
                {
                    //Console.WriteLine(receivedCalltree);
                    calltreeToSend = receivedCalltree;
                    string callsiteToInline = "";
                    int mode = 0;
                    List<string> inlinedCallsites = new List<string>();
                    for (int i = 0; i < receivedCalltree.Length; i++)
                    {
                        //Console.WriteLine(replyFromServer[i]);
                        if (receivedCalltree[i] == ',')
                        {
                            if (writeLog)
                                Console.WriteLine(callsiteToInline);
                            if (callsiteToInline.Equals("BLOCK"))
                                mode = 1;
                            else if (callsiteToInline.Equals("MUSTREACH"))
                                mode = -1;
                            else
                            {
                                if (mode == 0) // inline callsite
                                {
                                    if (writeLog)
                                        Console.WriteLine("inlining " + callsiteToInline);
                                    StratifiedCallSite scs = null;
                                    foreach (StratifiedCallSite cs in openCallSites)
                                    {
                                        if (GetPersistentID(cs).Equals(callsiteToInline))
                                        {
                                            scs = cs;
                                            break;
                                        }
                                    }
                                    if (scs == null)
                                    {
                                        if (writeLog)
                                        {
                                            Console.WriteLine("did not find " + callsiteToInline);
                                            Console.ReadLine();
                                            Console.WriteLine("did not find ");
                                        }
                                    }
                                    if (!inlinedCallsites.Contains(GetPersistentID(scs)))
                                        inlinedCallsites.Add(GetPersistentID(scs));
                                    else
                                        Console.WriteLine("ALREADY INLINED : " + GetPersistentID(scs));
                                    if (!persistentIDToCallsiteMap.ContainsKey(callsiteToInline))
                                        persistentIDToCallsiteMap.Add(callsiteToInline, scs);
                                    else
                                    {
                                        Console.WriteLine("ALREADY INLINED 2 : " + callsiteToInline);
                                        //Console.ReadLine();
                                    }
                                    openCallSites.Remove(scs);
                                    var vc = Expand(scs, "label_" + scs.callSiteExpr.ToString(), true, true);
                                    if (vc != null)
                                    {
                                        openCallSites.UnionWith(vc.CallSites);
                                        Debug.Assert(!cba.Util.BoogieVerify.options.useFwdBck);
                                    }
                                }
                                else if (mode == 1) //BLOCK callsite
                                {
                                    if (writeLog)
                                        Console.WriteLine("BLOCK " + callsiteToInline);
                                    StratifiedCallSite cs = persistentIDToCallsiteMap[callsiteToInline];
                                    Push();
                                    previousSplitSites.Add(callsiteToInline);
                                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));
                                    prevMustAsserted.Push(new List<Tuple<StratifiedVC, Block>>());
                                    decisions.Push(new Decision(DecisionType.BLOCK, 1, cs));
                                    //applyDecisionToDI(DecisionType.BLOCK, attachedVC[cs]);
                                    prover.Assert(cs.callSiteExpr, false, name: "block_" + GetPersistentID(cs));                                    
                                    mode = 0;                                    
                                }
                                else //MUSTREACH callsite
                                {
                                    if (writeLog)
                                        Console.WriteLine("MUSTREACH " + callsiteToInline);
                                    StratifiedCallSite cs = persistentIDToCallsiteMap[callsiteToInline];
                                    Push();
                                    previousSplitSites.Add(callsiteToInline);
                                    backtrackingPoints.Push(SiState.SaveState(this, openCallSites, previousSplitSites));                                    
                                    decisions.Push(new Decision(DecisionType.MUST_REACH, 1, cs));
                                    //try
                                    {
                                        //applyDecisionToDI(DecisionType.MUST_REACH, attachedVC[cs]);
                                    }
                                    //catch (KeyNotFoundException e)
                                    //
                                    //    Console.WriteLine(e.Message);
                                    //    Console.ReadLine();
                                    //}
                                    prevMustAsserted.Push(AssertMustReach(attachedVC[cs], PrevAsserted()));
                                    //AssertMustReach(attachedVC[cs], new HashSet<Tuple<StratifiedVC, Block>>());
                                    mode = 0;
                                    
                                }
                            }
                            callsiteToInline = "";
                        }
                        else
                            callsiteToInline = callsiteToInline + receivedCalltree[i];
                    }
                    if (makeTimeGraph)
                    {
                        timeGraph.startTime = DateTime.Now;
                        Tuple<int, int> timeGraphCurrentState = emulateServerStack.Pop();
                        parentNodeInTimegraph = timeGraphCurrentState.Item1;
                        childNodeInTimegraph = timeGraphCurrentState.Item2;
                    }
                }
                resetTime = resetTime + (DateTime.Now - resetStart).TotalSeconds;
                // Stratified Search
                if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "nounder")
                {
                    outcome = FwdNoUnder(openCallSites, reporter);
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "mustreach")
                {
                    outcome = MustReachStyle(openCallSites, reporter);
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "split" && !di.disabled)
                {
                    outcome = MustReachSplitStyle(openCallSites, reporter);
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "ucsplit" && !di.disabled)
                {
                    outcome = UnSatCoreSplitStyle(openCallSites, reporter);
                }
                /*else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "ucsplitparallel" && !di.disabled && cba.Util.HydraConfig.startHydra)
                {
                    //Console.WriteLine("running Hydra");
                    outcome = UnSatCoreSplitStyleParallel(openCallSites, reporter, timeGraph, prevMustAsserted,
                        backtrackingPoints, decisions);
                    //Console.WriteLine("Hydra Outcome: " + outcome.ToString());
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "ucsplitparallel2" && !di.disabled && cba.Util.HydraConfig.startHydra)
                {
                    outcome = UnSatCoreSplitStyleParallel(openCallSites, reporter, timeGraph, prevMustAsserted,
                        backtrackingPoints, decisions);
                }
                else if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "ucsplitparallel3" && !di.disabled && cba.Util.HydraConfig.startHydra)
                {
                    outcome = UnSatCoreSplitStyleParallel(openCallSites, reporter, timeGraph, prevMustAsserted,
                        backtrackingPoints, decisions);
                }*/
                else if((cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower().StartsWith("ucsplitparallel") || cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower().StartsWith("ucsplitparallel5")) && !di.disabled && cba.Util.HydraConfig.startHydra)
                {
                    outcome = UnSatCoreSplitStyleParallel(openCallSites, reporter, timeGraph, prevMustAsserted,
                        backtrackingPoints, decisions);
                }
                else
                {                    
                    int currRecursionBound = (BoogieVerify.options.extraFlags.Contains("MaxRec") || BoogieVerify.options.NonUniformUnfolding) ? CommandLineOptions.Clo.RecursionBound :
                        1;
                    while (true)
                    {
                        procsHitRecBound = new HashSet<string>();

                        outcome = Fwd(openCallSites, reporter, true, currRecursionBound);

                        // timeout?
                        if (outcome == Outcome.Inconclusive || outcome == Outcome.OutOfMemory || outcome == Outcome.TimedOut)
                            break;

                        // reached bound?
                        if (outcome == Outcome.ReachedBound && currRecursionBound < CommandLineOptions.Clo.RecursionBound)
                        {
                            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                                Console.WriteLine("SI: Exhausted recursion bound of {0}", currRecursionBound);
                            currRecursionBound++;
                            continue;
                        }

                        //Console.WriteLine("Concluding verdict at rec bound {0}", currRecursionBound);

                        // outcome is either ReachedBound with currRecBound == Max or
                        // Errors or Correct
                        break;
                    }
                }

                Pop();

                if (BoogieVerify.options.extraFlags.Contains("DiCheckSanity"))
                    di.CheckSanity();

                if (!di.disabled)
                    //Console.WriteLine("Time spent inside DI: {0} sec", di.timeTaken.TotalSeconds.ToString("F2"));
                
                if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0 ||
                    BoogieVerify.options.extraFlags.Contains("DumpDag"))
                    di.Dump("ct" + (dumpCnt++) + ".dot");

                if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1)
                    stats.print();

                #region Stash call tree
                if (cba.Util.BoogieVerify.options.CallTree != null)
                {
                    CallTree = new HashSet<string>();
                    var callsites = new HashSet<StratifiedCallSite>();
                    callsites.UnionWith(parent.Keys);
                    callsites.UnionWith(parent.Values);
                    callsites.ExceptWith(openCallSites);
                    callsites.Iter(scs => CallTree.Add(GetPersistentID(scs)));

                    prevMain = impl.Name;
                    prevDag = di.GetDag();
                }
                #endregion
                if (writeLog)
                Console.WriteLine("HERE1");
                if (isProgramSafe && outcome == Outcome.Correct)
                {
                    replyFromServer = sendRequestToServer("outcome", "SAFE");
                    return outcome;
                }
                else if (outcome == Outcome.Correct)
                    replyFromServer = sendRequestToServer("outcome", "OK");
                else if (outcome == Outcome.Errors)
                {
                    cba.Util.HydraConfig.startHydra = false;                    
                    replyFromServer = sendRequestToServer("outcome", "NOK");
                    return outcome;
                }
                else
                    replyFromServer = sendRequestToServer("outcome", "REACHEDBOUND");
                if (writeLog)
                    Console.WriteLine("HERE2");
                if (writeLog)
                    Console.WriteLine(replyFromServer);
                if (writeLog)
                    Console.WriteLine("HERE4");
                if (replyFromServer.Equals("kill") || replyFromServer.Equals("DONE"))
                    continueVerification = false;
            }
            if (makeTimeGraph)
            {
                string sendTimeGraph = "";
                //Console.Write("SplitSearch: ");
                sendTimeGraph = sendTimeGraph + "SplitSearch: \n";
                double singleCoreTime = 0;
                double sixteenCoreTime = 0;
                for (int i = 1; i <= 100; i++)
                {
                    var sum = 0.0;
                    for (int j = 0; j < 5; j++) sum += timeGraph.ComputeTimes(i);
                    sum = sum / 5;
                    if (i == 1)
                        singleCoreTime = sum;
                    if (i == 16)
                        sixteenCoreTime = sum;
                    //Console.Write("{0}\t", sum.ToString("F2"));
                    sendTimeGraph = sendTimeGraph + string.Format("{0}\t", sum.ToString("F2"));
                }
                //Console.WriteLine(" :end");
                sendTimeGraph = sendTimeGraph + " :end";
                if (writeLog)
                    Console.WriteLine(sendTimeGraph);
                //Console.ReadLine();
                sendRequestToServer("TimeGraph", sendTimeGraph);
            }
            //Console.ReadLine();
            return outcome;
        }

        static int dumpCnt = 0;

        // Inline
        private StratifiedVC Expand(StratifiedCallSite scs)
        {
            return Expand(scs, null, true, false);
        }

        private StratifiedVC Expand(StratifiedCallSite scs, string name, bool DoSubst, bool dontMerge)
        {
            inliningStartTime = DateTime.Now;
            MacroSI.PRINT_DEBUG("    ~ extend callsite " + scs.callSite.calleeName);
            Debug.Assert(DoSubst || di.disabled);
            var candidate = dontMerge ? null : di.FindMergeCandidate(scs);
            StratifiedVC ret = null;

            if (candidate == null)
            {
                stats.numInlined++;
                var svc = new StratifiedVC(implName2StratifiedInliningInfo[scs.callSite.calleeName], implementations);

                foreach (var newCallSite in svc.CallSites)
                {
                    parent[newCallSite] = scs;
                }
                VCExpr toassert;

                if (di.disabled)
                {
                    if (DoSubst)
                        toassert = prover.VCExprGen.Implies(scs.callSiteExpr, scs.Attach(svc));
                    else
                        toassert = prover.VCExprGen.Implies(scs.callSiteExpr, prover.VCExprGen.And(
                        svc.vcexpr, AttachByEquality(scs, svc)));
                }
                else
                {
                    var cb = GetControlBoolean(svc);
                    toassert = AttachByEquality(scs, svc);
                    toassert = prover.VCExprGen.Implies(scs.callSiteExpr, prover.VCExprGen.And(cb, toassert));
                    toassert = prover.VCExprGen.And(prover.VCExprGen.Implies(cb, svc.vcexpr), toassert);
                }

                prover.LogComment("Inlining " + scs.callSite.calleeName + " from " + (parent.ContainsKey(scs) ? attachedVC[parent[scs]].info.impl.Name : "main"));

                di.Expanded(scs, svc);
                stats.vcSize += SizeComputingVisitor.ComputeSize(toassert);
                //Console.WriteLine("VC of {0} is {1}", scs.callSite.calleeName, toassert);

                if (name != null)
                    prover.AssertNamed(toassert, true, name);
                else
                    prover.Assert(toassert, true);

                attachedVC[scs] = svc;
                attachedVCInv[svc] = scs;
                //TestMustReach(svc);
                ret = svc;
            }
            else
            {
                Merge(scs, candidate);
                ret = null;
            }
            inliningTime = inliningTime + (DateTime.Now - inliningStartTime).TotalSeconds;
            return ret;
        }

        private void Merge(StratifiedCallSite scs, StratifiedVC vc)
        {
            MacroSI.PRINT_DEBUG("    ~ attaching to existing callsite ");
            prover.LogComment("Attaching for " + scs.callSite.calleeName);
            var toassert = AttachByEquality(scs, vc);
            var cb = GetControlBoolean(vc);
            toassert = prover.VCExprGen.Implies(scs.callSiteExpr, prover.VCExprGen.And(cb, toassert));

            di.Merged(scs, vc);
            stats.vcSize += SizeComputingVisitor.ComputeSize(toassert);

            prover.Assert(toassert, true);
            attachedVC[scs] = vc;
        }

        // Return the control Boolean for the VC
        private VCExpr GetControlBoolean(StratifiedVC vc)
        {
            if (controlBoolean.ContainsKey(vc))
                return controlBoolean[vc];
            var lit = prover.VCExprGen.Variable("extraControlBoolSIDI" + controlBoolean.Count,
                Microsoft.Boogie.Type.Bool);
            controlBoolean.Add(vc, lit);
            return lit;
        }

        // Return unique call ID of a call site
        private int GetSiCallId(StratifiedCallSite scs)
        {
            return QKeyValue.FindIntAttribute(scs.callSite.Attributes, "si_unique_call", -1);
        }

        // Get persistent ID of a callsite
        private string GetPersistentID(StratifiedCallSite scs)
        {
            if (!parent.ContainsKey(scs))
                return string.Format("{0}_131_{1}", scs.callSite.calleeName, GetSiCallId(scs));

            var ret = GetPersistentID(parent[scs]);
            return string.Format("{0}_262_{1}_393_{2}", ret, scs.callSite.calleeName, GetSiCallId(scs));
        }

        // Get persistent ID of a VC
        private string GetPersistentID(StratifiedVC vc)
        {
            var ret = "";
            if (attachedVCInv.ContainsKey(vc))
            {
                var scs = attachedVCInv[vc];
                ret = GetPersistentID(scs);
            }
            return string.Format("{0}_262_{1}", ret, vc.info.impl.Name);
        }

        // 'Attach' inlined from Boogie/StratifiedVC.cs (and made static)
        // TODO: add it to Boogie/StratifiedVC.cs
        // ---------------------------------------- 
        // Original Attach works with interface variables renaming. We don't want this, as we backtrack sometimes.
        // We add an equality clause instead.
        public static VCExpr AttachByEquality(StratifiedCallSite callee, StratifiedVC svcCallee)
        {
            System.Diagnostics.Contracts.Contract.Assert(callee.callSite.interfaceExprs.Count == svcCallee.interfaceExprVars.Count);
            StratifiedInliningInfo info = svcCallee.info;
            ProverInterface prover = info.vcgen.prover;
            VCExpressionGenerator gen = prover.VCExprGen;

            VCExpr conjunction = VCExpressionGenerator.True;

            for (int i = 0; i < svcCallee.interfaceExprVars.Count; i++)
            {
                /* interface variables */
                VCExpr equality = gen.Eq(svcCallee.interfaceExprVars[i], callee.interfaceExprs[i]);
                conjunction = gen.And(equality, conjunction);
            }

            return conjunction;
        }

        private Outcome CheckVC(ProverInterface.ErrorHandler reporter)
        {
            stats.calls++;
            var stopwatch = Stopwatch.StartNew();
            proverStartTime = DateTime.Now;
            prover.Check();
            proverTime += (DateTime.Now - proverStartTime).TotalSeconds;
            stats.time += stopwatch.ElapsedTicks;
            ProverInterface.Outcome outcome = prover.CheckOutcomeCore(reporter);
            return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
        }

        private Outcome CheckVC(List<VCExpr> softAssumptions, ProverInterface.ErrorHandler reporter)
        {
            List<int> unsatCore;

            stats.calls++;
            var stopwatch = Stopwatch.StartNew();
            proverStartTime = DateTime.Now;
            ProverInterface.Outcome outcome = 
                prover.CheckAssumptions(new List<VCExpr>(), softAssumptions, out unsatCore, reporter);
            proverTime += (DateTime.Now - proverStartTime).TotalSeconds;
            stats.time += stopwatch.ElapsedTicks;
            return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
        }

        public override Outcome FindLeastToVerify(Implementation impl, ref HashSet<string> allBoolVars)
        {
            var name2VC = new Dictionary<string, StratifiedVC>();
            var getSVC = new Func<string, StratifiedVC>(name =>
                {
                    if (name2VC.ContainsKey(name))
                        return name2VC[name];
                    var tt = new StratifiedVC(implName2StratifiedInliningInfo[name], implementations);
                    name2VC.Add(name, tt);
                    return tt;
                });

            Push();

            StratifiedVC svc = getSVC(impl.Name);
            HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
            prover.Assert(svc.vcexpr, true);

            HashSet<StratifiedCallSite> nextOpenCallSites;
            while (openCallSites.Count != 0)
            {
                nextOpenCallSites = new HashSet<StratifiedCallSite>();
                foreach (StratifiedCallSite scs in openCallSites)
                {
                    svc = getSVC(scs.callSite.calleeName);
                    foreach (var newCallSite in svc.CallSites)
                    {
                        nextOpenCallSites.Add(newCallSite);
                    }
                    var toassert = scs.Attach(svc);
                    toassert = prover.VCExprGen.Implies(scs.callSiteExpr, toassert);
                    prover.Assert(toassert, true);
                }
                openCallSites = nextOpenCallSites;
            }

            // Find all the boolean constants
            var allConsts = new HashSet<VCExprVar>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                var constant = decl as Constant;
                if (constant == null) continue;
                if (!allBoolVars.Contains(constant.Name)) continue;
                var v = prover.Context.BoogieExprTranslator.LookupVariable(constant);
                allConsts.Add(v);
            }

            // Now, lets start the algo
            var min = refinementLoop(new EmptyErrorReporter(), new HashSet<VCExprVar>(), allConsts, allConsts);

            var ret = new HashSet<string>();
            foreach (var v in min)
            {
                ret.Add(v.Name);
            }
            allBoolVars = ret;

            Pop();
            
            return Outcome.Correct;
        }

        private HashSet<VCExprVar> refinementLoop(ProverInterface.ErrorHandler reporter, HashSet<VCExprVar> trackedVars, HashSet<VCExprVar> trackedVarsUpperBound, HashSet<VCExprVar> allVars)
        {
            Debug.Assert(trackedVars.IsSubsetOf(trackedVarsUpperBound));

            // If we already know the fate of all vars, then we're done.
            if (trackedVars.Count == trackedVarsUpperBound.Count)
                return new HashSet<VCExprVar>(trackedVars);

            // See if we already have enough variables tracked
            var success = refinementLoopCheckPath(reporter, trackedVars, allVars);
            if (success)
            {
                // We have enough
                return new HashSet<VCExprVar>(trackedVars);
            }

            // If all that remains is 1 variable, then we know that we must track it
            if (trackedVars.Count + 1 == trackedVarsUpperBound.Count)
                return new HashSet<VCExprVar>(trackedVarsUpperBound);

            // Partition the remaining set of variables
            HashSet<VCExprVar> part1, part2;
            var temp = new HashSet<VCExprVar>(trackedVarsUpperBound);
            temp.ExceptWith(trackedVars);
            Partition<VCExprVar>(temp, out part1, out part2);

            // First half
            var fh = new HashSet<VCExprVar>(trackedVars); fh.UnionWith(part2);
            var s1 = refinementLoop(reporter, fh, trackedVarsUpperBound, allVars);

            var a = new HashSet<VCExprVar>(part1); a.IntersectWith(s1);
            var b = new HashSet<VCExprVar>(part1); b.ExceptWith(s1);
            var c = new HashSet<VCExprVar>(trackedVarsUpperBound); c.ExceptWith(b);
            a.UnionWith(trackedVars);

            // Second half
            return refinementLoop(reporter, a, c, allVars);
        }

        private bool refinementLoopCheckPath(ProverInterface.ErrorHandler reporter, HashSet<VCExprVar> varsToSet, HashSet<VCExprVar> allVars)
        {
            var assumptions = new List<VCExpr>();
            var query = new HashSet<string>();
            varsToSet.Iter(v => query.Add(v.Name));

            prover.LogComment("FindLeast: Query Begin");

            foreach (var c in allVars)
            {
                if (varsToSet.Contains(c))
                {
                    assumptions.Add(c);
                }
                else
                {
                    assumptions.Add(prover.VCExprGen.Not(c));
                }
            }

            var o = CheckAssumptions(reporter, assumptions);
            if(o != Outcome.Correct && o != Outcome.Errors)
                throw new cba.Util.InternalError(string.Format("z3 ran out of resources in RefinementLoop: {0}", o));
            prover.LogComment("FindLeast: Query End");

            return (o == Outcome.Correct);
        }

        private Outcome CheckAssumptions(ProverInterface.ErrorHandler reporter, List<VCExpr> assumptions)
        {
            if (assumptions.Count == 0)
            {
                return CheckVC(reporter);
            }

            Push();
            foreach (var a in assumptions)
            {
                prover.Assert(a, true);
            }
            Outcome ret = CheckVC(reporter);
            Pop();
            return ret;
        }

        private static void Partition<T>(HashSet<T> values, out HashSet<T> part1, out HashSet<T> part2)
        {
            part1 = new HashSet<T>();
            part2 = new HashSet<T>();
            var size = values.Count;
            var crossed = false;
            var curr = 0;
            foreach (var s in values)
            {
                if (crossed) part2.Add(s);
                else part1.Add(s);
                curr++;
                if (!crossed && curr >= size / 2) crossed = true;
            }
        }
    }

    class BijectiveDictionary<T1, T2> : IEnumerable<KeyValuePair<T1, T2>>, IEnumerable
    {
        Dictionary<T1, T2> map1;
        Dictionary<T2, T1> map2;

        public BijectiveDictionary()
        {
            map1 = new Dictionary<T1, T2>();
            map2 = new Dictionary<T2, T1>();
        }

        public void Add(T1 elem1, T2 elem2)
        {
            map1.Add(elem1, elem2);
            map2.Add(elem2, elem1);
        }

        public T2 this[T1 key]
        {
            get
            {
                return map1[key];
            }
        }

        public T1 this[T2 key]
        {
            get
            {
                return map2[key];
            }
        }

        public T2 GetRange(T1 key)
        {
            return map1[key];
        }

        public T1 GetDomain(T2 key)
        {
            return map2[key];
        }

        public IEnumerable<T1> GetDomain()
        {
            return map1.Keys;
        }

        public IEnumerable<T2> GetRange()
        {
            return map2.Keys;
        }

        public bool ContainsDomain(T1 key)
        {
            return map1.ContainsKey(key);
        }

        public bool ContainsRange(T2 key)
        {
            return map2.ContainsKey(key);
        }

        public IEnumerator GetEnumerator()
        {
            return map1.GetEnumerator();
        }

        IEnumerator<KeyValuePair<T1, T2>> IEnumerable<KeyValuePair<T1, T2>>.GetEnumerator()
        {
            return map1.GetEnumerator();
        }
    }

    public enum MERGING_STRATEGY { NONE, FIRST, RANDOM_PICK, RANDOM, MAXC, OPT };

    public class DI
    {    
        MERGING_STRATEGY strategy;

        public bool disabled { get; private set; }
        public TimeSpan timeTaken { get; private set; }

        public StratifiedInlining SI;

        public Dictionary<StratifiedCallSite, StratifiedVC> containingVC;
        public Dictionary<StratifiedVC, int[]> vcToRecVector;

        public ProgramDisjointness Disj;
        IndexComputer IndexC;

        // For Merging (computed once)
        public static DagOracle optimalDag = null;

        public DagOracle currentDag;
        BijectiveDictionary<StratifiedVC, DagOracle.DagNode> vcNodeMap;
        BijectiveDictionary<DagOracle.DagNode, DagOracle.DagNode> currentOptNodeMapping;

        Random random;

        public DI()
        { }

        public DI(StratifiedInlining SI, bool disabled)
        {
            this.SI = SI;
            timeTaken = TimeSpan.Zero;
            var st = DateTime.Now;

            containingVC = new Dictionary<StratifiedCallSite, StratifiedVC>();
            vcToRecVector = new Dictionary<StratifiedVC, int[]>();
            this.disabled = disabled;
            random = new Random((int)DateTime.Now.Ticks);

            IndexC = null;
            Disj = null;
            currentDag = new DagOracle(SI.program, null);
            vcNodeMap = new BijectiveDictionary<StratifiedVC, DagOracle.DagNode>();
            currentOptNodeMapping = new BijectiveDictionary<DagOracle.DagNode, DagOracle.DagNode>();

            if (!disabled)
            {
                IndexC = new IndexComputer(SI.program);
                var impls = new Dictionary<string, Implementation>();
                SI.implName2StratifiedInliningInfo.Iter(tup => impls.Add(tup.Key, tup.Value.impl));
                Disj = new ProgramDisjointness(impls);

                currentDag = new DagOracle(SI.program, Disj, SI.extraRecBound);

                strategy = PickStrategy();
                
                if (strategy == MERGING_STRATEGY.OPT && optimalDag == null)
                {
                    optimalDag = new DagOracle(SI.program, Disj, SI.extraRecBound);
                    var tsize = optimalDag.ConstructCallDagOnTheFly(true, strategy);
                    Console.WriteLine("Constructed optimal dag, with {0} nodes (max {1})", optimalDag.ComputeSize(), tsize);
                }

            }
            timeTaken += (DateTime.Now - st);
        }

        public DI Copy()
        {
            var ret = new DI();
            ret.SI = SI;
            ret.disabled = disabled;
            ret.Disj = Disj;
            ret.strategy = strategy;
            ret.timeTaken = TimeSpan.Zero;
            ret.containingVC = new Dictionary<StratifiedCallSite, StratifiedVC>(containingVC);
            ret.vcToRecVector = new Dictionary<StratifiedVC, int[]>(vcToRecVector);
            ret.IndexC = IndexC;
            ret.currentDag = currentDag.Copy();
            
            ret.vcNodeMap = new BijectiveDictionary<StratifiedVC, DagOracle.DagNode>();
            ret.currentOptNodeMapping = new BijectiveDictionary<DagOracle.DagNode, DagOracle.DagNode>();
            foreach (var n in vcNodeMap.GetDomain())
                ret.vcNodeMap.Add(n, vcNodeMap[n]);
            foreach (var n in currentOptNodeMapping.GetDomain())
                ret.currentOptNodeMapping.Add(n, currentOptNodeMapping.GetRange(n));

            ret.random = new Random((int)DateTime.Now.Ticks);

            return ret;
        }

        public static MERGING_STRATEGY PickStrategy()
        {
            var strategy = MERGING_STRATEGY.FIRST;
            if (BoogieVerify.options.extraFlags.Contains("DiNone"))
            {
                Console.WriteLine("Selecting DAG Inilining strategy: None");
                strategy = MERGING_STRATEGY.NONE;
            }
            if (BoogieVerify.options.extraFlags.Contains("DiRandom"))
            {
                Console.WriteLine("Selecting DAG Inilining strategy: Random");
                strategy = MERGING_STRATEGY.RANDOM;
            }
            if (BoogieVerify.options.extraFlags.Contains("DiRandomPick"))
            {
                Console.WriteLine("Selecting DAG Inilining strategy: RandomPick");
                strategy = MERGING_STRATEGY.RANDOM_PICK;
            }
            if (BoogieVerify.options.extraFlags.Contains("DiMaxc"))
            {
                Console.WriteLine("Selecting DAG Inilining strategy: maxc");
                strategy = MERGING_STRATEGY.MAXC;
            }
            if (BoogieVerify.options.extraFlags.Contains("DiOpt"))
            {
                Console.WriteLine("Selecting DAG Inilining strategy: static opt");
                strategy = MERGING_STRATEGY.OPT;
            }
            return strategy;
        }

        public DagOracle GetDag()
        {
            return currentDag;
        }

        public int ComputeSize()
        {
            return currentDag.ComputeSize();
        }

        public HashSet<StratifiedVC> DisjointNodes(StratifiedVC vc)
        {
            var ret = new HashSet<StratifiedVC>();
            var disj = currentDag.AllDisjointNodes();
            var v = vcNodeMap[vc];
            var disjv = disj[v];
            foreach (var n in disjv)
            {
                try
                {
                    ret.Add(vcNodeMap[n]);
                }
                catch (KeyNotFoundException e)
                {
                    Console.WriteLine(e.Message);
                    Console.WriteLine(n.ToString());
                    Console.ReadLine();
                }
            }
            //disj[vcNodeMap[vc]].Iter(n => ret.Add(vcNodeMap[n]));
            return ret;
        }

        // Return the number of disjoint nodes for each node
        public Dictionary<StratifiedVC, int> ComputeNumDisjoint()
        {
            var ret = new Dictionary<StratifiedVC, int>();
            var disj = currentDag.AllDisjointNodes();
            foreach (var tup in disj)
                ret.Add(vcNodeMap[tup.Key], tup.Value.Count);
            return ret;
        }

        // Return subtree sizes for each node
        public Dictionary<StratifiedVC, HashSet<StratifiedVC>> ComputeSubtrees()
        {
            var ret = new Dictionary<StratifiedVC, HashSet<StratifiedVC>>();
            Dictionary<DagOracle.DagNode, int> nodeToTreeSize;
            Dictionary<DagOracle.DagNode, HashSet<DagOracle.DagNode>> nodeToChildren;
            currentDag.ComputeDagSizes(out nodeToTreeSize, out nodeToChildren);

            nodeToChildren.Iter(tup => ret.Add(vcNodeMap[tup.Key],
                new HashSet<StratifiedVC>(tup.Value.Select(n => vcNodeMap[n]))));

            return ret;
        }

        public void DeleteNode(StratifiedVC vc)
        {
            Debug.Assert(vcNodeMap.ContainsDomain(vc));
            var node = vcNodeMap[vc];
            if(currentDag.Nodes.Contains(node))
                currentDag.DeleteNodeAndDecendants(node);
        }

        public bool VcExists(StratifiedVC vc)
        {
            if (!vcNodeMap.ContainsDomain(vc))
                return false;
            return currentDag.Nodes.Contains(vcNodeMap[vc]);
        }

        public void CheckSanity()
        {
            var st = DateTime.Now;
            if(currentDag.Nodes.Count != 0)
                currentDag.CheckSanity();
            timeTaken += (DateTime.Now - st);
        }

        public void RegisterMain(StratifiedVC vc)
        {
            var st = DateTime.Now;

            RegisterVC(vc);

            if (disabled) return;

            Debug.Assert(currentDag.Nodes.Count == 0);

            var rv = IndexC.GetMainRv();
            var index = IndexC.GetIndex(vc.info.impl.Name, rv);
            vcToRecVector.Add(vc, rv);

            // Add to dag
            var node = new DagOracle.DagNode(index, vc.info.impl.Name, 1);

            vcNodeMap.Add(vc, node);
            currentDag.AddNode(node);

            currentDag.SetRoot(node);
            if (optimalDag != null)
                currentOptNodeMapping.Add(node, optimalDag.GetRoot());

            timeTaken += (DateTime.Now - st);
        }

        void RegisterVC(StratifiedVC vc)
        {
            foreach (var cs in vc.CallSites)
                containingVC[cs] = vc;           
        }

        public void Expanded(StratifiedCallSite cs, StratifiedVC vc)
        {
            var st = DateTime.Now;
            RegisterVC(vc);

            if (disabled) return;
            Debug.Assert(cs.callSite.calleeName == vc.info.impl.Name);

            var n1 = vcNodeMap[containingVC[cs]];

            int[] rv2 = null;
            var id2 = GetTargetId(cs, out rv2);
            vcToRecVector.Add(vc, rv2);

            // create node
            var n2 = new DagOracle.DagNode(id2, vc.info.impl.Name, 1);

            vcNodeMap.Add(vc, n2);
            currentDag.AddNode(n2);

            // Add edge to our dag
            var e = QKeyValue.FindIntAttribute(cs.callSite.Attributes, "si_unique_call", -1);
            currentDag.AddEdge(new DagOracle.DagEdge(n1, n2, e));

            if (optimalDag != null && !currentOptNodeMapping.ContainsDomain(n2))
            {
                var o1 = currentOptNodeMapping.GetRange(n1);
                var o2 = optimalDag.FindSuccessor(o1, e, n2.ImplName);
                if (o2 == null)
                {
                    Console.WriteLine("Unable to find successor of {0} and {1} to {2}", o1.id, e, n2.ImplName);
                    Debug.Assert(false);
                }
                currentOptNodeMapping.Add(n2, o2);
            }

            timeTaken += (DateTime.Now - st);
        }

        public void Merged(StratifiedCallSite cs, StratifiedVC vc)
        {
            var st = DateTime.Now;
            if (disabled) return;

            var n1 = vcNodeMap[containingVC[cs]];
            var n2 = vcNodeMap[vc];
            var e = QKeyValue.FindIntAttribute(cs.callSite.Attributes, "si_unique_call", -1);
            currentDag.AddEdge(new DagOracle.DagEdge(n1, n2, e));

            //currentDag.CheckSanity();

            timeTaken += (DateTime.Now - st);
        }

        string GetTargetId(StratifiedCallSite cs, out int[] rv2)
        {
            var n1 = vcNodeMap[containingVC[cs]];
            var rv1 = vcToRecVector[containingVC[cs]];
            rv2 = IndexC.IncrementIndex(cs.callSite.calleeName, rv1);
            var id2 = IndexC.GetIndex(cs.callSite.calleeName, rv2);

            return id2;
        }

        public StratifiedVC FindMergeCandidate(StratifiedCallSite cs)
        {
            var st = DateTime.Now;
            var ret = FindMergeCandidateInternal(cs);
            timeTaken += (DateTime.Now - st);
            return ret;
        }

        StratifiedVC FindMergeCandidateInternal(StratifiedCallSite cs)
        {
            if (disabled) return null;
            if (strategy == MERGING_STRATEGY.NONE) return null;

            Debug.Assert(!SI.attachedVC.ContainsKey(cs));

            var e = QKeyValue.FindIntAttribute(cs.callSite.Attributes, "si_unique_call", -1);
            int[] rv = null;
            var candidates = currentDag.FindMergeCandidates(vcNodeMap[containingVC[cs]], e, GetTargetId(cs, out rv));

            if (strategy == MERGING_STRATEGY.FIRST)
            {
                var n = candidates.FirstOrDefault();
                if (n == null) return null;
                return vcNodeMap[n];
            }

            var matches = candidates.ToList();
            if (matches.Count == 0) return null;

            if (strategy == MERGING_STRATEGY.MAXC)
            {
                var max = 0.0;
                StratifiedVC maxc = null;
                foreach (var c in matches)
                {
                    var size = currentDag.Descendants(c).Count / (1 + currentDag.Ancestors(c).Count);
                    if (max < size)
                    {
                        max = size;
                        maxc = vcNodeMap[c];
                    }
                }
                return maxc;
            }

            if (strategy == MERGING_STRATEGY.RANDOM)
            {
                var choice = random.Next(0, matches.Count + 2);
                if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                    Console.WriteLine("Making choice {0} of {1} for {2}", choice, matches.Count - 1, cs.callSite.calleeName);
                if (choice >= matches.Count) return null;
                return vcNodeMap[matches[choice]];
            }

            if (strategy == MERGING_STRATEGY.RANDOM_PICK)
            {
                var choice = random.Next(0, matches.Count);
                if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                    Console.WriteLine("Making choice {0} of {1} for {2}", choice, matches.Count - 1, cs.callSite.calleeName);
                return vcNodeMap[matches[choice]];
            }

            Debug.Assert(strategy == MERGING_STRATEGY.OPT);
            Debug.Assert(optimalDag != null);
            // this is where we are
            var n1 = vcNodeMap[containingVC[cs]];
            var call = QKeyValue.FindIntAttribute(cs.callSite.Attributes, "si_unique_call", -1);
            var o1 = currentOptNodeMapping.GetRange(n1);
            var o2 = optimalDag.FindSuccessor(o1, call, cs.callSite.calleeName);
            Debug.Assert(o2 != null);

            // lets see if our current dag has o2
            if (currentOptNodeMapping.ContainsRange(o2))
            {
                var n2 = currentOptNodeMapping.GetDomain(o2);
                Debug.Assert(matches.Contains(n2));
                return vcNodeMap[n2];
            }
            else
            {
                // Lets not merge right now
                return null;
            }

        }

        public void Dump(string filename)
        {
            currentDag.Dump(filename);
            ComputeDagSizes();
        }

        // Return the sizes of shared dags; and more info about the largest shared sub-tree
        private void ComputeDagSizes()
        {
            if(!disabled)
                currentDag.ComputeDagSizes();
        }

    }

    class IndexComputer
    {
        Program program;
        // call graph
        Graph<string> cg;
        // scc graph
        Graph<SCC<string>> sccgraph;
        // proc to reachable procs
        Dictionary<string, HashSet<string>> procToReachableProcs;
        // proc to index
        Dictionary<string, int> procToIndex;
        // index to proc
        string[] indexToProc;
        // recursive procs
        HashSet<string> recursiveProcs;

        public IndexComputer(Program program)
        {
            this.program = program;

            // call graph
            cg = BoogieUtil.GetCallGraph(program);

            // SCCs 
            var sccs = new StronglyConnectedComponents<string>(cg.Nodes,
                s => cg.Predecessors(s), s => cg.Successors(s));
            sccs.Compute();

            var procToScc = new Dictionary<string, SCC<string>>();

            foreach (var scc in sccs)
                foreach (var p in scc)
                    procToScc.Add(p, scc);

            // graph over SCCs
            sccgraph = new Graph<SCC<string>>();
            foreach (var scc in sccs)
                sccgraph.AddSource(scc);
            foreach (var edge in cg.Edges)
            {
                var s1 = procToScc[edge.Item1];
                var s2 = procToScc[edge.Item2];
                if (s1 != s2)
                    sccgraph.AddEdge(s2, s1);
            }

            // top sort SCC dag
            var sortedscc = sccgraph.TopologicalSort();

            var sccToReachableScc = new Dictionary<SCC<string>, HashSet<SCC<string>>>();
            foreach (var scc in sortedscc)
            {
                var r = new HashSet<SCC<string>>();
                r.Add(scc);
                foreach (var s in sccgraph.Predecessors(scc))
                    r.UnionWith(sccToReachableScc[s]);
                sccToReachableScc.Add(scc, r);
            }

            // Get recursive procs reachable from proc
            procToReachableProcs = new Dictionary<string, HashSet<string>>();
            foreach (var p in cg.Nodes)
            {
                procToReachableProcs[p] = new HashSet<string>();
                sccToReachableScc[procToScc[p]].Iter(scc => procToReachableProcs[p].UnionWith(scc));
            }

            recursiveProcs = BoogieUtil.GetCyclicNodes<string>(cg);

            indexToProc = new string[cg.Nodes.Count];
            procToIndex = new Dictionary<string, int>();
            int i = 0;
            cg.Nodes.Iter(p => { indexToProc[i] = p; procToIndex[p] = i; i++; });
        }

        public int[] GetMainRv()
        {
            var rv = new int[indexToProc.Length];
            for (int i = 0; i < rv.Length; i++) rv[i] = 0;
            return rv;
        }

        public int[] IncrementIndex(string proc, int[] recursionVector)
        {
            var ret = new int[recursionVector.Length];
            Array.Copy(recursionVector, ret, ret.Length);
            ret[procToIndex[proc]]++;
            return ret;
        }

        public string GetIndex(string proc, int[] recursionVector)
        {
            Debug.Assert(recursionVector.Length == indexToProc.Length);
            var procs = new HashSet<string>(recursiveProcs);
            procs.IntersectWith(procToReachableProcs[proc]);

            var ret = "";
            for (int i = 0; i < recursionVector.Length; i++)
            {
                if (!procs.Contains(indexToProc[i])) continue;
                ret += recursionVector[i].ToString();
            }
            return proc + "[" + ret + "]";
        }
    }

    public class ProgramDisjointness
    {
        Dictionary<string, Implementation> impls;

        // cache: impl -> pairs of disjoint calls
        Dictionary<string, HashSet<Tuple<int, int>>> exclusiveCache;

        public ProgramDisjointness(Program program)
        {
            var map = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => map.Add(impl.Name, impl));

            exclusiveCache = new Dictionary<string, HashSet<Tuple<int, int>>>();
            this.impls = new Dictionary<string, Implementation>(map);
        }

        public ProgramDisjointness(Dictionary<string, Implementation> impls)
        {
            exclusiveCache = new Dictionary<string, HashSet<Tuple<int, int>>>();
            this.impls = new Dictionary<string, Implementation>(impls);
        }

        public bool IsExclusive(string impl, int n1, int n2)
        {
            return IsExclusive(impls[impl], n1, n2);
        }

        public bool IsExclusive(Implementation impl, int n1, int n2)
        {
            if (n1 < 0 || n2 < 0)
                return false;

            if (exclusiveCache.ContainsKey(impl.Name))
                return !exclusiveCache[impl.Name].Contains(Tuple.Create(n1, n2)) &&
                    !exclusiveCache[impl.Name].Contains(Tuple.Create(n2, n1));

            var blockToCalls = new Dictionary<Block, HashSet<int>>();
            var seen = new HashSet<int>();
            foreach (var b in impl.Blocks)
            {
                blockToCalls.Add(b, new HashSet<int>());
                foreach (var cmd in b.Cmds)
                {
                    // check for both passified program as well as non-passified
                    QKeyValue attr = null;
                    if (cmd is AssumeCmd && (cmd as AssumeCmd).Expr is NAryExpr &&
                        impls.ContainsKey(((cmd as AssumeCmd).Expr as NAryExpr).Fun.FunctionName))
                    {
                        attr = (cmd as AssumeCmd).Attributes;
                    }
                    else if (cmd is CallCmd && impls.ContainsKey((cmd as CallCmd).callee))
                    {
                        attr = (cmd as CallCmd).Attributes;
                    }
                    if (attr == null) continue;
                    var v = QKeyValue.FindIntAttribute(attr, "si_unique_call", -1);
                    if (v < 0) continue;
                    blockToCalls[b].Add(v);

                    // sanity check
                    if (seen.Contains(v))
                    {
                        Console.WriteLine("WARNING: Duplicate si_unique_call annotations in {0}", impl.Name);
                        exclusiveCache.Add(impl.Name, new HashSet<Tuple<int, int>>());
                        return false;
                    }
                    seen.Add(v);
                }
            }

            var graph = Program.GraphFromImpl(impl);
            var canReachMe = new Dictionary<Block, HashSet<Block>>();
            impl.Blocks.Iter(b => canReachMe.Add(b, new HashSet<Block>()));

            foreach (var b in graph.TopologicalSort())
            {
                canReachMe[b].Add(b);
                foreach (var p in graph.Predecessors(b))
                    canReachMe[b].UnionWith(canReachMe[p]);
            }

            var reachable = new HashSet<Tuple<int, int>>();
            foreach (var b in impl.Blocks)
            {
                var from = new HashSet<int>();
                canReachMe[b].Iter(p => from.UnionWith(blockToCalls[p]));
                foreach (var tgt in blockToCalls[b])
                {
                    from.Iter(src => reachable.Add(Tuple.Create(src, tgt)));
                }
            }

            exclusiveCache.Add(impl.Name, reachable);
            return !exclusiveCache[impl.Name].Contains(Tuple.Create(n1, n2)) &&
                !exclusiveCache[impl.Name].Contains(Tuple.Create(n2, n1));
        }

        public void DumpCFG(Implementation impl, string filename)
        {
            var graph = Program.GraphFromImpl(impl);
            var str = new System.IO.StreamWriter(filename);
            str.WriteLine("digraph DAG {");

            graph.Nodes
                .Iter(n => str.WriteLine("{0} [ label = \"{1}\" color=black shape=box];", n.UniqueId, n.Label));

            foreach (var edge in graph.Edges)
                str.WriteLine("{0} -> {1} [ label = \"{2}\"];", edge.Item1.UniqueId, edge.Item2.UniqueId, "");

            str.WriteLine("}");
            str.Close();
        }

    }

    public class DagOracle
    {
        public class DagNode
        {
            public string ImplName;
            public string id;
            public int Size;
            public int uid { get; private set; }
            static int uidCounter = 0;

            public DagNode(string id, string ImplName, int Size)
            {
                this.id = id;
                this.ImplName = ImplName;
                this.Size = Size;
                this.uid = uidCounter++;
            }

            public override string ToString()
            {
                return ImplName;
            }
        }

        public class DagEdge
        {
            public DagNode Source, Target;
            public int CallSite;

            public DagEdge(DagNode source, DagNode target, int callsite)
            {
                this.Source = source;
                this.Target = target;
                this.CallSite = callsite;
            }
        }

        Program program;
        Dictionary<string, int> extraRecBound;

        DagNode Root;
        public HashSet<DagNode> Nodes { get; private set; }
        public HashSet<DagEdge> Edges { get; private set; }
        ProgramDisjointness Disj;

        // Dependent information
        public Dictionary<DagNode, HashSet<DagEdge>> Children { get; private set; }
        public Dictionary<DagNode, HashSet<DagEdge>> Parents { get; private set; }
        Dictionary<string, HashSet<DagNode>> IdToNodes;

        // lazily extending optimial dag
        Action<string> lazyExtendDag;
        Graph<string> idgraph;
        Dictionary<string, string> idToProc;

        // For stats
        TimeSpan tmpTime1; //, tmpTime2;

        public DagOracle(Program program, Dictionary<string, int> extraRecBound)
            :this(program, new ProgramDisjointness(program), extraRecBound)
        {
        }

        public DagOracle(Program program, ProgramDisjointness disj, Dictionary<string, int> extraRecBound)
        {
            Nodes = new HashSet<DagNode>();
            Edges = new HashSet<DagEdge>();
            Children = new Dictionary<DagNode, HashSet<DagEdge>>();
            Parents = new Dictionary<DagNode, HashSet<DagEdge>>();
            IdToNodes = new Dictionary<string, HashSet<DagNode>>();
            Root = null;

            this.Disj = disj;
            this.program = program;
            this.extraRecBound = extraRecBound;
        }

        // Create a fresh copy of the Dag
        public DagOracle Copy()
        {
            var ret = new DagOracle(program, Disj, extraRecBound);
            foreach (var n in Nodes)
                ret.AddNode(n);
            foreach (var e in Edges)
                ret.AddEdge(e);
            ret.Root = Root;

            return ret;
        }

        public void SetRoot(DagNode node)
        {
            AddNode(node);
            Root = node;
        }

        public DagNode GetRoot()
        {
            return Root;
        }

        IEnumerable<DagEdge> OutGoing(DagNode node)
        {
            return Children[node];
        }

        IEnumerable<DagEdge> InComing(DagNode node)
        {
            Debug.Assert(Nodes.Contains(node));

            return Parents[node];
        }

        public int ComputeSize()
        {
            RemoveUnreachableNodes();

            var ret = 0;
            Nodes.Iter(node => ret += node.Size);
            return ret;
        }

        public IEnumerable<DagNode> FindMergeCandidates(DagNode n1, int cs, string targetId)
        {
            if (!IdToNodes.ContainsKey(targetId) || IdToNodes[targetId].Count == 0)
                yield break;

            var an = Ancestors(n1);
            
            foreach (var n2 in IdToNodes[targetId])
            {
                Debug.Assert(!an.Contains(n2));

                // check ancestors of n1
                if (!CheckDisjointness(n2, an, new HashSet<DagNode>()))
                    continue;

                var d2 = Descendants(n2);

                var suitable = true;
                foreach (var e in Children[n1])
                {
                    if (Disj.IsExclusive(n1.ImplName, e.CallSite, cs)) continue;
                    var d1 = Descendants(e.Target);
                    if (d1.Intersection(d2).Count != 0)
                    {
                        suitable = false;
                        break;
                    }
                }
                if (!suitable) continue;
                
                // For each decendant of n2, if we go up, when it hits an,
                // then disjointness should hold; this is the entire check and above
                // are just filters
                foreach (var dn in d2)
                {
                    if (!CheckDisjointness(dn, an, d2))
                    {
                        suitable = false;
                        break;
                    }
                }

                if (!suitable) continue;

                yield return n2;
            }
            yield break;
        }

        // Return the set of all nodes disjoint with n. The second argument is optional; used for optimization
        // Precondition: This only works correctly when the DAG is a tree
        public Dictionary<DagNode, HashSet<DagNode>> AllDisjointNodes()
        {
            Dictionary<DagNode, int> nodeToTreeSize;
            Dictionary<DagNode, HashSet<DagNode>> nodeToChildren;
            ComputeDagSizes(out nodeToTreeSize, out nodeToChildren);

            var ret = new Dictionary<DagNode, HashSet<DagNode>>();
            Nodes.Iter(n => ret.Add(n, new HashSet<DagNode>()));
            AllDisjointNodesHelper(Root, ret, nodeToChildren);
            return ret;
        }

        void AllDisjointNodesHelper(DagNode n, Dictionary<DagNode, HashSet<DagNode>> nodeToDisj, Dictionary<DagNode, HashSet<DagNode>> nodeToDescendants)
        {
            foreach (var c in Children[n].Select(e => e.Target))
            {
                nodeToDisj[c].UnionWith(nodeToDisj[n]);
            }

            foreach (var e1 in Children[n])
            {
                foreach (var e2 in Children[n])
                {
                    if (e1 == e2) continue;
                    if (!Disj.IsExclusive(n.ImplName, e1.CallSite, e2.CallSite)) continue;
                    nodeToDisj[e1.Target].UnionWith(nodeToDescendants[e2.Target]);
                }
            }

            foreach (var c in Children[n].Select(e => e.Target))
            {
                AllDisjointNodesHelper(c, nodeToDisj, nodeToDescendants);
            }

        }


        public bool IsDisjoint(DagNode n1, DagNode n2)
        {
            if (n1 == n2) return false;
            if (Ancestors(n1).Contains(n2)) return false;

            // Light up ancestors of n2
            var ancestors = Ancestors(n2);
            Debug.Assert(!ancestors.Contains(n1));

            // Walk up from n1 and check
            return CheckDisjointness(n1, ancestors, new HashSet<DagNode>());
        }

        private bool CheckDisjointness(DagNode n, HashSet<DagNode> ancestors, HashSet<DagNode> blocked)
        {
            Debug.Assert(!ancestors.Contains(n));
            if(!Parents.ContainsKey(n)) return true;
            
            foreach (var pedge in Parents[n])
            {
                if (blocked.Contains(pedge.Source)) continue;

                if (ancestors.Contains(pedge.Source))
                {
                    foreach (var e in Children[pedge.Source].Where(c => ancestors.Contains(c.Target)))
                    {
                        if (!Disj.IsExclusive(pedge.Source.ImplName, pedge.CallSite, e.CallSite))
                            return false;
                    }
                }
                else
                {
                    if (!CheckDisjointness(pedge.Source, ancestors, blocked))
                        return false;
                }
            }
            return true;
        }

        private void Merge(DagNode n1, DagNode n2)
        {
            // Swing parents to n1
            var todelete = new List<DagEdge>();
            foreach (var edge in InComing(n2))
            {
                var nedge = new DagEdge(edge.Source, n1, edge.CallSite);
                todelete.Add(edge);
                AddEdge(nedge);
            }

            // delete n2
            todelete.Iter(DeleteEdge);
            DeleteNodeAndDecendants(n2);
        }

        // constructs a DAG over IDs (procedures + recursion vector)
        Graph<string> ConstructIdDag(out string main, out Dictionary<string, string> idToProc)
        {
            var ret = new Graph<string>();
            idToProc = new Dictionary<string, string>();
            
            var impls = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name, impl));

            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();
            main = ep.Name;

            var impl2index = new Dictionary<string, int>();
            impls.Iter(tup => impl2index.Add(tup.Key, impl2index.Count));

            var cg = BoogieUtil.GetCallGraph(program);
            var recursiveProcs = BoogieUtil.GetCyclicNodes<string>(cg);

            var procToReachableRecProcs = new Dictionary<string, HashSet<string>>();
            var ImplToId = new Func<Implementation, int[], string>((impl, rv) =>
            {
                var str = "";
                if (!procToReachableRecProcs.ContainsKey(impl.Name))
                {
                    procToReachableRecProcs.Add(impl.Name,
                        recursiveProcs.Intersection(BoogieUtil.GetReachableNodes<string>(impl.Name, cg)));
                }
                foreach (var r in procToReachableRecProcs[impl.Name])
                    str += rv[impl2index[r]].ToString();
                var id = string.Format("{0}[{1}]", impl.Name, str);
                
                return id;
            });


            var recursionVector = new int[impls.Count];
            for (int i = 0; i < recursionVector.Length; i++)
                recursionVector[i] = 0;

            var root = ImplToId(ep, recursionVector);
            idToProc[root] = ep.Name;

            ret.AddSource(root);

            var frontier = new Stack<Tuple<string, string, int[]>>();

            frontier.Push(Tuple.Create(root, ep.Name, recursionVector));

            while (frontier.Any())
            {
                var tt = frontier.Peek();
                frontier.Pop();

                var id = tt.Item1;
                var implName = tt.Item2;
                var rv = tt.Item3;

                foreach (var succImpl in cg.Successors(implName))
                {
                    var rvcopy = new int[rv.Length];
                    Array.Copy(rv, rvcopy, rv.Length);

                    rvcopy[impl2index[succImpl]]++;

                    if (HasExceededRecBound(succImpl, rvcopy[impl2index[succImpl]]))
                        continue;                    

                    var sid = ImplToId(impls[succImpl], rvcopy);
                    idToProc[sid] = succImpl;

                    ret.AddEdge(id, sid);
                    frontier.Push(Tuple.Create(sid, succImpl, rvcopy));
                }
            }
            return ret;
        }

        bool HasExceededRecBound(string impl, int bound)
        {
            if (!extraRecBound.ContainsKey(impl))
                return (bound > CommandLineOptions.Clo.RecursionBound);
            return bound > CommandLineOptions.Clo.RecursionBound + extraRecBound[impl];
        }

        // Returns the size of the fully expanded tree
        public int ConstructCallDagOnTheFly(bool lazy, MERGING_STRATEGY strategy)
        {
            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                Console.WriteLine("Constructing the call dag on the fly");

            var main = "";
            idToProc = null;
            idgraph = ConstructIdDag(out main, out idToProc);
            var sorted = idgraph.TopologicalSort();
            Debug.Assert(sorted.Count() != 0);
            var rootid = sorted.First();

            // id -> #nodes with that id in the fully expanded tree 
            // (used for debugging)
            var id2numnodes = new Dictionary<string, int>();
            idgraph.Nodes.Iter(s => id2numnodes.Add(s, 0));
            id2numnodes[rootid] = 1;

            // Start with empty call dag
            Root = new DagNode(rootid, main, 1);
            AddNode(Root);

            var impls = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name, impl));

            // impl to its calls
            var implToCalls = new Dictionary<string, HashSet<Tuple<int, string>>>();
            foreach (var tup in impls)
            {
                implToCalls.Add(tup.Key, new HashSet<Tuple<int, string>>());
                foreach (var block in tup.Value.Blocks)
                {
                    foreach (var cmd in block.Cmds.OfType<CallCmd>())
                    {
                        if (!impls.ContainsKey(cmd.callee))
                            continue;
                        var cs = QKeyValue.FindIntAttribute(cmd.Attributes, "si_unique_call", -1);
                        implToCalls[tup.Key].Add(Tuple.Create(cs, cmd.callee));
                    }
                }
            }

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                Console.WriteLine("ID graph done, and top sorted (size = {0})", idgraph.Nodes.Count);

            if (strategy != MERGING_STRATEGY.OPT)
            {
                var NodeToCalls = new Func<DagNode, List<Tuple<DagNode, int, string>>>(n =>
                    {
                        var r = new List<Tuple<DagNode, int, string>>();
                        implToCalls[n.ImplName].Iter(t => r.Add(Tuple.Create(n, t.Item1, t.Item2)));
                        return r;
                    });

                var opencalls = new List<Tuple<DagNode, int, string>>();
                opencalls.AddRange(NodeToCalls(Root));
                var rand = new Random((int)DateTime.Now.Ticks);
                while (opencalls.Count != 0)
                {
                    var next = rand.Next(0, opencalls.Count);
                    var cs = opencalls[next];
                    opencalls.RemoveAt(next);
                    var targetid = idgraph.Successors(cs.Item1.id).Where(id => idToProc[id] == cs.Item3).FirstOrDefault();
                    if (targetid == null) continue; // hit rec. bound

                    var candidates = FindMergeCandidates(cs.Item1, cs.Item2, targetid);

                    if (strategy == MERGING_STRATEGY.FIRST)
                    {
                        var t = candidates.FirstOrDefault();
                        if (t == null)
                        {
                            t = new DagNode(targetid, cs.Item3, 1);
                            opencalls.AddRange(NodeToCalls(t));
                        }
                        AddEdge(new DagEdge(cs.Item1, t, cs.Item2));
                        continue;
                    }

                    var candidatesList = candidates.ToList();

                    if (candidatesList.Count == 0)
                    {
                        var t = new DagNode(targetid, cs.Item3, 1);
                        opencalls.AddRange(NodeToCalls(t));
                        AddEdge(new DagEdge(cs.Item1, t, cs.Item2));
                        continue;
                    }

                    if (strategy == MERGING_STRATEGY.RANDOM)
                    {
                        
                        var choice = rand.Next(0, candidatesList.Count + 2);
                        DagNode t = null;
                        if (choice > candidatesList.Count - 1)
                        {
                            t = new DagNode(targetid, cs.Item3, 1);
                            opencalls.AddRange(NodeToCalls(t));
                        }
                        else
                        {
                            t = candidatesList[choice];
                        }
                        AddEdge(new DagEdge(cs.Item1, t, cs.Item2));
                        continue;
                    }

                    if (strategy == MERGING_STRATEGY.RANDOM_PICK)
                    {
                        var choice = rand.Next(0, candidatesList.Count);
                        var t = candidatesList[choice];
                        AddEdge(new DagEdge(cs.Item1, t, cs.Item2));
                        continue;
                    }

                    if (strategy == MERGING_STRATEGY.MAXC)
                    {
                        var max = 0.0;
                        DagNode t = null;
                        foreach (var c in candidatesList)
                        {
                            var size = Descendants(c).Count / (1 + Ancestors(c).Count);
                            if (max <= size)
                            {
                                max = size;
                                t = c;
                            }
                        }
                        AddEdge(new DagEdge(cs.Item1, t, cs.Item2));
                        continue;
                    }
                }
                return 0;
            }
            else
            {

                var idsExtended = new HashSet<string> { rootid };

                lazyExtendDag = new Action<string>(id =>
                    {
                        foreach (var n in sorted)
                        {
                            if (idsExtended.Contains(n)) continue;
                            idsExtended.Add(n);
                            ExtendAndCompress(n, idgraph, idToProc, implToCalls, id2numnodes);
                            if (n == id) break;
                        }
                    });

                if (lazy)
                    return 0;

                lazyExtendDag(sorted.Last());
            }

            /*
            foreach (var id in sorted)
            {
                if (id == rootid) continue;
                ExtendAndCompress(id, idgraph, idToProc, implToCalls, id2numnodes);
            }
            */            

            var ret = 0;
            id2numnodes.Iter(tup => ret += tup.Value);
            return ret;
        }

        public void ExtendDag(string id)
        {
            Debug.Assert(lazyExtendDag != null);
            lazyExtendDag(id);
        }

        void ExtendAndCompress(string id, Graph<string> idgraph, 
            Dictionary<string, string> idToProc,
            Dictionary<string, HashSet<Tuple<int, string>>> implToCalls,
            Dictionary<string, int> id2numnodes)
        {
            if(CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                Console.WriteLine("Adding id {0}", id);
            var predids = idgraph.Predecessors(id);
            Debug.Assert(predids.Count() != 0);

            // Add the edges to the new id
            foreach (var pred in predids)
            {
                var predproc = idToProc[pred];
                var succproc = idToProc[id];
                var calls = new HashSet<int>(
                    implToCalls[predproc].Where(t => t.Item2 == succproc).Select(t => t.Item1));

                // compute number of nodes
                id2numnodes[id] += id2numnodes[pred] * calls.Count;

                foreach (var n in IdToNodes[pred])
                    GenerateSuccessors(n, id, succproc, calls);
            }

            // compress
            Compress(id);
        }

        void GenerateSuccessors(DagNode node, string targetid, string targetproc, HashSet<int> calls)
        {
            foreach (var call in calls)
            {
                AddEdge(new DagEdge(node, new DagNode(targetid, targetproc, 1), call));
            }
        }

        void Compress(string id)
        {
            if(IdToNodes.ContainsKey(id))
                IdToNodes[id].RemoveWhere(n => !Nodes.Contains(n));

            if (!IdToNodes.ContainsKey(id) ||
                IdToNodes[id].Count() == 1)
                return;

            // induced subgraph on all dag nodes with name "name"
            Microsoft.Boogie.GraphUtil.Graph<DagNode> graph = null;
            Dictionary<DagNode, HashSet<DagNode>> adj = null;

            var st = DateTime.Now;

            if (IdToNodes[id].Count < 100)
            {
                graph = new Microsoft.Boogie.GraphUtil.Graph<DagNode>();

                // Make sure all the nodes are inserted
                IdToNodes[id].Iter(n => graph.AddSource(n));

                foreach (var n1 in IdToNodes[id])
                {
                    foreach (var n2 in IdToNodes[id])
                    {
                        if (n1.uid <= n2.uid) continue;

                        if (!IsDisjoint(n1, n2))
                        {
                            graph.AddEdge(n1, n2);
                            graph.AddEdge(n2, n1);
                        }
                    }
                }
                //System.IO.File.WriteAllText("induced.dot", graph.ToDot(n => n.uid.ToString()));
            }
            else
            {
                // Gather the subset of the dag that we should look at
                var ancestors = new HashSet<DagNode>();
                IdToNodes[id].Iter(v => ancestors.UnionWith(Ancestors(v)));

                HashSet<DagNode> tt = null;
                GetAdjacency(Root, id, out adj, out tt, ancestors);
            }

            #region Debugging code for adjacency code
            /*
            foreach (var n in graph.Nodes)
            {
                var s1 = new HashSet<DagNode>(graph.Successors(n));
                var s2 = adj[n];
                if (!s1.SetEquals(s2))
                {
                    var ancestors = new HashSet<DagNode>();
                    IdToNodes[id].Iter(v => ancestors.UnionWith(Ancestors(v)));
                    Dump("err.dot", ancestors);
                    Debug.Assert(false);
                }
            }
            */
            #endregion

            tmpTime1 += (DateTime.Now - st);

            var coloring = graph != null ? ColorGraph<DagNode>(graph) : ColorGraph<DagNode>(IdToNodes[id], n => adj[n]);

            // Got the coloring!
            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                Console.WriteLine("Got a coloring of {0} nodes with {1} colors", IdToNodes[id].Count, coloring.Values.Max() + 1);

            // pick representation in each color
            var representative = new Dictionary<int, DagNode>();
            foreach (var tup in coloring)
            {
                if (!representative.ContainsKey(tup.Value))
                    representative.Add(tup.Value, tup.Key);
            }

            // Merge
            foreach (var n in (new HashSet<DagNode>(IdToNodes[id])))
            {
                var r = representative[coloring[n]];
                if (r == n) continue;
                //Console.WriteLine("Merging for proc {0}, {1} with {2}", n.ImplName, n.uid, r.uid);
                Merge(r, n);
            }

            //if(merged)
            //    RemoveUnreachableNodes();
            // Done!
        }

        void GetAdjacency(DagNode node, string id, out Dictionary<DagNode, HashSet<DagNode>> adj, out HashSet<DagNode> reachable,
            HashSet<DagNode> universe)
        {
            adj = new Dictionary<DagNode, HashSet<DagNode>>();
            reachable = new HashSet<DagNode>();

            if (node.id == id)
            {
                adj.Add(node, new HashSet<DagNode>());
                reachable.Add(node);
                return;
            }

            if (!universe.Contains(node))
                return;

            var childToDescendants = new Dictionary<DagEdge, HashSet<DagNode>>();
            foreach (var e in Children[node])
            {
                Dictionary<DagNode, HashSet<DagNode>> a;
                HashSet<DagNode> d;
                GetAdjacency(e.Target, id, out a, out d, universe);

                // pt. wise union of adj
                foreach (var tup in a)
                {
                    if (!adj.ContainsKey(tup.Key))
                        adj.Add(tup.Key, new HashSet<DagNode>());
                    adj[tup.Key].UnionWith(tup.Value);
                }

                // stash decendants
                childToDescendants[e] = d;
            }

            // decide fate of node pairs whose least common ancestor is "node"
            foreach (var e1 in Children[node])
            {
                reachable.UnionWith(childToDescendants[e1]);
                foreach (var e2 in Children[node])
                {
                    if (e1 == e2) continue;
                    
                    if (Disj.IsExclusive(node.ImplName, e1.CallSite, e2.CallSite)) continue;
                    var g1 = childToDescendants[e1].Difference(childToDescendants[e2]);
                    var g2 = childToDescendants[e2].Difference(childToDescendants[e1]);

                    g1.RemoveWhere(a => a.id != id);
                    g2.RemoveWhere(a => a.id != id);

                    foreach(var a in g1)
                        adj[a].UnionWith(g2);

                    foreach (var a in g2)
                        adj[a].UnionWith(g1);                        
                }
            }

        }

        Dictionary<Node, int> ColorGraph<Node>(Microsoft.Boogie.GraphUtil.Graph<Node> graph)
        {
            return ColorGraph(graph.Nodes, n =>new HashSet<Node>(graph.Successors(n)));
        }

        // Colors a graph
        Dictionary<Node, int> ColorGraph<Node>(HashSet<Node> nodes, Func<Node, HashSet<Node>> Adjacency)
        {
            var nodelist = new List<Node>(nodes);
            var rand = new Random(0); //(int)DateTime.Now.Ticks);
            // number of node orderings to try
            int numTries = 10;

            var maxColors = Int32.MaxValue;
            Dictionary<Node, int> finalColoring = null;

            while (numTries > 0)
            {
                numTries--;
                // generate random ordering
                var perm = RandomPermutation(nodelist, rand);
                int maxc;
                var colors = Color(Adjacency, perm, out maxc);
                if (maxc < maxColors)
                {
                    finalColoring = colors;
                    maxColors = maxc;
                }
            }

            return finalColoring;
        }

        List<Node> RandomPermutation<Node>(List<Node> nodes, Random rand)
        {
            var ls = new List<Node>(nodes);
            var pm = new int[ls.Count];
            RandomPermutation(pm, rand);

            for (int i = 0; i < pm.Length; i++)
            {
                ls[i] = nodes[pm[i]];
            }

            return ls;
        }

        void RandomPermutation(int[] Permutation, Random rand)
        {
            int i;
            for (i = 0; i < Permutation.Length; i++)
            {
                var j = rand.Next(i + 1);
                Permutation[i] = Permutation[j];
                Permutation[j] = i;
            }
        }

        // returns a coloring of the nodes, given an ordering
        private Dictionary<Node, int> Color<Node>(Func<Node, HashSet<Node>> Adj,
            IEnumerable<Node> orderedNodes, out int maxColor)
        {
            var color = new Dictionary<Node, int>();
            maxColor = 0;
            foreach (var n in orderedNodes)
            {
                var neighborColors = new HashSet<int>();
                var consider = new HashSet<Node>(color.Keys);
                consider.IntersectWith(Adj(n));

                consider
                    .Iter(s => neighborColors.Add(color[s]));

                // find the least c that is not in neightColors
                var c = 0;
                while (true)
                {
                    if (!neighborColors.Contains(c))
                    {
                        break;
                    }
                    c++;
                }
                maxColor = Math.Max(maxColor, c);
                color.Add(n, c);
            }
            return color;
        }


        public HashSet<DagNode> Ancestors(DagNode node)
        {
            var ret = new HashSet<DagNode>();
            ret.Add(node);

            var frontier = new HashSet<DagNode>();
            frontier.Add(node);

            while (frontier.Count != 0)
            {
                var next = new HashSet<DagNode>();
                foreach (var p in frontier.Where(s => Parents.ContainsKey(s)))
                    next.UnionWith(Parents[p].Select(e => e.Source));

                frontier = next;
                frontier.ExceptWith(ret);

                ret.UnionWith(next);
            }
            return ret;
        }

        public HashSet<DagNode> Descendants(DagNode node)
        {
            var ret = new HashSet<DagNode>();
            ret.Add(node);

            var frontier = new HashSet<DagNode>();
            frontier.Add(node);

            while (frontier.Count != 0)
            {
                var next = new HashSet<DagNode>();
                foreach (var v in frontier)
                    next.UnionWith(Children[v].Select(e => e.Target));

                frontier = next;
                frontier.ExceptWith(ret);

                ret.UnionWith(next);
            }
            return ret;
        }

        public void AddNode(DagNode node)
        {
            if (Nodes.Contains(node))
                return;
            Nodes.Add(node);
            
            IdToNodes.InitAndAdd(node.id, node);

            Children.Add(node, new HashSet<DagEdge>());
            Parents.Add(node, new HashSet<DagEdge>());
        }

        public void AddEdge(DagEdge edge)
        {
            //Console.WriteLine("Adding edge {0} to {1}", edge.Source.id, edge.Target.id);
            Edges.Add(edge);
            AddNode(edge.Source);
            AddNode(edge.Target);

            Children[edge.Source].Add(edge);
            Parents[edge.Target].Add(edge);
        }

        public void DeleteEdge(DagEdge edge)
        {
            Edges.Remove(edge);
            Children[edge.Source].Remove(edge);
            Parents[edge.Target].Remove(edge);
        }

        public void DeleteNode(DagNode node)
        {
            Debug.Assert(Root != node);
            Debug.Assert(Nodes.Contains(node));

            var edges = new HashSet<DagEdge>();
            edges.UnionWith(Children[node]);
            edges.UnionWith(Parents[node]);
            foreach(var e in edges)
                DeleteEdge(e);

            Nodes.Remove(node);
            Children.Remove(node);
            Parents.Remove(node);
            IdToNodes[node.id].Remove(node);
        }

        public DagNode FindSuccessor(DagNode source, int call, string target)
        {
            if (lazyExtendDag != null)
            {
                Debug.Assert(idgraph != null);
                var succid = idgraph.Successors(source.id).Where(id => idToProc[id] == target)
                    .First();
                lazyExtendDag(succid);
            }

            return Children[source].Where(e => e.CallSite == call && e.Target.ImplName == target)
                .Select(e => e.Target).FirstOrDefault();
        }

        public void DeleteNodeAndDecendants(DagNode node)
        {
            Decendants(node).Iter(DeleteNode);
        }

        public static DagOracle ConstructCallDag(Program program, Dictionary<string, int> extraRecBound)
        {
            var ret = new DagOracle(program, extraRecBound);

            var impls = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name, impl));

            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            var implToCalls = new Dictionary<string, HashSet<Tuple<int, string>>>();
            foreach (var tup in impls)
            {
                implToCalls.Add(tup.Key, new HashSet<Tuple<int, string>>());
                foreach (var block in tup.Value.Blocks)
                {
                    foreach (var cmd in block.Cmds.OfType<CallCmd>())
                    {
                        if (!impls.ContainsKey(cmd.callee))
                            continue;
                        var cs = QKeyValue.FindIntAttribute(cmd.Attributes, "si_unique_call", -1);
                        implToCalls[tup.Key].Add(Tuple.Create(cs, cmd.callee));
                    }
                }
            }

            var impl2index = new Dictionary<string, int>();
            impls.Iter(tup => impl2index.Add(tup.Key, impl2index.Count));

            var cg = BoogieUtil.GetCallGraph(program);
            var recursiveProcs = BoogieUtil.GetCyclicNodes<string>(cg);

            var procToReachableRecProcs = new Dictionary<string, HashSet<string>>();
            var ImplToNode = new Func<Implementation, int[], DagNode>((impl, rv) =>
            {
                var size = 1;
                var str = "";
                if (!procToReachableRecProcs.ContainsKey(impl.Name))
                {
                    procToReachableRecProcs.Add(impl.Name,
                        recursiveProcs.Intersection(BoogieUtil.GetReachableNodes<string>(impl.Name, cg)));
                }
                foreach (var r in procToReachableRecProcs[impl.Name])
                    str += rv[impl2index[r]].ToString();
                return new DagNode(string.Format("{0}[{1}]", impl.Name, str), impl.Name, size);
            });


            var recursionVector = new int[impls.Count];
            for (int i = 0; i < recursionVector.Length; i++)
                recursionVector[i] = 0;

            var root = ImplToNode(ep, recursionVector);
            var frontier = new Stack<Tuple<DagNode, int[]>>();
            
            frontier.Push(Tuple.Create(root, recursionVector));

            while (frontier.Any())
            {
                var tt = frontier.Peek();
                frontier.Pop();

                var n = tt.Item1;
                var rv = tt.Item2;

                foreach (var tup in implToCalls[n.ImplName])
                {
                    var rvcopy = new int[rv.Length];
                    Array.Copy(rv, rvcopy, rv.Length);

                    rvcopy[impl2index[tup.Item2]]++;

                    if (ret.HasExceededRecBound(tup.Item2, rvcopy[impl2index[tup.Item2]]))
                        continue;

                    var s = ImplToNode(impls[tup.Item2], rvcopy);
                    ret.AddEdge(new DagEdge(n, s, tup.Item1));
                    frontier.Push(Tuple.Create(s, rvcopy));
                }                
            }

            ret.SetRoot(root);

            return ret;
        }

        public void Compress()
        {
            var graph = new Microsoft.Boogie.GraphUtil.Graph<string>();

            foreach (var e in Edges)
                graph.AddEdge(e.Source.id, e.Target.id);

            graph.AddSource(Root.id);

            tmpTime1 = TimeSpan.Zero;

            // Top-sort
            var sorted = graph.TopologicalSort();

            var compressed = new HashSet<string>();
            foreach (var n in sorted)
            {
                if (compressed.Contains(n))
                    continue;
                compressed.Add(n);

                Console.WriteLine("Compressing {0}", n);
                Compress(n);
                //CheckSanity();
            }
            Console.WriteLine("tmpTim1: {0}", tmpTime1.TotalSeconds.ToString("F2"));
        }

        void ColorTreeNode(DagNode node, Dictionary<string, int> MinColorAvailable, IEnumerable<string> ids, Dictionary<DagNode, int> FinalColoring)
        {
            FinalColoring[node] = MinColorAvailable[node.id];
            MinColorAvailable[node.id]++;

            if (Children[node].Count == 0)
                return;

            // First, let us color the out-going edges of n
            var graph = new Microsoft.Boogie.GraphUtil.Graph<DagNode>();
            Children[node].Iter(e => graph.AddSource(e.Target));

            foreach (var e1 in Children[node])
            {
                foreach (var e2 in Children[node])
                {
                    if (e1 == e2) continue;
                    if (!IsDisjoint(e1.Target, e2.Target))
                        graph.AddEdge(e1.Target, e2.Target);
                }
            }
            // color this graph
            var coloring = ColorGraph<DagNode>(graph);

            var maxcolor = coloring.Values.Max();

            // construct inverse map for the coloring
            var colorToNodes = new Dictionary<int, HashSet<DagNode>>();
            for (int i = 0; i <= maxcolor; i++)
                colorToNodes.Add(i, new HashSet<DagNode>());
            coloring.Iter(tup => colorToNodes[tup.Value].Add(tup.Key));

            // Node to its mincolor mapping
            var nodeToMinColorAvailable = new Dictionary<DagNode, Dictionary<string, int>>();

            // iterate over the colors in ascending order
            for (int i = 0; i <= maxcolor; i++)
            {
                foreach (var n in colorToNodes[i])
                {
                    var map = new Dictionary<string, int>(MinColorAvailable);

                    // take max over its neighbors that have a smaller color
                    foreach (var s in graph.Successors(n))
                    {
                        if (coloring[s] > i) continue;
                        foreach (var id in ids)
                            map[id] = Math.Max(map[id], nodeToMinColorAvailable[s][id]);
                    }

                    // Recurse
                    ColorTreeNode(n, map, ids, FinalColoring);
                    nodeToMinColorAvailable[n] = map;
                }
            }

        }

        public void CheckSanity()
        {
            // Check that all mergings are safe
            foreach (var node in Nodes.Where(n => Parents[n].Count > 1))
            {
                if (!CheckSanityForward(node))
                {
                    Dump("err.dot", Ancestors(node));
                    Console.WriteLine("DAG Sanity check failed!!");
                    Debug.Assert(false);
                }
            }

            HashSet<DagNode> tt = null; // temporary
            if(!CheckSanityBackward(Root, out tt)) {
                Console.WriteLine("DAG Sanity check failed!!");
                Debug.Assert(false);
            }

        }

        bool CheckSanityBackward(DagNode node, out HashSet<DagNode> reachable)
        {
            reachable = new HashSet<DagNode>{node};
            var childToDescendants = new Dictionary<DagEdge, HashSet<DagNode>>();
            foreach (var e in Children[node])
            {
                HashSet<DagNode> d;
                if (!CheckSanityBackward(e.Target, out d))
                    return false;
                childToDescendants[e] = d;
            }
            foreach (var e1 in Children[node])
            {
                reachable.UnionWith(childToDescendants[e1]);
                foreach (var e2 in Children[node])
                {
                    if (e1 == e2) continue;
                    if (childToDescendants[e1].Intersection(childToDescendants[e2]).Count > 0)
                    {
                        if (!Disj.IsExclusive(node.ImplName, e1.CallSite, e2.CallSite))
                            return false;
                    }
                }
            }

            return true;
        }
        
        bool CheckSanityForward(DagNode node)
        {
            foreach (var e1 in Parents[node])
            {
                foreach (var e2 in Parents[node])
                {
                    if (e1 == e2) continue;
                    if (e1.Source == e2.Source)
                    {
                        if (!Disj.IsExclusive(node.ImplName, e1.CallSite, e2.CallSite))
                        {
                            Console.WriteLine("Failed check 1: {0} {1} {2}", node.ImplName, e1.CallSite, e2.CallSite);
                            return false;
                        }
                        continue;
                    }
                    var a1 = Ancestors(e1.Source);
                    var a2 = Ancestors(e2.Source);

                    if (a1.Contains(e2.Source))
                    {
                        foreach (var e3 in Children[e2.Source])
                        {
                            if (e3 == e2) continue;
                            if (!a1.Contains(e3.Target)) continue;
                            if (!Disj.IsExclusive(e2.Source.ImplName, e2.CallSite, e3.CallSite))
                            {
                                Console.WriteLine("Failed check 2: {0} {1} {2} {3}", node.ImplName, e1.CallSite, e2.CallSite, e3.CallSite);
                                return false;
                            }
                        }
                        continue;
                    }

                    if (a2.Contains(e1.Source))
                    {
                        foreach (var e3 in Children[e1.Source])
                        {
                            if (e3 == e1) continue;
                            if (!a2.Contains(e3.Target)) continue;
                            if (!Disj.IsExclusive(e1.Source.ImplName, e1.CallSite, e3.CallSite))
                            {
                                Console.WriteLine("Failed check 3: {0} {1} {2} {3}", node.ImplName, e1.CallSite, e2.CallSite, e3.CallSite);
                                return false;
                            }
                        }

                        continue;
                    }

                    if (!IsDisjoint(e1.Source, e2.Source))
                    {
                        Console.WriteLine("Failed check 4: {0} {1} {2}", node.ImplName, e1.CallSite, e2.CallSite);
                        return false;
                    }
                }
            }
            return true;

        }

        void RemoveUnreachableNodes()
        {
            Debug.Assert(Root != null);

            var reached = Decendants(Root);

            var delete = new HashSet<DagNode>(Nodes);
            delete.ExceptWith(reached);
            delete.Iter(DeleteNode);
        }

        HashSet<DagNode> Decendants(DagNode node)
        {
            var reached = new HashSet<DagNode> { node };
            var frontier = new HashSet<DagNode> { node };
            while (frontier.Any())
            {
                var next = new HashSet<DagNode>();
                frontier.Iter(n =>
                    Children[n].Iter(e => next.Add(e.Target)));
                next.ExceptWith(reached);
                frontier = next;
                reached.UnionWith(next);
            }
            return reached;
        }

        public void Dump(string filename)
        {
            if (Nodes.Count == 0 || Root == null)
                return;
            Dump(filename, Nodes);
            //Disj.DumpCFG(BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "main"), "main.dot");
        }

        public void Dump(string filename, HashSet<DagNode> nodes)
        {
            RemoveUnreachableNodes();

            var str = new System.IO.StreamWriter(filename);
            str.WriteLine("digraph DAG {");

            nodes
                .Iter(n => str.WriteLine("{0} [ label = \"{1}\" color=black shape=box];", n.uid, n.ImplName));

            foreach (var edge in Edges.Where(e => nodes.Contains(e.Source) && nodes.Contains(e.Target)))
                str.WriteLine("{0} -> {1} [ label = \"{2}\"];", edge.Source.uid, edge.Target.uid, edge.CallSite);

            str.WriteLine("}");
            str.Close();
        }

        // Return the sizes of shared dags; and more info about the largest shared sub-tree
        public void ComputeDagSizes(out Dictionary<DagNode, int> nodeToTreeSizeMap,
            out Dictionary<DagNode, HashSet<DagNode>> nodeToChildrenMap)
        {
            var graph = new Microsoft.Boogie.GraphUtil.Graph<DagNode>();

            foreach (var e in Edges)
                graph.AddEdge(e.Target, e.Source);

            graph.AddSource(Root);

            // Top-sort
            var sorted = graph.TopologicalSort();
            var nodeToTreeSize = new Dictionary<DagNode, int>();
            var nodeToChildren = new Dictionary<DagNode, HashSet<DagNode>>();

            Nodes.Iter(vc => nodeToTreeSize.Add(vc, 0));
            Nodes.Iter(vc => nodeToChildren.Add(vc, new HashSet<DagNode>()));

            foreach (var n in sorted)
            {
                foreach (var s in Children[n].Select(e => e.Target))
                {
                    nodeToTreeSize[n] += nodeToTreeSize[s];
                    nodeToChildren[n].UnionWith(nodeToChildren[s]);
                }
                nodeToTreeSize[n]++;
                nodeToChildren[n].Add(n);
            }

            nodeToChildrenMap = nodeToChildren;
            nodeToTreeSizeMap = nodeToTreeSize;
        }

        // Return the sizes of shared dags; and more info about the largest shared sub-tree
        public int ComputeDagSizes()
        {
            Dictionary<DagNode, int> nodeToTreeSize;
            Dictionary<DagNode, HashSet<DagNode>> nodeToChildren;
            ComputeDagSizes(out nodeToTreeSize, out nodeToChildren);

            var hist = new Dictionary<int, int>(); // size -> count
            var largestsize = 0;
            DagNode largestnode = null;

            foreach (var n in Nodes)
            {
                if (Parents[n].Count > 1)
                {
                    var size = nodeToChildren[n].Count;
                    if (!hist.ContainsKey(size))
                        hist[size] = 0;
                    hist[size]++;

                    if (size > largestsize)
                    {
                        largestsize = size;
                        largestnode = n;
                    }
                }
            }
            
            if (largestnode != null)
            {
                Console.WriteLine("Shared node size distribution");
                hist.Iter(tup => Console.Write("{0}: {1}  ", tup.Key, tup.Value));
                Console.WriteLine();

                Console.WriteLine("Largest shared subtree has size {0}, tree size {1}, for proc {2}", largestsize,
                    nodeToTreeSize[largestnode], largestnode.ImplName);

                Dump("largest.dot", Ancestors(largestnode));
            }
            Console.WriteLine("Tree size: {0}", nodeToTreeSize[Root]);
             
            return nodeToTreeSize[Root];
        }

    }
    
    /****************************************
    *      Counter-example Generation       *
    ****************************************/

    public class EmptyErrorReporter : ProverInterface.ErrorHandler
    {
        public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome) { }
    }

    public class InsufficientDetailsToConstructCexPath : Exception
    {
        public InsufficientDetailsToConstructCexPath(string msg) : base(msg) { }

    }

    public class StratifiedInliningErrorReporter : ProverInterface.ErrorHandler
    {
        StratifiedInlining si;
        public VerifierCallback callback;
        StratifiedVC mainVC;
        public static TimeSpan ttime = TimeSpan.Zero;

        public bool reportTrace;
        public bool reportTraceIfNothingToExpand;

        public List<StratifiedCallSite> callSitesToExpand;
        List<Tuple<int, int>> orderedStateIds;

        public StratifiedInliningErrorReporter(VerifierCallback callback, StratifiedInlining si, StratifiedVC mainVC)
        {
            this.callback = callback;
            this.si = si;
            this.mainVC = mainVC;
            this.reportTrace = false;
            this.reportTraceIfNothingToExpand = false;
        }

        public override int StartingProcId()
        {
            return mainVC.id;
        }

        private Absy Label2Absy(string procName, string label)
        {
            int id = int.Parse(label);
            var l2a = si.implName2StratifiedInliningInfo[procName].label2absy;
            return (Absy)l2a[id];
        }

        public override void OnProverError(string message)
        {
            // Panic, shutdown!
            Console.WriteLine("Corral encountered a prover error. Giving up.");
            Console.Out.Flush();

            // Give a few seconds to the prover to shutdown
            var t1 =
            System.Threading.Tasks.Task.Run(async () =>
            {
                await System.Threading.Tasks.Task.Delay(5 * 1000);
                Environment.Exit(-1);
            });

            var t2 =
                System.Threading.Tasks.Task.Run(() => { si.prover.Close(); });

            System.Threading.Tasks.Task.WaitAll(t1, t2);
        }

        public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome)
        {
            // Timeout?
            if (proverOutcome != ProverInterface.Outcome.Invalid)
                return;

            var start = DateTime.Now;
            List<Absy> absyList = GetAbsyTrace(mainVC, labels);
            orderedStateIds = new List<Tuple<int, int>>();

            var cex = NewTrace(mainVC, absyList, model);
            //cex.PrintModel();

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 2)
                cex.Print(6, Console.Out);

            if (cex != null && (reportTrace ||
                (reportTraceIfNothingToExpand && callSitesToExpand.Count == 0)))
            {
                callback.OnCounterexample(cex, null);
                //this.PrintModel(model);
            }
            ttime += (DateTime.Now - start);
        }

        // returns a list of blocks followed by a fake assert
        private List<Absy> GetAbsyTrace(StratifiedVC svc, IList<string> labels)
        {
            if (CommandLineOptions.Clo.SIBoolControlVC)
                return GetAbsyTraceBoolControlVC(svc);
            else
                return GetAbsyTraceControlFlowVariable(svc, labels);
        }

        private List<Absy> GetAbsyTraceControlFlowVariable(StratifiedVC svc, IList<string> labels)
        {
            if (labels == null)
            {
                labels = si.prover.CalculatePath(svc.id);
            }
            var ret = new List<Absy>();
            foreach (var label in labels)
            {
                ret.Add(Label2Absy(svc.info.impl.Name, label));
            }
            return ret;
        }

        private List<Absy> GetAbsyTraceBoolControlVC(StratifiedVC svc)
        {
            Debug.Assert(CommandLineOptions.Clo.UseProverEvaluate, "Must use prover evaluate option with boolControlVC"); 
            
            var ret = new List<Absy>();
            var impl = svc.info.impl;
            var block = impl.Blocks[0];

            while (true)
            {
                ret.Add(block);
                var gc = block.TransferCmd as GotoCmd;
                if (gc == null) break;
                Block next = null;
                foreach (var succ in gc.labelTargets)
                {
                    var succtaken = (bool)svc.info.vcgen.prover.Evaluate(svc.blockToControlVar[succ]);
                    if (succtaken)
                    {
                        next = succ;
                        break;
                    }
                }
                Debug.Assert(next != null, "Must find a successor");
                Debug.Assert(!ret.Contains(next), "CFG cannot be cyclic");
                block = next;
            }

            // fake assert
            ret.Add(new AssertCmd(Token.NoToken, Expr.True));

            return ret;
        }

        private Counterexample NewTrace(StratifiedVC svc, List<Absy> absyList, Model model)
        {
            // assume that the assertion is in the last place??
            AssertCmd assertCmd = (AssertCmd)absyList[absyList.Count - 1];
            List<Block> trace = new List<Block>();
            var calleeCounterexamples = new Dictionary<TraceLocation, CalleeCounterexampleInfo>();
            for (int j = 0; j < absyList.Count - 1; j++)
            {
                Block b = (Block)absyList[j];
                trace.Add(b);
                if (svc.callSites.ContainsKey(b))
                {
                    foreach (StratifiedCallSite scs in svc.callSites[b])
                    {
                        if (!si.attachedVC.ContainsKey(scs))
                        {
                            if (callSitesToExpand == null)
                                callSitesToExpand = new List<StratifiedCallSite>();

                            callSitesToExpand.Add(scs);
                        }
                        else
                        {
                            List<Absy> calleeAbsyList = GetAbsyTrace(si.attachedVC[scs], null);
                            var calleeCounterexample = NewTrace(si.attachedVC[scs], calleeAbsyList, model);
                            calleeCounterexamples[new TraceLocation(trace.Count - 1, scs.callSite.numInstr)] =
                            new CalleeCounterexampleInfo(calleeCounterexample, new List<object>());
                        }
                    }
                }
                if (svc.recordProcCallSites.ContainsKey(b) && (model != null || CommandLineOptions.Clo.UseProverEvaluate))
                {
                    foreach (StratifiedCallSite scs in svc.recordProcCallSites[b])
                    {
                        var args = new List<object>();
                        foreach (VCExpr expr in scs.interfaceExprs)
                        {
                            if (model == null && CommandLineOptions.Clo.UseProverEvaluate)
                            {
                                args.Add(svc.info.vcgen.prover.Evaluate(expr));
                            }
                            else
                            {
                                if (expr is VCExprIntLit)
                                {
                                    args.Add(model.MkElement((expr as VCExprIntLit).Val.ToString()));
                                }
                                else if (expr == VCExpressionGenerator.True)
                                {
                                    args.Add(model.MkElement("true"));
                                }
                                else if (expr == VCExpressionGenerator.False)
                                {
                                    args.Add(model.MkElement("false"));
                                }
                                else if (expr is VCExprVar)
                                {
                                    var idExpr = expr as VCExprVar;
                                    var prover = svc.info.vcgen.prover;
                                    string name = prover.Context.Lookup(idExpr);
                                    Model.Func f = model.TryGetFunc(name);
                                    if (f != null)
                                    {
                                        var val = f.GetConstant();
                                        if (val is Model.DatatypeValue)
                                        {
                                            args.Add(GenerateTraceValue(val));
                                        }
                                        else
                                        {
                                            args.Add(val);
                                        }
                                    }
                                }
                                else
                                {
                                    Debug.Assert(false);
                                }
                            }
                        }
                        calleeCounterexamples[new TraceLocation(trace.Count - 1, scs.callSite.numInstr)] =
                            new CalleeCounterexampleInfo(null, args);
                    }
                }
            }

            Block lastBlock = (Block)absyList[absyList.Count - 2];
            Counterexample newCounterexample = VC.VCGen.AssertCmdToCounterexample(assertCmd, lastBlock.TransferCmd, trace, model, svc.info.mvInfo, si.prover.Context);
            newCounterexample.AddCalleeCounterexample(calleeCounterexamples);
            return newCounterexample;
        }

        private String GenerateTraceValue(Model.Element element)
        {
            var str = new System.IO.StringWriter();
            if (element is Model.DatatypeValue)
            {
                var val = (Model.DatatypeValue)element;
                if (val.ConstructorName == "_" && val.Arguments[0].ToString() == "(as-array)")
                {
                    var parens = val.Arguments[1].ToString();
                    var func = element.Model.TryGetFunc(parens.Substring(1, parens.Length - 2));
                    if (func != null)
                    {
                        str.Write("{");
                        var appCount = 0;
                        foreach (var app in func.Apps)
                        {
                            if (appCount++ > 0)
                                str.Write(",");
                            str.Write("\"");
                            var argCount = 0;
                            foreach (var arg in app.Args)
                            {
                                if (argCount++ > 0)
                                    str.Write(",");
                                str.Write(GenerateTraceValue(arg));
                            }
                            str.Write("\":{0}", GenerateTraceValue(app.Result));
                        }
                        if (func.Else != null)
                        {
                            if (func.AppCount > 0)
                                str.Write(",");
                            str.Write("\"*\":{0}", GenerateTraceValue(func.Else));
                        }
                        str.Write("}");
                    }
                }
            }
            if (str.ToString() == "")
                str.Write(element.ToString().Replace(" ", "").Replace("(", "").Replace(")", ""));
            return str.ToString();
        }
    }

}
