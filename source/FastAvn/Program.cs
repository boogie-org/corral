using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using btype = Microsoft.Boogie.Type;
using System.IO;
using System.Threading;
using System.Collections.Concurrent;

namespace FastAVN
{
    class Driver
    {
        static int approximationDepth = -1; // k-depth: default infinity
        static int blockingDepth = -1; // depth after which to block

        static int verbose = 1; // default verbosity level
        static bool createEntryPointBplsOnly = false; //if true stops fastavn after generating entrypoint bpls
        static bool mergeEntryPointBugsOnly = false; //if true then simply merges bugs present in all the entrypoint dirs
        static bool earlySplit = false; // split before AVH?

        static string avnPath = null; // path to AVN binary
        static string avHarnessInstrPath = null; // path to AVN harness instrumentation binary
        static readonly string bugReportFileName = "results.txt"; // default bug report filename produced by AVN
        static string avnArgs = ""; // AVN arguments
        static string avHarnessInstrArgs = ""; // harness instrumentation arguments
        static string mergedBugReportName = "bugs.txt";
        static string mergedBugReportCSV = "results.csv";
        static int numThreads = 4; // default number of parallel AVN instances
        static string angelic = "Angelic";
        static string trace_extension = ".tt";
        static string bug_folder = "Bugs";
        static string bug_filename = "Bug";
        static string angelic_stack = "stack";
        static string stack_extension = ".txt";
        static bool useMemNotDisk = false;
        static bool keepLongestTrace = false;
        static bool useProvidedEntryPoints = false;
        static bool onlyUseRootsAsEntryPoints = false;

        static DateTime startingTime = DateTime.Now;
        static volatile bool deadlineReached = false;
        static bool printingOutput = false;
        static int deadline = 0;
        static bool keepFiles = false;
        //include a procedure p if 
        //(ePP == null || p \in ePP) && (ePE == null || p \not\in ePE)
        static HashSet<string> entryPointProcs = null;
        static HashSet<string> entryPointExcludes = null; 

        static void Main(string[] args)
        {
            Console.CancelKeyPress += Console_CancelKeyPress;

            if (args.Length < 1)
            {
                Console.WriteLine("Usage: FastAVN file.bpl");
                return;
            }

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            if (args.Any(s => s == "/keepFiles"))
                Driver.keepFiles = true;

            if (args.Any(s => s == "/useMemNotDisk"))
                Driver.useMemNotDisk = true;

            args.Where(s => s.StartsWith("/aopt:"))
                .Iter(s => avnArgs += " /" + s.Substring("/aopt:".Length) + " ");

            args.Where(s => s.StartsWith("/hopt:"))
                .Iter(s => avHarnessInstrArgs += " /" + s.Substring("/hopt:".Length) + " ");

            if (args.Any(s => s == "/createEntrypointBplsOnly"))
                Driver.createEntryPointBplsOnly = true;

            if (args.Any(s => s == "/mergeEntrypointBugsOnly"))
                Driver.mergeEntryPointBugsOnly = true;

            if (args.Any(s => s == "/splitFirst"))
                Driver.earlySplit = true;

            if (args.Any(s => s == "/useEntryPoints"))
            {
                avHarnessInstrArgs += "/useEntryPoints ";
                useProvidedEntryPoints = true;
            }

            if (args.Any(s => s == "/onlyUseRootsAsEntryPoints"))
            {
                onlyUseRootsAsEntryPoints = true;
            }

            if (args.Any(s => s == "/keepLongestTrace"))
                Driver.keepLongestTrace = true;
            
            // user definded verbose level
            args.Where(s => s.StartsWith("/verbose:"))
                .Iter(s => verbose = int.Parse(s.Substring("/verbose:".Length)));

            // depth k used by implementation pruning
            args.Where(s => s.StartsWith("/angelicAfterDepth:"))
                .Iter(s => approximationDepth = int.Parse(s.Substring("/angelicAfterDepth:".Length)));

            // depth k used by implementation pruning
            args.Where(s => s.StartsWith("/blockAfterDepth:"))
                .Iter(s => blockingDepth = int.Parse(s.Substring("/blockAfterDepth:".Length)));

            args.Where(s => s.StartsWith("/numThreads:"))
                .Iter(s => numThreads = int.Parse(s.Substring("/numThreads:".Length)));

            args.Where(s => s.StartsWith("/killAfter:"))
                .Iter(s => deadline = int.Parse(s.Substring("/killAfter:".Length)));

            args.Where(s => s.StartsWith("/entryPointProc:"))
                .Iter(s =>
                    {
                        if (entryPointProcs == null) { entryPointProcs = new HashSet<string>(); }
                        entryPointProcs.Add(s.Substring("/entryPointProc:".Length));
                    });
            args.Where(s => s.StartsWith("/entryPointExcludes:"))
                .Iter(s =>
                {
                    if (entryPointExcludes == null) { entryPointExcludes = new HashSet<string>(); }
                    entryPointExcludes.Add(s.Substring("/entryPointExcludes:".Length));
                });

            // default args
            avnArgs += " /dumpResults:" + bugReportFileName + " ";
            avnArgs = " /EE:onlySlicAssumes+ /EE:ignoreAllAssumes- " + avnArgs;

            // Find AVN executable
            avnPath = findExe("AngelicVerifier.exe");
            avHarnessInstrPath = findExe("AvHarnessInstrumentation.exe");

            Debug.Assert(avnPath != null && avHarnessInstrPath != null, "Cannot find executables");
            Debug.Assert(blockingDepth < 0 || approximationDepth < 0, "Cannot do both blockingDepth and angelicDepth");

            try
            {
                if (Directory.Exists(bug_folder))
                {
                    Utils.Print(string.Format("WARNING!! Removing {0} folder", bug_folder));
                    Directory.Delete(Path.Combine(Directory.GetCurrentDirectory(), bug_folder), true);
                }
            }
            catch(IOException)
            {
                Utils.Print(string.Format("ERROR removing folder {0}", bug_folder));
            }

            try
            {
                Stats.resume("fastavn");

                if (Driver.mergeEntryPointBugsOnly)
                {
                    // collate bugs
                    printingOutput = true;
                    HashSet<string> epNames = new HashSet<string>(Directory.GetDirectories(@"."));
                    epNames = new HashSet<string>(epNames.Select(s => Path.GetFileName(s)));
                    printBugs(ref mergedBugs, epNames.Count);
                    mergeBugs(epNames);

                    return;
                }

                // Get input program
                Utils.Print(String.Format("----- Run FastAVN on {0} with k={1} ------",
                    args[0], approximationDepth), Utils.PRINT_TAG.AV_OUTPUT);

                // initialize corral and boogie for fastAVN
                InitializeCorralandBoogie();

                var inputfile = args[0];
                var entrypoints = new HashSet<string>();
                Program program;

                if (!earlySplit)
                {
                                    
                    if (entryPointProcs != null)
                    {
                        entryPointProcs.Iter(s => avHarnessInstrArgs += string.Format("/entryPointProc:{0} ", s));
                    }
                    if (entryPointExcludes != null)
                    {
                        entryPointExcludes.Iter(s => avHarnessInstrArgs += string.Format("/entryPointExcludes:{0} ", s));
                    }

                    // Run harness instrumentation    
                    var resultfile = Path.Combine(Directory.GetCurrentDirectory(), "hinst.bpl");
                    var hinstOut = RemoteExec.run(Directory.GetCurrentDirectory(), avHarnessInstrPath, string.Format("{0} \"{1}\" {2}", inputfile, resultfile, avHarnessInstrArgs));                    

                    hinstOut.Iter(s => Console.WriteLine("[hinst] {0}", s));

                    if (!File.Exists(resultfile))
                        throw new Exception("Error running harness instrumentation");

                    program = BoogieUtil.ReadAndOnlyResolve(resultfile);

                    // Do a run on instrumented program, filter out entrypoints
                    var entrypoint_impl = program.TopLevelDeclarations.OfType<Implementation>()
                        .Where(impl => QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                        .FirstOrDefault();
                    Debug.Assert(entrypoint_impl != null);

                    // other entrypoints can never reach an assertion, don't run AVN on them
                    foreach (Block b in entrypoint_impl.Blocks)
                    {
                        b.Cmds.OfType<CallCmd>()
                            .Where(cc => QKeyValue.FindBoolAttribute(cc.Attributes, AvUtil.AvnAnnotations.AvhEntryPointAttr))
                            .Iter(cc => entrypoints.Add(cc.callee));
                    }
                }
                else
                {
                    program = BoogieUtil.ReadAndOnlyResolve(inputfile);
                    program.TopLevelDeclarations.OfType<Implementation>()
                        .Where(impl => !useProvidedEntryPoints || QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint") || QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                        .Iter(impl => entrypoints.Add(impl.Name));

                    var mayReach = 
                        BoogieUtil.procsThatMaySatisfyPredicate(program, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));

                    entrypoints.IntersectWith(mayReach);
                }

                // do reachability analysis on procedures
                RunAVN(program, entrypoints);

                Stats.stop("fastavn");
                Stats.printStats();
            }
            catch (Exception e)
            {
                //stacktrace containts source locations, confuses regressions that looks for AV_OUTPUT
                Utils.Print(String.Format("FastAVN failed with: {0}", e.Message), Utils.PRINT_TAG.AV_OUTPUT);
                Utils.Print(String.Format("FastAVN failed with: {0}", e.Message + e.StackTrace), Utils.PRINT_TAG.AV_DEBUG);
            }
        }

        static void FastSplit(string file)
        {
            var start_time = DateTime.Now;

            ReportTimeAndMemory(start_time, "Start");

            var program = BoogieUtil.ParseProgram(file);

            ReportTimeAndMemory(start_time, "Parsed");

            var procs = BoogieUtil.procsThatMaySatisfyPredicate(program, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));
            program.RemoveTopLevelDeclarations(decl => (decl is Implementation) && !procs.Contains((decl as Implementation).Name));

            ReportTimeAndMemory(start_time, "Pruned");

            var cg = BoogieUtil.GetCallGraph(program);

            ReportTimeAndMemory(start_time, "CG");

            Console.WriteLine("#Procs: {0}", procs.Count);
            Console.WriteLine("#Nodes: {0}", cg.Nodes.Count);

            var i = 0;
            foreach (var proc in procs)
            {
                i++; if (i == 100) break;
                Console.Write("Proc {0}", proc);
                var reachable = BoogieUtil.GetReachableNodes(proc, cg);
                Console.WriteLine("   {0}", reachable.Count);

                var newProgram = new Program();
                newProgram.AddTopLevelDeclarations(program.TopLevelDeclarations.Where(decl => !(decl is Implementation) ||
                    !reachable.Contains((decl as Implementation).Name)));



                BoogieUtil.PrintProgram(newProgram, "tmp" + i.ToString() + ".bpl");

                ReportTimeAndMemory(start_time, "Prog " + i.ToString());
            }

        }
        static void ReportMemory(string msg = "")
        {
            Console.WriteLine("Memory{0}: {1} MB", msg == "" ? "" : " " + msg, (GC.GetTotalMemory(true) * 1.0 / (1024 * 1024)).ToString("F2"));
        }

        static void ReportTime(DateTime start, string msg = "")
        {
            Console.WriteLine("Elapsed time{0}: {1} seconds", msg == "" ? "" : " " + msg, (DateTime.Now - start).TotalSeconds.ToString("F2"));
        }

        static void ReportTimeAndMemory(DateTime start, string msg = "")
        {
            ReportTime(start, msg);
            ReportMemory(msg);
        }


        private static void InitializeCorralandBoogie()
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
        }

        // locate binary in the system
        private static string findExe(string exe)
        {
            string ret = null;
            var runDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            if (!File.Exists(Path.Combine(runDir, exe)))
            {
                var enviromentPath = System.Environment.GetEnvironmentVariable("PATH"); // look up in PATH
                var paths = enviromentPath.Split(';');
                ret = paths.Select(x => Path.Combine(x, exe))
                    .Where(x => File.Exists(x))
                    .FirstOrDefault();

                if (string.IsNullOrWhiteSpace(avnPath))
                    throw new FileNotFoundException("Cannot find executable: " + exe);
            }
            else
            {
                ret = Path.Combine(runDir, exe);
            }
            Utils.Print(String.Format("Found {0} at: {1}", exe, ret));

            return ret;
        }

        static ConcurrentBag<string> Shuffle(ConcurrentBag<string> bag)
        {
            var b = new List<string>(bag);
            var ret = new ConcurrentBag<string>();
            var rand = new Random();
            while (b.Count != 0)
            {
                var r = rand.Next(b.Count);
                ret.Add(b[r]);
                b.RemoveAt(r);
            }
            return ret;
        }

        public static ConcurrentDictionary<string, int> mergedBugs = new ConcurrentDictionary<string, int>();
        public static string fslock = "FileSystemLock";
        public static readonly bool debug = false;

        // static program information (!eagerSplit)
        public static Dictionary<string, HashSet<string>> edges = null;
        // static program information (eagerSplit)
        public static Microsoft.Boogie.GraphUtil.Graph<string> CallGraph = null;
        public static Dictionary<Declaration, HashSet<string>> DeclToGlobalsUsed = null;
        public static Dictionary<Declaration, HashSet<string>> DeclToFunctionsUsed = null;

        /// <summary>
        /// Run AVN binary on sliced programs
        /// </summary>
        /// <param name="prog">Original program</param>
        private static void RunAVN(Program prog, HashSet<string> epNames)
        {
            if(epNames.Count == 0)
            {
                Console.WriteLine("No entrypoints. All verified.");
                //SDV needs to see Merge ... to trust Fastavn did not crash
                // collate bugs
                printingOutput = true;
                printBugs(ref mergedBugs, 0);
                mergeBugs(new HashSet<string>());

                return;
            }

            // compute and stash some common information
            if (!earlySplit)
            {
                edges = buildCallGraph(prog);
            }
            else
            {
                CallGraph = BoogieUtil.GetCallGraph(prog);
                // for populating pred/succ cache
                CallGraph.Successors(CallGraph.Nodes.First());

                // function call graph
                var funcCallGraph = new Microsoft.Boogie.GraphUtil.Graph<string>();
                prog.TopLevelDeclarations.OfType<Function>()
                    .Iter(f => funcCallGraph.Nodes.Add(f.Name));

                foreach(var func in prog.TopLevelDeclarations.OfType<Function>())
                {
                    if (func.Body == null) continue;
                    var vu = new VarsUsed();
                    vu.VisitExpr(func.Body);
                    vu.functionsUsed.Iter(used => funcCallGraph.AddEdge(func.Name, used));
                }

                DeclToFunctionsUsed = new Dictionary<Declaration, HashSet<string>>();
                DeclToGlobalsUsed = new Dictionary<Declaration, HashSet<string>>();

                foreach (var decl in prog.TopLevelDeclarations)
                {
                    var vu = new VarsUsed();
                    vu.VisitDeclaration(decl);

                    DeclToGlobalsUsed.Add(decl, vu.globalsUsed);
                    DeclToFunctionsUsed.Add(decl, BoogieUtil.GetReachableNodes<string>(vu.functionsUsed, funcCallGraph));
                }
            }

            var matchesEntryPointExclude = new Func<string, bool>(s =>
            {
                return entryPointExcludes.Any(t => new System.Text.RegularExpressions.Regex(t).IsMatch(s)); 
            });

            //only roots 
            HashSet<string> nonRootImpls = null;
            if (onlyUseRootsAsEntryPoints)
            {
                nonRootImpls = new HashSet<string>();
                if (!earlySplit)
                {
                    edges.Iter(x => x.Value.Iter(y => nonRootImpls.Add(y)));
                }
                else {
                    CallGraph.Edges.Iter(x => nonRootImpls.Add(x.Item2));
                }
            }

            // entrypoints
            var entrypoints = new ConcurrentBag<Implementation>(prog.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => epNames.Contains(impl.Name))
                .Where(impl => entryPointProcs == null || entryPointProcs.Contains(impl.Name))
                .Where(impl => entryPointExcludes == null || !matchesEntryPointExclude(impl.Name))
                .Where(impl => nonRootImpls == null || !nonRootImpls.Contains(impl.Name)));

            if(entrypoints.Count == 0)
            {
                Console.WriteLine("No entrypoints... All verified.");
                //SDV needs to see Merge ... to trust Fastavn did not crash
                // collate bugs
                printingOutput = true;
                printBugs(ref mergedBugs, 0);
                mergeBugs(new HashSet<string>());
                return;
            }

            // deadline
            if (deadline > 0)
            {
                deadline = deadline - (int)((DateTime.Now - startingTime).TotalSeconds + 0.5);
                if (deadline < 0) deadline = 1;
            }

            if (deadline > 100)
            {
                var timer = new System.Timers.Timer((deadline - 100) * 1000);
                timer.Elapsed += (sender, e) => HandleTimer(epNames);
                timer.Start();
            }
            else if (deadline != 0)
            {
                Console.WriteLine("Ignoring small deadline of {0} seconds", deadline);
            }

            var threads = new List<Thread>();
            for (int i = 0; i < numThreads; i++)
            {
                var w = new Worker(prog, entrypoints);
                if(!earlySplit)
                    threads.Add(new Thread(new ThreadStart(w.RunSplitAndAv)));
                else
                    threads.Add(new Thread(new ThreadStart(w.RunSplitAndAvhAndAv)));
            }

            threads.Iter(t => t.Start());
            threads.Iter(t => t.Join());

            if (Driver.createEntryPointBplsOnly)
            {
                Console.WriteLine("Early exit due to /createEntryPointBplsOnly");
                return;
            }

            lock (fslock)
            {
                epNames = new HashSet<string>(Worker.DirsCreated);

                if (printingOutput) return;
                printingOutput = true;
                printBugs(ref mergedBugs, epNames.Count);
                mergeBugs(epNames);
            }
        }

        public static void HandleTimer(HashSet<string> epNames)
        {
            deadlineReached = true;
            var killed = KillSpawnedProcesses();
            killed += (epNames.Count - Worker.DirsCreated.Count);

            Console.WriteLine("FastAvn deadline reached; consolidating results");
            Console.WriteLine("Stopping approximately {0} instances of AV", killed);
        
            // Sleep for 5 seconds
            System.Threading.Thread.Sleep(5 * 1000);

            // collate bugs
            lock (fslock)
            {
                if (printingOutput) return;
                printingOutput = true;
                printBugs(ref mergedBugs, epNames.Count);
                mergeBugs(epNames);
            }

            // Kill self
            Process.GetCurrentProcess().Kill();
        }


        class Worker
        {
            ConcurrentBag<Implementation> impls;
            public static ConcurrentBag<string> DirsCreated = new ConcurrentBag<string>();
            HashSet<string> implNames;
            Program program;
            static string counter_lock = "counter_lock";
            static int trunc_counter = 0;

            public Worker(Program program, ConcurrentBag<Implementation> impls)
            {
                this.program = program; 
                this.impls = impls;
                this.implNames = new HashSet<string>();
                impls.Iter(im => implNames.Add(im.Name));
            }

            public void RunSplitAndAv()
            {
                Implementation impl;

                while (true)
                {
                    if (!impls.TryTake(out impl)) { break; }

                    var name = impl.Name;
                    // clash of lower-case names?
                    if (implNames.Any(s => s != impl.Name && s.ToLower() == impl.Name.ToLower()))
                    {
                        lock (counter_lock)
                        {
                            name = string.Format("{0}_{1}", name, trunc_counter);
                            trunc_counter++;
                        }
                    }

                    var tp = TruncatePath(name);
                    var wd = Path.Combine(Environment.CurrentDirectory, tp);
                    
                    DirsCreated.Add(tp);

                    Directory.CreateDirectory(wd); // create new directory for each entrypoint
                    RemoteExec.CleanDirectory(wd);
                    var pruneFile = Path.Combine(wd, "pruneSlice.bpl");
                    Program newprogram;

                    // Each entrypoint should have its own copy of program
                    if (useMemNotDisk)
                    {
                        newprogram = BoogieUtil.ReResolveInMem(program);
                    }
                    else
                    {
                        BoogieUtil.PrintProgram(program, pruneFile);
                        newprogram = BoogieUtil.ReadAndOnlyResolve(pruneFile);
                    }

                    // slice the program by entrypoints
                    Program shallowP = pruneDeepProcs(newprogram, ref edges, impl.Name, approximationDepth, implNames);
                    BoogieUtil.pruneProcs(shallowP,
                        shallowP.TopLevelDeclarations.OfType<Procedure>()
                        .Where(proc => BoogieUtil.checkAttrExists("entrypoint", proc.Attributes))
                        .Select(proc => proc.Name)
                        .FirstOrDefault());

                    File.Delete(pruneFile);
                    BoogieUtil.PrintProgram(shallowP, pruneFile); // dump sliced program

                    if (Driver.createEntryPointBplsOnly)
                    {
                        Console.WriteLine("Skipping AVN run for {0} given /createEntrypointBplsOnly", impl.Name);
                        continue;
                    }

                    Console.WriteLine("Running entrypoint {0} locally {{", impl.Name);

                    if (deadlineReached) return;

                    // spawn the job -- local
                    var output = RemoteExec.run(wd, avnPath, string.Format("\"{0}\" {1}", pruneFile, avnArgs));

                    PostProcess(impl.Name, wd, output);
                }                
            }

            public void RunSplitAndAvhAndAv()
            {
                Implementation impl;

                while (true)
                {
                    if (!impls.TryTake(out impl)) { break; }

                    var name = impl.Name;
                    // clash of lower-case names?
                    if (implNames.Any(s => s != impl.Name && s.ToLower() == impl.Name.ToLower()))
                    {
                        lock (counter_lock)
                        {
                            name = string.Format("{0}_{1}", name, trunc_counter);
                            trunc_counter++;
                        }
                    }

                    var tp = TruncatePath(name);
                    var wd = Path.Combine(Environment.CurrentDirectory, tp);
                    DirsCreated.Add(tp);

                    Directory.CreateDirectory(wd); // create new directory for each entrypoint
                    RemoteExec.CleanDirectory(wd);
                    var pruneFile = Path.Combine(wd, "pruneSlice.bpl");

                    var initProc = program.TopLevelDeclarations.OfType<Implementation>()
                        .Where(im => QKeyValue.FindBoolAttribute(im.Attributes, AvUtil.AvnAnnotations.InitialializationProcAttr))
                        .FirstOrDefault();

                    var reachable = BoogieUtil.GetReachableNodes(impl.Name, CallGraph);
                    if (initProc != null) reachable.UnionWith(BoogieUtil.GetReachableNodes(initProc.Name, CallGraph));

                    var newprogram = new Program();

                    newprogram.AddTopLevelDeclarations(program.TopLevelDeclarations.Where(decl => !(decl is Implementation) ||
                        reachable.Contains((decl as Implementation).Name)));

                    // Prune program
                    var cutoff = approximationDepth < 0 ? blockingDepth : approximationDepth;
                    if (cutoff > 0)
                    {
                        var pruneAway = ProcsAfterDepth(impl.Name, cutoff);
                        if (initProc != null)
                        {
                            BoogieUtil.GetReachableNodes(initProc.Name, CallGraph)
                                .Iter(s => pruneAway.Remove(s));
                        }

                        Debug.Assert(!pruneAway.Contains(impl.Name));

                        if (blockingDepth > 0)
                        {
                            // add assume false
                            var pimpls = new HashSet<Implementation>(newprogram.TopLevelDeclarations.OfType<Implementation>()
                                .Where(i => pruneAway.Contains(i.Name)));
                            foreach (var i in pimpls)
                            {
                                var fd = new FixedDuplicator(false);
                                var copy = fd.VisitImplementation(i);
                                copy.Blocks.Clear();
                                copy.Blocks.Add(new Block(Token.NoToken, "start",
                                    new List<Cmd> { BoogieAstFactory.MkAssume(Expr.False) },
                                    new ReturnCmd(Token.NoToken)));
                                newprogram.RemoveTopLevelDeclaration(i);
                                newprogram.AddTopLevelDeclaration(copy);
                            }
                        }
                        else
                        {
                            // delete the impl
                            newprogram.RemoveTopLevelDeclarations(decl => decl is Implementation &&
                                pruneAway.Contains((decl as Implementation).Name));
                        }
                    }

                    var topLevelProcs = new HashSet<string> { impl.Name };
                    if(initProc != null) topLevelProcs.Add(initProc.Name);    

                    BoogieUtil.pruneProcs(newprogram, topLevelProcs);

                    // Remove unnecessary decls
                    var globalsUsed = new HashSet<string>();
                    var functionsUsed = new HashSet<string>();
                    newprogram.TopLevelDeclarations.Where(decl => !(decl is GlobalVariable) && !(decl is Function))
                        .Iter(decl =>
                        {
                            if(DeclToGlobalsUsed.ContainsKey(decl))
                                globalsUsed.UnionWith(DeclToGlobalsUsed[decl]);
                            if(DeclToFunctionsUsed.ContainsKey(decl))
                                functionsUsed.UnionWith(DeclToFunctionsUsed[decl]);
                        });

                    newprogram.RemoveTopLevelDeclarations(decl => decl is GlobalVariable
                        && !globalsUsed.Contains((decl as GlobalVariable).Name));
                    newprogram.RemoveTopLevelDeclarations(decl => decl is Function
                        && !functionsUsed.Contains((decl as Function).Name));

                    Console.WriteLine("Running entrypoint {0} ({1} procs) {{", impl.Name,
                        newprogram.TopLevelDeclarations.OfType<Implementation>().Count());

                    var mayReach =
                        BoogieUtil.procsThatMaySatisfyPredicate(newprogram, cmd => (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd)));

                    if (!mayReach.Contains(impl.Name))
                    {
                        PostProcess(impl.Name, wd, new List<string> { "Assert not reachable" });
                        continue;
                    }

                    // make a copy of impl.Proc
                    var dup = new FixedDuplicator(true);
                    var implProcCopy = dup.VisitProcedure(impl.Proc);
                    // Mark entrypoint
                    implProcCopy.AddAttribute("entrypoint");

                    newprogram.RemoveTopLevelDeclaration(impl.Proc);
                    newprogram.AddTopLevelDeclaration(implProcCopy);

                    BoogieUtil.PrintProgram(newprogram, pruneFile); // dump sliced program

                    if (Driver.createEntryPointBplsOnly)
                    {
                        Console.WriteLine("Running entrypoint {0} }}", impl.Name);

                        Console.WriteLine("Skipping AVN run for {0} given /createEntrypointBplsOnly", impl.Name);
                        continue;
                    }

                    if (deadlineReached) return;

                    // spawn AVH
                    var resultfile = Path.Combine(wd, "hinst.bpl");
                    var hinstOut = RemoteExec.run(wd, avHarnessInstrPath, string.Format("\"{0}\" \"{1}\" {2} /entryPointProc:{3}", pruneFile, resultfile, avHarnessInstrArgs, impl.Name));
                    for (int i = 0; i < hinstOut.Count; i++)
                        hinstOut[i] = "[hinst] " + hinstOut[i];

                    List<string> output;

                    if (File.Exists(resultfile))
                    {
                        // spawn AV
                        output = RemoteExec.run(wd, avnPath, string.Format("\"{0}\" {1}", resultfile, avnArgs));
                    }
                    else
                    {
                        output = new List<string>();
                        output.Add("Error running AvH. Output not found.");
                    }

                    PostProcess(impl.Name, wd, hinstOut.Concat(output));
                }
            }

            static string TruncatePath(string implName)
            {
                if (implName.Length > 70)
                {
                    int cnt = 0;
                    // prevent long file names
                    lock (counter_lock)
                    {
                        cnt = trunc_counter;
                        trunc_counter++;
                    }

                    var prefix = implName.Substring(0, 70);
                    prefix += "trunc_" + cnt;
                    return prefix;
                }

                return implName;
            }

            // Do BFS. Return all procs with shortest distance > depth
            static HashSet<string> ProcsAfterDepth(string root, int depth)
            {
                var reachable = new HashSet<string>{ root };
                var currdepth = 0;

                var frontier = new HashSet<string>();
                frontier.UnionWith(reachable);

                while (frontier.Count != 0 && currdepth < depth)
                {
                    currdepth++;

                    var next = new HashSet<string>();
                    frontier.Iter(s => next.UnionWith(CallGraph.Successors(s)));

                    frontier = next.Difference(reachable);
                    reachable.UnionWith(next);
                }

                var nodes = new HashSet<string>(CallGraph.Nodes);
                nodes.ExceptWith(reachable);

                return nodes;
            }

            static void PostProcess(string impl, string wd, IEnumerable<string> output)
            {
                lock (fslock)
                {
                    // delete temp files
                    if (!keepFiles)
                    {
                        var files = System.IO.Directory.GetFiles(wd, "*.bpl");
                        foreach (var f in files)
                            System.IO.File.Delete(f);
                    }

                    using (StreamWriter sw = new StreamWriter(Path.Combine(wd, "stdout.txt")))
                        output.Iter(s => sw.WriteLine("{0}", s));
                }

                Console.WriteLine("Running entrypoint {0} }}", impl);

                lock (fslock)
                {
                    // collect and merge bugs
                    var bugs = collectBugs(Path.Combine(wd, bugReportFileName));
                    bugs.Iter(b =>
                    {
                        if (!mergedBugs.ContainsKey(b)) mergedBugs[b] = 0;
                        mergedBugs[b] += 1;
                    });
                    Utils.Print(string.Format("Bugs found so far: {0}", mergedBugs.Count));
                }

            }


        }

        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            Console.WriteLine("Got Ctrl-C");

            KillSpawnedProcesses();

            System.Diagnostics.Process.GetCurrentProcess()
                .Kill();
        }

        public static int KillSpawnedProcesses()
        {
            var killed = 0;
            lock (RemoteExec.SpawnedProcesses)
            {
                killed = RemoteExec.SpawnedProcesses.Count;
                foreach (var p in RemoteExec.SpawnedProcesses)
                    p.Kill();
                RemoteExec.SpawnedProcesses.Clear();
            }
            return killed;
        }

        class TraceInfo
        {
            public int metric_value;
            public List<Tuple<string, string>> traces;

            public TraceInfo()
            {
                metric_value = 0;
                traces = new List<Tuple<string, string>>();
            }
        }

        private static void mergeBugs(HashSet<string> entryPoints)
        {
            bool dbg = false;
            var sep = "###";
            // failing location -> TraceInfo
            var shortest_trace = new Dictionary<string, TraceInfo>();

            foreach (string impl in entryPoints)
            {
                if (!Directory.Exists(Path.Combine(Directory.GetCurrentDirectory(), impl))) continue;

                Stats.count("#EntryPoints");

                string result_file = Path.Combine(Directory.GetCurrentDirectory(), impl, bugReportFileName);
                if (dbg) Utils.Print(string.Format("Result File -> {0}", result_file), Utils.PRINT_TAG.AV_DEBUG);

                // (assert, metric, inconsistencySet, trace_file, stack_file)
                var traces = new List<Tuple<string, int, int, string, string>>();

                try
                {
                    foreach (string line in File.ReadLines(result_file))
                    {
                        if (line.StartsWith("Description"))
                            continue;
                        if (line.Contains("mustFail") && !line.Contains("notmustFail"))
                            continue;
                        // extract line from bug report but ignore the entrypoint info
                        var tokens = line.Split(',');
                        string bug_info = tokens.Where((s, i) => i < tokens.Length - 2).Concat(",");

                        var traceNumTokens = tokens.Last().Split('.');
                        var inconsistencyNum = traceNumTokens.Length == 2 ? Int32.Parse(traceNumTokens[0]) : -1;

                        string file_name = angelic + tokens.Last() + trace_extension;
                        string stack_filename = angelic + tokens.Last() + angelic_stack + stack_extension;
                        string trace_file = Path.Combine(Directory.GetCurrentDirectory(), impl, file_name);
                        string stack_file = Path.Combine(Directory.GetCurrentDirectory(), impl, stack_filename);
                        int metric = getMetric(trace_file);

                        if (dbg) Utils.Print(string.Format("Bug File -> {0} {1}", bug_info, trace_file), Utils.PRINT_TAG.AV_DEBUG);
                        if (dbg) Utils.Print(string.Format("Metric -> {0}", metric), Utils.PRINT_TAG.AV_DEBUG);

                        traces.Add(Tuple.Create(bug_info, metric, inconsistencyNum, trace_file, stack_file));
                    }

                }
                catch (FileNotFoundException)
                {
                    Utils.Print(string.Format("Bug report file not found: {0}", result_file));
                }
                catch (Exception e)
                {
                    Utils.Print(string.Format("Error when processing bug report: {0}", result_file));
                    Console.WriteLine(e.Message);
                    Console.WriteLine(e.StackTrace);
                }

                // inconsistencySet -> asserts
                var inconsistencySetAsserts = new Dictionary<int, List<string>>();
                // inconsistencySet -> TraceInfo
                var inconsistencySetTraceInfo = new Dictionary<int, TraceInfo>();

                foreach (var tup in traces.Where(t => t.Item3 >= 0))
                {
                    if (!inconsistencySetAsserts.ContainsKey(tup.Item3))
                    {
                        inconsistencySetAsserts.Add(tup.Item3, new List<string>());
                        inconsistencySetTraceInfo.Add(tup.Item3, new TraceInfo());
                    }
                    inconsistencySetAsserts[tup.Item3].Add(tup.Item1);
                    inconsistencySetTraceInfo[tup.Item3].metric_value += tup.Item2;
                    inconsistencySetTraceInfo[tup.Item3].traces.Add(Tuple.Create(tup.Item4, tup.Item5));
                }
                inconsistencySetAsserts.Iter(tup => tup.Value.Sort());

                // merge non-inconsistency bugs
                foreach (var tup in traces.Where(t => t.Item3 < 0))
                {
                    var tinfo = new TraceInfo();

                    if (!shortest_trace.ContainsKey(tup.Item1))
                    {
                        tinfo.metric_value = tup.Item2;
                        tinfo.traces.Add(Tuple.Create(tup.Item4, tup.Item5));
                        shortest_trace.Add(tup.Item1, tinfo);
                    }
                    else if (shortest_trace[tup.Item1].metric_value > tup.Item2)
                    {
                        shortest_trace[tup.Item1].metric_value = tup.Item2;
                        shortest_trace[tup.Item1].traces = new List<Tuple<string, string>> { Tuple.Create(tup.Item4, tup.Item5) };
                    }
                    continue;
                }



                // merge inconsistency bugs
                foreach (var tup in inconsistencySetAsserts)
                {
                    // check if any strict assert-subset already exists
                    var discard = false;
                    var assertSet = tup.Value;
                    var prefix = "";
                    for (int i = 0; i < assertSet.Count - 1; i++)
                    {
                        prefix += assertSet[i] + sep;
                        if (shortest_trace.ContainsKey(prefix))
                        {
                            discard = true;
                            break;
                        }
                    }

                    if (discard)
                    {
                        continue;
                    }

                    prefix += assertSet[assertSet.Count - 1];
                    if (!shortest_trace.ContainsKey(prefix))
                    {
                        shortest_trace.Add(prefix, inconsistencySetTraceInfo[tup.Key]);
                    }
                    else if (shortest_trace[prefix].metric_value > inconsistencySetTraceInfo[tup.Key].metric_value)
                    {
                        shortest_trace[prefix] = inconsistencySetTraceInfo[tup.Key];
                    }
                }
            }

            string trace_path = Path.Combine(Directory.GetCurrentDirectory(), bug_folder);
            int index = 0;
            Directory.CreateDirectory(bug_folder);

            var ToMsg = new Func<HashSet<int>, string>(hs =>
            {
                var msg = string.Format("Inconsistency Bug Set: {{ {0} }}", hs.Select(i => i.ToString()).Concat(","));
                return msg.Replace(' ', '_');
            });

            index = 0;
            foreach (string bug in shortest_trace.Keys)
            {
                var inconsistencySet = new HashSet<int>();
                if (shortest_trace[bug].traces.Count > 1)
                {
                    for (int i = 0; i < shortest_trace[bug].traces.Count; i++)
                        inconsistencySet.Add(index + i);
                }

                foreach (var tup in shortest_trace[bug].traces)
                {
                    string file_name = bug_filename + index.ToString() + trace_extension;
                    string stack_filename = bug_filename + index.ToString() + angelic_stack + stack_extension;
                    try
                    {
                        File.Copy(tup.Item1, Path.Combine(trace_path, file_name));
                        File.Copy(tup.Item2, Path.Combine(trace_path, stack_filename));
                        // create another copy of the buggy trace (for easy viewing with SDV)
                        var subdir = string.Format("Bug{0}", index);
                        Directory.CreateDirectory(Path.Combine(bug_folder, subdir));
                        if (inconsistencySet.Count == 0)
                        {
                            File.Copy(tup.Item1, Path.Combine(trace_path, subdir, "defect.tt"));
                        }
                        else
                        {
                            var msg = ToMsg(inconsistencySet);
                            var lines = File.ReadAllLines(tup.Item1);
                            for (int i = 0; i < lines.Length; i++)
                            {
                                lines[i] = lines[i].Replace("====Auto=====", "====Auto=====^" + msg);
                            }
                            File.WriteAllLines(Path.Combine(trace_path, subdir, "defect.tt"), lines);
                        }
                    }
                    catch (FileNotFoundException)
                    {
                        Utils.Print(string.Format("Trace file not found: {0}", tup.Item1));
                    }
                    index++;
                }
            }

            using (StreamWriter bugReportWriter = new StreamWriter(Path.Combine(Directory.GetCurrentDirectory(), mergedBugReportCSV)))
            {
                bugReportWriter.WriteLine("Description,Src File,Line,Procedure,Fail Status");
                foreach (string bug in shortest_trace.Keys)
                {
                    Stats.count("#Bugs");
                    var report = bug.Replace(sep, Environment.NewLine);
                    bugReportWriter.WriteLine(report);
                }
            }
        }

        private static int getMetric(string trace_file)
        {
            int num_lines = 0;

            try
            {
                foreach (string line in File.ReadLines(trace_file)) num_lines++;
            }

            catch (FileNotFoundException)
            {
                Utils.Print(string.Format("Trace file not found: {0}", trace_file));
            }
            catch (Exception e)
            {
                Utils.Print(string.Format("Error while processing trace file: {0}", trace_file));
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }

            return num_lines;
        }

        private static Dictionary<string, HashSet<string>> buildCallGraph(Program prog)
        {
            // build the call graph once
            var edges = new Dictionary<string, HashSet<string>>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;

                Stats.count("impl.count");
                edges.Add(impl.Name, new HashSet<string>());
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<CallCmd>()
                        .Iter(ccmd => edges[impl.Name].Add(ccmd.callee));
                    blk.Cmds.OfType<ParCallCmd>()
                        .Iter(pcmd => pcmd.CallCmds
                            .Iter(ccmd => edges[impl.Name].Add(ccmd.callee)));
                }
            }
            return edges;
        }

        // output merged bug report to console
        private static void printBugs(ref ConcurrentDictionary<string, int> mergedBugs, int numEntries)
        {
            using (StreamWriter bugReport = new StreamWriter(
                Path.Combine(Directory.GetCurrentDirectory(),
                mergedBugReportName)))
            {
                Utils.Print(string.Format("========= Merged Bugs for {0} Entry Points =========", numEntries),
                    Utils.PRINT_TAG.AV_OUTPUT);
                Utils.Print("Description,Src File,Line,Procedure,Fail Status", Utils.PRINT_TAG.AV_OUTPUT);
                bugReport.WriteLine("Description,Src File,Line,Procedure,Fail Status");
                foreach (string bug in mergedBugs.Keys)
                {
                    if (bug.Contains("mustFail") && !bug.Contains("notmustFail")) continue;
                    Utils.Print(string.Format("Bug: {0} Count: {1}", bug, mergedBugs[bug]), Utils.PRINT_TAG.AV_OUTPUT);
                    bugReport.WriteLine(bug);
                }
            }
        }

        // collect bug from the bug report file produce by AVN
        private static HashSet<string> collectBugs(string p)
        {
            HashSet<string> ret = new HashSet<string>();
            try
            {
                foreach (string line in File.ReadLines(p))
                {
                    if (line.StartsWith("Description"))
                        continue;
                    // extract line from bug report
                    ret.Add(line);
                }
            }
            catch (FileNotFoundException)
            {
                Utils.Print(string.Format("Bug report file not found: {0}", p));
            }
            catch (Exception e)
            {
                Utils.Print(string.Format("Error when processing bug report: {0}", p));
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }

            return ret;
        }

        // process AVN console output
        // TODO: collect individual stats for AVN run
        private static void readAVNOutput(string output)
        {
            foreach (string line in output.Split('\n'))
            {
                if (verbose >= 1 && numThreads <= 1)
                    // disable printing when running mutiple threads
                    Console.WriteLine(line);
                if (!line.StartsWith("[TAG: AV_STATS]"))
                    continue;
            }
        }

        /**
         * Prune by removing implementations that are not called within depth k (k>=0)
         * When k < 0, only prune implementations that are never called
         * Leave corralExtraInint alone.
        */
        private static Program pruneDeepProcs(Program origProgram,
            ref Dictionary<string, HashSet<string>> edges,
            string mainProcName, int k, HashSet<string> implNames)
        {
            if (mainProcName == null)
                return origProgram;

            // delete all calls in CorralMain other than mainProcName
            mainProcName = sliceMainForProc(origProgram, mainProcName, implNames);

            var boundedDepth = (k >= 0); // do we have a bounded depth

            Program program = (new FixedDuplicator(false)).VisitProgram(origProgram);
            Procedure malloc = FindMalloc(program);

            var reachable = new HashSet<string>();
            reachable.Add(mainProcName);

            var delta = new HashSet<string>(reachable);
            while (delta.Count != 0 && (!boundedDepth || k-- > 0))
            {
                var nf = new HashSet<string>();
                foreach (var n in delta)
                {
                    if (edges.ContainsKey(n)) nf.UnionWith(edges[n]);
                }
                delta = nf.Difference(reachable);
                reachable.UnionWith(nf);
            }

            var allProcs = new HashSet<string>(edges.Keys);
            var toRemove = allProcs.Difference(reachable);

            var newDecls = new List<Declaration>();
            foreach (var decl in program.TopLevelDeclarations)
            {
                //if (decl is Procedure && toRemove.Contains((decl as Procedure).Name)) continue;
                if (decl is Implementation)
                {
                    var impl = decl as Implementation;
                    if (toRemove.Contains(impl.Name) && !QKeyValue.FindBoolAttribute(impl.Attributes, AvUtil.AvnAnnotations.InitialializationProcAttr))
                    {
                        // drop
                        continue;
                    }
                }
                newDecls.Add(decl);
            }
            program.TopLevelDeclarations = newDecls;

            if (approximationDepth >= 0)
            {
                program = BoogieUtil.ReResolveInMem(program, true);
                // instrument to add stubs
                AvHarnessInstrumentation.Driver.SetOptions(avHarnessInstrArgs.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
                var hi = new AvHarnessInstrumentation.Instrumentations.HarnessInstrumentation(program, "", false);
                hi.DoInstrument(false);
            }

            return program;
        }

        // deletes calls to all entrypoints except mainproc, returns CorralMain since that this is the entrypoint
        // clears out all commands from the blocks with deleted calls
        private static string sliceMainForProc(Program program, string mainproc, HashSet<string> otherEPs)
        {
            Procedure entrypoint_proc = program.TopLevelDeclarations.OfType<Procedure>().Where(proc => BoogieUtil.checkAttrExists("entrypoint", proc.Attributes)).FirstOrDefault();

            Debug.Assert(entrypoint_proc != null);

            Implementation entrypoint_impl = program.TopLevelDeclarations.OfType<Implementation>().Where(impl => impl.Name.Equals(entrypoint_proc.Name)).FirstOrDefault();

            foreach (Block b in entrypoint_impl.Blocks)
            {
                if (b.Cmds.OfType<CallCmd>().Any(cc => cc.callee != mainproc && otherEPs.Contains(cc.callee)))
                    b.Cmds.Clear();
            }

            UnusedVarEliminator.Eliminate(program);

            return entrypoint_proc.Name;
        }

        // locate HAVOC_MALLOC
        private static Procedure FindMalloc(Program prog)
        {
            Procedure mallocProc = null;
            //find the malloc and malloc-full procedures
            foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
            {
                var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                if (attr == null) mallocProc = proc;
            }

            if (mallocProc == null)
            {
                throw new Exception("ABORT: no malloc procedure with {:allocator} declared in the input program");
            }
            return mallocProc;
        }
    }
}
