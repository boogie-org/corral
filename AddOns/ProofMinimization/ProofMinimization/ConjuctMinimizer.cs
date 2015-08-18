using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using PersistentProgram = ProgTransformation.PersistentProgram;
using cba.Util;
using System.Diagnostics;

namespace ProofMinimization
{

    class ConjuctMinimizer : Minimizer
    {
        Dictionary<string, PersistentProgram> fileToProg = new Dictionary<string, PersistentProgram>();
        Dictionary<int, Dictionary<string, HashSet<string>>> templateMap = new Dictionary<int, Dictionary<string, HashSet<string>>>(); 
        Dictionary<string, int> strToTemplate = new Dictionary<string, int>();
        Dictionary<int, string> templateToStr = new Dictionary<int, string>();
        Dictionary<string, HashSet<string>> fileToKeepConstants = new Dictionary<string, HashSet<string>>();
        Dictionary<string, int> fileToPerf = new Dictionary<string, int>();

        public ConjuctMinimizer(MinimizerData mdata) : base(mdata)
        {
            this.fileToProg = mdata.fileToProg;
            this.fileToPerf = mdata.fileToPerf;
            this.fileToKeepConstants = mdata.fileToKeepConstants;
            this.templateMap = mdata.templateMap;
            this.strToTemplate = mdata.strToTemplate;
            this.templateToStr = mdata.templateToStr;

        }

        // Minimize
        public override HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta)
        {
            templateToPerfDelta = new Dictionary<int, int>();

            var iter = 1;
            var tokeep = new HashSet<int>();
            var templates = new HashSet<int>(templateMap.Keys);
            var sw = new Stopwatch();

            sw.Start();

            while (templates.Count != 0)
            {
                Console.WriteLine("------ ITER {0} -------", iter++);

                // Drop one and re-run
                var c = MinControl.PickRandom(templates);
                templates.Remove(c);

                Console.WriteLine("  >> Trying {0} :: {1}", c, templateToStr[c]);

                Dictionary<string, int> perf;
                HashSet<string> filesVerified;
                string fileFailed;

                var rt = PruneAndRun(templates.Union(tokeep), out perf, out filesVerified, out fileFailed);

                if (rt == BoogieVerify.ReturnStatus.OK)
                {
                    // dropping was fine
                    Console.WriteLine("  >> Files verified: {0}", filesVerified.Concat(" "));
                    Console.WriteLine("  >> Dropping it");

                    // TODO: maintain information of extra constants that are
                    // no longer provable, and prune templateMap accordingly

                    // Extra information
                    var delta = 0;
                    perf.Iter(tup => delta += (tup.Value - fileToPerf[tup.Key]));
                    templateToPerfDelta[c] = delta;

                    // Update perf stats
                    perf.Iter(tup => fileToPerf[tup.Key] = tup.Value);
                }
                else
                {
                    Debug.Assert(fileFailed != null);
                    Console.WriteLine("  >> Files verified: {0}", filesVerified.Concat(" "));
                    Console.WriteLine("  >> File failed: {0}", fileFailed);
                    Console.WriteLine("  >> Cannot drop");
                    tokeep.Add(c);
                }

                //Log(iter);
                Console.WriteLine("Time elapsed: {0} sec", sw.Elapsed.TotalSeconds.ToString("F2"));
            }

            return tokeep;
        }


        // Prune away non-candidates, verify using the rest
        BoogieVerify.ReturnStatus PruneAndRun(HashSet<int> candidateTemplates, out Dictionary<string, int> perf, out HashSet<string> filesVerified, out string fileFailed)
        {
            perf = new Dictionary<string, int>();

            filesVerified = new HashSet<string>();
            fileFailed = null;

            foreach (var tup in fileToProg)
            {
                var file = tup.Key;

                var program = tup.Value.getProgram();
                program.Typecheck();

                // all constants
                var allconstants = new HashSet<string>(
                    program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                    .Select(c => c.Name));

                // candidate constants
                var candidates = new HashSet<string>();
                candidateTemplates.Where(t => templateMap[t].ContainsKey(file))
                    .Iter(t => candidates.UnionWith(templateMap[t][file]));

                // to keep
                var keep = fileToKeepConstants[file].Intersection(allconstants);

                // drop
                MinControl.DropConstants(program, allconstants.Difference(candidates.Union(keep)));

                // Run Houdini
                var assignment = CoreLib.HoudiniInlining.RunHoudini(program, true);
                //Console.WriteLine("  >> Contracts: {0}", assignment.Count);

                // Read the program again, add contracts
                program = tup.Value.getProgram();
                program.Typecheck();

                // Enforce the assignment back into the program
                CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);

                // Run SI
                var err = new List<BoogieErrorTrace>();

                // Set bound
                BoogieVerify.options.maxInlinedBound = 0;
                if (fileToPerf[file] != 0)
                    BoogieVerify.options.maxInlinedBound = MinControl.PerfMetric(fileToPerf[file]);

                var rstatus = BoogieVerify.Verify(program, out err, true);
                //Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
                //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

                var procs_inlined = BoogieVerify.CallTreeSize + 1;
                BoogieVerify.options.CallTree = new HashSet<string>();
                BoogieVerify.CallTreeSize = 0;
                BoogieVerify.verificationTime = TimeSpan.Zero;

                if (rstatus != BoogieVerify.ReturnStatus.OK)
                {
                    fileFailed = file;
                    return BoogieVerify.ReturnStatus.NOK;
                }

                perf[file] = procs_inlined;
                filesVerified.Add(file);
            }

            return BoogieVerify.ReturnStatus.OK;
        }

    }
}
