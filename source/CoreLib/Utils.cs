using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.IO;
using System.Threading;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Diagnostics.Contracts;


namespace Common
{
	public class GraphUtil
	{
		GraphNode root;
		HashSet<GraphNode> nodeSet = new HashSet<GraphNode>();
		HashSet<Tuple<GraphNode, GraphNode>> edgeSet = new HashSet<Tuple<GraphNode, GraphNode>>();

		string fname;

		public GraphUtil(string fname)
		{
			this.fname = fname;
		}

		public void AddEdge(GraphNode n1, GraphNode n2)
		{
			n1.children.Enqueue(n2);
			nodeSet.Add(n1);
			nodeSet.Add(n2);
			edgeSet.Add(new Tuple<GraphNode, GraphNode>(n1, n2));
		}

		public void WriteDot()
		{
			StreamWriter sw = new StreamWriter(fname);

			sw.WriteLine("digraph G {");

			foreach (GraphNode n in nodeSet)
			{
				if (n.scheduledOnProverId == -1)
					continue;

				string attr = "";

				#if false
				if (!n.isSubsumed)
				{
				attr = "shape = box"; // common case
				}
				else
				{
				attr = "shape = hexagon";
				}
				#endif

				if (!n.fromTrace)
				{
					attr = "shape = box"; // common case
				}
				else
				{
					attr = "shape = hexagon";
				}

				sw.WriteLine(n.GetName() + " [" + attr + ", label = \"" + n.GetLabel() + "\"];");
			}
			foreach (Tuple<GraphNode, GraphNode> t in edgeSet)
			{
				if (t.Item1.scheduledOnProverId == -1 || t.Item2.scheduledOnProverId == -1)
					continue;

				sw.WriteLine(t.Item1.GetName() + " -> " + t.Item2.GetName());
			}

			sw.WriteLine("}");
			sw.Close();
		}

		public void SetRoot(GraphNode graphNode)
		{
			root = graphNode;
		}
	}

	public class GraphNode
	{
		int id;
		HashSet<int> candidates = new HashSet<int>();
		public int scheduledOnProverId = -1;
		public Queue<int> solutionTime = new Queue<int>(); // time to solve this partition each time it is enqueued
		public bool fromTrace = false;

		public Queue<GraphNode> children = new Queue<GraphNode>();
		public string proverArrayState = "";
		public int backtrackCount; // when a softpartition is partitioned, each of them compute a summary
		//, and backtrack into the current partition. If still not satisfiable, the current partition is 
		// partitioned again. This field backtrackCount denotes as to which backtrack of the parent this
		// softpartition is created

		public bool isSubsumed = false;
		public double potentialParallelTime = 0;

		public GraphNode(int id, HashSet<int> candidates)
		{
			this.id = id;
			candidates.Iter<int>(n => this.candidates.Add(n));
		}

		public override string ToString()
		{
			StringBuilder b = new StringBuilder();
			candidates.Iter<int>(n => b.Append("," + n));

			StringBuilder b1 = new StringBuilder();
			solutionTime.Iter<int>(n => b1.Append("," + n));

			return id + " (" + b.ToString() + ")\\n" +
				"[" + scheduledOnProverId + "], " +
				"provers:[" + proverArrayState + "]\\n" +
				"bk = " + backtrackCount + "; " + 
				"tm = [" + b1.ToString() + "]; " +
				"pot = [" + (int) potentialParallelTime + "]; ";
		}

		public string GetName()
		{
			return id + "";
		}

		public string GetLabel()
		{
			return ToString();
		}
	}

	public class TimingStatisticManager
	{
		public enum TimingCategories { Z3Time, iZ3Time, ThreadSpawn };
		private Dictionary<int, Tuple<DateTime, TimingCategories>> token2startTime = new Dictionary<int, Tuple<DateTime, TimingCategories>>();

		private Dictionary<TimingCategories, double> timingStatistics = new Dictionary<TimingCategories, double>();

		private int globalTokenId;

		bool insideTimer = true;

		public TimingStatisticManager()
		{
			timingStatistics[TimingCategories.Z3Time] = 0;
			timingStatistics[TimingCategories.iZ3Time] = 0;
			timingStatistics[TimingCategories.ThreadSpawn] = 0;
		}

		public int StartTime(TimingCategories cat)
		{
			lock (this)
			{
				DateTime st = DateTime.UtcNow;
				globalTokenId++;

				token2startTime[globalTokenId] = new Tuple<DateTime,TimingCategories>(st, cat);

				return globalTokenId;
			}
		}

		public void StopTime(int tokenId, TimingCategories cat)
		{
			lock (this)
			{
				Contract.Assert(cat == token2startTime[tokenId].Item2);

				DateTime startTime = token2startTime[tokenId].Item1;
				token2startTime.Remove(tokenId);

				timingStatistics[cat] += (DateTime.UtcNow - startTime).TotalSeconds;
			}
		}

		public void AbortTimer()
		{
			lock (this)
			{
				if (insideTimer)
				{
					insideTimer = false;
					foreach (int tokenId in token2startTime.Keys)
					{
						DateTime startTime = token2startTime[tokenId].Item1;
						TimingCategories cat = token2startTime[tokenId].Item2;
						timingStatistics[cat] += (DateTime.UtcNow - startTime).TotalSeconds;
					}
					token2startTime.Clear();
				}
			}
		}

		public void PrintStatistics(int id)
		{
			Console.WriteLine("\t[{3}]  ThreadSpawn: {4}; Z3: {0} ; iZ3: {1} ; Total: {2}; ", timingStatistics[TimingCategories.Z3Time].ToString("F2"), timingStatistics[TimingCategories.iZ3Time].ToString("F2"), (timingStatistics[TimingCategories.Z3Time] + timingStatistics[TimingCategories.iZ3Time]).ToString("F2"), id, timingStatistics[TimingCategories.ThreadSpawn].ToString("F2"));
		}
	}

	public class OverlappingTimingStatisticManager
	{
		private Dictionary<TimingCategories, int> racingCounter = new Dictionary<TimingCategories, int>();

		public enum TimingCategories { TotalProverTime };

		private Dictionary<TimingCategories, double> timingStatistics = new Dictionary<TimingCategories, double>();

		private Dictionary<TimingCategories, DateTime> startTimes = new Dictionary<TimingCategories, DateTime>();

		public static bool disable = false;

		private Dictionary<TimingCategories, HashSet<int>> insideTimer = new Dictionary<TimingCategories, HashSet<int>>();

		public OverlappingTimingStatisticManager()
		{
			timingStatistics[TimingCategories.TotalProverTime] = 0;

			racingCounter[TimingCategories.TotalProverTime] = 0;
			insideTimer[TimingCategories.TotalProverTime] = new HashSet<int>();
		}

		public void StartTime(TimingCategories cat, int threadId)
		{
			if (disable) return;

			lock (this)
			{
				if (racingCounter[cat] == 0)
				{
					Contract.Assert(!startTimes.ContainsKey(cat));
					startTimes[cat] = DateTime.UtcNow;
				}

				insideTimer[cat].Add(threadId);
				racingCounter[cat]++;
			}
		}

		public void StopTime(TimingCategories cat, int threadId)
		{
			if (disable) return;

			lock (this)
			{
				racingCounter[cat]--;

				if (racingCounter[cat] == 0)
				{
					timingStatistics[cat] += (DateTime.UtcNow - startTimes[cat]).TotalSeconds;
					startTimes.Remove(cat);
				}

				insideTimer[cat].Remove(threadId);
			}
		}

		public void AbortTimer(int threadId)
		{
			lock (this)
			{
				foreach (TimingCategories cat in insideTimer.Keys)
				{
					if (insideTimer[cat].Contains(threadId))
					{
						racingCounter[cat]--;
						insideTimer[cat].Remove(threadId);
						if (racingCounter[cat] == 0)
						{
							timingStatistics[cat] += (DateTime.UtcNow - startTimes[cat]).TotalSeconds;
							startTimes.Remove(cat);
						}
					}
				}
			}
		}

		public void PrintStatistics()
		{
			if (disable) return;
			Console.WriteLine("Overlapped Prover Time: {0} ", timingStatistics[TimingCategories.TotalProverTime].ToString("F2"));
		}
	}


	// stolen from http://code.logos.com/blog/2008/12/profiling_lock_contention.html

	public class TimedMonitor {
		/// <summary>
		/// Initializes a new instance of the <see cref="TimedMonitor"/> class.
		/// </summary>

		public TimedMonitor()
		{
			// use a private lock so that clients must go through Lock()
			m_lock = new object();

			#if ENABLE_TIMEDMONITOR
			m_sw = new Stopwatch();
			#else
			m_sw = null;
			m_enterCount = 0;
			#endif

		}



		/// <summary>
		/// Acquires an exclusive lock and records how long the acquisition took.
		/// </summary>
		/// <returns>An object that can be disposed to release the lock.</returns>

		public LockHolder Lock()
		{
			#if ENABLE_TIMEDMONITOR
			m_sw.Start();
			#endif

			Monitor.Enter(m_lock);

			#if ENABLE_TIMEDMONITOR
			m_sw.Stop();
			m_enterCount++;
			#endif
			return new LockHolder(m_lock);
		}


		// TODO: Implement Enter() and Exit() as separate methods for more
		//   complex locks that can't be wrapped in a 'using' block.
		// TODO: Implement Pulse, PulseAll, and Wait.

		/// <summary>
		/// Gets the number of times the lock was acquired.
		/// </summary>
		/// <value>The number of times the lock was acquired.</value>

		public long EnterCount
		{
			get { return m_enterCount; }
		}

		/// <summary>
		/// Gets the total time spent waiting to acquire the lock.
		/// </summary>
		/// <value>The total time spent waiting to acquire the lock.</value>

		public TimeSpan WaitTime
		{
			get { return m_sw == null ? TimeSpan.Zero : m_sw.Elapsed;  }
		}


		/// <summary>
		/// Releases the lock acquired by <see cref="TimedMonitor.Lock"/>.
		/// </summary>

		public struct LockHolder : IDisposable
		{
			/// <summary>
			/// Releases the lock.
			/// </summary>

			public void Dispose()
			{
				Monitor.Exit(m_lock);
			}

			internal LockHolder(object objLock)
			{
				m_lock = objLock;
			}

			readonly object m_lock;

		}

		readonly object m_lock;
		readonly Stopwatch m_sw;
		long m_enterCount;
	} 

}
