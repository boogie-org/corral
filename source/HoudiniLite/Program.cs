using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Outcome = VC.VCGen.Outcome;
using cba.Util;
using CoreLib;
using Microsoft.Boogie.GraphUtil;

namespace HoudiniLite
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: HoudiniLite.exe file.bpl [options]");
                return;
            }
            var file = args[0];
            var boogieArgs = "";
            var check = false;
            var iter = false;
            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }
                if (args[i] == "/check")
                {
                    check = true;
                    continue;
                }
                if (args[i] == "/iter")
                {
                    iter = true;
                    continue;
                }

                boogieArgs += args[i] + " ";
            }
            Initalize(boogieArgs);

            if (iter)
            {
                var currfile = "curr.bpl";
                var program = BoogieUtil.ReadAndResolve(file);
                var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "Av_FDO_Pnp");

                //SimplifyImpl(impl);
                RemoveEmptyBlock(impl);
                BoogieUtil.PrintProgram(program, currfile);
                return;

                // Find reachable procedures
                //BoogieUtil.pruneProcs(program, impl.Name);
                
                // delete assert true
                //impl.Blocks
                //    .Iter(blk => blk.Cmds.RemoveAll(cmd => BoogieUtil.isAssertTrue(cmd)));

                

                //BoogieUtil.PrintProgram(program, currfile);

                foreach (var block in impl.Blocks)
                {
                    for (int i = 0; i < block.Cmds.Count; )
                    {
                        if (block.Cmds[i] is CallCmd)
                        {
                            var cmd = block.Cmds[i];
                            block.Cmds.RemoveAt(i);

                            Console.WriteLine("Trying {0} :: {1}", block.Label, cmd);
                            BoogieUtil.PrintProgram(program, currfile);
                            var b = Check(currfile, boogieArgs);
                            if (b)
                            {
                                Console.WriteLine("Cannot delete");
                                block.Cmds.Insert(i, cmd);
                                i++;
                            }
                        }
                        else
                        {
                            i++;
                        }
                    }
                }

                // delete empty blocks
                RemoveEmptyBlock(impl);

                // compress
                var prune = new cba.PruneProgramPass(true);
                prune.run(new cba.PersistentCBAProgram(program, impl.Name, 0)).writeToFile(currfile);
                return;
            }

            var sw = new Stopwatch();
            sw.Start();

            var assignment = HoudiniInlining.RunHoudini(BoogieUtil.ReadAndResolve(file), true);

            sw.Stop();

            Console.WriteLine("HoudiniLite took: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));
            HoudiniStats.Print();
            Console.WriteLine("Num true = {0}", assignment.Count);
            if(CommandLineOptions.Clo.PrintAssignment)
              Console.WriteLine("True assignment: {0}", assignment.Concat(" "));

            //var outp = BoogieUtil.ReadAndResolve(file);
            //HoudiniInlining.InstrumentHoudiniAssignment(outp, assignment);
            //BoogieUtil.PrintProgram(outp, file.Replace(".bpl", "_out.bpl"));

            if (check)
            {
                sw.Restart();

                CommandLineOptions.Install(new CommandLineOptions());
                CommandLineOptions.Clo.PrintInstrumented = true;
                CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
                CommandLineOptions.Clo.ContractInfer = true;
                BoogieUtil.InitializeBoogie(boogieArgs);

                var actual = RunBoogieHoudini(BoogieUtil.ReadAndResolve(file));

                sw.Stop();

                Console.WriteLine("Houdini took: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));

                if (!assignment.Equals(actual))
                {
                    Console.WriteLine("Constants proved by us but not houdini: {0}", assignment.Difference(actual).Concat(" "));
                    Console.WriteLine("Constants proved by houdini but not us: {0}", actual.Difference(assignment).Concat(" "));
                }
            }
        }

        static void SimplifyImpl(Implementation impl)
        {
            var seen = new HashSet<string>();
            var paths = new List<List<Cmd>>();
            var Process = new Action<IEnumerable<Block>>(ls =>
                {
                    var cmds = ls.Select(b => b.Cmds).Select(l => l.AsEnumerable())
                        .Aggregate((new List<Cmd>()).AsEnumerable(), (a, b) => a.Concat(b))
                        .ToList();
                    var str = cmds.Select(c => c.ToString()).Concat(" ");
                    if (seen.Contains(str)) return;
                    seen.Add(str);
                    paths.Add(cmds);
                });

            EnumeratePaths(impl.Blocks[0], new Stack<Block>(), Process);

            Console.WriteLine("Found {0} paths", paths.Count);

            var nlabs = new List<string>();
            var nblocks = new List<Block>();
            var cnt = 0;

            paths.Iter(l =>
            {
                var lab = "l" + (cnt++);
                nblocks.Add(new Block(Token.NoToken, lab, l, new ReturnCmd(Token.NoToken)));
                nlabs.Add(lab);
            });

            var bs = new Block(Token.NoToken, "start", new List<Cmd>(), new GotoCmd(Token.NoToken,
                nlabs));

            impl.Blocks.Clear();
            impl.Blocks.Add(bs);
            impl.Blocks.AddRange(nblocks);

        }

        static void EnumeratePaths(Block block, Stack<Block> currPath, Action<IEnumerable<Block>> act)
        {
            currPath.Push(block);
            if (block.TransferCmd is ReturnCmd)
            {
                act(currPath);
                currPath.Pop();
                return;
            }
            var gc = block.TransferCmd as GotoCmd;
            foreach (var succ in gc.labelTargets)
            {
                EnumeratePaths(succ, currPath, act);
            }
            currPath.Pop();
        }

        static void RemoveEmptyBlock(Implementation impl)
        {
            var pred = new Dictionary<Block, HashSet<Block>>();
            var succ = new Dictionary<Block, HashSet<Block>>();
            var b2l = BoogieUtil.labelBlockMapping(impl);

            impl.Blocks.Iter(blk => pred.Add(blk, new HashSet<Block>()));
            impl.Blocks.Iter(blk => succ.Add(blk, new HashSet<Block>()));

            // Remove duplicates
            foreach (var b in impl.Blocks)
            {
                var gc = b.TransferCmd as GotoCmd;
                if (gc == null) continue;
                gc.labelNames = new HashSet<string>(gc.labelNames).ToList();
                gc.labelTargets = new List<Block>();
            }

            foreach (var blk in impl.Blocks)
            {
                var gc = blk.TransferCmd as GotoCmd;
                if (gc == null) continue;
                foreach (var s in gc.labelNames)
                {
                    pred[b2l[s]].Add(blk);
                    succ[blk].Add(b2l[s]);
                }
            }

            var emptyBlocks = new HashSet<Block>(impl.Blocks.Where(b => b.Cmds.Count == 0 && !(b.TransferCmd is ReturnCmd)));
            emptyBlocks.Remove(impl.Blocks[0]);

            foreach (var b in emptyBlocks)
            {
                foreach (var p in pred[b])
                {
                    var gc = p.TransferCmd as GotoCmd;

                    gc.labelNames.Remove(b.Label);
                    gc.labelNames.AddRange(succ[b].Select(a => a.Label));
                    gc.labelNames = new HashSet<string>(gc.labelNames).ToList();
                }

                var preds = new HashSet<Block>(pred[b]);
                var succs = new HashSet<Block>(succ[b]);

                preds.Iter(p => { succ[p].Remove(b); succ[p].UnionWith(succs); });
                succs.Iter(s => { pred[s].Remove(b); pred[s].UnionWith(preds); });
            }

            foreach (var b in impl.Blocks)
            {
                var gc = b.TransferCmd as GotoCmd;
                if (gc == null) continue;
                gc.labelNames = new HashSet<string>(gc.labelNames).ToList();
                gc.labelTargets = new List<Block>(gc.labelNames.Select(l => b2l[l]));
            }

            impl.Blocks.RemoveAll(b => emptyBlocks.Contains(b));
        }


        static bool Check(string file, string boogieArgs)
        {
            Initalize(boogieArgs);
            var assign1 = HoudiniInlining.RunHoudini(BoogieUtil.ReadAndResolve(file));

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
            CommandLineOptions.Clo.ContractInfer = true;
            BoogieUtil.InitializeBoogie(boogieArgs);

            var assign2 = RunBoogieHoudini(BoogieUtil.ReadAndResolve(file));

            if (assign1.Contains("CIC184") && !assign2.Contains("CIC184"))
                return false;
            return true;
        }

        static void Initalize(string boogieOptions)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
            CommandLineOptions.Clo.ContractInfer = true;
            BoogieUtil.InitializeBoogie(boogieOptions);
            CommandLineOptions.Clo.ProverCCLimit = 1;
            cba.Util.BoogieVerify.options = new BoogieVerifyOptions();
        }

        static HashSet<string> RunBoogieHoudini(Program program)
        {
            var houdiniStats = new Microsoft.Boogie.Houdini.HoudiniSession.HoudiniStatistics();
            var houdini = new Microsoft.Boogie.Houdini.Houdini(program, houdiniStats);
            var outcome = houdini.PerformHoudiniInference();

            var ret = new HashSet<string>();
            outcome.assignment.Where(tup => tup.Value).Iter(tup => ret.Add(tup.Key));
            return ret;
        }
    }

}
