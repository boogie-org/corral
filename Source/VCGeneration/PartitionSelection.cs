using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System.Diagnostics.Contracts;
using Microsoft.Basetypes;
using Microsoft.Boogie.VCExprAST;
using System.Runtime.Serialization;
//using System.Runtime.Serialization.Formatters.Soap;
using System.Runtime.Serialization.Formatters.Binary;
using RefinementFuzzing;
using Common;

namespace VC
{
	public class PartitionSelectionHeuristics
	{
		HashSet<int> attemptedCandidateSummaries = new HashSet<int>();
		HashSet<string> attemptedProcSummaries = new HashSet<string>();

		public void AttemptedSummaryGeneration(int id, VerificationState vState)
		{
			Contract.Assert(false);
		}

		private IEnumerable<int> CandidatesMissingSummaries(IEnumerable<int> currset, VerificationState vState)
		{
			HashSet<int> candidatesMissingSummaries = new HashSet<int>();

			lock (RefinementFuzzing.Settings.lockThis)
			{
				foreach (int id in currset)
				{
					string proc = vState.calls.getProc(id);
					if (!attemptedProcSummaries.Contains(proc))
						candidatesMissingSummaries.Add(id);
				}

				candidatesMissingSummaries.ExceptWith(attemptedCandidateSummaries);
			}

			return candidatesMissingSummaries;
		}

		public VCExpr ExprMissingSummaries(IEnumerable<int> currset, VerificationState vState)
		{
			IEnumerable<int> candidatesMissingSummaries = CandidatesMissingSummaries(currset, vState);

			if (candidatesMissingSummaries.Count() == 0)
			{
				return VCExpressionGenerator.False;
			}

			VCExpr expr = VCExpressionGenerator.True;
			foreach (int id in candidatesMissingSummaries)
			{
				expr = vState.checker.prover.VCExprGen.AndSimp(expr, vState.calls.getFalseExpr(id));
			}

			return expr;
		}
	}
}
