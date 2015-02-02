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

namespace CoreLib
{
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

    /* stratified inlining technique */
    class StratifiedInlining : StratifiedVCGenBase
    {
        public Stats stats;

        /* call-site to VC map -- used for trace construction */
        public Dictionary<StratifiedCallSite, StratifiedVC> attachedVC;

        /*  Parent linking -- used only for computing the recursion depth */
        public Dictionary<StratifiedCallSite, StratifiedCallSite> parent;

        // Set of implementations
        HashSet<string> implementations;

        /* results of the initial program analyses */
        private List<Procedure> assertMethods;
        private BuildCallGraph.CallGraph callGraph;

        /* main procedure (fake main) */
        private Procedure mainProc;

        /* map to stratified VCs (stack of VCs, as we can have several VCs for the same procedure) */
        private Dictionary<string, Stack<StratifiedVC>> implName2SVC;

        /* Call Tree after VerifyImplementation */
        private HashSet<string> CallTree;

        public HashSet<string> GetCallTree()
        {
            return CallTree;
        }

        /* creates or retrieves a VC */
        public StratifiedVC getSVC(string name)
        {
            StratifiedVC vc;
            if (!implName2SVC.ContainsKey(name) || implName2SVC[name] == null || implName2SVC[name].Count <= 0)
            {
                implName2SVC[name] = new Stack<StratifiedVC>();
                vc = new StratifiedVC(implName2StratifiedInliningInfo[name], implementations);
                implName2SVC[name].Push(vc);
            }
            else
                vc = implName2SVC[name].First();
            return vc;
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
                        Console.WriteLine("-> " + method.Name);
            }

            BuildCallGraph builder = new BuildCallGraph();
            builder.Visit(prog);
            callGraph = builder.graph;

            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 3)
                callGraph.PrintOut();
        }

        public StratifiedInlining(Program program, string logFilePath, bool appendLogFile) :
            base(program, logFilePath, appendLogFile, new List<Checker>())
        {
            stats = new Stats();
            implName2SVC = new Dictionary<string, Stack<StratifiedVC>>();

            if (cba.Util.BoogieVerify.options.useFwdBck)
            {
                RunInitialAnalyses(program);
            }

            attachedVC = new Dictionary<StratifiedCallSite, StratifiedVC>();
            parent = new Dictionary<StratifiedCallSite, StratifiedCallSite>();
            implementations = new HashSet<string>(implName2StratifiedInliningInfo.Keys);
        }

        ~StratifiedInlining()
        {
            if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                stats.print();
        }

        /* depth in the call tree */
        private int StackDepth(StratifiedCallSite cs)
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
        private int RecursionDepth(StratifiedCallSite cs)
        {
            int i = 1;
            StratifiedCallSite iter = cs;
            while (parent.ContainsKey(iter))
            {
                iter = parent[iter]; /* previous callsite */
                if (iter.callSite.calleeName == cs.callSite.calleeName)
                    i++; /* recursion */
            }

            // Usual
            if (!cba.Util.BoogieVerify.options.extraRecBound.ContainsKey(cs.callSite.calleeName))
                return i;

            // Usual
            if (i <= CommandLineOptions.Clo.RecursionBound)
                return i;

            // Support extraRecBound
            // If RecBound = 1 and extraRecBound is 2 then if actual recursion depth
            // is 1 or 2 or 3, we still return 1. Otherwise we return (actual-extra)
            if (i > CommandLineOptions.Clo.RecursionBound &&
                i <= CommandLineOptions.Clo.RecursionBound + cba.Util.BoogieVerify.options.extraRecBound[cs.callSite.calleeName])
                return CommandLineOptions.Clo.RecursionBound;

            // Support extraRecBound
            return i - cba.Util.BoogieVerify.options.extraRecBound[cs.callSite.calleeName];
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

        // Does not make under-approx queries; doesn't do push/pop
        public Outcome FwdNoUnder(HashSet<StratifiedCallSite> openCallSites, StratifiedInliningErrorReporter reporter)
        {
            Outcome outcome = Outcome.Inconclusive;
            reporter.reportTraceIfNothingToExpand = true;

            // candidates that are pinned to false because they hit the recursion bound
            var boundAsserted = new HashSet<StratifiedCallSite>();

            while (true)
            {
                MacroSI.PRINT_DETAIL("  - overapprox");

                // overapproximate query
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (RecursionDepth(cs) > CommandLineOptions.Clo.RecursionBound ||
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
                MacroSI.PRINT_DETAIL("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);

                MacroSI.PRINT_DETAIL("    - checked: " + outcome);
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
                    openCallSites.UnionWith(svc.CallSites);
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
                MacroSI.PRINT_DETAIL("  - overapprox");
                // overapproximate query
                
                MacroSI.PRINT_DETAIL("    - check");
                reporter.callSitesToExpand = new List<StratifiedCallSite>();
                outcome = CheckVC(reporter);
                
                MacroSI.PRINT_DETAIL("    - checked: " + outcome);

                // timeout?
                if (outcome != Outcome.Errors && outcome != Outcome.Correct)
                {
                    Pop(); 
                    break;
                }

                if (outcome == Outcome.Correct)
                {                    
                    if(decisions.Count == 0)
                    {
                        if(boundHit) outcome = Outcome.ReachedBound;
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

                    for(int i = 0; i < summaries.Count; i++)
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
                    var svc = Expand(scs, name, false);

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
                reporter.reportTrace = main;
                outcome = CheckVC(reporter);
                Pop();
                MacroSI.PRINT_DETAIL("    - checked: " + outcome);
                if (outcome != Outcome.Correct) break;

                MacroSI.PRINT_DETAIL("  - overapprox");
                // overapproximate query
                Push();
                foreach (StratifiedCallSite cs in openCallSites)
                {
                    // Stop if we've reached the recursion bound or
                    // the stack-depth bound (if there is one)
                    if (RecursionDepth(cs) > recBound ||
                        (CommandLineOptions.Clo.StackDepthBound > 0 &&
                        StackDepth(cs) > CommandLineOptions.Clo.StackDepthBound))
                    {
                        prover.Assert(cs.callSiteExpr, false);
                        boundHit = true;
                    }
                }
                MacroSI.PRINT_DETAIL("    - check");
                reporter.reportTrace = false;
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
                    openCallSites.Remove(scs);
                    var svc = Expand(scs);
                    openCallSites.UnionWith(svc.CallSites);

                    if (cba.Util.BoogieVerify.options.useFwdBck) MustNotFail(scs, svc);
                }
            }
            return outcome;
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

        /* verification */
        public override Outcome VerifyImplementation(Implementation impl, VerifierCallback callback)
        {
            // Sanity checking
            if (cba.Util.BoogieVerify.options.procsToSkip.Count != 0)
            {
                Console.WriteLine("Warning: newSI doesn't support procedure skipping");
            }
            if (cba.Util.BoogieVerify.options.NonUniformUnfolding)
            {
                Console.WriteLine("Warning: newSI doesn't support non-uniform procedure inlining");
            }

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

            MacroSI.PRINT("Starting forward approach...");

            Push();

            StratifiedVC svc = new StratifiedVC(implName2StratifiedInliningInfo[impl.Name], implementations); ;
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
                    if (RecursionDepth(scs) > CommandLineOptions.Clo.RecursionBound) continue;

                    var ss = Expand(scs);
                    nextOpenCallSites.UnionWith(ss.CallSites);
                }
                openCallSites = nextOpenCallSites;
            }
            #endregion

            #region Repopulate Call Tree
            if (cba.Util.BoogieVerify.options.CallTree != null)
            {
                while(true)
                {
                    var toAdd = new HashSet<StratifiedCallSite>();
                    var toRemove = new HashSet<StratifiedCallSite>();
                    foreach (StratifiedCallSite scs in openCallSites)
                    {
                        if(!cba.Util.BoogieVerify.options.CallTree.Contains(GetPersistentID(scs))) continue;
                        toRemove.Add(scs);
                        var ss = Expand(scs);
                        toAdd.UnionWith(ss.CallSites);
                        MacroSI.PRINT(string.Format("Eagerly inlining: {0}", scs.callSite.calleeName), 2);
                    }
                    openCallSites.ExceptWith(toRemove);
                    openCallSites.UnionWith(toAdd);
                    if (toRemove.Count == 0) break;
                } 
            }
            #endregion
            
            // Stratified Search
            if (cba.Util.BoogieVerify.options.newStratifiedInliningAlgo.ToLower() == "nounder")
            {
                outcome = FwdNoUnder(openCallSites, reporter);
            }
            else
            {
                int currRecursionBound = 1;
                while (true)
                {
                    outcome = Fwd(openCallSites, reporter, true, currRecursionBound);

                    // timeout?
                    if (outcome == Outcome.Inconclusive || outcome == Outcome.OutOfMemory || outcome == Outcome.TimedOut)
                        break;

                    // reached bound?
                    if (outcome == Outcome.ReachedBound && currRecursionBound < CommandLineOptions.Clo.RecursionBound)
                    {
                        currRecursionBound++;
                        continue;
                    }

                    // outcome is either ReachedBound with currRecBound == Max or
                    // Errors or Correct
                    break;
                }
            }

            Pop();
            
            #region Stash call tree
            if (cba.Util.BoogieVerify.options.CallTree != null)
            {
                CallTree = new HashSet<string>();
                var callsites = new HashSet<StratifiedCallSite>();
                callsites.UnionWith(parent.Keys);
                callsites.UnionWith(parent.Values);
                callsites.ExceptWith(openCallSites);
                callsites.Iter(scs => CallTree.Add(GetPersistentID(scs)));
            }
            #endregion
            
            return outcome;
        }


        // Inline
        private StratifiedVC Expand(StratifiedCallSite scs)
        {
            return Expand(scs, null, true);
        }

        private StratifiedVC Expand(StratifiedCallSite scs, string name, bool DoSubst)
        {
            MacroSI.PRINT_DETAIL("    ~ extend callsite " + scs.callSite.calleeName);
            stats.numInlined++;
            stats.stratNumInlined++;
            var svc = new StratifiedVC(implName2StratifiedInliningInfo[scs.callSite.calleeName], implementations);
            foreach (var newCallSite in svc.CallSites)
            {
                parent[newCallSite] = scs;
            }
            VCExpr toassert; 

            if(DoSubst)
                toassert = prover.VCExprGen.Implies(scs.callSiteExpr, scs.Attach(svc));
            else
                toassert = prover.VCExprGen.Implies(scs.callSiteExpr, prover.VCExprGen.And(
                    svc.vcexpr, AttachByEquality(scs, svc)));

            stats.vcSize += SizeComputingVisitor.ComputeSize(toassert);
            //Console.WriteLine("VC of {0} is {1}", scs.callSite.calleeName, toassert);

            if (name != null)
                prover.AssertNamed(toassert, true, name);
            else
                prover.Assert(toassert, true);

            attachedVC[scs] = svc;

            return svc;
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
            return string.Format("{0}_131_{1}_131_{2}", ret, scs.callSite.calleeName, GetSiCallId(scs));
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
            prover.Check();
            stats.time += stopwatch.ElapsedTicks;
            ProverInterface.Outcome outcome = prover.CheckOutcomeCore(reporter);
            return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
        }

        public override Outcome FindLeastToVerify(Implementation impl, ref HashSet<string> allBoolVars)
        {
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
                    prover.Assert(scs.Attach(svc), true);
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


    /****************************************
    *      Counter-example Generation       *
    ****************************************/

    class EmptyErrorReporter : ProverInterface.ErrorHandler
    {
        public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome) { }
    }

    class StratifiedInliningErrorReporter : ProverInterface.ErrorHandler
    {
        StratifiedInlining si;
        public VerifierCallback callback;
        StratifiedVC mainVC;
        public static TimeSpan ttime = TimeSpan.Zero;
        IList<string> GlobalLabels;

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
            this.GlobalLabels = null;
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

        public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome)
        {
            // Timeout?
            if (proverOutcome != ProverInterface.Outcome.Invalid)
                return;

            if (CommandLineOptions.Clo.UseLabels)
                GlobalLabels = labels;

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
            else if (CommandLineOptions.Clo.UseLabels)
                return GetAbsyTraceLabels(svc, GlobalLabels);
            else
                return GetAbsyTraceControlFlowVariable(svc, labels);
        }

        private List<Absy> GetAbsyTraceLabels(StratifiedVC svc, IList<string> labels)
        {
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
                    if (!svc.block2label.ContainsKey(succ))
                        continue;

                    if (labels.Contains(svc.block2label[succ]))
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
