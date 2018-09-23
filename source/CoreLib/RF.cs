using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics.Contracts;
using Microsoft.Boogie;
using System.IO;
using Microsoft.Boogie.VCExprAST;
using CoreLib;
using Common;
using System.Threading;


namespace RefinementFuzzing
{

	public class ConcurrentContext
	{
		public List<SoftPartition> softPartitionPrefix;

		/*
       public Dictionary<string, VCExpr> proc2Summary;
       public int candidateCount;     // The candidates created in the parent; child starts renaming from here
       public int currInlineCount;
       public int newVarCnt;          // The private variables in the new instances of the calls are assigned IDs from here onwards
       public Dictionary<int, VCExpr> id2VC;
       public Dictionary<int, int> candidateParent;
       public Dictionary<int, List<int>> candidateChildren;
       public Dictionary<VCExprOp, VCExpressionGenerator.SingletonOp> SingletonOpDict;
       public Dictionary<int, VCExprNAry> id2Candidate;
       public VCExpr vcExprGenTrue;
       public VCExpr vcExprGenFalse;
        */

		public int id;

		public Dictionary<int, VCExprVar/*!*/>/*!*/ id2ControlVar;
		public StratifiedInlining vcgen;
		public VerificationState vstate;
		public SoftPartition spartition;

		// return result
		public VerifyResult res;

        public List<SoftPartition> outPartitions;

		// to notify the main thread on completion
		WaitHandle waitHandles;

		private static int threadIdCntr = 0;
		public int getNewThreadId()
		{
            Console.WriteLine("Inside getNewThreadId\n");
            int id = -1;
			lock (RefinementFuzzing.Settings.lockThis)
				//using (RefinementFuzzing.Settings.timedLock.Lock()) 
			{
				id = threadIdCntr;
				threadIdCntr++;
			}

			return id;
		}

		public ConcurrentContext(StratifiedInlining vcgen, VerificationState vstate, SoftPartition spartition, WaitHandle waitHandles, ProverInterface prover)
		{
            Console.WriteLine("Inside ConcurrentContext constructor\n");
            id = getNewThreadId();

			this.vcgen = vcgen;
			this.vstate = vstate;
			this.spartition = spartition;

			//vcgen.solver = new ConcurrentSolver(vcgen, vstate);
            
			this.waitHandles = waitHandles;

			softPartitionPrefix = new List<SoftPartition>();
			while (spartition != null)
			{
				softPartitionPrefix.Add(spartition);
				spartition = spartition.parent;
			}

			softPartitionPrefix.Reverse();
		}

		public static List<T> Copy<T>(List<T> obj)
		{
			List<T> list = new List<T>();
			foreach (T x in obj)
			{
				list.Add(x);
			}

			return list;
		}

		public static HashSet<T> Copy<T>(HashSet<T> obj)
		{
			HashSet<T> list = new HashSet<T>();
			foreach (T x in obj)
			{
				list.Add(x);
			}

			return list;
		}

		public static Dictionary<T, List<V>> DeepCopy<T, V>(Dictionary<T, List<V>> obj)
		{
			Dictionary<T, List<V>> dict = new Dictionary<T, List<V>>();

			foreach (T x in obj.Keys)
			{
				dict[x] = Copy<V>(obj[x]);
			}
			return dict;
		}

		public static Dictionary<T, HashSet<V>> DeepCopy<T, V>(Dictionary<T, HashSet<V>> obj)
		{
			Dictionary<T, HashSet<V>> dict = new Dictionary<T, HashSet<V>>();

			foreach (T x in obj.Keys)
			{
				dict[x] = Copy<V>(obj[x]);
				/*
                        List<V> newList = new List<V>();
                        (obj[x] as List<V>).Iter<V>(n => newList.Add(n));
                        dict[x] = newList as List<V>;
                 * */

			}
			return dict;
		}

		public static Dictionary<T, V> Copy<T, V>(Dictionary<T, V> obj, bool shallowCopy = false)
		{
			if (obj == null)
				return null;

			Dictionary<T, V> dict = new Dictionary<T, V>();

			System.Type type1 = typeof(V);
			//Type type2 = V.GetType();

			if (!shallowCopy)
			{
				if (type1.Name.Length >= 4 && type1.Name.Substring(0, 4) == "List")
					Contract.Assert(false); // Need deep copy?

				if (type1.Name.Length >= 10 && type1.Name.Substring(0, 10) == "Dictionary")
					Contract.Assert(false);

				if (type1.Name.Length >= 7 && type1.Name.Substring(0, 7) == "HashSet")
					Contract.Assert(false);
			}

			foreach (T x in obj.Keys)
			{
				dict[x] = obj[x];
			}

			return dict;
		}

		public void ProcessContext()
		{
            Console.WriteLine("Inside ProcessContext\n");
            Console.WriteLine("Thread Spawned!");

			List<SoftPartition> entryPartitions = new List<SoftPartition>();
			entryPartitions.Add(spartition);

            double solTime2 = 0;
            outPartitions = new List<SoftPartition>();

            //lock (RefinementFuzzing.Settings.lockThis)
            {
				//res = vcgen.solver.Solve(entryPartitions, this.vstate);
                res = vcgen.SolvePartition(spartition, vstate, out outPartitions, out solTime2, vcgen.proverStackBookkeeper, null, 1);

            }

            
			/*if (res == VerifyResult.Errors)
			{
				Console.WriteLine("Prover Error: " + RefinementFuzzing.Settings.error_msg);
				Contract.Assert(false);
			}
			else
			{
				RefinementFuzzing.Settings.error_msg = "";
			}*/

			RefinementFuzzing.Settings.WritePrimaryLog(vcgen.proverStackBookkeeper.id, spartition.Id, "ProcessContext", "Returning thread: " + id);

			// notify the main thread

			(waitHandles as ManualResetEvent).Set();
		}

	}

	class Concurrent
	{

		public static Thread SpawnThread(ConcurrentContext context)
		{
            Console.WriteLine("Inside SpawnThread\n");
            Thread oThread = new Thread(new ThreadStart(context.ProcessContext));

			lock (RefinementFuzzing.Settings.lockThis)
			{
				RefinementFuzzing.Settings.globalThreadList.Add(oThread, context);
			}

			//RefinementFuzzing.Settings.WritePrimaryLog(context.vcgen.proverStackBookkeeper.id, context.spartition.Id, "SpawnThread", "Starting thread: " + context.id);

			// Start the thread
			oThread.Start();

			// Spin for a while waiting for the started thread to become
			// alive:
			//while (!oThread.IsAlive) ;

			// Put the Main thread to sleep for 1 millisecond to allow oThread
			// to do some work:
			//Thread.Sleep(1);

			// Request that oThread be stopped
			//oThread.Abort();

			// Wait until oThread finishes. Join also has overloads
			// that take a millisecond interval or a TimeSpan object.
			//oThread.Join();

			return oThread;
		}
	}

	public class RF
	{
		static int currRefinementRound = 0;
		static int maxFuncId = 0;
		static Dictionary<int, int> history = new Dictionary<int, int>();
		static int baseProb = 3;
		static private Random r = new Random();
		static public StreamWriter writer = new StreamWriter("C:\\Test\\InliningLog.txt");

		public static void SelectCandidates(StratifiedInlining.FCallHandler calls, ProverInterface prover, List<int> candidates)
		{
            Console.WriteLine("Inside SelectCandidates\n");
            //return;

            currRefinementRound++;

			writer.WriteLine("(Original) " + currRefinementRound + ": " + candidates.Count);

			if (!Settings.__MYCHANGES__)
				return;

			//SelectCandidates4(calls, prover, candidates);
			SelectCandidates2(candidates);

			writer.WriteLine("(Modified) " + currRefinementRound + ": " + candidates.Count);
		}

		public static void SelectCandidates4(StratifiedInlining.FCallHandler calls, ProverInterface prover, List<int> candidates)
		{
            Console.WriteLine("Inside SelectCandidates4\n");
            if (candidates.Count < 2)
				return;

			List<int> newCandidates = new List<int>();

			//            while (newCandidates.Count <= (candidates.Count / baseProb)) { 
			List<VCExpr> assumptions = new List<VCExpr>();
			List<VCExpr> softAssumptions = new List<VCExpr>();
			foreach (int id in candidates)
			{
				// Disable one of the candidates
				softAssumptions.Add(calls.getFalseExpr(id));
			}

			List<int> unsatCore = new List<int>();

			MyErrHandler errHandler = new MyErrHandler(calls, candidates);
			ProverInterface.Outcome outcome = prover.CheckAssumptions(assumptions, softAssumptions, out unsatCore, errHandler);

			if (outcome == ProverInterface.Outcome.Valid)
			{
				// This call-site is important for the error
				//Console.WriteLine("Important");
				throw new Exception();

			}
			else if (outcome == ProverInterface.Outcome.Invalid)
			{
				// This call-site is not important for the error

				if (softAssumptions.Count == 0)
				{
					Console.WriteLine("Disjoint Partitioning!");
				}
				else
				{
					Console.WriteLine("Subset Obtained!");

					foreach (int i in candidates)
					{
						if (errHandler.getSolutionValue(i))
						{
							newCandidates.Add(i);
						}
					}
				}
			}
			else
			{
				throw new Exception();
			}


			if (newCandidates.Count == 0)
			{
				Console.WriteLine("No candidate is important --- adding one");
				int x = candidates[0];
				candidates.Clear();
				candidates.Add(x);
				return;
			}
			else
			{
				candidates.Clear();
				newCandidates.Iter<int>(n => candidates.Add(n)); // needed to add the project "Core"
			}
		}

		class MyErrHandler : ProverInterface.ErrorHandler
		{
			private StratifiedInlining.FCallHandler calls;
			private List<int> candidates;
			private Dictionary<int, bool> id2Value = new Dictionary<int, bool>(); // SMTSolver solution: candidate id to its bool

			public MyErrHandler(StratifiedInlining.FCallHandler calls, List<int> candidates)
			{
				// TODO: Complete member initialization
				this.calls = calls;
				this.candidates = candidates;
			}
			public override void OnModel(IList<string>/*!>!*/ labels, Model model, ProverInterface.Outcome proverOutcome)
			{
				// TODO: it would be better to check which reachability variables are actually set to one!
				List<Block> traceNodes = new List<Block>();
				List<AssertCmd> assertNodes = new List<AssertCmd>();

				//Console.WriteLine(model.ToString());

				//var x = model.GetElement("var2");

				foreach (int id in candidates)
				{
					var v = calls.id2ControlVar[id];
					var f = model.GetFunc(v.Name);
					Model.Boolean e = f.GetConstant() as Model.Boolean;
					id2Value[id] = e.Value;
					Console.WriteLine("{0} --> {1}", f.Name, f.GetConstant());
				}

				//model.Write(Console.Out);

				foreach (string s in labels)
				{
					//  Console.Write("{0}, ", s);
					// Contract.Assert(s != null);
					//Absy node = Label2Absy(s);
					//if (node is Block)
					//{
					//   Block b = (Block)node;
					//   traceNodes.Add(b);
					//    Console.Write("{0}, ", b.Label);
					//}
				}
				//m_CurrentTrace.AddRange(traceNodes);
			}

			public bool getSolutionValue(int id) 
			{
				return id2Value[id];
			}
		}

		public static void SelectCandidates3(StratifiedInlining.FCallHandler calls, ProverInterface prover, List<int> candidates)
		{
            Console.WriteLine("Inside SelectCandidates3\n");
            if (candidates.Count < 3)
				return;

			List<int> newCandidates = new List<int>();

			//            while (newCandidates.Count <= (candidates.Count / baseProb)) { 
			List<VCExpr> assumptions = new List<VCExpr>();
			foreach (int id in candidates)
			{
				// Disable one of the candidates
				assumptions.Clear();
				assumptions.Add(calls.getFalseExpr(id));

				List<int> unsatCore = new List<int>();

				ProverInterface.Outcome outcome = prover.CheckAssumptions(assumptions, new List<VCExpr>(), out unsatCore, new ProverInterface.ErrorHandler());

				if (outcome == ProverInterface.Outcome.Valid)
				{
					// This call-site is important for the error
					Console.WriteLine("Important");
					newCandidates.Add(id);
				}
				else if (outcome == ProverInterface.Outcome.Invalid)
				{
					// This call-site is not important for the error
					Console.WriteLine("Unimportant");
				}
				else
				{
					throw new Exception();
				}
			}

			if (newCandidates.Count == 0)
			{
				Console.WriteLine("No candidate is important --- adding one");
				int x = candidates[0];
				candidates.Clear();
				candidates.Add(x);
				return;
			}
			else
			{
				candidates.Clear();
				newCandidates.Iter<int>(n => candidates.Add(n)); // needed to add the project "Core"
			}
		}

		public static void SelectCandidates2(List<int> candidates)
		{
            Console.WriteLine("Inside SelectCandidates2\n");
            List<int> newCandidates = new List<int>();

			//            while (newCandidates.Count <= (candidates.Count / baseProb)) { 
			foreach (int id in candidates)
			{
				int refineLevelAdded = 0;
				bool present = history.TryGetValue(id, out refineLevelAdded);
				int probNumerator = 1;

				if (present)
				{
					if (currRefinementRound - refineLevelAdded > 5)
					{
						probNumerator = 1; //forget very old candidates
						history.Remove(id);
						history.Add(id, currRefinementRound);
					}
					else
						probNumerator = currRefinementRound - refineLevelAdded + 2;
				}
				else
				{
					history.Add(id, currRefinementRound);
				}

				int random = r.Next(baseProb);
				//  Console.WriteLine(random);

				if (random < probNumerator)
				{
					// Console.WriteLine("true");
					if (!newCandidates.Contains(id))
						newCandidates.Add(id);
				}
				else
				{
					// Console.WriteLine("false");
				}
			}
			//            }

			//Console.ReadKey();

			candidates.Clear();
			newCandidates.Iter<int>(n => candidates.Add(n)); // needed to add the project "Core"
		}

		public static void SelectCandidates1(List<int> candidates)
		{
            Console.WriteLine("Inside SelectCandidates1\n");
            Console.WriteLine("candidates: ");
			Settings.PrintAll(candidates);

			Console.WriteLine("Removing: ");
			int last = candidates.Max();
			Random r = new Random();
			List<int> newCandidates = new List<int>();
			//vState.calls.currCandidates = new HashSet<int>();
			int threshold = Settings.getThreshold(candidates);
			while (newCandidates.Count() < threshold)
			{
				int num = r.Next(0, candidates.Count);
				if (!newCandidates.Contains(candidates[num]))
					newCandidates.Add(candidates[num]);
				// vState.calls.currCandidates.Add(num);
			}

			candidates.Clear();
			newCandidates.Iter<int>(n => candidates.Add(n)); // needed to add the project "Core"
		}
	}


	public class Settings
	{
		public static bool __MYCHANGES__ = true;
		public static bool interpolatingProver = false;

		public delegate void RunHoudiniFuncType(Microsoft.Boogie.Program program, List<VCExpr> invList, Dictionary<VCExpr, bool> result);

		internal static int getThreshold(List<int> lst)
		{
			return lst.Count / 2;
		}

		internal static void PrintAll(List<int> lst)
		{
			foreach (int x in lst)
			{
				Console.WriteLine(x);
			}
		}

		// Set it here to increase the verbosity from Z3
		public static int ProverVerbosity = 0;

		// Set it here for ReadKey after each partition is retrieved
		public static bool PausedExecution { get { return false; } }

		// Set it here for ReadKey after each partition is retrieved
		public static bool SimplifyInterpolant { get { return true; } }

		// Set it here for ReadKey after each partition is retrieved
		public static bool PrintInterpolant { get { return false; } }

		// CANDIDATE_SUMMARY: summary is kept for each call site summary (cheap to use as no renaming of variables required);
		// PROC_SUMMARY: summary from multiple call sites are conjuncted (stronger summaries)
		//public static SummaryDB.SummaryType SummaryTypeInUse { get { return SummaryDB.SummaryType.PROC_SUMMARY; } }

		//public static bool flushProverLog { get { return true; } } // set true to flush prover logfile at every send (expensive)

		public static HashSet<VCExpr> vc_set = new HashSet<VCExpr>();
		public static HashSet<VCExpr> interpolant_set = new HashSet<VCExpr>();

		public enum TraversalStyle { DefaultBreadthFirst, DepthFirst, RandomizedDepthFirst, SaveFile, CostBasedSelection };
		public enum CostFunction { Random, CexSimilarity };
		public static TraversalStyle traversalStyle = TraversalStyle.CostBasedSelection;
		public static CostFunction costFunction = CostFunction.CexSimilarity;

		public enum CounterexampleEnumerationStrategy { SoftBlocking, EnumerateAll, DisjointModuleSummaries };
		public static CounterexampleEnumerationStrategy counterexampleEnumerationStrategy = CounterexampleEnumerationStrategy.DisjointModuleSummaries;
		//public static CounterexampleEnumerationStrategy counterexampleEnumerationStrategy = CounterexampleEnumerationStrategy.DisjointModuleSummaries;

		public static int enumerationBound = 50;

		public static bool consoleRun = true;

		// Essential to running our implementation in opposition to SI (set the flag isDistributed, isConcurrent to run the concurrent or distributed version)
		public static bool concurrentSolving = true;

		public static int pendingThreshold = 100000;

		public static bool reachedRecursionBound = false;

		//public static Func<Tuple<object, List<HoudiniPacket>>, int> RunHoudini;
		public static Func<string, object, int> RunAsChild;
		public static Func<string, object, object> ResumeFromParent;

		public static string summaryPrintFile = "summary.txt";
		//public static string summaryPrintFile = null;

		// careful! very expensive
		//public static string summaryLog = "summaryLog.html";
		public static string summaryLog = null;
		//public static bool summaryLogHTML = true;
		public static bool summaryLogHTML = false;

		public static bool DoFullResets = false;

		//public static RunHoudiniFuncType RunHoudini;

		public static int HoudiniVerifiedTrue = 0;

		public static int HoudiniVerifiedTotal = 0;

		public static bool UseHoudini = false;

		public static object HoudiniInstance;

		public static bool DumpHoudiniFiles = false;

		// This needs to be used with "true"; Houdini inserts some instrumentation in the program due to 
		// which they don't work properly next time
		public static bool HoudiniReloadProgramEveryTime = true;

		public static bool houdiniProver = false;

		public static bool useOptimizedProverStack = true;

		public static bool isDistributed = false;
		public static bool isConcurrent = false;

		//public static bool vcWithLabels = true;

		// Use Z3 to simplify the SummaryDB (very expensive)
		public static bool doSimplify = false; // cannot be done on a prover that produces unsat-cores

		public static bool addInfeasibilityConstraints = false;

		public static bool FindProverExecutableEveryTime = true;
		public static bool RandomizedSoftPartitions = false;

		// allows two counterexamples to overlap
		public static bool PartitionBoundariesSoft = true;

		// Copies the actual parameters into fresh variables --- required for tree interpolation
		public static bool FreshParamCopies = true;

		// creates a new set of actual parameters copying, with equality constraints for variables passed (which may alias) and literals (which disappear in the VC)
		// this step prevents procedure summaries from having existentials and also subsumes "FreshParamCopies"
		//public static bool NewFormalCopies = false && !FreshParamCopies; // FreshParamCopies must be off

		// how many softpartitions to create from one parent
		public static int SoftPartitionBound = 1;

		public static int totalThreadBudget = 4;

		public static System.Object lockThis = new System.Object();
		public static StreamWriter primaryLog = new StreamWriter("PrimaryLog.txt");
		public static StreamWriter partitioningLog = new StreamWriter("PartitioningLog.txt");

		public static bool useInterpolatingAsMainProver = true;

		public static bool preAllocateProvers = true;

		public static bool treatInterpolantNULLAsInterpolantTrue = false;

		public static bool proverSendUnderLock = true;
		public static object proverSendLock = new object();

		public static string error_msg;

		public static bool constructExplorationGraph = false;
		public static Common.GraphUtil explorationGraph = new GraphUtil("abc.dot");
		public static bool refreshExplorationGraph = true;
		public static Dictionary<int, string> candidateNames = new Dictionary<int, string>();

		public static int timeout = 3600; // timeout in seconds; zero to disable

		public static bool useConcurrentSummaryDB = true;

		public enum SymbolicHodiniStrategy { QuantifierEliminate, ConcretizeFuncArgs, ConcretizeFreeVars };
		public static SymbolicHodiniStrategy symbolicHoudiniStrategy = SymbolicHodiniStrategy.ConcretizeFreeVars;

		public enum ThreadJoinStrategy { ContinueAfterFirstChildReturns, WaitForAllChildren };
		public static ThreadJoinStrategy threadJoinStrategy = ThreadJoinStrategy.ContinueAfterFirstChildReturns;

		public static bool estimateParallelism = false && !isConcurrent && !isDistributed;

		public static bool instantlyPropagateSummaries = true;

		public static bool useDifferentZ3Seeds = false;

		public static OverlappingTimingStatisticManager oTimer = new OverlappingTimingStatisticManager();

		public static Dictionary<Thread, RefinementFuzzing.ConcurrentContext> globalThreadList = new Dictionary<Thread, ConcurrentContext>();

		//public static TimedMonitor timedLock = new TimedMonitor();

		// this says with what probability does we decide to spawn threads for partitioning
		public static double seedProbForPartitioning = 1.0/10;

		public static double getProbForPartitioning(int n)
		{
            Console.WriteLine("Inside getProbForPartitioning\n");
            if (n == 0) return seedProbForPartitioning;

			double inv = 1.0 / seedProbForPartitioning;
			double v = Math.Pow((inv)/(inv - 1), n-1) / (inv-1);
			return v;
		}

		public static Dictionary<int, int> softpartition2partitionCounts = new Dictionary<int,int>();
		public static bool DoPredAbsOnSummaries = false;
		public static string AbstractSummaryFile = "AbstractSummaries.txt";

		public static bool needErrorTraces = false;

		//public static bool assertExistingSummaryForInterpolation = true; // summary generation as interp(VC, context /\ existing_summary)

		public static bool generateTraceBlock = false;

		// record large summaries as candidate summaries so that the time to mutate etc. is saved (-ve to disable)
		public static int largeSummariesAsCandidateSummariesThreshold = 100000; // will only work if lazySummaries is true

		public static bool noInterpolationOnMainProver = false; // set "true" to turn summaries off

		public static bool lazySummaries = true;    // refrains from inserting blocked nodes in each softpartition
		public static bool lazyLazySummaries = true; // summary generation only on SAT for the whole tree expanded by UNSAT

		public static bool suppressZ3Errors = true;

		public static bool disableUnderapproxMode = true;

		public static bool reduceInterpolationUsingUnsatCore = true;

		#if false
		public static StreamWriter inliningFile = new StreamWriter("InliningFile.txt");
		#endif

		#if true
		public static StreamWriter lastInliningFile = null;
		//public static StreamWriter lastInliningFile = new StreamWriter("LastInlined.txt");
		public static StreamReader guideOnPathFile = null;
		#else
		public static StreamWriter lastInliningFile = null;
		public static StreamReader guideOnPathFile = new StreamReader("LastInlined.txt");
		#endif

		public static SoftPartition ErrPartition;
		public static bool doSimplifyViaCNF = false;

		// If the recursive calls have been expanded till the recursion bound, mark the summaries as Safe (Overapprox)
		public static bool FullRecursiveUnrolledAsSafe = true;

		public static void WritePrimaryLog(int proverId, int id, string funcName, string msg) 
		{
			lock (primaryLog)
			{
				primaryLog.WriteLine("[{3}] SoftPartition {0} : {1} : {2}", id, funcName, msg, proverId);
				primaryLog.Flush();
			}
		}

		public static void WritePartitioningLog(int proverId, SoftPartition s, int numPartitions, bool partitionDecision, VerificationState vstate = null, SoftPartition s1 = null, SoftPartition s2 = null)
		{
            // TODO: write proper logs
			lock (RefinementFuzzing.Settings.lockThis)
				//using (RefinementFuzzing.Settings.timedLock.Lock())
			{
				if (!partitionDecision)
					partitioningLog.WriteLine("\n[{0}] SoftPartition {1} has {2} partitions : not partitioned", proverId, s.Id, numPartitions);
				else
				{
					if (s2 == null)
						partitioningLog.WriteLine("\n[{0}] SoftPartition {1} has forced partitions : partitioned into {3}", proverId, s.Id, numPartitions, s1.Id);
					else
						partitioningLog.WriteLine("\n[{0}] SoftPartition {1} has {2} partitions : partitioned into {3}, {4}", proverId, s.Id, numPartitions, s1.Id, s2.Id);

					
				}
				partitioningLog.Flush();
			}
		}

		public static void SetConfiguration(int choice)
		{
			switch (choice)
			{
			case 0:
				; // default: no change in setting
				break;

			case 1:
				{
					// concurrent
					isConcurrent = true;
					totalThreadBudget = 2;
					traversalStyle = TraversalStyle.DefaultBreadthFirst;
				}
				break;

			case 2:
				{
					// best config for sequential
					isConcurrent = false;
					consoleRun = true;
					totalThreadBudget = 1;
					traversalStyle = TraversalStyle.DepthFirst;
					estimateParallelism = true && !isConcurrent && !isDistributed;
				}
				break;

			case 3:
				{
					// concurrent -- eight threads
					isConcurrent = true;
					totalThreadBudget = 4;
					SoftPartitionBound = 4;
					traversalStyle = TraversalStyle.CostBasedSelection;
					costFunction = CostFunction.CexSimilarity;
				}
				break;

			case 4:
				{
					// concurrent -- eight threads
					consoleRun = true;
					isConcurrent = true;
					totalThreadBudget = 8;
					SoftPartitionBound = 8;
					traversalStyle = TraversalStyle.DefaultBreadthFirst;
				}
				break;

			case 5:
				{
					// concurrent
					isConcurrent = true;
					consoleRun = false;
					totalThreadBudget = 2;
					SoftPartitionBound = 2;
					useConcurrentSummaryDB = true;
					traversalStyle = TraversalStyle.RandomizedDepthFirst;
					threadJoinStrategy = ThreadJoinStrategy.ContinueAfterFirstChildReturns;
				}
				break;

			case 6:
				{
					// concurrent
					isConcurrent = true;
					consoleRun = false;
					totalThreadBudget = 4;
					SoftPartitionBound = 2;
					useConcurrentSummaryDB = true;
					traversalStyle = TraversalStyle.RandomizedDepthFirst;
					threadJoinStrategy = ThreadJoinStrategy.ContinueAfterFirstChildReturns;
				}
				break;

			case 7:
				{
					// concurrent
					isConcurrent = true;
					consoleRun = false;
					totalThreadBudget = 8;
					SoftPartitionBound = 2;
					useConcurrentSummaryDB = true;
					traversalStyle = TraversalStyle.RandomizedDepthFirst;
					threadJoinStrategy = ThreadJoinStrategy.ContinueAfterFirstChildReturns;
				}
				break;

			case 8:
				{
					isConcurrent = true;
					consoleRun = true;
					totalThreadBudget = 2;
					SoftPartitionBound = 2;
					useConcurrentSummaryDB = true;
					traversalStyle = TraversalStyle.DefaultBreadthFirst;
					threadJoinStrategy = ThreadJoinStrategy.ContinueAfterFirstChildReturns;
				}
				break;

			default:
				Console.WriteLine("Unknown configuration option for configSetting");
				Contract.Assert(false);
				break;
			}
		}

		// If some other thread updates the summary while this current thread was computing the summary,
		// do not update the new summary as the summary from the other thread may be enough
		public static bool handleSummaryUpdateConflicts = true;
        internal static int debugCounter;
    }
}
