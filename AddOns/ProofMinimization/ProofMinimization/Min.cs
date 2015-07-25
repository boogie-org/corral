using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using PersistentProgram = ProgTransformation.PersistentProgram;
using System.Text.RegularExpressions;
using btype = Microsoft.Boogie.Type;

namespace ProofMinimization
{
    static class Minimize
    {
        static bool dbg = false;
        static readonly int TemplateCounterStart = 1000;
        static int IterCnt = 0;
        public static bool usePerf = false;

        // file name -> Program
        static Dictionary<string, PersistentProgram> fileToProg = new Dictionary<string, PersistentProgram>();
        // template ID -> file -> {constants}
        static Dictionary<int, Dictionary<string, HashSet<string>>> templateMap = new Dictionary<int, Dictionary<string, HashSet<string>>>();
        // template ID -> identifier string
        static Dictionary<string, int> strToTemplate = new Dictionary<string, int>();
        // file -> constants to keep always
        static Dictionary<string, HashSet<string>> fileToKeepConstants = new Dictionary<string, HashSet<string>>();

        public static void ReadFiles(IEnumerable<string> files, HashSet<string> keepPatterns)
        {
            var addTemplate = new Action<int, string, string>((templateId, file, constant) =>
                {
                    if (!templateMap.ContainsKey(templateId)) templateMap.Add(templateId, new Dictionary<string, HashSet<string>>());
                    if (!templateMap[templateId].ContainsKey(file)) templateMap[templateId].Add(f, new HashSet<string>());
                    templateMap[templateId][file].Add(constant);
                });

            foreach (var f in files)
            {
                var program = BoogieUtil.ReadAndResolve(f);
                CheckRMT(program);

                fileToKeepConstants.Add(f, new HashSet<string>());

                // Add annotations
                foreach (var p in keepPatterns)
                {
                    var re = new Regex(p);
                    program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential") && re.IsMatch(c.Name))
                    .Iter(c =>
                        {
                            c.AddAttribute(Driver.MustKeepAttr);
                            fileToKeepConstants[f].Add(c.Name);
                        });
                }

                // Prune, according to annotations
                DropConstants(program, new HashSet<string>(
                    program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, Driver.DropAttr))
                    .Select(c => c.Name)));

                var allconstants = new Dictionary<string, Constant>();
                program.TopLevelDeclarations.OfType<Constant>()
                    .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                    .Iter(c => allconstants.Add(c.Name, c));

                // Normalize expressions
                program.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(impl => impl.Proc.Ensures.Iter(ens => SimplifyExpr.SimplifyEnsures(ens, allconstants)));

                // Remove constants that don't hold -- optimization



                // create template map
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
                    {
                        string constantName = null;
                        Expr expr = null;

                        var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                            ens.Condition, allconstants.Keys, out constantName, out expr);

                        if (!match) continue;
                        if (fileToKeepConstants[f].Contains(constantName)) continue;

                        var templateId = QKeyValue.FindIntAttribute(ens.Attributes, "template", -1);
                        if (templateId != -1) addTemplate(templateId, f, constantName);
                        else
                        {
                            var temp = SimplifyExpr.ExprToTemplate(expr);
                            if (strToTemplate.ContainsKey(temp))
                            {
                                // template for it exists
                                addTemplate(strToTemplate[temp], f, constantName);
                            }
                            else
                            {
                                // create new template
                                strToTemplate.Add(temp, TemplateCounterStart + strToTemplate.Count);
                                addTemplate(strToTemplate[temp], f, constantName);
                            }
                        }
                    }

                }




                // stash the program
                fileToProg.Add(f, new PersistentProgram(program));
            }

            if (dbg)
            {
                var id2str = new Dictionary<int, string>();
                strToTemplate.Iter(tup => id2str.Add(tup.Value, tup.Key));

                foreach (var tup in templateMap)
                {
                    Console.WriteLine("Template {0} :: {1}", tup.Key, id2str[tup.Key]);
                    foreach (var tup2 in tup.Value)
                    {
                        Console.WriteLine("  File {0}", tup2.Key);
                        tup2.Value.Iter(c => Console.WriteLine("    Candidate {0}", c));
                    }
                }
            }
        }

        // Prune away non-candidates, verify using the rest
        static BoogieVerify.ReturnStatus PruneAndRun(HashSet<int> candidateTemplates, ref int inlined)
        {
            foreach (var tup in fileToProg)
            {
                var file = tup.Key;

                var program = tup.Value.getProgram();
                program.Typecheck();

                // Gather the candidates
            }


            // Remove non-candidates
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, candidates, true);
            program.RemoveTopLevelDeclarations(decl => (decl is Constant) && QKeyValue.FindBoolAttribute(decl.Attributes, "existential") &&
                !candidates.Contains((decl as Constant).Name));

            //BoogieUtil.PrintProgram(program, "hi_query" + IterCnt + ".bpl");

            // Run Houdini
            assignment = CoreLib.HoudiniInlining.RunHoudini(program, true);
            //Console.WriteLine("  >> Contracts: {0}", assignment.Count);

            // Read the program again, add contracts
            program = inp.getProgram();
            program.Typecheck();

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);
            //BoogieUtil.PrintProgram(program, "si_query" + IterCnt + ".bpl");

            // Run SI
            var err = new List<BoogieErrorTrace>();

            // Set bound
            BoogieVerify.options.maxInlinedBound = 0;
            if (inlined != 0)
                BoogieVerify.options.maxInlinedBound = PerfMetric(inlined);

            var rstatus = BoogieVerify.Verify(program, out err, true);
            //Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;


            return rstatus;
        }


        // Prune away non-candidates, verify using the rest
        static BoogieVerify.ReturnStatus PruneAndRun(PersistentProgram inp, HashSet<string> candidates, out HashSet<string> assignment, ref int inlined)
        {
            IterCnt++;

            var program = inp.getProgram();
            program.Typecheck();

            // Remove non-candidates
            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, candidates, true);
            program.RemoveTopLevelDeclarations(decl => (decl is Constant) && QKeyValue.FindBoolAttribute(decl.Attributes, "existential") &&
                !candidates.Contains((decl as Constant).Name));

            //BoogieUtil.PrintProgram(program, "hi_query" + IterCnt + ".bpl");

            // Run Houdini
            assignment = CoreLib.HoudiniInlining.RunHoudini(program, true);
            //Console.WriteLine("  >> Contracts: {0}", assignment.Count);

            // Read the program again, add contracts
            program = inp.getProgram();
            program.Typecheck();

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, assignment);
            //BoogieUtil.PrintProgram(program, "si_query" + IterCnt + ".bpl");

            // Run SI
            var err = new List<BoogieErrorTrace>();

            // Set bound
            BoogieVerify.options.maxInlinedBound = 0;
            if (inlined != 0)
                BoogieVerify.options.maxInlinedBound = PerfMetric(inlined);

            var rstatus = BoogieVerify.Verify(program, out err, true);
            //Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;


            return rstatus;
        }

        static int PerfMetric(int n)
        {
            if (!usePerf) return Int32.MaxValue;
            if (n < 50) return (n + 100);
            return 2 * n;
        }

        static Random rand = null;

        // pick one with max cost randomly
        string PickRandom(HashSet<string> set)
        {
            Debug.Assert(set.Count != 0);

            if (rand == null)
            {
                rand = new Random((int)DateTime.Now.Ticks);
            }

            //var max = set.Select(c => candidateToCost[c]).Max();
            //var selected = set.Where(s => candidateToCost[s] == max);
            var selected = set;

            var ind = rand.Next(selected.Count());
            return selected.ToList()[ind];
        }

        // Prune away some constants according to annotations
        static void DropConstants(Program program, HashSet<string> drop)
        {
            
            var constants = new HashSet<string>(
                program.TopLevelDeclarations.OfType<Constant>()
                .Select(c => c.Name));

            var dontdrop = constants.Difference(drop);

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, dontdrop, true);
            program.RemoveTopLevelDeclarations(c => c is Constant && drop.Contains((c as Constant).Name));
        }

        // Input program must be an RMT query
        static void CheckRMT(Program program)
        {
            if (program.TopLevelDeclarations.OfType<Implementation>()
                .Any(impl => impl.Blocks
                    .Any(blk => blk.Cmds
                        .Any(c => c is AssertCmd && !BoogieUtil.isAssertTrue(c)))))
                throw new Exception("Input program cannot have an assertion");

            var ep = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                .FirstOrDefault();

            if (ep == null)
                throw new Exception("Entrypoint not found");
        }
    }
}