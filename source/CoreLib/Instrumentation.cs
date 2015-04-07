using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
// Contains classes that do program instrumentation

namespace cba
{
    // Instrumentation Config
    public static class InstrumentationConfig
    {
        // Print the instrumented bpl file
        public static bool printInstrumented = false;

        // Name of the instrumented bpl file to print
        public static string instrumentedFile = null;

        // Use old instrumentation where any context switch can raise exception
        public static bool UseOldInstrumentation = false;

        // Instrument RaiseException before all procedures
        public static bool raiseExceptionBeforeAllProcedures = false;

        // For debugging
        public static bool addRaiseException = true;

        // For debugging: 0 (None), 1 (Some), 2 (All)
        public static int addInvariants = 0;

        // Name of the procedure used to fix a context
        public static string corralFixContextName = "corral_fix_context";

        // Name of the procedure used to raiseException
        public static string corralFixRaiseExceptionName = "corral_fix_raise_exception";

        public static string getFixedContextProcName(int i)
        {
            return corralFixContextName + "_" + i.ToString(); 
        }

        public static CallCmd getFixedContextProc(int i)
        {
            var name = getFixedContextProcName(i);
            return new CallCmd(Token.NoToken, name, new List<Expr>(), new List<IdentifierExpr>());
        }

        public static int getFixedContextValue(Cmd c)
        {
            var cc = c as CallCmd;
            if (cc == null) return -1;
            var prefix = corralFixContextName + "_";
            if (cc.Proc.Name.StartsWith(prefix))
            {
                return Int32.Parse(cc.Proc.Name.Substring(prefix.Length));
            }
            else
            {
                return -1;
            }
        }

        public static string getFixedRaiseExceptionProcName()
        {
            return corralFixRaiseExceptionName;
        }

        public static CallCmd getFixedRaiseExceptionProc()
        {
            var name = getFixedRaiseExceptionProcName();
            return new CallCmd(Token.NoToken, name, new List<Expr>(), new List<IdentifierExpr>());
        }

        public static bool isFixedRaiseExceptionProc(Cmd c)
        {
            var cc = c as CallCmd;
            if (cc == null) return false;
            var prefix = corralFixContextName + "_";
            if (cc.Proc.Name == getFixedRaiseExceptionProcName())
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        // Do a deterministic thread id assignment
        public static bool deterministicThreadId = false;

        /**
        * Normally, the sequentialization adds a context switch before every access to shared variables.
        * When /cooperative is given, this behaviour is suppressed.
        * context switches are only added where explictly specified by a dummy call to corral_yield. 
        **/
        public static bool cooperativeYield = false;

    }

    // Splits the set of declarations in the program to ones that
    // need to be instrumented and ones that don't
    public class Splitter 
    {
        // The following is an input to this class
        private InstrumentationPolicy policy;

        // The following are the outputs of this class: the separated list of
        // declarations
        private List<Declaration> globalsList;
        private List<Declaration> procsList;
        private List<Declaration> implList;
        private List<Declaration> noInstrumentation;

        public Splitter(Program prog, InstrumentationPolicy p)
        {
            policy = p;

            globalsList = new List<Declaration>();
            procsList = new List<Declaration>();
            implList = new List<Declaration>();
            noInstrumentation = new List<Declaration>();

            split(prog);
        }

        private void split(Program prog)
        {
            var decls = prog.TopLevelDeclarations;
            foreach (Declaration d in decls)
            {
                if (policy.instrument(d))
                {

                    if (d is GlobalVariable)
                    {
                        globalsList.Add(d);
                    }
                    else if (d is Procedure)
                    {
                        procsList.Add(d);
                    }
                    else if (d is Implementation)
                    {
                        implList.Add(d);
                    }
                    else
                    {
                        throw new InternalError("Cannot instrument a declaration that is not one of" +
                                                "globalvar or procedure or implementation.");
                    }
                } 
                else
                {
                    noInstrumentation.Add(d);
                }
            }
        }

        // All the get methods return a new copy of the declarations
        public List<Declaration> getNoInstrumentDecl()
        {
            return duplicateList(noInstrumentation);
        }
        
        public List<Declaration> getGlobalDecl()
        {
            return duplicateList(globalsList);
        }
        
        public List<Declaration> getProcDecl()
        {
            return duplicateList(procsList);
        }

        public List<Declaration> getImplDecl()
        {
            return duplicateList(implList);
        }

        // Creates a new copy of the declarations
        private static List<Declaration> duplicateList(List<Declaration> inp)
        {
            FixedDuplicator dup = new FixedDuplicator();
            var ret = new List<Declaration>();
            foreach (Declaration d in inp)
            {
                ret.Add(dup.VisitDeclaration(d));
            }
            return ret;
        }

    }

    // This class instruments globals, procedures and implementations
    public class Instrumenter
    {
        // The execution context bound for instrumentation
        private int K;

        // A VariableManager is used to create variable copies
        private VariableManager mgr;

        // The instrumentation policy tells us which globals and procedures to
        // instrument
        private InstrumentationPolicy policy;

        // Some useful program information
        private ProgramInfo pinfo;

        // A command renamer. Given a command cmd, it is used to produce
        // K copies of the command, where the i^th copy manipulates the
        // i^th copy of global variables
        private CmdRenamer cmd_renamer;

        // Used for getting unique labels
        private int label_cnt;

        // To keep track of the code transformations made
        InsertionTrans tinfo;

        // Keep track of blocks that record the value of k. If a block has "assume k == i" then
        // remember this fact here.
        public List<Triple<string, string, int>> blocksWithFixedK { get; private set; }

        // Blocks that correspond to raising raiseException
        public HashSet<string> blocksThatRaiseException { get; private set; }

        // For each inserted context switch, keep track of which instruction caused its insertion
        public Dictionary<int, Triple<string, string, int>> contextSwitchLocation { get; private set; }
        public Dictionary<int, HashSet<string>> contextSwitchLocationGlobalsRead { get; private set; }

        // Counter for getting unique context switch locations
        private int csCounter;

        public Instrumenter(InstrumentationPolicy pol, VariableManager m, ProgramInfo pinf, InsertionTrans t)
        {
            Debug.Assert(pol.executionContextBound >= 1);
            policy = pol;
            pinfo = pinf;
            K = policy.executionContextBound;
            mgr = m;
            tinfo = t;
            blocksWithFixedK = new List<Triple<string, string, int>>();
            blocksThatRaiseException = new HashSet<string>();
            contextSwitchLocation = new Dictionary<int, Triple<string, string, int>>();
            contextSwitchLocationGlobalsRead = new Dictionary<int, HashSet<string>>();
            csCounter = 0;

            cmd_renamer = new CmdRenamer(mgr, policy);

            label_cnt = 0;
        }

        // Input: A list of declarations to instrument
        // Output: The intrumented list of declarations. It instruments
        // globals, procedures and implementations. The instrumentation
        // may be performed in-place, i.e., the input list of declarations 
        // may change.
        public List<Declaration> instrument(List<Declaration> decls)
        {
            var ret = new List<Declaration>();

            if (InstrumentationConfig.UseOldInstrumentation)
            {
                VariableManager.ContextSwitchRaisesException = true;
            }
            else
            {
                VariableManager.ContextSwitchRaisesException = false;
            }

            // Annotation widen points
            // TODO: Locate loops in a better way; or just compile them away into procedures
            var tmpProg = new Program();
            tmpProg.TopLevelDeclarations = decls;
            WidenPoints.Compute(tmpProg);

            foreach (Declaration d in decls)
            {
                if (!policy.instrument(d))
                {
                    ret.Add(d);
                    continue;
                }

                if (d is GlobalVariable)
                {
                    var ls = instrument((GlobalVariable)d);
                    ls.Iterate(x => ret.Add((Declaration)x));
                }
                else if (d is Procedure)
                {
                    ret.Add( (Declaration) instrument((Procedure)d));
                }
                else if (d is Implementation)
                {
                    if (InstrumentationConfig.UseOldInstrumentation)
                    {
                        ret.Add((Declaration)instrumentOld((Implementation)d));
                    }
                    else
                    {
                        ret.Add((Declaration)instrument((Implementation)d));
                    }
                }
                else
                {
                    throw new InternalError("Cannot instrument a declaration other than" +
                                            " global, procedure or implementation");
                }
            }

            return ret;
        }

        public Procedure getContextSwitchProcedure()
        {
            return mgr.getContextSwitchProcedure(this.K);
        }

        // Return the set of variables that the instrumentation pass added because of the
        // given global variable g. (Its the K copies if g is modified, or its g itself)
        public HashSet<string> getInstrumentedVars(string g)
        {
            var ret = new HashSet<string>();
            
            if (!policy.instrumentGlobalVar(g))
            {
                ret.Add(g);
                return ret;
            }

            return mgr.getAllVarCopies(g);
        }

        // Input: A global variable to instrument
        // Output: the list of instrumented global variables: essentially, 
        // copy the variable K times, and (K-1) more copies for the INIT
        // versions of the variable
        public List<GlobalVariable> instrument(GlobalVariable g)
        {
            Debug.Assert(policy.instrument(g));

            List<GlobalVariable> dups = mgr.duplicateGlobalVar(g, DuplicationPolicy.AllCopies(K));
            dups.AddRange(mgr.duplicateGlobalVar(g, DuplicationPolicy.InitCopies(K)));

            return dups;

        }

        // Input: A procedure declaration to instrument.
        // Output: The instrumented procedure declaration.
        //
        // Changes the modified declaration of a procedure: replace each global variable
        // with all its K copies.
        public Procedure instrument(Procedure proc) {
            Debug.Assert(policy.instrument(proc));

            return instrument(proc, DuplicationPolicy.AllCopies(K));
        }

        // Applies the duplication policy to the modifies list
        private Procedure instrument(Procedure proc, DuplicationPolicy dup)
        {
            // Check ensures annotations
            foreach (Ensures en in proc.Ensures)
            {
                if (policy.hasGlobalVarsToInstrument(en.Condition))
                {
                    en.Condition.Emit(new TokenTextWriter(Console.Out));
                    throw new InternalError("Cannot yet instrument ensures annotations that have global variables");
                }
                // convert expr to: !assertsPassed || expr
                en.Condition = Expr.Or(Expr.Not(Expr.Ident(mgr.errorVar)), en.Condition);
            }

            // Check requires annotations
            foreach (Requires re in proc.Requires)
            {
                if (policy.hasGlobalVarsToInstrument(re.Condition))
                {
                    re.Condition.Emit(new TokenTextWriter(Console.Out));
                    throw new InternalError("Cannot yet instrument requires annotations that have global variables");
                }
            }

            // Change the "modifies" list: replace each "to-instrument" global variable
            // with all its K copies
            List<IdentifierExpr> mods = new List<IdentifierExpr>();
            var copies = new Dictionary<string, List<GlobalVariable>>();

            foreach (IdentifierExpr ie in proc.Modifies)
            {
                GlobalVariable gbl = ie.Decl as GlobalVariable;
                
                if (gbl == null)
                {
                    mods.Add(ie);
                    continue;
                }

                if (!policy.instrument(gbl))
                {
                    mods.Add(ie);
                    continue;
                }

                var newg = mgr.duplicateGlobalVar(gbl, dup);
                newg.Iterate(x => mods.Add(new IdentifierExpr(gbl.tok, x)));
                copies.Add(gbl.Name, newg);
            }

            if (policy.procHasImpl(proc.Name))
            {
                mods.Add(new IdentifierExpr(mgr.vark.tok, mgr.vark));
                mods.Add(new IdentifierExpr(mgr.raiseException.tok, mgr.raiseException));
                mods.Add(new IdentifierExpr(mgr.errorVar.tok, mgr.errorVar));
                mods.Add(new IdentifierExpr(mgr.inAtomicBlock.tok, mgr.inAtomicBlock));
                mods.Add(new IdentifierExpr(mgr.tidVar.tok, mgr.tidVar));
                mods.Add(new IdentifierExpr(mgr.tidCountVar.tok, mgr.tidCountVar));

                // Add some default invariants (to help lazy inlining)
                // free ensures k < K
                // free ensures old(k) <= k
                // free ensures assertsPassed ==> old(assertsPassed)
                // free ensures old(tidCount) <= tidCount
                // free ensures old(tid) == tid

                if (InstrumentationConfig.addInvariants != 0)
                {
                    proc.Ensures.Add(new Ensures(true, Expr.Lt(Expr.Ident(mgr.vark), Expr.Literal(K))));
                    proc.Ensures.Add(new Ensures(true, Expr.Le(new OldExpr(Token.NoToken, Expr.Ident(mgr.vark)), Expr.Ident(mgr.vark))));
                    proc.Ensures.Add(new Ensures(true, Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(mgr.tidVar)), Expr.Ident(mgr.tidVar))));

                    if (!pinfo.procContainsAssert(proc.Name))
                    {
                        proc.Ensures.Add(new Ensures(true, Expr.Eq(Expr.Ident(mgr.errorVar), new OldExpr(Token.NoToken, Expr.Ident(mgr.errorVar)))));
                    }
                    else
                    {
                        proc.Ensures.Add(new Ensures(true, Expr.Imp(Expr.Ident(mgr.errorVar), new OldExpr(Token.NoToken, Expr.Ident(mgr.errorVar)))));
                    }

                    if (InstrumentationConfig.addInvariants == 2)
                    {
                        for (int i = 1; i < K; i++)
                        {
                            Expr expr = Expr.True;
                            for (int j = 0; j < i; j++)
                            {
                                foreach (var tp in copies)
                                {
                                    expr = Expr.And(expr, Expr.Eq(Expr.Ident(tp.Value[j]), new OldExpr(Token.NoToken, Expr.Ident(tp.Value[j]))));
                                }
                            }
                            expr = Expr.Imp(Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(mgr.vark)), Expr.Literal(i)), expr);
                            proc.Ensures.Add(new Ensures(true, expr));
                        }
                    }

                    if (!pinfo.procSpawnsThread(proc.Name) && pinfo.threadIdType.IsInt)
                    {
                        proc.Ensures.Add(new Ensures(true, Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(mgr.tidCountVar)), Expr.Ident(mgr.tidCountVar))));
                        if (InstrumentationConfig.addInvariants == 2)
                        {
                            for (int i = 0; i < K - 1; i++)
                            {
                                Expr expr = Expr.True;
                                for (int j = i + 1; j < K; j++)
                                {
                                    foreach (var tp in copies)
                                    {
                                        expr = Expr.And(expr, Expr.Eq(Expr.Ident(tp.Value[j]), new OldExpr(Token.NoToken, Expr.Ident(tp.Value[j]))));
                                    }
                                }
                                expr = Expr.Imp(Expr.Eq(Expr.Ident(mgr.vark), Expr.Literal(i)), expr);
                                proc.Ensures.Add(new Ensures(true, expr));
                            }
                        }
                    }
                    else if(pinfo.threadIdType.IsInt)
                    {
                        proc.Ensures.Add(new Ensures(true, Expr.Le(new OldExpr(Token.NoToken, Expr.Ident(mgr.tidCountVar)), Expr.Ident(mgr.tidCountVar))));
                    }

                }
            }

            proc.Modifies = mods;

            return proc;
        }

        // Input: A procedure implememtation to instrument.
        // Output: The instrumented implementation.
        //
        // Each command is replaced by its K copies, strung together with appropriate
        // control flow.
        //
        // Note: We're slightly unsound (I think) when we're in storm mode. Some insertions of
        // context switches is avoided in this mode. These include: (a) at the beginning of an
        // implementation; (b) right after a procedure call. Part (a) should be sound because 
        // we rewrite call commands to make sure that they do not access global variables. For
        // part (b), I'm not sure
        public Implementation instrumentOld(Implementation impl)
        {
            Debug.Assert(policy.instrument(impl));

            List<Block> instrumented = new List<Block>();

            // Fixed context value, if needed
            int fixedContext = 0;

            // These two represent the current Block being constructed
            List<Cmd> curr;
            string curr_label;

            // Gotta start things off by inserting a contextSwitch 
            // before the first statement
            bool first_block = true;

            foreach (Block block in impl.Blocks)
            {
                curr = new List<Cmd>();
                curr_label = block.Label;

                // This block will result in a block with the same name
                // in the target program (and maybe also produce more blocks)
                tinfo.addTrans(impl.Name, block.Label, block.Label);

                // Gotta start things off by inserting a contextSwitch 
                // before the first statement. These contextSwitches seem
                // to be really costly. THus, in storm mode, we only place
                // these contextSwitches for procedures that are ever called
                // asynchronously. This allows such procedures to not use
                // their first execution context, allowing other threads to
                // use it first.
                if (first_block && policy.isProcAsync(impl.Name))
                {
                    if (policy.isProcAsync(impl.Name))
                    {
                        curr.Add(ContextSwitchCmd());
                    }
                    else
                    {
                        curr.Add(ContextSwitchCmd()); //impl.Name, curr_label, 0));
                    }
                    curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                    curr = new List<Cmd>();
                }
                first_block = false;

                // The instruction in the current block that we're looking at
                int incnt = -1;

                foreach (Cmd cmd in block.Cmds)
                {
                    incnt++;

                    // If this is a fixed context instruction, then record the value
                    if (policy.isFixedContextProc(cmd, ref fixedContext))
                    {
                        curr.Add(new AssumeCmd(Token.NoToken, Expr.True));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // If this is a raiseException instruction, then raise it
                    if (policy.isFixedRaiseExceptionProc(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.raiseException, true));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // Replace call atomic_begin() with inAtomicBlock := true
                    if (policy.isAtomicBegin(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.inAtomicBlock, true));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // Replace call atomic_end() with inAtomicBlock := false; contextswitch()
                    if (policy.isAtomicEnd(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.inAtomicBlock, false));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        curr.Add(ContextSwitchCmd(impl, block.Label, incnt, cmd));
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();

                        continue;
                    }

                    // Replace call corral_yield() with assume !inAtomicBlock; contextswitch()
                    if (policy.isYield(cmd))
                    {
                        curr.Add(new AssumeCmd(Token.NoToken, Expr.Eq(Expr.Ident(mgr.inAtomicBlock), Expr.False)));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        curr.Add(ContextSwitchCmd());
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();

                        continue;
                    }

                    // Replace call assert_dummy() with assertsPassed := false; raiseException := !inAtomicBlock;
                    if (policy.isAssertCmd(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.errorVar, false));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        curr.Add(BoogieAstFactory.MkVarEqExpr(mgr.raiseException, Expr.Not(Expr.Ident(mgr.inAtomicBlock))));

                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();

                        continue;
                    }

                    // Replace "y := getThreadID() with y := tid
                    if (policy.isGetThreadID(cmd))
                    {
                        CallCmd ccmd = cmd as CallCmd;
                        if (ccmd.Outs.Count == 0)
                        {
                            // return value not needed; ignore this command
                            continue;
                        }
                        if (ccmd.Outs.Count != 1)
                        {
                            throw new InvalidInput("getThreadID returns multiple values");
                        }
                        if (ccmd.Outs[0] == null)
                        {
                            // return value not needed
                            continue;
                        }
                        curr.Add(BoogieAstFactory.MkVarEqVar(ccmd.Outs[0].Decl, mgr.tidVar));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // starting_cmd.Add(BoogieAstFactory.MkMapConstant(mgr.finishedVar, false));
                    // starting_cmd.Add(BoogieAstFactory.MkMapConstant(mgr.numRoundsVar, 0));

                    if (policy.hasOldGlobalVarsToInstrument(cmd))
                    {
                        cmd.Emit(new TokenTextWriter(Console.Out), 0);
                        throw new InternalError("Cannot yet handle \"old\" variables");
                    }

                    // if cmd does not refer to a "to-instrument" global variable, then don't
                    // bother duplicating it. Furthermore, insert context switch only if its a
                    // procedure call.
                    bool isCall = false;
                    bool isAsyncCall = false;
                    // If cmd is a procedure call, is it a call to a procedure with
                    // an implementation?
                    bool hasBody = true;
                    if (cmd is CallCmd)
                    {
                        isCall = true;
                        isAsyncCall = (cmd as CallCmd).IsAsync;
                        hasBody = policy.procHasImpl((cmd as CallCmd).Proc.Name);
                    }

                    bool hasGlobals = policy.hasGlobalVarsToInstrument(cmd);

                    if (!hasGlobals)
                    {
                        // Instrument asserts
                        if (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd))
                        {
                            curr.Add(BoogieAstFactory.instrumentAssert(mgr.errorVar, cmd as AssertCmd));
                            addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                            curr.Add(ContextSwitchCmd(/*impl.Name, block.Label, incnt*/));
                            curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                            curr = new List<Cmd>();
                        }
                        else
                        {
                            curr.Add(cmd);
                            addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        }
                    }
                    else
                    {
                        // cmd reads/writes to a global variable. Duplicate it K times.
                        
                        curr_label = addBasicInstrumentation(impl.Name, block.Label, incnt, cmd, instrumented, curr, curr_label, fixedContext);
                        curr = new List<Cmd>();
                    }

                    if (isCall && hasBody && !isAsyncCall)
                    {
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();
                    }

                    // Add a context switch if:
                    // -- cmd had global variables; or
                    // -- cmd is an async call to a procedure with a body
                    // -- cmd is a call to a procedure with an implementation and we're not in storm mode.
                    if ((isAsyncCall && hasBody) || hasGlobals)
                    {
                        if (isAsyncCall)
                        {
                            curr.Add(ContextSwitchCmd());
                        }
                        else
                        {
                            curr.Add(ContextSwitchCmd(impl, block.Label, incnt, cmd));
                        }

                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();
                    }
                    
                }
                instrumented.Add(new Block(Token.NoToken, curr_label, curr, block.TransferCmd));

            }

            impl.Blocks = instrumented;

            return impl;
        }

        // return true if expr is "true"
        private bool exprIsTrue(Expr expr)
        {
            if (expr is LiteralExpr && (expr as LiteralExpr).IsTrue) return true;
            
            // check if "! false"
            var nary = expr as NAryExpr;
            if (nary == null) return false;
            var uop = nary.Fun as UnaryOperator;
            if (uop == null) return false;
            if (uop.Op != UnaryOperator.Opcode.Not) return false;

            var nexpr = nary.Args[0];
            if (nexpr is LiteralExpr && (nexpr as LiteralExpr).IsFalse) return true;
            return false;
        }

        private void annotateBlockingAssumes(Implementation impl)
        {
            // Annotate all assumes (that are not assume true) by default
            foreach (var blk in impl.Blocks)
            {
                foreach (Cmd cmd in blk.Cmds)
                {
                    var acmd = cmd as AssumeCmd;
                    if (acmd == null) continue;
                    if (exprIsTrue(acmd.Expr)) continue;

                    var p = new List<object>();
                    acmd.Attributes = new QKeyValue(Token.NoToken, "do_re", p, acmd.Attributes);
                }
            }

            // Build a predecessor map
            var preds = new Dictionary<string, HashSet<string>>();
            foreach (var blk in impl.Blocks)
            {
                var src = blk.Label;
                var gc = blk.TransferCmd as GotoCmd;
                if (gc == null) continue;
                foreach (string tgt in gc.labelNames)
                {
                    if (!preds.ContainsKey(tgt)) preds.Add(tgt, new HashSet<string>());
                    preds[tgt].Add(src);
                }
            }

            // Find the pattern for "deterministic" branching
            //  goto lab1, lab2;
            // lab1: assume e;
            // lab2: assume not e;
            // and there are no other edges to lab1 and lab2

            var nameBlockMap = BoogieUtil.labelBlockMapping(impl);

            foreach (var blk in impl.Blocks)
            {
                if (blk.Cmds.Count == 0) continue;
                

                var acmd = blk.Cmds[0] as AssumeCmd;
                if (acmd == null) continue;

                if (!QKeyValue.FindBoolAttribute(acmd.Attributes, "do_re")) continue;

                if (!preds.ContainsKey(blk.Label)) continue;
                if(preds[blk.Label].Count != 1) continue;

                var unique_pred = nameBlockMap[preds[blk.Label].First()];
                var gc = unique_pred.TransferCmd as GotoCmd;
                Debug.Assert(gc != null);

                if (gc.labelNames.Count != 2) continue;

                var lab2 = gc.labelNames[0];
                if (lab2 == blk.Label) lab2 = gc.labelNames[1];
                Debug.Assert(lab2 != blk.Label);

                var block2 = nameBlockMap[lab2];
                if (block2.Cmds.Count == 0) continue;
                var acmd2 = block2.Cmds[0] as AssumeCmd;
                if (acmd2 == null) continue;

                if (!checkNegation(acmd.Expr, acmd2.Expr)) continue;

                // Remove attribute
                Debug.Assert(QKeyValue.FindBoolAttribute(acmd2.Attributes, "do_re"));
                Debug.Assert(acmd2.Attributes.Key == "do_re");
                Debug.Assert(acmd.Attributes.Key == "do_re");

                acmd2.Attributes = acmd2.Attributes.Next;
                acmd.Attributes = acmd.Attributes.Next;
            }

            // Remove annotations on assumes that are the first in a widening block
            foreach (var blk in impl.Blocks)
            {
                if (!blk.widenBlock) continue;
                if (blk.Cmds.Count == 0) continue;
                var acmd = blk.Cmds[0] as AssumeCmd;
                if (acmd == null || !QKeyValue.FindBoolAttribute(acmd.Attributes, "do_re")) continue;
                Debug.Assert(acmd.Attributes.Key == "do_re");
                acmd.Attributes = acmd.Attributes.Next;
            }
        }

        // Check if the expressions are negations of each other
        private bool checkNegation(Expr expr1, Expr expr2)
        {
            var e1 = expr1 as NAryExpr;
            var e2 = expr2 as NAryExpr;
            if (e1 == null || e2 == null) return false;
            
            var uop1 = e1.Fun as UnaryOperator;
            if (uop1 != null && uop1.Op == UnaryOperator.Opcode.Not)
            {
                if (checkIfSame(e1.Args[0], e2)) return true;
            }

            var uop2 = e2.Fun as UnaryOperator;
            if (uop2 != null && uop2.Op == UnaryOperator.Opcode.Not)
            {
                if (checkIfSame(e2.Args[0], e1)) return true;
            }

            var bop1 = e1.Fun as BinaryOperator;
            var bop2 = e2.Fun as BinaryOperator;
            if (bop1 == null || bop2 == null) return false;
            if (!checkIfSame(e1.Args[0], e2.Args[0]) || !checkIfSame(e1.Args[1], e2.Args[1])) return false;

            if (checkIfNegatedOp(bop1.Op, bop2.Op)) return true;
            if (checkIfNegatedOp(bop2.Op, bop1.Op)) return true;
            return false;
        }

        // Check if the expressions are same
        private bool checkIfSame(Expr expr1, Expr expr2)
        {
            return (expr1.ToString() == expr2.ToString());
        }

        // Check if the op codes are negated
        private bool checkIfNegatedOp(BinaryOperator.Opcode op1, BinaryOperator.Opcode op2)
        {
            if (op1 == BinaryOperator.Opcode.Eq && op2 == BinaryOperator.Opcode.Neq) return true;
            if (op1 == BinaryOperator.Opcode.Le && op2 == BinaryOperator.Opcode.Gt) return true;
            if (op1 == BinaryOperator.Opcode.Ge && op2 == BinaryOperator.Opcode.Lt) return true;
            return false;
        }

        public Implementation instrument(Implementation impl)
        {
            Debug.Assert(policy.instrument(impl));

            List<Block> instrumented = new List<Block>();

            // Fixed context value, if needed
            int fixedContext = 0;

            // annotate blocking assumes
            annotateBlockingAssumes(impl);

            // These two represent the current Block being constructed
            List<Cmd> curr;
            string curr_label;

            foreach (Block block in impl.Blocks)
            {
                curr = new List<Cmd>();
                curr_label = block.Label;

                // This block will result in a block with the same name
                // in the target program (and maybe also produce more blocks)
                tinfo.addTrans(impl.Name, block.Label, block.Label);

                // The instruction in the current block that we're looking at
                int incnt = -1;

                // If this is a widening block, add raiseException
                if (block.widenBlock && !InstrumentationConfig.cooperativeYield)
                {
                    curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                    curr = new List<Cmd>();
                }

                foreach (Cmd cmd in block.Cmds)
                {
                    incnt++;

                    // If this is a fixed context instruction, then record the value
                    if (policy.isFixedContextProc(cmd, ref fixedContext))
                    {
                        curr.Add(new AssumeCmd(Token.NoToken, Expr.True));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // If this is a raiseException instruction, then raise it
                    if (policy.isFixedRaiseExceptionProc(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.raiseException, true));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    // Replace call atomic_begin() with contextswitch(); raiseException; inAtomicBlock := true; 
                    if (policy.isAtomicBegin(cmd))
                    {
                        if (!InstrumentationConfig.cooperativeYield)
                        {
                            curr.Add(ContextSwitchCmd());
                            curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                            curr = new List<Cmd>();
                        }

                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.inAtomicBlock, true));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        continue;
                    }

                    // Replace call atomic_end() with inAtomicBlock := false
                    if (policy.isAtomicEnd(cmd))
                    {
                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.inAtomicBlock, false));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        continue;
                    }

                    // Replace call corral_yield() with contextswitch()
                    if (policy.isYield(cmd))
                    {
                        //curr.Add(new AssumeCmd(Token.NoToken, Expr.Eq(Expr.Ident(mgr.inAtomicBlock), Expr.False)));
                        curr.Add(ContextSwitchCmd());
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                        curr = new List<Cmd>();

                        continue;
                    }

                    // Replace call assert_dummy() with assertsPassed := false; raiseException := !inAtomicBlock;
                    if (policy.isAssertCmd(cmd))
                    {
                        // raise exception before the assert
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                        curr = new List<Cmd>();

                        curr.Add(BoogieAstFactory.MkVarEqConst(mgr.errorVar, false));
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                        curr.Add(BoogieAstFactory.MkVarEqExpr(mgr.raiseException, Expr.Not(Expr.Ident(mgr.inAtomicBlock))));
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();

                        continue;
                    }

                    // Replace "y := getThreadID() with y := tid
                    if (policy.isGetThreadID(cmd))
                    {
                        CallCmd ccmd = cmd as CallCmd;
                        if (ccmd.Outs.Count == 0)
                        {
                            // return value not needed; ignore this command
                            continue;
                        }
                        if (ccmd.Outs.Count != 1)
                        {
                            throw new InvalidInput("getThreadID returns multiple values");
                        }
                        if (ccmd.Outs[0] == null)
                        {
                            // return value not needed
                            curr.Add(new AssumeCmd(Token.NoToken, Expr.True));
                        }
                        else
                        {
                            curr.Add(BoogieAstFactory.MkVarEqVar(ccmd.Outs[0].Decl, mgr.tidVar));
                        }
                        addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        continue;
                    }

                    if (policy.hasOldGlobalVarsToInstrument(cmd))
                    {
                        cmd.Emit(new TokenTextWriter(Console.Out), 0);
                        throw new InternalError("Cannot yet handle \"old\" variables");
                    }

                    // raise exception before blocking assumes
                    var assumecmd = cmd as AssumeCmd;
                    if (assumecmd != null && QKeyValue.FindBoolAttribute(assumecmd.Attributes, "do_re") && !InstrumentationConfig.cooperativeYield)
                    {
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                        curr = new List<Cmd>();
                    }

                    // if cmd does not refer to a "to-instrument" global variable, then don't
                    // bother duplicating it. Furthermore, insert context switch only if its a
                    // procedure call.
                    bool isCall = false;
                    bool isAsyncCall = false;
                    // If cmd is a procedure call, is it a call to a procedure with
                    // an implementation?
                    bool hasBody = true;
                    if (cmd is CallCmd)
                    {
                        isCall = true;
                        isAsyncCall = (cmd as CallCmd).IsAsync;
                        hasBody = policy.procHasImpl((cmd as CallCmd).Proc.Name);
                    }

                    // raise exception before a recursive procedure call
                    if (isCall && hasBody && !InstrumentationConfig.cooperativeYield && 
                        (policy.isRecCall(impl.Name, (cmd as CallCmd).callee) || InstrumentationConfig.raiseExceptionBeforeAllProcedures))
                    {
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                        curr = new List<Cmd>();
                    }

                    bool hasGlobals = policy.hasGlobalVarsToInstrument(cmd);

                    if (!hasGlobals)
                    {
                        // Instrument asserts
                        if (cmd is AssertCmd)
                        {
                            curr.Add(BoogieAstFactory.instrumentAssert(mgr.errorVar, cmd as AssertCmd));
                            addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);

                            if (!InstrumentationConfig.cooperativeYield)
                            {
                                curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label, true);
                                curr = new List<Cmd>();
                            }
                            else
                            {
                                // raiseException := (!mgr.errorVar && !inAotmicBlock)
                                curr.Add(BoogieAstFactory.MkVarEqExpr(mgr.raiseException, Expr.And(Expr.Not(Expr.Ident(mgr.errorVar)), Expr.Not(Expr.Ident(mgr.inAtomicBlock)))));
                                curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                                curr = new List<Cmd>();
                            }
                        }
                        else
                        {
                            curr.Add(cmd);
                            addedTrans(impl.Name, block.Label, incnt, cmd, curr_label, curr);
                        }
                    }
                    else
                    {
                        if (!InstrumentationConfig.cooperativeYield)
                            curr.Add(ContextSwitchCmd());

                        // cmd reads/writes to a global variable. Duplicate it K times.
                        curr_label = addBasicInstrumentation(impl.Name, block.Label, incnt, cmd, instrumented, curr, curr_label, fixedContext);
                        curr = new List<Cmd>();
                    }

                    if (isCall && hasBody && !isAsyncCall)
                    {
                        curr_label = addRaiseExceptionInstrumentation(instrumented, curr, curr_label);
                        curr = new List<Cmd>();
                    }

                }
                instrumented.Add(new Block(Token.NoToken, curr_label, curr, block.TransferCmd));

            }

            impl.Blocks = instrumented;

            return impl;
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last());
            tinfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }

        // Duplicates the cmd K times.
        //
        // goto label0, label1, ..., label{K-1};
        //
        // label0:
        //   assume k == 0
        //   cmd(gbl__0/gbl)
        //   goto lab;
        //
        // label1:
        //   assume k == 1
        //   cmd(gbl__1/gbl)
        //   goto lab;
        //
        //  ...
        //
        // lab:
        //
        // Inputs: the cmd to duplicate (and its location in the program procName::blockName::currCount),
        // the list of blocks being constructed; the current block being constructed.
        // End current block and adds two new blocks.
        // Returns "lab".

        private string addBasicInstrumentation(
            string procName, string blockName, int currCount, Cmd cmd,
            List<Block> instrumented, List<Cmd> curr, string curr_label,
            int fixedContext)
        {
            if (cmd is AssumeCmd && policy.mode != ConcurrencyMode.FixedContext)
            {
                // Calling this avoids splitting control flow, but then it makes reconstructing the error trace harder
                // (because we don't know the value of k that the assume statement used)
                //
                // TODO: Do this for other commands as well (like AssignCmd that only read globals, but don't write to one)
                // This is low priority because drivers don't seem to have very many of these statements (everything is a
                // map update)
                return addBasicInstrumentationAssume(procName, blockName, currCount, cmd as AssumeCmd,
                    instrumented, curr, curr_label, fixedContext);
            }

            if (policy.mode == ConcurrencyMode.FixedContext)
            {
                return addBasicInstrumentationFixedContext(procName, blockName, currCount, cmd,
                    instrumented, curr, curr_label, fixedContext);
            }

            FixedDuplicator dup = new FixedDuplicator(true);

            // Make K copies of this cmd.
            // Make up K new labels
            List<Cmd> copies = new List<Cmd>();
            List<String> labels = new List<String>();

            for (int i = 0; i < K; i++)
            {
                labels.Add(getNewLabel());

                Cmd cmd_copy = (Cmd)dup.Visit(cmd);

                cmd_renamer.K = i;

                Cmd conv = (Cmd)cmd_renamer.Visit(cmd_copy);

                // Instrument further if the command is an assert
                // (We need to record the value of the assert)
                AssertCmd acmd = conv as AssertCmd;
                if (acmd != null)
                {
                    conv = BoogieAstFactory.instrumentAssert(mgr.errorVar, acmd);

                }

                copies.Add(conv);

                // The i^th block starts with label labels[i] and its first cmd is
                // assume (k == i)
                blocksWithFixedK.Add(new Triple<string, string, int>(procName, labels[i], i));
            }

            // Finish the current block with a K-way goto
            GotoCmd tc = new GotoCmd(Token.NoToken, labels);
            Block blk = new Block(Token.NoToken, curr_label, curr, tc);

            instrumented.Add(blk);

            // Add K new blocks that all come back to the same location
            string common_label = getNewLabel();
            for (int i = 0; i < K; i++)
            {
                // assume(k == i)
                AssumeCmd acmd = BoogieAstFactory.MkAssumeVarEqConst(mgr.vark, i);

                List<Cmd> cs = new List<Cmd>();
                cs.Add(acmd);
                cs.Add(copies[i]);
                addedTrans(procName, blockName, currCount, cmd, labels[i], cs);

                instrumented.Add(new Block(Token.NoToken, labels[i], cs, BoogieAstFactory.MkGotoCmd(common_label)));
            }

            return common_label;

        }

        private string addBasicInstrumentationFixedContext(
            string procName, string blockName, int currCount, Cmd cmd,
            List<Block> instrumented, List<Cmd> curr, string curr_label,
            int fixedContext)
        {
            FixedDuplicator dup = new FixedDuplicator(true);

            // Make 1 copy of this cmd.
            // Make up 1 new label
            var label = getNewLabel();
            Cmd cmd_copy = (Cmd)dup.Visit(cmd);
            cmd_renamer.K = fixedContext;
            Cmd copy = (Cmd)cmd_renamer.Visit(cmd_copy);

            // Instrument further if the command is an assert
            // (We need to record the value of the assert)
            AssertCmd assertcmd = copy as AssertCmd;
            if (assertcmd != null)
            {
                copy = BoogieAstFactory.instrumentAssert(mgr.errorVar, assertcmd);
            }

            // The i^th block starts with label labels[i] and its first cmd is
            // assume (k == i)
            blocksWithFixedK.Add(new Triple<string, string, int>(procName, label, fixedContext));

            // Finish the current block 
            Block blk = new Block(Token.NoToken, curr_label, curr, BoogieAstFactory.MkGotoCmd(label));

            instrumented.Add(blk);

            // Add a new block
            string common_label = getNewLabel();

            // assume(k == i)
            AssumeCmd acmd = BoogieAstFactory.MkAssumeVarEqConst(mgr.vark, fixedContext);

            List<Cmd> cs = new List<Cmd>();
            cs.Add(acmd);
            cs.Add(copy);
            addedTrans(procName, blockName, currCount, cmd, label, cs);

            instrumented.Add(new Block(Token.NoToken, label, cs, BoogieAstFactory.MkGotoCmd(common_label)));

            return common_label;
        }

        // CBA instrumentation for "assume c":
        //
        // assume k == 0 => c_0;
        // assume k == 1 => c_1;
        // ...
        // assume k == K-1 => c_{K-1};
        // goto lab;
        //
        // lab:

        private string addBasicInstrumentationAssume(
            string procName, string blockName, int currCount, AssumeCmd cmd,
            List<Block> instrumented, List<Cmd> curr, string curr_label,
            int fixedContext)
        {
            FixedDuplicator dup = new FixedDuplicator(true);

            // Make K copies
            for (int i = 0; i < K; i++)
            {
                if (policy.mode == ConcurrencyMode.FixedContext && i != fixedContext)
                    continue;

                Cmd cmd_copy = (Cmd)dup.Visit(cmd);
                cmd_renamer.K = i;
                var conv = (AssumeCmd)cmd_renamer.Visit(cmd_copy);

                // Instrument the condition further
                conv = BoogieAstFactory.instrumentAssume(conv, mgr.vark, i);
                curr.Add(conv);

                // Have to do a little hack here. We only say that the cmd with k==0
                // corresponds to the original cmd (for mapBackTrace)
                if (i == 0)
                {
                    addedTrans(procName, blockName, currCount, cmd, curr_label, curr);
                }
            }

            var newlab = getNewLabel();
            instrumented.Add(new Block(Token.NoToken, curr_label, curr, BoogieAstFactory.MkGotoCmd(newlab)));

            return newlab;
        }

        // Does instrumentation for raiseException:
        //
        // (if havocFlag) havoc raiseException;
        // goto label1, label2;
        //
        // label1:
        //   assume raiseException == true (&& !inAtomicBlock)
        //   return;
        //
        // label2:
        //   assume raiseException == false
        //   goto lab;
        //
        // lab:
        //
        // Inputs: the list of blocks being constructed; the current block being constructed.
        // End current block and adds two new blocks.
        // Returns "lab".
        private string addRaiseExceptionInstrumentation(List<Block> instrumented, List<Cmd> curr, string curr_label)
        {
            return addRaiseExceptionInstrumentation(instrumented, curr, curr_label, false);
        }

        private string addRaiseExceptionInstrumentation(List<Block> instrumented, List<Cmd> curr, string curr_label, bool havocFlag)
        {
            if (!InstrumentationConfig.addRaiseException)
            {
                // End current block, goto new block
                string newb = getNewLabel();
                instrumented.Add(new Block(Token.NoToken, curr_label, curr, BoogieAstFactory.MkGotoCmd(newb)));
                return newb;
            }

            if (havocFlag)
            {
                curr.Add(BoogieAstFactory.MkHavocVar(mgr.raiseException));
            }

            string lbl1 = getNewLabel();
            string lbl2 = getNewLabel();

            List<String> ssp = new List<String>();
            ssp.Add(lbl1);
            ssp.Add(lbl2);
            instrumented.Add(new Block(Token.NoToken, curr_label, curr, new GotoCmd(Token.NoToken, ssp)));

            string common_label = getNewLabel();
            // assume(raiseException == true)
            AssumeCmd acmd_re_true = BoogieAstFactory.MkAssumeVarEqConst(mgr.raiseException, true);

            // && !inAtomicBlock
            if (havocFlag)
            {
                acmd_re_true.Expr = Expr.And(acmd_re_true.Expr, Expr.Not(Expr.Ident(mgr.inAtomicBlock)));
            }

            // assume(raiseException == false)
            AssumeCmd acmd_re_false = BoogieAstFactory.MkAssumeVarEqConst(mgr.raiseException, false);

            curr = new List<Cmd>();
            curr.Add(acmd_re_true);
            instrumented.Add(new Block(Token.NoToken, lbl1, curr, new ReturnCmd(Token.NoToken)));
            blocksThatRaiseException.Add(lbl1);

            curr = new List<Cmd>();
            curr.Add(acmd_re_false);
            instrumented.Add(new Block(Token.NoToken, lbl2, curr, BoogieAstFactory.MkGotoCmd(common_label)));

            return common_label;
        }


        // Instrument the given main procedure implementation.
        // Do only that instrumentation that is specific to main; the
        // other instrumentation is done by instrument()
        //
        // 1. Initialize variables (k, errorVar, etc.)
        // 2. Add the assume statements (including the Checker)
        // 3. Add assert(no error)
        public void instrumentGivenMainImpl(Implementation mainImpl)
        {
            var blocks = mainImpl.Blocks;

            // Initialize the new variables by adding at the beginning of the procedure:
            // k := 0
            // errorVar := true
            // raiseException := false
            // inAtomic := false
            // assume tidCount >= 1
            // tid := tidCount
            // (leave finished and numRounds uninitialized, by design)
            // assume Mem__1 == Mem_s_1 ...

            var starting_cmd = new List<Cmd>();

            starting_cmd.Add(BoogieAstFactory.MkVarEqConst(mgr.vark, 0));
            starting_cmd.Add(BoogieAstFactory.MkVarEqConst(mgr.errorVar, true));
            starting_cmd.Add(BoogieAstFactory.MkVarEqConst(mgr.raiseException, false));
            starting_cmd.Add(BoogieAstFactory.MkVarEqConst(mgr.inAtomicBlock, false));
            if (InstrumentationConfig.deterministicThreadId)
            {
                starting_cmd.Add(BoogieAstFactory.MkVarEqExpr(mgr.tidCountVar, TidArithmetic.getLiteral(1)));
            }
            starting_cmd.Add(new AssumeCmd(Token.NoToken, TidArithmetic.assumeGt(mgr.tidCountVar, 0)));
            starting_cmd.Add(BoogieAstFactory.MkVarEqVar(mgr.tidVar, mgr.tidCountVar));

            starting_cmd.AddRange(mgr.constructInitAssumes(K, policy));

            var commandsAdded = starting_cmd.Count;
            starting_cmd.AddRange(blocks[0].Cmds);

            blocks[0] = new Block(blocks[0].tok, blocks[0].Label, starting_cmd, blocks[0].TransferCmd);
            tinfo.addedInstrToBeg(mainImpl.Name, blocks[0].Label, commandsAdded);

            if (!blocks[0].Label.StartsWith("cba_label_"))
            {
                // The above check is performed because the "tinfo" being maintained by this
                // function is a continuation of the one by the "instrument" procedure, which
                // already has added more basic blocks to the program.
                tinfo.addTrans(mainImpl.Name, blocks[0].Label, blocks[0].Label);
            }

            // Iterate through the commands and do the following
            // -- Replace "return" by goto newlab;
            //    newlab:
            //     (assume Mem__0 == Mem_s_1 ...; assert(errorVar); return)
            // (This code transformation doesn't need to be recorded in "tinfo")
            var newlab = getNewLabel();
            var nblocks = new List<Block>();

            foreach (Block block in blocks)
            {
                // Convert return to: goto newlab

                if (block.TransferCmd is ReturnCmd)
                {
                    nblocks.Add(new Block(block.tok, block.Label, block.Cmds, BoogieAstFactory.MkGotoCmd(newlab)));
                }
                else
                {
                    nblocks.Add(new Block(block.tok, block.Label, block.Cmds, block.TransferCmd));
                }
                if (!block.Label.StartsWith("cba_label_"))
                {
                    tinfo.addTrans(mainImpl.Name, block.Label, block.Label);
                }

            }

            // assume Mem__0 == Mem_s_1 ...
            // assert(errorVar)
            // return

            List<Cmd> curr = new List<Cmd>();
            curr.AddRange(mgr.constructChecker(K, policy));

            // assert(errorVar)
            curr.Add(BoogieAstFactory.MkAssert(Expr.Ident(mgr.errorVar)));

            nblocks.Add(new Block(Token.NoToken, newlab, curr, new ReturnCmd(Token.NoToken)));

            mainImpl.Blocks = nblocks;
        }

        /////////////////////////////
        // private stuff
        /////////////////////////////

        private string getNewLabel()
        {
            string ret = "cba_label_" + (label_cnt.ToString());
            label_cnt++;
            return ret;
        }

        private CallCmd ContextSwitchCmd(Implementation impl, string blockName, int instr, Cmd cmd)
        {
            var procName = impl.Name;

            var ret = ContextSwitchCmd();
            // {:cs_location int}
            var param = new List<object>();
            param.Add(new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(getNewCSLocation())));
            var attr = new QKeyValue(Token.NoToken, "cs_location", param, null);

            ret.Attributes = attr;

            // store location
            contextSwitchLocation.Add(csCounter, new Triple<string, string, int>(procName, blockName, instr));
            // vars used

            if (BoogieUtil.checkIsCall(LanguageSemantics.atomicEndProcName(), cmd))
            {
                contextSwitchLocationGlobalsRead.Add(csCounter, VarsInAtomicBlock.VarsAccessed(impl, blockName, instr));
            }
            else
            {
                var gused = new GlobalVarsUsed();
                gused.Visit(cmd);
                contextSwitchLocationGlobalsRead.Add(csCounter, new HashSet<string>(gused.globalsUsed.AsEnumerable()));
            }
            
            return ret;
        }

        private CallCmd ContextSwitchCmd()
        {
            return
                new CallCmd(Token.NoToken, mgr.getContextSwitchProcedure(K).Name, new List<Expr>(), new List<IdentifierExpr>());
        }

        private int getNewCSLocation()
        {
            return ++csCounter;
        }

    }

    // For atomicity
    public class VarsInAtomicBlock
    {
        public static HashSet<string> VarsAccessed(Implementation impl, string blockName, int cnt)
        {
            var blockMap = BoogieUtil.labelBlockMapping(impl);
            var block = blockMap[blockName];

            // build an inverted block map for the implementation
            var preds = new Dictionary<string, HashSet<string>>();
            blockMap.Keys.Iter(st => preds.Add(st, new HashSet<string>()));

            foreach (var blk in impl.Blocks)
            {
                var gc = blk.TransferCmd as GotoCmd;
                if (gc == null) continue;
                foreach (string tgt in gc.labelNames) preds[tgt].Add(blk.Label);
            }

            var ret = new HashSet<string>();
            for (int i = cnt; i >= 0; i--)
            {
                if (BoogieUtil.checkIsCall(LanguageSemantics.atomicBeginProcName(), block.Cmds[i] as Cmd))
                {
                    return getVars(block, i, cnt);
                }
            }

            ret.UnionWith(getVarsBefore(block, cnt));

            // Do a dfs from the atomic_end command until an atomic_begin command
            var stack = new Stack<string>();
            var visited = new HashSet<string>();

            stack.Push(block.Label);

            while (stack.Any())
            {
                var b = blockMap[stack.Pop()];
                visited.Add(b.Label);

                foreach (var c in preds[b.Label])
                {
                    if (visited.Contains(c)) continue;
                    var pos = findAtomicBegin(blockMap[c]);
                    if (pos == -1)
                    {
                        ret.UnionWith(getVars(blockMap[c], 0, blockMap[c].Cmds.Count));
                        stack.Push(c);
                    }
                    else
                    {
                        ret.UnionWith(getVarsAfter(blockMap[c], pos));
                    }
                }
            }
            return ret;
        }

        private static int findAtomicBegin(Block block)
        {
            int ret = -1;
            for (int i = block.Cmds.Count - 1; i >= 0; i--)
            {
                if (BoogieUtil.checkIsCall(LanguageSemantics.atomicBeginProcName(), block.Cmds[i] as Cmd))
                {
                    return i;
                }
            }
            return ret;
        }

        private static HashSet<string> getVarsBefore(Block block, int cnt)
        {
            return getVars(block, 0, cnt);
        }

        private static HashSet<string> getVarsAfter(Block block, int cnt)
        {
            return getVars(block, cnt, block.Cmds.Count);
        }

        private static HashSet<string> getVars(Block block, int start, int end)
        {
            var ret = new HashSet<string>();
            for (int i = start; i < end; i++)
            {
                var gused = new GlobalVarsUsed();
                gused.Visit(block.Cmds[i]);
                ret.UnionWith(gused.globalsUsed);
            }
            return ret;
        }

    }

    // Has methods for setting attributes on procedure declarations
    public class SetAttribute
    {
        // Sets an {:inline 1} attribute on all procedure declarations
        public static void setInline(List<Declaration> decls)
        {
            foreach (Declaration d in decls)
            {
                if (d is Procedure)
                {
                    setInline((Procedure)d);
                }
            }
        }

        // Sets an {:inline 1} attribute on all procedure declarations with an
        // implementation, except main
        public static void setInline(List<Declaration> decls, 
            InstrumentationPolicy policy, string mainProcName)
        {
            foreach (Declaration d in decls)
            {
                if (d is Procedure)
                {
                    var name = (d as Procedure).Name;
                    if (policy.procHasImpl(name) && name != mainProcName) 
                        setInline((Procedure)d);
                }
            }
        }

        // Sets an {:inline 1} attribute on a procedure declaration
        public static void setInline(Procedure p)
        {
            // Set inline attribute, but first check if an inline attribute
            // has already been set
            Expr before = QKeyValue.FindExprAttribute(p.Attributes, "inline");
            if (before != null)
            {
                //Console.WriteLine("Warning: some inline attribute has already been set for {0}",
                //    p.Name);
                return;
            }

            Expr num = Expr.Literal(1);
            var val = new List<object>();
            val.Add(num);

            QKeyValue inl = new QKeyValue(Token.NoToken, "inline", val, p.Attributes);
            p.Attributes = inl;
        }

        // Set a {:verify false} attribute on all procedure declarations
        public static void setNoVerify(List<Declaration> decls)
        {
            foreach (Declaration d in decls)
            {
                if (d is Procedure)
                {
                    setNoVerify((Procedure)d);
                }
            }
        }

        // Set a {:verify false} attribute on all "to-instrument" procedure declarations
        public static void setNoVerify(List<Declaration> decls,
            InstrumentationPolicy policy, string mainProcName)
        {
            foreach (Declaration d in decls)
            {
                if (d is Procedure)
                {
                    var name = (d as Procedure).Name;
                    if (policy.procHasImpl(name) && name != mainProcName) 
                        setNoVerify((Procedure)d);
                }
            }
        }

        // Set a {:verify false} attribute on a procedure declaration
        public static void setNoVerify(Procedure p)
        {
            Expr num1 = Expr.Literal(false);
            var val1 = new List<object>();
            val1.Add(num1);
            QKeyValue noverify = new QKeyValue(Token.NoToken, "verify", val1, p.Attributes);
            p.Attributes = noverify;
        }
    }

    // For renaming a command to use the K^th copy of the global
    // variables
    public class CmdRenamer : FixedVisitor
    {
        public int K;
        private VariableManager mgr;
        private InstrumentationPolicy policy;

        public CmdRenamer(VariableManager p, InstrumentationPolicy pol)
        {
            K = 0;
            mgr = p;
            policy = pol;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            IdentifierExpr newNode;
            if (node.Name != node.Decl.Name || node.Name != node.Decl.TypedIdent.Name)
                Console.WriteLine("Inconsistent variable/ident naming on " + node.Name + " " + node.Decl.Name + " " + node.Decl.TypedIdent.Name);

            GlobalVariable g = node.Decl as GlobalVariable;
            if (g == null)
            {
                newNode = null;
            }
            else
            {
                if (!policy.instrument(g))
                {
                    newNode = null;
                }
                else
                {

                    var newg = mgr.duplicateGlobalVar(g, DuplicationPolicy.OneCopy(K));
                    Debug.Assert(newg.Count == 1);
                    newNode = new IdentifierExpr(Token.NoToken, newg[0]);
                }
            }
            return base.VisitIdentifierExpr(newNode == null ? node : newNode);
        }


        public override Variable VisitVariable(Variable node)
        {
            Variable newg;

            GlobalVariable g = node as GlobalVariable;
            if (g == null)
            {
                newg = null;
            }
            else
            {
                if (!policy.instrument(g))
                {
                    newg = null;
                }
                else
                {

                    var tmp = mgr.duplicateGlobalVar(g, DuplicationPolicy.OneCopy(K));
                    Debug.Assert(tmp.Count == 1);
                    newg = tmp[0];
                }
            }

            return base.VisitVariable(newg == null ? node : newg);

        }
    }

    // This class only instruments async calls. It does not modify the control flow
    // of the program.
    //
    // call {:async} foo(a,b,c) is rewritten as:
    // 
    // save vars
    // old_k := k
    // old_tid = tid;
    // old_atomic := inAtomic
    // inAtomic := false
    //
    // // call the translated version of the thread with a new tid
    // old_tidCount = tidCount;
    // havoc tidCount;
    // assume tidCount > old_tidCount;
    // tid = tidCount;
    // assume !finished[tid]
    // save thread-locals
    // havoc thread-locals
    // call foo(a,b,c);
    // restore thread-locals
    // child-tid := tid
    //
    // // did the thread finish?
    // finished[tid] := not(raiseException);
    //
    // // How many rounds did foo take?
    // numRounds[tid] := k;
    //
    // // reset variables
    // tid = old_tid;
    // k = old_k;
    // raiseException = false;
    // inAtomic = old_atomic
    //
    public class InstrumentAsyncCalls : FixedVisitor
    {
        // Does the current implementation have a async call?
        public bool hasAsync { get; private set; }

        // Current implementation
        private string implName;

        // The variable manager
        private VariableManager vmgr;

        // A record of the transformation carried out
        private InsertionTrans tinfo;

        // A local variable to represent old_tidCount
        private Variable old_tidCount;

        // A local variable to represent old_atomic
        private Variable old_atomic;

        // A local variable for child tid
        private Variable childTid;

        // Thread local variables and their Local versions
        private Dictionary<string, GlobalVariable> threadLocalGlobals;
        private Dictionary<string, LocalVariable> threadLocalLocals;

        public InstrumentAsyncCalls(VariableManager mgr, ProgramInfo pinfo, InsertionTrans t)
        {
            hasAsync = false;
            vmgr = mgr;
            old_tidCount = null;
            tinfo = t;
            threadLocalGlobals = pinfo.threadLocalGlobals;
            threadLocalLocals = new Dictionary<string, LocalVariable>();
            foreach (var g in threadLocalGlobals.Values)
            {
                var lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                    "loc_" + g.Name, g.TypedIdent.Type));
                threadLocalLocals.Add(g.Name, lv);
            }

        }

        public override Implementation VisitImplementation(Implementation node)
        {
            hasAsync = false;
            implName = node.Name;
            old_tidCount = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "old_tidCount", vmgr.tidCountVar.TypedIdent.Type));
            old_atomic = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "old_atomic", Microsoft.Boogie.Type.Bool));
            childTid = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "child_tid_var_loc", vmgr.tidCountVar.TypedIdent.Type));

            node = base.VisitImplementation(node);
            if (hasAsync)
            {
                // Add old_k, old_tid, old_tidCount declarations
                node.LocVars.Add(vmgr.getOldkLocalVar(implName));
                node.LocVars.Add(vmgr.getOldtidLocalVar(implName));
                node.LocVars.Add(old_tidCount);
                node.LocVars.Add(old_atomic);
                node.LocVars.Add(childTid);
                
                // Add declarations for local versions of each thread-local vars
                foreach (var l in threadLocalLocals)
                {
                    node.LocVars.Add(l.Value);
                }

                // Add thread locals to the modifies clause
                var currMods = new HashSet<string>();
                foreach (IdentifierExpr ie in node.Proc.Modifies) currMods.Add(ie.Decl.Name);
                foreach (var g in threadLocalGlobals)
                {
                    if (!currMods.Contains(g.Key)) node.Proc.Modifies.Add(new IdentifierExpr(Token.NoToken, g.Value));
                }
            }
            old_tidCount = null;
            old_atomic = null;

            return node;
        }

        // This is the main place where the instrumentation happens
        public override Block VisitBlock(Block block)
        {
            // The new list of commands that we will construct
            List<Cmd> lcmds = new List<Cmd>();

            // index into block.Cmds
            int inCnt = -1;

            foreach (Cmd cmd in block.Cmds)
            {
                inCnt ++;

                if (!(cmd is CallCmd))
                {
                    lcmds.Add(cmd);
                    addedTrans(implName, block.Label, inCnt, cmd, lcmds);
                    continue;
                }

                CallCmd ccmd = cmd as CallCmd;

                if (ccmd.callee == LanguageSemantics.getChildThreadIDName())
                {
                    var outv = ccmd.Outs[0];
                    // outv := child_tid                    
                    lcmds.Add(BoogieAstFactory.MkVarEqVar(outv.Decl, childTid));
                    addedTrans(implName, block.Label, inCnt, cmd, lcmds);
                    continue;
                }

                // Ignore non-async calls 
                if (!ccmd.IsAsync)
                {
                    lcmds.Add(cmd);
                    addedTrans(implName, block.Label, inCnt, cmd, lcmds);
                    continue;
                }

                // We have an async call. Instrument it!
                hasAsync = true;

                // old_k := k
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    vmgr.getOldkLocalVar(implName), vmgr.vark));

                // old_tid := tid
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    vmgr.getOldtidLocalVar(implName), vmgr.tidVar));

                // old_tidCount = tidCount
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    old_tidCount, vmgr.tidCountVar));

                // old_atomic = inAotmic
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    old_atomic, vmgr.inAtomicBlock));

                // inAtomic := false
                lcmds.Add(BoogieAstFactory.MkVarEqConst(vmgr.inAtomicBlock, false));

                // havoc tidCount
                if (InstrumentationConfig.deterministicThreadId)
                {
                    // tidCount ++;
                    var e = TidArithmetic.increment(vmgr.tidCountVar);
                    lcmds.Add(BoogieAstFactory.MkVarEqExpr(vmgr.tidCountVar, e));
                }
                else
                {
                    lcmds.Add(BoogieAstFactory.MkHavocVar(vmgr.tidCountVar));
                }

                // assume tidCount > old_tidCount
                var ae = TidArithmetic.assumeGt(vmgr.tidCountVar, old_tidCount);
                lcmds.Add(new AssumeCmd(Token.NoToken, ae));

                // tid = tidCount
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    vmgr.tidVar, vmgr.tidCountVar));
                
                // save thread-locals
                foreach (var tl in threadLocalLocals.Keys)
                {
                    // loc_tl := tl
                    lcmds.Add(BoogieAstFactory.MkVarEqVar(threadLocalLocals[tl], threadLocalGlobals[tl]));
                }

                // havoc thread-locals
                foreach (var tl in threadLocalLocals.Keys)
                {
                    // havoc tl
                    lcmds.Add(BoogieAstFactory.MkHavocVar(threadLocalGlobals[tl]));
                }

                // call foo(a,b,c);
                // local_tid = tid;

                ccmd = new CallCmd(ccmd.tok, ccmd.Proc.Name, ccmd.Ins, ccmd.Outs, ccmd.Attributes, false);

                lcmds.Add(ccmd);
                addedTrans(implName, block.Label, inCnt, cmd, lcmds);

                // child-tid := tid;
                lcmds.Add(BoogieAstFactory.MkVarEqVar(childTid, vmgr.tidVar));

                // restore thread-locals
                foreach (var tl in threadLocalLocals.Keys)
                {
                    // tl := loc_tl
                    lcmds.Add(BoogieAstFactory.MkVarEqVar(threadLocalGlobals[tl], threadLocalLocals[tl]));
                }

                // tid = old_tid;
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    vmgr.tidVar, vmgr.getOldtidLocalVar(implName)));

                // k = old_k;
                lcmds.Add(BoogieAstFactory.MkVarEqVar(
                    vmgr.vark, vmgr.getOldkLocalVar(implName)));

                // raiseException = false;
                lcmds.Add(BoogieAstFactory.MkVarEqConst(vmgr.raiseException, false));

                // inAtomic = old_atomic
                lcmds.Add(BoogieAstFactory.MkVarEqVar(vmgr.inAtomicBlock, old_atomic));
            }

            block.Cmds = lcmds;
            tinfo.addTrans(implName, block.Label, block.Label);

            return block;
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string blk, int inCnt, Cmd inCmd, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last());
            tinfo.addTrans(procName, blk, inCnt, inCmd, blk, curr.Count - 1, cseq);
        }
    }

    // This class massages call commands to a better form for the instrumenter.
    // Let g_i be global variables and l_i be local variables.
    // It replaces "call g_1 := foo(g_2,l_1)" with
    // l_2 := g_2;
    // call l_3 := foo(l_2, l_1);
    // g_1 := l_3;
    //
    // where l_2 and l_3 are new local variables.
    // The control flow of the program is not modified.
    public class RewriteCallCmds : FixedVisitor
    {
        // If onlyAsync is true, then only async calls are rewritten,
        // otherwise all calls are rewritten
        private bool onlyAsync;

        // A set of local variables that we may want to add to the current
        // implementation being visited. T
        private List<LocalVariable> localsToAdd;

        // A counter for generating local variables with different names
        private int localVarCount;

        // Name of the current implementation being visited
        private string implName;

        // The transformation carried out
        public ModifyTrans tinfo;

        // If onlyAsync is true, then only async calls are rewritten,
        // otherwise all calls are rewritten
        public RewriteCallCmds(bool a)
        {
            onlyAsync = a;
            localVarCount = 0;
            implName = null;
            tinfo = new ModifyTrans();
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            implName = node.Name;
            localsToAdd = new List<LocalVariable>();
            node = base.VisitImplementation(node);
            localsToAdd.Iterate(x => node.LocVars.Add((Variable)x));

            return node;
        }

        // Return a new local variable
        private LocalVariable getNewLocal(Microsoft.Boogie.Type type)
        {
            string name = "cmdloc_dummy_var_" + (localVarCount.ToString());
            TypedIdent tid = new TypedIdent(Token.NoToken, name, type);
            LocalVariable lv = new LocalVariable(Token.NoToken, tid);
            localsToAdd.Add(lv);
            localVarCount++;
            return lv;
        }

        // This is the main place where the rewriting happens
        public override Block VisitBlock(Block block)
        {
            GlobalVarsUsed usesg = new GlobalVarsUsed();

            // The new list of commands that we will construct
            List<Cmd> lcmds = new List<Cmd>();

            foreach (Cmd cmd in block.Cmds)
            {

                if (!(cmd is CallCmd))
                {
                    tinfo.add(implName, block.Label, new InstrTrans(cmd, cmd));
                    lcmds.Add(cmd);
                    continue;
                }

                CallCmd ccmd = cmd as CallCmd;

                // Ignore non-async calls if our flag says so
                if (onlyAsync && !ccmd.IsAsync)
                {
                    tinfo.add(implName, block.Label, new InstrTrans(cmd, cmd));
                    lcmds.Add(cmd);
                    continue;
                }


                // If the call command doesn't have any global variables, then no need
                // to instrument
                usesg.Visit(ccmd);
                if (usesg.Used.Count == 0)
                {
                    tinfo.add(implName, block.Label, new InstrTrans(cmd, cmd));
                    lcmds.Add(cmd);
                    continue;
                }

                // Get ready to instrument

                // The callee
                Procedure callee = ccmd.Proc;
                // This is the list of commands for saving the arguments
                List<Cmd> saveArgs = new List<Cmd>();
                // This is the new list of arguments
                List<Expr> newArgs = new List<Expr>();
                // This is the new list of returns
                List<IdentifierExpr> newReturns = new List<IdentifierExpr>();
                // This is the list of commands for restoring return values
                List<Cmd> restoreReturns = new List<Cmd>();

                // Go through the arguments of the call
                int argcount = 0;
                foreach (Expr exp in ccmd.Ins)
                {
                    if (exp != null)
                    {
                        usesg.reset();
                        usesg.Visit(exp);
                    }

                    if (exp != null && usesg.Used.Count != 0)
                    {
                        // Cannot use the following statement because
                        // exp.Type is not available unless type checking
                        // is performed. Let's avoid type checking for now.
                        //Variable lvar = getNewLocal(exp.Type);
                        Variable lvar = getNewLocal(ccmd.Proc.InParams[argcount].TypedIdent.Type);
                        saveArgs.Add(
                            BoogieAstFactory.MkVarEqExpr(lvar, exp)
                            );
                        newArgs.Add(Expr.Ident(lvar));
                    }
                    else
                    {
                        newArgs.Add(exp);
                    }
                    argcount ++;
                }

                // Go through the return values
                argcount = 0;
                foreach (IdentifierExpr exp in ccmd.Outs)
                {
                    if (exp != null)
                    {
                        usesg.reset();
                        usesg.Visit(exp);
                    }

                    if (exp != null && usesg.Used.Count != 0)
                    {
                        Variable lvar = getNewLocal(ccmd.Proc.OutParams[argcount].TypedIdent.Type);
                        IdentifierExpr ret = new IdentifierExpr(Token.NoToken, lvar);
                        restoreReturns.Add(
                            BoogieAstFactory.MkVarEqExpr(exp.Decl, ret)
                            );
                        newReturns.Add(ret);
                    }
                    else
                    {
                        newReturns.Add(exp);
                    }
                    argcount++;
                }

                // Now add to lcmds: saveArgs; newcall command; restoreReturns
                var newCmds = new List<Cmd>();
                newCmds.AddRange(saveArgs);
                CallCmd newcallcmd = new CallCmd(ccmd.tok, ccmd.Proc.Name, newArgs, newReturns, ccmd.Attributes, ccmd.IsAsync);
                newcallcmd.Proc = callee; // Temporary hack to avoid doing "Resolve"

                newCmds.Add(newcallcmd);
                newCmds.AddRange(restoreReturns);

                tinfo.add(implName, block.Label, new InstrTrans(cmd, newCmds, saveArgs.Count));
                lcmds.AddRange(newCmds);
            }

            block.Cmds = lcmds;

            return block;
        }
    }

    public class AssertLocation : IEqualityComparer<AssertLocation>
    {
        public string procName;
        public string blockName;
        public int instrNo;

        public AssertLocation()
        {
            procName = blockName = null;
            instrNo = 0;
        }

        public AssertLocation(string procName, string blockName, int instrNo)
        {
            this.procName = procName;
            this.blockName = blockName;
            this.instrNo = instrNo;
        }

        public bool Equals(AssertLocation a, AssertLocation b)
        {
            return (a.procName == b.procName && a.blockName == b.blockName && a.instrNo == b.instrNo);
        }

        public int GetHashCode(AssertLocation a)
        {
            return 131 * a.procName.GetHashCode() + a.blockName.GetHashCode() + a.instrNo;
        }
    }

    // This class rewrites asserts.
    // It replaces "assert e" with:
    // goto lab1, lab2;
    // 
    // lab1:
    //   assume not(e)
    //   call cba_assert_not_reachable();
    //   //assume false;
    //   goto lab3;
    // lab2:
    //   assume e
    //   goto lab3;
    // lab3:
    //   ...
    public class RewriteAsserts
    {
        public static readonly string AssertIdentificationAttribute = "corral_assert_pt";

        // The transformation carried out
        HashSet<string> lab1BlocksAdded;
        HashSet<string> lab1BlocksAddedForReq;
        HashSet<string> lab1BlocksAddedForEns;
        HashSet<string> lab2BlocksAdded;
        HashSet<string> lab2BlocksAddedForReqEns;
        HashSet<string> lab3BlocksAdded;

        // new name count
        int newNameCount;

        // Set of all assert locations in the input program
        Dictionary<AssertLocation, bool> allAssertLocations;

        // Location of the failing assert in the trace given to mapBackTrace
        public AssertLocation failingAssert {get; private set;}

        // Found the assert?
        public bool assertFound
        {
            get
            {
                return (failingAssert != null);
            }
        }

        // Should we expect to find a failing assert in the trace?
        private bool shouldFindAssert;

        public RewriteAsserts()
        {
            lab1BlocksAdded = new HashSet<string>();
            lab1BlocksAddedForReq = new HashSet<string>();
            lab1BlocksAddedForEns = new HashSet<string>();
            lab2BlocksAdded = new HashSet<string>();
            lab2BlocksAddedForReqEns = new HashSet<string>();
            lab3BlocksAdded = new HashSet<string>();
            newNameCount = 0;
            allAssertLocations = new Dictionary<AssertLocation, bool>(new AssertLocation());
            failingAssert = null;
            shouldFindAssert = true;
        }

        public RewriteAsserts(bool shouldFindAssert)
            : this()
        {
            this.shouldFindAssert = shouldFindAssert;
        }

        // For allowing multiple traces to be mapped back
        public void reset()
        {
            failingAssert = null;
        }

        public Program VisitProgram(Program inp)
        {
            var hasDecl = false;

            foreach (var decl in inp.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    VisitImplementation(decl as Implementation);
                }
                else if (decl is Procedure)
                {
                    if ((decl as Procedure).Name == LanguageSemantics.assertNotReachableName())
                    {
                        hasDecl = true;
                    }
                }
            }

            if (!hasDecl)
            {
                inp.AddTopLevelDeclaration(
                    new Procedure(
                        Token.NoToken, LanguageSemantics.assertNotReachableName(),
                        new List<TypeVariable>(), new List<Variable>(), new List<Variable>(),
                        new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));

            }
            else
            {
                // Delete all annotations of corral_assert_not_reachable (otherwise we can get type errors)
                var assertProc = BoogieUtil.findProcedureDecl(inp.TopLevelDeclarations, LanguageSemantics.assertNotReachableName());
                assertProc.Modifies = new List<IdentifierExpr>();
                assertProc.Requires = new List<Requires>();
                assertProc.Ensures = new List<Ensures>();
            }

            // Make all requires and ensures free
            foreach (var proc in inp.TopLevelDeclarations.OfType<Procedure>())
            {
                // Make all requires free
                proc.Requires = new List<Requires>(proc.Requires.OfType<Requires>().Select(r => new Requires(r.tok, true, r.Condition, null, r.Attributes)).ToArray());
                // Make all ensures free
                proc.Ensures = new List<Ensures>(proc.Ensures.OfType<Ensures>().Select(r => new Ensures(r.tok, true, r.Condition, null, r.Attributes)).ToArray());
            }

            return inp;
        }

        private Implementation VisitImplementation(Implementation node)
        {
            var newBlocks = new List<Block>();

            foreach (Block block in node.Blocks)
            {
                var currCmds = new List<Cmd>();
                var currLabel = block.Label;

                foreach (Cmd cmd in block.Cmds)
                {
                    if (BoogieUtil.isAssertTrue(cmd))
                    {
                        // convert assert true to assume true
                        currCmds.Add(new AssumeCmd(cmd.tok, Expr.True));
                        continue;
                    }

                    if (cmd is AssertCmd)
                    {
                        branchForAssert((cmd as AssertCmd).Expr, ref currLabel, ref currCmds, newBlocks, 0);
                        continue;
                    }

                    // For a call, check for non-free requires 
                    if (cmd is CallCmd)
                    {
                        var ccmd = cmd as CallCmd;
                        var reqToAssert = ccmd.Proc.Requires.OfType<Requires>().Where(r => !r.Free);
                        if (reqToAssert.Count() == 0)
                        {
                            currCmds.Add(cmd);
                            continue;
                        }
                        var formalToActual = new Dictionary<string, Expr>();
                        for (int i = 0; i < ccmd.Ins.Count; i++)
                            formalToActual.Add(ccmd.Proc.InParams[i].Name, ccmd.Ins[i]);

                        var subst = new Substitution(v =>
                        {
                            if (formalToActual.ContainsKey(v.Name)) return formalToActual[v.Name];
                            return Expr.Ident(v);
                        });

                        Expr aexpr = Expr.True;
                        foreach (var req in reqToAssert)
                            aexpr = Expr.And(aexpr, Substituter.Apply(subst, req.Condition));

                        branchForAssert(aexpr, ref currLabel, ref currCmds, newBlocks, 1);

                        currCmds.Add(cmd);
                        continue;
                    }

                    currCmds.Add(cmd);
                }

                // At a return, check for non-free ensures
                if (block.TransferCmd is ReturnCmd)
                {
                    var ensToAssert = node.Proc.Ensures.OfType<Ensures>().Where(e => !e.Free);
                    if (ensToAssert.Count() != 0)
                    {
                        Expr aexpr = Expr.True;
                        foreach (var ens in ensToAssert)
                            aexpr = Expr.And(aexpr, ens.Condition);

                        branchForAssert(aexpr, ref currLabel, ref currCmds, newBlocks, 2);
                    }
                }

                newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, block.TransferCmd));
            }

            node.Blocks = newBlocks;

            foreach (var block in newBlocks)
            {
                recordNotReachableProcLocation(node.Name, block);
            }

            return node;
        }

        // forAssert: 0 for assert, 1 for requires, 2 for ensures
        private void branchForAssert(Expr aexpr, ref string currLabel, ref List<Cmd> currCmds, List<Block> newBlocks, int forAssert)
        {
            var acallcmd = new CallCmd(Token.NoToken, LanguageSemantics.assertNotReachableName(), new List<Expr>(), new List<IdentifierExpr>());

            var lab1 = getNewLabel();
            var lab2 = getNewLabel();
            var lab3 = getNewLabel();

            lab1BlocksAdded.Add(lab1);
            lab2BlocksAdded.Add(lab2);
            lab3BlocksAdded.Add(lab3);

            if (forAssert != 0) lab2BlocksAddedForReqEns.Add(lab2);
            if (forAssert == 1) lab1BlocksAddedForReq.Add(lab1);
            if (forAssert == 2) lab1BlocksAddedForEns.Add(lab1);

            // End current block
            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(lab1, lab2)));

            // lab1
            currLabel = lab1;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(aexpr), 
                new QKeyValue(Token.NoToken, AssertIdentificationAttribute, new List<object>(), null)));
            currCmds.Add(acallcmd);
            // cannot put assume false here: when the assert is inside
            // an atomic block then a context switch would not happen between
            // the assert and this assume
            //currCmds.Add(new AssumeCmd(Token.NoToken, Expr.False));

            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds,
                BoogieAstFactory.MkGotoCmd(lab3)));
            //new ReturnCmd(Token.NoToken)));

            // lab2
            currLabel = lab2;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, aexpr));

            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(lab3)));

            // lab3
            currLabel = lab3;
            currCmds = new List<Cmd>();
        }

        private void recordNotReachableProcLocation(string procName, Block block)
        {
            for (int i = 0; i < block.Cmds.Count; i++)
            {
                var cmd = block.Cmds[i];
                if (cmd is CallCmd && (cmd as CallCmd).Proc != null)
                {
                    if ((cmd as CallCmd).Proc.Name == LanguageSemantics.assertNotReachableName())
                    {
                        allAssertLocations.Add(new AssertLocation(procName, block.Label, i), true);
                    }
                }
            }
        }

        // Return a new local variable
        private string getNewLabel()
        {
            string name = "assert_rewrite_dummy_block_" + (newNameCount.ToString());
            newNameCount++;
            return name;
        }

        // Walk through the trace:
        //   for lab1 & lab2 blocks, replace them with one INTRA instruction
        //   for lab3 blocks, merge with previous
        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            var ret = mapBackTraceRec(trace);
            if (failingAssert == null)
            {
                // Walk through the trace to find the failing assert because we didn't
                // find it already
                findAssert(trace);
                if (failingAssert == null && shouldFindAssert)
                {
                    throw new InternalError("Failed to find the failing assert");
                }
            }
            return ret;
        }

        private void findAssert(ErrorTrace trace)
        {
            if (trace == null) return;

            var currLoc = new AssertLocation(trace.procName, "", 0);

            foreach (var blk in trace.Blocks)
            {
                currLoc.blockName = blk.blockName;

                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    currLoc.instrNo = i;
                    if (allAssertLocations.ContainsKey(currLoc))
                    {
                        if (failingAssert != null)
                        {
                            throw new InternalError("Multiple asserts can fail");
                        }
                        blk.Cmds[i].info = new AssertFailInstrInfo(blk.Cmds[i].info);
                        failingAssert = new AssertLocation(currLoc.procName, currLoc.blockName, currLoc.instrNo);
                    }
                    findAssert(blk.Cmds[i].CalleeTrace);
                }
            }

        }

        private ErrorTrace mapBackTraceRec(ErrorTrace trace)
        {
            var ret = new ErrorTrace(trace.procName);
            ErrorTraceBlock last = null;

            foreach (var blk in trace.Blocks)
            {
                if (lab1BlocksAdded.Contains(blk.blockName))
                {
                    Debug.Assert(last != null);
                    if (blk.Cmds.Count > 1)
                    {
                        var binfo = blk.Cmds[0].info;
                        if (failingAssert != null)
                        {
                            throw new InternalError("Multiple assertions have failed");
                        }
                        failingAssert = new AssertLocation(trace.procName, last.blockName, last.Cmds.Count);

                        if (lab1BlocksAddedForReq.Contains(blk.blockName))
                        {
                            if (last.Cmds.Count == 0)
                                last.info = new RequiresFailInstrInfo(binfo);
                            else
                                last.Cmds.Last().info = new RequiresFailInstrInfo(binfo);
                        }
                        else if (lab1BlocksAddedForEns.Contains(blk.blockName))
                        {
                            if (last.Cmds.Count == 0)
                                last.info = new EnsuresFailInstrInfo(binfo);
                            else
                                last.Cmds.Last().info = new EnsuresFailInstrInfo(binfo);
                        }
                        else
                        {
                            last.addInstr(new IntraInstr(new AssertFailInstrInfo(binfo)));
                        }
                    }
                    else
                    {
                        last.addInstr(new IntraInstr());
                    }
                    
                }
                else if (lab2BlocksAdded.Contains(blk.blockName))
                {
                    Debug.Assert(last != null);
                    InstrInfo info = new InstrInfo();
                    if (blk.Cmds.Count >= 1)
                    {
                        info = new InstrInfo(blk.Cmds[0].info);
                    }
                    if(!lab2BlocksAddedForReqEns.Contains(blk.blockName))
                        last.addInstr(new IntraInstr(info));
                }
                else if (lab3BlocksAdded.Contains(blk.blockName))
                {
                    Debug.Assert(last != null);
                    foreach (var inst in blk.Cmds)
                    {
                        last.addInstr(mapBackInstr(inst));
                    }
                }
                else
                {
                    last = new ErrorTraceBlock(blk.blockName);
                    last.info = blk.info;

                    foreach (var inst in blk.Cmds)
                    {
                        last.addInstr(mapBackInstr(inst));
                    }
                    ret.addBlock(last);
                }
            }
            if (trace.returns) ret.addReturn();

            return ret;
        }

        private ErrorTraceInstr mapBackInstr(ErrorTraceInstr inst)
        {
            if (inst.CalleeTrace == null)
            {
                return inst;
            }

            var cinst = inst as CallInstr;
            Debug.Assert(cinst != null);
            var ret = new CallInstr(mapBackTraceRec(cinst.calleeTrace), cinst.asyncCall, cinst.info);

            return ret;
        }
    }

    public class CallVisitor : FixedVisitor
    {
        Action<CallCmd> action;
        public CallVisitor(Action<CallCmd> action)
        {
            this.action = action;
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            action(node);
            return base.VisitCallCmd(node);
        }
    }

    // Set up a single-threaded program for Stratified Inlining
    public class SequentialInstrumentation : CompilerPass
    {
        // The transformation
        InsertionTrans tinfo;
        // error variable
        GlobalVariable assertsPassed;
        public string assertsPassedName
        {
            get
            {
                if (assertsPassed == null) return null;
                return assertsPassed.Name;
            }
        }

        // Tokenize the assertions


        public SequentialInstrumentation()
        {
            passName = "SequentialInstrumentation";
            tinfo = new InsertionTrans();
            assertsPassed = null;
        }

        private void CreateAssertsPassedVar(Program program)
        {
            var name = "assertsPassed";
            var cnt = 0;
            while (program.TopLevelDeclarations.OfType<GlobalVariable>().Any(g => g.Name == name))
            {
                name = "assertsPassed" + (++cnt);
            }

            assertsPassed = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                name, Microsoft.Boogie.Type.Bool));
        }

        // If the program has no reachable "async" calls then it is single threaded, i.e., sequential.
        // This call mutates the program by removing all implementations unreachable from main.
        public static bool isSingleThreadProgram(Program program, string mainProcName)
        {
            // Procedures that do an async call
            var asyncCallProcs = new HashSet<string>();

            // Prune unreachable procedures
            var callGraph = new Dictionary<string, HashSet<string>>();

            // call graph
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                callGraph.Add(impl.Name, new HashSet<string>());
                var vs = new CallVisitor(cmd => 
                    {
                        callGraph[impl.Name].Add(cmd.callee);
                        if (hasAsyncAnnotation(cmd))
                        {
                            asyncCallProcs.Add(impl.Name);
                        }
                    });
                vs.VisitImplementation(impl);
            }

            // find reachable procedures
            var reachable = new HashSet<string>();
            reachable.Add(mainProcName);

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

            var remainingDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    var name = (decl as Implementation).Name;
                    if (!reachable.Contains(name)) continue;
                }
                remainingDecls.Add(decl);
            }
            program.TopLevelDeclarations = remainingDecls;

            reachable.IntersectWith(asyncCallProcs);
            if (reachable.Count == 0) return true;
            return false;
        }

        static bool hasAsyncAnnotation(Cmd cmd)
        {
            var ccmd = cmd as CallCmd;
            if (ccmd == null) return false;

            return ccmd.IsAsync;
        }

        public static HashSet<string> procsWithAsserts(Program program)
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
                    foreach (var cmd in blk.Cmds.OfType<CallCmd>())
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

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            CreateAssertsPassedVar(program);
            var impls = BoogieUtil.nameImplMapping(program);
            var pwa = procsWithAsserts(program);

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var instrumented = new List<Block>();
                foreach (var blk in impl.Blocks)
                {
                    var currCmds = new List<Cmd>();
                    var currLabel = blk.Label;

                    tinfo.addTrans(impl.Name, blk.Label, blk.Label);
                    var incnt = -1;
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        incnt++;

                        // replace "t := getThreadID" with "t := 1"
                        if (BoogieUtil.checkIsCall(LanguageSemantics.getThreadIDName(), cmd))
                        {
                            var ccmd = cmd as CallCmd;
                            var outv = ccmd.Outs[0];
                            if (outv == null)
                            {
                                currCmds.Add(cmd);
                                addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);
                                continue;
                            }
                            currCmds.Add(BoogieAstFactory.MkVarEqConst(outv.Decl, 1));
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);
                            continue;
                        }

                        // instrument assert
                        if (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd))
                        {
                            currCmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, (cmd as AssertCmd).Expr));
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                            currLabel = addInstr(instrumented, currCmds, currLabel);
                            currCmds = new List<Cmd>();

                            continue;
                        }

                        // is assert false
                        if (BoogieUtil.checkIsCall(LanguageSemantics.assertNotReachableName(), cmd))
                        {
                            currCmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, Expr.False));
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                            currLabel = addInstr(instrumented, currCmds, currLabel);
                            currCmds = new List<Cmd>();

                            continue;
                        }

                        // procedure call 
                        if (cmd is CallCmd && pwa.Contains((cmd as CallCmd).callee))
                        {
                            currCmds.Add(cmd);
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);
                            currLabel = addInstr(instrumented, currCmds, currLabel);
                            currCmds = new List<Cmd>();
                            continue;
                        }

                        currCmds.Add(cmd);
                        addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                    }

                    instrumented.Add(new Block(Token.NoToken, currLabel, currCmds, blk.TransferCmd));

                }

                impl.Blocks = instrumented;
            }

            program.AddTopLevelDeclaration(assertsPassed);
            addMain(program);

            BoogieUtil.DoModSetAnalysis(program);

            // Set inline attribute
            // free requires assertsPassed == true;
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.Proc.Requires.Add(new Requires(true, Expr.Ident(assertsPassed)));
            }

            // convert free ensures e to:
            //  free ensures assertsPassed == false || e
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => pwa.Contains(impl.Name)))
            {
                foreach (Ensures ens in impl.Proc.Ensures)
                    ens.Condition = Expr.Or(Expr.Not(Expr.Ident(assertsPassed)), ens.Condition);
            }

            return program;
        }

        // Adds a new main:
        //   assertsPassed := true;
        //   call main();
        //   assert assertsPassed;
        void addMain(CBAProgram program)
        {
            var dup = new FixedDuplicator();
            var origMain = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            var newMain = dup.VisitImplementation(origMain);
            var newProc = dup.VisitProcedure(origMain.Proc);

            newMain.Name += "_SeqInstr";
            newProc.Name += "_SeqInstr";
            newMain.Proc = newProc;

            var mainIns = new List<Expr>();
            foreach (Variable v in newMain.InParams)
            {
                mainIns.Add(Expr.Ident(v));
            }
            var mainOuts = new List<IdentifierExpr>();
            foreach (Variable v in newMain.OutParams)
            {
                mainOuts.Add(Expr.Ident(v));
            }

            var callMain = new CallCmd(Token.NoToken, program.mainProcName, mainIns, mainOuts);
            callMain.Proc = origMain.Proc;

            var cmds = new List<Cmd>();
            cmds.Add(BoogieAstFactory.MkVarEqConst(assertsPassed, true));
            cmds.Add(callMain);            
            cmds.Add(new AssertCmd(Token.NoToken, Expr.Ident(assertsPassed)));

            var blk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
            newMain.Blocks = new List<Block>();
            newMain.LocVars = new List<Variable>();
            newMain.Blocks.Add(blk);

            program.AddTopLevelDeclaration(newProc);
            program.AddTopLevelDeclaration(newMain);

            program.mainProcName = newMain.Name;

            // Set entrypoint
            origMain.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Attributes);
            origMain.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Proc.Attributes);

            newMain.AddAttribute("entrypoint");
        }

        
        public override ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            // knock off top-level procedure
            var OldMainName = (input as PersistentCBAProgram).mainProcName;
            ErrorTrace ptrace = null;
            foreach (var blk in trace.Blocks)
            {
                var c = blk.Cmds.OfType<CallInstr>().First(cmd => cmd.callee == OldMainName);
                if (c == null) continue;
                ptrace = c.calleeTrace;
                break;
            }

            return tinfo.mapBackTrace(ptrace);
        }

        // goto label1, label2;
        //
        // label1:
        //   assume !assertsPassed;
        //   return;
        //
        // label2:
        //   assume assertsPassed;
        //   goto lab;
        //
        // lab:
        //
        // Inputs: the list of blocks being constructed; the current block being constructed.
        // End current block and adds two new blocks.
        // Returns "lab".

        private string addInstr(List<Block> instrumented, List<Cmd> curr, string curr_label)
        {
            string lbl1 = getNewLabel();
            string lbl2 = getNewLabel();

            List<String> ssp = new List<String>{lbl1, lbl2};
            instrumented.Add(new Block(Token.NoToken, curr_label, curr, new GotoCmd(Token.NoToken, ssp)));

            string common_label = getNewLabel();
            // assume (!assertsPassed)
            AssumeCmd cmd1 = new AssumeCmd(Token.NoToken, Expr.Not(Expr.Ident(assertsPassed)));
            // assume (assertsPassed)
            AssumeCmd cmd2 = new AssumeCmd(Token.NoToken, Expr.Ident(assertsPassed));

            curr = new List<Cmd>();
            curr.Add(cmd1);
            instrumented.Add(new Block(Token.NoToken, lbl1, curr, new ReturnCmd(Token.NoToken)));

            curr = new List<Cmd>();
            curr.Add(cmd2);
            instrumented.Add(new Block(Token.NoToken, lbl2, curr, BoogieAstFactory.MkGotoCmd(common_label)));

            return common_label;
        }

        static int labelCnt = 0;

        static string getNewLabel()
        {
            labelCnt++;
            return "SeqInstr_" + labelCnt.ToString();
        }
        
        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last());
            tinfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }
    }
}
