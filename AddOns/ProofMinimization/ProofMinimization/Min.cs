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

    struct MinimizerData
    {
        // file name -> Program
        public Dictionary<string, PersistentProgram> fileToProg;
        // template ID -> file -> {constants}
        public Dictionary<int, Dictionary<string, HashSet<string>>> templateMap;
        // identifier string -> template ID 
        public Dictionary<string, int> strToTemplate;
        public Dictionary<int, string> templateToStr;
        // file -> constants to keep always
        public Dictionary<string, HashSet<string>> fileToKeepConstants;
        // file -> perf
        public Dictionary<string, int> fileToPerf;
        // template Id -> template expression
        public Dictionary<int, Expr> tempIdToExpr;

        public Dictionary<string, HashSet<int>> fileToTempIds;

        public MinimizerData(Dictionary<string, PersistentProgram> fileToProg, Dictionary<string, int> fileToPerf,
                             Dictionary<string, HashSet<string>> fileToKeepConstants, Dictionary<int, Dictionary<string, HashSet<string>>> templateMap,
                             Dictionary<int, string> templateToStr, Dictionary<string, int> strToTemplate, Dictionary<int, Expr> tempIdToExpr,
                             Dictionary<string, HashSet<int>> fileToTempIds) 
        {
            this.fileToProg = fileToProg;
            this.fileToPerf = fileToPerf;
            this.fileToKeepConstants = fileToKeepConstants;
            this.templateMap = templateMap;
            this.templateToStr = templateToStr;
            this.strToTemplate = strToTemplate;
            this.tempIdToExpr = tempIdToExpr;
            this.fileToTempIds = fileToTempIds;
        }
    }

    abstract class Minimizer
    {
        // file name -> Program
        public MinimizerData mdata;

        public Minimizer(MinimizerData mdata)
        {
            this.mdata = mdata;
        }

        public abstract HashSet<int> FindMin(out Dictionary<int, int> templateToPerfDelta);
    }



    // TODO: make this non-static
    // ZVONIMIR: I believe this TODO could now be removed.
    static class MinControl
    {
        public static int IterCnt = 0;
        public static bool dbg = false;
        static readonly int TemplateCounterStart = 1000;
        public static bool usePerf = false;
        public static bool useSI = true;
        public static int method = 0;
        
        public static MinimizerData ReadFiles(IEnumerable<string> files, HashSet<string> keepPatterns)
        {
            Dictionary<string, PersistentProgram> fileToProg = new Dictionary<string, PersistentProgram>();
            Dictionary<int, Dictionary<string, HashSet<string>>> templateMap = new Dictionary<int, Dictionary<string, HashSet<string>>>();
            Dictionary<string, int> strToTemplate = new Dictionary<string, int>();
            Dictionary<int, string> templateToStr = new Dictionary<int, string>();
            Dictionary<string, HashSet<string>> fileToKeepConstants = new Dictionary<string, HashSet<string>>();
            Dictionary<string, int> fileToPerf = new Dictionary<string, int>();
            
            Dictionary<int, Expr> tempIdToExpr = new Dictionary<int, Expr>();
            Dictionary<string, HashSet<int>> fileToTempIds = new Dictionary<string, HashSet<int>>();

            var addTemplate = new Action<int, string, string>((templateId, file, constant) =>
                {
                    if (!templateMap.ContainsKey(templateId)) templateMap.Add(templateId, new Dictionary<string, HashSet<string>>());
                    if (!templateMap[templateId].ContainsKey(file)) templateMap[templateId].Add(file, new HashSet<string>());
                    templateMap[templateId][file].Add(constant);
                });

            foreach (var f in files)
            {
                var program = BoogieUtil.ReadAndResolve(f);
                CheckRMT(program);

                fileToKeepConstants.Add(f, new HashSet<string>());
                fileToTempIds.Add(f, new HashSet<int>());

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
                HashSet<string> consts = new HashSet<string>(allconstants.Keys);
                HashSet<string> assignment;
                int perf = 0;

                var ret = ConstrInitialProof(new PersistentProgram(program), consts, out assignment, ref perf);

                if (ret != BoogieVerify.ReturnStatus.OK)
                {
                    Console.WriteLine("Warning: Program {0} doesn't have an initial inductive proof", f);
                    continue;
                }

                // anything not in assignment can be dropped
                DropConstants(program, consts.Difference(assignment));
                consts.Difference(assignment).Iter(s => allconstants.Remove(s));
                fileToKeepConstants[f].IntersectWith(assignment);

                Console.WriteLine("File {0} defines {1} constants ({2} dropped)", f, assignment.Count, consts.Count - assignment.Count);

                // initial perf
                fileToPerf.Add(f, perf);

                // create template map
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
                    {
                        string constantName = null;
                        Expr expr = null;

                        var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                            ens.Condition, allconstants.Keys, out constantName, out expr);

                        expr = SimplifyExpr.NormalizeExpr(expr);

                        if (!match) continue;
                        if (fileToKeepConstants[f].Contains(constantName)) continue;

                        var templateId = QKeyValue.FindIntAttribute(ens.Attributes, "template", -1);
                        if (templateId != -1)
                        {
                            addTemplate(templateId, f, constantName);
                            if (!strToTemplate.ContainsKey(SimplifyExpr.ExprToTemplate(expr)))
                            {
                                strToTemplate.Add(SimplifyExpr.ExprToTemplate(expr), templateId);
                            }
                        }
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
                                var tid = TemplateCounterStart + strToTemplate.Count;
                                strToTemplate.Add(temp, tid);
                                addTemplate(strToTemplate[temp], f, constantName);
                                tempIdToExpr[strToTemplate[temp]] = SimplifyExpr.ExprToTemplateExpr(expr);
                                fileToTempIds[f].Add(tid);
                            }
                        }
                    }

                }

                // stash the program
                fileToProg.Add(f, new PersistentProgram(program));
            }

            templateToStr = new Dictionary<int, string>();
            strToTemplate.Iter(tup => templateToStr.Add(tup.Value, tup.Key));

            Console.WriteLine("Found {0} templates", templateMap.Count);

            if (dbg)
            {
                foreach (var tup in templateMap)
                {
                    Console.WriteLine("Template {0} :: {1}", tup.Key, templateToStr[tup.Key]);
                    foreach (var tup2 in tup.Value)
                    {
                        Console.WriteLine("  File {0}", tup2.Key);
                        tup2.Value.Iter(c => Console.WriteLine("    Candidate {0}", c));
                    }
                }
            }
            return new MinimizerData(fileToProg, fileToPerf, fileToKeepConstants, templateMap, templateToStr, strToTemplate, tempIdToExpr, fileToTempIds);
        }

        public static HashSet<int> Minimize(MinimizerData data, out  Dictionary<int, int> templateToPerfDelta)
        {
            if (method == 1)
            {
                K1BreadthMinimizer minimizer = new K1BreadthMinimizer(data);
                return minimizer.FindMin(out templateToPerfDelta);
            }
            else
            {
                ConjuctMinimizer minimizer = new ConjuctMinimizer(data);
                return minimizer.FindMin(out templateToPerfDelta);
            }
        }



        // Construct initial proof (removing non-candidates along the way).
        public static BoogieVerify.ReturnStatus ConstrInitialProof(PersistentProgram inp, HashSet<string> candidates, out HashSet<string> assignment, ref int inlined)
        {
            IterCnt++;
            var program = inp.getProgram();
            program.Typecheck();
            
            program = BoogieUtil.ReResolve(program);

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
                BoogieVerify.options.maxInlinedBound = MinControl.PerfMetric(inlined);

            var rstatus = BoogieVerify.Verify(program, out err, true);
            //Console.WriteLine(string.Format("  >> Procedures Inlined: {0}", BoogieVerify.CallTreeSize));
            //Console.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));

            inlined = BoogieVerify.CallTreeSize + 1;
            BoogieVerify.options.CallTree = new HashSet<string>();
            BoogieVerify.CallTreeSize = 0;
            BoogieVerify.verificationTime = TimeSpan.Zero;

            return rstatus;
        }
   
        public static int PerfMetric(int n)
        {
            if (!usePerf) return Int32.MaxValue;
            if (!useSI) return (n+1);
            if (n < 50) return (n + 100);
            return 2 * n;
        }

        static Random rand = null;

        // pick one with max cost randomly
        public static T PickRandom<T>(HashSet<T> set)
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

        // Prune away some constants from the program
        public static void DropConstants(Program program, HashSet<string> drop)
        {
            
            var constants = new HashSet<string>(
                program.TopLevelDeclarations.OfType<Constant>()
                .Select(c => c.Name));

            var dontdrop = constants.Difference(drop);

            CoreLib.HoudiniInlining.InstrumentHoudiniAssignment(program, dontdrop, true);
            program.RemoveTopLevelDeclarations(c => c is Constant && drop.Contains((c as Constant).Name));
        }

        // Input program must be an RMT query
        public static void CheckRMT(Program program)
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


        // Basically a copy of InstantiateTemplates from VerificationPasses.
        public static List<Expr> InstantiateTemplate(Expr template, HashSet<Variable> templateVars, 
                                                     Dictionary<string, Variable> globals, Dictionary<string, Variable> formals)
        {
            HashSet<string> templateVarNames = new HashSet<string>();
            templateVars.Iter(v => templateVarNames.Add(v.Name));
            Dictionary<string, Variable> templateNameToVar = new Dictionary<string, Variable>();
            templateVars.Iter(v => templateNameToVar.Add(v.Name, v));

            var ret = new List<Expr>();

            var dup = new FixedDuplicator();

            // TODO: Akash's code uses globalsUsed. Why????
            var used = new GlobalVarsUsed();
            used.VisitExpr(template);

            if (used.varsUsed.Any(g => !globals.ContainsKey(g) && !templateVarNames.Contains(g)))
            {
                Console.WriteLine("UNINDENTIFED VARIABLE FOUND IN THE TEMPLATE: {0}", template.ToString());
                return ret;
            }
                
            var subst = new Dictionary<string, Variable>();

            var templateVarUsed = used.varsUsed.Intersection(templateVarNames);
            
            if (templateVarUsed.Count == 0)
            {
                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals, new Dictionary<string, Function>())).VisitExpr(e);
                ret.Add(e);
                return ret;
            }

            // Set of matches for each template variable
            var matches = new Dictionary<string, HashSet<Variable>>();
            
            foreach (var tvName in templateVarUsed)
            {
                var tv = templateVars.First(v => v.Name == tvName);
                matches.Add(tvName, new HashSet<Variable>());

                var includeFormalIn = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalIn");
                var includeFormalOut = QKeyValue.FindBoolAttribute(tv.Attributes, "includeFormalOut");
                var includeGlobals = QKeyValue.FindBoolAttribute(tv.Attributes, "includeGlobals");

                if (!includeFormalIn && !includeFormalOut && !includeGlobals)
                {
                    includeFormalIn = true;
                    includeFormalOut = true;
                    includeGlobals = true;
                }

                var onlyMatchVar = QKeyValue.FindStringAttribute(tv.Attributes, "match");
                System.Text.RegularExpressions.Regex matchRegEx = null;
                if (onlyMatchVar != null) matchRegEx = new System.Text.RegularExpressions.Regex(onlyMatchVar);

                foreach (var kvp in globals.Concat(formals))
                {
                    if (tv.TypedIdent.Type.ToString() != kvp.Value.TypedIdent.Type.ToString())
                        continue;

                    if (kvp.Value is Constant) continue;
                    if (matchRegEx != null && !matchRegEx.IsMatch(kvp.Key)) continue;
                    if (!includeFormalIn && kvp.Value is Formal && (kvp.Value as Formal).InComing) continue;
                    if (!includeFormalOut && kvp.Value is Formal && !(kvp.Value as Formal).InComing) continue;
                    if (!includeGlobals && kvp.Value is GlobalVariable) continue;
                    
                    var v = templateNameToVar[tvName];
                    if (v is Formal && kvp.Value is Formal)
                    {
                        if ((v as Formal).InComing != (kvp.Value as Formal).InComing)
                        {
                            continue;
                        }
                    }

                    matches[tvName].Add(kvp.Value);
                }
            }

            // return if empty set of matches
            if (matches.Any(kvp => kvp.Value.Count == 0))
                return ret;

            // take cartesian product
            var tvars = new List<string>(matches.Keys);
            var matchArr = new List<Variable[]>();
            for (int i = 0; i < tvars.Count; i++)
            {
                var arr = new Variable[matches[tvars[i]].Count];
                int j = 0;
                foreach (var v in matches[tvars[i]]) arr[j++] = v;
                matchArr.Add(arr);
            }

            // N-bit counter
            var counter = new int[tvars.Count];
            for (int i = 0; i < counter.Length; i++) counter[i] = 0;
            var GetNext = new Func<bool>(() =>
            {
                var done = false;
                var i = 0;
                while (!done)
                {
                    counter[i]++;
                    if (counter[i] == matchArr[i].Length)
                    {
                        counter[i] = 0;
                        i++;
                        if (i == counter.Length)
                            return false;
                    }
                    else
                    {
                        done = true;
                    }
                }
                return true;
            });

            do
            {
                subst = new Dictionary<string, Variable>();
                for (int i = 0; i < tvars.Count; i++)
                    subst.Add(tvars[i], matchArr[i][counter[i]]);
                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals)).VisitExpr(e);
                ret.Add(e);
            } while (GetNext());

            return ret;
        }
    }
}