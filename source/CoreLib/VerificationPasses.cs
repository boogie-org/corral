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

                program.TopLevelDeclarations.Add(intDecl);
            }

            Procedure boolDecl = BoogieUtil.findProcedureDecl(program.TopLevelDeclarations, recordBoolArgProc);
            if (boolDecl == null)
            {
                var inv = new List<Variable>();
                inv.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Bool), true));

                boolDecl = new Procedure(Token.NoToken, recordBoolArgProc, new List<TypeVariable>(), inv, new List<Variable>(), new List<Requires>(),
                    new List<IdentifierExpr>(), new List<Ensures>());

                program.TopLevelDeclarations.Add(boolDecl);
            }

            // Get the set of implementations in the program
            var impls = new HashSet<string>();
            BoogieUtil.GetImplementations(program).ForEach(impl => impls.Add(impl.Name));

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
                                v = (modelVal as Model.Integer).AsInt();
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
                            v = (modelVal as Model.Integer).AsInt();
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
                var mods = new HashSet<string>();
                proc.Modifies.OfType<IdentifierExpr>()
                    .Iter(ie => mods.Add(ie.Name));

                if (!mustMod.IsSubsetOf(mods)) return false;
                if (mustNotMod.Intersection(mods).Any()) return false;
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

        // Template
        public HashSet<Variable> templateVars;
        public List<EExpr> templates;
        public int InlineDepth;
        private HashSet<string> templateVarNames;
        private ExtractLoopsPass elPass;
        public static bool runHoudini = true;
        public string printHoudiniQuery = null;

        // Named constants: (implName, id) -> set of constants with that id
        Dictionary<Tuple<string, string>, HashSet<string>> namedConstants;
        // Dependencies: constant -> id that it depends on
        Dictionary<string, string> dependenciesBetConstants;

        private Dictionary<string, IEnumerable<Expr>> staticAnalysisSummaries;
        private Dictionary<string, IEnumerable<Expr>> staticAnalysisPreconditions;
        private HashSet<string> staticAnalysisConstants;
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
            staticAnalysisConstants = new HashSet<string>();

            this.namedConstants = new Dictionary<Tuple<string, string>, HashSet<string>>();
            this.dependenciesBetConstants = new Dictionary<string, string>();

            ExtractLoops = true;
            templateVarNames = new HashSet<string>();
            templateVars.Iter(v => templateVarNames.Add(v.Name));
        }

        private Expr UpdateVars(Expr expr, Dictionary<string, Variable> globals)
        {
            var dup = new FixedDuplicator();
            var subst = new Dictionary<string, Variable>();
            var e = dup.VisitExpr(expr);
            e = (new VarSubstituter(subst, globals)).VisitExpr(e);
            return e;
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

            var templateVarUsed = gused.globalsUsed.Intersection(templateVarNames);
            if (templateVarUsed.Count == 0)
            {
                var subst = new Dictionary<string, Variable>();
                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals, funcs)).VisitExpr(e);
                ret.Add(e);
                return ret;
            }
            Debug.Assert(templateVarUsed.Count == 1, "Can only handle 1 template variable per expression");
            var tvName = templateVarUsed.First();
            var tv = templateVars.First(v => v.Name == tvName);


            var includeFormalIn = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalIn");
            var includeFormalOut = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalOut");
            var includeGlobals = QKeyValue.FindBoolAttribute(tv.Attributes, "includeGlobals");

            if (!includeFormalIn && !includeFormalOut && !includeGlobals)
            {
                includeFormalIn = true;
                includeFormalOut = true;
                includeGlobals = true;
            }

            var onlyMatchVar = QKeyValue.FindStringAttribute(tv.Attributes, "match");
            System.Text.RegularExpressions.Regex matchRegEx = null;
            if(onlyMatchVar != null) matchRegEx = new System.Text.RegularExpressions.Regex(onlyMatchVar);

            foreach (var kvp in globals.Concat(formals))
            {
                if (tv.TypedIdent.Type.ToString() !=  kvp.Value.TypedIdent.Type.ToString())
                    continue;

                if (kvp.Value is Constant) continue;
                if (matchRegEx != null && !matchRegEx.IsMatch(kvp.Key)) continue;
                if (!includeFormalIn && kvp.Value is Formal && (kvp.Value as Formal).InComing) continue;
                if (!includeFormalOut && kvp.Value is Formal && !(kvp.Value as Formal).InComing) continue;
                if (!includeGlobals && kvp.Value is GlobalVariable) continue;

                var subst = new Dictionary<string, Variable>();
                subst.Add(tvName, kvp.Value);

                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals)).VisitExpr(e);
                ret.Add(e);
            }

            return ret;
        }

        public bool onlyEnsures()
        {
            foreach (var e in templates)
            {
                if (e.IsRequires) return false;
            }
            return true;
        }

        public Dictionary<string, Dictionary<string, EExpr>> Instantiate(Program program)
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

            // Iterate over templates
            foreach (var template in templates)
            {
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var proc = impl.Proc;
                    if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;
                    if (!template.Match(proc)) continue;

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
                            proc.Ensures.Add(ens);
                        }
                        else
                        {
                            var req = new Requires(false, e);
                            req.Attributes = new QKeyValue(Token.NoToken, "candidate", new List<object>(), template.annotations);
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
                    }
                    else
                    {
                        var ens = new Ensures(true, addOld(expr));
                        name2Impl[impl.Name].Proc.Ensures.Add(ens);
                    }

                    
                    ret[impl.Name].Add(constant.Name, new EExpr(expr, true));
                }
            }

            program.TopLevelDeclarations.AddRange(constants);

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

            ModSetCollector.DoModSetAnalysis(program);

            DoStaticAnalysis(program);

            var info = Instantiate(program);

            if (!runAbsHoudini && info.Count == 0 && summaries.Count == 0) return program;

            if (runHoudini)
            {
                if (info.Count != 0)
                {
                    (new RewriteCallDontCares()).VisitProgram(program);
                    RunHoudini(program, info);
                    program = (input as PersistentCBAProgram).getCBAProgram();
                }
            }
            else
            {
                Debug.Assert(onlyEnsures());
                // Turn on summary computation in Boogie
                Debug.Assert(CommandLineOptions.Clo.StratifiedInlining > 0);
                CommandLineOptions.Clo.StratifiedInliningOption = 6;
            }

            // Insert summaries
            addSummaries(program);
            
            return program;
        }

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

            ModSetCollector.DoModSetAnalysis(program);

            DoStaticAnalysis(program);

            // fake abs houdini to get the template instantiation correct
            runAbsHoudiniConfig = "";
            // We don't want predicates from "main"
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "main");
            if (impl != null) impl.AddAttribute("entrypoint");

            var info = Instantiate(program);

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

            AbstractHoudini absHoudini = null;
            PredicateAbs.Initialize(program);
            absHoudini = new AbstractHoudini(program);
            absHoudini.computeSummaries(new PredicateAbs(program.TopLevelDeclarations.OfType<Implementation>().First().Name));
            // Abstract houdini sets a prover option for the time limit. Get rid of that now
            CommandLineOptions.Clo.ProverOptions.RemoveAll(str => str.StartsWith("TIME_LIMIT"));

            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;

            // Record new summaries
            var predicates = absHoudini.GetPredicates();
            
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
            var attr = new QKeyValue(Token.NoToken, "va_keep", new List<object>(), null);

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
            Console.WriteLine("Running {0}Houdini", runAbsHoudini ? "Abstract " : "");

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
                        var acmd = blk.Cmds[i] as AssertCmd;
                        if (acmd == null) continue;
                        var le = acmd.Expr as LiteralExpr;
                        if (le != null && le.IsTrue) continue;
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
                                    if (acmd == null || BoogieUtil.isAssertTrue(cmd))
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
            allGlobals.ForEach(g => globals.Add(g.Name, g));

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
            CommandLineOptions.Clo.ProverCCLimit = 5;
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

                inline(program);
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
                    CommandLineOptions.Clo.ProverOptions.RemoveAll(str => str.StartsWith("TIME_LIMIT"));
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
                        Console.WriteLine("Inferred {0} contracts", trueConstants.Count);
                    }
                    var time4 = DateTime.Now;
                    Log.WriteLine(Log.Debug, "Houdini took {0} seconds", (time4 - time3).TotalSeconds.ToString("F2"));
                    houdini = null;
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
                    origProg.TopLevelDeclarations.AddRange(newAxioms);
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
        private static Expr addOld(Expr expr)
        {
            return Substituter.Apply(Subst, expr);
        }

        private void inline(Program program)
        {
            if (CommandLineOptions.Clo.InlineDepth >= 0)
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
                        Inliner.ProcessImplementation(program, impl);
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


    // For SDV: Given a program (representing a path) that is SAT, add concretization
    // to determinize the trace
    public class SDVConcretizePathPass : CompilerPass
    {
        public bool success;
        readonly string recordProcName = "boogie_si_record_sdvcp_int";
        readonly string initLocProcName = "init_locals_nondet__tmp";
        public Dictionary<string, Tuple<string, string, int>> allocConstants;
        Dictionary<int, Tuple<string, string, int>> callIdToLocation;

        private HashSet<string> procsWithoutBody;

        public SDVConcretizePathPass(Dictionary<int, Tuple<string, string, int>> callIdToLocation)
        {
            success = false;
            procsWithoutBody = new HashSet<string>();
            allocConstants = new Dictionary<string, Tuple<string, string, int>>();
            this.callIdToLocation = callIdToLocation;
        }
        
        public override CBAProgram runCBAPass(CBAProgram p)
        {
            p.Typecheck();

            p.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procsWithoutBody.Add(proc.Name));
            p.TopLevelDeclarations.OfType<Implementation>().Iter(impl => procsWithoutBody.Remove(impl.Name));

            // remove malloc
            //procsWithoutBody.RemoveWhere(str => str.Contains("malloc"));

            // Make sure that procs without a body don't modify globals
            foreach (var proc in p.TopLevelDeclarations.OfType<Procedure>().Where(proc => procsWithoutBody.Contains(proc.Name)))
            {
                if (proc.Modifies.Count > 0 && !proc.Name.Contains("HAVOC_malloc"))
                    throw new InvalidInput("Produce Bug Witness: Procedure " + proc.Name + " modifies globals");
            }

            // Add the boogie_si_record_int procedure
            var inpVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), true);
            var inpArgs = new List<Variable>();
            inpArgs.Add(inpVar);

            var reProc = new Procedure(Token.NoToken, recordProcName, new List<TypeVariable>(), inpArgs, new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());

            // Add a procedure to fake initialization of local variables
            var outVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), false);
            var reLocProc = new Procedure(Token.NoToken, initLocProcName, new List<TypeVariable>(),
                new List<Variable>(), new List<Variable>(new Variable[] { outVar }), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
            procsWithoutBody.Add(reLocProc.Name);

            foreach (var impl in p.TopLevelDeclarations.OfType<Implementation>())
            {
                var ncmds = new List<Cmd>();
                foreach (var loc in impl.LocVars.OfType<Variable>().Where(v => v.TypedIdent.Type.IsInt))
                {
                    var cc = new CallCmd(Token.NoToken, initLocProcName, new List<Expr>(), new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(loc) }));
                    cc.Proc = reLocProc;
                    ncmds.Add(cc);
                }
                ncmds.AddRange(impl.Blocks[0].Cmds);
                impl.Blocks[0].Cmds = ncmds;
            }
            p.TopLevelDeclarations.Add(reLocProc);

            // save the current program
            var fd = new FixedDuplicator(true);
            var modInpProg = fd.VisitProgram(p);

             // Instrument to record stuff
             p.TopLevelDeclarations.OfType<Implementation>().Iter(impl =>
                 impl.Blocks.Iter(instrument));

            // Name clash if this assert fails
            Debug.Assert(BoogieUtil.findProcedureDecl(p.TopLevelDeclarations, recordProcName) == null);

            p.TopLevelDeclarations.Add(reProc);
            
            var program = new PersistentCBAProgram(p, p.mainProcName, 0);
            //program.writeToFile("beforeverify.bpl");
            var vp = new VerificationPass(true);
            vp.run(program);

            success = vp.success;
            if (success) return null;

            var trace = mapBackTraceRecord(vp.trace);

            RestrictToTrace.addConcretization = true;
            RestrictToTrace.addConcretizationAsConstants = true;
            var tinfo = new InsertionTrans();
            var rt = new RestrictToTrace(modInpProg, tinfo);
            rt.addTrace(trace);
            RestrictToTrace.addConcretization = false;
            RestrictToTrace.addConcretizationAsConstants = false;

            var rtprog = rt.getProgram();

            // Build a map of where the alloc constants are from
            foreach (var kvp in rt.allocConstantToCall)
            {
                var allocConst = kvp.Key;
                var callId = kvp.Value;
                Debug.Assert(callIdToLocation.ContainsKey(callId));
                allocConstants.Add(allocConst, callIdToLocation[callId]);
            }

            /*
            foreach (var impl in rtprog.TopLevelDeclarations.OfType<Implementation>())
            {
                // strip _trace from the impl name
                var implName = impl.Name;
                var c = implName.LastIndexOf("_trace");
                while (c != -1)
                {
                    implName = implName.Substring(0, c);
                    c = implName.LastIndexOf("_trace");
                }

                var vu = new VarsUsed();
                vu.VisitImplementation(impl);
                vu.varsUsed.Where(s => s.StartsWith("alloc_"))
                    .Iter(s => allocConstants[s] = implName);
            }
            */
            program = new PersistentCBAProgram(rtprog, rt.getFirstNameInstance(p.mainProcName), p.contextBound);

            // Lets inline it all
            var inlp = new InliningPass(1);
            program = inlp.run(program);

            var compress = new CompressBlocks();
            var ret = program.getProgram();
            compress.VisitProgram(ret);

            
            return new CBAProgram(ret, program.mainProcName, 0);
        }


        private void instrument(Block block)
        {
            var newCmds = new List<Cmd>();
            foreach (Cmd cmd in block.Cmds)
            {
                newCmds.Add(cmd);
                if (cmd is HavocCmd && ((cmd as HavocCmd).Vars.Count > 1 || !(cmd as HavocCmd).Vars[0].Decl.TypedIdent.Type.IsInt))
                {
                    Console.WriteLine("{0}", cmd);
                    throw new InvalidInput("Produce Bug Witness: Havoc cmd found");
                }

                if (cmd is HavocCmd)
                {
                    var hcmd = cmd as HavocCmd;
                    var arg = hcmd.Vars[0];
                    newCmds.Add(makeRecordCall(arg));
                    continue;
                }

                if (!(cmd is CallCmd))
                {
                    continue;
                }

                var ccmd = cmd as CallCmd;

                if (ccmd.Outs.Count != 1)
                {
                    continue;
                }

                if (!procsWithoutBody.Contains(ccmd.Proc.Name))
                {
                    continue;
                }

                var retVal = ccmd.Outs[0];

                if (retVal == null) continue;

                if (!retVal.Type.IsInt)
                {
                    continue;
                }

                newCmds.Add(makeRecordCall(retVal));
            }
            block.Cmds = newCmds;
        }

        private CallCmd makeRecordCall(IdentifierExpr v)
        {
            var ins = new List<Expr>();
            ins.Add(v);

            return new CallCmd(Token.NoToken, recordProcName, ins, new List<IdentifierExpr>());
        }


        public ErrorTrace mapBackTraceRecord(ErrorTrace trace)
        {
            var ret = new ErrorTrace(trace.procName);

            foreach (var block in trace.Blocks)
            {
                var nb = new ErrorTraceBlock(block.blockName);
                foreach (var cmd in block.Cmds)
                {
                    if (cmd is CallInstr)
                    {
                        var ccmd = cmd as CallInstr;
                        if (ccmd.callee == recordProcName)
                        {
                            Debug.Assert(nb.Cmds.Count != 0);
                            nb.Cmds.Last().info = ccmd.info;
                            continue;
                        }

                        if (ccmd.hasCalledTrace)
                        {
                            var c = new CallInstr(mapBackTraceRecord(ccmd.calleeTrace), ccmd.asyncCall, ccmd.info);
                            nb.addInstr(c);
                        }
                        else
                        {
                            nb.addInstr(ccmd);
                        }

                    }
                    else
                    {
                        nb.addInstr(cmd.Copy());
                    }

                }
                ret.addBlock(nb);
            }

            if (trace.returns)
            {
                ret.addReturn(trace.raisesException);
            }

            return ret;
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
            ModSetCollector.DoModSetAnalysis(p);
            
            // Eliminate local variables that are never used (i.e., their value is never read)
            varEliminator = new UnReadVarEliminator();
            varEliminator.run(p);

            // Eliminate dead variables -- does not change the program.
            UnusedVarEliminator.Eliminate(p); 
            
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
            ModSetCollector.DoModSetAnalysis(p);

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

        public DeepAssertRewrite()
        {
            origMain = null;
            firstBlockToImpl = new Dictionary<string, string>();
            blockToOrig = new Dictionary<string, Tuple<string, string>>();
            assertContinueBlocks = new HashSet<string>();
            callContinueBlocks = new HashSet<string>();
            exitBlocks = new HashSet<string>();
            callInlinedBlocks = new HashSet<string>();
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Prepare for stratified inlining with assertions
            var procsThatCannotReachAssert = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procsThatCannotReachAssert.Add(proc.Name));
            procsThatCannotReachAssert.ExceptWith(SequentialInstrumentation.procsWithAsserts(program));

            if (procsThatCannotReachAssert.Contains(program.mainProcName))
                return program;

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
                        eb.Cmds.Add(new AssertCmd(acmd.tok, acmd.Expr));
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

            // detect loops
            var l2b = BoogieUtil.labelBlockMapping(mainCopy);
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

            // Add new main back to the program
            program.TopLevelDeclarations.Add(mainCopy);

            // add decl for newmain
            var origMainDecl = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => proc.Name == mainName)
                .FirstOrDefault();
            var newMainDecl = (new Duplicator()).VisitProcedure(origMainDecl);
            newMainDecl.Name = mainCopy.Name;
            mainCopy.Proc = newMainDecl;
            program.TopLevelDeclarations.Add(newMainDecl);

            return program;
        }

        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
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
        public PersistentCBAProgram InstrumentTrace(PersistentCBAProgram ptrace)
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

            program.TopLevelDeclarations.Add(av);
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Proc.Modifies.Add(Expr.Ident(av)));

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
}
