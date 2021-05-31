using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;
using Microsoft.Boogie;
using System.Diagnostics;

namespace ProofMinTrain
{
    class Driver
    {
        // Root folder of where the training files are located
        public static string BenchBaseDir = @"d:\pmin";
        public static readonly string BenchBaseDirNoHoudini = @"d:\pmin_nohoudini";
        // ProofMin.exe location
        public static string ProofMinExe = @"d:\train\corral\proofminimization.exe";
        // Where the training benchmarks are setup (for RunParServer)
        public static readonly string TrainRootDir = @"d:\train";
        // RunParServer.exe
        public static readonly string RunParServerExe = @"c:\users\akashl\documents\work\rse\cba\runpar\binaries\runparserver.exe";
        // Config file for running on test data
        public static readonly string RunParConfigFile = @"d:\train\train-config.xml";
        // Base results files
        public static readonly string BaseResultsFile = @"d:\train\base-results.txt";

        public static bool OnlyDuality = false;
        public static string ProofMinArgs = "";
        public static int sampleFraction = 0;

        public static Dictionary<string, List<string>> templates = new Dictionary<string, List<string>>();
        public static List<string> ConsoleOutput = new List<string>();
        public static List<WorkItem> work = new List<WorkItem>();
        public static volatile bool abort = false;
        public static bool allowMemTemplates = false;

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");
            abort = true;
            lock (CommonLib.Util.SpawnedProcesses)
            {
                foreach (var p in CommonLib.Util.SpawnedProcesses)
                    p.Kill();
                CommonLib.Util.SpawnedProcesses.Clear();
            }
            File.WriteAllLines("train-result.txt", ConsoleOutput);
        }

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("ProofMinTrain.exe rule1 rule2 ... /sample:p [/ProofMinOptions]");
                return;
            }

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // Read command-line flags

            var rules = new HashSet<string>();
            var pminFlags = new List<string>();
            var test = false;
            
            Dictionary<string, List<string>> intemplates = null; // user-provided templates
            Dictionary<string, HashSet<string>> insampledfiles = null; // user-provided files
            var nrules = new HashSet<string>(); // rules to avoid
            foreach (var arg in args)
            {
                if (arg.StartsWith("/sample:"))
                {
                    sampleFraction = Int32.Parse(arg.Substring("/sample:".Length));
                    continue;
                }

                if (arg == "/onlyDuality")
                {
                    ProofMinArgs += "/keep:CIC ";
                    OnlyDuality = true;
                    continue;
                }

                if (arg == "/baseNoHoudini")
                {
                    BenchBaseDir = BenchBaseDirNoHoudini;
                    continue;
                }

                if (arg.StartsWith("/basedir:"))
                {
                    BenchBaseDir = arg.Substring("/basedir:".Length);
                    continue;
                }

                if (arg.StartsWith("/pmin:"))
                {
                    ProofMinExe = arg.Substring("/pmin:".Length);
                    continue;
                }

                if (arg == "/test")
                {
                    test = true;
                    continue;
                }

                if (arg == "/allowMemTemplates")
                {
                    allowMemTemplates = true;
                    continue;
                }

                if (arg.StartsWith("/wo:"))
                {
                    nrules.Add(arg.Substring("/wo:".Length));
                    continue;
                }

                if (arg.StartsWith("/templates:"))
                {
                    intemplates = new Dictionary<string, List<string>>();
                    insampledfiles = new Dictionary<string, HashSet<string>>();
                    var lines = System.IO.File.ReadAllLines(arg.Substring("/templates:".Length)).ToList();

                    string rule = null;
                    foreach (var line in lines)
                    {
                        if (line.StartsWith("Rule:"))
                        {
                            var tok = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                            rule = tok.Last();

                            intemplates.Add(rule, new List<string>());
                            insampledfiles.Add(rule, new HashSet<string>());
                        }
                        else if (line.StartsWith("File:"))
                        {
                            Debug.Assert(rule != null);
                            var tok = line.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                            insampledfiles[rule].Add(tok.Last());
                        }
                        else
                        {
                            Debug.Assert(rule != null);
                            intemplates[rule].Add(line);
                        }
                    }

                    if (intemplates.Values.Any(ls => ls.Any(t => !CheckSanity(t))))
                    {
                        return;
                    }

                    continue;
                }

                if (arg == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }

                if (arg.StartsWith("/"))
                {
                    ProofMinArgs += arg + " ";
                    continue;
                }

                rules.UnionWith(
                    Directory.GetDirectories(BenchBaseDir, arg).Select(d => Path.GetFileName(d)));

            }

            Console.WriteLine("BenchBaseDir: {0}", BenchBaseDir);
            if (Environment.CurrentDirectory.ToLower().StartsWith(BenchBaseDir.ToLower()))
            {
                Console.WriteLine("Cannot start process from within the BenchBase directory");
                return;
            }

            if (intemplates != null && !test)
            {
                Console.WriteLine("Error: Templates can only be provided in /test mode");
                return;
            }

            // Are all rules available?

            var allrules = new HashSet<string>(
                Directory.GetDirectories(BenchBaseDir).Select(d => Path.GetFileName(d)));

            var invalid = new HashSet<string>(rules);
            invalid.ExceptWith(allrules);

            foreach (var r in invalid)
                Console.WriteLine("Warning: Rule {0} not valid", r);

            rules.ExceptWith(invalid);
            rules.ExceptWith(nrules);

            if(intemplates != null) rules.IntersectWith(intemplates.Keys);

            // rule -> all driver files used for training
            var sampledfiles = new Dictionary<string, HashSet<string>>();

            foreach (var rule in rules)
            {
                sampledfiles.Add(rule, new HashSet<string>());
                if (insampledfiles != null && insampledfiles.ContainsKey(rule))
                    sampledfiles[rule].UnionWith(insampledfiles[rule]);

                if (!Directory.Exists(Path.Combine(BenchBaseDir, rule, "rts")))
                {
                    Console.WriteLine("Skipping rule {0} because no RTS files found", rule);
                    continue;
                }

                // select all rts files
                var files = new HashSet<string>();
                files.UnionWith(
                    Directory.GetFiles(Path.Combine(BenchBaseDir, rule, "rts"), "*.bpl"));

                if (Directory.Exists(Path.Combine(BenchBaseDir, rule, "drivers")))
                {
                    // sample the driver files
                    var driverfiles = new List<string>(
                        Directory.GetFiles(Path.Combine(BenchBaseDir, rule, "drivers"), "*.bpl"));
                    Shuffle(driverfiles);

                    var len = (driverfiles.Count * sampleFraction) / 100;
                    for (int i = 0; i < len; i++)
                        sampledfiles[rule].Add(driverfiles[i]);
                }

                files.UnionWith(sampledfiles[rule]);

                Console.WriteLine("WorkItem created for rule {0} with {1} files", rule, files.Count);

                work.Add(new WorkItem(rule, files, sampledfiles[rule]));
            }

            if (intemplates == null)
            {
                var threads = new List<Thread>();

                for (int i = 0; i < Environment.ProcessorCount; i++)
                {
                    var w = new Worker();
                    threads.Add(new Thread(new ThreadStart(w.Run)));
                }

                threads.ForEach(t => t.Start());
                threads.ForEach(t => t.Join());

                File.WriteAllLines("train-result.txt", ConsoleOutput);
            }
            else
            {
                Driver.templates = intemplates;
            }

            if (test)
                Test(rules, sampledfiles);
        }

        static bool CheckSanity(string template)
        {
            if (!allowMemTemplates && template.Contains("Mem_T."))
            {
                Console.WriteLine("Error: annotation contains memory map: {0}", template);
                return false;
            }

            if (!allowMemTemplates && template.Contains("li2bplFunctionConstant"))
            {
                Console.WriteLine("Error: annotation contains li2bplFunctionConstant: {0}", template);
                return false;
            }

            if (template.Contains("forall") || template.Contains("exists"))
            {
                Console.WriteLine("Error: annotation contains quantifier: {0}", template);
                return false;
            }

            var tvars = new string[] { "v_fin_int", "v_fout_int", "v_loop_int" };

            for (int i = 9; i >= 1; i--)
            {
                for (int j = 0; j < tvars.Length; j++)
                {
                    if (template.Contains(tvars[j] + "_" + i.ToString()))
                    {
                        Console.WriteLine("Error: annotation contains too many template variables: {0}", template);
                        return false;
                    }
                }

            }

            var hasNumberedVars = false;
            for (int j = 0; j < tvars.Length; j++)
            {
                if (template.Contains(tvars[j] + "_0"))
                {
                    hasNumberedVars = true;
                    break;
                }
            }

            if (!hasNumberedVars)
            {
                if (template.Split(tvars, StringSplitOptions.None).Length > 2)
                {
                    Console.WriteLine("Error: annotation contains too many template variables: {0}", template);
                    return false; 
                }

            }

            return true;
        }

        static void Test(HashSet<string> rules, Dictionary<string, HashSet<string>> sampledFiles)
        {
            // driver file map
            var driver_file_map = GetFileMap(Path.Combine(TrainRootDir, "data", "drivers", "file_map.txt"));

            // pm file -> driver file
            var pm_map = new Dictionary<string, string>();
            var pm_map_lines = File.ReadAllLines(Path.Combine(BenchBaseDir, "drivers_file_map.txt"));
            foreach (var line in pm_map_lines)
            {
                var tok = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                if (tok.Length != 2) continue;
                pm_map.Add(tok[0], tok[1]);
            }

            // directory to stash all the files, with new templates
            var filedir = Path.Combine(TrainRootDir, "data", "pmin");

            if (!Directory.Exists(filedir))
                Directory.CreateDirectory(filedir);
            else
                CommonLib.Util.CleanDirectory(filedir);

            // Apply templates
            foreach (var rule in rules)
            {
                if (!driver_file_map.ContainsKey(rule))
                    driver_file_map.Add(rule, new HashSet<string>());
                if (!Driver.templates.ContainsKey(rule))
                    Driver.templates.Add(rule, new List<string>());

                var sampled_driver_files = new HashSet<string>(sampledFiles[rule].Select(f => pm_map[Path.GetFileName(f)]));
                var driver_files = new HashSet<string>(driver_file_map[rule]);
                driver_files.ExceptWith(sampled_driver_files);

                ApplyTemplates(Driver.templates[rule], driver_files, rule, filedir);
            }

            File.Copy(Path.Combine(TrainRootDir, "data", "drivers", "file_map.txt"), Path.Combine(filedir, "file_map.txt"));

            // Run Corral
            Console.WriteLine("Running RunParServer");

            var output =
               CommonLib.Util.run(TrainRootDir, RunParServerExe, RunParConfigFile);

            output.ForEach(s => Console.WriteLine("{0}", s));

            var baseResults = ParseResultsFile(BaseResultsFile);
            var currResults = ParseResultsFile(Path.Combine(TrainRootDir, "results.txt"));

            // merge results
            var mergedResults = new Dictionary<string, string>();
            foreach (var tup in currResults)
            {
                if (!baseResults.ContainsKey(tup.Key))
                {
                    Console.WriteLine("Warning: did not find base results for {0}", tup.Key);
                    continue;
                }
                mergedResults.Add(tup.Key, baseResults[tup.Key] + tup.Value);
            }

            // Dump results
            File.WriteAllLines("test-results.txt", 
                mergedResults.Select(tup => tup.Key + "\t" + tup.Value));
        }

        // rule -> all files of that rule
        static Dictionary<string, HashSet<string>> GetFileMap(string file)
        {
            var lines = File.ReadAllLines(file);
            var ret = new Dictionary<string, HashSet<string>>();
            foreach (var tok in lines.Select(line => line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries)))
            {
                if (tok.Length < 2) continue;
                if (!ret.ContainsKey(tok[2]))
                    ret.Add(tok[2], new HashSet<string>());

                ret[tok[2]].Add(Path.GetFileName(tok[0]));
            }
            return ret;
        }

        static Dictionary<string, string> ParseResultsFile(string file)
        {
            var baseResults = new Dictionary<string, string>();
            if (File.Exists(file))
            {
                var lines = File.ReadAllLines(file);
                foreach (var line in lines)
                {
                    var tok = line.Split(new char[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                    var res = "";
                    for (int i = 1; i < tok.Length; i++) res += tok[i] + "\t";
                    baseResults.Add(Path.GetFileName(tok[0]), res);
                }
            }
            return baseResults;
        }

        static void ApplyTemplates(IEnumerable<string> templates, IEnumerable<string> driver_files, string rule, string filedir)
        {
            foreach (var f in driver_files)
            {
                AddTemplates(templates, Path.Combine(TrainRootDir, "data", "drivers", f), Path.Combine(filedir, f));
            }

            Console.WriteLine("For rule {0}, {1} files added to directory {2}", rule, driver_files.Count(), filedir);
        }

        static void AddTemplates(IEnumerable<string> templates, string infile, string outfile)
        {
            var program = BoogieUtil.ParseProgram(infile);
            var tproc = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => QKeyValue.FindBoolAttribute(p.Attributes, "template"))
                .FirstOrDefault();
            var globals = new HashSet<string>(program.TopLevelDeclarations.OfType<Variable>().Select(v => v.Name));

            Debug.Assert(tproc != null);

            if (!Driver.OnlyDuality)
            {
                tproc.Ensures.RemoveAll(ens => !ens.Free);
            }

            foreach (var t in templates)
            {
                var aexpr = ToAnnotatedExpr(t);

                // Make sure all globals are present in the file
                var gv = new GatherVariables();
                gv.VisitExpr(aexpr.Item2);
                var vars = new HashSet<string>(gv.variables);
                vars.RemoveWhere(v => v.StartsWith("v_fin_int") || v.StartsWith("v_fout_int") || v.StartsWith("v_loop_int"));
                if (!vars.IsSubsetOf(globals)) continue;

                // special support
                if (QKeyValue.FindBoolAttribute(aexpr.Item1, "irql") && 
                    (aexpr.Item2.ToString() == "v_fin_int == v_fout_int" || aexpr.Item2.ToString() == "v_fout_int == v_fin_int"))
                {
                    AddIrql(tproc, program);
                    continue;
                }

                var annotationStr = "";
                if (aexpr.Item1 != null)
                {
                    var sw = new StringWriter();
                    aexpr.Item1.Emit(new TokenTextWriter(sw));
                    sw.Close();
                    annotationStr = sw.ToString();
                }

                var newt = MakeUniqueTemplateVariables.Rewrite(aexpr.Item2);
                var tstr = newt.ToString();
                tproc.Ensures.Add(ToEnsures(annotationStr + " " + FindAnnotations(tstr), tstr));
            }

            program.TopLevelDeclarations.AddRange(MakeUniqueTemplateVariables.template_var_in.Values);
            program.TopLevelDeclarations.AddRange(MakeUniqueTemplateVariables.template_var_out.Values);
            program.TopLevelDeclarations.AddRange(MakeUniqueTemplateVariables.template_var_loop.Values);

            BoogieUtil.PrintProgram(program, outfile);
        }

        static void AddIrql(Procedure proc, Program program)
        {
            var v1 = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "pm_loop_loc", Microsoft.Boogie.Type.Int));
            v1.AddAttribute("template");
            v1.AddAttribute("includeLoopLocals");

            proc.Ensures.Add(new Ensures(false, Expr.Eq(Expr.Ident(v1), new OldExpr(Token.NoToken, Expr.Ident(v1)))));
            program.TopLevelDeclarations.Add(v1);
        }

        static Tuple<QKeyValue, Expr> ToAnnotatedExpr(string str)
        {
            var ens = ToEnsures("", str);
            return Tuple.Create(ens.Attributes, ens.Condition);
        }

        static Expr ToExpr(string str)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0};", str);
            Parser.Parse(programText, "dummy.bpl", out program);

            // get variables
            var gv = (new GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);
            // resolve
            program.Resolve();

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First().Condition;
        }

        static Ensures ToEnsures(string annotations, string expr)
        {
            Program program;

            // parse str as an unresolved expr
            var programText = string.Format("procedure foo(); ensures {0} {1};", annotations, expr);
            if (Parser.Parse(programText, "dummy.bpl", out program) != 0)
            {
                Console.WriteLine("Failed at {0} {1}", annotations, expr);
            }

            // get variables
            var gv = (new GatherVariables());
            gv.Visit(program);
            foreach (var v in gv.variables)
            {
                programText += Environment.NewLine + string.Format("var {0}: int;", v);
            }

            // try parsing again
            Parser.Parse(programText, "dummy.bpl", out program);
            // resolve
            program.Resolve();

            return program.TopLevelDeclarations.OfType<Procedure>()
                .First().Ensures.First();
        }

        static string FindAnnotations(string predicate)
        {
            var expr = ToExpr(predicate);
            var ret = "";

            // Get variables used in the expr
            var variables = new HashSet<Variable>();
            var vu = new GatherNonOldVariables();
            vu.VisitExpr(expr);

            foreach (var v in vu.variables)
            {
                if (v.StartsWith("pm_tvar_"))
                    continue;
                if (v.StartsWith("SLAM_guard") && v.EndsWith("_init"))
                    continue;

                ret += string.Format(" {{:mustmod \"{0}\" }}", v);
            }

            return ret;
        }

        private static Random rng = new Random();  

        static void Shuffle(List<string> ls)
        {
            int n = ls.Count;
            while (n > 1)
            {
                n--;
                int k = rng.Next(n + 1);
                var value = ls[k];
                ls[k] = ls[n];
                ls[n] = value;
            }  
        }
    }

    // v_fin_in + v_fin_int --> v_fin_int_1 + v_fin_int_2
    public class MakeUniqueTemplateVariables : StandardVisitor
    {
        public static readonly string formalin = "v_fin_int";
        public static readonly string formalout = "v_fout_int";
        public static readonly string looploc = "v_loop_int";
        public static Dictionary<int, GlobalVariable> template_var_in = new Dictionary<int, GlobalVariable>();
        public static Dictionary<int, GlobalVariable> template_var_out = new Dictionary<int, GlobalVariable>();
        public static Dictionary<int, GlobalVariable> template_var_loop = new Dictionary<int, GlobalVariable>();

        int curr_count_in;
        int curr_count_out;
        int curr_count_loop;

        private MakeUniqueTemplateVariables()
        {
            curr_count_in = 10;
            curr_count_out = 10;
            curr_count_loop = 10;
        }

        public static Expr Rewrite(Expr expr)
        {
            var mu = new MakeUniqueTemplateVariables();
            return mu.VisitExpr(expr);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Name.StartsWith(formalin))
            {
                if (node.Name == formalin)
                {
                    var tv = CreateFormalIn(curr_count_in);
                    curr_count_in++;
                    return Expr.Ident(tv);
                }
                else
                {
                    var cnt = 0;
                    if (Int32.TryParse(node.Name.Substring(formalin.Length + 1), out cnt))
                    {
                        return Expr.Ident(CreateFormalIn(cnt));
                    }
                    return node;
                }                
            }

            if (node.Name.StartsWith(formalout))
            {
                if (node.Name == formalout)
                {
                    var tv = CreateFormalOut(curr_count_out);
                    curr_count_out++;
                    return Expr.Ident(tv);
                }
                else
                {
                    var cnt = 0;
                    if (Int32.TryParse(node.Name.Substring(formalout.Length + 1), out cnt))
                    {
                        return Expr.Ident(CreateFormalOut(cnt));
                    }
                    return node;
                }
            }

            if (node.Name.StartsWith(looploc))
            {
                if (node.Name == looploc)
                {
                    var tv = CreateLoopVar(curr_count_loop);
                    curr_count_loop++;
                    return Expr.Ident(tv);
                }
                else
                {
                    var cnt = 0;
                    if (Int32.TryParse(node.Name.Substring(looploc.Length + 1), out cnt))
                    {
                        return Expr.Ident(CreateLoopVar(cnt));
                    }
                    return node;
                }
            }

            return node;
        }

        Variable CreateFormalIn(int cnt)
        {
            if (!template_var_in.ContainsKey(cnt))
            {
                var nvar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "pm_tvar_in_" + (cnt).ToString(),
                    Microsoft.Boogie.Type.Int));
                nvar.AddAttribute("template");
                nvar.AddAttribute("includeFormalIn");
                template_var_in.Add(cnt, nvar);
            }

            return template_var_in[cnt];
        }
        Variable CreateFormalOut(int cnt)
        {
            if (!template_var_out.ContainsKey(cnt))
            {
                var nvar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "pm_tvar_out_" + (cnt).ToString(),
                    Microsoft.Boogie.Type.Int));
                nvar.AddAttribute("template");
                nvar.AddAttribute("includeFormalOut");
                template_var_out.Add(cnt, nvar);
            }

            return template_var_out[cnt];
        }
        Variable CreateLoopVar(int cnt)
        {
            if (!template_var_loop.ContainsKey(cnt))
            {
                var nvar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "pm_tvar_loop_" + (cnt).ToString(),
                    Microsoft.Boogie.Type.Int));
                nvar.AddAttribute("template");
                nvar.AddAttribute("includeLoopLocals");
                template_var_loop.Add(cnt, nvar);
            }

            return template_var_loop[cnt];
        }
    }

    // Gather variables in an unresolved program
    public class GatherVariables : StandardVisitor
    {
        public HashSet<string> variables;

        public GatherVariables()
        {
            variables = new HashSet<string>();
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            variables.Add(node.Name);
            return node;
        }
    }


    // Gather variables that don't appear inside old
    public class GatherNonOldVariables : StandardVisitor
    {
        public HashSet<string> variables;

        public GatherNonOldVariables()
        {
            variables = new HashSet<string>();
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            return node;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            variables.Add(node.Name);
            return node;
        }

        public override Variable VisitVariable(Variable node)
        {
            variables.Add(node.Name);
            return node;
        }

    }


    class WorkItem
    {
        public string rule;
        public IEnumerable<string> files;
        public IEnumerable<string> driverfiles;

        public WorkItem(string rule, IEnumerable<string> files, IEnumerable<string> driverfiles)
        {
            this.rule = rule;
            this.files = files;
            this.driverfiles = driverfiles;
        }
    }

    class Worker
    {
        public Worker()
        {
        }

        public void Run()
        {

            while (true)
            {
                WorkItem wi = null;

                if (Driver.abort)
                    return;

                lock (Driver.work)
                {
                    if (Driver.work.Count == 0) return;
                    wi = Driver.work[0];
                    Driver.work.RemoveAt(0);
                }

                var rule = wi.rule;
                var files = wi.files;

                if (Directory.Exists(rule))
                    CommonLib.Util.CleanDirectory(rule);
                else
                    Directory.CreateDirectory(rule);

                File.WriteAllLines(Path.Combine(rule, "fnames.txt"), files);

                var sw = new Stopwatch();
                sw.Start();

                var output =
                    CommonLib.Util.run(Path.Combine(Environment.CurrentDirectory, rule), 
                    Driver.ProofMinExe, string.Format("/files:fnames.txt {0}", Driver.ProofMinArgs));

                var elapsed = sw.Elapsed;

                File.WriteAllLines(Path.Combine(rule, "stdout.txt"), output);

                var parsedoutput = ParseOutput(output);

                lock (Driver.templates)
                {
                    if (!Driver.templates.ContainsKey(rule))
                        Driver.templates.Add(rule, new List<string>());

                    Driver.templates[rule].AddRange(parsedoutput);
                }

                lock (Driver.ConsoleOutput)
                {
                    // Delete temp_corral*
                    foreach (var f in Directory.GetFiles(Path.Combine(Environment.CurrentDirectory, rule), "temp_corral*"))
                        File.Delete(f);

                    Console.WriteLine("{0}", "Rule: " + rule);
                    Driver.ConsoleOutput.Add("Rule: " + rule);

                    Console.WriteLine("Time: {0} {1}", rule, elapsed.TotalSeconds.ToString("F2"));
                    foreach (var line in parsedoutput)
                    {
                        Console.WriteLine("{0}", "  " + line);
                        Driver.ConsoleOutput.Add(line);
                    }

                    foreach (var file in wi.driverfiles)
                    {
                        Driver.ConsoleOutput.Add("File: " + file);
                    }
                }
            }

        }

        public static List<string> ParseOutput(List<string> output)
        {
            var ret = new List<string>();
            var tok = "Additional contract required: ";
            foreach (var s in output)
            {
                if (!s.StartsWith(tok)) continue;
                ret.Add(s.Substring(tok.Length));
            }
            return ret;
        }
    }

    public class BoogieUtil
    {
        public static void PrintProgram(Program p, string filename)
        {
            var outFile = new TokenTextWriter(filename);
            p.Emit(outFile);
            outFile.Close();
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(string name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (attr.Key == name) return true;
            }
            return false;
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(HashSet<string> name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (name.Contains(attr.Key)) return true;
            }
            return false;
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
    }


}
