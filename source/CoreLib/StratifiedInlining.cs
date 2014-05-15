﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Outcome = VC.VCGen.Outcome;
    
namespace CoreLib {
    /****************************************
    *           Pseudo macros               *
    ****************************************/
    
    // TODO: replace this with conventional functions
    public class MacroSI
    {
        public static void PRINT(string s, int lvl)
        {
            if (CommandLineOptions.Clo.StratifiedInliningVerbose > lvl)
                Console.WriteLine(s);
        }
    
        public static void PRINT(string s) { PRINT(s, 0); }
    
        public static void PRINT_DETAIL(string s) { PRINT(s, 1); }
    
        public static void PRINT_DEBUG(string s) { PRINT(s, 3); }
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
    
            public void PrintOut()
            {
                System.Console.WriteLine("digraph G {");
                foreach (var pair in callers)
                    foreach (var second in pair.Value)
                        System.Console.WriteLine("\"" + pair.Key.Name + "\"->\"" + second.Name + "\";");
                System.Console.WriteLine("}");
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
    
    class Stats
    {
        public int numInlined = 0;
        public int vcSize = 0;
        public int stratNumInlined = 0;
        public int bck = 0;
        public int stacksize = 0;
        public int calls = 0;
        public long time = 0;
    
        public void print()
        {
            Console.WriteLine("--------- Stats ---------");
            Console.WriteLine("number of functions inlined: "+numInlined);
            Console.WriteLine("number of backtracking: "+bck);
            Console.WriteLine("total number of assertions in Z3 stack: " + stacksize);
            Console.WriteLine("total number of Z3 calls: "+calls);
            Console.WriteLine("total time spent in Z3: (tick) "+time);
            Console.WriteLine("-------------------------");
        }
    }
    
    
    /****************************************
    *          Stratified Inlining          *
    ****************************************/
    
    /* stratified inlining technique */
    class StratifiedInlining : StratifiedVCGenBase 
    {
    public Stats stats;

    public Dictionary<StratifiedCallSite, StratifiedVC> attachedVC;
    public Dictionary<StratifiedCallSite, StratifiedCallSite> parent;
    public Dictionary<StratifiedCallSite, StratifiedCallSite> child;

    /* results of the initial program analyses */
    private List<Procedure> assertMethods;
    private BuildCallGraph.CallGraph callGraph;
    
    /* gymnastic between Procedure, and Name */
    private Dictionary<String, Procedure> procToProc;
    
    /* main procedure (fake main) */
    private Procedure mainProc;
    
    /* map to stratified VCs (stack of VCs, as we can have several VCs for the same procedure) */
    private Dictionary<string, Stack<StratifiedVC>> implName2SVC;
    
    /* constant for BFS/DFS parametrisation -- -1 if using heuristics */
    private bool BFSDFS = false; // use the parametrisation
    private int BFSDFSConst = int.MaxValue;

    /* creates or retrieves a VC */
    public StratifiedVC getSVC(string name)
    {
        StratifiedVC vc;
        if (!implName2SVC.ContainsKey(name) || implName2SVC[name] == null || implName2SVC[name].Count <= 0)
        {
            implName2SVC[name] = new Stack<StratifiedVC>();
            vc = new StratifiedVC(implName2StratifiedInliningInfo[name]);
            implName2SVC[name].Push(vc);
        }
        else
            vc = implName2SVC[name].First();
        return vc;
    }
    
    /* creates a new VC */
    public StratifiedVC getNewSVC(string name)
    {
        StratifiedVC vc;
        if (!implName2SVC.ContainsKey(name) || implName2SVC[name] == null)
            implName2SVC[name] = new Stack<StratifiedVC>();
        vc = new StratifiedVC(implName2StratifiedInliningInfo[name]);
        implName2SVC[name].Push(vc);
        return vc;
    }
    
    /* removes a VC */
    public void removeSVC(string name)
    {
        if (implName2SVC.ContainsKey(name) && implName2SVC[name].Count > 0)
            implName2SVC[name].Pop();
    }
    
    /* computes the map for the Procedure/Name gymnastic */
    protected void ProcedureToCallSite(Program P)
    {
        // we clone the declarations list as implName2StratifiedInliningInfo updates it
        List<Declaration> declarations = new List<Declaration>(P.TopLevelDeclarations);
        foreach (Declaration decl in declarations)
#if(false)
            if (decl is Implementation)
                // TODO: initial SVC creation useless -- but we need to compensate the previous call to labsy2...
                getSVC(((Implementation) decl).Name);
            else
#endif
            if (decl is Procedure)
            {
                Procedure proc = (Procedure)decl;
                if (!procToProc.ContainsKey(proc.Name))
                    procToProc.Add(proc.Name, proc);
                else
                    procToProc[proc.Name] = proc;
            }
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
            MacroSI.PRINT("No assert detected in the methods -- use foward approach instead.");
            return;
        }
        else
        {
            MacroSI.PRINT(assertMethods.Count + " methods containing asserts detected");
            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1)
                foreach (var method in assertMethods)
                    Console.WriteLine("-> "+method.Name);
        }
    
        BuildCallGraph builder = new BuildCallGraph();
        builder.Visit(prog);
        callGraph = builder.graph; 
        ProcedureToCallSite(prog);
   
        if (CommandLineOptions.Clo.StratifiedInliningVerbose > 3)
            callGraph.PrintOut();
    }
          
    public StratifiedInlining(Program program, string logFilePath, bool appendLogFile) :
        base (program, logFilePath, appendLogFile, new List<Checker>())
    {
        stats = new Stats();
        implName2SVC = new Dictionary<string, Stack<StratifiedVC>>();

        if (cba.Util.BoogieVerify.options.useFwdBck)
        {
            procToProc = new Dictionary<string, Procedure>();
            RunInitialAnalyses(program);
        }
    
        attachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>();
        parent = new Dictionary<StratifiedCallSite, StratifiedCallSite>();
        child = new Dictionary<StratifiedCallSite, StratifiedCallSite>();
    }
    
    ~StratifiedInlining()
    {
        if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
            stats.print();
    }

    /* depth of the recursion inlined so far */
    private int MyRecursionDepth(StratifiedCallSite cs)
    {
        int i = 0;
        StratifiedCallSite iter = cs;
        while (parent.ContainsKey(iter))
        {
            iter = parent[iter]; /* previous callsite */
            if (iter.callSite.calleeName == cs.callSite.calleeName)
                i++; /* recursion */
        }
        return i;
    }

    /* depth of the recursion inlined so far */
    private int RecursionDepth(StratifiedCallSite cs, Implementation mainImpl)
    {
        int i = 0;
        StratifiedCallSite iter = cs;
        while (parent.ContainsKey(iter))
        {
            iter = parent[iter]; /* previous callsite */
            if (iter.callSite.calleeName == cs.callSite.calleeName)
                i++; /* recursion */
        }
        if (mainImpl.Name == cs.callSite.calleeName)
            i++;
        return i;
    }

    /* depth of the recursion inlined so far */
    private int RecursionDepth(StratifiedCallSite cs)
    {
        int i = 0;
        StratifiedCallSite iter = cs;
        while (child.ContainsKey(iter))
        {
            iter = child[iter]; /* previous callsite */
            if (iter.callSite.calleeName == cs.callSite.calleeName)
                i++; /* recursion */
        }
        return i;
    }

    /* for measuring Z3 stack */
    protected void Push()
    {
        stats.stacksize++;
        prover.Push();
    }

    /* for measuring Z3 stack */
    protected void Pop()
    {
        stats.stacksize--;
        prover.Pop();

    }

    public Outcome Fwd(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter, bool main)
    {
        Outcome outcome = Outcome.Inconclusive;
        var callSitesAttached = new HashSet<StratifiedCallSite>();
        var parentsAttached = new HashSet<StratifiedCallSite>();

        var boundHit = false;
        while (true)
        {
            MacroSI.PRINT_DETAIL("  - underapprox");
            boundHit = false;

            // underapproximate query
            Push();

            foreach (StratifiedCallSite cs in openCallSites)
            {
                prover.Assert(cs.callSiteExpr, false);   
            }

            MacroSI.PRINT_DETAIL("    - check");
            reporter.underapproximationMode = main;
            outcome = CheckVC(reporter);
            Pop();
            MacroSI.PRINT_DETAIL("    - checked: " + outcome);
            if (outcome != Outcome.Correct) break;

            MacroSI.PRINT_DETAIL("  - overapprox");
            // overapproximate query
            Push();
            foreach (StratifiedCallSite cs in openCallSites)
            {
                if (MyRecursionDepth(cs) == CommandLineOptions.Clo.RecursionBound)
                {
                    prover.Assert(cs.callSiteExpr, false);
                    boundHit = true;
                }
            }
            MacroSI.PRINT_DETAIL("    - check");
            reporter.underapproximationMode = false;
            reporter.callSitesToExpand = new List<StratifiedCallSite>();
            outcome = CheckVC(reporter);
            Pop();
            MacroSI.PRINT_DETAIL("    - checked: " + outcome);
            if (outcome != Outcome.Errors)
            {
                if (boundHit && outcome == Outcome.Correct)
                    outcome = Outcome.ReachedBound;

                break; // done
            }
            if (reporter.callSitesToExpand.Count == 0)
                return Outcome.Inconclusive;

            foreach (var scs in reporter.callSitesToExpand)
            {
                MacroSI.PRINT_DETAIL("    ~ extend callsite " + scs.callSite.calleeName);
                openCallSites.Remove(scs);
                stats.numInlined++;
                stats.stratNumInlined++;
                var svc = new StratifiedVC(implName2StratifiedInliningInfo[scs.callSite.calleeName]);
                //Console.WriteLine("Adding call-sites (fwd): {0}", svc.CallSites.Select(s => s.callSiteExpr.ToString()).Concat(" "));

                foreach (var newCallSite in svc.CallSites)
                {
                    openCallSites.Add(newCallSite);
                    parent[newCallSite] = scs;
                }
                var toassert =scs.Attach(svc);
                stats.vcSize += SizeComputingVisitor.ComputeSize(toassert);

                prover.Assert(toassert, true);
                attachedVC[scs] = svc;
                MustNotFail(scs, svc);
            }
        }
        return outcome;
    }

    public Outcome Bck(StratifiedVC svc, HashSet<StratifiedCallSite> openCallSites, 
        StratifiedInliningErrorReporter reporter, Dictionary<string, int> backboneRecDepth)
    {
        var outcome = Fwd(openCallSites, reporter, svc.info.impl.Name == mainProc.Name);
        if (outcome != Outcome.Errors)
            return outcome;
        if(svc.info.impl.Name == mainProc.Name)
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

            var callerVC = new StratifiedVC(implName2StratifiedInliningInfo[caller.Name]);
            backboneRecDepth[caller.Name]++;
            var callerReporter = new StratifiedInliningErrorReporter(reporter.callback, this, callerVC, callerVC.id);
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

                MacroSI.PRINT_DETAIL("    ~ bck to " + caller.Name);

                outcome = Bck(callerVC, ccs, callerReporter, backboneRecDepth);

                MacroSI.PRINT_DETAIL("    ~ bck to " + caller.Name + " Done");

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
        MacroSI.PRINT("Starting forward/backward approach...");
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

            StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[assertMethod.Name]); ;
            HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
            prover.Assert(svc.vcexpr, true);

            var reporter = new StratifiedInliningErrorReporter(callback, this, svc, svc.id);
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

            MacroSI.PRINT("No bug starting from " + assertMethod.Name + ". Selecting next method (if existing)...");
        }

        /* none of the methods containing an assert reaches successfully the main -- the program is safe */
        return boundHit ? Outcome.ReachedBound : Outcome.Correct;
    }

    void MustFail(StratifiedVC svc)
    {
        Debug.Assert(svc.info.interfaceExprVars.Exists(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed)));

        var indexFirst = svc.info.interfaceExprVars.FindIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));
        var indexLast = svc.info.interfaceExprVars.FindLastIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));

        var AssertVar = new Action<int,bool>( (index, b) =>
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

    /* verification */
    public override Outcome VerifyImplementation(Implementation impl, VerifierCallback callback)
    {
        bool oldUseLabels = CommandLineOptions.Clo.UseLabels;
        CommandLineOptions.Clo.UseLabels = false;
    
        /* the forward/backward approach can only be applied for programs with asserts in calls
        * and single-threaded (multi-threaded programs contain a final assert in the main).
        * Otherwise, use forward approach */
        if (cba.Util.BoogieVerify.options.useFwdBck && assertMethods.Count > 0)
        {
            // assert true to flush all one-time axioms, decls, etc
            prover.Assert(VCExpressionGenerator.True, true);

            //var ret = VerifyImplementationFwdBck(impl, callback);
            var ret = FwdBckVerify(impl, callback);
            CommandLineOptions.Clo.UseLabels = oldUseLabels;
            return ret;
        }
    
        MacroSI.PRINT("Starting forward approach...");
    
        CommandLineOptions.Clo.UseLabels = false;
        Push();
    
        StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[impl.Name]); ;
        HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
        prover.Assert(svc.vcexpr, true);
    
        Outcome outcome;
        var reporter = new StratifiedInliningErrorReporter(callback, this, svc);
    
        /* 
        // Eager inlining (works only for hierarchical programs)
        HashSet<StratifiedCallSite> nextOpenCallSites;
        while (openCallSites.Count != 0) {
        nextOpenCallSites = new HashSet<StratifiedCallSite>();
        foreach (StratifiedCallSite scs in openCallSites) {
            svc = new StratifiedVC(implName2StratifiedInliningInfo[scs.callSite.calleeName]);
            foreach (var newCallSite in svc.CallSites) {
            nextOpenCallSites.Add(newCallSite);
            }
            prover.Assert(scs.Attach(svc), true);
            attachedVC[scs] = svc;
        }
        openCallSites = nextOpenCallSites;
        }
    
        reporter.underapproximationMode = true;
        outcome = CheckVC(reporter);
        */
          
        int currRecursionBound = 1;
        var boundHit = false;
        while (true)
        {
            boundHit = false;
            MacroSI.PRINT_DETAIL("  - underapprox");
            // underapproximate query
            Push();

            foreach (StratifiedCallSite cs in openCallSites)
            {
                prover.Assert(cs.callSiteExpr, false);
            }
            MacroSI.PRINT_DETAIL("    - check");
            reporter.underapproximationMode = true;
            outcome = CheckVC(reporter);
            Pop();
            MacroSI.PRINT_DETAIL("    - checked: " + outcome);
            if (outcome != Outcome.Correct) break;

            MacroSI.PRINT_DETAIL("  - overapprox");
            // overapproximate query
            Push();
            foreach (StratifiedCallSite cs in openCallSites)
            {
                if (RecursionDepth(cs, impl) == currRecursionBound)
                {
                    prover.Assert(cs.callSiteExpr, false);
                    boundHit = true;
                }
            }
            MacroSI.PRINT_DETAIL("    - check");
            reporter.underapproximationMode = false;
            reporter.callSitesToExpand = new List<StratifiedCallSite>();
            outcome = CheckVC(reporter);
            Pop();
            MacroSI.PRINT_DETAIL("    - checked: " + outcome);
            if (outcome != Outcome.Errors)
            {
                if (outcome != Outcome.Correct) break;
                if (boundHit) outcome = Outcome.ReachedBound;
                if (currRecursionBound == CommandLineOptions.Clo.RecursionBound) break;
                currRecursionBound++;
            }
            foreach (var scs in reporter.callSitesToExpand)
            {
                MacroSI.PRINT_DETAIL("    ~ extend callsite " + scs.callSite.calleeName);
                openCallSites.Remove(scs);
                stats.numInlined++;
                stats.stratNumInlined++;
                svc = new StratifiedVC(implName2StratifiedInliningInfo[scs.callSite.calleeName]);
                foreach (var newCallSite in svc.CallSites)
                {
                    openCallSites.Add(newCallSite);
                    parent[newCallSite] = scs;
                }
                var toassert = scs.Attach(svc);
                stats.vcSize += SizeComputingVisitor.ComputeSize(toassert);

                prover.Assert(toassert, true);
                attachedVC[scs] = svc;
            }
        }
    
        Pop(); 
        CommandLineOptions.Clo.UseLabels = oldUseLabels;
        return outcome;
    }
    
    /* with backward/forward approach */
    public Outcome VerifyImplementationFwdBck(Implementation impl, VerifierCallback callback)
    {
        MacroSI.PRINT("Starting forward/backward approach...");
        Outcome outcome = Outcome.Correct;
        /* is there a method with assert leading to a real counter-example? */
        foreach (Procedure assertMethod in assertMethods)
        {
            /* if the method is not in the call-graph, it is the fake main initially added */
            if (!callGraph.callers.ContainsKey(assertMethod))
                continue;   

            Push();

            StratifiedVC svc = getSVC(assertMethod.Name);
            HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
            outcome = ForwardVerify(impl, assertMethod.Name, callback, 1, svc, openCallSites, new HashSet<StratifiedCallSite>());

            /* a bug is found */
            if (outcome == Outcome.Errors)
                return outcome;

            MacroSI.PRINT("No bug starting from " + assertMethod.Name + ". Selecting next method (if existing)...");
        }
    
        /* none of the methods containing an assert reaches successfully the main -- the program is safe */
        return Outcome.Correct;
    }
    
    /* forward: original Corral stratified inlining, adapted to local (non Main) reasoning */
    protected Outcome ForwardVerify(
        Implementation impl /*only passed for the depth*/, 
        string method, 
        VerifierCallback callback,
        int currRecursionBound, 
        StratifiedVC svc, 
        HashSet<StratifiedCallSite> originalOpenCallSites,
        HashSet<StratifiedCallSite> originalVisitedCallSites)
    {
        /* local copies */
        HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(originalOpenCallSites);
        /* callsites inlined in the current exploration */
        HashSet<StratifiedCallSite> visitedCallSites = new HashSet<StratifiedCallSite>(originalVisitedCallSites);

        /* for SVCs removal */
        HashSet<StratifiedCallSite> locallyVisitedCallSites = new HashSet<StratifiedCallSite>();

        /* decision table:
         * ---------------
         * 
         *              this \ bwd  |    SAT    |   UNSAT
         * -------------------------------------------------
         * underapprox    SAT       |   BUG     | extend CS
         *               UNSAT      |    X      | extend CS
         * -------------------------------------------------
         *  overapprox    SAT       | extend CS |   SAFE
         *               UNSAT      |    X      |   SAFE
         *               
         *  "this" means the result of the verification of this function (and the functions inlined) in the
         *  under-approximation and over-approximation phases. "bwd" refers to the backward call which aims
         *  at finding a feasible context (i.e., a path starting from the main) to inline the current method, 
         *  with its current inlined functions attached.
         */

        /* adds assertsPassed at the end of the VC for local test */
        if (svc.info.interfaceExprVars.Exists(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed)))
        {
            var index = svc.info.interfaceExprVars.FindLastIndex(x => x.Name.Contains(cba.Util.BoogieVerify.assertsPassed));
            if (cba.Util.BoogieVerify.assertsPassedIsInt)
            {
                Microsoft.Basetypes.BigNum zero = Microsoft.Basetypes.BigNum.FromInt(0);
                prover.Assert(prover.VCExprGen.Eq(svc.interfaceExprVars[index], prover.VCExprGen.Integer(zero)), false);
            }
            else
                prover.Assert(svc.interfaceExprVars[index], false);
        }
    
        MacroSI.PRINT_DETAIL("+ fwd in " + method); 
        prover.Assert(svc.vcexpr, true);
    
        Outcome outcome;
        var reporter = new StratifiedInliningErrorReporter(callback, this, svc, svc.id);
        Outcome ret = Outcome.Errors;
    
        while (true)
        {
            MacroSI.PRINT_DETAIL("  - underapprox in "+method);
            /* underapproximate query */
            Push(); 
    
            foreach (StratifiedCallSite cs in openCallSites)
            {
                prover.Assert(cs.callSiteExpr, false);
                visitedCallSites.Add(cs);
                //Console.WriteLine("closing callsite: "+cs.callSite.calleeName+"@"+cs.callSite.callSiteVar);
            }
            reporter.underapproximationMode = false;
            MacroSI.PRINT_DETAIL("    - check");
            outcome = CheckVC(reporter);
            Pop(); 
    
            MacroSI.PRINT_DETAIL("    - checked: "+outcome);
            if (outcome != Outcome.Correct)
            {
                /* checks all the callers */
                ret = BackwardVerify(impl, callGraph.callers[procToProc[method]], callback,
                        currRecursionBound, method, svc, visitedCallSites, openCallSites);

                if (ret != Outcome.Correct)
                {
                    foreach (var cs in locallyVisitedCallSites)
                        removeSVC(cs.callSite.calleeName);
                    return ret;
                }
            }

            foreach (StratifiedCallSite cs in openCallSites)
            {
                visitedCallSites.Remove(cs);
            }
            MacroSI.PRINT_DETAIL("  - overapprox in " + method);
            /* overapproximate query */
            Push(); 
    
            foreach (StratifiedCallSite cs in openCallSites)
            {
                if (RecursionDepth(cs, impl) == currRecursionBound)
                    prover.Assert(cs.callSiteExpr, false);
            }
            reporter.underapproximationMode = false;
            reporter.callSitesToExpand = new List<StratifiedCallSite>();
            MacroSI.PRINT_DETAIL("    - check");
            outcome = CheckVC(reporter);

            Pop(); 
            MacroSI.PRINT_DETAIL("    - checked: "+outcome);
            if (outcome != Outcome.Errors)
            {
                if (outcome != Outcome.Correct) break;
                if (currRecursionBound >= CommandLineOptions.Clo.RecursionBound) break;
                currRecursionBound++;
            }

            if (reporter.callSitesToExpand.Count <= 0 && (ret == Outcome.Correct || outcome == Outcome.Correct))
            {
                if (currRecursionBound >= CommandLineOptions.Clo.RecursionBound)
                {
                    foreach (var cs in locallyVisitedCallSites)
                        removeSVC(cs.callSite.calleeName);

                    MacroSI.PRINT_DEBUG("no more callsites to inline or no satisfiable context for this method");
                    return Outcome.Correct;
                }
                currRecursionBound++;
            }

            /* only for parametrisation */
            if (BFSDFS)
            {
                if (reporter.callSitesToExpand.Any(x => !openCallSites.Contains(x)))
                {
                    foreach (var cs in locallyVisitedCallSites)
                        removeSVC(cs.callSite.calleeName);

                    return Outcome.Correct;
                }
            }

            /* extends the necessary call-sites */
            foreach (var scs in reporter.callSitesToExpand)
            {
                openCallSites.Remove(scs);
    
                stats.numInlined++;
                stats.stratNumInlined++;
                visitedCallSites.Add(scs);
                locallyVisitedCallSites.Add(scs);
                MacroSI.PRINT_DETAIL("    ~ extend callsite " + scs.callSite.calleeName + "@" + scs.callSite.callSiteVar);
                var localVC = getNewSVC(scs.callSite.calleeName);
                foreach (var newCallSite in localVC.CallSites)
                {
                    if (visitedCallSites.Contains(newCallSite))
                        continue;
                    //Console.WriteLine("new callsite: " + newCallSite.callSite.calleeName);
                    openCallSites.Add(newCallSite);
                    parent[newCallSite] = scs;
                    child[scs] = newCallSite;
                }
                prover.Assert(scs.Attach(localVC), true);
                attachedVC[scs] = localVC;
            }
        }
    
        foreach (var cs in locallyVisitedCallSites)
            removeSVC(cs.callSite.calleeName);
    
        /* no real bug found from the main to this function below the recursion threshold */
        return outcome;
    }
    
    /* in the context of several calls to a same function in the same function, distinguishes them */
    private static bool isCallee(StratifiedCallSite callee, StratifiedCallSite cs)
    {
        return (callee.callSite.calleeName == cs.callSite.calleeName 
            && callee.callSite.callSiteVar.Name == cs.callSite.callSiteVar.Name);
    }
    
    /* backward: goes backward in the callgraph */
    protected Outcome BackwardVerify(Implementation impl/*only passed for the depth*/, 
        List<Procedure> setOfCallers, 
        VerifierCallback callback,
        int currRecursionBound, 
        string callee, 
        StratifiedVC vcCallee, 
        HashSet<StratifiedCallSite> originalVisitedCallSites,
        HashSet<StratifiedCallSite> aboveOpenCallSites)
    {
        /* local copy */
        HashSet<StratifiedCallSite> visitedCallSites = new HashSet<StratifiedCallSite>(originalVisitedCallSites);

        /* not reachable from main */
        if (setOfCallers.Count <= 0)
        {
            MacroSI.PRINT_DETAIL("no more callers");
            return Outcome.Correct;
        }

        stats.bck++;
        Outcome outcome = Outcome.Correct;
        Push();

        foreach (Procedure setOfCS in setOfCallers)
        {
            Push();

            if (setOfCS.Name == mainProc.Name)
            {
                foreach (var cs in getSVC(setOfCS.Name).CallSites)
                {
                    if (cs.callSite.calleeName != callee)
                        continue;

                    StratifiedCallSite callee_cs = cs;

                    /* callee == real main in the code */
                    MacroSI.PRINT_DETAIL("+ from " + callee + ", bwd to " + mainProc.Name);

                    /* inline the main in the fake main: */
                    /* gets a VC for the implementation of the fake main and main */
                    StratifiedVC fakeMain = getSVC(mainProc.Name);
                    StratifiedVC mainVC = vcCallee;

                    prover.Assert(AttachByEquality(callee_cs, mainVC), true);
                    attachedVC[callee_cs] = mainVC;
                    /* to claim that we consider (in the path) this very callsite */
                    prover.Assert(callee_cs.callSiteExpr, true);

                    MacroSI.PRINT_DETAIL("+ fwd in " + mainProc);
                    prover.Assert(fakeMain.vcexpr, true);

                    var reporter = new StratifiedInliningErrorReporter(callback, this, fakeMain, fakeMain.id);
                    MacroSI.PRINT_DETAIL("  - underapprox");
                    /* underapproximate query */
                    reporter.underapproximationMode = true;
                    MacroSI.PRINT_DETAIL("    - check");
                    outcome = CheckVC(reporter);
                    MacroSI.PRINT_DETAIL("    - checked: " + outcome);

                    /* fakeMain just inlines main -- if we have a bug in main, then we also have one in the whole impl */
                    Debug.Assert(Outcome.Errors == outcome);
                    return Outcome.Errors;
                }
            }
                
            /* if this method is not the main neither called, then it is safe */
            if (!callGraph.callers.ContainsKey(setOfCS))
            {
                Pop();
                continue;
            }

            /* picks a caller and a callsite for backward call-graph exploration */
            foreach (var parentSetOfCS in callGraph.callers[setOfCS])
                foreach (StratifiedCallSite method in getSVC(parentSetOfCS.Name).CallSites)
                {
                    if (method.callSite.calleeName != setOfCS.Name)
                        continue;
    
                    foreach (var cs in getSVC(setOfCS.Name).CallSites)
                    {
                        if (cs.callSite.calleeName != callee)
                          continue;

                        /* recursion bound */
                        if (RecursionDepth(cs) >= CommandLineOptions.Clo.RecursionBound)
                            continue;

                        StratifiedCallSite callee_cs = cs;
                        MacroSI.PRINT_DETAIL("+ from " + callee +"@" + callee_cs.callSite.callSiteVar + ", bwd to " + method.callSite.calleeName);

                        /* inline method in the caller: */
                        /* gets a VC for the implementation of the method currently considered */
                        StratifiedVC previousSvc = getSVC(method.callSite.calleeName);
                        StratifiedVC svc = getNewSVC(method.callSite.calleeName);
                        HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);

                        /* we get the corresponding callee in a copy of the VC */
                        visitedCallSites.Remove(callee_cs);
                        callee_cs = getCorrespondingCallSite(callee_cs, previousSvc, svc);
                        visitedCallSites.Add(callee_cs);

                        /* removes the callee (previous method) before attaching VCs */
                        openCallSites.Remove(callee_cs);
    
                        /* DFS/BFS parametrisation (default: DFS)
                         * --------------------------------------
                         * + DFS: During an overapproximation, a callsite from a previously visited method can be inlined.
                         * If we backtrack, the knowledge of the method inlined is lost.
                         * + BFS: During an overapproximation, a callsite from a previously visited method cannot be inlined.
                         * If it needs to, there will be a backtrack up to the method containing this callsite.
                         * In practice, if callsitesToExtend not included in openCallsites, backtrack.
                         * 
                         * DFS and BFS can be combined. When to apply BFS? For methods with more than N potential calls.
                         * (whole DFS: N=+inf; whole BFS: N=0)
                         * (We take here N=#method.callsites, but we can imagine some more avanced heuristics involving more constants)
                         */
                        if (BFSDFS)
                        {
                            int N;
                            if (BFSDFSConst >= 0)
                                N = BFSDFSConst;
                            else
                                N = vcCallee.CallSites.Count;

                            if (callGraph.callers[procToProc[vcCallee.info.function.Name]].Count <= N)
                            {
                                /* adds callees' *open*-callsites to method's callsite */
                                foreach (var newCallSite in aboveOpenCallSites/*vcCallee.CallSites -- has access to all the open callsites above*/)
                                {
                                    /* already visited callsites are not open */
                                    if (visitedCallSites.Contains(newCallSite))
                                        continue;
                                    openCallSites.Add(newCallSite);
                                }
                            }
                        }
                        else 
                            /* adds callees' *open*-callsites to method's callsite (and the others above) */
                            foreach (var newCallSite in aboveOpenCallSites/*vcCallee.CallSites*/)
                            {
                                /* already visited callsites are not open */
                                if (visitedCallSites.Contains(newCallSite))
                                    continue;
                                openCallSites.Add(newCallSite);
                            }

                        /* to propagate the parent/child maps */
                        foreach (var oldCallSite in vcCallee.CallSites)
                            if (visitedCallSites.Contains(oldCallSite))
                            {
                                parent[oldCallSite] = callee_cs;
                                child[callee_cs] = oldCallSite;
                            }

                        prover.Assert(AttachByEquality(callee_cs, vcCallee), true);
                        attachedVC[callee_cs] = vcCallee;
                        /* to claim that we consider (in the path) this very callsite */
                        prover.Assert(callee_cs.callSiteExpr, true);

                        /* recursion bound would be reached if backtracking to this method */
                        outcome = ForwardVerify(impl, method.callSite.calleeName, callback, currRecursionBound,
                             svc, openCallSites, visitedCallSites);

                        /* removes callees' *open*-callsites to method's callsite */
                        foreach (var newCallSite in vcCallee.CallSites)
                        {
                            openCallSites.Remove(newCallSite);
                        }

                        /* restores the parent/child maps of before we tried to backtrack (and inline) this function */
                        foreach (var oldCallSite in vcCallee.CallSites)
                            if (visitedCallSites.Contains(oldCallSite))
                            {
                                parent.Remove(oldCallSite);
                                child.Remove(callee_cs);
                            }

                        removeSVC(method.callSite.calleeName);
    
                        /* we found a reachable bug */
                        if (outcome == Outcome.Errors)
                            return outcome;
    
                        Pop();
                    }
                }
        }
    
        /* this function doesn't lead to a real bug from Main */
        return Outcome.Correct;
    }
    
    /* returns the call-site in the copy of the VC which corresponds to the call-site in the original VC */
    protected StratifiedCallSite getCorrespondingCallSite(StratifiedCallSite callee, StratifiedVC svcCaller, StratifiedVC copy)
    {
        int eq = 0;
        for (eq = 0; eq < svcCaller.CallSites.Count && !isCallee(svcCaller.CallSites[eq],callee); ++eq);
        Debug.Assert(svcCaller.CallSites.Count != eq);
        return copy.CallSites[eq];
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
    
        for (int i=0; i<svcCallee.interfaceExprVars.Count; i++)
        {
            /* interface variables */
            VCExpr equality = gen.Eq(svcCallee.interfaceExprVars[i], callee.interfaceExprs[i]);
            conjunction = gen.And(equality, conjunction);
        }
    
        return conjunction;
    }
    
    private Outcome CheckVC(ProverInterface.ErrorHandler reporter) {
        stats.calls++;
        var stopwatch = Stopwatch.StartNew();
        prover.Check();
        stats.time += stopwatch.ElapsedTicks;
        ProverInterface.Outcome outcome = prover.CheckOutcomeCore(reporter);
        return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
    }
    
    public override Outcome FindLeastToVerify(Implementation impl, ref HashSet<string> allBoolVars) {
        bool oldUseLabels = CommandLineOptions.Clo.UseLabels;
        CommandLineOptions.Clo.UseLabels = false;
        Push(); 
    
        StratifiedVC svc = getSVC(impl.Name);
        HashSet<StratifiedCallSite> openCallSites = new HashSet<StratifiedCallSite>(svc.CallSites);
        prover.Assert(svc.vcexpr, true);
    
        HashSet<StratifiedCallSite> nextOpenCallSites;
        while (openCallSites.Count != 0) {
            nextOpenCallSites = new HashSet<StratifiedCallSite>();
            foreach (StratifiedCallSite scs in openCallSites) {
                svc = getSVC(scs.callSite.calleeName);
                foreach (var newCallSite in svc.CallSites) {
                    nextOpenCallSites.Add(newCallSite);
                }
            prover.Assert(scs.Attach(svc), true);
        }
        openCallSites = nextOpenCallSites;
        }
    
        // Find all the boolean constants
        var allConsts = new HashSet<VCExprVar>();
        foreach (var decl in program.TopLevelDeclarations) {
            var constant = decl as Constant;
            if (constant == null) continue;
            if (!allBoolVars.Contains(constant.Name)) continue;
            var v = prover.Context.BoogieExprTranslator.LookupVariable(constant);
            allConsts.Add(v);
        }
    
        // Now, lets start the algo
        var min = refinementLoop(new EmptyErrorReporter(), new HashSet<VCExprVar>(), allConsts, allConsts);
    
        var ret = new HashSet<string>();
        foreach (var v in min) {
            ret.Add(v.Name);
        }
        allBoolVars = ret;
    
        Pop(); 
        CommandLineOptions.Clo.UseLabels = oldUseLabels;
        return Outcome.Correct;
    }
    
    private HashSet<VCExprVar> refinementLoop(ProverInterface.ErrorHandler reporter, HashSet<VCExprVar> trackedVars, HashSet<VCExprVar> trackedVarsUpperBound, HashSet<VCExprVar> allVars) {
        Debug.Assert(trackedVars.IsSubsetOf(trackedVarsUpperBound));
    
        // If we already know the fate of all vars, then we're done.
        if (trackedVars.Count == trackedVarsUpperBound.Count)
            return new HashSet<VCExprVar>(trackedVars);
    
        // See if we already have enough variables tracked
        var success = refinementLoopCheckPath(reporter, trackedVars, allVars);
        if (success) {
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
    
    private bool refinementLoopCheckPath(ProverInterface.ErrorHandler reporter, HashSet<VCExprVar> varsToSet, HashSet<VCExprVar> allVars) {
        var assumptions = new List<VCExpr>();
        var query = new HashSet<string>();
        varsToSet.Iter(v => query.Add(v.Name));
    
        prover.LogComment("FindLeast: Query Begin");
    
        foreach (var c in allVars) {
        if (varsToSet.Contains(c)) {
            assumptions.Add(c);
        }
        else {
            assumptions.Add(prover.VCExprGen.Not(c));
        }
        }
    
        var o = CheckAssumptions(reporter, assumptions);
        Debug.Assert(o == Outcome.Correct || o == Outcome.Errors);
        prover.LogComment("FindLeast: Query End");
    
        return (o == Outcome.Correct);
    }
    
    private Outcome CheckAssumptions(ProverInterface.ErrorHandler reporter, List<VCExpr> assumptions) {
        if (assumptions.Count == 0) {
        return CheckVC(reporter);
        }
    
        Push(); 
        foreach (var a in assumptions) {
        prover.Assert(a, true);
        }
        Outcome ret = CheckVC(reporter);
        Pop(); 
        return ret;
    }
    
    private static void Partition<T>(HashSet<T> values, out HashSet<T> part1, out HashSet<T> part2) {
        part1 = new HashSet<T>();
        part2 = new HashSet<T>();
        var size = values.Count;
        var crossed = false;
        var curr = 0;
        foreach (var s in values) {
        if (crossed) part2.Add(s);
        else part1.Add(s);
        curr++;
        if (!crossed && curr >= size / 2) crossed = true;
        }
    }
    }


    /****************************************
    *      Counter-example Generation       *
    ****************************************/

    class EmptyErrorReporter : ProverInterface.ErrorHandler {
    public override void OnModel(IList<string> labels, Model model) { }
    }
    
    class StratifiedInliningErrorReporter : ProverInterface.ErrorHandler {
    StratifiedInlining si;
    public VerifierCallback callback;
    StratifiedVC mainVC;
    /* (dynamic) id of the method the closest to top-level */
    public int basis;
    public static TimeSpan ttime = TimeSpan.Zero; 
    public bool underapproximationMode;
    public List<StratifiedCallSite> callSitesToExpand;
    List<Tuple<int, int>> orderedStateIds;
    
    public StratifiedInliningErrorReporter(VerifierCallback callback, StratifiedInlining si, StratifiedVC mainVC) {
        this.callback = callback;
        this.si = si;
        this.mainVC = mainVC;
        this.underapproximationMode = false;
        this.basis = 0;
    }
    
    public StratifiedInliningErrorReporter(VerifierCallback callback, StratifiedInlining si, StratifiedVC mainVC, int methodId)
    {
        this.callback = callback;
        this.si = si;
        this.mainVC = mainVC;
        this.underapproximationMode = false;
        this.basis = methodId;
    }
    
    public override int StartingProcId()
    {
        return basis;
    }
    
    private Absy Label2Absy(string procName, string label) {
        int id = int.Parse(label);
        var l2a = si.implName2StratifiedInliningInfo[procName].label2absy;
        return (Absy)l2a[id];
    }
    
    public override void OnModel(IList<string> labels, Model model) {
        var start = DateTime.Now;
        List<Absy> absyList = new List<Absy>();
        foreach (var label in labels) {
            absyList.Add(Label2Absy(mainVC.info.impl.Name, label));
        }
    
        orderedStateIds = new List<Tuple<int, int>>();
    
        var cex = NewTrace(mainVC, absyList, model);
        //cex.PrintModel();
    
        if (CommandLineOptions.Clo.StratifiedInliningVerbose > 2)
        cex.Print(6, Console.Out);
    
        if (underapproximationMode && cex != null) {
            callback.OnCounterexample(cex, null);
            //this.PrintModel(model);
        }
        ttime += (DateTime.Now - start);
    }
    
    private Counterexample NewTrace(StratifiedVC svc, List<Absy> absyList, Model model) {
        // assume that the assertion is in the last place??
        AssertCmd assertCmd = (AssertCmd)absyList[absyList.Count - 1];
        List<Block> trace = new List<Block>();
        var calleeCounterexamples = new Dictionary<TraceLocation, CalleeCounterexampleInfo>();
        for (int j = 0; j < absyList.Count - 1; j++) {
        Block b = (Block)absyList[j];
        trace.Add(b);
        if (svc.callSites.ContainsKey(b)) {
            foreach (StratifiedCallSite scs in svc.callSites[b]) {
            if (!si.attachedVC.ContainsKey(scs)) {
                if (callSitesToExpand == null)
                    callSitesToExpand = new List<StratifiedCallSite>();
    
                callSitesToExpand.Add(scs);
            }
            else {
                string[] labels = si.prover.CalculatePath(si.attachedVC[scs].id);
                List<Absy> calleeAbsyList = new List<Absy>();
                foreach (string label in labels) {
                    calleeAbsyList.Add(Label2Absy(scs.callSite.calleeName, label));
                }
                var calleeCounterexample = NewTrace(si.attachedVC[scs], calleeAbsyList, model);
                calleeCounterexamples[new TraceLocation(trace.Count - 1, scs.callSite.numInstr)] =
                new CalleeCounterexampleInfo(calleeCounterexample, new List<object>());
            }
            }
        }
        if (svc.recordProcCallSites.ContainsKey(b) && (model != null || CommandLineOptions.Clo.UseProverEvaluate))
        {
            foreach (StratifiedCallSite scs in svc.recordProcCallSites[b]) {
            var args = new List<object>();
            foreach (VCExpr expr in scs.interfaceExprs) {
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
                            args.Add(f.GetConstant());
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
    }
}
