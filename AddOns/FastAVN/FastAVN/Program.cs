using cba.Util;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading;

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
        static bool dependentEntrypointExec = false; //whether to execute all entry points in dependence order or not
        

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

            if (args.Any(s => s == "/dependentEntrypointExec"))
                Driver.dependentEntrypointExec = true;

            if(args.Any(s => s== "/printCallDependence"))
            {
                Driver.printCallDependence = true;
            }
            
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
            avnPath = findExe("AngelicVerifierNull.exe");
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



                    //After instrumentation unrolling for removing the recursion
                    int origBound = CommandLineOptions.Clo.RecursionBound;
                    CommandLineOptions.Clo.RecursionBound = 2;
                    cba.ExtractRecursionPass rollOut = new cba.ExtractRecursionPass();
                    
                    string epname = program.TopLevelDeclarations.OfType<NamedDeclaration>().Where(d => QKeyValue.FindBoolAttribute(d.Attributes,
                        "entrypoint")).Select(nd => nd.Name).First();
                    cba.PersistentCBAProgram tempProgram = new cba.PersistentCBAProgram(program, epname, 0);
                    var rolledOutProgram = rollOut.run(tempProgram);
                    program = rolledOutProgram.getProgram();
                    //restoring the recursion bound 
                    CommandLineOptions.Clo.RecursionBound = origBound;
                    

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
        private static bool printCallDependence = false;


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



             foreach(var impl in prog.TopLevelDeclarations.OfType<Implementation>())
            {
                string methodName = impl.Proc + "";
                
                foreach (var block in impl.Blocks)
                {
                    foreach(var cmd  in block.cmds.OfType<AssertCmd>())
                    {
                        int lineNum = cmd.Line;
                        
                        cmd.Attributes = new QKeyValue(Token.NoToken, "uniqueAVNID", (new string[1] { methodName+ AssertEliminator.NameSeparator+lineNum}), cmd.Attributes);
                        

                    }

                }
            }

            //BoogieUtil.PrintProgram(prog, "annotatedProg.bpl");

           
            Microsoft.Boogie.GraphUtil.Graph<string> callgraph = BoogieUtil.GetCallGraph(prog);
            callgraph.Successors(callgraph.Nodes.First());
            Dictionary<string, List<string>> dependencyInfo = BuildEntryPointDependenceGraph(prog, entrypoints, callgraph);

            //only for debugging
            if (printCallDependence)
            {
                printDependenceInfo(callgraph, dependencyInfo);
            }


            if (dependentEntrypointExec)
            {

                //never modify this dictionary
                Dictionary<string, List<string>> depInfoCopy = new Dictionary<string, List<string>>();
                foreach(var e  in dependencyInfo.Keys)
                {
                    var newK = e + "";
                    List<string> mem = new List<string>();
                    foreach(var m in dependencyInfo[e])
                    {
                        mem.Add(m + "");
                    }
                    depInfoCopy.Add(newK, mem);
                }


                HashSet<string> allEntryPointNames = new HashSet<string>();
                entrypoints.Iter(impl => allEntryPointNames.Add(impl.Name));

                


                var workingCopy = "tempProg.bpl";
                BoogieUtil.PrintProgram(prog, workingCopy);
                Program currentProgram = BoogieUtil.ReadAndOnlyResolve(workingCopy);
                //File.Delete(workingCopy);
                

                /*This code runs the entrypoints with no dependence
                 and keeps modifying the dependence as and when the entrypoints are done.
                 We assume for now that this graph is acyclic. */
                int parCount = 0;
                while (!AllEntryPointsDone(dependencyInfo))
                {
                    parCount++;
                    HashSet<string> currentEntrypointNames;
                    //pick the one with zero dep and create threads for them
                    ConcurrentBag<Implementation> currentEntrypoints = getIndependentEntrypoints(entrypoints, 
                        dependencyInfo, out currentEntrypointNames);

                    
                    
                    //get entrypoint directories to get the entrypoints removed
                    HashSet<string> removedEntrypointNames = new HashSet<string>();
                    removedEntrypointNames = new HashSet<string>(currentEntrypointNames);
                    ExecuteEPInSeq(currentProgram, currentEntrypoints, currentEntrypointNames, allEntryPointNames, depInfoCopy);
                
                    
                    //replaces the asertions based on results
                    if (ReplacementRequired(dependencyInfo))
                        currentProgram = AssertEliminator.ReplaceAssertsOfDepImpls(currentProgram, removedEntrypointNames, allEntryPointNames, callgraph);


                    //remove the current independent and update the others in depgraph                
                    foreach (var epName in removedEntrypointNames)
                    {
                        dependencyInfo.Where(ep => ep.Value.Contains(epName)).Iter(ep => ep.Value.Remove(epName));
                        dependencyInfo.Remove(epName);
                    }

                    printMesg("end of run " + parCount);

                }
            }
            else
            {
                /* old code*/

                //sorting the entrypoints for the older algorithm
                ConcurrentQueue<Implementation> epQueue = new ConcurrentQueue<Implementation>();
                int maxDep = dependencyInfo.Max(dep => dep.Value.Count);
                for(int i = 0; i<= maxDep; i++)
                {
                    foreach(var ep  in dependencyInfo.Where(dep => dep.Value.Count == i))
                    {
                        epQueue.Enqueue(entrypoints.Where(e => e.Name.Equals(ep.Key)).First());
                    }
                }
                
                var threads = new List<Thread>();
                for (int i = 0; i < numThreads; i++)
                {
                    var w = new Worker(prog, epQueue);
                    if (!earlySplit)
                        threads.Add(new Thread(new ThreadStart(w.RunSplitAndAv)));
                    else
                        threads.Add(new Thread(new ThreadStart(w.RunSplitAndAvhAndAv)));
                }

                threads.Iter(t => t.Start());
                threads.Iter(t => t.Join());
            }



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

                //printing results
                AssertEliminator.printAVResults();
            }
        }

        private static void printDependenceInfo(Graph<string> callgraph, Dictionary<string, List<string>> dependencyInfo)
        {
            string dir = "Info";
            
            if(Directory.Exists(dir))
            {
                Directory.Delete(dir, true);
                Directory.CreateDirectory(dir);
            }
            else
            {
                Directory.CreateDirectory(dir);
            }

            string fname =Path.Combine(dir, "callgraph.txt");
            if (File.Exists(fname))
            {
                File.Delete(fname);
            }
            List<string> callContents = new List<string>();
            callContents.Add( "Printing the call graph :");
            foreach (var node in callgraph.Nodes)
            {
                callContents.Add( node + " calls : ");
                foreach (var succ in callgraph.Successors(node))
                {
                    callContents.Add( "==> " + succ);

                }
            }
            File.AppendAllLines(fname, callContents);


            var fname1 = Path.Combine(dir, "dependencyInfo.txt");
            if (File.Exists(fname1))
            {
                File.Delete(fname1);
            }
            var count = 0;
            var maxcount = dependencyInfo.Max(dep => dep.Value.Count);
            List<string> depContents = new List<string>();
            Console.WriteLine("the max count is : {0}", maxcount);
            while (count <= maxcount)
            {

                foreach (var d in dependencyInfo.Where
                    (dep => dep.Value.Count == count))
                {
                    depContents.Add("Entrypoint " + d.Key + " with count " + count + " depends on : ");
                    foreach (var val in dependencyInfo[d.Key])
                    {
                        
                        depContents.Add( "==> " + val);
                    }

                }
                count++;
            }
            File.AppendAllLines(fname1, depContents);


        }

        private static string GetlistToPrint(List<string> value)
        {
            string listOfValues = "";
            foreach(var s in value)
            {
                listOfValues += s + "\t";
            }
            return listOfValues;
        }


        private static void ExecuteEPInSeq(Program currentProgram, ConcurrentBag<Implementation> currentEntrypoints, 
            HashSet<string> currentEntrypointNames, HashSet<string> allEntryPointNames, Dictionary<string, List<string>> depInfoCopy)
        {
            foreach (var ep in currentEntrypointNames)
            {
                

                var currentImpl = currentEntrypoints.Where(e => e.Name.Equals(ep)).First();
                HashSet<string> succ = new HashSet<string>(depInfoCopy[ep]);
                if (!EPhasAsserts(currentImpl) && AssertEliminator.NoBlockEP.Contains(succ))
                {
                    printMesg("skipping execution of :" + ep);
                    continue;
                }


                ConcurrentQueue<Implementation> currentEP = new ConcurrentQueue<Implementation>(currentEntrypoints.
                    Where(e => e.Name.Equals(ep)));
                
                Worker w = new Worker(currentProgram, currentEP, allEntryPointNames);
                if (!earlySplit)
                    w.RunSplitAndAv();
                else
                    w.RunSplitAndAvhAndAv();
                
            }
        }

        private static bool EPhasAsserts(Implementation currentImpl)
        {
            if (currentImpl == null)
                return false;


            foreach(var block in currentImpl.Blocks)
            {
                foreach(var cmd in block.Cmds)
                {
                    if(cmd is AssertCmd)
                    {
                        var acmd = cmd as AssertCmd;
                        //ignoring assert true statements;
                        if (!acmd.Expr.Equals(Expr.True))
                            return true;
                    }
                }
            }

            return false;
        }

        private static HashSet<string> ExecuteEPInParallel(Program currentProgram, ConcurrentQueue<Implementation> currentEntrypoints, 
            HashSet<string> allEntryPointNames, HashSet<string> currentEntrypointNames)
        {
            HashSet<string> removedEPNames = new HashSet<string>();
            var threads = new List<Thread>();
            //parallel execution
            for (int i = 0; i < numThreads; i++)
            {
                //giving the independent entry points to the worker thread
                var w = new Worker(currentProgram, currentEntrypoints, allEntryPointNames);
                if (!earlySplit)
                    threads.Add(new Thread(new ThreadStart(w.RunSplitAndAv)));
                else
                    threads.Add(new Thread(new ThreadStart(w.RunSplitAndAvhAndAv)));
            }

            threads.Iter(t => t.Start());
            threads.Iter(t => t.Join());

            //extracting the entrypoints done
            foreach (var dirPath in Worker.DirsCreated)
            {
                string[] dirComp = dirPath.Split(Path.DirectorySeparatorChar);
                string dir = dirComp[dirComp.Length - 1];
                if (currentEntrypointNames.Any(name => dir.Equals(name)))
                    removedEPNames.Add(dirPath);
            }

            return removedEPNames;
        }

        private static void printMesg(string v)
        {
            Console.WriteLine("[Snigdha] {0}", v);
        }

        //this can be refined more later to inline on an entrypoint specific way
        private static bool ReplacementRequired(Dictionary<string, List<string>> dependencyInfo)
        {
            return dependencyInfo.Any(dep => dependencyInfo[dep.Key].Count > 0);
        }



        //return the methods with no dependencies, i.e. empty lists
        private static ConcurrentBag<Implementation> getIndependentEntrypoints(ConcurrentBag<Implementation> entrypoints,
            Dictionary<string, List<string>> dependencyInfo, out HashSet<string> currentEntrypointsNames)
        {
            ConcurrentBag<Implementation> independentEntryPoints = new ConcurrentBag<Implementation>();
            entrypoints.Where(impl => dependencyInfo.ContainsKey(impl.Proc.Name) && dependencyInfo[impl.Proc.Name].Count == 0).
                Iter(impl => independentEntryPoints.Add(impl));


            


            currentEntrypointsNames = new HashSet<string>();
            foreach (var ep in independentEntryPoints)
                currentEntrypointsNames.Add(ep.Proc.Name.ToString());

            return independentEntryPoints;
            

            /*HashSet<string> epAdded = new HashSet<string>();
             *if(independentEntryPoints.IsEmpty)
              {
                  //mutually recursive case
                  foreach(var ep1 in dependencyInfo.Keys)
                  {
                      if (epAdded.Contains(ep1))
                          continue;
                      HashSet<string> toAdd = new HashSet<string>(dependencyInfo.Keys.Where(ep => dependencyInfo[ep].Contains(ep1) &&
                          dependencyInfo[ep1].Contains(ep)));

                      if (toAdd.Count() > 0)
                      {
                          toAdd.Add(ep1);

                          int minLevel = toAdd.Min(e => dependencyInfo[e].Count);
                          toAdd.RemoveWhere(e => dependencyInfo[e].Count > minLevel);

                          foreach (var ep in toAdd)
                          {
                              var impl = entrypoints.Where(epImpl => epImpl.Name.Equals(ep)).First();
                              if (!independentEntryPoints.Contains(impl))
                              {

                                  independentEntryPoints.Add(impl);
                                  epAdded.Add(ep);
                              }

                          }
                      }


                  }
              }
              */

        }

        private static bool AllEntryPointsDone(Dictionary<string, List<string>> dependencyInfo)
        {
            if (dependencyInfo.Keys.Count != 0)
                return false;
            else
                return true;
        }

        /*This function extracts the dependence of the entrypoints from the call graph
         TODO : Ensure this function returns an acyclic graph.*/
        private static Dictionary<string, List<string>> BuildEntryPointDependenceGraph(Program prog, ConcurrentBag<Implementation> entrypoints,
            Microsoft.Boogie.GraphUtil.Graph<string> callgraph)
        {
            Dictionary<string, List<string>> entrypointDepGraph = new Dictionary<string, List<string>>();
            
            
            foreach (var epImpl in entrypoints)
                {
                    string epName = epImpl.Proc.Name;
                    List<string>  successors= new List<string>();
                    BoogieUtil.GetReachableNodes(epName, callgraph).Where(funcName => !funcName.Equals(epName) && 
                            entrypoints.Any(impl => impl.Proc.Name.Equals(funcName))).Iter(funcName 
                            => successors.Add(funcName));
                    entrypointDepGraph[epName] = successors;                    
                }                
            


            

            return entrypointDepGraph;
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
            ConcurrentQueue<Implementation> impls;
            public static ConcurrentBag<string> DirsCreated = new ConcurrentBag<string>();
            HashSet<string> implNames;
            Program program;
            static string counter_lock = "counter_lock";
            static int trunc_counter = 0;

            public Worker(Program program, ConcurrentQueue<Implementation> impls)
            {
                this.program = program; 
                this.impls = impls;
                this.implNames = new HashSet<string>();
                impls.Iter(im => implNames.Add(im.Name));
            }

            public Worker(Program program, ConcurrentQueue<Implementation> impls, HashSet<string> implNames)
            {
                this.program = program;
                this.impls = impls;
                this.implNames = new HashSet<string>(implNames);
            }

            public void RunSplitAndAv()
            {
                Implementation impl;

                while (true)
                {
                    if (!impls.TryDequeue(out impl)) { break; }

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
                    if (!impls.TryDequeue(out impl)) { break; }

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

        //This class contains the utilities to modify the assertions based on their analysis outcomes
        public class AssertEliminator
        {

            //methodName and assert number separator
            public const char NameSeparator = '$';
            private static HashSet<string> callsToIgnore = null;
            private static HashSet<string> choiceCallsToAdd = new HashSet<string>();
            private static HashSet<string> noBlockEP = new HashSet<string>();

            private static List<string> resultRec = new List<string>();

            public static Program ReplaceAssertsOfDepImpls(Program currentProgram, HashSet<string> 
                removedEntryPoints, HashSet<string> AllEPNames, Microsoft.Boogie.GraphUtil.Graph<string> callgraph)
            {
                HashSet<string> currentDirs = new HashSet<string>(removedEntryPoints);

                
                foreach (var dir in currentDirs)
                {
                    bool entrypointBlocks = false;
                    string filename = Path.Combine(dir, "avnResult.txt");
                    
                    if (File.Exists(filename))
                    {
                        //adding the result
                        string[] lines = File.ReadAllLines(filename);
                        Dictionary<string, string> assertRes = new Dictionary<string, string>();
                        lines.Iter(res => assertRes.Add(res.Split(':')[0], res.Split(':')[1]));

                        //initialized per entrypoint
                        choiceCallsToAdd = new HashSet<string>();
                        foreach (var assertID in assertRes.Keys)
                        {

                            
                            if (assertRes[assertID].Equals("PASS"))
                            {
                                
                                currentProgram = ReplacePassOrFailAsserts(currentProgram, assertID);

                            }
                            else if (assertRes[assertID].Equals("FAIL"))
                            {
                                
                                currentProgram = ReplacePassOrFailAsserts(currentProgram, assertID);
                                
                            }
                            else if(assertRes[assertID].Equals("BLOCK"))
                            {
                                //replace assertion in the original program method
                                
                                ReplaceAssertByAssume(currentProgram, dir, callgraph);
                                currentProgram = ReplaceBlockedAsserts(currentProgram, assertID, dir, AllEPNames);
                                entrypointBlocks = true;
                                
                            }
                            
                        }

                        ReplaceCallsForCallers(currentProgram, dir, AllEPNames);
                           

                    }
                    if (!entrypointBlocks) {
                        NoBlockEP.Add(dir);
                    }
                    


                }


                return currentProgram;
            }


            //this function replaces the asserts with the result PASS or FAIL, by an assume
            public static Program ReplacePassOrFailAsserts(Program currentProgram, string assertID)
            {
                string functionName = assertID.Split(NameSeparator)[0];

                var assertToAssume = new Func<Cmd, Cmd>(cmd =>
                {
                    var acmd = cmd as AssertCmd;
                    if (acmd == null || !QKeyValue.FindStringAttribute(acmd.Attributes, "uniqueAVNID").Equals(assertID)) return cmd;
                    return new AssumeCmd(cmd.tok, acmd.Expr, acmd.Attributes);
                });
                foreach (var impl in currentProgram.TopLevelDeclarations.OfType<Implementation>())
                    if (impl.Proc.Name.Equals(functionName))
                        foreach (var block in impl.Blocks)
                            block.Cmds = new List<Cmd>(block.Cmds.Map(c => assertToAssume(c)));

                return currentProgram;

            }


            private static Program ReplaceBlockedAsserts(Program currentProgram, string assertID, string dirName, HashSet<string> allEPNames)
  
            {

                

                Program prunedProgram = BoogieUtil.ReadAndOnlyResolve(Path.Combine(dirName, "prunedProg_" + assertID + ".bpl"));

                //get the important elements
        
                string entrypoint = dirName;

                //from the original program
                Implementation origEpImpl = currentProgram.TopLevelDeclarations.OfType<Implementation>().Where(im => im.Name.Equals(entrypoint)).First();


                //from the pruned program
                Implementation prunedEPImpl = prunedProgram.TopLevelDeclarations.OfType<Implementation>().Where(
                    im => QKeyValue.FindStringAttribute(im.Attributes, "origRTname").Equals(entrypoint)).First();
                string prunedEPName = prunedEPImpl.Name;



                //1. inlining the methods called by the entry point

                Program newPrunedProgram = InlinePrunedProgram(prunedProgram, prunedEPImpl, assertID);

               
                Dictionary<string, string> implRename = RenameTraceImpls(newPrunedProgram, assertID);


                //removing the calls present due to pruning
                SetCallsToIgnore(prunedProgram, currentProgram);            


                //cleaning up the pruned program
                foreach (var impl in newPrunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    //removing the context calls
                    impl.Blocks.Iter(b => b.Cmds.RemoveAll(cmd => (cmd is CallCmd) && (callsToIgnore.Contains((cmd as CallCmd).Proc.Name))));
                    
                    //removing havoc commands
                    impl.Blocks.Iter(b => b.Cmds.RemoveAll(cmd => (cmd is HavocCmd)));


                    //removing  triggers and extra information added by concretization
                    foreach (var block in impl.Blocks)
                    {
                        //trigger removing
                        block.Cmds.RemoveAll(cmd => (cmd is AssumeCmd) && ((cmd as AssumeCmd).Expr is NAryExpr)  &&
                        ((cmd as AssumeCmd).Expr as NAryExpr).Fun.FunctionName.Contains("unknownTrigger_"));


                        //ID removing
                        foreach(var cmd in block.Cmds)
                        {
                            if(cmd is CallCmd)
                            {
                                var ccmd = cmd as CallCmd;
                                var newAttr = RemoveAttr(ccmd.Attributes, "ConcretizeCallId");
                                ccmd.Attributes = newAttr;
                            }
                        }
                    }

                    
                    

                }

                //BoogieUtil.PrintProgram(newPrunedProgram, "inlinedPrunedProgram" + (inlineFileCount++) + ".bpl");


                //add all to the current program - both impl and procedure
                foreach (var decl in newPrunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    
                    if (!currentProgram.TopLevelDeclarations.OfType<Implementation>().Any(im => im.Name.Equals(decl.Name)))
                    {
                        currentProgram.AddTopLevelDeclaration(decl);
                        currentProgram.AddTopLevelDeclaration(decl.Proc);

                    }
                }

                //REVISE : add all functions called by pruned program to currentprogram
                HashSet<string> funcsUsed = new HashSet<string>();
                var vu = new VarsUsed();
                foreach(var impl in newPrunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    vu.Visit(impl);
                    vu.functionsUsed.Iter(f => funcsUsed.Add(f));
                }
                
                //remove the triggers
                funcsUsed.RemoveWhere(f => f.Contains("unknownTrigger_"));
                
                foreach (var f in funcsUsed)
                {
                    var func = newPrunedProgram.TopLevelDeclarations.OfType<Function>().Where(fn => fn.Name.Equals(f)).First();
                    if( currentProgram.Functions.Count() > 0 && !currentProgram.TopLevelDeclarations.OfType<Function>().Any(fn => fn.Name.Equals(f)))
                    {
                        currentProgram.AddTopLevelDeclaration(func);
                    }

                }
               
                

                //create the dummy choice method with the two calls


                Procedure origEpProc = origEpImpl.Proc;
                Procedure choiceProc = new Procedure(Token.NoToken, entrypoint+"$"+assertID + "$choice", origEpProc.TypeParameters, origEpProc.InParams,
                    origEpProc.OutParams, origEpProc.Requires, origEpProc.Modifies, origEpProc.Ensures, origEpProc.Attributes);
                Implementation choiceImpl = new Implementation(Token.NoToken, entrypoint + "$" + assertID + "$choice", origEpImpl.TypeParameters, origEpImpl.InParams,
                    origEpImpl.OutParams, origEpImpl.LocVars, new List<Block>(), origEpImpl.Attributes);

                
                choiceImpl.Proc = choiceProc;
                currentProgram.AddTopLevelDeclaration(choiceProc);
                currentProgram.AddTopLevelDeclaration(choiceImpl);



                //insert code in the original program for the call to the trace
                choiceCallsToAdd.Add(choiceImpl.Name);
                //ReplaceCallsForCallers(currentProgram, finalCallers, choiceImpl.Name, entrypoint);

                List<Block> choiceBlocks = GetChoiceBlocks(choiceImpl, implRename[prunedEPName], entrypoint, assertID);
                choiceImpl.Blocks.AddRange(choiceBlocks);

                
                return currentProgram;

            }


            //TODO This function should replace all the asserts in the entrypoint by assumes
            private static void ReplaceAssertByAssume(Program currentProgram,  string entrypoint, 
                Microsoft.Boogie.GraphUtil.Graph<string> callgraph)
            {
                
                //replacing function
                var assertToAssume = new Func<Cmd, Cmd>(cmd =>
                {
                    var acmd = cmd as AssertCmd;
                    if (acmd == null) return cmd;
                    return new AssumeCmd(cmd.tok, acmd.Expr, acmd.Attributes);
                });

                Implementation impl = currentProgram.TopLevelDeclarations.OfType<Implementation>().Where(
                    im => im.Proc.Name.Equals(entrypoint)).First();
                    if(impl != null)
                        foreach (var block in impl.Blocks)
                            block.Cmds = new List<Cmd>(block.Cmds.Map(c => assertToAssume(c)));
                
                
                
            }


            //this function should be called at the end of on entry point and replace all it's calls with the series of calls to the choice methods
            //the choice methods would have been added earlier 
            //this is going to increase the size of programs per assertions - is it acceptable?
            private static void ReplaceCallsForCallers(Program currentProgram, string entrypoint, 
                HashSet<string> allEPNames)
            {
                Microsoft.Boogie.GraphUtil.Graph<string> callgraph = BoogieUtil.GetCallGraph(currentProgram);
                callgraph.Successors(callgraph.Nodes.First());
                IEnumerable<string> callers = callgraph.Predecessors(entrypoint);
                var finalCallers = callers.Intersect(allEPNames);

                foreach (var impl  in currentProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    if (finalCallers.Contains(impl.Name))
                    {
                        List<Block> newBlocks = new List<Block>();
                        foreach(var block in impl.Blocks)
                        {
                            List<Cmd> cmds = new List<Cmd>();
                            foreach(var cmd in block.Cmds)
                            {
                                if (cmd is CallCmd)
                                {
                                    CallCmd ccmd = cmd as CallCmd;
                                    if (ccmd.callee.Equals(entrypoint))
                                    {

                                        //add calls for all choice methods
                                        foreach(var choice in choiceCallsToAdd)
                                        {
                                            CallCmd newcmd = new CallCmd(Token.NoToken, choice, ccmd.Ins, ccmd.Outs, ccmd.Attributes);
                                            cmds.Add(newcmd);
                                        }
                                        
                                    }
                                    else
                                        cmds.Add(ccmd);                                    
                                }
                                else
                                    cmds.Add(cmd);
                                
                            }
                            Block newBlock = new Block(Token.NoToken, block.Label, cmds, block.TransferCmd);
                            newBlocks.Add(newBlock);
                        }
                        impl.Blocks.Clear();
                        impl.Blocks.AddRange(newBlocks);
                    }
                }
            }

            private static List<Block> GetChoiceBlocks(Implementation choiceImpl, string prunedInlinedEPName, string entrypoint, 
                string assertID)
            {
                List<Block> blocks = new List<Block>();
                List<Expr> ins = new List<Expr>();
                List<IdentifierExpr> outs = new List<IdentifierExpr>();

                choiceImpl.InParams.Iter(inp => ins.Add(new IdentifierExpr(Token.NoToken, inp, inp.IsMutable)));
                choiceImpl.OutParams.Iter(outp => outs.Add(new IdentifierExpr(Token.NoToken, outp, outp.IsMutable)));


                //creating block 3 - the trace block
                Block b3 = new Block(Token.NoToken, assertID + "TraceCall", new List<Cmd>(), new ReturnCmd(Token.NoToken));
                Cmd callTraceCmd = new CallCmd(Token.NoToken, prunedInlinedEPName, ins, outs);
                Cmd finishcmd = new AssumeCmd(Token.NoToken, Expr.False);
                b3.Cmds.Add(callTraceCmd);
                b3.Cmds.Add(finishcmd);
               

                //creating block b2 - the original method block
                Block b2 = new Block(Token.NoToken, assertID + "OrigCall", new List<Cmd>(), new ReturnCmd(Token.NoToken));
                Cmd callOrigCmd = new CallCmd(Token.NoToken, entrypoint, ins, outs);
                b2.Cmds.Add(callOrigCmd);

                List<Block> succBlocks = new List<Block>();
                succBlocks.Add(b3);
                succBlocks.Add(b2);

                List<string> succBlocksLabel = new List<string>();
                succBlocksLabel.Add(b3.Label);
                succBlocksLabel.Add(b2.Label);

                //creating block 1
                GotoCmd NDChoiceGoto = new GotoCmd(Token.NoToken, succBlocksLabel, succBlocks);
                Block b1 = new Block(Token.NoToken, assertID + "$NDChoice1", new List<Cmd>(), NDChoiceGoto);

                blocks.Add(b1);
                blocks.Add(b2);
                blocks.Add(b3);
                return blocks;
            }

            private static void SetCallsToIgnore(Program prunedProgram, Program currentProgram)
            {
                //calls included due to the instrumentation
                callsToIgnore = new HashSet<string>();


                foreach(var pp in prunedProgram.TopLevelDeclarations.OfType<Procedure>())
                {
                    if(!currentProgram.TopLevelDeclarations.OfType<Procedure>().Any(p => p.Name.Equals(pp.Name)))
                    {
                        callsToIgnore.Add(pp.Name);
                    }
                }

               
                
                
                //retain the renamed methods
                foreach (var impl in prunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    if ((QKeyValue.FindStringAttribute(impl.Attributes, "origRTname") != null ||
                        QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint") && callsToIgnore.Contains(impl.Proc.Name)))
                        callsToIgnore.Remove(impl.Proc.Name);
                }

               


            }

            static int inlineFileCount = 0;

            public static HashSet<string> NoBlockEP { get => noBlockEP; set => noBlockEP = value; }

            //inlines the current entry point under analysis 
            private static Program InlinePrunedProgram(Program prunedProgram, Implementation prunedEPImpl, string assertID)
            {
                //changing the entrypoint from corral_main to current entrypoint
                var epProc = prunedProgram.TopLevelDeclarations.OfType<Procedure>().Where(
                    p => QKeyValue.FindBoolAttribute(p.Attributes, "entrypoint")).First();

                if (epProc != null && !epProc.Name.Equals(prunedEPImpl.Name))
                {
                    //remove the unnecessary entrypoint impl

                    prunedProgram.RemoveTopLevelDeclaration(epProc);
                    var epImpl = prunedProgram.TopLevelDeclarations.OfType<Implementation>().Where(im => im.Name.Equals(epProc.Name)).First();
                    prunedProgram.RemoveTopLevelDeclaration(epImpl);

                    //add the entrypoint attirbute to the impl
                    prunedEPImpl.Proc.AddAttribute("entrypoint");
                    prunedEPImpl.AddAttribute("entrypoint");

                }

                //inlining
                //is the bound OK?
                cba.InliningPass inlineP = new cba.InliningPass(1);
                //REVISE these bounds!
                cba.PersistentCBAProgram pprunedProgram = new cba.PersistentCBAProgram(prunedProgram, prunedEPImpl.Name, 0);
                var inlinedPProgram = inlineP.run(pprunedProgram);
                var newPrunedProgram = inlinedPProgram.getProgram();
                
                

                //remove the entrypoint attribute
                var inlinedEPProc = newPrunedProgram.TopLevelDeclarations.OfType<Procedure>().Where(p => QKeyValue.FindBoolAttribute(p.Attributes,
                   "entrypoint")).First();

                var inlinedEPImpl = newPrunedProgram.TopLevelDeclarations.OfType<Implementation>().Where(im => QKeyValue.FindBoolAttribute(im.Attributes,
                   "entrypoint")).First();

                QKeyValue newImplAttr = RemoveAttr(inlinedEPImpl.Attributes, "entrypoint");
                QKeyValue newProcAttr = RemoveAttr(inlinedEPProc.Attributes, "entrypoint");

                Procedure newInlinedProc = new Procedure(Token.NoToken, inlinedEPProc.Name, inlinedEPProc.TypeParameters, inlinedEPProc.InParams,
                    inlinedEPProc.OutParams, inlinedEPProc.Requires, inlinedEPProc.Modifies, inlinedEPProc.Ensures, newProcAttr);

                Implementation newInlinedImpl = new Implementation(Token.NoToken, inlinedEPImpl.Name, inlinedEPImpl.TypeParameters, inlinedEPImpl.InParams,
                    inlinedEPImpl.OutParams, inlinedEPImpl.LocVars, inlinedEPImpl.Blocks, newImplAttr);

                //remove other asserts from the inlined program
                var assertToAssume = new Func<Cmd, Cmd>(cmd =>
                {
                    var acmd = cmd as AssertCmd;
                    if (acmd == null || QKeyValue.FindStringAttribute(acmd.Attributes, "uniqueAVNID").Equals(assertID)) return cmd;
                    return new AssumeCmd(cmd.tok, acmd.Expr, acmd.Attributes);
                });
                foreach (var block in newInlinedImpl.Blocks)
                    block.Cmds = new List<Cmd>(block.Cmds.Map(c => assertToAssume(c)));

                


                newInlinedImpl.Proc = newInlinedProc;

                newPrunedProgram.RemoveTopLevelDeclaration(inlinedEPImpl);
                newPrunedProgram.RemoveTopLevelDeclaration(inlinedEPProc);
                newPrunedProgram.AddTopLevelDeclaration(newInlinedImpl);
                newPrunedProgram.AddTopLevelDeclaration(newInlinedProc);

                

                return newPrunedProgram;
            }

            private static QKeyValue RemoveAttr(QKeyValue attributes, string Key)
            {
                QKeyValue currentAttr = attributes;
                QKeyValue newAttr = null;
                while (currentAttr != null)
                {
                    if (!currentAttr.Key.Equals(Key))
                    {
                        if (newAttr == null)
                        {
                            newAttr = new QKeyValue(Token.NoToken, currentAttr.Key, currentAttr.Params, null);
                        }
                        else
                        {
                            newAttr = new QKeyValue(Token.NoToken, currentAttr.Key, currentAttr.Params, newAttr);
                        }
                    }
                    currentAttr = currentAttr.Next;

                }

                return newAttr;
            }

            private static Dictionary<string, string> RenameTraceImpls(Program prunedProgram, string assertID)
            {
                Dictionary<string, string> renameInfo = new Dictionary<string, string>();

                List<Declaration> declToAdd = new List<Declaration>();
                List<Declaration> declToRemove = new List<Declaration>();
                //renaming impls from the trace
                string prefix = assertID + "$";
                foreach (var impl in prunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    
                    Implementation newImpl = new Implementation(Token.NoToken, prefix + impl.Name, impl.TypeParameters, impl.InParams,
                        impl.OutParams, impl.LocVars, impl.Blocks, impl.Attributes);
                    
                    Procedure proc = impl.Proc;
                    Procedure newProc = new Procedure(Token.NoToken, prefix + impl.Name, proc.TypeParameters, proc.InParams, proc.OutParams,
                        proc.Requires, proc.Modifies, proc.Ensures, proc.Attributes);
                    newImpl.Proc = newProc;
                    
                    declToAdd.Add(newProc);
                    declToRemove.Add(proc);
                    declToAdd.Add(newImpl);
                    declToRemove.Add(impl);
                    renameInfo.Add(impl.Name, newImpl.Name);
                }

                prunedProgram.RemoveTopLevelDeclarations(d => declToRemove.Contains(d));
                prunedProgram.AddTopLevelDeclarations(declToAdd);
                return renameInfo;
            }

           

           

            private static Program ReplaceBlockedAssertsOld(Program currentProgram, string assertID, string dirName)
            {
                string entrypoint = dirName;
                

                //get the file from the directory - bound to exist for blocked asserts -error check?
                Program prunedProgram = BoogieUtil.ReadAndOnlyResolve(Path.Combine(dirName, "prunedProg_" + assertID + ".bpl"));

                //may need list of where and requires clauses etc too - see the instrumentation closely
                Dictionary<string, TypedIdent> epIns = new Dictionary<string, TypedIdent>();
                Dictionary<string, TypedIdent> epOut = new Dictionary<string, TypedIdent>();
                Dictionary<string, TypedIdent> epLocVars = new Dictionary<string, TypedIdent>();

                //calls included due to the instrumentation

                prunedProgram.TopLevelDeclarations.OfType<Procedure>().Where(proc => !currentProgram.TopLevelDeclarations.OfType<Procedure>().Contains(proc)).
                    Iter(proc => callsToIgnore.Add(proc.Name));

                //retain the renamed methods
                foreach (var impl in prunedProgram.TopLevelDeclarations.OfType<Implementation>())
                {
                    if ((QKeyValue.FindStringAttribute(impl.Attributes, "origRTname") != null ||
                        QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint") && callsToIgnore.Contains(impl.Proc.Name)))
                        callsToIgnore.Remove(impl.Proc.Name);

                    
                }




                //initial prefix  for renaming all the variables to add it to the local vars of the callers
                //should the variables be differentiated based on assertIDs too?
                string uniqueVarPrefix = "traceInline$" + assertID + "$" + entrypoint + "$";

                //for the list of commands
                List<Cmd> cmdsToAdd = new List<Cmd>();

                TraceInline inlineInfo = new TraceInline(entrypoint, uniqueVarPrefix, epIns, epOut, epLocVars, cmdsToAdd);
                inlineInfo = ComputeInlinedBlock(prunedProgram, inlineInfo, assertID);

                //manage the ins and outs finally here, including the decalration in this method



               

                return currentProgram;
            }



            private static TraceInline ComputeInlinedBlock(Program program, TraceInline inlineInfo, string assertId)
            {
                
                Implementation mImpl = program.TopLevelDeclarations.OfType<Implementation>().Where(im => QKeyValue.FindStringAttribute(im.Attributes, "origRTname").Equals(inlineInfo.MethodName)).First();

                //methods with no implementation
                if (mImpl == null)
                    return inlineInfo;

                List<string> varsToRename = new List<string>();
                //add the renamed variables to the list of ins, outs and loc vars
                mImpl.InParams.Iter(v =>  inlineInfo.Ins.Add(v.Name, new TypedIdent(Token.NoToken, inlineInfo.VarPrefix + v.Name, v.TypedIdent.Type)));
                mImpl.OutParams.Iter(v => inlineInfo.Outs.Add(v.Name, new TypedIdent(Token.NoToken, inlineInfo.VarPrefix + v.Name, v.TypedIdent.Type)));
                mImpl.LocVars.Iter(v => inlineInfo.LocVars.Add(v.Name, new TypedIdent(Token.NoToken, inlineInfo.VarPrefix + v.Name, v.TypedIdent.Type)));

                varsToRename.AddRange(inlineInfo.Ins.Keys);
                varsToRename.AddRange(inlineInfo.Outs.Keys);
                varsToRename.AddRange(inlineInfo.LocVars.Keys);


                
                RewriteVars rw = new RewriteVars(inlineInfo.VarPrefix, varsToRename);
                foreach (Block block in mImpl.Blocks)
                {
                    if (inlineInfo.AssertFound)
                        break;
                    foreach(Cmd cmd in block.Cmds)
                    {
                        if(cmd is AssertCmd)
                        {
                            var acmd = cmd as AssertCmd;
                            if (QKeyValue.FindStringAttribute(acmd.Attributes, "uniqueAVNID").Equals(assertId))
                            {
                                inlineInfo.AssertFound = true;
                                Expr assertExpr = rw.VisitExpr(acmd.Expr);
                                inlineInfo.AddToInlinedTrace(new AssertCmd(Token.NoToken, assertExpr, acmd.Attributes));
                            }
                            else
                            {
                                //another assert found - convert to assume after renaming
                                Expr assumeExpr = rw.VisitExpr(acmd.Expr);
                                inlineInfo.AddToInlinedTrace(new AssumeCmd(Token.NoToken, assumeExpr, acmd.Attributes));
                            }


                        }

                        if(cmd is CallCmd)
                        {
                            CallCmd ccmd = cmd as CallCmd;
                            string procName = ccmd.Proc.Name;
                            if (callsToIgnore.Contains(procName))
                            {
                                
                                continue;
                            }
                            Implementation impl = program.TopLevelDeclarations.OfType<Implementation>().Where(im => im.Proc.Name.Equals(procName)).First();
                            if(impl!=null)
                            {
                                //need to inline
                                

                                string origName = QKeyValue.FindStringAttribute(impl.Attributes, "origRTname");
                                TraceInline newInlineInfo = new TraceInline(origName, inlineInfo.VarPrefix + "$" + origName+"$", new Dictionary<string, TypedIdent>(),
                                    new Dictionary<string, TypedIdent>(), new Dictionary<string, TypedIdent>(), new List<Cmd>());

                                newInlineInfo = ComputeInlinedBlock(program, newInlineInfo, assertId);

                                //add the information from the recieved object
                                inlineInfo.AssertFound = newInlineInfo.AssertFound;

                                //add the actual to formal assignment
                                //take care of the renaming
                                for (int i = 0; i < ccmd.Ins.Count; i++)
                                {
                                    Expr actual = ccmd.Ins[i];
                                    Expr renamedActual = rw.VisitExpr(actual);
                                    Variable formal = impl.InParams[i];
                                    TypedIdent renamedFormal = newInlineInfo.Ins[formal.Name];

                                    IdentifierExpr expr = new IdentifierExpr(Token.NoToken, renamedFormal.Name, renamedFormal.Type, formal.IsMutable);
                                    SimpleAssignLhs lhs = new SimpleAssignLhs(Token.NoToken, expr);
                                    List<AssignLhs> lhss = new List<AssignLhs>();
                                    lhss.Add(lhs);
                                    List<Expr> rhss = new List<Expr>();
                                    rhss.Add(renamedActual);

                                    AssignCmd acmd = new AssignCmd(Token.NoToken, lhss, rhss);
                                   
                                    inlineInfo.AddToInlinedTrace(acmd);
                                }

                                //add the rest of the trace
                                inlineInfo.AddToInlinedTrace(newInlineInfo.InlinedTrace);

                                //add the out variables assignment
                                //take care of renaming
                                //add the outs only if trace completed
                               // if (!inlineInfo.AssertFound)
                                //{
                                    for (int i = 0; i < ccmd.Outs.Count; i++)
                                    {
                                        IdentifierExpr lhsexpr = rw.VisitExpr(ccmd.Outs[i]) as IdentifierExpr;
                                        string formalName = newInlineInfo.Outs.Keys.ElementAt(i);
                                        TypedIdent rhsExpr = newInlineInfo.Outs[formalName];
                                        //is the false here correct? REVISE!!!
                                        IdentifierExpr rhs = new IdentifierExpr(Token.NoToken, rhsExpr.Name, rhsExpr.Type, false);


                                        //what if the return value was going in a map?? REVISE!!
                                        SimpleAssignLhs lhs = new SimpleAssignLhs(Token.NoToken, lhsexpr);
                                        List<AssignLhs> lhss = new List<AssignLhs>();
                                        lhss.Add(lhs);
                                        List<Expr> rhss = new List<Expr>();
                                        rhss.Add(rhs);

                                        AssignCmd acmd = new AssignCmd(Token.NoToken, lhss, rhss);
                                        // inlineInfo.AddToInlinedTrace(acmd);
                                        



                                    }
                                //}
                                
                                //add the renamed variables for declaration - ISSUE! 
                               /* newInlineInfo.Ins.Iter(v => inlineInfo.Ins.Add(v.Key, v.Value));
                                newInlineInfo.Outs.Iter(v => inlineInfo.Ins.Add(v.Key, v.Value));
                                newInlineInfo.LocVars.Iter(v => inlineInfo.Ins.Add(v.Key, v.Value));*/

                            }
                            else
                            {
                                //add the command as it is
                                inlineInfo.AddToInlinedTrace(ccmd);
                            }
    



                        }

                        if(cmd is AssignCmd)
                        {
                            AssignCmd acmd = cmd as AssignCmd;
                            List<AssignLhs> newLhss = new List<AssignLhs>();
                            List<Expr> newRhss = new List<Expr>();

                            foreach(AssignLhs e in acmd.Lhss)
                            {
                                if(e is SimpleAssignLhs)
                                {
                                    SimpleAssignLhs oldSlhs = e as SimpleAssignLhs;
                                    IdentifierExpr newExpr = rw.VisitExpr(oldSlhs.AsExpr) as IdentifierExpr;
                                    SimpleAssignLhs slhs = new SimpleAssignLhs(Token.NoToken, newExpr);
                                    newLhss.Add(slhs);
                                }
                                //have a case for mapAssign too
                                if(e is MapAssignLhs)
                                {
                                    MapAssignLhs me = e as MapAssignLhs;
                                    //have a recursive method which calls visit on all indices and the map ID
                                    
                                }
                            }

                            foreach(Expr e in acmd.Rhss)
                            {
                                Expr newExpr = rw.VisitExpr(e);
                                newRhss.Add(newExpr);
                            }

                            inlineInfo.AddToInlinedTrace(new AssignCmd(Token.NoToken, newLhss, newRhss));
                        }

                        
                    }
                    if(block.TransferCmd is ReturnCmd)
                    {
                        //assign output variable
                    }
                }
                return inlineInfo;
            }

            public static void printAVResults()
            {

                try
                {
                    string path = "bugresult_report.txt";
                    if(File.Exists(path))
                    {
                        File.Delete(path);
                    }

                    HashSet<string> dirs = new HashSet<string>(Worker.DirsCreated);

                    foreach (var dirPath in dirs)
                    {
                        var filePath = Path.Combine(dirPath, "avnResult.txt");
                        string[] dirComp = dirPath.Split(Path.DirectorySeparatorChar);
                        string epName = dirComp[dirComp.Length - 1];
                        string[] lines = File.ReadAllLines(filePath);
                        foreach(var line in lines)
                        {
                            var assert = line.Split(':')[0];
                            var result = line.Split(':')[1];
                            if(result.Equals("FAIL") || result.Equals("BLOCK"))
                            {
                                var str = epName + ", " + assert + ", " + result + "\n";
                                File.AppendAllText(path, str);
                            }
                            
                        }

                    }
                }
                catch(Exception e)
                {
                    Console.WriteLine("Error Reporting the results");
                }
                
               
            }
        }

        class TraceInline
        {
            private Dictionary<string, TypedIdent> ins = new Dictionary<string, TypedIdent>();
            private Dictionary<string, TypedIdent> outs = new Dictionary<string, TypedIdent>();
            private Dictionary<string, TypedIdent> locVars = new Dictionary<string, TypedIdent>();
            private List<Cmd> inlinedTrace = new List<Cmd>();
            private string methodName;
            private bool assertFound;
            
            private string varPrefix;

            public TraceInline()
            {
                methodName = "";
               
                VarPrefix = "";
            }

            public TraceInline(string mName, string prefix, 
                Dictionary<string, TypedIdent> ins, Dictionary<string, TypedIdent> outs, Dictionary<string, TypedIdent> locvar, 
                List<Cmd> iTrace)
            {
                this.ins = new Dictionary<string, TypedIdent>(ins);
                this.outs = new Dictionary<string, TypedIdent>(outs);
                this.locVars = new Dictionary<string, TypedIdent>(locvar);
                this.inlinedTrace = new List<Cmd>(iTrace);
                methodName = mName;
                
                varPrefix = prefix;
            }

            public Dictionary<string, TypedIdent> Ins { get => ins; set => ins = value; }
            public Dictionary<string, TypedIdent> Outs { get => outs; set => outs = value; }
            public Dictionary<string, TypedIdent> LocVars { get => locVars; set => locVars = value; }
            public string MethodName { get => methodName; set => methodName = value; }
           
            public string VarPrefix { get => varPrefix; set => varPrefix = value; }
            public List<Cmd> InlinedTrace { get => inlinedTrace; set => inlinedTrace = value; }
            public bool AssertFound { get => assertFound; set => assertFound = value; }

            public void AddToInlinedTrace(Cmd cmd)
            {
                inlinedTrace.Add(cmd);
            }

            internal void AddToInlinedTrace(List<Cmd> inlinedTrace)
            {
                this.inlinedTrace.AddRange(new List<Cmd>(inlinedTrace));
            }
        }


       
        /// <summary>
        /// this is a visitor that will rename the input parameters and local variables of a called method by attaching a
        /// prefix
        /// </summary>
        class RewriteVars : StandardVisitor
        {
            string prefix;
            List<string> varsToRename = new List<string>();
            
            

            public RewriteVars(string prefix, List<string> varsToRename)
            {
                this.prefix = prefix;
                this.varsToRename = new List<string>(varsToRename);
            }

            public override Expr VisitNAryExpr(NAryExpr node)
            {
                var ret = base.VisitNAryExpr(node) as NAryExpr;
                List<Expr> renamedArgs = new List<Expr>();

                //renaming the variables in the arguments
                foreach (Expr e in node.Args)
                {
                    renamedArgs.Add(VisitExpr(e));
                }

                if(renamedArgs.Count>0)
                {
                    return new NAryExpr(Token.NoToken, node.Fun, renamedArgs, node.Immutable);
                }

                return ret;
            }

            

            public override Expr VisitIdentifierExpr(IdentifierExpr node)
            {
                var ret = base.VisitIdentifierExpr(node) as IdentifierExpr;

                if(varsToRename.Contains(node.Name))
                {
                    return new IdentifierExpr(Token.NoToken, prefix+node.Name, node.Type, node.Immutable);
                }
                return ret;
            }

            
        }
    }

    
}