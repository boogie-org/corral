using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cba.Util;
using cba;
using Microsoft.Boogie.Houdini;
using Microsoft.Boogie;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using Microsoft.Boogie.GraphUtil;

public class CbaLiveVariableAnalysis
{
    public static void ClearLiveVariables(Implementation impl)
    {
        Contract.Requires(impl != null);
        foreach (Block/*!*/ block in impl.Blocks)
        {
            Contract.Assert(block != null);
            block.liveVarsBefore = null;
        }
    }

    public static HashSet<Variable> GetLiveVarsAfter(Program program, Implementation impl, Block block, int cmdPos)
    {
        var liveVarsAfter = initLiveVars(block, impl, program);
        for (int i = block.Cmds.Count - 1; i > cmdPos; i--)
        {
            var cc = block.Cmds[i] as CallCmd;
            if (cc != null)
            {
                PropagateCall(cc, liveVarsAfter, program);
                continue;
            }
            Propagate(block.Cmds[i], liveVarsAfter, program == null);
        }
        return liveVarsAfter;
    }

    public static void ComputeLiveVariables(Implementation impl, Program program)
    {
        Contract.Requires(impl != null);
        //Microsoft.Boogie.Helpers.ExtraTraceInformation("Starting live variable analysis");
        Graph<Block> dag = new Graph<Block>();
        dag.AddSource(cce.NonNull(impl.Blocks[0])); // there is always at least one node in the graph
        foreach (Block b in impl.Blocks)
        {
            GotoCmd gtc = b.TransferCmd as GotoCmd;
            if (gtc != null)
            {
                Contract.Assume(gtc.labelTargets != null);
                foreach (Block/*!*/ dest in gtc.labelTargets)
                {
                    Contract.Assert(dest != null);
                    dag.AddEdge(dest, b);
                }
            }
        }

        IEnumerable<Block> sortedNodes = dag.TopologicalSort();
        foreach (Block/*!*/ block in sortedNodes)
        {
            Contract.Assert(block != null);
            HashSet<Variable/*!*/>/*!*/ liveVarsAfter = initLiveVars(block, impl, program);

            List<Cmd> cmds = block.Cmds;
            int len = cmds.Count;
            for (int i = len - 1; i >= 0; i--)
            {
                var cc = cmds[i] as CallCmd;
                if (cc != null)
                {
                    PropagateCall(cc, liveVarsAfter, program);
                    continue;
                }
                Propagate(cmds[i], liveVarsAfter, program == null);
            }

            block.liveVarsBefore = liveVarsAfter;

        }
    }

    private static void PropagateCall(CallCmd cc, HashSet<Variable> liveVarsAfter, Program program)
    {
        // globals U in-params U (after - out-params)
        cc.Outs.Where(ie => ie != null).Iter(ie => liveVarsAfter.Remove(ie.Decl));
        if (program != null)
        {
            program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Iter(v => liveVarsAfter.Add(v));
        }

        VariableCollector/*!*/ collector = new VariableCollector();
        cc.Ins.Where(e => e != null).Iter(e => collector.Visit(e));
        if (program == null)
        {
            liveVarsAfter.UnionWith(collector.usedVars.Where(v => v is LocalVariable || v is Formal));
        }
        else
        {
            liveVarsAfter.UnionWith(collector.usedVars);
        }
    }

    private static HashSet<Variable> initLiveVars(Block block, Implementation impl, Program program)
    {
        HashSet<Variable/*!*/>/*!*/ liveVarsAfter = new HashSet<Variable/*!*/>();
        if (block.TransferCmd is GotoCmd)
        {
            GotoCmd gotoCmd = (GotoCmd)block.TransferCmd;
            if (gotoCmd.labelTargets != null)
            {
                foreach (Block/*!*/ succ in gotoCmd.labelTargets)
                {
                    Contract.Assert(succ != null);
                    Contract.Assert(succ.liveVarsBefore != null);
                    liveVarsAfter.UnionWith(succ.liveVarsBefore);
                }
            }
        }
        else if (block.TransferCmd is ReturnCmd)
        {
            // Globals and out-formals are live
            if (program != null)
            {
                program.TopLevelDeclarations
                    .OfType<GlobalVariable>()
                    .Iter(v => liveVarsAfter.Add(v));
            }

            impl.OutParams
                .OfType<Formal>()
                .Iter(v => liveVarsAfter.Add(v));
        }
        return liveVarsAfter;
    }

    // perform in place update of liveSet
    public static void Propagate(Cmd cmd, HashSet<Variable/*!*/>/*!*/ liveSet, bool allGlobalsAreLive)
    {
        Contract.Requires(cmd != null);
        Contract.Requires(cce.NonNullElements(liveSet));
        if (cmd is AssignCmd)
        {
            AssignCmd/*!*/ assignCmd = (AssignCmd)cce.NonNull(cmd);
            // I must first iterate over all the targets and remove the live ones.
            // After the removals are done, I must add the variables referred on 
            // the right side of the removed targets

            AssignCmd simpleAssignCmd = assignCmd.AsSimpleAssignCmd;
            HashSet<int> indexSet = new HashSet<int>();
            int index = 0;
            foreach (AssignLhs/*!*/ lhs in simpleAssignCmd.Lhss)
            {
                Contract.Assert(lhs != null);
                SimpleAssignLhs salhs = lhs as SimpleAssignLhs;
                Contract.Assert(salhs != null);
                Variable var = salhs.DeepAssignedVariable;
                if (var != null && (liveSet.Contains(var) || (allGlobalsAreLive && var is GlobalVariable)))
                {
                    indexSet.Add(index);
                    liveSet.Remove(var);
                }
                index++;
            }
            index = 0;
            foreach (Expr/*!*/ expr in simpleAssignCmd.Rhss)
            {
                Contract.Assert(expr != null);
                if (indexSet.Contains(index))
                {
                    VariableCollector/*!*/ collector = new VariableCollector();
                    collector.Visit(expr);
                    if (allGlobalsAreLive)
                    {
                        liveSet.UnionWith(collector.usedVars.Where(v => v is LocalVariable || v is Formal));
                    }
                    else
                    {
                        liveSet.UnionWith(collector.usedVars);
                    }
                }
                index++;
            }
        }
        else if (cmd is HavocCmd)
        {
            HavocCmd/*!*/ havocCmd = (HavocCmd)cmd;
            foreach (IdentifierExpr/*!*/ expr in havocCmd.Vars)
            {
                Contract.Assert(expr != null);
                if (expr.Decl != null)
                {
                    liveSet.Remove(expr.Decl);
                }
            }
        }
        else if (cmd is PredicateCmd)
        {
            Contract.Assert((cmd is AssertCmd || cmd is AssumeCmd));
            PredicateCmd/*!*/ predicateCmd = (PredicateCmd)cce.NonNull(cmd);
            if (predicateCmd.Expr is LiteralExpr)
            {
                LiteralExpr le = (LiteralExpr)predicateCmd.Expr;
                if (le.IsFalse)
                {
                    liveSet.Clear();
                }
            }
            else
            {
                VariableCollector/*!*/ collector = new VariableCollector();
                collector.Visit(predicateCmd.Expr);
                if (allGlobalsAreLive)
                {
                    liveSet.UnionWith(collector.usedVars.Where(v => v is LocalVariable || v is Formal));
                }
                else
                {
                    liveSet.UnionWith(collector.usedVars);
                }
            }
        }
        else if (cmd is CommentCmd)
        {
            // comments are just for debugging and don't affect verification
        }
        else if (cmd is SugaredCmd)
        {
            SugaredCmd/*!*/ sugCmd = (SugaredCmd)cce.NonNull(cmd);
            Propagate(sugCmd.Desugaring, liveSet, allGlobalsAreLive);
        }
        else if (cmd is StateCmd)
        {
            StateCmd/*!*/ stCmd = (StateCmd)cce.NonNull(cmd);
            List<Cmd>/*!*/ cmds = cce.NonNull(stCmd.Cmds);
            int len = cmds.Count;
            for (int i = len - 1; i >= 0; i--)
            {
                Propagate(cmds[i], liveSet, allGlobalsAreLive);
            }
            foreach (Variable/*!*/ v in stCmd.Locals)
            {
                Contract.Assert(v != null);
                liveSet.Remove(v);
            }
        }
        else
        {
            {
                Contract.Assert(false);
                throw new cce.UnreachableException();
            }
        }
    }
}
