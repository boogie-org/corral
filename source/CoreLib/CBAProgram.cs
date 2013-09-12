using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using System.IO;
using cba.Util;

namespace cba
{
    // A CBA Program stores a Boogie.Program with some meta information like the
    // name of the main procedure. 
    public class CBAProgram : Program
    {
        // Name of the main procedure
        public string mainProcName;

        // Execution context bound
        // (0 if program is sequential)
        public int contextBound;

        // Captures the interleavings that are allowed in the program
        // (All or some fixed one)
        public ConcurrencyMode mode;

        public CBAProgram(Program p, string main, int bound) :  base()
        {
            tok = p.tok;
            TopLevelDeclarations = p.TopLevelDeclarations;

            mainProcName = main;
            contextBound = bound;
            mode = ConcurrencyMode.AnyInterleaving;
        }

        public CBAProgram(Program p, string main, int bound, ConcurrencyMode mode)
            : base()
        {
            tok = p.tok;
            TopLevelDeclarations = p.TopLevelDeclarations;

            mainProcName = main;
            contextBound = bound;
            this.mode = mode;
        }

        public PersistentCBAProgram getPersistentVersion()
        {
            return new PersistentCBAProgram(this as Program, mainProcName, contextBound, mode);
        }

    }

    public enum ConcurrencyMode { AnyInterleaving, FixedContext };

    // PersistentCBAProgram does not allow
    // in-place modifications to its internal program. 
    public class PersistentCBAProgram : ProgTransformation.PersistentProgram
    {
        // The set of all global variables of the program
        public VarSet allVars
        {
            get
            {
                if (allVarsLazy != null) return allVarsLazy;
                allVarsLazy = VarSet.GetAllVars(base.getProgram());
                return allVarsLazy;
            }
        }

        // To enable lazy computation of allVars
        private VarSet allVarsLazy;
        
        // Name of the main procedure
        public string mainProcName { get; private set; }

        // Execution context bound
        // (0 if program is sequential)
        public int contextBound;

        // Captures the interleavings that are allowed in the program
        // (All or some fixed one)
        public ConcurrencyMode mode;

        public PersistentCBAProgram(Program p, string main, int bound) : base(p)
        {
            mainProcName = main;
            contextBound = bound;
            mode = ConcurrencyMode.AnyInterleaving;
            // allVarsLazy = null;
            allVarsLazy = VarSet.GetAllVars(p);
        }

        public PersistentCBAProgram(Program p, string main, int bound, ConcurrencyMode mode)
            : base(p)
        {
            mainProcName = main;
            contextBound = bound;
            this.mode = mode;
            // allVarsLazy = null;
            allVarsLazy = VarSet.GetAllVars(p);
        }

        public CBAProgram getCBAProgram()
        {
            return new CBAProgram(base.getProgram(), mainProcName, contextBound, mode);
        }

    }
}
