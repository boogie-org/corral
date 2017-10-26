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
using TrainerDB;
using System.Diagnostics.Contracts;

namespace Trainer
{
    [Serializable]
    public class RuleAsString
    {
        public HashSet<string> preSet = new HashSet<string>();
        public HashSet<string> postSet = new HashSet<string>();

        public RuleAsString(RuleTemplate t)
        {
            preSet.UnionWith(t.preSetStr);
            postSet.UnionWith(t.postSetStr);
        }

        public override bool Equals(object obj)
        {
            RuleAsString that = obj as RuleAsString;
            return this.preSet.SetEquals(that.preSet) && this.postSet.SetEquals(that.postSet);
        }

        public override int GetHashCode()
        {
            return preSet.Count * postSet.Count; 
        }
    }

    [Serializable]
    public class TemplateDictionarySerializable
    {
        // A table of annotated atoms 
        public List<RuleAsString> table;

        public TemplateDictionarySerializable()
        {
            table = new List<RuleAsString>();
        }

        public void LoadFromDB()
        {
            foreach (var t in RuleTemplateDB.RuleTemplateSet.Keys)
            {
                RuleAsString r = new RuleAsString(t);
                Add(r);
            }
        }

        public void DumpToDB()
        {
            Contract.Assert(RuleTemplateDB.RuleTemplateSet.Count == 0);

            foreach (var r in table)
            {
                RuleTemplate t = new RuleTemplate(r);
                RuleTemplateDB.record(t);
            }
        }

        public void Add(RuleAsString rule)
        {
            //var str = string.Format("{0} {1}", annotation == null ? "" : annotation.ToString(), atom);
            if (table.Contains(rule)) return;
            table.Add(rule);
        }

        public static TemplateDictionarySerializable Merge(IEnumerable<TemplateDictionarySerializable> atoms)
        {
            var ret = new HashSet<RuleAsString>();
            atoms.Iter(atom => ret.UnionWith(atom.table));
            var merged = new TemplateDictionarySerializable();
            merged.table.AddRange(ret);
            return merged;
        }

        public void Print(string file)
        {
            var fs = new System.IO.StreamWriter(file);
            foreach (var atom in table)
            {
                fs.WriteLine("{0}", atom);
            }
            fs.Close();
        }

        public string DumpPredicates(out int NumAtoms)
        {
            string ret = "";
            table.Iter(atom => ret = ret + Environment.NewLine + " ensures " + atom + ";");

            NumAtoms = table.Count;
            return ret;
        }

        public static TemplateDictionarySerializable ReadTemplateDictionary(string file)
        {
            using (var fs = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                var obj = serializer.Deserialize(fs);
                return obj as TemplateDictionarySerializable;
            }
        }

        public static void WriteTemplateDictionary(object db, string file)
        {
            using (var fs = new System.IO.FileStream(file, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None))
            {
                var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                serializer.Serialize(fs, db);
            }
        }
    }

    class Driver2
    {
        public class CompileException : Exception
        {
            public CompileException(string s)
                : base(s)
            {
            }
        }

        public enum MODE { GENERATE_TEMPLATES, GENERATE_CANDIDATES, RUN_CANDIDATES };

        // Global flags
        public static MODE mode = MODE.GENERATE_TEMPLATES;
        public static int runCandidatesMode = 0;
        public static bool useStubs = false;
        public static bool debugging = false;

        public static List<string> flags = new List<string>();
        public static string bplfile = "";

        // Static data
        static string wlimitexe = "";
        static string corralexe = "";
        static string iz3exe = "";
        static string z3exe = "";
        //static string timeout = "10800 /m 4099 "; // time with mem constraints added
        static int timeout = 3600;
        static int memlimit = 10*1024;

        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: generator file.[c|bpl]");
                return;
            }

            for (int i = 0; i < args.Count(); i++)
                ProcessArg(args[i]);

            var files = CommonLib.Util.GetFilesForUnion(args);
            if (files != null)
            {
                if (mode == MODE.GENERATE_TEMPLATES)
                {
                    // merge atoms.db
                    var dbs = new List<TemplateDictionarySerializable>();
                    files.Iter(f => dbs.Add(TemplateDictionarySerializable.ReadTemplateDictionary(f)));
                    TemplateDictionarySerializable.WriteTemplateDictionary(
                        TemplateDictionarySerializable.Merge(dbs), CommonLib.GlobalConfig.util_result_file);
                }
                else if (mode == MODE.GENERATE_CANDIDATES)
                {
                    // merge candidates db
                    var dbs = new List<StubAnnotatedSummaryDictionary>();
                    files.Iter(f => dbs.Add(TrainerDB.Driver.ReadCandidateDB(f)));
                    TrainerDB.Driver.WriteDB(
                        StubAnnotatedSummaryDictionary.Merge(dbs), CommonLib.GlobalConfig.util_result_file);
                }
                else
                {
                    // merge corral output
                    var cat = new List<string>();
                    foreach (var file in files)
                    {
                        cat.AddRange(System.IO.File.ReadAllLines(file));
                        cat.Add("=========");
                    }
                    System.IO.File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, cat);
                }

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
                z3exe = Path.Combine(root, "..", "corral", "z3.exe");
                iz3exe = Path.Combine(root, "..", "iz3", "z3.exe");
                CommandLineOptions.Clo.Z3ExecutablePath = z3exe;

                runGenerator();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        public static void loadTemplates(Program inprog, string outfile)
        {
            DeleteNonFreeTemplates(inprog);
            BoogieUtil.PrintProgram(inprog, outfile);

            #region ZL: read atoms from atoms.db.

            var database = Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location),
                "atoms.db");

            if (!System.IO.File.Exists(database))
                throw new Exception("File does not exist: " + database);

            TemplateDictionarySerializable summaries = null;

            while (true)
            {
                try
                {
                    using (var fs = new System.IO.FileStream(database, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
                    {
                        var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                        summaries = serializer.Deserialize(fs) as TemplateDictionarySerializable;
                        break;
                    }

                }
                catch (System.IO.IOException ex)
                {
                    Thread.Sleep(300);
                    Console.WriteLine("-- {0}: {1}", ex.GetType().Name, ex.ToString());
                }
            }


            #endregion

            // Load out database from the deserialized object
            summaries.DumpToDB();

            
#if false
            var numPreds = 0;

            string s = @"procedure {:trainingPredicates} summaryTrainingtemplate();";
            //string s = @"procedure {:XXX} YYY();";
            s += summaries.DumpPredicates(out numPreds);


            // Add procedure summaryTrainingtemplate() by reading summary.db.

            using (var file = new System.IO.StreamWriter(outfile, true))
            {
                file.WriteLine(s);
                if (debugging) Console.WriteLine("Read atoms from atoms.db");
            }
#endif

        }

        public static void addAtomsToBoogieFile(Program inprog, string outfile)
        {
            DeleteNonFreeTemplates(inprog);
            BoogieUtil.PrintProgram(inprog, outfile);

            #region ZL: read atoms from atoms.db.

            var database = Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location),
                "atoms.db");

            if (!System.IO.File.Exists(database))
                throw new Exception("File does not exist: " + database);

            AtomDictionary summaries = null;

            while (true)
            {
                try
                {
                    using (var fs = new System.IO.FileStream(database, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
                    {
                        var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                        summaries = serializer.Deserialize(fs) as AtomDictionary;
                        break;
                    }

                }
                catch (System.IO.IOException ex)
                {
                    Thread.Sleep(300);
                    Console.WriteLine("-- {0}: {1}", ex.GetType().Name, ex.ToString());
                }
            }

            var numPreds = 0;

            string s = @"procedure {:trainingPredicates} summaryTrainingtemplate();";
            //string s = @"procedure {:XXX} YYY();";
            s += summaries.DumpPredicates(out numPreds);

            #endregion

            // Add procedure summaryTrainingtemplate() by reading summary.db.

            using (var file = new System.IO.StreamWriter(outfile, true))
            {
                file.WriteLine(s);
                if (debugging) Console.WriteLine("Read atoms from atoms.db");
            }

        }


        public static void addPredicatesToBoogieFile(Program inprog, string outfile, string candidateFile)
        {
            // delete {:template} and {:trainingPredicates} procedure
            DeleteNonFreeTemplates(inprog);
            BoogieUtil.PrintProgram(inprog, outfile);

            #region ZL: read summaries from dababase.
            //var database = Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location),
            //    "candidates.db");
            var database = Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location),
                candidateFile);
            if (!System.IO.File.Exists(database))
                throw new Exception("File does not exist: " + database);

            StubAnnotatedSummaryDictionary summaries = null;

            while (true)
            {
                try
                {
                    using (var fs = new System.IO.FileStream(database, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read))
                    {
                        var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                        summaries = StubAnnotatedSummaryDictionary.GetDictionary(serializer.Deserialize(fs));
                        break;
                    }

                }
                catch (System.IO.IOException ex)
                {
                    Thread.Sleep(300);
                    Console.WriteLine("-- {0}: {1}", ex.GetType().Name, ex.ToString());
                }
            }

            summaries.DeMarshall(z3exe);
            var numPreds = 0;
            string s = summaries.DumpPredicates(out numPreds);
            // TODO: 1. Add "free requires yogi_error == 0; free ensures alloc >= old(alloc);"
            //       2. Add the two long candidates for irql rules. 
            //       3. Track Mem_T.int4.
            //       4. Add free ensures and free requires for type state variables. 
            //       5. Add inline depth argument 


            #endregion

            using (var file = new System.IO.StreamWriter(outfile, true))
            {
                file.WriteLine("procedure {:template} summaryTemplates();");
                file.WriteLine(s);
                if (debugging) Console.WriteLine("Written summary tempaltes from cubes.db");
            }
        }

        static void runGenerator()
        {
            var filename = "";
            var corralflags = flags.Concat(" ");

            if (mode == MODE.GENERATE_CANDIDATES)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);
                loadTemplates(prog, "train.bpl");
                //corralflags += " /trainSummaries /runHoudini:2";  // "trainSummaries" runs AbstractHoudini and generates "candidates.txt"
                filename = "train.bpl"; // Corral just needs to be run to generate the final bpl file

                //corralflags += @" /useDuality /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /bopt:printFixedPoint:fp.bpl /bopt:printConjectures:cp /recursionBound:100 ";
                corralflags += @" /useDuality /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /recursionBound:100 ";
                //corralflags += @" /useDuality /bopt:printFixedPoint:fp.bpl /bopt:printConjectures:cp /recursionBound:100 ";
                corralflags += " /bopt:z3exe:" + iz3exe + " "; 
                corralflags += " /printFinalProg:f.bpl ";
            }
            else if (mode == MODE.RUN_CANDIDATES)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);

                addPredicatesToBoogieFile(prog, "test0.bpl", "candidates0.db");
                addPredicatesToBoogieFile(prog, "test1.bpl", "candidates1.db");
                addPredicatesToBoogieFile(prog, "test2.bpl", "candidates2.db");
                addPredicatesToBoogieFile(prog, "test3.bpl", "candidates3.db");
                //filename = "test.bpl";
                filename = null;

                //corralflags += " /timeLimit:3000 /memLimit:4096 ";
            }
            else if (mode == MODE.GENERATE_TEMPLATES)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);
                DeleteNonFreeTemplates(prog);
                BoogieUtil.PrintProgram(prog, "basic.bpl");
                filename = "basic.bpl";

                corralflags += @" /useDuality /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /bopt:printFixedPoint:fp.bpl /bopt:printConjectures:cp /recursionBound:100 ";
                corralflags += " /bopt:z3exe:" + iz3exe + " ";
            }

            
            if (mode == MODE.GENERATE_TEMPLATES)
            {
                if (debugging) Console.WriteLine("Running corral with flags: {0}", corralflags);
                
                var corralout = CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2}", timeout, corralexe, filename + " " + corralflags));

                if (!System.IO.File.Exists("fp.bpl"))
                {
                    Console.WriteLine("Summary file is not found!");
                    return;
                }

                CommandLineOptions.Clo.ApplyDefaultOptions(); // needed for creating prover
                CommandLineOptions.Clo.StratifiedInlining = 1;
                addTemplatesFromDualityOutput(filename);
                Console.WriteLine("Done");
            }
            else if (mode == MODE.GENERATE_CANDIDATES)
            {
                if (debugging) Console.WriteLine("Running corral with flags: {0}", corralflags);
                var corralout = CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2}", timeout, corralexe, filename + " " + corralflags));

                CommandLineOptions.Clo.ApplyDefaultOptions(); // needed for creating prover
                CommandLineOptions.Clo.StratifiedInlining = 1;
                addSummaryTemplate("train.bpl");
                Console.WriteLine("Done");
            }
            else
            {
                File.WriteAllText(CommonLib.GlobalConfig.util_result_file, "Starting Run");  // clear out the file

#if false
                // (1) Run vanilla Corral+SI WITH manual summaries
                string output1 = runCorral(bplfile, corralflags, false);

                // (2) Run vanilla Corral+SI WITHOUT manual summaries
                string corralFlagsNoHoudini = "";
                corralflags.Split(' ').Iter<string>(n => { if (!n.StartsWith("/runHoudini")) corralFlagsNoHoudini += n + " "; });
                string output2 = runCorral(bplfile, corralFlagsNoHoudini, false);

                // (3) Run vanilla Corral+Duality WITH manual summaries
                string output3 = runCorral(bplfile, corralflags, true);

                // (4) Run vanilla Corral+Duality WITHOUT manual summaries
                string output4 = runCorral(bplfile, corralFlagsNoHoudini, true);
#endif
                string output = "";

                if(runCandidatesMode == 0)
                // (5) Run Corral+SI WITH predicate summaries
                output = runCorral("test0.bpl", corralflags, false);

                if (runCandidatesMode == 1)
                // (6) Run Corral+SI WITH template(Clauses) summaries
                output = runCorral("test1.bpl", corralflags, false);

                if (runCandidatesMode == 2)
                // (7) Run Corral+SI WITH template(BoundedTail) summaries
                output = runCorral("test2.bpl", corralflags, false);

                if (runCandidatesMode == 3)
                // (8) Run Corral+SI WITH template(FreeTail) summaries
                output = runCorral("test3.bpl", corralflags, false);

                Console.WriteLine("{0}", output);
            }
        }

        static string runCorral(string filename, string corralflags, bool useDuality)
        {
            string fullFlags;

            if (useDuality)
                fullFlags = @" /useDuality /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10"
                    + corralflags + " /bopt:z3exe:" + iz3exe + " ";
            else
                fullFlags = corralflags;

            if (debugging) Console.WriteLine("Running corral with flags: {0}", fullFlags);

            var corralout = CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                string.Format("/w {0} /m {1} {2} {3}", timeout, memlimit, corralexe, filename + " " + fullFlags));

            File.AppendAllLines(CommonLib.GlobalConfig.util_result_file, corralout);
            string output = CommonLib.Util.parseOutput(corralout, false);

            return output;
        }

        static void DeleteNonFreeTemplates(Program prog)
        {
            // Delete non-free templates
            prog.TopLevelDeclarations.RemoveAll(decl =>
                BoogieUtil.checkAttrExists("trainingPredicates", decl.Attributes));
            var template = prog.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => BoogieUtil.checkAttrExists("template", p.Attributes))
                .FirstOrDefault();
            if (template != null)
            {
                template.Ensures.RemoveAll(e => !e.Free);
                template.Requires.RemoveAll(e => !e.Free);
            }
        }

        private static void addTemplatesFromDualityOutput(string filename)
        {
            var pwd = Environment.CurrentDirectory;
            var dualityOutputFiles = new List<string>();
                //System.IO.Directory.GetFiles(pwd, "cp.*").ToList();
            //dualityOutputFiles.RemoveAll(fname => fname == System.IO.Path.Combine(pwd, "cp.tmp"));

            if (System.IO.File.Exists("fp.bpl"))
                dualityOutputFiles.Add("fp.bpl");

            Contract.Assert(dualityOutputFiles.Count == 1);

            // create Rule database
            EnvironmentalSummaries envSummaries = new EnvironmentalSummaries(new List<string> { filename }, dualityOutputFiles[0], false); // TODO: Later set to FALSE
            //envSummaries.EmitBplWithSummaries(EnvironmentalSummaries.InsertedSummaryType.LearntTemplates, "EnvVarsPredAbsInductiveTemplates.bpl");
            envSummaries.CreateRuleTemplateDB(EnvironmentalSummaries.InsertedSummaryType.LearntTemplates);

            // Store to file
            TemplateDictionarySerializable tds = new TemplateDictionarySerializable();
            tds.LoadFromDB();
            var atomDatabasePath = CommonLib.GlobalConfig.util_result_file;
            if (System.IO.File.Exists(atomDatabasePath))
            {
                Console.WriteLine("{0} is already present. Aborting!", atomDatabasePath);
                Debug.Assert(!System.IO.File.Exists(atomDatabasePath));
            }
            TemplateDictionarySerializable.WriteTemplateDictionary(tds, atomDatabasePath);
        }

        private static void addAtomsFromDualityOutput(string filename)
        {
            var pwd = Environment.CurrentDirectory;
            var dualityOutputFiles = System.IO.Directory.GetFiles(pwd, "cp.*").ToList();
            dualityOutputFiles.RemoveAll(fname => fname == System.IO.Path.Combine(pwd, "cp.tmp"));

            if (System.IO.File.Exists("fp.bpl"))
                dualityOutputFiles.Add("fp.bpl");

            //foreach (var file in dualityOutputFiles)
            //    Console.WriteLine("file: {0}", file);


            if (!dualityOutputFiles.Any())
                return;

            // Get the set of variables with annotation {:environment}.
            var slicVars = new HashSet<string>();
            var testBpl = BoogieUtil.ParseProgram(filename);
            testBpl.TopLevelDeclarations.OfType<Variable>()
                .Where(g => QKeyValue.FindBoolAttribute(g.Attributes, "environment"))
                .Iter(g => slicVars.Add(g.Name));

            var outatoms = new HashSet<string>();
            var summaries = new AtomDictionary();
            foreach (var file in dualityOutputFiles)
            {
                // Parse the procedure summary file fp.bpl generated by Duality.
                var program = BoogieUtil.ParseProgram(file);

                // Collect atomic propositions that talk about slic variables.
                var literalVisitor = new LiteralVisitor();
                foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
                {
                    foreach (var ens in proc.Ensures)
                    {
                        literalVisitor.VisitEnsures(ens);
                    }
                }

                // Filter literals that talk about SLIC variables only.
                var literals = new HashSet<Expr>();
                foreach (var lit in literalVisitor.literals)
                {
                    var fv = new VarsInExpr();
                    fv.VisitExpr(lit);
                    bool allVarsAreSlicVars = true;
                    foreach (var v in fv.Vars)
                    {
                        if (!slicVars.Contains(v))
                            allVarsAreSlicVars = false;
                    }
                    if (allVarsAreSlicVars)
                        literals.Add(lit);
                }

                // Get pre/post annotation
                var GetAtomFromLiteral = new Func<Expr, Tuple<string, Expr>>(e =>
                {
                    if (HasNonOldExpr.Process(e))
                    {
                        return Tuple.Create("{:post}", e);
                    }
                    else
                    {
                        return Tuple.Create("{:pre}", e);
                    }
                });

                literals.Select(l => GetAtomFromLiteral(l))
                    .Iter(t =>
                    {
                        summaries.Add(t.Item1, t.Item2);
                        outatoms.Add(t.Item1 + " " + t.Item2);
                    });
            }

            var atomDatabasePath = CommonLib.GlobalConfig.util_result_file;
            Debug.Assert(!System.IO.File.Exists(atomDatabasePath));
            TrainerDB.Driver.WriteDB(summaries, atomDatabasePath);

            if (debugging)
            {
                foreach (var atom in outatoms)
                {
                    Console.WriteLine("Dumped atom: {0}", atom);
                }
                Console.WriteLine("Dumped atoms to db.");
            }
        }

        private static void addSummaryTemplate(string inferFile)
        {
            EnvironmentalSummaries envSummaries = new EnvironmentalSummaries(new List<string>(), null, true);
            envSummaries.RunAbstractHoudini();  // generates the file "corralPredicates.txt"

            if (!System.IO.File.Exists("corralPredicates.txt"))
                return;

            // stubs is always [] in the current version.
            var predWithStubs = new HashSet<Tuple<string, string>>();
            using (var file = new System.IO.StreamReader("corralPredicates.txt"))
            {
                string pred;
                string stubs = "";
                while ((pred = file.ReadLine()) != null)
                {
                    if (useStubs)
                    {
                        stubs = file.ReadLine();
                        if (stubs == "[]")
                            stubs = "";
                        else
                            stubs = string.Format("{{:stubs \"{0}\"}}", stubs);
                    }
                    predWithStubs.Add(Tuple.Create(stubs, pred));
                }
            }

            string database = CommonLib.GlobalConfig.util_result_file;

            Debug.Assert(!System.IO.File.Exists(database));
            var summaries = new StubAnnotatedSummaryDictionary();
            StubAnnotatedSummaryDictionary.CreateProver(z3exe);
            if (useStubs)
                predWithStubs.Iter(tup => summaries.Add(tup.Item1, tup.Item2));
            else
                predWithStubs.Iter(tup => summaries.Add("", tup.Item2));
            //predicates.Iter(pred => summaries.Add(property, pred));
            //summaries.Print(databaseTxt);
            StubAnnotatedSummaryDictionary.CloseProver();
            summaries.Marshall();

            while (true)
            {
                try
                {
                    using (var fs = new System.IO.FileStream(database, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None))
                    {
                        var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                        serializer.Serialize(fs, summaries);
                        break;
                    }
                }
                catch (System.IO.IOException)
                {
                    Random rnd = new Random();
                    Thread.Sleep(rnd.Next(300, 501));
                }

            }
            if (debugging) Console.WriteLine("Dumped summaries to db.");
        }

        private static void addSummaryPredicate()
        {
            if (!System.IO.File.Exists("corralPredicates.txt"))
                return;

            // stubs is always [] in the current version.
            var predWithStubs = new HashSet<Tuple<string, string>>();
            using (var file = new System.IO.StreamReader("corralPredicates.txt"))
            {
                string pred;
                string stubs = "";
                while ((pred = file.ReadLine()) != null)
                {
                    if (useStubs)
                    {
                        stubs = file.ReadLine();
                        if (stubs == "[]")
                            stubs = "";
                        else
                            stubs = string.Format("{{:stubs \"{0}\"}}", stubs);
                    }
                    predWithStubs.Add(Tuple.Create(stubs, pred));
                }
            }

            string database = CommonLib.GlobalConfig.util_result_file;

            Debug.Assert(!System.IO.File.Exists(database));
            var summaries = new StubAnnotatedSummaryDictionary();
            StubAnnotatedSummaryDictionary.CreateProver(z3exe);
            if (useStubs)
                predWithStubs.Iter(tup => summaries.Add(tup.Item1, tup.Item2));
            else
                predWithStubs.Iter(tup => summaries.Add("", tup.Item2));
            //predicates.Iter(pred => summaries.Add(property, pred));
            //summaries.Print(databaseTxt);
            StubAnnotatedSummaryDictionary.CloseProver();
            summaries.Marshall();

            while (true)
            {
                try
                {
                    using (var fs = new System.IO.FileStream(database, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None))
                    {
                        var serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                        serializer.Serialize(fs, summaries);
                        break;
                    }
                }
                catch (System.IO.IOException)
                {
                    Random rnd = new Random();
                    Thread.Sleep(rnd.Next(300, 501));
                }

            }
            if (debugging) Console.WriteLine("Dumped summaries to db.");
        }

        static void ProcessArg(string arg)
        {
            if (arg == "/break")
            {
                System.Diagnostics.Debugger.Launch();
                return;
            }

            if (arg == "/debug")
            {
                debugging = true;
                return;
            }

            if (arg == "/runCandidates")
            {
                mode = MODE.RUN_CANDIDATES;
                return;
            }

            if (arg.StartsWith("/runCandidates:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                runCandidatesMode = Int32.Parse(sp[1]);
                mode = MODE.RUN_CANDIDATES;
                return;
            }

            if (arg == "/generateCandidates")
            {
                mode = MODE.GENERATE_CANDIDATES;
                return;
            }

            if (arg == "/generateAtoms")
            {
                mode = MODE.GENERATE_TEMPLATES;
                return;
            }

            if (arg.StartsWith("/templateType:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                int templateType = Int32.Parse(sp[1]);
                if (templateType == 1)
                    InductiveSummaries.useDirectedRules = InductiveSummaries.TemplateType.ClausePredicates;
                else if (templateType == 2)
                    InductiveSummaries.useDirectedRules = InductiveSummaries.TemplateType.OnlyHeadBoundedTail;
                else if (templateType == 3)
                    InductiveSummaries.useDirectedRules = InductiveSummaries.TemplateType.OnlyHeadFreeTail;
                else
                {
                    Console.WriteLine("Wrong template type!");
                    Contract.Assert(false);
                }
                return;
            }

            if (arg.StartsWith("/timeout:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                timeout = Int32.Parse(sp[1]);
                return;
            }

            if (arg.StartsWith("/memlimit:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                memlimit = Int32.Parse(sp[1]);
                return;
            }

            if (arg == "/stub")
            {
                useStubs = true;
                TrainerDB.Driver.useStubs = true;
                return;
            }

            if (arg.StartsWith("/extra:"))
            {
                flags.Add("/" + arg.Substring("/extra:".Length));
                return;
            }

            if (arg.EndsWith(".bpl"))
            {
                bplfile = arg;
                return;
            }

            flags.Add(arg);
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
