using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace cba
{
    /* Global config -- do not change default values here. Change in runCBA() */
    public static class GlobalConfig
    {
        // Is the program single threaded?
        public static bool isSingleThreaded = false;

        public static bool useLocalVariableAbstraction = false;

        // Generate a C Trace for concurrency explorer
        public static bool genCTrace = false;

        // Recusion bound
        public static int recursionBound = 2;

        // The refinement algorithm to use
        public static char[] refinementAlgo = { 't', 't', 't', 't'};

        // For inferring contracts
        public static ContractInfer InferPass = null;

        // Print the instrumented bpl file
        public static bool printInstrumented
        {
            get
            {
                return InstrumentationConfig.printInstrumented;
            }
            set
            {
                InstrumentationConfig.printInstrumented = value;
            }
        }

        // Name of the instrumented bpl file to print
        public static string instrumentedFile
        {
            get
            {
                return InstrumentationConfig.instrumentedFile;
            }
            set
            {
                InstrumentationConfig.instrumentedFile = value;
            }
        }

        // static inlining?
        public static int staticInlining = 0;

        // Generic annotations
        public static List<string> annotations = new List<string>();

        // catch all exceptions?
        public static bool catchAllExceptions = false;

        // Use ArrayTheory in the boogie verifier
        public static ArrayTheoryOptions useArrayTheory = ArrayTheoryOptions.WEAK;

        // Used for dumping out the final Z3 query
        public static string explainQuantifiers = null;

        // Hint for when to start conserving memory
        public static int memLimit
        {
            get
            {
                return ProgTransformation.PersistentProgram.memLimit;
            }
            set
            {
                ProgTransformation.PersistentProgram.memLimit = value;
            }
        }

        // For debugging
        public static bool addRaiseException
        {
            get
            {
                return InstrumentationConfig.addRaiseException;
            }
            set
            {
                InstrumentationConfig.addRaiseException = value;
            }
        }

        // For debugging: 0 (None), 1 (Some), 2 (All)
        public static int addInvariants
        {
            get
            {
                return InstrumentationConfig.addInvariants;
            }
            set
            {
                InstrumentationConfig.addInvariants = value;
            }
        }

        // Print all traces produced during the abstraction-refinement loop
        public static bool printAllTraces = false;

        // Timeout (0 means infinity)
        public static int timeOut = 0;

        // Starting time
        public static DateTime corralStartTime;

        public static int getTimeLeft()
        {
            if (timeOut == 0) return 0;
            var ret = timeOut - (int) ((DateTime.Now - corralStartTime).TotalSeconds);
            if (ret <= 0) ret = 1; // KLM: prevent ret from being negative
            // if (ret == 0) ret = 1;
            return ret;
        }

        public static bool timeOutReached()
        {
            if (timeOut == 0) return false;
            if ((DateTime.Now - corralStartTime).TotalSeconds >= timeOut)
                return true;
            return false;
        }

        public static bool cadeTiming = false;
    }
}
