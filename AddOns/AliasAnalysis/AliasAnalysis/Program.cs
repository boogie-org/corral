using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using Microsoft.Boogie.GraphUtil;

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
            if (args.Any(s => s == "/full"))
                AliasConstraintSolver.NoEmptyLoads = true;
            if (args.Any(s => s == "/warn"))
                AliasConstraintSolver.printWarnings = true;
            if (args.Any(s => s == "/eliminateCycles"))
                AliasConstraintSolver.doCycleElimination = true;
            if (args.Any(s => s == "/generateCP"))
                AliasAnalysis.generateCP = true;
            if (args.Any(s => s == "/demand-driven"))
                AliasAnalysis.demandDrivenAA = true;

            AliasAnalysis.mergeFull = false; // don't merge by default
            
            args.Where(s => s.StartsWith("/prune:"))
                .Iter(s => prune = s.Split(':')[1]);

            args.Where(s => s.StartsWith("/envUnroll:"))
                .Iter(s => AliasConstraintSolver.environmentPointersUnroll = Int32.Parse(s.Split(':')[1]));

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            var program = BoogieUtil.ParseProgram(args[0]);
            Program origProgram = null;
            if (true /*prune != null*/)
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

            if (true /*prune != null*/)
            {
                origProgram.Resolve();
                PruneAliasingQueries.Prune(origProgram, ret);
                if (prune != null) BoogieUtil.PrintProgram(origProgram, prune);
                if (AliasAnalysis.generateCP) AliasAnalysis.ConstructConstraintProg(origProgram);
            }
        }

    }

    public class MarkMustAliasQueries : FixedVisitor
    {
        AliasAnalysisResults result;
        public static string mustNULL = "mustNULL";
        public static int countmustNULL = 0;
        AssertCmd currCmd;

        public MarkMustAliasQueries(AliasAnalysisResults result)
        {
            this.result = result;
            currCmd = null;
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            currCmd = node;
            var ret = base.VisitAssertCmd(node);
            currCmd = null;
            return ret;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var fcall = node.Fun as FunctionCall;
            if (fcall != null && result.mustbeNULL.ContainsKey(fcall.FunctionName))
            {
                if (currCmd != null && result.mustbeNULL[fcall.FunctionName] == true)
                {
                    currCmd.Attributes = new QKeyValue(Token.NoToken, mustNULL, new List<object>(), currCmd.Attributes);
                    countmustNULL++;
                }
            }
            return base.VisitNAryExpr(node);
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

        public static void Prune(Program program, AliasAnalysisResults result, bool removeUnreachableProcs = true)
        {
            Function AllocationSites = null;
            Dictionary<string, Constant> asToAS = new Dictionary<string, Constant>();

            if (result.allocationSites.Any())
            {
                // type AS;
                var asType = new TypeCtorDecl(Token.NoToken, "AS", 0);
                program.AddTopLevelDeclaration(asType);
                // add AS constants
                var sites = new HashSet<string>();
                result.allocationSites.Values.Iter(v => sites.UnionWith(v));
                foreach (var s in sites)
                {
                    var c = new Constant(Token.NoToken,
                            new TypedIdent(Token.NoToken, "AS_" + s, new CtorType(Token.NoToken, asType, new List<btype>())),
                            true);
                    asToAS.Add(s, c);
                    program.AddTopLevelDeclaration(c);
                }
                // Add: function AllocationSites(int, AS) : bool
                AllocationSites = new Function(Token.NoToken, "AllocationSites", 
                    new List<Variable>{
                       new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "a", btype.Int), true),
                       new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "b", new CtorType(Token.NoToken, asType, new List<btype>())), true)
                    },
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "c", btype.Bool), false)
                    );
                program.AddTopLevelDeclaration(AllocationSites);
            }

            // marking aliasing queries as mustNULL
            var mark = new MarkMustAliasQueries(result);
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => mark.VisitImplementation(impl));

            var prune = new PruneAliasingQueries(result, AllocationSites, asToAS);

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => prune.VisitImplementation(impl));
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => prune.PruneFalseBranches(impl));
            var main = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .FirstOrDefault();
            if (main != null && removeUnreachableProcs)
                BoogieUtil.pruneProcs(program, main.Name);

            // remove aliasing queries
            program.TopLevelDeclarations = new List<Declaration>(program.TopLevelDeclarations
                .Where(decl => !(decl is Function && BoogieUtil.checkAttrExists("aliasingQuery", decl.Attributes))));

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
                //assume true && AS(e,A1) && AS(e,A3);
                Expr r = Expr.True;
                foreach (var s in result.allocationSites[fcall.FunctionName])
                    r = Expr.And(r,
                         new NAryExpr(Token.NoToken, new FunctionCall(AllocationSites), new List<Expr> { node.Args[0], Expr.Ident(asToAS[s]) }));
                return r;
            }

            var ret = base.VisitNAryExpr(node);

            var nary = ret as NAryExpr;
            if (nary != null && nary.Fun is BinaryOperator
                && (nary.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or)
            {
                if (nary.Args.Any(a => a == Expr.True))
                    return Expr.True;
            }
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

        public static HashSet<string> Simplify(Program program)
        {
            var sa = new SimplifyAliasingQueries();
            sa.VisitProgram(program);
            return sa.aliasingFunctions;
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

    public class DemandDrivenAASolver
    {
        // AAGraph[w] denotes incoming edges to w
        Dictionary<string, HashSet<Edge>> AAGraph;
        // stores target of each store
        Dictionary<string, HashSet<string>> map2stores;
        // stores target of each load
        Dictionary<string, HashSet<string>> map2loads;
        // full allocation sites, currently unused
        HashSet<string> fullAllocSites;
        // list of aliasing queries
        HashSet<Tuple<string, string>> queries;
        // demand driven PointsTo set generated
        Dictionary<string, HashSet<string>> pointsTo;

        // used for every aliasing query
        HashSet<string> marked;
        List<string> worklist;
        //public static string nullAS;
        bool dbg = false;

        abstract class Edge
        {
            public string source;
            public string target;
        }

        class AllocEdge : Edge
        {
            public bool isFull;
            static int counter = 0;

            public AllocEdge(string s, bool full)
            {
                // reversing the edge due to the algorithm of RegularPT
                if (AliasAnalysis.mergeFull)
                {
                    if (full)
                        target = "allocSiteSpecial";
                    else
                        target = "allocSite" + (counter++).ToString();
                }
                else
                    target = "allocSite" + (counter++).ToString();

                source = s;
                isFull = full;
            }
        }

        class MatchEdge : Edge
        {
            public MatchEdge(string s, string t)
            {
                source = s;
                target = t;
            }
        }

        class AssignEdge : Edge
        {
            public AssignEdge(string s, string t)
            {
                source = s;
                target = t;
            }
        }

        public DemandDrivenAASolver()
        {
            AAGraph = new Dictionary<string, HashSet<Edge>>();
            map2stores = new Dictionary<string, HashSet<string>>();
            map2loads = new Dictionary<string, HashSet<string>>();
            fullAllocSites = new HashSet<string>();
            queries = new HashSet<Tuple<string, string>>();

            pointsTo = new Dictionary<string, HashSet<string>>();
            marked = new HashSet<string>();
            worklist = new List<string>();
            //nullAS = null;

        }

        public void AddAllocEdge(string name, bool full)
        {
            // reversing the edge, goes from var -> allocSite
            AllocEdge ae = new AllocEdge(name, full);
            string source = ae.source;
            if (!AAGraph.ContainsKey(source)) AAGraph[source] = new HashSet<Edge>();
            if (full) fullAllocSites.Add(ae.target);
            AAGraph[source].Add(ae);
            if (dbg) Console.WriteLine("Adding alloc edge => {0} -> {1}", source, name);
        }

        public void AddAssignEdge(string y, string x)
        {
            if (!AAGraph.ContainsKey(y)) AAGraph[y] = new HashSet<Edge>();
            AAGraph[y].Add(new AssignEdge(y, x));
            if (dbg) Console.WriteLine("Adding assign edge => {0} -> {1}", y, x);
        }

        public void AddStore(string loadMap, string storeTarget)
        {
            if (!map2stores.ContainsKey(loadMap)) map2stores[loadMap] = new HashSet<string>();
            map2stores[loadMap].Add(storeTarget);
        }

        public void AddLoad(string loadMap, string loadTarget)
        {
            if (!map2loads.ContainsKey(loadMap)) map2loads[loadMap] = new HashSet<string>();
            map2loads[loadMap].Add(loadTarget);
        }

        public void AddMatchEdges()
        {
            // reversing the edges due to RegularPT algorithm
            foreach (string map in map2stores.Keys)
            {
                foreach (string target in map2stores[map])
                {
                    if (map2loads.ContainsKey(map))
                    {
                        foreach (string source in map2loads[map])
                        {
                            if (!AAGraph.ContainsKey(source)) AAGraph[source] = new HashSet<Edge>();
                            AAGraph[source].Add(new MatchEdge(source, target));
                            if (dbg) Console.WriteLine("Adding match edge => {0} -> {1}", source, target);
                        }
                    }
                }
            }

            //InitFullAllocators();
        }

        public void GetQuery(string item1, string item2)
        {
            var query = Tuple.Create(item1, item2);
            queries.Add(query);
        }

        // TODO: add appropriate edges
        private void InitFullAllocators()
        {
            foreach (var map in map2loads.Keys)
            {
                foreach (var aSite in fullAllocSites)
                {
                    if (!AAGraph.ContainsKey(aSite)) AAGraph[aSite] = new HashSet<Edge>();
                }
            }
        }

        /*
        private void FindNULL()
        {
            string NULL = "NULL";
            Debug.Assert(AAGraph.ContainsKey(NULL));
            
            foreach (string node in AAGraph.Keys)
            {
                foreach (Edge e in AAGraph[node])
                {
                    if (e is AllocEdge)
                    {
                        var ae = e as AllocEdge;
                        if (ae.target.Equals(NULL))
                        {
                            nullAS = node;
                            return;
                        }
                    }
                }
            }
        }
        */

        public void Solve()
        {
            foreach (var query in queries)
            {
                if (!pointsTo.ContainsKey(query.Item1))
                {
                    var pt1 = RegularPT(query.Item1);
                    pointsTo.Add(query.Item1, pt1);
                }

                if (!pointsTo.ContainsKey(query.Item2))
                {
                    var pt2 = RegularPT(query.Item2);
                    pointsTo.Add(query.Item2, pt2);
                }

            }
        }

        private HashSet<string> RegularPT(string source)
        {
            var PointsTo = new HashSet<string>();

            worklist = new List<string>();
            marked = new HashSet<string>();

            propagate(source);
            
            while (worklist.Count != 0)
            {
                string w = worklist.First();
                worklist.Remove(w);

                if (AAGraph.ContainsKey(w))
                {
                    // foreach NEW edge o -> w
                    foreach (AllocEdge ae in AAGraph[w].OfType<AllocEdge>())
                        PointsTo.Add(ae.target);

                    // foreach ASSIGN and MATCH edge y -> w
                    foreach (Edge e in AAGraph[w])
                    {
                        if (e is AssignEdge || e is MatchEdge)
                        {
                            propagate(e.target);
                        }
                    }
                }
            }

            if (GVN.doGVN)
            {
                // checking whether NULL \in PointsTo or not
                HashSet<string> nullPointsTo = new HashSet<string>();

                string NULL = "NULL";
                string nullAS = null;
                Debug.Assert(AAGraph.ContainsKey(NULL));

                foreach (AllocEdge ae in AAGraph[NULL].OfType<AllocEdge>())
                    nullAS = ae.target;

                worklist = new List<string>();
                marked = new HashSet<string>();

                propagate(source);

                while (worklist.Count != 0)
                {
                    string w = worklist.First();
                    worklist.Remove(w);

                    if (AAGraph.ContainsKey(w))
                    {
                        // foreach NEW edge o -> w
                        foreach (AllocEdge ae in AAGraph[w].OfType<AllocEdge>())
                            nullPointsTo.Add(ae.target);

                        // foreach ASSIGN and MATCH edge y -> w
                        foreach (Edge e in AAGraph[w])
                        {
                            if (e is AssignEdge || e is MatchEdge)
                            {
                                if (!e.target.StartsWith("cseTmp")) propagate(e.target);
                            }
                        }
                    }
                }

                if (!nullPointsTo.Contains(nullAS) || source.StartsWith("cseTmp")) PointsTo.Remove(nullAS);
            }

            return PointsTo;
        }

        private void propagate(string source)
        {
            if (!marked.Contains(source))
            {
                worklist.Add(source);
                marked.Add(source);
            }
        }

        public Dictionary<string, HashSet<string>> GetResults()
        {
            return pointsTo;
        }
    }

    public class GatherAliasingQueries : FixedVisitor
    {
        Implementation currImpl;
        HashSet<string> aliasingQueryFuncs;
        HashSet<Tuple<Variable, Variable, Implementation>> aliasingQueries;

        private GatherAliasingQueries()
        {
            currImpl = null;
            aliasingQueryFuncs = new HashSet<string>();
            aliasingQueries = new HashSet<Tuple<Variable, Variable, Implementation>>();
        }

        public static HashSet<Tuple<Variable, Variable, Implementation>> Gather(Program program)
        {
            var gaq = new GatherAliasingQueries();
            gaq.VisitProgram(program);
            return gaq.aliasingQueries;
        }

        public override Program VisitProgram(Program node)
        {
            node.TopLevelDeclarations.OfType<Function>()
                .Where(func => BoogieUtil.checkAttrExists("aliasingQuery", func.Attributes))
                .Iter(func => aliasingQueryFuncs.Add(func.Name));

            return base.VisitProgram(node);
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            currImpl = node;
            var ret = base.VisitImplementation(node);
            currImpl = null;
            return ret;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                var func = (node.Fun as FunctionCall).FunctionName;
                if (aliasingQueryFuncs.Contains(func))
                {
                    Debug.Assert(node.Args.Count == 2);
                    var arg1 = node.Args[0] as IdentifierExpr;
                    var arg2 = node.Args[1] as IdentifierExpr;
                    Debug.Assert(arg1 != null && arg2 != null && currImpl != null);

                    aliasingQueries.Add(Tuple.Create(arg1.Decl, arg2.Decl, currImpl));
                }

            }
            return base.VisitNAryExpr(node);
        }
    }

    public class AliasAnalysisResults
    {
        public Dictionary<string, bool> aliases;
        public Dictionary<string, HashSet<string>> allocationSites;
        public Dictionary<string, bool> mustbeNULL;
        public AliasAnalysisResults()
        {
            aliases = new Dictionary<string, bool>();
            allocationSites = new Dictionary<string, HashSet<string>>();
            mustbeNULL = new Dictionary<string, bool>();
        }
    }

    public class AliasAnalysis
    {

        Program program;
        HashSet<string> allocatedConstants;
        AliasConstraintSolver solver;
        int counter;
        public static bool dbg = false;
        public static HashSet<string> non_null_vars = null;
        public static bool generateCP = false;
        public static bool demandDrivenAA = false;
        public static bool mergeFull = true;
        DemandDrivenAASolver ddsolver;

        // program containing constraints for AA
        private static Program constraintProg;

        // type for allocation sites
        private static TypeCtorDecl Type_AS = new TypeCtorDecl(Token.NoToken, "allocSite", 0);

        private AliasAnalysis(Program program)
        {
            this.program = program;
            this.allocatedConstants = new HashSet<string>();
            solver = new AliasConstraintSolver();
            counter = 0;
            constraintProg = new Program();
            ddsolver = new DemandDrivenAASolver();
        }

        /* Looks at the assumes and asserts, figures out their SSA, and ensures that the allocation site corresponding to NULL does not flow into these variables */
        private void Process_Assumes_Asserts()
        {
            non_null_vars = new HashSet<string>();
            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (Block b in impl.Blocks)
                {
                    foreach (Cmd c in b.Cmds)
                    {
                        if (c is AssignCmd)
                        {
                            var ac = c as AssignCmd;
                            foreach (AssignLhs lhs in ac.Lhss)
                            {
                                if (lhs is SimpleAssignLhs && lhs.DeepAssignedVariable.Name.StartsWith("cseTmp"))
                                {
                                    non_null_vars.Add(ConstructVariableName(lhs.DeepAssignedVariable, impl.Name));
                                }
                            }
                        }
                    }
                }
            }
        }

        private void SetQueries()
        {
            var queries = GatherAliasingQueries.Gather(program);
            
            foreach (var tuple in queries)
                ddsolver.GetQuery(ConstructVariableName(tuple.Item1, tuple.Item3.Name), ConstructVariableName(tuple.Item2, tuple.Item3.Name));
        }

        public static AliasAnalysisResults DoAliasAnalysis(Program program)
        {
            var aa = new AliasAnalysis(program);
            if (dbg) Console.WriteLine("Creating Points-to constraints ... ");
            aa.Process();
            if (dbg) Console.WriteLine("Done");
            if (dbg) Console.WriteLine("Solving Points-to constraints ... ");
            if (AliasAnalysis.demandDrivenAA)
            {
                // HACK: will work only for non-null aliasing queries
                // TODO: make it general
                Console.WriteLine("Running demand driven alias analysis");
                if (GVN.doGVN) Console.WriteLine("Using global value numbering");
                aa.SetQueries();
                aa.ddsolver.Solve();
                aa.solver.SetResults(aa.ddsolver.GetResults());
            }
            else
            {
                if (GVN.doGVN) Console.WriteLine("Using global value numbering");
                aa.solver.Solve();
                //aa.getReturnAllocSites(aa.solver.GetPointsToSet());
                Console.WriteLine("AA: Cycle elimination found {0} cycles", AliasConstraintSolver.numCycles);
                // Solve the queries
            }
            if (dbg) Console.WriteLine("Done");
            return
                AliasQuerySolver.Solve(program, new Func<Variable, Variable, Implementation, bool>((v1, v2, impl) => aa.solver.IsAlias(
                    aa.ConstructVariableName(v1, impl.Name),
                    aa.ConstructVariableName(v2, impl.Name))),
                    new Func<Variable, Variable, Implementation, bool>((v1, v2, impl) => aa.solver.IsReachable(
                    aa.ConstructVariableName(v1, impl.Name),
                    aa.ConstructVariableName(v2, impl.Name))),
                    new Func<Variable, Implementation, HashSet<string>>((v1, impl) => aa.solver.AllocationSites(
                    aa.ConstructVariableName(v1, impl.Name))),
                    new Func<Variable, Variable, Implementation, bool>((v1, v2, impl) => aa.solver.IsMustAlias(
                    aa.ConstructVariableName(v1, impl.Name),
                    aa.ConstructVariableName(v2, impl.Name)))
                    );
        }

        class AliasQuerySolver : FixedVisitor
        {
            Func<Variable, Variable, Implementation, bool> IsAlias;
            Func<Variable, Variable, Implementation, bool> IsReachable;
            Func<Variable, Implementation, HashSet<string>> PointsToSet;
            Func<Variable, Variable, Implementation, bool> IsMustAlias;
            HashSet<string> aliasQueryFuncs;
            HashSet<string> reachableQueryFuncs;
            HashSet<string> allocationSitesQueryFuncs;
            AliasAnalysisResults results;
            Implementation currImpl;

            private AliasQuerySolver(HashSet<string> aliasQueryFuncs, HashSet<string> reachableQueryFuncs, HashSet<string> allocationSitesQueryFuncs, 
                Func<Variable, Variable, Implementation, bool> IsAlias,
                Func<Variable, Variable, Implementation, bool> IsReachable,
                Func<Variable, Variable, Implementation, bool> IsMustAlias,
                Func<Variable, Implementation, HashSet<string>> PointsToSet)
            {
                this.aliasQueryFuncs = aliasQueryFuncs;
                this.reachableQueryFuncs = reachableQueryFuncs;
                this.allocationSitesQueryFuncs = allocationSitesQueryFuncs;
                this.results = new AliasAnalysisResults();
                this.IsAlias = IsAlias;
                this.IsReachable = IsReachable;
                this.IsMustAlias = IsMustAlias;
                this.PointsToSet = PointsToSet;
                aliasQueryFuncs.Iter(q => results.aliases.Add(q, false));
                aliasQueryFuncs.Iter(q => results.mustbeNULL.Add(q, true));
                reachableQueryFuncs.Iter(q => results.aliases.Add(q, false));
                reachableQueryFuncs.Iter(q => results.mustbeNULL.Add(q, true));
                allocationSitesQueryFuncs.Iter(q => results.allocationSites.Add(q, new HashSet<string>()));
            }

            public static AliasAnalysisResults Solve(Program program, 
                Func<Variable, Variable, Implementation, bool> IsAlias,
                Func<Variable, Variable, Implementation, bool> IsReachable,
                Func<Variable, Implementation, HashSet<string>> PointsToSet,
                Func<Variable, Variable, Implementation, bool> IsMustAlias)
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

                var qSolver = new AliasQuerySolver(aq, rq, asq, IsAlias, IsReachable, IsMustAlias, PointsToSet);
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

                        if (results.mustbeNULL[func])
                        {
                            results.mustbeNULL[func] = IsMustAlias(arg1.Decl, arg2.Decl, currImpl);
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
            //var cmd2AllocationConstraint = new Dictionary<Tuple<Implementation, Block, Cmd>, string>();
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
                    if (AliasAnalysis.demandDrivenAA)
                    {
                        var name = ConstructVariableName(c, null);
                        ddsolver.AddAllocEdge(name, false);
                    }
                    else
                    {
                        solver.Add(new AllocationConstraint(ConstructVariableName(c, null), false));
                    }
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
                            {
                                //cmd2AllocationConstraint.Add(new Tuple<Implementation, Block, Cmd>(impl, block, ccmd), AllocationConstraint.getSite());
                                if (AliasAnalysis.demandDrivenAA)
                                {
                                    var name = ConstructVariableName(ccmd.Outs[0].Decl, impl.Name);
                                    ddsolver.AddAllocEdge(name, funkyAllocators.Contains(ccmd.callee));
                                }
                                else
                                {
                                    solver.Add(new AllocationConstraint(ConstructVariableName(ccmd.Outs[0].Decl, impl.Name), funkyAllocators.Contains(ccmd.callee)));
                                }
                            }
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

            // add 'match' edges from source of each map to store to the target of each load
            if (AliasAnalysis.demandDrivenAA)
            {
                ddsolver.AddMatchEdges();
                
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
            if (AliasAnalysis.demandDrivenAA)
            {
                ddsolver.AddStore(loadMap, storeTargetTmp);
            }
            else
            {
                solver.Add(new StoreConstraint(storeTargetTmp, loadTargetTmp, loadMap));
            }
        }

        private void ProcessAssignment(string target, HashSet<Tuple<Variable, List<string>>> sourceReadSet, string sourceProcName)
        {
            var x = target;
            foreach (var tup in sourceReadSet)
            {
                var y = ConstructVariableName(tup.Item1, sourceProcName);
                if (tup.Item2.Count == 0)
                {
                    if (AliasAnalysis.demandDrivenAA)
                    {
                        // reversing the edge due to RegularPT algorithm
                        ddsolver.AddAssignEdge(x, y);
                    }
                    else
                    {
                        solver.Add(new AssignConstraint(y, x));
                    }
                }
                else
                {
                    var currTarget = x;
                    for (int i = 0; i < tup.Item2.Count; i++)
                    {
                        var currSource = (i == tup.Item2.Count - 1) ? y : ("tmpVar" + (counter++).ToString());
                        if (AliasAnalysis.demandDrivenAA)
                        {
                            var loadMap = tup.Item2[i];
                            ddsolver.AddLoad(loadMap, currTarget);
                        }
                        else
                        {
                            solver.Add(new LoadConstraint(currSource, currTarget, tup.Item2[i]));
                        }
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

        private static void InitConstraintProg(Program program)
        {
            constraintProg.AddTopLevelDeclaration(Type_AS);
            ConstructConstraintStmts.Type_AS = Type_AS;

            Constant specialConstant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "scalarAS", new CtorType(Token.NoToken, Type_AS, new List<btype>())));
            constraintProg.AddTopLevelDeclaration(specialConstant);
            ConstructConstraintStmts.specialConstant = specialConstant;

            ConstructConstraintStmts.allocatedConstants = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "allocated"))
                .Iter(c =>
                {
                    ConstructConstraintStmts.allocatedConstants.Add(c.Name);
                });

            ConstructConstraintStmts.allocators = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => BoogieUtil.checkAttrExists("allocator", proc.Attributes))
                .Iter(proc => ConstructConstraintStmts.allocators.Add(proc.Name));

            ConstructConstraintStmts.fullAllocators = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindStringAttribute(proc.Attributes, "allocator") == "full")
                .Iter(proc => ConstructConstraintStmts.fullAllocators.Add(proc.Name));

            ConstructConstraintStmts.implNames = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>().Iter(impl => ConstructConstraintStmts.implNames.Add(impl.Name));

            ConstructConstraintStmts.asCounter = 0;

            ConstructConstraintStmts.globalMaps = new HashSet<GlobalVariable>();
            ConstructConstraintStmts.allocSites = new HashSet<Constant>();
            ConstructConstraintStmts.fullAllocSites = new HashSet<Constant>();
        }

        private static void InitializeGlobals()
        {
            HashSet<string> entrypoints = new HashSet<string>();
            constraintProg.TopLevelDeclarations.OfType<Procedure>().Where(proc => BoogieUtil.checkAttrExists("entrypoint", proc.Attributes)).Iter(proc => entrypoints.Add(proc.Name));
            //Debug.Assert(entrypoints.Count == 1);

            Implementation entrypoint = constraintProg.TopLevelDeclarations.OfType<Implementation>().Where(impl => impl.Name.Equals(entrypoints.FirstOrDefault())).FirstOrDefault();

            CtorType asType = new CtorType(Token.NoToken, Type_AS, new List<btype>());

            Function fn = new Function(Token.NoToken, "IsFull", 
                new List<Variable> { new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "aS", asType), true) },
                new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "ret", btype.Bool), true));
            constraintProg.AddTopLevelDeclaration(fn);

            List<Cmd> cmds = new List<Cmd>();

            foreach (Constant c in ConstructConstraintStmts.allocSites)
            {
                Expr expr = new NAryExpr(Token.NoToken, new FunctionCall(fn), new List<Expr>{new IdentifierExpr(Token.NoToken, c)});
                AssumeCmd ac = null;
                if (ConstructConstraintStmts.fullAllocSites.Contains(c))
                {
                    ac = new AssumeCmd(Token.NoToken, expr);
                }
                else
                {
                    ac = new AssumeCmd(Token.NoToken, Expr.Not(expr));
                }
                cmds.Add(ac);
            }

            foreach (var map in ConstructConstraintStmts.globalMaps)
            {
                IdentifierExpr x = new IdentifierExpr(Token.NoToken, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "x", asType)));
                IdentifierExpr y = new IdentifierExpr(Token.NoToken, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "y", asType)));
                Expr isfull_x = new NAryExpr(Token.NoToken, new FunctionCall(fn), new List<Expr>{x});
                Expr isfull_y = new NAryExpr(Token.NoToken, new FunctionCall(fn), new List<Expr>{y});
                Expr x_neq_y = Expr.Neq(x, y);
                Expr lhs = Expr.Or(Expr.Or(Expr.Not(isfull_x), Expr.Not(isfull_y)), x_neq_y);
                Expr rhs = new NAryExpr(Token.NoToken, new MapSelect(Token.NoToken, 2), new List<Expr> { new IdentifierExpr(Token.NoToken, map), x, y });
                Expr not_rhs = Expr.Not(rhs);
                Expr body = Expr.Imp(lhs, not_rhs);
                ForallExpr expr = new ForallExpr(Token.NoToken, new List<Variable> { x.Decl, y.Decl }, new Trigger(Token.NoToken, true, new List<Expr> { rhs }), body);
                AssumeCmd ac = new AssumeCmd(Token.NoToken, expr);
                cmds.Add(ac);
            }

            Block newBlock = new Block(Token.NoToken, "init", cmds, new GotoCmd(Token.NoToken, new List<Block> { entrypoint.Blocks[0] }));
            List<Block> newBlocks = new List<Block>();
            newBlocks.Add(newBlock);
            entrypoint.Blocks.Iter(blk => newBlocks.Add(blk));
            entrypoint.Blocks = newBlocks;
        }

        public static Program ConstructConstraintProg(Program program)
        {
            InitConstraintProg(program);

            foreach (Implementation impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                List<Block> newBlocks = new List<Block>();
                List<Variable> newLocVars = new List<Variable>();
                HashSet<string> globalMaps = new HashSet<string>();
                
                List<Variable> input = new List<Variable>();
                impl.InParams.Iter(v => input.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, v.Name, new CtorType(Token.NoToken, Type_AS, new List<btype>())), true)));

                List<Variable> output = new List<Variable>();
                impl.OutParams.Iter(v => output.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, v.Name, new CtorType(Token.NoToken, Type_AS, new List<btype>())), true)));

                impl.LocVars.Iter(v => newLocVars.Add(new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, v.Name, new CtorType(Token.NoToken, Type_AS, new List<btype>())))));

                ConstructConstraintStmts.varCounter = 0;

                foreach (Block b in impl.Blocks)
                {
                    List<Variable> newLocVarsBlock = null;
                    var block = ConstructConstraintStmts.ProcessBlock(b, out newLocVarsBlock);
                    newBlocks.Add(block);
                    newLocVars.AddRange(newLocVarsBlock);
                }

                Procedure constraintProc = new Procedure(Token.NoToken, impl.Name, new List<TypeVariable>(), input, output, new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                Debug.Assert(impl.Proc != null);
                if (BoogieUtil.checkAttrExists("entrypoint", impl.Proc.Attributes)) constraintProc.AddAttribute("entrypoint");
                constraintProg.AddTopLevelDeclaration(constraintProc);

                Implementation constraintImpl = new Implementation(Token.NoToken, impl.Name, new List<TypeVariable>(), input, output, newLocVars, newBlocks);
                constraintProg.AddTopLevelDeclaration(constraintImpl);
            }

            InitializeGlobals();

            CommandLineOptions.Clo.DoModSetAnalysis = true;
            BoogieUtil.ReResolve(constraintProg);
            CommandLineOptions.Clo.DoModSetAnalysis = false;
            BoogieUtil.PrintProgram(constraintProg, "constraint_prog.bpl");

            return constraintProg;
        }

        private static GlobalVariable getGlobalMap(string name)
        {
            CtorType asType = new CtorType(Token.NoToken, Type_AS, new List<btype>());

            foreach (var map in constraintProg.TopLevelDeclarations.OfType<GlobalVariable>())
            {
                if (map.Name.Equals(name)) return map;
            }

            GlobalVariable newmap = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, name, new MapType(Token.NoToken, new List<TypeVariable>(),
                new List<btype> { asType, asType }, btype.Bool)));
            constraintProg.AddTopLevelDeclaration(newmap);
            ConstructConstraintStmts.globalMaps.Add(newmap);

            return newmap;
        }

        private static void addGlobalVar(string name)
        {
            CtorType asType = new CtorType(Token.NoToken, Type_AS, new List<btype>());

            foreach (GlobalVariable variable in constraintProg.TopLevelDeclarations.OfType<GlobalVariable>())
            {
                if (variable.Name.Equals(name)) return;
            }

            GlobalVariable newvar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, name, asType));
            constraintProg.AddTopLevelDeclaration(newvar);
            return;
        }

        private static string getASvariable(string name)
        {
            return name + "_allocSite";
        }

        private static Constant getConstant(string name)
        {
            CtorType asType = new CtorType(Token.NoToken, Type_AS, new List<btype>());

            if (!ConstructConstraintStmts.allocatedConstants.Contains(name)) return ConstructConstraintStmts.specialConstant;

            foreach (Constant c in constraintProg.TopLevelDeclarations.OfType<Constant>())
            {
                if (c.Name.Equals(getASvariable(name))) return c;
            }

            Constant newc = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, getASvariable(name), asType));
            constraintProg.AddTopLevelDeclaration(newc);

            return newc;
        }

        private static Constant getAllocationConstant(bool full)
        {
            CtorType asType = new CtorType(Token.NoToken, Type_AS, new List<btype>());

            Constant allocConstant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "allocSite" + ConstructConstraintStmts.asCounter++.ToString(), asType));
            ConstructConstraintStmts.allocSites.Add(allocConstant);

            if (full)
            {
                ConstructConstraintStmts.fullAllocSites.Add(allocConstant);
                allocConstant.AddAttribute("full");
            }
            constraintProg.AddTopLevelDeclaration(allocConstant);
            
            return allocConstant;
        }

        public class ConstructConstraintStmts
        {
            Block origBlock;
            Block currBlock;
            List<Cmd> currCmds;
            List<Variable> locVars;
            public static int varCounter;
            public static TypeCtorDecl Type_AS;
            public static Constant specialConstant;
            public static HashSet<string> allocatedConstants;
            public static HashSet<string> allocators;
            public static HashSet<string> fullAllocators;
            public static HashSet<string> implNames;
            public static HashSet<GlobalVariable> globalMaps;
            public static HashSet<Constant> allocSites;
            public static HashSet<Constant> fullAllocSites;
            public static int asCounter;

            private ConstructConstraintStmts(Block b)
            {
                origBlock = b;
                locVars = new List<Variable>();
                currCmds = new List<Cmd>();
            }

            private void ProcessAssignCmd(AssignCmd ac)
            {
                List<Expr> newRhss = new List<Expr>();
                List<AssignLhs> newLhss = new List<AssignLhs>();

                for (int i = 0; i < ac.Rhss.Count; i++)
                {
                    var rs = ReadSet.Get(ac.Rhss[i]);
                    IdentifierExpr rhs = null;
                    var cmds = CreateCmds(rs, ReadSet.containsConsts, out rhs);
                    newRhss.Add(rhs);
                    currCmds.AddRange(cmds);
                }
                for (int i = 0; i < ac.Lhss.Count; i++)
                {
                    if (ac.Lhss[i] is SimpleAssignLhs)
                    {
                        var lhs = ac.Lhss[i] as SimpleAssignLhs;
                        if (lhs.DeepAssignedVariable is GlobalVariable) addGlobalVar(lhs.DeepAssignedVariable.Name);
                        newLhss.Add(ac.Lhss[i]);
                    }
                    else
                    {
                        var massign = ac.Lhss[i] as MapAssignLhs;

                        var loadMap = massign.DeepAssignedVariable.Name;
                        GlobalVariable gmap = getGlobalMap(loadMap);
                        IdentifierExpr lhs = null;
                        var indexRead = ReadSet.Get(massign.Indexes);

                        var cmds = CreateCmds(indexRead, ReadSet.containsConsts, out lhs);
                        newLhss.Add(new MapAssignLhs(Token.NoToken, new SimpleAssignLhs(Token.NoToken, new IdentifierExpr(Token.NoToken, gmap)), new List<Expr> { lhs, newRhss[i] }));
                        newRhss[i] = Expr.True;
                        currCmds.AddRange(cmds);
                    }
                }
                var finalac = new AssignCmd(Token.NoToken, newLhss, newRhss);
                currCmds.Add(finalac);
            }

            private void ProcessCallCmd(CallCmd cc)
            {
                if (allocators.Contains(cc.callee))
                {
                    Debug.Assert(cc.Ins.Count == 1 && cc.Outs.Count == 1);
                    SimpleAssignLhs lhs = new SimpleAssignLhs(Token.NoToken, cc.Outs[0]);
                    var ac = new AssignCmd(Token.NoToken, new List<AssignLhs> { lhs }, new List<Expr> { new IdentifierExpr(Token.NoToken, getAllocationConstant(fullAllocators.Contains(cc.callee))) });
                    currCmds.Add(ac);
                    cc.Outs.Iter(id => { if (id.Decl is GlobalVariable) addGlobalVar(id.Decl.Name); });
                    return;
                }
                else if (!implNames.Contains(cc.callee))
                {
                    List<AssignLhs> lhss = new List<AssignLhs>();
                    List<Expr> rhss = new List<Expr>();
                    foreach (IdentifierExpr id in cc.Outs)
                    {
                        SimpleAssignLhs lhs = new SimpleAssignLhs(Token.NoToken, id);
                        IdentifierExpr rhs = new IdentifierExpr(Token.NoToken, specialConstant);
                        lhss.Add(lhs);
                        rhss.Add(rhs);
                    }
                    if (lhss.Count > 0)
                    {
                        var ac = new AssignCmd(Token.NoToken, lhss, rhss);
                        currCmds.Add(ac);
                    }
                    return;
                }

                List<Expr> newins = new List<Expr>();
                foreach (var expr in cc.Ins)
                {
                    var rs = ReadSet.Get(expr);
                    IdentifierExpr newin = null;
                    var cmds = CreateCmds(rs, ReadSet.containsConsts, out newin);
                    newins.Add(newin);
                    currCmds.AddRange(cmds);
                }
                cc.Outs.Iter(id => { if (id.Decl is GlobalVariable) addGlobalVar(id.Decl.Name); });
                var newcc = new CallCmd(Token.NoToken, cc.callee, newins, cc.Outs);
                currCmds.Add(newcc);
            }

            private void ProcessAssertCmd(AssertCmd ac)
            {
                Expr expr = CleanAssert.getExprFromAssertCmd(ac);
                string null_expr = CleanAssert.getNULLFromAssertCmd(ac);

                var rs = ReadSet.Get(expr);
                IdentifierExpr id = null;
                var cmds = CreateCmds(rs, ReadSet.containsConsts, out id);
                currCmds.AddRange(cmds);
                AssertCmd newac = new AssertCmd(Token.NoToken, Expr.Neq(id, new IdentifierExpr(Token.NoToken, getConstant(null_expr))));
                currCmds.Add(newac);
            }

            private void ProcessAssumeCmd(AssumeCmd ac)
            {
                Expr expr = CleanAssert.getExprFromAssumeCmd(ac);
                string null_expr = CleanAssert.getNULLFromAssumeCmd(ac);

                var rs = ReadSet.Get(expr);
                IdentifierExpr id = null;
                var cmds = CreateCmds(rs, ReadSet.containsConsts, out id);
                currCmds.AddRange(cmds);
                AssumeCmd newac = new AssumeCmd(Token.NoToken, Expr.Neq(id, new IdentifierExpr(Token.NoToken, getConstant(null_expr))));
                currCmds.Add(newac);
            }

            private void Construct()
            {
                foreach (Cmd c in origBlock.Cmds)
                {
                    if (c is AssignCmd)
                    {
                        var ac = c as AssignCmd;
                        ProcessAssignCmd(ac);
                    }
                    else if (c is CallCmd)
                    {
                        var cc = c as CallCmd;
                        ProcessCallCmd(cc);
                    }
                    else if (c is AssertCmd)
                    {
                        var ac = c as AssertCmd;
                        if (CleanAssert.isNullAssertCmd(ac))
                        {
                            ProcessAssertCmd(ac);
                        }
                    }
                    else if (c is AssumeCmd)
                    {
                        var ac = c as AssumeCmd;
                        if (CleanAssert.isNullAssumeCmd(ac))
                        {
                            ProcessAssumeCmd(ac);
                        }
                    }
                }
                currBlock = new Block(Token.NoToken, origBlock.Label, currCmds, origBlock.TransferCmd);
            }

            private List<Cmd> CreateCmds(HashSet<Tuple<Variable, List<string>>> readSet, bool containsConsts, out IdentifierExpr newRhs)
            {
                var cmds = new List<Cmd>();
                newRhs = null;

                Expr expr = null;
                if (containsConsts)
                {
                    Variable tmpVar = ConstructLocVar();
                    IdentifierExpr tmpId = new IdentifierExpr(Token.NoToken, tmpVar);
                    HavocCmd hc = new HavocCmd(Token.NoToken, new List<IdentifierExpr> { tmpId });
                    cmds.Add(hc);
                    newRhs = tmpId;
                    expr = Expr.Eq(tmpId, new IdentifierExpr(Token.NoToken, specialConstant.Name, specialConstant.TypedIdent.Type));
                }
                foreach (var tup in readSet)
                {
                    if (tup.Item1 is GlobalVariable) addGlobalVar(tup.Item1.Name);

                    Expr currExpr = null;
                    if (tup.Item2.Count == 0)
                    {
                        Variable tmpVar = ConstructLocVar();
                        IdentifierExpr tmpId = new IdentifierExpr(Token.NoToken, tmpVar);
                        HavocCmd hc = new HavocCmd(Token.NoToken, new List<IdentifierExpr> { tmpId });
                        cmds.Add(hc);
                        newRhs = tmpId;
                        if (tup.Item1 is Constant)
                            currExpr = Expr.Eq(tmpId, new IdentifierExpr(Token.NoToken, getConstant(tup.Item1.Name)));
                        else
                            currExpr = Expr.Eq(tmpId, new IdentifierExpr(Token.NoToken, tup.Item1));
                    }
                    else
                    {
                        Debug.Assert(!(tup.Item1 is Constant));
                        Variable currTarget = null;
                        for (int i = tup.Item2.Count - 1 ; i >= 0 ; i--)
                        {
                            var currSource = (i == tup.Item2.Count - 1) ? tup.Item1 : currTarget;
                            currTarget = ConstructLocVar();
                            IdentifierExpr currId = new IdentifierExpr(Token.NoToken, currTarget);
                            newRhs = currId;
                            HavocCmd hc = new HavocCmd(Token.NoToken, new List<IdentifierExpr> { currId });
                            cmds.Add(hc);
                            GlobalVariable map = getGlobalMap(tup.Item2[i]);
                            currExpr = new NAryExpr(Token.NoToken, new MapSelect(Token.NoToken, 2), new List<Expr> { new IdentifierExpr(Token.NoToken, map), new IdentifierExpr(Token.NoToken, currSource), currId });
                            if (i != 0)
                            {
                                var currAC = BoogieAstFactory.MkAssume(currExpr);
                                cmds.Add(currAC);
                            }
                        }
                    }

                    if (expr == null) expr = currExpr;
                    else expr = Expr.Or(expr, currExpr);
                }
                Debug.Assert(expr != null);
                var ac = BoogieAstFactory.MkAssume(expr);
                cmds.Add(ac);

                return cmds;
            }

            private LocalVariable ConstructLocVar()
            {
                LocalVariable lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "cpTmp" + (varCounter++).ToString(), new CtorType(Token.NoToken, Type_AS, new List<btype>())));
                locVars.Add(lv);
                return lv;
            }

            public static Block ProcessBlock(Block b, out List<Variable> newLocVars)
            {
                var cc = new ConstructConstraintStmts(b);
                cc.Construct();
                newLocVars = cc.locVars;
                return cc.currBlock;
            }
        }
    }

    public class ReadSet : FixedVisitor
    {
        HashSet<Tuple<Variable, List<string>>> readSet;
        List<string> currMapSelects;
        public static bool containsConsts;

        private ReadSet()
        {
            readSet = new HashSet<Tuple<Variable, List<string>>>();
            currMapSelects = new List<string>();
            containsConsts = false;
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

        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            containsConsts = true;
            return base.VisitLiteralExpr(node);
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
            if (AliasAnalysis.mergeFull)
            {
                if (full) this.allocSite = "allocSiteSpecial";
                else this.allocSite = "allocSite" + (counter++).ToString();
            }
            else
                this.allocSite = "allocSite" + (counter++).ToString();
            this.target = target;
            this.full = full;
        }

        public static string getSite()
        {
            return ("allocSite" + counter.ToString());
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
        public static bool solved;
        public static int environmentPointersUnroll = 0;
        public static bool dbg = false;
        public static bool NoEmptyLoads = false;
        public static bool printWarnings = false;
        string null_allocSite;
        public static bool doCycleElimination = false;
        public static int numCycles = 0;

        // fake node implementation
        Dictionary<FakeNode, HashSet<string>> FakePointsTo;
        Dictionary<FakeNode, HashSet<string>> FakePointsToDelta;
        HashSet<FakeNode> fakeworklist;
        Dictionary<string, FakeNode> string2node;


        private class FakeNode
        {
            public HashSet<string> collection;

            public FakeNode(HashSet<string> c)
            {
                collection = c;
            }

            public FakeNode(string s)
            {
                collection = new HashSet<string>() { s };
            }

            public FakeNode()
            {
                collection = new HashSet<string>();
            }

            public void Add(string s)
            {
                collection.Add(s);
            }

            public override bool Equals(object obj)
            {
                if (obj is FakeNode)
                {
                    FakeNode ob = obj as FakeNode;
                    return collection.SetEquals(ob.collection);
                }
                return false;
            }

            public override int GetHashCode()
            {
                int hash = 0;
                foreach (string s in collection) hash += s.GetHashCode();
                return hash;
            }

            public override string ToString()
            {
                string s = "{";
                foreach (string c in collection) s += c + " ";
                s += "}";
                return s;
            }
        }

        public AliasConstraintSolver()
        {
            constraints = new List<AliasConstraint>();
            PointsTo = new Dictionary<string, HashSet<string>>();
            PointsToDelta = new Dictionary<string, HashSet<string>>();
            worklist = new HashSet<string>();
            solved = false;
            null_allocSite = null;

            // FakeNode implementation
            FakePointsTo = new Dictionary<FakeNode, HashSet<string>>();
            FakePointsToDelta = new Dictionary<FakeNode, HashSet<string>>();
            fakeworklist = new HashSet<FakeNode>();
            string2node = new Dictionary<string, FakeNode>();
        }


        public void Add(AliasConstraint constraint)
        {
            Debug.Assert(!solved);
            if (dbg) Console.WriteLine("Adding constraint: {0}", constraint);
            constraints.Add(constraint);
        }

        private void DetectCycle(Dictionary<FakeNode, HashSet<FakeNode>> G, FakeNode source)
        {
            Stack<FakeNode> stack = new Stack<FakeNode>();
            stack.Push(source);
            HashSet<FakeNode> discovered = new HashSet<FakeNode>();

            int i = 0;
            while (stack.Count > 0)
            {
                FakeNode node = stack.Pop();
                if (node.Equals(source) && i > 0)
                {
                    Console.WriteLine("Found a cycle");
                    return;
                }
                if (!discovered.Contains(node))
                {
                    discovered.Add(node);
                    if (G.ContainsKey(node)) foreach (FakeNode fn in G[node]) stack.Push(fn);
                }
                i++;
            }
        }

        private void MergeSCCs(Dictionary<FakeNode, HashSet<FakeNode>> G)
        {
            var Pred = new Dictionary<FakeNode, HashSet<FakeNode>>();
            var Succ = G;

            foreach (FakeNode fn in G.Keys) Pred.Add(fn, new HashSet<FakeNode>());

            foreach (var node in G.Keys)
            {
                foreach (var succs in G[node])
                {
                    if (!Pred.ContainsKey(succs)) Pred.Add(succs, new HashSet<FakeNode>());
                    Pred[succs].Add(node);
                }
            }

            var sccs = new StronglyConnectedComponents<FakeNode>(G.Keys.AsEnumerable(),
                new Adjacency<FakeNode>(n => Succ[n]),
                new Adjacency<FakeNode>(n => Pred[n]));
            sccs.Compute();

            foreach (var scc in sccs)
            {
                if (scc.Count > 1)
                {
                    //Console.WriteLine("Found one!");
                    numCycles++;
                    FakeNode newnode = new FakeNode();
                    FakePointsTo.Add(newnode, new HashSet<string>());
                    FakePointsToDelta.Add(newnode, new HashSet<string>());
                    HashSet<FakeNode> newnode_succs = new HashSet<FakeNode>();
                    foreach (FakeNode fn in scc)
                    {
                        foreach (string s in fn.collection)
                        {
                            string2node[s] = newnode;
                            newnode.Add(s);
                            //Console.Write("{0} ", s);
                        }
                        //Console.WriteLine();
                        foreach (FakeNode succ in Succ[fn])
                        {
                            if (!scc.Contains(succ))
                            {
                                newnode_succs.Add(succ);
                                Pred[succ].Remove(fn);
                                Pred[succ].Add(newnode);
                            }
                        }
                        foreach (FakeNode pred in Pred[fn])
                        {
                            if (!scc.Contains(pred))
                            {
                                //if (!G.ContainsKey(pred)) Console.WriteLine(pred.ToString());
                                G[pred].Remove(fn);
                                G[pred].Add(newnode);
                            }
                        }
                    }
                    foreach (FakeNode fn in scc) G.Remove(fn);
                    G.Add(newnode, newnode_succs);
                }
            }
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
            var origG = new Dictionary<string, HashSet<string>>();

            // FakeNode points-to graph
            var fakeG = new Dictionary<FakeNode, HashSet<FakeNode>>();
            var Succ = new Dictionary<FakeNode, HashSet<FakeNode>>();
            var Pred = new Dictionary<FakeNode, HashSet<FakeNode>>();

            // DoAnalysis
            worklist = new HashSet<string>();

            // DoAnalysis on FakeNode Graph
            fakeworklist = new HashSet<FakeNode>();

            if (doCycleElimination)
            {
                foreach (var a in constraints.OfType<AllocationConstraint>())
                {
                    if (a.target.Equals("NULL")) continue;
                    FakeNode target = new FakeNode(a.target);
                    string2node[a.target] = target;
                    FakePointsToDelta.InitAndAdd(target, a.allocSite);
                    fakeworklist.Add(target);
                }
                foreach (var a in constraints.OfType<AssignConstraint>())
                {
                    FakeNode source = new FakeNode(a.source);
                    FakeNode target = new FakeNode(a.target);
                    string2node[a.source] = source;
                    string2node[a.target] = target;
                    fakeG.InitAndAdd(source, target);
                    //DetectCycle(fakeG, source);
                }

                MergeSCCs(fakeG);

                FakeProcessWorklist(fakeG, variables, varToStore, varToLoad);

                foreach (string s in string2node.Keys)
                {
                    if (!PointsTo.ContainsKey(s)) PointsTo.Add(s, new HashSet<string>());
                    if (FakePointsTo.ContainsKey(string2node[s])) foreach (string aS in FakePointsTo[string2node[s]]) PointsTo[s].Add(aS); 
                }

                
                foreach (var a in constraints.OfType<AllocationConstraint>())
                {
                    if (!a.target.Equals("NULL")) continue;
                    PointsToDelta.InitAndAdd(a.target, a.allocSite);
                    worklist.Add(a.target);
                }

                foreach (var a in constraints.OfType<AssignConstraint>())
                    origG.InitAndAdd(a.source, a.target);
                
                foreach (var n in PointsTo.Keys)
                {
                    if (variables.Contains(n))
                    {
                        foreach (var store in varToStore[n])
                        {
                            var x = store.target;
                            var y = store.source;
                            var f = store.map;

                            foreach (string o in PointsTo[n])
                            {
                                var of = GetODotf(o, f);
                                origG.InitAndAdd(y, of);
                            }
                        }

                        foreach (var load in varToLoad[n])
                        {
                            var x = load.source;
                            var y = load.target;
                            var f = load.map;

                            foreach (string o in PointsTo[n])
                            {
                                var of = GetODotf(o, f);
                                origG.InitAndAdd(of, y);
                            }
                        }
                    }
                }

                ProcessWorklist(origG, variables, varToStore, varToLoad);
                
            }
            else
            {
                foreach (var a in constraints.OfType<AllocationConstraint>())
                {
                    PointsToDelta.InitAndAdd(a.target, a.allocSite);
                    worklist.Add(a.target);
                }
                foreach (var a in constraints.OfType<AssignConstraint>())
                    G.InitAndAdd(a.source, a.target);

                ProcessWorklist(G, variables, varToStore, varToLoad);
            }

            

            if (NoEmptyLoads)
            {
                var newAllocSitesToDepth = new Dictionary<string, int>();

                do
                {
                    // Gather all empty loads
                    var emptyloads = constraints.OfType<LoadConstraint>().Select(GetEmptyLoads).Aggregate(new HashSet<Tuple<string, string>>(),
                        (a, b) => a.Union(b));

                    if (!emptyloads.Any()) break;

                    Console.WriteLine("There were {0} empty loads, trying again", emptyloads.Count());


                    foreach (var tup in emptyloads)
                    {
                        var o = tup.Item1;
                        var f = tup.Item2;

                        var currDepth = newAllocSitesToDepth.ContainsKey(o) ? newAllocSitesToDepth[o] : 0;
                        if (currDepth == environmentPointersUnroll)
                        {
                            // Add {o} to the points-to set of o.f
                            var of = GetODotf(o, f);
                            DiffProp(new HashSet<string> { o }, of);
                            PointsTo[of].UnionWith(PointsToDelta[of]);
                        }
                        else
                        {
                            // create a new allocation site 
                            var oprime = "aa_as_otf" + newAllocSitesToDepth.Count;
                            newAllocSitesToDepth.Add(oprime, currDepth + 1);

                            if (!PointsTo.ContainsKey(oprime)) PointsTo.Add(oprime, new HashSet<string>());
                            if (!PointsToDelta.ContainsKey(oprime)) PointsToDelta.Add(oprime, new HashSet<string>());


                            // Add {o'} to the points-to set of o.f
                            var of = GetODotf(o, f);
                            DiffProp(new HashSet<string> { oprime }, of);
                            PointsTo[of].UnionWith(PointsToDelta[of]);
                        }
                    }

                    ProcessWorklist(G, variables, varToStore, varToLoad);

                } while (true);

            }

            // Warnings
            if (printWarnings)
            {
                foreach (var lc in constraints.OfType<LoadConstraint>().Where(lc =>
                    !PointsTo.ContainsKey(lc.source) || PointsTo[lc.source].Count == 0))
                {
                    Console.WriteLine("Warning: loading from an unallocated value: {0}", lc);
                }
                foreach (var sc in constraints.OfType<StoreConstraint>().Where(sc =>
                    !PointsTo.ContainsKey(sc.target) || PointsTo[sc.target].Count == 0))
                {
                    Console.WriteLine("Warning: storing to an unallocated value: {0}", sc);
                }
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

        // Return (o,f) such that PointsTo(o.f) is empty
        private HashSet<Tuple<string, string>> GetEmptyLoads(LoadConstraint lc)
        {
            var ret = new HashSet<Tuple<string, string>>();
            if(!PointsTo.ContainsKey(lc.source)) return ret;

            var pts = PointsTo[lc.source];
            foreach (var o in pts)
            {
                var of = GetODotf(o, lc.map);
                if (!PointsTo.ContainsKey(of) || PointsTo[of].Count == 0)
                    ret.Add(Tuple.Create(o, lc.map));
            }
            return ret;
        }

        private void ProcessWorklist(Dictionary<string, HashSet<string>> G, HashSet<string> variables,
            Dictionary<string, List<StoreConstraint>> varToStore, Dictionary<string, List<LoadConstraint>> varToLoad)
        {
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

        }

        private void FakeProcessWorklist(Dictionary<FakeNode, HashSet<FakeNode>> G, HashSet<string> variables,
            Dictionary<string, List<StoreConstraint>> varToStore, Dictionary<string, List<LoadConstraint>> varToLoad)
        {
            while (fakeworklist.Count != 0)
            {
                var n = fakeworklist.First();
                fakeworklist.Remove(n);

                if (!G.ContainsKey(n)) G.Add(n, new HashSet<FakeNode>());
                if (!FakePointsTo.ContainsKey(n)) FakePointsTo.Add(n, new HashSet<string>());
                if (!FakePointsToDelta.ContainsKey(n)) FakePointsToDelta.Add(n, new HashSet<string>());

                G[n].Iter(nprime => FakeDiffProp(FakePointsToDelta[n], nprime));

                foreach (string s in n.collection)
                {
                    if (variables.Contains(s))
                    {
                        foreach (var store in varToStore[s])
                        {
                            var x = store.target;
                            var y = store.source;
                            var f = store.map;
                            var ptd = FakePointsToDelta[n];
                            foreach (var o in ptd)
                            {
                                var of = GetODotf(o, f);

                                FakeNode fakey = new FakeNode(y);
                                if (!string2node.ContainsKey(y)) string2node[y] = fakey;

                                if (!G.ContainsKey(string2node[y])) G.Add(string2node[y], new HashSet<FakeNode>());
                                if (!FakePointsTo.ContainsKey(string2node[y])) FakePointsTo.Add(string2node[y], new HashSet<string>());

                                FakeNode fakeof = new FakeNode(of);
                                if (!string2node.ContainsKey(of)) string2node[of] = fakeof;
                                if (!G[string2node[y]].Contains(string2node[of]))
                                {
                                    G[string2node[y]].Add(string2node[of]);
                                    //DetectCycle(G, string2node[y]);
                                    //MergeSCCs(G);
                                    if (!FakePointsTo.ContainsKey(string2node[y])) FakePointsTo.Add(string2node[y], new HashSet<string>());
                                    FakeDiffProp(FakePointsTo[string2node[y]], string2node[of]);
                                }

                            }
                        }
                        foreach (var load in varToLoad[s])
                        {
                            var x = load.source;
                            var y = load.target;
                            var f = load.map;
                            var ptd = FakePointsToDelta[n];
                            foreach (var o in ptd)
                            {
                                var of = GetODotf(o, f);

                                FakeNode fakeof = new FakeNode(of);
                                if (!string2node.ContainsKey(of)) string2node[of] = fakeof;
                                if (!G.ContainsKey(string2node[of])) G.Add(string2node[of], new HashSet<FakeNode>());
                                if (!FakePointsTo.ContainsKey(string2node[of])) FakePointsTo.Add(string2node[of], new HashSet<string>());

                                FakeNode fakey = new FakeNode(y);
                                if (!string2node.ContainsKey(y)) string2node[y] = fakey;
                                if (!G[string2node[of]].Contains(string2node[y]))
                                {
                                    G[string2node[of]].Add(string2node[y]);
                                    //DetectCycle(G, string2node[of]);
                                    //MergeSCCs(G);
                                    if (!FakePointsTo.ContainsKey(string2node[of])) FakePointsTo.Add(string2node[of], new HashSet<string>());
                                    FakeDiffProp(FakePointsTo[string2node[of]], string2node[y]);
                                }
                            }
                        }
                    }
                }
                FakePointsTo[n].UnionWith(FakePointsToDelta[n]);
                FakePointsToDelta[n] = new HashSet<string>();
            }

        }

        public void SetResults(Dictionary<string, HashSet<string>> pts)
        {
            PointsTo = pts;
            solved = true;
        }

        public Dictionary<string, HashSet<string>> GetPointsToSet()
        {
            return PointsTo;
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
                        if (doCycleElimination)
                        {
                            FakeNode fakeof = new FakeNode(of);
                            if (!string2node.ContainsKey(of)) string2node[of] = fakeof;
                            if (!FakePointsTo.ContainsKey(string2node[of]))
                                FakePointsTo.Add(string2node[of], new HashSet<string>());
                            FakePointsTo[string2node[of]].Add(nsite);
                        }
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

            // If the variable is known to be non null, remove allocation site of NULL from its points to set
            if (PointsTo.ContainsKey("NULL") && PointsTo["NULL"].Count > 0)
            {
                null_allocSite = PointsTo["NULL"].First();
                if (n.StartsWith("cseTmp") && GVN.doGVN) change.Remove(null_allocSite);
            }
            
            if (!change.IsSubsetOf(PointsToDelta[n]))
                worklist.Add(n);

            PointsToDelta[n] = PointsToDelta[n].Union(change);
        }

        private void FakeDiffProp(HashSet<string> srcSet, FakeNode n)
        {
            if (!FakePointsTo.ContainsKey(n))
                FakePointsTo.Add(n, new HashSet<string>());
            if (!FakePointsToDelta.ContainsKey(n))
                FakePointsToDelta.Add(n, new HashSet<string>());

            var change = new HashSet<string>(srcSet);
            change.ExceptWith(FakePointsTo[n]);

            // If the variable is known to be non null, remove allocation site of NULL from its points to set
            if (string2node.ContainsKey("NULL") && FakePointsTo.ContainsKey(string2node["NULL"]) && FakePointsTo[string2node["NULL"]].Count > 0)
            {
                null_allocSite = FakePointsTo[string2node["NULL"]].First();
                foreach (string s in n.collection) if (AliasAnalysis.non_null_vars.Contains(s)) change.Remove(null_allocSite);
            }

            if (!change.IsSubsetOf(FakePointsToDelta[n]))
                fakeworklist.Add(n);

            FakePointsToDelta[n] = FakePointsToDelta[n].Union(change);
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

        // Does var1 only point to var2?
        public bool IsMustAlias(string var1, string var2)
        {
            Debug.Assert(solved);
            if (!PointsTo.ContainsKey(var1) || PointsTo[var1].Count == 0)
            {
                if (dbg) Console.WriteLine("Warning: empty points-to set for {0}", var1);
                return false;
            }

            if (!PointsTo.ContainsKey(var2) || PointsTo[var2].Count == 0)
            {
                if (dbg) Console.WriteLine("Warning: empty points-to set for {0}", var2);
                return false;
            }

            if (PointsTo[var1].Count > 1 || PointsTo[var2].Count > 1) return false;
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
