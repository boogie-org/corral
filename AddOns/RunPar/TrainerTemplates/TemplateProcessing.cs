using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.IO;
using Microsoft.Boogie;
using System.Diagnostics.Contracts;
using Microsoft.Basetypes;
using Microsoft.Boogie.VCExprAST;
using Microsoft.Boogie.Houdini;

namespace Microsoft.Boogie
{
    public class RuleTemplate
    {
        public HashSet<Expr> preSet = new HashSet<Expr>();
        public HashSet<Expr> postSet = new HashSet<Expr>();

        public HashSet<string> preSetStr = new HashSet<string>();
        public HashSet<string> postSetStr = new HashSet<string>();

        public int count;

        public RuleTemplate(HashSet<Expr> preSet, HashSet<Expr> postSet)
        {
            this.preSet.UnionWith(preSet);
            this.postSet.UnionWith(postSet);

            preSet.Iter<Expr>(n => preSetStr.Add(n.ToString()));
            postSet.Iter<Expr>(n => postSetStr.Add(n.ToString()));
        }

        public RuleTemplate(Trainer.RuleAsString r)
        {
            this.preSetStr.UnionWith(r.preSet);
            this.postSetStr.UnionWith(r.postSet);
            LoadExprs();
        }

        public void LoadExprs()
        {
            Program program;

            string preStr = ListToDisjoin(preSetStr, "ensures {:pre}");
            string postStr = ListToDisjoin(postSetStr, "ensures {:post}");

            // parse str as an unresolved expr
            //var programText = string.Format("procedure foo(); requires {0}; ensures {1};", preStr, postStr);
            var programText = string.Format("procedure foo(); {0} {1}", preStr, postStr);
            Parser.Parse(programText, "dummy.bpl", out program);

            // the program now just has the procedure with ensures/requires; the respective variables need to be added
            // get variables
            var gv = (new Trainer.GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);

            // resolve
            program.Resolve();

            program.TopLevelDeclarations.OfType<Procedure>().First().Ensures.Where(ens => QKeyValue.FindBoolAttribute(ens.Attributes, "pre")).Iter(n => preSet.Add(n.Condition));
            program.TopLevelDeclarations.OfType<Procedure>().First().Ensures.Where(ens => QKeyValue.FindBoolAttribute(ens.Attributes, "post")).Iter(n => postSet.Add(n.Condition));
        }

        private static string ListToDisjoin(HashSet<string> setStr, string prefix)
        {
            string buf = null;
            setStr.Iter<string>(n => buf += prefix + " " + n + "; ");
            return buf;
        }

        public override int GetHashCode()
        {
            return preSetStr.Count * postSetStr.Count;
        }

        public override bool Equals(object obj)
        {
            RuleTemplate t = obj as RuleTemplate;
            return preSetStr.SetEquals(t.preSetStr) && postSetStr.SetEquals(t.postSetStr);
        }
    }

    public class RuleTemplateDB
    {
        public static Dictionary<RuleTemplate, int> RuleTemplateSet = new Dictionary<RuleTemplate, int>(); // <rule, numInstances>

        public static void record(RuleTemplate t)
        {
            if (RuleTemplateSet.ContainsKey(t))
            {
                RuleTemplateSet[t]++;
            }
            else
            {
                RuleTemplateSet[t] = 1; // insert a new template
            }
        }

        public static void dump()
        {
            StreamWriter sw = new StreamWriter("Templates.txt");

            foreach (RuleTemplate t in RuleTemplateSet.Keys)
            {
                sw.WriteLine("{0}\t{1}\t{2}", getPredicatesList(t.preSet), getPredicatesList(t.postSet), RuleTemplateSet[t]);
            }

            sw.Close();
        }

        public static string getPredicatesList(HashSet<Expr> predSet)
        {
            string buf = "";

            foreach (Expr e in predSet)
            {
                buf += e.ToString() + ", ";
            }

            return buf;
        }

        private static Tuple<IdentifierExpr, bool> getVarInPredicate(Expr predicate, int p)
        {
            IdentifierExpr v = null;
            bool isOld = false;

            if (predicate is NAryExpr)
            {
                var id = (predicate as NAryExpr).Args[p];

                if (id is OldExpr)
                {
                    v = ((id as OldExpr).Expr) as IdentifierExpr;
                    isOld = true;
                }
                else
                {
                    v = id as IdentifierExpr;
                    isOld = false;
                }
            }

            return new Tuple<IdentifierExpr, bool>(v, isOld);
        }

        // a predicate is a post predicate if any of the variables in the predicate is not OldExpr
        public static bool isPost(Expr predicate)
        {
            bool isPost = false; // if at least one variable is not old(.), then expression is post

            // check if predicate is relevant w.r.t modifies set

            var v1 = getVarInPredicate(predicate, 0);
            var v2 = getVarInPredicate(predicate, 1);

            // check if it is pre or post
            if (v1.Item1 != null && !v1.Item2)
                isPost = true;

            if (v2.Item1 != null && !v2.Item2)
                isPost = true;

            return isPost;
        }

        public static void RecordTemplates(string procname, HashSet<Clause> clauseSet, OldExprBindings oldExprBindings) // clauseSet is a conjuction of clauses
        {
            Dictionary<VCExpr, Expr> bounds = oldExprBindings.GetDict(procname);

            // each clause is a rule, as it can be written as pre => post
            foreach (Clause c in clauseSet)
            {
                HashSet<VCExpr> participatingPredicates = new HashSet<VCExpr>();
                participatingPredicates.UnionWith(c.pos);
                participatingPredicates.UnionWith(c.neg);

                HashSet<Expr> preSet = new HashSet<Expr>();
                HashSet<Expr> postSet = new HashSet<Expr>();
                foreach (VCExpr vcexpr in participatingPredicates)
                {
                    Expr e = VCExpr2Expr.VCExprToExpr(vcexpr, bounds);

                    if (!isPost(e))
                    {
                        preSet.Add(e);
                    }
                    else
                    {
                        if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadFreeTail)
                        {
                            if (c.neg.Contains(vcexpr))
                                postSet.Add(Expr.Not(e));
                            else
                                postSet.Add(e);
                        }
                        else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadBoundedTail)
                        {
                            if (c.neg.Contains(vcexpr))
                                postSet.Add(Expr.Not(e));
                            else
                                postSet.Add(e);
                        }
                        else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.ClausePredicates)
                            postSet.Add(e);
                        else
                            Contract.Assert(false);
                    }
                }

                RuleTemplate template = new RuleTemplate(preSet, postSet);
                RuleTemplateDB.record(template);
            }
        }
    }

    public class OldExprBindings
    {
        // create the RenamedVars->OldExpr map
        private Dictionary<string, Dictionary<VCExpr, Expr>> boundsDict = new Dictionary<string, Dictionary<VCExpr, Expr>>();

        public void RecordOldExprBinding(string procname, Variable var_pre, Variable var_post, Program program, ProverInterface prover)
        {
            //foreach (GlobalVariable g in program.GlobalVariables())
            {
                if (var_post.Name.StartsWith(procname + "_"))
                {
                    Dictionary<VCExpr, Expr> bounds = null;
                    bool found = boundsDict.TryGetValue(procname, out bounds);

                    if (!found)
                    {
                        bounds = new Dictionary<VCExpr, Expr>();
                        boundsDict[procname] = bounds;
                    }

                    VCExpr vcexpr_pre = prover.Context.BoogieExprTranslator.Translate(Expr.Ident(var_pre));
                    VCExpr vcexpr_post = prover.Context.BoogieExprTranslator.Translate(Expr.Ident(var_post));

                    bounds.Add(vcexpr_pre, new OldExpr(Token.NoToken, Expr.Ident(var_pre))); // pre: var -> old(var)
                    bounds.Add(vcexpr_post, Expr.Ident(var_pre)); // post: proc_var -> var
                }
                else
                    Contract.Assert(false);
            }
        }

        public Dictionary<VCExpr, Expr> GetDict(string procname)
        {
            return boundsDict[procname];
        }
    }

    public class EnvironmentalSummaries
    {
        HashSet<string> environmentVariables;
        Dictionary<string, VCExpr> proc2Summary = new Dictionary<string, VCExpr>();
        Dictionary<string, List<Expr>> proc2Ensures = new Dictionary<string, List<Expr>>();

        ProverInterface prover;

        Program freshProgram;

        OldExprBindings oldExprBindings; // there are no equivalents of old(var) in VCExpr; so we need to create new variables to rename OldExpr to VCExprVar/ExprIdentifier

        public enum InsertedSummaryType { EnvVarsPredAbs, AllSummaries, EnvVarsInductiveSummaryPredicatesPerFunction, EnvVarsInductiveSummaryGlobalPredicates, LearntTemplates };

        public EnvironmentalSummaries(List<string> inputFiles, string dualityFixPointFile, bool addCorralOut)
        {
            string renamedFile = RenameProcedures(dualityFixPointFile);

            List<string> fileList = new List<string>(inputFiles);

            if (addCorralOut)
                fileList.Add("f.bpl"); // TODO: CHECK LATER

            if (renamedFile != null)
                fileList.Add(renamedFile);

            fileList.Iter<string>(n => Console.WriteLine(n));

            freshProgram = ExecutionEngine.ParseBoogieProgram(fileList, false);
            int errCount1 = freshProgram.Resolve();
            int errCount2 = freshProgram.Typecheck();

            Contract.Assert(errCount1 == 0 && errCount2 == 0);

            freshProgram.Emit(new TokenTextWriter("CombinedBPL.bpl"));

            prover = ProverInterface.CreateProver(freshProgram, "log2.txt", true, CommandLineOptions.Clo.ProverKillTime);

            prover.AssertAxioms();

            environmentVariables = CollectEnvironmentVariables();

            oldExprBindings = new OldExprBindings();

            GetDualitySummaries(dualityFixPointFile);
        }


        // renames all procedures by appending "_summary" to the procedure names
        public string RenameProcedures(string dualityFixPointFile)
        {
            if (dualityFixPointFile == null)
                return null;

            List<string> fileList = new List<string>();
            fileList.Add(dualityFixPointFile);
            Program summaryProgram = ExecutionEngine.ParseBoogieProgram(fileList, false);
            //int errCount1 = summaryProgram.Resolve();
            //int errCount2 = summaryProgram.Typecheck();

            //Contract.Assert(errCount1 == 0 && errCount2 == 0);

            Program newProg = new Program();

            foreach (Declaration t in summaryProgram.TopLevelDeclarations)
            {
                if (t is Procedure)
                {
                    Procedure proc = t as Procedure;

                    if (proc.Ensures.Count == 0)
                        continue;

                    Procedure newProc = new Procedure(Token.NoToken, proc.Name + "_summary", proc.TypeParameters, proc.InParams, proc.OutParams, proc.Requires, proc.Modifies, proc.Ensures);

                    newProg.TopLevelDeclarations.Add(newProc);
                }
            }

            string fname = "DualitySummariesRenamed2.bpl";

            TokenTextWriter tw = new TokenTextWriter(fname);
            newProg.Emit(tw);
            tw.Close();

            return fname;
        }

        private HashSet<string> CollectEnvironmentVariables()
        {
            HashSet<string> envVars = new HashSet<string>();

            foreach (Declaration t in freshProgram.TopLevelDeclarations)
            {
                QKeyValue attr;
                string name;

                if (t is GlobalVariable)
                {
                    GlobalVariable gvar = t as GlobalVariable;

                    attr = gvar.Attributes;
                    name = gvar.Name;
                }
                else if (t is Constant)
                {
                    Constant c = t as Constant;

                    attr = c.Attributes;
                    name = c.Name;
                }
                else
                    continue;

                bool isEnvironVar = QKeyValue.FindBoolAttribute(attr, "environment");

                if (isEnvironVar)
                {
                    envVars.Add(name);
                }
            }

            return envVars;
        }

        public void Initialize(Procedure proc)
        {
            List<Variable> functionInterfaceVars = new List<Variable>();
            foreach (Variable v in freshProgram.GlobalVariables())
            {
                functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
            }
            foreach (Variable v in proc.InParams)
            {
                functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
            }
            foreach (Variable v in proc.OutParams)
            {
                functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
            }
            foreach (IdentifierExpr e in proc.Modifies)
            {
                if (e.Decl == null) continue;
                functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", e.Decl.TypedIdent.Type), true));
            }

            /*
            Formal returnVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", Bpl.Type.Bool), false);

            function = new Function(Token.NoToken, proc.Name, functionInterfaceVars, returnVar);
            vcgen.prover.Context.DeclareFunction(function, "");
            */

            List<Expr> exprs = new List<Expr>();
            foreach (Variable v in freshProgram.GlobalVariables())
            {
                Contract.Assert(v != null);
                exprs.Add(new OldExpr(Token.NoToken, new IdentifierExpr(Token.NoToken, v)));
            }
            foreach (Variable v in proc.InParams)
            {
                Contract.Assert(v != null);
                exprs.Add(new IdentifierExpr(Token.NoToken, v));
            }
            foreach (Variable v in proc.OutParams)
            {
                Contract.Assert(v != null);
                exprs.Add(new IdentifierExpr(Token.NoToken, v));
            }
            foreach (IdentifierExpr ie in proc.Modifies)
            {
                Contract.Assert(ie != null);
                if (ie.Decl == null)
                    continue;
                exprs.Add(ie);
            }

            /*
            Expr freePostExpr = new NAryExpr(Token.NoToken, new FunctionCall(function), exprs);
            proc.Ensures.Add(new Ensures(Token.NoToken, true, freePostExpr, "", new QKeyValue(Token.NoToken, "si_fcall", new List<object>(), null)));
            */
        }

#if false
        private Program CreateSummariesProgram(string dualityFPFile)
        {
            List<string> fileList = new List<string>();
            fileList.Add(dualityFPFile);

            Program summariesProgram = ExecutionEngine.ParseBoogieProgram(fileList, false);

            // The program does not have any of the global variable declarations; they need to be added

            foreach (GlobalVariable gv in freshProgram.GlobalVariables())
            {
                //testc = new TypedIdent(Token.NoToken, gv.Name, );
                summariesProgram.TopLevelDeclarations.Add(new GlobalVariable(Token.NoToken, gv.TypedIdent));
                //summariesProgram.TopLevelDeclarations.Add(gv);
            }

            //summariesProgram.Typecheck();
            int errCount1 = summariesProgram.Resolve();
            //int errCount2 = summariesProgram.Typecheck();

            summariesProgram.Emit(new TokenTextWriter("final.bpl"));

            return summariesProgram;
        }
#endif

        private void GetDualitySummaries(string dualityFPFile)
        {
            if (dualityFPFile == null)
                return;

            //Program summariesProgram = CreateSummariesProgram(dualityFPFile);

            /*
            List<string> fileList = new List<string>();
            fileList.Add(dualityFPFile);

            Program summariesProgram = ExecutionEngine.ParseBoogieProgram(fileList, false);
            summariesProgram.Typecheck();
            summariesProgram.Resolve();
            */
            //prover = ProverInterface.CreateProver(summariesProgram, "log.txt", true, CommandLineOptions.Clo.ProverKillTime);

            List<Procedure> procList = new List<Procedure>();
            freshProgram.TopLevelDeclarations.Iter<Declaration>(n => { if (n is Procedure) procList.Add(n as Procedure); });

            Dictionary<string, Expr> recExprDict = new Dictionary<string, Expr>();

            foreach (Declaration decl in procList)
            {
                if (decl is Procedure)
                {
                    //Initialize(decl as Procedure);

                    Procedure proc = decl as Procedure;

                    string procname = proc.Name;

                    if (!procname.EndsWith("_summary"))
                    {
                        continue;
                    }

                    procname = procname.Remove(procname.Count() - "_summary".Count());
                    //procname = procname.Except("_summary");

                    Dictionary<Variable, Expr> substalwaysMap = new Dictionary<Variable, Expr>();

                    if (proc.Ensures.Count == 0)
                        continue;

                    // create new global variables to rename the OldExpr in the summaries
                    foreach (Variable v in freshProgram.GlobalVariables())
                    {
                        GlobalVariable newvar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, procname + "_" + v.Name, v.TypedIdent.Type));
                        substalwaysMap[v] = new IdentifierExpr(Token.NoToken, newvar);
                        freshProgram.TopLevelDeclarations.Add(newvar);
                        oldExprBindings.RecordOldExprBinding(procname, v, newvar, freshProgram, prover);
                    }

                    recExprDict[procname] = Expr.True;

                    proc2Ensures[procname] = new List<Expr>();
                    foreach (Ensures ensure in proc.Ensures)
                    {
                        proc2Ensures[procname].Add(ensure.Condition);

                        /*
                        Formal g = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "actual_ReturnBufferExpectedSize", Type.Int), true);

                         * */

                        Substitution substalways = Substituter.SubstitutionFromHashtable(substalwaysMap);
                        //Dictionary<Variable, Expr> oldFrameSubstMap = new Dictionary<Variable, Expr>();
                        //Substitution oldFrameSubst = Substituter.SubstitutionFromHashtable(oldFrameSubstMap);
                        //var substalways = new Substitution(v1 => (!freshProgram.GlobalVariables().Contains(v1)) ? Expr.Ident(v1) : new IdentifierExpr(Token.NoToken, procname + " _" + v1.Name, Expr.Ident(v1).Type));
                        var substold = new Substitution(v1 => Expr.Ident(v1));
                        Expr recExpr = Substituter.ApplyReplacingOldExprs(substalways, substold, ensure.Condition);

                        recExprDict[procname] = Expr.And(recExpr, recExprDict[procname]);
                    }
                    /*
                    prover.Context.BoogieExprTranslator.BindVariable(g);

                     */

                }
            }

            int errCount = freshProgram.Resolve();

            Contract.Assert(errCount == 0);

            foreach (string procname in recExprDict.Keys)
            {
                //VCExpr vcexpr = VCExpressionGenerator.True;

                Expr recExpr = recExprDict[procname];
                VCExpr vcexpr = prover.Context.BoogieExprTranslator.Translate(recExpr);
                //vcexpr = prover.VCExprGen.And(vcexpr, v);

                proc2Summary[procname] = vcexpr;
            }
        }

        public void EmitBplWithSummaries(InsertedSummaryType insertedSummaryType, string outFileName)
        {
            Program newfreshProgram = ExecutionEngine.ParseBoogieProgram(CommandLineOptions.Clo.Files, false); // we will change this program, so read a fresh one from disk

            if (insertedSummaryType == InsertedSummaryType.AllSummaries)
            {
                foreach (Declaration decl in newfreshProgram.TopLevelDeclarations)
                {
                    if (decl is Procedure)
                    {
                        string name = (decl as Procedure).Name;
                        if (proc2Ensures.ContainsKey(name))
                        {
                            Procedure proc = decl as Procedure;

                            foreach (Expr exp in proc2Ensures[name])
                            {
                                proc.Ensures.Add(new Ensures(true, exp));
                            }
                        }
                    }
                    //program.TopLevelDeclarations[proc];
                }
            }
            else if (insertedSummaryType == InsertedSummaryType.EnvVarsPredAbs)
            {
                //Contract.Assert(false);

                Dictionary<string, HashSet<Clause>> abstractSummaryDictClauseSet;
                Dictionary<string, VCExpr> proc2abs = DoPredAbsUsingEnv(prover, environmentVariables, out abstractSummaryDictClauseSet);

                foreach (Declaration decl in newfreshProgram.TopLevelDeclarations)
                {
                    if (decl is Procedure)
                    {
                        Procedure proc = (decl as Procedure);
                        string procname = proc.Name;
                        if (proc2abs.ContainsKey(procname))
                        {
                            Dictionary<VCExpr, Expr> bounds = oldExprBindings.GetDict(procname);

                            VCExpr vcexp = proc2abs[procname];
                            Expr exp = VCExpr2Expr.VCExprToExpr(vcexp, bounds);

                            proc.Ensures.Add(new Ensures(Token.NoToken, true, exp, "from_proof", new QKeyValue(Token.NoToken, "from_proof", new List<object>(), null)));
                        }
                    }
                }
                /*
                VCExpr summary = abstractSummaries[name];
                Expr exp = Common.VCExpr2Expr.VCExprToExpr(summary, interfaceMaps.getInterfacMap(name));
                (decl as Procedure).Ensures.Add(new Ensures(true, exp));
                 * */
            }
            else if (insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryPredicatesPerFunction || insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryGlobalPredicates)
            {
                //Contract.Assert(false);

                newfreshProgram.Resolve();
                newfreshProgram.Typecheck();

                Dictionary<string, List<Expr>> houdiniOutSummaries = DoPredAbsInductiveSummaries(freshProgram, prover, environmentVariables, insertedSummaryType);
#if true

                foreach (Declaration decl in newfreshProgram.TopLevelDeclarations)
                {
                    if (decl is Procedure)
                    {
                        Procedure proc = (decl as Procedure);
                        string procname = proc.Name;
                        if (houdiniOutSummaries.ContainsKey(procname))
                        {
                            List<Expr> exps = houdiniOutSummaries[procname];

                            exps.Iter<Expr>(n => proc.Ensures.Add(new Ensures(Token.NoToken, true, n, "from_proof", new QKeyValue(Token.NoToken, "from_proof", new List<object>(), null))));
                        }
                    }
                }
#endif
                /*
                VCExpr summary = abstractSummaries[name];
                Expr exp = Common.VCExpr2Expr.VCExprToExpr(summary, interfaceMaps.getInterfacMap(name));
                (decl as Procedure).Ensures.Add(new Ensures(true, exp));
                 * */
            }
            else if (insertedSummaryType == InsertedSummaryType.LearntTemplates)
            {
                Dictionary<string, HashSet<Clause>> abstractSummaryDictClauseSet;
                Dictionary<string, VCExpr> proc2abs = DoPredAbsUsingEnv(prover, environmentVariables, out abstractSummaryDictClauseSet);
                abstractSummaryDictClauseSet.Keys.Iter<string>(n => RuleTemplateDB.RecordTemplates(n, abstractSummaryDictClauseSet[n], oldExprBindings));
                RuleTemplateDB.dump();

                newfreshProgram.Resolve();
                newfreshProgram.Typecheck();

                HashSet<string> summaries;
                Dictionary<string, List<Expr>> houdiniOutSummaries = DoPredAbsInductiveSummariesLearntTemplates(freshProgram, prover, environmentVariables, insertedSummaryType, out summaries);

#if true
                foreach (Declaration decl in newfreshProgram.TopLevelDeclarations)
                {
                    if (decl is Procedure)
                    {
                        Procedure proc = (decl as Procedure);
                        string procname = proc.Name;
                        if (houdiniOutSummaries.ContainsKey(procname))
                        {
                            List<Expr> exps = houdiniOutSummaries[procname];

                            exps.Iter<Expr>(n => proc.Ensures.Add(new Ensures(Token.NoToken, true, n, "from_proof", new QKeyValue(Token.NoToken, "from_proof", new List<object>(), null))));
                        }
                    }
                }
#endif
            }
            else
                Contract.Assert(false);


            TokenTextWriter f = new TokenTextWriter(outFileName);
            newfreshProgram.Emit(f);
            f.Close();
        }

        // Interface for TrainerTemplates
        public void CreateRuleTemplateDB(InsertedSummaryType insertedSummaryType)
        {
            if (insertedSummaryType == InsertedSummaryType.LearntTemplates)
            {
                Dictionary<string, HashSet<Clause>> abstractSummaryDictClauseSet;
                Dictionary<string, VCExpr> proc2abs = DoPredAbsUsingEnv(prover, environmentVariables, out abstractSummaryDictClauseSet);
                abstractSummaryDictClauseSet.Keys.Iter<string>(n => RuleTemplateDB.RecordTemplates(n, abstractSummaryDictClauseSet[n], oldExprBindings));
                //RuleTemplateDB.dump();
            }
        }

        // Interface for TrainerTemplates
        public HashSet<string> RunAbstractHoudini()
        {
            HashSet<string> summaries;
            Dictionary<string, List<Expr>> houdiniOutSummaries = DoPredAbsInductiveSummariesLearntTemplates(freshProgram, prover, environmentVariables, InsertedSummaryType.LearntTemplates, out summaries);

            return summaries;

        }

        //private Dictionary<string, Expr> DoPredAbsInductiveSummaries(ProverInterface prover, HashSet<string> envVars)
        private Dictionary<string, List<Expr>> DoPredAbsInductiveSummariesLearntTemplates(Program program, ProverInterface prover, HashSet<string> envVars, InsertedSummaryType insertedSummaryType, out HashSet<string> summaries)
        {
            InductiveSummaries inductiveSummaries = new InductiveSummaries();
            return inductiveSummaries.trainSummaries(program, RuleTemplateDB.RuleTemplateSet.Keys, out summaries);
        }

        //private Dictionary<string, Expr> DoPredAbsInductiveSummaries(ProverInterface prover, HashSet<string> envVars)
        private Dictionary<string, List<Expr>> DoPredAbsInductiveSummaries(Program program, ProverInterface prover, HashSet<string> envVars, InsertedSummaryType insertedSummaryType)
        {
            Dictionary<string, HashSet<Expr>> predicateDict = null;
            HashSet<Expr> predicateSet = null;
            HashSet<string> predicateSetStr = null;

            if (insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryPredicatesPerFunction)
                predicateDict = new Dictionary<string, HashSet<Expr>>();
            else if (insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryGlobalPredicates)
            {
                predicateSet = new HashSet<Expr>();
                predicateSetStr = new HashSet<string>();
            }
            else
                Contract.Assert(false);

            foreach (string f in proc2Summary.Keys)
            {
                Console.Out.WriteLine("Procedure: " + f);
                Dictionary<VCExpr, Expr> bound = oldExprBindings.GetDict(f);

                VCExpr e = proc2Summary[f];

                // select all predicates with only env vars
                VCExprEnvSelector sel = new VCExprEnvSelector(prover, envVars);
                HashSet<VCExpr> selectedPredicates = sel.Select(e, f);
                HashSet<Expr> selectedPredicatesExpr = new HashSet<Expr>();
                selectedPredicates.Iter<VCExpr>(n => selectedPredicatesExpr.Add(VCExpr2Expr.VCExprToExpr(n, bound)));

                if (selectedPredicatesExpr.Count > 0)
                {
                    if (insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryPredicatesPerFunction)
                        predicateDict[f] = selectedPredicatesExpr;
                    else if (insertedSummaryType == InsertedSummaryType.EnvVarsInductiveSummaryGlobalPredicates)
                    {
                        //predicateSet.UnionWith(selectedPredicatesExpr);
                        selectedPredicatesExpr.Iter<Expr>(n => { if (!predicateSetStr.Contains(n.ToString())) { predicateSetStr.Add(n.ToString()); predicateSet.Add(n); } });
                    }
                    else
                        Contract.Assert(false);
                }
            }

            InductiveSummaries inductiveSummaries = new InductiveSummaries();
            return inductiveSummaries.trainSummaries(program, predicateDict, predicateSet);
        }

        public class EmptyErrorHandler : ProverInterface.ErrorHandler
        {
            public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome)
            { }
        }

        private Dictionary<string, VCExpr> DoPredAbsUsingEnv(ProverInterface prover, HashSet<string> envVars, out Dictionary<string, HashSet<Clause>> abstractSummaryDictClauseSet)
        {
            Dictionary<string, VCExpr> abstractSummaryDict = new Dictionary<string, VCExpr>();
            abstractSummaryDictClauseSet = new Dictionary<string, HashSet<Clause>>();

            foreach (string f in proc2Summary.Keys)
            {
                Console.Out.WriteLine("Procedure: " + f);

                VCExpr e = proc2Summary[f];

                // select all predicates with only env vars
                VCExprEnvSelector sel = new VCExprEnvSelector(prover, envVars);
                HashSet<VCExpr> selectedPredicates = sel.Select(e, f);

                // do predicate abstraction
                HashSet<Clause> abstractionClauseSet = new HashSet<Clause>();
                HashSet<VCExpr> abstractionClauseSetVCExpr = new HashSet<VCExpr>();

                HashSet<Clause> currentFrontier = new HashSet<Clause>();
                HashSet<Clause> nextFrontier = new HashSet<Clause>();
                int count = selectedPredicates.Count;

                selectedPredicates.Iter<VCExpr>(n => currentFrontier.Add(new Clause(null, n, null)));
                selectedPredicates.Iter<VCExpr>(n => currentFrontier.Add(new Clause(null, null, n)));

                do
                {
                    // use next-frontier to create the current frontier
                    foreach (Clause cl in nextFrontier)
                    {
                        foreach (VCExpr exp in selectedPredicates)
                        {
                            if (cl.pos.Contains(exp) || cl.neg.Contains(exp))
                            {
                                continue;
                            }
                            else
                            {
                                Clause c_pos = new Clause(cl, exp, null); // extend by disjunction with 'exp'
                                Clause c_neg = new Clause(cl, null, exp); // extend by disjunction with '!exp'

                                if (!c_pos.isCoveredBy(abstractionClauseSet))
                                    currentFrontier.Add(c_pos);

                                if (!c_neg.isCoveredBy(abstractionClauseSet))
                                    currentFrontier.Add(c_neg);
                            }
                        }
                    }

                    nextFrontier.Clear();

                    List<Clause> worklist = currentFrontier.ToList();
                    while (worklist.Count > 0)
                    {
                        Clause cl = worklist[0];
                        worklist.RemoveAt(0);

                        VCExpr v = cl.getVCExpr(prover.VCExprGen);

                        // check if the expression implies it
                        //List<int> unsatCore = new List<int>();
                        //List<VCExpr> assumptions = new List<VCExpr>();
                        //assumptions.Add(v);

                        VCExpr testExpr = prover.VCExprGen.Implies(e, v);
                        testExpr = prover.VCExprGen.Not(testExpr);

#if false
                        prover.Push();
                        //ProverInterface.Outcome outcome = bk.getMainProver().CheckAssumptions(assumptions, out unsatCore, new ProverInterface.ErrorHandler());
                        prover.Assert(testExpr, true);
                        prover.Check();
                        ProverInterface.Outcome outcome = prover.GetProverSingleResponse();
                        prover.Pop();
#endif

                        prover.Push();
                        prover.Assert(prover.VCExprGen.LabelPos("dummy", testExpr), true);  // add a dummy label else it cries
                        prover.Check();
                        ProverInterface.Outcome outcome = prover.CheckOutcomeCore(new EmptyErrorHandler());
                        prover.Pop();

                        if (outcome == ProverInterface.Outcome.Valid)
                        {
                            abstractionClauseSetVCExpr.Add(v);
                            abstractionClauseSet.Add(cl);

                            // no need to add it to the nextFrontier as this is the strongest abstraction
                            // and any weaker clause is surely in this abstraction
                        }
                        else
                        {
                            // adding this clause to nextFrontier as it is still not weak enough
                            nextFrontier.Add(cl);
                        }
                    }

                    currentFrontier.Clear();
                }
                while (nextFrontier.Count > 0);

                VCExpr z = VCExpressionGenerator.True;
                foreach (VCExpr x in abstractionClauseSetVCExpr)
                {
                    z = prover.VCExprGen.AndSimp(z, x);
                }

                if (!z.Equals(VCExpressionGenerator.True))
                {
                    abstractSummaryDict[f] = z;
                    abstractSummaryDictClauseSet[f] = abstractionClauseSet;
                }
            }

            return abstractSummaryDict;
        }
    }

    public class Clause
    {
        public HashSet<VCExpr> pos = new HashSet<VCExpr>();
        public HashSet<VCExpr> neg = new HashSet<VCExpr>();

        public Clause(Clause c, VCExpr pos_exp, VCExpr neg_exp)
        {
            if (c != null)
            {
                this.pos.UnionWith(c.pos);
                this.neg.UnionWith(c.neg);
            }

            if (pos_exp != null)
                this.pos.Add(pos_exp);

            if (neg_exp != null)
                this.neg.Add(neg_exp);
        }

        public override int GetHashCode()
        {
            return pos.Count * neg.Count;
        }

        public override bool Equals(object that)
        {
            if (this.pos.SetEquals((that as Clause).pos) && this.neg.SetEquals((that as Clause).neg))
            {
                return true;
            }
            else
                return false;
        }

        public VCExpr getVCExpr(VCExpressionGenerator gen)
        {
            VCExpr v = VCExpressionGenerator.False;
            pos.Iter<VCExpr>(n => v = gen.OrSimp(v, n));
            neg.Iter<VCExpr>(n => v = gen.OrSimp(v, gen.Not(n)));

            return v;
        }

        public bool isCoveredBy(Clause that)
        {
            if (that.pos.IsProperSupersetOf(this.pos) && that.neg.IsProperSupersetOf(this.neg))
                return true;
            else
                return false;
        }

        public bool isCoveredBy(HashSet<Clause> thatSet)
        {
            foreach (Clause that in thatSet)
            {
                if (that.pos.IsSubsetOf(this.pos) || that.neg.IsSubsetOf(this.neg)) // note it's a disjunction, so smaller is stronger than the larger
                    return true;
            }

            return false;
        }
    }

    public class VCExprEnvSelector : IVCExprVisitor<VCExpr, string>
    {
        ProverInterface prover;
        HashSet<string> envVars;
        HashSet<VCExpr> selectedSet = new HashSet<VCExpr>();

        public VCExprEnvSelector(ProverInterface prover, HashSet<string> envVars)
        {
            this.prover = prover;
            this.envVars = envVars;
        }

        public VCExpr Visit(VCExprVar vc, string varName)
        {
            return vc;
        }

        public VCExpr Visit(VCExprLet vc, string p)
        {
            Select(vc.Body, p);
            return null;
        }

        public VCExpr Visit(VCExprQuantifier vc, string p)
        {
            Select(vc.Body, p);
            return vc;
        }

        public VCExpr Visit(VCExprLiteral vc, string p)
        {
            return vc;
        }

#if true
        private bool isEnvVar(VCExprVar var, HashSet<string> environmentVariables, string procname)
        {
            string varname = "";

            if (var.Name.StartsWith(procname + "_"))
            {
                varname = var.Name.Remove(0, (procname + "_").Count());
            }
            else
            {
                varname = var.Name;
            }

            if (environmentVariables.Contains(varname))
                return true;

#if false
            //Dictionary<VCExpr, Expr> name_map = interfaceMaps.getInterfacMap(procname);

            if (!name_map.ContainsKey(var))
                return false;

            Expr exp_var = name_map[var];
            string var_name = null;

            if (exp_var is IdentifierExpr)
            {
                var_name = (exp_var as IdentifierExpr).Name;
            }
            else if (exp_var is OldExpr)
            {
                var_name = ((exp_var as OldExpr).Expr as IdentifierExpr).Name;
            }
            else
                return false;

            if (environmentVariables.Contains(var_name))
                return true;

            /*
            foreach (string x in environmentVariables)
            {
                if (name.EndsWith("_" + x) || name.StartsWith(x + "@"))
                    return true;
            }
            */
#endif

            return false;
        }
#endif

        public VCExpr Visit(VCExprNAry vc, string p)
        {
            if (vc.Arity == 2 &&
                (vc.Op == VCExpressionGenerator.EqOp ||
                vc.Op == VCExpressionGenerator.NeqOp ||
                vc.Op == VCExpressionGenerator.LeOp ||
                vc.Op == VCExpressionGenerator.LtOp ||
                vc.Op == VCExpressionGenerator.GeOp ||
                vc.Op == VCExpressionGenerator.GtOp))
            {
                VCExpr v1 = (vc as VCExprNAry).ElementAt(0);
                VCExpr v2 = (vc as VCExprNAry).ElementAt(1);

                if (((v1 is VCExprVar) || (v1 is VCExprLiteral)) && ((v2 is VCExprVar) || (v2 is VCExprLiteral)))
                {
                    if (v1 is VCExprVar && !isEnvVar((v1 as VCExprVar), envVars, p))
                        return vc;
                    else if (v2 is VCExprVar && !isEnvVar((v2 as VCExprVar), envVars, p))
                        return vc;

                    selectedSet.Add(vc);

                    return vc;
                }
            }

            foreach (VCExpr v in vc.UniformArguments)
                Select(v, p);

            return vc;
        }

        public HashSet<VCExpr> Select(VCExpr vc, string procName)
        {
            vc.Accept<VCExpr, string>(this, procName);

            return selectedSet;
        }
    }

    public class InductiveSummaries
    {

        public class EExpr
        {
            public Expr expr;
            public int typ;
            public HashSet<string> mustMod;
            public HashSet<string> mustNotMod;
            public QKeyValue annotations;

            public static HashSet<string> procsThatFail = null;

            public bool IsFree
            {
                get
                {
                    return (typ == 0 || typ == 2);
                }
            }

            public bool IsRequires
            {
                get
                {
                    return (typ == 2 || typ == 3);
                }
            }

            public bool IsEnsures
            {
                get
                {
                    return (typ == 0 || typ == 1);
                }
            }

            private EExpr()
            {
                this.expr = null;
                typ = 0;
                mustMod = new HashSet<string>();
                mustNotMod = new HashSet<string>();
            }

            public EExpr(Expr expr, bool isEnsures)
                : this()
            {
                this.expr = expr;
                typ = isEnsures ? 1 : 3;
            }

            public EExpr(Ensures ens)
                : this()
            {
                this.expr = ens.Condition;
                if (ens.Free) typ = 0;
                else typ = 1;
                processAnnotations(ens.Attributes);
            }

            public EExpr(Requires req)
                : this()
            {
                this.expr = req.Condition;
                if (req.Free) typ = 2;
                else typ = 3;
                processAnnotations(req.Attributes);
            }

            private void processAnnotations(QKeyValue attr)
            {
                annotations = attr;

                for (; attr != null; attr = attr.Next)
                {
                    if (attr.Params.Count != 1)
                        continue;
                    if (!(attr.Params[0] is string))
                        continue;

                    var v = (string)attr.Params[0];

                    switch (attr.Key)
                    {
                        case "mustmod": mustMod.Add(v);
                            break;
                        case "mustnotmod": mustNotMod.Add(v);
                            break;
                    }

                }
            }

            public bool Match(Procedure proc)
            {
                var mods = new HashSet<string>();
                proc.Modifies.OfType<IdentifierExpr>()
                    .Iter(ie => mods.Add(ie.Name));

                if (!mustMod.IsSubsetOf(mods)) return false;
                if (mustNotMod.Intersection(mods).Any()) return false;

                if (QKeyValue.FindBoolAttribute(annotations, "mustfail"))
                {
                    Debug.Assert(procsThatFail != null);
                    return procsThatFail.Contains(proc.Name);
                }

                return true;
            }

            public Ensures getEnsures()
            {
                Debug.Assert(IsEnsures);
                return new Ensures(IsFree, expr);
            }

            public Requires getRequires()
            {
                Debug.Assert(IsRequires);
                return new Requires(IsFree, expr);
            }
        }

        public static bool doCartesianAbstraction = true;

        public enum TemplateType { ClausePredicates, OnlyHeadFreeTail, OnlyHeadBoundedTail };
        public static TemplateType useDirectedRules = TemplateType.OnlyHeadFreeTail;

        public static int HoudiniTimeout = -1;
        public static bool disableStaticAnalysis = false;
        public static bool inferPreconditions = false;
        public static bool checkAsserts = false;
        public static string runAbsHoudiniConfig = null;
        public static bool fastRequiresInference = false;
        public static bool runAbsHoudini
        {
            get
            {
                return (runAbsHoudiniConfig != null);
            }
        }

        // extract loops?
        public bool ExtractLoops;

        // Template
        public HashSet<Variable> templateVars;
        public List<EExpr> templates;
        public int InlineDepth;
        private HashSet<string> templateVarNames;
        //protected ExtractLoopsPass elPass;
        public static bool runHoudini = true;
        public string printHoudiniQuery = null;

        bool FPA = true; // Full Predicate Abstraction
        private bool doLearntTemplates = true;

        class ExprSet
        {
            public HashSet<Expr> exprSet = new HashSet<Expr>();
            public HashSet<string> exprSetStr = new HashSet<string>();

            public void Add(Expr e)
            {
                if (!exprSetStr.Contains(e.ToString()))
                {
                    exprSet.Add(e);
                    exprSetStr.Add(e.ToString());
                }
            }

            public void AddModuloNegation(Expr e)
            {
                if (!exprSetStr.Contains(e.ToString()) && !exprSetStr.Contains(Expr.Not(e).ToString()))
                {
                    exprSet.Add(e);
                    exprSetStr.Add(e.ToString());
                }
            }
        }

        public Dictionary<string, List<Expr>> trainSummaries(Program program, IEnumerable<RuleTemplate> templateDict, out HashSet<string> predicateSet)
        {
            var newFns = new List<Declaration>();
            var proc2Exprs = new Dictionary<string, List<Expr>>();

            List<RuleTemplate> templates = null;

            if (templateDict != null)
            {
                templates = templateDict.ToList();
            }
            else
                Contract.Assert(false);

            if (templates.Count == 0)
                Contract.Assert(false);

            Dictionary<string, Expr> func2post = null;
            ExprSet prePredicates = new ExprSet();

            if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadFreeTail)
            {
                func2post = new Dictionary<string, Expr>();
                templateDict.Iter<RuleTemplate>(n => n.preSet.Iter<Expr>(k => prePredicates.AddModuloNegation(k)));
            }
            else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadBoundedTail)
            {
                func2post = new Dictionary<string, Expr>();
            }
            else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.ClausePredicates)
            {
                func2post = null;
            }
            else
                Contract.Assert(false);

            // for each procedure, select only the templates which are either empty post or the post has at least one modified predicate
            foreach (var p in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = p.Proc;

                if (proc.Name.Equals("I8042MouseIsrDpc"))
                    Console.Write("");

                HashSet<RuleTemplate> selectedTemplates = new HashSet<RuleTemplate>();

                HashSet<string> modifies = new HashSet<string>();
                proc.Modifies.Iter<IdentifierExpr>(n => modifies.Add(n.ToString()));

                foreach (RuleTemplate t in templates)
                {
                    if (t.postSet.Count == 0)
                    {
                        // enable if need to allow templates with only OldExpr
#if false
                        selectedTemplates.Add(t);
#endif
                        continue;
                    }

                    // Only have head where all predicates involves are in the modifies set
                    if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadFreeTail ||
                        InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadBoundedTail ||
                        InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.ClausePredicates)
                    {
                        HashSet<string> varsInFuncModifies = new HashSet<string>();
                        proc.Modifies.Iter<IdentifierExpr>(n => varsInFuncModifies.Add(n.Name));

                        HashSet<string> varsInPostPredicates = new HashSet<string>();

                        foreach (Expr predicate in t.postSet)
                        {
                            Expr posPred = predicate;

                            if ((predicate as NAryExpr).Fun is UnaryOperator)
                            {
                                Contract.Assert(((predicate as NAryExpr).Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not);

                                posPred = (predicate as NAryExpr).Args[0];
                            }

                            Contract.Assert((posPred as NAryExpr).Args.Count == 2);
                            var v1 = getVarInPredicate(posPred, 0);
                            var v2 = getVarInPredicate(posPred, 1);

                            if (v1.Item1 != null && !v1.Item2)
                                varsInPostPredicates.Add(v1.Item1.Name);

                            if (v2.Item1 != null && !v2.Item2)
                                varsInPostPredicates.Add(v2.Item1.Name);
                        }

                        if (!varsInPostPredicates.IsSubsetOf(varsInFuncModifies))
                            continue;
                        else
                            selectedTemplates.Add(t);
                    }
                    else
                    {
                        foreach (Expr predicate in t.postSet)
                        {
                            Expr posPred = predicate;

                            if ((predicate as NAryExpr).Fun is UnaryOperator)
                            {
                                Contract.Assert(((predicate as NAryExpr).Fun as UnaryOperator).Op == UnaryOperator.Opcode.Not);

                                posPred = (predicate as NAryExpr).Args[0];
                            }

                            Contract.Assert((posPred as NAryExpr).Args.Count == 2);

                            bool isInModifies = false;

                            // check if predicate is relevant w.r.t modifies set

                            var v1 = getVarInPredicate(posPred, 0);
                            var v2 = getVarInPredicate(posPred, 1);

                            if (v1.Item1 != null && modifies.Contains(v1.Item1.Name))
                                isInModifies = true;

                            if (v2.Item1 != null && modifies.Contains(v2.Item1.Name))
                                isInModifies = true;

                            if (isInModifies)
                            {
                                selectedTemplates.Add(t);
                                break;
                            }
                        }
                    }
                }

                int id = 0;
                HashSet<string> addedHeads = new HashSet<string>();
                foreach (RuleTemplate t in selectedTemplates)
                {
                    if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadFreeTail)
                    {
                        HashSet<Expr> funcArgList = prePredicates.exprSet;

                        // create head of the rule as disjunction of predicates
                        Expr predicate = null;
                        t.postSet.Iter<Expr>(n => { predicate = (predicate == null) ? n : Expr.Or(predicate, n); });

                        if (predicate == null)  // no summary of just pre predicates
                            continue;

                        if (addedHeads.Contains(predicate.ToString()))
                            continue;
                        else
                            addedHeads.Add(predicate.ToString());

                        // add "dummy" existential function to drive predicate abstraction
                        var foo = CreateFunctionFPA(funcArgList.Count, "foo" + id + "_" + proc.Name);
                        foo.AddAttribute("absdomain", "PredicateAbs");
                        newFns.Add(foo);
                        id++;

                        //var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                        var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), funcArgList.ToList());
                        expr = Expr.Or(expr, predicate) as NAryExpr;
                        //expr = Expr.Imp(Expr.Not(expr), predicate); // (not pre) => post i.e. (pre \/ post); here pre are foo(); initially pre is false; will try to climb to true
                        proc.Ensures.Add(new Ensures(false, expr));

                        proc2Exprs.Add(foo.Name, funcArgList.ToList());
                        func2post.Add(foo.Name, predicate);
                    }
                    else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadBoundedTail)
                    {
                        HashSet<Expr> funcArgList = t.preSet;

                        // create head of the rule as disjunction of predicates
                        Expr predicate = null;
                        t.postSet.Iter<Expr>(n => { predicate = (predicate == null) ? n : Expr.Or(predicate, n); });

                        if (predicate == null)  // no summary of just pre predicates
                            continue;

                        // add "dummy" existential function to drive predicate abstraction
                        var foo = CreateFunctionFPA(funcArgList.Count, "foo" + id + "_" + proc.Name);
                        foo.AddAttribute("absdomain", "PredicateAbs");
                        newFns.Add(foo);
                        id++;

                        //var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                        var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), funcArgList.ToList());
                        expr = Expr.Or(expr, predicate) as NAryExpr;
                        //expr = Expr.Imp(Expr.Not(expr), predicate); // (not pre) => post i.e. (pre \/ post); here pre are foo(); initially pre is false; will try to climb to true
                        proc.Ensures.Add(new Ensures(false, expr));

                        proc2Exprs.Add(foo.Name, funcArgList.ToList());
                        func2post.Add(foo.Name, predicate);
                    }
                    else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.ClausePredicates)
                    {
                        HashSet<Expr> funcArgList = t.preSet.Union(t.postSet);

                        // add "dummy" existential function to drive predicate abstraction
                        var foo = CreateFunctionFPA(funcArgList.Count, "foo" + id + "_" + proc.Name);
                        foo.AddAttribute("absdomain", "PredicateAbs");
                        newFns.Add(foo);
                        id++;

                        //var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                        var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), funcArgList.ToList());
                        //expr = Expr.Or(expr, predicate) as NAryExpr;
                        //expr = Expr.Imp(Expr.Not(expr), predicate); // (not pre) => post i.e. (pre \/ post); here pre are foo(); initially pre is false; will try to climb to true
                        proc.Ensures.Add(new Ensures(false, expr));

                        proc2Exprs.Add(foo.Name, funcArgList.ToList());
                    }
                    else
                        Contract.Assert(false);
                }
            }

            program.TopLevelDeclarations.AddRange(newFns);


            // Massage program
            //(new RewriteCallDontCares()).VisitProgram(program);
            // get rid of assert in main
            //var mainImpl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "fakeMain");
            var mainImpl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "main");
            foreach (var blk in mainImpl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var acmd = blk.Cmds[i] as AssertCmd;
                    if (acmd == null) continue;
                    var le = acmd.Expr as LiteralExpr;
                    if (le != null && le.IsTrue) continue;
                    blk.Cmds[i] = new AssumeCmd(Token.NoToken, acmd.Expr);
                }
            }

            // Run Abs Houdini

            CommandLineOptions.Clo.InlineDepth = InlineDepth;
            var old = CommandLineOptions.Clo.ProcedureInlining;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Spec;
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            var cc = CommandLineOptions.Clo.ProverCCLimit;
            CommandLineOptions.Clo.ContractInfer = true;
            var oldTimeout = CommandLineOptions.Clo.ProverKillTime;

            CommandLineOptions.Clo.ProverKillTime = 20000; // AbsHoudini interprets this as milliseconds
            CommandLineOptions.Clo.ProverCCLimit = 1;
            CommandLineOptions.Clo.AbstractHoudini = runAbsHoudiniConfig;
            CommandLineOptions.Clo.PrintErrorModel = 1;     // this is required
            string oldmodelfile = CommandLineOptions.Clo.PrintErrorModelFile;
            CommandLineOptions.Clo.PrintErrorModelFile = "model2.txt"; // else it is printed on STDOUT
            AbstractHoudini.WitnessFile = null;

            Dictionary<string, List<Expr>> houdiniSummaryOut = new Dictionary<string, List<Expr>>();

            var time3 = DateTime.Now;

            //inline(program);
            BoogieUtil.TypecheckProgram(program, "error.bpl");

            if (printHoudiniQuery != null)
                BoogieUtil.PrintProgram(program, printHoudiniQuery);

            HashSet<string> predicates = new HashSet<string>();

            Program houdiniProgram;

            // dump and reload the fresh program to escape VCExprVar->ExprIdentifier->Variable mapping issues faced during translation
            if (true)
            {
                TokenTextWriter tt = new TokenTextWriter("AbsHoudIn.bpl");
                program.Emit(tt);
                tt.Close();

                houdiniProgram = ExecutionEngine.ParseBoogieProgram(new List<string> { "AbsHoudIn.bpl" }, false);
                int errCount1 = houdiniProgram.Resolve();
                int errCount2 = houdiniProgram.Typecheck();

                Contract.Assert(errCount1 == 0 && errCount2 == 0);
            }

            if (FPA)
            {
                AbstractDomainFactory.Initialize(houdiniProgram);
                var domain = AbstractDomainFactory.GetInstance("PredicateAbs");
                AbsHoudini abs = new AbsHoudini(houdiniProgram, domain);
                CommandLineOptions.Clo.PrintAssignment = true;
                var absout = abs.ComputeSummaries();

                var summaries = abs.GetAssignment();

                foreach (var foo in summaries)
                {
                    var body = foo.Body;
                    if (body is LiteralExpr && (body as LiteralExpr).IsTrue) // foo => cond,  if foo=false, then nothing useful is asserted; remember that (not foo)=> post is asserted
                        continue;

                    // break top-level ANDs

                    var subst = new Substitution(v =>
                    {
                        var num = Int32.Parse(v.Name.Substring(1));
                        return proc2Exprs[foo.Name][num];
                    });

                    body = Substituter.Apply(subst, body);

                    if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadFreeTail)
                    {
                        body = Expr.Or(body, func2post[foo.Name]);
                    }
                    else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.OnlyHeadBoundedTail)
                    {
                        body = Expr.Or(body, func2post[foo.Name]);
                    }
                    else if (InductiveSummaries.useDirectedRules == InductiveSummaries.TemplateType.ClausePredicates)
                    {

                    }
                    else
                        Contract.Assert(false);

                    string funcName = null;

                    funcName = foo.Name.Substring(foo.Name.IndexOf("_") + 1);

                    if (funcName.Equals("I8042MouseIsrDpc"))
                        Console.Write("");

                    if (!houdiniSummaryOut.ContainsKey(funcName))
                        houdiniSummaryOut[funcName] = new List<Expr> { body };
                    else
                        houdiniSummaryOut[funcName].Add(body);

                    foreach (var c in houdiniSummaryOut[funcName])
                        predicates.Add(c.ToString());
                }
            }
            else
            {
                AbstractHoudini absHoudini = null;
                PredicateAbs.Initialize(program);
                absHoudini = new AbstractHoudini(program);
                absHoudini.computeSummaries(new PredicateAbs(program.TopLevelDeclarations.OfType<Implementation>().First().Name));
                // Abstract houdini sets a prover option for the time limit. Get rid of that now
                CommandLineOptions.Clo.ProverOptions.RemoveAll(str => str.StartsWith("TIME_LIMIT"));

                // Record new summaries
                predicates = absHoudini.GetPredicates();
            }


            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;
            CommandLineOptions.Clo.PrintErrorModelFile = oldmodelfile;

#if false
            // get rid of "true ==> blah" for type-state predicates 
            // because we know they get covered by other candidates anyway
            var typestatePost = new HashSet<string>();
            templates
                .Where(ee => BoogieUtil.checkAttrExists("typestate", ee.annotations)
                    && BoogieUtil.checkAttrExists("post", ee.annotations))
                .Iter(ee => typestatePost.Add(ee.expr.ToString()));
            predicates.ExceptWith(typestatePost);
#endif

            // write out the predicates
            Console.WriteLine("Predicates:");
            predicates.Iter(s => Console.WriteLine("  {0}", s));
            using (var fs = new System.IO.StreamWriter("corralPredicates.txt"))
            {
                predicates.Iter(s => fs.WriteLine("{0}", s));
            }

            predicateSet = predicates;
            return houdiniSummaryOut;
        }

        public Dictionary<string, List<Expr>> trainSummaries(Program program, Dictionary<string, HashSet<Expr>> predicateDict, HashSet<Expr> predicateSet)
        {
            // discard non-free templates
            //templates.RemoveAll(ee => !ee.IsFree);

            //var trainingProc = program.TopLevelDeclarations.OfType<Procedure>()
            //    .Where(proc => BoogieUtil.checkAttrExists("trainingPredicates", proc.Attributes))
            //    .FirstOrDefault();
            //if (trainingProc == null)
            //    throw new InternalError("Illegal invocation of training summaries mode");

            //foreach (Ensures ens in trainingProc.Ensures)
            //    templates.Add(new EExpr(ens));

            //BoogieUtil.DoModSetAnalysis(program);

            //DoStaticAnalysis(program);

            // fake abs houdini to get the template instantiation correct
            runAbsHoudiniConfig = "";

            Contract.Assert(predicateDict == null || predicateSet == null);

#if false
            // We don't want predicates from "main"
            var impl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            if (impl != null) impl.AddAttribute("entrypoint");

            var info = Instantiate(program);
#endif

            Dictionary<string, Expr> func2post = new Dictionary<string, Expr>();
            var proc2Exprs = new Dictionary<string, List<Expr>>();
            if (FPA)
            {
                var newFns = new List<Declaration>();
                foreach (var p in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var proc = p.Proc;

                    List<Expr> exprArgs;

                    if (predicateDict != null)
                    {
                        if (!predicateDict.ContainsKey(proc.Name))
                            continue;

                        exprArgs = predicateDict[proc.Name].ToList();
                    }
                    else
                    {
                        exprArgs = predicateSet.ToList();
                    }

                    if (exprArgs.Count == 0)
                        continue;

                    //                    var sp = proc.Ensures.Partition(ens => ens.Free);
                    //                    proc.Ensures = sp.fst;

                    if (doCartesianAbstraction)  // for all pre predicates (those having only old(.)) p1, p2.. and post predicates (atleast one expression not having old(.)), q1, q2..., add ensures as foo1(p1,p2..)=>q1, foo2(p1, p2...)=>q2...
                    {
                        Contract.Assert(predicateSet != null && predicateDict == null);

                        // only include predicates where at least one variable is included in the modifies set
                        // also divide the set into pre/post sets
                        HashSet<Expr> pre = new HashSet<Expr>();
                        HashSet<Expr> post = new HashSet<Expr>();

                        HashSet<string> modifies = new HashSet<string>();
                        proc.Modifies.Iter<IdentifierExpr>(n => modifies.Add(n.ToString()));

                        foreach (Expr predicate in predicateSet)
                        {
                            Contract.Assert((predicate as NAryExpr).Args.Count == 2);

                            bool isPost = false; // if at least one variable is not old(.), then expression is post
                            bool isInModifies = false;

                            // check if predicate is relevant w.r.t modifies set

                            var v1 = getVarInPredicate(predicate, 0);
                            var v2 = getVarInPredicate(predicate, 1);

                            if (v1.Item1 != null && modifies.Contains(v1.Item1.Name))
                                isInModifies = true;

                            if (v2.Item1 != null && modifies.Contains(v2.Item1.Name))
                                isInModifies = true;

#if false
                            if (!isInModifies)
                                continue;
#endif
                            // check if it is pre or post
                            if (v1.Item1 != null && !v1.Item2)
                                isPost = true;

                            if (v2.Item1 != null && !v2.Item2)
                                isPost = true;

                            if (isPost)
                            {
                                if (isInModifies)
                                    post.Add(predicate); // only relevant if is this predicate can be modified by this procedure
                            }
                            else
                            {
                                pre.Add(predicate);
                            }
                        }

                        int id = 0;
                        foreach (Expr predicate in post)
                        {
                            // add "dummy" existential function to drive predicate abstraction
                            var foo = CreateFunctionFPA(pre.Count, "foo" + id + "_" + proc.Name);
                            foo.AddAttribute("absdomain", "PredicateAbs");
                            newFns.Add(foo);
                            id++;

                            //var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                            var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), pre.ToList());
                            expr = Expr.Or(expr, predicate) as NAryExpr;
                            //expr = Expr.Imp(Expr.Not(expr), predicate); // (not pre) => post i.e. (pre \/ post); here pre are foo(); initially pre is false; will try to climb to true
                            proc.Ensures.Add(new Ensures(false, expr));

                            proc2Exprs.Add(foo.Name, pre.ToList());

                            func2post.Add(foo.Name, predicate);
                        }
                    }
                    else
                    {
                        // add "dummy" existential function to drive predicate abstraction
                        var foo = CreateFunctionFPA(exprArgs.Count, "foo_" + proc.Name);
                        foo.AddAttribute("absdomain", "PredicateAbs");
                        newFns.Add(foo);

                        //var exprArgs = new List<Expr>(sp.snd.Select(ens => ens.Condition));
                        var expr = new NAryExpr(Token.NoToken, new FunctionCall(foo), exprArgs);
                        proc.Ensures.Add(new Ensures(false, expr));

                        proc2Exprs.Add(foo.Name, exprArgs);
                    }


                }

                program.TopLevelDeclarations.AddRange(newFns);
            }

            // Massage program
            //(new RewriteCallDontCares()).VisitProgram(program);
            // get rid of assert in main
            var mainImpl = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, "fakeMain");
            foreach (var blk in mainImpl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    var acmd = blk.Cmds[i] as AssertCmd;
                    if (acmd == null) continue;
                    var le = acmd.Expr as LiteralExpr;
                    if (le != null && le.IsTrue) continue;
                    blk.Cmds[i] = new AssumeCmd(Token.NoToken, acmd.Expr);
                }
            }

            // Run Abs Houdini

            CommandLineOptions.Clo.InlineDepth = InlineDepth;
            var old = CommandLineOptions.Clo.ProcedureInlining;
            CommandLineOptions.Clo.ProcedureInlining = CommandLineOptions.Inlining.Spec;
            var si = CommandLineOptions.Clo.StratifiedInlining;
            CommandLineOptions.Clo.StratifiedInlining = 0;
            var cc = CommandLineOptions.Clo.ProverCCLimit;
            CommandLineOptions.Clo.ContractInfer = true;
            var oldTimeout = CommandLineOptions.Clo.ProverKillTime;

            CommandLineOptions.Clo.ProverKillTime = 20000; // AbsHoudini interprets this as milliseconds
            CommandLineOptions.Clo.ProverCCLimit = 1;
            CommandLineOptions.Clo.AbstractHoudini = runAbsHoudiniConfig;
            CommandLineOptions.Clo.PrintErrorModel = 1;
            AbstractHoudini.WitnessFile = null;

            Dictionary<string, List<Expr>> houdiniSummaryOut = new Dictionary<string, List<Expr>>();

            var time3 = DateTime.Now;

            //inline(program);
            BoogieUtil.TypecheckProgram(program, "error.bpl");

            if (printHoudiniQuery != null)
                BoogieUtil.PrintProgram(program, printHoudiniQuery);

            HashSet<string> predicates = new HashSet<string>();

            Program houdiniProgram;

            // dump and reload the fresh program to escape VCExprVar->ExprIdentifier->Variable mapping issues faced during translation
            if (true)
            {
                TokenTextWriter tt = new TokenTextWriter("AbsHoudIn.bpl");
                program.Emit(tt);
                tt.Close();


                houdiniProgram = ExecutionEngine.ParseBoogieProgram(new List<string> { "AbsHoudIn.bpl" }, false);
                int errCount1 = houdiniProgram.Resolve();
                int errCount2 = houdiniProgram.Typecheck();

                Contract.Assert(errCount1 == 0 && errCount2 == 0);
            }

            if (FPA)
            {
                AbstractDomainFactory.Initialize(houdiniProgram);
                var domain = AbstractDomainFactory.GetInstance("PredicateAbs");
                AbsHoudini abs = new AbsHoudini(houdiniProgram, domain);
                CommandLineOptions.Clo.PrintAssignment = true;
                var absout = abs.ComputeSummaries();

                var summaries = abs.GetAssignment();

                foreach (var foo in summaries)
                {
                    var body = foo.Body;
                    if (body is LiteralExpr && (body as LiteralExpr).IsTrue) // foo => cond,  if foo=false, then nothing useful is asserted; remember that (not foo)=> post is asserted
                        continue;

                    // break top-level ANDs

                    var subst = new Substitution(v =>
                    {
                        var num = Int32.Parse(v.Name.Substring(1));
                        return proc2Exprs[foo.Name][num];
                    });

                    body = Substituter.Apply(subst, body);

                    string funcName = null;

                    if (doCartesianAbstraction)
                    {
                        funcName = foo.Name.Substring(foo.Name.IndexOf("_") + 1);

                        if (!houdiniSummaryOut.ContainsKey(funcName))
                            houdiniSummaryOut[funcName] = new List<Expr> { Expr.Or(body, func2post[foo.Name]) };
                        else
                            houdiniSummaryOut[funcName].Add(Expr.Or(body, func2post[foo.Name]));
                    }
                    else
                    {
                        funcName = foo.Name.Substring("foo_".Length);

                        houdiniSummaryOut[funcName] = GetConjuncts(body);
                    }

                    foreach (var c in houdiniSummaryOut[funcName])
                        predicates.Add(c.ToString());
                }
            }
            else
            {
                AbstractHoudini absHoudini = null;
                PredicateAbs.Initialize(program);
                absHoudini = new AbstractHoudini(program);
                absHoudini.computeSummaries(new PredicateAbs(program.TopLevelDeclarations.OfType<Implementation>().First().Name));
                // Abstract houdini sets a prover option for the time limit. Get rid of that now
                CommandLineOptions.Clo.ProverOptions.RemoveAll(str => str.StartsWith("TIME_LIMIT"));

                // Record new summaries
                predicates = absHoudini.GetPredicates();
            }


            CommandLineOptions.Clo.InlineDepth = -1;
            CommandLineOptions.Clo.ProcedureInlining = old;
            CommandLineOptions.Clo.StratifiedInlining = si;
            CommandLineOptions.Clo.ProverCCLimit = cc;
            CommandLineOptions.Clo.ContractInfer = false;
            CommandLineOptions.Clo.ProverKillTime = oldTimeout;
            CommandLineOptions.Clo.AbstractHoudini = null;
            CommandLineOptions.Clo.PrintErrorModel = 0;

#if false
            // get rid of "true ==> blah" for type-state predicates 
            // because we know they get covered by other candidates anyway
            var typestatePost = new HashSet<string>();
            templates
                .Where(ee => BoogieUtil.checkAttrExists("typestate", ee.annotations)
                    && BoogieUtil.checkAttrExists("post", ee.annotations))
                .Iter(ee => typestatePost.Add(ee.expr.ToString()));
            predicates.ExceptWith(typestatePost);
#endif

            // write out the predicates
            Console.WriteLine("Predicates:");
            predicates.Iter(s => Console.WriteLine("  {0}", s));
            using (var fs = new System.IO.StreamWriter("corralPredicates.txt"))
            {
                predicates.Iter(s => fs.WriteLine("{0}", s));
            }

            return houdiniSummaryOut;
        }

        private Tuple<IdentifierExpr, bool> getVarInPredicate(Expr predicate, int p)
        {
            IdentifierExpr v = null;
            bool isOld = false;

            if (predicate is NAryExpr)
            {
                var id = (predicate as NAryExpr).Args[p];

                if (id is OldExpr)
                {
                    v = ((id as OldExpr).Expr) as IdentifierExpr;
                    isOld = true;
                }
                else
                {
                    v = id as IdentifierExpr;
                    isOld = false;
                }
            }

            return new Tuple<IdentifierExpr, bool>(v, isOld);
        }

        private Function CreateFunctionFPA(int numArgs, string name)
        {
            var args = new List<Variable>();
            for (int i = 0; i < numArgs; i++)
                args.Add(BoogieAstFactory.MkFormal("x" + i.ToString(), Microsoft.Boogie.Type.Bool, true));
            var ret = new Function(Token.NoToken, name, args, BoogieAstFactory.MkFormal("x", Microsoft.Boogie.Type.Bool, false));
            ret.AddAttribute("existential", Expr.Literal(true));
            return ret;
        }

        private List<Expr> GetConjuncts(Expr expr)
        {
            var nary = expr as NAryExpr;
            if (nary == null) return new List<Expr> { expr };
            var bop = nary.Fun as BinaryOperator;
            if (bop == null || bop.Op != BinaryOperator.Opcode.And) return new List<Expr> { expr };

            var l1 = GetConjuncts(nary.Args[0]);
            var l2 = GetConjuncts(nary.Args[1]);

            return new List<Expr>(l1.Concat(l2));
        }
    }

    public class VCExpr2Expr
    {

        public static Variable MakeVar(VCExprVar v)
        {
            var foo = new TypedIdent(Token.NoToken, v.Name.ToString(), v.Type);
            return new BoundVariable(Token.NoToken, foo);
        }

        public static BinaryOperator.Opcode VCOpToOp(VCExprOp op)
        {
            if (op == VCExpressionGenerator.AddIOp)
                return BinaryOperator.Opcode.Add;
            if (op == VCExpressionGenerator.SubIOp)
                return BinaryOperator.Opcode.Sub;
            if (op == VCExpressionGenerator.MulIOp)
                return BinaryOperator.Opcode.Mul;
            if (op == VCExpressionGenerator.DivIOp)
                return BinaryOperator.Opcode.Div;
            if (op == VCExpressionGenerator.EqOp)
                return BinaryOperator.Opcode.Eq;
            if (op == VCExpressionGenerator.LeOp)
                return BinaryOperator.Opcode.Le;
            if (op == VCExpressionGenerator.LtOp)
                return BinaryOperator.Opcode.Lt;
            if (op == VCExpressionGenerator.GeOp)
                return BinaryOperator.Opcode.Ge;
            if (op == VCExpressionGenerator.GtOp)
                return BinaryOperator.Opcode.Gt;
            if (op == VCExpressionGenerator.AndOp)
                return BinaryOperator.Opcode.And;
            if (op == VCExpressionGenerator.OrOp)
                return BinaryOperator.Opcode.Or;
            throw new Exception();
        }

        public static Expr MakeBinary(BinaryOperator.Opcode op, List<Expr> args)
        {
            if (args.Count == 0)
            {
                // with zero args we need the identity of the op
                switch (op)
                {
                    case BinaryOperator.Opcode.And:
                        return Expr.True;
                    case BinaryOperator.Opcode.Or:
                        return Expr.False;
                    case BinaryOperator.Opcode.Add:
                        return new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ZERO);
                    default:
                        throw new Exception();
                }
            }
            var temp = args[0];
            for (int i = 1; i < args.Count; i++)
                temp = Expr.Binary(Token.NoToken, op, temp, args[i]);
            return temp;
        }

        public static Expr VCExprToExpr(VCExpr e, Dictionary<VCExpr, Expr> bound)
        {
            if (e is VCExprVar)
            {
                if (bound.ContainsKey(e))
                    return bound[e];
                return Expr.Ident(MakeVar(e as VCExprVar)); // TODO: this isn't right
            }
            if (e is VCExprIntLit)
            {
                var n = e as VCExprIntLit;
                return new LiteralExpr(Token.NoToken, n.Val);
            }
            if (e is VCExprNAry)
            {
                var f = e as VCExprNAry;
                var args = new List<Expr>();
                for (int i = 0; i < f.Arity; i++)
                {
                    args.Add(VCExprToExpr(f[i], bound));
                }

                if (f.Op == VCExpressionGenerator.NotOp)
                    return Expr.Unary(Token.NoToken, UnaryOperator.Opcode.Not, args[0]);

                if (f.Op == VCExpressionGenerator.IfThenElseOp)
                    return new NAryExpr(Token.NoToken, new IfThenElse(Token.NoToken), args);

                if (f.Op is VCExprSelectOp)
                {
                    var idx = new List<Expr>();
                    idx.Add(args[1]);
                    return Expr.Select(args[0], idx);
                }

                if (f.Op is VCExprStoreOp)
                {
                    var idx = new List<Expr>();
                    idx.Add(args[1]);
                    return Expr.Store(args[0], idx, args[2]);
                }

                var op = VCOpToOp(f.Op);
                return MakeBinary(op, args);
            }

            if (e is VCExprQuantifier)
            {
                var f = e as VCExprQuantifier;
                var vs = new List<Variable>();
                var new_bound = new Dictionary<VCExpr, Expr>(bound);
                foreach (var v in f.BoundVars)
                {
                    var ve = MakeVar(v);
                    vs.Add(ve);
                    new_bound.Add(v, Expr.Ident(ve));
                }
                var bd = VCExprToExpr(f.Body, new_bound);
                if (f.Quan == Quantifier.EX)
                    return new ExistsExpr(Token.NoToken, vs, bd);
                else
                    return new ForallExpr(Token.NoToken, vs, bd);
            }
            if (e == VCExpressionGenerator.True)
            {
                return Expr.True;
            }
            if (e == VCExpressionGenerator.False)
            {
                return Expr.False;
            }
            if (e is VCExprLet)
            {

            }

            throw new Exception();
        }

    }

}
