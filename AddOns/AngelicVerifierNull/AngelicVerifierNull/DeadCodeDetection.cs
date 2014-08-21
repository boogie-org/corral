using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PersistentProgram = cba.PersistentCBAProgram;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using Microsoft.Boogie;
using System.Diagnostics;

namespace AngelicVerifierNull
{
    class DeadCodeInstrumentation : FixedVisitor
    {
        HashSet<string> nonNullMaps;
        HashSet<AssumeCmd> targetBranches;
        Program origprog;

        public DeadCodeInstrumentation(Program _prog)
        {
            origprog = _prog;
            nonNullMaps = new HashSet<string>(); // maps whose fields are assumed non-null
            targetBranches = new HashSet<AssumeCmd>();
        }

        public void CollectAssumptions()
        {
            Implementation extraInit = BoogieUtil.findProcedureImpl(origprog.TopLevelDeclarations, "corralExtraInit");
            if (extraInit == null)
                throw new Exception("Input program does not have corralExtraInit!");

            foreach (Block b in extraInit.Blocks)
            {
                b.Cmds.OfType<AssumeCmd>().Iter(a =>
                {
                    var varCollector = new VariableCollector();
                    varCollector.Visit(a.Expr);
                    varCollector.usedVars.Where(u => u.TypedIdent.Type.IsMap)
                        .Iter(m => nonNullMaps.Add(m.ToString()));
                });
            }
        }

        // Insert assert false for each conditional branch
        public static Program InsertAssertFalse(Program prog)
        {
            var deadCode = new DeadCodeInstrumentation(prog);
            deadCode.CollectAssumptions();
            //Program prog = (new FixedDuplicator(false)).VisitProgram(deadCode.origprog);
            prog = deadCode.VisitProgram(prog);

            return prog;
        }

        public override Block VisitBlock(Block node)
        {
            for (int i = 0; i < node.Cmds.Count; ++i)
            {
                if (node.Cmds[i] is AssumeCmd)
                {
                    var assuCmd = node.Cmds[i] as AssumeCmd;
                    if (!BoogieUtil.checkAttrExists("partition", assuCmd.Attributes)) continue;

                    var varCollector = new VariableCollector();
                    varCollector.Visit(assuCmd.Expr);

                    if (varCollector.usedVars.Where(u => u.TypedIdent.Type.IsMap)
                        .Any(m => nonNullMaps.Contains(m.ToString())))
                    {
                        var assertFalse = BoogieAstFactory.MkAssert(Expr.False);
                        node.Cmds.Insert(i + 1, assertFalse);
                    }
                }
                else if (node.Cmds[i] is AssertCmd)
                {
                    var asstCmd = node.Cmds[i] as AssertCmd;
                    if (!BoogieUtil.checkAttrExists("nonnull", asstCmd.Attributes)) continue;

                    node.Cmds.RemoveAt(i);
                }
            }
            return base.VisitBlock(node);
        }


    }

    public class DeadCodeDetection
    {
        static cba.Configs corralConfig = null;
        static cba.CorralState corralState = null;
        // call Corral on the instrumented
        public static void RunCorral(PersistentProgram prog)
        {
            // Rewrite program to a more convinient form
            var rc = new cba.RewriteCallCmdsPass(true);
            prog = rc.run(prog);

            //var instr = new AvnInstrumentation(harnessInstrumentation);
            //prog = instr.run(prog);

            if (corralState != null)
            {
                corralConfig.trackedVars.UnionWith(corralState.TrackedVariables);
                cba.ConfigManager.progVerifyOptions.CallTree = corralState.CallTree;
            }

            var refinementState = new cba.RefinementState(prog,
                new HashSet<string>(corralConfig.trackedVars.Union(new string[] { "assertsPassed" })),
                false);

            cba.ErrorTrace cexTrace = null;
            try
            {
                cba.Driver.checkAndRefine(prog, refinementState, null, out cexTrace);
            }
            catch (Exception)
            {
                // dump corral state for next iteration
                corralState = new cba.CorralState();
                corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
                corralState.TrackedVariables = refinementState.getVars().Variables;

                throw;
            }

            // dump corral state for next iteration
            corralState = new cba.CorralState();
            corralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
            corralState.TrackedVariables = refinementState.getVars().Variables;
        }

        public static PersistentProgram Detect(PersistentProgram program, cba.Configs _config)
        {
            corralConfig = _config;

            var prog = DeadCodeInstrumentation.InsertAssertFalse(program.getProgram());
            BoogieUtil.PrintProgram(prog, "deadcode.bpl");

            var persist = new PersistentProgram(prog, program.mainProcName, program.contextBound);
            //DeadCodeDetection.RunCorral(persist);
            return persist;
        }
    }
}
