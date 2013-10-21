using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;

namespace ConcurrentHoudini
{
    class Driver
    {
        static void parseFlag(string arg)
        {
            var sep = new char[1];
            sep[0] = ':';
            if (arg.StartsWith("/break"))
            {
                System.Diagnostics.Debugger.Launch();
            }
            else if (arg.StartsWith("/dbg"))
            {
                dbg = true;
            }
            else if (arg == "/local")
            {
                local = true;
            }
            else if (arg == "/noTid")
            {
                noTid = true;
            }
            else if (arg == "/noPerm")
            {
                noPerm = true;
            }
            else if (arg == "/instantiate")
            {
                instantiateTemplates = true;
            }
            else if (arg == "/injectYields")
            {
                injectYields = true;
            }
            else if (arg == "/pruneAsserts")
            {
                pruneAsserts = true;
            }
            else
            {
                printUsageMessage();
                throw new Exception("Unknown flag: " + arg);
            }
        }
        static string parseCommandLine(string[] args)
        {
            var inputFlags = cba.FlagReader.read(args);
            var flags =  new List<string>();
            string inFileName = null;
            foreach (var flag in inputFlags)
            {
                if (cba.FlagReader.isFlag(flag))
                    flags.Add(flag);
                else if (flag.EndsWith(".bpl"))
                {
                    if (inFileName == null)
                        inFileName = flag;
                    else
                    {
                        printUsageMessage();
                        throw new Exception("Two input files given: " + inFileName + " & " + flag);
                    }
                }
                else
                {
                    printUsageMessage();
                    throw new Exception("Unknown argument: " + flag);
                }
            }

           
            foreach (var flag in flags)
                parseFlag(flag);

            if (inFileName == null)
            {
                printUsageMessage();
                throw new Exception("No input file given");
            }
            return inFileName;
        }

        static void printUsageMessage()
        {
            string msg =
                "Usage: ConcurrentHoudini.exe [/dbg][/break][/idempotent:{true,false}][/main:<entry_func_name>] inputfile";
            Console.Write(msg);
            Console.WriteLine();
        }



        public static bool dbg;
        static bool local = false;

        // Inject templates
        static bool instantiateTemplates = false; 
        // Do not instrument for tid 
        static bool noTid = false;
        // Do not instrument for permissions (simple MHP analysis)
        static bool noPerm = false;
        // Convert original asserts to assumes
        static bool pruneAsserts = false;
        // Inject yields at each global access
        static bool injectYields = false;

        public static Context con = null;
        public static string absDomain = "IA[HoudiniConst]";

        static void Main(string[] args)
        {
            con = new Context();

            string
                inFileName = null,
                unrolledFileName = null,
                tidRewrittenFileName = null,
                expandedFileName = null,
                annotatedFileName = null,
                splitFileName = null,
                yieldedFileName = null,
                instantiatedFileName = null,
                finalFileName = null,
                mhpFileName = null,
                hmifFileName = null;
            dbg = false;

            inFileName = parseCommandLine(args);

            string[] parts = inFileName.Split('.');
            if (parts.Count() == 1)
            {
                unrolledFileName = inFileName + "_unrolled";
                hmifFileName = inFileName + "_hmif";
                expandedFileName = inFileName + "_expanded";
                tidRewrittenFileName = inFileName + "_tidRewritten";
                annotatedFileName = inFileName + "_annotated";
                splitFileName = inFileName + "_split";
                yieldedFileName = inFileName + "_yielded";
                finalFileName = inFileName + "_final";
                mhpFileName = inFileName + "_mhp";
                instantiatedFileName = inFileName + "_inst";
            }
            else
            {
                string name = parts[0];
                unrolledFileName = name + "_unrolled";
                hmifFileName = name + "_hmif";
                expandedFileName = name + "_expanded";
                annotatedFileName = name + "_annotated";
                splitFileName = name + "_split";
                yieldedFileName = name + "_yielded";
                finalFileName = name + "_final";
                mhpFileName = name + "_mhp";
                instantiatedFileName = name + "_inst";
                tidRewrittenFileName = name + "_tidRewritten";
                for (int i = 1; i < parts.Count(); ++i)
                {
                    unrolledFileName += "." + parts[i];
                    hmifFileName += "." + parts[i];
                    expandedFileName += "." + parts[i];
                    annotatedFileName += "." + parts[i];
                    splitFileName += "." + parts[i];
                    yieldedFileName += "." + parts[i];
                    finalFileName += "." + parts[i];
                    tidRewrittenFileName += "." + parts[i];
                    mhpFileName += "." + parts[i];
                    instantiatedFileName += "." + parts[i];
                }
            }

            ExecutionEngine.printer = new ConsolePrinter();
            //CommanLineOptions will control how boogie parses the program and gives us the IR
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.Parse(new string[] { });
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.StratifiedInliningVerbose = 2;
            CommandLineOptions.Clo.UseArrayTheory = true;
            CommandLineOptions.Clo.TypeEncodingMethod = CommandLineOptions.TypeEncoding.Monomorphic;

            Program program;
            program = BoogieUtil.ReadAndOnlyResolve(inFileName);

            // TODO: assert that no procedure can be called in both sync and async mode!

            
            // Find entrypoint and initialize con
            var entry = program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .FirstOrDefault();

            if (entry == null)
                throw new Exception("Entrypoint not found");

            con.entryFunc = entry.Name;

            // Remove unreachable procedures
            cba.PruneProgramPass.pruneProcs(program, entry.Name);
            // Extract loops
            program.ExtractLoops();

            ModSetCollector.DoModSetAnalysis(program);

            if (pruneAsserts)
                program = og.GuardAsserts(program);

            if (instantiateTemplates)
            {
                var inst = new TemplateInstantiator(program);
                inst.Instantiate(program);
                program = BoogieUtil.ReResolve(program, instantiatedFileName);
            }

            var sp = new SplitThreads(con, dbg);
            var hmif = new HowManyInstanceFinder(con, dbg);

            var split = new Converter<Program, Program>(sp.split);
            var findHowManyInstances = new Converter<Program, Program>(hmif.Compute);

            if(dbg)
              Console.WriteLine("Splitting procedures on thread entry: {0}", splitFileName);

            program = split(program);
            program = BoogieUtil.ReResolve(program, hmifFileName);

            program = findHowManyInstances(program);
            program = BoogieUtil.ReResolve(program, splitFileName);

            if (dbg)
                Console.WriteLine("Injecting yields");

            // Get rid of corral_yield
            program = og.RemoveCorralYield(program, con.yieldProc);

            if(injectYields)
                program = og.InsertYields(program);

            BoogieUtil.PrintProgram(program, yieldedFileName);

            if(dbg)
                Console.WriteLine("Instrumenting: {0}", annotatedFileName);

            if(!noTid)
                program = og.InstrumentTid(program);

            program = og.InstrumentAtomicBlocks(program);

            if(!noPerm)
                program = og.InstrumentPermissions(program);

            program = BoogieUtil.ReResolve(program, annotatedFileName);

            // Run OG
            if(dbg)
                Console.WriteLine("Running OG: {0}", expandedFileName);

            LinearTypechecker linearTypechecker;
            var oc = ExecutionEngine.ResolveAndTypecheck(program, annotatedFileName, out linearTypechecker);

            if (oc != PipelineOutcome.ResolvedAndTypeChecked)
                throw new Exception(string.Format("{0} type checking errors detected in {1}", linearTypechecker.errorCount, annotatedFileName));

            var ogTransform = new OwickiGriesTransform(linearTypechecker);
            ogTransform.Transform();
            var eraser = new LinearEraser();
            eraser.VisitProgram(program);

            //var stats = new PipelineStatistics();
            //ExecutionEngine.EliminateDeadVariablesAndInline(program);
            //var ret = ExecutionEngine.InferAndVerify(program, stats);
            //ExecutionEngine.printer.WriteTrailer(stats);
            //return;

            program = BoogieUtil.ReResolve(program, expandedFileName);

            // Run Abs
            if(dbg)
                Console.WriteLine("Running abs houdini on {0}", expandedFileName);

            ExecutionEngine.EliminateDeadVariablesAndInline(program);

            CommandLineOptions.Clo.ContractInfer = true;
            CommandLineOptions.Clo.AbstractHoudini = absDomain;
            CommandLineOptions.Clo.UseProverEvaluate = true;
            CommandLineOptions.Clo.ModelViewFile = "z3model";
            
            Microsoft.Boogie.Houdini.AbstractDomainFactory.Initialize(program);
            var domain = Microsoft.Boogie.Houdini.AbstractDomainFactory.GetInstance(absDomain);

            var abs = new Microsoft.Boogie.Houdini.AbsHoudini(program, domain);
            var outcome = abs.ComputeSummaries();
            if (outcome.outcome != VC.ConditionGeneration.Outcome.Correct)
            {
                Console.WriteLine("Some assert failed while running AbsHoudini, aborting");
                outcome.errors.ForEach(error => og.PrintError(error));
                return;
            }

            var answer = abs.GetAssignment();

            var provedAsserts = new Dictionary<string, bool>();
            answer.Where(func => QKeyValue.FindBoolAttribute(func.Attributes, "assertGuard"))
                .Iter(func => {
                    var le = func.Body as LiteralExpr;
                    System.Diagnostics.Debug.Assert(le != null);
                    provedAsserts.Add(func.Name, le.IsFalse);
                });

            // remove injected existential functions
            answer = answer.Where(func => !QKeyValue.FindBoolAttribute(func.Attributes, "chignore")
                && !QKeyValue.FindBoolAttribute(func.Attributes, "assertGuard"));

            using (var tt = new TokenTextWriter(Console.Out))
                answer.ToList().ForEach(func => func.Emit(tt, 0));


            if(dbg)
                Console.WriteLine("Injecting invariants back into the original program: {0}", finalFileName);

            program = BoogieUtil.ReadAndOnlyResolve(yieldedFileName);
            // remove existential functions
            program.TopLevelDeclarations.RemoveAll(decl => (decl is Function) && QKeyValue.FindBoolAttribute((decl as Function).Attributes, "existential"));
            program.TopLevelDeclarations.AddRange(answer);

            program = og.PruneProvedAsserts(program, f => provedAsserts[f] );

            // Remove ensures and requires
            program = og.RemoveRequiresAndEnsures(program);
            // Remove tid func
            program = og.RemoveThreadIdFunc(program);
            using (Microsoft.Boogie.TokenTextWriter writer = new Microsoft.Boogie.TokenTextWriter(finalFileName))
                program.Emit(writer);

        }

 

        // convert:
        //   call corral_yield(expr);
        // to:
        //   assume expr;
        //   yield;
        //   assume expr;
        static Program MassageCorralYield(Program program)
        {
            var cy = program.TopLevelDeclarations.OfType<Procedure>()
                .FirstOrDefault(proc => proc.Name == con.yieldProc);
            if (cy == null) return program;
            if (cy.InParams.Count != 1)
                throw new Exception("ConcurrentHoudini expects that corral_yield has 1 argument");

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (var cmd in blk.Cmds)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd == null || ccmd.callee != cy.Name)
                        {
                            ncmds.Add(cmd);
                            continue;
                        }
                        ncmds.Add(cba.Util.BoogieAstFactory.MkAssume(ccmd.Ins[0]));
                        ncmds.Add(new YieldCmd(Token.NoToken));
                        ncmds.Add(cba.Util.BoogieAstFactory.MkAssume(ccmd.Ins[0]));

                    }
                    blk.Cmds = ncmds;
                }
            }

            return program;

        }

    }
}
