using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using Microsoft.Boogie.Houdini;

namespace cba
{
    /* A verification pass is one that actually calls Boogie to get an error trace */
    public class VerificationPass : CompilerPass
    {
        // Did the call to Boogie succeed (i.e., returned "verified")?
        public bool success { get; protected set; }

        // Did the verification reach the recursion bound?
        public bool reachedBound { get; private set; }

        // The error traces
        public List<ErrorTrace> traces { get; protected set; }

        // The first trace
        public ErrorTrace trace
        {
            get
            {
                if (traces == null || traces.Count == 0)
                    return null;
                return traces[0];
            }
        }

        // Error trace needed?
        protected bool needErrorTraces;

        // The set of global variables that were used in proof of correctness
        // TODO: This is not yet computed!
        //public Set<string> globalsUsedForProof { get; private set; }

        // For pruning a program
        PruneProgramPass prune;
        public static bool usePruning = true;

        // The set of global variables whose value should be recorded in the trace.
        // Precondition: All of these are "int" variables.
        protected HashSet<string> varsToRecord;
        bool recordTransformationHappened;

        // Name of procedure that records its argument's concrete value
        public static string recordArgProcPrefix = "boogie_si_record";
        string recordIntArgProc;
        string recordBoolArgProc;

        // Is Boogie going to give us a model
        static bool WillGetModel
        {
            get
            {
                return BoogieVerify.options.UseProverEvaluate || !BoogieVerify.options.StratifiedInliningWithoutModels;
            }
        }

        // For debugging
        public static TimeSpan tempTime = TimeSpan.Zero;
        public static bool measureTempTime = false;

        public VerificationPass(bool cex)
            : base()
        {
            passName = "Some verification pass";
            success = false;
            reachedBound = false;
            traces = new List<ErrorTrace>();
            prune = null;
            needErrorTraces = cex;
            //globalsUsedForProof = new Set<string>();
            varsToRecord = new HashSet<string>();
            recordTransformationHappened = false;
            recordIntArgProc = recordArgProcPrefix + "_vp_special_int";
            recordBoolArgProc = recordArgProcPrefix + "_vp_special_bool";
        }

        public VerificationPass(bool cex, params string[] varsToRecord)
            : this(cex)
        {
            this.varsToRecord = new HashSet<string>();
            varsToRecord.Iter(s => this.varsToRecord.Add(s));
            if (varsToRecord.Length != 0 && !WillGetModel)
                Debug.Assert(false, "Model generation is turned off -- cannot record values");

        }

        public VerificationPass(bool cex, HashSet<string> varsToRecord)
            : this(cex)
        {
            this.varsToRecord = varsToRecord;
        }

        public override CBAProgram runCBAPass(CBAProgram prog)
        {
            if (usePruning)
            {
                return runVerificationPass(input as PersistentCBAProgram);
            }
            return feedToBoogie(prog);
        }

        // Returns a program that only contains the counterexample
        public CBAProgram runVerificationPass(PersistentCBAProgram prog)
        {
            prune = new PruneProgramPass();
            var pruned = prune.run(prog) as PersistentCBAProgram;
            CBAProgram p = pruned.getCBAProgram();

            return feedToBoogie(p);
        }

        private CBAProgram feedToBoogie(CBAProgram p) {
            // Do typechecking 
            if (BoogieUtil.TypecheckProgram(p as Program, "verificationPass"))
            {
                BoogieUtil.PrintProgram(p, "error.bpl");
                throw new InvalidProg("Cannot typecheck");
            }

            BoogieVerify.options.Set();

            // An important pass for recording the value of int variables
            Debug.Assert(CommandLineOptions.Clo.StratifiedInlining > 0);
            if(WillGetModel)
              recordVarsTransformation(p, p.mainProcName);

            //System.Diagnostics.Debugger.Break();
            
            var counterexamples = new List<BoogieErrorTrace>();
            BoogieVerify.ReturnStatus ret;
            if (needErrorTraces)
            {
                ret = BoogieVerify.Verify(p as Program, out counterexamples, true /* isCBA */);
            }
            else
            {
                ret = BoogieVerify.Verify(p as Program);
            }

            success = (ret != BoogieVerify.ReturnStatus.NOK);
            reachedBound = (ret == BoogieVerify.ReturnStatus.ReachedBound);

            if (!needErrorTraces)
            {
                return null;
            }

            if (varsToRecord.Count != 0 && !WillGetModel)
                Debug.Assert(false, "Model generation is turned off -- cannot record values");

            // Currently, we're only concerned with one counterexample.
            foreach (var et in counterexamples)
            {
                Debug.Assert(et is BoogieAssertErrorTrace);

                var cnt = 1;
                var etrace = constructErrorTrace(et.cex, et.impl.Name, false, ref cnt);

                if(prune != null)  etrace = prune.mapBackTrace(etrace);
                traces.Add(etrace);

                //PrintProgramPath.print(input, etrace, "tt");
            }

            return null;
        }

        // Records the value of k after every context switch
        void recordVarsTransformation(Program program, string mainProcName)
        {
            if (varsToRecord.Count == 0) return;

            recordTransformationHappened = true;
            
            // Add declaration for the recording procedure, if not already present
            Procedure intDecl = BoogieUtil.findProcedureDecl(program.TopLevelDeclarations, recordIntArgProc);
            if (intDecl == null)
            {
                var inv = new List<Variable>();
                inv.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), true));

                intDecl = new Procedure(Token.NoToken, recordIntArgProc, new List<TypeVariable>(), inv, new List<Variable>(), new List<Requires>(),
                    new List<IdentifierExpr>(), new List<Ensures>());

                program.AddTopLevelDeclaration(intDecl);
            }

            Procedure boolDecl = BoogieUtil.findProcedureDecl(program.TopLevelDeclarations, recordBoolArgProc);
            if (boolDecl == null)
            {
                var inv = new List<Variable>();
                inv.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Bool), true));

                boolDecl = new Procedure(Token.NoToken, recordBoolArgProc, new List<TypeVariable>(), inv, new List<Variable>(), new List<Requires>(),
                    new List<IdentifierExpr>(), new List<Ensures>());

                program.AddTopLevelDeclaration(boolDecl);
            }

            // Get the set of implementations in the program
            var impls = new HashSet<string>();
            BoogieUtil.GetImplementations(program).Iter(impl => impls.Add(impl.Name));

            // Gather the set of constants whose values have to be recorded
            var constantsToRecord = new HashSet<Constant>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(g => varsToRecord.Contains(g.Name))
                .Iter(g => constantsToRecord.Add(g as Constant));

            // Add the record call after every Cmd that modifies a variable
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                // record constants at the beginning of main
                if (impl.Name == mainProcName && constantsToRecord.Any())
                {
                    var ncmds = new List<Cmd>();
                    foreach (var v in constantsToRecord)
                    {
                        CallCmd rc = null;
                        if (v.TypedIdent.Type.IsInt)
                        {
                            rc = new CallCmd(Token.NoToken, recordIntArgProc, new List<Expr>{Expr.Ident(v)}, new List<IdentifierExpr>());
                            rc.Proc = intDecl;
                        }
                        else
                        {
                            rc = new CallCmd(Token.NoToken, recordBoolArgProc, new List<Expr>{Expr.Ident(v)}, new List<IdentifierExpr>());
                            rc.Proc = boolDecl;
                        }
                        ncmds.Add(rc);
                    }
                    ncmds.AddRange(impl.Blocks[0].Cmds);
                    impl.Blocks[0].Cmds = ncmds;
                }

                foreach (var block in impl.Blocks)
                {
                    var newCmds = new List<Cmd>();
                    bool changed = false;
                    foreach (Cmd cmd in block.Cmds)
                    {
                        newCmds.Add(cmd);
                        var modVars = BoogieUtil.getVarsModified(cmd, impls);
                        modVars.IntersectWith(varsToRecord);
                        if (modVars.Count == 0)
                            continue;

                        changed = true;
                        foreach (var m in modVars)
                        {
                            var rc = getRecordCmd(m, cmd, intDecl, boolDecl);
                            if (rc == null) continue;
                            newCmds.Add(rc);
                        }

                    }
                    if (changed)
                    {
                        block.Cmds = newCmds;
                    }
                }
            }

        }

        private CallCmd getRecordCmd(string varName, Cmd cmd, Procedure intDecl, Procedure boolDecl)
        {
            var fv = new FindVars();
            fv.Visit(cmd);
            Debug.Assert(fv.varsFound.ContainsKey(varName));

            var v = fv.varsFound[varName];

            Debug.Assert(v != null);
            if (!v.TypedIdent.Type.IsInt && !v.TypedIdent.Type.IsBool) return null;

            var ins = new List<Expr>();
            ins.Add(Expr.Ident(v));

            CallCmd rc = null;
            if (v.TypedIdent.Type.IsInt)
            {
                rc = new CallCmd(Token.NoToken, recordIntArgProc, ins, new List<IdentifierExpr>());
                rc.Proc = intDecl;
            }
            else
            {
                rc = new CallCmd(Token.NoToken, recordBoolArgProc, ins, new List<IdentifierExpr>());
                rc.Proc = boolDecl;
            }

            return rc;
        }

        // Construct a ErrorTrace from a Counterexample of procedure procName
        // (possibly interprocedural). The flag "completeTrace" says if btrace
        // is expected to be a trace from entry to exit of the procedure or not
        //
        // captureStateIndex: current index into btrace.model.States
        protected ErrorTrace constructErrorTrace(Counterexample btrace, string procName,
            bool completeTrace, ref int captureStateIndex)
        {
            if(btrace == null) return null;

            var ret = new ErrorTrace(procName);

            // All blocks, except the last are complete blocks
            for (int i = 0, n = btrace.Trace.Count - 1; i < n; i++)
            {
                var blk = btrace.Trace[i];
                var etblk = new ErrorTraceBlock(blk.Label);
                etblk.info = new InstrInfo();

                ErrorTraceInstr lastInstr = null;

                for (int numInstr = 0; numInstr < blk.Cmds.Count; numInstr++) 
                {
                    Cmd c = blk.Cmds[numInstr];
                    var loc = new TraceLocation(i, numInstr);
                    ErrorTraceInstr instr = null;

                    if (btrace.calleeCounterexamples.ContainsKey(loc))
                    {
                        ErrorTrace calleeTrace = constructErrorTrace(
                             btrace.calleeCounterexamples[loc].counterexample, (c as CallCmd).Proc.Name, true, ref captureStateIndex);
                        var info = new InstrInfo();
                        var cc = c as CallCmd;
                        Debug.Assert(cc != null);

                        if (cc.Proc.Name == recordIntArgProc || cc.Proc.Name == recordBoolArgProc )
                        {
                            Debug.Assert(recordTransformationHappened);
                            Debug.Assert(btrace.calleeCounterexamples[loc].args.Count == 1);
                            Debug.Assert(cc.Ins[0] is IdentifierExpr);

                            var modelVal = btrace.calleeCounterexamples[loc].args[0];
                            object v = null;
                            if (cc.Proc.Name == recordIntArgProc && modelVal is Model.Integer)
                            {
                                // TODO: need a better fix for BigNums
                                //v = (modelVal as Model.Integer).AsInt();
                                v = Microsoft.Basetypes.BigNum.FromString((modelVal as Model.Integer).Numeral);
                            }
                            else if (cc.Proc.Name == recordIntArgProc && modelVal is int)
                            {
                                v = (int)modelVal;
                            }
                            else if (cc.Proc.Name == recordIntArgProc && modelVal is Microsoft.Basetypes.BigNum)
                            {
                                v = BoogieUtil.BigNumToIntForce((Microsoft.Basetypes.BigNum)modelVal);
                            }
                            else if(modelVal is Model.Boolean)
                            {
                                v = (modelVal as Model.Boolean).Value;
                            }
                            else if (modelVal is bool)
                            {
                                v = (bool)modelVal;
                            }
                            else
                            {
                                Debug.Assert(false);
                            }
                            if (lastInstr != null && lastInstr.info != null)
                                lastInstr.info.addVal((cc.Ins[0] as IdentifierExpr).Name, v);
                            else
                                etblk.info.addVal((cc.Ins[0] as IdentifierExpr).Name, v);
                            continue;
                        }
                        if (cc.Proc.Name.StartsWith(recordArgProcPrefix))
                        {
                            Debug.Assert(btrace.calleeCounterexamples[loc].args.Count == 1);
                            //Debug.Assert(cc.Ins[0] is IdentifierExpr);

                            var v = btrace.calleeCounterexamples[loc].args[0];
                            if (v != null)
                            {
                                info.addVal("si_arg", v);
                            }
                        }
                        instr = new CallInstr(cc.Proc.Name, calleeTrace, false, info);
                    }
                    else if (c is CallCmd)
                    {
                        var callee = (c as CallCmd).Proc.Name;
                        instr = new CallInstr(callee);
                    }
                    else
                    {
                        var ac = c as AssumeCmd;
                        if (ac != null && btrace.Model != null && QKeyValue.FindStringAttribute(ac.Attributes, "captureState") == "corral_capture")
                        {
                            var info = new ModelInstrInfo(btrace.Model, captureStateIndex);
                            instr = new IntraInstr(info);
                            captureStateIndex++;
                        }
                        else
                        {
                            instr = new IntraInstr();
                        }
                    }
                    lastInstr = instr;
                    etblk.addInstr(instr);
                }
                ret.addBlock(etblk);
            }

            // The last block has the failing assertion -- we assume this assertion
            // to be the last one of the block
            var lastBlk = btrace.Trace[btrace.Trace.Count - 1];
            var lastBlkLen = lastBlk.Cmds.Count - 1;
            
            if (!completeTrace)
            {
                lastBlkLen = -1;
                for (int i = lastBlk.Cmds.Count - 1; i >= 0; i--)
                {
                    if (lastBlk.Cmds[i] is AssertCmd)
                    {
                        lastBlkLen = i;
                        break;
                    }
                }
                if (lastBlkLen == -1)
                {
                    throw new InternalError("Failed to find the failing assert");
                }
            }

            ErrorTraceInstr lastInstr2 = null;

            var lastEtBlk = new ErrorTraceBlock(lastBlk.Label);
            lastEtBlk.info = new InstrInfo();
            for (int i = 0; i <= lastBlkLen; i++)
            {
                var c = lastBlk.Cmds[i];
                var loc = new TraceLocation(btrace.Trace.Count - 1, i);
                ErrorTraceInstr instr = null;
                if (btrace.calleeCounterexamples.ContainsKey(loc))
                {
                    var calleeTrace = constructErrorTrace(
                        btrace.calleeCounterexamples[loc].counterexample, (c as CallCmd).Proc.Name, true, ref captureStateIndex);
                    var info = new InstrInfo();

                    var cc = c as CallCmd;
                    Debug.Assert(cc != null);

                    if (cc.Proc.Name == recordIntArgProc || cc.Proc.Name == recordBoolArgProc)
                    {
                        Debug.Assert(recordTransformationHappened);
                        Debug.Assert(btrace.calleeCounterexamples[loc].args.Count == 1);
                        Debug.Assert(cc.Ins[0] is IdentifierExpr);

                        var modelVal = btrace.calleeCounterexamples[loc].args[0];
                        object v = null;
                        if (cc.Proc.Name == recordIntArgProc && modelVal is Model.Integer)
                        {
                            // TODO: need a better fix for BigNums
                            //v = (modelVal as Model.Integer).AsInt();
                            v = Microsoft.Basetypes.BigNum.FromString((modelVal as Model.Integer).Numeral);
                        }
                        else if (cc.Proc.Name == recordIntArgProc && modelVal is int)
                        {
                            v = (int)modelVal;
                        }
                        else if (cc.Proc.Name == recordIntArgProc && modelVal is Microsoft.Basetypes.BigNum)
                        {
                            v = BoogieUtil.BigNumToIntForce((Microsoft.Basetypes.BigNum)modelVal);
                        }
                        else if (modelVal is Model.Boolean)
                        {
                            v = (modelVal as Model.Boolean).Value;
                        }
                        else if (modelVal is bool)
                        {
                            v = (bool)modelVal;
                        }
                        else
                        {
                            Debug.Assert(false);
                        }
                        if (lastInstr2 != null && lastInstr2.info != null)
                            lastInstr2.info.addVal((cc.Ins[0] as IdentifierExpr).Name, v);
                        else
                            lastEtBlk.info.addVal((cc.Ins[0] as IdentifierExpr).Name, v);
                        continue;
                    }
                    else if (cc.Proc.Name.StartsWith(recordArgProcPrefix))
                    {
                        Debug.Assert(btrace.calleeCounterexamples[loc].args.Count == 1);
                        //Debug.Assert(cc.Ins[0] is IdentifierExpr);

                        var v = btrace.calleeCounterexamples[loc].args[0];
                        if (v != null)
                        {
                            info.addVal("si_arg", v);
                        }
                    }

                    instr = new CallInstr(cc.Proc.Name, calleeTrace, false, info);
                }
                else if (c is CallCmd)
                {
                    var callee = (c as CallCmd).Proc.Name;
                    instr = new CallInstr(callee);
                }
                else
                {
                    var ac = c as AssumeCmd;
                    if (ac != null && btrace.Model != null && QKeyValue.FindStringAttribute(ac.Attributes, "captureState") == "corral_capture")
                    {
                        var info = new ModelInstrInfo(btrace.Model, captureStateIndex);
                        instr = new IntraInstr(info);
                        captureStateIndex++;
                    }
                    else
                    {
                        instr = new IntraInstr();
                    }
                }
                lastInstr2 = instr;
                lastEtBlk.addInstr(instr);
            }

            ret.addBlock(lastEtBlk);

            if (completeTrace)
            {
                ret.addReturn();
            }

            return ret;
        }

    }

    public class ContractInfer : CompilerPass
    {
        public class EExpr 
        {
            public Expr expr;
            public int typ;
            public HashSet<string> mustMod;
            public HashSet<string> mustNotMod;
            public QKeyValue annotations;

            public static HashSet<string> procsThatFail = null;

            public bool IsFree
            {
                get
                {
                    return (typ == 0 || typ == 2);
                }
            }

            public bool IsRequires
            {
                get
                {
                    return (typ == 2 || typ == 3);
                }
            }

            public bool IsEnsures
            {
                get
                {
                    return (typ == 0 || typ == 1);
                }
            }

            private EExpr()
            {
                this.expr = null;
                typ = 0;
                mustMod = new HashSet<string>();
                mustNotMod = new HashSet<string>();
            }

            public EExpr(Expr expr, bool isEnsures)
                : this()
            {
                this.expr = expr;
                typ = isEnsures ? 1 : 3;
            }

            public EExpr(Ensures ens)
                :this()
            {
                this.expr = ens.Condition;
                if (ens.Free) typ = 0;
                else typ = 1;
                processAnnotations(ens.Attributes);
            }

            public EExpr(Requires req)
                : this()
            {
                this.expr = req.Condition;
                if (req.Free) typ = 2;
                else typ = 3;
                processAnnotations(req.Attributes);
            }

            private void processAnnotations(QKeyValue attr)
            {
                annotations = attr;

                for(; attr != null; attr = attr.Next)
                {
                    if(attr.Params.Count != 1) 
                        continue;
                    if(!(attr.Params[0] is string)) 
                        continue;

                    var v = (string)attr.Params[0];

                    switch (attr.Key)
                    {
                        case "mustmod": mustMod.Add(v);
                            break;
                        case "mustnotmod": mustNotMod.Add(v);
                            break;
                    }
                    
                }
            }

            public bool Match(Procedure proc)
            {
                if (QKeyValue.FindBoolAttribute(annotations, "loop") &&
                    !QKeyValue.FindBoolAttribute(proc.Attributes, "LoopProcedure"))
                    return false;

                var mods = new HashSet<string>();
                proc.Modifies.OfType<IdentifierExpr>()
                    .Iter(ie => mods.Add(ie.Name));

                if (!mustMod.IsSubsetOf(mods)) return false;
                if (mustNotMod.Intersection(mods).Any()) return false;

                if (QKeyValue.FindBoolAttribute(annotations, "mustfail"))
                {
                    Debug.Assert(procsThatFail != null);
                    return procsThatFail.Contains(proc.Name);
                }

                return true;
            }

            public Ensures getEnsures()
            {
                Debug.Assert(IsEnsures);
                return new Ensures(IsFree, expr);
            }

            public Requires getRequires()
            {
                Debug.Assert(IsRequires);
                return new Requires(IsFree, expr);
            }
        }

        // extract loops?
        public bool ExtractLoops;

        public static int HoudiniTimeout = -1;
        public static bool disableStaticAnalysis = false;
        public static bool inferPreconditions = false;
        public static bool checkAsserts = false;
        public static string runAbsHoudiniConfig = null;
        public static bool fastRequiresInference = false;
        public static bool runAbsHoudini
        {
            get
            {
                return (runAbsHoudiniConfig != null);
            }
        }
        public static bool useHoudiniLite = false;

        // Template
        public HashSet<Variable> templateVars;
        public List<EExpr> templates;
        public int InlineDepth;
        private HashSet<string> templateVarNames;
        protected ExtractLoopsPass elPass;
        public static bool runHoudini = true;
        public string printHoudiniQuery = null;

        // Named constants: (implName, id) -> set of constants with that id
        protected Dictionary<Tuple<string, string>, HashSet<string>> namedConstants;
        // Dependencies: constant -> id that it depends on
        protected Dictionary<string, string> dependenciesBetConstants;

        private Dictionary<string, IEnumerable<Expr>> staticAnalysisSummaries;
        private Dictionary<string, IEnumerable<Expr>> staticAnalysisPreconditions;
        protected HashSet<string> staticAnalysisConstants;
        public static bool checkStaticAnalysis = false;

        public Dictionary<string, List<EExpr>> summaries;

        public ContractInfer(ContractInfer that)
        {
            this.templates = that.templates;
            this.templateVars = that.templateVars;
            this.InlineDepth = that.InlineDepth;
            this.elPass = new ExtractLoopsPass(that.elPass.unrollNum);
            this.summaries = that.summaries;
            this.printHoudiniQuery = that.printHoudiniQuery;

            this.namedConstants = new Dictionary<Tuple<string, string>, HashSet<string>>();
            this.dependenciesBetConstants = new Dictionary<string, string>();

            ExtractLoops = true;
            templateVarNames = new HashSet<string>();
            templateVars.Iter(v => templateVarNames.Add(v.Name));
            staticAnalysisSummaries = new Dictionary<string, IEnumerable<Expr>>();
            staticAnalysisPreconditions = new Dictionary<string, IEnumerable<Expr>>();
            staticAnalysisConstants = new HashSet<string>();
        }

        public ContractInfer(HashSet<Variable> templateVars, List<Requires> req, List<Ensures> ens, int InlineDepth,
            int unroll)
        {
            this.templates = new List<EExpr>();
            foreach (Requires r in req) templates.Add(new EExpr(r));
            foreach (Ensures e in ens) templates.Add(new EExpr(e));

            this.templateVars = templateVars;
            this.InlineDepth = InlineDepth;
            this.elPass = new ExtractLoopsPass(unroll);
            this.summaries = new Dictionary<string, List<EExpr>>();
            staticAnalysisSummaries = new Dictionary<string, IEnumerable<Expr>>();
            staticAnalysisPreconditions = new Dictionary<string, IEnumerable<Expr>>();
            staticAnalysisConstants = new HashSet<string>();

            this.namedConstants = new Dictionary<Tuple<string, string>, HashSet<string>>();
            this.dependenciesBetConstants = new Dictionary<string, string>();

            ExtractLoops = true;
            templateVarNames = new HashSet<string>();
            templateVars.Iter(v => templateVarNames.Add(v.Name));
        }

        protected Expr UpdateVars(Expr expr, Dictionary<string, Variable> globals)
        {
            var dup = new FixedDuplicator();
            var subst = new Dictionary<string, Variable>();
            var e = dup.VisitExpr(expr);
            e = (new VarSubstituter(subst, globals)).VisitExpr(e);
            return e;
        }

        private bool usesTemplateVars(Expr template, HashSet<string> vars)
        {
            var gused = new GlobalVarsUsed();
            gused.VisitExpr(template);
            return gused.globalsUsed.Intersection(vars).Any();
        }

        private List<Expr> InstantiateTemplate(Expr template,
            Dictionary<string, Variable> globals, Dictionary<string, Variable> formals, Dictionary<string, Function> funcs)
        {
            var ret = new List<Expr>();

            var dup = new FixedDuplicator();
            var gused = new GlobalVarsUsed();
            gused.VisitExpr(template);

            if (gused.globalsUsed.Any(g => !globals.ContainsKey(g) && !templateVarNames.Contains(g)))
                return ret;

            var subst = new Dictionary<string, Variable>();

            var templateVarUsed = gused.globalsUsed.Intersection(templateVarNames);
            if (templateVarUsed.Count == 0)
            {
                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals, funcs)).VisitExpr(e);
                ret.Add(e);
                return ret;
            }

            // Set of matches for each template variable
            var matches = new Dictionary<string, HashSet<Variable>>();
            var loopVars = new HashSet<string>();

            foreach (var tvName in templateVarUsed)
            {
                var tv = templateVars.First(v => v.Name == tvName);
                matches.Add(tvName, new HashSet<Variable>());

                var includeFormalIn = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalIn");
                var includeFormalOut = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalOut");
                var includeGlobals = QKeyValue.FindBoolAttribute(tv.Attributes, "includeGlobals");
                var includeLoopLocals = QKeyValue.FindBoolAttribute(tv.Attributes, "includeLoopLocals");

                if (!includeFormalIn && !includeFormalOut && !includeGlobals && !includeLoopLocals)
                {
                    // default configuration
                    includeFormalIn = true;
                    includeFormalOut = true;
                    includeGlobals = true;
                }

                if (includeLoopLocals && (includeFormalIn || includeFormalOut || includeGlobals))
                    throw new InvalidInput("ContractInfer: a template variable cannot have other includes with includeLoopLocals");

                if (includeLoopLocals)
                    loopVars.Add(tvName);

                var onlyMatchVar = QKeyValue.FindStringAttribute(tv.Attributes, "match");
                System.Text.RegularExpressions.Regex matchRegEx = null;
                if (onlyMatchVar != null) matchRegEx = new System.Text.RegularExpressions.Regex(onlyMatchVar);

                foreach (var kvp in globals.Concat(formals))
                {
                    if (tv.TypedIdent.Type.ToString() != kvp.Value.TypedIdent.Type.ToString())
                        continue;

                    if (kvp.Value is Constant) continue;
                    if (matchRegEx != null && !matchRegEx.IsMatch(kvp.Key)) continue;
                    if (includeLoopLocals)
                    {
                        if (kvp.Value is GlobalVariable) continue;
                        
                        // Just store formal ins 
                        // Assumption: there are more formal ins of loops than formal outs
                        if (kvp.Value is Formal && (kvp.Value as Formal).InComing)
                            matches[tvName].Add(kvp.Value);

                        continue;
                    }
                    if (!includeFormalIn && kvp.Value is Formal && (kvp.Value as Formal).InComing) continue;
                    if (!includeFormalOut && kvp.Value is Formal && !(kvp.Value as Formal).InComing) continue;
                    if (!includeGlobals && kvp.Value is GlobalVariable) continue;

                    matches[tvName].Add(kvp.Value);
                }
            }

            // return if empty set of matches
            if (matches.Any(kvp => kvp.Value.Count == 0))
                return ret;

            // take cartesian product
            var tvars = new List<string>(matches.Keys);
            var matchArr = new List<Variable[]>();
            for (int i = 0; i < tvars.Count; i++)
            {
                var arr = new Variable[matches[tvars[i]].Count];
                int j = 0;
                foreach (var v in matches[tvars[i]]) arr[j++] = v;
                matchArr.Add(arr);
            }

            // N-bit counter
            var counter = new int[tvars.Count];
            for (int i = 0; i < counter.Length; i++) counter[i] = 0;
            var GetNext = new Func<bool>(() =>
                {
                    var done = false;
                    var i = 0;
                    while (!done)
                    {
                        counter[i]++;
                        if (counter[i] == matchArr[i].Length)
                        {
                            counter[i] = 0;
                            i++;
                            if (i == counter.Length)
                                return false;
                        }
                        else
                        {
                            done = true;
                        }
                    }
                    return true;
                });

            var inToOutMap = new Dictionary<Variable, Variable>();
            if (loopVars.Count > 0)
            {
                // for each formal In in_v, map in_v -> v
                var inMap = new Dictionary<Variable, string>();
                formals.Values
                    .Select(f => f as Formal)
                    .Where(f => f.InComing && f.Name.StartsWith("in_"))
                    .Iter(f => inMap.Add(f, f.Name.Substring("in_".Length)));

                // for each formal Out out_v, map v -> out_v
                var outMap = new Dictionary<string, Variable>();
                formals.Values
                    .Select(f => f as Formal)
                    .Where(f => !f.InComing && f.Name.StartsWith("out_"))
                    .Iter(f => outMap.Add(f.Name.Substring("out_".Length), f));

                foreach (var tup in inMap)
                {
                    if (!outMap.ContainsKey(tup.Value)) continue;
                    inToOutMap.Add(tup.Key, outMap[tup.Value]);
                }
            }

            do
            {
                subst = new Dictionary<string, Variable>();
                for (int i = 0; i < tvars.Count; i++)
                    subst.Add(tvars[i], matchArr[i][counter[i]]);
                var e = dup.VisitExpr(template);
                var substituter = new VarSubstituter(subst, globals);

                if (loopVars.Count > 0)
                {
                    // Fix for loop locals
                    // current, lloc -> in_v, change this to
                    // lloc -> out_v and old(lloc) -> in_v
                    var oldVarSubst = new Dictionary<string, Variable>();
                    var valid = true;
                    foreach (var lloc in loopVars)
                    {
                        if (!inToOutMap.ContainsKey(subst[lloc]))
                        {
                            valid = false;
                            break;
                        }
                        oldVarSubst.Add(lloc, subst[lloc]);
                        subst[lloc] = inToOutMap[subst[lloc]];                        
                    }

                    if (valid)
                    {
                        substituter.SetOldVarSubst(oldVarSubst);
                        e = substituter.VisitExpr(e);
                        ret.Add(e);
                    }
                }
                else
                {
                    e = substituter.VisitExpr(e);
                    ret.Add(e);
                }

            } while (GetNext());

            return ret;
        }

        public bool onlyEnsures()
        {
            foreach (var e in templates)
            {
                if (e.IsRequires && !e.IsFree) return false;
            }
            return true;
        }

        public virtual Dictionary<string, Dictionary<string, EExpr>> Instantiate(Program program)
        {
            var globals = new Dictionary<string, Variable>();
            program.TopLevelDeclarations
                .OfType<Variable>()
                .Iter(c => globals.Add(c.Name, c));

            var funcs = new Dictionary<string, Function>();
            program.TopLevelDeclarations.OfType<Function>().Iter(fn => funcs.Add(fn.Name, fn));

            var ret = new Dictionary<string, Dictionary<string, EExpr>>();
            var dup = new FixedDuplicator();

            var cnt = 0;
            var constants = new List<Constant>();

            var templateCounter = 0;

            // loop vars
            var loopTemplateVars = new HashSet<string>(templateVars.Where(v => QKeyValue.FindBoolAttribute(v.Attributes, "includeLoopLocals")).Select(v => v.Name));

            // Iterate over templates
            foreach (var template in templates)
            {
                templateCounter++;
                var forLoopOnly = usesTemplateVars(template.expr, loopTemplateVars);

                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var proc = impl.Proc;
                    if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;
                    var nocandidates = QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "nohoudini");
                    if (!template.Match(proc)) continue;
                    if (forLoopOnly && !QKeyValue.FindBoolAttribute(proc.Attributes, "LoopProcedure")) continue;

                    if (!ret.ContainsKey(proc.Name)) ret.Add(proc.Name, new Dictionary<string, EExpr>());

                    var formals = new Dictionary<string, Variable>();
                    proc.InParams.OfType<Formal>()
                        .Iter(f => formals.Add(f.Name, f));
                    proc.OutParams.OfType<Formal>()
                        .Iter(f => formals.Add(f.Name, f));

                    var allExprs = InstantiateTemplate(template.expr, globals, formals, funcs);
                    if (allExprs.Count == 0) continue;

                    foreach (var expr in allExprs)
                    {
                        if (template.IsFree)
                        {
                            if (template.IsEnsures) proc.Ensures.Add(new Ensures(true, expr));
                            if (template.IsRequires) proc.Requires.Add(new Requires(true, expr));
                            continue;
                        }
                        if (nocandidates) continue;

                        Expr e = null;

                        if (!runAbsHoudini)
                        {
                            var constant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "CIC" + cnt.ToString(), Microsoft.Boogie.Type.Bool), false);
                            constant.AddAttribute("existential", Expr.Literal(true));
                            cnt++;

                            // record names and dependencies
                            var id = QKeyValue.FindStringAttribute(template.annotations, "name");
                            if (id != null) namedConstants.InitAndAdd(Tuple.Create(impl.Name, id), constant.Name);

                            id = QKeyValue.FindStringAttribute(template.annotations, "dep");
                            if (id != null) dependenciesBetConstants.Add(constant.Name, id);

                            e = Expr.Imp(Expr.Ident(constant), expr);
                            constants.Add(constant);

                            ret[proc.Name].Add(constant.Name, new EExpr(expr, template.IsEnsures));
                        }
                        else
                        {
                            e = expr;
                        }

                        if (template.IsEnsures)
                        {
                            var ens = new Ensures(false, e);
                            ens.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), template.annotations);
                            ens.Attributes = new QKeyValue(Token.NoToken, "template", new List<object> { Expr.Literal(templateCounter) }, ens.Attributes);
                            proc.Ensures.Add(ens);
                        }
                        else
                        {
                            var req = new Requires(false, e);
                            req.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), template.annotations);
                            req.Attributes = new QKeyValue(Token.NoToken, "template", new List<object> { Expr.Literal(templateCounter) }, req.Attributes);
                            proc.Requires.Add(req);
                        }
                    }
                }
            }

            if (runAbsHoudini)
                checkStaticAnalysis = false;

            var name2Impl = BoogieUtil.nameImplMapping(program);

            foreach (var kvp in staticAnalysisSummaries)
            {
                var impl = name2Impl[kvp.Key];
                var proc = impl.Proc;
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;
                if (!ret.ContainsKey(proc.Name)) ret.Add(proc.Name, new Dictionary<string, EExpr>());

                foreach (var expr in kvp.Value)
                {
                    var constant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "CIC" + cnt.ToString(), Microsoft.Boogie.Type.Bool), false);
                    constant.AddAttribute("existential", Expr.Literal(true));
                    constants.Add(constant);
                    staticAnalysisConstants.Add(constant.Name);
                    cnt++;

                    Ensures ens = null;

                    if (checkStaticAnalysis)
                    {
                        var e = Expr.Imp(Expr.Ident(constant), expr);
                        ens = new Ensures(false, e);
                        ens.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), ens.Attributes);
                    }
                    else
                    {
                        ens = new Ensures(true, expr);
                    }

                    name2Impl[impl.Name].Proc.Ensures.Add(ens);
                    ret[impl.Name].Add(constant.Name, new EExpr(expr, true));
                }
            }

            foreach (var kvp in staticAnalysisPreconditions)
            {
                var impl = name2Impl[kvp.Key];
                var proc = impl.Proc;
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;
                if (!ret.ContainsKey(proc.Name)) ret.Add(proc.Name, new Dictionary<string, EExpr>());

                foreach (var expr in kvp.Value)
                {
                    var constant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "CIC" + cnt.ToString(), Microsoft.Boogie.Type.Bool), false);
                    constant.AddAttribute("existential", Expr.Literal(true));
                    constants.Add(constant);
                    staticAnalysisConstants.Add(constant.Name);
                    cnt++;

                    if (checkStaticAnalysis)
                    {
                        var e = Expr.Imp(Expr.Ident(constant), expr);
                        var ens = new Requires(false, e);
                        ens.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), ens.Attributes);
                        name2Impl[impl.Name].Proc.Requires.Add(ens);
                        ret[impl.Name].Add(constant.Name, new EExpr(expr, false));
                    }
                    else
                    {
                        var ens = new Ensures(true, addOld(expr));
                        name2Impl[impl.Name].Proc.Ensures.Add(ens);
                        ret[impl.Name].Add(constant.Name, new EExpr(addOld(expr), true));
                    }

                    
                }
            }

            program.AddTopLevelDeclarations(constants);

            return ret;
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            #region sanity checking for abstract houdini
            if (runAbsHoudini)
            {
                if (templates.Any(eexpr => eexpr.IsRequires && !eexpr.IsFree))
                    throw new InvalidInput("Abstract Houdini doesn't yet support inferring Requires annotations");
                var checkAttr = new Func<QKeyValue, bool>(attr =>
                    {
                        for (; attr != null; attr = attr.Next)
                        {
                            if (attr.Key == "pre" || attr.Key == "post" || attr.Key == "upper") return true;
                        }
                        return false;
                    });
                
                if (templates.Any(eexpr => !eexpr.IsFree && !checkAttr(eexpr.annotations)))
                    throw new InvalidInput("Abstract Houdini called with illegal templates");
            }
            #endregion

            if (ExtractLoops)
            {
                // Unroll loops
                var inputPrime = elPass.run(input);
                program = (inputPrime as PersistentCBAProgram).getCBAProgram();
            }

            BoogieUtil.DoModSetAnalysis(program);
            EExpr.procsThatFail = BoogieUtil.procsThatMaySatisfyPredicate(program, c => BoogieUtil.isAssert(c));

            DoStaticAnalysis(program);
            var info = Instantiate(program);

            if (printHoudiniQuery != null) PrintProofMinQuery(program, "pm_" + printHoudiniQuery);

            if (!runAbsHoudini && info.Count == 0 && summaries.Count == 0) return program;

            if (runHoudini)
            {
                if (info.Count != 0)
                {
                    (new RewriteCallDontCares()).VisitProgram(program);
                    if(printHoudiniQuery != null) PrintProofMinQuery(program, "pm_" + printHoudiniQuery);
                    RunHoudini(program, info);
                    program = (input as PersistentCBAProgram).getCBAProgram();
                }
            }
            else
            {
                Debug.Assert(onlyEnsures());
                // Turn on summary computation in Boogie
                Debug.Assert(CommandLineOptions.Clo.StratifiedInlining > 0);
                CommandLineOptions.Clo.StratifiedInliningOption = 1;
            }

            // Insert summaries
            addSummaries(program);
            
            return program;
        }

        public static void PrintProofMinQuery(Program program, string outfile)
        {
            // Make a copy
            program = BoogieUtil.ReResolveInMem(program);

            // drop entrypoint annotation from procedures
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(p => p.Attributes = BoogieUtil.removeAttr("entrypoint", p.Attributes));

            // find the entrypoint
            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            // convert assert to assume negation
            foreach (var blk in ep.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var acmd = blk.Cmds[i] as AssertCmd;
                    if (acmd == null || BoogieUtil.isAssertTrue(acmd)) continue;
                    blk.Cmds[i] = new AssumeCmd(acmd.tok, Expr.Not(acmd.Expr));
                }
            }

            // Dump program
            BoogieUtil.PrintProgram(program, outfile);                    
        }


        public static bool FPA = false;

        public void trainSummaries(CBAProgram program)
        {
            // discard non-free templates
            templates.RemoveAll(ee => !ee.IsFree);

            var trainingProc = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => BoogieUtil.checkAttrExists("trainingPredicates", proc.Attributes))
                .FirstOrDefault();
            if (trainingProc == null)
                throw new InternalError("Illegal invocation of training summaries mode");

            foreach (Ensures ens in trainingProc.Ensures)
                templates.Add(new EExpr(ens));

            BoogieUtil.DoModSetAnalysis(program);

            DoStaticAnalysis(program);

            // fake abs houdini to get the template instantiation correct
            runAbsHoudiniConfig = "";
            // We don't want predicates from "main"
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            if (impl != null) impl.AddAttribute("entrypoint");

            var info = Instantiate(program);

            var proc2Exprs = new Dictionary<string, List<Expr>>();
            if (FPA)
            {
                var newFns = new List<Declaration>();
                foreach (var p in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var proc = p.Proc;
                    
                    var sp = proc.Ensures.Partition(ens => ens.Free);
                    proc.Ensures = sp.fst;

                    var foo = CreateFunctionFPA(sp.snd.Count, "foo_" + proc.Name);
                    foo.AddAttribute("absdomain", "PredicateAbs");
                    newFns.Add(foo);

                    var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                    var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), exprArgs);
                    proc.Ensures.Add(new Ensures(false, expr));

                    proc2Exprs.Add(foo.Name, exprArgs);
                }

                program.AddTopLevelDeclarations(newFns);
            }

            // Massage program
            (new RewriteCallDontCares()).VisitProgram(program);
            // get rid of assert in main
            var mainImpl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            foreach (var blk in mainImpl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var acmd = blk.Cmds[i] as AssertCmd;
                    if (acmd == null) continue;
                    var le = acmd.Expr as LiteralExpr;
                    if (le != null && le.IsTrue) continue;
                    blk.Cmds[i] = new AssumeCmd(Token.NoToken, acmd.Expr);
                }
            }

            // Run Abs Houdini

            CommandLineOptions.Clo.InlineDepth = InlineDepth;
            var old = CommandLineOptions.Clo.ProcedureInlining;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Spec;
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            var cc = CommandLineOptions.Clo.ProverCCLimit;
            CommandLineOptions.Clo.ContractInfer = true;
            var oldTimeout = CommandLineOptions.Clo.ProverKillTime;

            CommandLineOptions.Clo.ProverKillTime = 20000; // AbsHoudini interprets this as milliseconds
            CommandLineOptions.Clo.ProverCCLimit = 1;
            CommandLineOptions.Clo.AbstractHoudini = runAbsHoudiniConfig;
            CommandLineOptions.Clo.PrintErrorModel = 1;
            AbstractHoudini.WitnessFile = null;

            var time3 = DateTime.Now;

            inline(program);
            BoogieUtil.TypecheckProgram(program, "error.bpl");

            if (printHoudiniQuery != null)
                BoogieUtil.PrintProgram(program, printHoudiniQuery);

            HashSet<string> predicates = new HashSet<string>();

            if (FPA)
            {
                AbstractDomainFactory.Initialize(program);
                var domain = AbstractDomainFactory.GetInstance("PredicateAbs");
                var abs = new AbsHoudini(program, domain);
                CommandLineOptions.Clo.PrintAssignment = true;
                var absout = abs.ComputeSummaries();

                var summaries = abs.GetAssignment();
                foreach (var foo in summaries)
                {
                    var body = foo.Body;
                    if(body is LiteralExpr && (body as LiteralExpr).IsTrue)
                        continue;

                    // break top-level ANDs

                    var subst = new Substitution(v =>
                        {
                            var num = Int32.Parse(v.Name.Substring(1));
                            return proc2Exprs[foo.Name][num];
                        });

                    body = Substituter.Apply(subst, body);

                    foreach(var c in GetConjuncts(body)) 
                        predicates.Add(c.ToString());
                }
            }
            else
            {
                AbstractHoudini absHoudini = null;
                PredicateAbs.Initialize(program);
                absHoudini = new AbstractHoudini(program);
                absHoudini.computeSummaries(new PredicateAbs(program.TopLevelDeclarations.OfType<Implementation>().First().Name));
                // Abstract houdini sets a prover option for the time limit. Get rid of that now
                CommandLineOptions.Clo.ProverOptions = CommandLineOptions.Clo.ProverOptions.Where(str => !str.StartsWith("TIME_LIMIT"));

                // Record new summaries
                predicates = absHoudini.GetPredicates();
            }

            
            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;

            // get rid of "true ==> blah" for type-state predicates 
            // because we know they get covered by other candidates anyway
            var typestatePost = new HashSet<string>();
            templates
                .Where(ee => BoogieUtil.checkAttrExists("typestate", ee.annotations)
                    && BoogieUtil.checkAttrExists("post", ee.annotations))
                .Iter(ee => typestatePost.Add(ee.expr.ToString()));
            predicates.ExceptWith(typestatePost);

            // write out the predicates
            Console.WriteLine("Predicates:");
            predicates.Iter(s => Console.WriteLine("  {0}", s));
            using (var fs = new System.IO.StreamWriter("corralPredicates.txt"))
            {
                predicates.Iter(s => fs.WriteLine("{0}", s));
            }
        }

        private Function CreateFunctionFPA(int numArgs, string name)
        {
            var args = new List<Variable>();
            for(int i = 0; i < numArgs; i++) 
                args.Add(BoogieAstFactory.MkFormal("x" + i.ToString(), Microsoft.Boogie.Type.Bool, true));
            var ret = new Function(Token.NoToken, name, args, BoogieAstFactory.MkFormal("x", Microsoft.Boogie.Type.Bool, false));
            ret.AddAttribute("existential", Expr.Literal(true));
            return ret;
        }

        private List<Expr> GetConjuncts(Expr expr)
        {
            var nary = expr as NAryExpr;
            if (nary == null) return new List<Expr> { expr };
            var bop = nary.Fun as BinaryOperator;
            if (bop == null || bop.Op != BinaryOperator.Opcode.And) return new List<Expr> { expr };

            var l1 = GetConjuncts(nary.Args[0]);
            var l2 = GetConjuncts(nary.Args[1]);

            return new List<Expr>(l1.Concat(l2));
        }

        private void DoStaticAnalysis(CBAProgram program)
        {
            //BoogieUtil.PrintProgram(program, "StaticIn.bpl");
            if (disableStaticAnalysis) return;

            StaticAnalysis.ConstantProp.program = program;
            var rhs = new StaticAnalysis.RHS(program, new StaticAnalysis.ConstantProp());
            rhs.Compute();
            if(inferPreconditions)
               rhs.ComputePreconditions();
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl =>
                    {
                        var summary = rhs.GetSummary(impl.Name) as StaticAnalysis.ConstantProp;
                        staticAnalysisSummaries.Add(impl.Name, summary.ToExpr(true));
                        if (inferPreconditions)
                        {
                            var precondition = rhs.GetPrecondition(impl.Name) as StaticAnalysis.ConstantProp;
                            staticAnalysisPreconditions.Add(impl.Name, precondition.ToExpr(true));
                        }
                        //Console.WriteLine("{0}:", impl.Name);
                        //summary.Print(true);
                        //Console.WriteLine("{0}:", impl.Name);
                        //precondition.Print(true);
                    });

            Console.WriteLine("Static analysis took {0} s", rhs.computeTime.TotalSeconds.ToString("F2"));
        }

        private void addSummaries(Program program)
        {
            QKeyValue attr = new QKeyValue(Token.NoToken, "va_keep", new List<object>(), null);

            // Insert summaries
            foreach (var decl in program.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                var proc = impl.Proc;
                if (summaries.ContainsKey(proc.Name))
                {
                    foreach (var eexpr in summaries[proc.Name])
                    {
                        if (eexpr.IsEnsures) proc.Ensures.Add(new Ensures(Token.NoToken, true, eexpr.expr, "", attr));
                        if (eexpr.IsRequires) proc.Ensures.Add(new Ensures(Token.NoToken, true, addOld(eexpr.expr), "", attr));
                        if (checkAsserts)
                            if (eexpr.IsRequires) proc.Requires.Add(new Requires(Token.NoToken, true, eexpr.expr, "", attr));
                    }
                }

                // Insert the free guys
                var globals = new Dictionary<string, Variable>();
                program.TopLevelDeclarations
                    .OfType<Variable>()
                    .Iter(c => globals.Add(c.Name, c));

                var funcs = new Dictionary<string, Function>();
                program.TopLevelDeclarations.OfType<Function>().Iter(fn => funcs.Add(fn.Name, fn));

                var formals = new Dictionary<string, Variable>();
                proc.InParams.OfType<Formal>()
                    .Iter(f => formals.Add(f.Name, f));
                proc.OutParams.OfType<Formal>()
                    .Iter(f => formals.Add(f.Name, f));

                foreach (var eexpr in templates)
                {
                    if (!eexpr.IsFree) continue;
                    if (QKeyValue.FindBoolAttribute(eexpr.annotations, "drop")) continue;

                    var allExprs = InstantiateTemplate(eexpr.expr, globals, formals, funcs);

                    foreach (var expr in allExprs)
                    {
                        if (eexpr.IsEnsures) proc.Ensures.Add(new Ensures(Token.NoToken, true, expr, "", attr));
                        if (eexpr.IsRequires) proc.Ensures.Add(new Ensures(Token.NoToken, true, addOld(expr), "", attr));
                        if (checkAsserts)
                            if (eexpr.IsRequires) proc.Requires.Add(new Requires(Token.NoToken, true, expr, "", attr));
                    }
                }

            }
        }

        private void RunHoudini(CBAProgram program, Dictionary<string, Dictionary<string, EExpr>> info)
        {
            var runHoudiniLite = useHoudiniLite;
            if (checkAsserts || fastRequiresInference || runAbsHoudini) runHoudiniLite = false;

            Console.WriteLine("Running {0}Houdini{1}", runAbsHoudini ? "Abstract " : "", runHoudiniLite ? "Lite" : "");

            // Get rid of inline attributes
            foreach (var decl in program.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                if (QKeyValue.FindIntAttribute(impl.Proc.Attributes, "inline", -1) == -1) continue;
                impl.Proc.Attributes = BoogieUtil.removeAttr("inline", impl.Proc.Attributes);
                impl.Proc.Attributes = BoogieUtil.removeAttr("verify", impl.Proc.Attributes);
                impl.Attributes = BoogieUtil.removeAttr("inline", impl.Attributes);
                impl.Attributes = BoogieUtil.removeAttr("verify", impl.Attributes);
            }
            
            if (checkAsserts)
            {
                // Guard assert with an existential Boolean
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks.Iter(blk =>
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        if (!BoogieUtil.isAssert(blk.Cmds[i])) continue;
                        var acmd = blk.Cmds[i] as AssertCmd;
                        blk.Cmds[i] = new AssumeCmd(Token.NoToken, acmd.Expr);
                    }
                }));

            }
            else
            {
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks
                        .Iter(blk =>
                            {
                                var ncmds = new List<Cmd>();
                                foreach (var cmd in blk.Cmds)
                                {
                                    var acmd = cmd as AssertCmd;
                                    if (!BoogieUtil.isAssert(cmd))
                                    {
                                        ncmds.Add(cmd);
                                        continue;
                                    }
                                    ncmds.Add(new AssumeCmd(acmd.tok, acmd.Expr));
                                }
                                blk.Cmds = ncmds;
                            }));
            }

            // Add old summaries
            var allGlobals = BoogieUtil.GetGlobalVariables(program);
            var globals = new Dictionary<string, Variable>();
            allGlobals.Iter(g => globals.Add(g.Name, g));

            foreach (var decl in program.TopLevelDeclarations)
            {
                var proc = decl as Procedure;
                if (proc == null) continue;
                if (!summaries.ContainsKey(proc.Name)) continue;
                foreach (var eexpr in summaries[proc.Name])
                {
                    if (eexpr.IsEnsures) proc.Ensures.Add(new Ensures(true, UpdateVars(eexpr.expr, globals)));
                    if (eexpr.IsRequires) proc.Requires.Add(new Requires(true, UpdateVars(eexpr.expr, globals)));
                }
            }


            // Run Houdini

            CommandLineOptions.Clo.InlineDepth = InlineDepth;
            var old = CommandLineOptions.Clo.ProcedureInlining;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Spec;
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            var cc = CommandLineOptions.Clo.ProverCCLimit;
            CommandLineOptions.Clo.ProverCCLimit = runHoudiniLite ? 1 : 5;
            CommandLineOptions.Clo.ContractInfer = true;
            var oldTimeout = CommandLineOptions.Clo.ProverKillTime;
            CommandLineOptions.Clo.ProverKillTime = Math.Max(1, (HoudiniTimeout + 500) / 1000); // milliseconds -> seconds

            if (runAbsHoudini)
            {
                CommandLineOptions.Clo.ProverKillTime = 20000; // AbsHoudini interprets this as milliseconds
                CommandLineOptions.Clo.ProverCCLimit = 1;
                CommandLineOptions.Clo.AbstractHoudini = runAbsHoudiniConfig;
                CommandLineOptions.Clo.PrintErrorModel = 1;
                AbstractHoudini.WitnessFile = null;
                AbstractHoudini.iterTimeLimit = HoudiniTimeout; // milliseconds
            }

            var time3 = DateTime.Now;

            var trueConstants = new HashSet<string>();
            AbstractHoudini absHoudini = null;
            var programProcs = new List<Procedure>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(proc => programProcs.Add(proc));

            try
            {
                if (checkAsserts)
                    program = new CBAProgram(BoogieUtil.ReResolve(program), program.mainProcName, program.contextBound);

                Program origProg = null;
                var allConstants = new HashSet<string>();
                var requiresConstants = new HashSet<string>();
                if (fastRequiresInference)
                {
                    // Turn off requires candidates
                    program.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                        .Iter(c => allConstants.Add(c.Name));

                    origProg = BoogieUtil.ReResolve(program);
                    program.TopLevelDeclarations.OfType<Procedure>()
                        .Iter(proc =>
                        {
                            var uv = new VarsUsed();
                            uv.VisitRequiresSeq(proc.Requires);
                            requiresConstants.UnionWith(uv.varsUsed.Intersection(allConstants));
                            proc.Requires = proc.Requires.Filter(re => re.Free);
                        });
                    program.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => requiresConstants.Contains(c.Name))
                        .Iter(c => c.Attributes = BoogieUtil.removeAttr("existential", c.Attributes));
                }

                if(!runHoudiniLite)
                    inline(program);

                // TODO: what about abshoudini?
                PruneIrrelevantImpls(program);
                BoogieUtil.TypecheckProgram(program, "error.bpl");

                if (printHoudiniQuery != null)
                    BoogieUtil.PrintProgram(program, printHoudiniQuery);

                HoudiniOutcome outcome = null;

                if (runAbsHoudini)
                {
                    PredicateAbs.Initialize(program);
                    absHoudini = new AbstractHoudini(program);
                    absHoudini.computeSummaries(new PredicateAbs(program.TopLevelDeclarations.OfType<Implementation>().First().Name));
                    // Abstract houdini sets a prover option for the time limit. Get rid of that now
                    CommandLineOptions.Clo.ProverOptions = CommandLineOptions.Clo.ProverOptions.Where(str => !str.StartsWith("TIME_LIMIT"));
                }
                else
                {
                    if (runHoudiniLite)
                    {
                        cba.Util.BoogieVerify.options = new BoogieVerifyOptions();
                        var res = CoreLib.HoudiniInlining.RunHoudini(program);
                        trueConstants.UnionWith(res);
                        //CoreLib.HoudiniStats.Print();
                        //Console.WriteLine("Num true = {0}", res.Count);
                        //Console.WriteLine("True assignment: {0}", res.Concat(" "));
                        //trueConstants.UnionWith(res);
                        //throw new NormalExit("Done");
                    }
                    else
                    {

                        var houdiniStats = new HoudiniSession.HoudiniStatistics();
                        Houdini houdini = new Houdini(program, houdiniStats);
                        outcome = houdini.PerformHoudiniInference();
                        Debug.Assert(outcome.ErrorCount == 0, "Something wrong with houdini");

                        if (!fastRequiresInference)
                        {
                            outcome.assignment.Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });        
                        }
                        houdini = null; // for gc
                    }
                    Console.WriteLine("Inferred {0} contracts", trueConstants.Count);

                    var time4 = DateTime.Now;
                    Log.WriteLine(Log.Debug, "Houdini took {0} seconds", (time4 - time3).TotalSeconds.ToString("F2"));
                }
                
                if(fastRequiresInference)
                {
                    var newAxioms = new List<Axiom>();
                    foreach (var b in origProg.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => allConstants.Contains(c.Name) && !requiresConstants.Contains(c.Name)))
                    {
                        b.Attributes = BoogieUtil.removeAttr("existential", b.Attributes);
                        var axiom = Expr.Eq(Expr.Ident(b), Expr.Literal(outcome.assignment[b.Name]));
                        axiom.Type = Microsoft.Boogie.Type.Bool;
                        axiom.TypeParameters = SimpleTypeParamInstantiation.EMPTY;
                        newAxioms.Add(new Axiom(Token.NoToken, axiom));
                    }
                    origProg.AddTopLevelDeclarations(newAxioms);
                    //BoogieUtil.PrintProgram(origProg, "h2.bpl");

                    CommandLineOptions.Clo.ReverseHoudiniWorklist = true;
                    var houdiniStats = new HoudiniSession.HoudiniStatistics();
                    Houdini houdini = new Houdini(origProg, houdiniStats);
                    HoudiniOutcome outcomeReq = houdini.PerformHoudiniInference();
                    Debug.Assert(outcomeReq.ErrorCount == 0, "Something wrong with houdini");
                    CommandLineOptions.Clo.ReverseHoudiniWorklist = false;

                    outcome.assignment.Where(kvp => !requiresConstants.Contains(kvp.Key))
                        .Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });
                    outcomeReq.assignment
                        .Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });

                    Console.WriteLine("Inferred {0} contracts", trueConstants.Count);
                    var time4 = DateTime.Now;
                    Log.WriteLine(Log.Debug, "Houdini took {0} seconds", (time4 - time3).TotalSeconds.ToString("F2"));
                    houdini = null;
                }
                 
            }
            catch (OutOfMemoryException)
            {
                Console.WriteLine("Houdini ran out of memory; trusting static analysis");
                trueConstants.UnionWith(staticAnalysisConstants);
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl =>
                    {
                        impl.Blocks = new List<Block>();
                        impl.OriginalBlocks = new List<Block>();
                    });
            }

            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;

            if (runAbsHoudini)
                trueConstants = staticAnalysisConstants;

            #region debug static analysis

            if (!staticAnalysisConstants.IsSubsetOf(trueConstants))
            {
                foreach (var c in staticAnalysisConstants.Difference(trueConstants))
                {
                    Expr expr = null;
                    var proc = "";
                    foreach (var kvp in info)
                    {
                        if (!kvp.Value.ContainsKey(c)) continue;
                        expr = kvp.Value[c].expr;
                        proc = kvp.Key;
                        break;
                    }
                    Console.WriteLine("The following expr in {0} is not valid", proc);
                    expr.Emit(new TokenTextWriter(Console.Out));
                    Console.WriteLine();
                }

                Debug.Assert(false, "Bug in static analysis module");
            }
            #endregion

            // Record new summaries
            if (runAbsHoudini)
            {
                foreach (var proc in programProcs)
                {
                    var summary = absHoudini.GetSummary(program, proc);
                    if (!summaries.ContainsKey(proc.Name)) summaries.Add(proc.Name, new List<EExpr>());
                    summaries[proc.Name].Add(new EExpr(new Ensures(true, summary)));
                }
            }

            foreach (var proc in programProcs)
            {
                if (!info.ContainsKey(proc.Name)) continue;

                // Gather true constants
                var tconsts = new HashSet<string>
                    (info[proc.Name].Keys.Where(s => trueConstants.Contains(s)));

                foreach (var kvp in info[proc.Name])
                {
                    if (!trueConstants.Contains(kvp.Key)) continue;

                    // check dependencies: if any of them hold then discard this one
                    var addSummary = true;
                    if (dependenciesBetConstants.ContainsKey(kvp.Key))
                    {
                        var dep = dependenciesBetConstants[kvp.Key];
                        var depKey = Tuple.Create(proc.Name, dep);
                        if (namedConstants.ContainsKey(depKey))
                        {
                            if (namedConstants[depKey].Intersection(tconsts).Any())
                                addSummary = false;
                        }
                    }

                    if (addSummary)
                    {
                        if (!summaries.ContainsKey(proc.Name)) summaries.Add(proc.Name, new List<EExpr>());
                        summaries[proc.Name].Add(kvp.Value);
                    }
                }

            }

        }

        public PersistentCBAProgram addSummaries(PersistentCBAProgram p)
        {
            var program = p.getCBAProgram();
            addSummaries(program);

            // clear the summaries
            summaries.Clear();

            return new PersistentCBAProgram(program, p.mainProcName, p.contextBound);
        }

        // convert v to old(v)
        private static Expr Subst(Variable v)
        {
            return new OldExpr(Token.NoToken, Expr.Ident(v));
        }

        // convert v to old(v)
        protected static Expr addOld(Expr expr)
        {
            return Substituter.Apply(Subst, expr);
        }

        protected void inline(Program program)
        {
            foreach (Declaration d in program.TopLevelDeclarations)
            {
                Implementation impl = d as Implementation;
                if (impl != null)
                {
                    impl.OriginalBlocks = impl.Blocks;
                    impl.OriginalLocVars = impl.LocVars;
                }
            }
            foreach (Declaration d in program.TopLevelDeclarations)
            {
                Implementation impl = d as Implementation;
                if (impl != null && !impl.SkipVerification)
                {
                    if (CommandLineOptions.Clo.InlineDepth >= 0)
                    {
                        Inliner.ProcessImplementation(program, impl);
                    }
                    else
                    {
                        CallInliner.ProcessImplementation(program, impl);
                    }
                    
                }
            }
            foreach (Declaration d in program.TopLevelDeclarations)
            {
                Implementation impl = d as Implementation;
                if (impl != null)
                {
                    impl.OriginalBlocks = null;
                    impl.OriginalLocVars = null;
                }
            }

        }

        public class CallInliner : Inliner
        {
            public CallInliner(Program program)
                : base(program, null, -1)
            { }

            new public static void ProcessImplementation(Program program, Implementation impl)
            {
                ProcessImplementation(program, impl, new CallInliner(program));
            }

            protected override int GetInlineCount(CallCmd callCmd, Implementation impl)
            {

                if (QKeyValue.FindBoolAttribute(callCmd.Attributes, "inlinecall"))
                {
                    recursiveProcUnrollMap[impl.Name] = 1;
                    return 1;
                }
                else
                    return 0;
            }
        }

        // Remove implementations that cannot have an impact on any houdini candidate.
        // In our setting (only postconditions), these are ones that don't have a non-free ensures
        protected void PruneIrrelevantImpls(Program program)
        {   
            var implHasEnsures = new Predicate<Implementation>(impl =>
            {
                bool r = impl.Proc.Ensures.Any(en => !en.Free);
                return r;
            });

            var ignoreImpl = new Predicate<Implementation>(impl =>
            {
                bool r = QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "nohoudini");
                return r;
            });

            program.TopLevelDeclarations =
                program.TopLevelDeclarations.Where(decl => !(decl is Implementation) || (implHasEnsures(decl as Implementation) && !ignoreImpl(decl as Implementation)));
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            var ret = trace;
            if(ExtractLoops) ret = elPass.mapBackTrace(trace);

            if (!runHoudini)
            {
                CommandLineOptions.Clo.StratifiedInliningOption = 0;
            }
            return ret;
        }
    }

    /**
     * Simple Houdini Inference Pass
     */
    public class SimpleHoudini : ContractInfer
    {
        private List<Constant> candCons; // maintain a list of bool constants for candidates
        private static int ConstCounter; // numbering the bool constants
        private Dictionary<string, Tuple<Expr,string>> candAsserts; // candidate assertions
        public bool InNonNull, OutNonNull, InImpOutNonNull, InImpOutNull; // a few switches for templates
        public HashSet<KeyValuePair<string, string>> inferred_asserts;
        public bool addContracts; // add inferred contracts

        public SimpleHoudini(HashSet<Variable> templateVars, List<Requires> req, List<Ensures> ens, int InlineDepth,
            int unroll) : base(templateVars, req, ens, InlineDepth, unroll)
        {
            ConstCounter = 0;
            candCons = new List<Constant>();
            candAsserts = new Dictionary<string, Tuple<Expr,string>>();
            InNonNull = true;
            OutNonNull = true;
            InImpOutNonNull = false;
            InImpOutNull = false;
            addContracts = true;
        }

        // simplified version of runCBAPass
        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // inject candidates
            Instantiate(program);

            if (ExtractLoops)
            {
                var rb = CommandLineOptions.Clo.RecursionBound;
                CommandLineOptions.Clo.RecursionBound = 2;
                
                // Unroll loops
                program.ExtractLoops();

                CommandLineOptions.Clo.RecursionBound = rb;
            }

            program = new CBAProgram(BoogieUtil.ReResolve(program), program.mainProcName, program.contextBound);

            (new RewriteCallDontCares()).VisitProgram(program);
            RunHoudini(program);

            program = (input as PersistentCBAProgram).getCBAProgram();
            // add inferred contracts
            if (addContracts)
            {
                Debug.Assert(false, "Unsupported right now; should be easy to add");
                program = addInferredContracts(program, summaries);
            }

            // prune assertions
            var notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (Block b in impl.Blocks)
                {
                    var removal_list = new HashSet<AssertCmd>();
                    foreach (AssertCmd ac in b.Cmds.OfType<AssertCmd>())
                    {
                        if (ac.Expr.ToString() == Expr.True.ToString() ||
                            ac.Expr.ToString() == notfalse)
                            continue;
                        else
                        {
                            if (inferred_asserts.Contains(new KeyValuePair<string, string>(ac.Expr.ToString(), b.Label)))
                            {
                                removal_list.Add(ac);
                            }
                        }
                    }
                    foreach (AssertCmd ac in removal_list) b.Cmds.Remove(ac);
                }
            }
            return program;
        }

        private CBAProgram addInferredContracts(CBAProgram program, Dictionary<string, List<EExpr>> summaries)
        {
            var attr = new QKeyValue(Token.NoToken, "inferred", new List<object>(), null);
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = impl.Proc;

                if (!summaries.Keys.Contains(impl.Name)) continue;

                foreach (var contract in summaries[impl.Name])
                {
                    if (contract.IsEnsures) proc.Ensures.Add(new Ensures(Token.NoToken, true, contract.expr, "", attr));
                    if (contract.IsRequires) proc.Ensures.Add(new Ensures(Token.NoToken, true, addOld(contract.expr), "", attr));
                }
            }
            return program;
        }


        // simplified version of RunHoudini
        private void RunHoudini(CBAProgram program)
        {
            inferred_asserts = new HashSet<KeyValuePair<string, string>>();
            Console.WriteLine("Running {0}Houdini", runAbsHoudini ? "Abstract " : "");
            // Run Houdini

            CommandLineOptions.Clo.InlineDepth = InlineDepth;
            var old = CommandLineOptions.Clo.ProcedureInlining;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Spec;
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            var cc = CommandLineOptions.Clo.ProverCCLimit;
            CommandLineOptions.Clo.ProverCCLimit = 5;
            CommandLineOptions.Clo.ContractInfer = true;
            var oldTimeout = CommandLineOptions.Clo.ProverKillTime;
            CommandLineOptions.Clo.ProverKillTime = Math.Max(1, (HoudiniTimeout + 500) / 1000); // milliseconds -> seconds

            var time3 = DateTime.Now;

            var trueConstants = new HashSet<string>();
            var programProcs = new List<Procedure>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(proc => programProcs.Add(proc));

            try
            {
                if (checkAsserts)
                    program = new CBAProgram(BoogieUtil.ReResolve(program), program.mainProcName, program.contextBound);

                Program origProg = null;
                var allConstants = new HashSet<string>();
                var requiresConstants = new HashSet<string>();

                if (fastRequiresInference)
                {
                    // Turn off requires candidates
                    program.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                        .Iter(c => allConstants.Add(c.Name));

                    origProg = BoogieUtil.ReResolve(program);
                    program.TopLevelDeclarations.OfType<Procedure>()
                        .Iter(proc =>
                        {
                            var uv = new VarsUsed();
                            uv.VisitRequiresSeq(proc.Requires);
                            requiresConstants.UnionWith(uv.varsUsed.Intersection(allConstants));
                            proc.Requires = proc.Requires.Filter(re => re.Free);
                        });
                    program.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => requiresConstants.Contains(c.Name))
                        .Iter(c => c.Attributes = BoogieUtil.removeAttr("existential", c.Attributes));
                }

                inline(program);

                // TODO: what about abshoudini?
                //PruneIrrelevantImpls(program); // turn off this to aviod assertions being removed

                BoogieUtil.TypecheckProgram(program, "error.bpl");

                if (printHoudiniQuery != null)
                    BoogieUtil.PrintProgram(program, printHoudiniQuery);

                HoudiniOutcome outcome = null;

                {
                    var houdiniStats = new HoudiniSession.HoudiniStatistics();
                    Houdini houdini = new Houdini(program, houdiniStats);
                    outcome = houdini.PerformHoudiniInference();
                    Debug.Assert(outcome.ErrorCount == 0, "Something wrong with houdini");

                    if (!fastRequiresInference)
                    {
                        outcome.assignment.Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });
                        Console.WriteLine("Inferred {0} contracts", trueConstants.Count);
                    }
                    var time4 = DateTime.Now;
                    Log.WriteLine(Log.Debug, "Houdini took {0} seconds", (time4 - time3).TotalSeconds.ToString("F2"));
                    houdini = null;
                }

                if (fastRequiresInference)
                {
                    var newAxioms = new List<Axiom>();
                    foreach (var b in origProg.TopLevelDeclarations.OfType<Constant>()
                        .Where(c => allConstants.Contains(c.Name) && !requiresConstants.Contains(c.Name)))
                    {
                        b.Attributes = BoogieUtil.removeAttr("existential", b.Attributes);
                        var axiom = Expr.Eq(Expr.Ident(b), Expr.Literal(outcome.assignment[b.Name]));
                        axiom.Type = Microsoft.Boogie.Type.Bool;
                        axiom.TypeParameters = SimpleTypeParamInstantiation.EMPTY;
                        newAxioms.Add(new Axiom(Token.NoToken, axiom));
                    }
                    origProg.AddTopLevelDeclarations(newAxioms);
                    //BoogieUtil.PrintProgram(origProg, "h2.bpl");

                    CommandLineOptions.Clo.ReverseHoudiniWorklist = true;
                    var houdiniStats = new HoudiniSession.HoudiniStatistics();
                    Houdini houdini = new Houdini(origProg, houdiniStats);
                    HoudiniOutcome outcomeReq = houdini.PerformHoudiniInference();
                    Debug.Assert(outcomeReq.ErrorCount == 0, "Something wrong with houdini");
                    CommandLineOptions.Clo.ReverseHoudiniWorklist = false;

                    outcome.assignment.Where(kvp => !requiresConstants.Contains(kvp.Key))
                        .Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });
                    outcomeReq.assignment
                        .Iter(kvp => { if (kvp.Value) trueConstants.Add(kvp.Key); });

                    Console.WriteLine("Inferred {0} contracts", trueConstants.Count);
                    var time4 = DateTime.Now;
                    Log.WriteLine(Log.Debug, "Houdini took {0} seconds", (time4 - time3).TotalSeconds.ToString("F2"));
                    houdini = null;
                }
            }
            catch (OutOfMemoryException)
            {
                Console.WriteLine("Houdini ran out of memory; trusting static analysis");
                trueConstants.UnionWith(staticAnalysisConstants);
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl =>
                    {
                        impl.Blocks = new List<Block>();
                        impl.OriginalBlocks = new List<Block>();
                    });
            }

            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;

            //#region debug static analysis

            //if (!staticAnalysisConstants.IsSubsetOf(trueConstants))
            //{
            //    foreach (var c in staticAnalysisConstants.Difference(trueConstants))
            //    {
            //        Expr expr = null;
            //        var proc = "";
            //        foreach (var kvp in info)
            //        {
            //            if (!kvp.Value.ContainsKey(c)) continue;
            //            expr = kvp.Value[c].expr;
            //            proc = kvp.Key;
            //            break;
            //        }
            //        Console.WriteLine("The following expr in {0} is not valid", proc);
            //        expr.Emit(new TokenTextWriter(Console.Out));
            //        Console.WriteLine();
            //    }

            //    Debug.Assert(false, "Bug in static analysis module");
            //}
            //#endregion

            // Record new summaries
            int cia = 0;
            candAsserts.Keys.Where(s => trueConstants.Contains(s))
                .Iter(a =>
                {
                    Console.WriteLine(string.Format("Inferred Assert: {0} in {1}", candAsserts[a].Item1, candAsserts[a].Item2));
                    inferred_asserts.Add(new KeyValuePair<string, string>(candAsserts[a].Item1.ToString(), candAsserts[a].Item2));
                    cia++;
                });
            Console.WriteLine(string.Format("Total Asserts: {0} out of {1}", cia, candAsserts.Count));
        }

        

        /**
         * Add houdini candidates for each procedure with implementation
         * Requires: CIC => in > 0
         * Ensures: CIC => (in > 0 => out > 0)
         * Ensures: CIC => out > 0
         * Ensures: CIC => (in <= 0 => out <= 0)
         */
        public override Dictionary<string, Dictionary<string, EExpr>> Instantiate(Program program)
        {
            var ret = new Dictionary<string, Dictionary<string, EExpr>>();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = impl.Proc;
                impl.Blocks.Iter(blk => // replace assert (e) by assert (CIC => e)
                    {
                        for (int i = 0; i < blk.Cmds.Count; i++)
                        {
                            var ac = blk.Cmds[i] as AssertCmd;
                            if (ac != null && !BoogieUtil.isAssertTrue(blk.Cmds[i]))
                            {
                                var cons = FreshConstant(candCons);
                                blk.Cmds[i] = new AssertCmd(ac.tok, Expr.Imp(Expr.Ident(cons), ac.Expr));
                                candAsserts[cons.Name] = new Tuple<Expr,string>(ac.Expr, blk.Label);
                            }
                        }
                    });

                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;
                if (!ret.ContainsKey(proc.Name)) ret.Add(proc.Name, new Dictionary<string, EExpr>());

                List<Expr> requires = new List<Expr>();
                if (InNonNull || InImpOutNonNull || InImpOutNull)
                {
                    foreach (Variable p in proc.InParams) // requires(p != NULL)
                    {
                        if (!IsPointerVariable(p))
                            continue;
                        var expr = NonNull(p);
                        requires.Add(expr);
                        if (InNonNull)
                            proc.Requires.Add(CandiateRequire(expr, candCons, ret[impl.Name]));
                    }
                }
                foreach (Variable r in proc.OutParams) // ensures(p != NULL => r != NULL)
                {
                    if (!IsPointerVariable(r))
                        continue;
                    if (OutNonNull)
                    {
                        // out != NULL
                        proc.Ensures.Add(CandidateEnsure(NonNull(r), candCons, ret[impl.Name]));
                    }

                    if (InImpOutNonNull)
                    {
                        // in != NULL => out != NULL
                        requires.OfType<Expr>().
                            Iter(req =>
                            {
                                var expr = Expr.Imp(req, NonNull(r));
                                proc.Ensures.Add(CandidateEnsure(expr, candCons, ret[impl.Name]));
                            });
                    }

                    if (InImpOutNull)
                    {
                        // in == NULL => out == NULL
                        requires.OfType<Expr>().Iter(req =>
                            {
                                var expr = Expr.Imp(Expr.Not(req), Expr.Not(NonNull(r)));
                                proc.Ensures.Add(CandidateEnsure(expr, candCons, ret[impl.Name]));
                            });
                    }
                }
            }

            program.AddTopLevelDeclarations(candCons);
            //BoogieUtil.PrintProgram(program, "bfHoudini.bpl");
            return ret;
        }

        // return a candidate Ensures expression and add to corresponding info entry
        private Ensures CandidateEnsure(Expr cond, List<Constant> clist, Dictionary<string,EExpr> infoEntry)
        {
            var cons = FreshConstant(clist);
            var expr = Expr.Imp(Expr.Ident(cons), cond);
            var ret = new Ensures(false, expr);
            infoEntry.Add(cons.Name, new EExpr(cond, true));
            ret.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), ret.Attributes);
            return ret;
        }

        // return a candidate Require expression and add to corresponding info entry
        private Requires CandiateRequire(Expr cond, List<Constant> clist, Dictionary<string, EExpr> infoEntry)
        {
            var cons = FreshConstant(clist);
            var expr = Expr.Imp(Expr.Ident(cons), cond);
            var ret = new Requires(false, expr);
            ret.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), ret.Attributes);
            infoEntry.Add(cons.Name, new EExpr(cond, false));
            return ret;
        }

        // return a fresh existential constant
        private Constant FreshConstant(List<Constant> clist)
        {
            var constant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "CIC" + 
                (ConstCounter++).ToString(), Microsoft.Boogie.Type.Bool), false);
            constant.AddAttribute("existential", Expr.Literal(true));
            clist.Add(constant); // add to bool constant list
            return constant;
        }

        // need to be refined
        private bool IsPointerVariable(Variable x)
        {
            return x.TypedIdent.Type.IsInt &&
                !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
        }

        // return x > 0
        private Expr NonNull(Variable x)
        {
            return Expr.Gt(IdentifierExpr.Ident(x),
                              new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(0)));
        }
    }


    // Runs the Boogie verifier. Assumes that the program has not been inlined.
    public class StaticInlineAndVerifyPass : VerificationPass
    {
        StaticInliningAndUnrollingPass inliningPass;

        public StaticInlineAndVerifyPass(StaticSettings settings, bool needErrorTrace)
            : base(needErrorTrace)
        {
            passName = "Inline and verify pass";
            inliningPass = new StaticInliningAndUnrollingPass(settings);
        }

        public StaticInlineAndVerifyPass(StaticSettings settings, bool needErrorTrace, HashSet<string> varsToRecord)
            : base(needErrorTrace, varsToRecord)
        {
            passName = "Inline and verify pass";
            inliningPass = new StaticInliningAndUnrollingPass(settings);
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Do Inlining
            var prog = inliningPass.run(input);
            
            runVerificationPass(prog as PersistentCBAProgram);

            if (needErrorTraces)
            {
                // Map back trace
                for (int i = 0; i < traces.Count; i++)
                {
                    traces[i] = inliningPass.mapBackTrace(traces[i]);
                }
            }

            return null;
        }
    }

    // Common things for pruning a program, making it easier
    // for Verification
    public class PruneProgramPass : CompilerPass
    {
        // Unused Variable elimination
        UnReadVarEliminator varEliminator;

        // For compressing basic blocks
        CompressBlocks compressBlocks;

        // Remove unreachable procedures in the call graph?
        public static bool RemoveUnreachable = false;

        // Normalize statements
        public static bool normalizeStatements = false;

        public PruneProgramPass()
            : this(true)
        {

        }

        public PruneProgramPass(bool compress)
            : base()
        {
            passName = "Pruning program";
            varEliminator = null;
            if (!compress) compressBlocks = null;
            else compressBlocks = new CompressBlocks();
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Remove unreachable procedures
            if (RemoveUnreachable) BoogieUtil.pruneProcs(p, p.mainProcName);

            // normalize commands
            if (normalizeStatements) p.TopLevelDeclarations.OfType<Implementation>().Iter(normalizeImpl);
 
            // Re-do modset analysis
            BoogieUtil.DoModSetAnalysis(p);
            
            // Eliminate local variables that are never used (i.e., their value is never read)
            varEliminator = new UnReadVarEliminator();
            varEliminator.run(p);

            // Eliminate dead variables -- does not change the program.
            UnusedVarEliminator.Eliminate(p); 
            
            // Remove annotations that won't parse because of dropped variables
            RemoveVarsFromAttributes.Prune(p);

            // Compress basic blocks
            if(compressBlocks!=null)
              compressBlocks.VisitProgram(p);
            
            return p;
        }


        // Change:
        //   Mem := Mem[x := v]
        // to:
        //   Mem[x] := v
        // and:
        //   x := x;
        // to:
        //   assume true;  
        private void normalizeImpl(Implementation impl)
        {
            foreach (var blk in impl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var cmd = blk.Cmds[i] as AssignCmd;
                    if (cmd == null) continue;
                    if (cmd.Lhss.Count != 1) continue;

                    var lhs = cmd.Lhss[0] as SimpleAssignLhs;
                    if (lhs == null) continue;
                    if (!lhs.AssignedVariable.Decl.TypedIdent.Type.IsMap) continue;

                    var rhs = cmd.Rhss[0] as NAryExpr;
                    if (rhs == null) continue;
                    if (rhs.Fun.FunctionName != "MapStore") continue;
                    if (rhs.Args.Count != 3) continue;
                    var arg1 = rhs.Args[0] as IdentifierExpr;
                    if (arg1 == null) continue;

                    // The map variable is the same on both side
                    if (lhs.AssignedVariable.Decl.Name != arg1.Decl.Name) continue;

                    blk.Cmds[i] = BoogieAstFactory.MkMapAssign(arg1.Decl, rhs.Args[1], rhs.Args[2]);
                }

                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var cmd = blk.Cmds[i] as AssignCmd;
                    if (cmd == null) continue;
                    if (cmd.Lhss.Count != 1) continue;

                    var lhs = cmd.Lhss[0] as SimpleAssignLhs;
                    if (lhs == null) continue;

                    var rhs = cmd.Rhss[0] as IdentifierExpr;
                    if (rhs == null) continue;

                    if (lhs.AssignedVariable.Name != rhs.Decl.Name)
                        continue;

                    blk.Cmds[i] = BoogieAstFactory.MkAssume(Expr.True);
                }
            }
        }


        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            if(compressBlocks != null)
                trace = compressBlocks.mapBackTrace(trace);
            return varEliminator.mapBackTrace(trace);
            
            //return trace;
        }
    }

    // Common things for pruning a program, making it easier
    // for Verification
    public class PruneLocals : CompilerPass
    {
        // Unused Variable elimination
        UnReadVarEliminator varEliminator;

        public PruneLocals()
            : base()
        {
            passName = "Pruning program";
            varEliminator = null;
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {

            // Re-do modset analysis
            BoogieUtil.DoModSetAnalysis(p);

            // Eliminate local variables that are never used (i.e., their value is never read)
            varEliminator = new UnReadVarEliminator(true);
            varEliminator.run(p);

            // Eliminate dead variables -- does not change the program.
            UnusedVarEliminator.Eliminate(p);

            return p;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            return varEliminator.mapBackTrace(trace);

            //return trace;
        }
    }

    public class DeepAssertRewrite : CompilerPass
    {
        string origMain;

        Dictionary<string, string> firstBlockToImpl;
        
        // newBlock -> <origBlock, Proc>
        Dictionary<string, Tuple<string, string>> blockToOrig;
        
        // continue blocks
        HashSet<string> assertContinueBlocks;
        HashSet<string> callContinueBlocks;

        // exit blocks
        HashSet<string> exitBlocks; // for assert
        HashSet<string> callInlinedBlocks; // for calls

        // number of procs inlined into main
        public int procsIncludedInMain { get; private set; }

        // disable loop transformation
        public static bool disableLoops = false;

        public DeepAssertRewrite()
        {
            origMain = null;
            firstBlockToImpl = new Dictionary<string, string>();
            blockToOrig = new Dictionary<string, Tuple<string, string>>();
            assertContinueBlocks = new HashSet<string>();
            callContinueBlocks = new HashSet<string>();
            exitBlocks = new HashSet<string>();
            callInlinedBlocks = new HashSet<string>();
            procsIncludedInMain = 0;
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Prepare for stratified inlining with assertions
            var procsThatCannotReachAssert = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procsThatCannotReachAssert.Add(proc.Name));
            procsThatCannotReachAssert.ExceptWith(SequentialInstrumentation.procsWithAsserts(program));

            if (procsThatCannotReachAssert.Contains(program.mainProcName))
                return program;

            if (!disableLoops)
            {
                // loopy guys cannot reach asserts
                program.TopLevelDeclarations.OfType<LoopProcedure>()
                    .Iter(proc => procsThatCannotReachAssert.Add(proc.Name));

                program.TopLevelDeclarations.OfType<Procedure>()
                    .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "LoopProcedure"))
                    .Iter(proc => procsThatCannotReachAssert.Add(proc.Name));
            }

            // Make copies of all procedures that can reach assert
            var implCopy = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => !procsThatCannotReachAssert.Contains(impl.Name))
                .Iter(impl => implCopy.Add(impl.Name,
                    (new FixedDuplicator(true)).VisitImplementation(impl)));

            procsIncludedInMain = implCopy.Count;

            // Disable assertions in the original procedures
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl =>
                    impl.Blocks.Iter(blk =>
                    {
                        for (int i = 0; i < blk.Cmds.Count; i++)
                        {
                            var ac = blk.Cmds[i] as AssertCmd;
                            if (ac != null) blk.Cmds[i] = new AssumeCmd(ac.tok, ac.Expr);
                        }
                    }));

            // Identify main
            var main = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();
            if (main == null)
                main = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);

            var mainName = main.Name;
            origMain = main.Name;

            // delete entrypoint attribute
            main.Attributes = BoogieUtil.removeAttr("entrypoint", main.Attributes);
            main.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", main.Proc.Attributes);

            // rename stuff
            implCopy.Values
                .Where(impl => impl.Name != mainName)
                .Iter(impl => RenameImpl(impl));

            // Add all procedures to main
            var implToFirstBlock = new Dictionary<string, Block>();
            implCopy.Values
                .Iter(impl => implToFirstBlock.Add(impl.Name, impl.Blocks[0]));

            var mainCopy = implCopy[mainName];
            mainCopy.Blocks.Iter(blk => blockToOrig.Add(blk.Label, Tuple.Create(blk.Label, origMain)));

            mainCopy.AddAttribute("entrypoint");

            // Merge impls
            foreach (var impl in implCopy.Values)
            {
                if (impl.Name == mainName)
                    continue;
                // union locals
                mainCopy.LocVars.AddRange(impl.LocVars);
                // formals have already been substituted by locals
                mainCopy.LocVars.AddRange(impl.OutParams);
                mainCopy.LocVars.AddRange(impl.InParams);

                mainCopy.Blocks.AddRange(impl.Blocks);
            }

            // Block return in main
            foreach (var blk in mainCopy.Blocks.Where(b => b.TransferCmd is ReturnCmd))
                blk.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.False));

            // Change name of new main
            mainCopy.Name = "new" + mainCopy.Name;

            // Edit procedure calls in the copied impls
            var newLabCnt = 0;
            var GetNewLabel = new Func<string>(() =>
            {
                return "sia_lab" + (newLabCnt++);
            });

            var GetExitBlock = new Func<Block>(() =>
                new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(), new ReturnCmd(Token.NoToken)));

            var newBlocks1 = new List<Block>();
            var newBlocks2 = new List<Block>();

            foreach (var blk in mainCopy.Blocks)
            {
                var currBlock = new Block(blk.tok, blk.Label, new List<Cmd>(), null);

                foreach (var cmd in blk.Cmds)
                {
                    var acmd = cmd as AssertCmd;
                    if (acmd != null && !(acmd.Expr is LiteralExpr && (acmd.Expr as LiteralExpr).IsTrue))
                    {
                        // split for assertion
                        var lab = GetNewLabel();
                        var nblk = new Block(Token.NoToken, lab, new List<Cmd>(), null);
                        var eb = GetExitBlock();

                        // Finish current block
                        currBlock.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { nblk, eb });
                        eb.Cmds.Add(new AssertCmd(acmd.tok, acmd.Expr, acmd.Attributes));
                        nblk.Cmds.Add(new AssumeCmd(acmd.tok, acmd.Expr));

                        newBlocks2.Add(eb);
                        newBlocks1.Add(currBlock);
                        currBlock = nblk;

                        assertContinueBlocks.Add(nblk.Label);
                        exitBlocks.Add(eb.Label);

                        continue;
                    }

                    var ccmd = cmd as CallCmd;
                    if (ccmd != null && implToFirstBlock.ContainsKey(ccmd.callee))
                    {
                        var lab = GetNewLabel();
                        var afBlk = new Block(Token.NoToken, lab, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(implToFirstBlock[ccmd.callee].Label));
                        callInlinedBlocks.Add(afBlk.Label);

                        // formal-in := actuals
                        for (int i = 0; i < implCopy[ccmd.callee].InParams.Count; i++)
                        {
                            var formal = implCopy[ccmd.callee].InParams[i];
                            var actual = ccmd.Ins[i];
                            afBlk.Cmds.Add(BoogieAstFactory.MkVarEqExpr(formal, actual));
                        }

                        lab = GetNewLabel();
                        var nblk = new Block(Token.NoToken, lab, new List<Cmd>(), null);

                        // Finish current block
                        currBlock.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { nblk, afBlk });
                        newBlocks1.Add(currBlock);
                        newBlocks1.Add(afBlk);

                        nblk.Cmds.Add(ccmd);

                        callContinueBlocks.Add(nblk.Label);

                        currBlock = nblk;
                        continue;
                    }

                    currBlock.Cmds.Add(cmd);
                }

                currBlock.TransferCmd = blk.TransferCmd;
                newBlocks1.Add(currBlock);
            }

            mainCopy.Blocks = newBlocks1;
            mainCopy.Blocks.AddRange(newBlocks2);

            implToFirstBlock.Iter(kvp => firstBlockToImpl.Add(kvp.Value.Label, kvp.Key));

            if (!disableLoops)
            {
                // Get rid of loops in main
                var l2b = BoogieUtil.labelBlockMapping(mainCopy);
                foreach (var b in mainCopy.Blocks)
                {
                    var tc = b.TransferCmd as GotoCmd;
                    if (tc == null) continue;
                    tc.labelTargets = new List<Block>(tc.labelNames.Select(s => l2b[s]));
                }

                mainCopy.Blocks = LoopUnroll.UnrollLoops(mainCopy.Blocks[0], CommandLineOptions.Clo.RecursionBound, false);

                // detect loops
                l2b = BoogieUtil.labelBlockMapping(mainCopy);
                var color = new Dictionary<Block, int>();
                mainCopy.Blocks.Iter(b => color.Add(b, 0));
                var Succ = new Func<Block, IEnumerable<Block>>(b =>
                {
                    var succ = new List<Block>();
                    var gc = b.TransferCmd as GotoCmd;
                    if (gc == null) return succ;
                    gc.labelNames.Iter(s => succ.Add(l2b[s]));
                    return succ;
                });
                var parentTree = new Dictionary<Block, Block>();
                var cycle = new List<Block>();
                // DFS
                try
                {
                    DFS(mainCopy.Blocks[0], null, Succ, color, parentTree, cycle);
                }
                catch (Exception)
                {
                    var firstBlockToImpl = new Dictionary<string, string>();
                    implToFirstBlock.Iter(kvp => firstBlockToImpl.Add(kvp.Value.Label, kvp.Key));

                    cycle.Reverse();
                    cycle.Where(b => firstBlockToImpl.ContainsKey(b.Label))
                        .Iter(b => Console.WriteLine("{0}", firstBlockToImpl[b.Label]));
                    throw;
                }
            }

            // Add new main back to the program
            program.AddTopLevelDeclaration(mainCopy);
            program.mainProcName = mainCopy.Name;

            // add decl for newmain
            var origMainDecl = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => proc.Name == mainName)
                .FirstOrDefault();
            var newMainDecl = (new Duplicator()).VisitProcedure(origMainDecl);
            newMainDecl.Name = mainCopy.Name;
            mainCopy.Proc = newMainDecl;
            program.AddTopLevelDeclaration(newMainDecl);

            if (disableLoops)
            {
                // need to get loops out of main
                program = new CBAProgram(BoogieUtil.ReResolve(program), program.mainProcName, program.contextBound);
                var ex = new ExtractLoopsPass(true);
                program = ex.runCBAPass(program);
                // redo IDs
                (new AddUniqueCallIds()).VisitProgram(program);
                return program;
            }

            return program;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            // undo loop unrolling
            trace = LoopUnrollingPass.undoUnrolling(trace);

            // This transformation is: rename blocks, instrument calls, instrument assertions
            var ret = mapBackTraceRec(trace, 0, origMain);
            //PrintProgramPath.print(input, ret, "tr");
            return ret;
        }

        private ErrorTrace mapBackTraceRec(ErrorTrace trace, int currBlockNum, string procName)
        {
            var ret = new ErrorTrace(procName);
            var first = true;

            while (currBlockNum < trace.Blocks.Count)
            {
                var currBlock = trace.Blocks[currBlockNum];

                if (!first && firstBlockToImpl.ContainsKey(currBlock.blockName))
                {
                    var callee = firstBlockToImpl[currBlock.blockName];
                    var calleeTrace = mapBackTraceRec(trace, currBlockNum, callee);
                    var blk = ret.Blocks.Last();
                    blk.Cmds.Add(new CallInstr(calleeTrace));
                    return ret;
                }

                // what kind of block is this?
                if (blockToOrig.ContainsKey(currBlock.blockName))
                {
                    Debug.Assert(blockToOrig[currBlock.blockName].Item2 == ret.procName);
                    var blk = new ErrorTraceBlock(blockToOrig[currBlock.blockName].Item1);
                    currBlock.Cmds.Iter(c => blk.Cmds.Add(c));
                    ret.Blocks.Add(blk);
                }
                else if (assertContinueBlocks.Contains(currBlock.blockName))
                {
                    var blk = ret.Blocks.Last();
                    currBlock.Cmds.Iter(c => blk.Cmds.Add(c));
                }
                else if (callContinueBlocks.Contains(currBlock.blockName))
                {
                    var blk = ret.Blocks.Last();
                    currBlock.Cmds.Iter(c => blk.Cmds.Add(c));
                }
                else if (exitBlocks.Contains(currBlock.blockName))
                {
                    var blk = ret.Blocks.Last();
                    currBlock.Cmds.Iter(c => blk.Cmds.Add(c));
                }
                else if (callInlinedBlocks.Contains(currBlock.blockName))
                {
                    // skip this block
                }
                else
                {
                    Debug.Assert(false);
                }

                currBlockNum++;
                first = false;
            }
            return ret;
        }

        // Maps block label to the procedure that it come from,
        // when it is the entry block of that procedure
        public string EntryBlockToProc(string blockLabel)
        {
            var label = LoopUnroll.sanitizeLabel(blockLabel);
            if (!firstBlockToImpl.ContainsKey(label))
                return null;
            return firstBlockToImpl[label];
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


        // Rename basic blocks, local variables
        // Add "havoc locals" at the beginning
        // block return
        private void RenameImpl(Implementation impl)
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
                blockToOrig.Add(newName, Tuple.Create(origBlocks[blk.Label].Label, origImpl.Name));
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

        // Instrument deep asserts in a trace
        public static PersistentCBAProgram InstrumentTrace(PersistentCBAProgram ptrace, GlobalRefinementState refinementState)
        {
            var program = ptrace.getProgram();
            var main = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, ptrace.mainProcName);

            var av = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "DA_assertVar", Microsoft.Boogie.Type.Bool));

            // convert "assert e" to "DA_assertVar := e"
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        if (blk.Cmds[i] is AssertCmd && !BoogieUtil.isAssertTrue(blk.Cmds[i]))
                        {
                            blk.Cmds[i] = BoogieAstFactory.MkVarEqExpr(av, (blk.Cmds[i] as AssertCmd).Expr);
                        }
                    }

                }
            }

            // DA_assertVar := true
            var sblk = new Block(Token.NoToken, "newMainStartBlk__0", new List<Cmd>(),
                BoogieAstFactory.MkGotoCmd(main.Blocks[0].Label));

            sblk.Cmds.Add(BoogieAstFactory.MkVarEqConst(av, true));
            var nblks = main.Blocks;
            main.Blocks = new List<Block>();
            main.Blocks.Add(sblk);
            main.Blocks.AddRange(nblks);

            // assert DA_assertVar
            main.Blocks.Where(blk => blk.TransferCmd is ReturnCmd)
                .Iter(blk => blk.Cmds.Add(BoogieAstFactory.MkAssert(Expr.Ident(av))));

            program.AddTopLevelDeclaration(av);
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Proc.Modifies.Add(Expr.Ident(av)));

            // Reflect the addition of a new global variable on
            // our refinement state
            refinementState.Add(new AddVarMapping(new VarSet(av.Name, "")));

            return new PersistentCBAProgram(program, ptrace.mainProcName, ptrace.contextBound);
        }

        // Inverse for InstrumentTrace
        public ErrorTrace InstrumentTraceMapBack(ErrorTrace trace)
        {
            // get rid of first block of main and the last assert
            Debug.Assert(trace.Blocks[0].blockName == "newMainStartBlk__0");
            trace.Blocks.RemoveAt(0);
            var lastBlk = trace.Blocks.Last();
            lastBlk.Cmds.RemoveAt(lastBlk.Cmds.Count - 1);
            return trace;
        }
    }

    /* TODO: Unify with DeepAssertRewrite */
    public class ConcurrentDeepAssertRewrite : CompilerPass
    {
        public string newMainName;
        public HashSet<string> newVars;

        Dictionary<string, string> firstBlockToImpl;

        // newBlock -> <origBlock, Proc>
        Dictionary<string, Tuple<string, string>> blockToOrig;

        // continue blocks
        HashSet<string> assertContinueBlocks;
        HashSet<string> callContinueBlocks;

        public ConcurrentDeepAssertRewrite()
        {
            newMainName = null;
            firstBlockToImpl = new Dictionary<string, string>();
            blockToOrig = new Dictionary<string, Tuple<string, string>>();
            assertContinueBlocks = new HashSet<string>();
            callContinueBlocks = new HashSet<string>();
            newVars = new HashSet<string>();
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Identify main
            var main = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint") ||
                    QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                .FirstOrDefault();
            if (main == null && program.mainProcName != null)
                main = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            if (main.OutParams.Count != 0)
            {
                // create a dummy main that calls the original one
                main = CreateDummyMain(program, main);
                program.mainProcName = main.Name;
            }
            SequentialInstrumentation.isSingleThreadProgram(program, main.Name);

            // Prepare for stratified inlining with assertions
            var procsThatCannotReachAssert = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procsThatCannotReachAssert.Add(proc.Name));
            procsThatCannotReachAssert.ExceptWith(procsThatCanSequentiallyReachAsserts(program));

            //if (procsThatCannotReachAssert.Contains(program.mainProcName))
            //    return program;

            // loopy guys cannot reach asserts
            program.TopLevelDeclarations.OfType<LoopProcedure>()
                .Iter(proc => procsThatCannotReachAssert.Add(proc.Name));

            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "LoopProcedure"))
                .Iter(proc => procsThatCannotReachAssert.Add(proc.Name));

            // Make copies of all procedures that can reach assert
            var implCopy = new Dictionary<string, Implementation>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => !procsThatCannotReachAssert.Contains(impl.Name))
                .Iter(impl => implCopy.Add(impl.Name,
                    (new FixedDuplicator(true)).VisitImplementation(impl)));

            // Disable assertions in the original procedures
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl =>
                    impl.Blocks.Iter(blk =>
                    {
                        for (int i = 0; i < blk.Cmds.Count; i++)
                        {
                            var ac = blk.Cmds[i] as AssertCmd;
                            if (ac != null) blk.Cmds[i] = new AssumeCmd(ac.tok, ac.Expr);
                        }
                    }));


            // async procs
            var asyncProcs = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(blk => blk.Cmds.OfType<CallCmd>()
                        .Where(c => c.IsAsync)
                        .Iter(c => asyncProcs.Add(c.callee))));
            asyncProcs.Add(main.Name);

            // flag
            var flag = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "daFlag", Microsoft.Boogie.Type.Int));
            // proc To Num
            var procToNum = new Dictionary<string, int>();
            foreach (var p in asyncProcs)
                procToNum.Add(p, procToNum.Count + 1);
            newVars.Add(flag.Name);

            // constants for arguments
            var argConstants = new Dictionary<Microsoft.Boogie.Type, List<Constant>>();
            var argCnt = 0;
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>().Where(i => asyncProcs.Contains(i.Name)))
            {
                var myCnt = new Dictionary<Microsoft.Boogie.Type, int>();
                foreach (var v in impl.InParams)
                {
                    var vType = v.TypedIdent.Type;
                    if (!myCnt.ContainsKey(vType))
                    {
                        myCnt[vType] = 0;
                    }
                    if (!argConstants.ContainsKey(vType))
                    {
                        argConstants[vType] = new List<Constant>();
                    }
                    if (argConstants[vType].Count == myCnt[vType])
                    {
                        argConstants[vType].Add(new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "daArg" + argCnt.ToString(), vType)));
                        argCnt++;
                    }
                    myCnt[vType] = myCnt[vType] + 1;
                }
            }
            Console.WriteLine("Creating {0} constants for async proc arguments", argCnt);

            var mainName = main.Name;

            // delete entrypoint attribute
            main.Attributes = BoogieUtil.removeAttr("entrypoint", main.Attributes);
            main.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", main.Proc.Attributes);

            // create a new main
            var newMainProc = new Procedure(Token.NoToken, "daFakeMain", new List<TypeVariable>(main.Proc.TypeParameters),
                new List<Variable>(main.Proc.InParams), new List<Variable>(main.Proc.OutParams), new List<Requires>(main.Proc.Requires),
                new List<IdentifierExpr>(), new List<Ensures>(main.Proc.Ensures));

            var newMainImpl = new Implementation(Token.NoToken, "daFakeMain", new List<TypeVariable>(main.TypeParameters),
                new List<Variable>(main.InParams), new List<Variable>(main.OutParams), new List<Variable>(), new List<Block>());

            newMainImpl.AddAttribute("entrypoint");
            newMainProc.AddAttribute("entrypoint");
            newMainName = newMainImpl.Name;

            // rename stuff
            implCopy.Values
                .Iter(impl => RenameImpl(impl));

            // Add all procedures to main
            var implToFirstBlock = new Dictionary<string, Block>();
            implCopy.Values
                .Iter(impl => implToFirstBlock.Add(impl.Name, impl.Blocks[0]));

            // Merge impls
            foreach (var impl in implCopy.Values)
            {
                // union locals
                newMainImpl.LocVars.AddRange(impl.LocVars);
                // formals have already been substituted by locals
                newMainImpl.LocVars.AddRange(impl.OutParams);
                newMainImpl.LocVars.AddRange(impl.InParams);

                newMainImpl.Blocks.AddRange(impl.Blocks);
            }

            // Block return in main
            foreach (var blk in newMainImpl.Blocks.Where(b => b.TransferCmd is ReturnCmd))
                blk.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.False));

            // Edit procedure calls in the copied impls
            var newLabCnt = 0;
            var GetNewLabel = new Func<string>(() =>
            {
                return "sia_lab" + (newLabCnt++);
            });

            var GetExitBlock = new Func<Block>(() =>
                new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(), new ReturnCmd(Token.NoToken)));

            var newBlocks1 = new List<Block>();
            var newBlocks2 = new List<Block>();

            foreach (var blk in newMainImpl.Blocks)
            {
                var currBlock = new Block(blk.tok, blk.Label, new List<Cmd>(), null);

                foreach (var cmd in blk.Cmds)
                {
                    var ccmd = cmd as CallCmd;
                    if (ccmd != null && implToFirstBlock.ContainsKey(ccmd.callee) && !ccmd.IsAsync)
                    {
                        var lab = GetNewLabel();
                        var afBlk = new Block(Token.NoToken, lab, new List<Cmd>(), BoogieAstFactory.MkGotoCmd(implToFirstBlock[ccmd.callee].Label));

                        // formal-in := actuals
                        for (int i = 0; i < implCopy[ccmd.callee].InParams.Count; i++)
                        {
                            var formal = implCopy[ccmd.callee].InParams[i];
                            var actual = ccmd.Ins[i];
                            afBlk.Cmds.Add(BoogieAstFactory.MkVarEqExpr(formal, actual));
                        }

                        lab = GetNewLabel();
                        var nblk = new Block(Token.NoToken, lab, new List<Cmd>(), null);

                        // Finish current block
                        currBlock.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { nblk, afBlk });
                        newBlocks1.Add(currBlock);
                        newBlocks1.Add(afBlk);

                        nblk.Cmds.Add(ccmd);

                        currBlock = nblk;
                        continue;
                    }
                    currBlock.Cmds.Add(cmd);
                }

                currBlock.TransferCmd = blk.TransferCmd;
                newBlocks1.Add(currBlock);
            }

            newMainImpl.Blocks = newBlocks1;
            newMainImpl.Blocks.AddRange(newBlocks2);

            implToFirstBlock.Iter(kvp => firstBlockToImpl.Add(kvp.Value.Label, kvp.Key));

            // add preamble for the new main
            //   flag := 0
            //   if(*)
            //      async main() && dispatch to thread entries on flag
            //   else
            //      flag := main && goto main

            var mainCanFail = !procsThatCannotReachAssert.Contains(main.Name);
            var threadEntryBlocks = new Dictionary<string, Block>();
            foreach (var p in asyncProcs)
            {
                if (!implToFirstBlock.ContainsKey(p))
                    continue;

                var blk = new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(), BoogieAstFactory.MkGotoCmd(implToFirstBlock[p].Label));
                var pcopy = implCopy[p];
                var myCnt = new Dictionary<Microsoft.Boogie.Type, int>();
                foreach (var v in pcopy.InParams)
                {
                    var vType = v.TypedIdent.Type;
                    if (!myCnt.ContainsKey(vType))
                    {
                        myCnt[vType] = 0;
                    }
                    var idx = myCnt[vType];
                    blk.Cmds.Add(BoogieAstFactory.MkAssumeVarEqVar(v, argConstants[vType][idx]));
                    myCnt[vType] = idx + 1;
                }
                blk.Cmds.Add(BoogieAstFactory.MkAssumeVarEqConst(flag, procToNum[p]));
                threadEntryBlocks.Add(p, blk);
            }
            var sb2 = new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(),
                mainCanFail ? BoogieAstFactory.MkGotoCmd(threadEntryBlocks[main.Name].Label) as TransferCmd : new ReturnCmd(Token.NoToken));
            if (mainCanFail)
            {
                sb2.Cmds.Add(BoogieAstFactory.MkVarEqConst(flag, procToNum[main.Name]));
            }
            var gcAll = new GotoCmd(Token.NoToken, new List<string>(threadEntryBlocks.Where(kvp => kvp.Key != main.Name)
                    .Select(kvp => kvp.Value.Label))) as TransferCmd;
            if ((gcAll as GotoCmd).labelNames.Count == 0)
                gcAll = new ReturnCmd(Token.NoToken);

            var sb3 = new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(),
                gcAll);
            sb3.Cmds.Add(new CallCmd(Token.NoToken, main.Name,
                new List<Expr>(newMainImpl.InParams.Select(v => Expr.Ident(v))), new List<IdentifierExpr>(newMainImpl.OutParams.Select(v => Expr.Ident(v))), null, true));

            var sb1 = new Block(Token.NoToken, GetNewLabel(), new List<Cmd>(),
                BoogieAstFactory.MkGotoCmd(sb2.Label, sb3.Label));
            sb1.Cmds.Add(BoogieAstFactory.MkVarEqConst(flag, 0));


            var nb = new List<Block>();
            nb.Add(sb1); nb.Add(sb2); nb.Add(sb3);
            nb.AddRange(threadEntryBlocks.Values);
            nb.AddRange(newMainImpl.Blocks);
            newMainImpl.Blocks = nb;

            program.AddTopLevelDeclaration(flag);
            foreach (var cnsts in argConstants.Values)
            {
                program.AddTopLevelDeclarations(cnsts);
            }

            // Instrument async in original procedures
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var newBlocks = new List<Block>();

                foreach (var blk in impl.Blocks)
                {
                    var currCmds = new List<Cmd>();
                    var currLabel = blk.Label;

                    foreach (var cmd in blk.Cmds)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd == null || !ccmd.IsAsync || !implToFirstBlock.ContainsKey(ccmd.callee))
                        {
                            currCmds.Add(cmd);
                            continue;
                        }
                        var lab1 = GetNewLabel();
                        var lab2 = GetNewLabel();
                        var lab3 = GetNewLabel();

                        // end current block
                        newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds,
                            BoogieAstFactory.MkGotoCmd(lab1, lab2)));

                        // lab1: set args; flag := T; goto lab3;
                        var cmds1 = new List<Cmd>();
                        var myCnt = new Dictionary<Microsoft.Boogie.Type, int>();
                        for (int i = 0; i < ccmd.Ins.Count; i++)
                        {
                            var vType = ccmd.Proc.InParams[i].TypedIdent.Type;
                            if (!myCnt.ContainsKey(vType))
                            {
                                myCnt[vType] = 0;
                            }
                            var idx = myCnt[vType];
                            cmds1.Add(BoogieAstFactory.MkAssume(Expr.Eq(ccmd.Ins[i], Expr.Ident(argConstants[vType][idx]))));
                            myCnt[vType] = idx + 1;
                        }
                        cmds1.Add(BoogieAstFactory.MkVarEqConst(flag, procToNum[ccmd.callee]));
                        newBlocks.Add(new Block(Token.NoToken, lab1, cmds1, 
                            BoogieAstFactory.MkGotoCmd(lab3)));

                        // lab2: ccmd
                        newBlocks.Add(new Block(Token.NoToken, lab2, new List<Cmd>{ccmd},
                            BoogieAstFactory.MkGotoCmd(lab3)));

                        currLabel = lab3;
                        currCmds = new List<Cmd>();
                    }
                    newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds,
                        blk.TransferCmd));
                }
                impl.Blocks = newBlocks;
            }

            // detect loops
            var l2b = BoogieUtil.labelBlockMapping(newMainImpl);
            var color = new Dictionary<Block, int>();
            newMainImpl.Blocks.Iter(b => color.Add(b, 0));
            var Succ = new Func<Block, IEnumerable<Block>>(b =>
            {
                var succ = new List<Block>();
                var gc = b.TransferCmd as GotoCmd;
                if (gc == null) return succ;
                gc.labelNames.Iter(s => succ.Add(l2b[s]));
                return succ;
            });
            var parentTree = new Dictionary<Block, Block>();
            var cycle = new List<Block>();
            // DFS
            try
            {
                DFS(newMainImpl.Blocks[0], null, Succ, color, parentTree, cycle);
            }
            catch (Exception)
            {
                var firstBlockToImpl = new Dictionary<string, string>();
                implToFirstBlock.Iter(kvp => firstBlockToImpl.Add(kvp.Value.Label, kvp.Key));

                cycle.Reverse();
                cycle.Where(b => firstBlockToImpl.ContainsKey(b.Label))
                    .Iter(b => Console.WriteLine("{0}", firstBlockToImpl[b.Label]));
                throw;
            }

            var bwa = new HashSet<Block>();
            newMainImpl.Blocks
                .Where(blk => blk.Cmds.OfType<AssertCmd>()
                    .Any(c => !BoogieUtil.isAssertTrue(c)))
                .Iter(blk => bwa.Add(blk));
            if (bwa.All(b => color[b] == 0))
            {
                Console.WriteLine("Assert statically not reachable");
            }
                    
            // Add new main back to the program
            program.AddTopLevelDeclaration(newMainImpl);

            // add decl for newmain
            newMainImpl.Proc = newMainProc;
            program.AddTopLevelDeclaration(newMainProc);
            program.mainProcName = newMainName;

            return program;
        }

        private Implementation CreateDummyMain(Program program, Implementation main) 
        {
            var dup = new FixedDuplicator();
            var newMain = dup.VisitImplementation(main);
            var newProc = dup.VisitProcedure(main.Proc);

            newMain.Name = "DA_dummy_" + main.Name;
            newProc.Name = "DA_dummy_" + main.Name;
            newMain.Proc = newProc;

            // drop out params -- make them locals
            newMain.LocVars = new List<Variable>();
            newMain.LocVars.AddRange(newMain.OutParams);
            newMain.OutParams = new List<Variable>();
            newProc.OutParams = new List<Variable>();

            var mainIns = new List<Expr>();
            foreach (Variable v in newMain.InParams)
            {
                mainIns.Add(Expr.Ident(v));
            }
            var mainOuts = new List<IdentifierExpr>();
            foreach (Variable v in newMain.LocVars)
            {
                mainOuts.Add(Expr.Ident(v));
            }

            var callMain = new CallCmd(Token.NoToken, main.Name, mainIns, mainOuts);
            callMain.Proc = main.Proc;

            var blk = new Block(Token.NoToken, "start", new List<Cmd>{callMain}, new ReturnCmd(Token.NoToken));
            newMain.Blocks = new List<Block>();
            newMain.Blocks.Add(blk);

            program.AddTopLevelDeclaration(newProc);
            program.AddTopLevelDeclaration(newMain);

            // Set entrypoint
            main.Attributes = BoogieUtil.removeAttr("entrypoint", main.Attributes);
            main.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", main.Proc.Attributes);

            newMain.AddAttribute("entrypoint");
            newMain.Proc.AddAttribute("entrypoint");

            return newMain;
        }


        public static HashSet<string> procsThatCanSequentiallyReachAsserts(Program program)
        {
            var pwa = new HashSet<string>();

            // backward call graph
            var callGraph = new Dictionary<string, HashSet<string>>();

            program.TopLevelDeclarations.OfType<Procedure>().Iter(
                proc => callGraph.Add(proc.Name, new HashSet<string>()));

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    foreach (var cmd in blk.Cmds.OfType<CallCmd>().Where(c => !c.IsAsync))
                    {
                        callGraph[cmd.callee].Add(impl.Name);
                    }

                    foreach (var cmd in blk.Cmds.OfType<AssertCmd>())
                    {
                        if (!BoogieUtil.isAssertTrue(cmd))
                        {
                            pwa.Add(impl.Name);
                            break;
                        }
                    }
                }
            }

            // find reachable procedures
            var reachable = new HashSet<string>();
            reachable.UnionWith(pwa);
            reachable.Add(LanguageSemantics.assertNotReachableName());

            // Transitive closure
            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0)
            {
                var nf = new HashSet<string>();
                foreach (var n in delta)
                {
                    if (callGraph.ContainsKey(n)) nf.UnionWith(callGraph[n]);
                }
                delta = nf.Difference(reachable);
                reachable.UnionWith(nf);
            }

            return reachable;
        }


        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            throw new NotImplementedException();
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


        // Rename basic blocks, local variables
        // Add "havoc locals" at the beginning
        // block return
        private void RenameImpl(Implementation impl)
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
                blockToOrig.Add(newName, Tuple.Create(origBlocks[blk.Label].Label, origImpl.Name));
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

    }

}
