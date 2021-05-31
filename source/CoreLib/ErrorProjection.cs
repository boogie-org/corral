using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;
using System.Diagnostics;

namespace cba
{
    public class ErrorProjectionPass : VerificationPass
    {
        Dictionary<string, string> labelProcMap;

        // The set of procedures that we know lie on an error path
        HashSet<string> procsOnEP;

        // The set of procedure that are not on any error path
        public HashSet<string> ErrorProjection { get; private set; }

        // Settings for the verification pass
        StaticSettings settings;

        public ErrorProjectionPass(StaticSettings settings)
            : base(true)
        {
            passName = "Error projection pass";
            labelProcMap = null;
            procsOnEP = new HashSet<string>();
            ErrorProjection = null;
            this.settings = settings;
        }

        // For generating new labels
        static int label_cnt = 0;


        public override CBAProgram runCBAPass(CBAProgram p)
        {
            procsOnEP = new HashSet<string>();
            var nameImplMap = BoogieUtil.nameImplMapping(p);

            // Set of all procedures (with an implementation)
            var allProcs = new HashSet<string>();
            foreach (var tp in nameImplMap)
            {
                allProcs.Add(tp.Key);
            }

            var verifier = getVerifier();

            // Run verification, gather traces
            verifier.run(input);

            // Set verification result
            success = verifier.success;
            traces = verifier.traces;

            // Now, compute the error projection
            if (verifier.success)
            {
                ErrorProjection = allProcs;
                return null;
            }

            // Look at all procedures that lie on the error trace
            foreach (var trace in verifier.traces)
            {
                procsOnEP.UnionWith(trace.getProcs());
            }

            Log.WriteLine(Log.Normal, string.Format("EP: Got {0} traces and {1} procs", verifier.traces.Count, procsOnEP.Count));

            // Just make sure that we inlcude main here (probably not necessary)
            procsOnEP.Add(p.mainProcName);

            // Have we already covered all of the program?
            if (procsOnEP.Equals(allProcs))
            {
                ErrorProjection = new HashSet<string>();
                return null;
            }

            // Iterate and try to force the verifier to return paths in 
            // different procedures
            var done = false;
            do
            {
                var moreProcs = iterateComputation(input as PersistentCBAProgram, HashSetExtras<string>.Difference(allProcs, procsOnEP));
                if (moreProcs.Count == 0)
                {
                    done = true;
                }
                else
                {
                    procsOnEP.UnionWith(moreProcs);
                    if (procsOnEP.Equals(allProcs))
                    {
                        done = true;
                    }
                }
            } while (!done);

            ErrorProjection = HashSetExtras<string>.Difference(allProcs, procsOnEP);
            return null;            
        }

        // Given a set of candidate procedures, find out which of them lie
        // on an error path. This function is iterated until it returns the
        // empty set or the whole set of candidates
        public HashSet<string> iterateComputation(PersistentCBAProgram program, HashSet<string> candidates)
        {
            var ret = new HashSet<string>();

            // Instrument the program.
            // instrument() sets labelProcMap
            var newProg = instrument(program, candidates);

            CommandLineOptions.Clo.ProverCCLimit = 5;
            var verifier = getVerifier();
            verifier.run(newProg);

            if (verifier.success)
            {
                return ret;
            }

            foreach (var trace in verifier.traces)
            {
                // Find the failing assert -- it must be in main
                var blkName = trace.Blocks.Last().blockName;
                if (labelProcMap.ContainsKey(blkName))
                {
                    ret.Add(labelProcMap[blkName]);
                }
            }
            
            foreach (var trace in verifier.traces)
            {
                // trace.getProcs().Iter(s => ret.Add(s));
                ret.UnionWith(trace.getProcs());
            }

            ret = HashSetExtras<string>.Intersection(ret, candidates);

            Log.WriteLine(Log.Normal, string.Format("EP: Got {0} traces and {1} procs", verifier.traces.Count, ret.Count));

            return ret;
        }

        private PersistentCBAProgram instrument(PersistentCBAProgram pprogram, HashSet<string> candidates)
        {
            Debug.Assert(candidates.Count != 0);

            labelProcMap = new Dictionary<string, string>();
            var program = pprogram.getProgram();
            var nameImplMap = BoogieUtil.nameImplMapping(program);

            // Each candidate gets its own variable
            var procVars = new Dictionary<string, Variable>();
            foreach (var str in candidates)
            {
                procVars.Add(str,
                    new GlobalVariable(Token.NoToken,
                        new TypedIdent(Token.NoToken, "ep_var_" + str, Microsoft.Boogie.Type.Bool)));

                program.AddTopLevelDeclaration(procVars[str]);
            }

            // Add the new variables to each procedures' modifies clause
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    var impl = decl as Implementation;
                    foreach (var str in candidates)
                    {
                        impl.Proc.Modifies.Add(new IdentifierExpr(Token.NoToken, procVars[str]));
                    }
                }
            }

            // Instrument program
            foreach (var str in candidates)
            {
                var impl = nameImplMap[str];
                var ncmds = new List<Cmd>();
                ncmds.Add(BoogieAstFactory.MkVarEqConst(procVars[str], false));
                ncmds.AddRange(impl.Blocks[0].Cmds);

                impl.Blocks[0].Cmds = ncmds;
            }

            // Instrument main.
            // -- Assign true to the new variables
            // -- Change the assert
            //    (We assume that main only has one assert)

            var mainImpl = nameImplMap[pprogram.mainProcName];
            var newCmds = new List<Cmd>();
            foreach (var str in candidates)
            {
                newCmds.Add(BoogieAstFactory.MkVarEqConst(procVars[str], true));
            }
            newCmds.AddRange(mainImpl.Blocks[0].Cmds);
            mainImpl.Blocks[0].Cmds = newCmds;

            // Find the assert
            Block blkWithAssert = null;
            AssertCmd assertCmd = null;
            bool found = false;
            foreach (var blk in mainImpl.Blocks)
            {
                found = false;
                foreach (var cmd in blk.Cmds)
                {
                    if (cmd is AssertCmd)
                    {
                        assertCmd = cmd as AssertCmd;
                        found = true;
                        break;
                    }
                }

                if (found)
                {
                    blkWithAssert = blk;
                    break;
                }
            }

            Debug.Assert(blkWithAssert != null);

            // Construct the new blocks
            var newLabs = new Dictionary<string, string>();
            var restLab = getNewLabel();

            foreach (var str in candidates)
            {
                newLabs.Add(str, getNewLabel());
                var tcmds = new List<Cmd>();
                
                tcmds.Add(new AssertCmd(Token.NoToken, Expr.Or(Expr.Ident(procVars[str]), assertCmd.Expr)));

                mainImpl.Blocks.Add(new Block(Token.NoToken, newLabs[str], tcmds ,BoogieAstFactory.MkGotoCmd(restLab) ));

            }

            // change blkWithAssert to include only commands upto the assert
            // Add the rest of commands to a new block
            found = false;
            newCmds = new List<Cmd>();
            var newBlk = new Block(Token.NoToken, restLab, new List<Cmd>(), blkWithAssert.TransferCmd);
            foreach (Cmd cmd in blkWithAssert.Cmds)
            {
                if (cmd is AssertCmd)
                {
                    found = true;
                    continue;
                }
                if (!found)
                {
                    newCmds.Add(cmd);
                }
                else
                {
                    newBlk.Cmds.Add(cmd);
                }
            }
            blkWithAssert.Cmds = newCmds;
            var targets = new List<String>(newLabs.Values.ToArray());
            blkWithAssert.TransferCmd = new GotoCmd(Token.NoToken, targets);

            mainImpl.Blocks.Add(newBlk);

            var ret = new PersistentCBAProgram(program, pprogram.mainProcName, pprogram.contextBound);
            //ret.writeToFile("ep_instrumented.bpl");

            return ret;
        }

        // Remove all procs in "procsToRemove" from the program, and replace calls to these procedures by
        // assume false
        public static PersistentCBAProgram prune(PersistentCBAProgram pprogram, HashSet<string> procsToRemove)
        {
            if (procsToRemove.Count == 0)
                return pprogram;

            // Go through all Commands and remove calls 
            CBAProgram program = pprogram.getCBAProgram();

            foreach (var decl in program.TopLevelDeclarations)
            {
                if (!(decl is Implementation))
                    continue;
                var impl = decl as Implementation;
                foreach (Block blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        if (isCall(blk.Cmds[i], procsToRemove))
                        {
                            blk.Cmds[i] = new AssumeCmd(Token.NoToken, Expr.False);
                        }
                    }
                }
            }

            // Remove declarations and implementations
            var newDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    if (procsToRemove.Contains((decl as Implementation).Name))
                        continue;
                }
                else if (decl is Procedure)
                {
                    if (procsToRemove.Contains((decl as Procedure).Name))
                        continue;
                }
                newDecls.Add(decl);
            }

            program.TopLevelDeclarations = newDecls;
            return new PersistentCBAProgram(program, program.mainProcName, program.contextBound);
        }

        // is cmd a call to a procedure in "procs"?
        private static bool isCall(Cmd cmd, HashSet<string> procs)
        {
            if (!(cmd is CallCmd))
                return false;

            var ccmd = cmd as CallCmd;
            return procs.Contains(ccmd.Proc.Name);
        }

        private VerificationPass getVerifier()
        {
            return new StaticInlineAndVerifyPass(settings, true);
        }

        private static string getNewLabel()
        {
            string ret = "ep_label_" + (label_cnt.ToString());
            label_cnt++;
            return ret;
        }
    }
}
