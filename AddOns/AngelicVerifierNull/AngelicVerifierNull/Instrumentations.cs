using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using CBAProgram = cba.CBAProgram;
using AvUtil;

namespace AngelicVerifierNull
{

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    public class Instrumentations
    {
        public class MallocInstrumentation
        {
            Program prog;

            public const string mallocTriggerFuncName = "unknownTrigger_";
            // allocator_call -> trigger function
            public Dictionary<int, string> mallocTriggersLocation; //don't keep any objects (e.g. Function) since program changes
            public Dictionary<string, int> mallocTriggerToAllocationSite; //don't keep any objects (e.g. Function) since program changes
            int id;

            public MallocInstrumentation(Program program)
            {
                prog = program;
                id = 0;
            }
            public void DoInstrument()
            {
                var mi = new MallocInstrumentVisitor(this)
                    .Visit(prog);                
            }

            private class MallocInstrumentVisitor : StandardVisitor
            {
                public Block currBlock = null;
                public Implementation currImpl = null;
                MallocInstrumentation instance;
                public Dictionary<CallCmd, Function> mallocTriggers;
                public MallocInstrumentVisitor(MallocInstrumentation mi)
                {
                    instance = mi;
                    mallocTriggers = new Dictionary<CallCmd, Function>();
                    instance.mallocTriggersLocation = new Dictionary<int, string>();
                    instance.mallocTriggerToAllocationSite = new Dictionary<string, int>();
                }
                public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
                {
                    int callCmdCount = -1; 
                    var newCmdSeq = new List<Cmd>();
                    foreach (Cmd c in cmdSeq)
                    {
                        newCmdSeq.Add(c);
                        var callCmd = c as CallCmd;
                        if (callCmd != null) callCmdCount++;
                        if (callCmd != null && BoogieUtil.checkAttrExists(AvnAnnotations.AngelicUnknownCall, callCmd.Proc.Attributes))
                        {
                            var retCall = callCmd.Outs[0];
                            btype retType = callCmd.Proc.OutParams[0].TypedIdent.Type;
                            if (retType == null) retType = btype.Int;
                            var mallocTriggerFn = new Function(Token.NoToken, mallocTriggerFuncName + mallocTriggers.Count,
                                new List<Variable>() { BoogieAstFactory.MkFormal("a", retType, false) },
                                BoogieAstFactory.MkFormal("r", btype.Bool, false));
                            mallocTriggers[callCmd] = mallocTriggerFn;
                            var callId = QKeyValue.FindIntAttribute(callCmd.Attributes, cba.RestrictToTrace.ConcretizeCallIdAttr, -1);
                            Debug.Assert(callId == -1, "Calls to unknown must not already be tagged with an ID");

                            callId = instance.id++;
                            callCmd.Attributes = new QKeyValue(Token.NoToken, cba.RestrictToTrace.ConcretizeCallIdAttr, new List<object> { Expr.Literal(callId) }, callCmd.Attributes);

                            instance.mallocTriggersLocation[callId] = mallocTriggerFn.Name;
                            instance.mallocTriggerToAllocationSite[mallocTriggerFn.Name] = callId;
                            instance.prog.AddTopLevelDeclaration(mallocTriggerFn);
                            var fnApp = new NAryExpr(Token.NoToken,
                                new FunctionCall(mallocTriggerFn),
                                new List<Expr> () {retCall});
                            newCmdSeq.Add(BoogieAstFactory.MkAssume(fnApp)); 
                        }
                    }
                    return base.VisitCmdSeq(newCmdSeq);
                }
                public override Block VisitBlock(Block node)
                {
                    currBlock = node;    
                    return base.VisitBlock(node);
                }
                public override Implementation VisitImplementation(Implementation node)
                {
                    currImpl = node;
                    return base.VisitImplementation(node);
                }
            }
        }

        /// <summary>
        /// Useful for rewriting an expr (with only constants) from one PersistentProgram to another
        /// TODO: Is there a cleaner way to achieve this?
        /// </summary>
        public class RewriteConstants : StandardVisitor
        {
            Dictionary<string,Variable> newConstantsMap;
            public RewriteConstants(HashSet<Variable> newConstants)
            {
                this.newConstantsMap = new Dictionary<string, Variable>();
                newConstants.Iter(x => this.newConstantsMap[x.Name] = x);
            }
            public override Variable VisitVariable(Variable node)
            {
                if (newConstantsMap.ContainsKey(node.Name))
                    return base.VisitVariable(newConstantsMap[node.Name]);
                else
                {
                    Utils.Print("WARNING!!: Cannot find constant " + node.Name + " in the set of constants");
                    return base.VisitVariable(node);
                }
            }
        }
    }

    // Tokens represent assertions
    class AssertToken
    {
        public int id {get; private set;}
        static int idCounter = 0;
        public AssertToken(int id)
        {
            this.id = id;
        }
        internal static AssertToken GetNextToken()
        {
            return new AssertToken(idCounter++);
        }
        public override bool Equals(object obj)
        {
            return (obj as AssertToken).id == id;
        }
        public override int GetHashCode()
        {
            return id.GetHashCode();
        }
    }

    /* Initial instrumentation done before running corral.
     * It gets rid of source line annotation and print commands (because
     * there are too many of them).
     * It also instruments assertions.
     */
    class AvnInstrumentation : cba.CompilerPass
    {
        // Information for mapping back traces
        cba.ModifyTrans sourceInfo;
        cba.CompressBlocks compressBlocks;
        cba.InsertionTrans assertInstrInfo;
        cba.InsertionTrans blanksInfo;
        cba.DeepAssertRewrite da;
        List<cba.InsertionTrans> suppressInfo;

        // List of stubs
        HashSet<string> programStubs;

        // Token -> assertion representing that token
        Dictionary<AssertToken, AssertCmd> originalAssertions;

        // Token -> (procedure,block) where the assertion came from
        Dictionary<AssertToken, Tuple<string, string>> tokenLocation;

        // procedure -> its set of tokens
        Dictionary<string, HashSet<AssertToken>> procToTokens;

        // tokens suppressed so far; this only monotonically grows
        HashSet<AssertToken> suppressedTokens;
        // temporarily suppress tokens
        HashSet<AssertToken> tempSuppressedTokens;

        // The program that is constantly updated with blocked assertions
        // or input constraints.
        Program currProg;

        // Name of the harness procedure
        string origMainName;

        // Assertion instrumentation
        public readonly string assertsPassedName = "assertsPassed";
        GlobalVariable assertsPassed;

        // Ebasic assumptions
        public HashSet<string> procsWithEnvAssumptions { get; private set; }


        public AvnInstrumentation(HashSet<string> programStubs)
        {
            passName = "SequentialInstrumentation"; 
            assertInstrInfo = new cba.InsertionTrans();
            blanksInfo = new cba.InsertionTrans();
            assertsPassed = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "assertsPassed", Microsoft.Boogie.Type.Bool));
            compressBlocks = new cba.CompressBlocks();
            originalAssertions = new Dictionary<AssertToken, AssertCmd>();
            tokenLocation = new Dictionary<AssertToken, Tuple<string, string>>();
            procToTokens = new Dictionary<string, HashSet<AssertToken>>();
            suppressedTokens = new HashSet<AssertToken>();
            tempSuppressedTokens = new HashSet<AssertToken>();
            currProg = null;
            this.programStubs = programStubs;
            origMainName = null;
            procsWithEnvAssumptions = new HashSet<string>();
            suppressInfo = new List<cba.InsertionTrans>();
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Add blanks
            blanksInfo = AddBlanks(program);

            // Remove unreachable procedures
            BoogieUtil.pruneProcs(program, program.mainProcName);

            if (!Options.TraceSlicing)
            {
                // Remove source line annotations
                sourceInfo = cba.PrintSdvPath.DeleteSourceInfo(program);
            }
            else
            {
                sourceInfo = null;
            }

            // Remove print info
            //printInfo = cba.PrintSdvPath.DeletePrintCmds(program);

            // Compress
            compressBlocks.VisitProgram(program);

            // name Ebasic
            NameEnvironmentConstraints(program);

            // Instrument assertions
            int tokenId = 0;

            origMainName = program.mainProcName;

            CBAProgram ret = null;

            if (!Options.DeepAsserts)
            {
                // Do error-bit instrumentation
                var impls = BoogieUtil.nameImplMapping(program);
                var pwa = cba.SequentialInstrumentation.procsWithAsserts(program);

                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    var instrumented = new List<Block>();
                    foreach (var blk in impl.Blocks)
                    {
                        var currCmds = new List<Cmd>();
                        var currLabel = blk.Label;

                        assertInstrInfo.addTrans(impl.Name, blk.Label, blk.Label);
                        var incnt = -1;
                        foreach (Cmd cmd in blk.Cmds)
                        {
                            incnt++;

                            // instrument assert
                            if (cmd is AssertCmd && !BoogieUtil.isAssertTrue(cmd))
                            {
                                currCmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, (cmd as AssertCmd).Expr));

                                var token = new AssertToken(tokenId);
                                originalAssertions.Add(token, cmd as AssertCmd);
                                tokenLocation.Add(token, Tuple.Create(impl.Name, currLabel));
                                procToTokens.InitAndAdd(impl.Name, token);

                                addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                                currLabel = addInstr(instrumented, currCmds, currLabel, tokenId);
                                tokenId++;
                                currCmds = new List<Cmd>();

                                continue;
                            }

                            // procedure call 
                            if (cmd is CallCmd && pwa.Contains((cmd as CallCmd).callee))
                            {
                                currCmds.Add(cmd);
                                addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);
                                currLabel = addInstr(instrumented, currCmds, currLabel, -1);
                                currCmds = new List<Cmd>();
                                continue;
                            }

                            currCmds.Add(cmd);
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                        }

                        instrumented.Add(new Block(Token.NoToken, currLabel, currCmds, blk.TransferCmd));

                    }

                    impl.Blocks = instrumented;
                }

                program.AddTopLevelDeclaration(assertsPassed);
                var newMain = addMain(program);

                BoogieUtil.DoModSetAnalysis(program);

                // Set inline attribute
                // free requires assertsPassed == true;
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    impl.Proc.Requires.Add(new Requires(true, Expr.Ident(assertsPassed)));
                }

                // convert free ensures e to:
                //  free ensures assertsPassed == false || e
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>()
                    .Where(impl => pwa.Contains(impl.Name)))
                {
                    foreach (Ensures ens in impl.Proc.Ensures)
                        ens.Condition = Expr.Or(Expr.Not(Expr.Ident(assertsPassed)), ens.Condition);
                }

                currProg = program;
                ret = new CBAProgram(program, newMain, 0);
            }
            else
            {
                // Use Deep-assert instrumentation
                da = new cba.DeepAssertRewrite();

                // First, tag assertions with tokens
                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    foreach (var blk in impl.Blocks)
                    {
                        foreach (var cmd in blk.Cmds.OfType<AssertCmd>())
                        {
                            if (BoogieUtil.isAssertTrue(cmd)) continue;

                            var token = new AssertToken(tokenId);
                            cmd.Attributes = new QKeyValue(Token.NoToken, "avn", new List<object> { Expr.Literal(tokenId) },
                                cmd.Attributes);
                            originalAssertions.Add(token, cmd);
                            tokenLocation.Add(token, Tuple.Create(impl.Name, blk.Label));
                            procToTokens.InitAndAdd(impl.Name, token);
                            tokenId++;
                        }
                    }
                }

                // Second, do the rewrite
                var t1 = new PersistentProgram(program, program.mainProcName, program.contextBound);
                var t2 = da.run(t1);
                var daprog = t2.getCBAProgram();

                // Third, revisit the assertions and remember their location
                // in the output program. This is a bit of a hack. The "tokenLocation"
                // of a token is the pair (p1,b1) where p1 is the procedure the assertion
                // originally came from and b1 is the block in the new main that contains
                // that assertion.
                var main = BoogieUtil.findProcedureImpl(daprog.TopLevelDeclarations, daprog.mainProcName);
                foreach (var block in main.Blocks)
                {
                    foreach (var cmd in block.Cmds.OfType<AssertCmd>())
                    {
                        var tok = QKeyValue.FindIntAttribute(cmd.Attributes, "avn", -1);
                        if (tok < 0) continue;
                        var token = new AssertToken(tok);

                        Debug.Assert(tokenLocation.ContainsKey(token));
                        var oldloc = tokenLocation[token];
                        tokenLocation[token] = Tuple.Create(oldloc.Item1, block.Label);
                    }

                }

                currProg = daprog;
                ret = daprog;
            }

            return ret;
        }

        // convert {:Ebasic} to {:Ebasic n}
        void NameEnvironmentConstraints(Program program)
        {
            procsWithEnvAssumptions = new HashSet<string>();

            var cnt = 0;
            var AddAttr = new Action<Implementation, Cmd>((impl,cmd) =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return;
                if (!QKeyValue.FindBoolAttribute(acmd.Attributes, AvnAnnotations.EnvironmentAssumptionAttr))
                    return;

                acmd.Attributes = BoogieUtil.removeAttr(AvnAnnotations.EnvironmentAssumptionAttr, acmd.Attributes);
                acmd.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.EnvironmentAssumptionAttr, new List<object> { Expr.Literal(cnt) }, acmd.Attributes);
                cnt++;
                procsWithEnvAssumptions.Add(impl.Name);
            });

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach(var block in impl.Blocks) 
                    block.Cmds.Iter(c => AddAttr(impl, c));
            }
        }

        public void SuppressEnvironmentConstraint(int n)
        {
            var suppressed = false;

            var Mutate = new Action<Cmd>(cmd =>
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null) return;
                var id = QKeyValue.FindIntAttribute(acmd.Attributes, AvnAnnotations.EnvironmentAssumptionAttr, -1);
                if (id == -1 || id != n) return;
                suppressed = true;
                Console.WriteLine("Suppresing environment constraint: {0}", acmd.Expr);
                acmd.Expr = Expr.True;
            });

            foreach (var impl in currProg.TopLevelDeclarations.OfType<Implementation>())
            {
                if (!procsWithEnvAssumptions.Contains(impl.Name))
                    continue;

                foreach (var block in impl.Blocks)
                    block.Cmds.Iter(Mutate);
            }
            Debug.Assert(suppressed);
        }

        // This is to avoid a corner-case with ModifyTrans where some statements
        // that are deleted by the transformation are picked up at the end of the 
        // trace while mapping back. 
        // We avoid this by adding "assume true" right after procedure calls
        private cba.InsertionTrans AddBlanks(Program program)
        {
            var tinfo = new cba.InsertionTrans();

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var currCmds = new List<Cmd>();

                    tinfo.addTrans(impl.Name, blk.Label, blk.Label);
                    var incnt = -1;
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        incnt++;

                        // procedure call 
                        if (cmd is CallCmd)
                        {
                            currCmds.Add(cmd);
                            tinfo.addTrans(impl.Name, blk.Label, incnt, cmd, blk.Label, currCmds.Count - 1, new List<Cmd>{ currCmds.Last() });
                            currCmds.Add(BoogieAstFactory.MkAssume(Expr.True));
                            continue;
                        }

                        currCmds.Add(cmd);
                        tinfo.addTrans(impl.Name, blk.Label, incnt, cmd, blk.Label, currCmds.Count - 1, new List<Cmd> { currCmds.Last() });
                    }
                    blk.Cmds = currCmds;
                }
            }

            return tinfo;
        }

        public override cba.ErrorTrace mapBackTrace(cba.ErrorTrace trace)
        {
            cba.ErrorTrace ptrace = null;
            if (!Options.DeepAsserts)
            {
                // knock off top-level procedure
                var OldMainName = (input as PersistentProgram).mainProcName;
                
                foreach (var blk in trace.Blocks)
                {
                    var c = blk.Cmds.OfType<cba.CallInstr>().First(cmd => cmd.callee == OldMainName);
                    if (c == null) continue;
                    ptrace = c.calleeTrace;
                    break;
                }
                Debug.Assert(ptrace != null);
            }
            else
            {
                ptrace = da.mapBackTrace(trace);
            }

            trace = ptrace;
            (suppressInfo as IEnumerable<cba.InsertionTrans>)
                .Reverse().Iter(tinfo => trace = tinfo.mapBackTrace(trace));

            trace = assertInstrInfo.mapBackTrace(trace);
            trace = compressBlocks.mapBackTrace(trace);
            //trace = printInfo.mapBackTrace(trace);
            if(sourceInfo != null) trace = sourceInfo.mapBackTrace(trace);
            trace = blanksInfo.mapBackTrace(trace);
            return trace;
        }

        // Return the set of stubs used along the trace
        public HashSet<string> GetStubs(cba.ErrorTrace trace)
        {
            var ret = new HashSet<string>();
            GetStubs(trace, ret);
            return ret;
        }

        void GetStubs(cba.ErrorTrace trace, HashSet<string> ret)
        {
            if(trace == null)
                return;
            
            if (programStubs.Contains(trace.procName))
                ret.Add(trace.procName);

            trace.Blocks
                .Iter(blk => blk.Cmds.OfType<cba.CallInstr>()
                    .Iter(cc => GetStubs(cc.calleeTrace, ret)));                   
        }

        // Returns file and line of the failing assert. Dumps
        // error trace to disk.
        public Tuple<string, int> PrintErrorTrace(cba.ErrorTrace trace, string filename, List<Tuple<string, int, string>> eeSlicedSourceLines, string failStatus)
        {
            trace = mapBackTrace(trace);
            
            if (Driver.printTraceMode == Driver.PRINT_TRACE_MODE.Boogie)
            {
                cba.PrintProgramPath.print(input, trace, filename);
                return null;
            }
            else
            {
                // relevant lines
                cba.PrintSdvPath.relevantLines = null;
                if (eeSlicedSourceLines != null)
                {
                    cba.PrintSdvPath.relevantLines = new HashSet<Tuple<string, int>>();
                    eeSlicedSourceLines.Iter(tup => cba.PrintSdvPath.relevantLines.Add(Tuple.Create(tup.Item1, tup.Item2)));
                }

                cba.PrintSdvPath.failingLocation = null;
                cba.PrintSdvPath.failStatus = failStatus;

                
                cba.PrintSdvPath.Print(input.getProgram(), trace, new HashSet<string>(), "",
                    filename + ".tt", filename + "stack.txt");

                if (cba.PrintSdvPath.abortMessage != null)
                {
                    var am = new TokenTextWriter(filename + ".txt");
                    am.WriteLine(cba.PrintSdvPath.abortMessage);
                    am.Close();
                }


                if (cba.PrintSdvPath.lastDriverLocation == null)
                    return null;
                cba.PrintSdvPath.failingLocation = Tuple.Create(cba.PrintSdvPath.lastDriverLocation.Item1, cba.PrintSdvPath.lastDriverLocation.Item3);

                cba.PrintSdvPath.Print(input.getProgram(), trace, new HashSet<string>(), "",
                    filename + ".tt", filename + "stack.txt");

                if (cba.PrintSdvPath.abortMessage != null)
                {
                    var am = new TokenTextWriter(filename + ".txt");
                    am.WriteLine(cba.PrintSdvPath.abortMessage);
                    am.Close();
                }

                cba.PrintSdvPath.relevantLines = null;
                cba.PrintSdvPath.failingLocation = null;
                cba.PrintSdvPath.failStatus = null;

                return Tuple.Create(cba.PrintSdvPath.lastDriverLocation.Item1, cba.PrintSdvPath.lastDriverLocation.Item3);
            }
        }

        // Get the current program (with blocked assertions and input constraints)
        public PersistentProgram GetCurrProgram()
        {
            return new PersistentProgram(currProg, (output as PersistentProgram).mainProcName,
                (output as PersistentProgram).contextBound);
        }

        // The assertion corresponding to the given token
        public AssertCmd GetFailingAssert(AssertToken token)
        {
            return originalAssertions[token];

        }

        // Location where the assertion lived
        public string GetFailingAssertProcName(AssertToken token)
        {
            return tokenLocation[token].Item1;
        }

        // Procs with at least one assertion
        public HashSet<string> GetProcsWithAsserts()
        {
            var ret = new HashSet<string>();
            procToTokens.Where(kvp => kvp.Value.Count != 0)
                .Iter(kvp => ret.Add(kvp.Key));
            return ret;
        }

        // Suppress assertions in all but one procedure.
        // Returns the ones left.
        public HashSet<AssertToken> SuppressAllButOneProcedure(string procName)
        {
            Debug.Assert(tempSuppressedTokens.Count == 0);
            tempSuppressedTokens = new HashSet<AssertToken>();
            procToTokens.Where(kvp => kvp.Key != procName)
                .Iter(kvp => tempSuppressedTokens.UnionWith(kvp.Value));

            tempSuppressedTokens.Iter(t => SuppressToken(t));

            var ret = new HashSet<AssertToken>(procToTokens[procName]);
            ret.ExceptWith(suppressedTokens);

            return ret;
        }

        // Unsuppress assertions (inverse of SuppressAllButOneProcedure)
        public void Unsuppress()
        {
            foreach (var token in tempSuppressedTokens)
            {
                if (suppressedTokens.Contains(token))
                    continue;
                UnsuppressToken(token);
            }
            tempSuppressedTokens = new HashSet<AssertToken>();

            BoogieUtil.DoModSetAnalysis(currProg);
        }


        // precondition: pathProgram has a single implementation
        // Suppress an assertion (that failed in the pathProgram) and
        // return its token
        public AssertToken SuppressAssert(Program pathProgram)
        {
            var impl = pathProgram.TopLevelDeclarations.OfType<Implementation>()
                .First();

            var tokenId = -1;
            foreach (var acmd in impl.Blocks[0].Cmds.OfType<PredicateCmd>())
            {
                tokenId = QKeyValue.FindIntAttribute(acmd.Attributes, "avn", -1);
                if (tokenId == -1) continue;
                break;
            }

            Debug.Assert(tokenId != -1);
            var token = new AssertToken(tokenId);
            
            SuppressToken(token);

            BoogieUtil.DoModSetAnalysis(currProg);

            suppressedTokens.Add(token);

            return token;
        }

        public void SuppressToken(AssertToken token)
        {
            var location = tokenLocation[token];

            if (Options.DeepAsserts)
                location = Tuple.Create((output as PersistentProgram).mainProcName, location.Item2);

            var p = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations, location.Item1);
            var block = p.Blocks.Where(blk => blk.Label == location.Item2).FirstOrDefault();

            // disable assignment to assertsPassed
            var ncmds = new List<Cmd>();
            foreach (var cmd in block.Cmds)
            {
                if (!Options.DeepAsserts && (cmd is AssignCmd) && (cmd as AssignCmd).Lhss[0].DeepAssignedVariable.Name == assertsPassedName)
                {
                    var acmd = BoogieAstFactory.MkAssume((cmd as AssignCmd).Rhss[0]) as AssumeCmd;
                    acmd.Attributes = new QKeyValue(Token.NoToken, "suppressAssert",
                        new List<object> { Expr.Literal(token.id) }, null);
                    ncmds.Add(acmd);
                }
                else if (Options.DeepAsserts && (cmd is AssertCmd)
                  && QKeyValue.FindIntAttribute((cmd as AssertCmd).Attributes, "avn", -1) == token.id)
                {
                    var acmd = new AssumeCmd(Token.NoToken, (cmd as AssertCmd).Expr, (cmd as AssertCmd).Attributes);
                    ncmds.Add(acmd);
                }
                else
                    ncmds.Add(cmd);
            }
            block.Cmds = ncmds;
        }

        private void UnsuppressToken(AssertToken token)
        {
            var location = tokenLocation[token];
            var p = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations, location.Item1);
            var block = p.Blocks.Where(blk => blk.Label == location.Item2).FirstOrDefault();

            // disable assignment to assertsPassed
            var ncmds = new List<Cmd>();
            foreach (var cmd in block.Cmds)
            {
                if (!Options.DeepAsserts && cmd is AssumeCmd && QKeyValue.FindIntAttribute((cmd as AssumeCmd).Attributes, "suppressAssert", -1) == token.id)
                {
                    ncmds.Add(BoogieAstFactory.MkVarEqExpr(assertsPassed, (cmd as AssumeCmd).Expr));
                }
                else if (Options.DeepAsserts && cmd is AssumeCmd &&
                  QKeyValue.FindIntAttribute((cmd as AssumeCmd).Attributes, "avn", -1) == token.id)
                {
                    ncmds.Add(new AssertCmd(Token.NoToken, (cmd as AssertCmd).Expr, (cmd as AssertCmd).Attributes));
                }
                else
                    ncmds.Add(cmd);
            }
            block.Cmds = ncmds;
        }

        static int SuppressionCount = 0;

        // Suppress an input constraint
        public int SuppressInput(Expr input)
        {
            // find main
            var main = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations,
                origMainName);

            // construct the assume
            var ret = SuppressionCount++;
            var req = new Requires(true, input);
            req.Attributes = new QKeyValue(Token.NoToken, AvnAnnotations.BlockingConstraintAttr, 
                new List<object> { Expr.Literal(ret) }, req.Attributes);

            main.Proc.Requires.Add(req);

            // For mapback (is redundant now)
            var tinfo = new cba.InsertionTrans();
            suppressInfo.Add(tinfo);
            return ret;
        }

        // Suppress an input constraint
        public void RemoveInputSuppression(int id)
        {
            // find main
            var main = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations,
                origMainName);

            // Requires has the right id?
            var Mutate = new Func<Requires, Requires>(req =>
                {
                    if (QKeyValue.FindIntAttribute(req.Attributes, AvnAnnotations.BlockingConstraintAttr, -1) == id)
                        return new Requires(true, Expr.True);
                    return req;
                });

            main.Proc.Requires = main.Proc.Requires.Map(r => Mutate(r));
        }

        // Adds a new main:
        //   assertsPassed := true;
        //   call main();
        //   assert assertsPassed;
        string addMain(CBAProgram program)
        {
            var dup = new FixedDuplicator();
            var origMain = BoogieUtil.findProcedureImpl(program.TopLevelDeclarations, program.mainProcName);
            var newMain = dup.VisitImplementation(origMain);
            var newProc = dup.VisitProcedure(origMain.Proc);

            newMain.Name += "_SeqInstr";
            newProc.Name += "_SeqInstr";
            newMain.Proc = newProc;

            var mainIns = new List<Expr>();
            foreach (Variable v in newMain.InParams)
            {
                mainIns.Add(Expr.Ident(v));
            }
            var mainOuts = new List<IdentifierExpr>();
            foreach (Variable v in newMain.OutParams)
            {
                mainOuts.Add(Expr.Ident(v));
            }

            var callMain = new CallCmd(Token.NoToken, program.mainProcName, mainIns, mainOuts);
            callMain.Proc = origMain.Proc;

            var cmds = new List<Cmd>();
            cmds.Add(BoogieAstFactory.MkVarEqConst(assertsPassed, true));
            cmds.Add(callMain);
            cmds.Add(new AssertCmd(Token.NoToken, Expr.Ident(assertsPassed)));

            var blk = new Block(Token.NoToken, "start", cmds, new ReturnCmd(Token.NoToken));
            newMain.Blocks = new List<Block>();
            newMain.Blocks.Add(blk);

            program.AddTopLevelDeclaration(newProc);
            program.AddTopLevelDeclaration(newMain);

            program.mainProcName = newMain.Name;

            // Set entrypoint
            origMain.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Attributes);
            origMain.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", origMain.Proc.Attributes);

            newMain.AddAttribute("entrypoint");

            return newMain.Name;
        }

       
        // goto label1, label2;
        //
        // label1:
        //   assume {:avn tok} !assertsPassed;
        //   return;
        //
        // label2:
        //   assume assertsPassed;
        //   goto lab;
        //
        // lab:
        //
        // Inputs: the list of blocks being constructed; the current block being constructed.
        // End current block and adds two new blocks.
        // Returns "lab".

        private string addInstr(List<Block> instrumented, List<Cmd> curr, string curr_label, int token)
        {
            string lbl1 = getNewLabel();
            string lbl2 = getNewLabel();

            List<String> ssp = new List<String> { lbl1, lbl2 };
            instrumented.Add(new Block(Token.NoToken, curr_label, curr, new GotoCmd(Token.NoToken, ssp)));

            string common_label = getNewLabel();
            // assume (!assertsPassed)
            AssumeCmd cmd1 = new AssumeCmd(Token.NoToken, Expr.Not(Expr.Ident(assertsPassed)));
            if(token >= 0)
                cmd1.Attributes = new QKeyValue(Token.NoToken, "avn", new List<object> { Expr.Literal(token) }, cmd1.Attributes);

            // assume (assertsPassed)
            AssumeCmd cmd2 = new AssumeCmd(Token.NoToken, Expr.Ident(assertsPassed));

            curr = new List<Cmd>();
            curr.Add(cmd1);
            instrumented.Add(new Block(Token.NoToken, lbl1, curr, new ReturnCmd(Token.NoToken)));

            curr = new List<Cmd>();
            curr.Add(cmd2);
            instrumented.Add(new Block(Token.NoToken, lbl2, curr, BoogieAstFactory.MkGotoCmd(common_label)));

            return common_label;
        }

        static int labelCnt = 0;

        static string getNewLabel()
        {
            labelCnt++;
            return "AvnSeqInstr_" + labelCnt.ToString();
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last()); 
            assertInstrInfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }

    }

}
