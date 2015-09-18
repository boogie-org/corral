using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Microsoft.Basetypes;
using BType = Microsoft.Boogie.Type;
using cba.Util;

namespace ExplainError
{

    /// <summary>
    /// Status returned by ExplainError
    /// </summary>
    public enum STATUS
    {
        SUCCESS,         /* the returned constraint suppresses error */
        PARTIALCOVER,    /* will be deprecated */
        TIMEOUT,         /* analysis timed out */
        INCONCLUSIVE,    /* analysis was imprecise */
        ILLEGAL          /* some unexpected condition encountered */
    };

    public enum COVERMODE
    {
        MONOMIAL,       /* only consider a monomial overcover (clausal under cover for resulting block) */
        FULL,           /* only consider full DNF overcover   (CNF under cover for the resulting block) */
        FULL_IF_NO_MONOMIAL  /* only consider full if no monomial overcover other than true */
    };

    public class Toplevel
    {
        # region Analysis flags
        public const string CAPTURESTATE_ATTRIBUTE_NAME = "captureState";
        private const int MAX_TIMEOUT = 100;
        private const int MAX_CONJUNCTS = 5000; //max depth of stack

        //Options: Add them to ParseAndRemoveNonBoogieOptions

        //flags to control which assumes to consider in the trace
        //Important: Keep default as the sound option, as it influences the the "true" trace slicing
        private static bool onlySlicAssumes = false;
        private static bool ignoreAllAssumes = false; //default = false

        //flags to define syntactic filters on atoms
        private static bool onlyDisplayAliasingInPre = false;
        private static bool onlyDisplayMapExpressions = false;
        private static bool dontDisplayComparisonsWithConsts = false;
        private static bool displayTypeStateVariables = true; //display any atom where some variable is annotated with a {:typestatevar}
        private static bool displayGuardVariables = true; //display any atom where some variable is annotated with a {:guardvar}
        private static bool noFilters = false; //if true, then matches any atom
        private static bool diplayPropertyMaps = true; //hack: added for filtering valid

        //the Exprs to filter by
        public static bool useFiltersFromFile = false;
        public static List<Expr> negativeFilters;
        public static List<Expr> positiveFilters;

        //flags to define Boolean structure on the cover
        private static COVERMODE eeCoverOpt = COVERMODE.FULL_IF_NO_MONOMIAL;

        //Display options
        private static bool showBoogieExprs = false;
        public static bool useFieldMapAttribute = true; //shoudl always use it, not exposing
        public static bool dontUsePruningWhileEliminatingUpdates = false; // if false, uses a prover to sel(upd(m,i,v),j) --> {v, sel(m,j), ite(i=j, v, sel(m,j))}
        public static bool checkIfExprFalseCalled = false; //HACK!
        private static int timeout = MAX_TIMEOUT; // seconds
        private static bool verbose = false;

        #endregion

        #region Globals
        //Statics
        static private Stopwatch sw;
        static public Program prog;
        static private Implementation currImpl;
        static private Expr currPre; //the current pre under consideration
        /* vcgen related state */
        static private VCGen vcgen;
        static private ProverInterface proverInterface;
        //static private ProverInterface.ErrorHandler handler;
        static private ConditionGeneration.CounterexampleCollector collector;
        static private Boogie2VCExprTranslator translator;
        static private VCExpressionGenerator exprGen;

        static public HashSet<string> fieldMapFuncs; //set of functions that have "fieldMap" attribute
        static public bool allCubesCovered; // are all the cubes covered in the final returned set
        static public STATUS returnStatus; //what is the status of the return
        static public Dictionary<string, string> complexCExprs; //list of let exprs for displaying concisely

        static private ControlFlowDependency cflowDependencyInfo; //information of static analysis of the entire program

        // side-effect
        static public List<Expr> suggestions = new List<Expr>(); // input constraint suggestions

        #endregion

        //this will be invoked from corral
        /// <summary>
        /// explainErrorFilters is used to control any options to filter
        ///    0 : reserved for default SDV options 
        ///    1 : {ignoreAllAssumes, !onlyDisplayAliasingInPre, !onlyDisplayMapExpressions, !dontDisplayComparisonWithConsts}
        ///    10: (returns true/false)
        /// </summary>
        /// <param name="impl"></param>
        /// <param name="pr"></param>
        /// <param name="tmout"></param>
        /// <param name="skipAssumes">a set of assumes to skip from slicing</param>
        /// <param name="explainErrorFilters"></param>
        /// <param name="status"></param>
        /// <param name="complexCExprsRet"></param>
        /// <returns></returns>
        public static List<string> Go(Implementation impl, Program pr, int tmout, int explainErrorFilters,
            string extraArgs,
            ControlFlowDependency cntrlFlowDependencyInfo,
            HashSet<AssumeCmd> skipAssumes, 
            out STATUS status, out Dictionary<string, string> complexCExprsRet,
            out HashSet<List<Expr>> preInDnfForm,
            out List<Tuple<string,int,string>> eeSlicedSourceLines)
        {
            Console.WriteLine("List of non-cmd-line arguments to EE = {0}", extraArgs);
            suggestions = new List<Expr>();
            ExplainError.Toplevel.ParseCommandLine("");
            prog = pr;
            /////////////////////////////////////
            //override teh default options
            verbose = false;
            onlySlicAssumes = true; //changing it to false makese several stackoverflowexns, timeouts with little 
            onlyDisplayAliasingInPre = true;
            onlyDisplayMapExpressions = true;
            dontDisplayComparisonsWithConsts = true;
            cflowDependencyInfo = cntrlFlowDependencyInfo;
            if (explainErrorFilters == 1) //using it for memory safety rootcause
            {
                ignoreAllAssumes = true;
                //onlyDisplayAliasingInPre = false;
                onlyDisplayMapExpressions = false;
                dontDisplayComparisonsWithConsts = false;
            }

            showBoogieExprs = false;
            complexCExprsRet = null;
            timeout = tmout > 0 ? tmout : MAX_TIMEOUT;
            Console.WriteLine("ExplainError:Timeout = {0}", timeout);

            string[] na;
            ParseArgs(extraArgs.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries), out na);
            ////////////////////////////////////
            ExplainError.Toplevel.fieldMapFuncs = new HashSet<string>();
            if (ExplainError.Toplevel.useFieldMapAttribute)
                foreach (var a in ExplainError.Toplevel.prog.TopLevelDeclarations)
                    if ((a is Function) && QKeyValue.FindStringAttribute(((Function)a).Attributes, "fieldmap") != null)
                        ExplainError.Toplevel.fieldMapFuncs.Add(((Function)a).Name);
            var tmp = Go(impl, skipAssumes, out preInDnfForm, out eeSlicedSourceLines);
            status = returnStatus;
            complexCExprsRet = complexCExprs;
            return tmp;
        }
        public static List<string> Go(Implementation impl,
            HashSet<AssumeCmd> skipAssumes,
            out HashSet<List<Expr>> preInDnfForm, 
            out List<Tuple<string,int,string>> eeSlicedSourceLines)
        {
            sw = new Stopwatch();
            sw.Start();
            preInDnfForm = null; //HashSet<List<Expr>> preInDnfForm = null;
            eeSlicedSourceLines = null;
            allCubesCovered = true;
            returnStatus = STATUS.INCONCLUSIVE;
            currImpl = impl; //avoid passing it around
            if (!CheckSanity(impl)) return null;
            Console.WriteLine("############# Implementation = {0} #################", impl.Name);
            try
            {
                //SimplifyAssumesUsingForwardPass();
                ComputePreCmdSeq(impl.Blocks[0].Cmds, skipAssumes, out preInDnfForm, out eeSlicedSourceLines);
                //Don't call the prover on impl before the expression generation phase, it adds auxiliary incarnation variables, and later checks are rendered vacuous
                //10/29/14: [shuvendu] Not sure what CheckNecessayDisjuncts does exactly, we will pretend it returns true, but need the check for semantically true
                //expressions (CheckIfTrueDisjunct). We have extracted it out of CheckNecessaryDisjuncts call now
                if (true /*CheckNecessaryDisjuncts(ref preInDnfForm)*/)
                {
                    CheckIfTrueDisjunct(ref preInDnfForm);
                    Console.WriteLine("SUCCESS!! Returned set of cubes are necessary and minimal ....");
                    Console.WriteLine("ExplainError Rootcause = {0}", ExprListSetToDNFExpr(preInDnfForm)); //print boogie exprs
                    returnStatus = STATUS.SUCCESS;
                }
                else
                {
                    Console.WriteLine(">>>> WARNING: The returned set is not necessary (incomplete)....");
                    returnStatus = STATUS.PARTIALCOVER;
                }
                currImpl = null;
                sw.Stop();
                var preStrings = DisplayDisjunctsOnConsole(preInDnfForm);
                PersistSuggestionsInFile(preInDnfForm, preStrings);
                return preStrings;
            }
            catch (Exception e)
            {
                Console.WriteLine("ExplainError failed with {0}", e.Message);
                if (e is TimeoutException) returnStatus = STATUS.TIMEOUT;
                else returnStatus = STATUS.INCONCLUSIVE;
                preInDnfForm = new HashSet<List<Expr>>();
                return new List<string>();
            }
        }

        /// <summary>
        /// Top-level method for performing a true trace slicing independent of EE heuristics
        /// </summary>
        /// <param name="impl"></param>
        /// <param name="pr"></param>
        /// <param name="tmout"></param>
        /// <param name="cntrlFlowDependencyInfo"></param>
        /// <param name="eeSlicedSourceLines"></param>
        /// <returns>the set of assumes that were skipped</returns>
        public static HashSet<AssumeCmd> TrueTraceSlicing(Implementation impl, Program pr, int tmout, 
            ControlFlowDependency cntrlFlowDependencyInfo,
            out List<Tuple<string,int,string>> eeSlicedSourceLines)
        {
            sw = new Stopwatch();
            sw.Start();
            Console.WriteLine("\n\nEE: Performning sound TraceSlicing with no EE filter");
            ExplainError.Toplevel.ParseCommandLine("");
            prog = pr;
            /////////////////////////////////////
            //override teh default options
            verbose = false;
            cflowDependencyInfo = cntrlFlowDependencyInfo;
            timeout = tmout > 0 ? tmout : MAX_TIMEOUT;
            //we will ignore any options to EE, for sound slicing
            onlySlicAssumes = false;
            ignoreAllAssumes = false; //default = false

            ////////////////////////////////////
            ExplainError.Toplevel.fieldMapFuncs = new HashSet<string>();
            //Don't care variables
            HashSet<List<Expr>> preInDnfForm;
            HashSet<AssumeCmd> skippedAssumes = new HashSet<AssumeCmd>(); //set of assumes to skip starts emtpy and modified by ComputePreCmdSeq
            ComputePreCmdSeq(impl.Blocks[0].Cmds, skippedAssumes, out preInDnfForm, out eeSlicedSourceLines,true);
            return skippedAssumes;
        }

        private static void PersistSuggestionsInFile(HashSet<List<Expr>> preInDnfForm, List<string> preStrings)
        {
            var cnfClauses = ExprListSetToNegatedCNFExprList(preInDnfForm);
            cnfClauses.Iter(x =>
                suggestions.Add(x));
        }

        private static void CheckTimeout(string p)
        {
            if (verbose) Console.Write("At [{0},{1},{2}]..", p, sw.ElapsedMilliseconds / 1000, timeout);
            if (sw.ElapsedMilliseconds > timeout * 1000) throw new TimeoutException("ExplainError timed out at [" + p + "]" + sw.ElapsedMilliseconds + " ms");
        }

        # region Top-level routines for computing and massaging Pre

        /// <summary>
        /// Will compute a DNF form of precondition for statements upto the last assume {:captureState "Start"} true
        /// or all the statements, if no such assume exists
        /// Performs a static slicing of the trace
        /// </summary>
        /// <param name="cmdseq"></param>
        /// <param name="preInDnfForm"></param>
        private static void ComputePreCmdSeq(List<Cmd> cmdseq, 
            HashSet<AssumeCmd> skipAssumes, /* modified */
            out HashSet<List<Expr>> preInDnfForm, out List<Tuple<string,int,string>> eeRelevantSourceLines,
            bool traceSlicingOnly=false)
        {
            HashSet<Variable> supportVarsInPre = new HashSet<Variable>();
            Stack<Tuple<string, string>> branchJoinStack = new Stack<Tuple<string, string>>();

            var GetSupportVars = new Func<Expr, IEnumerable<Variable>>(x =>
            {
                var vc = new VariableCollector();
                vc.Visit(x);
                return vc.usedVars;
            }
            );

            eeRelevantSourceLines = new List<Tuple<string, int, string>>();
            var allSourceLines = new List<Tuple<string, int>>();

            var FindSourceLineInfo = new Func<QKeyValue, Tuple<string,int>> (kv => 
                {
                    var sourceFile = QKeyValue.FindStringAttribute(kv, "sourcefile");
                    var sourceLine = QKeyValue.FindIntAttribute(kv, "sourceline", -1);
                    if (sourceFile != null && sourceLine != -1)
                        return Tuple.Create(sourceFile, sourceLine);
                    return null;
                });

            preInDnfForm = new HashSet<List<Expr>>();
            List<Cmd> cmds = cmdseq.Cast<Cmd>().ToList();
            cmds.Reverse();
            //Expr pre = Expr.True; //pre(cmd, true) //changing it to a list as subsExpr uses visitExpr
            var preL = new List<Expr>();
            preL.Add(Expr.True);
            int conjunctCount = 0; //keep track of how many conjuncts to avoid StackOverflow in substituteExpr/perform DNF
            int numAssertsInTrace = 0;
            int numAssumeSkipped = 0;
            int numAssumes = 0;
            int numAssigns = 0, numAssignsSkipped = 0;
            List<string> lastStmtsAdded = new List<string>(); //remember if a stmt was added since last sourceline found
            foreach (var cmd in cmds)
            {
                //if (verbose) Console.WriteLine("+++Stack = {0}", string.Join(",", branchJoinStack.ToList()));
                CheckTimeout("Inside ComputePre");
                if (cmd is AssertCmd)
                {
                    if (IsTrueAssert((AssertCmd)cmd))
                    {
                        var si = FindSourceLineInfo(((AssertCmd)cmd).Attributes);
                        if (si != null) //a line with sourcefile/sourceline info
                        {
                            //only count valid sourcefiles
                            if (si.Item1 != "?")
                            {
                                allSourceLines.Add(Tuple.Create(si.Item1, si.Item2));
                                if (lastStmtsAdded.Count > 0)
                                    eeRelevantSourceLines.Add(Tuple.Create(si.Item1, si.Item2, string.Join("\t", lastStmtsAdded)));
                            }
                            lastStmtsAdded.Clear();  //reset it after considering sourceline
                        }
                        continue; 
                    } else
                    {
                        #region ensure single non-trivial assert
                        //EE requires that there is at most one assert in the trace 
                        //We will ignore any assertion with True syntactically, but otherwise crash if there are multiple asserts
                        #endregion
                        Debug.Assert(numAssertsInTrace == 0,
                            string.Format("EE requires at most one non-syntactic-true assertion in the trace, found an extra {0}", cmd.ToString()));
                        Debug.Assert(branchJoinStack.Count == 0, "Expecting the branchJoin stack to be empty at an assertion");
                        numAssertsInTrace++;
                        //pre = Expr.And(Expr.Not(((AssertCmd)cmd).Expr), pre); //TODO: Boolean simplifications
                        preL.Add(Expr.Not(((AssertCmd)cmd).Expr));
                        GetSupportVars(((AssertCmd)cmd).Expr).Iter(x => supportVarsInPre.Add(x));
                    }
                }
                else if (cmd is AssumeCmd)
                {
                    string captureStateLoc;
                    if (ContainsCaptureStateAttribute((AssumeCmd)cmd, out captureStateLoc))
                    {
                        Debug.Assert(branchJoinStack.Count == 0, "Expecting the branchJoin stack to be empty at a captureStateLoc ");
                        break; //compute pre now
                    }
                    if (ContainsBlockInfo((AssumeCmd)cmd))
                    {
                        //if (verbose) Console.WriteLine("--- Block {0}", cmd);
                        UpdateBranchJoinStack((AssumeCmd)cmd, supportVarsInPre, branchJoinStack);
                        continue;
                    }
                    if (!MatchesSyntacticAssumeFilters((AssumeCmd)cmd)) continue;
                    numAssumes++; //this assume permitted by filter
                    if (skipAssumes.Contains(cmd) || branchJoinStack.Count > 0)
                    {
                        numAssumeSkipped++; 
                        //we are adding to skipAssumes when !skipAssumes.Contains(cmd) && branchJoinStack.Count > 0
                        skipAssumes.Add(cmd as AssumeCmd); 
                        continue;
                    }
                    if (conjunctCount++ > MAX_CONJUNCTS) throw new Exception("Aborting as there is a chance of StackOverflow");
                    if (conjunctCount % 100 == 0) Console.Write("{0},", conjunctCount);
                    //pre = Expr.And(((AssumeCmd)cmd).Expr, pre); //TODO: Boolean simplifications
                    preL.Add(((AssumeCmd)cmd).Expr);
                    GetSupportVars(((AssumeCmd)cmd).Expr).Iter(x => supportVarsInPre.Add(x));
                }
                else if (cmd is AssignCmd)
                {
                    //The assignments cannot be skipped, as we need to do substituion. 
                    var a = (cmd as AssignCmd).AsSimpleAssignCmd;
                    //pre = ExprUtil.MySubstituteInExpr(pre, a.Lhss, a.Rhss);
                    //compare the old and substituted expr to see if we can skip this assignment
                    var oldPreL = new List<Expr>(preL);
                    preL = preL.ConvertAll((x => ExprUtil.MySubstituteInExpr(x, a.Lhss, a.Rhss)));
                    numAssigns++;
                    supportVarsInPre.Clear(); //we will compute it fresh from preL
                    preL.Iter(e => GetSupportVars(e).Iter(y => supportVarsInPre.Add(y)));
                    if (!oldPreL.Zip(preL).Any(x => x.Item1.ToString() != x.Item2.ToString()))
                    {
                        numAssignsSkipped++;
                        continue; //don't display considered stmt
                    }
                }
                else
                {
                    continue; 
                }
                lastStmtsAdded.Add(cmd.ToString()); //if we reach here some statement was added
            }
            var slicingStr = traceSlicingOnly ? "TraceSlicing" : "Precond";
            Console.WriteLine("ExplainError[{2}]: Num of conditionals considered by slice/Total Num conditionals = {0}/{1}", numAssumes-numAssumeSkipped, numAssumes, slicingStr);
            Console.WriteLine("ExplainError[{2}]: Num of relevant source lines considered by slice/Total source lines = {0}/{1}", 
                eeRelevantSourceLines.Count, allSourceLines.Count, slicingStr);
            Console.WriteLine("ExplainError[{0}]: Sliced Trace => \n\t{1}", slicingStr,
                string.Join("\n\t", eeRelevantSourceLines.Select(x => string.Format(("#### sourceFile = {0}, sourceLine = {1}, \n\t\t {2}"), x.Item1, x.Item2, x.Item3))));

            //Now compute the pre over the sequence of commands
            //THIS IS THE HEAVYWEIGHT SIMPLIFICATION, SO IGNORE WHEN NOT NEEDED
            if (traceSlicingOnly) return;
            foreach (var d in ComputePreOverVocab(preL, null))
                preInDnfForm.Add(d);
        }

        private static void UpdateBranchJoinStack(AssumeCmd assumeCmd, HashSet<Variable> supportVars, Stack<Tuple<string, string>> branchJoinStack)
        {
            //block is b
            //can have other attributes
            var GetImplAndBlockFromAttr = new Func<QKeyValue, Tuple<string, string>>(y =>
                {
                    for (var x = y; x != null; x = x.Next)
                    {
                        if (x.Key == "basicblock")
                            return Tuple.Create((string)x.Params[0], (string)x.Params[1]);
                        else if (x.Key == "beginproc")
                            return Tuple.Create((string)x.Params[0], "beginproc");
                        else if (x.Key == "endproc")
                            return Tuple.Create((string)x.Params[0], "endproc");
                    }
                    return Tuple.Create((string)null, (string)null);
                }
            );

            //for var {:origianllocal "f", "x"} y, return "x", otherwise "y"
            var GetOrigVar = new Func<Variable, string>(v =>
            {
                if (BoogieUtil.checkAttrExists("originallocal", v.Attributes))
                    return (string)v.Attributes.Params[1];
                return v.ToString();
            });

            var blockInfo = GetImplAndBlockFromAttr(assumeCmd.Attributes);
            Debug.Assert(blockInfo.Item1 != null, "Implementation cannot be null in basicblock/beginproc/endproc annotations");
            string branchBlockName;
            HashSet<string> modSet;
            //First pop since blockInfo.Item2 can be both a branch and a join point
            if (cflowDependencyInfo.IsBranchBlock(blockInfo))
            {
                if (branchJoinStack.Count > 0 &&
                    branchJoinStack.Peek().Item1 == blockInfo.Item1 &&
                    branchJoinStack.Peek().Item2 == blockInfo.Item2)
                {
                    Console.WriteLine("BranchJoinStack: Pop {0} {1}", blockInfo.Item1, blockInfo.Item2);
                    branchJoinStack.Pop();
                }
            }
            if (cflowDependencyInfo.IsJoinBlock(blockInfo, out branchBlockName, out modSet))
            {
                var origVars = supportVars.Select(x => GetOrigVar(x));
                if (branchJoinStack.Count > 0 || !origVars.Any(x => modSet.Contains(x)))
                {
                    Console.WriteLine("BranchJoinStack: Push {0} {1} from {2}", blockInfo.Item1, branchBlockName, blockInfo.Item2);
                    //for (b1,j1) and (b1,j2), b1 is only encountered once, so we need to merge the two pushes
                    if (branchJoinStack.Count == 0  ||
                        branchJoinStack.Peek().Item1 != blockInfo.Item1 ||
                        branchJoinStack.Peek().Item2 != branchBlockName)
                        branchJoinStack.Push(Tuple.Create(blockInfo.Item1, branchBlockName));
                }
            }

        }

        private static bool ContainsBlockInfo(AssumeCmd assumeCmd)
        {
            if (cflowDependencyInfo == null) return false;
            return BoogieUtil.checkAttrExists("basicblock", assumeCmd.Attributes) ||
                 BoogieUtil.checkAttrExists("beginproc", assumeCmd.Attributes) ||
                 BoogieUtil.checkAttrExists("endproc", assumeCmd.Attributes);
        }

        private static void SimplifyAssumesUsingForwardPass()
        {
            foreach (Cmd c in currImpl.Blocks[0].Cmds)
            {
                var assumeCmd = c as AssumeCmd;
                if (assumeCmd == null) continue;
                if (assumeCmd.Expr.ToString() == Expr.True.ToString()) continue;
                if (!MatchesSyntacticAssumeFilters(assumeCmd)) continue; //thousands of assumes on uninitialized variables
                //HACK: still hundreds of assumes, just look for the equalities
                var oldExpr = assumeCmd.Expr;
                if (!(
                    oldExpr.ToString().Contains("==") ||
                    oldExpr.ToString().Contains("!="))) continue;

                assumeCmd.Expr = Expr.Not(oldExpr);
                prog.Resolve(); prog.Typecheck(); //TODO: perhaps move this inside MyVerifyImplementation?
                Console.WriteLine("Checking the assume {0} ", assumeCmd);
                if (VCVerifier.MyVerifyImplementation(currImpl) == ConditionGeneration.Outcome.Correct)
                {
                    Console.WriteLine("Evals to true");
                    assumeCmd.Expr = Expr.True;
                }
                else
                {
                    assumeCmd.Expr = oldExpr;
                }
            }
            throw new Exception("This is just for experimentation");
        }
        private static HashSet<List<Expr>> ComputePreOverVocab(List<Expr> pre, string captureStateLoc)
        {
            if (verbose) Console.WriteLine("ComputePreOverVocab...");
            pre.Reverse(); // to keep up the list structure as before (when pre was conjoined)

            currPre = ExprUtil.ConjoinExprsBalanced(pre);
            HashSet<List<Expr>> displayStrs = new HashSet<List<Expr>>();
            List<Expr> cubeLiterals; // = new List<Expr>();
            cubeLiterals = pre;
            CheckTimeout("Inside ComputePreOverVocab");
            Expr t = Expr.True;
            var nc = new List<Expr>();
            foreach (var c in cubeLiterals)
                nc.Add(FlattenITE(RewriteITEFixPoint(CreateITE(c))));
            t = ExprUtil.ConjoinExprsBalanced(nc); //TODO: perform NNF should just take nc
            if (VCVerifier.CheckIfExprFalse(currImpl, t))
                throw new Exception("Something wrong in ExplainError as EE thinks the trace looks infeasible");
            if (!VCVerifier.CheckIfExprFalse(currImpl, Expr.Not(Expr.Iff(currPre, t))))
            {
                //Console.WriteLine("currPre = {0}, t = {0}", currPre.ToString(), t.ToString());
                //until we can show that the exprs before and after the ITE rewrite are the same
                Console.WriteLine("!!! WARNING: The ITE simplications are not validity preserving");
            }
            var e = ExprUtil.PerformNNF(t);
            //TODO: get the NNF in a list<Expr> form so that FilteredPreIsNecessary does not have to recurse on the AND chain
            Expr fe; //filtered expr (not used)
            HashSet<Expr> filteredAtoms;
            if ((filteredAtoms = FilteredAtoms(currImpl, e, out fe)).Count == 0)
            {
                //throw new Exception("Abort: No atoms after applying filter...no point proceeding");
                Console.WriteLine("No atoms after applying filter...treating it as Expr.True");
                currPre = null;
                displayStrs = new HashSet<List<Expr>>();
                displayStrs.Add(new List<Expr>() { Expr.True });
                return displayStrs;
            }
            var preDnf = new List<Expr>();
            //we first check if there is a cover using a non-empty conjunction of atoms
            if (eeCoverOpt == COVERMODE.FULL)
            {
                Console.WriteLine("\n Going directly for precise but expensive DNF based cover\n");
                preDnf = ExprUtil.PerformDNF(e);
            }
            else
            {
                var mc = MonomialCubeCover(currImpl, currPre, e, filteredAtoms, out preDnf);
                if (mc)
                    Console.WriteLine("\n Found a conjunctive cube cover {0}\n", preDnf[0]);
                else
                {
                    if (eeCoverOpt == COVERMODE.MONOMIAL)
                        preDnf.Add(Expr.True); //return True as the cover, or false as the block
                    else //FULL_IF_NO_MONOMIAL
                    {
                        Console.WriteLine("\n No conjunctive cube cover found...going for precise but expensive DNF based cover\n");
                        preDnf = ExprUtil.PerformDNF(e);
                    }
                }
            }
            Console.WriteLine("\n\n-------------------- Pre at {0} in DNF [Size = {1}] ---------------------",
                        captureStateLoc == null ? "Start" : "CaptureState at " + captureStateLoc, preDnf.Count);
            var feasCnt = 0;
            var prunedCubesFromDnf = new HashSet<List<Expr>>(); //string form of exprs
            foreach (var cube in preDnf)
            {
                cubeLiterals.Clear();
                CheckTimeout("Before pruning");
                //Prune any cube that is unsat
                if (VCVerifier.CheckIfExprFalse(currImpl, cube))
                {
                    CheckTimeout("After pruning");
                    if (verbose) Console.WriteLine("Cube pruned"); continue;
                } //infeasible cube
                feasCnt++;
                SplitConjunction(cube, ref cubeLiterals);
                if (!FilterCubesOverVocabulary(cubeLiterals, ref prunedCubesFromDnf, ref displayStrs))
                {
                    //the DNF is essentially True
                    Console.WriteLine("\n ---- Pre in DNF is Expr.True as all atoms in a cube filtered away ---\n");
                    prunedCubesFromDnf.Clear(); displayStrs.Clear();
                    prunedCubesFromDnf.Add(new List<Expr>() { Expr.True });
                    displayStrs.Add(new List<Expr>() { Expr.True });
                    break;
                }
            }
            Console.WriteLine("--------------------- Feasible Count = {0} ----------------------------", feasCnt);
            currPre = null;
            return displayStrs;
        }

        /// <summary>
        /// Monomial abstraction of currPre using fe; less precise than full cover
        /// Overapproximates currPre with And_p{p in fe | currPre implies p}
        /// Returns false if the set only contains true
        /// </summary>
        /// <param name="currImpl"></param>
        /// <param name="currPre"></param>
        /// <param name="e"></param>
        /// <param name="fe"></param>
        /// <param name="l"></param>
        /// <returns></returns>
        private static bool MonomialCubeCover(Implementation currImpl, Expr currPre, Expr e, HashSet<Expr> fe, out List<Expr> l)
        {
            var t = fe.ToList().FindAll(a => VCVerifier.CheckIfExprFalse(currImpl, Expr.Not(Expr.Imp(currPre, a))));
            l = new List<Expr>();
            if (t.Count > 0)
                l.Add(t.Aggregate((Expr)Expr.True, (x, y) => ExprUtil.And(x, y)));
            return t.Count > 0;
        }

        /// <summary>
        /// Clause abstraction of currPre using fe; less precise than full cover (possibly stronger than the monomial cover, if it exists)
        /// Overapproximates currPre with Vee_p{p \in fe} that overapproximates currPre
        /// Ensure that the cover is not the same as True (e.g. x == null || x != null)
        /// </summary>
        /// <param name="currImpl"></param>
        /// <param name="currPre"></param>
        /// <param name="e"></param>
        /// <param name="fe"></param>
        /// <param name="l"></param>
        /// <returns></returns>
        private static bool ClauseCover(Implementation currImpl, Expr currPre, Expr e, HashSet<Expr> fe, out List<Expr> l)
        {
            throw new NotImplementedException();
        }

        class InjectNecessaryDisjuncts : StandardVisitor
        {
            Expr exprToAssume;
            public InjectNecessaryDisjuncts(Expr c)
            {
                exprToAssume = c;
            }
            public override Cmd VisitAssumeCmd(AssumeCmd cmd)
            {
                string captureStateLoc;
                if (ContainsCaptureStateAttribute((AssumeCmd)cmd, out captureStateLoc) &&
                    captureStateLoc != null)
                {
                    return base.VisitAssumeCmd(new AssumeCmd(Token.NoToken, exprToAssume));
                }
                return base.VisitAssumeCmd(cmd);
            }
        }
        private static bool CheckNecessaryDisjuncts(ref HashSet<List<Expr>> preInDnfForm)
        {
            if (!checkIfExprFalseCalled)
                throw new Exception("We need to call CheckIfEXprFalseCalled before calling CheckNecessaryDisjuncts");
            var proc = currImpl.Proc;
            Debug.Assert(proc != null, "The proc of currImpl is null");
            Expr disjunct = ExprListSetToDNFExpr(preInDnfForm);
            var oldCmds = new List<Cmd>(currImpl.Blocks[0].Cmds);
            var t = new InjectNecessaryDisjuncts(ExprUtil.Not(disjunct));
            t.VisitImplementation(currImpl); //changes currImpl as well
            var result = (VCVerifier.MyVerifyImplementation(currImpl) == VC.ConditionGeneration.Outcome.Correct);
            Console.WriteLine("Disjunct = {0}, IsNecessary= {1}", disjunct, result);
            currImpl.Blocks[0].Cmds = new List<Cmd>(oldCmds); //restore the cmds to have the captureState
            if (!result) return false;
            //now try to greedily minimize
            var retain = new HashSet<List<Expr>>();

            foreach (var d in preInDnfForm)
            {
                var tmp = new HashSet<List<Expr>>(preInDnfForm);
                tmp.Remove(d); //remove 1 element and check the rest
                disjunct = ExprListSetToDNFExpr(tmp);
                t = new InjectNecessaryDisjuncts(ExprUtil.Not(disjunct));
                t.VisitImplementation(currImpl); //changes currImpl as well
                result = (VCVerifier.MyVerifyImplementation(currImpl) == VC.ConditionGeneration.Outcome.Correct);
                Console.WriteLine("Disjunct = {0}, IsNecessary= {1}", disjunct, result);
                if (!result) retain.Add(d); //necessary
                currImpl.Blocks[0].Cmds = oldCmds; //restore the cmds to have the captureState
            }
            if (retain.Count > 0) //else keep preInDnfForm possibly non-minimal
                preInDnfForm = retain;
            return true;
        }

        /// <summary>
        /// check if the disjunct is semantically true
        /// if so, replace it by true
        /// </summary>
        /// <param name="preInDnfForm"></param>
        private static void CheckIfTrueDisjunct(ref HashSet<List<Expr>> preInDnfForm)
        {
            var pre = ExprUtil.Not(ExprListSetToDNFExpr(preInDnfForm));
            if (VCVerifier.CheckIfExprFalse(currImpl, pre))
            {
                Console.WriteLine("Replacing semantically true expr ({0}) with true", pre);
                preInDnfForm = new HashSet<List<Expr>>();
                preInDnfForm.Add(new List<Expr>() { Expr.True });
            }
        }

        private static List<string> DisplayDisjunctsOnConsole(HashSet<List<Expr>> preInDnfForm)
        {
            var preStrings = new List<string>();
            complexCExprs = new Dictionary<string, string>(); //a set of complex expressions that we abstract
            Console.WriteLine("\n\nThe list disjuncts\n---------------------\n");
            foreach (var g in preInDnfForm)
            {
                string displayStr = "";
                foreach (var c in g)
                {
                    var d = DisplayCExpression(c, 0, ref complexCExprs);
                    if (d == null) continue;
                    if (showBoogieExprs)
                        Console.WriteLine("\t {0} // {1} ", d, c);
                    else
                        Console.WriteLine("\t {0} ", d);
                    displayStr += (d + "\t");
                }
                Console.WriteLine("------------");
                preStrings.Add(displayStr);
            }
            Console.WriteLine("\n\nThe list of complex objs definitions ");
            foreach (var kv in complexCExprs)
                Console.WriteLine("\t{0} ==> {1}", kv.Value, kv.Key);
            return preStrings;
        }
        /// <summary>
        /// Returns the subset of literals in cubeLiterals that matches Vocabulary (IsLiteralInVocabulary)
        /// Returns false if the set of literals is empty, indicating the expression True
        /// </summary>
        /// <param name="cubeLiterals"></param>
        /// <param name="displayedConjuncts"></param>
        /// <param name="displayStrs"></param>
        /// <returns></returns>
        private static bool FilterCubesOverVocabulary(List<Expr> cubeLiterals, ref HashSet<List<Expr>> displayedConjuncts, ref HashSet<List<Expr>> displayStrs)
        {
            CheckTimeout("Inside DisplayConjuncts");
            List<Expr> toDisplay = new List<Expr>();
            foreach (var c in cubeLiterals)
            {
                //apply the display filters first (the RewriteITEFixPoint is very expensive, only apply locally)
                if (!LiteralInVocabulary(c)) continue;
                toDisplay.Add(c);
            }
            if (toDisplay.Count == 0) { return false; }
            //var str = String.Join(",", toDisplay);
            //if (displayedConjuncts.Contains(str)) return;
            if (SubsumedCubes(toDisplay, displayedConjuncts)) return true;
            //Console.WriteLine("------------");
            //displayedConjuncts.Add(str);
            displayedConjuncts.Add(toDisplay);
            displayStrs.Add(toDisplay); //this may be redundant, as the C expressions are generated much later
            CheckTimeout("End DisplayConjuncts");
            return true;
        }
        // finds if there is a cube in displayedConjuncts that is subsumed by toDisplay
        private static bool SubsumedCubes(List<Expr> toDisplay, HashSet<List<Expr>> displayedConjuncts)
        {
            foreach (var cb in displayedConjuncts)
            {
                bool found = true;
                foreach (var d in cb)
                {
                    if (toDisplay.Find(x => (x.ToString() == d.ToString())) == null)
                    {
                        found = false;
                        break;
                    }
                }
                if (found) return true;
            }
            return false;
        }
        #endregion

        #region Helper functins for displaying C expressions
        //returns null whenever there is confusion
        private static Expr DisplayCExpression(Expr c, int depth, ref Dictionary<string, string> complexCExprs)
        {
            //Displays expr with some hacked up C string
            //M_f'[f(h(x))] --> x.h.f 
            //f' can be type unified (pvoid)
            //[[f(e)]]         --> literal"[[e]].f"
            //                     & literal"[[e]].f", when at the outermost scope
            //[[M_f'[g(e)]]]   --> let  x = [[g(e)]] in x
            //[[M_f'[e]]       --> let  x = [[e]] in *x
            //[[Uop(e1)]]      --> Cop(Uop) [[e1]]         //unary
            //[[BOp(e1,e2)]]   --> [[e1]] Cop(BOp) [[e2]]  //binary
            //[[Op(e1,e2..)]]  --> Cop(Op) ([[e1]],...)    //nary
            var a = c as NAryExpr;
            if (a == null) return c;
            var newArgs = new List<Expr>();
            foreach (Expr arg in a.Args)
            {
                var t = DisplayCExpression(arg, depth + 1, ref complexCExprs);
                if (t == null) return null;
                newArgs.Add(t);
            }
            var f = a.Fun as Function;
            string fldname = null;
            if (IsCField(a.Fun, out fldname) && a.Args.Count == 1)
                return MakeCFieldDeref(newArgs[0], fldname, c.Type);
            if (IsCMemory(a.Fun, newArgs)) //dont use the name in the field as it could be a unified type
            {
                //strip the & from arg when Mem is applied
                var tmp = StripAddrOf(newArgs[1]);
                if (IsFieldDeref(a.Args)) //x.f, takes a.Args
                    return GetArrowFromDot(tmp);
                else
                    return MakeCDeref(tmp, c.Type);
            }
            var ret = ExprUtil.NAryExpr(a.Fun, newArgs);
            if (depth != 0)
            {
                //only non-field/Mem exprs at depth > 0 are interesting
                //depth 0 can include ==/!= etc. that we keep
                var key = "complex-obj" + complexCExprs.Count;
                if (!complexCExprs.ContainsKey(ret.ToString()))
                    complexCExprs.Add(ret.ToString(), key);
                else
                    key = complexCExprs[ret.ToString()];
                return Expr.Ident(key, c.Type);
            }
            return ret;
        }
        private static Expr StripAddrOf(Expr expr)
        {
            var es = expr.ToString();
            if (!es.StartsWith("&")) return expr;
            return Expr.Ident(es.Substring(1), expr.Type);
        }
        private static Expr MakeAddrOf(Expr expr, BType t)
        {
            var es = "&" + expr.ToString();
            return new IdentifierExpr(Token.NoToken, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, es, t)));
        }
        //makes e.f --> e->f
        private static Expr GetArrowFromDot(Expr expr)
        {
            var i = expr as IdentifierExpr;
            if (i == null) return expr;
            var s = i.ToString();
            if (!s.Contains('.')) return expr;
            var l = s.LastIndexOf('.');
            var t = s.Substring(0, l) + "->" + s.Substring(l + 1);
            return Expr.Ident(t, expr.Type);
        }
        private static bool IsFieldDeref(IList<Expr> args)
        {
            if (args == null || args.Count != 2) return false;
            if (!args[0].ToString().StartsWith("Mem_")) return false;
            var a = args[1] as NAryExpr;
            if (a == null) return false;
            var f = a.Fun as FunctionCall;
            if (f == null) return false;
            return true;
        }
        private static bool IsCMemory(IAppliable fun, List<Expr> es)
        {
            var str = fun.FunctionName;
            if (es == null || es.Count != 2) return false;
            var f = es[0].ToString();
            if (str == "MapSelect" && f.StartsWith("Mem_")) return true; //Mem_T.PVOID does not contain __
            return false;
        }
        private static Expr MakeCFieldDeref(Expr expr, string fldname, BType t)
        {
            var es = StripAddrOf(expr).ToString() + "." + fldname; //when composing fields, get the & out
            var e = new IdentifierExpr(Token.NoToken, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, es, t)));
            return MakeAddrOf(e, t);
        }
        private static Expr MakeCDeref(Expr expr, BType t)
        {
            var es = "*" + expr.ToString();
            return new IdentifierExpr(Token.NoToken, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, es, t)));
        }
        private static bool IsCField(IAppliable appliable, out string fldname)
        {
            fldname = null;
            if (IsCFieldAttribute(appliable, out fldname))
                return true;
            var f = appliable.FunctionName;
            string fieldSep = "_";
            if (f.Contains(fieldSep)) //HACK!!
            {
                fldname = f.Substring(0, f.IndexOf(fieldSep));
                return true;
            }
            if (f.Contains("_unnamed_tag_"))
            {
                fldname = f.Substring(0, f.IndexOf("_unnamed_tag_"));
                return true;
            }
            return false;
        }
        private static bool IsCFieldAttribute(IAppliable appliable, out string fldname)
        {
            fldname = null;
            var f = appliable as FunctionCall;
            if (f == null) return false;
            fldname = QKeyValue.FindStringAttribute(f.Func.Attributes, "fieldname");
            return fldname != null;
        }
        #endregion

        #region The routines to eliminate array updates from expressions
        //From the almost correct spec project (acsspec) 
        private static Expr CreateITE(Expr p)
        {
            CheckTimeout("Inside CreateITE");
            var pn = p as NAryExpr;
            if (pn == null) return p;
            if (pn.Fun.FunctionName == "MapSelect")
            {
                return EliminateUpdates(pn.Args[0], pn.Args[1]);
            }
            List<Expr> args = new List<Expr>();
            var pArgs = new List<Expr>(pn.Args);
            foreach (Expr a in pArgs /*pn.Args*/)  //Collection was modified; enumeration operation may not execute (???)
            {
                var b = CreateITE(a);
                args.Add(b);
            }
            return ExprUtil.NAryExpr(pn.Fun, args);
        }
        private static Expr EliminateUpdates(Expr map, Expr index)
        {
            CheckTimeout("Inside EliminateUpdates");
            if (!(map is NAryExpr)) return Expr.Select(map, CreateITE(index));
            var m = map as NAryExpr;
            if (m.Fun.FunctionName != "MapStore")
            {
                return Expr.Select(map, index);
                //throw new Exception("Error: Expecting a mapstore expression. Are you using a 2-dimensional map in " + m.ToString());
            }
            var i = m.Args[0];
            var j = m.Args[1];
            var k = m.Args[2];
            var eq = ExprUtil.Eq(index, j);
            var l = Expr.Select(i, index);
            if (IsInconsistentWithContext(eq))
            {
                Console.Write("+");
                return CreateITE(l); //else
            }
            else if (IsInconsistentWithContext(ExprUtil.Not(eq)))
            {
                Console.Write("-");
                return CreateITE(k); //then
            }
            Console.Write("*");
            var a = CreateITE(eq);
            var b = CreateITE(k);
            var c = CreateITE(l);
            return ExprUtil.Ite(a, b, c);
        }
        //Is eq inconsistent with the context
        private static bool IsInconsistentWithContext(Expr e)
        {
            //turning it on may be unsound M[x:=1][y] != 1 ==> x != y, but simplifying it to M[y] != 1 is not equivalent            
            if (dontUsePruningWhileEliminatingUpdates) return false;
            if (currPre == null) return false;
            var res = VCVerifier.CheckIfExprFalse(currImpl, ExprUtil.And(currPre, e));
            Console.Write(".");
            return res;
        }
        private static Expr TryRewriteITE(Expr e)
        { //Try to apply a rewrite rule if applicable
            CheckTimeout("Inside TryRewriteITE");
            if (!(e is NAryExpr)) return e;
            var a = e as NAryExpr;
            if (a.Fun.FunctionName == "if-then-else")
            {
                return new NAryExpr(Token.NoToken, new IfThenElse(Token.NoToken), new List<Expr> { TryRewriteITE(a.Args[0]), TryRewriteITE(a.Args[1]), TryRewriteITE(a.Args[2]) });
            }
            List<Expr> args = new List<Expr>();
            int indx = 0;
            foreach (Expr b in a.Args)
            {
                if (!(b is NAryExpr)) { args.Add(b); indx++; continue; }
                var c = b as NAryExpr;
                if (c.Fun.FunctionName != "if-then-else") { args.Add(TryRewriteITE(c)); indx++; continue; }
                var i = TryRewriteITE(c.Args[0]);
                var j = TryRewriteITE(c.Args[1]);
                var k = TryRewriteITE(c.Args[2]);
                var args1 = new List<Expr>(a.Args);
                args1[indx] = j;
                var t1 = ExprUtil.NAryExpr(a.Fun, args1);
                var args2 = new List<Expr>(a.Args);
                args2[indx] = k;
                var t2 = ExprUtil.NAryExpr(a.Fun, args2);
                return new NAryExpr(Token.NoToken, new IfThenElse(Token.NoToken), new List<Expr> { i, t1, t2 });
            }
            return ExprUtil.NAryExpr(a.Fun, args);
        }
        private static Expr RewriteITEFixPoint(Expr e)
        {
            CheckTimeout("RewriteITEFixPoint start");
            var e1 = e;
            var e2 = TryRewriteITE(e1);
            while (e2.ToString() != e1.ToString()) { e1 = e2; e2 = TryRewriteITE(e1); }
            return e2;
        }
        private static Expr FlattenITE(Expr expr)
        {
            CheckTimeout("FlattenITE start");
            Expr a, b, c;
            var e = expr as NAryExpr;
            if (e == null) return expr;
            var args = new List<Expr>();
            foreach (Expr arg in e.Args)
                args.Add(FlattenITE(arg));
            var f = ExprUtil.NAryExpr(e.Fun, args);
            if (!IsIteExpr(f, out a, out b, out c)) return f; //
            return ExprUtil.Or(
                ExprUtil.And(a, b),
                ExprUtil.And(ExprUtil.Not(a), c));
        }
        private static bool IsIteExpr(Expr expr, out Expr a, out Expr b, out Expr c)
        {
            a = b = c = null;
            var e = expr as NAryExpr;
            if (e == null) return false;
            if (e.Fun.FunctionName != "if-then-else") return false;
            a = e.Args[0];
            b = e.Args[1];
            c = e.Args[2];
            return true;
        }
        private static Expr EliminateITE(Expr p)
        {
            var e = p as NAryExpr;
            if (e == null) return p;
            if (ExprUtil.IsRelationalOp(e.Fun))
                return EliminateITERelationalExpr(e);
            var args = new List<Expr>();
            foreach (Expr a in e.Args)
                args.Add(EliminateITE(a));
            return ExprUtil.NAryExpr(e.Fun, args);
        }
        private static Expr EliminateITERelationalExpr(NAryExpr x)
        {
            var e = x as NAryExpr;
            if (e == null) return x;
            Expr a = null, b = null, c = null;
            //[[ ite(a,b,c) <> f ]] ---> {a && b <> f} || {!a &&  c <> f}    
            if (IsIteExpr(e.Args[0], out a, out b, out c))
                return ExpandITE(e.Fun, a, b, c, e.Args[1], false);
            //[[ f <> ite(a,b,c) ]] ---> {a && f <> b} || {!a &&  f <> c}    
            if (IsIteExpr(e.Args[1], out a, out b, out c))
                return ExpandITE(e.Fun, a, b, c, e.Args[0], true); //c <> f
            return e;
        }
        private static Expr ExpandITE(IAppliable fun, Expr a, Expr b, Expr c, Expr f, bool flip)
        {
            var bf = flip ? new List<Expr> { f, b } : new List<Expr> { b, f };
            var cf = flip ? new List<Expr> { f, c } : new List<Expr> { c, f };
            return ExprUtil.Or(
                ExprUtil.And(a, ExprUtil.NAryExpr(fun, bf)),
                ExprUtil.And(ExprUtil.Not(a), ExprUtil.NAryExpr(fun, cf)));
        }
        //private static bool IsSelectAppliedToUpdate(Expr expr, out Expr a, out Expr b, out Expr c, out Expr d)
        //{
        //    throw new NotImplementedException("This method is deprecated");
        //    a = null; b = null; c = null; d = null;
        //    var e = expr as NAryExpr;
        //    if (e == null) return false;
        //    if (e.Fun.FunctionName != "MapSelect") return false;
        //    var h = e.Args[0] as NAryExpr;
        //    if (h == null) return false;
        //    if (h.Fun.FunctionName != "MapStore") return false;
        //    a = h.Args[0];
        //    b = h.Args[1];
        //    c = h.Args[2];
        //    d = e.Args[1];
        //    return true;
        //}


        //deprecated methods
        //private static Expr EliminateArrayUpdates(Expr e)
        //{
        //    throw new NotImplementedException("This method is deprecated");
        //    //ASSUMPTION: maps are not passed as arguments to functions/predicates, including ==/!=
        //    //Apply the following rule recursively
        //    var a = e as NAryExpr;
        //    if (a == null) return e;
        //    Expr e1 = a;
        //    if (ExprUtil.IsRelationalOp(a.Fun))
        //        e1 = EliminateArrayUpdatesFromRelationalExpr(a);
        //    a = e1 as NAryExpr;
        //    if (a == null) return e1; // it could be that a is x == y, in that case we need to simplify the == 
        //    //recurse down the structure
        //    var newArgs = new List<Expr>();
        //    foreach (Expr arg in a.Args)
        //        newArgs.Add(EliminateArrayUpdates(arg));
        //    return ExprUtil.NAryExpr(a.Fun, newArgs);
        //}
        //private static Expr EliminateArrayUpdatesFromRelationalExpr(Expr x)
        //{
        //    throw new NotImplementedException("This method is deprecated");
        //    var e = x as NAryExpr;
        //    if (e == null) return x;
        //    Expr a = null, b = null, c = null , d = null;
        //    //[[sel(upd(a,b,c),d) <> f ]] ---> {b == d && c <> f} || {b != d && sel(a,d) <> f}    
        //    if (IsSelectAppliedToUpdate(e.Args[0], out a, out b, out c, out d))
        //    {
        //        return EliminateUpdateSelect(e.Fun, a, b, c, d, e.Args[1], false);
        //    }
        //    //[[f <> sel(upd(a,b,c),d) ]] ---> {b == d && f <> c} || {b != d && f <> sel(a,d)}    
        //    if (IsSelectAppliedToUpdate(e.Args[1], out a, out b, out c, out d))
        //    {
        //        return EliminateUpdateSelect(e.Fun, a, b, c, d, e.Args[0], true); //c <> f
        //    }
        //    return e;
        //}
        //private static bool IsSelectAppliedToUpdate(Expr expr, out Expr a, out Expr b, out Expr c, out Expr d)
        //{
        //    throw new NotImplementedException("This method is deprecated");
        //    a = null; b = null; c = null; d = null;
        //    var e = expr as NAryExpr;
        //    if (e == null) return false;
        //    if (e.Fun.FunctionName != "MapSelect") return false;
        //    var h = e.Args[0] as NAryExpr;
        //    if (h == null) return false;
        //    if (h.Fun.FunctionName != "MapStore") return false;
        //    a = h.Args[0];
        //    b = h.Args[1];
        //    c = h.Args[2];
        //    d = e.Args[1];
        //    return true;
        //}
        //private static Expr EliminateUpdateSelect(IAppliable fun, Expr a, Expr b, Expr c, Expr d, Expr f, bool flip)
        //{
        //    throw new NotImplementedException("This method is deprecated");
        //    /// The flip flag is used becaues the operator <> may not be symmetric (e.g. a < b and b < a)
        //    var bd = EliminateArrayUpdatesFromRelationalExpr(Expr.Eq(b, d)); // [[b == d]]
        //    List<Expr> cf;
        //    // c <> f vs. f <> c
        //    if (flip) 
        //        cf = new List<Expr>(f,c);
        //    else 
        //        cf = new List<Expr>(c,f); 
        //    var a2 = EliminateArrayUpdatesFromRelationalExpr(ExprUtil.NAryExpr(fun, cf)); //[[c<>f]]
        //    var dl = new List<Expr>(); dl.Add(d);
        //    List<Expr> sf; 
        //    // sel(a,d) <> f or f <> sel(a,d) 
        //    if (flip) 
        //        sf = new List<Expr>(f, Expr.Select(a, dl));
        //    else
        //        sf = new List<Expr>(Expr.Select(a, dl), f);
        //    var a3 = EliminateArrayUpdatesFromRelationalExpr(ExprUtil.NAryExpr(fun, sf)); //[[sf]]
        //    return ExprUtil.Or(ExprUtil.And(bd, a2), ExprUtil.And(ExprUtil.Not(bd), a3));
        //}
        #endregion

        #region Parsing related methods
        /*
         * A whole bunch of parsing functions 
         */
        public static bool ParseCommandLine(string clo)
        {
            //without the next line, it fails to find the right prover!!
            var boogieOptions = "/typeEncoding:m /doModSetAnalysis -timeLimit:100  -removeEmptyBlocks:0 /errorLimit:1 /printInstrumented " + clo;
            var oldArgs = boogieOptions.Split(' ');
            string[] args;
            //Custom parser to look and remove RootCause specific options
            var help = ParseArgs(oldArgs, out args);
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.RunningBoogieFromCommandLine = true;
            CommandLineOptions.Clo.Parse(args);
            return !help;
        }
        public static bool CheckBooleanFlag(string s, string flagName, ref bool flag, bool valueWhenPresent)
        {
            if (s == "/" + flagName || s == "-" + flagName)
            {
                flag = valueWhenPresent;
                return true;
            }
            return false;
        }
        public static bool CheckBooleanFlag(string s, string flagName, ref bool flag)
        {
            return CheckBooleanFlag(s, flagName, ref flag, true)
                || CheckBooleanFlag(s, flagName + "+", ref flag, true)
                || CheckBooleanFlag(s, flagName + "-", ref flag, false);
        }
        public static bool CheckIntegerFlag(string s, string flagName, ref int flag)
        {
            if (s.StartsWith("/" + flagName + ":") || s.StartsWith("-" + flagName + ":"))
            {
                int size = ("/" + flagName + ":").Length;
                if (Int32.TryParse(s.Substring(size), out flag))
                    return true;
                else
                    throw new Exception(string.Format("Illegal integer argument to {0}", s));
            }
            return false;
        }
        public static bool ParseArgs(string[] args, out string[] newargs)
        {
            var retArgs = new List<string>();
            bool help = false;
            foreach (var a in args)
            {
                if (CheckBooleanFlag(a, "verbose", ref verbose)) continue;
                if (CheckBooleanFlag(a, "onlySlicAssumes", ref onlySlicAssumes)) continue;
                if (CheckBooleanFlag(a, "ignoreAllAssumes", ref ignoreAllAssumes)) continue;
                if (CheckBooleanFlag(a, "onlyDisplayAliasingInPre", ref onlyDisplayAliasingInPre)) continue;
                if (CheckBooleanFlag(a, "displayGuardVars", ref displayGuardVariables)) continue;
                if (CheckBooleanFlag(a, "displayTypeStateVars", ref displayTypeStateVariables)) continue;
                if (CheckBooleanFlag(a, "onlyDisplayMapExpressions", ref onlyDisplayMapExpressions)) continue;
                if (CheckBooleanFlag(a, "dontDisplayComparisonsWithConsts", ref dontDisplayComparisonsWithConsts)) continue;
                if (CheckBooleanFlag(a, "noFilters", ref noFilters)) continue;
                //if (CheckBooleanFlag(a, "showPreAtAllCapturedStates", ref showPreAtAllCapturedStates)) continue;
                if (CheckBooleanFlag(a, "showBoogieExprs", ref showBoogieExprs)) continue;
                if (CheckBooleanFlag(a, "dontUsePruningWhileEliminatingUpdates", ref dontUsePruningWhileEliminatingUpdates)) continue;
                int eeCoverOptAsInt = 0;
                if (CheckIntegerFlag(a, "eeCoverOpt", ref eeCoverOptAsInt))
                {
                    eeCoverOpt =
                        eeCoverOptAsInt == 0 ? COVERMODE.MONOMIAL :
                        eeCoverOptAsInt == 1 ? COVERMODE.FULL :
                        COVERMODE.FULL_IF_NO_MONOMIAL;
                    continue;
                }
                retArgs.Add(a);
                if (a == "-?" || a == "/?") { retArgs.Remove(a); help = true; continue; } //Hide help from Boogie
            }
            newargs = retArgs.ToArray();
            if (help)
            {
                Console.WriteLine("\n  **** To see all the Boogie flags (only few like /proc supported), use /help \n");
                Console.WriteLine("\n  ---- ExplainError options ----------------------------------------\n");
                Console.WriteLine("  Boolean options: use /option or /option+ to set, use /option- to unset");
                Console.WriteLine("  /verbose:                      Makes output verbose");
                //Console.WriteLine("  /showPreAtAllCapturedStates    Show Pre at any place {:captureState} is specified, default only Start");
                Console.WriteLine("  /onlySlicAssumes:              Ignore assumes that do not have {:slic} attribute");
                Console.WriteLine("  /onlyDisplayAliasingInPre:     Only display aliasing (x == y) constaints where both sides are non constants");
                Console.WriteLine("  /onlyDisplayMapExpressions:    Only display expressions with at least one map expression (e.g. m[e] <> e'");
                Console.WriteLine("  /dontDisplayComparisonsWithConsts: Dont display expressions of the form e <> c, where c is const");
                Console.WriteLine("  /showBoogieExprs:              Displays Boogie exprs along with C exrpr (Cexpr //BoogieExpr)");
                Console.WriteLine("  /dontUsePruningWhileEliminatingUpdates:  Don't use pruning while eliminating updates (default off)");
                Console.WriteLine("  /eeCoverOpt:k :                Cover mode k = 0 (monomial only), = 1 (full dnf only), = _ (full-if-no-monomial)");
                Console.WriteLine("\n  ----------------------------------------------------------------\n");
                return true;
            }
            return false;
        }
        public static bool ParseProgram(string fname, out Program prog)
        {
            prog = null;
            int errCount;
            try
            {
                errCount = Parser.Parse(fname, new List<string>(), out prog);
                if (errCount != 0 || prog == null)
                {
                    Console.WriteLine("WARNING: {0} parse errors detected in {1}", errCount, fname);
                    return false;
                }
            }
            catch (IOException e)
            {
                Console.WriteLine("WARNING: Error opening file \"{0}\": {1}", fname, e.Message);
                return false;
            }
            errCount = prog.Resolve();
            if (errCount > 0)
            {
                Console.WriteLine("WARNING: {0} name resolution errors in {1}", errCount, fname);
                return false;
            }
            errCount = prog.Typecheck();
            if (errCount > 0)
            {
                Console.WriteLine("WARNING: {0} type checking errors in {1}", errCount, fname);
                return false;
            }
            return true;
        }
        private static bool ContainsCaptureStateAttribute(AssumeCmd assumeCmd, out string captureStateLoc)
        {
            captureStateLoc = QKeyValue.FindStringAttribute(assumeCmd.Attributes, CAPTURESTATE_ATTRIBUTE_NAME);
            //return (captureStateLoc != null);
            return captureStateLoc == "Start";
        }
        private static bool CheckSanity(Implementation impl)
        {
            if (impl == null) { returnStatus = STATUS.ILLEGAL; return false; }
            if (CommandLineOptions.Clo.ProcsToCheck != null && !CommandLineOptions.Clo.ProcsToCheck.Any(x => impl.Name.StartsWith(x)))
            {
                returnStatus = STATUS.ILLEGAL; return false;
            }
            if (impl.Blocks.Count == 0) { returnStatus = STATUS.ILLEGAL; return false; }
            if (impl.Blocks.Count > 1)
            {
                Console.WriteLine("Only expecting a single block with assume, assign statements terminating in an assert");
                returnStatus = STATUS.ILLEGAL;
                return false;
            }
            var offendingCmd = false;
            foreach (var stmt in impl.Blocks[0].Cmds)
            {
                if (!(stmt is AssumeCmd || stmt is AssertCmd || stmt is AssignCmd || stmt is HavocCmd || stmt is CallCmd))
                {
                    if (verbose)
                        Console.Write("Only expecting assume/assign/assert/havoc/call commands. \t ==> " + stmt);
                    else
                        offendingCmd = true;
                }
            }
            if (!verbose && offendingCmd)
                Console.WriteLine(">>>>WARNING: Presence of at least one non assign/assume/assert/havoc/call cmd found. Turn on /verbose to see the cmds.");
            return true;
        }
        #endregion

        #region Invoking Verifier for semantic queries
        private static void CreateProver()
        {
            //create vcgen/proverInterface
            vcgen = new VCGen(prog, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, new List<Checker>());
            proverInterface = ProverInterface.CreateProver(prog, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, CommandLineOptions.Clo.ProverKillTime);
            translator = proverInterface.Context.BoogieExprTranslator;
            exprGen = proverInterface.Context.ExprGen;
            collector = new ConditionGeneration.CounterexampleCollector();
        }
        /// <summary>
        /// Class for asking semantic questions for the verifier (carried over from almost correct specs)
        /// </summary>
        public static class VCVerifier
        {
            /// <summary>
            /// Checks if an expr implies false (modulo the axioms)
            /// </summary>
            /// <param name="impl"></param>
            /// <param name="e"></param>
            /// <returns></returns>
            public static bool CheckIfExprFalse(Implementation impl, Expr e)
            {//checks if e <=> false semantically
                var blks = new List<Block>();
                blks.Add(new Block());
                var i = new Implementation(Token.NoToken, "DummyCheckForFalse", impl.Proc.TypeParameters, impl.Proc.InParams, impl.Proc.OutParams, new List<Variable>(), new List<Block>());
                i.OriginalBlocks = blks;
                i.OriginalLocVars = new List<Variable>();
                var p = new Procedure(Token.NoToken, "DummyCheckForFalse", impl.Proc.TypeParameters, impl.Proc.InParams, impl.Proc.OutParams,
                    new List<Requires>(new Requires[] { new Requires(false, e) }), new List<IdentifierExpr>(), new List<Ensures>(new Ensures[] { new Ensures(false, Expr.False) }));
                i.Proc = p;
                var cexList = new List<Counterexample>();
                var mList = new List<Model>();
                prog.AddTopLevelDeclaration(i);
                prog.AddTopLevelDeclaration(p);
                prog.Resolve();
                prog.Typecheck();
                var result = (MyVerifyImplementation(i, ref cexList, ref mList) == VC.ConditionGeneration.Outcome.Correct);
                prog.RemoveTopLevelDeclaration(i);
                prog.RemoveTopLevelDeclaration(p);
                prog.Resolve();
                prog.Typecheck();
                Console.Write(".");
                if (verbose) Console.WriteLine("CheckIfExprFalse: input {0}, output {1}", e.ToString(), result);
                checkIfExprFalseCalled = true;
                return result;
            }
            //routines for querying the verifier
            public static VC.ConditionGeneration.Outcome MyVerifyImplementation(Implementation i,
                ref List<Counterexample> cexList, ref List<Model> mList)
            {
                //this creates a z3 process per vcgen
                var checkers = new List<Checker>();
                VC.VCGen vcgen = new VC.VCGen(prog, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend, checkers);
                //make deep copy of the blocks
                var tmpBlocks = new List<Block>();
                foreach (Block b in i.Blocks)
                {
                    var newcmds = new List<Cmd>();
                    foreach (var c in b.Cmds)
                        newcmds.Add(c);
                    tmpBlocks.Add(new Block(Token.NoToken, b.Label, newcmds, b.TransferCmd));
                }
                var tmpLocVars = new List<Variable>(i.LocVars);
                if (i.OriginalBlocks != null)
                {
                    i.Blocks = i.OriginalBlocks;
                    i.LocVars = i.OriginalLocVars;
                }
                var outcome = vcgen.VerifyImplementation((Implementation)i, out cexList, out mList);
                var reset = new ResetVerificationState();
                reset.Visit(i);
                foreach (Checker checker in checkers)
                {
                    //Contract.Assert(checker != null);
                    checker.Close();
                }
                vcgen.Close();
                i.Blocks = tmpBlocks;
                i.LocVars = tmpLocVars;
                return outcome;
            }
            public static VC.ConditionGeneration.Outcome MyVerifyImplementation(Implementation i)
            {
                List<Counterexample> cexs = new List<Counterexample>();
                List<Model> models = new List<Model>();
                return MyVerifyImplementation(i, ref cexs, ref models);
            }
            class ResetVerificationState : StandardVisitor
            {
                public override Cmd VisitAssertCmd(AssertCmd node)
                {
                    node.IncarnationMap = null;
                    return base.VisitAssertCmd(node);
                }
                public override TypedIdent VisitTypedIdent(TypedIdent node)
                {
                    if (node.Type != null)  //special hack to avoid encountering variables with null Type (e.g. call10690formal@b@0)
                        node.Type = (Microsoft.Boogie.Type)this.Visit(node.Type);
                    return node;
                }
                public override Cmd VisitAssumeCmd(AssumeCmd node)
                {
                    //TODO: This fix does not help

                    //get rid of some temp variables introduced
                    if (node.Expr != null && node.Expr.ToString().Contains("formal@"))
                        node.Expr = Expr.True;
                    else
                        node.Expr = this.VisitExpr(node.Expr);
                    return node;
                }

            }
        }
        #endregion

        #region Syntactic queries on expression sets and massaging to DNF/CNF/list form
        #region deprecated
        ///// <summary>
        ///// UNSOUND HACK: turns any f(t) --> t. Useful for comparing devExt(4) == devExt(5), where most funcs are unary 
        ///// </summary>
        ///// <param name="c"></param>
        ///// <returns></returns>
        //private static Expr CleanupUnaryFuncApplications(Expr a)
        //{
        //    var b = a as NAryExpr;
        //    if (b == null) return a;
        //    var newArgs = new List<Expr>();
        //    foreach (Expr arg in b.Args)
        //        newArgs.Add(CleanupUnaryFuncApplications(arg));
        //    if (newArgs.Count == 1 && b.Fun.FunctionName != "Not") //any unary function is shortcircuited
        //        return newArgs[0];
        //    return new NAryExpr(Token.NoToken, b.Fun, newArgs);
        //}
        #endregion
        private static bool IsAliasingConstraint(Expr c)
        {
            var expr = c as NAryExpr;
            if (expr == null) return false;
            var binOp = expr.Fun as BinaryOperator;
            if (binOp == null) return false;
            if (binOp.Op != BinaryOperator.Opcode.Eq /* && binOp.Op != BinaryOperator.Opcode.Neq */) return false;
            if (expr.Args[0] is LiteralExpr && expr.Args[1] is LiteralExpr) return false;
            //if (binOp.Op != BinaryOperator.Opcode.Eq && (expr.Args[0] is LiteralExpr || expr.Args[1] is LiteralExpr)) return false;
            //we want to keep x[y := z][w] != z constaints that give rise to y != w aliasing constraints
            return true;
        }
        private static bool ContainsMapExpression(Expr c)
        {
            var a = c as NAryExpr;
            if (a == null) return false;
            //just look at top-level exprs
            foreach (var arg in a.Args)
            {
                var b = arg as NAryExpr;
                if (b != null && b.Fun.FunctionName == "MapSelect")
                    return true;
            }
            return false;
        }
        private static bool IsRelationalExprWithConst(Expr c)
        {
            var a = c as NAryExpr;
            if (a == null) return false;
            //just look at top-level exprs
            if (!ExprUtil.IsRelationalOp(a.Fun)) return false;
            foreach (var arg in a.Args)
                if (arg is LiteralExpr) return true;
            return false;
        }
        private static bool ContainsGuardVar(Expr c)
        {
            var vu = new VarsUsed();
            vu.Visit(c);
            return vu.Vars.Any(v => QKeyValue.FindBoolAttribute(v.Attributes, "guardvar"));
        }

        private static bool ContainsPropertyMap(Expr c)
        {
            var vu = new VarsUsed();
            vu.Visit(c);
            return vu.Vars.Any(v => (QKeyValue.FindBoolAttribute(v.Attributes, "propertyMap") && v.TypedIdent.Type.IsMap));
        }
        private static bool ContainsTypeStateVar(Expr c)
        {
            var expr = c as NAryExpr;
            if (expr == null) return false;
            var binOp = expr.Fun as BinaryOperator;
            if (binOp == null) return false;
            if (binOp.Op != BinaryOperator.Opcode.Eq && binOp.Op != BinaryOperator.Opcode.Neq &&
                binOp.Op != BinaryOperator.Opcode.Lt && binOp.Op != BinaryOperator.Opcode.Gt &&
                binOp.Op != BinaryOperator.Opcode.Le && binOp.Op != BinaryOperator.Opcode.Ge
                ) return false;
            var x0 = expr.Args[0] as IdentifierExpr;
            var x1 = expr.Args[1] as IdentifierExpr;
            if (x0 == null && x1 == null) return false;
            
            if (x0 != null && QKeyValue.FindBoolAttribute(x0.Decl.Attributes, "typestatevar")) return true;
            if (x1 != null && QKeyValue.FindBoolAttribute(x1.Decl.Attributes, "typestatevar")) return true;


            return false;
        }

        #region LiteralNotInVocabulary reworked


        private static bool LiteralInVocabulary(Expr c)
        {
            Console.Write("Atom:{0}\t", c);
            if (useFiltersFromFile)
            {
                return LiteralInVocabularyNew(c);
            }
            else
                return !LiteralNotInVocabularyOld(c);
        }

        private static bool LiteralNotInVocabularyOld(Expr c)
        {
            //Console.Write("Atom:{0}\t", c);
            //TODO: currently, the order matters (otherwise {typestate}x != c will get filtered by aliasingConstarint)
            //TODO: separate positive and negative filters
            if (noFilters) return false; //anything matches
            if (displayTypeStateVariables && ContainsTypeStateVar(c)) return false;  //definitely matches
            if (!displayGuardVariables && ContainsGuardVar(c)) return true;  //definitely not matches
            if (diplayPropertyMaps && ContainsPropertyMap(c)) return false;
            if (onlyDisplayAliasingInPre && !IsAliasingConstraint(c)) return true;   //definitely not matches
            if (onlyDisplayMapExpressions && !ContainsMapExpression(c)) return true;
            if (dontDisplayComparisonsWithConsts && IsRelationalExprWithConst(c)) return true;
            if (!onlyDisplayAliasingInPre) return true;
            return false;
        }

        private static bool LiteralInVocabularyNew(Expr c)
        {
            foreach (var nf in negativeFilters)
            {
                var emv = new ExprMatchVisitor(nf);
                emv.Visit(c);
                if (emv.Matches)
                    return false;
            }
            foreach (var pf in positiveFilters)
            {
                var emv = new ExprMatchVisitor(pf);
                emv.Visit(c);
                if (emv.Matches)
                    return true;
            }
            return false;
        }

        #endregion

        /// <summary>
        /// Splits a conjunction into its components
        /// </summary>
        /// <param name="pre"></param>
        /// <param name="cubeLiterals"></param>
        private static void SplitConjunction(Expr pre, ref List<Expr> cubeLiterals)
        {
            if (cubeLiterals.Contains(pre)) return; //eliminate duplicates
            var expr = pre as NAryExpr;
            if (expr == null) { cubeLiterals.Add(pre); return; }
            var binOp = expr.Fun as BinaryOperator;
            if (binOp == null || binOp.Op != BinaryOperator.Opcode.And)
            {
                cubeLiterals.Add(pre); return;
            }
            SplitConjunction(expr.Args[0], ref cubeLiterals);
            SplitConjunction(expr.Args[1], ref cubeLiterals);
        }
        private static bool IsTrueAssert(AssertCmd assertCmd)
        {
            return (assertCmd.Expr.ToString() == "true"); //TODO: any better way to check?
        }
        private static bool MatchesSyntacticAssumeFilters(AssumeCmd assumeCmd)
        {
            if (((AssumeCmd) assumeCmd).Expr.ToString() == Expr.True.ToString()) return false;
            //only consider assume wiht {:partition} tags
            if (!QKeyValue.FindBoolAttribute(assumeCmd.Attributes, "partition")) return false;
            if (ignoreAllAssumes) return false;
            if(onlySlicAssumes) return QKeyValue.FindBoolAttribute(assumeCmd.Attributes, "slic");
            return true;
        }
        private static HashSet<Expr> FilteredAtoms(Implementation currImpl, Expr t, out Expr e)
        {
            var fexps = new HashSet<Expr>(); // list of filtered exprs
            e = GetFilteredExpr(t, ref fexps); //the return expr is of no value now
            Console.WriteLine("\n Filtered atoms before true/false = {0}", String.Join(", ", fexps));
            fexps.RemoveWhere(p =>
                VCVerifier.CheckIfExprFalse(currImpl, p) ||
                VCVerifier.CheckIfExprFalse(currImpl, Expr.Not(p))); //remove any true/false predicate
            Console.WriteLine("\n Filtered atoms = {0}", String.Join(", ", fexps));
            return fexps;
        }
        private static Expr GetFilteredExpr(Expr e, ref HashSet<Expr> fexps)
        {
            CheckTimeout("Inside GetFilteredExpr");
            var expr = e as NAryExpr;
            if (expr == null)
            {
                if (!LiteralInVocabulary(e)) return Expr.True; //default
                if (!fexps.Contains(e)) fexps.Add(e);
                return e;
            }
            var binOp = expr.Fun as BinaryOperator;
            if (binOp == null || (binOp.Op != BinaryOperator.Opcode.And && binOp.Op != BinaryOperator.Opcode.Or))
            {
                if (!LiteralInVocabulary(e)) return Expr.True; //default
                if (!fexps.Contains(e)) fexps.Add(e);
                return e;
            }
            return ExprUtil.NAryExpr(binOp,
                new List<Expr> { GetFilteredExpr(expr.Args[0], ref fexps), GetFilteredExpr(expr.Args[1], ref fexps) });
        }
        /// <summary>
        /// Returns false if c matches all the enabled filters that apply to it
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>

        public static Expr ExprListSetToDNFExpr(HashSet<List<Expr>> preInDnfForm)
        {
            Expr ret = Expr.False;
            foreach (var el in preInDnfForm)
                ret = ExprUtil.Or(ret, el.Aggregate((Expr)Expr.True, (x, y) => Expr.And(x, y)));
            return ret;
        }
        public static List<Expr> ExprListSetToNegatedCNFExprList(HashSet<List<Expr>> preInDnfForm)
        {
            //negate a set represnting DNF expression --> list of CNF clauses
            var ret = new List<Expr>();
            ret.AddRange(
                preInDnfForm.Select(el =>
                    el.Aggregate((Expr)Expr.False, (x, y) => ExprUtil.Or(x, ExprUtil.Not(y)))));
            return ret;
        }
        #endregion

        #region Expression transformer/simplifier module
        /// <summary>
        /// performs syntactic simplifications of expressions
        /// </summary>
        public static class ExprUtil
        {
            public static bool ExprEq(Expr a, Expr b)
            {
                if (a == b) return true;
                if (a.ToString() == b.ToString()) return true; //expr comparison does not work currently
                return false;
            }
            public static bool ExprNeq(Expr a, Expr b)
            {
                if (NeqDueToOntoFunc(a, b)) return true;
                if (a is LiteralExpr && b is LiteralExpr && a.ToString() != b.ToString()) return true;
                return false;
            }

            private static bool NeqDueToOntoFunc(Expr a, Expr b)
            {
                Expr a1 = null, b1 = null;
                IAppliable f1 = null, f2 = null;
                //checks if a is f(a') and b is f(b') where f is a one-one function
                if (IsOneToOneFuncAppl(a, out a1, out f1) && IsOneToOneFuncAppl(b, out b1, out f2) && f1.ToString() == f2.ToString())
                    return ExprNeq(a1, b1);
                return false;
            }
            private static bool IsOneToOneFuncAppl(Expr a, out Expr a1, out IAppliable f1)
            {
                //Currently, we look at the fieldMap attribute of a function
                a1 = null;
                f1 = null;
                var b = a as NAryExpr;
                if (b == null) return false;
                f1 = b.Fun;
                if (!fieldMapFuncs.Contains(f1.FunctionName)) return false;
                a1 = b.Args[0];
                return true;

            }

            public static Expr Not(Expr a)
            {
                if (ExprUtil.ExprEq(a, Expr.True)) return Expr.False;
                else if (ExprUtil.ExprEq(a, Expr.False)) return Expr.True;
                return Expr.Not(a);
            }
            public static Expr And(Expr a, Expr b)
            {
                if (ExprEq(a, Expr.False) || ExprEq(b, Expr.False)) return Expr.False;
                if (ExprEq(a, Expr.True)) return b;
                if (ExprEq(b, Expr.True)) return a;
                return Expr.And(a, b);
            }
            public static Expr Or(Expr a, Expr b)
            {
                if (ExprEq(a, Expr.True) || ExprEq(b, Expr.True)) return Expr.True;
                if (ExprEq(a, Expr.False)) return b;
                if (ExprEq(b, Expr.False)) return a;
                return Expr.Or(a, b);
            }
            public static Expr Eq(Expr a, Expr b)
            {
                if (ExprEq(a, b)) return Expr.True;
                if (ExprNeq(a, b)) return Expr.False;
                return Expr.Eq(a, b);
            }
            public static Expr Neq(Expr a, Expr b)
            {
                if (ExprEq(a, b)) return Expr.False;
                if (ExprNeq(a, b)) return Expr.True;
                return Expr.Neq(a, b);
            }
            public static Expr NAryExpr(IAppliable fun, List<Expr> exprSeq)
            {
                //it may not return an NAryExpr as some of them might be simplified to LiteralExpr And(x,T) --> x
                var op1 = fun as UnaryOperator;
                if (op1 != null && op1.Op == UnaryOperator.Opcode.Not) return ExprUtil.Not(exprSeq[0]);
                var op = fun as BinaryOperator;
                if (op == null) return new NAryExpr(Token.NoToken, fun, exprSeq);
                if (op.Op == BinaryOperator.Opcode.And) return ExprUtil.And(exprSeq[0], exprSeq[1]);
                if (op.Op == BinaryOperator.Opcode.Or) return ExprUtil.Or(exprSeq[0], exprSeq[1]);
                if (op.Op == BinaryOperator.Opcode.Eq) return ExprUtil.Eq(exprSeq[0], exprSeq[1]);
                if (op.Op == BinaryOperator.Opcode.Neq) return ExprUtil.Neq(exprSeq[0], exprSeq[1]);
                return new NAryExpr(Token.NoToken, fun, exprSeq);
            }
            public static Expr Ite(Expr a, Expr b, Expr c)
            {
                if (ExprEq(a, Expr.True)) return b;
                if (ExprEq(a, Expr.False)) return c;
                return new NAryExpr(Token.NoToken, new IfThenElse(Token.NoToken), new List<Expr> { a, b, c });
            }

            public static bool IsRelationalOp(IAppliable o)
            {
                var op = o as BinaryOperator;
                if (op == null) return false;
                return
                    (op.Op == BinaryOperator.Opcode.Le ||
                    op.Op == BinaryOperator.Opcode.Lt ||
                    op.Op == BinaryOperator.Opcode.Gt ||
                    op.Op == BinaryOperator.Opcode.Ge ||
                    op.Op == BinaryOperator.Opcode.Eq ||
                    op.Op == BinaryOperator.Opcode.Neq);
            }
            public static Expr MySubstituteInExpr(Expr p, IList<AssignLhs> lhss, IList<Expr> rhss)
            {
                var h = new Dictionary<Variable, Expr>();
                for (int i = 0; i < lhss.Count; ++i)
                {
                    h.Add(lhss[i].DeepAssignedVariable, rhss[i]);
                }
                Substitution s = Substituter.SubstitutionFromHashtable(h);
                return Substituter.Apply(s, p);
            }

            /// <summary>
            /// Converts e to a negation normal form by pushing negation
            /// </summary>
            /// <param name="e"></param>
            /// <returns></returns>
            public static Expr PerformNNF(Expr e)
            {
                return PerformNNFAux(e, false);
            }
            private static Expr PerformNNFAux(Expr e, bool not)
            {
                CheckTimeout("PerformNNFAux start");
                var a = e as NAryExpr;
                if (a == null)
                {
                    if (not) return ExprUtil.Not(e);
                    else return e;
                }
                var n = a.Fun as UnaryOperator;
                if (n != null && n.Op == UnaryOperator.Opcode.Not)
                    return PerformNNFAux(a.Args[0], !not);
                var m = a.Fun as BinaryOperator;
                if (m == null || (m.Op != BinaryOperator.Opcode.And && m.Op != BinaryOperator.Opcode.Or))
                {
                    if (not) return ExprUtil.Not(e);
                    else return e;
                }
                var t0 = PerformNNFAux(a.Args[0], not);
                var t1 = PerformNNFAux(a.Args[1], not);
                if (m.Op == BinaryOperator.Opcode.And && not)
                    return ExprUtil.Or(t0, t1);
                if (m.Op == BinaryOperator.Opcode.Or && not)
                    return ExprUtil.And(t0, t1);
                return NAryExpr(m, new List<Expr> { t0, t1 });
            }


            /// <summary>
            ///Converts to a Disjunctive Normal Form (DNF) 
            ///Blows up when Expr is large
            /// </summary>
            /// <param name="e"></param>
            /// <returns></returns>
            public static List<Expr> PerformDNF(Expr e)
            {
                CheckTimeout("PerformDNF start");
                var ret = new List<Expr>();
                ret.Add(e);
                var a = e as NAryExpr;
                if (a == null) return ret;
                var n = a.Fun as BinaryOperator;
                if (a == null || n == null || !(n.Op == BinaryOperator.Opcode.And || n.Op == BinaryOperator.Opcode.Or))
                    return ret;
                ret.Clear();
                if (n.Op == BinaryOperator.Opcode.Or)
                {
                    var l0 = PerformDNF(a.Args[0]);
                    var l1 = PerformDNF(a.Args[1]);
                    ret.AddRange(l0);
                    ret.AddRange(l1);
                    return ret;
                }
                else //has to be && 
                {
                    var l0 = PerformDNF(a.Args[0]);
                    var l1 = PerformDNF(a.Args[1]);
                    var m0 = new List<Expr>();
                    var m1 = new List<Expr>();
                    foreach (var b in l0)
                    {
                        CheckTimeout("PerformDNFPruning check1");
                        //Console.Write(".");
                        //if (!VCVerifier.CheckIfExprFalse(currImpl, ExprUtil.And(b, a.Args[1])))
                        m0.Add(b);
                    }
                    foreach (var b in l1)
                    {
                        CheckTimeout("PerformDNFPruning check2");
                        //Console.Write(".");
                        //if (!VCVerifier.CheckIfExprFalse(currImpl, ExprUtil.And(b, a.Args[0])))
                        m1.Add(b);
                    }
                    foreach (Expr b in m0) // Cross product
                    {
                        CheckTimeout("PerformDNF CrossProduct");
                        foreach (Expr c in m1)
                        {
                            //Console.Write("-");
                            if (!VCVerifier.CheckIfExprFalse(currImpl, ExprUtil.And(b, c)))
                                ret.Add(ExprUtil.And(b, c));
                        }
                    }
                    return ret;
                }
            }

            /// <summary>
            /// Conjoins a list of expressions, but tries to maintain a balanced tree
            /// </summary>
            /// <param name="preL"></param>
            /// <returns></returns>
            internal static Expr ConjoinExprsBalanced(List<Expr> preL)
            {
                List<Expr> workList = new List<Expr>(preL);
                var x = (Expr)Expr.True;
                while (workList.Count != 0)
                {
                    x = workList[0]; workList.RemoveAt(0);
                    if (workList.Count == 0) break;
                    var y = workList[0]; workList.RemoveAt(0);
                    var z = ExprUtil.And(x, y);
                    workList.Add(z);
                }
                return x;
            }
        }
        #endregion

    }

}
