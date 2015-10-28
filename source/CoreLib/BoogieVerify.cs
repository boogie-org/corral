using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Microsoft.Boogie;
//using BoogiePL;
using System.Diagnostics.Contracts;
using System.IO;
using VC;
using cba.Util;

namespace cba.Util
{
    public static class BoogieVerify
    {
        public enum ReturnStatus { OK, NOK, ReachedBound };
        public static readonly string ExtraRecBoundAttr = "SIextraRecBound";

        // Verification options
        public static BoogieVerifyOptions options;

        // Unrolling for irreducible loops (default behavior: recursion bound)
        public static int irreducibleLoopUnroll = -1;

        // Stats or debugging flags
        public static TimeSpan verificationTime = TimeSpan.Zero;
        public static TimeSpan tempTime = TimeSpan.Zero;
        public static bool recordTempTime = false;
        public static int CallTreeSize = 0;
        public static int vcSize = 0;
        public static bool shuffleProgram = false;
        public static bool removeAsserts = true;
        public static string assertsPassed = "assertsPassed";
        public static bool assertsPassedIsInt = false;
        public static bool useDuality = false;

        // TODO: move this elsewhere
        public static HashSet<string> ignoreAssertMethods;

        public static void setTimeOut(int TO)
        {
            CommandLineOptions.Clo.ProverKillTime = -1;
            if (TO > 0)
            {
                CommandLineOptions.Clo.ProverKillTime = TO;
            }
        }

        // Note: This procedure calls Boogie routines that modify the input program.
        // But we ensure that the set of error traces returned (if any) correspond
        // to the original input program.
        public static ReturnStatus Verify(Program program,
                                          out List<BoogieErrorTrace> allErrors, bool isCBA = false)
        {
            var to = new List<string>();

            ReturnStatus ret = BoogieVerify.Verify(program, true, out allErrors, out to, isCBA);

            if (to.Count != 0)
                throw new InternalError("Z3 ran out of resources");

            return ret;
        }

        public static ReturnStatus Verify(Program program)
        {
            var ls = new List<BoogieErrorTrace>();
            var to = new List<string>();

            ReturnStatus ret = BoogieVerify.Verify(program, false, out ls, out to);
            if (to.Count != 0)
                throw new InternalError("Z3 ran out of resources");

            return ret;
        }

        public static ReturnStatus Verify(Program program,
                                          bool needErrorTraces,
                                          out List<BoogieErrorTrace> allErrors,
                                          out List<string> timedOut,
                                          bool isCBA = false)
        {
            ReturnStatus ret = ReturnStatus.OK;
            allErrors = new List<BoogieErrorTrace>();
            timedOut = new List<string>();
            Debug.Assert(program != null);
            
            // Make a copy of the input program
            var duper = new FixedDuplicator(true);
            var origProg = new Dictionary<string, Implementation>();

            if (needErrorTraces)
            {
                foreach (var decl in program.TopLevelDeclarations)
                {
                    if (decl is Implementation)
                    {
                        var origImpl = duper.VisitImplementation(decl as Implementation);
                        origProg.Add(origImpl.Name, origImpl);
                    }
                }
            }
            
            if (removeAsserts)
                RemoveAsserts(program);
            
            // Set options
            options.Set();

            // save RB
            var rb = CommandLineOptions.Clo.RecursionBound;
            if (BoogieVerify.irreducibleLoopUnroll >= 0)
                CommandLineOptions.Clo.RecursionBound = BoogieVerify.irreducibleLoopUnroll;

            // Do loop extraction
            var extractionInfo = program.ExtractLoops();

            // restore RB
            CommandLineOptions.Clo.RecursionBound = rb;

            // set bounds
            if (options.extraRecBound != null)
            {
                options.extraRecBound.Iter(tup =>
                    {
                        var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, tup.Key);
                        if (impl != null) impl.AddAttribute(BoogieVerify.ExtraRecBoundAttr, Expr.Literal(tup.Value));
                    });
            }

            #region Save program to disk
            if (shuffleProgram)
            {
                BoogieUtil.PrintProgram(program, "last_query.bpl");
                program = BoogieUtil.ReadAndResolve("last_query.bpl");
            }

            if (options.printProg)
            {
                Debug.Assert(options.progFileName != null, "Invalid options");
                BoogieUtil.PrintProgram(program, options.progFileName);
            }
            #endregion

            var origBlocks = new Dictionary<string, Tuple<Block, Implementation>>();

            // ---------- Infer invariants --------------------------------------------------------

            // Abstract interpretation -> Always use (at least) intervals, if not specified otherwise (e.g. with the "/noinfer" switch)
            //Microsoft.Boogie.AbstractInterpretation.AbstractInterpretation.RunAbstractInterpretation(program);

            //// ---------- Verify ----------------------------------------------------------------

            var mains = new List<Implementation>(
                program.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")));


            VC.VCGen vcgen = null;
            try
            {
                Debug.Assert(CommandLineOptions.Clo.vcVariety != CommandLineOptions.VCVariety.Doomed);
                Debug.Assert (CommandLineOptions.Clo.StratifiedInlining > 0);
                if (options.newStratifiedInlining) {
                  if(options.newStratifiedInliningAlgo.ToLower() == "duality") Microsoft.Boogie.SMTLib.Factory.UseInterpolation = true;
                  vcgen = new CoreLib.StratifiedInlining(program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, null);
                }
                else
                   // vcgen = new VC.StratifiedVCGen(options.CallTree != null, options.CallTree, options.procsToSkip, options.extraRecBound, program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, new List<Checker>());


                    if (!useDuality || !isCBA || !needErrorTraces || options.StratifiedInlining > 1 || mains.Count > 1)
                        vcgen = new VC.StratifiedVCGen(options.CallTree != null, options.CallTree, program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, new List<Checker>()); 
                    else
                    {
                        CommandLineOptions.Clo.FixedPointMode = CommandLineOptions.FixedPointInferenceMode.Corral;
                        CommandLineOptions.Clo.FixedPointEngine = "duality";
                        vcgen = new Microsoft.Boogie.FixedpointVC(program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, new List<Checker>(), options.extraRecBound);
                    }
            }
            catch (ProverException e)
            {
                Log.WriteLine(Log.Error, "ProverException: {0}", e.Message);
                return ReturnStatus.OK;
            }

            if (!mains.Any())
                throw new InternalError("No entrypoint found");

            if (mains.Count > 1)
                Console.WriteLine("Verifying {0} impls", mains.Count);

            foreach (var impl in mains)
            {
                Log.WriteLine(Log.Debug, "Verifying implementation " + impl.Name);

                List<Counterexample> errors;

                VC.VCGen.Outcome outcome;

                try
                {
                    var start = DateTime.Now;

                    outcome = vcgen.VerifyImplementation(impl, out errors);

                    var end = DateTime.Now;

                    TimeSpan elapsed = end - start;
                    Log.WriteLine(Log.Debug, string.Format("  [{0} s]  ", elapsed.TotalSeconds));

                    verificationTime += elapsed;
                    if (recordTempTime) tempTime += elapsed;
                }
                catch (VC.VCGenException e)
                {
                    throw new InternalError("VCGenException: " + e.Message);
                    //errors = null;
                    //outcome = VC.VCGen.Outcome.Inconclusive;
                }
                catch (UnexpectedProverOutputException upo)
                {

                    throw new InternalError("Unexpected prover output: " + upo.Message);
                    //errors = null;
                    //outcome = VC.VCGen.Outcome.Inconclusive;
                }

                switch (outcome)
                {
                    case VC.VCGen.Outcome.Correct:
                        break;
                    case VC.VCGen.Outcome.Errors:
                        break;
                    case VC.VCGen.Outcome.ReachedBound:
                        ret = ReturnStatus.ReachedBound;
                        break;
                    case VC.VCGen.Outcome.Inconclusive:
                        throw new InternalError("z3 says inconclusive");
                    case VC.VCGen.Outcome.OutOfMemory:
                        // wipe out any counterexamples
                        timedOut.Add(impl.Name); errors = new List<Counterexample>();
                        break;
                    case VC.VCGen.Outcome.TimedOut:
                        // wipe out any counterexamples
                        timedOut.Add(impl.Name); errors = new List<Counterexample>();
                        break;
                    default:
                        throw new InternalError("z3 unknown response");
                }

                Log.WriteLine(Log.Debug, outcome.ToString());

                Log.WriteLine(Log.Debug, (errors == null ? 0 : errors.Count) + " counterexamples.");
                if (errors != null) ret = ReturnStatus.NOK;

                // Print model
                if (errors != null && errors.Count > 0 && errors[0].Model != null && CommandLineOptions.Clo.ModelViewFile != null)
                {
                    var model = errors[0].Model;
                    var cnt = 0;
                    model.States.Iter(st =>
                    {
                        if (st.Name.StartsWith("corral"))
                        {
                            st.ChangeName(st.Name + "_" + cnt.ToString()); cnt++;
                        }
                    });

                    using (var wr = new StreamWriter(CommandLineOptions.Clo.ModelViewFile, false))
                    {
                        model.Write(wr);
                    }
                }

                if (errors != null && needErrorTraces)
                {
                    for (int i = 0; i < errors.Count; i++)
                    {
                        //errors[i].Print(1, Console.Out);

                        // Map the trace across loop extraction
                        if (vcgen is VC.VCGen)
                        {
                            errors[i] = (vcgen as VC.VCGen).extractLoopTrace(errors[i], impl.Name, program, extractionInfo);
                        }

                        if (errors[i] is AssertCounterexample)
                        {
                            // Special treatment for assert counterexamples for CBA: Reconstruct
                            // trace in the input program.
                            ReconstructImperativeTrace(errors[i], impl.Name, origProg);
                            allErrors.Add(new BoogieAssertErrorTrace(errors[i] as AssertCounterexample, origProg[impl.Name], program));
                        }
                        else
                        {
                            allErrors.Add(new BoogieErrorTrace(errors[i], origProg[impl.Name], program));
                        }
                    }
                }

            }

            //PutBackAsserts(program);

            if (vcgen is StratifiedVCGen)
            {
                CallTreeSize = (vcgen as StratifiedVCGen).numInlined;
                vcSize = (vcgen as StratifiedVCGen).vcsize;
                if (options.CallTree != null)
                {
                    options.CallTree = VC.StratifiedVCGen.callTree;
                    VC.StratifiedVCGen.callTree = null;
                }
            }
            else if (vcgen is CoreLib.StratifiedInlining)
            {
                CallTreeSize = (vcgen as CoreLib.StratifiedInlining).stats.numInlined;
                vcSize = (vcgen as CoreLib.StratifiedInlining).stats.vcSize;
                if (options.CallTree != null)
                {
                    options.CallTree = (vcgen as CoreLib.StratifiedInlining).GetCallTree();
                }
            }
            else
                CallTreeSize = 0;

            vcgen.Close();
            CommandLineOptions.Clo.TheProverFactory.Close();

            return ret;
        }

        private static void DFS(Block root, Block parent, Func<Block, IEnumerable<Block>> Succ, Dictionary<Block, int> color, Dictionary<Block, Block> parentTree, List<Block> cycle)
        {
            if (color[root] == 2)
                return;

            if (color[root] == 1)
            {
                Console.WriteLine("Cycle found");
                while (root != parent)
                {
                    cycle.Add(parent);
                    parent = parentTree[parent];
                }
                cycle.Add(root);
                throw new Exception("");
            }

            parentTree[root] = parent;

            color[root] = 1;
            
            var succs = Succ(root);
            foreach (var s in succs)
                DFS(s, root, Succ, color, parentTree, cycle);

            color[root] = 2;
        }

        private static HashSet<string> ProcsThatCannotReachAssert(Program program)
        {
            return new HashSet<string>();
        }

        // Rename basic blocks, local variables
        // Add "havoc locals" at the beginning
        // block return
        private static void RenameImpl(Implementation impl, Dictionary<string, Tuple<Block,Implementation>> origProg)
        {
            var origImpl = (new FixedDuplicator(true)).VisitImplementation(impl);
            var origBlocks = BoogieUtil.labelBlockMapping(origImpl);

            // create new locals
            var newLocals = new Dictionary<string, Variable>();
            foreach (var l in impl.LocVars.Concat(impl.InParams).Concat(impl.OutParams))
            {
                // substitute even formal variables with LocalVariables. This is fine
                // because we finally just merge all implemnetations together
                var nl = BoogieAstFactory.MkLocal(l.Name + "_" + impl.Name + "_copy", l.TypedIdent.Type);
                newLocals.Add(l.Name, nl);
            }

            // rename locals
            var subst = new VarSubstituter(newLocals, new Dictionary<string, Variable>());
            subst.VisitImplementation(impl);

            // Rename blocks 
            foreach (var blk in impl.Blocks)
            {
                var newName = impl.Name + "_" + blk.Label;
                origProg.Add(newName, Tuple.Create(origBlocks[blk.Label], origImpl));
                blk.Label = newName;

                if (blk.TransferCmd is GotoCmd)
                {
                    var gc = blk.TransferCmd as GotoCmd;
                    gc.labelNames = new List<string>(
                        gc.labelNames.Select(lab => impl.Name + "_" + lab));
                }

                if (blk.TransferCmd is ReturnCmd)
                {
                    // block return
                    blk.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.False));
                }
            }

            /*
            // havoc locals -- not necessary
            if (newLocals.Count > 0)
            {
                var ies = new List<IdentifierExpr>();
                newLocals.Values.Iter(v => ies.Add(Expr.Ident(v)));
                impl.Blocks[0].Cmds.Insert(0, new HavocCmd(Token.NoToken, ies));
            }
             */
        }

        // Check that assert and return only appear together 
        private static void RemoveAsserts(Program program)
        {
            var mains = program.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));

            foreach (var main in mains)
            {
                foreach (var blk in main.Blocks)
                {
                    var isReturn = (blk.TransferCmd is ReturnCmd);
                    var assertPos = -2;
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        if (BoogieUtil.isAssertTrue(blk.Cmds[i]))
                            continue;

                        if (blk.Cmds[i] is AssertCmd)
                        {
                            assertPos = i;
                            break;
                        }
                    }

                    if (!isReturn && assertPos != -2)
                    {
                        BoogieUtil.PrintProgram(program, "error.bpl");
                        throw new InternalError("assert is not followed by return");
                    }

                    if (isReturn)
                    {
                        if (assertPos != blk.Cmds.Count - 1)
                        {
                            //throw new InternalError("return is not preceeded by an assert");
                            blk.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.False));
                        }
                        else
                        {
                            var assertcmd = blk.Cmds[assertPos] as AssertCmd;
                            blk.Cmds[assertPos] = new AssumeCmd(Token.NoToken, Expr.Not(assertcmd.Expr),
                                new QKeyValue(Token.NoToken, "OldAssert", new List<object>(), null));
                        }
                    }

                }
            }
        }

        private static void PutBackAsserts(Program program)
        {
            var mains = program.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));

            foreach (var main in mains)
            {
                foreach (var blk in main.Blocks.Where(blk => blk.TransferCmd is ReturnCmd))
                {
                    Debug.Assert(blk.Cmds.Count > 0);
                    var acmd = blk.Cmds.Last() as AssumeCmd;
                    Debug.Assert(acmd != null);
                    Debug.Assert(QKeyValue.FindBoolAttribute(acmd.Attributes, "OldAssert"));
                    var expr = acmd.Expr as NAryExpr;
                    Debug.Assert(expr != null);
                    Debug.Assert(expr.Fun is UnaryOperator);
                    blk.Cmds[blk.Cmds.Count - 1] = new AssertCmd(Token.NoToken, expr.Args[0]);
                }
            }

        }

        // Assumptions:
        //  - Program has no recursion
        public static HashSet<string> FindLeastToVerify(Program program, HashSet<string> boolVars)
        {
            Debug.Assert(program != null);

            RemoveAsserts(program);

            if (options.printProg)
            {
                BoogieUtil.PrintProgram(program, options.progFileName);
            }

            //// ---------- Verify ----------------------------------------------------------------
            Debug.Assert(CommandLineOptions.Clo.StratifiedInlining > 0);

            VC.StratifiedVCGenBase vcgen = null;
            try
            {
                if(options.newStratifiedInlining) 
                    vcgen = new CoreLib.StratifiedInlining(program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, null);
                else
                    vcgen = new VC.StratifiedVCGen(program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, new List<Checker>());
            }
            catch (ProverException)
            {
                Log.WriteLine(Log.Error, "ProverException: {0}");
                return new HashSet<string>();
            }

            var mains = program.TopLevelDeclarations
                .OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));

            if (mains.Count() != 1)
                throw new InternalError("Wrong number of entrypoints for FindLeastToverify");

            var main = mains.First();

            VC.VCGen.Outcome outcome;
            //HashSet<string> minVars = new HashSet<string>();

            try
            {
                var start = DateTime.Now;

                outcome = vcgen.FindLeastToVerify(main, ref boolVars);

                var end = DateTime.Now;

                TimeSpan elapsed = end - start;
                Log.WriteLine(Log.Debug, string.Format("  [{0} s]  ", elapsed.TotalSeconds));

                verificationTime += elapsed;
                if (recordTempTime) tempTime += elapsed;
            }
            catch (VC.VCGenException e)
            {
                throw new InternalError("VCGenException: " + e.Message);
                //errors = null;
                //outcome = VC.VCGen.Outcome.Inconclusive;
            }
            catch (UnexpectedProverOutputException upo)
            {

                throw new InternalError("Unexpected prover output: " + upo.Message);
                //errors = null;
                //outcome = VC.VCGen.Outcome.Inconclusive;
            }

            switch (outcome)
            {
                case VC.VCGen.Outcome.Correct:
                    break;
                case VC.VCGen.Outcome.Errors:
                    Debug.Assert(false);
                    break;
                case VC.VCGen.Outcome.ReachedBound:
                    Debug.Assert(false);
                    break;
                case VC.VCGen.Outcome.Inconclusive:
                    throw new InternalError("z3 says inconclusive");
                case VC.VCGen.Outcome.OutOfMemory:
                    throw new InternalError("z3 out of memory");
                case VC.VCGen.Outcome.TimedOut:
                    throw new InternalError("z3 timed out");
                default:
                    throw new InternalError("z3 unknown response");
            }
            Debug.Assert(outcome == VC.VCGen.Outcome.Correct);

            vcgen.Close();
            CommandLineOptions.Clo.TheProverFactory.Close();
            return boolVars;
        }

        // Computes the set of unique procs inlined by looking at the inlined call tree
        public static HashSet<string> UniqueProcsInlined()
        {
            var ret = new HashSet<string>();
            if (options.CallTree == null) return ret;

            foreach (var s in options.CallTree)
            {
                var tokens = s.Split(new string[] {"_131_"}, StringSplitOptions.RemoveEmptyEntries);
                if (tokens.Length < 2) continue;
                ret.Add(tokens[tokens.Length - 2]);
            }
            return ret;
        }

        public static Counterexample ReconstructTrace(Counterexample trace, string currProc, TraceLocation currLocation, Dictionary<string, Tuple<Block, Implementation>> origProg)
        {
            // we cannot be starting in the last block
            Debug.Assert(currLocation.numBlock != trace.Trace.Count - 1);
            // we cannot be starting in the middle of a block
            Debug.Assert(currLocation.numInstr == 0);

            var newTrace = new List<Block>();
            var newTraceCallees = new Dictionary<TraceLocation, CalleeCounterexampleInfo>();
            
            Block currOrigBlock = null;
            Implementation currOrigImpl = null;
            int currOrigInstr = 0;

            while (true)
            {
                if (currLocation.numInstr == 0 && origProg.ContainsKey(trace.Trace[currLocation.numBlock].Label))
                {
                    var origPlace = origProg[trace.Trace[currLocation.numBlock].Label];
                    if (currOrigImpl != null && currOrigImpl.Name != origPlace.Item2.Name)
                    {
                        // change of proc

                        // First, recurse
                        var calleeTrace = ReconstructTrace(trace, origPlace.Item2.Name, currLocation, origProg);
                        // Find the call to this guy in currOrigBlock
                        while (currOrigInstr < currOrigBlock.Cmds.Count)
                        {
                            var cmd = currOrigBlock.Cmds[currOrigInstr] as CallCmd;
                            if (cmd != null && cmd.callee == origPlace.Item2.Name)
                                break;
                            currOrigInstr++;
                        }
                        Debug.Assert(currOrigInstr != currOrigBlock.Cmds.Count);
                        newTraceCallees.Add(new TraceLocation(newTrace.Count - 1, currOrigInstr), new CalleeCounterexampleInfo(calleeTrace, new List<object>()));
                        // we're done
                        break;
                    }

                    currOrigBlock = origPlace.Item1;
                    currOrigImpl = origProg[trace.Trace[currLocation.numBlock].Label].Item2;
                    currOrigInstr = 0;

                    newTrace.Add(currOrigBlock);
                }

                if (trace.calleeCounterexamples.ContainsKey(currLocation))
                {
                    // find the corresponding call in origBlock
                    var calleeInfo = trace.calleeCounterexamples[currLocation];
                    var calleeName = trace.getCalledProcName(trace.Trace[currLocation.numBlock].Cmds[currLocation.numInstr]);
                    while (currOrigInstr < currOrigBlock.Cmds.Count)
                    {
                        var cmd = currOrigBlock.Cmds[currOrigInstr] as CallCmd;
                        if (cmd != null && cmd.callee == calleeName)
                            break;
                        currOrigInstr++;                        
                    }
                    Debug.Assert(currOrigInstr != currOrigBlock.Cmds.Count);
                    newTraceCallees.Add(new TraceLocation(newTrace.Count - 1, currOrigInstr), calleeInfo);
                }

                // increment location
                currLocation.numInstr++;
                if (currLocation.numInstr >= trace.Trace[currLocation.numBlock].Cmds.Count)
                {
                    currLocation.numBlock++;
                    currLocation.numInstr = 0;
                }
                if (currLocation.numBlock == trace.Trace.Count)
                    break;
            }

            var ret = new AssertCounterexample(newTrace, null, trace.Model, trace.MvInfo, trace.Context);
            ret.calleeCounterexamples = newTraceCallees;

            return ret;
        }

        // Note: this does not reconstruct the failing assert in trace
        public static void ReconstructImperativeTrace(Counterexample trace, string currProc, Dictionary<string, Implementation> origProg)
        {
            if (trace == null) return;

            var originalBlocks = BoogieUtil.labelBlockMapping(origProg[currProc]);

            var newBlocks = new List<Block>();
            var newCalleeTraces = new Dictionary<TraceLocation, CalleeCounterexampleInfo>();

            for (int numBlock = 0; numBlock < trace.Trace.Count; numBlock++)
            {
                Block b = trace.Trace[numBlock];

                Block ib;
                originalBlocks.TryGetValue(b.Label, out ib);
                if (ib == null)
                {
                    // Such blocks correspond to "itermediate" blocks inserted
                    // by Boogie. We can ignore them. (But note that we should
                    // still check that the counterexample is a valid path in impl
                    // to guard against vagaries of Boogie.)

                    //Log.Out(Log.Normal, "Could not find block " + b.Label);
                    //b.Emit(new TokenTextWriter(Console.Out), 0);
                    for (int numInstr = 0; numInstr < b.Cmds.Count; numInstr++)
                    {
                        if (trace.calleeCounterexamples.ContainsKey(new TraceLocation(numBlock, numInstr)))
                        {
                            throw new InternalError("BoogieVerify: An intermediate block has a procedure call");
                        }
                    }

                }
                else
                {
                    // We have a corresponding block. The number of Commands in b and ib won't match. We
                    // simply use all of the Cmds of ib -- and match the calls manually
                    // TODO: Fix this! It doesn't work when the failing assert is not the last statement 
                    // of the block
                    newBlocks.Add(ib);
                    var calleeTraces = new List<Duple<string, CalleeCounterexampleInfo>>();
                    for (int numInstr = 0; numInstr < b.Cmds.Count; numInstr++)
                    {
                        var loc = new TraceLocation(numBlock, numInstr);
                        if (trace.calleeCounterexamples.ContainsKey(loc))
                        {
                            Cmd c = b.Cmds[numInstr];
                            var calleeName = trace.getCalledProcName(c);
                            var calleeTrace = trace.calleeCounterexamples[loc].counterexample;
                            ReconstructImperativeTrace(calleeTrace, calleeName, origProg);
                            calleeTraces.Add(
                                new Duple<string, CalleeCounterexampleInfo>(
                                    calleeName,
                                    new CalleeCounterexampleInfo(calleeTrace,
                                        trace.calleeCounterexamples[loc].args)
                                        ));
                        }
                    }

                    // Check consistency and map calleeTraces to the actual call instructions
                    var currCount = 0;
                    for (int numInstr = 0; numInstr < ib.Cmds.Count; numInstr++)
                    {
                        Cmd c = ib.Cmds[numInstr];

                        if (!(c is CallCmd))
                            continue;

                        var cc = c as CallCmd;

                        // No more calls left to process
                        if (calleeTraces.Count <= currCount)
                            break;

                        if (cc.Proc.Name != calleeTraces[currCount].fst)
                            continue;

                        // Check if this proc has an implementation
                        //if (!origProg.ContainsKey(cc.Proc.Name))
                        //    continue;

                        // Check if the proc is inlined
                        //if (QKeyValue.FindExprAttribute(cc.Proc.Attributes, "inline") == null)
                        //    continue;

                        // Some thing wrong about the interprocedural trace returned by Boogie if the
                        // following don't match
                        // TODO: Fix when the failing assert is not the last statement of the block
                        //Debug.Assert(cc.Proc.Name == calleeTraces[currCount].fst);

                        newCalleeTraces.Add(new TraceLocation(newBlocks.Count - 1, numInstr), calleeTraces[currCount].snd);
                        currCount++;
                    }
                }
            }
            trace.Trace = newBlocks;
            // reset other info. Safe thing to do unless we know what it is
            trace.relatedInformation = new List<string>();
            trace.calleeCounterexamples = newCalleeTraces;
        }
    }

    public class BoogieVerifyOptions
    {
        // For eager inlining
        public int StratifiedInlining
        {
            get
            {
                return _stratifiedInlining;
            }
            set
            {
                Debug.Assert(value > 0);
                _stratifiedInlining = value;
            }
        }
        private int _stratifiedInlining;

        public bool newStratifiedInlining;
        public string newStratifiedInliningAlgo;

        public bool NonUniformUnfolding;

        public HashSet<string> CallTree;

        public bool StratifiedInliningWithoutModels;
        public bool UseProverEvaluate;
        public string ModelViewFile;

        public bool useFwdBck;
        public bool useDI;

        // Bound on maximum procs that can be inlined (0 = no bound)
        public int maxInlinedBound;

        // Printing the program setnt to Boogie
        public bool printProg;
        public string progFileName;

        // Extended API
        public Dictionary<string, int> extraRecBound;
        public HashSet<string> extraFlags;

        // Default options
        public BoogieVerifyOptions()
        {
            StratifiedInlining = 1;
            newStratifiedInlining = false;
            newStratifiedInliningAlgo = null;
            NonUniformUnfolding = false;
            CallTree = null;
            StratifiedInliningWithoutModels = false;
            UseProverEvaluate = true;
            ModelViewFile = null;
            printProg = false;
            progFileName = null;
            extraRecBound = new Dictionary<string, int>();
            useFwdBck = false;
            useDI = false;
            extraFlags = new HashSet<string>();
            maxInlinedBound = 0;
        }

        public BoogieVerifyOptions Copy()
        {
            var ret = new BoogieVerifyOptions();
            ret.StratifiedInlining = StratifiedInlining;
            ret.newStratifiedInlining = newStratifiedInlining;
            ret.newStratifiedInliningAlgo = newStratifiedInliningAlgo;
            ret.NonUniformUnfolding = NonUniformUnfolding;
            ret.CallTree = CallTree;
            if (CallTree != null)
            {
                ret.CallTree = new HashSet<string>(CallTree);
            }
            ret.StratifiedInliningWithoutModels = StratifiedInliningWithoutModels;
            ret.UseProverEvaluate = UseProverEvaluate;
            ret.ModelViewFile = ModelViewFile;
            ret.printProg = printProg;
            ret.progFileName = progFileName;
            ret.useFwdBck = useFwdBck;
            ret.useDI = useDI;
            ret.maxInlinedBound = maxInlinedBound;
            ret.extraRecBound = new Dictionary<string, int>(ret.extraRecBound);
            ret.extraFlags.UnionWith(extraFlags);

            return ret;
        }

        // Invariant: This method should be idempotent, i.e., it should always
        // overwrite all options set by a previous call to Set
        public void Set()
        {
            CommandLineOptions.Clo.StratifiedInlining = StratifiedInlining;
            CommandLineOptions.Clo.NonUniformUnfolding = NonUniformUnfolding;
            CommandLineOptions.Clo.StratifiedInliningWithoutModels = StratifiedInliningWithoutModels;
            CommandLineOptions.Clo.UseProverEvaluate = UseProverEvaluate;
            if (!StratifiedInliningWithoutModels && ModelViewFile != null)
                CommandLineOptions.Clo.ModelViewFile = ModelViewFile;
        }
    }

    public class BoogieErrorTrace
    {
        public Counterexample cex { get; protected set; }
        public Implementation impl { get; protected set; }
        public Program prog { get; protected set; }

        public BoogieErrorTrace(Counterexample c, Implementation m, Program p)
        {
            cex = c;
            impl = m;
            prog = p;
        }

        /*
        public void print(TokenTextWriter ttw)
        {
            foreach (Block b in cex.Trace)
                b.Emit(ttw, 0);
        }
        */

        public void printLabels(TokenTextWriter ttw)
        {
            printLabels(cex, ttw, 0);
        }

        private static void printLabels(Counterexample cex, TokenTextWriter ttw, int indent)
        {
            for (int numBlock = 0; numBlock < cex.Trace.Count; numBlock++)
            {
                Block b = cex.Trace[numBlock];

                printIndent(ttw, indent);
                ttw.WriteLine(b.Label);

                for (int numInstr = 0; numInstr < b.Cmds.Count; numInstr++)
                {
                    Cmd c = b.Cmds[numInstr];
                    var loc = new TraceLocation(numBlock, numInstr);
                    if (cex.calleeCounterexamples.ContainsKey(loc))
                    {
                        printIndent(ttw, indent); ttw.WriteLine("call to {0}:", (c as CallCmd).Proc.Name);
                        printLabels(cex.calleeCounterexamples[loc].counterexample, ttw, indent + 1);
                        printIndent(ttw, indent); ttw.WriteLine("return from {0}.", (c as CallCmd).Proc.Name);
                        printIndent(ttw, indent); ttw.WriteLine(b.Label);
                    }
                }
            }

        }

        private static void printIndent(TokenTextWriter ttw, int indent)
        {
            for (int i = 0; i < indent; i++)
            {
                ttw.Write(" ");
            }
        }


        protected List<string> getLabels()
        {
            var ret = new List<string>();
            foreach (Block b in cex.Trace)
                ret.Add(b.Label);
            return ret;
        }

    }

    public class BoogieAssertErrorTrace : BoogieErrorTrace
    {

        AssertCounterexample acex;

        public BoogieAssertErrorTrace(AssertCounterexample c, Implementation m, Program p)
            : base(c, m, p)
        {
            acex = c;
        }

        // Concatenate all the commands in the error trace. 
        private Block getCmdSeq(out HashSet<string> calledProcs)
        {
            calledProcs = new HashSet<string>();

            // First, gather the set of all labels (used only for debugging purposes)
            var allLabels = new HashSet<string>();
            foreach (Block b in cex.Trace)
            {
                allLabels.Add(b.Label);
            }

            List<Cmd> clist = new List<Cmd>();
            List<String> prev_labels = null;
            foreach (Block b in cex.Trace)
            {
                //b.Emit(new TokenTextWriter(Console.Out), 0);
                if (prev_labels != null)
                {
                    if (!prev_labels.Contains(b.Label))
                    {
                        // This means that we went through a fake block
                        // inserted by boogie verifier
                        Debug.Assert(!allLabels.Any(x => prev_labels.Contains(x)));
                    }
                }

                foreach (Cmd c in b.Cmds)
                {
                    if (c is CallCmd)
                    {
                        CallCmd cc = c as CallCmd;
                        calledProcs.Add(cc.Proc.Name);
                    }
                    clist.Add(c);
                }

                GotoCmd gcmd = b.TransferCmd as GotoCmd;
                if (gcmd != null)
                {
                    prev_labels = gcmd.labelNames;
                }
                else
                {
                    prev_labels = new List<String>();
                }
            }

            // Return a block with label the same as the label of the first block of the counter example, and a
            // return command in the end.
            return new Block(Token.NoToken, cex.Trace[0].Label, clist, new ReturnCmd(Token.NoToken));

        }

        // Return the counterexample as an implementation with a single basic block.
        private Implementation getImplementation(out HashSet<string> calledProcs)
        {
            Block trace = getCmdSeq(out calledProcs);
            var blocks = new List<Block>();
            blocks.Add(trace);

            return new Implementation(Token.NoToken, impl.Name + "_cex", impl.TypeParameters, impl.InParams,
                impl.OutParams, impl.LocVars, blocks, impl.Attributes);

        }

        // Verify that the trace is a valid counterexample (i.e., it returns an assertion-failure counterexample
        // upon verification.
        // Returns a program that consists of a single implementation with a single basic
        // block that contains the trace.
        public bool verifyTrace(out Program newProg)
        {
            // Currently, this only works for intraprocedural traces
            Debug.Assert(acex.calleeCounterexamples.Count == 0);

            HashSet<string> calledProcs;
            Implementation traceImpl = getImplementation(out calledProcs);

            newProg = new Program();

            // The set of called procedures should only be ones
            // that do not have an implementation
            foreach (Declaration decl in prog.TopLevelDeclarations)
            {
                if (decl is GlobalVariable)
                {
                    newProg.AddTopLevelDeclaration(decl);
                }
                else if (decl is Procedure)
                {
                    Procedure tmp = decl as Procedure;
                    if (calledProcs.Contains(tmp.Name))
                    {
                        newProg.AddTopLevelDeclaration(decl);
                    }
                    else if (tmp.Name == impl.Name)
                    {
                        Procedure pex = new Procedure(Token.NoToken, tmp.Name + "_cex", tmp.TypeParameters, tmp.InParams,
                            tmp.OutParams, tmp.Requires, tmp.Modifies, tmp.Ensures, tmp.Attributes);
                        newProg.AddTopLevelDeclaration(pex);
                    }
                }
                else if (decl is Implementation)
                {
                    Implementation tmp = decl as Implementation;
                    Debug.Assert(!calledProcs.Contains(tmp.Name));
                }
                else
                {
                    // Just add the other guys (axioms, functions, etc.)
                    newProg.AddTopLevelDeclaration(decl);
                }
            }

            newProg.AddTopLevelDeclaration(traceImpl);

            newProg = BoogieUtil.ReResolve(newProg, "cex.bpl");
            Program newProgCopy = BoogieUtil.ReadAndResolve("cex.bpl");
            // (We need to create a copy because Boogie.Verify changes the input program)

            var errors = new List<BoogieErrorTrace>();
            var ret = BoogieVerify.Verify(newProgCopy, out errors);
            if (ret != BoogieVerify.ReturnStatus.NOK)
            {
                return false;
            }

            return true;
        }

    }

}