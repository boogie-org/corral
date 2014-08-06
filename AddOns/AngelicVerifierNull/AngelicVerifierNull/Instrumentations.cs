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

namespace AngelicVerifierNull
{

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    class Instrumentations
    {
        const string CORRAL_EXTRA_INIT_PROC = "corralExtraInit";

        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;
            Procedure mallocProcedure = null;
            Procedure mallocProcedureFull = null;
            bool useProvidedEntryPoints = false;
            public Dictionary<string, string> blockEntryPointConstants; //they guard assume false before calling e_i in the harness 
            public HashSet<string> entrypoints; // set of entrypoints identified
            List<Variable> globalParams = new List<Variable>(); // parameters as global variables

            public HarnessInstrumentation(Program program, string corralName, bool useProvidedEntryPoints)
            {
                prog = program;
                mainName = corralName;
                this.useProvidedEntryPoints = useProvidedEntryPoints;
                blockEntryPointConstants = new Dictionary<string,string>();
                entrypoints = new HashSet<string>();
            }
            public void DoInstrument()
            {
                FindMalloc();
                FindNULL();
                CreateMainProcedure();
                ChangeStubsIntoUnkowns();
            }
            
            private void CreateMainProcedure()
            {
                //blocks 
                List<Block> mainBlocks = new List<Block>();
                List<Variable> locals = new List<Variable>();
                Stats.numProcs = prog.TopLevelDeclarations.Where(x => x is Implementation).Count();
                Stats.numProcsAnalyzed = 0;
                HashSet<Constant> blockCallConsts = new HashSet<Constant>(); 
                foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
                {
                    // skip this impl if it is not marked as an entrypoint
                    if (useProvidedEntryPoints && !QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                        continue;
                    Stats.numProcsAnalyzed++;
                    impl.Proc.Attributes = BoogieUtil.removeAttr("entrypoint", impl.Proc.Attributes);
                    entrypoints.Add(impl.Name);

                    //allocate params
                    var args = new List<Variable>();
                    var rets = new List<Variable>();

                    
                    impl.OutParams.ForEach(v => rets.Add(BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type)));
                    if (Driver.allocateParameters)
                    {
                        // use impl.Proc here to pickup scalar/pointer attributes
                        impl.Proc.InParams.ForEach(v =>
                            {
                                var l = BoogieAstFactory.MkLocal(v.Name + "_" + impl.Name, v.TypedIdent.Type);
                                l.Attributes = v.Attributes;
                                args.Add(l);
                            });
                        locals.AddRange(args);
                    }
                    else
                    {
                        impl.Proc.InParams.ForEach(v => 
                            {
                                var g = BoogieAstFactory.MkGlobal(v.Name + "_" + impl.Name, v.TypedIdent.Type);
                                g.Attributes = v.Attributes;
                                args.Add(g);
                            });
                        globalParams.AddRange(args);
                    }

                    
                    locals.AddRange(rets);

                    //call 
                    var blockCallConst = new Constant(Token.NoToken,
                        new TypedIdent(Token.NoToken, "__block_call_" + impl.Name, btype.Bool), false);
                    blockCallConsts.Add(blockCallConst);
                    blockEntryPointConstants[blockCallConst.Name] = impl.Name;
                    var blockCallAssumeCmd = new AssumeCmd(Token.NoToken, IdentifierExpr.Ident(blockCallConst));
                    
                    var cmds = new List<Cmd>();
                    cmds.Add(blockCallAssumeCmd);
                    if (Driver.allocateParameters) // allocate parameters if option is enabled
                    {
                        var argMallocCmds = AllocatePointersAsUnknowns(args);
                        cmds.AddRange(argMallocCmds);
                    }

                    var callCmd = new CallCmd(Token.NoToken, impl.Name, args.ConvertAll(x => (Expr)IdentifierExpr.Ident(x)),
                        rets.ConvertAll(x => IdentifierExpr.Ident(x)));                
                    
                    cmds.Add(callCmd);
                    //succ
                    var txCmd = new ReturnCmd(Token.NoToken);
                    var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                    mainBlocks.Add(blk);
                }
                // add global variables to prog
                // globals.Iter(x => prog.TopLevelDeclarations.Add(x)); 
                //add the constants to the prog
                blockCallConsts.Iter(x => prog.TopLevelDeclarations.Add(x));
                //TODO: get globals of type refs/pointers and maps
                var initCmd = (AssumeCmd) BoogieAstFactory.MkAssume(Expr.True);
                //TODO: find a reusable API to add attributes to cmds
                initCmd.Attributes = new QKeyValue(Token.NoToken, ExplainError.Toplevel.CAPTURESTATE_ATTRIBUTE_NAME, new List<Object>() {"Start"}, null);
                var globalCmds = new List<Cmd>() { initCmd };
                //add call to corralExtraInit
                var inits = prog.TopLevelDeclarations.OfType<Procedure>().Where(x => x.Name == CORRAL_EXTRA_INIT_PROC);
                if (inits.Count() > 0)
                    globalCmds.Add(BoogieAstFactory.MkCall(inits.First(), new List<Expr>(), new List<Variable>()));

                // initialize globals
                globalCmds.AddRange(AllocatePointersAsUnknowns(prog.GlobalVariables().ConvertAll(x => (Variable)x)));

                // globals for parameters
                prog.TopLevelDeclarations.AddRange(globalParams);

                //first block
                var transferCmd =
                    mainBlocks.Count > 0 ? (TransferCmd)(new GotoCmd(Token.NoToken, mainBlocks)) : (TransferCmd) (new ReturnCmd(Token.NoToken));
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", globalCmds, transferCmd);
                var blocks = new List<Block>();
                blocks.Add(blkStart);
                blocks.AddRange(mainBlocks);
                var mainProcImpl = BoogieAstFactory.MkImpl("CorralMain", new List<Variable>(), new List<Variable>(), locals, blocks);
                mainProcImpl[0].AddAttribute("entrypoint");
                prog.TopLevelDeclarations.AddRange(mainProcImpl);
            }
            
            // create a copy ofthe variables without annotations
            private List<Variable> DropAnnotations(List<Variable> vars)
            {
                var ret = new List<Variable>();
                var dup = new Duplicator();
                vars.Select(v => dup.VisitVariable(v)).Iter(v =>
                    {
                        v.Attributes = null;
                        ret.Add(v);
                    });
                return ret;
            }

            private void ChangeStubsIntoUnkowns()
            {
                var procsWithImpl = prog.TopLevelDeclarations.OfType<Implementation>()
                    .Select(x => x.Proc);
                var procs = prog.TopLevelDeclarations.OfType<Procedure>();
                //TODO: this can be almost quadratic in the size of |Procedures|, cleanup
                var procsWithoutImpl = procs.Where(x => !procsWithImpl.Contains(x));
                var stubImpls = new List<Implementation>();
                foreach (var p in procsWithoutImpl)
                {
                    if (BoogieUtil.checkAttrExists("allocator", p.Attributes)) continue;
                    MkStubImplementation(stubImpls, p);
                }
                prog.TopLevelDeclarations.AddRange(stubImpls);
            }
            //Change the body of any stub that returns a pointer into calling malloc()
            //TODO: only do this for procedures with a single return with a pointer type            
            private void MkStubImplementation(List<Implementation> stubImpls, Procedure p)
            {
                List<Cmd> cmds = new List<Cmd>();
                List<Variable> localVars = new List<Variable>();
                foreach (var op in p.OutParams)
                {
                    if (IsPointerVariable(op)) cmds.Add(AllocatePointerAsUnknown(op));
                    else cmds.Add(BoogieAstFactory.MkHavocVar(op)); //Corral alias analysis crashes (what is semantics of uninit var for inlining)
                }
                foreach (var ip in p.InParams)
                {
                    if (!BoogieUtil.checkAttrExists("ref", ip.Attributes)) continue;
                    string mapName = QKeyValue.FindStringAttribute(ip.Attributes, "ref");
                    if (mapName == null) {
                        Utils.Print(String.Format("Expecting a map <name> with {:ref <name>} annotation on procedure {0}", p.Name), 
                            Utils.PRINT_TAG.AV_WARNING);
                        continue;
                    }
                    var mapVars = prog.TopLevelDeclarations.OfType<Variable>().Where(x => x.Name == mapName && x.TypedIdent.Type.IsMap);
                    if (mapVars.Count() != 1)
                    {
                        Utils.Print(String.Format("Mapname {0} provided in {:ref} for parameter {1} for procedure {2} has {3} matches, expecting exactly 1 match",
                            mapName, ip.Name, p.Name, mapVars.Count()),
                            Utils.PRINT_TAG.AV_WARNING);
                        continue;
                    }
                    var tmpVar = BoogieAstFactory.MkLocal("__tmp_" + ip.Name, ip.TypedIdent.Type);
                    localVars.Add(tmpVar);
                    cmds.Add(AllocatePointerAsUnknown(tmpVar));
                    cmds.Add(BoogieAstFactory.MkMapAssign(mapVars.First(), IdentifierExpr.Ident(ip), IdentifierExpr.Ident(tmpVar)));
                }
                if (cmds.Count == 0) return; //don't create a body if no statements
                var blk = BoogieAstFactory.MkBlock(cmds, new ReturnCmd(Token.NoToken));
                var blks = new List<Block>() { blk };
                //don't insert the proc as it already exists
                var impl = BoogieAstFactory.MkImpl(p.Name, 
                    DropAnnotations(p.InParams), 
                    DropAnnotations(p.OutParams),
                    new List<Variable>(), blks);
                ((Implementation)impl[1]).LocVars.AddRange(localVars);
                stubImpls.Add((Implementation)impl[1]);
            }
            private Cmd AllocatePointerAsUnknown(Variable x)
            {
                return BoogieAstFactory.MkCall(mallocProcedureFull, 
                    new List<Expr>(){new LiteralExpr(Token.NoToken, Microsoft.Basetypes.BigNum.ONE)}, 
                    new List<Variable>() {x});
            }
            private List<Cmd> AllocatePointersAsUnknowns(List<Variable> vars)
            {
                return GetPointerVars(vars)
                    .Select(x => AllocatePointerAsUnknown(x)).ToList();
            }
            private void FindMalloc()
            {
                //find the malloc and malloc-full procedures
                foreach (var proc in prog.TopLevelDeclarations.OfType<Procedure>()
                    .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
                {
                    var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                    if (attr == null) mallocProcedure = proc;
                    else if (attr == "full") mallocProcedureFull = proc;
                }

                if (mallocProcedure == null)
                {
                    throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator} declared in the input program");
                }

                if (mallocProcedureFull == null)
                {
                    throw new InputProgramDoesNotMatchExn("ABORT: no malloc procedure with {:allocator \"full\"} declared in the input program");
                }

                if (mallocProcedure.InParams.Count != 1 || mallocProcedureFull.InParams.Count != 1)
                {
                    throw new InputProgramDoesNotMatchExn(String.Format("ABORT: malloc procedure {0} should have exactly 1 argument, found {1}",
                        mallocProcedure.Name, mallocProcedure.InParams.Count));
                }
            }
            private void FindNULL()
            {
                //find the malloc procedure
                var nulls = prog.TopLevelDeclarations
                    .Where(x => x is Constant && x.ToString().Equals("NULL"));
                if (!nulls.Any())
                    throw new InputProgramDoesNotMatchExn("ABORT: no NULL constant declared in the input program");
            }
            private List<Variable> GetPointerVars(List<Variable> vars)
            {
                return vars.Where(x => IsPointerVariable(x)).ToList();
            }
            /// <summary>
            /// TODO: Refine this to only return variables of type pointers
            /// </summary>
            /// <param name="x"></param>
            /// <returns></returns>
            private bool IsPointerVariable(Variable x)
            {
                return x.TypedIdent.Type.IsInt &&
                    !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
            }
        }

        public class MallocInstrumentation
        {
            Program prog;

            public const string mallocTriggerFuncName = "mallocTrigger_";
            public Dictionary<Tuple<string, string, int>, string> mallocTriggersLocation; //don't keep any objects (e.g. Function) since program changes

            public MallocInstrumentation(Program program)
            {
                prog = program;
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
                    instance.mallocTriggersLocation = new Dictionary<Tuple<string, string, int>, string>();
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
                        if (callCmd != null && BoogieUtil.checkAttrExists("allocator", callCmd.Proc.Attributes))
                        {
                            var retCall = callCmd.Outs[0];
                            var mallocTriggerFn = new Function(Token.NoToken, mallocTriggerFuncName + mallocTriggers.Count,
                                new List<Variable>() { BoogieAstFactory.MkFormal("a", btype.Int, false) },
                                BoogieAstFactory.MkFormal("r", btype.Bool, false));
                            mallocTriggers[callCmd] = mallocTriggerFn;
                            instance.mallocTriggersLocation[Tuple.Create(currImpl.Name, currBlock.Label, callCmdCount)] = mallocTriggerFn.Name;
                            instance.prog.TopLevelDeclarations.Add(mallocTriggerFn);
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

        public class AssertGuardInstrumentation
        {
            Program prog;

            public AssertGuardInstrumentation(Program program)
            {
                prog = program;
            }
            public void DoInstrument()
            {
                new AssertGuardInstrumentVisitor(this)
                    .Visit(prog);
            }

            private class AssertGuardInstrumentVisitor : StandardVisitor
            {
                AssertGuardInstrumentation instance;
                public Dictionary<AssertCmd, Constant> assertGuardConsts;
                public AssertGuardInstrumentVisitor(AssertGuardInstrumentation agi)
                {
                    instance = agi;
                    assertGuardConsts = new Dictionary<AssertCmd, Constant>();
                }
                public override Cmd VisitAssertCmd(AssertCmd node)
                {
                    if (assertGuardConsts.ContainsKey(node)) return node;
                    if (node.Expr.ToString().Equals(Expr.True.ToString())) return node;
                    var guardConst = new Constant(Token.NoToken, 
                        new TypedIdent(Token.NoToken, "_assert_guard_" + assertGuardConsts.Count(), btype.Bool), false);
                    node.Expr = Expr.Imp(IdentifierExpr.Ident(guardConst), node.Expr);
                    assertGuardConsts[node] = guardConst;
                    instance.prog.TopLevelDeclarations.Add(guardConst);
                    return base.VisitAssertCmd(node);
                }
            }
        }

        public class AssertCountVisitor : StandardVisitor
        {
            public int assertCount = 0;
            public string notfalse = null;

            public AssertCountVisitor()
            {
                notfalse = new NAryExpr(Token.NoToken, new UnaryOperator(Token.NoToken, UnaryOperator.Opcode.Not), new List<Expr> { Expr.False }).ToString();
            }

            public override Cmd VisitAssertCmd(AssertCmd node)
            {
                // disregard true and !false
                if (node.Expr.ToString() == Expr.True.ToString() ||
                    node.Expr.ToString() == notfalse)
                    return node;

                assertCount++;
                return base.VisitAssertCmd(node);
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

    /* Initial instrumentation done before running corral.
     * It gets rid of source line annotation and print commands (because
     * there are too many of them).
     * It also instruments assertions.
     */
    class AvnInstrumentation : cba.CompilerPass
    {
        cba.ModifyTrans sourceInfo;
        cba.ModifyTrans printInfo;
        cba.CompressBlocks compressBlocks;
        cba.InsertionTrans assertInstrInfo;

        Instrumentations.HarnessInstrumentation harnessInstr;

        Dictionary<int, AssertCmd> originalAssertions;

        Dictionary<int, Tuple<string, string>> tokenLocation;

        Program currProg;

        public readonly string assertsPassedName = "assertsPassed";
        GlobalVariable assertsPassed;

        public AvnInstrumentation(Instrumentations.HarnessInstrumentation harnessInstr)
        {
            passName = "SequentialInstrumentation"; 
            assertInstrInfo = new cba.InsertionTrans();
            assertsPassed = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "assertsPassed", Microsoft.Boogie.Type.Bool));
            compressBlocks = new cba.CompressBlocks();
            originalAssertions = new Dictionary<int, AssertCmd>();
            tokenLocation = new Dictionary<int, Tuple<string, string>>();
            currProg = null;
            this.harnessInstr = harnessInstr;
        }

        public override CBAProgram runCBAPass(CBAProgram program)
        {
            // Remove unreachable procedures
            BoogieUtil.pruneProcs(program, program.mainProcName);

            // Remove source line annotations
            sourceInfo = cba.PrintSdvPath.DeleteSourceInfo(program);

            // Remove print info
            //printInfo = cba.PrintSdvPath.DeletePrintCmds(program);

            // Compress
            compressBlocks.VisitProgram(program);

            // Instrument assertions
            int token = 0;

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
                            originalAssertions.Add(token, cmd as AssertCmd);
                            tokenLocation.Add(token, Tuple.Create(impl.Name, currLabel));
                            addedTrans(impl.Name, blk.Label, incnt, cmd, currLabel, currCmds);

                            currLabel = addInstr(instrumented, currCmds, currLabel, token++);
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

            program.TopLevelDeclarations.Add(assertsPassed);
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

            return new CBAProgram(program, newMain, 0);
        }

        public override cba.ErrorTrace mapBackTrace(cba.ErrorTrace trace)
        {
            // knock off top-level procedure
            var OldMainName = (input as PersistentProgram).mainProcName;
            cba.ErrorTrace ptrace = null;
            foreach (var blk in trace.Blocks)
            {
                var c = blk.Cmds.OfType<cba.CallInstr>().First(cmd => cmd.callee == OldMainName);
                if (c == null) continue;
                ptrace = c.calleeTrace;
                break;
            }
            Debug.Assert(ptrace != null);

            trace = assertInstrInfo.mapBackTrace(ptrace);
            trace = compressBlocks.mapBackTrace(trace);
            //trace = printInfo.mapBackTrace(trace);
            trace = sourceInfo.mapBackTrace(trace);
            return trace;
        }

        public IEnumerable<Constant> GetRoundRobinBlockingConstants()
        {
            var blockConstNames = harnessInstr.blockEntryPointConstants.Keys;
            var blockCallConsts = currProg.TopLevelDeclarations
                .OfType<Constant>()
                .Where(x => blockConstNames.Contains(x.Name));
            return blockCallConsts;
        }

        public void BlockAllButThis(Constant constant)
        {
            var blockCallConsts = GetRoundRobinBlockingConstants();
            var tmp = new HashSet<Constant>(blockCallConsts);
            tmp.Remove(constant);
            var blockExpr = tmp.Aggregate((Expr)Expr.True, (x, y) => (Expr.And(x, Expr.Not(IdentifierExpr.Ident(y)))));
            var mainProc = currProg.TopLevelDeclarations.OfType<Procedure>()
                .Where(x => x.Name == (output as PersistentProgram).mainProcName).FirstOrDefault();
            mainProc.Requires.Add(new Requires(Token.NoToken, false, blockExpr, null, 
                new QKeyValue(Token.NoToken, "RRBlocking", new List<object>(), null))); 
        }

        public void RemoveBlockingConstraint()
        {
            var mainProc = currProg.TopLevelDeclarations.OfType<Procedure>()
                .Where(x => x.Name == (output as PersistentProgram).mainProcName).FirstOrDefault();

            mainProc.Requires.RemoveAll(x => QKeyValue.FindBoolAttribute(x.Attributes, "RRBlocking"));
        }

        // returns file and line of the failing assert
        public Tuple<string, int> PrintErrorTrace(cba.ErrorTrace trace, string filename)
        {
            trace = mapBackTrace(trace);
            
            if (Driver.printTraceMode == Driver.PRINT_TRACE_MODE.Boogie)
            {
                cba.PrintProgramPath.print(input, trace, filename + ".txt");
                return null;
            }
            else
            {
                cba.PrintSdvPath.Print(input.getProgram(), trace, new HashSet<string>(), "",
                    filename + ".tt", "stack.txt");
                return Tuple.Create(cba.PrintSdvPath.lastDriverLocation.Item1, cba.PrintSdvPath.lastDriverLocation.Item3);
            }
        }

        public PersistentProgram GetCurrProgram()
        {
            return new PersistentProgram(currProg, (output as PersistentProgram).mainProcName,
                (output as PersistentProgram).contextBound);
        }

        public AssertCmd GetFailingAssert(int token)
        {
            return originalAssertions[token];

        }

        public string GetFailingAssertProcName(int token)
        {
            return tokenLocation[token].Item1;
        }

        // precondition: pathProgram has a single implementation
        public int SuppressAssert(Program pathProgram)
        {
            var impl = pathProgram.TopLevelDeclarations.OfType<Implementation>()
                .First();

            var token = -1;
            foreach (var acmd in impl.Blocks[0].Cmds.OfType<AssumeCmd>())
            {
                token = QKeyValue.FindIntAttribute(acmd.Attributes, "avn", -1);
                if (token == -1) continue;
                break;
            }

            Debug.Assert(token != -1);

            var location = tokenLocation[token];
            var p = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations, location.Item1);
            var block = p.Blocks.Where(blk => blk.Label == location.Item2).FirstOrDefault();

            // disable assignment to assertsPassed
            var ncmds = new List<Cmd>();
            foreach (var cmd in block.Cmds)
            {
                if ((cmd is AssignCmd) && (cmd as AssignCmd).Lhss[0].DeepAssignedVariable.Name == assertsPassedName)
                    ncmds.Add(BoogieAstFactory.MkAssume((cmd as AssignCmd).Rhss[0]));
                else
                    ncmds.Add(cmd);
            }
            block.Cmds = ncmds;

            BoogieUtil.DoModSetAnalysis(currProg);

            return token;
        }

        public void SuppressInput(Expr input)
        {
            var main = BoogieUtil.findProcedureImpl(currProg.TopLevelDeclarations,
                (output as PersistentProgram).mainProcName);
            main.Proc.Requires.Add(new Requires(true, input));
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

            program.TopLevelDeclarations.Add(newProc);
            program.TopLevelDeclarations.Add(newMain);

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
            return "SeqInstr_" + labelCnt.ToString();
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last()); 
            assertInstrInfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }


        public string GetEntryPoint(cba.ErrorTrace cex, HashSet<string> IdentifiedEntryPoints)
        {
            // knock off top-level main, and then see what is called
            var OldMainName = (input as PersistentProgram).mainProcName;
            cba.ErrorTrace ptrace = null;
            foreach (var blk in cex.Blocks)
            {
                var c = blk.Cmds.OfType<cba.CallInstr>().First(cmd => cmd.callee == OldMainName);
                if (c == null) continue;
                ptrace = c.calleeTrace;
                break;
            }
            Debug.Assert(ptrace != null);

            return
                ptrace.Blocks.Select(blk => blk.Cmds.OfType<cba.CallInstr>()).Aggregate((a, b) => a.Concat(b))
                .Where(ci => IdentifiedEntryPoints.Contains(ci.callee))
                .Select(ci => ci.callee)
                .FirstOrDefault();

        }
    }
}
