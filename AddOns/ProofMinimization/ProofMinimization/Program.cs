using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using PersistentProgram = ProgTransformation.PersistentProgram;
using System.Text.RegularExpressions;

namespace ProofMinimization
{
    class Driver
    {
        public static readonly string MustKeepAttr = "pm_mustkeep";
        public static readonly string DropAttr = "pm_drop";
        public static readonly string CostAttr = "pm_cost";
        //static Program ForLogging = null;

        

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("ProofMin file(s).bpl [options]");
                return;
            }

            var boogieArgs = "";
            var once = false;
            var usePerf = false;
            var printcontracts = false;
            var keepPatterns = new HashSet<string>();

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
                if (args[i] == "/printAssignment")
                {
                    printcontracts = true;
                    continue;
                }

                if (args[i].StartsWith("/keep:"))
                {
                    keepPatterns.Add(args[i].Substring("/keep:".Length));
                    continue;
                }

                if (args[i].StartsWith("/perf"))
                {
                    usePerf = true;
                    continue;
                }

                boogieArgs += args[i] + " ";
            }

            // Initialize Boogie
            boogieArgs += " /typeEncoding:m /weakArrayTheory /errorLimit:1 ";
            Initalize(boogieArgs);

            // Get the input files
            var files = System.IO.Directory.GetFiles(".", args[0]);
            if (files.Length == 0)
            {
                Console.WriteLine("No files given");
                return;
            }
            Console.WriteLine("Found {0} files", files.Length);

            // file name -> Program
            Dictionary<string, PersistentProgram> fileToProg = new Dictionary<string, PersistentProgram>();
            // template ID -> file -> {constants}
            Dictionary<int, Dictionary<string, HashSet<string>>> templateMap = new Dictionary<int, Dictionary<string, HashSet<string>>>();

            foreach (var f in files)
            {
                var program = BoogieUtil.ReadAndResolve(args[0]);
                CheckRMT(program);

                // Add annotations
                foreach (var p in keepPatterns)
                {
                    var re = new Regex(p);
                    program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential") && re.IsMatch(c.Name))
                    .Iter(c => c.AddAttribute(MustKeepAttr));
                }

                // Prune, according to annotations
                DropConstants(program, new HashSet<string>(
                    program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, DropAttr))
                    .Select(c => c.Name)));

                // Normalize expressions


                // create template map


                fileToProg.Add(f, new PersistentProgram(program));
            }

            if (once)
            {
                Debug.Assert(fileToProg.Count == 1);
                var proofmin = new ProofMin(fileToProg.Values.First(), usePerf);
                proofmin.RunOnce(printcontracts);
                return;
            }

            HashSet<string> candidates;
            Dictionary<string, int> constantToPerfDelta;
            HashSet<string> dropped;
            var contracts = proofmin.GetContracts();
            
            var ret = proofmin.Run(out candidates, out dropped, out constantToPerfDelta);

            if (!ret)
                return;

            Console.WriteLine("Done with the first run");
            foreach (var c in candidates)
            {
                Console.WriteLine("First run: {0}", contracts[c]);
            }
            foreach (var tup in constantToPerfDelta)
            {
                if (tup.Value <= 2) continue;
                Console.WriteLine("First run pref: {0} {1}", tup.Value, contracts[tup.Key]);
            }

            // Lets see if we can break down things further
            program = inprog.getProgram();
            // drop ones that we don't need anymore
            DropConstants(program, dropped);
            // break the rest into smaller parts
            var kept = BreakDownInvariants(program, candidates);
            if (kept.Count != candidates.Count)
            {
                inprog = new PersistentProgram(program);
                proofmin = new ProofMin(inprog, usePerf);

                HashSet<string> candidates2;
                Dictionary<string, int> constantToPerfDelta2;
                HashSet<string> dropped2;
                var contracts2 = proofmin.GetContracts();

                ret = proofmin.Run(out candidates2, out dropped2, out constantToPerfDelta2);
                Debug.Assert(ret, "This cannot happen because we just started from a proof");

                // merge results
                candidates = candidates2.Union(kept);
                constantToPerfDelta2.Iter(tup => constantToPerfDelta.Add(tup.Key, tup.Value));
                contracts2.Where(tup => !contracts.ContainsKey(tup.Key)).Iter(tup => contracts.Add(tup.Key, tup.Value));
            }
            
            //Log(0);
            foreach (var c in candidates)
            {
                Console.WriteLine("Additional contract required: {0}", NormalizeExpr(contracts[c]));
            }
            foreach (var tup in constantToPerfDelta)
            {
                if (tup.Value <= 2) continue;
                Console.WriteLine("Contract to pref: {0} {1}", tup.Value, NormalizeExpr(contracts[tup.Key]));
            }
        }

        // Input program must be an RMT query
        static void CheckRMT(Program program)
        {            
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
        }

        // remove implications, push negation inside
        class SimplifyExpr : StandardVisitor
        {
            private SimplifyExpr() { }

            public static Expr Simplify(Expr expr)
            {
                var vs = new SimplifyExpr();
                return vs.VisitExpr(expr);
            }

            public override Expr VisitNAryExpr(NAryExpr node)
            {
                Expr ret = node;

                // Remove implies
                if (node.Fun is BinaryOperator && (node.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Imp)
                {
                    ret = Expr.Or(Expr.Not(node.Args[0]), node.Args[1]) as NAryExpr;
                }

                // Push negation inside
                if (node.Fun is UnaryOperator && (node.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                {
                    ret = PushNegationInside(node.Args[0]);
                }

                return base.VisitExpr(ret);
            }


            // push negations inside
            static Expr PushNegationInside(Expr expr)
            {
                var nary = expr as NAryExpr;
                if (nary == null)
                    return Expr.Not(expr);

                if (nary.Fun is UnaryOperator && (nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not)
                    return nary.Args[0];

                if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
                    return Expr.Or(PushNegationInside(nary.Args[0]), PushNegationInside(nary.Args[1]));

                if (nary.Fun is BinaryOperator && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or)
                    return Expr.And(PushNegationInside(nary.Args[0]), PushNegationInside(nary.Args[1]));

                return Expr.Not(expr);
            }
        }

        static Expr NormalizeExpr(Expr expr)
        {
            var disj = ProofMin.GetExprDisjuncts(expr);
            if (disj.Count != 1)
            {
                disj = disj.Map(e => NormalizeExpr(e));
                disj.Sort(new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString()))));
                var ret = disj[0];
                for (int i = 1; i < disj.Count; i++)
                    ret = Expr.Or(ret, disj[i]);
                return ret;
            }

            var conj = ProofMin.GetExprConjunctions(expr);
            if (conj.Count != 1)
            {
                conj = conj.Map(e => NormalizeExpr(e));
                conj.Sort(new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString()))));

                return Expr.And(conj);
            }

            var naryexpr = expr as NAryExpr;
            if (naryexpr == null)
                return expr;

            if (naryexpr.Fun is BinaryOperator)
            {
                NAryExpr nexpr;
                bool applyNeg;

                NormalizeOperator((naryexpr.Fun as BinaryOperator), naryexpr.Args[0], naryexpr.Args[1], out nexpr, out applyNeg);

                if (applyNeg) return Expr.Not(nexpr);
                return nexpr;
            }

            return expr;
        }

        static void NormalizeOperator(BinaryOperator op, Expr arg1, Expr arg2, out NAryExpr expr, out bool applyNeg)
        {
            expr = null;
            applyNeg = false;

            BinaryOperator.Opcode newop = op.Op;

            if (op.Op == BinaryOperator.Opcode.Lt)
                newop = BinaryOperator.Opcode.Ge;
            else if (op.Op == BinaryOperator.Opcode.Le)
                newop = BinaryOperator.Opcode.Gt;
            else if (op.Op == BinaryOperator.Opcode.Neq)
                newop = BinaryOperator.Opcode.Eq;

            var comp = new Comparison<Expr>((e1, e2) => (e1.ToString().CompareTo(e2.ToString())));
            var constructExpr = new Func<BinaryOperator, Expr, Expr, NAryExpr>((o, e1, e2) =>
                {
                    if (o.Op == BinaryOperator.Opcode.Eq && comp(e1, e2) > 0)
                        return new NAryExpr(Token.NoToken, o, new List<Expr> { e2, e1 });
                    return new NAryExpr(Token.NoToken, o, new List<Expr> { e1, e2 });
                });

            if (newop == op.Op)
            {
                expr = constructExpr(op, arg1, arg2);
                applyNeg = false;
            }

            expr = constructExpr(new BinaryOperator(Token.NoToken, newop), arg1, arg2); 
            applyNeg = true;
        }

        static HashSet<string> BreakDownInvariants(Program program, HashSet<string> candidates)
        {
            var markkeep = new HashSet<string>();
            var added = new HashSet<Constant>();

            var counter = 0;
            var GetExistentialConstant = new Func<Constant>(() =>
            {
                var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                    "DualityProofConstBrokenDown" + (counter++), Microsoft.Boogie.Type.Bool), false);
                c.AddAttribute("existential");
                return c;
            });

            var constants = new Dictionary<string, Constant>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => constants.Add(c.Name, c));

            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                var newens = new List<Ensures>();

                foreach (var ens in proc.Ensures.Where(e => !e.Free))
                {
                    string constantName = null;
                    Expr expr = null;

                    var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                        ens.Condition, candidates, out constantName, out expr);

                    if (!match) continue;

                    var elements = ProofMin.BreakDownExpr(expr);
                    if (elements.Count == 1)
                    {
                        markkeep.Add(constantName);
                        continue;
                    }

                    // add cost
                    constants[constantName].AddAttribute(Driver.CostAttr, Expr.Literal(1));

                    // add the constituents
                    foreach (var elem in elements)
                    {
                        var c = GetExistentialConstant();
                        added.Add(c);
                        newens.Add(new Ensures(false, Expr.Imp(Expr.Ident(c), elem)));
                    }
                    
                }

                proc.Ensures.AddRange(newens);
            }

            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => markkeep.Contains(c.Name))
                .Iter(c => c.AddAttribute(Driver.MustKeepAttr));

            program.AddTopLevelDeclarations(added);

            return markkeep;
        }

        static void DropConstants(Program program, HashSet<string> drop)
        {
            // Prune, according to annotations
            var constants = new HashSet<string>(
                program.TopLevelDeclarations.OfType<Constant>()
                .Select(c => c.Name));

            var dontdrop = constants.Difference(drop);

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, dontdrop, true);
            program.RemoveTopLevelDeclarations(c => c is Constant && drop.Contains((c as Constant).Name));
        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            //Log(0);
            System.Diagnostics.Process.GetCurrentProcess()
                .Kill();
        }

        static void Log(int i)
        {
            /*
            if (ForLogging == null) return;

            ForLogging.TopLevelDeclarations.OfType<Constant>()
                .Where(c => keep.Contains(c.Name))
                .Iter(c => c.AddAttribute(MustKeepAttr));

            ForLogging.TopLevelDeclarations.OfType<Constant>()
                .Where(c => dropped.Contains(c.Name))
                .Iter(c => c.AddAttribute(DropAttr));

            BoogieUtil.PrintProgram(ForLogging, string.Format("pmh_logged{0}.bpl", i == 0 ? "" : i.ToString()));
             */
        }

        public static Program InjectDualityProof(Program program, string DualityProofFile)
        {
            Program DualityProof;

            using (var st = new System.IO.StreamReader(DualityProofFile))
            {
                var s = ParserHelper.Fill(st, new List<string>());
                // replace %i by bound_var_i
                for (int i = 1; i <= 9; i++)
                {
                    s = s.Replace(string.Format("%{0}", i), string.Format("pm_bv_{0}", i));
                }
                var v = Parser.Parse(s, DualityProofFile, out DualityProof);
                if (v != 0) throw new Exception("Failed to parse " + DualityProofFile);
            }


            var implToContracts = new Dictionary<string, List<Expr>>();
            foreach (var proc in DualityProof.TopLevelDeclarations.OfType<Procedure>())
            {
                implToContracts.Add(proc.Name, new List<Expr>());
                foreach (var ens in proc.Ensures)
                {
                    implToContracts[proc.Name].AddRange(ProofMin.GetExprConjunctions(ens.Condition));
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
                if (QKeyValue.FindBoolAttribute(proc.Attributes, "nohoudini"))
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

        static void Initalize(string boogieOptions)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
            CommandLineOptions.Clo.ContractInfer = true;
            CommandLineOptions.Clo.RecursionBound = 2;
            BoogieUtil.InitializeBoogie(boogieOptions);
            cba.Util.BoogieVerify.options = new BoogieVerifyOptions();
            cba.Util.BoogieVerify.options.newStratifiedInlining = true;
            cba.Util.BoogieVerify.options.newStratifiedInliningAlgo = "";
            //cba.Util.BoogieVerify.options.useDI = true;
            cba.Util.BoogieVerify.options.extraFlags.Add("SiStingy");

            BoogieVerify.removeAsserts = false;
            cba.PersistentCBAProgram.useIO = true;
            ProgTransformation.PersistentProgramIO.useFiles = true;
        }
    }

    class ProofMin
    {
        HashSet<string> keep;
        HashSet<string> dropped;

        Stopwatch sw;
        bool usePerf;
        Random rand;
        PersistentProgram inprog;
        Dictionary<string, int> candidateToCost;

        static int InvocationCounter = 0;

        public ProofMin(PersistentProgram program, bool usePerf)
        {
            keep = new HashSet<string>();
            dropped = null;
            sw = new Stopwatch();
            this.usePerf = usePerf;
            rand = new Random((int)DateTime.Now.Ticks);
            this.inprog = program;

            // logging
            program.writeToFile("pm_query" + (InvocationCounter++) + ".bpl");

            // gather keep vars
            var prog = inprog.getProgram();
            prog.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, Driver.MustKeepAttr))
                .Iter(c => keep.Add(c.Name));
        }

        public bool Run(out HashSet<string> constantsToKeep, out HashSet<string> constantsToDrop, out Dictionary<string, int> constantToPerf)
        {
            constantsToKeep = new HashSet<string>();
            constantToPerf = new Dictionary<string, int>();
            constantsToDrop = new HashSet<string>();
            dropped = new HashSet<string>();

            var program = inprog.getProgram();

            HashSet<string> assignment = null;
            HashSet<string> candidates = new HashSet<string>();
            candidateToCost = new Dictionary<string, int>();

            int perf = 0;

            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => candidates.Add(c.Name));

            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => candidates.Contains(c.Name))
                .Iter(c => candidateToCost.Add(c.Name, QKeyValue.FindIntAttribute(c.Attributes, Driver.CostAttr, 0)));

            var rt = PruneAndRun(inprog, candidates, out assignment, ref perf);

            if (rt != BoogieVerify.ReturnStatus.OK)
            {
                Console.WriteLine("Cannot minimize a non-correct program ({0})", rt);
                return false;
            }

            if (candidates.Count != assignment.Count)
                Console.WriteLine("Dropping {0} candidates", (candidates.Count - assignment.Count));

            dropped.UnionWith(candidates.Difference(assignment));
            keep.IntersectWith(assignment);
            candidates = assignment.Difference(keep);

            sw = new Stopwatch();
            sw.Start();

            // Prune
            var inlineDepthBound = Math.Max(0, CommandLineOptions.Clo.InlineDepth);
            for (int id = inlineDepthBound; id <= inlineDepthBound; id++)
            {
                CommandLineOptions.Clo.InlineDepth = id;
                Console.WriteLine("------ Inline Depth {0} -------", id);
                var additional = FindMin(inprog, candidates, constantToPerf, ref perf);

                // re-test the additional ones with higher inline depth
                keep = keep.Difference(additional);
                candidates = new HashSet<string>(additional);

                if (id != inlineDepthBound)
                {
                    var contracts = GetContracts();
                    foreach (var c in candidates)
                        Console.WriteLine("Potential at InDt {0}: {1}", id, contracts[c]);
                }
            }
            constantsToKeep = candidates;
            constantsToDrop = dropped;
            return true;
        }

        // Return the additional set of constants to keep
        HashSet<string> FindMin(PersistentProgram inprog, HashSet<string> candidates, Dictionary<string, int> constantToPerfDelta, ref int perf)
        {
            var iter = 1;
            var assignment = new HashSet<string>();
            var additional = new HashSet<string>();
            candidates = new HashSet<string>(candidates);

            while (candidates.Count != 0)
            {
                Console.WriteLine("------ ITER {0} -------", iter++);

                // Drop one and re-run
                var c = PickRandom(candidates);
                candidates.Remove(c);

                Console.WriteLine("  >> Trying {0}", c);

                int inlined = perf;
                var rt = PruneAndRun(inprog, candidates.Union(keep), out assignment, ref inlined);

                if (rt == BoogieVerify.ReturnStatus.OK)
                {
                    // dropping was fine
                    Console.WriteLine("  >> Dropping it and {0} others", (candidates.Count + keep.Count - assignment.Count));
                    constantToPerfDelta.Add(c, (inlined - perf));

                    // MustKeep is a subset of assignment, if no user annotation is given.
                    // Under user annotations, mustkeep is really "should keep"
                    //Debug.Assert(mustkeep.IsSubsetOf(assignment));
                    keep.IntersectWith(assignment);

                    dropped.Add(c);
                    dropped.UnionWith(candidates.Union(keep).Difference(assignment));

                    candidates = assignment;
                    candidates.ExceptWith(keep);

                    perf = inlined;

                    Debug.Assert(!candidates.Contains(c));
                }
                else
                {
                    Console.WriteLine("  >> Cannot drop");
                    keep.Add(c);
                    additional.Add(c);
                }

                //Log(iter);
                Console.WriteLine("Time elapsed: {0} sec", sw.Elapsed.TotalSeconds.ToString("F2"));
            }

            return additional.Intersection(keep);
        }


        int PerfMetric(int n)
        {
            if (!usePerf) return Int32.MaxValue;
            if (n < 50) return (n + 100);
            return 2 * n;
        }

        // pick one with max cost randomly
        string PickRandom(HashSet<string> set)
        {
            Debug.Assert(set.Count != 0);

            if (rand == null)
            {
                rand = new Random((int)DateTime.Now.Ticks);
            }

            var max = set.Select(c => candidateToCost[c]).Max();
            var selected = set.Where(s => candidateToCost[s] == max);

            var ind = rand.Next(selected.Count());
            return selected.ToList()[ind];
        }

        public Dictionary<string, Expr> GetContracts()
        {
            var program = inprog.getProgram();
            var constants = new HashSet<string>(program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Select(c => c.Name));

            return
                CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, constants);
        }

        public void RunOnce(bool printcontracts)
        {
            var program = inprog.getProgram();
            program.Typecheck();
            BoogieUtil.PrintProgram(program, "hi_query.bpl");

            Console.WriteLine("Running HoudiniLite");
            var assignment = CoreLib.HoudiniInlining.RunHoudini(program, true);
            Console.WriteLine("Inferred {0} contracts", assignment.Count);

            // Read the program again, add contracts
            program = inprog.getProgram();
            program.Typecheck();

            var contracts =
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

            if (printcontracts)
            {
                foreach (var tup in contracts)
                    Console.WriteLine("{0}: {1}", tup.Key, tup.Value);

            }
        }

        static int IterCnt = 0;

        BoogieVerify.ReturnStatus PruneAndRun(PersistentProgram inp, HashSet<string> candidates, out HashSet<string> assignment, ref int inlined)
        {
            IterCnt++;

            var program = inp.getProgram();
            program.Typecheck();

            // Remove non-candidates
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, candidates, true);
            program.RemoveTopLevelDeclarations(decl => (decl is Constant) && QKeyValue.FindBoolAttribute(decl.Attributes, "existential") &&
                !candidates.Contains((decl as Constant).Name));

            BoogieUtil.PrintProgram(program, "hi_query" + IterCnt + ".bpl");

            // Run Houdini
            assignment = CoreLib.HoudiniInlining.RunHoudini(program, true);
            Console.WriteLine("  >> Contracts: {0}", assignment.Count);

            // Read the program again, add contracts
            program = inp.getProgram();
            program.Typecheck();

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);

            BoogieUtil.PrintProgram(program, "si_query" + IterCnt + ".bpl");

            // Run SI
            var err = new List<BoogieErrorTrace>();

            // Set bound
            BoogieVerify.options.maxInlinedBound = 0;
            if (inlined != 0)
                BoogieVerify.options.maxInlinedBound = PerfMetric(inlined);

            var rstatus = BoogieVerify.Verify(program, out err, true);
            Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;


            return rstatus;
        }

        public static List<Expr> GetExprConjunctions(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.And);
        }

        public static List<Expr> GetExprDisjuncts(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.Or);
        }

        // Return the set of conjuncts of the expr
        public static List<Expr> GetSubExprs(Expr expr, BinaryOperator.Opcode op)
        {
            var conjuncts = new List<Expr>();
            if (expr is NAryExpr && (expr as NAryExpr).Fun is BinaryOperator &&
                ((expr as NAryExpr).Fun as BinaryOperator).Op == op)
            {
                var c0 = GetSubExprs((expr as NAryExpr).Args[0], op);
                var c1 = GetSubExprs((expr as NAryExpr).Args[1], op);
                conjuncts.AddRange(c0);
                conjuncts.AddRange(c1);
            }
            else
            {
                conjuncts.Add(expr);
            }

            return conjuncts;
        }

        // Break (a && b) || (c && d) to {a, b, c, d}
        public static List<Expr> BreakDownExpr(Expr expr)
        {
            var ret = new List<Expr>();
            var disj = GetExprDisjuncts(expr);
            disj.Iter(d => ret.AddRange(GetExprConjunctions(d)));
            return ret;
        }

    }
}
