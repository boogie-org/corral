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

                boogieArgs += args[i] + " ";
            }
            Initalize(boogieArgs);

            var sw = new Stopwatch();
            sw.Start();

            var assignment = HoudiniInlining.RunHoudini(BoogieUtil.ReadAndResolve(file));

            sw.Stop();

            Console.WriteLine("HoudiniLite took: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));
            HoudiniStats.Print();
            Console.WriteLine("Num true = {0}", assignment.Count);
            Console.WriteLine("True assignment: {0}", assignment.Concat(" "));

            if (check)
            {
                sw.Restart();

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

        static void Initalize(string boogieOptions)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
            CommandLineOptions.Clo.ContractInfer = true;
            BoogieUtil.InitializeBoogie(boogieOptions);
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

    static class HoudiniStats
    {
        public static int ProverCount = 0;

        static Dictionary<string, TimeSpan> timeTaken = new Dictionary<string, TimeSpan>();
        static Dictionary<string, DateTime> clocks = new Dictionary<string, DateTime>();

        public static void Start(string name)
        {
            clocks[name] = DateTime.Now;
        }

        public static void Stop(string name)
        {
            Debug.Assert(clocks.ContainsKey(name));
            if (!timeTaken.ContainsKey(name)) timeTaken[name] = TimeSpan.Zero; // initialize
            timeTaken[name] += (DateTime.Now - clocks[name]);
        }

        public static void Reset()
        {
            ProverCount = 0;
            timeTaken = new Dictionary<string, TimeSpan>();
            clocks = new Dictionary<string, DateTime>();
        }

        public static void Print()
        {
            Console.WriteLine("Num queries = {0}", ProverCount);
            foreach (var clock in timeTaken)
            {
                Console.WriteLine("Clock {0} = {1}", clock.Key, clock.Value.TotalSeconds.ToString("F2"));
            }
        }
    }

    class HoudiniInlining : StratifiedInlining
    {
        public static readonly string CandidateFuncPrefix = "HoudiniLiteFunc$";
        public static readonly string CandidateFuncAssertedPrefix = "HoudiniLiteFuncAsserted$";

        public HoudiniInlining(Program program, string logFilePath, bool appendLogFile, Action<Implementation> PassiveImplInstrumentation) :
            base(program, logFilePath, appendLogFile, PassiveImplInstrumentation)
        {
        }

        public static HashSet<string> RunHoudini(Program program)
        {
            HoudiniStats.Reset();

            // Gather existential constants
            var CandidateConstants = new Dictionary<string, Constant>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => CandidateConstants.Add(c.Name, c));

            // Create a function, one for each impl, for book-keeping
            var CandidateFuncsAssumed = new Dictionary<string, Function>();
            var CandidateFuncsAsserted = new Dictionary<string, Function>();
            var AssumeToAssert = new Dictionary<Function, Function>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl =>
                    {
                        var fassumed = GetCandidateFunc(CandidateFuncPrefix, impl.Name);
                        var fasserted = GetCandidateFunc(CandidateFuncAssertedPrefix, impl.Name);
                        CandidateFuncsAssumed.Add(impl.Name, fassumed);
                        CandidateFuncsAsserted.Add(impl.Name, fasserted);
                        AssumeToAssert.Add(fassumed, fasserted);
                    });


            // Tag the ensures so we can keep track of them
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => InstrumentEnsures(impl, CandidateFuncsAssumed[impl.Name], CandidateConstants));

            // Rewrite functions that are asserted
            var RewriteAssumedToAssertedAction = new Action<Implementation>(impl =>
                {
                    var rewrite = new RewriteFuncs(AssumeToAssert);
                    foreach (var blk in impl.Blocks)
                        foreach (var acmd in blk.Cmds.OfType<AssertCmd>())
                            acmd.Expr = rewrite.VisitExpr(acmd.Expr);
                });

            program.AddTopLevelDeclarations(CandidateFuncsAssumed.Values);
            program.AddTopLevelDeclarations(CandidateFuncsAsserted.Values);

            var callgraph = BoogieUtil.GetCallGraph(program);
            var impl2Priority = DeterminePriorityOrder(program, callgraph);
            var impls = new HashSet<string>(impl2Priority.Keys);

            HoudiniStats.Start("VCGen");

            // VC Gen
            var hi = new HoudiniInlining(program, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, RewriteAssumedToAssertedAction);

            HoudiniStats.Stop("VCGen");

            var worklist = new SortedSet<Tuple<int, string>>();
            impl2Priority.Iter(tup => worklist.Add(Tuple.Create(tup.Value, tup.Key)));

            // Current assignment: set of true constants
            // Initially: everything is true
            var assignment = new HashSet<string>(CandidateConstants.Keys);

            var prover = hi.prover;
            var reporter = new EmptyErrorReporter();

            // assert true to flush all one-time axioms, decls, etc
            prover.Assert(VCExpressionGenerator.True, true);

            HoudiniStats.Start("MainLoop");

            // worklist algorithm
            while (worklist.Any())
            {
                var implName = worklist.First().Item2;
                worklist.Remove(worklist.First());

                prover.LogComment("Processing " + implName);
                prover.Push();

                HoudiniStats.Start("HVC1");
                var hvc = new HoudiniVC(hi.implName2StratifiedInliningInfo[implName], impls, assignment);
                HoudiniStats.Stop("HVC1");
                HoudiniStats.Start("HVC2");
                var openCallSites = new HashSet<StratifiedCallSite>(hvc.CallSites);
                prover.Assert(hvc.vcexpr, true);
                HoudiniStats.Stop("HVC2");
                

                // Check for each candidate, if it holds
                var changed = false;
                while (true)
                {
                    var remaining = hvc.constantToAssertedExpr.Keys.Where(k => assignment.Contains(k)).ToList();

                    if (remaining.Count == 0)
                        break;

                    HoudiniStats.ProverCount++;
                    HoudiniStats.Start("ProverTime");

                    prover.Push();

                    // assert them all
                    VCExpr toassert = VCExpressionGenerator.True;
                    foreach (var k in remaining)
                        toassert = prover.VCExprGen.And(toassert, hvc.constantToAssertedExpr[k]);

                    prover.Assert(toassert, false);

                    prover.Check();
                    var outcome = prover.CheckOutcomeCore(reporter);

                    // check which ones failed
                    if (outcome == ProverInterface.Outcome.Invalid || outcome == ProverInterface.Outcome.Undetermined)
                    {
                        //var removed = 0;
                        foreach (var k in remaining)
                        {
                            var b = (bool)prover.Evaluate(hvc.constantToAssertedExpr[k]);
                            if (!b)
                            {
                                assignment.Remove(k);
                                //removed++;
                                changed = true;
                            }
                        }
                        Debug.Assert(changed);
                        //Console.WriteLine("Query {0}: Invalid for {1}, {2} removed", HoudiniStats.ProverCount, implName, removed);
                    }

                    HoudiniStats.Stop("ProverTime");
                    prover.Pop();


                    if (outcome == ProverInterface.Outcome.TimeOut || outcome == ProverInterface.Outcome.OutOfMemory)
                    {
                        assignment.ExceptWith(remaining);
                        changed = true;
                        break;
                    }

                    if (outcome == ProverInterface.Outcome.Valid)
                    {
                        //Console.WriteLine("Query {0}: Valid for {1}", HoudiniStats.ProverCount, implName);
                        break;
                    }

                }

                prover.Pop();

                if (changed)
                {
                    // add dependencies back
                    foreach (var caller in callgraph.Predecessors(implName))
                        worklist.Add(Tuple.Create(impl2Priority[caller], caller));
                }
            }

            HoudiniStats.Stop("MainLoop");

            return assignment;
        }

        // Compute SCCs and determine a priority order for impls
        static Dictionary<string, int> DeterminePriorityOrder(Program program, Graph<string> callgraph)
        {
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));            

            var sccs = new StronglyConnectedComponents<string>(callgraph.Nodes,
                new Adjacency<string>(n => callgraph.Predecessors(n)),
                new Adjacency<string>(n => callgraph.Successors(n)));
            sccs.Compute();

            // impl -> priority
            var impl2Priority = new Dictionary<string, int>();
            int p = 0;
            foreach (var scc in sccs)
            {
                foreach (var impl in scc)
                {
                    impl2Priority.Add(impl, p);
                    p++;
                }
            }

            return impl2Priority;
        }

        static Function GetCandidateFunc(string prefix, string implname)
        {
            return new Function(Token.NoToken, prefix + implname,
                new List<Variable> { BoogieAstFactory.MkFormal("a", Microsoft.Boogie.Type.Bool, true), BoogieAstFactory.MkFormal("b", Microsoft.Boogie.Type.Bool, true) },
                BoogieAstFactory.MkFormal("c", Microsoft.Boogie.Type.Bool, false));
        }

        static string GetImplName(string candidateFunc)
        {
            if (candidateFunc.StartsWith(CandidateFuncPrefix))
                return candidateFunc.Substring(CandidateFuncPrefix.Length);

            if (candidateFunc.StartsWith(CandidateFuncAssertedPrefix))
                return candidateFunc.Substring(CandidateFuncAssertedPrefix.Length);

            Debug.Assert(false);
            return null;
        }

        static void InstrumentEnsures(Implementation impl, Function CandidateFunc, Dictionary<string, Constant> CandidateConstants)
        {
            if (impl.Proc.Requires.Any(r => !r.Free))
                throw new Exception("HoudiniLite: Non-free requires not yet supported");

            // non-free ensures
            var newens = new List<Ensures>();
            foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
            {
                string constantName = null;
                Expr expr = null;

                var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                    ens.Condition, CandidateConstants.Keys, out constantName, out expr);

                if(!match)
                    throw new Exception("HoudiniLite: Ensures without a candidate implication not yet supported");

                var constant = CandidateConstants[constantName];

                // ensures f(constant, expr);
                newens.Add(new Ensures(false,
                    new NAryExpr(Token.NoToken, new FunctionCall(CandidateFunc),
                        new List<Expr> { Expr.Ident(constant), expr })));
            }

            impl.Proc.Ensures.RemoveAll(e => !e.Free);
            impl.Proc.Ensures.AddRange(newens);
        }

        public VCExpr GetSummary(string proc)
        {
            throw new NotImplementedException();
        }

        public HashSet<string> GetCurrentAssignment()
        {
            throw new NotImplementedException();
        }
    }

    class RewriteFuncs : StandardVisitor
    {
        Dictionary<Function, Function> rewrite;

        public RewriteFuncs(Dictionary<Function, Function> rewrite)
        {
            this.rewrite = rewrite;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var ret = base.VisitNAryExpr(node) as NAryExpr;
            if (ret.Fun is FunctionCall && rewrite.ContainsKey((ret.Fun as FunctionCall).Func))
            {
                return new NAryExpr(Token.NoToken, new FunctionCall(rewrite[(ret.Fun as FunctionCall).Func]),
                    ret.Args);
            }
            return ret;
        }
    }
    
    class HoudiniVC : StratifiedVC
    {
        public Dictionary<string, Dictionary<string, VCExpr>> calleeToConstantToAssumedExpr;
        public Dictionary<string, VCExpr> constantToAssertedExpr;

        public HoudiniVC(StratifiedInliningInfo siInfo, HashSet<string> procCalls, HashSet<string> currentAssignment)
            : base(siInfo, procCalls)
        {
            var gen = siInfo.vcgen.prover.VCExprGen;
            // Remove CandiateFunc
            var fsp = new FindSummaryPred(gen);
            vcexpr = fsp.Mutate(vcexpr, true);
            this.calleeToConstantToAssumedExpr = fsp.calleeToConstantToAssumedExpr;
            this.constantToAssertedExpr = fsp.constantToAssertedExpr;

            // Assume current summaries of callees
            foreach (var cs in CallSites)
            {
                if (!calleeToConstantToAssumedExpr.ContainsKey(cs.callSite.calleeName))
                    continue;

                foreach (var tup in calleeToConstantToAssumedExpr[cs.callSite.calleeName])
                {
                    if (!currentAssignment.Contains(tup.Key)) continue;

                    vcexpr = gen.And(vcexpr,
                        gen.Implies(cs.callSiteExpr, tup.Value));
                }
            }
        }

        class FindSummaryPred : MutatingVCExprVisitor<bool>
        {
            public Dictionary<string, Dictionary<string, VCExpr>> calleeToConstantToAssumedExpr;
            public Dictionary<string, VCExpr> constantToAssertedExpr;

            public FindSummaryPred(VCExpressionGenerator gen)
                : base(gen)
            {
                calleeToConstantToAssumedExpr = new Dictionary<string, Dictionary<string, VCExpr>>();
                constantToAssertedExpr = new Dictionary<string, VCExpr>();
            }

            protected override VCExpr UpdateModifiedNode(VCExprNAry originalNode,
                                                  List<VCExpr> newSubExprs,
                                                  bool changed,
                                                  bool arg)
            {
                VCExpr ret;
                if (changed)
                    ret = Gen.Function(originalNode.Op,
                                       newSubExprs, originalNode.TypeArguments);
                else
                    ret = originalNode;

                VCExprNAry retnary = ret as VCExprNAry;
                if (retnary == null) return ret;
                var op = retnary.Op as VCExprBoogieFunctionOp;
                if (op == null)
                    return ret;

                string calleeName = op.Func.Name;

                if (calleeName.StartsWith(HoudiniInlining.CandidateFuncAssertedPrefix))
                {
                    var lt = retnary[0] as VCExprConstant;
                    Debug.Assert(lt != null);
                    constantToAssertedExpr.Add(lt.Name, retnary[1]);
                    return VCExpressionGenerator.True;
                }

                if (calleeName.StartsWith(HoudiniInlining.CandidateFuncPrefix))
                {
                    var calleeProc = calleeName.Substring(HoudiniInlining.CandidateFuncPrefix.Length);
                    var lt = retnary[0] as VCExprConstant;
                    Debug.Assert(lt != null);
                    if (!calleeToConstantToAssumedExpr.ContainsKey(calleeProc))
                        calleeToConstantToAssumedExpr.Add(calleeProc, new Dictionary<string, VCExpr>());

                    if (calleeToConstantToAssumedExpr[calleeProc].ContainsKey(lt.Name))
                        calleeToConstantToAssumedExpr[calleeProc][lt.Name] = Gen.And(calleeToConstantToAssumedExpr[calleeProc][lt.Name], retnary[1]);
                    else
                        calleeToConstantToAssumedExpr[calleeProc].Add(lt.Name, retnary[1]);

                    return VCExpressionGenerator.True;
                }

                return ret;

            }

        }


    }
    
}
