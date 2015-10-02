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
            for (int i = 0; i < conjucts.Count; i++)
            {
                // Preserves order of disjuncts.
                indexedCnf.Add(SimplifyExpr.GetExprDisjuncts(conjucts[i]));
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
            return new TemplateAnnotations(clauses); 
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
                str += "\n\t" + clstr;
            }
            return str + "\n}";    
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

            for (int i = 1; i <= this.annots.ClauseMaxSize(); i++)
            {
                simplificationSizes.Add(i);
            }
            // 0 is the last since clauses of size 0 make the formula weaker.
            simplificationSizes.Add(0);
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
            // NOTE: clause goes from 0 to annots.ClauseCount()-1
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
                return createSimplifiedFormula(subset);
            }
        }


        TemplateAnnotations createSimplifiedFormula(HashSet<int> subset)
        {
            TemplateAnnotations canns = annots.DeepCopy();
            var clause = canns.GetClause(clauseIndex);
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
                if (mask > cl.Count)
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

                // If the subset size mathces our simplification size,
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

        static HashSet<string> identifiers = new HashSet<string>();

        public K1BreadthMinimizer(MinimizerData mdata) : base(mdata)
        {
        }

        public override HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta)
        {
            var files = mdata.fileToProg.Keys.ToList();
            for (int i = 0; i < files.Count; i++)
            {
                var file = files[i];
                var minTemplate = computeMinimalTemplate(file, mdata.fileToProg[file]);
                Console.WriteLine(minTemplate);
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

            TemplateAnnotations icnf = new TemplateAnnotations(templates);
            Console.WriteLine("Indexed template ({0}):", templates.Count);
            Console.WriteLine("\t{0}", icnf.ToString());

            int initialCost = mdata.fileToPerf[file];
            TemplateAnnotations bestTemplate = icnf;
            while (true)
            {
                var t = getBetterTemplate(program, bestTemplate, initialCost);
                if (t == null)
                {
                    break;
                }
                else
                {
                    bestTemplate = t;
                }
            }

            return bestTemplate;
        }


        bool isMinimalTemplateTemplateAnnotations (ProgTransformation.PersistentProgram program, TemplateAnnotations template, int initialCost)
        {
            var t = getBetterTemplate(program, template, initialCost);
            if (t == null)
            {
                return true;
            }
            return false;
        }

        TemplateAnnotations getBetterTemplate(ProgTransformation.PersistentProgram program, TemplateAnnotations template, int initialCost)
        {
            Console.WriteLine("Creating k1 simplified templates iterator...");
            SimplifiedAnnotsIterator iter = new SimplifiedAnnotsIterator(template);

            TemplateAnnotations simple;
            while ((simple = iter.next()) != null)
            {
                Console.WriteLine("Checking subtemplate: {0}", simple.ToString());

                Console.WriteLine("Computing instantiations.");
                var insts = instantiateTemplate(simple, program);

                Console.WriteLine("Computing the cost");
                int cost = computeCost(program, insts);

                if (cost < initialCost)
                {
                    return simple;
                }
            }

            return null;
        }

        int computeCost(ProgTransformation.PersistentProgram program, Dictionary<Procedure, List<Expr>> instantiation)
        {
            var allconstants = new Dictionary<string, Constant>();
            var prog = program.getProgram();
            prog.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => allconstants.Add(c.Name, c));
            MinControl.DropConstants(prog, new HashSet<string>(allconstants.Keys));

            
            foreach (var proc in instantiation.Keys)
            {
                var procedure = prog.FindProcedure(proc.Name);
                foreach(var expr in instantiation[proc])
                {
                    string ident = createRandomIdentifier();
                    var tident = new TypedIdent(Token.NoToken, ident, Microsoft.Boogie.BasicType.Bool);
                    Constant c = new Constant(Token.NoToken, tident, false);
                    c.AddAttribute("existential", new object[1] { Microsoft.Boogie.Expr.True });
                    prog.AddTopLevelDeclaration(c);
                    
                    var identExp = new IdentifierExpr(Token.NoToken, tident.Name, tident.Type);
                    var impl = new NAryExpr(Token.NoToken, new BinaryOperator(Token.NoToken, BinaryOperator.Opcode.Imp), new List<Expr> { identExp, expr});
                    var ens = new Ensures(false, impl);
                    procedure.Ensures.Add(ens);
                }
            }

            var pcopy1 = BoogieUtil.ReResolveInMem(prog);
            var pcopy2 = BoogieUtil.ReResolveInMem(prog);
            //cba.Util.BoogieUtil.PrintProgram(prog, "interim1.txt");

            var assignment = CoreLib.HoudiniInlining.RunHoudini(pcopy1, true);
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(pcopy2, assignment);
            var pcopy3 = BoogieUtil.ReResolveInMem(pcopy2);
            //cba.Util.BoogieUtil.PrintProgram(pcopy3, "interim2.txt");


            // Run SI
            var err = new List<BoogieErrorTrace>();
            // Set bound to infinity.
            BoogieVerify.options.maxInlinedBound = 0;

            var rstatus = BoogieVerify.Verify(pcopy3, out err, true);
            //Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            var procs_inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;

            Console.WriteLine(rstatus);
            Console.WriteLine(procs_inlined);
            Console.WriteLine(err.Count);

            Environment.Exit(0);

            return 0;
        } 

        string createRandomIdentifier()
        {
            string letters = "abcdefghijklmnopqrstuvxwzABCDEFGHIJKLMNOPQRSTUVWXZ";
            string numbers = "0123456789";

            string ident = null;
            while(true)
            {
                ident = "";
                var random = new Random();
                for (int i = 0; i < 5; i++)
                {
                    ident += letters[random.Next(0, letters.Length - 1)];
                    ident += numbers[random.Next(0, numbers.Length - 1)];
                }

                if (!identifiers.Contains(ident))
                {
                    identifiers.Add(ident);
                    break;
                }
            }
            return ident;
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

        List<Expr> instantiateProcTemplates(Expr template, Dictionary<string, Variable> globals, Dictionary<string, Variable> formals)
        {
            return MinControl.InstantiateTemplate(template, SimplifyExpr.templateVars, globals, formals);
        }

    }
}
