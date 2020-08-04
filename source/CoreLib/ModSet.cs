using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;

namespace cba
{
    // TODO: Remove this class!
    /*
    public class ModSetAnalysis : Util.FixedVisitor
    {
        Procedure proc;
        public Dictionary<Procedure, HashSet<Variable>> modSets { get; private set; }
        bool moreProcessingRequired;

        // Update mod sets: This procedure is a copy of BoogieUtil.DoModSetAnalysis
        public static void updateModSet(Program program)
        {
            ModSetAnalysis msa = new ModSetAnalysis();
            msa.DoModSetAnalysis(program);

            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure)
                {
                    Procedure proc = decl as Procedure;
                    proc.Modifies = new List<IdentifierExpr>();
                    
                    if (!msa.modSets.ContainsKey(proc))
                        continue;

                    foreach (Variable v in msa.modSets[proc])
                    {
                        proc.Modifies.Add(new IdentifierExpr(Token.NoToken, v));
                    }
                }
            }
        }

        public void DoModSetAnalysis(Program program)
        {
            modSets = new Dictionary<Procedure, HashSet<Variable>>();

            HashSet<string> implementedProcs = new HashSet<string>();
            foreach (Declaration decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    Implementation impl = (Implementation)decl;
                    implementedProcs.Add(impl.Name);
                }
            }

            foreach (Declaration decl in program.TopLevelDeclarations)
            {
                if (decl is Procedure && !implementedProcs.Contains((decl as Procedure).Name))
                {
                    proc = (Procedure)decl;
                    foreach (IdentifierExpr expr in proc.Modifies)
                    {
                        ProcessVariable(expr.Decl);
                    }
                    proc = null;
                }
            }

            moreProcessingRequired = true;
            while (moreProcessingRequired)
            {
                moreProcessingRequired = false;
                VisitProgram(program);
            }

        }

        public override Implementation VisitImplementation(Implementation node)
        {
            proc = node.Proc;
            Implementation ret = base.VisitImplementation(node);
            proc = null;

            return ret;
        }

        public override Cmd VisitAssignCmd(AssignCmd assignCmd)
        {
            Cmd ret = base.VisitAssignCmd(assignCmd);
            foreach (AssignLhs lhs in assignCmd.Lhss)
            {
                ProcessVariable(lhs.DeepAssignedVariable);
            }
            return ret;
        }
        public override Cmd VisitHavocCmd(HavocCmd havocCmd)
        {
            Cmd ret = base.VisitHavocCmd(havocCmd);
            foreach (IdentifierExpr expr in havocCmd.Vars)
            {
                ProcessVariable(expr.Decl);
            }
            return ret;
        }
        public override Cmd VisitCallCmd(CallCmd callCmd)
        {
            Cmd ret = base.VisitCallCmd(callCmd);
            foreach (var c in callCmd.Outs)
            {
                if (c == null) continue;
                ProcessVariable(c.Decl);
            }

            Procedure callee = callCmd.Proc;
            if (callee != null && modSets.ContainsKey(callee))
            {
                foreach (Variable var in modSets[callee])
                {
                    ProcessVariable(var);
                }
            }
            return ret;
        }

        private void ProcessVariable(Variable var)
        {
            Procedure localProc = proc;
            if (var == null) return;
            if (!(var is GlobalVariable)) return;

            if (!modSets.ContainsKey(localProc))
            {
                modSets[localProc] = new HashSet<Variable>();
            }
            if (modSets[localProc].Contains(var)) return;
            moreProcessingRequired = true;
            modSets[localProc].Add(var);
        }
    }
    */


}
