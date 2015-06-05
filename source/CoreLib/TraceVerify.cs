using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    public class RestrictToTrace
    {
        // Current counter, one for each string that is renamed
        private Dictionary<string,int> usedNames;
        // The input program
        private Program inp;
        // A mapping: name -> implementation for inp
        private Dictionary<string, Implementation> nameToImpl;
        // A mapping: name -> procedure for inp
        private Dictionary<string, Procedure> nameToProc;
        // The set of procedures (without implementation) that are called by some trace
        private HashSet<string> calledProcsNoImpl;
        // The output program
        private Program output;
        // The code transformation done to go from inp to output
        private InsertionTrans tinfo;
        // New proc declarations to be added 
        private HashSet<int> newFixedContextProcs;
        // Add proc declaration for Fix_RaiseException
        private bool addRaiseExceptionProcDecl;

        // Add concretization assignments
        public static bool addConcretization = false;
        public static bool addConcretizationAsConstants = false;
        public static readonly string ConcretizeConstantNameAttr = "ConcretizeConstantName";
        public static readonly string ConcretizeCallIdAttr = "ConcretizeCallId";
        public Dictionary<string, int> concretizeConstantToCall;
        // For concretizing values of an uninterpreted sort: value -> constants with that value
        private Dictionary<string, HashSet<Constant>> uvalueToConstants; 
        // Convert non-failing asserts to assumes
        public static bool convertNonFailingAssertsToAssumes = false;

        public RestrictToTrace(Program p, InsertionTrans t)
        {
            inp = p;

            usedNames = new Dictionary<string, int>();
            nameToImpl = BoogieUtil.nameImplMapping(inp);
            nameToProc = BoogieUtil.nameProcMapping(inp);
            calledProcsNoImpl = new HashSet<string>();
            output = new Program();
            tinfo = t;
            newFixedContextProcs = new HashSet<int>();
            addRaiseExceptionProcDecl = false;
            concretizeConstantToCall = new Dictionary<string, int>();
            uvalueToConstants = new Dictionary<string, HashSet<Constant>>();
        }

        private string addIntToString(string s, int i)
        {
            return s + "__unique__" + (i + 1).ToString();
        }

        // Restricts a program to a single trace. 
        //
        // Returns the new name of trace.procName.
        // Adds resultant declarations to output program
        public string addTrace(ErrorTrace trace)
        {
            var ret = addTraceRec(trace);

            // uninterpreted constants

            // Gather the uninterpreted sorts
            var sorts = new Dictionary<string, Microsoft.Boogie.Type>(); 
            uvalueToConstants.Values
                .Iter(s => s
                    .Iter(c => sorts[c.TypedIdent.Type.AsCtor.Decl.Name] = c.TypedIdent.Type));

            foreach (var sort in sorts.Values)
            {
                var uvalueToUniqueConst = new Dictionary<string, Constant>();
                var cnt = 0;
                foreach (var v in uvalueToConstants.Keys)
                {
                    var uconst = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                        "uc__" + sort.ToString() + "__" + (cnt++), sort), true);
                    uvalueToUniqueConst.Add(v, uconst);
                }
                output.AddTopLevelDeclarations(uvalueToUniqueConst.Values);
                foreach (var tup in uvalueToConstants)
                {
                    Expr expr = Expr.True;
                    var uconst = uvalueToUniqueConst[tup.Key];
                    tup.Value.Where(c => c.TypedIdent.Type.AsCtor.Decl.Name == sort.AsCtor.Decl.Name)
                        .Iter(c => expr = Expr.And(expr, Expr.Eq(Expr.Ident(c), Expr.Ident(uconst))));
                    if (expr != Expr.True)
                        output.AddTopLevelDeclaration(new Axiom(Token.NoToken, expr));
                }
            }

            return ret;

        }

        private static int const_counter = 0;

        private string addTraceRec(ErrorTrace trace)
        {
            Debug.Assert(trace.Blocks.Count != 0);

            // First, construct the procedure declaration: only a name change required
            string newName = getNewName(trace.procName);
            Procedure proc = nameToProc[trace.procName];

            output.AddTopLevelDeclaration(
                new Procedure(Token.NoToken, newName, proc.TypeParameters, proc.InParams,
                    proc.OutParams, proc.Requires, proc.Modifies, proc.Ensures,
                    proc.Attributes));

            // Now to peice together the commands from the implementation. We keep around
            // multiple blocks to make sure that trace mapping works out.
            var traceBlocks = new List<Block>();

            Implementation impl = nameToImpl[trace.procName];

            var labelToBlock = BoogieUtil.labelBlockMapping(impl);

            // These two need not agree. This happens when impl.Block[0] has
            // no commands.
            // Debug.Assert(impl.Blocks[0].Label == trace.Blocks[0].blockName);
            Debug.Assert(reachableViaEmptyBlocks(impl.Blocks[0].Label, labelToBlock).Contains(trace.Blocks[0].blockName));

            for (int i = 0, n = trace.Blocks.Count; i < n; i++)
            {
                Block curr = labelToBlock[trace.Blocks[i].blockName];

                Block traceBlock = new Block();
                traceBlock.Cmds = new List<Cmd>();
                traceBlock.Label = addIntToString(trace.Blocks[i].blockName, i); // (The "i" is to deal with loops)
                if (i != n - 1)
                {
                    traceBlock.TransferCmd = BoogieAstFactory.MkGotoCmd(addIntToString(trace.Blocks[i + 1].blockName, i + 1));
                }
                else
                {
                    traceBlock.TransferCmd = new ReturnCmd(Token.NoToken);
                }
                tinfo.addTrans(newName, trace.Blocks[i].blockName, traceBlock.Label);

                #region Check consistency
                Debug.Assert(curr.Cmds.Count >= trace.Blocks[i].Cmds.Count);
                if (trace.Blocks[i].Cmds.Count != curr.Cmds.Count)
                {
                    Debug.Assert((i == n - 1));
                }

                if (curr.TransferCmd is ReturnCmd)
                {
                    Debug.Assert(i == n - 1);
                }
                else if (curr.TransferCmd is GotoCmd)
                {
                    List<String> targets = (curr.TransferCmd as GotoCmd).labelNames;
                    // one of these targets should be the next label
                    if (i != n - 1)
                    {
                        Debug.Assert(reachableViaEmptyBlocks(targets, labelToBlock).Contains(trace.Blocks[i + 1].blockName));
                    }
                }
                else
                {
                    throw new InternalError("Unknown transfer command");
                }
                #endregion

                // Index into trace.Blocks[i].Cmds
                int instrCount = -1;

                foreach (Cmd c in curr.Cmds)
                {
                    instrCount++;
                    if (instrCount == trace.Blocks[i].Cmds.Count)
                        break;

                    ErrorTraceInstr curr_instr = trace.Blocks[i].Cmds[instrCount];
                    if (curr_instr.info.isValid)
                    {
                        traceBlock.Cmds.Add(InstrumentationConfig.getFixedContextProc(curr_instr.info.executionContext));
                        newFixedContextProcs.Add(curr_instr.info.executionContext);
                    }

                    // Don't keep "fix context value" procs from the input program
                    if (InstrumentationConfig.getFixedContextValue(c) != -1)
                    {
                        traceBlock.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.True));
                        addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);
                        continue;
                    }

                    // Don't keep "fix raise exception" procs from the input program
                    if (InstrumentationConfig.isFixedRaiseExceptionProc(c))
                    {
                        traceBlock.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.True));
                        addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);
                        continue;
                    }

                    if (addConcretization && c is HavocCmd && curr_instr.info != null && curr_instr.info.hasIntVar("si_arg")
                        && (c as HavocCmd).Vars.Count > 0 && (c as HavocCmd).Vars[0].Decl.TypedIdent.Type.IsInt)
                    {
                        // concretize havoc-ed variable
                        var val = curr_instr.info.getIntVal("si_arg");
                        traceBlock.Cmds.Add(BoogieAstFactory.MkVarEqConst((c as HavocCmd).Vars[0].Decl, val));
                        addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);
                        continue;
                    }

                    if (!(c is CallCmd))
                    {
                        if (convertNonFailingAssertsToAssumes && c is AssertCmd && !(curr_instr.info is AssertFailInstrInfo))
                        {
                            traceBlock.Cmds.Add(new AssumeCmd(c.tok, (c as AssertCmd).Expr, (c as AssertCmd).Attributes));
                        }
                        else
                        {
                            traceBlock.Cmds.Add(c);
                        }
                        Debug.Assert(!curr_instr.isCall());
                        addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);

                        continue;
                    }
                    Debug.Assert(curr_instr.isCall());

                    CallCmd cc = c as CallCmd;
                    CallInstr call_instr = curr_instr as CallInstr;

                    if (!nameToImpl.ContainsKey(cc.Proc.Name) || !call_instr.hasCalledTrace)
                    {
                        // This is a call to a procedure without implementation; skip;
                        calledProcsNoImpl.Add(cc.Proc.Name);
                        traceBlock.Cmds.Add(c);
                        Debug.Assert(!call_instr.hasCalledTrace);
                        if (addConcretization && cc.Outs.Count == 1 && call_instr.info.hasVar("si_arg"))
                        {
                            if (!addConcretizationAsConstants)
                            {
                                if (call_instr.info.hasBoolVar("si_arg"))
                                    traceBlock.Cmds.Add(BoogieAstFactory.MkVarEqConst(cc.Outs[0].Decl, call_instr.info.getBoolVal("si_arg")));
                                else if (call_instr.info.hasIntVar("si_arg"))
                                    traceBlock.Cmds.Add(BoogieAstFactory.MkVarEqConst(cc.Outs[0].Decl, call_instr.info.getIntVal("si_arg")));
                                else
                                    Debug.Assert(false);

                            }
                            else 
                            {
                                // create a constant that is equal to this literal, then use the constant
                                // for concretization

                                // do we use a specific name for the constant?
                                var constantName = QKeyValue.FindStringAttribute(cc.Attributes, ConcretizeConstantNameAttr);
                                if (constantName == null) constantName = "";

                                var constant = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                                    string.Format("alloc_{0}__{1}", constantName, const_counter), cc.Outs[0].Decl.TypedIdent.Type), false);
                                const_counter++;

                                traceBlock.Cmds.Add(BoogieAstFactory.MkVarEqVar(cc.Outs[0].Decl, constant));
                                output.AddTopLevelDeclaration(constant);

                                if (call_instr.info.hasIntVar("si_arg"))
                                    output.AddTopLevelDeclaration(new Axiom(Token.NoToken, Expr.Eq(Expr.Ident(constant), Expr.Literal(call_instr.info.getIntVal("si_arg")))));
                                else if (call_instr.info.hasVar("si_arg") && cc.Outs[0].Decl.TypedIdent.Type.IsCtor)
                                    uvalueToConstants.InitAndAdd(call_instr.info.getVal("si_arg").ToString(), constant);

                                var id = QKeyValue.FindIntAttribute(cc.Attributes, ConcretizeCallIdAttr, -1);
                                concretizeConstantToCall.Add(constant.Name, id);
                            }

                        }
                        addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);
                        continue;
                    }

                    Debug.Assert(call_instr.calleeTrace.procName == cc.Proc.Name);
                    var callee = addTraceRec(call_instr.calleeTrace);

                    var newcmd = new CallCmd(Token.NoToken, callee, cc.Ins, cc.Outs, cc.Attributes, cc.IsAsync);
                    traceBlock.Cmds.Add(newcmd);
                    addedTrans(newName, curr.Label, instrCount, c, traceBlock.Label, traceBlock.Cmds);

                }
                traceBlocks.Add(traceBlock);
            }

            Debug.Assert(traceBlocks.Count != 0);
            if (trace.raisesException)
            {
                var exitblk = traceBlocks.Last();
                exitblk.Cmds.Add(InstrumentationConfig.getFixedRaiseExceptionProc());
                addRaiseExceptionProcDecl = true;
            }

            // Add the implementation to output
            //var block = new Block(Token.NoToken, trace.Blocks[0].blockName, traceCmdSeq, new ReturnCmd(Token.NoToken));
            //List<Block> blocks = new List<Block>();
            //blocks.Add(block);

            //tinfo.addTrans(newName, trace.Blocks[0].blockName, trace.Blocks[0].blockName);
            tinfo.addProcNameTrans(trace.procName, newName);

            output.AddTopLevelDeclaration(
                new Implementation(Token.NoToken, newName, impl.TypeParameters,
                    impl.InParams, impl.OutParams, impl.LocVars, traceBlocks,
                    QKeyValue.FindStringAttribute(impl.Attributes, "origRTname") == null ?
                      new QKeyValue(Token.NoToken, "origRTname", new List<object> { impl.Name }, impl.Attributes)
                    : impl.Attributes));
            
            return newName;
        }

        // Record the fact that we added instruction corresponding to "in" as the last instruction
        // of "curr"
        private void addedTrans(string procName, string inBlk, int inCnt, Cmd inCmd, string outBlk, List<Cmd> curr)
        {
            List<Cmd> cseq = new List<Cmd>();
            cseq.Add(curr.Last());
            tinfo.addTrans(procName, inBlk, inCnt, inCmd, outBlk, curr.Count - 1, cseq);
        }

        // Return the set of blocks reachable while only going through empty blocks
        private HashSet<string> reachableViaEmptyBlocks(string lab, Dictionary<string, Block> labelBlockMap)
        {
            List<String> ss = new List<String>();
            ss.Add(lab);
            return reachableViaEmptyBlocks(ss, labelBlockMap);
        }

        // Return the set of blocks reachable while only going through empty blocks
        private HashSet<string> reachableViaEmptyBlocks(List<String> lab, Dictionary<string, Block> labelBlockMap)
        {
            var stack = new List<Block>();
            var visited = new HashSet<string>();

            foreach (string s in lab)
            {
                stack.Add(labelBlockMap[s]);
            }

            while (stack.Count != 0)
            {
                var node = stack.First();
                stack.RemoveAt(0);

                if (visited.Contains(node.Label))
                    continue;

                visited.Add(node.Label);

                if (node.Cmds.Count != 0)
                    continue;

                if (node.TransferCmd is GotoCmd)
                {
                    var gc = node.TransferCmd as GotoCmd;
                    foreach (string s in gc.labelNames)
                    {
                        stack.Add(labelBlockMap[s]);
                    }
                }
            }

            return visited;
        }

        private string getNewName(string str)
        {
            int val;
            if (usedNames.TryGetValue(str, out val))
            {
                usedNames[str] = val + 1;
                return str + "_trace_" + val;
            }
            else
            {
                usedNames.Add(str, 2);
                return str + "_trace_" + 1;
            }
        }

        // Get the unique string to which str was renamed to by getNewName
        public string getFirstNameInstance(string str)
        {
            int val;
            if (!usedNames.TryGetValue(str, out val))
            {
                throw new InternalError("getUniqueName: String not renamed to anything!");
            } else {
                return str + "_trace_" + 1;
            }
        }

        public Program getProgram() {
            // Names for procs that fix context values
            HashSet<string> newProcsToAdd = new HashSet<string>();
            foreach (var i in newFixedContextProcs)
            {
                newProcsToAdd.Add(InstrumentationConfig.getFixedContextProcName(i));
            }
            if (addRaiseExceptionProcDecl)
            {
                newProcsToAdd.Add(InstrumentationConfig.getFixedRaiseExceptionProcName());
            }

            // Add globals, axioms, functions, etc
            foreach (Declaration decl in inp.TopLevelDeclarations)
            {
                if ((decl is Procedure) || (decl is Implementation))
                    continue;
                output.AddTopLevelDeclaration(decl);
            }
            
            // Add procedure declarations (ones without an implementation), as required
            foreach (string str in calledProcsNoImpl)
            {
                newProcsToAdd.Remove(str);
                output.AddTopLevelDeclaration(nameToProc[str]);
                tinfo.addProcNameTrans(str, str);
            }

            // Add declaration for fixing context values
            foreach (var p in newProcsToAdd)
            {
                var proc = new Procedure(Token.NoToken, p, new List<TypeVariable>(),
                    new List<Variable>(), new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                output.AddTopLevelDeclaration(proc);
            }

            //string outfile = "trace.bpl";
            //BoogieUtil.PrintProgram(output, outfile);

            Program ret = output;
            output = null;

            return ret;
        }

    }
}
