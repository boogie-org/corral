using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;
using System.IO;

namespace pminbench
{
    class Driver
    {
        static string corralExe = null;
        static string proofMinExe = null;
        static string proofbench = "proofbench";

        static void Main(string[] args)
        {
            // Initialize
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // Find necessary files
            if (!LocateFiles())
                return;

            var files = new HashSet<string>();
            var pminargs = "";

            foreach (var arg in args)
            {
                if (arg == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }

                if (arg.StartsWith("/"))
                {
                    pminargs += arg + " ";
                    continue;
                }

                // Fetch file names
                var fname = System.IO.Path.GetFileName(arg);
                var dirname = System.IO.Path.GetDirectoryName(arg);
                if (dirname == "") dirname = ".";
                files.UnionWith(System.IO.Directory.GetFiles(dirname, fname));
            }

            // create proofbench directory
            if (!Directory.Exists(proofbench))
                Directory.CreateDirectory(proofbench);
            else
                Util.CleanDirectory(proofbench);

            // Run duality, get proofs
            var cnt = 0;
            foreach (var file in files)
            {
                var proof = RunDuality(file);
                if (proof == null) continue;
                BoogieUtil.PrintProgram(proof, Path.Combine(proofbench, string.Format("pf{0}.bpl", cnt++)));
            }

            Console.WriteLine("Obtained {0} proofs", cnt);
            Console.WriteLine("Running Proof Minimization");

            var res =
                Util.run(Environment.CurrentDirectory, proofMinExe, string.Format("{0} {1} /perf", Path.Combine(proofbench, "*.bpl"), pminargs));
            File.WriteAllLines("proofmin_out.txt", res);

            var templates = ParseOutput(res);

            Console.WriteLine("Inferred annotations: ");
            templates.Iter(t => Console.WriteLine("  {0}", t));
        }

        public static List<string> ParseOutput(List<string> output)
        {
            var ret = new List<string>();
            var tok = "Additional contract required: ";
            foreach (var s in output)
            {
                if (!s.StartsWith(tok)) continue;
                ret.Add(s.Substring(tok.Length).Replace("{:loop} ", ""));
            }
            return ret;
        }

        static bool LocateFiles()
        {
            var runDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            corralExe = Path.Combine(runDir, "corral.exe");
            proofMinExe = Path.Combine(runDir, "ProofMinimization.exe");

            if (!File.Exists(corralExe))
            {
                Console.WriteLine("Error: corral.exe not found");
                return false;
            }

            if (!File.Exists(proofMinExe))
            {
                proofMinExe = Path.Combine(runDir, "..", "ProofMin", "ProofMinimization.exe");
                if (!File.Exists(proofMinExe))
                {
                    Console.WriteLine("Error: ProofMinimization.exe not found");
                    return false;
                }
            }

            return true;
        }

        static VerifierOutput RunCorral(string file)
        {
            var ret = new VerifierOutput();

            return ret;
        }

        static Program RunDuality(string file)
        {
            Console.WriteLine("Running Duality on {0}", file);

            File.Delete("pm_corral_houd.bpl");
            File.Delete("duality_fp.bpl");

            var res =
                Util.run(Environment.CurrentDirectory, corralExe, string.Format("{0} /trackAllVars /runHoudini /useDuality /bopt:printFixedPoint:duality_fp.bpl /printHoudiniQuery:corral_houd.bpl /recursionBound:10000 /disableStaticAnalysis", file));

            if (!File.Exists("pm_corral_houd.bpl") || !File.Exists("duality_fp.bpl"))
            {
                Console.WriteLine("Proof not found");
                return null;
            }

            var program = BoogieUtil.ReadAndOnlyResolve("pm_corral_houd.bpl");
            program = InjectDualityProof(program, "duality_fp.bpl");

            return program;
        }

        public static Program InjectDualityProof(Program program, string DualityProofFile)
        {
            Program DualityProof;

            using (var st = new System.IO.StreamReader(DualityProofFile))
            {
                var s = ParserHelper.Fill(st, new List<string>());
                // replace %i by bound_var_i
                for (int i = 0; i <= 9; i++)
                {
                    s = s.Replace(string.Format("%{0}", i), string.Format("pm_bv_{0}", i));
                }
                var v = Parser.Parse(s, DualityProofFile, out DualityProof);
                if (v != 0) throw new Exception("Failed to parse " + DualityProofFile);
            }


            var implToContracts = new Dictionary<string, List<Expr>>();
            foreach (var proc in DualityProof.TopLevelDeclarations.OfType<Procedure>())
            {
                implToContracts.Add(proc.Name, new List<Expr>());
                foreach (var ens in proc.Ensures)
                {
                    implToContracts[proc.Name].AddRange(GetExprConjunctions(ens.Condition));
                }
            }

            var counter = 0;
            var GetExistentialConstant = new Func<Constant>(() =>
            {
                var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                    "DualityProofConst" + (counter++), Microsoft.Boogie.Type.Bool), false);
                c.AddAttribute("existential");
                return c;
            });

            var constsToAdd = new List<Declaration>();
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                if (!implToContracts.ContainsKey(proc.Name))
                    continue;
                if (QKeyValue.FindBoolAttribute(proc.Attributes, "nohoudini"))
                    continue;

                foreach (var expr in implToContracts[proc.Name])
                {
                    var c = GetExistentialConstant();
                    constsToAdd.Add(c);
                    proc.Ensures.Add(new Ensures(false,
                        Expr.Imp(Expr.Ident(c), expr)));
                }
            }

            program.AddTopLevelDeclarations(constsToAdd);

            return program;
        }

        public static List<Expr> GetExprConjunctions(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.And);
        }

        public static List<Expr> GetExprDisjuncts(Expr expr)
        {
            return GetSubExprs(expr, BinaryOperator.Opcode.Or);
        }

        // Return the set of conjuncts of the expr
        public static List<Expr> GetSubExprs(Expr expr, BinaryOperator.Opcode op)
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

    }

    class VerifierOutput
    {
        public Program proof;
        public BoogieVerify.ReturnStatus status;

        public VerifierOutput()
        {
            proof = null;
            status = BoogieVerify.ReturnStatus.NOK;
        }
    }
}
