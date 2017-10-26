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

namespace Trainer
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

        public enum MODE { GENERATE_ATOMS, GENERATE_CANDIDATES, RUN_CANDIDATES };

        // Global flags
        public static MODE mode = MODE.GENERATE_ATOMS;
        public static bool useStubs = false;
        public static bool debugging = false;
        
        public static List<string> flags = new List<string>();
        public static string bplfile = "";

        // Static data
        static string wlimitexe = "";
        static string corralexe = "";
        static string iz3exe = "";
        static string z3exe = "";
        static int timeout = 3600;

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
                if (mode == MODE.GENERATE_ATOMS)
                {
                    // merge atoms.db
                    var dbs = new List<AtomDictionary>();
                    files.Iter(f => dbs.Add(TrainerDB.Driver.ReadAtomDB(f)));
                    TrainerDB.Driver.WriteDB(
                        AtomDictionary.Merge(dbs), CommonLib.GlobalConfig.util_result_file);
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

                runGenerator();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
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
                if(debugging) Console.WriteLine("Read atoms from atoms.db");
            }

        }


        public static void addPredicatesToBoogieFile(Program inprog, string outfile)
        {
            // delete {:template} and {:trainingPredicates} procedure
            DeleteNonFreeTemplates(inprog);
            BoogieUtil.PrintProgram(inprog, outfile);

            #region ZL: read summaries from dababase.
            var database = Path.Combine(Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location),
                "candidates.db");
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
                if(debugging) Console.WriteLine("Written summary tempaltes from cubes.db");
            }

        }

        static void runGenerator()
        {
            var filename = "";
            var corralflags = flags.Concat(" ");

            if (mode == MODE.GENERATE_CANDIDATES)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);
                addAtomsToBoogieFile(prog, "train.bpl");
                corralflags += " /trainSummaries /runHoudini:2";
                filename = "train.bpl";
            }
            else if (mode == MODE.RUN_CANDIDATES)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);
                addPredicatesToBoogieFile(prog, "test.bpl");
                filename = "test.bpl";

                corralflags += @" /useDuality ";
                corralflags += " /bopt:z3exe:" + iz3exe + " ";
            }
            else if (mode == MODE.GENERATE_ATOMS)
            {
                var prog = BoogieUtil.ParseProgram(bplfile);
                DeleteNonFreeTemplates(prog);
                BoogieUtil.PrintProgram(prog, "basic.bpl");
                filename = "basic.bpl";

                corralflags += @" /useDuality /z3opt:Fixedpoint.no_conj=true /z3opt:Fixedpoint.mbqi=false /z3opt:SMT.QI.max_instances=10000 /z3opt:SMT.QI.EAGER_THRESHOLD=10 /bopt:printFixedPoint:fp.bpl /bopt:printConjectures:cp /recursionBound:100 ";
                corralflags += " /bopt:z3exe:" + iz3exe + " ";
            }

            if(debugging) Console.WriteLine("Running corral with flags: {0}", corralflags);

            var corralout = CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe, 
                string.Format("/w {0} {1} {2}", timeout, corralexe, filename + " " + corralflags));

            if (mode == MODE.GENERATE_ATOMS)
            {
                addAtomsFromDualityOutput(filename);
                Console.WriteLine("Done");
            }
            else if (mode == MODE.GENERATE_CANDIDATES)
            {
                addSummaryPredicate();
                Console.WriteLine("Done");
            }
            else
            {
                File.WriteAllLines(CommonLib.GlobalConfig.util_result_file, corralout);
                string output1 = CommonLib.Util.parseOutput(corralout, false);

                // Run vanilla Corral without Houdini inference

                string corralFlagsNoHoudini = "";
                corralflags.Split(' ').Iter<string>(n => { if (!n.StartsWith("/runHoudini")) corralFlagsNoHoudini += n + " "; });
                
                if (debugging) Console.WriteLine("Running corral with flags: {0}", corralflags);

                var corralout2 = CommonLib.Util.run(Environment.CurrentDirectory, wlimitexe,
                    string.Format("/w {0} {1} {2}", timeout, corralexe, filename + " " + corralFlagsNoHoudini));

                File.AppendAllLines(CommonLib.GlobalConfig.util_result_file, corralout2);
                string output2 = CommonLib.Util.parseOutput(corralout2, false);

                Console.WriteLine("{0} {1}", output1, output2);
            }
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

            Debug.Assert (!System.IO.File.Exists(database));
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
            if(debugging) Console.WriteLine("Dumped summaries to db.");
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

            if (arg == "/generateCandidates")
            {
                mode = MODE.GENERATE_CANDIDATES;
                return;
            }

            if (arg == "/generateAtoms")
            {
                mode = MODE.GENERATE_ATOMS;
                return;
            }

            if (arg.StartsWith("/timeout:"))
            {
                var sp = arg.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                timeout = Int32.Parse(sp[1]);
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
