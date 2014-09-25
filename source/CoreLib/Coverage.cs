using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;

namespace cba
{
    // Does verification while also gathering coverage data: the set of all procedures
    // that were never reached.
    public class CoveragePass : VerificationPass
    {
        // The set of procedures covered
        public HashSet<string> procsNotCovered { get; private set; }

        // Settings for verification pass
        StaticSettings settings;

        public CoveragePass(StaticSettings settings)
            : base(true)
        {
            passName = "Coverage verification pass";
            procsNotCovered = null;
            this.settings = settings;
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            // Run verification, gather traces
            var verifier = getVerifier();
            verifier.run(input);

            // Set verification result
            success = verifier.success;
            traces = verifier.traces;

            // Now compute coverage, provided error was not reached
            if (!verifier.success)
            {
                return null;
            }

            // Gather procedure names           
            var nameImplMap = BoogieUtil.nameImplMapping(p);

            var allProcs = new HashSet<string>();
            foreach (var tp in nameImplMap)
            {
                allProcs.Add(tp.Key);
            }

            procsNotCovered = new HashSet<string>();
            procsNotCovered.UnionWith(allProcs);
            procsNotCovered.Remove(p.mainProcName);

            // Iterate and gather procedures that can be reached
            int oldProverLimit = CommandLineOptions.Clo.ProverCCLimit;

            var done = false;
            do
            {
                // Set the number of traces returned by boogie in one shot                
                CommandLineOptions.Clo.ProverCCLimit = procsNotCovered.Count();

                var covered = iterateComputation(input as PersistentCBAProgram, procsNotCovered);
                if (covered.Count == 0)
                {
                    done = true;
                }
                else
                {
                    procsNotCovered = HashSetExtras<string>.Difference(procsNotCovered, covered);
                    if (!procsNotCovered.Any())
                    {
                        done = true;
                    }
                }
            } while (!done);

            CommandLineOptions.Clo.ProverCCLimit = oldProverLimit;

            return null;            
        }

        // Given a set of candidate procedures, find out which of them can be reached
        public HashSet<string> iterateComputation(PersistentCBAProgram program, HashSet<string> candidates)
        {
            var ret = new HashSet<string>();

            // Instrument the program.
            // instrument() sets labelProcMap
            var newProg = instrument(program, candidates);

            var verifier = getVerifier();
            verifier.run(newProg);

            // Nothing more can be covered
            if (verifier.success)
            {
                return ret;
            }

            // All these guys were covered
            foreach (var trace in verifier.traces)
            {
                // trace.getProcs().Iter(s => ret.Add(s));
                ret.UnionWith(trace.getProcs());
            }

            ret = HashSetExtras<string>.Intersection(ret, candidates);

            Log.WriteLine(Log.Normal, string.Format("Coverage: Got {0} traces and {1} procs", verifier.traces.Count, ret.Count));

            return ret;
        }

        private PersistentCBAProgram instrument(PersistentCBAProgram pprogram, HashSet<string> candidates)
        {
            var program = pprogram.getProgram();
            foreach (var decl in program.TopLevelDeclarations)
            {
                if (!(decl is Implementation))
                    continue;

                var impl = decl as Implementation;

                // Create two blocks at the start of the implementation:
                // newStart:
                //   goto lab,origStart;
                //
                // lab:
                //   assert false;
                //   return;
                //

                var lab = getNewLabel();
                var targets1 = new List<String>();
                targets1.Add(lab);
                targets1.Add(impl.Blocks[0].Label);

                var blk1 = new Block(Token.NoToken, getNewLabel(), new List<Cmd>(), new GotoCmd(Token.NoToken, targets1));
                
                var blk2cmds = new List<Cmd>();
                blk2cmds.Add(new AssertCmd(Token.NoToken, Expr.Literal(false)));

                var blk2 = new Block(Token.NoToken, lab, blk2cmds, new ReturnCmd(Token.NoToken));

                // Get rid of original asserts
                // TODO: This works with the CBA reduction??
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0, n = blk.Cmds.Count; i < n; i++)
                    {
                        if (blk.Cmds[i] is AssertCmd)
                        {
                            var c = (blk.Cmds[i] as AssertCmd).Expr;
                            blk.Cmds[i] = new AssumeCmd(Token.NoToken, c);
                        }
                    }
                }

                // Put in the new blocks
                var newBlocks = new List<Block>();
                newBlocks.Add(blk1);
                newBlocks.AddRange(impl.Blocks);
                newBlocks.Add(blk2);

                impl.Blocks = newBlocks;
            }

            return new PersistentCBAProgram(program, pprogram.mainProcName, pprogram.contextBound);
        }

        private VerificationPass getVerifier()
        {
            return new StaticInlineAndVerifyPass(settings, true);
        }

        static int label_cnt = 0;
        private static string getNewLabel()
        {
            string ret = "cpass_label_" + (label_cnt.ToString());
            label_cnt++;
            return ret;
        }
    }

}
