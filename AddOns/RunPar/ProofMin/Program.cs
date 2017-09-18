using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Runtime.Serialization;
using System.Threading;
using Microsoft.Boogie.VCExprAST;
using System.Diagnostics;
using System.ComponentModel;
using System.Xml.Serialization;
using System.IO;

namespace ProofMin
{
    class Driver
    {
        public class CompileException : Exception
        {
            public CompileException(string s)
                : base(s)
            {
            }
        }

        // Global flags
        public static bool useStubs = false;
        public static bool debugging = false;
        public static bool noHoudini = false;

        public static List<string> flags = new List<string>();
        public static List<string> ProofMinflags = new List<string>();
        public static string bplfile = "";

        // Static data
        static string wlimitexe = "";
        static string corralexe = "";
        static string proofminexe = "";
        static string iz3exe = "";
        static string z3exe = "";
        static int timeout = 7200;

        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: proofmin file.[c|bpl]");
                return;
            }

            ProcessArg(args);

            var files = CommonLib.Util.GetFilesForUnion(args);
            if (files != null)
            {
                // merge corral output
                var cat = new List<string>();
                foreach (var file in files)
                {
                    cat.AddRange(System.IO.File.ReadAllLines(file));
                    cat.Add("=========");
                }
                System.IO.File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, cat);
                return;
            }

            try
            {
                // Set up Boogie
                CommandLineOptions.Install(new CommandLineOptions());
                CommandLineOptions.Clo.PrintInstrumented = true;

                // Set up corral, duality
                var root = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
                wlimitexe = Path.Combine(root, "wlimit.exe");
                corralexe = Path.Combine(root, "..", "corral", "corral.exe");
                proofminexe = Path.Combine(root, "..", "corral", "proofminimization.exe");
                z3exe = Path.Combine(root, "..", "corral", "z3.exe");
                iz3exe = Path.Combine(root, "..", "iz3", "z3.exe");

                runGenerator();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        static void runGenerator()
        {
            var sw = new System.Diagnostics.Stopwatch();
            sw.Start();

            if (noHoudini)
            {
                var nfile = "noh_file.bpl";
                removeTemplates(bplfile, nfile);
                flags.RemoveAll(s => s == bplfile);
                flags.Add(nfile);
            }

            // Run corral, get houdini query and duality proof
            var corralflags = flags.Concat(" ");
            corralflags += " /printHoudiniQuery:a.bpl /bopt:printFixedPoint:b.bpl /useDuality  /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 " + string.Format(" /bopt:z3exe:{0} ", iz3exe);


            //output.WriteLine("Running {0} /w {1} /m {2} {3} {4}", wlimitexe, timeout, memout, corralexe, corralflags.Concat(" "));
            //output.Flush();

            var result =
                CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} /m {1} {2} {3}", timeout, 2500, corralexe, corralflags));

            if (CommonLib.Util.CorralOutcomeHasBugs(result))
            {
                result.Add("Corral reported bugs, skipping this program");
                Console.WriteLine("{0}", sw.Elapsed.TotalSeconds.ToString("F2"));
                File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, result);
                return;
            }

            var refinements = CommonLib.Util.CorralNumRefinements(result);
            var tv = CommonLib.Util.CorralFinalTrackedVars(result);

            if (refinements > 1)
            {
                result.Add("Refinements reported, rerunning corral");

                foreach (var v in tv)
                    corralflags += string.Format(" /track:{0}", v);

                var resultPrime =
                    CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} /m {1} {2} {3}", timeout, 2500, corralexe, corralflags));

                if (CommonLib.Util.CorralOutcomeHasBugs(resultPrime) || CommonLib.Util.CorralNumRefinements(resultPrime) != 1)
                {
                    result.AddRange(resultPrime);
                    result.Add("Corral reported bugs or more refinements, skipping this program");
                    Console.WriteLine("{0}", sw.Elapsed.TotalSeconds.ToString("F2"));
                    File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, result);
                    return;
                }

                result.AddRange(resultPrime);
            }

            Console.WriteLine("{0}", sw.Elapsed.TotalSeconds.ToString("F2"));

            if (!File.Exists("pm_a.bpl") || !File.Exists("b.bpl"))
            {
                result.Add("Corral did not produce the required files, skipping");
                File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, result);
                return;
            }

            // ProofMin
            //var result2 =
            //    CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
            //    string.Format("/w {0} /m {1} {2} {3}", timeout, 2500, proofminexe, " pm_a.bpl /duality:b.bpl /keep:CIC* /perf " + ProofMinflags.Concat(" ")));            

            var program = InjectDualityProof(ParseProgram("pm_a.bpl"), "b.bpl");

            result.AddRange(
                WriteProgram(program, Path.GetFileName(bplfile)));
            result.Add("WriteProgram done");

            File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, result);
        }

        static void removeTemplates(string file, string outfile)
        {
            var program = ParseProgram(file);
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>().Where(p => QKeyValue.FindBoolAttribute(p.Attributes, "template")))
            {
                proc.Ensures.RemoveAll(ens => !ens.Free);
            }

            var sw = new StreamWriter(outfile, false);
            var tw = new TokenTextWriter(sw);
            program.Emit(tw);
            sw.Close();
            tw.Close();
        }

        static IEnumerable<string> WriteProgram(Program program, string infile)
        {
            var cd = System.Environment.CurrentDirectory;
            var ret = new List<string>();

            var result_dir = @"f:\tmp\pmin";
            if (!System.IO.Directory.Exists(result_dir))
            {
                result_dir = @"d:\tmp\pmin";
                if (!System.IO.Directory.Exists(result_dir))
                {
                    ret.Add("Result directory not found");
                    return ret;
                }
            }

            var trypath = "";
            var cnt = 0;

            while (true)
            {
                trypath = Path.Combine(result_dir, infile.Replace(".bpl", string.Format("_pm_{0}.bpl", cnt)));
                ret.Add(string.Format("Trying file name {0}", trypath));

                if (System.IO.File.Exists(trypath))
                {
                    cnt++;
                    continue;
                }

                StreamWriter sw;

                try
                {
                    sw = new StreamWriter(trypath, false);
                    var tw = new TokenTextWriter(sw);
                    program.Emit(tw);
                    sw.Close();
                    tw.Close();
                }
                catch (System.IO.IOException)
                {
                    continue;
                }

                break;
            }

            ret.Add(string.Format("File written: {0}", trypath));

            System.IO.StreamWriter mapFile = null;

            while (mapFile == null)
            {
                try
                {
                    mapFile = new System.IO.StreamWriter(result_dir + "\\file_map.txt", true);
                }
                catch (System.IO.IOException)
                {
                    mapFile = null;
                    System.Threading.Thread.Sleep(10);
                }
            }

            mapFile.WriteLine(Path.GetFileName(trypath) + "\t" + infile);
            mapFile.Close();

            ret.Add(string.Format("Written to file_map as well"));
            return ret;
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

            program.TopLevelDeclarations.AddRange(constsToAdd);

            return program;
        }

        public static Program ParseProgram(string f)
        {
            Program p = new Program();

            try
            {
                if (Parser.Parse(f, new List<string>(), out p) != 0)
                {
                    Console.WriteLine("Failed to read " + f);
                    return null;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return null;
            }
            return p;
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

        static void ProcessArg(string[] args)
        {
            foreach (var arg in args)
            {
                if (arg.StartsWith("/remove:runHoudini"))
                {
                    noHoudini = true;
                    continue;
                }

                if (arg == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }

                if (arg == "/debug")
                {
                    debugging = true;
                    continue;
                }

                if (arg.StartsWith("/timeout:"))
                {
                    var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                    timeout = Int32.Parse(sp[1]);
                    continue;
                }

                if (arg.StartsWith("/popt:"))
                {
                    ProofMinflags.Add("/" + arg.Substring("/popt:".Length));
                    continue;
                }

                if (arg.EndsWith(".bpl"))
                {
                    bplfile = arg;
                    flags.Add(arg);
                    continue;
                }

                flags.Add(arg);
            }
        }
    }

    public static class Stats
    {
        private static List<DateTime> beginTimes = new List<DateTime>();

        public static void beginTime()
        {
            beginTimes.Add(DateTime.Now);
        }

        public static void endTime(ref TimeSpan counter)
        {
            counter += (DateTime.Now - beginTimes.Last());
            beginTimes.RemoveAt(beginTimes.Count - 1);
        }

        public static void endTime(string output)
        {
            var t = (DateTime.Now - beginTimes.Last());
            Console.WriteLine("{0}: {1} s", output, t.TotalSeconds);
            beginTimes.RemoveAt(beginTimes.Count - 1);
        }
    }

    class NotApplicable : Exception { }


}
