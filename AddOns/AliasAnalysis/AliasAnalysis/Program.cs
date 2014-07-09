using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;

namespace AliasAnalysis
{
    class Driver
    {
        static void Main(string[] args)
        {
            bool doSSA = true;
            var dbg = false;
            string prune = null;

            if (args.Length < 1)
            {
                Console.WriteLine("Usage: AliasAnalysis file.bpl [flags]");
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();
            if (args.Any(s => s == "/nossa"))
                doSSA = false;
            if (args.Any(s => s == "/dbg"))
                dbg = true;
            args.Where(s => s.StartsWith("/prune:"))
                .Iter(s => prune = s.Split(':')[1]);

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            var program = BoogieUtil.ParseProgram(args[0]);
            Program origProgram = null;
            if (prune != null)
                origProgram = (new FixedDuplicator(false)).VisitProgram(program);

            program.Resolve();

            // Make sure that aliasing queries are on identifiers only
            SimplifyAliasingQueries.Simplify(program);

            // Do SSA
            if (doSSA)
            {
                program =
                  SSA.Compute(program, PhiFunctionEncoding.Verifiable, new HashSet<string> { "int" });
                if (dbg) BoogieUtil.PrintProgram(program, "ssa.bpl");
            }

            AliasAnalysis.dbg = dbg;
            AliasConstraintSolver.dbg = dbg;

            var ret =
            AliasAnalysis.DoAliasAnalysis(program);

            foreach (var tup in ret.aliases)
                Console.WriteLine("{0}: {1}", tup.Key, tup.Value);

            if (prune != null)
            {
                origProgram.Resolve();
                PruneAliasingQueries.Prune(origProgram, ret);
                BoogieUtil.PrintProgram(origProgram, prune);
            }
        }

    }

    public class PruneAliasingQueries : FixedVisitor
    {
        AliasAnalysisResults result;
        
        Function AllocationSites;
        Dictionary<string, Constant> asToAS;

        PruneAliasingQueries(AliasAnalysisResults result, Function AllocationSites, Dictionary<string, Constant> asToAS)
        {
            this.result = result;
            this.AllocationSites = AllocationSites;
            this.asToAS = asToAS;
        }

        public static void Prune(Program program, AliasAnalysisResults result)
        {
            Function AllocationSites = null;
            Dictionary<string, Constant> asToAS = new Dictionary<string, Constant>();

            if (result.allocationSites.Any())
            {
                // type AS;
                var asType = new TypeCtorDecl(Token.NoToken, "AS", 0);
                program.TopLevelDeclarations.Add(asType);
                // add AS constants
                var sites = new HashSet<string>();
                result.allocationSites.Values.Iter(v => sites.UnionWith(v));
                foreach (var s in sites)
                {
                    var c = new Constant(Token.NoToken,
                            new TypedIdent(Token.NoToken, "AS_" + s, new CtorType(Token.NoToken, asType, new List<btype>())),
                            true);
                    asToAS.Add(s, c);
                    program.TopLevelDeclarations.Add(c);
                }
                // Add: function AllocationSites(int) : AS
                AllocationSites = new Function(Token.NoToken, "AllocationSites", new List<Variable>{
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "a", btype.Int), true)},
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "b", new CtorType(Token.NoToken, asType, new List<btype>())), false));
                program.TopLevelDeclarations.Add(AllocationSites);
            }

            var prune = new PruneAliasingQueries(result, AllocationSites, asToAS);

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => prune.VisitImplementation(impl));
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => prune.PruneFalseBranches(impl));
            var main = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .FirstOrDefault();
            if (main != null)
                BoogieUtil.pruneProcs(program, main.Name);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var fcall = node.Fun as FunctionCall;
            if (fcall != null && result.aliases.ContainsKey(fcall.FunctionName))
            {
                if (result.aliases[fcall.FunctionName] == false)
                {
                    return Expr.False;
                }
                else
                {
                    return Expr.Eq(node.Args[0], node.Args[1]);
                }
            }

            if (fcall != null && result.allocationSites.ContainsKey(fcall.FunctionName))
            {
                Expr r = Expr.False;
                foreach (var s in result.allocationSites[fcall.FunctionName])
                    r = Expr.Or(r, Expr.Eq(new NAryExpr(Token.NoToken, new FunctionCall(AllocationSites), new List<Expr>{node.Args[0]}), Expr.Ident(asToAS[s])));
                return r;
            }

            var ret = base.VisitNAryExpr(node);

            var nary = ret as NAryExpr;
            if (nary != null && nary.Fun is BinaryOperator
                && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.And)
            {
                if (nary.Args.Any(a => a == Expr.False))
                    return Expr.False;
            }
            if (nary != null && nary.Fun is UnaryOperator
                && (nary.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not
                && nary.Args[0] is LiteralExpr
                && (nary.Args[0] as LiteralExpr).IsFalse)
            {
                return Expr.True;
            }

            return ret;
        }

        public void PruneFalseBranches(Implementation impl)
        {
            foreach (var block in impl.Blocks)
            {
                var ncmds = new List<Cmd>();
                foreach (var cmd in block.Cmds)
                {
                    ncmds.Add(cmd);
                    if (BoogieUtil.isAssumeFalse(cmd))
                        break;
                }
                block.Cmds = ncmds;
            }

            var tt = CommandLineOptions.Clo.PruneInfeasibleEdges;
            CommandLineOptions.Clo.PruneInfeasibleEdges = true;
            impl.PruneUnreachableBlocks();
            CommandLineOptions.Clo.PruneInfeasibleEdges = tt;
        }
    }

    public class SimplifyAliasingQueries : FixedVisitor
    {
        Implementation currImpl;
        int counter;
        HashSet<string> aliasingFunctions;
        List<Cmd> extraCmds;

        SimplifyAliasingQueries()
        {
            currImpl = null;
            counter = 0;
            aliasingFunctions = new HashSet<string>();
            extraCmds = new List<Cmd>();
        }

        public static void Simplify(Program program)
        {
            var sa = new SimplifyAliasingQueries();
            sa.VisitProgram(program);
        }

        public override Program VisitProgram(Program node)
        {
            node.TopLevelDeclarations.OfType<Function>()
                .Where(func => BoogieUtil.checkAttrExists("aliasingQuery", func.Attributes))
                .Iter(func => aliasingFunctions.Add(func.Name));

            return base.VisitProgram(node);
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            currImpl = node;
            node = base.VisitImplementation(node);
            currImpl = null;
            return node;
        }

        public override Block VisitBlock(Block node)
        {
            var newcmds = new List<Cmd>();
            foreach (var cmd in node.Cmds)
            {
                extraCmds = new List<Cmd>();
                base.Visit(cmd);
                newcmds.AddRange(extraCmds);
                newcmds.Add(cmd);
            }
            node.Cmds = newcmds;
            return node;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall && aliasingFunctions.Contains((node.Fun as FunctionCall).FunctionName))
            {
                if (currImpl == null) return node;

                for (int i = 0; i < node.Args.Count; i++)
                {
                    if (node.Args[i] is IdentifierExpr) continue;
                    var lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "aaTmp" + (counter++).ToString(),
                        btype.Int));
                    currImpl.LocVars.Add(lv);
                    extraCmds.Add(BoogieAstFactory.MkVarEqExpr(lv, node.Args[i]));
                    node.Args[i] = Expr.Ident(lv);
                }
            }
            return base.VisitNAryExpr(node);
        }
    }

    /*
    public class AliasQuery
    {
        public Variable var1;
        public Implementation impl1;
        public Variable var2;
        public Implementation impl2;

        public AliasQuery(GlobalVariable var1, GlobalVariable var2)
            :this(var1, null, var2, null)
        { }

        public AliasQuery(GlobalVariable var1, Variable var2, Implementation impl2)
            : this(var1, null, var2, impl2)
        { }

        public AliasQuery(Variable var1, Implementation impl1, Variable var2, Implementation impl2)
        {
            this.var1 = var1;
            this.var2 = var2;
            this.impl1 = impl1;
            this.impl2 = impl2;
        }

        public static AliasQuery Parse(string line, Program program)
        {
            var sp = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
            if (sp.Length != 4)
                return null;
            var nameToImpl = BoogieUtil.nameImplMapping(program);
            var impl1 = nameToImpl.ContainsKey(sp[1]) ? nameToImpl[sp[1]] : null;
            var impl2 = nameToImpl.ContainsKey(sp[3]) ? nameToImpl[sp[3]] : null;
            Variable var1, var2;

            if (impl1 == null)
            {
                var1 = program.TopLevelDeclarations.OfType<GlobalVariable>()
                    .Where(g => g.Name == sp[0]).FirstOrDefault();
            }
            else
            {
                var1 = impl1.LocVars
                    .Where(g => g.Name == sp[0]).FirstOrDefault();
            }
            if (impl2 == null)
            {
                var2 = program.TopLevelDeclarations.OfType<GlobalVariable>()
                    .Where(g => g.Name == sp[2]).FirstOrDefault();
            }
            else
            {
                var2 = impl2.LocVars
                    .Where(g => g.Name == sp[2]).FirstOrDefault();
            }

            if (var1 == null || var2 == null)
                return null;
            return new AliasQuery(var1, impl1, var2, impl2);
        }
    }
    */

    public class AliasAnalysisResults
    {
        public Dictionary<string, bool> aliases;
        public Dictionary<string, HashSet<string>> allocationSites;
        public AliasAnalysisResults()
        {
            aliases = new Dictionary<string, bool>();
            allocationSites = new Dictionary<string, HashSet<string>>();
        }
    }

    public class AliasAnalysis
    {

        Program program;
        HashSet<string> allocatedConstants;
        AliasConstraintSolver solver;
        int counter;
        public static bool dbg = false;

        private AliasAnalysis(Program program)
        {
            this.program = program;
            this.allocatedConstants = new HashSet<string>();
            solver = new AliasConstraintSolver();
            counter = 0;
        }

        public static AliasAnalysisResults DoAliasAnalysis(Program program)
        {
            var aa = new AliasAnalysis(program);
            if (dbg) Console.WriteLine("Creating Points-to constraints ... ");
            aa.Process();
            if (dbg) Console.WriteLine("Done");
            if (dbg) Console.WriteLine("Solving Points-to constraints ... ");
            aa.solver.Solve();
            if (dbg) Console.WriteLine("Done");

            // Solve the queries
            return
                AliasQuerySolver.Solve(program, new Func<Variable, Variable, Implementation, bool>((v1, v2, impl) => aa.solver.IsAlias(
                    aa.ConstructVariableName(v1, impl.Name),
                    aa.ConstructVariableName(v2, impl.Name))),
                    new Func<Variable, Variable, Implementation, bool>((v1, v2, impl) => aa.solver.IsReachable(
                    aa.ConstructVariableName(v1, impl.Name),
                    aa.ConstructVariableName(v2, impl.Name))),
                    new Func<Variable, Implementation, HashSet<string>>((v1, impl) => aa.solver.AllocationSites(
                    aa.ConstructVariableName(v1, impl.Name)))
                    );
        }

        class AliasQuerySolver : FixedVisitor
        {
            Func<Variable, Variable, Implementation, bool> IsAlias;
            Func<Variable, Variable, Implementation, bool> IsReachable;
            Func<Variable, Implementation, HashSet<string>> PointsToSet;
            HashSet<string> aliasQueryFuncs;
            HashSet<string> reachableQueryFuncs;
            HashSet<string> allocationSitesQueryFuncs;
            AliasAnalysisResults results;
            Implementation currImpl;

            private AliasQuerySolver(HashSet<string> aliasQueryFuncs, HashSet<string> reachableQueryFuncs, HashSet<string> allocationSitesQueryFuncs, 
                Func<Variable, Variable, Implementation, bool> IsAlias,
                Func<Variable, Variable, Implementation, bool> IsReachable,
                Func<Variable, Implementation, HashSet<string>> PointsToSet)
            {
                this.aliasQueryFuncs = aliasQueryFuncs;
                this.reachableQueryFuncs = reachableQueryFuncs;
                this.allocationSitesQueryFuncs = allocationSitesQueryFuncs;
                this.results = new AliasAnalysisResults();
                this.IsAlias = IsAlias;
                this.IsReachable = IsReachable;
                this.PointsToSet = PointsToSet;
                aliasQueryFuncs.Iter(q => results.aliases.Add(q, false));
                reachableQueryFuncs.Iter(q => results.aliases.Add(q, false));
                allocationSitesQueryFuncs.Iter(q => results.allocationSites.Add(q, new HashSet<string>()));
            }

            public static AliasAnalysisResults Solve(Program program, 
                Func<Variable, Variable, Implementation, bool> IsAlias,
                Func<Variable, Variable, Implementation, bool> IsReachable,
                Func<Variable, Implementation, HashSet<string>> PointsToSet)
            {
                var aq = new HashSet<string>();
                var rq = new HashSet<string>();
                var asq = new HashSet<string>();
                foreach (var func in program.TopLevelDeclarations.OfType<Function>()
                    .Where(func => BoogieUtil.checkAttrExists("aliasingQuery", func.Attributes)))
                {
                    var p = QKeyValue.FindStringAttribute(func.Attributes, "aliasingQuery");
                    if(p != null && p == "transitive") rq.Add(func.Name);
                    else if(p != null && p == "allocationsites") asq.Add(func.Name);
                    else aq.Add(func.Name);
                }

                var qSolver = new AliasQuerySolver(aq, rq, asq, IsAlias, IsReachable, PointsToSet);
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl =>
                    {
                        qSolver.currImpl = impl;
                        qSolver.VisitImplementation(impl);
                    });

                return qSolver.results;
            }

            public override Expr VisitNAryExpr(NAryExpr node)
            {
                if (node.Fun is FunctionCall)
                {
                    var func = (node.Fun as FunctionCall).FunctionName;
                    if (aliasQueryFuncs.Contains(func) || reachableQueryFuncs.Contains(func))
                    {
                        Debug.Assert(node.Args.Count == 2);
                        var arg1 = node.Args[0] as IdentifierExpr;
                        var arg2 = node.Args[1] as IdentifierExpr;
                        Debug.Assert(arg1 != null && arg2 != null);
                        if (!results.aliases[func])
                        {
                            results.aliases[func] = aliasQueryFuncs.Contains(func) ?
                                IsAlias(arg1.Decl, arg2.Decl, currImpl) :
                                IsReachable(arg1.Decl, arg2.Decl, currImpl);

                        }
                    }
                    if (allocationSitesQueryFuncs.Contains(func))
                    {
                        Debug.Assert(node.Args.Count == 1);
                        var arg1 = node.Args[0] as IdentifierExpr;
                        Debug.Assert(arg1 != null);
                        results.allocationSites[func].UnionWith(
                            PointsToSet(arg1.Decl, currImpl));
                    }

                }
                return base.VisitNAryExpr(node);
            }
        }

        private void Process()
        {
            // Find the allocators
            var allocators = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => BoogieUtil.checkAttrExists("allocator", proc.Attributes))
                .Iter(proc => allocators.Add(proc.Name));

            var funkyAllocators = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindStringAttribute(proc.Attributes, "allocator") == "full")
                .Iter(proc => funkyAllocators.Add(proc.Name));

            var nameToImpl = BoogieUtil.nameImplMapping(program);

            // Add allocated global constants
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "allocated"))
                .Iter(c =>
                {
                    allocatedConstants.Add(c.Name);
                    solver.Add(new AllocationConstraint(ConstructVariableName(c, null), false));
                });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var block in impl.Blocks)
                {
                    foreach (var cmd in block.Cmds)
                    {
                        var assign = cmd as AssignCmd;
                        if (assign != null)
                            for (int i = 0; i < assign.Lhss.Count; i++)
                                ProcessAssignment(assign.Lhss[i], impl.Name, assign.Rhss[i], impl.Name);
                        var ccmd = cmd as CallCmd;
                        if (ccmd != null)
                        {
                            if (allocators.Contains(ccmd.callee) && ccmd.Outs.Count == 1)
                                solver.Add(new AllocationConstraint(ConstructVariableName(ccmd.Outs[0].Decl, impl.Name), funkyAllocators.Contains(ccmd.callee)));
                            else if (nameToImpl.ContainsKey(ccmd.callee))
                            {
                                var callee = nameToImpl[ccmd.callee];
                                // formals := actuals
                                for (int i = 0; i < callee.InParams.Count; i++)
                                    ProcessAssignment(new SimpleAssignLhs(Token.NoToken, Expr.Ident(callee.InParams[i])),
                                        callee.Name, ccmd.Ins[i], impl.Name);
                                // outs := return
                                for (int i = 0; i < callee.OutParams.Count; i++)
                                    ProcessAssignment(new SimpleAssignLhs(Token.NoToken, ccmd.Outs[i]), impl.Name,
                                        Expr.Ident(callee.OutParams[i]), callee.Name);
                            }
                        }
                    }
                }
            }
        }

        private void ProcessAssignment(AssignLhs target, string targetProcName, Expr source, string sourceProcName)
        {
            var rs = ReadSet.Get(source);
            if (target is SimpleAssignLhs)
            {
                ProcessAssignment(ConstructVariableName(target.DeepAssignedVariable, targetProcName), rs, sourceProcName);
                return;
            }

            var massign = target as MapAssignLhs;
            var loadMap = massign.DeepAssignedVariable.Name;
            var loadTargetTmp = "tmpVar" + (counter++).ToString();
            var storeTargetTmp = "tmpVar" + (counter++).ToString();
            var indexRead = ReadSet.Get(massign.Indexes);

            ProcessAssignment(loadTargetTmp, indexRead, sourceProcName);
            ProcessAssignment(storeTargetTmp, rs, sourceProcName);
            solver.Add(new StoreConstraint(storeTargetTmp, loadTargetTmp, loadMap));
        }

        private void ProcessAssignment(string target, HashSet<Tuple<Variable, List<string>>> sourceReadSet, string sourceProcName)
        {
            var x = target;
            foreach (var tup in sourceReadSet)
            {
                var y = ConstructVariableName(tup.Item1, sourceProcName);
                if (tup.Item2.Count == 0)
                    solver.Add(new AssignConstraint(y, x));
                else
                {
                    var currTarget = x;
                    for (int i = 0; i < tup.Item2.Count; i++)
                    {
                        var currSource = (i == tup.Item2.Count - 1) ? y : ("tmpVar" + (counter++).ToString());
                        solver.Add(new LoadConstraint(currSource, currTarget, tup.Item2[i]));
                        currTarget = currSource;
                    }
                }
            }
        }

        private string ConstructVariableName(Variable v, string procName)
        {
            if (v is GlobalVariable || allocatedConstants.Contains(v.Name))
                return v.Name;
            return v.Name + "$" + procName;
        }


    }

    public class ReadSet : FixedVisitor
    {
        HashSet<Tuple<Variable, List<string>>> readSet;
        List<string> currMapSelects;

        private ReadSet()
        {
            readSet = new HashSet<Tuple<Variable, List<string>>>();
            currMapSelects = new List<string>();
        }

        public static HashSet<Tuple<Variable, List<string>>> Get(Expr expr)
        {
            var rs = new ReadSet();
            rs.VisitExpr(expr);
            return rs.readSet;
        }

        public static HashSet<Tuple<Variable, List<string>>> Get(IEnumerable<Expr> exprs)
        {
            var rs = new ReadSet();
            exprs.Iter(expr => rs.VisitExpr(expr));
            return rs.readSet;
        }

        public override Variable VisitVariable(Variable node)
        {
            readSet.Add(Tuple.Create(node, new List<string>(currMapSelects)));
            return base.VisitVariable(node);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is MapSelect)
            {
                currMapSelects.Add((node.Args[0] as IdentifierExpr).Name);
                for (int i = 1; i < node.Args.Count; i++)
                    base.VisitExpr(node.Args[i]);
                currMapSelects.RemoveAt(currMapSelects.Count - 1);
                return node;
            }
            return base.VisitNAryExpr(node);
        }
    }

    public abstract class AliasConstraint
    {
        public abstract void GatherMentionedVars(ref HashSet<string> vars);
    }

    class AssignConstraint : AliasConstraint
    {
        public string source;
        public string target;
        public AssignConstraint(string source, string target)
        {
            this.source = source;
            this.target = target;
        }
        public override void GatherMentionedVars(ref HashSet<string> vars)
        {
            vars.Add(source);
            vars.Add(target);
        }
        public override string ToString()
        {
            return string.Format("{0} := {1}", target, source);
        }
    }

    class AllocationConstraint : AliasConstraint
    {
        public string allocSite;
        public string target;
        public bool full;
        private static int counter = 0;

        public AllocationConstraint(string target, bool full)
        {
            this.allocSite = "allocSite" + (counter++).ToString();
            this.target = target;
            this.full = full;
        }

        public override void GatherMentionedVars(ref HashSet<string> vars)
        {
            vars.Add(target);
        }
        public override string ToString()
        {
            return string.Format("{0} := {1}", target, allocSite);
        }

    }

    class LoadConstraint : AliasConstraint
    {
        public string source;
        public string map;
        public string target;

        public LoadConstraint(string source, string target, string map)
        {
            this.source = source;
            this.target = target;
            this.map = map;
        }

        public override void GatherMentionedVars(ref HashSet<string> vars)
        {
            vars.Add(source);
            vars.Add(target);
        }
        public override string ToString()
        {
            return string.Format("{0} := {1}.{2}", target, source, map);
        }

    }

    class StoreConstraint : AliasConstraint
    {
        public string source;
        public string map;
        public string target;

        public StoreConstraint(string source, string target, string map)
        {
            this.source = source;
            this.target = target;
            this.map = map;
        }

        public override void GatherMentionedVars(ref HashSet<string> vars)
        {
            vars.Add(source);
            vars.Add(target);
        }
        public override string ToString()
        {
            return string.Format("{0}.{1} := {2}", target, map, source);
        }

    }

    public class AliasConstraintSolver
    {
        List<AliasConstraint> constraints;
        Dictionary<string, HashSet<string>> PointsTo;
        Dictionary<string, HashSet<string>> PointsToDelta;
        HashSet<string> maps;
        HashSet<string> worklist;
        bool solved;
        const int environmentPointersUnroll = 0;
        public static bool dbg = false;

        public AliasConstraintSolver()
        {
            constraints = new List<AliasConstraint>();
            PointsTo = new Dictionary<string, HashSet<string>>();
            PointsToDelta = new Dictionary<string, HashSet<string>>();
            worklist = new HashSet<string>();
            solved = false;
        }

        public void Add(AliasConstraint constraint)
        {
            Debug.Assert(!solved);
            if (dbg) Console.WriteLine("Adding constraint: {0}", constraint);
            constraints.Add(constraint);
        }

        public void Solve()
        {
            var sw = new Stopwatch();
            sw.Start();

            // variables
            var variables = new HashSet<string>();
            constraints.Iter(c => c.GatherMentionedVars(ref variables));

            // maps
            maps = new HashSet<string>();
            constraints.OfType<LoadConstraint>()
                .Iter(c => maps.Add(c.map));
            constraints.OfType<StoreConstraint>()
                .Iter(c => maps.Add(c.map));

            // alloc sites
            var allocSites = new HashSet<string>();
            constraints.OfType<AllocationConstraint>()
                .Iter(c => allocSites.Add(c.allocSite));

            // Varible -> store instruction
            var varToStore = new Dictionary<string, List<StoreConstraint>>();
            variables.Iter(v => varToStore.Add(v, new List<StoreConstraint>()));
            constraints.OfType<StoreConstraint>()
                .Iter(s => varToStore[s.target].Add(s));

            // Variable -> load instruction
            var varToLoad = new Dictionary<string, List<LoadConstraint>>();
            variables.Iter(v => varToLoad.Add(v, new List<LoadConstraint>()));
            constraints.OfType<LoadConstraint>()
                .Iter(l => varToLoad[l.source].Add(l));

            InitFullAllocators();

            var G = new Dictionary<string, HashSet<string>>();

            // DoAnalysis
            worklist = new HashSet<string>();
            foreach (var a in constraints.OfType<AllocationConstraint>())
            {
                PointsToDelta.InitAndAdd(a.target, a.allocSite);
                worklist.Add(a.target);
            }
            foreach (var a in constraints.OfType<AssignConstraint>())
                G.InitAndAdd(a.source, a.target);
            while (worklist.Count != 0)
            {
                var n = worklist.First();
                worklist.Remove(n);

                if (!G.ContainsKey(n)) G.Add(n, new HashSet<string>());
                if (!PointsTo.ContainsKey(n)) PointsTo.Add(n, new HashSet<string>());
                if (!PointsToDelta.ContainsKey(n)) PointsToDelta.Add(n, new HashSet<string>());

                G[n].Iter(nprime => DiffProp(PointsToDelta[n], nprime));

                if (variables.Contains(n))
                {
                    foreach (var store in varToStore[n])
                    {
                        var x = store.target;
                        var y = store.source;
                        var f = store.map;
                        var ptd = PointsToDelta[n];
                        foreach (var o in ptd)
                        {
                            var of = GetODotf(o, f);
                            if (!G.ContainsKey(y)) G.Add(y, new HashSet<string>());
                            if (!PointsTo.ContainsKey(y)) PointsTo.Add(y, new HashSet<string>());

                            if (!G[y].Contains(of))
                            {
                                G[y].Add(of);
                                DiffProp(PointsTo[y], of);
                            }

                        }
                    }
                    foreach (var load in varToLoad[n])
                    {
                        var x = load.source;
                        var y = load.target;
                        var f = load.map;
                        var ptd = PointsToDelta[n];
                        foreach (var o in ptd)
                        {
                            var of = GetODotf(o, f);
                            if (!G.ContainsKey(of)) G.Add(of, new HashSet<string>());
                            if (!PointsTo.ContainsKey(of)) PointsTo.Add(of, new HashSet<string>());
                            if (!G[of].Contains(y))
                            {
                                G[of].Add(y);
                                DiffProp(PointsTo[of], y);
                            }
                        }
                    }
                }
                PointsTo[n].UnionWith(PointsToDelta[n]);
                PointsToDelta[n] = new HashSet<string>();
            }
            #region stats
            if (dbg)
            {
                Console.WriteLine("Num constraints: {0}", constraints.Count);
                Console.WriteLine("Num variables, maps, alloc-sites: {0}, {1},  {2}", variables.Count, maps.Count, allocSites.Count);
                Console.WriteLine("Time: {0}", sw.Elapsed.TotalSeconds);
            }
            #endregion
            solved = true;
        }

        // For debugging only
        public HashSet<string> GetPointsTo(string var)
        {
            return PointsTo[var];
        }
        public HashSet<string> GetPointsTo(string var, string map)
        {
            var ret = new HashSet<string>();
            foreach (var o in PointsTo[var])
            {
                ret.UnionWith(PointsTo[GetODotf(o, map)]);
            }
            return ret;
        }

        private void InitFullAllocators()
        {
            // For "full" allocation sites, add extra constraints
            var fullAllocSites = new HashSet<string>();
            constraints.OfType<AllocationConstraint>().Where(ac => ac.full)
                .Iter(ac => fullAllocSites.Add(ac.allocSite));

            var maps = new HashSet<string>();
            constraints.OfType<LoadConstraint>()
                .Iter(l => maps.Add(l.map));
            constraints.OfType<StoreConstraint>()
                .Iter(l => maps.Add(l.map));

            // For each full alloc site o and map f, add:
            // PointsTo[o.f] = {o_f_i}
            // PointsTo[o_g_i.f] = {o_g_{i+1}}
            // PointsTo[o_g_n.f] = {o_g_n}

            int uid = 0;

            var frontier = new HashSet<string>(fullAllocSites);
            for (int i = 0; i <= environmentPointersUnroll; i++)
            {
                var next = new HashSet<string>();
                foreach (var o in frontier)
                {
                    foreach (var f in maps)
                    {
                        var of = GetODotf(o, f);
                        var nsite = (i == environmentPointersUnroll) ? o : "aa_newEnvSite" + (uid++).ToString();
                        if (!PointsTo.ContainsKey(of))
                            PointsTo.Add(of, new HashSet<string>());
                        PointsTo[of].Add(nsite);
                        next.Add(nsite);
                    }
                }
                frontier = next;
            }
        }


        private string GetODotf(string o, string f)
        {
            return "allocConstruct$" + o + "$" + f;
        }

        private bool isODotf(string of)
        {
            return of.StartsWith("allocConstruct$");
        }

        private Tuple<string, string> deconstructODotf(string of)
        {
            var sp = of.Split('$');
            Debug.Assert(sp.Length == 3);
            return Tuple.Create(sp[1], sp[2]);
        }

        private void DiffProp(HashSet<string> srcSet, string n)
        {
            if (!PointsTo.ContainsKey(n))
                PointsTo.Add(n, new HashSet<string>());
            if (!PointsToDelta.ContainsKey(n))
                PointsToDelta.Add(n, new HashSet<string>());

            var change = new HashSet<string>(srcSet);
            change.ExceptWith(PointsTo[n]);
            if (!change.IsSubsetOf(PointsToDelta[n]))
                worklist.Add(n);

            PointsToDelta[n] = PointsToDelta[n].Union(change);
        }

        public bool IsAlias(string var1, string var2)
        {
            Debug.Assert(solved);
            if (!PointsTo.ContainsKey(var1) || PointsTo[var1].Count == 0)
            {
                if(dbg) Console.WriteLine("Warning: empty points-to set for {0}", var1);
                return false;
            }

            if (!PointsTo.ContainsKey(var2) || PointsTo[var2].Count == 0)
            {
                if (dbg) Console.WriteLine("Warning: empty points-to set for {0}", var2);
                return false;
            }

            return PointsTo[var1].Intersection(PointsTo[var2]).Any();
        }

        // Does var1 || var1->f1 || var1->f1->f2 ... == var2?
        public bool IsReachable(string var1, string var2)
        {
            Debug.Assert(solved);

            if (!PointsTo.ContainsKey(var1) || !PointsTo.ContainsKey(var2) || PointsTo[var1].Count == 0 || PointsTo[var2].Count == 0)
                return false;

            // compute closure under load
            var reachable = new HashSet<string>(PointsTo[var1]);
            var delta = new HashSet<string>(reachable);
            while (delta.Any())
            {
                var next = new HashSet<string>();
                foreach (var o in delta)
                {
                    foreach (var m in maps)
                    {
                        var om = GetODotf(o, m);
                        if (PointsTo.ContainsKey(om))
                        {
                            next.UnionWith(PointsTo[om]);
                        }
                    }
                }
                reachable.UnionWith(next);
                delta = next;
                delta.ExceptWith(reachable);
            }

            return reachable.Intersection(PointsTo[var2]).Any();
        }

        // Return the set of allocation sites of v
        public HashSet<string> AllocationSites(string v)
        {
            Debug.Assert(solved);
            var ret = new HashSet<string>();

            if (!PointsTo.ContainsKey(v))
                return ret;

            return PointsTo[v];
        }
    }

    public static class InitDictionary
    {
        public static void InitAndAdd<K, V>(this Dictionary<K, HashSet<V>> map, K key, V value)
        {
            if (!map.ContainsKey(key)) map.Add(key, new HashSet<V>());
            map[key].Add(value);
        }
    }
}
