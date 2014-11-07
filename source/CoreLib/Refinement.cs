using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Microsoft.Boogie;
using cba.Util;
using ProgTransformation;

namespace cba
{
    public abstract class GeneralVerifier
    {
        // A procedure that checks "prog" tracking variables in "trackedVars".
        // Returns: true if Valid (no bug), and false otherwise. 
        public abstract bool checkPath(PersistentCBAProgram prog, VarSet trackedVars);
    }

    public class GeneralRefinementScheme
    {
        public static bool printStats = false;
        public static bool useHierarchicalSearch = true;
        public static bool noInitialPruning = false;

        // The verifier
        protected GeneralVerifier verifier;

        // The program to refine over
        protected PersistentCBAProgram program;

        // The refinement state
        protected RefinementState refinementState;

        // The initial set of tracked tokens
        protected HashSet<IRefinementToken> initialTrackedTokens;

        // The initial set of untracked tokens
        protected HashSet<IRefinementToken> initialTrackedTokensUpperBound;

        // The set of all equi classes variables that may be tracked or untracked
        protected HashSet<IRefinementToken> allTokens;

        // Try dropping these variables in the initialPruning
        protected HashSet<string> tryDroppingVars;

        // Use search inside Z3
        public bool useZ3Search { get; protected set; }

        // Time take for refinement
        public TimeSpan timeTaken { get; private set; }

        public GeneralRefinementScheme(GeneralVerifier v, PersistentCBAProgram program, RefinementState refinementState)
            : this(v, false, program, refinementState, new HashSet<string>())
        { }

        public GeneralRefinementScheme(GeneralVerifier v, bool z3search, PersistentCBAProgram program, RefinementState refinementState)
            : this(v, z3search, program, refinementState, new HashSet<string>())
        { }

        public GeneralRefinementScheme(GeneralVerifier v, bool z3search, PersistentCBAProgram program, RefinementState refinementState, HashSet<string> tryDroppingVars)
        {
            verifier = v;
            this.program = program;
            this.refinementState = refinementState;
            this.allTokens = refinementState.allTokens;
            this.useZ3Search = z3search;
            this.timeTaken = TimeSpan.Zero;
            this.tryDroppingVars = new HashSet<string>(tryDroppingVars);

            // Initialize
            initialTrackedTokens = refinementState.trackedTokens;
            if (noInitialPruning)
            {
                initialTrackedTokensUpperBound = allTokens;
            }
            else
            {
                initialTrackedTokensUpperBound = initialPruning();
                initialTrackedTokensUpperBound.UnionWith(initialTrackedTokens);
            }

        }

        // Return a set of variables that definitely need not be tracked
        protected HashSet<IRefinementToken> initialPruning()
        {
            // Remove unread variables (locals and globals)
            Program prog = program.getProgram();
            var elim = new UnReadVarEliminator();
            prog = elim.run(prog);
            var globalsRead = new HashSet<string>();
            BoogieUtil.GetGlobalVariables(prog).Iter(v => globalsRead.Add(v.Name));

            BoogieUtil.DoModSetAnalysis(prog);
            HashSet<string> globalsModified = new HashSet<string>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                var proc = decl as Procedure;
                if (proc == null) continue;
                foreach (IdentifierExpr ie in proc.Modifies)
                {
                    globalsModified.Add(ie.Name);
                }
            }

            Debug.Assert(globalsRead.Contains(globalsModified));
            globalsModified.ExceptWith(tryDroppingVars);

            VarSet globalsModifiedVarSet = new VarSet(globalsModified, program.allVars.Procedures);
            var success = verifier.checkPath(program, globalsModifiedVarSet);
            if (success)
            {
                // No error -- variables not modified are irrelevant
                return refinementState.getRelevantTokens(globalsModified);
            }
            else
            {
                return refinementState.getRelevantTokens(globalsRead);
            }
        }

        // This does field refinement.
        // returns:
        //    the new set of variables to track in refinementState.trackedTokens

        public void doRefinement()
        {
            var startTime = DateTime.Now;

            if (VariableSlicing.EncounteredParallelAssignment)
            {
                // TODO: Fix! Currently, FullVariableAbstraction cannot
                // handle parallel assignments because it leads to too
                // many case splits
                useZ3Search = false;
                Console.WriteLine("Turning off Z3 search due to parallel assignments");
            }

            if (useZ3Search)
            {
                Program faProgProg;
                HashSet<string> boolVars;
                FullVariableAbstraction fabs;

                doRefinementInZ3Helper(out faProgProg, out boolVars, out fabs);
                ProgTransformation.PersistentProgramIO.CheckMemoryPressure();

                boolVars = BoogieVerify.FindLeastToVerify(faProgProg, boolVars);
                // Debug.Assert(boolVars.Count > 0);
                if (boolVars.Count == 0)
                    throw new InternalError("Refinement unable to make progress");

                refinementState.trackedTokens.UnionWith(fabs.getTokens(boolVars));

                timeTaken = (DateTime.Now - startTime);
                return;
            }

            var remainingVars = initialTrackedTokensUpperBound.Difference(initialTrackedTokens).Count;
            if (printStats)
            {
                Console.WriteLine("Vars to refine over: {0}", remainingVars);
            }

            if (useHierarchicalSearch)
            {
                var ec = refinementLoop(initialTrackedTokens, initialTrackedTokensUpperBound);
                if (ec.Count <= refinementState.trackedTokens.Count)
                {
                    var vp2t = new VariableSlicePass(refinementState.getVars());
                    var lowerProgt = vp2t.run(program);
                    lowerProgt.writeToFile("error.bpl");
                    Debug.Assert(false);
                }
                refinementState.trackedTokens = ec;
            }

            var varsDone = 0;
            var percentDone = 0;
            var trackedVars = new HashSet<IRefinementToken>(initialTrackedTokens);
            var trackedVarsUpperBound = new HashSet<IRefinementToken>(initialTrackedTokensUpperBound);
            foreach (IRefinementToken v in initialTrackedTokensUpperBound)
            {
                if (trackedVars.Contains(v))
                    continue;

                varsDone++;
                if (printStats && (varsDone * 10 / remainingVars) > percentDone)
                {
                    percentDone = varsDone * 10 / remainingVars;
                    Console.WriteLine("Percent done: {0}%", percentDone * 10);
                }

                trackedVarsUpperBound.Remove(v);
                bool success = refinementLoopCheckPath(trackedVarsUpperBound);

                if (!success)
                {
                    // error (abstracted too much), track v
                    trackedVars.Add(v);
                    trackedVarsUpperBound.Add(v);

                    success = refinementLoopCheckPath(trackedVars);

                    if (success)
                    {
                        // Tracking enough vars to rule out this counterexample, 
                        // continue with the rest of the program
                        break;
                    }
                }
            }

            refinementState.trackedTokens = trackedVars;
            timeTaken = (DateTime.Now - startTime);
        }

        private void doRefinementInZ3Helper(out Program faProgProg, out HashSet<string> boolVars, out FullVariableAbstraction fabs)
        {
            //program.writeToFile("RefineInp.bpl");

            var vp1 = new VariableSlicePass(refinementState.getVars(initialTrackedTokensUpperBound));
            var upperProg = vp1.run(program);

            //var vp2 = new VariableSlicePass(refinementState.getVars());
            //var lowerProg = vp2.run(program);
            //lowerProg.writeToFile("RefineLow.bpl");

            var p = upperProg.getCBAProgram();
            
            if (p.Typecheck() != 0)
            {
                p.Emit(new TokenTextWriter("error.bpl"));
                throw new InternalError("Type errors");
            }
            //BoogieUtil.PrintProgram(p, "RefineUp.bpl");

            fabs = new FullVariableAbstraction(p, initialTrackedTokens, allTokens.Difference(initialTrackedTokensUpperBound), refinementState);
            var faProg = fabs.doTransformation(out boolVars);
            fabs.FreeMemory();
            //faProg.writeToFile("RefineOut.bpl");
            Debug.Assert(boolVars.Count > 0);

            // Inline, if necessary
            // ********* missing **********
            //faProg.writeToFile("error.bpl");
            faProgProg = faProg.getProgram();

            var t = faProgProg.Typecheck();
            Debug.Assert(t == 0);

            //BoogieUtil.PrintProgram(faProgProg, "refine.bpl");

            ProgTransformation.PersistentProgram.FreeParserMemory();
        }


        // For CADE 2011
        public void doRefinement1()
        {
            var remainingVars = initialTrackedTokensUpperBound.Difference(initialTrackedTokens).Count;
            var initSize = initialTrackedTokens.Count;

            var t1 = DateTime.Now;

            counter = 0;
            var trackedVars = new HashSet<IRefinementToken>(initialTrackedTokens);
            var trackedVarsUpperBound = new HashSet<IRefinementToken>(initialTrackedTokensUpperBound);
            foreach (IRefinementToken v in initialTrackedTokensUpperBound)
            {
                if (trackedVars.Contains(v))
                    continue;

                trackedVarsUpperBound.Remove(v);
                bool success = refinementLoopCheckPath(trackedVarsUpperBound);

                if (!success)
                {
                    // error (abstracted too much), track v
                    trackedVars.Add(v);
                    trackedVarsUpperBound.Add(v);

                    success = refinementLoopCheckPath(trackedVars);

                    if (success)
                    {
                        // Tracking enough vars to rule out this counterexample, 
                        // continue with the rest of the program
                        break;
                    }
                }
            }
            var sol2 = trackedVars;
            var sol2count = counter;

            var t2 = DateTime.Now;

            counter = 0;
            var sol1 = refinementLoop(initialTrackedTokens, initialTrackedTokensUpperBound);
            var sol1count = counter;

            var t3 = DateTime.Now;

            var vp1 = new VariableSlicePass(refinementState.getVars(initialTrackedTokensUpperBound));
            var upperProg = vp1.run(program);

            var p = upperProg.getCBAProgram();
            if (p.Typecheck() != 0)
            {
                p.Emit(new TokenTextWriter("error.bpl"));
                throw new InternalError("Type errors");
            }

            HashSet<string> boolVars;
            var fabs = new FullVariableAbstraction(p, initialTrackedTokens, allTokens.Difference(initialTrackedTokensUpperBound), refinementState);
            var faProg = fabs.doTransformation(out boolVars);

            Debug.Assert(boolVars.Count > 0);

            var faProgProg = faProg.getProgram();

            var t = faProgProg.Typecheck();
            Debug.Assert(t == 0);

            boolVars = BoogieVerify.FindLeastToVerify(faProgProg, boolVars);
            Debug.Assert(boolVars.Count > 0);

            refinementState.trackedTokens.UnionWith(fabs.getTokens(boolVars));
            var sol3 = refinementState.trackedTokens;

            var t4 = DateTime.Now;

            var b1 = sol3.SetEquals(sol2);
            var b2 = sol3.SetEquals(sol1);
            var b3 = sol3.Count == sol2.Count;
            var b4 = sol3.Count == sol1.Count;

            Console.WriteLine();
            Console.WriteLine("RD: {0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {10}", remainingVars, sol3.Count - initSize, sol1count, sol2count, (t4 - t3).TotalSeconds.ToString("0.00"), (t3 - t2).TotalSeconds.ToString("0.00"), (t2 - t1).TotalSeconds.ToString("0.00"), b1, b2, b3, b4);
            Console.WriteLine();
            return;
        }

        // A hierarchical search over all the fields. At best, it can give an exponential saving. At worst, it will
        // require twice as many queries.
        // Input: 
        //   allVars: The set of all variables we're concerned with
        //   trackedVars: A subset of allVars. We already know that these must be tracked
        //   notTrackedVars: A subset of allVars, disjoint from trackedVars. We already know that these need not be tracked
        // Output:
        //   The new set of variables to track
        private HashSet<IRefinementToken> refinementLoop(HashSet<IRefinementToken> trackedVars, HashSet<IRefinementToken> trackedVarsUpperBound)
        {
            Debug.Assert(trackedVarsUpperBound.Contains(trackedVars));

            // If we already know the fate of all vars, then we're done.
            if (trackedVars.Count == trackedVarsUpperBound.Count)
                return new HashSet<IRefinementToken>(trackedVars);

            // See if we already have enough variables tracked
            var success = refinementLoopCheckPath(trackedVars);
            if (success)
            {
                // We have enough
                return new HashSet<IRefinementToken>(trackedVars);
            }

            // If all that remains is 1 variable, then we know that we must track it
            if (trackedVars.Count + 1 == trackedVarsUpperBound.Count)
                return new HashSet<IRefinementToken>(trackedVarsUpperBound);

            // Partition the remaining set of variables
            HashSet<IRefinementToken> part1, part2;
            trackedVarsUpperBound.Difference(trackedVars).Partition(out part1, out part2);

            // First half
            var s1 = refinementLoop(trackedVars.Union(part2), trackedVarsUpperBound);
            var a = part1.Intersection(s1);
            var b = part1.Difference(s1);

            // Second half
            return refinementLoop(trackedVars.Union(a), trackedVarsUpperBound.Difference(b));
        }

        static int counter = 0;

        protected virtual bool refinementLoopCheckPath(HashSet<IRefinementToken> trackedVars)
        {
            counter++;
            return verifier.checkPath(program, refinementState.getVars(trackedVars));
        }
    }

    // An empty interface. Used to mark an opaque refinement token
    public interface IRefinementToken
    {
    }

    // The current refinement state of Corral.
    // It consists of a set of tokens. Each token represents a set of (variable,procedure) pairs.
    public class RefinementState
    {
        // The set of all tokens
        public HashSet<IRefinementToken> allTokens;
        // The current set of tracked tokens
        public HashSet<IRefinementToken> trackedTokens;
        // A list of variable and procedure mappings that have been carried out by corral
        protected List<VarProcMapping> mappings;
        // Allows for backtracking using Push and Pop
        protected List<int> numMappingsAdded;
        // The initial mapping from tokens to VarSet
        protected Dictionary<IRefinementToken, VarSet> initialMap;
        // Time taken inside this class
        public TimeSpan timeSpent;

        // Cache. Unused -- TODO: use it for efficiency!
        private Dictionary<IRefinementToken, VarSet> tokenCache;

        // Just a wrapper for an int
        protected class RefinementToken : IRefinementToken
        {
            public int id;

            public RefinementToken(int id)
            {
                this.id = id;
            }

            public override string ToString()
            {
                return id.ToString();
            }

            public override bool Equals(object obj)
            {
                var that = obj as RefinementToken;
                Debug.Assert(that != null);
                return id == that.id;
            }

            public override int GetHashCode()
            {
                return id.GetHashCode();
            }
        }

        // Input:
        //   allVars: allVars of the original concurrent program
        //   trackedVars: The set of variables to be tracked initially (as specified by the user)
        //   useLocalAbs: Use local variable abstraction (or global)
        public RefinementState(VarSet allVars, HashSet<string> trackedVars, bool useLocalAbstraction)
        {
            allTokens = new HashSet<IRefinementToken>();
            trackedTokens = new HashSet<IRefinementToken>();
            mappings = new List<VarProcMapping>();
            numMappingsAdded = new List<int>();
            numMappingsAdded.Add(0);

            tokenCache = new Dictionary<IRefinementToken, VarSet>();
            initialMap = new Dictionary<IRefinementToken, VarSet>();

            if (useLocalAbstraction)
            {
                // For local abstraction, we have one token per (var,proc) pair
                int cnt = 0;
                foreach (var vp in allVars)
                {
                    cnt++;
                    var token = new RefinementToken(cnt);
                    var tokenVars = new VarSet(vp.fst, vp.snd);
                    initialMap.Add(token, tokenVars);
                    allTokens.Add(token);
                    if (trackedVars.Contains(vp.fst))
                    {
                        trackedTokens.Add(token);
                    }
                }
            }
            else
            {
                // For Global abstraction, we have one token per variable
                var globals = allVars.Variables;
                var globalToToken = new Dictionary<string, IRefinementToken>();
                int cnt = 0;
                foreach (var g in globals)
                {
                    cnt++;
                    var token = new RefinementToken(cnt);
                    globalToToken.Add(g, token);
                    initialMap.Add(token, new VarSet());
                    allTokens.Add(token);
                }
                
                foreach (var vp in allVars)
                {
                    var token = globalToToken[vp.fst];
                    initialMap[token].Add(vp);

                    if (trackedVars.Contains(vp.fst))
                    {
                        trackedTokens.Add(token);
                    }
                }
            }
        }

        public RefinementState(Program program, HashSet<string> trackedVars, bool useLocalAbstraction)
            : this(VarSet.GetAllVars(program), trackedVars, useLocalAbstraction) { }

        public RefinementState(PersistentCBAProgram program, HashSet<string> trackedVars, bool useLocalAbstraction)
            : this(program.allVars, trackedVars, useLocalAbstraction) { }

        public virtual void trackVar(string v)
        {
            foreach (var vp in initialMap)
            {
                var token = vp.Key;

                if (vp.Value.Variables.Contains(v))
                {
                    trackedTokens.Add(token);
                }
            }
        }

        public virtual void debugPrint(string fname)
        {
            var file = new System.IO.StreamWriter(fname);

            foreach (var token in allTokens)
            {
                file.WriteLine("Token {0}", token.ToString());
                file.WriteLine("{0}", getOnlyMappedVars(token).Variables.Print());
                file.WriteLine("{0}", getOnlyMappedVars(token).ToString());
            }

            file.WriteLine("Default");
            var d = new VarSet();
            foreach (var m in mappings)
            {
                d = m.map(d);
                d.Add(m.defaultSet());
            }
            
            file.WriteLine("{0}", d.Variables.Print());
            file.WriteLine("{0}", d.ToString());

            file.Close();
        }

        // Get the set of (var,proc) pairs represented by the current set of tracked tokens
        public virtual VarSet getVars()
        {
            return getVars(trackedTokens);
        }

        // Get the set of (var,proc) pairs represented by the given set of tokens
        public virtual VarSet getVars(HashSet<IRefinementToken> tokens)
        {
            var start = DateTime.Now;
            var ret = new VarSet();
            foreach (var t in tokens)
            {
                ret.Add(initialMap[t]);
            }

            // Now, go through the maps
            foreach (var m in mappings)
            {
                ret = m.map(ret);
                ret.Add(m.defaultSet());
            }
            timeSpent += (DateTime.Now - start);
            return ret;
        }

        // Get the set of (var,proc) pairs that correspond to token. 
        // Do not include the default set
        public virtual VarSet getOnlyMappedVars(IRefinementToken token)
        {
            var ret = new VarSet();
            ret.Add(initialMap[token]);

            // Now, go through the maps
            foreach (var m in mappings)
            {
                ret = m.map(ret);
            }
            return ret;
        }

        // Create a backtracking point
        public void Push()
        {
            numMappingsAdded.Add(0);
        }
        
        // Add a variable/procedure mapping
        public void Add(VarProcMapping m)
        {
            mappings.Add(m);
            numMappingsAdded[numMappingsAdded.Count - 1]++;
        }

        // Backtrack to the last Push
        public void Pop()
        {
            Debug.Assert(numMappingsAdded.Count > 1);
            var n = numMappingsAdded.Last();
            for (int i = 0; i < n; i++)
            {
                mappings.RemoveAt(mappings.Count - 1);
            }
            numMappingsAdded.RemoveAt(numMappingsAdded.Count - 1);
        }

        // Get the set of tokens that map to something in relevantVars
        public virtual HashSet<IRefinementToken> getRelevantTokens(HashSet<string> relevantVars)
        {
            var start = DateTime.Now;
            var ret = new HashSet<IRefinementToken>();
            foreach (var t in allTokens)
            {
                var ent = initialMap[t];

                foreach (var m in mappings)
                {
                    ent = m.map(ent);
                }

                if (ent.Variables.Intersection(relevantVars).Count != 0)
                {
                    ret.Add(t);
                }
            }
            timeSpent += (DateTime.Now - start);
            return ret;
        }
    }

    // The current refinement state of Corral. 
    // This is a simpler version of RefinementState
    public class GlobalRefinementState : RefinementState
    {
        private Dictionary<string, HashSet<string>> varToProcs;

        // Input:
        //   allVars: allVars of the original concurrent program
        //   trackedVars: The set of variables to be tracked initially (as specified by the user)
        public GlobalRefinementState(VarSet allVars, HashSet<string> trackedVars)
            : base(allVars, trackedVars, false)
        {
            varToProcs = null;

            // Filter out proc names from initial map
            foreach (var t in allTokens)
            {
                initialMap[t] = new VarSet(initialMap[t].Variables, "");
            }
        }

        public GlobalRefinementState(PersistentCBAProgram program, HashSet<string> trackedVars)
            : this(program.allVars, trackedVars) { }

        public GlobalRefinementState(Program program, HashSet<string> trackedVars)
            : this(VarSet.GetAllVars(program), trackedVars) { }

        public void setAllVars(VarSet av)
        {
            Debug.Assert(av != null);
            varToProcs = new Dictionary<string,HashSet<string>>();
            foreach (var v in av.Variables)
            {
                varToProcs.Add(v, new HashSet<string>());
            }

            foreach (var vp in av)
            {
                varToProcs[vp.fst].Add(vp.snd);
            }
        }

        // Get the set of (var,proc) pairs represented by the given set of tokens
        public override  VarSet getVars(HashSet<IRefinementToken> tokens)
        {
            Debug.Assert(varToProcs != null);

            var vars = base.getVars(tokens);

            return addAllProcs(vars);
        }

        // Get the set of (var,proc) pairs that correspond to token. 
        // Do not include the default set
        public override VarSet getOnlyMappedVars(IRefinementToken token)
        {
            Debug.Assert(varToProcs != null);

            var vars = base.getOnlyMappedVars(token);

            return addAllProcs(vars);
        }

        private VarSet addAllProcs(VarSet vars)
        {
            var ret = new VarSet();
            foreach (var vp in vars)
            {
                Debug.Assert(vp.snd == "");
                if (varToProcs.ContainsKey(vp.fst))
                {
                    ret.Add(new VarSet(vp.fst, varToProcs[vp.fst]));
                }
            }
            return ret;
        }
        
        public override void debugPrint(string fname)
        {
            var file = new System.IO.StreamWriter(fname);

            foreach (var token in allTokens)
            {
                file.WriteLine("Token {0}", token.ToString());
                file.WriteLine("{0}", getOnlyMappedVars(token).Variables.Print());
                file.WriteLine("{0}", getOnlyMappedVars(token).ToString());

            }

            file.WriteLine("Default");
            var d = new VarSet();
            foreach (var m in mappings)
            {
                d = m.map(d);
                d.Add(m.defaultSet());
            }
            d = addAllProcs(d);

            file.WriteLine("{0}", d.Variables.Print());
            file.WriteLine("{0}", d.ToString());

            file.Close();
        }
        
    }

    public class FullVariableAbstraction
    {
        RefinementState refinementState;
        HashSet<IRefinementToken> tracked;
        HashSet<IRefinementToken> dontTrack;
        HashSet<IRefinementToken> tokens;
        CBAProgram program;
        Dictionary<IRefinementToken, Variable> tokenVarMap;
        Dictionary<string, IRefinementToken> invTokenVarMap;
        Dictionary<Duple<string, string>, IRefinementToken> varTokenMap;
        HashSet<string> varsToInstrument;
        List<Variable> localVarsToAdd;

        public FullVariableAbstraction(CBAProgram program, HashSet<IRefinementToken> tracked,
            HashSet<IRefinementToken> dontTrack, RefinementState refinementState)
        {
            this.program = program;
            this.tracked = tracked;
            this.dontTrack = dontTrack;
            this.refinementState = refinementState;
            tokenVarMap = new Dictionary<IRefinementToken, Variable>();
            invTokenVarMap = new Dictionary<string, IRefinementToken>();

            this.tokens = refinementState.allTokens.Difference(tracked).Difference(dontTrack);
            this.varsToInstrument = new HashSet<string>();
            
            int cnt = 0;
            foreach (var token in tokens)
            {
                cnt++;
                var name = "corral_full_abs_var_" + cnt.ToString();
                tokenVarMap.Add(token, new Constant(Token.NoToken, new TypedIdent(Token.NoToken, name, Microsoft.Boogie.Type.Bool), false));
                invTokenVarMap.Add(name, token);
            }
            //Console.WriteLine("Tokens: {0}", tokens.Count);

            varTokenMap = new Dictionary<Duple<string, string>, IRefinementToken>();
            foreach (var token in tokens)
            {
                var vars = refinementState.getOnlyMappedVars(token);
                foreach (var v in vars)
                {
                    varsToInstrument.Add(v.fst);

                    if (varTokenMap.ContainsKey(v))
                    {
                        Debug.Assert(varTokenMap[v] == token);
                    }
                    varTokenMap.Add(v, token);
                }
            }
        }

        public PersistentProgram doTransformation(out HashSet<string> boolVars)
        {
            var impls = new HashSet<string>();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impls.Add(impl.Name);
                localVarsToAdd = new List<Variable>();
                doTransformation(impl);
                impl.LocVars.AddRange(localVarsToAdd);
            }
            
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
                doTransformation(proc, impls.Contains(proc.Name));

            program.AddTopLevelDeclarations(tokenVarMap.Values);

            boolVars = new HashSet<string>();
            foreach (var t in tokenVarMap.Values)
            {
                boolVars.Add(t.Name);
            }

            //addFakeMain(program, BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName));

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(pruneFalseBlocks);

            return new PersistentProgram(program);
        }

        void pruneFalseBlocks(Implementation impl)
        {
            // Gather list of blocks with "assume false" as the first statement
            var blocks = impl.Blocks
                .Where(blk => blk != impl.Blocks[0] && blk.Cmds.Count > 0 && BoogieUtil.isAssumeFalse(blk.Cmds[0]));

            var toPrune = new HashSet<string>();
            blocks.Iter(blk => toPrune.Add(blk.Label));

            // Prune
            var newBlocks = new List<Block>();
            impl.Blocks
                .Filter(blk => !toPrune.Contains(blk.Label))
                .Iter(blk => newBlocks.Add(blk));

            Debug.Assert(newBlocks[0] == impl.Blocks[0]);

            impl.Blocks = newBlocks;

            // Change goto commands
            foreach (var blk in impl.Blocks.Filter(blk => blk.TransferCmd is GotoCmd))
            {
                var gc = blk.TransferCmd as GotoCmd;
                var ss = new List<String>();

                gc.labelNames
                    .OfType<string>()
                    .Where(l => !toPrune.Contains(l))
                    .Iter(l => ss.Add(l));

                gc.labelNames = ss;
            }


        }

        public void FreeMemory()
        {
            program = null;
        }

        public HashSet<IRefinementToken> getTokens(HashSet<string> boolVars)
        {
            var ret = new HashSet<IRefinementToken>();
            foreach (var s in boolVars)
            {
                ret.Add(invTokenVarMap[s]);
            }
            return ret;
        }

        // Adds a fake main that has the assertion and calls the real main.
        // This is to make "main" small.
        private static Implementation addFakeMain(Program program, Implementation oldMainImpl)
        {
            var oldMainProc = oldMainImpl.Proc;

            // Create new global variable "assertVar"
            var assertVar = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "BU_assertVar", Microsoft.Boogie.Type.Bool));

            // Modify asserts in old Main. We only modify when all asserts are of
            // the form "assert ...; return"
            var blocksWithAsserts = new List<Block>();
            foreach (var blk in oldMainImpl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++)
                {
                    if (blk.Cmds[i] is AssertCmd)
                    {
                        if (i != blk.Cmds.Count - 1 || !(blk.TransferCmd is ReturnCmd))
                            return oldMainImpl;
                        blocksWithAsserts.Add(blk);
                    }
                }
            }
            Debug.Assert(blocksWithAsserts.Count != 0);

            // We can do instrumentation
            foreach (var blk in blocksWithAsserts)
            {
                var acmd = blk.Cmds[blk.Cmds.Count - 1] as AssertCmd;
                blk.Cmds[blk.Cmds.Count - 1] = BoogieAstFactory.MkVarEqExpr(assertVar, acmd.Expr);
            }

            // remove "entrypoint" from old main
            oldMainImpl.Attributes = BoogieUtil.removeAttr("entrypoint", oldMainImpl.Attributes);
            oldMainProc.Modifies.Add(new IdentifierExpr(Token.NoToken, assertVar));

            // Create new main procedure
            var newMainProc = new Procedure(Token.NoToken, "fakeMain", oldMainProc.TypeParameters,
                oldMainProc.InParams, oldMainProc.OutParams, oldMainProc.Requires,
                oldMainProc.Modifies, oldMainProc.Ensures);

            var newMainImpl = new Implementation(Token.NoToken, "fakeMain", oldMainImpl.TypeParameters,
                oldMainImpl.InParams, oldMainImpl.OutParams, new List<Variable>(), new List<Block>());

            newMainImpl.AddAttribute("entrypoint");

            // assertVar := true;
            // call old_main
            // assert assertVar;
            var ins = new List<Expr>();
            var outs = new List<IdentifierExpr>();
            foreach (Variable v in oldMainImpl.InParams)
            {
                ins.Add(Expr.Ident(v));
            }
            foreach (Variable v in oldMainImpl.OutParams)
            {
                outs.Add(Expr.Ident(v));
            }

            var cmd = new CallCmd(Token.NoToken, oldMainProc.Name, ins, outs);
            cmd.Proc = oldMainProc;

            var cmds = new List<Cmd>();
            cmds.Add(BoogieAstFactory.MkVarEqConst(assertVar, true));
            cmds.Add(cmd);
            cmds.Add(new AssertCmd(Token.NoToken, Expr.Ident(assertVar)));

            var ablk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
            newMainImpl.Blocks.Add(ablk);

            newMainImpl.Proc = newMainProc;

            program.AddTopLevelDeclaration(newMainProc);
            program.AddTopLevelDeclaration(newMainImpl);
            program.AddTopLevelDeclaration(assertVar);

            return newMainImpl;
        }

        // Process free requires and ensures:
        //    replace "free requires e" with "free requires tracked ==> e"
        //    same for ensures
        private void doTransformation(Procedure proc, bool hasImpl)
        {
            foreach (Requires req in proc.Requires)
            {
                var varsUsed = new VarsUsed();
                varsUsed.Visit(req.Condition);
                if (varsUsed.globalsUsed.Intersection(varsToInstrument).Count == 0)
                    continue;
                Debug.Assert(req.Free);
                var expr = getAllTrackedExpr(varsUsed.globalsUsed, proc.Name);
                req.Condition = Expr.Imp(expr, req.Condition);
            }
            foreach (Ensures ens in proc.Ensures)
            {
                var varsUsed = new VarsUsed();
                varsUsed.Visit(ens.Condition);
                if (varsUsed.globalsUsed.Intersection(varsToInstrument).Count == 0)
                    continue;
                Debug.Assert(!hasImpl || ens.Free);
                var expr = getAllTrackedExpr(varsUsed.globalsUsed, proc.Name);
                ens.Condition = Expr.Imp(expr, ens.Condition);
            }

        }

        // Convert assertions to talk only about local variables
        private void assertLocals(Implementation impl)
        {
            int ticker = 0;
            var GetLocal = new Func<Variable>(() =>
                BoogieAstFactory.MkLocal("FVA_assert_local_" + (ticker++), Microsoft.Boogie.Type.Bool));

            foreach (var block in impl.Blocks)
            {
                var ncmds = new List<Cmd>();
                foreach (var cmd in block.Cmds)
                {
                    var acmd = cmd as AssertCmd;
                    if (acmd == null)
                    {
                        ncmds.Add(cmd);
                        continue;
                    }
                    var vu = new VarsUsed();
                    vu.Visit(acmd);
                    if (vu.globalsUsed.Count == 0)
                    {
                        ncmds.Add(cmd);
                        continue;
                    }
                    var loc = GetLocal();
                    impl.LocVars.Add(loc);
                    // loc := expr
                    ncmds.Add(
                        BoogieAstFactory.MkVarEqExpr(loc, acmd.Expr));
                    // assert loc;
                    ncmds.Add(
                        new AssertCmd(acmd.tok, Expr.Ident(loc), acmd.Attributes));
                }
                block.Cmds = ncmds;
            }
        }

        private void doTransformation(Implementation impl)
        {
            assertLocals(impl);

            var newBlocks = new List<Block>();
            foreach (var block in impl.Blocks)
            {
                var currCmds = new List<Cmd>();
                var currLabel = block.Label;

                foreach (Cmd cmd in block.Cmds)
                {
                    var varsUsed = new VarsUsed();
                    varsUsed.Visit(cmd);

                    if (varsUsed.globalsUsed.Intersection(varsToInstrument).Count == 0)
                    {
                        currCmds.Add(cmd);
                        continue;
                    }

                    if (cmd is CallCmd)
                    {
                        Debug.Assert(varsUsed.globalsUsed.Count == 0);
                        currCmds.Add(cmd);
                        continue;
                    }

                    if (cmd is HavocCmd)
                    {
                        currCmds.Add(cmd);
                        continue;
                    }

                    if (cmd is AssertCmd || cmd is AssumeCmd)
                    {
                        var label1 = getNewLabel();
                        var label2 = getNewLabel();
                        var endlabel = getNewLabel();

                        newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(label1, label2)));

                        var expr = getAllTrackedExpr(varsUsed.globalsUsed, impl.Name);

                        // block 1
                        currCmds = new List<Cmd>();
                        currLabel = label1;

                        currCmds.Add(new AssumeCmd(Token.NoToken, expr));
                        currCmds.Add(cmd);
                        newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endlabel)));

                        // block 2
                        currCmds = new List<Cmd>();
                        currLabel = label2;

                        currCmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(expr)));
                        if (cmd is AssertCmd)
                        {
                            currCmds.Add(new AssertCmd(Token.NoToken, Expr.False));
                        }
                        newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endlabel)));

                        currCmds = new List<Cmd>();
                        currLabel = endlabel;
                        continue;
                    }

                    if (cmd is AssignCmd)
                    {
                        AssignCmd acmd = (AssignCmd)cmd;

                        if(acmd.Lhss.Count != 1)
                            throw new InternalError("Cannot yet handle parallel assigns with count " + (acmd.Lhss.Count).ToString());

                        AssignLhs lhs = acmd.Lhss[0];
                        Expr rhs = acmd.Rhss[0];

                        var endLabel = getNewLabel();

                        var choice1 = getAllTrackedExpr(lhs.DeepAssignedVariable.Name, impl.Name);
                        addChoice1(ref newBlocks, choice1, ref currLabel, ref currCmds, endLabel);
                        if (lhs is MapAssignLhs)
                        {
                            varsUsed = new VarsUsed();
                            (lhs as MapAssignLhs).Indexes.Iter(e => varsUsed.Visit(e));
                            var choice2 = getAllTrackedExpr(varsUsed.globalsUsed, impl.Name);
                            addChoice2(ref newBlocks, acmd, choice2, ref currLabel, ref currCmds, endLabel);
                        }
                        varsUsed = new VarsUsed();
                        varsUsed.Visit(rhs);

                        var choice3 = getAllTrackedExpr(varsUsed.globalsUsed, impl.Name);
                        addChoice3(ref newBlocks, acmd, choice3, ref currLabel, ref currCmds, endLabel);

                        currLabel = endLabel;
                        currCmds = new List<Cmd>();

                        continue;
                    }

                    Debug.Assert(false);
                }
                newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, block.TransferCmd));
            }
            impl.Blocks = newBlocks;
        }

        private void addChoice1(ref List<Block> newBlocks, Expr choice, ref string currLabel, ref List<Cmd> currCmds, string endLabel)
        {
            if (choice == Expr.True) return;

            var label1 = getNewLabel();
            var label2 = getNewLabel();

            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(label1, label2)));

            currLabel = label1;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(choice)));
            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endLabel)));

            currLabel = label2;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, choice));
        }

        private void addChoice2(ref List<Block> newBlocks, AssignCmd cmd, Expr choice, ref string currLabel, ref List<Cmd> currCmds, string endLabel)
        {
            if (choice == Expr.True) return;

            var label1 = getNewLabel();
            var label2 = getNewLabel();

            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(label1, label2)));

            currLabel = label1;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(choice)));
            currCmds.Add(BoogieAstFactory.MkHavocVar(cmd.Lhss[0].DeepAssignedVariable));
            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endLabel)));

            currLabel = label2;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, choice));

        }

        private void addChoice3(ref List<Block> newBlocks, AssignCmd cmd, Expr choice, ref string currLabel, ref List<Cmd> currCmds, string endLabel)
        {
            var label1 = getNewLabel();
            var label2 = getNewLabel();
            AssignLhs lhs = cmd.Lhss[0];
            Expr rhs = cmd.Rhss[0];

            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(label1, label2)));

            currLabel = label1;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(choice)));
            if (lhs is SimpleAssignLhs)
            {
                currCmds.Add(BoogieAstFactory.MkHavocVar(lhs.DeepAssignedVariable));
            }
            else
            {
                // Get new local variable dummy
                LocalVariable dummy = getNewLocal(lhs.Type);

                // havoc dummy
                currCmds.Add(BoogieAstFactory.MkHavocVar(dummy));

                // lhs := dummy
                var tmp2 = new List<AssignLhs>();
                var tmp3 = new List<Expr>();
                tmp2.Add(lhs);
                tmp3.Add(Expr.Ident(dummy));
                currCmds.Add(new AssignCmd(Token.NoToken, tmp2, tmp3));
            }
            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endLabel)));

            currLabel = label2;
            currCmds = new List<Cmd>();

            currCmds.Add(new AssumeCmd(Token.NoToken, choice));
            currCmds.Add(cmd);
            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(endLabel)));
        }

        private static int localVarCount = 0;

        // Return a new local variable. Also add it to impl if it is not null
        private LocalVariable getNewLocal(Microsoft.Boogie.Type type)
        {
            string name = "full_slice_dummy_var_" + (localVarCount.ToString());
            TypedIdent tid = new TypedIdent(Token.NoToken, name, type);
            LocalVariable lv = new LocalVariable(Token.NoToken, tid);
            localVarsToAdd.Add(lv);
            localVarCount++;
            return lv;
        }

        private HashSet<IRefinementToken> getTokens(HashSet<string> vars, string proc)
        {
            var ret = new HashSet<IRefinementToken>();
            foreach (var v in vars)
            {
                var key = new Duple<string, string>(v, proc);
                if (varTokenMap.ContainsKey(key))
                {
                    ret.Add(varTokenMap[key]);
                }
            }
            return ret;
        }

        private Expr getAllTrackedExpr(string v, string proc)
        {
            var vs = new HashSet<string>();
            vs.Add(v);
            return getAllTrackedExpr(vs, proc);
        }

        private Expr getAllTrackedExpr(HashSet<string> vars, string proc)
        {
            Expr ret = Expr.True;
            var tokens = getTokens(vars, proc);
            if (tokens.Count == 0) return ret;
            foreach (var t in tokens)
            {
                ret = Expr.And(ret, Expr.Ident(tokenVarMap[t]));
            }

            return ret;
        }

        private static int labelCounter = 0;

        private string getNewLabel()
        {
            return "full_var_abs_label_" + (labelCounter++).ToString();
        }
    }

    // A general interface to Variable/Procedure Mapping
    public abstract class VarProcMapping
    {
        // What does a given (var,proc) pair map to?
        // (The return value can be an empty set)
        public abstract VarSet map(Duple<string, string> var);

        // The new (var,proc) pairs added by the mapping
        public virtual VarSet defaultSet()
        {
            return new VarSet();
        }

        public VarSet map(VarSet vars)
        {
            var ret = new VarSet();
            foreach (var v in vars)
            {
                ret.Add(map(v));
            }
            return ret;
        }
    }

    // The Variable/Procedure mapping carried out by the sequentialization transformation
    public class InstrMapping : VarProcMapping
    {
        // A map: [original program variable -> Set of instrumented program variables that it produced]
        Dictionary<string, HashSet<string>> varMapping;
        // The set of new variables added in the instrumented program
        protected HashSet<string> newVarsAdded;
        // The set of new procedures added in the instrumented program
        HashSet<string> newProcsAdded;
        // The set of all variables in the instrumented program
        HashSet<string> allVars;
        // The set of all procedures in the instrumented program
        HashSet<string> allProcs;
        // The set of (var,proc) pairs added in the instrumented program
        VarSet pairsAdded;
        // The set of (var,proc) pairs in the instrumented program
        VarSet allPairs;
        // Name of main (that has the Checker)
        string mainProcName;

        public InstrMapping(StormInstrumentationPass inst)
        {
            allVars = new HashSet<string>();
            allProcs = new HashSet<string>();
            newProcsAdded = new HashSet<string>();
            newVarsAdded = new HashSet<string>();
            varMapping = new Dictionary<string, HashSet<string>>();
            
            var instrumentedProg = inst.output.getProgram();
            var globals = BoogieUtil.GetGlobalVariables(instrumentedProg);
            var procs = BoogieUtil.GetProcedures(instrumentedProg);
            mainProcName = (inst.input as PersistentCBAProgram).mainProcName;

            globals.Iter(g => allVars.Add(g.Name));
            procs.Iter(p => allProcs.Add(p.Name));

            newProcsAdded = inst.getInstrumentedProcedures();

            var inpGlobals = BoogieUtil.GetGlobalVariables(inst.input.getProgram());
            newVarsAdded = new HashSet<string>(allVars);

            foreach (var g in inpGlobals)
            {
                var ig = inst.getInstrumentedVars(g.Name);
                varMapping.Add(g.Name, ig);
                newVarsAdded.ExceptWith(ig);
            }

            allPairs = VarSet.GetAllVars(instrumentedProg);
            var v1 = new VarSet(newVarsAdded, allProcs);
            var v2 = new VarSet(allVars, newProcsAdded);
            pairsAdded = v1.Union(v2).Intersection(allPairs);
        }

        // Map (x,p) to { (x__1, p), (x__2, p), ..., (x_K, p) }
        public override VarSet map(Duple<string, string> v)
        {
            Debug.Assert(varMapping.ContainsKey(v.fst));
            var v1 = new VarSet(varMapping[v.fst], v.snd);
            // include main because it has the checker instrumentation
            var v2 = new VarSet(varMapping[v.fst], mainProcName);
            return v1.Union(v2);
        }

        // Returns: ((NewVars x AllProcs) U (AllVars x NewProcs)) 
        //          Intersect (AllVarProc that occur in the program)
        public override VarSet defaultSet()
        {
            return pairsAdded;
        }
    }

    // The Variable/Procedure mapping carried out when a program is restricted to a trace.
    // Procedures get renamed to possibly multiple (0 or many) procedures.
    public class TraceMapping : VarProcMapping
    {
        // Map from destination procedure name to original procedure name
        Dictionary<string, string> procMap;
        // The inverse of the above map
        Dictionary<string, HashSet<string>> invProcMap;

        public TraceMapping(InsertionTrans tinfo)
        {
            this.procMap = tinfo.procNameMap;
            this.invProcMap = tinfo.invProcNameMap;
        }

        public TraceMapping(Dictionary<string, string> procMap)
        {
            this.procMap = procMap;
            invProcMap = new Dictionary<string, HashSet<string>>();
            foreach (var kvp in procMap)
            {
                if (!invProcMap.ContainsKey(kvp.Value))
                {
                    invProcMap.Add(kvp.Value, new HashSet<string>());
                }
                invProcMap[kvp.Value].Add(kvp.Key);
            }
        }
        // Map the procedure to its new incarnations (if any)
        public override VarSet map(Duple<string, string> var)
        {
            if (invProcMap.ContainsKey(var.snd))
            {
                return new VarSet(var.fst, invProcMap[var.snd]);
            }
            else
            {
                return new VarSet();
            }
        }

    }

    // The Variable/Procedure mapping in which variables are added
    public class AddVarMapping : VarProcMapping
    {
        VarSet varsAdded;

        public AddVarMapping(VarSet varsAdded)
        {
            this.varsAdded = varsAdded;
        }

        // Map the procedure to its new incarnations (if any)
        public override VarSet map(Duple<string, string> var)
        {
            return new VarSet(var.fst, var.snd);
        }

        public override VarSet defaultSet()
        {
            return varsAdded;
        }

    }

    
    // The Variable/Procedure mapping carried out by inlining.
    // Multiple procedures (namely those that get inlined) get merged into the same procedure.
    // Some variables (unused ones) also get deleted.
    // Note: this is unsafe to use with Local Variable Abstraction -- because a mapping
    // that merges procedures cannot really be supported. The reason is that each refinement
    // token must map to a disjoint set of (var,proc) pairs
    public class InliningMapping : VarProcMapping
    {
        HashSet<string> procsMerged;
        string mainProcName;
        HashSet<string> varsDeleted;

        public InliningMapping(StaticInliningAndUnrollingPass cp)
        {
            Debug.Assert(cp.settings.numLoopUnrolls == -1);
            Debug.Assert(cp.settings.staticInlining == 1);

            var inProg = cp.input.getProgram();

            mainProcName = (cp.input as PersistentCBAProgram).mainProcName;
            var procs = BoogieUtil.GetProcedures(inProg);

            // Get hold of all procedures that were inlined
            procsMerged = new HashSet<string>();
            foreach (var p in procs)
            {
                if (QKeyValue.FindIntAttribute(p.Attributes, "inline", -1) != -1)
                {
                    procsMerged.Add(p.Name);
                }
            }

            // Get hold of variables that were deleted
            var outProg = cp.output.getProgram();
            var inGlobals = new HashSet<string>();
            BoogieUtil.GetGlobalVariables(inProg).Iter(g => inGlobals.Add(g.Name));
            var outGlobals = new HashSet<string>();
            BoogieUtil.GetGlobalVariables(outProg).Iter(g => outGlobals.Add(g.Name));
            varsDeleted = inGlobals.Difference(outGlobals);
           
        }

        public override VarSet map(Duple<string, string> var)
        {
            if (varsDeleted.Contains(var.fst))
            {
                return new VarSet();
            }

            if (procsMerged.Contains(var.snd))
            {
                return new VarSet(var.fst, mainProcName);
            }
            return new VarSet(var.fst, var.snd);
        }
    }
    
}
