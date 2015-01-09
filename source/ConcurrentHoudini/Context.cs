using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using bpl = Microsoft.Boogie;

namespace ConcurrentHoudini
{
    class ConcurrentHoudiniException : Exception
    {
        public ConcurrentHoudiniException(string s) : base(s) { }
    }

    /**
     * This class serves the following purposes:
     * (1) Readonly data memebrs in the class are special names used by concurrent houdini and corral to refer to procedures
     *     and other labels in input programs.
     * (2) Holds some counters that lets us generate unique labels throughout the transformation.
     * (3) Provides thin interface functions for LINQ queries
     **/
    class Context
    {
        // ////////////////////////////////////////////////////////////////////
        // Labels with special meaning in the input program and annotations / 
        // annotation templates
        // ////////////////////////////////////////////////////////////////////

        // ///////////////// Corral defined labels ////////////////////////////
        // Attributes
        // template variables may be additionally labelled as templates for local variables, global variables, or parameters specifically. 
        // If nothing is mentioned, a template variables matches all variables of the correct type.
        public string templateAttr { get; private set; }
        public string globalAttr { get; private set; }
        public string localAttr { get; private set; }
        public string inParamAttr { get; private set; }
        public string outParamAttr { get; private set; }
        // Procedure names
        // These procedures begin and end an atomic block respectively.
        public string corralTidProc { get; private set; }
        public string atomicBegProc { get; private set; }
        public string atomicEndProc { get; private set; }
        // This procedure can be used to obtain the current threads thread id.       
        public string tidFunc { get; private set; }
        // This procedure tells corral to insert a context switch.
        public string yieldProc { get; private set; }
        // ///////////////// Concurrent Houdini defined labels ////////////////
        // Shared Variable
        // Attributes
        public string preCondAttr { get; private set; }
        public string postCondAttr { get; private set; }
        public string envGuaranteeAttr { get; private set; }
        public string envRelyAttr { get; private set; }
        public string invariantAttr { get; private set; }

        // The name of the entry function. This is mutable.
        // This is also updated whenever fake entry functions are created.
        public string entryFunc { get; set; }
        // ////////////////////////////////////////////////////////////////////
        // Labels used to conjecture a proof.
        // ////////////////////////////////////////////////////////////////////

        // Attributes
        public string threadEntryAttr { get; private set; }
        public string singleInstAttr { get; private set; }
        public string threadAttr { get; private set; }
        public string yieldAttr { get; private set; }
        public string specialAttr { get; private set; }
        // Procedure Names
        // This special procedure is used to conjecture constraints on reachable states in the program
        public string rProc { get; private set; }
        public string guaranteeConstraintSuffix { get; private set; }
        public string idempotentConstraintSuffix { get; private set; }


        // Used primarily by ProofExpander
        // Local variables
        // Refers to a thread's tid
        public string tid { get; private set; }
        // Refers to some other thread's tid. 
        public string tidOther { get; private set; }
        // Shared variables
        // Used to track whether we're in an atomic block
        public string atomicBlockVar { get; private set; }
        // _at_call variables are used to refer to the value of shared 
        // variables at the head of a procedure 
        public string atCallSuffix { get; private set; }
        public string shadowVarSuffix { get; private set; }
        // mhpVars are used to track what thread instances may be running in parallel to a thread
        public string mhpSuffix { get; private set; }
        public string mhpAttr { get; private set; }
        public string mhpTypeName { get; private set; }
        public string mhpNone { get; private set; }
        public string mhpOne { get; private set; }
        public string mhpMany { get; private set; }

        public string assertsPassedVarName { get; private set; }
        public string fakeMainPrefix { get; private set; }

        // This is used only in the laballedprogram
        public string tidPlacedholderVar { get; private set; }

        // ////////////////////////////////////////////////////////////////////
        // Counters and Expander strings to obtain unique labels 
        // ////////////////////////////////////////////////////////////////////

        // Each thread gets a unique thread id.
        // Used when splitting procedures
        private string threadNameStub;
        public string originalThreadAttr;
        private int numThreads;
        public string getSplitProcName(string procName)
        {
            return (procName == entryFunc)? procName : threadNameStub + numThreads + procName;
        }
        public bpl.QKeyValue getThreadAttr(string threadName)
        {
            var paramList = new List<object>();
            paramList.Add(threadName);
            return new bpl.QKeyValue(bpl.Token.NoToken, threadAttr, paramList, null);
        }
        public bpl.QKeyValue originalProcAttr(string procName)
        {
            var paramList = new List<object>();
            paramList.Add(procName);
            return new bpl.QKeyValue(bpl.Token.NoToken, originalThreadAttr, paramList, null);
        }

        public void nextThread()
        {
            numThreads++;
        }
        public string readThreadName(bpl.Procedure proc)
        {
            return getAttrParams(proc.Attributes, threadAttr)[0] as string;            
        }

        // Each yield statement in the program gets a unique label.
        public int numYield { get; private set; }
        public bpl.QKeyValue getNextYieldLabel()
        {
            var paramList = new List<object>();
            paramList.Add(new bpl.LiteralExpr(bpl.Token.NoToken, Microsoft.Basetypes.BigNum.FromInt(numYield++)));
            return new bpl.QKeyValue(bpl.Token.NoToken, yieldAttr, paramList, null);
        }
        public bpl.QKeyValue getAssumeAttrFromCmd(bpl.Cmd cmd)
        {
            if (!isYield(cmd) && !isR(cmd)) return null;
            var attr = (cmd as bpl.CallCmd).Attributes;
            while(attr != null)
            {
                if (attr.Key == yieldAttr)
                {
                    var num = (attr.Params[0] as bpl.LiteralExpr).asBigNum;
                    var paramList = new List<object>();
                    paramList.Add(new bpl.LiteralExpr(bpl.Token.NoToken, num));
                    return new bpl.QKeyValue(bpl.Token.NoToken, invariantAttr, paramList, null);
                }
                attr = attr.Next;
            }
            return null;
        }
        public int readYieldLabel(bpl.Cmd cmd)
        {
            var callCmd = cmd as bpl.CallCmd;
            if (callCmd == null)
                throw new ConcurrentHoudiniException("[Context::readYieldLabel] Not a call command");
            var args = getAttrParams(callCmd.Attributes, yieldAttr);
            if (args.Count() < 1 || !(args[0] is bpl.LiteralExpr))
                throw new ConcurrentHoudiniException("[Context::readYieldLabel] Ill formed parameter");
            var numExpr = args[0] as bpl.LiteralExpr;
            return numExpr.asBigNum.ToInt;
        }
        public int readInvariantLabel(bpl.Cmd cmd)
        {
            var callCmd = cmd as bpl.CallCmd;
            if (callCmd == null)
                throw new ConcurrentHoudiniException("[Context::readInvariantLabel] Not a call command");
            var args = getAttrParams(callCmd.Attributes, invariantAttr);
            if (args.Count() < 1 || !(args[0] is bpl.LiteralExpr))
                throw new ConcurrentHoudiniException("[Context::readInvariantLabel] Ill formed parameter");
            var numExpr = args[0] as bpl.LiteralExpr;
            return numExpr.asBigNum.ToInt;
        }

        // Each proposed constraint in the program must be guarded by an "existential" boolean variable.
        private string existsConstName;
        private string existsConstAttr;
        private int numExistsConst;
        public List<bpl.Constant> existsConsts { get; private set; }
        public bpl.Expr guardWithExistConst(bpl.Expr expr)
        {
            var existsConst = new bpl.Constant(bpl.Token.NoToken, new bpl.TypedIdent(bpl.Token.NoToken, existsConstName + (numExistsConst++), bpl.Type.Bool));
            existsConsts.Add(existsConst);
            return bpl.NAryExpr.Imp(new bpl.IdentifierExpr(bpl.Token.NoToken, existsConst), expr);
        }
        public bpl.Declaration getExistConstDeclaration(bpl.Variable vbl)
        {
            var res = new bpl.Constant(bpl.Token.NoToken, new bpl.TypedIdent(bpl.Token.NoToken, vbl.Name, vbl.TypedIdent.Type), false);
            var paramList = new List<object>();
            paramList.Add(new bpl.LiteralExpr(bpl.Token.NoToken, true));
            var attr = new bpl.QKeyValue(bpl.Token.NoToken, existsConstAttr, paramList, null);
            attr.Next = res.Attributes;
            res.Attributes = attr;
            return res;
        }
        public void emptyExistsConsts()
        {
            existsConsts = new List<bpl.Constant>();
        }

        // Obtain unique labels for blocks for various purposes
        private string uniqueBlockPrefix;
        private int uniqueBlockNum;
        private string blockLabelSuffix;
        private int passNum;
        private int numExtendedBlocksCreated;
        public void resetExtendedBlockCounter()
        {
            numExtendedBlocksCreated = 0;
        }
        public void resetPass()
        {
            passNum = 0;
        }
        public void nextPass()
        {
            passNum++;
        }
        public string getNextExtendedBlockLabel(string curLabel)
        {
            if (curLabel == null || curLabel == "")
                throw new ConcurrentHoudiniException("[Context::getNextExtendedBlockCounter] Must pass in non empty current Label to extend");
            string res = numExtendedBlocksCreated == 0 ? curLabel : curLabel + "_" +passNum + blockLabelSuffix + numExtendedBlocksCreated;
            numExtendedBlocksCreated++;
            return res;
        }
        public string getNextUniqueBlockLabel()
        {
            return uniqueBlockPrefix + (uniqueBlockNum++);
        }


        
        // ////////////////////////////////////////////////////////////////////
        // Interface functions for queries on program AST and some handy 
        // constructors
        // ////////////////////////////////////////////////////////////////////
        // A generic function that checks for attribute key 'key' in attribute list 'attr'.
        private bool hasAttrKey(bpl.QKeyValue attr, string key)
        {
            while (attr != null)
            {
                if (attr.Key == key)
                    return true;
                attr = attr.Next;
            }
            return false;
        }
        private IList<object> getAttrParams(bpl.QKeyValue attr, string key)
        {
            while (attr != null)
            {
                if (attr.Key == key)
                    return attr.Params;
                attr = attr.Next;
            }
            return null;
        }

        // procedure attributes
        public bool isThreadEntry(bpl.Declaration decl)
        {
            if (!(decl is bpl.Procedure))
                return false;
            if (hasAttrKey(decl.Attributes, threadEntryAttr))
                return true;
            else
                return false;
        }
        public bool isSingleInstanceThread(bpl.Declaration decl)
        {
            if (!(decl is bpl.Procedure))
                return false;
            if (!isThreadEntry(decl))
                return false;
            if (hasAttrKey(decl.Attributes, singleInstAttr))
                return true;
            else
                return false;
        }

        // Asynchronous calls
        public bool isAsyncCall(bpl.Cmd cmd)
        {
            if(!(cmd is bpl.CallCmd))
                return false;
            var callCmd = cmd as bpl.CallCmd;
            return callCmd.IsAsync;
        }
        public bool isSyncCall(bpl.Cmd cmd)
        {
            if (!(cmd is bpl.CallCmd))
                return false;
            var callCmd = cmd as bpl.CallCmd;
            return !callCmd.IsAsync;
        }
        
        // Templatized variables
        public bool isTemplate(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return hasAttrKey(vbl.Attributes, templateAttr);
        }
        public bool isGlobal(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return hasAttrKey(vbl.Attributes, globalAttr);
        }
        public bool isLocal(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return hasAttrKey(vbl.Attributes, localAttr);
        }
        public bool isInParam(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return hasAttrKey(vbl.Attributes, inParamAttr);
        }
        public bool isOutParam(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return hasAttrKey(vbl.Attributes, outParamAttr);
        }
        public bool isAllTypes(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return isTemplate(vbl) && !isGlobal(vbl) && !isInParam(vbl) && !isOutParam(vbl) && !isLocal(vbl);
        }
        public bool isNonTemplate(bpl.Variable vbl)
        {
            if (vbl == null) return false;
            return !hasAttrKey(vbl.Attributes, templateAttr);
        }
        public bool isTemplate(bpl.Procedure proc)
        {
            if (proc == null) return false;
            return hasAttrKey(proc.Attributes, templateAttr);
        }
        public bool isNonTemplate(bpl.Procedure proc)
        {
            if (proc == null) return false;
            return !hasAttrKey(proc.Attributes, templateAttr);
        }

        //Other special variables
        public bool isAtomicBlockVar(bpl.Variable variable)
        {
            return variable != null && variable is bpl.GlobalVariable && variable.Name == atomicBlockVar;
        }
        public bool isTidVar(bpl.Variable variable)
        {
            return variable != null && variable is bpl.GlobalVariable && variable.Name == tid;
        }
        public bool isTidOtherVar(bpl.Variable variable)
        {
            return variable != null && variable is bpl.GlobalVariable && variable.Name == tidOther;
        }
        
        // Special procedures
        public bool isMain(bpl.Declaration decl)
        {
            return
                decl != null && (
                    (decl is bpl.Implementation && (decl as bpl.Implementation).Name == entryFunc) ||
                    (decl is bpl.Procedure && (decl as bpl.Procedure).Name == entryFunc));
        }
        public bool isRProc(bpl.Declaration decl)
        {
            return (decl is bpl.Procedure) && ((decl as bpl.Procedure).Name == rProc);
        }
        public bool isYieldProc(bpl.Declaration decl)
        {
            return (decl is bpl.Procedure) && ((decl as bpl.Procedure).Name == yieldProc);
        }
        public bool isAtomicBegProc(bpl.Declaration decl)
        {
            return decl != null && decl is bpl.Procedure && (decl as bpl.Procedure).Name == atomicBegProc;
        }
        public bool isAtomicEndProc(bpl.Declaration decl)
        {
            return decl != null && decl is bpl.Procedure && (decl as bpl.Procedure).Name == atomicEndProc;
        }
        public bool isThreadEntry(bpl.Procedure proc)
        {
            if (proc == null) return false;
            return hasAttrKey(proc.Attributes, threadEntryAttr);
        }
        public bool isThreadEntry(bpl.Implementation impl)
        {
            if (impl == null) return false;
            return isThreadEntry(impl.Proc);
        }
        
        // Special procedure calls
        public bool isR(bpl.Cmd cmd)
        {
            if (cmd == null) return false;
            if (!(cmd is bpl.CallCmd)) return false;
            return (cmd as bpl.CallCmd).callee == rProc;
        }
        public bool isYield(bpl.Cmd cmd)
        {
            if (cmd == null) return false;
            if (!(cmd is bpl.CallCmd)) return false;
            return (cmd as bpl.CallCmd).callee == yieldProc;
        }
        public bool isAtomicBeg(bpl.Cmd cmd)
        {
            if (cmd == null) return false;
            if (!(cmd is bpl.CallCmd)) return false;
            return (cmd as bpl.CallCmd).callee == atomicBegProc;
        }
        public bool isAtomicEnd(bpl.Cmd cmd)
        {
            if (cmd == null) return false;
            if (!(cmd is bpl.CallCmd)) return false;
            return (cmd as bpl.CallCmd).callee == atomicEndProc;
        }
        public bool isTidFunc(bpl.Expr expr)
        {
            if (!(expr is bpl.NAryExpr)) return false;
            var naryExpr = expr as bpl.NAryExpr;
            if (naryExpr.Fun is bpl.FunctionCall && (naryExpr.Fun as bpl.FunctionCall).Func.Name == tidFunc)
                return true;
            else
                return false;
        }
        
        // Different types of ensure conditions
        public bool isPreRequire(bpl.Requires ens)
        {
            if (ens == null) return false;
            return hasAttrKey(ens.Attributes, preCondAttr);
        }
        public bool isPostEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return hasAttrKey(ens.Attributes, postCondAttr);
        }
        public bool isInvariantEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return hasAttrKey(ens.Attributes, invariantAttr);
        }
        public bool isEnvGuaranteeEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return hasAttrKey(ens.Attributes, envGuaranteeAttr);
        }
        public bool isEnvRelyEnsure(bpl.Ensures req)
        {
            if (req == null) return false;
            return hasAttrKey(req.Attributes, envRelyAttr);
        }
        public bool isNonPreRequire(bpl.Requires ens)
        {
            if (ens == null) return false;
            return !hasAttrKey(ens.Attributes, preCondAttr);
        }
        public bool isNonPostEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return !hasAttrKey(ens.Attributes, postCondAttr);
        }
        public bool isNonInvariantEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return !hasAttrKey(ens.Attributes, invariantAttr);
        }
        public bool isNonEnvGuaranteeEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return !hasAttrKey(ens.Attributes, envGuaranteeAttr);
        }
        public bool isNonEnvRelyEnsure(bpl.Ensures ens)
        {
            if (ens == null) return false;
            return !hasAttrKey(ens.Attributes, envRelyAttr);
        }
        

        // mhp var info
        public bool isMhpVar(bpl.Declaration decl)
        {
            if (decl == null || !(decl is bpl.GlobalVariable)) return false;
            var glbl = decl as bpl.GlobalVariable;
            if (getAttrParams(glbl.Attributes, mhpAttr) == null) return false;
            return true;
        }
        public bool isNoneInst(bpl.Declaration decl)
        {
            if(decl == null || !(decl is bpl.Constant)) return false;
            var constant = decl as bpl.Constant;
            if (constant.Name == mhpNone) return true;
            else return false;
        }
        public bool isOneInst(bpl.Declaration decl)
        {
            if (decl == null || !(decl is bpl.Constant)) return false;
            var constant = decl as bpl.Constant;
            if (constant.Name == mhpOne) return true;
            else return false;
        }

        // Constructors
        public bpl.Ensures getEnvGuaranteeEnsure(bpl.Expr expr)
        {
            return new bpl.Ensures(bpl.Token.NoToken, false, expr, null, new bpl.QKeyValue(bpl.Token.NoToken, envGuaranteeAttr, new List<object>(), null));
        }
        public bpl.Ensures getEnvRelyEnsure(bpl.Expr expr)
        {
            return new bpl.Ensures(bpl.Token.NoToken, false, expr, null, new bpl.QKeyValue(bpl.Token.NoToken, envRelyAttr, new List<object>(), null));
        }
        
        public bpl.Requires getPreRequires(bpl.Expr expr)
        {
            return new bpl.Requires(bpl.Token.NoToken, false, expr, null, new bpl.QKeyValue(bpl.Token.NoToken, preCondAttr, new List<object>(), null));
        }
        public bpl.Ensures getPostEnsure(bpl.Expr expr)
        {
            return new bpl.Ensures(bpl.Token.NoToken, false, expr, null, new bpl.QKeyValue(bpl.Token.NoToken, postCondAttr, new List<object>(), null));
        }
        public bpl.Ensures getInvEnsure(bpl.Expr expr)
        {
            return new bpl.Ensures(bpl.Token.NoToken, false, expr, null, new bpl.QKeyValue(bpl.Token.NoToken, invariantAttr, new List<object>(), null));
        }
        public bpl.QKeyValue getThreadEntryAttr() 
        {
            return new bpl.QKeyValue(bpl.Token.NoToken, threadEntryAttr, new List<object>(), null);
        }
        public bpl.QKeyValue getSingleInstanceAttr()
        {
            return new bpl.QKeyValue(bpl.Token.NoToken, singleInstAttr, new List<object>(), null);
        }
        public bpl.Formal getAtCallVar(bpl.GlobalVariable glbl)
        {
            if (glbl == null) return null;
            return new bpl.Formal(bpl.Token.NoToken, new bpl.TypedIdent(bpl.Token.NoToken, glbl.Name + atCallSuffix, glbl.TypedIdent.Type), true);
        }
        public bpl.GlobalVariable getMHPVar(string procName, bpl.TypeCtorDecl typeDecl)
        {
            var res = new bpl.GlobalVariable(bpl.Token.NoToken, new bpl.TypedIdent(bpl.Token.NoToken, procName + mhpSuffix, new bpl.CtorType(bpl.Token.NoToken, typeDecl, new List<Microsoft.Boogie.Type>())));
            var attrs = new List<object>();
            attrs.Add(procName);
            res.Attributes = new bpl.QKeyValue(bpl.Token.NoToken, mhpAttr, attrs, null);
            return res;
        }
        public string getShadowVarName(bpl.Variable glbl)
        {
            return glbl.Name + shadowVarSuffix;
        }
        public string getFakeMainName(string mainName)
        {
            return fakeMainPrefix + mainName;
        }
        public string getGuaranteeConstraintProcName(string threadName)
        {
            return threadName + guaranteeConstraintSuffix;
        }
        public string getIdempotentConstraintProcName(string threadName)
        {
            return threadName + idempotentConstraintSuffix;
        }

        public string readMhpVarProcName(bpl.Declaration decl)
        {
            if (!isMhpVar(decl))
                return null;
            var someNameIcantThinkUpRightNow = getAttrParams(decl.Attributes, mhpAttr);
            if (someNameIcantThinkUpRightNow.Count() > 0)
                return someNameIcantThinkUpRightNow[0] as string;
            else
                return null;
        }
        // ////////////////////////////////////////////////////////////////////
        // Constructor. Counter initialization.
        // ////////////////////////////////////////////////////////////////////
        public Context()
        {
            templateAttr = "template";
            globalAttr = "shared";
            localAttr = "local";
            inParamAttr = "in";
            outParamAttr = "out";
            corralTidProc = "corral_getThreadID";
            atomicBegProc = "corral_atomic_begin";
            atomicEndProc = "corral_atomic_end";
            tidFunc = "CHThreadId";
            yieldProc = "corral_yield";
            envGuaranteeAttr = "env";
            envRelyAttr = "rely";
            preCondAttr = "pre";
            postCondAttr = "post";
            invariantAttr = "inv";
            specialAttr = "special";
            entryFunc = "main";
            fakeMainPrefix = "ConcurrentHoudini_";
            assertsPassedVarName = "CHAssertsPassed";
            tidPlacedholderVar = "tidPlaceholder";


            threadEntryAttr = "thread_entry";
            singleInstAttr = "single_instance";
            threadAttr = "thread_num";
            rProc = "houdini_conjecture";
            guaranteeConstraintSuffix = "_guarantee_constraint";
            idempotentConstraintSuffix = "_idempotent_constraint";
            tid = "houdini_tid";
            tidOther = "houdini_tid_other";
            atomicBlockVar = "houdini_in_atomic";
            atCallSuffix = "_at_call";
            mhpSuffix = "_numInstances";
            mhpAttr = "numInstances";
            mhpTypeName = "mhpAbstractCounter";
            mhpNone = "noneInst";
            mhpOne = "oneInst";
            mhpMany = "manyInst";
            shadowVarSuffix = "_shadow";

            threadNameStub = "corralThread";
            originalThreadAttr = "original_proc_name";
            numThreads = 0;
            yieldAttr = "chyield";
            numYield = 0;
            existsConstName = "propose";
            existsConstAttr = "existential";
            numExistsConst = 0;
            existsConsts = new List<bpl.Constant>();
            blockLabelSuffix = "RGPE";
            numExtendedBlocksCreated = 0;
            passNum = 0;
            uniqueBlockPrefix = "RGPEUniqueBlock";
            uniqueBlockNum = 0;
        }
        // Copy constructor. copy over the counter values


    }
}
