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
            else if (arg == "/perm")
            {
                instrumentPermissions = true;
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
            else if (arg == "/splitThreads")
            {
                splitThreads = true;
            }
            else if (arg == "/extractLoops")
            {
                extractLoops = true;
            }
            else if (arg == "/corral")
            {
                splitThreads = true;
                extractLoops = true;
                instrumentPermissions = true;
                //pruneAsserts = true;
                //instantiateTemplates = true;
            }
            else if (arg == "/printAssignment")
            {
                printAssignment = true;
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
                "Usage: ConcurrentHoudini.exe inputfile [/flags]";
            Console.Write(msg);
            Console.WriteLine();
        }



        public static bool dbg;
        static bool local = false;

        // Inject templates
        static bool instantiateTemplates = false; 
        // Do not instrument for tid 
        static bool noTid = false;
        // Instrument for permissions (simple MHP analysis)
        static bool instrumentPermissions = false;
        // Convert original asserts to assumes
        static bool pruneAsserts = false;
        // Inject yields at each global access
        static bool injectYields = false;
        // Extract loops
        static bool extractLoops;
        // Split threads based on entry point
        static bool splitThreads;
        // print assignment
        static bool printAssignment = false;

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

            var tmpFileName = "og__tmp.bpl";

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
            {
                Console.WriteLine("Warning: No entrypoint given");
                con.entryFunc = null;
            }
            else
            {
                con.entryFunc = entry.Name;
            }

            // Remove unreachable procedures
            BoogieUtil.pruneProcs(program, con.entryFunc);

            // Extract loops
            if(extractLoops)
                program.ExtractLoops();

            BoogieUtil.DoModSetAnalysis(program);

            if (pruneAsserts)
                program = og.GuardAsserts(program);

            if (injectYields)
                program = og.InsertYields(program);

            if (instantiateTemplates)
            {
                var inst = new TemplateInstantiator(program);
                inst.Instantiate(program);
                program = BoogieUtil.ReResolve(program, dbg ? instantiatedFileName : tmpFileName);
            }

            var sp = new SplitThreads(con, dbg);
            var hmif = new HowManyInstanceFinder(con, dbg);

            var split = new Converter<Program, Program>(sp.split);
            var findHowManyInstances = new Converter<Program, Program>(hmif.Compute);

            if (entry != null && splitThreads)
            {
                if (dbg)
                    Console.WriteLine("Splitting procedures on thread entry: {0}", splitFileName);

                program = split(program);
                program = BoogieUtil.ReResolve(program, dbg ? hmifFileName : tmpFileName);

                program = findHowManyInstances(program);
                program = BoogieUtil.ReResolve(program, dbg ? splitFileName : tmpFileName);
            }

            // Get rid of corral_yield
            program = og.RemoveCorralYield(program, con.yieldProc);


            var yieldedProgram = new ProgTransformation.PersistentProgram(program);

            if(dbg)
                Console.WriteLine("Instrumenting: {0}", annotatedFileName);

            if(!noTid)
                program = og.InstrumentTid(program);

            program = og.InstrumentAtomicBlocks(program);

            if(instrumentPermissions)
                program = og.InstrumentPermissions(program);

            program = BoogieUtil.ReResolve(program, dbg ? annotatedFileName : tmpFileName);

            CommandLineOptions.Clo.ContractInfer = true;
            CommandLineOptions.Clo.AbstractHoudini = absDomain;
            CommandLineOptions.Clo.UseProverEvaluate = true;
            CommandLineOptions.Clo.ModelViewFile = "z3model";
            Microsoft.Boogie.Houdini.AbstractDomainFactory.Initialize(program);

            // First, do sequential
            var answer = DoInference(program, InferenceMode.SEQUENTIAL, annotatedFileName, expandedFileName);

            program = BoogieUtil.ReadAndOnlyResolve(dbg ? annotatedFileName : tmpFileName);

            // prune "true" functions
            var progFuncs = new Dictionary<string, Function>();
            program.TopLevelDeclarations.OfType<Function>()
                .Iter(f => progFuncs.Add(f.Name, f));
            
            var truefuncs = new List<Function>();
            foreach (var f in answer)
            {
                if (f.Body is LiteralExpr && (f.Body as LiteralExpr).IsTrue)
                {
                    truefuncs.Add(f);
                    var actualf = progFuncs[f.Name];
                    actualf.Attributes = BoogieUtil.removeAttr("existential", actualf.Attributes);
                    actualf.Body = Expr.True;
                }
            }
            Console.WriteLine("Sequential check pruned away {0} functions, {1} remain", truefuncs.Count, answer.Count() - truefuncs.Count);

            // now do concurrent
            answer = DoInference(program, InferenceMode.CONCURRENT, annotatedFileName, expandedFileName);
            answer = answer.Concat(truefuncs);

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

            if (printAssignment)
            {
                using (var tt = new TokenTextWriter(Console.Out))
                    answer.ToList().Iter(func => func.Emit(tt, 0));
            }


            if(dbg)
                Console.WriteLine("Injecting invariants back into the original program: {0}", finalFileName);

            program = yieldedProgram.getProgram();

            // remove existential functions
            program.RemoveTopLevelDeclarations(decl => (decl is Function) && QKeyValue.FindBoolAttribute((decl as Function).Attributes, "existential"));
            program.AddTopLevelDeclarations(answer);

            program = og.PruneProvedAsserts(program, f => provedAsserts[f] );

            // Remove ensures and requires
            program = og.RemoveRequiresAndEnsures(program);
            // Remove tid func
            program = og.RemoveThreadIdFunc(program);
            using (Microsoft.Boogie.TokenTextWriter writer = new Microsoft.Boogie.TokenTextWriter(finalFileName))
                program.Emit(writer);

        }

        enum InferenceMode { SEQUENTIAL, CONCURRENT };

        static IEnumerable<Function> DoInference(Program program, InferenceMode mode, string annotatedFileName, string expandedFileName)
        {
            var tmpFileName = "og__tmp_di.bpl";

            if (mode == InferenceMode.SEQUENTIAL)
            {
                // remove yields
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Blocks
                        .Iter(blk => blk.Cmds = new List<Cmd>(blk.Cmds.Filter(c => !(c is YieldCmd)))));
            }

            // Run OG
            if (dbg)
                Console.WriteLine("Running OG: {0}", expandedFileName);

            LinearTypeChecker linearTypechecker;
            CivlTypeChecker moverTypeChecker;
            var oc = ExecutionEngine.ResolveAndTypecheck(program, annotatedFileName, out linearTypechecker, out moverTypeChecker);

            if (oc != PipelineOutcome.ResolvedAndTypeChecked)
                throw new Exception(string.Format("{0} type checking errors detected in {1}", linearTypechecker.errorCount, annotatedFileName));

            Concurrency.Transform(linearTypechecker, moverTypeChecker);
            var eraser = new LinearEraser();
            eraser.VisitProgram(program);

            //var stats = new PipelineStatistics();
            //ExecutionEngine.EliminateDeadVariablesAndInline(program);
            //var ret = ExecutionEngine.InferAndVerify(program, stats);
            //ExecutionEngine.printer.WriteTrailer(stats);
            //return;

            program = BoogieUtil.ReResolve(program, dbg ? expandedFileName : tmpFileName);

            // Run Abs
            if (dbg)
                Console.WriteLine("Running abs houdini on {0}", expandedFileName);

            ExecutionEngine.EliminateDeadVariables(program);
            ExecutionEngine.Inline(program);

            var domain = Microsoft.Boogie.Houdini.AbstractDomainFactory.GetInstance(absDomain);

            var abs = new Microsoft.Boogie.Houdini.AbsHoudini(program, domain);
            var outcome = abs.ComputeSummaries();
            if (outcome.outcome != VC.ConditionGeneration.Outcome.Correct)
            {
                Console.WriteLine("Some assert failed while running AbsHoudini, aborting");
                outcome.errors.Iter(error => og.PrintError(error));
            }

            return abs.GetAssignment();
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
