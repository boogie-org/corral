using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics.Contracts;
using System.IO;
using Microsoft.Boogie;
using System.Threading;
using Microsoft.Basetypes;
using Microsoft.Boogie.VCExprAST;
using VC;

namespace CoreLib
{
	public enum VerifyResult { Verified, Partitioned, BugFound, Errors, NoMoreConstraintPartition, Interrupted };

	[Serializable()]
	public class SoftPartition
	{
		public static int totalPartitions = 0; // for assigning id

		private int id;
		public int level;
		int parentId;
		public SoftPartition parent;
		public VCExpr prefixVC = null;  // hold the vc of the prefix trace; it does not include the VCs in the current softpartition (i.e. the candidates in lastInlined)

		//public bool stale; // the constraint of this node on the prover stack is now stale (maybe due to new summaries produced)

		/*
         * candidateUniverse is the set of all the inlined candidates in this partition
         * activeCandidates is the set of all non-inlined candidates which are candiates to be opened in this partition
         * lastInlined is the set of all inlined candidates from the parent SoftPartition to this SoftPartition
         * 
         */
		//public HashSet<int> currUnopenedCandidates;
		//public HashSet<int> inlinedCandidates;
		public HashSet<StratifiedCallSite> activeCandidates;
		public HashSet<StratifiedCallSite> blockedCandidates;
        public HashSet<StratifiedCallSite> mustreachCandidates;
		public HashSet<StratifiedCallSite> candidateUniverse;  // the universe expands as we go deeper

		public HashSet<StratifiedCallSite> candidatesReachingRecBound;

		public HashSet<StratifiedCallSite> lastInlined;

		public static Dictionary<int, SoftPartition> id2SoftPartition = new Dictionary<int, SoftPartition>();

		public int pendCount = 0;

		public int Id { get { return id; } }

		public Common.GraphNode graphNode;

		private void setupSoftPartition(SoftPartition parent, int parentId, int partitionLevel, HashSet<StratifiedCallSite> activeCandidates, HashSet<StratifiedCallSite> blockedCandidates, HashSet<StratifiedCallSite> candidateUniverse, HashSet<StratifiedCallSite> lastInlined, HashSet<StratifiedCallSite> candidatesReachingRecBound, VCExpr prefixVC = null)
		{
			lock (RefinementFuzzing.Settings.lockThis)
				//using (RefinementFuzzing.Settings.timedLock.Lock())
			{
				id = totalPartitions++;
				id2SoftPartition[id] = this;
			}

			this.parentId = parentId;
			this.parent = parent;
			this.level = partitionLevel;
			this.activeCandidates = activeCandidates;
			this.blockedCandidates = blockedCandidates;
			this.candidateUniverse = candidateUniverse;
			this.candidatesReachingRecBound = candidatesReachingRecBound;
			this.lastInlined = lastInlined;
			this.prefixVC = prefixVC;
			//this.stale = false;

			if (RefinementFuzzing.Settings.constructExplorationGraph)
			{
				lock (RefinementFuzzing.Settings.lockThis)
				{
					if (id != 0)
					{
						this.graphNode = new Common.GraphNode(id, this.lastInlined);
						graphNode.backtrackCount = parent.pendCount;
						RefinementFuzzing.Settings.explorationGraph.AddEdge(parent.graphNode, this.graphNode);
					}
					else
					{
						this.graphNode = new Common.GraphNode(id, new HashSet<StratifiedCallSite>());
						RefinementFuzzing.Settings.explorationGraph.SetRoot(this.graphNode);
					}
				}
			}
		}

		public SoftPartition(SoftPartition parent, int parentId, int partitionLevel, HashSet<VC.StratifiedCallSite> activeCandidates, HashSet<VC.StratifiedCallSite> blockedCandidates, HashSet<VC.StratifiedCallSite> candidateUniverse, HashSet<VC.StratifiedCallSite> lastInlined, HashSet<VC.StratifiedCallSite> candidatesReachingRecBound, VCExpr prefixVC = null)
		{
			setupSoftPartition(parent, parentId, partitionLevel, activeCandidates, blockedCandidates, candidateUniverse, lastInlined, candidatesReachingRecBound, prefixVC);
		}

		public SoftPartition(SoftPartition parentPartition, IEnumerable<StratifiedCallSite> newActiveCandidates, IEnumerable<StratifiedCallSite> newBlockedCandidates, IEnumerable<StratifiedCallSite> candidatesInlined, HashSet<StratifiedCallSite> candidatesThatReachingRecBound, VCExpr prefixVC = null)
		{
			HashSet<StratifiedCallSite> activeCandidates = new HashSet<StratifiedCallSite>();
			HashSet<StratifiedCallSite> candidateUniverse = new HashSet<StratifiedCallSite>();
			HashSet<StratifiedCallSite> blockedCandidates = new HashSet<StratifiedCallSite>();
			HashSet<StratifiedCallSite> lastInlined = new HashSet<StratifiedCallSite>();
			HashSet<StratifiedCallSite> candidatesReachingRecBound = new HashSet<StratifiedCallSite>();

			candidatesInlined.Iter<StratifiedCallSite>(n => lastInlined.Add(n));

			newActiveCandidates.Iter<StratifiedCallSite>(n => { activeCandidates.Add(n); });
			//parentPartition.activeCandidates.Iter<int>(n => activeCandidates.Add(n));

			parentPartition.candidateUniverse.Iter<StratifiedCallSite>(n => candidateUniverse.Add(n));
			candidatesInlined.Iter<StratifiedCallSite>(n => candidateUniverse.Add(n));

			parentPartition.blockedCandidates.Iter<StratifiedCallSite>(n => blockedCandidates.Add(n));
			newBlockedCandidates.Iter<StratifiedCallSite>(n => { blockedCandidates.Add(n); });

			candidatesThatReachingRecBound.Iter<StratifiedCallSite>(n => candidatesReachingRecBound.Add(n));

			setupSoftPartition(parentPartition, parentPartition.Id, parentPartition.level + 1, activeCandidates, blockedCandidates, candidateUniverse, lastInlined, candidatesReachingRecBound, prefixVC);
		}

		private string printHashSet(HashSet<StratifiedCallSite> hs)
		{
			StringBuilder sb = new StringBuilder();
			sb.Append("{");
			foreach (StratifiedCallSite i in hs)
			{
				sb.Append(i + ", ");
			}
			//sb.Remove(-1, 1);
			sb.Append("}");

			return sb.ToString();
		}

		public string printSoftPartition()
		{
			StringBuilder sb = new StringBuilder();
			sb.Append("(" + id + ")");
			sb.Append("[active: " + printHashSet(activeCandidates));
			sb.Append("; blocked: " + printHashSet(blockedCandidates));
			sb.Append("; universe: " + printHashSet(candidateUniverse));
			sb.Append("; lastInlined: " + printHashSet(lastInlined) + "]");
			return sb.ToString();
		}

		public bool isEquivalent(Object obj)
		{
			if (this == obj)
				return true;

			SoftPartition o2 = obj as SoftPartition;

			if (this.level != o2.level)
				return false;

			if (this.parentId != o2.parentId)
				return false;

			if (!this.activeCandidates.SetEquals(o2.activeCandidates))
				return false;

			if (!this.blockedCandidates.SetEquals(o2.blockedCandidates))
				return false;

			if (!this.candidateUniverse.SetEquals(o2.candidateUniverse))
				return false;

			if (!this.candidatesReachingRecBound.SetEquals(o2.candidatesReachingRecBound))
				return false;

			if (!this.lastInlined.SetEquals(o2.lastInlined))
				return false;

			return true;
		}

		public bool isSubsumedIn(IEnumerable<SoftPartition> spSet)
		{
			foreach (SoftPartition sp in spSet)
			{
				if (isEquivalent(sp))
					return true;
			}

			return false;
		}
	}

	// Store important information related to a single VerifyImplementation query
	public class VerificationState
	{
		// The call tree
		//public StratifiedInlining.FCallHandler calls;
        //public StratifiedInlining.ApiChecker checker;
        public StratifiedInliningErrorReporter reporter;
        public ProverStackBookkeeping proverBookeeper;
		// For statistics
		public int vcSize;
		public int expansionCount;
        public StratifiedInlining.SiState siState;
		//public SummaryDB summaryDB;

		// For making summary queries on the side
		//public ApiChecker checker2;

		public static int newVarCnt = 0;

		public int threadBudget; // Number of child threads that can be spawned by this thread
		public int proverId;

		public VerificationState(StratifiedInliningErrorReporter reporter, ProverStackBookkeeping proverBookeeper)
		{
			//prover.Assert(vcMain, true);
			//this.calls = calls;
            this.reporter = reporter;
			//this.checker = new StratifiedInlining.ApiChecker(prover, reporter);
			vcSize = 0;
			expansionCount = 0;
			threadBudget = RefinementFuzzing.Settings.totalThreadBudget;
			proverId = 0;
            this.proverBookeeper = proverBookeeper;
		}

        /*
		public VerificationState(StratifiedInlining.FCallHandler calls, ProverInterface prover, ProverInterface.ErrorHandler reporter,
			ProverInterface prover2, ProverInterface.ErrorHandler reporter2)
			: this(calls)
		{
			//this.checker2 = new ApiChecker(prover2, reporter2);
			threadBudget = RefinementFuzzing.Settings.totalThreadBudget;
			proverId = 0;
		}
        */

		public VerificationState(VerificationState vstate, StratifiedInliningErrorReporter reporter, int proverId, ProverStackBookkeeping proverBookeeper)
		{
			//this.calls = calls;
			//this.checker = new StratifiedInlining.ApiChecker(prover, reporter);
			vcSize = vstate.vcSize;
			expansionCount = vstate.expansionCount;
			//this.newVarCnt = vstate.newVarCnt;
			this.threadBudget = vstate.threadBudget;
			this.proverId = proverId;
            this.reporter = reporter;
            this.proverBookeeper = proverBookeeper;
		}
        
	}


	public class ProverArrayManager
	{
		ProverStackBookkeeping[] proverArray;
		bool[] proverAvailable;
		int[] proverOwner;
		int numProvers;
		Program program;

		Dictionary<ProverStackBookkeeping, int> proverDict = new Dictionary<ProverStackBookkeeping, int>();

		public ProverArrayManager(int n, Program program, ProverInterface firstProver)
		{
			this.program = program;

			proverArray = new ProverStackBookkeeping[n];
			proverAvailable = new bool[n];
			proverOwner = new int[n];
			numProvers = n;

			for (int i = 0; i < n; i++)
			{
				ProverInterface mainProver;
				ProverInterface interpolatingProver;

				if (i == 0)
					mainProver = firstProver;
				else
					mainProver = ProverInterface.CreateProver(program, "proverLog" + i + ".txt", true, CommandLineOptions.Clo.ProverKillTime);

				interpolatingProver = mainProver;
				mainProver = null;

				proverArray[i] = new ProverStackBookkeeping(mainProver, i); // if main prover is null, interpolating prover is the main prover
				proverAvailable[i] = true;
				proverOwner[i] = -1;
				proverDict[proverArray[i]] = i;

			}
		}

		public void PrintTimers()
		{
			proverArray.Iter<ProverStackBookkeeping>(n => n.timingStatisticsManager.PrintStatistics(n.id));
		}

		public void ReturnProver(ProverStackBookkeeping prover, int ownerId, bool docheck = true)
		{
			lock (this)
			{
				int i = proverDict[prover];
				proverAvailable[i] = true;

				//proverDict.Remove(prover);

				proverOwner[i] = ownerId;

				if (ownerId != proverArray[i].Top())
				{
					// after a join when a child returns the stack to the parent
					proverArray[i].Pop();
				}

				if (docheck)
				{
					Contract.Assert(ownerId == proverArray[i].Top());

					if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
					{
						// cleanup
						prover.Pop();  // Remove the owner as it may be stale
					}
				}
			}
		}

		public ProverStackBookkeeping BorrowProver(int ownerId)
		{
			lock (this)
			{
				// Try to search for a prover which had the same owner
				for (int i = 0; i < numProvers; i++)
				{
					if (proverAvailable[i] && proverOwner[i] == ownerId)
					{
						proverAvailable[i] = false;
						// by default, all are trace provers
						//proverArray[i].isTraceProver = true;
						return proverArray[i];
					}
				}

				// Search for any free prover
				for (int i = 0; i < numProvers; i++)
				{
					if (proverAvailable[i])
					{
						if (!proverArray[i].doneResetOnce || RefinementFuzzing.Settings.generateTraceBlock)
						{
							proverArray[i].Reset();
							proverArray[i].doneResetOnce = true;
						}
						#if false
						else
						{
						proverArray[i].ReCreateProvers(program);
						}
						#endif

						// by default, all are trace provers
						//proverArray[i].isTraceProver = true;

						proverAvailable[i] = false;
						proverOwner[i] = ownerId;
						return proverArray[i];
					}
				}
			}

			return null;
		}



		public void RequestProver(ProverStackBookkeeping proverStackBookkeeping, int ownerId)
		{
			lock (this)
			{
				int i = proverDict[proverStackBookkeeping];
				Contract.Assert(proverAvailable[i]);

				proverAvailable[i] = false;
				proverOwner[i] = ownerId;
			}
		}

		public string GetStatus()
		{
			int available = 0;

			lock (this)
			{
				proverAvailable.Iter<bool>(n => { if (n) available++; });
			}

			return "free:" + available + "; busy: " + (numProvers - available);
		}

		public int GetFreeProverCount()
		{
			int available = 0;

			lock (this)
			{
				proverAvailable.Iter<bool>(n => { if (n) available++; });
			}

			return available;
		}
	}


	public class ProverStackBookkeeping
	{
		//static int cntr;

		public int id;

		public bool doneResetOnce = false;
		//public bool isTraceProver = true; // this prover has the prefix trace and not the whole VCs

		private ProverInterface mainProver;
        //public StratifiedInlining.ApiChecker checker;
        //public StratifiedInliningErrorReporter reporter;

        //private ProverInterface interpolatingProver;
        private Stack<int> proverStackStatus = new Stack<int>();

		public HashSet<int> pinnedPartitions = new HashSet<int>(); // set of all partitions inlined in the prover which cannot be removed as interpolation computation was unsuccessful or interpolant was large

		public HashSet<SoftPartition> stalePartitions = new HashSet<SoftPartition>();

		//public SummariesMetadataInProverStack metaStack;

		public Common.TimingStatisticManager timingStatisticsManager = new Common.TimingStatisticManager();

		public ProverStackBookkeeping(ProverInterface mainProver, int id)
		{
			if (RefinementFuzzing.Settings.useInterpolatingAsMainProver)
				this.mainProver = null;
			else
				this.mainProver = mainProver;
            //this.interpolatingProver = interpolatingProver;

            //metaStack = new SummariesMetadataInProverStack(this);

            this.id = id;
		}

		public void Push(SoftPartition sp)
		{
			proverStackStatus.Push(sp.Id);
			if (mainProver != null) mainProver.Push();
			//interpolatingProver.Push();

			//metaStack.Push(sp.activeCandidates, vstate);
		}

		public void PushPrefixTrace(SoftPartition sp)
		{
			proverStackStatus.Push(-sp.Id); // -ve refers to prefix trace
			if (mainProver != null) mainProver.Push();
			//interpolatingProver.Push();

			//metaStack.Push(new HashSet<int>(), vstate);
		}

		public const int INVALID = Int32.MinValue;
		public SoftPartition pendingInterpolation = null;
		public HashSet<int> deferredPartitions = new HashSet<int>();
		public HashSet<int> candidatesInUnsatCore = null;

		public void PushEmpty()
		{
			proverStackStatus.Push(INVALID);
			if (mainProver != null) mainProver.Push();
			//interpolatingProver.Push();

			//metaStack.Push(new HashSet<int>(), null);
		}

		public int Pop()
		{
			int id = proverStackStatus.Pop();

			if (!RefinementFuzzing.Settings.noInterpolationOnMainProver)
			{
				if (mainProver != null) mainProver.Pop();
				//	interpolatingProver.Pop();
			}

			//metaStack.Pop();

			//if (proverStackStatus.Count != metaStack.summariesStack.Count)
			//	Contract.Assert(false);

			return id;
		}

		public int Top()
		{
			return proverStackStatus.Peek();
		}

		public int Count()
		{
			return proverStackStatus.Count();
		}

		private void Assert(VCExpr expr, string name)
		{
			//lock (RefinementFuzzing.Settings.lockThis) // there is a race on RefinementFuzzing.Settings.vcWithLabels
			{
				if (mainProver != null)
				{
					mainProver.Assert(expr, true); // emit lebels but no names
				}

				//interpolatingProver.Assert(expr, true);
				//interpolatingProver.AssertForInterpolation(expr, name, true, false); // emit names but not labels as iZ3 cannot handle labels
			}

			/*
                if (mainProver != null)
                {
                    mainProver.Push();
                    mainProver.Assert(expr, true);
                    
                    mainProver.Push();
                    mainProver.Assert(expr, true);
                    
                    mainProver.Push();
                    mainProver.Assert(expr, true);
                    

                    mainProver.Push();
                    mainProver.Assert(expr, true);
                    mainProver.Pop();
                    mainProver.Pop();
                    mainProver.Pop();
                    mainProver.Pop();
                }
                 * */
		}

		public void Assert(VCExpr expr, string name, string comment)
		{
			//if (mainProver != null) mainProver.Comment(comment);
			//interpolatingProver.Assert(expr, true);
			//interpolatingProver.Comment(comment);

			Assert(expr, name);

		}

		public ProverInterface getMainProver()
		{
			Contract.Assert(RefinementFuzzing.Settings.preAllocateProvers);

			return mainProver;
		}

		public ProverInterface getInterpolatingProver()
		{
			Contract.Assert(RefinementFuzzing.Settings.preAllocateProvers);
			return null;
		}

		public void Reset()
		{
			Contract.Assert(RefinementFuzzing.Settings.preAllocateProvers);
			if (mainProver != null) mainProver.Reset(mainProver.VCExprGen);
			//interpolatingProver.CompleteReset(interpolatingProver.VCExprGen);
			proverStackStatus.Clear();
			//metaStack.summariesStack.Clear();

			//mainProver.FlushAxiomsToTheoremProver();
			//interpolatingProver.FlushAxiomsToTheoremProver();
		}

		internal string printStack()
		{
			StringBuilder sb = new StringBuilder();
			sb.Append("[");
			//for (int i = 0; i < proverStackStatus.Count; i++)
			//    sb += proverStackStatus[i];
			foreach (int i in proverStackStatus)
				sb.Append(i + ", ");
			sb.Append("]");
			return sb.ToString();
			//return proverStackStatus.ToString();
		}

		internal void ReCreateProvers(Program program)
		{
			mainProver.Close();
			//interpolatingProver.Close();
			mainProver = ProverInterface.CreateProver(program, null, true, CommandLineOptions.Clo.ProverKillTime);
			//interpolatingProver = ProverInterface.CreateProver(program, null, true, CommandLineOptions.Clo.ProverKillTime);
		}

		public Stack<int> getProverStackStatus()
		{
			return proverStackStatus;
		}

		public void putPinOnPartition(int spId)
		{
			pinnedPartitions.Add(spId);
		}

		public void releasePinOnPartition(int spId)
		{
			pinnedPartitions.Remove(spId);

			// also release all pinned partitions below it as this summary can stand for the full inlined call-tree
			List<int> proverStack = proverStackStatus.ToList();
			List<int> subTree = GetPartitionSubTree(spId, proverStack);

			subTree.Iter<int>(n => pinnedPartitions.Remove(n));
		}

		private List<int> GetPartitionSubTree(int candidateId, List<int> universalSet)
		{
			HashSet<int> notInSubtree = new HashSet<int>();
			HashSet<int> subTree = new HashSet<int> { candidateId };

			while (true)
			{
				foreach (int id in universalSet)
				{
					if (id == 0)
						continue;

					int parentId = -1;
					lock (RefinementFuzzing.Settings.lockThis)
					{
						parentId = SoftPartition.id2SoftPartition[id].parent.Id;
					}

					if (subTree.Contains(parentId))
					{
						subTree.Add(id);
					}
					else
					{
						notInSubtree.Add(id);
					}
				}

				if (universalSet.Count == notInSubtree.Count)
					break; // fixpoint reached
				else
				{
					universalSet = new List<int>(notInSubtree);
					notInSubtree.Clear();
				}
			}

			return subTree.ToList();
		}

	}


	public class ConcurrentSolver
	{
		//Dictionary<int, List<SoftPartition>> hierarchicalQueue = new Dictionary<int,List<SoftPartition>>();

		HierarchicalQueue hierarchicalQueue;
		Random rand = new Random();
		//StratifiedInlining.FCallHandler calls;
		StratifiedInlining vcgen;
		public VerificationState vState;

		static int ctr = 0;

		public ConcurrentSolver(StratifiedInlining vcgen, VerificationState vState)
		{
			this.vcgen = vcgen;
			this.vState = vState;
			//this.calls = vState.calls;
		}

		int currQLevel = 0;

		public VerifyResult Solve(List<StratifiedCallSite> entryPoints) // for a child, the entryPoints are the "open" candidates
		{
			List<SoftPartition> entryPartitions = new List<SoftPartition>();

			foreach (StratifiedCallSite e in entryPoints)
			{
				HashSet<StratifiedCallSite> universalCandidates = new HashSet<StratifiedCallSite>();
				universalCandidates.Add(e);

				//vState.calls.currCandidates.Iter<int>(n => universalCandidates.Add(n));

				HashSet<StratifiedCallSite> blockedCandidates = new HashSet<StratifiedCallSite>();
				HashSet<StratifiedCallSite> activeCandidates = new HashSet<StratifiedCallSite>();

				SoftPartition s = new SoftPartition(null, -1, 0, activeCandidates, blockedCandidates, universalCandidates, universalCandidates, new HashSet<StratifiedCallSite>());

				entryPartitions.Add(s);
			}

			VerifyResult ret = Solve(entryPartitions);

			return ret;
		}

		Tuple<Thread, RefinementFuzzing.ConcurrentContext> createThread(SoftPartition spawnForPartition, int childrenThreadBudget, WaitHandle waitHandle, SoftPartition parentPartition, int proverIndex)
		{
			StratifiedInlining childVCgen = null;
			ProverStackBookkeeping bookKeeper = null;

			if (RefinementFuzzing.Settings.preAllocateProvers)
			{
				// Borrow a prover
				//bookKeeper = StratifiedInlining.proverManager.BorrowProver(parentPartition.Id);
				bookKeeper = StratifiedInlining.proverManager.BorrowProver(parentPartition.Id);

				childVCgen = new StratifiedInlining(this.vcgen);
			}
			else
				; // TODO childVCgen = new StratifiedInlining(this.vcgen, null, false, new List<Checker>(), null);

			StratifiedInliningErrorReporter parentReporter = vState.reporter as StratifiedInliningErrorReporter;
			StratifiedInliningErrorReporter childErrReporter = new StratifiedInliningErrorReporter(parentReporter.callback, null, null); // TODO: handle the second and third arguments
			//childErrReporter.SetCandidateHandler(childCalls);

			if (RefinementFuzzing.Settings.preAllocateProvers)
				childVCgen.proverStackBookkeeper = bookKeeper;
			else
				childVCgen.proverStackBookkeeper = new ProverStackBookkeeping(childVCgen.prover, 0);

            // Put all of the necessary state into one object
            var ChildVState = new VerificationState(childErrReporter, childVCgen.proverStackBookkeeper);

            RefinementFuzzing.ConcurrentContext context = new RefinementFuzzing.ConcurrentContext(childVCgen, ChildVState, spawnForPartition, childrenThreadBudget, waitHandle, childVCgen.prover);

			Thread t = RefinementFuzzing.Concurrent.SpawnThread(context);

			return new Tuple<Thread, RefinementFuzzing.ConcurrentContext>(t, context);
		}

		Tuple<Thread, RefinementFuzzing.ConcurrentContext> createThreadWithProver(SoftPartition spawnForPartition, ProverStackBookkeeping bookKeeper, int childrenThreadBudget, WaitHandle waitHandle, SoftPartition parentPartition)
		{
			StratifiedInlining childVCgen = null;
			//ProverStackBookkeeping bookKeeper = null;

			if (RefinementFuzzing.Settings.preAllocateProvers)
			{

				// Borrow a prover
				//bookKeeper = StratifiedInlining.proverManager.BorrowProver(parentPartition.Id);
				//bookKeeper = StratifiedInlining.proverManager.BorrowProver(parentPartition.Id);

				if (RefinementFuzzing.Settings.useInterpolatingAsMainProver)
					; // TODO childVCgen = new StratifiedInlining(this.vcgen, null, false, new List<Checker>(), bookKeeper.getInterpolatingProver());
				else
					; // TODO childVCgen = new StratifiedInlining(this.vcgen, null, false, new List<Checker>(), bookKeeper.getMainProver());
			}
			else
				;// TODO childVCgen = new StratifiedInlining(this.vcgen, null, false, new List<Checker>(), null);
			//StratifiedInlining.VerificationState childVstate = new StratifiedInlining.VerificationState(vState);

			StratifiedInlining.FCallHandler childCalls = null;
			// TODO	StratifiedInlining.FCallHandler childCalls = new StratifiedInlining.FCallHandler(childVCgen.prover.VCExprGen, childVCgen.implName2StratifiedInliningInfo, calls);
			//calls.setCurrProcAsMain();

			StratifiedInliningErrorReporter parentReporter = vState.reporter as StratifiedInliningErrorReporter;
			StratifiedInliningErrorReporter childErrReporter = new StratifiedInliningErrorReporter(parentReporter.callback, null, null); // Handle the last two arguments
			childErrReporter.SetCandidateHandler(childCalls);

			// Put all of the necessary state into one object
			var ChildVState = new VerificationState(vState, childErrReporter, bookKeeper.id, bookKeeper);

			if (RefinementFuzzing.Settings.preAllocateProvers)
				childVCgen.proverStackBookkeeper = bookKeeper;
			else
				childVCgen.proverStackBookkeeper = new ProverStackBookkeeping(childVCgen.prover, 0);

			//Console.WriteLine("Spawning Threads. Press a key to continue...");
			//Console.ReadKey();

			RefinementFuzzing.ConcurrentContext context = new RefinementFuzzing.ConcurrentContext(childVCgen, ChildVState, spawnForPartition, childrenThreadBudget, waitHandle, childVCgen.prover);
			Thread t = RefinementFuzzing.Concurrent.SpawnThread(context);

			return new Tuple<Thread, RefinementFuzzing.ConcurrentContext>(t, context);
		}

		public VerifyResult Solve(List<SoftPartition> entryPartitions) // for a child, the entryPoints are the "open" candidates
		{
			if (RefinementFuzzing.Settings.counterexampleEnumerationStrategy == RefinementFuzzing.Settings.CounterexampleEnumerationStrategy.DisjointModuleSummaries && RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.DefaultBreadthFirst)
				return Solve1(entryPartitions);
			else
				return Solve2(entryPartitions);
		}

		public enum WorkType { SP, S_, _P }; // <softpartition, prover>, <softpartition, __>, <__, prover>

		Tuple<SoftPartition, ProverStackBookkeeping> getElement(List<Tuple<SoftPartition, ProverStackBookkeeping>> list, WorkType workType)
		{
			foreach (Tuple<SoftPartition, ProverStackBookkeeping> t in list)
			{
				if (workType == WorkType.SP && t.Item1 != null && t.Item2 != null)
				{
					list.Remove(t);
					return t;
				}
				else if (workType == WorkType.S_ && t.Item1 != null && t.Item2 == null)
				{
					list.Remove(t);
					return t;
				}
				else if (workType == WorkType._P && t.Item1 == null && t.Item2 != null)
				{
					list.Remove(t);
					return t;
				}
			}

			return null;
		}

		public VerifyResult Solve1(List<SoftPartition> entryPartitions) // for a child, the entryPoints are the "open" candidates
		{
			Contract.Assert(RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.DefaultBreadthFirst);
			Contract.Assert(RefinementFuzzing.Settings.useConcurrentSummaryDB);
			Contract.Assert(RefinementFuzzing.Settings.threadJoinStrategy == RefinementFuzzing.Settings.ThreadJoinStrategy.ContinueAfterFirstChildReturns);

			hierarchicalQueue = new HierarchicalQueue(entryPartitions, HierarchicalQueue.QType.BFS, vState);

			//ProverStackBookkeeping primaryProver = vcgen.proverStackBookkeeper;

			SoftPartition s;
			while ((s = hierarchicalQueue.getNextPartition(vcgen.proverStackBookkeeper)) != null)
			{
				List<SoftPartition> partitions;

				/*
                if (RefinementFuzzing.Settings.abortAllThreads)
                    return VerifyResult.Interrupted;
                */

				if (RefinementFuzzing.Settings.constructExplorationGraph)
				{
					lock (RefinementFuzzing.Settings.lockThis)
						//using (RefinementFuzzing.Settings.timedLock.Lock()) 
					{
						s.graphNode.scheduledOnProverId = vcgen.proverStackBookkeeper.id;
						s.graphNode.proverArrayState = StratifiedInlining.proverManager.GetStatus();

						if (RefinementFuzzing.Settings.refreshExplorationGraph)
						{
							RefinementFuzzing.Settings.explorationGraph.WriteDot();
						}
					}
				}

				if (s.level != currQLevel)
				{
					Console.Out.WriteLine("QLevel: " + s.level);
					hierarchicalQueue.printQStatistics();
					currQLevel = s.level;
				}
				else
				{
					Console.Write(".");
				}

				Console.WriteLine(s.printSoftPartition());

				if (RefinementFuzzing.Settings.PausedExecution)
					Console.ReadKey();

				double solTime;
				//VerifyResult outcome = Verify(s, out partitions, out solTime);
				List<Tuple<SoftPartition, ProverStackBookkeeping>> worklist = new List<Tuple<SoftPartition, ProverStackBookkeeping>>();
				List<Tuple<SoftPartition, ProverStackBookkeeping>> deferredWorklist = new List<Tuple<SoftPartition, ProverStackBookkeeping>>();
				//worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(s, vcgen.proverStackBookkeeper));
				worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(null, vcgen.proverStackBookkeeper));

				VerifyResult outcome;

				HashSet<SoftPartition> CexList = new HashSet<SoftPartition>();

				// Release prover -- we are spawning a thread and the parent will wait till it returns
				ProverStackBookkeeping originalProver = vcgen.proverStackBookkeeper;
				//originalProver.isTraceProver = false;
				//StratifiedInlining.proverManager.ReturnProver(vcgen.proverStackBookkeeper, s.Id);

				WaitHandle[] handles = new WaitHandle[RefinementFuzzing.Settings.totalThreadBudget];

				Dictionary<Thread, RefinementFuzzing.ConcurrentContext> threadList = new Dictionary<Thread, RefinementFuzzing.ConcurrentContext>();
				Dictionary<int, Thread> currRunningThreadsDict = new Dictionary<int, Thread>();

				for (int i = 0; i < handles.Count(); i++)
					handles[i] = new ManualResetEvent(false);

				//int nextThreadToRun = 0;
				int indexInRunningThreads = 0;

				double maxTime = 0;
				int totalNumCalls = 0;

				bool hasSpawnedThreads = false;

				while (true)
				{
					if (worklist.Count == 0)
					{
						// no more threads to run; just wait for the current ones to complete
						if (currRunningThreadsDict.Count == 0)
							break;

						int index = WaitHandle.WaitAny(handles);

						(handles[index] as ManualResetEvent).Reset();

						Thread t = currRunningThreadsDict[index]; // the thread that completed

						lock (RefinementFuzzing.Settings.lockThis)
						{
							t.Join();
							RefinementFuzzing.Settings.globalThreadList.Remove(t);
						}

						RefinementFuzzing.ConcurrentContext context = threadList[t];
						currRunningThreadsDict.Remove(index);

						Console.WriteLine("Join done");
						RefinementFuzzing.Settings.WritePrimaryLog(context.vcgen.proverStackBookkeeper.id, s.Id, "Solve", "Joining Thread " + context.id + " for soft partition: " + context.spartition.Id);

						// Get the result fom the child
						VerifyResult res = context.res;

						if (res != VerifyResult.Verified)
						{
							return res;
						}

						CexList.Remove(context.spartition);

						if (context.vcgen.timeTaken > maxTime)
							maxTime = context.vcgen.timeTaken;

						totalNumCalls += context.vcgen.numCalls;

						deferredWorklist.Iter<Tuple<SoftPartition, ProverStackBookkeeping>>(n => worklist.Add(n));
						deferredWorklist.Clear();

						// allow the prover to be used if possible
						worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(null, context.vcgen.proverStackBookkeeper));
					}

					// combine S_ and _P to SP if possible 
					CombineSP(worklist);

					Tuple<SoftPartition, ProverStackBookkeeping> workElem;

					if (null != (workElem = getElement(worklist, WorkType.SP)))
					{
						// got both softpartition and prover --- just run

						indexInRunningThreads = workElem.Item2.id;

						// there is a thread to be run
						SoftPartition spawnForPartition = workElem.Item1;
						ProverStackBookkeeping bookKeeper = workElem.Item2;

						RefinementFuzzing.Settings.WritePrimaryLog(bookKeeper.id, s.Id, "Solve", "Creating Thread for soft partition: " + spawnForPartition.Id);

						int tokenid = bookKeeper.timingStatisticsManager.StartTime(Common.TimingStatisticManager.TimingCategories.ThreadSpawn);
						Tuple<Thread, RefinementFuzzing.ConcurrentContext> tuple = createThreadWithProver(spawnForPartition, bookKeeper, -1, handles[indexInRunningThreads], s);
						bookKeeper.timingStatisticsManager.StopTime(tokenid, Common.TimingStatisticManager.TimingCategories.ThreadSpawn);
						threadList[tuple.Item1] = tuple.Item2;

						// assign the new thread the 'id' of the completed thread on the WaitHandles
						currRunningThreadsDict[indexInRunningThreads] = tuple.Item1;

					}
					else if (null != (workElem = getElement(worklist, WorkType._P)))
					{
						int numProvers = StratifiedInlining.proverManager.GetFreeProverCount();

						// partition 's'

						lock (s)
						{
							RefinementFuzzing.Settings.WritePrimaryLog(workElem.Item2.id, s.Id, "Solve1", "Attempting to enter critical section for softpartition: " + s.Id);
							outcome = vcgen.SolvePartition(s, vState, out partitions, out solTime, workElem.Item2, CexList, numProvers + 1); //available + the current prover
							RefinementFuzzing.Settings.WritePrimaryLog(workElem.Item2.id, s.Id, "Solve1", "Leaving critical section for softpartition: " + s.Id);

							if (partitions.Count > 1)
								Console.Write("ABC");
						}

						if (outcome == VerifyResult.Verified)
						{
							Contract.Assert(CexList.Count == 0);

							RefinementFuzzing.Settings.WritePrimaryLog(workElem.Item2.id, s.Id, "Solve1", "Not Returning prover (verified): " + workElem.Item2.id);
							//StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);

							// Partition Verified
							hierarchicalQueue.TaskCompleted(s);

							// Don't return the original prover as only it can do pops
							if (workElem.Item2 != originalProver)
							{
                                StratifiedInlining.proverManager.ReturnProver(workElem.Item2, s.Id);
							}
							else
								;// Contract.Assert(worklist.Count == 0); // only the original prover remains in the worklist

							vcgen.proverStackBookkeeper = originalProver;
							//vState.checker.prover = originalProver.getMainProver();
							//vState.summaryDB.prover5 = originalProver.getInterpolatingProver();

							Console.Write("BCD");
						}
						else if (outcome == VerifyResult.NoMoreConstraintPartition)
						{
							Contract.Assert(CexList.Count != 0);

							RefinementFuzzing.Settings.WritePrimaryLog(workElem.Item2.id, s.Id, "Solve1", "Returning prover (no more partitions found): " + workElem.Item2.id);

							// Don't return the original prover as only it can do pops
							if (workElem.Item2 != originalProver)
								StratifiedInlining.proverManager.ReturnProver(workElem.Item2, s.Id);
							//else
							//    worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(null, originalProver));

							//StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);

							// Partition Verified
							// hierarchicalQueue.TaskCompleted(s);
						}
						else if (outcome == VerifyResult.BugFound)
						{
							// Got an error with underapprox --- bug!

							RefinementFuzzing.Settings.ErrPartition = s;

							cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, 0, threadList, s);
							return VerifyResult.BugFound;
						}
						else if (outcome == VerifyResult.Partitioned)
						{
							Contract.Assert(partitions != null);

							//StratifiedInlining.proverManager.ReturnProver(vcgen.proverStackBookkeeper, s.Id);

							if (s.pendCount > RefinementFuzzing.Settings.pendingThreshold)
							{
								Helpers.ExtraTraceInformation("Pending threshold exceeded! Aborting.");

								if (RefinementFuzzing.Settings.consoleRun)
									Console.ReadKey();

								System.Environment.Exit(-1);
							}

							hierarchicalQueue.TaskPended(s);

							partitions.Iter<SoftPartition>(p => CexList.Add(p));

							if (partitions.Count > 1)
							{
								worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(partitions[0], workElem.Item2));
								partitions.RemoveAt(0);
								partitions.Iter<SoftPartition>(p => worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(p, null)));

								hasSpawnedThreads = true;
							}
							else if (hasSpawnedThreads) // previous iterations of the loop had spawned threads, then this function is running in concurrent mode with multiple solvers
							{
								Contract.Assert(partitions.Count == 1);
								worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(partitions[0], workElem.Item2));
							}
							else
							{
								partitions.Iter<SoftPartition>(p => hierarchicalQueue.TaskAdded(p)); // do sequentially
								continue;
							}

							Contract.Assert(RefinementFuzzing.Settings.isConcurrent);
						}
						else if (outcome == VerifyResult.Errors)
						{
							// Errors -- Give up!

							cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, 0, threadList, s);
							RefinementFuzzing.Settings.ErrPartition = s;

							return VerifyResult.Errors;
						}
						else
						{
							// Exception -- Give up!
							Contract.Assert(false);
						}

						// cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, 0, threadList, s);

						hierarchicalQueue.SetLowestLevelAsReady(vcgen.proverStackBookkeeper);

						// the parent should now get the prover back
						//StratifiedInlining.proverManager.RequestProver(vcgen.proverStackBookkeeper, s.Id);
					}
					else if (null != (workElem = getElement(worklist, WorkType.S_)))
					{
						// got only softpartition

						// request for a prover
						ProverStackBookkeeping bookKeeper = StratifiedInlining.proverManager.BorrowProver(s.Id);

						if (bookKeeper != null)
						{
							Tuple<SoftPartition, ProverStackBookkeeping> w = new Tuple<SoftPartition, ProverStackBookkeeping>(workElem.Item1, bookKeeper);
							worklist.Add(w);
						}
						else
						{
							// push the work element back (to a deferred worklist to avoid spinning) and wait!
							deferredWorklist.Add(workElem);
						}
					}
					else
						Contract.Assert(false);
				}


			}

			return VerifyResult.Verified;
		}

		private void CombineSP(List<Tuple<SoftPartition, ProverStackBookkeeping>> worklist)
		{
			while (true)
			{
				Tuple<SoftPartition, ProverStackBookkeeping> w1 = getElement(worklist, WorkType.S_);
				Tuple<SoftPartition, ProverStackBookkeeping> w2 = getElement(worklist, WorkType._P);

				if (w1 != null && w2 != null)
				{
					worklist.Add(new Tuple<SoftPartition, ProverStackBookkeeping>(w1.Item1, w2.Item2));
				}
				else if (w1 != null)
				{
					worklist.Add(w1);
					break;
				}
				else if (w2 != null)
				{
					worklist.Add(w2);
					break;
				}
				else
					break;
			}
		}

		public VerifyResult Solve2(List<SoftPartition> entryPartitions) // for a child, the entryPoints are the "open" candidates
		{
			//List<int> entryPoints = new List<int>();
			//entryPoints.Add(0); // only '0' for the moment

			hierarchicalQueue = new HierarchicalQueue(entryPartitions, HierarchicalQueue.QType.BFS, vState);

			SoftPartition s;
			while ((s = hierarchicalQueue.getNextPartition(vcgen.proverStackBookkeeper)) != null)
			{
				List<SoftPartition> partitions;

				if (RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.RandomizedDepthFirst)
				{
					lock (RefinementFuzzing.Settings.lockThis)
						//using (RefinementFuzzing.Settings.timedLock.Lock()) 
					{
						if (s.Id > 0)
							RefinementFuzzing.Settings.softpartition2partitionCounts[s.Id] = RefinementFuzzing.Settings.softpartition2partitionCounts[s.parent.Id];
						else
							RefinementFuzzing.Settings.softpartition2partitionCounts[s.Id] = 0;
					}
				}

				if (RefinementFuzzing.Settings.constructExplorationGraph)
				{
					lock (RefinementFuzzing.Settings.lockThis)
						//using (RefinementFuzzing.Settings.timedLock.Lock()) 
					{
						s.graphNode.scheduledOnProverId = vcgen.proverStackBookkeeper.id;
						s.graphNode.proverArrayState = StratifiedInlining.proverManager.GetStatus();

						if (RefinementFuzzing.Settings.refreshExplorationGraph)
						{
							RefinementFuzzing.Settings.explorationGraph.WriteDot();
						}
					}
				}

				if (s.level != currQLevel)
				{
					Console.Out.WriteLine("QLevel: " + s.level);
					hierarchicalQueue.printQStatistics();
					currQLevel = s.level;
				}
				else
				{
					Console.Write(".");
				}

				Console.WriteLine(s.printSoftPartition());

				if (RefinementFuzzing.Settings.PausedExecution)
					Console.ReadKey();

				double solTime;
				VerifyResult outcome = Verify(s, out partitions, out solTime);

				if (outcome == VerifyResult.Verified)
				{
					// Partition Verified
					hierarchicalQueue.TaskCompleted(s);

					if (RefinementFuzzing.Settings.estimateParallelism)
					{
						double maxChild = 0;
						s.graphNode.children.Iter<Common.GraphNode>(n => { maxChild = (maxChild > n.potentialParallelTime) ? maxChild : n.potentialParallelTime; });
						s.graphNode.potentialParallelTime += solTime + maxChild;

						if (s.Id == 0)
						{
							Console.Out.WriteLine("Estimated parallel run: {0}", (int)s.graphNode.potentialParallelTime);
						}
					}
				}
				else if (outcome == VerifyResult.BugFound)
				{
					// Got an error with underapprox --- bug!

					RefinementFuzzing.Settings.ErrPartition = s;

					return VerifyResult.BugFound;
				}
				else if (outcome == VerifyResult.Partitioned)
				{
					Contract.Assert(partitions != null);

					if (s.pendCount > RefinementFuzzing.Settings.pendingThreshold)
					{
						Helpers.ExtraTraceInformation("Pending threshold exceeded! Aborting.");

						if (RefinementFuzzing.Settings.consoleRun)
							Console.ReadKey();

						System.Environment.Exit(-1);
					}

					if (RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.RandomizedDepthFirst && partitions.Count > 1)
					{
						int min = RefinementFuzzing.Settings.SoftPartitionBound < vState.threadBudget ? RefinementFuzzing.Settings.SoftPartitionBound : vState.threadBudget;
						bool flag = false;
						bool tossDecision = false;

						if (min > 1)
						{
							flag = true;
							lock (RefinementFuzzing.Settings.lockThis)
								//using (RefinementFuzzing.Settings.timedLock.Lock())
							{
								double q = RefinementFuzzing.Settings.getProbForPartitioning(RefinementFuzzing.Settings.softpartition2partitionCounts[s.Id]);
								RefinementFuzzing.Settings.softpartition2partitionCounts[s.Id]++;

								if (rand.Next(100) < (q * 100))
								{
									tossDecision = true;
									; // allow partitioning
								}
								else
								{
									tossDecision = false;
									min = 1; // don't partition
								}
							}
						}

						int numPartitions = partitions.Count;
						List<SoftPartition> selectedSet = new List<SoftPartition>();

						for (int i = 0; i < min; i++)
						{
							int sel = rand.Next(partitions.Count);
							SoftPartition selectedPartition = partitions[sel];

							partitions.RemoveAt(sel);
							selectedSet.Add(selectedPartition);
						}

						partitions = selectedSet;

						if (flag && tossDecision && min > 1)
							RefinementFuzzing.Settings.WritePartitioningLog(vcgen.proverStackBookkeeper.id, s, numPartitions, tossDecision, vState, selectedSet[0], selectedSet[1]);
						else if (flag)
							RefinementFuzzing.Settings.WritePartitioningLog(vcgen.proverStackBookkeeper.id, s, numPartitions, tossDecision);

					}

					if (RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.CostBasedSelection && partitions.Count > 1)
					{
						int min = RefinementFuzzing.Settings.SoftPartitionBound < vState.threadBudget ? RefinementFuzzing.Settings.SoftPartitionBound : vState.threadBudget;

						int numPartitions = partitions.Count;

						partitions = SelectedSet(partitions, min);

						if (partitions.Count > 1)
							RefinementFuzzing.Settings.WritePartitioningLog(vcgen.proverStackBookkeeper.id, s, numPartitions, (partitions.Count > 1), vState, partitions[0], partitions[1]);
						else if (partitions.Count == 1)
							RefinementFuzzing.Settings.WritePartitioningLog(vcgen.proverStackBookkeeper.id, s, numPartitions, (partitions.Count > 1));

					}

					hierarchicalQueue.TaskPended(s);

					if (!RefinementFuzzing.Settings.isConcurrent)
						partitions.Iter<SoftPartition>(p => hierarchicalQueue.TaskAdded(p));

					/*
					if (RefinementFuzzing.Settings.isDistributed)
					{
						if (RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.SaveFile)
						{
							foreach (SoftPartition sp in partitions)
							{
								DistributedContext context = new DistributedContext(vState, sp);
								int retCode = RefinementFuzzing.Settings.RunAsChild("xyz" + (ctr++) + ".dat", context);
							}
						}
					}
					*/

					if (RefinementFuzzing.Settings.isConcurrent)
					{
						if (partitions.Count > 1 && vState.threadBudget > 1)
						{
							int numThreadsSpawned;

							numThreadsSpawned = (partitions.Count > vState.threadBudget) ? vState.threadBudget : partitions.Count;
							int childrenThreadBudget = vState.threadBudget / numThreadsSpawned;

							// Release prover -- we are spawning a thread and the parent will wait till it returns
							ProverStackBookkeeping originalProver = vcgen.proverStackBookkeeper;
							StratifiedInlining.proverManager.ReturnProver(vcgen.proverStackBookkeeper, s.Id);

							WaitHandle[] handles = new WaitHandle[numThreadsSpawned];
							//List<Thread> pendingThreads = new List<Thread>();

							Dictionary<Thread, RefinementFuzzing.ConcurrentContext> threadList = new Dictionary<Thread, RefinementFuzzing.ConcurrentContext>();
							Dictionary<int, Thread> currRunningThreadsDict = new Dictionary<int, Thread>();

							for (int i = 0; i < handles.Count(); i++)
								handles[i] = new ManualResetEvent(false);

							int nextThreadToRun = 0;
							int indexInRunningThreads;

							double maxTime = 0;
							int totalNumCalls = 0;

							while (true)
							{
								if (nextThreadToRun >= numThreadsSpawned) // only after the first 'numThreadsSpawned' threads have got spawned
								{
									// Wait for a thread to complete and then handle it

									int index = WaitHandle.WaitAny(handles);

									(handles[index] as ManualResetEvent).Reset();

									Thread t = currRunningThreadsDict[index]; // the thread that completed
									t.Join();

									RefinementFuzzing.ConcurrentContext context = threadList[t];
									currRunningThreadsDict.Remove(index);

									//context.vcgen.Close();
									Console.WriteLine("Join done");
									RefinementFuzzing.Settings.WritePrimaryLog(context.vcgen.proverStackBookkeeper.id, s.Id, "Solve", "Joining Thread " + context.id + " for soft partition: " + context.spartition.Id);

									// Get the result fom the child
									VerifyResult res = context.res;

									//context.vcgen.proverStackBookkeeper.Pop();
									//if (!(res != VerifyResult.Verified || context.vcgen.proverStackBookkeeper.Top() == s.Id))
									//    Contract.Assert(res != VerifyResult.Verified || context.vcgen.proverStackBookkeeper.Top() == s.Id);


									if (context.vcgen.timeTaken > maxTime)
										maxTime = context.vcgen.timeTaken;

									totalNumCalls += context.vcgen.numCalls;

									if (res == VerifyResult.BugFound)
									{
										cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, nextThreadToRun, threadList, s);

										return VerifyResult.BugFound;
									}
									else
									{
										Contract.Assert(res == VerifyResult.Verified);

										if (RefinementFuzzing.Settings.threadJoinStrategy != RefinementFuzzing.Settings.ThreadJoinStrategy.ContinueAfterFirstChildReturns)
										{
											// Release prover (release it with the parent's as the thread did the job for the parent as the prover stack is so set up)
											StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);
										}

										/*
										if (!RefinementFuzzing.Settings.useConcurrentSummaryDB)
										{
											// Merge the parent's summaries with that returned by the child
											vState.summaryDB.Union(context.vstate.summaryDB, s.activeCandidates);
										}
										*/
									}

									if (RefinementFuzzing.Settings.threadJoinStrategy == RefinementFuzzing.Settings.ThreadJoinStrategy.ContinueAfterFirstChildReturns)
									{
										//StratifiedInlining.proverManager.RequestProver(vcgen.proverStackBookkeeper, s.Id);
										//vcgen.proverStackBookkeeper = StratifiedInlining.proverManager.BorrowProver(s.Id);

										if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
										{
											//s.stale = true; // so as to push the new summaries
											context.vcgen.proverStackBookkeeper.stalePartitions.Add(s);
											//context.vcgen.proverStackBookkeeper.Pop(); // so as to push the new summaries
											//context.vcgen.proverStackBookkeeper.Pop(); // so as to push the new summaries
										}

										List<SoftPartition> newPartitions = new List<SoftPartition>();
										// .VerifyResult outcome2 = Verify(s, out newPartitions);

										HashSet<SoftPartition> partitionsInProgress = new HashSet<SoftPartition>();
										foreach (int idx in currRunningThreadsDict.Keys)
										{
											partitionsInProgress.Add(partitions[idx]);
										}

										double solTime2 = 0;
										// important: call it with the context of the current thread so that it uses the
										// correct prover (context.vcgen.proverStackBookkeeper)
										// At the same time, it needs to be called with vState (not context.vstate) so
										// that all the expansions on the call-tree are recorded
										// Also, due to these reasons, this partition cannot be run concurrently.
										// .VerifyResult outcome2 = context.vcgen.SolvePartition(s, context.vstate, out newPartitions); 
										VerifyResult outcome2 = vcgen.SolvePartition(s, vState, out newPartitions, out solTime2, context.vcgen.proverStackBookkeeper, partitionsInProgress, 1);

										if (RefinementFuzzing.Settings.traversalStyle == RefinementFuzzing.Settings.TraversalStyle.RandomizedDepthFirst && newPartitions.Count > 1)
										{
											int min = RefinementFuzzing.Settings.SoftPartitionBound;

											if (min > 1)
											{
												int numPartitions = newPartitions.Count;
												List<SoftPartition> selectedSet = new List<SoftPartition>();

												for (int i = 0; i < min; i++)
												{
													int sel = rand.Next(newPartitions.Count);
													SoftPartition selectedPartition = newPartitions[sel];

													newPartitions.RemoveAt(sel);
													selectedSet.Add(selectedPartition);
												}

												newPartitions = selectedSet;
											}
										}

										if (RefinementFuzzing.Settings.estimateParallelism)
										{
											s.graphNode.potentialParallelTime += solTime2;
										}

										if (outcome2 == VerifyResult.NoMoreConstraintPartition)
										{
											// no work to do --- release thread and prover
											StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);

											continue;
										}
										else if (outcome2 == VerifyResult.BugFound)
										{
											cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, nextThreadToRun, threadList, s);

											return VerifyResult.BugFound;
										}
										else if (outcome2 == VerifyResult.Verified)
										{
											//cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, nextThreadToRun);

											//return VerifyResult.Verified;

											StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);

											break;
										}
										else if (outcome2 == VerifyResult.Partitioned)
										{
											if (nextThreadToRun <= partitions.Count - 1)
												partitions.RemoveRange(nextThreadToRun, (partitions.Count - nextThreadToRun));

											for (int i = 0; i < newPartitions.Count; i++)
											{
												if ((newPartitions[i]).isSubsumedIn(partitions))
												{
													RefinementFuzzing.Settings.WritePrimaryLog(context.vcgen.proverStackBookkeeper.id, s.Id, "Solve", "Speculation successful!");

													if (RefinementFuzzing.Settings.constructExplorationGraph)
														newPartitions[i].graphNode.isSubsumed = true;

													continue;
												}

												partitions.Add(newPartitions[i]);
												RefinementFuzzing.Settings.WritePartitioningLog(vcgen.proverStackBookkeeper.id, s, 1, true, context.vstate, newPartitions[i], null);
											}

											/*
                                            for (int i = 0; i < newPartitions.Count; i++)
                                            {
                                                partitions[nextThreadToRun + i] = newPartitions[i];
                                            }
                                             * */
										}

										// Release prover (release it with the parent's as the thread did the job for the parent as the prover stack is so set up)
										StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id);

										// steal the 'id' of the completed thread for the next thread to run
										indexInRunningThreads = index;

										//continue;
									}
									else if (RefinementFuzzing.Settings.threadJoinStrategy == RefinementFuzzing.Settings.ThreadJoinStrategy.WaitForAllChildren)
									{
										// steal the 'id' of the completed thread for the next thread to run
										indexInRunningThreads = index;
									}
									else
									{
										indexInRunningThreads = -1;
										Contract.Assert(false);
									}
								}
								else
								{
									// initial lot of threads
									indexInRunningThreads = nextThreadToRun;
									//handles[indexInRunningThreads] = new AutoResetEvent(false);
								}

								if (nextThreadToRun < partitions.Count)
								{
									// there is a thread to be run
									SoftPartition spawnForPartition = partitions[nextThreadToRun];

									RefinementFuzzing.Settings.WritePrimaryLog(vcgen.proverStackBookkeeper.id, s.Id, "Solve", "Creating Thread for soft partition: " + spawnForPartition.Id);

									int tokenid = vcgen.proverStackBookkeeper.timingStatisticsManager.StartTime(Common.TimingStatisticManager.TimingCategories.ThreadSpawn);
									Tuple<Thread, RefinementFuzzing.ConcurrentContext> tuple = createThread(spawnForPartition, childrenThreadBudget, handles[indexInRunningThreads], s, nextThreadToRun);
									vcgen.proverStackBookkeeper.timingStatisticsManager.StopTime(tokenid, Common.TimingStatisticManager.TimingCategories.ThreadSpawn);
									threadList[tuple.Item1] = tuple.Item2;

									// assign the new thread the 'id' of the completed thread on the WaitHandles
									currRunningThreadsDict[indexInRunningThreads] = tuple.Item1;

									nextThreadToRun++;
								}
								else
								{
									// no more threads to run; just wait for the current ones to complete
									if (currRunningThreadsDict.Count == 0)
										break;
								}
							}


							/*
                            threadList.Keys.Iter<Thread>(n => pendingThreads.Add(n));

                            foreach (Thread t in threadList.Keys)
                            {
                                RefinementFuzzing.ConcurrentContext context = threadList[t];
                                t.Join();
                                pendingThreads.Remove(t);
                                context.vcgen.Close();
                                Console.WriteLine("Join done");
                                vState.summaryDB.Union(context.vstate.summaryDB, s.activeCandidates);

                                VerifyResult res = context.res;

                                if (res == VerifyResult.BugFound)
                                {
                                    pendingThreads.Iter<Thread>(n => n.Abort());

                                    if (context.vcgen.timeTaken > maxTime)
                                        maxTime = context.vcgen.timeTaken;

                                    totalNumCalls += context.vcgen.numCalls;

                                    vcgen.timeTaken += maxTime;
                                    vcgen.numCalls += totalNumCalls;
                                    vcgen.threadsSpawned += partitions.Count;

                                    return VerifyResult.BugFound;
                                }
                                else
                                {
                                    Contract.Assert(res == VerifyResult.Verified);

                                    if (context.vcgen.timeTaken > maxTime)
                                        maxTime = context.vcgen.timeTaken;

                                    totalNumCalls += context.vcgen.numCalls;
                                }
                            }
                             */

							cleanup(currRunningThreadsDict, handles, maxTime, totalNumCalls, nextThreadToRun, threadList, s);

							hierarchicalQueue.SetLowestLevelAsReady(vcgen.proverStackBookkeeper);
							//hierarchicalQueue.TaskCompleted(spawnForPartition);

							// the parent should now get the prover back
							StratifiedInlining.proverManager.RequestProver(vcgen.proverStackBookkeeper, s.Id);

						}
						else
							partitions.Iter<SoftPartition>(p => hierarchicalQueue.TaskAdded(p));
					}
				}
				else if (outcome == VerifyResult.Errors)
				{
					// Errors -- Give up!

					return VerifyResult.Errors;
				}
				else
				{
					// Exception -- Give up!
					throw new Exception();
				}
			}

			return VerifyResult.Verified;
		}

		private List<SoftPartition> SelectedSet(List<SoftPartition> partitions, int count)
		{
			Contract.Assert(RefinementFuzzing.Settings.SoftPartitionBound == 2);
			List<SoftPartition> selectedSet = new List<SoftPartition>();

			if (count == 1)
			{
				selectedSet.Add(partitions[0]);
				return selectedSet;
			}

			if (RefinementFuzzing.Settings.costFunction == RefinementFuzzing.Settings.CostFunction.CexSimilarity)
			{
				int maxDist = 0;
				Tuple<SoftPartition, SoftPartition> minCostPair = null;

				// find min-cost for all pairs

				foreach (SoftPartition c1 in partitions)
					foreach (SoftPartition c2 in partitions)
					{
						if (c1 == c2) continue;

						IEnumerable<StratifiedCallSite> intersetSet = c1.lastInlined.Intersect<StratifiedCallSite>(c2.lastInlined);
						IEnumerable<StratifiedCallSite> symDiff = (c1.lastInlined.Except(intersetSet)).Union<StratifiedCallSite>(c2.lastInlined.Except(intersetSet));

						if (maxDist < symDiff.Count())
						{
							maxDist = symDiff.Count();
							minCostPair = new Tuple<SoftPartition, SoftPartition>(c1, c2);
						}
					}


				selectedSet.Add(minCostPair.Item1);
				selectedSet.Add(minCostPair.Item2);

				return selectedSet;
			}

			return null;
		}

		private void cleanup(Dictionary<int, Thread> currRunningThreadsDict, WaitHandle[] handles, double maxTime, int totalNumCalls, int numThreadsSpawned, Dictionary<Thread, RefinementFuzzing.ConcurrentContext> threadList, SoftPartition s)
		{
			// Abort remaining thread (if any, for example if bug found/error reported)
			//currRunningThreadsDict.Values.Iter<Thread>(n => { n.Abort(); });

			lock (RefinementFuzzing.Settings.lockThis)
			{
				RefinementFuzzing.Settings.globalThreadList.Remove(System.Threading.Thread.CurrentThread);

				foreach (Thread t in RefinementFuzzing.Settings.globalThreadList.Keys)
				{
					t.Abort();
					RefinementFuzzing.ConcurrentContext context = RefinementFuzzing.Settings.globalThreadList[t];
					//currRunningThreadsDict.Remove(index);

					context.vcgen.proverStackBookkeeper.timingStatisticsManager.AbortTimer();
					RefinementFuzzing.Settings.oTimer.AbortTimer(context.vcgen.proverStackBookkeeper.id);

					StratifiedInlining.proverManager.ReturnProver(context.vcgen.proverStackBookkeeper, s.Id, false);

					if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
						context.vcgen.proverStackBookkeeper.stalePartitions.Add(s);
				}
			}


			/*
            lock (RefinementFuzzing.Settings.lockThis)
            {
                RefinementFuzzing.Settings.globalThreadList.Remove(t);
            }
            */
			// free handles
			foreach (WaitHandle h in handles)
			{
				h.Close();
			}

			// update statistics
			vcgen.timeTaken += maxTime;
			vcgen.numCalls += totalNumCalls;
			vcgen.threadsSpawned += numThreadsSpawned;
		}


		bool done = false;
		private static bool first;
		private ProverInterface.Outcome VerifyTest(SoftPartition s, out List<SoftPartition> partitions)
		{
			//throw new NotImplementedException();
			int v;

			if (s.level > 3 || done)
			{
				v = 0;
				done = true;
			}
			else if (s.level == 0)
				v = 1;
			else
				v = rand.Next(2);

			if (v < 1)
			{
				Console.Out.WriteLine("Verified: " + s.Id);
				partitions = null;
				return ProverInterface.Outcome.Valid;
			}
			else
			{
				partitions = new List<SoftPartition>();
				HashSet<StratifiedCallSite> ac = new HashSet<StratifiedCallSite>();
				//ac.Add(1);
				//ac.Add(2);
				SoftPartition s1 = new SoftPartition(s, ac, new HashSet<StratifiedCallSite>(), new HashSet<StratifiedCallSite>(), new HashSet<StratifiedCallSite>());
				SoftPartition s2 = new SoftPartition(s, ac, new HashSet<StratifiedCallSite>(), new HashSet<StratifiedCallSite>(), new HashSet<StratifiedCallSite>());
				partitions.Add(s1);
				partitions.Add(s2);

				Console.WriteLine("Invalid: Created partitions for " + s.Id + "->" + s1.Id + ", " + s2.Id);

				return ProverInterface.Outcome.Invalid;
			}
		}

		private VerifyResult Verify(SoftPartition s, out List<SoftPartition> partitions, out double solTime)
		{
			VerifyResult ret = vcgen.SolvePartition(s, vState, out partitions, out solTime);

			return ret;
		}
	}

	class HierarchicalQueue
	{
		private Dictionary<int, List<SoftPartition>> readyQ = new Dictionary<int, List<SoftPartition>>();
		private Dictionary<int, List<SoftPartition>> pendingQ = new Dictionary<int, List<SoftPartition>>();

		public enum QType { BFS, DFS };

		private QType qType;

		int currentLevel = 0;
		int baseLevel = 0;  // this is the level from which the queue starts (for spawned threads, it will not be zero)

		/*
        public HierarchicalQueue(List<int> entryPoints, QType qType, StratifiedInlining.VerificationState vState) // candidates are all funct
        {
            this.qType = qType;

            readyQ[0] = new List<SoftPartition>();
            pendingQ[0] = new List<SoftPartition>();

            foreach (int e in entryPoints)
            {
                HashSet<int> universalCandidates = new HashSet<int>();
                universalCandidates.Add(e);

                //vState.calls.currCandidates.Iter<int>(n => universalCandidates.Add(n));

                HashSet<int> blockedCandidates = new HashSet<int>();
                HashSet<int> activeCandidates = new HashSet<int>();

                vState.calls.currCandidates.Iter<int>(n => activeCandidates.Add(n));

                SoftPartition s = new SoftPartition(null, -1, 0, activeCandidates, blockedCandidates, universalCandidates, universalCandidates, new HashSet<int>());
                
                readyQ[0].Add(s);
            }
        }
         * */

		public HierarchicalQueue(List<SoftPartition> entrySoftPartitions, QType qType, VerificationState vState) // candidates are all funct
		{

			Contract.Assert(entrySoftPartitions.Count == 1); // the other case has not been implemented

			this.qType = qType;

			int minLevel = 0xffffff;
			entrySoftPartitions.Iter<SoftPartition>(n => { minLevel = (minLevel > n.level) ? n.level : minLevel; });
			baseLevel = minLevel;
			currentLevel = minLevel;

			readyQ[baseLevel] = new List<SoftPartition>();
			pendingQ[baseLevel] = new List<SoftPartition>();

			entrySoftPartitions.Iter<SoftPartition>(n => { readyQ[baseLevel].Add(n); });
		}

		public void printQStatistics()
		{
			Console.WriteLine();
			Console.WriteLine("level: (ReadyQ, PendingQ)");
			for (int i = baseLevel; i <= currentLevel; i++)
			{
				Console.Write(i + "(" + readyQ[i].Count + ", " + pendingQ[i].Count + ")");
				Console.Write(" [PendCounts: ");
				foreach (SoftPartition p in pendingQ[i])
					Console.Write(p.pendCount + ", ");
				Console.WriteLine("]");
			}
			Console.WriteLine();
		}

		public SoftPartition getNextPartition(ProverStackBookkeeping bookKeeper)
		{
			if (qType == QType.BFS)
				return getNextPartitionBFS(bookKeeper);
			else if (qType == QType.DFS)
				return getNextPartitionDFS();
			else
			{
				Contract.Assert(false); // unreachable code
				return null;
			}
		}

		private SoftPartition getNextPartitionBFS(ProverStackBookkeeping bookKeeper)
		{
			if (readyQ[currentLevel] == null)
			{
				Contract.Assert(false); // unreachable code
			}

			if (readyQ[currentLevel].Count() == 0)
			{
				if (pendingQ[currentLevel].Count() > 0) // everything at this level is pended
				{
					Contract.Assert(readyQ[currentLevel + 1].Count() > 0);

					currentLevel++;

					SoftPartition sf = readyQ[currentLevel][0];
					readyQ[currentLevel].Remove(sf);
					return sf;
				}
				else if (pendingQ[currentLevel].Count() == 0) // no ready and no pending --- finished this level
				{
					if (currentLevel == baseLevel)
					{
						// reached topmost level --- done!
						return null;
					}

					currentLevel--;

					// Move all pended tasks in upper level to ready queue
					foreach (SoftPartition s in pendingQ[currentLevel])
					{
						readyQ[currentLevel].Add(s);

						if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
							bookKeeper.stalePartitions.Add(s); // the lower level would have generated new summaries
					}

					pendingQ[currentLevel].Clear();

					SoftPartition sf = readyQ[currentLevel][0];
					readyQ[currentLevel].Remove(sf);
					return sf;
				}
				else
					Contract.Assert(false); // unreachable code
			}
			else
			{
				// return the next partition at this level
				List<SoftPartition> rq = readyQ[currentLevel];

				SoftPartition sf = rq[0];
				rq.Remove(sf);
				return sf;
			}

			Contract.Assert(false); // unreachable code
			return null;
		}

		private SoftPartition getNextPartitionDFS()
		{
			Contract.Assert(false); // unimplemented
			return null;
		}

		public void SetLowestLevelAsReady(ProverStackBookkeeping bookKeeper)
		{
			// Move all pended tasks in upper level to ready queue
			foreach (SoftPartition s in pendingQ[currentLevel])
			{
				readyQ[currentLevel].Add(s);
				//s.stale = true;

				if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
					bookKeeper.stalePartitions.Add(s);

			}
			pendingQ[currentLevel].Clear();
		}

		public void TaskCompleted(SoftPartition s)
		{
			Contract.Assert(currentLevel == s.level);

			readyQ[currentLevel].Remove(s);
		}

		public void TaskPended(SoftPartition s)
		{
			Contract.Assert(currentLevel == s.level);

			readyQ[currentLevel].Remove(s);
			pendingQ[currentLevel].Add(s);

			s.pendCount++;
		}

		public void TaskAdded(SoftPartition s)
		{
			Contract.Assert((currentLevel + 1) == s.level);

			List<SoftPartition> rq;
			bool present = readyQ.TryGetValue(currentLevel + 1, out rq);

			// "open up" the queues for the next level (if req)
			if (!present)
			{
				rq = readyQ[currentLevel + 1] = new List<SoftPartition>();
				pendingQ[currentLevel + 1] = new List<SoftPartition>();
			}

			rq.Add(s);
		}
	}
}
