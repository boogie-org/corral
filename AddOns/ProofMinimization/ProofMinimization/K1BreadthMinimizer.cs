using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;

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
            // Simplified size always has to strictly less than the clause size.
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

        public K1BreadthMinimizer(MinimizerData mdata) : base(mdata)
        {
        }

        public override HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta)
        {
            Console.WriteLine("\n\n");
            var files = mdata.fileToProg.Keys.ToList();
            for (int i = 0; i < files.Count; i++)
            {
                var file = files[i];
                computeMinimalTemplate(file, mdata.fileToProg[file]);
            }


            templateToPerfDelta = new Dictionary<int,int>();
            return new HashSet<int>();
        }


        void computeMinimalTemplate(string file, ProgTransformation.PersistentProgram program)
        {

            var fileTempIds = mdata.fileToTempIds[file];
            //fileTempIds = fileTempIds.ToList();
            List<Expr> templates = new List<Expr>();

            Console.WriteLine("Found the following templates for program {0}.", file);
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

            Console.WriteLine("Printing k1 simplified templates");
            SimplifiedAnnotsIterator iter = new SimplifiedAnnotsIterator(icnf);

            TemplateAnnotations simple;
            while((simple = iter.next()) != null)
            {
                Console.WriteLine(simple.ToString());
                Console.WriteLine("");

            }
            

        }

    }
}
