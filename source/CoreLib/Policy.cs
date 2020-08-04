using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;

namespace cba
{
    // Dictates how the instrumentation is to be carried out.
    //    o global variables to instrument
    //    o The execution context bound to be followed
    //    o Should the instrumented procedures have an inline attribute set?
    public class InstrumentationPolicy
    {
        
        private HashSet<string> globalsToInstrument;
        private HashSet<string> procsWithImpl;
        private HashSet<string> asyncProcs;
        private HashSet<Tuple<string, string>> recursiveProcs;

        // The execution context bound
        public int executionContextBound { get; private set; }

        // Name of the atomic_begin and atomic_end procedures
        private string atomicBeginProcName;
        private string atomicEndProcName;

        // Name of the "is_reachable" procedure
        private string assertNotReachableName;

        // Name of the procedure that returns current thread id
        private string getThreadIDName;

        // Concurrency mode
        public ConcurrencyMode mode { get; private set; }

        public InstrumentationPolicy(int K, HashSet<string> glob, HashSet<string> procsWithImpl, HashSet<string> asyncProcs, HashSet<Tuple<string, string>> recursiveProcs, ConcurrencyMode mode) 
        {
            executionContextBound = K;
            globalsToInstrument = glob;
            this.procsWithImpl = procsWithImpl;
            this.asyncProcs = asyncProcs;
            this.recursiveProcs = recursiveProcs;
            this.mode = mode;

            atomicBeginProcName = LanguageSemantics.atomicBeginProcName();
            atomicEndProcName = LanguageSemantics.atomicEndProcName();
            assertNotReachableName = LanguageSemantics.assertNotReachableName();
            getThreadIDName = LanguageSemantics.getThreadIDName();
        }

        public bool instrument(Declaration decl)
        {
            if (decl is GlobalVariable)
                return instrument((GlobalVariable)decl);

            if (decl is Procedure)
                return instrument((Procedure)decl);

            if (decl is Implementation)
                return instrument((Implementation)decl);

            return false;
            //throw new InternalError("Incorrect type passed to instrument");
        }

        public bool instrument(GlobalVariable g)
        {
            return globalsToInstrument.Contains(g.Name);
        }

        public bool instrumentGlobalVar(string g)
        {
            return globalsToInstrument.Contains(g);
        }

        public bool instrument(Procedure p)
        {
            return true;
            //return procsWithoutImpl.Contains(p.Name);
        }

        public bool instrument(Implementation im)
        {
            return true;
            //return procsWithoutImpl.Contains(im.Name);
        }

        public bool procHasImpl(string procName)
        {
            return procsWithImpl.Contains(procName);
        }

        // Is this a backedge in the call graph (only true when the call is recursive)
        public bool isRecCall(string from, string to)
        {
            return recursiveProcs.Contains(Tuple.Create(from, to));
        }

        // Is the procedure ever called asynchronously?
        public bool isProcAsync(string procName)
        {
            return asyncProcs.Contains(procName);
        }

        // Is this command "call atomic_begin()"
        public bool isAtomicBegin(Cmd cmd)
        {
            return BoogieUtil.checkIsCall(atomicBeginProcName, cmd);

        }

        // Is this command "call atomic_end()"
        public bool isAtomicEnd(Cmd cmd)
        {
            return BoogieUtil.checkIsCall(atomicEndProcName, cmd);

        }

        // Is this command "call assert_proc()"
        public bool isAssertCmd(Cmd cmd)
        {
            return BoogieUtil.checkIsCall(assertNotReachableName, cmd);
        }

        // Is this command "call getThreadID()"
        public bool isGetThreadID(Cmd cmd)
        {
            return BoogieUtil.checkIsCall(getThreadIDName, cmd);
        }

        // Is this command a yield?
        public bool isYield(Cmd cmd)
        {
            return cmd is YieldCmd;
        }

        public bool isFixedContextProc(Cmd cmd, ref int i)
        {
            var t = InstrumentationConfig.getFixedContextValue(cmd);
            if(t != -1) i = t;

            return (t != -1);
        }

        public bool isFixedRaiseExceptionProc(Cmd cmd)
        {
            return InstrumentationConfig.isFixedRaiseExceptionProc(cmd);
        }

        public bool hasGlobalVarsToInstrument(Absy exp)
        {
            GlobalVarsUsed usesg = new GlobalVarsUsed();

            usesg.Visit(exp);

            // If any used variable is also modified then return true
            if (usesg.Used.Any(x => globalsToInstrument.Contains(x)))
                return true;

            return false;
        }

        public bool hasOldGlobalVarsToInstrument(Absy exp)
        {
            GlobalVarsUsed usesg = new GlobalVarsUsed();

            usesg.Visit(exp);

            // If any used variable is also modified then return true
            if (usesg.oldVarsUsed.Any(x => globalsToInstrument.Contains(x)))
                return true;

            return false;
        }

        // Prints the policy 
        public void print(TokenTextWriter writer)
        {
            if (writer == null)
                return;

            writer.WriteLine("=================================");
            writer.WriteLine("The instrumentation policy:");
            writer.Write("  Globals to instrument: ");

            foreach (var s in globalsToInstrument)
            {
                writer.Write("{0}  ", s);
            }

            writer.WriteLine();

            /*
            writer.Write("  Procedures without implementation: ");
            foreach (var s in procsWithoutImpl)
            {
                writer.Write("{0}  ", s);
            }
            writer.WriteLine();

            writer.WriteLine("  Atomic-block procedures: {0}  {1}", atomicBeginProcName, atomicEndProcName);
            writer.WriteLine("  Assertion procedure: {0}", assertNotReachableName);
            */
            writer.WriteLine("=================================");
        }


    }

}
