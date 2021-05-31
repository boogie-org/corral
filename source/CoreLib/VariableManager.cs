using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    // Maintains global variables that are added by the instrumenter. It has
    // variables like: the K copies of the global variables, extra variables
    // for contextBound, raiseException, etc.
    public class VariableManager
    {
        // variable "k" for tracking current execution context
        public GlobalVariable vark { get; private set; }
        private string varkName;

        // variable "raiseException". It can be set by procedure "contextSwitch".
        // When set, the current thread exits (from all procedures called by it)
        public GlobalVariable raiseException { get; private set; }
        private string raiseExceptionName;

        // When this Boolean variable is set, a context switch is disallowed
        public GlobalVariable inAtomicBlock { get; private set; }
        private string inAtomicBlockName;

        // Variable to keep track if some assertion has failed or not
        public GlobalVariable errorVar { get; private set; }
        private string errorVarName;

        // Variable to keep track of current thread id
        public GlobalVariable tidVar { get; private set; }
        private string tidVarName;

        // Variable to keep track of the number of threads
        public GlobalVariable tidCountVar { get; private set; }
        private string tidCountVarName;

        // Local variable for "old_k" to keep track of local value of k
        // (One per procedure)
        private Dictionary<string, LocalVariable> oldkLocalVars;
        private string oldkVarName;

        // Local variable for "old_tid" to keep track of local value of tid
        // (One per procedure)
        private Dictionary<string, LocalVariable> oldtidLocalVars;
        private string oldtidVarName;

        // The set of all declared global variables
        public Dictionary<string, GlobalVariable> declaredGlobals { get; private set; }

        // The number of copies we have created for the global variables
        private int numCopiesCreated;

        // Variable name -> all its K copies. This is for each declared global.
        private Dictionary<string, List<GlobalVariable>> gblVarCopies;

        // Variable name -> (K-1) copies that store the intial value of the variable.
        private Dictionary<string, List<GlobalVariable>> gblVarInitCopies;

        // The "contextSwitch" procedure
        private int csProcBound; // for caching
        private Procedure csProc;
        public string csProcName { get; private set; }

        // ContextSwitch can raise exception?
        public static bool ContextSwitchRaisesException = true;

        // The name of the main procedure to be added
        // The actual procedure is constructed in the instrumenter
        public string cbaMainName { get; private set; }
        
        public VariableManager(ProgramInfo pinfo)
        {
            varkName = "k";
            csProcName = "contextSwitch";
            raiseExceptionName = "raiseException";
            errorVarName = "assertsPassed";
            inAtomicBlockName = "inAtomicBlock";
            tidVarName = LanguageSemantics.tidName;
            tidCountVarName = "tidCount";
            oldkVarName = "old_k";
            oldtidVarName = "old_tid";

            cbaMainName = pinfo.mainProcName;
            csProcBound = -1;

            vark = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, varkName, Microsoft.Boogie.Type.Int));

            raiseException = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, raiseExceptionName,
                                                                              Microsoft.Boogie.Type.Bool));

            errorVar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, errorVarName,
                                                                        Microsoft.Boogie.Type.Bool));

            inAtomicBlock = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, inAtomicBlockName,
                                                                              Microsoft.Boogie.Type.Bool));

            tidVar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, tidVarName,
                                                                      pinfo.threadIdType));

            tidCountVar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, tidCountVarName,
                                                                              pinfo.threadIdType));

            // Construct type int -> bool
            var ts = new List<Microsoft.Boogie.Type>();
            ts.Add(pinfo.threadIdType);
            MapType mt = new MapType(Token.NoToken, new List<TypeVariable>(), ts, Microsoft.Boogie.Type.Bool);

            // Construct type int -> int
            mt = new MapType(Token.NoToken, new List<TypeVariable>(), ts, Microsoft.Boogie.Type.Int);

            oldkLocalVars = new Dictionary<string, LocalVariable>();
            oldtidLocalVars = new Dictionary<string, LocalVariable>();

            declaredGlobals = pinfo.declaredGlobals;

            numCopiesCreated = 0;
            gblVarCopies = new Dictionary<string, List<GlobalVariable>>();
            gblVarInitCopies = new Dictionary<string, List<GlobalVariable>>();

            // Make some copies for now
            makeCopies(1);

            // Check if any of variables we're going to insert
            // have any clashes with what is existing
            if (declaredGlobals.ContainsKey(varkName)
                || declaredGlobals.ContainsKey(raiseExceptionName)
                || declaredGlobals.ContainsKey(errorVarName)
                || declaredGlobals.ContainsKey(inAtomicBlockName)
                || pinfo.allProcs.Contains(csProcName))
            {
                throw new InvalidProg("Possible name clashes!");
            }

        }

        public LocalVariable getOldkLocalVar(string procName)
        {
            LocalVariable lvar;
            if (oldkLocalVars.TryGetValue(procName, out lvar))
            {
                return lvar;
            }
            lvar = new LocalVariable(Token.NoToken,
                new TypedIdent(Token.NoToken, oldkVarName, vark.TypedIdent.Type));
            oldkLocalVars.Add(procName, lvar);
            return lvar;
        }

        public LocalVariable getOldtidLocalVar(string procName)
        {
            LocalVariable lvar;
            if (oldtidLocalVars.TryGetValue(procName, out lvar))
            {
                return lvar;
            }
            lvar = new LocalVariable(Token.NoToken,
                new TypedIdent(Token.NoToken, oldtidVarName, tidVar.TypedIdent.Type));
            oldtidLocalVars.Add(procName, lvar);
            return lvar;
        }

        public Procedure getContextSwitchProcedure(int K)
        {
            Debug.Assert(K >= 1);
            
            if (csProcBound == K) return csProc;

            csProcBound = K;

            // Procedure for context switching

            //procedure contextSwitch();
            //modifies k;
            //modifies raiseException;
            //ensures(old(k) <= k);
            //ensures(k < K);
            //ensures(inAtomicBlock => (old(k) == k && (raiseException == false)))
            //ensures(!assertsPassed && !inAtomicBlock => raiseException)

            List<IdentifierExpr> mods = new List<IdentifierExpr>();
            mods.Add(new IdentifierExpr(Token.NoToken, vark));

            if (InstrumentationConfig.addRaiseException && ContextSwitchRaisesException)
            {
                mods.Add(new IdentifierExpr(Token.NoToken, raiseException));
            }

            // ensures(k < K)
            Ensures e1 = new Ensures(false, BoogieAstFactory.MkAssumeVarLtConst(vark, K).Expr);

            // ensures(old(k) <= k)
            Ensures e2 = new Ensures(false, BoogieAstFactory.MkAssumeOldVarLeVar(vark, vark).Expr);

            Ensures e3;
            if (InstrumentationConfig.addRaiseException && ContextSwitchRaisesException)
            {
                //ensures(inAtomicBlock => (old(k) == k && (raiseException == false)))
                e3 = new Ensures(false, BoogieAstFactory.MkAssumeInAtomic(inAtomicBlock, vark, raiseException).Expr);
            }
            else
            {
                //ensures(inAtomicBlock => (old(k) == k))
                e3 = new Ensures(false, Expr.Imp(Expr.Ident(inAtomicBlock), Expr.Eq(new OldExpr(Token.NoToken, Expr.Ident(vark)), Expr.Ident(vark))));
            }

            List<Ensures> ensures = new List<Ensures>();
            ensures.Add(e1);
            ensures.Add(e2);
            ensures.Add(e3);

            csProc = new Procedure(Token.NoToken, csProcName, new List<TypeVariable>(), new List<Variable>(), new List<Variable>(),
                                   new List<Requires>(), mods, ensures);

            return csProc;

        }

        public List<Declaration> getNewDeclarations(int K)
        {
            var ret = new List<Declaration>();

            ret.Add(vark);
            ret.Add(raiseException);
            ret.Add(inAtomicBlock);
            ret.Add(errorVar);
            ret.Add(tidVar);
            ret.Add(tidCountVar);
            ret.Add(getContextSwitchProcedure(K));

            return ret;
        }

        // Make sure that we have created at least K copies of the
        // global variables
        private void makeCopies(int K)
        {
            if (numCopiesCreated >= K) return;

            // Duplicate the global variables (K - numCopiesCreated) times
            foreach (var v in declaredGlobals)
            {
                var g = v.Value;
                List<GlobalVariable> currCopies;

                // Actual copies of global variables
                bool found = gblVarCopies.TryGetValue(g.Name, out currCopies);

                if (numCopiesCreated == 0)
                {
                    Debug.Assert(!found);
                    currCopies = new List<GlobalVariable>();
                }

                if (numCopiesCreated != 0)
                {
                    Debug.Assert(found);
                    Debug.Assert(currCopies.Count == numCopiesCreated);
                }

                for (int i = numCopiesCreated; i < K; i++)
                {
                    var newname = g.Name + "__" + i.ToString();
                    currCopies.Add(new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, newname, g.TypedIdent.Type)));
                }

                gblVarCopies[g.Name] = currCopies;

                // INIT copies of global variables
                found = gblVarInitCopies.TryGetValue(g.Name, out currCopies);

                if (numCopiesCreated <= 1)
                {
                    Debug.Assert(!found || (found && currCopies.Count == 0));
                    currCopies = new List<GlobalVariable>();
                }

                if (numCopiesCreated > 1)
                {
                    Debug.Assert(found);
                    Debug.Assert(currCopies.Count == numCopiesCreated - 1);
                }

                for (int i = numCopiesCreated; i < K; i++)
                {
                    if (i == 0) continue;
                    var newname = g.Name + "_s_" + (i).ToString();
                    currCopies.Add(new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, newname, g.TypedIdent.Type)));
                }

                gblVarInitCopies[g.Name] = currCopies;

            }

            numCopiesCreated = K;

        }

        // Returns the i^th copy of global variable gbl
        public GlobalVariable GetVarCopy(GlobalVariable gbl, int i)
        {
            Debug.Assert(gbl != null);
            makeCopies(i + 1);

            // Don't create new if gbl is already a new one
            if (!declaredGlobals.ContainsKey(gbl.Name))
            {
                return null;
            }

            List<GlobalVariable> copies;

            var found = gblVarCopies.TryGetValue(gbl.Name, out copies);

            Debug.Assert(found);
            Debug.Assert(copies != null);
            Debug.Assert(copies[i] != null);

            return copies[i];
        }

        // Returns the i^th INIT copy of global variable gbl
        public GlobalVariable GetVarInitCopy(GlobalVariable gbl, int i)
        {
            Debug.Assert(gbl != null);
            Debug.Assert(i != 0);
            makeCopies(i + 1);

            // Only valid for declared globals
            if (!declaredGlobals.ContainsKey(gbl.Name))
            {
                return null;
            }

            List<GlobalVariable> copies;

            var found = gblVarInitCopies.TryGetValue(gbl.Name, out copies);

            Debug.Assert(found);
            Debug.Assert(copies != null);
            Debug.Assert(copies[i - 1] != null);

            return copies[i - 1];
        }

        // If duplication policy is:
        //    ONE_COPY(K): return {gbl__K}
        //    ALL_COPIES(K): return {gbl__0, ..., gbl__{K-1}}
        //    INIT_COPIES(K): return {gbl_s_1, ..., gbl_s_{K-1}}
        public List<GlobalVariable> duplicateGlobalVar(
            GlobalVariable gbl,
            DuplicationPolicy dpolicy)
        {
            var new_globals = new List<GlobalVariable>();
            int cp;

            if (dpolicy.IsOneCopy(out cp))
            {
                GlobalVariable g = GetVarCopy(gbl, cp);
                if (g != null) new_globals.Add(g);
            }
            else if (dpolicy.IsAllCopies(out cp))
            {
                for (int i = 0; i < cp; i++)
                {
                    GlobalVariable g = GetVarCopy(gbl, i);
                    if (g != null) new_globals.Add(g);
                }
            }
            else if (dpolicy.IsInitCopies(out cp))
            {
                for (int i = 1; i < cp; i++)
                {
                    GlobalVariable g = GetVarInitCopy(gbl, i);
                    if (g != null) new_globals.Add(g);
                }
            }
            else
            {
                Debug.Assert(false);
            }

            return new_globals;
        }

        // Return the set of all copies made for a variable
        public HashSet<string> getAllVarCopies(string varname)
        {
            HashSet<string> ret = new HashSet<string>();
            List<GlobalVariable> copies;

            if (gblVarCopies.TryGetValue(varname, out copies))
            {
                foreach (GlobalVariable g in copies)
                {
                    ret.Add(g.Name);
                }
            }

            if (gblVarInitCopies.TryGetValue(varname, out copies))
            {
                foreach (GlobalVariable g in copies)
                {
                    ret.Add(g.Name);
                }
            }

            return ret;
        }

        // For each variable Mem to instrument, return:
        // assume Mem__1 == Mem_s_1
        // assume Mem__2 == Mem_s_2
        // ...
        // assume Mem__{K-1} == Mem_s_{K-1}
        public List<Cmd> constructInitAssumes(int K, InstrumentationPolicy policy)
        {
            List<Cmd> cseq = new List<Cmd>();

            for (int i = 1; i < K; i++)
            {
                foreach (var declg in declaredGlobals)
                {
                    if (!policy.instrument(declg.Value)) continue;

                    var g = declg.Value;
                    // assume Mem__1 == Mem_s_1 ...
                    cseq.Add(BoogieAstFactory.MkAssumeVarEqVar(GetVarCopy(g, i), GetVarInitCopy(g, i)));
                }
            }

            return cseq;
        }

        // For each variable Mem to instrument, return:
        // assume Mem__0 == Mem_s_1
        // assume Mem__1 == Mem_s_2
        // ...
        // assume Mem__{K-2} == Mem_s_{K-1}
        public List<Cmd> constructChecker(int K, InstrumentationPolicy policy)
        {
            List<Cmd> cseq = new List<Cmd>();
            for (int i = 0; i < K - 1; i++)
            {
                foreach (var declg in declaredGlobals)
                {
                    if (!policy.instrument(declg.Value)) continue;

                    var g = declg.Value;

                    cseq.Add(BoogieAstFactory.MkAssumeVarEqVar(GetVarCopy(g, i), GetVarInitCopy(g, i + 1)));
                }
            }

            return cseq;
        }

        /*
        // globals not to instrument: keep as is. 
        //
        // other globals: see policy. 
        //    ONE_COPY(K): return {gbl__K}
        //    ALL_COPIES(K): return {gbl__0, ..., gbl__{K-1}}
        //    INIT_COPIES(K): return {gbl_s_1, ..., gbl_s_{K-1}}
        public List<GlobalVariable> duplicateGlobalVar(
            GlobalVariable gbl, 
            InstrumentationPolicy ipolicy,
            DuplicationPolicy dpolicy)
        {
            var new_globals = new List<GlobalVariable>();
            int cp;

            if (!ipolicy.instrument(gbl))
            {
                // This global is not to be instrumented
                if (!dpolicy.IsInitCopies(out cp))
                {
                    new_globals.Add(gbl);
                }

            }
            else
            {
                if (dpolicy.IsOneCopy(out cp))
                {
                    GlobalVariable g = GetVarCopy(gbl, cp);
                    if (g != null) new_globals.Add(g);
                }
                else if (dpolicy.IsAllCopies(out cp))
                {
                    for (int i = 0; i < cp; i++)
                    {
                        GlobalVariable g = GetVarCopy(gbl, i);
                        if (g != null) new_globals.Add(g);
                    }
                }
                else if (dpolicy.IsInitCopies(out cp))
                {
                    for (int i = 1; i < cp; i++)
                    {
                        GlobalVariable g = GetVarInitCopy(gbl, i);
                        if (g != null) new_globals.Add(g);
                    }
                }
                else
                {
                    Debug.Assert(false);
                }
            }

            return new_globals;
        }
        */
    }

    // Duplication policy for copying global variables
    public class DuplicationPolicy
    {
        private bool one_copy;
        private int i;
        private bool all_copies;
        private bool init_copies;

        private DuplicationPolicy(bool a, int b, bool c, bool d)
        {
            one_copy = a;
            i = b;
            all_copies = c;
            init_copies = d;
        }

        public static DuplicationPolicy OneCopy(int a)
        {
            return new DuplicationPolicy(true, a, false, false);
        }

        public static DuplicationPolicy AllCopies(int a)
        {
            return new DuplicationPolicy(false, a, true, false);
        }

        public static DuplicationPolicy InitCopies(int a)
        {
            return new DuplicationPolicy(false, a, false, true);
        }

        public bool IsOneCopy(out int c) { c = i; return one_copy; }
        public bool IsAllCopies(out int c) { c = i; return all_copies; }
        public bool IsInitCopies(out int c) { c = i; return init_copies; }

    }

}
