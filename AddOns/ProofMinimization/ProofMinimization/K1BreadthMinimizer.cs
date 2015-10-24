using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace ProofMinimization
{
    // Set of template annotations implemented as a indexed set of clauses, i.e., an
    // indexed CNF formula, i.e., a CNF formula thought of as a list. 
    class TemplateAnnotations
    {
        double cst = 0;
        List<List<Expr>> icnf;

        // Constructors
        public TemplateAnnotations(List<Expr> cnfs)
        {
            //Debug.Assert(cnfs.All(exp => SimplifyExpr.IsCleanCNF(exp)));
            Expr cnf = SimplifyExpr.Reduce(cnfs, BinaryOperator.Opcode.And);
            icnf = makeItIndexed(cnf);
        }

        public TemplateAnnotations(Expr cnf)
        {
            //Debug.Assert(SimplifyExpr.IsCleanCNF(cnf));
            icnf = makeItIndexed(cnf);
        }

        public TemplateAnnotations(List<List<Expr>> icnf)
        {
            //Debug.Assert(icnf.All(exp => (exp.All(e => SimplifyExpr.IsCleanCNF(e)))));
            this.icnf = icnf; 
        }


        static List<List<Expr>> makeItIndexed(Expr cnf)
        {
            List<List<Expr>> indexedCnf = new List<List<Expr>>();
            List<Expr> conjucts = SimplifyExpr.GetExprConjunctions(cnf);
            HashSet<string> uniqueConjucts = new HashSet<string>();
            for (int i = 0; i < conjucts.Count; i++)
            {
                // Here we don't take into account the conjucts that are 
                // exactly the same. TODO: can we somehow recognize two
                // equivalent templates as well as those that are tautologies?
                // This just looks for string equivalence.
                if (!uniqueConjucts.Contains(conjucts[i].ToString()))
                {
                    uniqueConjucts.Add(conjucts[i].ToString());
                    // Preserves order of disjuncts.
                    indexedCnf.Add(SimplifyExpr.GetExprDisjuncts(conjucts[i]));
                }
            }
            return indexedCnf;
        }


        public int ClauseCount()
        {
            return icnf.Count;
        }

        public List<Expr> GetClause(int i)
        {
            return icnf[i];
        }

        public TemplateAnnotations DeepCopy()
        {
            List<List<Expr>> clauses = new List<List<Expr>>();
            for (int i = 0; i < icnf.Count; i++)
            {
                List<Expr> clause = new List<Expr>();
                for (int j = 0; j < icnf[i].Count; j++)
                {
                    clause.Add(icnf[i][j]);
                }
   
                clauses.Add(clause);
            }

            var t = new TemplateAnnotations(clauses);
            t.SetCost(Cost());
            return t; 
        }

        public override string ToString()
        {
            string str = "{";
            for (int i = 0; i < icnf.Count; i++)
            {
                string clstr = "";
                HashSet<Expr> clause = new HashSet<Expr>();
                foreach (var lit in icnf[i])
                {
                    clstr += lit + "\t";
                }
                str += "\r\n\t" + clstr;
            }
            return str + "\r\n}";    
        }

        public Expr ToCnfExpression()
        {
            List<Expr> conjucts = new List<Expr>();
            for (int i = 0; i < icnf.Count; i++)
            {
                var clause = icnf[i];
                if (clause.Count != 0)
                {
                    // Order preserving.
                    var clauseExpr = SimplifyExpr.Reduce(clause, BinaryOperator.Opcode.Or);
                    conjucts.Add(clauseExpr);
                }
            }

            if (conjucts.Count == 0)
            {
                return Expr.True;
            } 
            else
            {
                return SimplifyExpr.Reduce(conjucts, BinaryOperator.Opcode.And);
            }
        }

        public int ClauseMaxSize() {
            int ms = 0;
            foreach (var clause in icnf) 
            {
                ms = clause.Count > ms? clause.Count : ms;
            }
            return ms;
        }

        public double Cost()
        {
            return cst;
        }

        public void SetCost(double c)
        {
            this.cst = c;
        }
    }


    // Lazy iterator over k=1 simplified annotation sets of a given set.
    class SimplifiedAnnotsIterator
    {
        TemplateAnnotations annots;

        // iteration state
        int clauseIndex = 0;
        int simplSizeIndex = 0;
        // size of simplified clause.
        List<int> simplificationSizes = new List<int>();

        // binary mask for subset enumeration.
        int mask = -1;

        public SimplifiedAnnotsIterator(TemplateAnnotations annots)
        {
            this.annots = annots;

            for (int i = 0; i <= this.annots.ClauseMaxSize(); i++)
            {
                simplificationSizes.Add(i);
            }
        }

        // Gimme the next simplified annotation set.
        public TemplateAnnotations next()
        {
            // True has no simplified versions. 
            if (annots.ToCnfExpression() == Expr.True)
            {
                return null;
            }

            // If we simplified for all simpflification sizes, we are done.
            if (simplSizeIndex >= simplificationSizes.Count)
            {
                return null;
            }

            // If we finished simplifying all clauses for the current simplification size.
            // NOTE: clauseIndex goes from 0 to annots.ClauseCount() - 1
            if (clauseIndex >= annots.ClauseCount())
            {
                clauseIndex = 0;
                mask = -1;
                simplSizeIndex++;
                return next();
            }
                
            // If we enlisted all subsets of the current clause. This also covers the case
            // when simplification size is bigger than the clause.
            var subset = nextSubset();
            if (subset == null) 
            {
                clauseIndex++;
                mask = -1;
                return next();
            }
            else
            {
                return createSimplifiedFormula(subset, clauseIndex);
            }
        }


        TemplateAnnotations createSimplifiedFormula(HashSet<int> subset, int clIndex)
        {
            TemplateAnnotations canns = annots.DeepCopy();
            var clause = canns.GetClause(clIndex);
            List<Expr> newClause = new List<Expr>();
            for (int i = 0; i < clause.Count; i++)
            {
                if (subset.Contains(i))
                {
                    newClause.Add(clause[i]);
                }
            }
            clause.Clear();
            clause.AddRange(newClause);
            return canns;
        }

        HashSet<int> nextSubset()
        {
            int simplifiedSize = simplificationSizes[simplSizeIndex];
            // This is probably not even necessary, but can save some time.
            // Simplified size always has to be strictly less than the clause size.
            if (simplifiedSize >= annots.GetClause(clauseIndex).Count)
            {
                return null;
            }

            while (true)
            {
                mask++;
                var cl = annots.GetClause(clauseIndex);
                // We are interested in strict subsets.
                if (mask >= (Math.Pow(2, cl.Count) - 1))
                {
                    break;
                }

                // Make mask a char array and add the leading 0s.
                var bits = Convert.ToString(mask, 2).ToCharArray();
                while (bits.Length < cl.Count)
                {
                    var lbits = bits.ToList();
                    lbits.Insert(0, '0');
                    bits = lbits.ToArray<Char>();
                }

                // Collect the 1 bit indices, they encode our subset.
                HashSet<int> subset = new HashSet<int>();
                for (int i = 0; i < bits.Length; i++)
                {
                    if (bits[i] == '1')
                    {
                        subset.Add(i);
                    }
                }

                // If the subset size matches our simplification size,
                // we have a simplified clause data: return it.
                if (subset.Count == simplifiedSize)
                {                    
                    return subset;
                }
            }

            return null;
        }
    }


    class K1BreadthMinimizer : Minimizer
    {
        //int call = 0;
        
        static HashSet<string> identifiers = new HashSet<string>();
        static Dictionary<string, double> costMemoization = new Dictionary<string, double>();
        double hbalance = 0.1;

        static string ART_VAR_PREFIX = "ART_";

        public K1BreadthMinimizer(MinimizerData mdata) : base(mdata)
        {
        }

        public override HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta)
        {
            Dictionary<string, TemplateAnnotations> minTemplates = new Dictionary<string, TemplateAnnotations>();

            var files = mdata.fileToProg.Keys.ToList();
            for (int i = 0; i < files.Count; i++)
            {
                var file = files[i];
                Console.WriteLine("\r\n\r\nWorking on file :" + file);

                var prog = mdata.fileToProg[file];

                Console.WriteLine("Checking for minimal template in existing results.");
                foreach (var f in minTemplates.Keys)
                {
                    Console.WriteLine("Checking existing result for {0}", f);
                    var t = minTemplates[f];
                    try
                    {
                        if (isMinimalTemplate(prog, t))
                        {
                            minTemplates[file] = t;
                            Console.WriteLine("Found minimal template in existing results:" + t.ToString());
                            break;
                        }
                    }
                    catch
                    {
                        Console.WriteLine("ERROR: Minimality check failed {0}. Investigate!", f);
                    }
                }

                // Basically, if the previous loop ended in a break.
                if (minTemplates.ContainsKey(file))
                {
                    continue;
                }

                Console.WriteLine("\r\nNo minimal template found in current results. Computing my own minimal.");

                try {
                    var minTemplate = computeMinimalTemplate(file, prog);
                    Console.WriteLine("Now updating previous results");
                    foreach (var f in minTemplates.Keys)
                    {
                        try
                        {
                            Console.WriteLine("Updating " + f);
                            if (isMinimalTemplate(prog, minTemplate))
                            {
                                minTemplates[f] = minTemplate;
                                Console.WriteLine("Updated!");
                                break;
                            }
                            Console.WriteLine("No need for updating");
                        }
                        catch
                        {
                            Console.WriteLine("ERROR: Minimality check failed {0}. Investigate!", f);
                        }
                    }
                    minTemplates[file] = minTemplate;
                    Console.WriteLine("Done updating.");
                } catch (Exception e)
                {
                    Console.WriteLine("ERROR: Something went wrong with program {0}. Investigate!", file);
                }
                Console.WriteLine();
            }


            Console.WriteLine("\r\nPRINTING MINIMAL TEMPLATES");
            HashSet<string> uniqueTemplates = new HashSet<string>();
            foreach (var k in minTemplates.Keys)
            {
                uniqueTemplates.Add(minTemplates[k].ToString());          
            }
            foreach (var tempStr in uniqueTemplates)
            {
                Console.WriteLine(tempStr);
            }

            templateToPerfDelta = new Dictionary<int,int>();
            return new HashSet<int>();
        }


        TemplateAnnotations computeMinimalTemplate(string file, ProgTransformation.PersistentProgram program)
        {
            var fileTempIds = mdata.fileToTempIds[file];

            Console.WriteLine("Found the following templates for program {0}:", file);
            List<Expr> templates = new List<Expr>();
            foreach (var tid in fileTempIds)
            {
                Console.WriteLine(tid);
                var template = mdata.tempIdToExpr[tid];
                Console.WriteLine("\t{0}", template.ToString());
                templates.Add(template);
            }

            costMemoization = new Dictionary<string, double>();

            Console.WriteLine("\nCreating indexed template {0}", templates.Count);
            TemplateAnnotations icnf = new TemplateAnnotations(templates);
            
            TemplateAnnotations bestTemplate = icnf;
            Console.WriteLine("Creating initial cost...");
            bestTemplate.SetCost(getInitialCost(program, icnf)); 
            Console.WriteLine("Initial cost constructed: {0}", bestTemplate.Cost());

            while (true)
            {
                //call++;
                Console.WriteLine("Currently best template: \r\n{0}", bestTemplate.ToString());
                 
                var t = getBetterTemplate(program, bestTemplate);
                if (t == null)
                {
                    break;
                }
                else
                {
                    Console.WriteLine("Best template just changed.\n");
                    bestTemplate = t;
                }
            }

            Console.WriteLine("COST: {0} \r\n MINIMAL TEMPLATE: {1}\r\n", bestTemplate.Cost(), bestTemplate.ToString());
            return bestTemplate;
        }


        bool isMinimalTemplate(ProgTransformation.PersistentProgram program, TemplateAnnotations template)
        {
            var t = template.DeepCopy();
            Console.WriteLine("Creating initial cost...");
            t.SetCost(getInitialCost(program, t));
            Console.WriteLine("Initial cost constructed: {0}", t.Cost());         
            var better = getBetterTemplate(program, t, false);
            if (better == null)
            {
                return true;
            }
            return false;
        }

        double getInitialCost(ProgTransformation.PersistentProgram program, TemplateAnnotations template)
        {
            var insts = instantiateTemplate(template, program);
            return computeCost(program, insts);
        }

        TemplateAnnotations getBetterTemplate(ProgTransformation.PersistentProgram program, TemplateAnnotations template, bool useMemo = true)
        {
            Console.WriteLine("Creating k1 simplified templates iterator...");
            SimplifiedAnnotsIterator iter = new SimplifiedAnnotsIterator(template);

            TemplateAnnotations simple;
            while ((simple = iter.next()) != null)
            {
                Console.WriteLine("Checking subtemplate: {0}", simple.ToString());

                double cost;
                if (useMemo && costMemoization.ContainsKey(simple.ToString()))
                {
                    Console.WriteLine("Subtemplate already processed before; taking cost from there.");
                    cost = costMemoization[simple.ToString()];
                    simple.SetCost(cost);
                } else { 
                    Console.WriteLine("Computing instantiations...");
                    var insts = instantiateTemplate(simple, program);

                    Console.WriteLine("Computing the cost...");
                    cost = computeCost(program, insts);
                    simple.SetCost(cost);
                    costMemoization[simple.ToString()] = cost;
                }
                
                Console.WriteLine("Cost is {0}", cost);

                if (cost < template.Cost())
                {
                    return simple;
                }
            }

            return null;
        }

        double computeCost(ProgTransformation.PersistentProgram program, Dictionary<Procedure, List<Expr>> instantiation)
        {
            var allconstants = new Dictionary<string, Constant>();
            var prog = program.getProgram();
            prog.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => allconstants.Add(c.Name, c));
            MinControl.DropConstants(prog, new HashSet<string>(allconstants.Keys));
            //cba.Util.BoogieUtil.PrintProgram(prog, "interim0_" + call + ".bpl");
            
            int instCnt = 0;
            foreach (var proc in instantiation.Keys)
            {
                var procedure = prog.FindProcedure(proc.Name);
                foreach (var expr in instantiation[proc])
                {
                    string ident = createRandomIdentifier();
                    var tident = new TypedIdent(Token.NoToken, ident, Microsoft.Boogie.BasicType.Bool);
                    Constant c = new Constant(Token.NoToken, tident, false);
                    c.AddAttribute("existential", new object[1] { Microsoft.Boogie.Expr.True });
                    prog.AddTopLevelDeclaration(c);

                    var identExp = new IdentifierExpr(Token.NoToken, tident.Name, tident.Type);
                    var impl = new NAryExpr(Token.NoToken, new BinaryOperator(Token.NoToken, BinaryOperator.Opcode.Imp), new List<Expr> { identExp, expr });
                    var ens = new Ensures(false, impl);
                    procedure.Ensures.Add(ens);
                    instCnt++;
                }
            }

            // Running Houdini and Corral must be done on fresh program instances.
            var pcopy1 = BoogieUtil.ReResolveInMem(prog);
            var pcopy2 = BoogieUtil.ReResolveInMem(prog);
            //cba.Util.BoogieUtil.PrintProgram(prog, "interim1_" + call + ".bpl");

            var assignment = CoreLib.HoudiniInlining.RunHoudini(pcopy1, true);
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(pcopy2, assignment);
            // Cost of Houdini is currently the number of thrown candidates.
            // This roughly corresponds to the number of solver calls, which
            // is what we ideally want.
            long houdiniCost = instCnt - assignment.Count;

            // Take a fresh copy for corral, just in case.
            var pcopy3 = BoogieUtil.ReResolveInMem(pcopy2);
            //cba.Util.BoogieUtil.PrintProgram(pcopy3, "interim2_" + call + ".bpl");
            // Run SI but first set bound to infinity.
            BoogieVerify.options.maxInlinedBound = 0;
            var err = new List<BoogieErrorTrace>();
            var rstatus = BoogieVerify.Verify(pcopy3, out err, true);

            var procs_inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;

            if (rstatus == BoogieVerify.ReturnStatus.NOK)
            {
                throw new Exception("Corral returned NOT OK, we don't expect such benchmarks!");
            } else if (rstatus == BoogieVerify.ReturnStatus.ReachedBound)
            {
                return Double.MaxValue;
            } else
            {
                Console.WriteLine("Procedures inlined: {0}\tHoudini solver calls: {1}", procs_inlined, houdiniCost);
                //var cost =  ((double)(houdiniCost) / instantiation.Keys.Count) + procs_inlined;
                //var cost =  hbalance * houdiniCost + procs_inlined;
                var cost = procs_inlined;
                return cost;
            }
        } 

        Dictionary<Procedure, List<Expr>> instantiateTemplate(TemplateAnnotations tanns, ProgTransformation.PersistentProgram program)
        {
            // Get global variables.
            Program prog = program.getProgram();
            var globals = new Dictionary<string, Variable>();
            prog.TopLevelDeclarations
                .OfType<Variable>()
                .Iter(c => globals.Add(c.Name, c));

            // TODO: This should be done simpler???
            var tannsCNF = tanns.ToCnfExpression();
            var annots = SimplifyExpr.GetExprConjunctions(tannsCNF);

            Dictionary<Procedure, List<Expr>> procToInsts = new Dictionary<Procedure, List<Expr>>();

            foreach (var impl in prog.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = impl.Proc;
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint")) continue;

                var formals = new Dictionary<string, Variable>();
                proc.InParams.OfType<Formal>()
                    .Iter(f => formals.Add(f.Name, f));
                proc.OutParams.OfType<Formal>()
                    .Iter(f => formals.Add(f.Name, f));
        
                List<Expr> procInsts = new List<Expr>();
                for (int i = 0; i < annots.Count; i++) 
                {
                    var annot = annots[i];
                    var insts = instantiateProcTemplates(annot, globals, formals);
                    procInsts.AddRange(insts);
                }
                procToInsts[proc] = procInsts;
            }

            return procToInsts;
        }

        List<Expr> instantiateProcTemplates(Expr template, Dictionary<string, Variable> globals, 
                                            Dictionary<string, Variable> formals)
        {
            HashSet<Variable> templateVars = new HashSet<Variable>();
            var unqVarTemplate = toUniqueVarExpr(template, templateVars);
            return MinControl.InstantiateTemplate(unqVarTemplate, templateVars, globals, formals);
        }

        Expr toUniqueVarExpr(Expr expr, HashSet<Variable> templateVars)
        {
            Dictionary<Microsoft.Boogie.Type, int> inTypeIndices = new Dictionary<Microsoft.Boogie.Type, int>();
            Dictionary<Microsoft.Boogie.Type, int> outTypeIndices = new Dictionary<Microsoft.Boogie.Type, int>();
            var ret =
                Substituter.Apply(new Substitution(v =>
                {
                    if (v is Formal && (v as Formal).InComing)
                    {
                        var typ = v.TypedIdent.Type;
                        if (!inTypeIndices.ContainsKey(typ))
                        {
                            inTypeIndices[typ] = -1;
                        }
                        inTypeIndices[typ] += 1;
                        var nVar = BoogieAstFactory.MkFormal(v.Name + "_" + inTypeIndices[typ], typ, true);
                        templateVars.Add(nVar);
                        return Expr.Ident(nVar);
                    }
                    if (v is Formal && !(v as Formal).InComing)
                    {
                        var typ = v.TypedIdent.Type;
                        if (!outTypeIndices.ContainsKey(typ))
                        {
                            outTypeIndices[typ] = -1;
                        }
                        outTypeIndices[typ] += 1;
                        var nVar = BoogieAstFactory.MkFormal(v.Name + "_" + outTypeIndices[typ], typ, false);
                        templateVars.Add(nVar);
                        return Expr.Ident(nVar);
                    }
                    return Expr.Ident(v);
                }), expr);

            return ret;
        }

        string createRandomIdentifier()
        {
            string ident = null;
            while (true)
            {
                ident = ART_VAR_PREFIX + Guid.NewGuid().ToString();
                ident = ident.Replace("-", "_");

                if (!identifiers.Contains(ident))
                {
                    identifiers.Add(ident);
                    break;
                }
                
            }
            return ident;
        }

    }
}
