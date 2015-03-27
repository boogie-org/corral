using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Z3;

namespace AliasAnalysis
{
    public class AASolver
    {
        Context ctx;
        IntSort Int;
        BoolSort Bool;

        FuncDecl pt;
        FuncDecl fpt;
        //FuncDecl assign_inst;
        //FuncDecl cse_assign_inst;
        //FuncDecl load_inst;
        //FuncDecl cse_load_inst;
        //FuncDecl store_inst;
        FuncDecl non_null_pt;

        Fixedpoint solver;

        int alloc_counter;
        int id_counter;
        Dictionary<string, int> string2identifier;

        public AASolver()
        {
            ctx = new Context();
            Int = ctx.IntSort;
            Bool = ctx.BoolSort;
            
            pt = ctx.MkFuncDecl("pt", new Sort[] { Int, Int }, Bool);
            non_null_pt = ctx.MkFuncDecl("non-null-pt", Int, Bool);
            fpt = ctx.MkFuncDecl("fpt", new Sort[] { Int, Int, Int }, Bool);
            //assign_inst = ctx.MkFuncDecl("assign-inst", new Sort[] { Int, Int }, Bool);
            //cse_assign_inst = ctx.MkFuncDecl("cse-assign-inst", new Sort[] { Int, Int }, Bool);
            //load_inst = ctx.MkFuncDecl("load-inst", new Sort[] { Int, Int, Int }, Bool);
            //cse_load_inst = ctx.MkFuncDecl("cse-load-inst", new Sort[] { Int, Int, Int }, Bool);
            //store_inst = ctx.MkFuncDecl("store-inst", new Sort[] { Int, Int, Int }, Bool);

            alloc_counter = 0;
            id_counter = 0;
            string2identifier = new Dictionary<string, int>();

            //IntExpr s = (IntExpr)ctx.MkBound(0, Int);
            //IntExpr x = (IntExpr)ctx.MkBound(1, Int);
            //IntExpr y = (IntExpr)ctx.MkBound(2, Int);
            //IntExpr f = (IntExpr)ctx.MkBound(3, Int);
            //IntExpr s1 = (IntExpr)ctx.MkBound(4, Int);
            //IntExpr s2 = (IntExpr)ctx.MkBound(5, Int);

            solver = ctx.MkFixedpoint();
            solver.RegisterRelation(pt);
            solver.RegisterRelation(non_null_pt);
            solver.RegisterRelation(fpt);
            //solver.RegisterRelation(assign_inst);
            //solver.RegisterRelation(cse_assign_inst);
            //solver.RegisterRelation(load_inst);
            //solver.RegisterRelation(cse_load_inst);
            //solver.RegisterRelation(store_inst);

            //solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s, y], (BoolExpr)assign_inst[x, y]), (BoolExpr)pt[s, x]));
            //solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s, y], (BoolExpr)cse_assign_inst[x, y], (BoolExpr)non_null_pt[s]), (BoolExpr)pt[s, x]));
            //solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, y], (BoolExpr)load_inst[x, y, f], (BoolExpr)fpt[s2, s1, f]), (BoolExpr)pt[s2, x]));
            //solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, y], (BoolExpr)cse_load_inst[x, y, f], (BoolExpr)fpt[s2, s1, f], (BoolExpr)non_null_pt[s2]), (BoolExpr)pt[s2, x]));
            //solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, x], (BoolExpr)store_inst[x, f, y], (BoolExpr)pt[s2, y]), (BoolExpr)fpt[s2, s1, f]));

            /*
            solver.AddRule((BoolExpr)pt[ctx.MkInt(1), ctx.MkInt(11)]);
            solver.AddRule((BoolExpr)non_null_pt[ctx.MkInt(1)]);
            solver.AddRule((BoolExpr)pt[ctx.MkInt(2), ctx.MkInt(12)]);
            solver.AddRule((BoolExpr)non_null_pt[ctx.MkInt(2)]);
            solver.AddRule((BoolExpr)store_inst[ctx.MkInt(11), ctx.MkInt(14), ctx.MkInt(12)]);
            solver.AddRule((BoolExpr)load_inst[ctx.MkInt(13), ctx.MkInt(11), ctx.MkInt(14)]);
            solver.AddRule((BoolExpr)pt[ctx.MkInt(0), ctx.MkInt(11)]);
            solver.AddRule((BoolExpr)cse_assign_inst[ctx.MkInt(15), ctx.MkInt(11)]);
            solver.AddRule((BoolExpr)assign_inst[ctx.MkInt(12), ctx.MkInt(15)]);

            Status stat;
            stat = solver.Query((BoolExpr)pt[ctx.MkInt(2), ctx.MkInt(13)]);
            Console.WriteLine("{0}", stat);

            stat = solver.Query((BoolExpr)pt[ctx.MkInt(1), ctx.MkInt(13)]);
            Console.WriteLine("{0}", stat);

            stat = solver.Query((BoolExpr)pt[ctx.MkInt(0), ctx.MkInt(15)]);
            Console.WriteLine("{0}", stat);
            */
        }

        // uniqute identifier to each string in program
        private int GetIdentifier(string s)
        {
            if (string2identifier.ContainsKey(s)) return string2identifier[s];
            else
            {
                int num = id_counter++;
                string2identifier.Add(s, num);
                return num;
            }
        }

        // x = new T();
        public void AddAllocationConstraint(string x_str)
        {
            int s = alloc_counter++;
            int x = GetIdentifier(x_str);
            
            solver.AddRule((BoolExpr)pt[ctx.MkInt(s), ctx.MkInt(x)]);

            if (!x_str.Equals("NULL")) solver.AddRule((BoolExpr)non_null_pt[ctx.MkInt(s)]);
        }

        // x = y;
        public void AddAssignConstraint(string x_str, string y_str)
        {
            int x = GetIdentifier(x_str);
            int y = GetIdentifier(y_str);

            IntExpr s = (IntExpr)ctx.MkBound(0, Int);

            if (x_str.StartsWith("cseTmp")) solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s, ctx.MkInt(y)], (BoolExpr)non_null_pt[s]), (BoolExpr)pt[s, ctx.MkInt(x)]));
            solver.AddRule(ctx.MkImplies((BoolExpr)pt[s, ctx.MkInt(y)], (BoolExpr)pt[s, ctx.MkInt(x)]));

            //if (x_str.StartsWith("cseTmp")) solver.AddRule((BoolExpr)cse_assign_inst[ctx.MkInt(x), ctx.MkInt(y)]);
            //else solver.AddRule((BoolExpr)assign_inst[ctx.MkInt(x), ctx.MkInt(y)]);
        }

        // x.f = y;
        public void AddStoreConstraint(string x_str, string f_str, string y_str)
        {
            int x = GetIdentifier(x_str);
            int f = GetIdentifier(f_str);
            int y = GetIdentifier(y_str);

            IntExpr s1 = (IntExpr)ctx.MkBound(1, Int);
            IntExpr s2 = (IntExpr)ctx.MkBound(2, Int);

            solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, ctx.MkInt(x)], (BoolExpr)pt[s2, ctx.MkInt(y)]), (BoolExpr)fpt[s2, s1, ctx.MkInt(f)]));

            //solver.AddRule((BoolExpr)store_inst[ctx.MkInt(x), ctx.MkInt(f), ctx.MkInt(y)]);
        }

        // x = y.f
        public void AddLoadConstraint(string x_str, string y_str, string f_str)
        {
            int x = GetIdentifier(x_str);
            int y = GetIdentifier(y_str);
            int f = GetIdentifier(f_str);

            IntExpr s1 = (IntExpr)ctx.MkBound(4, Int);
            IntExpr s2 = (IntExpr)ctx.MkBound(5, Int);

            if (x_str.StartsWith("cseTmp")) solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, ctx.MkInt(y)], (BoolExpr)fpt[s2, s1, ctx.MkInt(f)], (BoolExpr)non_null_pt[s2]), (BoolExpr)pt[s2, ctx.MkInt(x)]));
            else solver.AddRule(ctx.MkImplies(ctx.MkAnd((BoolExpr)pt[s1, ctx.MkInt(y)], (BoolExpr)fpt[s2, s1, ctx.MkInt(f)]), (BoolExpr)pt[s2, ctx.MkInt(x)]));

            //if (x_str.StartsWith("cseTmp")) solver.AddRule((BoolExpr)cse_load_inst[ctx.MkInt(x), ctx.MkInt(y), ctx.MkInt(f)]);
            //else solver.AddRule((BoolExpr)load_inst[ctx.MkInt(x), ctx.MkInt(y), ctx.MkInt(f)]);
        }

        public Dictionary<string, HashSet<string>> GetPointsToData()
        {
            var PointsTo = new Dictionary<string, HashSet<string>>();

            foreach (string str in string2identifier.Keys)
            {
                PointsTo.Add(str, new HashSet<string>());

                int x = string2identifier[str];
                int s, s1, s2;
                for (s = 0 ; s < alloc_counter ; s++)
                {
                    Console.WriteLine("Solving if {0} belongs to pt({1})", "allocSite" + s.ToString(), str);
                    Status stat = solver.Query((BoolExpr)pt[ctx.MkInt(s), ctx.MkInt(x)]);
                    if (stat.ToString().Equals("SATISFIABLE")) PointsTo[str].Add("allocSite" + s.ToString());
                    Console.WriteLine("Done!");
                }

                for (s1 = 0; s1 < alloc_counter; s1++)
                {
                    var of = GetODotf("allocSite" + s1.ToString(), str);
                    PointsTo.Add(of, new HashSet<string>());
                    for (s2 = 0 ; s2 < alloc_counter ; s2++)
                    {
                        Console.WriteLine("Solving if {0} belongs to pt({1}.{2})", "allocSite" + s2.ToString(), "allocSite" + s1.ToString(), str);
                        Status stat = solver.Query((BoolExpr)fpt[ctx.MkInt(s2), ctx.MkInt(s1), ctx.MkInt(x)]);
                        if (stat.ToString().Equals("SATISFIABLE")) PointsTo[of].Add("allocSite" + s2.ToString());
                        Console.WriteLine("Done!");
                    }
                }
            }
            
            return PointsTo;
        }

        // o.f -> allocConstruct$o$f
        private string GetODotf(string o, string f)
        {
            return "allocConstruct$" + o + "$" + f;
        }
    }
}
