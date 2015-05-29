using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using PersistentProgram = ProgTransformation.PersistentProgram;

namespace ProofMinimization
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("ProofMin file.bpl [options]");
                return;
            }

            var boogieArgs = "";
            string dualityprooffile = null;
            var once = false;

            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }
                if (args[i] == "/once")
                {
                    once = true;
                    continue;
                }

                if (args[i].StartsWith("/duality:"))
                {
                    dualityprooffile = args[i].Substring("/duality:".Length);
                    continue;
                }

                boogieArgs += args[i] + " ";
            }
            Initalize(boogieArgs);

            var program = BoogieUtil.ReadAndResolve(args[0]);

            // Input program must be an RMT query
            if (program.TopLevelDeclarations.OfType<Implementation>()
                .Any(impl => impl.Blocks
                    .Any(blk => blk.Cmds
                        .Any(c => c is AssertCmd && !BoogieUtil.isAssertTrue(c)))))
                throw new Exception("Input program cannot have an assertion");

            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            if (ep == null)
                throw new Exception("Entrypoint not found");

            // Inject duality proof
            if (dualityprooffile != null)
            {
                program = InjectDualityProof(program, BoogieUtil.ParseProgram(dualityprooffile));
                
            }

            var inprog = new PersistentProgram(program);

            
            if (once)
            {
                RunOnce(inprog);
                return;
            }

            HashSet<string> assignment = null;
            HashSet<string> candidates = new HashSet<string>();
            int inlined = 0;

            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => candidates.Add(c.Name));

            var rt = PruneAndRun(inprog, candidates, out assignment, out inlined);

            if (rt != BoogieVerify.ReturnStatus.OK)
            {
                Console.WriteLine("Cannot minimize a non-correct program");
                return;
            }

            if (candidates.Count != assignment.Count)
                Console.WriteLine("Dropping {0} candidates", (candidates.Count - assignment.Count));

            candidates = assignment;
            var mustkeep = new HashSet<string>();

            var iter = 1;
            var sw = new Stopwatch();
            sw.Start();

            // Prune
            while (candidates.Count != 0)
            {
                Console.WriteLine("------ ITER {0} -------", iter++);

                // Drop one and re-run
                var c = PickRandom(candidates);
                candidates.Remove(c);

                Console.WriteLine("  >> Trying {0}", c);

                rt = PruneAndRun(inprog, candidates.Union(mustkeep), out assignment, out inlined);

                if (rt == BoogieVerify.ReturnStatus.OK)
                {
                    // dropping was fine
                    Console.WriteLine("  >> Dropping it and {0} others", (candidates.Count + mustkeep.Count - assignment.Count));
                    candidates = assignment;
                    candidates.ExceptWith(mustkeep);
                    mustkeep.IntersectWith(assignment);

                    Debug.Assert(!candidates.Contains(c));
                }
                else
                {
                    Console.WriteLine("  >> Cannot drop");
                    mustkeep.Add(c);
                }
                Console.WriteLine("Time elapsed: {0} sec", sw.Elapsed.TotalSeconds.ToString("F2"));
            }

            Console.WriteLine("Final assignment: {0}", mustkeep.Concat(" "));
        }

        static Random rand = null;

        static string PickRandom(HashSet<string> set)
        {
            Debug.Assert(set.Count != 0);

            if (rand == null)
            {
                rand = new Random((int)DateTime.Now.Ticks);
            }

            var ind = rand.Next(set.Count);
            return set.ToList()[ind];
        }

        static void RunOnce(PersistentProgram inp)
        {
            var program = inp.getProgram();
            program.Typecheck();
            BoogieUtil.PrintProgram(program, "hi_query.bpl");

            Console.WriteLine("Running HoudiniLite");
            var assignment = CoreLib.HoudiniInlining.RunHoudini(program);
            Console.WriteLine("Inferred {0} contracts", assignment.Count);

            // Read the program again, add contracts
            program = inp.getProgram();
            program.Typecheck();

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);

            BoogieUtil.PrintProgram(program, "si_query.bpl");

            // Run SI
            var err = new List<BoogieErrorTrace>();

            var rstatus = BoogieVerify.Verify(program, out err, true);
            Console.WriteLine("SI Return status: {0}", rstatus);
            if (err == null || err.Count == 0)
                Console.WriteLine("program verified");
            else
            {
                foreach (var trace in err.OfType<BoogieAssertErrorTrace>())
                {
                    Console.WriteLine("{0} did not verify", trace.impl.Name);
                    //if (!config.noTrace) trace.cex.Print(0, Console.Out);
                }
            }

            Console.WriteLine(string.Format("Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));
        }

        static int IterCnt = 0;

        static BoogieVerify.ReturnStatus PruneAndRun(PersistentProgram inp, HashSet<string> candidates, out HashSet<string> assignment, out int inlined)
        {
            IterCnt++;

            var program = inp.getProgram();
            program.Typecheck();

            // Remove non-candidates
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, candidates, true);
            program.RemoveTopLevelDeclarations(decl => (decl is Constant) && !candidates.Contains((decl as Constant).Name));

            // Run Houdini
            assignment = CoreLib.HoudiniInlining.RunHoudini(program);
            Console.WriteLine("  >> Contracts: {0}", assignment.Count);

            // Read the program again, add contracts
            program = inp.getProgram();
            program.Typecheck();

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);

            //BoogieUtil.PrintProgram(program, "si_query" + IterCnt + ".bpl");

            // Run SI
            var err = new List<BoogieErrorTrace>();

            var rstatus = BoogieVerify.Verify(program, out err, true);
            Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            inlined = BoogieVerify.CallTreeSize;

            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;

            
            return rstatus;
        }

        static Program InjectDualityProof(Program program, Program DualityProof)
        {
            var implToContracts = new Dictionary<string, List<Expr>>();
            foreach (var proc in DualityProof.TopLevelDeclarations.OfType<Procedure>())
            {
                implToContracts.Add(proc.Name, new List<Expr>());
                foreach (var ens in proc.Ensures)
                {
                    implToContracts[proc.Name].AddRange(GetExprConjunctions(ens.Condition));
                }
            }

            var counter = 0;
            var GetExistentialConstant = new Func<Constant>(() =>
                {
                    var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                        "DualityProofConst" + (counter++), Microsoft.Boogie.Type.Bool), false);
                    c.AddAttribute("existential");
                    return c;
                });

            var constsToAdd = new List<Declaration>();
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                if (!implToContracts.ContainsKey(proc.Name))
                    continue;
                foreach (var expr in implToContracts[proc.Name])
                {
                    var c = GetExistentialConstant();
                    constsToAdd.Add(c);
                    proc.Ensures.Add(new Ensures(false,
                        Expr.Imp(Expr.Ident(c), expr)));
                }
            }

            program.AddTopLevelDeclarations(constsToAdd);

            return BoogieUtil.ReResolveInMem(program);
        }

        // Return the set of conjuncts of the expr
        static List<Expr> GetExprConjunctions(Expr expr)
        {
            var conjuncts = new List<Expr>();
            if (expr is NAryExpr && (expr as NAryExpr).Fun is BinaryOperator &&
                ((expr as NAryExpr).Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
            {
                var c0 = GetExprConjunctions((expr as NAryExpr).Args[0]);
                var c1 = GetExprConjunctions((expr as NAryExpr).Args[1]);
                conjuncts.AddRange(c0);
                conjuncts.AddRange(c1);
            }
            else
            {
                conjuncts.Add(expr);
            }

            return conjuncts;
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

            BoogieVerify.removeAsserts = false;
            CommandLineOptions.Clo.RecursionBound = 1;
        }
    }
}
