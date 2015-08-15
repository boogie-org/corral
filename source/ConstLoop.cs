using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cba.Util;
using cba;
using Microsoft.Boogie.Houdini;
using Microsoft.Boogie;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using Microsoft.Boogie.GraphUtil;

namespace cba
{
    // Idempotent loop: whatever two iterations of the loop 
    //                  can do, one iteration can do as well.
    // We define a constant loop as one which is idempotent, except
    // for a single counter variable. In this case, we simply havoc
    // the counter variable and remove recursive calls of the loop
    class ConstLoop :CompilerPass
    {
        // call graph
        Dictionary<string, HashSet<string>> callGraph;
        // impl -> exit block label
        Dictionary<string, string> exitBlock;
        // impl -> loop body start block
        Dictionary<string, string> loopBodyStartBlock;
        // impl -> potential counter variable
        Dictionary<string, Variable> implCounter;
        // impl -> block label such that last Cmd in this block is the recursive call
        Dictionary<string, string> recCallBlock;
        // Set of live out-formals 
        Dictionary<string, HashSet<string>> liveFormals;
        // Leaf procs called by potential constant loops
        HashSet<string> leafProcs;
        // var copy (init)
        Dictionary<string, Variable> varInitCopy;
        // var copy (final)
        Dictionary<string, Variable> varFinalCopy;
        // var copy (final2)
        Dictionary<string, Variable> varFinal2Copy;
        // variable for determinizing corral_nondet
        GlobalVariable nonDetCounter, nonDetCounterInit;
        // Block created for merging recursive calls
        Dictionary<string, string> mergedRecCallBlock;
        // Set of pruned loops
        public HashSet<string> cLoops { get; private set; }
        // Empty loop iteration for pruned loops
        Dictionary<string, ErrorTrace> emptyLoopIter;
        // control "havoc" statement non-determinism?
        bool controlHavocNonDet;
        // Converts havoc to corral_nondet
        InstrumentHavoc instHavoc;
        // Turn off counter identification
        bool counterAbs;

        // Record detailed conclusions of the current run
        public ConstLoopHistory currHistory { get; private set; }

        // Summary of previous runs
        // 0: no; 1: yes; 2: maybe
        Func<Implementation, int> prevRunSummary;

        // This pass didn't do anything
        bool noop;

        // Input program
        Program inProg;
        // output program
        Program outProg;

        public ConstLoop(Func<Implementation, int> history)
            : this(false, true, history) { }

        public ConstLoop()
            : this(false, true, impl => 2) { }

        public ConstLoop(bool controlHavoc, bool counterAbs, Func<Implementation, int> history)
        {
            callGraph = new Dictionary<string, HashSet<string>>();
            exitBlock = new Dictionary<string, string>();
            implCounter = new Dictionary<string, Variable>();
            leafProcs = new HashSet<string>();
            recCallBlock = new Dictionary<string, string>();
            varInitCopy = new Dictionary<string, Variable>();
            varFinalCopy = new Dictionary<string, Variable>();
            varFinal2Copy = new Dictionary<string, Variable>();
            loopBodyStartBlock = new Dictionary<string, string>();
            liveFormals = new Dictionary<string, HashSet<string>>();
            mergedRecCallBlock = new Dictionary<string, string>();
            cLoops = new HashSet<string>();
            emptyLoopIter = new Dictionary<string, ErrorTrace>();
            this.controlHavocNonDet = controlHavoc;
            this.counterAbs = counterAbs;
            instHavoc = new InstrumentHavoc();
            this.noop = false;
            this.prevRunSummary = history;
            this.currHistory = new ConstLoopHistory();
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            Log.WriteLine("--------- CL ----------");
            
            var annotated = new HashSet<string>();

            if (controlHavocNonDet)
            {
                instHavoc.runPass(p);
            }

            inProg = p;

            // do mod set analysis
            BoogieUtil.DoModSetAnalysis(p);

            // allocate some variables
            nonDetCounter = BoogieAstFactory.MkGlobal("nonDetCounter__cl", Microsoft.Boogie.Type.Int)
                as GlobalVariable;
            nonDetCounterInit = BoogieAstFactory.MkGlobal("nonDetCounter__cl_init", Microsoft.Boogie.Type.Int)
                as GlobalVariable;

            // For convinience, introduce alloc variable if there isn't one
            if (BoogieUtil.findVarDecl(inProg.TopLevelDeclarations, "alloc") == null)
            {
                inProg.AddTopLevelDeclaration(
                    BoogieAstFactory.MkGlobal("alloc", Microsoft.Boogie.Type.Int));
            }

            // Gather the set of implementations with "loop" inside their name
            var loopImpls = new List<Implementation>();
            p.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => { if (impl.Name.Contains("loop")) loopImpls.Add(impl); });
            
            // Filter definite NO
            loopImpls = loopImpls.Filter(impl => prevRunSummary(impl) != 0);

            // Construct the call graph
            p.TopLevelDeclarations
                .OfType<Procedure>()
                .Iter(proc => callGraph.Add(proc.Name, new HashSet<string>()));

            foreach (var impl in p.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.Blocks
                    .Iter(blk =>
                        blk.Cmds.OfType<CallCmd>()
                        .Iter(cc => callGraph[impl.Name].Add(cc.callee)));
            }

            // Sometimes loops have multiple backedges, hence multiple recursive calls: merge them
            loopImpls.Iter(impl =>
                {
                    var lb = LoopBound.mergeRecCalls(impl);
                    if(lb != null) mergedRecCallBlock.Add(impl.Name, lb);
                });

            // Filter to those with the right CFG
            loopImpls = loopImpls.Filter(impl => CheckImplAndRecordHistory(impl));


            if (loopImpls.Count == 0)
            {
                noop = true;
                return null;
            }

            // Filter based on definite YES
            loopImpls
                .Where(loop => prevRunSummary(loop) == 1)
                .Iter(impl => cLoops.Add(impl.Name));

            loopImpls = loopImpls.Filter(loop => prevRunSummary(loop) != 1);

            if (loopImpls.Count != 0)
            {
                // Create copies of global variables
                foreach (var g in inProg.TopLevelDeclarations.OfType<GlobalVariable>())
                {
                    var ngInit = new GlobalVariable(Token.NoToken, new TypedIdent(
                        Token.NoToken, g.Name + "__init", g.TypedIdent.Type));
                    var ngFinal = new GlobalVariable(Token.NoToken, new TypedIdent(
                        Token.NoToken, g.Name + "__final", g.TypedIdent.Type));
                    var ngFinal2 = new GlobalVariable(Token.NoToken, new TypedIdent(
                        Token.NoToken, g.Name + "__final2", g.TypedIdent.Type));
                    varInitCopy.Add(g.Name, ngInit);
                    varFinalCopy.Add(g.Name, ngFinal);
                    varFinal2Copy.Add(g.Name, ngFinal2);
                }

                // Create copies of loopsImpls
                var loopImplsCopy = new List<Implementation>();
                var dup = new FixedDuplicator(true);
                loopImpls.Iter(impl =>
                    {
                        var copy = dup.VisitImplementation(impl);
                        copy.Proc = impl.Proc;
                        loopImplsCopy.Add(copy);
                    });

                // For deterministic malloc
                if (leafProcs.Contains("__HAVOC_malloc"))
                {
                    leafProcs.Add("__HAVOC_det_malloc");
                }

                // insert assertions
                loopImplsCopy.Iter(impl => CheckIdempotence(impl));

                // Populate the out program
                PopulateOutProg(loopImplsCopy);

                // Handle nondeterminism in corral_nondet and malloc
                HandleNonDeterminism();

                // Find constant loops
                cLoops.UnionWith(FindConstantLoops(loopImplsCopy));

                // Look at the annotations
                if (counterAbs)
                {
                    var possibleLoops = new HashSet<string>();
                    loopImpls.Iter(impl => possibleLoops.Add(impl.Name));

                    // We're told to treat some loops as idempotent?
                    annotated.UnionWith(
                        GlobalConfig.annotations
                        .Where(s => s.StartsWith("CL:"))
                        .Select(s => s.Split(':'))
                        .Where(sp => sp.Length == 2)
                        .Select(sp => sp[1])
                        .Where(loop => possibleLoops.Contains(loop)));

                    // sdv front-end notion of "counter loops"
                    var counterAnn = GlobalConfig.annotations
                        .Where(s => s.StartsWith("PruneCounterLoop:"))
                        .Select(s => s.Split(':'))
                        .Where(sp => sp.Length == 2)
                        .Select(sp => Int32.Parse(sp[1]));

                    if (counterAnn.Any())
                    {
                        var counterLoopBound = counterAnn.First();
                        annotated.UnionWith(
                            loopImpls.Where(impl => getCounterAnnotation(impl).Item1 >= counterLoopBound)
                            .Select(impl => impl.Name));
                    }
                    annotated.ExceptWith(cLoops);
                    cLoops.UnionWith(annotated);
                            
                }
            }

            cLoops.Iter(s =>
                Log.WriteLine("CL: Constant loop {0} {1}", s, annotated.Contains(s) ? "(annotated)" : ""));

            cLoops.Iter(c => PruneConstantLoops(c));

            // For mapBack
            cLoops.Iter(c => emptyLoopIter.Add(c, mkEmptyLoopIter(inProg, c)));

            var ret = new CBAProgram(inProg, p.mainProcName, p.contextBound);

            // Let go of extra memory
            inProg = null;
            outProg = null;
            prevRunSummary = null;

            return ret;
        }

        // Find if a loop has "CounterLoop" annotation
        public static Tuple<int, string> getCounterAnnotation(Implementation impl)
        {
            var potentialBlocks = new HashSet<string>();
            potentialBlocks.Add(impl.Blocks[0].Label);
            var gc = impl.Blocks[0].TransferCmd as GotoCmd;
            if(gc != null ) 
                gc.labelNames.OfType<string>().Iter(s => potentialBlocks.Add(s));

            var label2Block = BoogieUtil.labelBlockMapping(impl);
            foreach (var b in potentialBlocks)
            {
                var blk = label2Block[b];
                var num = -1;
                foreach (var cmd in blk.Cmds.OfType<AssumeCmd>())
                {
                    num = QKeyValue.FindIntAttribute(cmd.Attributes, "CounterLoop", num);
                    if (num >= 0)
                    {
                        var counter = QKeyValue.FindStringAttribute(cmd.Attributes, "Counter");
                        return Tuple.Create(num, counter);
                    }

                }
            }
            return Tuple.Create<int, string>(-1, null);
        }

        // For corral_nondet, add:
        //   modifies cnt;
        //   ensures ret == detChoice(cnt);
        //   ensures cnt == old(cnt) + 1;
        //
        //  For malloc, replace __HAVOC_malloc with
        //   __HAVOC_det_malloc (already provided by HAVOC)
        private void HandleNonDeterminism()
        {
            var detChoice = new Function(Token.NoToken, "detChoice__cl",
                new List<Variable> {
                    new Formal(Token.NoToken,
                        new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), true) },
                new Formal(Token.NoToken,
                    new TypedIdent(Token.NoToken, "y", Microsoft.Boogie.Type.Int), false));

            var corralNondet = BoogieUtil.findProcedureDecl(outProg.TopLevelDeclarations, "corral_nondet");
            if (corralNondet != null)
            {
                outProg.AddTopLevelDeclaration(detChoice);
                corralNondet.Modifies.Add(new IdentifierExpr(Token.NoToken, nonDetCounter));

                var ret = corralNondet.OutParams[0] as Variable;
                var c1 = Expr.Eq(Expr.Ident(ret), new NAryExpr(Token.NoToken,
                    new FunctionCall(detChoice), new List<Expr>{Expr.Ident(nonDetCounter)}));
                var c2 = Expr.Eq(Expr.Ident(nonDetCounter),
                    Expr.Add(new OldExpr(Token.NoToken, Expr.Ident(nonDetCounter)),
                    Expr.Literal(1)));

                corralNondet.Ensures.Add(new Ensures(false, c1));
                corralNondet.Ensures.Add(new Ensures(false, c2));
            }

            var malloc = BoogieUtil.findProcedureDecl(outProg.TopLevelDeclarations, "__HAVOC_malloc");
            var mallocDet = BoogieUtil.findProcedureDecl(outProg.TopLevelDeclarations, "__HAVOC_det_malloc");
            if (malloc != null && mallocDet != null)
            {
                outProg.TopLevelDeclarations
                    .OfType<Implementation>()
                    .Iter(impl =>
                        impl.Blocks.Iter(blk =>
                            {
                                for (int i = 0; i < blk.Cmds.Count; i++)
                                {
                                    var cc = blk.Cmds[i] as CallCmd;
                                    if (cc == null) continue;
                                    if (cc.callee == malloc.Name)
                                    {
                                        cc = new CallCmd(cc.tok, mallocDet.Name, cc.Ins, cc.Outs, cc.Attributes, cc.IsAsync);
                                        cc.Proc = mallocDet;
                                        blk.Cmds[i] = cc;
                                    }
                                }
                            }));

            }
        }

        // Return the set of reachable procedures in the call graph.
        // Does a BFS. Returns false if recursion is detected.
        // Also returns the maximum call depth
        private bool ReachableProcedure(string proc, out int depth, out HashSet<string> reachable)
        {
            reachable = new HashSet<string>();
            depth = 0;

            reachable.UnionWith(callGraph[proc]);
            reachable.Remove(proc);

            var frontier = new HashSet<string>();
            frontier.UnionWith(reachable);
          
            depth = 0;
            while (frontier.Count != 0)
            {
                depth++;

                var next = new HashSet<string>();
                frontier.Iter(s => next.UnionWith(callGraph[s]));

                frontier = next.Difference(reachable);
                reachable.UnionWith(next);
            }
            var rset = new HashSet<string>(reachable);

            // Check if cyclic (except for the proc->proc edge)
            var graph = new Graph<string>();
            callGraph
                .Where(kvp => rset.Contains(kvp.Key))
                .Iter(kvp =>
                kvp.Value.Iter(tgt =>
                {
                    if (kvp.Key != proc || tgt != proc)
                        graph.AddEdge(kvp.Key, tgt);
                }));

            if (!Graph<string>.Acyclic(graph, proc))
                return false;

            return true;
        }


        // Replace the recursive call with "havoc counter"
        private void PruneConstantLoops(string cLoop)
        {
            var impl = BoogieUtil.findProcedureImpl(inProg.TopLevelDeclarations, cLoop);
            var rec = impl.Blocks.First(blk => blk.Label == recCallBlock[impl.Name]);
            rec.Cmds.Remove(rec.Cmds.Last());
            if (counterAbs)
            {
                rec.Cmds.Add(BoogieAstFactory.MkHavocVar(implCounter[impl.Name]));
            }
            else
            {
                rec.Cmds.Add(BoogieAstFactory.MkAssume(Expr.True));
            }
        }

        // Query boogie to find constant loops
        private HashSet<string> FindConstantLoops(IEnumerable<Implementation> candidates)
        {
            var ret = new HashSet<string>();
            var allErrors = new List<BoogieErrorTrace>();
            var timeOuts = new List<string>();

            // Break all links with inProg
            BoogieUtil.PrintProgram(outProg, "cLoopsQuery.bpl");
            outProg = BoogieUtil.ReadAndOnlyResolve("cLoopsQuery.bpl");
            BoogieUtil.DoModSetAnalysis(outProg);
            BoogieUtil.TypecheckProgram(outProg, "cLoopsQuery.bpl");

            // Set options
            var options = new BoogieVerifyOptions();
            //options.StratifiedInlining = 100;
            options.StratifiedInliningWithoutModels = true;
            BoogieVerify.options = options;

            // set strong array theory
            var ua_old = CommandLineOptions.Clo.UseArrayTheory;
            var wa_old = CommandLineOptions.Clo.WeakArrayTheory;
            CommandLineOptions.Clo.UseArrayTheory = true;
            CommandLineOptions.Clo.WeakArrayTheory = false; 

            var to = CommandLineOptions.Clo.ProverKillTime;
            CommandLineOptions.Clo.ProverKillTime = 5;

            // verify
            BoogieVerify.Verify(outProg, true, out allErrors, out timeOuts);

            // Find all those impls that verified
            candidates.Iter(impl => ret.Add(impl.Name));
            allErrors.Iter(et => ret.Remove(et.impl.Name));
            timeOuts.Iter(impl => ret.Remove(impl));

            if (timeOuts.Any())
            {
                Console.Write("Timed out: ");
                timeOuts.Iter(impl => Console.Write("{0} ", impl));
                Console.WriteLine();
            }

            // Record history
            foreach (var impl in candidates)
            {
                if (ret.Contains(impl.Name))
                {
                    var used = new VarsUsed();
                    used.VisitImplementation(impl);
                    currHistory.globalsUsed.Add(impl.Name, used.globalsUsed);
                }
                else
                {
                    currHistory.semanticallyFailedLoops.Add(impl.Name);
                }
            }

            // Reset options
            CommandLineOptions.Clo.UseArrayTheory = ua_old;
            CommandLineOptions.Clo.WeakArrayTheory = wa_old; 

            CommandLineOptions.Clo.ProverKillTime = to;

            return ret;
        }

        // Given a loop procedure, modify it to check for its idempotence.
        // Precondition: CheckImpl(impl) is true
        //
        // g == g_init
        // body0;
        // g == g_final && f == f_final
        // if(aggressive)
        //    havoc g, l, f
        //    g == g_init
        //    Init;
        //    body0b
        //    g == g_final2 && f == f_final2
        // havoc g, l, f
        // g == g_init
        // Init;
        // body1;
        // t := [in-formals <- out-formals]
        // havoc l, f;
        // Init[in-formals <- t]
        // body2
        // assert g == g_final && f == f_final [where f is live at some call site]
        //
        // Additionally:
        //   o corral_nondet counter is made same for body0 and body2, whereas body1 is started with an
        //     arbitrary counter
        //   o Allocation during body1 is made far away (after alloc_mid2); and alloc at the start of body0 and body1 is 
        //     the same
        //   o For the assertion, we only check for equality of maps (Mem_T.f) at addresses less than alloc_mid2
        private void CheckIdempotence(Implementation impl)
        {
            // Create copies of out formals
            foreach (var g in impl.OutParams.OfType<Variable>())
            {
                var ngFinal = new LocalVariable(Token.NoToken, new TypedIdent(
                    Token.NoToken, g.Name + "__final", g.TypedIdent.Type));
                varFinalCopy.Add(g.Name, ngFinal);
                var ngFinal2 = new LocalVariable(Token.NoToken, new TypedIdent(
                    Token.NoToken, g.Name + "__final2", g.TypedIdent.Type));
                varFinal2Copy.Add(g.Name, ngFinal2);
            }

            // create copies of in formals
            var inFormalsCopy = new Dictionary<string, Variable>();
            foreach (var g in impl.InParams.OfType<Variable>())
            {
                var ng = new LocalVariable(Token.NoToken, new TypedIdent(
                    Token.NoToken, g.Name + "__copy", g.TypedIdent.Type));
                inFormalsCopy.Add(g.Name, ng);
            }

            var loopGlobals = LoopGlobVars(impl);
            var loopFormals = LoopFormalVars(impl);
            var allFormals = impl.OutParams.OfType<Variable>();

            var initExpr = VarEqCopy(loopGlobals, s => varInitCopy[s]);
            var finalExpr = VarEqCopy(loopGlobals.Concat(loopFormals), s => varFinalCopy[s]);
            var final2Expr = VarEqCopy(loopGlobals.Concat(loopFormals), s => varFinal2Copy[s]);

            // nondet counter
            string[] cntHelpers = { "a", "ac", "b", "c" };
            var cntVars = new Dictionary<string, Variable>();
            cntHelpers.Iter(s => cntVars.Add(s, BoogieAstFactory.MkLocal("nondetCnt_cl_" + s, nonDetCounter.TypedIdent.Type)));
            var assumeCnt = new Func<string, AssumeCmd>(s => BoogieAstFactory.MkAssumeVarEqVar(nonDetCounter, cntVars[s]));
            var havocCnt = BoogieAstFactory.MkHavocVar(nonDetCounter);

            // alloc
            var alloc = BoogieUtil.findVarDecl(inProg.TopLevelDeclarations, "alloc");
            Debug.Assert(alloc != null);

            string[] allocHelpers = { "a1", "a2", "ac1", "ac2", "b1", "b2", "c1", "c2", "sp1", "sp2" };
            var allocVars = new Dictionary<string, Variable>();
            allocHelpers.Iter(s => allocVars.Add(s, BoogieAstFactory.MkLocal("alloc_cl_" + s, alloc.TypedIdent.Type)));

            var havocAlloc = BoogieAstFactory.MkHavocVar(alloc);
            var assumeAllocEq = new Func<string, AssumeCmd>(s => BoogieAstFactory.MkAssumeVarEqVar(alloc, allocVars[s]));
            var assumeAllocGt = new Func<string, AssumeCmd>(s => BoogieAstFactory.MkAssumeVarGtVar(alloc, allocVars[s]));

            var ieSeq = new List<IdentifierExpr>();
            loopGlobals.Iter(v => ieSeq.Add(new IdentifierExpr(Token.NoToken, v)));
            Cmd havocGlobals = new HavocCmd(Token.NoToken, ieSeq);
            if (ieSeq.Count == 0) havocGlobals = BoogieAstFactory.MkAssume(Expr.True);

            ieSeq = new List<IdentifierExpr>();
            impl.LocVars.OfType<Variable>().Iter(v => ieSeq.Add(new IdentifierExpr(Token.NoToken, v)));
            allFormals.Iter(v => ieSeq.Add(new IdentifierExpr(Token.NoToken, v)));
            Cmd havocLocals = new HavocCmd(Token.NoToken, ieSeq);
            if (ieSeq.Count == 0) havocLocals = BoogieAstFactory.MkAssume(Expr.True);

            // init cmds
            var initCmds = impl.Blocks[0].Cmds;
            var initCmdsCopy = (new FixedDuplicator()).VisitCmdSeq(initCmds);
            
            // initCmds[in-formals <- in-formals-copy]
            initCmdsCopy = (new VarSubstituter(inFormalsCopy, new Dictionary<string, Variable>())).VisitCmdSeq(initCmdsCopy);

            // create two copies of the body
            var body0 = BoogieUtil.labelBlockMapping(impl);
            var body1 = CreateLoopBodyCopy(impl, "_copy1");
            var body2 = CreateLoopBodyCopy(impl, "_copy2");
            var body0b = CreateLoopBodyCopy(impl, "_copy0b");

            // in-formals-copy := rec-call-in-params
            var assignInFormalsCopy = new List<Cmd>();
            var recCall = body0[recCallBlock[impl.Name]].Cmds.Last() as CallCmd;
            Debug.Assert(recCall.callee == impl.Name);
            impl.InParams
                .OfType<Variable>()
                .Zip(recCall.Ins, (v, e) => Tuple.Create(inFormalsCopy[v.Name], e))
                .Iter(tup => assignInFormalsCopy.Add(BoogieAstFactory.MkVarEqExpr(tup.Item1, tup.Item2)));
            
            // assume init
            var head0 = body0[loopBodyStartBlock[impl.Name]];
            var head0Cmds = head0.Cmds;
            head0.Cmds = new List<Cmd>{BoogieAstFactory.MkAssume(initExpr)};
            head0.Cmds.Add(assumeCnt("a"));
            head0.Cmds.Add(assumeAllocEq("a1"));
            head0.Cmds.AddRange(head0Cmds);

            // assume final
            var rec0 = body0[recCallBlock[impl.Name]];
            rec0.Cmds.Remove(rec0.Cmds.Last());
            rec0.Cmds.Add(BoogieAstFactory.MkAssume(finalExpr));
            rec0.Cmds.Add(assumeAllocEq("a2"));
            
            // havoc globals, locals, formals; assume init; init; goto body1
            rec0.Cmds.Add(havocCnt);
            rec0.Cmds.Add(assumeCnt("b"));
            rec0.Cmds.Add(havocAlloc);
            rec0.Cmds.Add(assumeAllocEq("b1"));
            

            rec0.Cmds.Add(havocGlobals);
            rec0.Cmds.Add(havocLocals);
            rec0.Cmds.Add(BoogieAstFactory.MkAssume(initExpr));

            rec0.Cmds.AddRange(initCmds);
            rec0.TransferCmd = BoogieAstFactory.MkGotoCmd(body1[loopBodyStartBlock[impl.Name]].Label);

            // havoc locals, formals; initCmdsCopy; goto body2
            var rec1 = body1[recCallBlock[impl.Name]];
            rec1.Cmds.Remove(rec1.Cmds.Last());
            rec1.Cmds.AddRange(assignInFormalsCopy);
            rec1.Cmds.Add(havocLocals);
            rec1.Cmds.AddRange(initCmdsCopy);
            rec1.Cmds.Add(havocCnt);
            rec1.Cmds.Add(assumeCnt("c"));
            rec1.Cmds.Add(assumeAllocEq("b2"));
            rec1.Cmds.Add(havocAlloc);
            rec1.Cmds.Add(assumeAllocEq("c1"));
            rec1.TransferCmd = BoogieAstFactory.MkGotoCmd(body2[loopBodyStartBlock[impl.Name]].Label);

            // assert final
            var rec2 = body2[recCallBlock[impl.Name]];
            rec2.Cmds.Remove(rec2.Cmds.Last());
            rec2.Cmds.Add(assumeAllocEq("c2"));

            Expr matchCnt = BoogieAstFactory.MkExprVarEqVar(cntVars["a"], cntVars["c"]);

            Expr matchAlloc = BoogieAstFactory.MkExprAnd(
                BoogieAstFactory.MkExprVarGtVar(allocVars["b1"], allocVars["c2"]),
                BoogieAstFactory.MkExprVarEqVar(allocVars["a1"], allocVars["c1"]),
                BoogieAstFactory.MkExprVarGtVar(allocVars["b1"], allocVars["a2"]));

            Expr matchAddr =
                BoogieAstFactory.MkExprVarGtVar(allocVars["a2"], allocVars["sp1"]);

            var matchFinal =
                finalAssertExpr(loopGlobals.Concat(loopFormals), s => varFinalCopy[s], allocVars["sp1"]);

            Expr matchIter = BoogieAstFactory.MkExprAnd(
                matchCnt, matchAlloc, matchAddr);

            Expr assertExpr = Expr.Imp(matchIter, matchFinal);
            rec2.Cmds.Add(BoogieAstFactory.MkAssert(assertExpr));               

            // add new blocks to the impl
            impl.Blocks.AddRange(body1.Values);
            impl.Blocks.AddRange(body2.Values);            

            // Declare locals and clear copies of out formals
            foreach (var g in impl.OutParams.OfType<Variable>())
            {
                impl.LocVars.Add(varFinalCopy[g.Name]);
                varFinalCopy.Remove(g.Name);

                impl.LocVars.Add(varFinal2Copy[g.Name]);
                varFinal2Copy.Remove(g.Name);
            }
            allocVars.Values.Iter(v => impl.LocVars.Add(v));
            cntVars.Values.Iter(v => impl.LocVars.Add(v));

            inFormalsCopy.Values.Iter(v => impl.LocVars.Add(v));
        }

        private Expr finalAssertExpr(IEnumerable<Variable> vars, Func<string, Variable> varsFinal, Variable sp)
        {
            Expr ret = Expr.True;
            foreach (var v in vars)
            {
                var f = varsFinal.Invoke(v.Name);
                if (v.TypedIdent.Type.IsMap && v.Name.StartsWith("Mem_T."))
                {
                    ret = Expr.And(ret, Expr.Eq(
                        BoogieAstFactory.MkMapAccessExpr(v, Expr.Ident(sp)),
                        BoogieAstFactory.MkMapAccessExpr(f, Expr.Ident(sp))));
                }
                else
                {
                    ret = Expr.And(ret, Expr.Eq(Expr.Ident(v), Expr.Ident(f)));
                }
            }
            return ret;

        }

        // return a copy of the loop body as [orig block name -> new block]
        private Dictionary<string, Block> CreateLoopBodyCopy(Implementation impl, string suffix)
        {
            var ret = new Dictionary<string, Block>();
            var dup = new FixedDuplicator();

            var startBlockLabel = impl.Blocks[0].Label;
            var bodyStartLabel = loopBodyStartBlock[impl.Name];
            var exitBlockLabel = exitBlock[impl.Name];

            // blocks in the loop body
            var body = impl.Blocks
                .Where(b => b.Label != startBlockLabel && b.Label != exitBlockLabel);

            // copy
            body.Iter(b => ret.Add(b.Label, dup.VisitBlock(b)));

            // rename labels
            ret.Values.Iter(b => b.Label += suffix);

            var renameLabels = new Action<GotoCmd>(gc =>
                {
                    var nSeq = new List<String>();
                    gc.labelNames.OfType<string>()
                        .Iter(s => nSeq.Add(s + suffix));
                    gc.labelNames = nSeq;
                    gc.labelTargets = new List<Block>();
                });

            // rename goto labels
            ret.Values
                .Where(b => b.TransferCmd is GotoCmd)
                .Select(b => b.TransferCmd as GotoCmd)
                .Iter(gc => renameLabels.Invoke(gc));

            return ret;
        }

        // returns each global modified by impl, except alloc
        private IEnumerable<Variable> LoopGlobVars(Implementation impl)
        {
            var ls2 = impl.Proc
                .Modifies.OfType<IdentifierExpr>()
                .Select(ie => ie.Decl)
                .Where(v => v.Name != "alloc");

            return ls2;
        }

        // returns each out formal, except the counter, and except those
        // that are not live at any call site of the impl
        private IEnumerable<Variable> LoopFormalVars(Implementation impl)
        {
            var ls1 = impl.OutParams
                .OfType<Variable>()
                .Where(v => liveFormals[impl.Name].Contains(v.Name));

            if (counterAbs)
            {
                var counter = implCounter[impl.Name];
                ls1 = ls1.Where(v => v.Name != counter.Name);
            }

            return ls1;
        }


        // returns (v1 == v1_copy && v2 == v2_copy ...)
        private Expr VarEqCopy(IEnumerable<Variable> vars, Func<string,Variable> varCopy)
        {
            Expr ret = Expr.True;
            foreach (var v in vars)
            {
                ret = Expr.And(ret, Expr.Eq(Expr.Ident(v), Expr.Ident(varCopy.Invoke(v.Name))));
            }
            return ret;
        }

        private void PopulateOutProg(IEnumerable<Implementation> loopImpls)
        {
            outProg = new Program();
            var loops = new Dictionary<string, Implementation>();
            loopImpls.Iter(impl => loops.Add(impl.Name, impl));
            var dup = new FixedDuplicator();

            foreach (var decl in inProg.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    var impl = decl as Implementation;
                    if (leafProcs.Contains(impl.Name))
                        outProg.AddTopLevelDeclaration(dup.VisitImplementation(impl));
                    else if (loops.ContainsKey(impl.Name))
                        outProg.AddTopLevelDeclaration(loops[impl.Name]);
                }
                else if (decl is Procedure)
                {
                    var name = (decl as Procedure).Name;
                    if (leafProcs.Contains(name) || loops.ContainsKey(name))
                        outProg.AddTopLevelDeclaration(dup.VisitProcedure(decl as Procedure));
                }
                else
                {
                    outProg.AddTopLevelDeclaration(decl);
                }
            }

            // declare new globals
            foreach (var g in inProg.TopLevelDeclarations.OfType<GlobalVariable>())
            {
                outProg.AddTopLevelDeclaration(varInitCopy[g.Name] as GlobalVariable);
                outProg.AddTopLevelDeclaration(varFinalCopy[g.Name] as GlobalVariable);
                outProg.AddTopLevelDeclaration(varFinal2Copy[g.Name] as GlobalVariable);
            }

            outProg.AddTopLevelDeclaration(nonDetCounter);
            outProg.AddTopLevelDeclaration(nonDetCounterInit);

            // Entry points
            outProg.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Attributes));
            loopImpls.Iter(impl => impl.AddAttribute("entrypoint"));
        }

        // Find the new "merged" block and absorb it into the previous block
        private ErrorTrace mapBackMergedRecCalls(ErrorTrace trace)
        {
            // First, apply recursively
            trace.Blocks
                .Iter(blk =>
                    blk.Cmds
                    .OfType<CallInstr>()
                    .Where(ci => ci.calleeTrace != null)
                    .Iter(ci => ci.SetErrorTrace(mapBackMergedRecCalls(ci.calleeTrace))));


            if (!mergedRecCallBlock.ContainsKey(trace.procName)) return trace;
            if (trace.Blocks.Count == 0) return trace;

            // Now merge blocks
            for (int i = 0; i < trace.Blocks.Count - 1; i++)
                Debug.Assert(mergedRecCallBlock[trace.procName] != trace.Blocks[i].blockName);

            var curr = trace.Blocks[trace.Blocks.Count - 1];
            
            if (mergedRecCallBlock[trace.procName] == curr.blockName)
            {
                Debug.Assert(curr.Cmds.Count == 1);
                Debug.Assert(trace.Blocks.Count > 1);

                var prev = trace.Blocks[trace.Blocks.Count - 2];                
                prev.Cmds.AddRange(curr.Cmds);
                trace.Blocks.RemoveAt(trace.Blocks.Count - 1);
            }

            return trace;
        }

        private bool CheckImplAndRecordHistory(Implementation impl)
        {
            var ret = CheckImpl(impl);
            if (ret == false)
                currHistory.staticallyFailedLoops.Add(impl.Name);
            return ret;
        }

        // Check that impl has:
        // -- entry, exit block
        // -- one recursive call
        // -- only calls leaf procedures
        // -- a single counter
        private bool CheckImpl(Implementation impl)
        {
            // Its strange if main is a loop; but still we cannot check loops that
            // have asserts inside them
            if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                return false;

            Log.WriteLine(Log.Debug, "CL: Examining {0}", impl.Name);

            // check entry, exit blocks
            var g1 = impl.Blocks[0].TransferCmd as GotoCmd;
            if (g1 == null) return false;
            if (g1.labelNames.Count != 2) return false;
            if (g1.labelNames[0] == impl.Blocks[0].Label || g1.labelNames[1] == impl.Blocks[0].Label) return false;
            if (!IsExitBlock(g1.labelNames[0], impl) && !IsExitBlock(g1.labelNames[1], impl)) return false;
            if (IsExitBlock(g1.labelNames[0], impl))
            {
                exitBlock.Add(impl.Name, g1.labelNames[0]);
                loopBodyStartBlock.Add(impl.Name, g1.labelNames[1]);
            }
            if (IsExitBlock(g1.labelNames[1], impl))
            {
                loopBodyStartBlock.Add(impl.Name, g1.labelNames[0]);
                exitBlock.Add(impl.Name, g1.labelNames[1]);
            }

            Log.WriteLine(Log.Debug, "CL:    Loop body start block identified: {0}", loopBodyStartBlock[impl.Name]);

            // Compute live formals
            liveFormals.Add(impl.Name, new HashSet<string>());

            // callers
            var callers = new HashSet<string>();
            callGraph.Iter(kvp =>
            { if (kvp.Value.Contains(impl.Name)) callers.Add(kvp.Key); });
            callers.Remove(impl.Name);

            var liveFormalNum = new HashSet<int>();
            var implMap = BoogieUtil.nameImplMapping(inProg);
            foreach (var callerN in callers)
            {
                var caller = implMap[callerN];
                CbaLiveVariableAnalysis.ClearLiveVariables(caller);
                CbaLiveVariableAnalysis.ComputeLiveVariables(caller, inProg);
                foreach (var blk in caller.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        var cc = blk.Cmds[i] as CallCmd;
                        if (cc == null || cc.callee != impl.Name)
                            continue;
                        var lv = CbaLiveVariableAnalysis.GetLiveVarsAfter(inProg, caller, blk, i);
                        for (int j = 0; j < cc.Outs.Count; j++)
                        {
                            if (lv.Contains(cc.Outs[j].Decl))
                                liveFormalNum.Add(j);
                        }
                    }
                }
            }

            var dead = new HashSet<string>();
            for (int i = 0; i < impl.OutParams.Count; i++)
            {
                var formal = impl.OutParams[i];
                if (liveFormalNum.Contains(i))
                    liveFormals[impl.Name].Add(formal.Name);
                else
                    dead.Add(formal.Name);
            }

            Log.WriteLine(Log.Debug, "CL:    Out params not live at any call-site: {0}", dead.Print());
            // check called procedures
            int depth;
            HashSet<string> callees;

            var acyclic = ReachableProcedure(impl.Name, out depth, out callees);

            if (!acyclic) return false;
            //if (depth > 4) return false;

            Log.WriteLine(Log.Debug, "CL:    Callees acceptable: {0}", callees.Print());

            // find the recursive call
            Block rBlock = null;
            foreach (var blk in impl.Blocks)
            {
                var recCalls =
                    blk.Cmds
                    .OfType<CallCmd>()
                    .Where(cc => cc.callee == impl.Name);
                if (!recCalls.Any()) continue;
                if (recCalls.Count() != 1) return false;
                if (rBlock != null) return false;
                rBlock = blk;
            }
            if (rBlock == null) return false;

            recCallBlock.Add(impl.Name, rBlock.Label);       

            // make sure recursive call is last in the block
            var rCall = rBlock.Cmds.Last() as CallCmd;
            if (rCall == null || rCall.callee != impl.Name) return false;

            Log.WriteLine(Log.Debug, "CL:    Recursive call identifed in block: {0}", rBlock.Label);

            // find the counter variable
            if (counterAbs)
            {
                var counter = FindCounter(impl, inProg);
                if (counter == null) return false;
                implCounter.Add(impl.Name, counter);

                Log.WriteLine(Log.Debug, "CL:    Counter variable identified: {0}", counter.Name);
            }

            leafProcs.UnionWith(callees);



            Log.WriteLine(Log.Debug, "CL:    Potential candidate {0}", impl.Name);
            return true;
        }

        private bool IsExitBlock(string label, Implementation impl)
        {
            var block = impl.Blocks.First(blk => blk.Label == label);
            if (block == null) return false;
            if (block.Cmds.Count != 0) return false;
            if (!(block.TransferCmd is ReturnCmd)) return false;
            return true;
        }

        // counter is an "int" variable && Formal out && the only one that influences itself
        private Variable FindCounter(Implementation impl, Program program)
        {
            var formals = new Dictionary<string, Variable>();
            impl.OutParams.OfType<Variable>()
                .Where(v => v.TypedIdent.Type.IsInt)
                .Iter(v => formals.Add(v.Name, v));
            var counters = new HashSet<string>();
            
            var depGraph = new Dictionary<string, HashSet<string>>();
            impl.LocVars.OfType<Variable>()
                .Iter(v => depGraph.Add(v.Name, new HashSet<string>()));
            impl.InParams.OfType<Variable>()
                .Iter(v => depGraph.Add(v.Name, new HashSet<string>()));
            impl.OutParams.OfType<Variable>()
                .Iter(v => depGraph.Add(v.Name, new HashSet<string>()));
            program.TopLevelDeclarations.OfType<Variable>()
                .Iter(v => depGraph.Add(v.Name, new HashSet<string>()));

            var first = true;
            foreach (var blk in impl.Blocks)
            {
                if (first)
                {
                    // skip start block
                    first = false;
                    continue;
                }
                // TODO: what about calls
                foreach (var cmd in blk.Cmds.OfType<AssignCmd>())
                {
                    var read = new HashSet<string>();
                    var written = new HashSet<string>();
                    VarsReadAndWritten(new Cmd[] { cmd }, out read, out written);
                    read.Iter(r =>
                        depGraph[r].UnionWith(written));
                }
            }

            // Find self loops
            // TODO: Find cycles
            formals.Keys
                .Where(f => depGraph[f].Contains(f))
                .Iter(f => counters.Add(f));

            if (counters.Count != 1)
            {
                // Lookup ":Counter" annotation
                var counterAnnotation = getCounterAnnotation(impl);
                if (counterAnnotation.Item2 == null) return null;
                if (counters.Contains(counterAnnotation.Item2))
                    return formals[counterAnnotation.Item2];
                if (counters.Contains("out_" + counterAnnotation.Item2))
                    return formals["out_" + counterAnnotation.Item2];
                return null;
            }

            return formals[counters.First()];
        }

        // Check that impl has:
        // -- 3 blocks, with the body contained in Blocks[1]
        private bool CheckImplOld(Implementation impl)
        {
            if (impl.Blocks.Count != 3) return false;
            var g1 = impl.Blocks[0].TransferCmd as GotoCmd;
            if (g1 == null) return false;
            if (g1.labelNames.Count != 2) return false;
            if (g1.labelNames[0] == impl.Blocks[0].Label || g1.labelNames[1] == impl.Blocks[0].Label) return false;
            if (impl.Blocks[1].Cmds.Count != 0 && impl.Blocks[2].Cmds.Count != 0) return false;
            if (!(impl.Blocks[1].TransferCmd is ReturnCmd) || !(impl.Blocks[2].TransferCmd is ReturnCmd)) return false;
            if (impl.Blocks[2].Cmds.Count != 0) return false;
            return true;
        }

        private bool CheckIfConstOld(Implementation impl, HashSet<string> impls, Program program)
        {
            var body = new List<Cmd>();

            impl.Blocks[0].Cmds.OfType<Cmd>().Iter(cmd => body.Add(cmd as Cmd));
            impl.Blocks[1].Cmds.OfType<Cmd>().Iter(cmd => body.Add(cmd as Cmd));

            if(!body.Any()) return false;

            // body should have no calls
            if (body.OfType<CallCmd>()
                .Any(cmd => cmd.callee != impl.Name && impls.Contains(cmd.callee)))
                return false;

            // check the recursive call
            var lcmd = body.Last() as CallCmd;
            if (lcmd == null || (lcmd.callee != impl.Name)) return false;

            if (body.OfType<CallCmd>().Count(cmd => (cmd.callee == impl.Name)) != 1)
                return false;

            // Get hold of variables read and written in the body
            HashSet<string> read;
            HashSet<string> written;

            VarsReadAndWritten(body, out read, out written);

            // Get hold of the counter variable; it must be the only
            // variable that is both read from and written to in the body
            var counters = read.Intersection(written);
            if (counters.Count != 1)
                return false;

            var counter = FindVariable(counters.First(), impl, program);
            if (!counter.TypedIdent.Type.IsInt)
                return false;

            // Check that the counter influences nothing but itself
            var influence = VarInfluences(counter, body);
            if (influence.Count != 1 || !influence.Contains(counter.Name))
                return false;

            // Success, this is a constant loop!
            // Replace the recursive call with "havoc counter"
            impl.Blocks[1].Cmds.Remove(impl.Blocks[1].Cmds.Last());
            impl.Blocks[1].Cmds.Add(BoogieAstFactory.MkHavocVar(counter));

            Console.WriteLine("Found constant loop: {0}", impl.Name);
            return true;
        }

        private HashSet<string> VarInfluences(Variable v, IEnumerable<Cmd> cmds)
        {
            var vused = new VarsUsed();
            var ret = new HashSet<string>();

            foreach (var cmd in cmds.OfType<AssignCmd>())
            {
                var read = new HashSet<string>();
                var written = new HashSet<string>();
                var ls = new List<Cmd>(); ls.Add(cmd);

                VarsReadAndWritten(ls, out read, out written);

                if (!read.Contains(v.Name))
                    continue;

                ret.UnionWith(written);
            }

            return ret;
        }

        private Variable FindVariable(string name, Implementation impl, Program program)
        {
            // lookup globals first
            Variable ret = program.TopLevelDeclarations.OfType<GlobalVariable>().FirstOrDefault(g => g.Name == name);
            if (ret != null) return ret;

            // lookup formals
            ret = impl.InParams.OfType<Variable>().FirstOrDefault(g => g.Name == name);
            if (ret != null) return ret;

            ret = impl.OutParams.OfType<Variable>().FirstOrDefault(g => g.Name == name);
            if (ret != null) return ret;

            ret = impl.LocVars.OfType<Variable>().FirstOrDefault(g => g.Name == name);
            if (ret != null) return ret;

            throw new InternalError("Variable not found");
        }

        private void VarsReadAndWritten(IEnumerable<Cmd> cmds, out HashSet<string> read, out HashSet<string> written)
        {
            var vused = new VarsUsed();

            read = new HashSet<string>();
            written = new HashSet<string>();

            foreach (var cmd in cmds)
            {
                vused.reset();

                var acmd = cmd as AssignCmd;
                if (acmd == null)
                {
                    vused.Visit(cmd);
                    read.UnionWith(vused.varsUsed);
                    continue;
                }

                acmd.Rhss.Iter(rhs => vused.Visit(rhs));
                read.UnionWith(vused.varsUsed);
                vused.reset();

                foreach (var lhs in acmd.Lhss)
                {
                    if (lhs is SimpleAssignLhs)
                    {
                        vused.Visit(lhs);
                        written.UnionWith(vused.varsUsed);
                    }
                    else
                    {
                        var mlhs = lhs as MapAssignLhs;
                        written.Add(mlhs.DeepAssignedVariable.Name);
                        mlhs.Indexes.Iter(e => vused.Visit(e));
                        read.UnionWith(vused.varsUsed);
                    }
                }
            }

        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if (noop) return trace;

            trace = addEmptyLoopIter(trace);

            trace = mapBackMergedRecCalls(trace);

            if (controlHavocNonDet)
                trace = instHavoc.mapBackTrace(trace);

            return trace;
        }

        // Add empty loop iterations for pruned rec calls
        private ErrorTrace addEmptyLoopIter(ErrorTrace trace)
        {
            // First, apply recursively
            trace.Blocks
                .Iter(blk =>
                    blk.Cmds
                    .OfType<CallInstr>()
                    .Where(ci => ci.calleeTrace != null)
                    .Iter(ci => ci.SetErrorTrace(addEmptyLoopIter(ci.calleeTrace))));

            // Find pruned rec calls
            if (!cLoops.Contains(trace.procName))
                return trace;

            if (!trace.returns)
                return trace;

            var rBlk = trace.Blocks.FirstOrDefault(b => b.blockName == recCallBlock[trace.procName]);
            if (rBlk == null)
                return trace;

            Debug.Assert(rBlk.Cmds.Count != 0);
            var hc = rBlk.Cmds.Last();
            rBlk.Cmds.RemoveAt(rBlk.Cmds.Count - 1);

            var iter = emptyLoopIter[trace.procName].Copy();
            iter.Blocks[0].info = hc.info;
            var ni = new CallInstr(iter, hc.info);
            rBlk.Cmds.Add(ni);

            return trace;
        }

        private ErrorTrace mkEmptyLoopIter(Program program, string procName)
        {
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, procName);
            var blk1 = new ErrorTraceBlock(impl.Blocks[0].Label);
            var blk2 = new ErrorTraceBlock(exitBlock[procName]);

            if (impl.Blocks[0].Cmds.OfType<CallCmd>().Any())
                Debug.Assert(false);

            impl.Blocks[0].Cmds
                .OfType<Cmd>()
                .Iter(c => blk1.Cmds.Add(new IntraInstr()));

            var ret = new ErrorTrace(procName);
            ret.addBlock(blk1);
            ret.addBlock(blk2);
            ret.addReturn();

            return ret;
        }
    }

    // For maintaining history across ConstLoop runs
    // (used within the corral refinement loop)
    class ConstLoopHistory
    {
        // History is null
        bool isNull;

        // Which loops failed statically in the previous run
        public HashSet<string> staticallyFailedLoops;
        // Which loops failed semantically in the previous run
        public HashSet<string> semanticallyFailedLoops;
        // For loops that succeeded, what global variables were used
        public Dictionary<string, HashSet<string>> globalsUsed;

        public ConstLoopHistory()
        {
            staticallyFailedLoops = new HashSet<string>();
            semanticallyFailedLoops = new HashSet<string>();
            globalsUsed = new Dictionary<string, HashSet<string>>();
            isNull = false;
        }

        public static ConstLoopHistory GetNull()
        {
            var ret = new ConstLoopHistory();
            ret.isNull = true;
            return ret;
        }

        public bool definiteFail(Implementation impl)
        {
            if (isNull)
                return false;

            if (semanticallyFailedLoops.Contains(impl.Name))
                return true;

            return false;
        }

        public bool definiteSuccess(Implementation impl)
        {
            if (isNull)
                return false;

            if (!globalsUsed.ContainsKey(impl.Name))
                return false;

            var used = new VarsUsed();
            used.VisitImplementation(impl);

            if (used.globalsUsed.IsSubsetOf(globalsUsed[impl.Name]))
                return true;

            return false;
        }

    }

    public class CbaLiveVariableAnalysis
    {
        public static void ClearLiveVariables(Implementation impl)
        {
            Contract.Requires(impl != null);
            foreach (Block/*!*/ block in impl.Blocks)
            {
                Contract.Assert(block != null);
                block.liveVarsBefore = null;
            }
        }

        public static HashSet<Variable> GetLiveVarsAfter(Program program, Implementation impl, Block block, int cmdPos)
        {
            var liveVarsAfter = initLiveVars(block, impl, program);
            for (int i = block.Cmds.Count - 1; i > cmdPos; i--)
            {
                var cc = block.Cmds[i] as CallCmd;
                if (cc != null)
                {
                    liveVarsAfter = PropagateCall(cc, liveVarsAfter, program);
                    continue;
                }
                Propagate(block.Cmds[i], liveVarsAfter);
            }
            return liveVarsAfter;
        }

        public static void ComputeLiveVariables(Implementation impl, Program program)
        {
            Contract.Requires(impl != null);
            //Microsoft.Boogie.Helpers.ExtraTraceInformation("Starting live variable analysis");
            Graph<Block> dag = new Graph<Block>();
            dag.AddSource(cce.NonNull(impl.Blocks[0])); // there is always at least one node in the graph
            foreach (Block b in impl.Blocks)
            {
                GotoCmd gtc = b.TransferCmd as GotoCmd;
                if (gtc != null)
                {
                    Contract.Assume(gtc.labelTargets != null);
                    foreach (Block/*!*/ dest in gtc.labelTargets)
                    {
                        Contract.Assert(dest != null);
                        dag.AddEdge(dest, b);
                    }
                }
            }

            IEnumerable<Block> sortedNodes = dag.TopologicalSort();
            foreach (Block/*!*/ block in sortedNodes)
            {
                Contract.Assert(block != null);
                HashSet<Variable/*!*/>/*!*/ liveVarsAfter = initLiveVars(block, impl, program);

                List<Cmd> cmds = block.Cmds;
                int len = cmds.Count;
                for (int i = len - 1; i >= 0; i--)
                {
                    var cc = cmds[i] as CallCmd;
                    if (cc != null)
                    {
                        liveVarsAfter = PropagateCall(cc, liveVarsAfter, program);
                        continue;
                    }
                    Propagate(cmds[i], liveVarsAfter);
                }

                block.liveVarsBefore = liveVarsAfter;

            }
        }

        private static HashSet<Variable> PropagateCall(CallCmd cc, HashSet<Variable> liveVarsAfter, Program program)
        {
            liveVarsAfter = new HashSet<Variable>(liveVarsAfter);
            // globals U in-params U (after - out-params)
            cc.Outs.Where(ie => ie != null).Iter(ie => liveVarsAfter.Remove(ie.Decl));
            program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Iter(v => liveVarsAfter.Add(v));

            VariableCollector/*!*/ collector = new VariableCollector();
            cc.Ins.Where(e => e != null).Iter(e => collector.Visit(e));
            liveVarsAfter.UnionWith(collector.usedVars);

            return liveVarsAfter;
        }

        private static HashSet<Variable> initLiveVars(Block block, Implementation impl, Program program)
        {
            HashSet<Variable/*!*/>/*!*/ liveVarsAfter = new HashSet<Variable/*!*/>();
            if (block.TransferCmd is GotoCmd)
            {
                GotoCmd gotoCmd = (GotoCmd)block.TransferCmd;
                if (gotoCmd.labelTargets != null)
                {
                    foreach (Block/*!*/ succ in gotoCmd.labelTargets)
                    {
                        Contract.Assert(succ != null);
                        Contract.Assert(succ.liveVarsBefore != null);
                        liveVarsAfter.UnionWith(succ.liveVarsBefore);
                    }
                }
            }
            else if (block.TransferCmd is ReturnCmd)
            {
                // Globals and out-formals are live
                program.TopLevelDeclarations
                    .OfType<GlobalVariable>()
                    .Iter(v => liveVarsAfter.Add(v));
                impl.OutParams
                    .OfType<Formal>()
                    .Iter(v => liveVarsAfter.Add(v));
            }
            return liveVarsAfter;
        }

        // perform in place update of liveSet
        public static void Propagate(Cmd cmd, HashSet<Variable/*!*/>/*!*/ liveSet)
        {
            Contract.Requires(cmd != null);
            Contract.Requires(cce.NonNullElements(liveSet));
            if (cmd is AssignCmd)
            {
                AssignCmd/*!*/ assignCmd = (AssignCmd)cce.NonNull(cmd);
                // I must first iterate over all the targets and remove the live ones.
                // After the removals are done, I must add the variables referred on 
                // the right side of the removed targets

                AssignCmd simpleAssignCmd = assignCmd.AsSimpleAssignCmd;
                HashSet<int> indexSet = new HashSet<int>();
                int index = 0;
                foreach (AssignLhs/*!*/ lhs in simpleAssignCmd.Lhss)
                {
                    Contract.Assert(lhs != null);
                    SimpleAssignLhs salhs = lhs as SimpleAssignLhs;
                    Contract.Assert(salhs != null);
                    Variable var = salhs.DeepAssignedVariable;
                    if (var != null && liveSet.Contains(var))
                    {
                        indexSet.Add(index);
                        liveSet.Remove(var);
                    }
                    index++;
                }
                index = 0;
                foreach (Expr/*!*/ expr in simpleAssignCmd.Rhss)
                {
                    Contract.Assert(expr != null);
                    if (indexSet.Contains(index))
                    {
                        VariableCollector/*!*/ collector = new VariableCollector();
                        collector.Visit(expr);
                        liveSet.UnionWith(collector.usedVars);
                    }
                    index++;
                }
            }
            else if (cmd is HavocCmd)
            {
                HavocCmd/*!*/ havocCmd = (HavocCmd)cmd;
                foreach (IdentifierExpr/*!*/ expr in havocCmd.Vars)
                {
                    Contract.Assert(expr != null);
                    if (expr.Decl != null)
                    {
                        liveSet.Remove(expr.Decl);
                    }
                }
            }
            else if (cmd is PredicateCmd)
            {
                Contract.Assert((cmd is AssertCmd || cmd is AssumeCmd));
                PredicateCmd/*!*/ predicateCmd = (PredicateCmd)cce.NonNull(cmd);
                if (predicateCmd.Expr is LiteralExpr)
                {
                    LiteralExpr le = (LiteralExpr)predicateCmd.Expr;
                    if (le.IsFalse)
                    {
                        liveSet.Clear();
                    }
                }
                else
                {
                    VariableCollector/*!*/ collector = new VariableCollector();
                    collector.Visit(predicateCmd.Expr);
                    liveSet.UnionWith(collector.usedVars);
                }
            }
            else if (cmd is CommentCmd)
            {
                // comments are just for debugging and don't affect verification
            }
            else if (cmd is SugaredCmd)
            {
                SugaredCmd/*!*/ sugCmd = (SugaredCmd)cce.NonNull(cmd);
                Propagate(sugCmd.Desugaring, liveSet);
            }
            else if (cmd is StateCmd)
            {
                StateCmd/*!*/ stCmd = (StateCmd)cce.NonNull(cmd);
                List<Cmd>/*!*/ cmds = cce.NonNull(stCmd.Cmds);
                int len = cmds.Count;
                for (int i = len - 1; i >= 0; i--)
                {
                    Propagate(cmds[i], liveSet);
                }
                foreach (Variable/*!*/ v in stCmd.Locals)
                {
                    Contract.Assert(v != null);
                    liveSet.Remove(v);
                }
            }
            else
            {
                {
                    Contract.Assert(false);
                    throw new cce.UnreachableException();
                }
            }
        }
    }

    // Currently, this replaces "havoc v" with
    // call v := corral_nondet();
    // TODO:
    //   Handle "havoc v1, v2, ..."
    //   Make as compiler pass
    class InstrumentHavoc 
    {
        Procedure corralNondet;
        
        // (proc, block, cmd#)
        HashSet<Tuple<string, string, int>> modifiedCmds;

        public InstrumentHavoc()
        {
            corralNondet = null;
            modifiedCmds = new HashSet<Tuple<string, string, int>>();
        }

        public void runPass(Program p)
        {
            // Find corral_nondet
            corralNondet = BoogieUtil.findProcedureDecl(p.TopLevelDeclarations, "corral_nondet");
            if (corralNondet == null)
            {
                var proc = BoogieAstFactory.MkProc("corral_nondet", new List<Variable>(), new List<Variable>(new Variable[] {
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), true)}));

                p.AddTopLevelDeclaration(proc);
                corralNondet = proc as Procedure;
            }

            p.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl =>
                    impl.Blocks.Iter(b => runPassBlock(impl.Name, b)));
        }

        private void runPassBlock(string impl, Block block)
        {
            for (int i = 0; i < block.Cmds.Count; i++)
            {
                var cmd = block.Cmds[i] as HavocCmd;
                if (cmd == null) continue;
                if (cmd.Vars.Count != 1) continue;

                var v = cmd.Vars[0].Decl;
                if (!v.TypedIdent.Type.IsInt) continue;

                var cc = new CallCmd(Token.NoToken, "corral_nondet", new List<Expr>(), cmd.Vars);
                cc.Proc = corralNondet;

                block.Cmds[i] = cc;
                modifiedCmds.Add(Tuple.Create(impl, block.Label, i));
            }

        }

        // replace CallInstr for corral_nondet with IntraInstr
        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            // First, apply recursively
            trace.Blocks
                .Iter(blk =>
                    blk.Cmds
                    .OfType<CallInstr>()
                    .Where(ci => ci.calleeTrace != null)
                    .Iter(ci => ci.SetErrorTrace(mapBackTrace(ci.calleeTrace))));

            foreach (var blk in trace.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    if (!modifiedCmds.Contains(Tuple.Create(trace.procName, blk.blockName, i)))
                        continue;
                    var instr = new IntraInstr(blk.Cmds[i].info);
                    blk.Cmds[i] = instr;
                }
            }

            return trace;
        }
    }
}
