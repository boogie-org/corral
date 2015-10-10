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
using Microsoft.Boogie.GraphUtil;

namespace CoreLib
{
    public static class HoudiniStats
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

        public static void PrintClock(string clock)
        {
            Debug.Assert(timeTaken.ContainsKey(clock));
            var v = timeTaken[clock];
            Console.WriteLine("Clock {0} = {1}", clock, v.TotalSeconds.ToString("F2"));
        }
    }

    public class DualHoudiniFail : Exception
    {
        public DualHoudiniFail(string msg) : base(msg) { }
    }

    public class HoudiniInlining : StratifiedInlining
    {
        public static readonly string CandidateFuncPrefix = "HoudiniLiteFunc$";
        public static readonly string CandidateFuncAssertedPrefix = "HoudiniLiteFuncAsserted$";
        static bool RobustAgainstEvaluate = false; // usually this is not needed
        public static bool DualHoudini = false;
        public static bool dbg = false;

        public HoudiniInlining(Program program, string logFilePath, bool appendLogFile, Action<Implementation> PassiveImplInstrumentation) :
            base(program, logFilePath, appendLogFile, PassiveImplInstrumentation)
        {
        }

        public static HashSet<string> RunHoudini(Program program, bool RobustAgainstEvaluate = false)
        {
            HoudiniStats.Reset();
            HoudiniInlining.RobustAgainstEvaluate = DualHoudini? false : RobustAgainstEvaluate;
            if (DualHoudini && CommandLineOptions.Clo.InlineDepth > 0)
                throw new DualHoudiniFail("InlineDepth not supported");

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
            var iterimpls = program.TopLevelDeclarations.OfType<Implementation>().ToList();
            iterimpls.Iter(impl => InstrumentEnsures(program, impl, CandidateFuncsAssumed[impl.Name], CandidateConstants));

            //BoogieUtil.PrintProgram(program, "h2.bpl");

            var RewriteAssumedToAssertedAction = new Action<Implementation>(impl =>
            {
                // Rewrite functions that are asserted
                var rewrite = new RewriteFuncs(AssumeToAssert);
                foreach (var blk in impl.Blocks)
                    foreach (var acmd in blk.Cmds.OfType<AssertCmd>())
                        acmd.Expr = rewrite.VisitExpr(acmd.Expr);

                var funcs = new HashSet<Function>(CandidateFuncsAssumed.Values);
                // Move call-site constant to the first argument of CandidateFuncs
                foreach (var blk in impl.Blocks)
                {
                    Expr cv = null;
                    // walk backwards
                    for (int i = blk.Cmds.Count - 1; i >= 0; i--)
                    {
                        var acmd = blk.Cmds[i] as AssumeCmd;
                        if (acmd == null) continue;

                        if (QKeyValue.FindBoolAttribute(acmd.Attributes, StratifiedVCGenBase.callSiteVarAttr))
                        {
                            cv = acmd.Expr;
                            continue;
                        }

                        InsertControlVar.Apply(acmd.Expr, funcs, cv);
                    }
                }

                //impl.Emit(new TokenTextWriter(Console.Out), 0);
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

                if (dbg) Console.WriteLine("Processing " + implName);
                prover.LogComment("Processing " + implName);

                prover.Push();

                var hvc = new HoudiniVC(hi.implName2StratifiedInliningInfo[implName], impls, assignment);
                var openCallSites = new HashSet<StratifiedCallSite>(hvc.CallSites);
                prover.Assert(hvc.vcexpr, true);

                var candidates = !DualHoudini ? new HashSet<string>(hvc.constantToAssertedExpr.Keys.Where(k => assignment.Contains(k))) :
                    new HashSet<string>(hvc.constantToAssumedExpr.Select(t => t.Item1).Where(k => assignment.Contains(k)));

                var provedTrue = new HashSet<string>();
                var provedFalse = new HashSet<string>();
                var idepth = Math.Max(0, CommandLineOptions.Clo.InlineDepth);

                // iterate over idepth
                while (true)
                {
                    // Part 1: over-approximate
                    var proved = ProveCandidates(prover, hvc.constantToAssertedExpr, hvc.constantToAssumedExpr, candidates.Difference(provedTrue.Union(provedFalse)));
                    provedTrue.UnionWith(proved);
                    if(dbg) Console.WriteLine("Proved {0} candiates at depth {1}", proved.Count, CommandLineOptions.Clo.InlineDepth - idepth);

                    if (idepth == 0 || openCallSites.Count == 0) break;

                    // Part 2: under-approximate
                    prover.Push();
                    foreach (var cs in openCallSites)
                        prover.Assert(cs.callSiteExpr, false);

                    var remaining = candidates.Difference(provedTrue.Union(provedFalse));
                    proved = ProveCandidates(prover, hvc.constantToAssertedExpr, hvc.constantToAssumedExpr, remaining);
                    provedFalse.UnionWith(remaining.Difference(proved));
                    if(dbg) Console.WriteLine("Disproved {0} candiates at depth {1}", remaining.Difference(proved).Count, CommandLineOptions.Clo.InlineDepth - idepth);

                    prover.Pop();

                    // resolved all?
                    if (candidates.Difference(provedTrue.Union(provedFalse)).Count == 0)
                        break;

                    // Inline one level
                    idepth--;
                    var nextOpenCallSites = new HashSet<StratifiedCallSite>();
                    foreach (var cs in openCallSites)
                    {
                        var callee = new HoudiniVC(hi.implName2StratifiedInliningInfo[cs.callSite.calleeName], impls, assignment);
                        var calleevc = cs.Attach(callee);
                        prover.Assert(prover.VCExprGen.Implies(cs.callSiteExpr, calleevc), true);
                        nextOpenCallSites.UnionWith(callee.CallSites);
                    }
                    openCallSites = nextOpenCallSites;
                }

                prover.Pop();

                var failed = candidates.Difference(provedTrue);
                assignment.ExceptWith(failed);

                if (failed.Count != 0)
                {
                    // add dependencies back into the worklist
                    if (!DualHoudini)
                    {
                        foreach (var caller in callgraph.Predecessors(implName))
                            worklist.Add(Tuple.Create(impl2Priority[caller], caller));
                    }
                    else
                    {
                        foreach (var caller in callgraph.Successors(implName))
                            worklist.Add(Tuple.Create(impl2Priority[caller], caller));
                    }
                }
            }

            HoudiniStats.Stop("MainLoop");

            hi.Close();

            return assignment;
        }

        // Returns the installed set of contracts
        public static Dictionary<string, Expr> InstrumentHoudiniAssignment(Program program, HashSet<string> assignment, bool dropOnly = false)
        {
            var ret = new Dictionary<string, Expr>();

            // Gather existential constants
            var CandidateConstants = new Dictionary<string, Constant>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => CandidateConstants.Add(c.Name, c));

            // Instrument the ensures
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var newens = new List<Ensures>();
                foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
                {
                    string constantName = null;
                    Expr expr = null;

                    var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                        ens.Condition, CandidateConstants.Keys, out constantName, out expr);

                    if (!match)
                        throw new Exception("HoudiniLite: Ensures without a candidate implication not yet supported");

                    if (!assignment.Contains(constantName))
                        continue;

                    if (!ret.ContainsKey(constantName))
                        ret.Add(constantName, expr);
                    else
                        ret[constantName] = Expr.And(ret[constantName], expr);

                    if (dropOnly)
                    {
                        newens.Add(ens);
                    }
                    else
                    {
                        // free ensures expr;
                        newens.Add(new Ensures(true, expr));
                    }
                }

                impl.Proc.Ensures.RemoveAll(e => !e.Free);
                impl.Proc.Ensures.AddRange(newens);
            }
            return ret;
        }


        // Prove candidates that hold (using an over-approximation, at the current inline depth).
        // Return the set of candidates proved correct
        static HashSet<string> ProveCandidates(ProverInterface prover, Dictionary<string, VCExpr> constantToAssertedExpr, List<Tuple<string, VCExpr, VCExpr>> constantToAssumedExpr, HashSet<string> candidates)
        {
            var remaining = new HashSet<string>(candidates);
            var reporter = new EmptyErrorReporter();
            var failed = new HashSet<string>();

            // for dual houdini, we have to iterate once around to the loop
            // even if remaining is empty
            bool secondtry = false; 

            while (true)
            {
                remaining.ExceptWith(failed);

                if (remaining.Count == 0 && (!DualHoudini || secondtry))
                    break;

                if (remaining.Count == 0)
                    secondtry = true;
                else
                    secondtry = false;

                HoudiniStats.ProverCount++;
                HoudiniStats.Start("ProverTime");

                prover.Push();

                var nameToCallSiteVar = new Dictionary<string, VCExprVar>();
                var callSiteVarToConstantToExpr = new Dictionary<string, Dictionary<string, VCExpr>>();

                if (!DualHoudini)
                {
                    // assert post
                    VCExpr toassert = VCExpressionGenerator.True;
                    foreach (var k in remaining)
                        toassert = prover.VCExprGen.And(toassert, constantToAssertedExpr[k]);

                    prover.Assert(toassert, false);
                }
                else
                {
                    // assume post of callees
                    foreach (var tup in constantToAssumedExpr)
                    {
                        if (!remaining.Contains(tup.Item1)) continue;
                        
                        var csVar = tup.Item2 as VCExprVar;
                        Debug.Assert(csVar != null);
                        if(!nameToCallSiteVar.ContainsKey(csVar.ToString()))
                            nameToCallSiteVar.Add(csVar.ToString(), csVar);

                        if (!callSiteVarToConstantToExpr.ContainsKey(csVar.ToString()))
                            callSiteVarToConstantToExpr.Add(csVar.ToString(), new Dictionary<string, VCExpr>());
                        callSiteVarToConstantToExpr[csVar.ToString()].Add(tup.Item1, tup.Item3);                        
                    }

                    foreach (var tup in callSiteVarToConstantToExpr)
                    {
                        var expr = VCExpressionGenerator.False;
                        tup.Value.Values.Iter(e => expr = prover.VCExprGen.Or(expr, e));
                        prover.Assert(prover.VCExprGen.Implies(nameToCallSiteVar[tup.Key], expr), true);
                    }

                }

                Dictionary<string, VCExprVar> recordingBool = null;
                if (RobustAgainstEvaluate)
                {
                    recordingBool = new Dictionary<string, VCExprVar>();
                    VCExpr torecord = VCExpressionGenerator.True;
                    foreach (var k in remaining)
                    {
                        var b = prover.VCExprGen.Variable("recordingVar_" + k, Microsoft.Boogie.Type.Bool);
                        recordingBool.Add(k, b);
                        torecord = prover.VCExprGen.And(torecord, prover.VCExprGen.Eq(b, constantToAssertedExpr[k]));
                    }
                    prover.Assert(torecord, true);
                }

                prover.Check();
                var outcome = prover.CheckOutcomeCore(reporter);

                // check which ones failed
                if (outcome == ProverInterface.Outcome.Invalid || outcome == ProverInterface.Outcome.Undetermined)
                {
                    var removed = 0;
                    if (!DualHoudini)
                    {
                        foreach (var k in remaining)
                        {
                            var b = recordingBool == null ? (bool)prover.Evaluate(constantToAssertedExpr[k])
                                : (bool)prover.Evaluate(recordingBool[k]);

                            if (!b)
                            {
                                failed.Add(k);
                                if (dbg) Console.WriteLine("Failed: {0}", k);
                                removed++;
                            }
                        }
                    }
                    else
                    {
                        foreach (var tup in callSiteVarToConstantToExpr)
                        {
                            if (!(bool)prover.Evaluate(nameToCallSiteVar[tup.Key]))
                                continue;
                            // call site taken
                            foreach (var tup2 in tup.Value)
                            {
                                if ((bool)prover.Evaluate(tup2.Value))
                                {
                                    failed.Add(tup2.Key);
                                    if (dbg) Console.WriteLine("Failed: {0}", tup2.Key);
                                    removed++;
                                }
                            }
                        }
                        if (removed == 0) throw new DualHoudiniFail("Nothing to drop");
                    }
                    Debug.Assert(removed != 0);
                    //if(dbg) Console.WriteLine("Query {0}: Invalid, {1} removed", HoudiniStats.ProverCount, removed);
                }

                HoudiniStats.Stop("ProverTime");
                prover.Pop();


                if (outcome == ProverInterface.Outcome.TimeOut || outcome == ProverInterface.Outcome.OutOfMemory)
                {
                    if (DualHoudini) throw new DualHoudiniFail("Timeout");
                    failed.UnionWith(remaining);
                    break;
                }

                if (outcome == ProverInterface.Outcome.Valid)
                {
                    //if(dbg) Console.WriteLine("Query {0}: Valid", HoudiniStats.ProverCount);
                    break;
                }
            }

            remaining.ExceptWith(failed);

            return remaining;
        }

        // Compute SCCs and determine a priority order for impls
        static Dictionary<string, int> DeterminePriorityOrder(Program program, Graph<string> callgraph)
        {
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            var sccs = new StronglyConnectedComponents<string>(callgraph.Nodes,
                new Adjacency<string>(n => DualHoudini ? callgraph.Successors(n) : callgraph.Predecessors(n)),
                new Adjacency<string>(n => DualHoudini ? callgraph.Predecessors(n) : callgraph.Successors(n)));
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
                new List<Variable> { BoogieAstFactory.MkFormal("a", Microsoft.Boogie.Type.Bool, true), 
                    BoogieAstFactory.MkFormal("b", Microsoft.Boogie.Type.Bool, true), BoogieAstFactory.MkFormal("c", Microsoft.Boogie.Type.Bool, true) },
                BoogieAstFactory.MkFormal("d", Microsoft.Boogie.Type.Bool, false));
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

        static void InstrumentEnsures(Program program, Implementation impl, Function CandidateFunc, Dictionary<string, Constant> CandidateConstants)
        {
            if (impl.Proc.Requires.Any(r => !r.Free))
                throw new Exception("HoudiniLite: Non-free requires not yet supported");

            // non-free ensures
            var newens = new List<Ensures>();
            foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
            {
                if (!DualHoudini)
                {
                    string constantName = null;
                    Expr expr = null;

                    var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                        ens.Condition, CandidateConstants.Keys, out constantName, out expr);

                    if (!match)
                        throw new Exception("HoudiniLite: Ensures without a candidate implication not yet supported: " + ens.Condition.ToString());

                    var constant = CandidateConstants[constantName];

                    // ensures f(true, constant, expr);
                    newens.Add(new Ensures(false,
                        new NAryExpr(Token.NoToken, new FunctionCall(CandidateFunc),
                            new List<Expr> { Expr.True, Expr.Ident(constant), expr })));
                }
                else
                {
                    var exprs = GetCandidateWithoutConstantDualHoudini(ens.Condition, s => CandidateConstants.ContainsKey(s));
                    if(exprs == null || exprs.Count() == 0)
                        throw new Exception("DualHoudiniLite: Ensures without proper candidate structure not yet supported: " + ens.Condition.ToString());
                    
                    // ensures f(true, constant, expr);
                    foreach(var tup in exprs)
                        newens.Add(new Ensures(false, new NAryExpr(Token.NoToken, new FunctionCall(CandidateFunc),
                            new List<Expr> { Expr.True, Expr.Ident(tup.Item1), tup.Item2 })));
                }
            }

            impl.Proc.Ensures.RemoveAll(e => !e.Free);
            impl.Proc.Ensures.AddRange(newens);
        }

        private static IEnumerable<Tuple<Constant, Expr>> GetCandidateWithoutConstantDualHoudini(Expr expr, Predicate<string> ValidConstant)
        {
            var ret = new List<Tuple<Constant, Expr>>();
            var disj = GetSubExprs(expr, BinaryOperator.Opcode.Or);
            foreach (var d in disj)
            {
                if (d is NAryExpr && (d as NAryExpr).Fun is BinaryOperator &&
                    ((d as NAryExpr).Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
                {
                    var constant = (d as NAryExpr).Args[0] as IdentifierExpr;
                    var e = (d as NAryExpr).Args[1];
                    if (constant == null || !ValidConstant(constant.Name))
                        return new List<Tuple<Constant, Expr>>();
                    ret.Add(Tuple.Create(constant.Decl as Constant, e));
                }
                else
                    return new List<Tuple<Constant, Expr>>();
            }
            return ret;
        }

        static List<Expr> GetSubExprs(Expr expr, BinaryOperator.Opcode op)
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

    class InsertControlVar : StandardVisitor
    {
        HashSet<Function> insertControlVar;
        Expr controlVar;

        public InsertControlVar(HashSet<Function> insertControlVar, Expr controlVar)
        {
            this.insertControlVar = insertControlVar;
            this.controlVar = controlVar;
        }

        public static void Apply(Expr expr, HashSet<Function> insertControlVar, Expr controlVar)
        {
            var iv = new InsertControlVar(insertControlVar, controlVar);
            iv.VisitExpr(expr);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var ret = base.VisitNAryExpr(node) as NAryExpr;
            if (ret.Fun is FunctionCall && insertControlVar.Contains((ret.Fun as FunctionCall).Func))
            {
                Debug.Assert(ret.Args[0] is LiteralExpr && (ret.Args[0] as LiteralExpr).Val is bool &&
                    (bool)(ret.Args[0] as LiteralExpr).Val == true);
                ret.Args[0] = controlVar;
            }
            return ret;
        }
    }

    class HoudiniVC : StratifiedVC
    {
        public List<Tuple<string, VCExpr, VCExpr>> constantToAssumedExpr;
        public Dictionary<string, VCExpr> constantToAssertedExpr;

        public HoudiniVC(StratifiedInliningInfo siInfo, HashSet<string> procCalls, HashSet<string> currentAssignment)
            : base(siInfo, procCalls)
        {
            var gen = siInfo.vcgen.prover.VCExprGen;
            // Remove CandiateFunc
            var fsp = new FindSummaryPred(gen);
            vcexpr = fsp.Apply(vcexpr);
            this.constantToAssumedExpr = fsp.constantToAssumedExpr;
            this.constantToAssertedExpr = fsp.constantToAssertedExpr;

            
            if (!HoudiniInlining.DualHoudini)
            {
                // Assume current summaries of callees
                foreach (var tup in constantToAssumedExpr)
                {
                    if (!currentAssignment.Contains(tup.Item1)) continue;
                    vcexpr = gen.And(vcexpr, gen.Implies(tup.Item2, tup.Item3));
                }
            }
            else
            {
                // Assert current post
                foreach (var tup in constantToAssertedExpr)
                {
                    if (!currentAssignment.Contains(tup.Key)) continue;
                    vcexpr = gen.And(vcexpr, gen.Not(tup.Value));
                }

            }
        }

        class FindSummaryPred : MutatingVCExprVisitor<bool>
        {
            public List<Tuple<string, VCExpr, VCExpr>> constantToAssumedExpr;
            public Dictionary<string, VCExpr> constantToAssertedExpr;

            public FindSummaryPred(VCExpressionGenerator gen)
                : base(gen)
            {
                constantToAssumedExpr = new List<Tuple<string, VCExpr, VCExpr>>();
                constantToAssertedExpr = new Dictionary<string, VCExpr>();
            }

            public VCExpr Apply(VCExpr expr)
            {
                return Mutate(expr, true);
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
                    var lt = retnary[1] as VCExprConstant;
                    Debug.Assert(lt != null);
                    constantToAssertedExpr.Add(lt.Name, retnary[2]);
                    return VCExpressionGenerator.True;
                }

                if (calleeName.StartsWith(HoudiniInlining.CandidateFuncPrefix))
                {
                    var lt = retnary[1] as VCExprConstant;
                    Debug.Assert(lt != null);
                    constantToAssumedExpr.Add(Tuple.Create(lt.Name, retnary[0], retnary[2]));
                    return VCExpressionGenerator.True;
                }

                return ret;

            }

        }


    }
}
