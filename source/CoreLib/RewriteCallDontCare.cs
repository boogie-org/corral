using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using System.IO;
using ProgTransformation;

namespace cba
{
    // This class rewrites a call command if it has "don't cares".
    // Replaces
    //    call * := foo(a,*,b)
    // with
    //    // havoc l2;
    //    call l1 := foo(a,l2,b)
    // where l1 and l2 are new local variables (we actually only need one per type)
    // This rewriting is required because Boogie's Inliner has a bug that makes it
    // crash while inlining calls with don't care expressions.
    //
    // This class needs a resolved program as input. Because for "*" arguments, the type
    // has to be looked up from the type of the called procedure.
    public class RewriteCallDontCares : FixedVisitor
    {
        // A set of local variables that we may want to add to the current
        // implementation being visited. T
        private List<LocalVariable> localsToAdd;

        // A counter for generating local variables with different names
        private int localVarCount;

        public RewriteCallDontCares()
        {
            localVarCount = 0;
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            localsToAdd = new List<LocalVariable>();
            node = base.VisitImplementation(node);
            localsToAdd.Iterate(x => node.LocVars.Add((Variable)x));

            return node;
        }

        // Return a new local variable
        private LocalVariable getNewLocal(Microsoft.Boogie.Type type)
        {
            string name = "dontcare_dummy_var_" + (localVarCount.ToString());
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
                    lcmds.Add(cmd);
                    continue;
                }

                CallCmd ccmd = cmd as CallCmd;

                // If the call command doesn't have any don't cares, then no need
                // to instrument
                bool found = false;
                found = ccmd.Outs.Any(x => (x == null));
                found = found || ccmd.Ins.Any(x => (x == null));

                if (!found)
                {
                    lcmds.Add(cmd);
                    continue;
                }

                // Get ready to instrument

                // This is the list of locals to havoc (for the arguments)
                List<IdentifierExpr> havocArgs = new List<IdentifierExpr>();

                // Go through the arguments of the call
                for (int i = 0, n = ccmd.Ins.Count; i < n; i++)
                {

                    if (ccmd.Ins[i] == null)
                    {
                        Variable lvar = getNewLocal(ccmd.Proc.InParams[i].TypedIdent.Type);
                        havocArgs.Add(new IdentifierExpr(Token.NoToken, lvar));
                        ccmd.Ins[i] = Expr.Ident(lvar);
                    }
                }

                /*
                // havoc locals -- not needed; because locals are uninitialized
                if (havocArgs.Length != 0)
                {
                    lcmds.Add(new HavocCmd(Token.NoToken, havocArgs));
                }
                */

                // Go through the return values
                for (int i = 0, n = ccmd.Outs.Count; i < n; i++)
                {
                    if (ccmd.Outs[i] == null)
                    {
                        Variable lvar = getNewLocal(ccmd.Proc.OutParams[i].TypedIdent.Type);
                        ccmd.Outs[i] = new IdentifierExpr(Token.NoToken, lvar);
                    }
                }

                // the new call command
                lcmds.Add(ccmd);

            }

            block.Cmds = lcmds;

            return block;
        }
    }

}
