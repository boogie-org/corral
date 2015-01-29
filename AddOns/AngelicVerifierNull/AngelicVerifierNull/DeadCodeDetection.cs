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
    #region DeadCode Instrumentation
    /// <summary>
    /// Instrument program for deadcode detection
    /// </summary>
    //class DeadCodeInstrumentation : FixedVisitor
    //{
        
    //    Program origprog;
    //    Dictionary<string, HashSet<string>> pointsTo;
    //    HashSet<string> globalPointers;
    //    Dictionary<string, HashSet<string>> targetBranches; // Impl Name -> Set of var names

    //    public DeadCodeInstrumentation(Program _prog, Dictionary<string, HashSet<string>> _pst)
    //    {
    //        origprog = _prog;
    //        NonNullAssumptions = new HashSet<string>(); // maps whose fields are assumed non-null
    //        //nonNullPointsTo = new Dictionary<string, HashSet<string>>();
    //        pointsTo = _pst;
    //        globalPointers = new HashSet<string>();
    //        GetPointerDecls(_prog.GlobalVariables()).Iter(g => { globalPointers.Add(g.Name); });
    //        targetBranches = new Dictionary<string, HashSet<string>>();
            
    //        Console.WriteLine("Points-to: " + pointsTo.Count);
    //    }

    //    public HashSet<string> GetDeadBranches()
    //    {
    //        HashSet<string> ret = new HashSet<string>();
    //        targetBranches.Keys.Iter(k => ret.UnionWith(targetBranches[k]));
    //        ret.IntersectWith(NonNullAssumptions);
    //        return ret;
    //    }

    //    /// <summary>
    //    /// Collect non-null field assumption
    //    /// </summary>
    //    public void CollectAssumptions()
    //    {
    //        Implementation extraInit = BoogieUtil.findProcedureImpl(origprog.TopLevelDeclarations, "corralExtraInit");
    //        if (extraInit == null)
    //            throw new Exception("Input program does not have corralExtraInit!");

    //        foreach (Block b in extraInit.Blocks)
    //        {
    //            b.Cmds.OfType<AssumeCmd>().Iter(a =>
    //            {
    //                if (a.Expr.ToString().Contains("<="))
    //                    return;

    //                var varCollector = new VariableCollector();
    //                varCollector.Visit(a.Expr);
    //                varCollector.usedVars.Where(u => u.TypedIdent.Type.IsMap)
    //                    .Iter(m => NonNullAssumptions.Add(m.ToString()));
    //            });
    //        }

    //        NonNullAssumptions.IntersectWith(globalPointers);
    //        Console.WriteLine("NonNull Map Count: " + NonNullAssumptions.Count);
    //        //Debug.Assert(nonNullMaps.IsSubsetOf(globalPointers));
            

    //        // compute points-to set of nonnull maps
    //        //nonNullMaps.Iter(n => pointsTo.Keys.Where(k =>
    //        //{
    //        //    var pair = deconstructODotf(k);
    //        //    if (pair == null) return false;
    //        //    return pair.Item2.Equals(n);
    //        //}).Iter(p =>
    //        //{
    //        //    //Console.WriteLine(p);
    //        //    if (!nonNullPointsTo.Keys.Contains(n))
    //        //        nonNullPointsTo[n] = new HashSet<string>();

    //        //    nonNullPointsTo[n].UnionWith(pointsTo[p]);
    //        //})
    //        //        );
    //    }

    //    /// <summary>
    //    /// Insert assert false for each conditional branch
    //    /// </summary>
    //    /// <param name="ssa">SSA program</param>
    //    /// <param name="assumptions">Output set of non-null field assumptions</param>
    //    /// <param name="assertCount">Output number of assertions inserted</param>
    //    /// <returns></returns>
    //    public Program DoDeadCodeInstrumentation(Program ssa, out int assertCount)
    //    {  
    //        CollectAssumptions();
    //        // do dead code instrumentations
    //        VisitProgram(ssa);
    //        var orig = InsertAssertFalse(out assertCount);

    //        return orig;
    //    }

    //    // Insert assert false to target branches
    //    private Program InsertAssertFalse(out int count)
    //    {
    //        var assertCount = 0;
    //        // print target branches to insert
    //        //targetBranches.Keys.Iter(k => { targetBranches[k].Iter(v => Console.WriteLine(v)); });
    //        // make assert false
    //        var assertFlase = BoogieAstFactory.MkAssert(Expr.False);
    //        (assertFlase as AssertCmd).Attributes = new QKeyValue(Token.NoToken,
    //            "deadcode", new List<object>() { }, null);

    //        origprog.TopLevelDeclarations.OfType<Implementation>()
    //            .Iter(imp =>
    //            {
    //                //Console.WriteLine(imp.Name);
    //                imp.Blocks.Iter(blk =>
    //            {
    //                //targetBranches[imp.Name].Iter(a => Console.WriteLine(a));
    //                var clist = new List<Cmd>();
    //                blk.Cmds.Iter(cmd =>
    //                {
    //                    if (cmd is AssertCmd) // ignore assert nonnull
    //                    {
    //                        var assCmd = cmd as AssertCmd;
    //                        if (BoogieUtil.checkAttrExists("nonnull", assCmd.Attributes))
    //                            return;
    //                    }
    //                    else if (cmd is AssumeCmd)
    //                    {
    //                        clist.Add(cmd);

    //                        var assuCmd = cmd as AssumeCmd;
    //                        if (!BoogieUtil.checkAttrExists("partition", assuCmd.Attributes))
    //                            return;
    //                        if (assuCmd.Expr is NAryExpr && assuCmd.ToString().Contains("=="))
    //                        {
    //                            var condition = assuCmd.Expr as NAryExpr;
    //                            Debug.Assert(condition.Args.Count == 2);
    //                            if (condition.Args.Any(a => a.ToString().Equals("NULL")))
    //                            {
    //                                Expr sVar = (condition.Args[0].ToString().Equals("NULL")) ?
    //                                    condition.Args[1] : condition.Args[0];

    //                                if (sVar is NAryExpr)
    //                                {  // a map access expr
    //                                    //Console.WriteLine(sVar);
    //                                    var map = sVar as NAryExpr;

    //                                    if (map.Fun is MapSelect &&
    //                                        targetBranches[imp.Name].Contains(map.Args[0].ToString()))
    //                                    {
    //                                        //Console.WriteLine(sVar);
    //                                        clist.Add(assertFlase);
    //                                        assertCount++;
    //                                    }
    //                                }
    //                                else if (targetBranches[imp.Name].Contains(sVar.ToString()))
    //                                {
    //                                    clist.Add(assertFlase);
    //                                    assertCount++;
    //                                }
    //                            }
    //                        }
    //                        return;
    //                    }
    //                    clist.Add(cmd);
    //                });
    //                blk.Cmds = clist;
    //            });
    //            });

    //        count = assertCount;
    //        return origprog;
    //    }

    //    // strip the version identifier added by SSA
    //    private string StripSSA(string name)
    //    {
    //        if (name.LastIndexOf("_") < 0) return name;
    //        return name.Remove(name.LastIndexOf("_"));
    //    }

    //    public override Implementation VisitImplementation(Implementation node)
    //    {
    //        targetBranches[node.Name] = new HashSet<string>();
    //        node.Blocks.Iter(b =>
    //            {
    //                b.Cmds.Iter(c =>
    //                    {
    //                        if (c is AssumeCmd)
    //                        {
    //                            var assuCmd = c as AssumeCmd;

    //                            if (!BoogieUtil.checkAttrExists("partition", assuCmd.Attributes)) return;
    //                            if (assuCmd.Expr is NAryExpr && assuCmd.ToString().Contains("=="))
    //                            {
    //                                var condition = assuCmd.Expr as NAryExpr;
    //                                Debug.Assert(condition.Args.Count == 2);
    //                                if (condition.Args.Any(a => a.ToString().Equals("NULL")))
    //                                {
    //                                    Expr sVar = (condition.Args[0].ToString().Equals("NULL")) ?
    //                                        condition.Args[1] : condition.Args[0];

    //                                    if (sVar is NAryExpr)
    //                                    {
    //                                        // a map access expr
    //                                        var map = sVar as NAryExpr;
    //                                        if (map.Fun is MapSelect)
    //                                        {
    //                                            var field = map.Args[0].ToString();
    //                                            var index = map.Args[1].ToString();

    //                                            if (!globalPointers.Contains(field)
    //                                                || !NonNullAssumptions.Contains(field))
    //                                                return; // only consier globals
    //                                            if (index.IndexOf("(") >= 0)
    //                                                index = index.Substring(index.IndexOf("(") + 1, index.IndexOf(")") -
    //                                                    index.IndexOf("(") - 1);

    //                                            Console.WriteLine("Detect MAP: " + field + " : " + index + " : " + node.Name);
    //                                            targetBranches[node.Name].Add(field);

    //                                            //if (nonNullPointsTo.Keys.Contains(field))
    //                                            //Stats.count("nonnull");
    //                                            //PrintPointsToSet(GetPointsTo(index, field));
    //                                        }
    //                                    }
    //                                    else
    //                                    {
    //                                        Stats.count("nonnull");
    //                                        // a simple var  assume (v == NULL);
    //                                        //Console.WriteLine("VAR: " + sVar);
    //                                        var key = sVar.ToString() + "$" + node.Name;
    //                                        // the pointer is connected to one of the nonnull fields
    //                                        if (
    //                                            GetPointsTo(key).Count > 0 && // is a pointer
    //                                            !GetPointsTo(key).Contains("allocSite0")) // non-null
    //                                        //&& nonNullPointsTo.Keys
    //                                        //.Any(n => nonNullPointsTo[n].IsSupersetOf(GetPointsTo(key))))
    //                                        {
    //                                            Console.WriteLine("Detect Pointer: " + key);
    //                                            targetBranches[node.Name].Add(StripSSA(sVar.ToString()));
    //                                        }
    //                                    }
    //                                }
    //                            }
    //                        }
    //                    });
    //            });

    //        return base.VisitImplementation(node);
    //    }

    //    private List<Variable> GetPointerDecls(IEnumerable<Variable> decls)
    //    {
    //        return decls.Where(d => !BoogieUtil.checkAttrExists("scalar", d.Attributes)).ToList();
    //    }
    //    private List<Variable> GetPointerVars(IEnumerable<Variable> vars)
    //    {
    //        return vars.Where(x => IsPointerVariable(x)).ToList();
    //    }
    //    private bool IsPointerVariable(Variable x)
    //    {
    //        return x.TypedIdent.Type.IsInt &&
    //            !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
    //    }
    //    private void PrintPointsToSet(IEnumerable<string> set)
    //    {
    //        Console.Write("SET: [");
    //        Console.Write(set.Concat(","));
    //        Console.Write("]\n");
    //    }

    //    public HashSet<string> GetPointsTo(string var)
    //    {
    //        if (pointsTo.Keys.Contains(var))
    //            return pointsTo[var];
    //        else return new HashSet<string>();
    //    }
    //    public HashSet<string> GetPointsTo(string var, string map)
    //    {
    //        var ret = new HashSet<string>();
    //        if (!pointsTo.Keys.Contains(var))
    //            return ret;

    //        foreach (var o in pointsTo[var])
    //        {
    //            ret.UnionWith(pointsTo[GetODotf(o, map)]);
    //        }
    //        return ret;
    //    }
    //    private string GetODotf(string o, string f)
    //    {
    //        return "allocConstruct$" + o + "$" + f;
    //    }

    //    private bool isODotf(string of)
    //    {
    //        return of.StartsWith("allocConstruct$");
    //    }

    //    private Tuple<string, string> deconstructODotf(string of)
    //    {
    //        var sp = of.Split('$');
    //        if(sp.Length != 3) return null;

    //        return Tuple.Create(sp[1], sp[2]);
    //    }
    //}
#endregion DeadCode Instrumentation

    #region DeadCode Detection
    /// <summary>
    /// Detect dead branches and the non-null field assumptions
    /// which cause them
    /// </summary>
    public class DeadCodeDetection
    {
        class DeadCodeAnalysisResult
        {
            public HashSet<string> AssumptionsToLift;
            public DeadCodeAnalysisResult()
            {
                AssumptionsToLift = new HashSet<string>();
            }
        }

        cba.Configs CorralConfig = null;
        cba.CorralState CorralState = null;
        HashSet<string> NonNullAssumptions = null; // non-null field assumptions in corralExtraInint
        PersistentProgram InstrumentedProg = null; // program with assert false
        Instrumentations.HarnessInstrumentation harness; // harness for Corral
        AvnInstrumentation instr;
        int AssertCount; // number of assert false
        const int CORRAL_RUN_LIMIT = 5; // limit the number of calls to corral
        private HashSet<string> globalPointers; // global pointers


        public DeadCodeDetection(PersistentProgram _instProg, cba.Configs _config)
        {
            InstrumentedProg = _instProg;
            globalPointers = new HashSet<string>();
            GetPointerDecls(_instProg.getProgram().GlobalVariables)
                .Iter(g => { globalPointers.Add(g.Name); });

            CollectAssumptions();
            CountAssertFalse();

            CorralConfig = _config;
            harness = new Instrumentations.HarnessInstrumentation(_instProg.getProgram(), CorralConfig.mainProcName, true);
            instr = new AvnInstrumentation(harness);
            ProgTransformation.PersistentProgramIO.useDuplicator = true;
            // Rewrite program to a more convinient form
            var rc = new cba.RewriteCallCmdsPass(true);
            InstrumentedProg = rc.run(InstrumentedProg);
            instr.run(InstrumentedProg);
        }

        private void CountAssertFalse()
        {
            InstrumentedProg.getProgram().TopLevelDeclarations.OfType<Implementation>()
                .Iter(imp => imp.Blocks.Iter(blk => blk.Cmds.OfType<AssertCmd>()
                    .Iter(cmd =>
                    {
                        if (BoogieUtil.checkAttrExists("deadcode", cmd.Attributes))
                            AssertCount++;
                    })));
        }

        /// <summary>
        /// Remove assert false from branches iteratively using Corral.
        /// </summary>
        /// <returns>Set of non-null field assumptions that causes the remaining dead branches</returns>
        public HashSet<string> FindDeadBranchIterative()
        {
            // using corral to find dead branches from the candidates "assert false"
            // run corral iteratively until no assert false can be supressed
            if (AssertCount <= 0)
                return new HashSet<string>();
            
            int RemoveCount = 0;
            while (true && RemoveCount<= CORRAL_RUN_LIMIT)
            {
                var prog = instr.GetCurrProgram();
                cba.ErrorTrace cex = null;
                // Don't reuse the call-tree 
                if (CorralState != null)
                    CorralState.CallTree = new HashSet<string>();
                try
                {
                    cex = RunCorral(prog);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Corral call terminates inconclusively with {0}...", e.Message);
                    break;
                }

                if (cex == null)
                {
                    Console.WriteLine(string.Format("No more assert false found, {0} dead branches left", 
                        AssertCount - RemoveCount));
                    break;
                }

                //get the error pathProgram
                CoreLib.SDVConcretizePathPass concretize;
                var pprog = Driver.GetPathProgram(cex, prog, out concretize);
                var tok = instr.SuppressAssert(pprog.getProgram());
                RemoveCount++;
            }

            HashSet<string> ret = new HashSet<string>();
            if (RemoveCount < CORRAL_RUN_LIMIT)
            {
                ret.UnionWith(CorralState.TrackedVariables);
                Debug.Assert(NonNullAssumptions != null);
                ret.IntersectWith(NonNullAssumptions);
            }

            return ret;
        }

        // call Corral on the instrumented, slightly modified
        // do not reuse previous tracked variables
        private cba.ErrorTrace RunCorral(PersistentProgram prog)
        {
            //if (CorralState != null)
            //{
            //    CorralConfig.trackedVars.UnionWith(CorralState.TrackedVariables);
            //    cba.ConfigManager.progVerifyOptions.CallTree = CorralState.CallTree;
            //}

            var refinementState = new cba.RefinementState(prog,
                new HashSet<string>(CorralConfig.trackedVars.Union(new string[] { instr.assertsPassedName })),
                false);

            cba.ErrorTrace cexTrace = null;
            try
            {
                cba.Driver.checkAndRefine(prog, refinementState, null, out cexTrace);
            }
            catch (Exception)
            {
                // dump corral state for next iteration
                CorralState = new cba.CorralState();
                CorralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
                CorralState.TrackedVariables = refinementState.getVars().Variables;

                throw;
            }

            // dump corral state for next iteration
            CorralState = new cba.CorralState();
            CorralState.CallTree = cba.ConfigManager.progVerifyOptions.CallTree;
            CorralState.TrackedVariables = refinementState.getVars().Variables;

            return cexTrace;
        }

        /// <summary>
        /// Detect dead branches caused by over-constrained field non-null assumptions
        /// </summary>
        /// <param name="origProg">original program</param>
        /// <param name="ssaProg">SSA program used by alias analysis</param>
        /// <param name="_config">corral config</param>
        /// <param name="_pts">points-to set produced by alias analysis</param>
        /// <returns>A program with over-constrained assumptions removed</returns>
        public static PersistentProgram Detect(PersistentProgram origProg,
            cba.Configs _config)
        {
            // deadcode detection only works for single entrypoint program
            // program with multiple entrypoints should be sliced
            //ssaProg.TopLevelDeclarations.OfType<Procedure>()
            //    .Iter(p => Console.WriteLine(QKeyValue.FindBoolAttribute(p.Attributes, "entrypoint")));
            var prog = origProg.getProgram();
            if (prog.TopLevelDeclarations.OfType<Procedure>()
                .Count(p => QKeyValue.FindBoolAttribute(p.Attributes, "entrypoint")) > 1)
            {
                Utils.Print("More than one entrypoint exist, dead code detection is disabled!",
                    Utils.PRINT_TAG.AV_OUTPUT);
                return origProg;
            }

            // disable assert non-null
            var rn = new Instrumentations.RemoveAssertNonNull();
            prog = rn.VisitProgram(prog);
            var progNoNonNull = new PersistentProgram(prog, origProg.mainProcName, origProg.contextBound);

            // instrument the original program by inserting "assert false" in suspicous
            // branches. the branches are selected according to alias analysis results
            var deadProg_ = InstrumentBranches.Run(progNoNonNull.getProgram(), progNoNonNull.mainProcName, true, true);
            
            BoogieUtil.PrintProgram(deadProg_, "dead.bpl");
            var deadProg = new PersistentProgram(deadProg_, progNoNonNull.mainProcName, 1);

            var detector = new DeadCodeDetection(deadProg, _config);
            HashSet<string> AssumptionsToRemove = detector.FindDeadBranchIterative();

            // remove assumptions from original program
            AssumptionsToRemove.Iter(a => Console.WriteLine("REMOVE: " + a));

            var retProg = origProg.getProgram();
            Implementation extraInit = Instrumentations.GetEnvironmentAssumptionsProc(retProg);
            if (extraInit == null)
                throw new Exception("Input program does not have corralExtraInit!");

            foreach (Block b in extraInit.Blocks)
            {
                List<Cmd> newCmdSeq = new List<Cmd>();
                b.Cmds.Iter(a =>
                {
                    if (a is AssumeCmd)
                    {
                        var assuCmd = a as AssumeCmd;
                        if (assuCmd.Expr is ForallExpr && !assuCmd.Expr.ToString().Contains("<="))
                        {
                            var varCollector = new VariableCollector();
                            varCollector.Visit(assuCmd.Expr);
                            if (varCollector.usedVars
                                .Where(u => u.TypedIdent.Type.IsMap)
                                .Any(m => AssumptionsToRemove.Contains(m.ToString())))
                                return;
                        }
                    }
                    newCmdSeq.Add(a);
                });
                b.Cmds = newCmdSeq;
            }

            return new PersistentProgram(retProg, origProg.mainProcName, origProg.contextBound);
        }

        /// <summary>
        /// Collect non-null field assumption
        /// </summary>
        private void CollectAssumptions()
        {
            var extraInit = Instrumentations.GetEnvironmentAssumptionsProc(InstrumentedProg.getProgram());
            if (extraInit == null)
                throw new Exception("Input program does not have corralExtraInit!");

            NonNullAssumptions = new HashSet<string>();
            foreach (Block b in extraInit.Blocks)
            {
                b.Cmds.OfType<AssumeCmd>().Iter(a =>
                {
                    if (a.Expr.ToString().Contains("<="))
                        return;
                    //Console.WriteLine(a.Expr);
                    var varCollector = new VariableCollector();
                    varCollector.Visit(a.Expr);
                    varCollector.usedVars.Where(u => u.TypedIdent.Type.IsMap)
                        .Iter(m => NonNullAssumptions.Add(m.ToString()));
                });
            }

            NonNullAssumptions.IntersectWith(globalPointers);
            Console.WriteLine("NonNull Map Count: " + NonNullAssumptions.Count);
        }

        private List<Variable> GetPointerDecls(IEnumerable<Variable> decls)
        {
            return decls.Where(d => !BoogieUtil.checkAttrExists("scalar", d.Attributes)).ToList();
        }
    }
#endregion DeadCode Detection
}