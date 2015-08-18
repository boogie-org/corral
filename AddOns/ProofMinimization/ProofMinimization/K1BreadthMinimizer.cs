using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;

namespace ProofMinimization
{

    class IndexedCNF
    {
        List<HashSet<Expr>> icnf;
        public IndexedCNF(List<Expr> cnfs)
        {
            // Debug.Assert(cnfs.All(exp => SimplifyExpr.IsCleanFolCNF(exp)));
            Expr cnf;
            if (cnfs.Count == 1)
            {
                cnf = cnfs[0];
            }
            else
            {
                cnf = SimplifyExpr.reduce(cnfs, BinaryOperator.Opcode.And);
            }

            icnf = makeItIndexed(cnf);
        }

        public IndexedCNF(Expr cnf)
        {
            //Debug.Assert(SimplifyExpr.IsCleanFolCNF(cnf));
            icnf = makeItIndexed(cnf);
        }


        static List<HashSet<Expr>> makeItIndexed(Expr cnf)
        {
            List<HashSet<Expr>> indexedCnf = new List<HashSet<Expr>>();
            List<Expr> conjucts = SimplifyExpr.GetSubExprs(cnf, BinaryOperator.Opcode.And);
            for (int i = 0; i < conjucts.Count; i++)
            {
                indexedCnf.Add(new HashSet<Expr>(SimplifyExpr.BreakDownExpr(conjucts[i])));
            }

            return indexedCnf;
        }

        public List<HashSet<Expr>> getClauses()
        {
            return icnf;
        }

        public HashSet<Expr> getClause(int i)
        {
            return icnf[i];
        }

        public List<HashSet<Expr>> Clone()
        {
            List<HashSet<Expr>> cl = new List<HashSet<Expr>>();
            for (int i = 0; i < icnf.Count; i++)
            {
                HashSet<Expr> clause = new HashSet<Expr>();
                foreach (var lit in icnf[i])
                {
                    clause.Add(lit);
                }
                cl.Add(clause);
            }
            return cl; 
        }
    }





    class K1BreadthMinimizer : Minimizer
    {
        MinimizerData mdata;

        public K1BreadthMinimizer(MinimizerData mdata) : base(mdata)
        {
            this.mdata = mdata;
        }

        public override HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta)
        {
            Console.WriteLine("\n\n\n\n\n");
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

            IndexedCNF template;


        }

    }
}
