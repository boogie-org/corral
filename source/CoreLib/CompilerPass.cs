using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    // A compiler pass can be instantiated multiple times, but each instance can be
    // used only once. The pass records (permanently) its input and output program.
    abstract public class CompilerPass : ProgTransformation.TransformationPass
    {
        public CompilerPass() : base() { }

        public PersistentCBAProgram getInput()
        {
            return input as PersistentCBAProgram;
        }

        public PersistentCBAProgram getOutput()
        {
            return output as PersistentCBAProgram;
        }

        abstract public CBAProgram runCBAPass(CBAProgram p);

        virtual public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            throw new InternalError("Map back trace: not implemented for " + this.GetType().Name);
            //return trace;
        }

        public TimeSpan lastRun;

        //////////////////////////////////////////////
        // Private guys -- need not bother about these
        //////////////////////////////////////////////

        protected override Program getInput(ProgTransformation.PersistentProgram inp)
        {
            PersistentCBAProgram ap = inp as PersistentCBAProgram;
            Debug.Assert(ap != null);

            return ap.getCBAProgram();
        }

        protected override ProgTransformation.PersistentProgram recordOutput(Program p)
        {
            CBAProgram ap = p as CBAProgram;
            Debug.Assert(ap != null);

            return ap.getPersistentVersion();
        }



        public PersistentCBAProgram run(PersistentCBAProgram inp)
        {
            var time1 = DateTime.Now;
            ProgTransformation.PersistentProgram outp = run(inp as ProgTransformation.PersistentProgram);
            var ret = outp as PersistentCBAProgram;
            var time2 = DateTime.Now;

            lastRun = (time2 - time1);

            return ret;
        }

        protected override Program runPass(Program inp)
        {
            CBAProgram ap = inp as CBAProgram;
            Debug.Assert(ap != null);

            CBAProgram ret = runCBAPass(ap);

            return ret as Program;
        }

    }


    public static class LoopBound
    {
        // loop impl -> the impl that calls it
        static Dictionary<string, Implementation> loopCaller;
        // Call graph
        static Dictionary<string, HashSet<Implementation>> Succ;
        static Dictionary<string, HashSet<Implementation>> Pred;
        // Max bound
        static int maxBound = -1;
        // Time taken
        public static TimeSpan timeTaken = TimeSpan.Zero;
        // User Annotations
        static List<string> UserAnnotations = new List<string>();

        // Initialize statics
        private static void Initialize(List<string> Annotations)
        {
            loopCaller = new Dictionary<string, Implementation>();
            Succ = new Dictionary<string, HashSet<Implementation>>();
            Pred = new Dictionary<string, HashSet<Implementation>>();
            UserAnnotations = Annotations;
        }

        public static Dictionary<string, int> Compute(CBAProgram program, int max, List<string> Annotations, BoogieVerifyOptions options)
        {
            var loopBounds = new Dictionary<string, int>();

            Initialize(Annotations);
            maxBound = max;
            var start = DateTime.Now;

            // remove non-free ensures and requires
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(proc => proc.Ensures = proc.Ensures.Filter(en => en.Free));
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(proc => proc.Requires = proc.Requires.Filter(en => en.Free));
            // remove assertions
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(blk => blk.Cmds = blk.Cmds.Map(c =>
                        {
                            var ac = c as AssertCmd;
                            if (ac == null) return c;
                            return new AssumeCmd(ac.tok, /*ac.Expr*/ Expr.True, ac.Attributes);
                        })));
            // delete yield
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(blk => blk.Cmds.RemoveAll(c => c is YieldCmd)));

            // Call graph
            ComputeCallGraph(program);

            // Gather the set of implementations with "loop" inside their name
            var allLoopImpls = new List<Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => { if (impl.Name.Contains("loop")) allLoopImpls.Add(impl); });

            // Prune to the right form
            var loopImpls = allLoopImpls.Filter(CheckImpl);

            #region Process user annotations

            // Include user anntations
            var allLoops = new HashSet<string>();
            loopImpls.Iter(impl => allLoops.Add(impl.Name));
            foreach (var sp in UserAnnotations
                .Where(s => s.StartsWith("LB:"))
                .Select(s => s.Split(':'))
                .Where(sp => sp.Length == 3))
            {
                // grab bound
                var bound = 0;
                if (!Int32.TryParse(sp[2], out bound))
                    continue;

                // grab proc
                if (!allLoops.Contains(sp[1]))
                    continue;

                loopBounds[sp[1]] = bound;
                Console.WriteLine("LB: Loop {0} requires minimum {1} iterations (annotated)", sp[1], bound);
            }
            loopImpls = loopImpls.Filter(impl => !loopBounds.ContainsKey(impl.Name));
            #endregion

            if (loopImpls.Count == 0)
                return loopBounds;

            // Prepare query
            var query = PrepareQuery(loopImpls, program);

            // Set general options
            BoogieVerify.options = options;

            // Set rec. bound
            var oldBound = CommandLineOptions.Clo.RecursionBound;
            CommandLineOptions.Clo.RecursionBound = maxBound;

            // Query
            var allErrors = new List<BoogieErrorTrace>();
            BoogieVerify.Verify(query, out allErrors);
            foreach (var trace in allErrors)
            {
                var loopName = QKeyValue.FindStringAttribute(trace.impl.Attributes, "LB_Mapping");
                var bound = RecBound(loopName, trace.cex, trace.impl.Name);
                if (bound <= 1) continue;
                loopBounds.Add(loopName, bound);
                Console.WriteLine("LB: Loop {0} requires minimum {1} iterations", loopName, bound);
            }

            CommandLineOptions.Clo.RecursionBound = oldBound;
            timeTaken = (DateTime.Now - start);

            return loopBounds;
        }

        public static PersistentCBAProgram AddLoopBounds(PersistentCBAProgram program, Dictionary<string, int> extraRecBounds)
        {
            if (extraRecBounds.Count == 0 || extraRecBounds.All(tup => tup.Value == 0)) return program;

            var prog = program.getCBAProgram();
            AddLoopBounds(prog, extraRecBounds);
            return new PersistentCBAProgram(prog, prog.mainProcName, prog.contextBound);
        }

        public static void AddLoopBounds(Program program, Dictionary<string, int> extraRecBounds)
        {
            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => extraRecBounds.ContainsKey(impl.Name))
                .Iter(impl => impl.AddAttribute(BoogieVerify.ExtraRecBoundAttr, Expr.Literal(extraRecBounds[impl.Name])));
        }

        private static int RecBound(string recFunc, Counterexample trace, string traceName)
        {
            var ret = 0;
            if (trace == null) return ret;
            if (recFunc == traceName)
                ret++;

            for (int numBlock = 0; numBlock < trace.Trace.Count; numBlock++)
            {
                Block b = trace.Trace[numBlock];
                for (int numInstr = 0; numInstr < b.Cmds.Count; numInstr++)
                {
                    Cmd c = b.Cmds[numInstr];
                    var loc = new TraceLocation(numBlock, numInstr);
                    if (trace.calleeCounterexamples.ContainsKey(loc))
                    {
                        ret +=
                            RecBound(recFunc, trace.calleeCounterexamples[loc].counterexample,
                            (c as CallCmd).Proc.Name);
                    }
                }
            }
            return ret;
        }

        private static Program PrepareQuery(IEnumerable<Implementation> loopImpls, Program program)
        {
            // Sometimes loops have multiple backedges, hence multiple recursive calls: merge them
            loopImpls.Iter(impl => mergeRecCalls(impl));

            var dup = new FixedDuplicator(true);
            // Make copies of loopImpl procs
            var loopProcsCopy = new Dictionary<string, Procedure>();
            loopImpls
                .Iter(impl => loopProcsCopy.Add(impl.Name, dup.VisitProcedure(impl.Proc)));

            loopProcsCopy.Values.Iter(proc => proc.Name += "_PassiveCopy");

            // Make copies of the caller implementations
            var loopCallerImplCopy = new Dictionary<string, Implementation>();
            var loopCallerProcCopy = new Dictionary<string, Procedure>();

            loopImpls
                .Iter(impl => loopCallerImplCopy.Add(impl.Name, dup.VisitImplementation(loopCaller[impl.Name])));

            loopImpls
                .Iter(impl => loopCallerProcCopy.Add(impl.Name, dup.VisitProcedure(loopCaller[impl.Name].Proc)));

            loopCallerImplCopy
                .Iter(kvp => kvp.Value.Name += "_EntryCopy_" + kvp.Key);

            loopCallerProcCopy
                .Iter(kvp => kvp.Value.Name += "_EntryCopy_" + kvp.Key);

            loopCallerImplCopy
                .Iter(kvp => kvp.Value.Proc = loopCallerProcCopy[kvp.Key]);

            // Instrument callers
            foreach (var kvp in loopCallerImplCopy)
            {
                var impl = kvp.Value;

                var av = BoogieAstFactory.MkLocal("LoopBound_AssertVar", Microsoft.Boogie.Type.Bool);
                impl.LocVars.Add(av);

                // av := true
                var init = BoogieAstFactory.MkVarEqConst(av, true);
                var initCmds = new List<Cmd>();
                initCmds.Add(init);
                initCmds.AddRange(impl.Blocks[0].Cmds);
                impl.Blocks[0].Cmds = initCmds;

                // av := false
                foreach (var blk in impl.Blocks)
                {
                    var newCmds = new List<Cmd>();
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        // disable assertions
                        if (blk.Cmds[i] is AssertCmd && !BoogieUtil.isAssertTrue(blk.Cmds[i]))
                        {
                            newCmds.Add(new AssumeCmd(Token.NoToken, (blk.Cmds[i] as AssertCmd).Expr));
                            continue;
                        }
                        var cc = blk.Cmds[i] as CallCmd;
                        if (cc != null && cc.callee == kvp.Key)
                        {
                            newCmds.Add(blk.Cmds[i]);
                            newCmds.Add(BoogieAstFactory.MkVarEqConst(av, false));
                        }
                        else if (cc != null && loopProcsCopy.ContainsKey(cc.callee))
                        {
                            var ncc = new CallCmd(cc.tok, loopProcsCopy[cc.callee].Name, cc.Ins, cc.Outs, cc.Attributes, cc.IsAsync);
                            ncc.Proc = loopProcsCopy[cc.callee];
                            newCmds.Add(ncc);
                        }
                        else
                        {
                            newCmds.Add(blk.Cmds[i]);
                        }
                    }
                    blk.Cmds = newCmds;
                }

                // assert av
                impl.Blocks
                    .Where(blk => blk.TransferCmd is ReturnCmd)
                    .Iter(blk => blk.Cmds.Add(new AssertCmd(Token.NoToken, Expr.Ident(av))));
            }

            // Prepare program
            var ret = new Program();
            program.TopLevelDeclarations
                .Where(decl => !(decl is Implementation))
                .Iter(decl => ret.AddTopLevelDeclaration(decl));

            loopProcsCopy.Values
                .Iter(decl => ret.AddTopLevelDeclaration(decl));

            loopCallerImplCopy.Values
                .Iter(decl => ret.AddTopLevelDeclaration(decl));

            loopCallerProcCopy.Values
                .Iter(decl => ret.AddTopLevelDeclaration(decl));

            loopImpls
                .Iter(impl => ret.AddTopLevelDeclaration(impl));

            loopCallerImplCopy.Values
                .Iter(impl => impl.AddAttribute("entrypoint"));

            // Store mapping: entrypoint -> loop
            loopImpls
                .Select(loop => Tuple.Create(loop, loopCallerImplCopy[loop.Name]))
                .Iter(tup => tup.Item2.AddAttribute("LB_Mapping", tup.Item1.Name));

            ret = BoogieUtil.ReResolveInMem(ret);

            return ret;
        }

        private static void ComputeCallGraph(Program program)
        {
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl =>
                {
                    Succ.Add(impl.Name, new HashSet<Implementation>());
                    Pred.Add(impl.Name, new HashSet<Implementation>());
                });

            var name2Impl = BoogieUtil.nameImplMapping(program);
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    foreach (var cmd in blk.Cmds.OfType<CallCmd>())
                    {
                        if (!Succ.ContainsKey(cmd.callee)) continue;
                        Succ[impl.Name].Add(name2Impl[cmd.callee]);
                        Pred[cmd.callee].Add(impl);
                    }
                }
            }
        }

        private static bool CheckImpl(Implementation impl)
        {
            var preds = new HashSet<Implementation>(Pred[impl.Name]);

            // recursive?
            if (!preds.Contains(impl))
                return false;

            preds.Remove(impl);

            // unique caller?
            if (preds.Count != 1)
                return false;

            // cannot be main

            loopCaller.Add(impl.Name, preds.First());

            return true;
        }


        // If the impl has multiple calls:
        //   "call foo(args); return;"
        // with the same args, then merge these calls into one
        public static string mergeRecCalls(Implementation impl)
        {
            // find the recursive calls
            var rBlocks = new List<Block>();
            foreach (var blk in impl.Blocks)
            {
                var rc =
                    blk.Cmds
                    .OfType<CallCmd>()
                    .Where(cc => cc.callee == impl.Name);
                if (!rc.Any()) continue;
                if (rc.Count() != 1) return null;

                // make sure recursive call is last in the block
                var rcall = rc.First();
                if (rcall != blk.Cmds.Last()) return null;

                // check return
                if (!(blk.TransferCmd is ReturnCmd)) return null;

                rBlocks.Add(blk);
            }

            if (rBlocks.Count <= 1) return null;

            // grab the rec calls
            var recCalls = new Dictionary<string, CallCmd>();
            rBlocks.Iter(blk => recCalls.Add(blk.Label, blk.Cmds.Last() as CallCmd));

            // prune attributes
            var origAttr = new Dictionary<string, QKeyValue>();
            recCalls.Iter(kvp => origAttr.Add(kvp.Key, kvp.Value.Attributes));

            recCalls.Values
                .Iter(cc => cc.Attributes = BoogieUtil.removeAttrs(new HashSet<string> { "si_unique_call", "si_old_unique_call" }, cc.Attributes));

            // check that all recursive calls have the same arguments

            // Check 1: ToString
            var callStr = new HashSet<string>();
            recCalls.Values
                .Iter(cc =>
                {
                    var str = new System.IO.StringWriter();
                    var tt = new TokenTextWriter(str);
                    cc.Emit(tt, 0);
                    tt.Close();
                    callStr.Add(str.ToString());
                    str.Close();
                });

            if (callStr.Count != 1)
            {
                // restore attributes
                recCalls
                    .Iter(kvp => kvp.Value.Attributes = origAttr[kvp.Key]);
                return null;
            }

            // Check 2: AST
            var rc1 = recCalls[recCalls.Keys.First()];
            if (
                recCalls.Values
                .Where(c => !IsSame(rc1, c))
                .Any())
            {
                // restore attributes
                recCalls
                    .Iter(kvp => kvp.Value.Attributes = origAttr[kvp.Key]);

                return null;
            }

            // Merge
            rc1.Attributes = origAttr[recCalls.Keys.First()];
            var nb = BoogieAstFactory.MkBlock(rc1);
            rBlocks.Iter(blk => blk.Cmds.Remove(blk.Cmds.Last()));
            rBlocks.Iter(blk =>
            {
                var gc = BoogieAstFactory.MkGotoCmd(nb.Label);
                gc.labelTargets = new List<Block>();
                gc.labelTargets.Add(nb);
                blk.TransferCmd = gc;
            });
            impl.Blocks.Add(nb);
            return nb.Label;
        }


        // check if two calls have the same arguments
        private static bool IsSame(CallCmd c1, CallCmd c2)
        {
            if (c1.Ins.Count != c2.Ins.Count) return false;
            if (c1.Outs.Count != c2.Outs.Count) return false;
            if (c1.callee != c2.callee) return false;

            var op = c1.Outs.Zip(c2.Outs, (ie1, ie2) => (ie1.Decl.Name == ie2.Decl.Name));
            if (op.Any(b => b == false)) return false;

            var ins = c1.Ins.Zip(c2.Ins, (e1, e2) => Tuple.Create(e1, e2));
            foreach (var pair in ins)
            {
                var e1 = pair.Item1 as IdentifierExpr;
                var e2 = pair.Item2 as IdentifierExpr;

                // TODO: more deeper check
                if (e1 == null || e2 == null) return false;
                if (e1.Decl.Name != e2.Decl.Name) return false;
            }
            return true;
        }
    }


    // Do variable slicing on p 
    public class VariableSlicePass : CompilerPass
    {
        VariableSlicing vslice;
        ModifyTrans tinfo;

        public VariableSlicePass(VarSet v)
        {
            tinfo = new ModifyTrans();
            vslice = new VariableSlicing(v, tinfo);
            passName = "Variable Slicing";
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Type information is needed in some cases. For instance, the Command
            // Mem[x] := untracked-expr is converted to havoc temp; Mem[x] := temp. Here
            // we need the type of "untracked-expr" or of "Mem[x]"
            if (p.Typecheck() != 0)
            {
                p.Emit(new TokenTextWriter("error.bpl"));
                throw new InternalError("Type errors");
            }
            vslice.VisitProgram(p as Program);
            BoogieUtil.DoModSetAnalysis(p);

            return p;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return tinfo.mapBackTrace(trace);
        }
    }


    // Compress basic blocks.
    public class CompressBlocksPass : CompilerPass
    {
        CompressBlocks compressBlocks;

        public CompressBlocksPass()
        {
            compressBlocks = new CompressBlocks();
            passName = "Compress blocks";
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            compressBlocks.VisitProgram(p);
            return p;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return compressBlocks.mapBackTrace(trace);
        }
    }


    // Composes passes together -- removes the need to store
    // intermediate program. 
    // Note: use only when the intermediate program is not needed
    // for the passes (e.g., in mapBackTrace)
    public class CompositePass : CompilerPass
    {
        List<CompilerPass> passes;

        public CompositePass(CompilerPass cp1, CompilerPass cp2)
        {
            passes = new List<CompilerPass>();
            passes.Add(cp1);
            passes.Add(cp2);
            passName = "Composite Pass ( ";
            foreach (CompilerPass cp in passes)
            {
                passName += cp.passName + " ";
            }
            passName += ")";
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Set the input for the first pass, just in case
            passes[0].setInput(input);

            CBAProgram curr = p;
            CBAProgram next = null;
            for (int i = 0; i < passes.Count; i++)
            {
                next = passes[i].runCBAPass(curr);
                curr = (next == null) ? curr : next;
            }

            return next;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            for (int i = passes.Count - 1; i >= 0 ; i--)
            {
                trace = passes[i].mapBackTrace(trace);
            }
            return trace;
        }
    }

    // Does inlining 
    public class InliningPass : CompilerPass
    {
        PersistentCBAProgram inlineInput;
        // inline recursion bound
        int bound;

        public InliningPass(int bound)
        {
            passName = "Inlining";
            inlineInput = null;
            this.bound = bound;
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Eliminate dead variables
            UnusedVarEliminator.Eliminate(p as Program);

            // Add the inlining bound
            addInlineAttribute(p);

            // Inline
            doInlining(p);

            // Remove the inlined procedures & implementations
            removeInlinedProcs(p);

            // Remove annotations that won't parse because of dropped variables
            RemoveVarsFromAttributes.Prune(p);

            return p;
        }

        private void addInlineAttribute(CBAProgram p)
        {
            foreach (var impl in p.TopLevelDeclarations.OfType<Implementation>())
            {
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                    continue;

                var proc = impl.Proc;
                var newattr = BoogieUtil.removeAttr("inline", proc.Attributes);

                Expr num = Expr.Literal(bound);
                var val = new List<object>();
                val.Add(num);

                proc.Attributes = new QKeyValue(Token.NoToken, "inline", val, newattr);
            }
        }

        private void doInlining(CBAProgram p)
        {
            inlineInput = new PersistentCBAProgram(p, p.mainProcName, p.contextBound);

            // Temporary fix for Boogie's bug while inlining calls
            // that have don't care expressions. This does not change the control
            // structure nor the number of commands per block -- hence, this transformation
            // need not be recorded.
            RewriteCallDontCares rdc = new RewriteCallDontCares();
            rdc.VisitProgram(p);

            // Copy of OnlyBoogie.EliminateDeadVariablesAndInline

            var TopLevelDeclarations = p.TopLevelDeclarations;
            bool inline = false;
            foreach (Declaration d in TopLevelDeclarations)
            {
                if ((d is Procedure || d is Implementation) && d.FindExprAttribute("inline") != null) inline = true;
            }
            if (inline)
            {
                foreach (Declaration d in TopLevelDeclarations)
                {
                    Implementation impl = d as Implementation;
                    if (impl != null)
                    {
                        impl.OriginalBlocks = impl.Blocks;
                        impl.OriginalLocVars = impl.LocVars;
                    }
                }
                foreach (Declaration d in TopLevelDeclarations)
                {
                    Implementation impl = d as Implementation;
                    if (impl != null && !impl.SkipVerification)
                    {
                        Inliner.ProcessImplementation(p as Program, impl);
                    }
                }
                foreach (Declaration d in TopLevelDeclarations)
                {
                    Implementation impl = d as Implementation;
                    if (impl != null)
                    {
                        impl.OriginalBlocks = null;
                        impl.OriginalLocVars = null;
                    }
                }
            }

        }

        // This inlines a program to the given inline depth.
        // Note: Set the flag CommandLineOptions.Clo.ProcedureInlining to get the
        // desired effect on leaf-level procedure calls
        public static void InlineToDepth(Program program)
        {
            var impls = program.TopLevelDeclarations.OfType<Implementation>();

            if (CommandLineOptions.Clo.InlineDepth < 0)
                return;
            /*
             * TODO: FIX!
            foreach (Implementation impl in impls)
            {
                var inlineRequiresVisitor = new Microsoft.Boogie.Houdini.InlineRequiresVisitor();
                inlineRequiresVisitor.Visit(impl);
            }

            foreach (Implementation impl in impls)
            {
                var freeRequiresVisitor = new Microsoft.Boogie.Houdini.FreeRequiresVisitor();
                freeRequiresVisitor.Visit(impl);
            }
            */
            foreach (Implementation impl in impls)
            {
                var inlineEnsuresVisitor = new Microsoft.Boogie.Houdini.InlineEnsuresVisitor();
                inlineEnsuresVisitor.Visit(impl);
            }

            foreach (Implementation impl in impls)
            {
                impl.OriginalBlocks = impl.Blocks;
                impl.OriginalLocVars = impl.LocVars;
            }
            foreach (Implementation impl in impls)
            {
                Inliner.ProcessImplementationForHoudini(program, impl);
            }
            foreach (Implementation impl in impls)
            {
                impl.OriginalBlocks = null;
                impl.OriginalLocVars = null;
            }
        }

        private void removeInlinedProcs(CBAProgram program)
        {
            HashSet<string> procsToRemove = new HashSet<string>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure)
                {
                    if (decl.FindExprAttribute("inline") != null)
                    {
                        procsToRemove.Add((decl as Procedure).Name);
                    }
                }
            }

            // Make sure we're not removing main
            procsToRemove.Remove(program.mainProcName);

            // Remove procs and Impls
            var newDecls = new List<Declaration>();

            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure)
                {
                    if (procsToRemove.Contains((decl as Procedure).Name))
                    {
                        continue;
                    }
                }
                else if (decl is Implementation)
                {
                    if (procsToRemove.Contains((decl as Implementation).Name))
                    {
                        continue;
                    }
                }

                newDecls.Add(decl);
            }

            program.TopLevelDeclarations = newDecls;
        }

        // Short-circuit the chain of returns produced by raiseException
        public void optimizeRaiseExceptionInstrumentation(CBAProgram program)
        {
            var procMap = BoogieUtil.nameImplMapping(program);
            var mainImpl = procMap[program.mainProcName];

            var labelBlockMap = BoogieUtil.labelBlockMapping(mainImpl);

            // For each block, check if the first statement is "assume raiseException"
            foreach (var blk in mainImpl.Blocks)
            {
                if (blk.Cmds.Count == 0)
                    continue;

                var cmd = blk.Cmds[0];

                if (!(cmd is AssumeCmd))
                    continue;

                var expr = (cmd as AssumeCmd).Expr;
                if (expr is IdentifierExpr)
                {
                    var v = (expr as IdentifierExpr).Decl;
                    if (v.Name != "raiseException")
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }

                // Yup, its "assume raiseException" -- follow the chain of gotos through empty blocks
                var lab = getSingleSucc(blk.TransferCmd);
                if (lab == null) continue;

                var b = labelBlockMap[lab];
                var chainLen = 0;

                /* Heuristic, possibly unsound: some blocks have a single statement that contains
                 * an assignment for the return value. Note that once raiseException has been raised,
                 * no return value is needed.
                 */
                while (b.Cmds.Count <= 1)
                {
                    var next = getSingleSucc(b.TransferCmd);
                    if (next == null)
                        break;
                    lab = next;
                    b = labelBlockMap[lab];
                    chainLen++;
                }

                blk.TransferCmd = BoogieAstFactory.MkGotoCmd(lab);

                if (chainLen != 0)
                {
                    Log.WriteLine(Log.Debug, "raiseException chain shortened by " + chainLen.ToString());
                }
            }

        }

        // If tcmd is "goto lab" then return lab, else return null
        private string getSingleSucc(TransferCmd tcmd)
        {
            if (!(tcmd is GotoCmd))
                return null;

            var gcmd = tcmd as GotoCmd;
            if (gcmd.labelNames.Count != 1)
                return null;
            return gcmd.labelNames[0];
        }

        private class WorkItemR
        {
            public Implementation impl;
            public Dictionary<string, Block> labelBlockMap;
            public Block block;
            public string label;
            public int count;

            public WorkItemR(Implementation i, string l)
            {
                impl = i;
                labelBlockMap = BoogieUtil.labelBlockMapping(impl);
                label = l;
                block = getBlock(label, labelBlockMap);
                count = 0;
            }

            private static Block getBlock(string lab, Dictionary<string, Block> dict)
            {
                Block ret;
                if (dict.TryGetValue(lab, out ret))
                {
                    Debug.Assert(ret != null);
                    return ret;
                }
                throw new InternalError("Unable to find label: " + lab);
            }

        }
                
        // Input: A trace in output (inlined version of input)
        // Output: The corresponding trace in input prog
        //
        // This procedure ignores the InstrInfo present in "trace". Currently,
        // there is no need to retain this information because we don't expect
        // trace to have any such information at all (because this trace is
        // produced by VerificationPass)
        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            trace = mapBackTraceInline(trace);
            return trace;
        }

        private ErrorTrace mapBackTraceInline(ErrorTrace trace)
        {
            Debug.Assert(trace.isIntra());

            Program inputProg = inlineInput.getProgram();

            var nameImplMap = BoogieUtil.nameImplMapping(inputProg);
            var traceLabels = trace.getBlockLabels();

            var stack = new List<WorkItemR>();
            Implementation startImpl = getImpl(trace.procName, nameImplMap);

            Debug.Assert(traceLabels[0] == startImpl.Blocks[0].Label);
            var curr = new WorkItemR(startImpl, traceLabels[0]);

            // This variable keeps our current position in traceLabels
            int ecount = 0;
            // This variable keeps our current position in traceLabels[ecount].Cmds
            int icount = 0;

            var ret = new ErrorTrace(trace.procName);
            ret.addBlock(new ErrorTraceBlock(traceLabels[0]));

            // We will walk over the input program, trying to cover the same path as
            // trace, knowing that trace represents an inlined path
            while (true)
            {
                // Reached the end of the path?
                if (ecount == traceLabels.Count)
                    break;

                //Console.WriteLine(curr.impl.Name + ": " + curr.label);

                // Reached the end of the current block?
                if (curr.count == curr.block.Cmds.Count)
                {
                    ecount++;
                    icount = 0;
                    if (ecount == traceLabels.Count)
                        break;

                    // Move onto the next block
                    TransferCmd tc = curr.block.TransferCmd;
                    if (tc is ReturnCmd)
                    {
                        ret.addReturn();

                        if (stack.Count == 0)
                        {
                            // We're done
                            Debug.Assert(ecount == traceLabels.Count);
                            break;
                        }
                        curr = stack[0];
                        stack.RemoveAt(0);

                        // An inlined procedure ends with "Return" label
                        Debug.Assert(inlinedLabelMatches("Return", traceLabels[ecount]));

                        ecount++;
                        icount = 0;
                        Debug.Assert(traceLabels[ecount].Contains(curr.block.Label));

                        continue;
                    }

                    if (tc is GotoCmd)
                    {
                        List<String> targets = (tc as GotoCmd).labelNames;
                        string target = matchInlinedLabelNames(targets, traceLabels[ecount]);
                        curr = new WorkItemR(curr.impl, target);
                        ret.addBlock(new ErrorTraceBlock(curr.label));
                        continue;
                    }

                    // Unknown transfer command
                    Debug.Assert(false);

                }

                // We have to continue in the same block
                Cmd c = curr.block.Cmds[curr.count];
                curr.count++;

                if (!(c is CallCmd))
                {
                    ret.addInstr(new IntraInstr(getInfo(trace, ecount, icount)));
                    icount++;
                    continue;
                }

                // We're at a procedure call
                CallCmd cc = c as CallCmd;

                // If this is a call to a procedure without implementation, then skip
                if (!nameImplMap.ContainsKey(cc.Proc.Name))
                {
                    ret.addInstr(new CallInstr(cc.Proc.Name, null, false, getInfo(trace, ecount, icount)));
                    icount++;
                    continue;
                }

                Implementation callee = getImpl(cc.Proc.Name, nameImplMap);
                string label = callee.Blocks[0].Label;
                // The first label in a inlined procedure is always called Entry
                ecount++;
                Debug.Assert(inlinedLabelMatches("Entry", traceLabels[ecount]));

                ecount++;
                icount = 0;
                Debug.Assert(inlinedLabelMatches(label, traceLabels[ecount]));

                WorkItemR next = new WorkItemR(callee, label);
                stack.Insert(0, curr);
                curr = next;

                ret.addCall(callee.Name);
                ret.addBlock(new ErrorTraceBlock(curr.label));
            }
            return ret;
        }

        private InstrInfo getInfo(ErrorTrace trace, int block, int cnt)
        {
            var blk = trace.Blocks[block];
            return blk.Cmds[cnt].info;
        }

        private static string matchInlinedLabelNames(List<String> strs, string inlined)
        {
            bool found = false;
            string ret = "";

            foreach (string str in strs)
            {
                if (str == inlined || inlinedLabelMatches(str, inlined))
                {
                    Debug.Assert(!found);
                    found = true;
                    ret = str;
                }
            }

            Debug.Assert(found);
            return ret;
        }

        private static bool inlinedLabelMatches(string str, string inlined)
        {
            str = "$" + str;
            return (inlined.EndsWith(str) && inlined.StartsWith("inline$"));
        }

        private static Implementation getImpl(string name, Dictionary<string, Implementation> dict)
        {
            Implementation impl;
            if (dict.TryGetValue(name, out impl))
            {
                Debug.Assert(impl != null);
                return impl;
            }
            throw new InternalError("Unable to find implementation: " + name);
        }
    }


    // Does loop unrolling 
    public class LoopUnrollingPass : CompilerPass
    {
        // Number of times to unroll
        public int unrollNum { get; private set; }

        public LoopUnrollingPass(int n)
        {
            unrollNum = n;
            passName = "Loop Unrolling (" + unrollNum.ToString() + ")";
        }

        public override CBAProgram runCBAPass(CBAProgram inp)
        {
            if (unrollNum < 0)
            {
                return null;
            }
            else
            {
                inp.UnrollLoops(unrollNum, false);
            }

            return inp;
        }
        
        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if (unrollNum < 0)
            {
                return trace;
            }

            return undoUnrolling(trace);
        }

        public static ErrorTrace undoUnrolling(ErrorTrace trace)
        {

            // The heuristic used here is to get rid of the "#num" sign in the labels.
            // We assume that is the only way that Boogie.UnrollLoops changes the labels
            ErrorTrace ret = new ErrorTrace(trace.procName);

            for (int i = 0, n = trace.Blocks.Count; i < n; i++)
            {
                ret.addBlock(new ErrorTraceBlock(sanitizeLabel(trace.Blocks[i].blockName)));

                foreach (var c in trace.Blocks[i].Cmds)
                {
                    if (c is CallInstr)
                    {
                        var cc = c as CallInstr;
                        if (cc.calleeTrace != null)
                        {
                            ret.addInstr(new CallInstr(undoUnrolling(cc.calleeTrace), cc.asyncCall, cc.info));
                            continue;
                        }
                    }
                    ret.addInstr(c);
                }
            }
            if (trace.returns)
            {
                ret.addReturn();
            }

            return ret;
        }

        // Remove the "#num" from the end of lab, if there is something like this
        public static string sanitizeLabel(string lab)
        {
            if (!lab.Contains('#'))
                return lab;

            // Find the last occurrance of "#"
            int pos = lab.LastIndexOf('#');

            return lab.Substring(0, pos);
        }

    }

    /* Static inlining and loop unrolling setting */
    public class StaticSettings
    {
        // Number of loop unrolling
        public int numLoopUnrolls;

        // Statically inline procedures?
        public int staticInlining;

        public StaticSettings(int unroll, int inline)
        {
            numLoopUnrolls = unroll;
            staticInlining = inline;
        }

    }

    public class StaticInliningAndUnrollingPass : CompilerPass
    {
        public StaticSettings settings { get; private set; }

        CompilerPass cp = null;

        public StaticInliningAndUnrollingPass(StaticSettings settings)
        {
            this.settings = settings;
            passName = "Static Inlining and Loop Unrolling (" + settings.staticInlining.ToString() + "," + settings.numLoopUnrolls.ToString() + ")";
            if (settings.numLoopUnrolls < 0 && settings.staticInlining <= 0)
            {
                // no-op
                cp = null;
            }
            else if (settings.numLoopUnrolls < 0)
            {
                cp = new InliningPass(settings.staticInlining);
            }
            else if (settings.staticInlining <= 0)
            {
                cp = new LoopUnrollingPass(settings.numLoopUnrolls);
            }
            else
            {
                cp = new CompositePass(new LoopUnrollingPass(settings.numLoopUnrolls), new InliningPass(settings.staticInlining));
            }
        }

        public override CBAProgram runCBAPass(CBAProgram inp)
        {
            if(cp == null) return null;

            cp.setInput(input);
            return cp.runCBAPass(inp);
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if (cp == null) return trace;
            return cp.mapBackTrace(trace);
        }
    }

    // A Pass that gets rid of "free requires" and "free ensures" by putting them
    // as assume statements inside the procedure implementation. This pass is sometimes
    // necessary because the Boogie "inliner" does not respect these annotations. Thus,
    // static inlining may differ some stratified inlining in these cases. This is not
    // important for corral (because these annotations always hold for all procedures with
    // implementation), but is important for cbugs that adds extra procedures.

    public class CompileRequiresAndEnsures : CompilerPass
    {

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            foreach (var decl in p.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                compile(impl);
            }

            return p;
        }

        public void compile(Implementation impl)
        {
            var ensures = impl.Proc.Ensures;
            var requires = impl.Proc.Requires;

            impl.Proc.Ensures = new List<Ensures>();
            impl.Proc.Requires = new List<Requires>();

            var reqCmds = new List<Cmd>();
            var ensCmds = new List<Cmd>();
            var newLocs = new List<Variable>();

            var substOld = new SubstOldVars();
            foreach(Ensures e in ensures) {
                Debug.Assert(e.Free);
                var expr = substOld.VisitExpr(e.Condition);
                ensCmds.Add(new AssumeCmd(Token.NoToken, expr, e.Attributes));
            }

            foreach(Requires r in requires) {
                Debug.Assert(r.Free);
                var vu = new VarsUsed();
                vu.VisitRequires(r);
                Debug.Assert(vu.oldVarsUsed.Count == 0);
                reqCmds.Add(new AssumeCmd(Token.NoToken, r.Condition, r.Attributes));
            }

            reqCmds.AddRange(substOld.initLocVars);

            substOld.varMap.Values.Iter(lv => newLocs.Add(lv));

            impl.LocVars.AddRange(newLocs);

            reqCmds.AddRange(impl.Blocks[0].Cmds);
            impl.Blocks[0].Cmds = reqCmds;

            foreach (var blk in impl.Blocks)
            {
                var rc = blk.TransferCmd as ReturnCmd;
                if (rc == null) continue;
                blk.Cmds.AddRange(ensCmds);
            }
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            throw new NotImplementedException();
        }

    }

    public class SubstOldVars : FixedVisitor
    {
        private bool insideOldExpr;
        public Dictionary<string, LocalVariable> varMap;
        public List<Cmd> initLocVars;

        public SubstOldVars()
        {
            insideOldExpr = false;
            varMap = new Dictionary<string, LocalVariable>();
            initLocVars = new List<Cmd>();
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            var previous = insideOldExpr;
            insideOldExpr = true;

            var ret = base.VisitOldExpr(node);

            insideOldExpr = previous;

            Debug.Assert(ret is OldExpr);

            // Drop the "old"
            return (ret as OldExpr).Expr;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (insideOldExpr)
            {
                Debug.Assert(!node.Name.StartsWith("old_lv_subst_"));
                if (!varMap.ContainsKey(node.Name))
                {
                    var lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                        "old_lv_subst_" + node.Name, node.Decl.TypedIdent.Type));
                    varMap.Add(node.Name, lv);
                    initLocVars.Add(BoogieAstFactory.MkVarEqVar(lv, node.Decl));
                }
                return new IdentifierExpr(Token.NoToken, varMap[node.Name]);
            }

            return node;
        }
    }
}