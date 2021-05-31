using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using btype = Microsoft.Boogie.Type;

namespace ConcurrentHoudini
{
    public class og
    {
        // Introduce a linear variable "perm" that originates in main and
        // gets passed around everywhere, with candidates:
        //   perm != mapconstbool(false);
        // Then, for each thread that is a single instance,
        //    assume perm[i]; 
        // where i is a unique index for that thread
        public static Program InstrumentPermissions(Program program)
        {
            if (Driver.con.entryFunc == null)
                return program;

            // map type: [int] bool;
            var settype = BoogieAstFactory.MkMapType(btype.Int, btype.Bool);

            // create function mapconstbool
            var mapconstbool = new Function(Token.NoToken, "ch_mapconstbool",
                new List<Variable>(new Variable[] {
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Bool), true) }),
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "r", settype), false));
            mapconstbool.AddAttribute("builtin", "MapConst");

            // create function mapunion
            var mapunion = new Function(Token.NoToken, "ch_mapunion",
                new List<Variable>(new Variable[] {
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", settype), true),
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "y", settype), true) }),
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "r", settype), false));
            mapunion.AddAttribute("builtin", "MapOr");

            program.AddTopLevelDeclaration(mapconstbool);
            program.AddTopLevelDeclaration(mapunion);

            // Get hold of all implementations
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            // Gather list of async-ed procedures
            var asyncProcs = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .Iter(proc => asyncProcs.Add(proc.Name));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Where(cmd => cmd.IsAsync)
                        .Iter(cmd => asyncProcs.Add(cmd.callee))));

            // Gather the list of threads with a single instance
            var singleInstances = new Dictionary<string, int>();
            var threadInstanceID = new Dictionary<string, int>();
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => asyncProcs.Contains(p.Name)))
            {
                if (!QKeyValue.FindBoolAttribute(proc.Attributes, Driver.con.singleInstAttr))
                    continue;
                var thread = QKeyValue.FindStringAttribute(proc.Attributes, Driver.con.originalThreadAttr);
                singleInstances[thread] = (singleInstances.Count);
            }
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                var thread = QKeyValue.FindStringAttribute(proc.Attributes, Driver.con.threadAttr);
                if(thread == null || !singleInstances.ContainsKey(thread))
                    continue;
                if(Driver.dbg)
                    Console.WriteLine("Proc: {0} of thread {1}", proc.Name, thread);

                threadInstanceID[proc.Name] = singleInstances[thread];
            }

            // Inject variable
            var permVarNamePrefix = "permVar";
            var addVar = new AddTaskLocalVars(asyncProcs, permVarNamePrefix, settype);
            addVar.run(program);
            program = BoogieUtil.ReResolve(program, "og__temp.bp");

            // Add {:linear "Perm"} annotation            
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(decl => decl.InParams.OfType<Variable>()
                    .Concat(decl.OutParams.OfType<Variable>())
                    .Where(v => v.Name.StartsWith(permVarNamePrefix))
                    .Iter(v => v.AddAttribute("linear", "Perm")));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => asyncProcs.Contains(impl.Name))
                .Iter(impl => impl.LocVars.OfType<Variable>()
                    .Where(v => v.Name.StartsWith(permVarNamePrefix))
                    .Iter(v => v.AddAttribute("linear", "Perm")));

            // v != mapconstbool(false)
            var MkAssumeNonEmpty = new Func<Variable, Expr>(v =>
                    Expr.Neq(Expr.Ident(v),
                    new NAryExpr(Token.NoToken, new FunctionCall(mapconstbool), new List<Expr>{Expr.False})));

            // v == mapconstbool(true)
            var MkAssumeFull = new Func<Variable, Expr>(v =>
                Expr.Eq(Expr.Ident(v),
                new NAryExpr(Token.NoToken, new FunctionCall(mapconstbool), new List<Expr>{Expr.True})));

            // func() || expr
            var MkCandidate = new Func<Function, Expr, Expr>((func, expr) =>
                Expr.Or(new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr>()), expr));

            // procs that can do async
            var transitiveAsyncProcs = ReachableFuncs(program, asyncProcs);


            var newFuncs = new HashSet<Function>();
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = impl.Proc;
                var permIn = addVar.getInVar(permVarNamePrefix, proc.Name);
                var permOut = addVar.getVar(permVarNamePrefix, proc.Name);
                
                bool canAsync = transitiveAsyncProcs.Contains(impl.Name);

                // free requires permIn != mapconstbool(false);
                proc.Requires.Add(new Requires(true, MkAssumeNonEmpty(permIn)));

                // TODO: assert that main cannot be called
                // free requires permIn == mapconstbool(true); for main
                if (QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"))
                    proc.Requires.Add(new Requires(true, MkAssumeFull(permIn)));

                if (!asyncProcs.Contains(impl.Name))
                {
                    var func = MkExistentialFuncPerm();
                    // ensures func() || permIn == permOut
                    proc.Ensures.Add(new Ensures(false, MkCandidate(func, Expr.Eq(Expr.Ident(permIn), Expr.Ident(permOut)))));
                    newFuncs.Add(func);
                }


                // One candidate Boolean per procedure
                var afunc = MkExistentialFuncPerm();
                newFuncs.Add(afunc);

                proc.Requires.Add(new Requires(false, MkCandidate(afunc, MkAssumeFull(permIn))));

                if (canAsync) afunc = MkExistentialFuncPerm();
                if (!asyncProcs.Contains(impl.Name)) proc.Ensures.Add(new Ensures(false, MkCandidate(afunc, MkAssumeFull(permOut))));
                newFuncs.Add(afunc);

                // On each yield, add:
                //   assert foo() || permOut == mapconstbool(true)
                //   assume permOut != mapconstbool(false)
                //   assume permOut[id];
                // At a call site
                //   call permOut, permOut2 := Split(permOut);
                //   async call foo(permOut2);

                var permOut2 = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, permVarNamePrefix + "Out2", settype));
                permOut2.AddAttribute("linear", "Perm");
                var addLocal = false;

                var id = threadInstanceID.ContainsKey(impl.Name) ? threadInstanceID[impl.Name] : -1;
                var assumeSingleInstance = BoogieAstFactory.MkAssume(BoogieAstFactory.MkMapAccessExpr(permOut, Expr.Literal(id)));

                if(id >= 0)
                   impl.Proc.Requires.Add(new Requires(true, BoogieAstFactory.MkMapAccessExpr(permIn, Expr.Literal(id))));

                var callSplit = new CallCmd(Token.NoToken, "SplitPerm", new List<Expr>{Expr.Ident(permOut)}, new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(permOut), Expr.Ident(permOut2) }));
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    for(int i = 0; i < blk.Cmds.Count; i++)
                    {
                        var cmd = blk.Cmds[i];
                        if (cmd is YieldCmd)
                        {
                            ncmds.Add(cmd);
                            // gather the associated asserts first
                            int j = i + 1;
                            while (j < blk.Cmds.Count && blk.Cmds[j] is AssertCmd)
                            {
                                ncmds.Add(blk.Cmds[j]);
                                j++;
                            }
                            i = j - 1;
                            if(canAsync) afunc = MkExistentialFuncPerm();
                            ncmds.Add(new AssertCmd(Token.NoToken, MkCandidate(afunc, MkAssumeFull(permOut))));
                            ncmds.Add(new AssumeCmd(Token.NoToken, MkAssumeNonEmpty(permOut)));
                            if (id >= 0) ncmds.Add(assumeSingleInstance);
                            newFuncs.Add(afunc);
                        }
                        else if (cmd is CallCmd && (cmd as CallCmd).IsAsync)
                        {
                            ncmds.Add(callSplit);
                            addLocal = true;

                            var ccmd = cmd as CallCmd;
                            // replace permOut with permOut2 in the arguments
                            for (int j = 0; j < ccmd.Ins.Count; j++)
                            {
                                if (ccmd.Ins[j] is IdentifierExpr && (ccmd.Ins[j] as IdentifierExpr).Name == permOut.Name)
                                    ccmd.Ins[j] = Expr.Ident(permOut2);
                            }

                            ncmds.Add(cmd);
                        } 
                        else
                        {
                            ncmds.Add(cmd);
                        }

                    }
                    blk.Cmds = ncmds;
                }

                if (addLocal)
                    impl.LocVars.Add(permOut2);
            }

            program.AddTopLevelDeclarations(newFuncs);

            // Insert the Split procedure as a string
            BoogieUtil.PrintProgram(program, "temp_rar.bpl");
            System.IO.File.AppendAllText("temp_rar.bpl",
                string.Format(@"{0}procedure SplitPerm({{:linear ""Perm""}} xls: [int]bool) returns ({{:linear ""Perm""}} xls1: [int]bool, {{:linear ""Perm""}} xls2: [int]bool);" +
            "{0}ensures xls == {1}(xls1, xls2) && xls1 != {2}(false) && xls2 != {2}(false);{0}", Environment.NewLine, mapunion.Name, mapconstbool.Name));

            program = BoogieUtil.ReadAndOnlyResolve("temp_rar.bpl");

            return program;
        }

        // return the list of procedures that can reach a procedure in "targets"
        private static HashSet<string> ReachableFuncs(Program program, HashSet<string> targets)
        {
            
            // get backward call graph
            var callGraph = new Dictionary<string, HashSet<string>>();

            var processCallCmd = new Action<CallCmd,Implementation>((cmd,impl) =>
                {
                    if (!callGraph.ContainsKey(cmd.callee))
                        callGraph.Add(cmd.callee, new HashSet<string>());
                    callGraph[cmd.callee].Add(impl.Name);
                });

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Iter(cmd => processCallCmd(cmd,impl))));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<ParCallCmd>()
                        .Iter(pcmd => pcmd.CallCmds
                            .Iter(cmd => processCallCmd(cmd, impl)))));

            var ret = new HashSet<string>();
            var delta = new HashSet<string>();
            delta.UnionWith(targets);
            ret.UnionWith(targets);
            while (delta.Any())
            {
                var next = new HashSet<string>();
                delta.Where(c => callGraph.ContainsKey(c)).Iter(c => next.UnionWith(callGraph[c]));
                delta = next.Difference(ret);
                ret.UnionWith(next);
            }
            return ret;
        }

        // return:
        //   function {:existential true} {:absdomain "IA[HoudiniConst]"} {:chignore} name(): bool;
        static int existentialFuncPermCounter = 0;
        private static Function MkExistentialFuncPerm()
        {
            var name = "ch_bool_" + existentialFuncPermCounter.ToString();
            existentialFuncPermCounter++;

            var func = new Function(Token.NoToken, name,
                new List<Variable>(),
                    new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "y", btype.Bool), true));

            func.AddAttribute("existential", Expr.Literal(true));
            func.AddAttribute("absdomain", "IA[HoudiniConst]");
            func.AddAttribute("chignore");

            return func;
        }

        private static Procedure CreateAllocateTid()
        {
            var formalOut = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Int), false);
            formalOut.AddAttribute("linear", "Tid");

            var allocate = new Procedure(Token.NoToken, "AllocateTid", new List<TypeVariable>(), new List<Variable>(),
                new List<Variable> { formalOut }, new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());

            allocate.Ensures.Add(new Ensures(false, Expr.Neq(Expr.Ident(formalOut), Expr.Literal(0))));

            return allocate;
        }

        public static Program InstrumentTid(Program program)
        {
            // check if we even need to instrument for tid or not
            if (!program.TopLevelDeclarations.OfType<Procedure>()
                .Any(proc => proc.Name == Driver.con.corralTidProc)
                &&
                !program.TopLevelDeclarations.OfType<Function>()
                .Any(func => func.Name == Driver.con.tidFunc))
            {
                return program;
            }

            // Get hold of all implementations
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            // Gather list of async-ed procedures
            var asyncProcs = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .Iter(proc => asyncProcs.Add(proc.Name));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Where(cmd => cmd.IsAsync)
                        .Iter(cmd => asyncProcs.Add(cmd.callee))));

            var tidVarNamePrefix = "tid_linear_guy";
            var addVars = new AddTaskLocalVars(asyncProcs, tidVarNamePrefix, Microsoft.Boogie.Type.Int);
            addVars.run(program);

            program = BoogieUtil.ReResolve(program, "og__temp.bp");

            var allocate = CreateAllocateTid();
            program.AddTopLevelDeclaration(allocate);

            // Add {:linear "Tid"} annotation
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(decl => decl.InParams.OfType<Variable>()
                    .Concat(decl.OutParams.OfType<Variable>())
                    .Where(v => v.Name.StartsWith(tidVarNamePrefix))
                    .Iter(v => v.AddAttribute("linear", "Tid")));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => asyncProcs.Contains(impl.Name))
                .Iter(impl => impl.LocVars.OfType<Variable>()
                    .Where(v => v.Name.StartsWith(tidVarNamePrefix))
                    .Iter(v => v.AddAttribute("linear", "Tid")));


            // create a local variable for the next Tid value
            var lv = BoogieAstFactory.MkLocal(tidVarNamePrefix + "_child", Microsoft.Boogie.Type.Int);
            lv.AddAttribute("linear", "Tid");

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.LocVars.Add(lv);
                var tidin = addVars.getInVar(tidVarNamePrefix, impl.Name);
                var tidout = addVars.getInVar(tidVarNamePrefix, impl.Name);
                impl.Proc.Requires.Add(new Requires(true, Expr.Neq(Expr.Ident(tidin), Expr.Literal(0))));
                if(!asyncProcs.Contains(impl.Name))
                  impl.Proc.Ensures.Add(new Ensures(true, Expr.Eq(Expr.Ident(tidin), Expr.Ident(tidout))));
                //var tidout = addVars.getVar(tidVarNamePrefix, impl.Name);
                //if(QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"))
                //    impl.Blocks[0].Cmds.Add(BoogieAstFactory.MkAssume(Expr.Neq(Expr.Ident(tidout), Expr.Literal(0))));
            }

            // Instrument TidFunc()
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var proc = impl.Proc;
                var tidIn = addVars.getInVar(tidVarNamePrefix, proc.Name);
                var tidOut = addVars.getVar(tidVarNamePrefix, proc.Name);

                foreach (Requires req in proc.Requires)
                {
                    var rf = new ReplaceTid(tidIn);
                    rf.VisitRequires(req);
                }

                foreach (Ensures ens in proc.Ensures)
                {
                    var rf = new ReplaceTid(tidOut);
                    rf.VisitEnsures(ens);
                }

                var rt = new ReplaceTid(tidOut);
                impl.Blocks = rt.VisitBlockList(impl.Blocks);
            }

            // Instrument
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var tidOut = addVars.getVar(tidVarNamePrefix, impl.Name);

                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd != null && ccmd.callee == Driver.con.corralTidProc)
                        {
                            ncmds.Add(BoogieAstFactory.MkVarEqVar(ccmd.Outs[0].Decl, tidOut));
                            continue;
                        }
                        if (ccmd != null && ccmd.IsAsync)
                        {
                            // tid_child := Allocate()
                            ncmds.Add(BoogieAstFactory.MkCall(allocate, new List<Expr>(), new List<Variable> { lv }));

                            // replace tid_out with tid_child
                            for (int i = 0; i < ccmd.Ins.Count; i++)
                            {
                                var ie = ccmd.Ins[i] as IdentifierExpr;
                                if (ie == null || !ie.Name.StartsWith(tidVarNamePrefix))
                                    continue;
                                ccmd.Ins[i] = Expr.Ident(lv);
                            }
                            ncmds.Add(ccmd);
                            continue;
                        }
                        ncmds.Add(cmd);
                    }
                    blk.Cmds = ncmds;
                }
            }

            return program;
        }

        class ReplaceTid : FixedVisitor
        {
            Variable tid;
            public ReplaceTid(Variable tid)
            {
                this.tid = tid;
            }

            public override Expr VisitNAryExpr(NAryExpr node)
            {
                if (node.Fun is FunctionCall && (node.Fun as FunctionCall).FunctionName == Driver.con.tidFunc)
                {
                    return Expr.Ident(tid);
                }
                return base.VisitNAryExpr(node);
            }
        }

        static int newBlockCounter = 0;
        static string getNewLabel()
        {
            return "nlabel" + (newBlockCounter++).ToString();
        }

        public static Program InstrumentAtomicBlocks(Program program)
        {
            // check if we need to instrument here or not
            if (!program.TopLevelDeclarations.OfType<Procedure>()
                .Any(proc => proc.Name == Driver.con.atomicBegProc ||
                proc.Name == Driver.con.atomicEndProc))
            {
                return program;
            }

            // Get hold of all implementations
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            // Gather list of async-ed procedures
            var asyncProcs = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .Iter(proc => asyncProcs.Add(proc.Name));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Where(cmd => cmd.IsAsync)
                        .Iter(cmd => asyncProcs.Add(cmd.callee))));


            var addVars = new AddTaskLocalVars(asyncProcs, "InAtomicBlock", Microsoft.Boogie.Type.Bool);
            addVars.run(program);

            // Instrument:
            // -- Initialize InAtomicBlock for entry procedures to async calls
            // -- corral_atomic_begin and corral_atomic_end
            // -- disable yields

            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => asyncProcs.Contains(impl.Name))
                .Select(impl => impl.Proc)
                .Iter(proc =>
                        proc.Requires.Add(new Requires(true, Expr.Not(Expr.Ident(addVars.getInVar("InAtomicBlock", proc.Name))))));

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                var ab = addVars.getVar("InAtomicBlock", impl.Name);

                var newBlocks = new List<Block>();
                foreach (var blk in impl.Blocks)
                {
                    var currLabel = blk.Label;
                    var currCmds = new List<Cmd>();

                    for(int i = 0; i < blk.Cmds.Count; i++)
                    {
                        var cmd = blk.Cmds[i];
                        var ccmd = cmd as CallCmd;
                        if (ccmd != null && ccmd.callee == Driver.con.atomicBegProc)
                        {
                            currCmds.Add(BoogieAstFactory.MkVarEqConst(ab, true));
                            continue;
                        }
                        if (ccmd != null && ccmd.callee == Driver.con.atomicEndProc)
                        {
                            currCmds.Add(BoogieAstFactory.MkVarEqConst(ab, false));
                            continue;
                        }
                        if (cmd is YieldCmd)
                        {
                            var lab1 = getNewLabel();
                            var lab2 = getNewLabel();

                            newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, BoogieAstFactory.MkGotoCmd(lab1, lab2)));
                            currCmds = new List<Cmd>();
                            currCmds.Add(BoogieAstFactory.MkAssumeVarEqConst(ab, false));
                            currCmds.Add(new YieldCmd(Token.NoToken));

                            int j = i + 1;
                            // Gather the associated asserts to this yield
                            while (j < blk.Cmds.Count && blk.Cmds[j] is AssertCmd)
                            {
                                currCmds.Add(blk.Cmds[j]);
                                j++;
                            }
                            i = j - 1;


                            newBlocks.Add(new Block(Token.NoToken, lab1, currCmds, BoogieAstFactory.MkGotoCmd(lab2)));

                            currLabel = lab2;
                            currCmds = new List<Cmd>();
                            continue;
                        }
                        currCmds.Add(cmd);
                    }
                    newBlocks.Add(new Block(Token.NoToken, currLabel, currCmds, blk.TransferCmd));
                }
                impl.Blocks = newBlocks;

            }

            program = BoogieUtil.ReResolve(program, "og__temp.bp");

            return program;
        }


        // Insert yield before access to a global variable.
        public static Program InsertYields(Program program)
        {
            // Gather list of modified globals
            BoogieUtil.DoModSetAnalysis(program);
            var modGlobals = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Proc.Modifies.OfType<IdentifierExpr>()
                    .Iter(ie => modGlobals.Add(ie.Name)));

            // Gather list of async-ed procedures
            var asyncProcs = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(proc => QKeyValue.FindBoolAttribute(proc.Attributes, "entrypoint"))
                .Iter(proc => asyncProcs.Add(proc.Name));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impl.Blocks
                    .Iter(block => block.Cmds.OfType<CallCmd>()
                        .Where(cmd => cmd.IsAsync)
                        .Iter(cmd => asyncProcs.Add(cmd.callee))));

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (asyncProcs.Contains(impl.Name))
                {
                    // insert yield at beginning
                    var ncmds = new List<Cmd>{new YieldCmd(Token.NoToken)};
                    ncmds.AddRange(impl.Blocks[0].Cmds);
                    impl.Blocks[0].Cmds = ncmds;
                }

                // And before each statement that accesses globals
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        var gu = new GlobalVarsUsed();
                        gu.Visit(cmd);
                        if (gu.globalsUsed.Intersection(modGlobals).Any())
                        {
                            ncmds.Add(new YieldCmd(Token.NoToken));
                        }
                        ncmds.Add(cmd);
                    }
                    blk.Cmds = ncmds;

                }
            }

            BoogieUtil.DoModSetAnalysis(program);
            return program;
        }

        // Replace corral_yield(e) with "yield; assert e"
        public static Program RemoveCorralYield(Program program, string corral_yield)
        {
            var cy = program.TopLevelDeclarations.OfType<Procedure>()
                .FirstOrDefault(proc => proc.Name == corral_yield);
            if (cy == null) return program;

            if (cy.InParams.Count != 1)
                throw new Exception("ConcurrentHoudini expects that corral_yield has 1 argument");

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (var cmd in blk.Cmds)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd == null || ccmd.callee != cy.Name)
                        {
                            ncmds.Add(cmd);
                            continue;
                        }
                        ncmds.Add(new YieldCmd(Token.NoToken));
                        ncmds.Add(cba.Util.BoogieAstFactory.MkAssert(ccmd.Ins[0]));
                    }
                    blk.Cmds = ncmds;
                }
            }

            return program;
        }


        // Add guards to add assertions
        public static Program GuardAsserts(Program program)
        {
            int counter = 0;
            var GetExistentialFunc = new Func<Function>(() =>
                {
                    var name = "AssertGuard" + (counter++).ToString();
                    var ret = new Function(Token.NoToken, name, new List<Variable>(),
                        BoogieAstFactory.MkFormal("x", btype.Bool, false));
                    ret.AddAttribute("existential", Expr.Literal(true));
                    ret.AddAttribute("absdomain", "IA[HoudiniConst]");
                    ret.AddAttribute("assertGuard");
                    return ret;
                });

            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            var newFuncs = new List<Function>();

            // Guard requires and ensures
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                if (QKeyValue.FindBoolAttribute(proc.Attributes, "template"))
                    continue;

                foreach (var req in proc.Requires)
                {
                    if (req.Free) continue;
                    var func = GetExistentialFunc();
                    req.Condition = Expr.Or(new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr>()), req.Condition);
                    req.Attributes = new QKeyValue(Token.NoToken, "guarded", new List<object>(), req.Attributes);
                    newFuncs.Add(func);
                }

                if (impls.Contains(proc.Name))
                {
                    foreach (var ens in proc.Ensures)
                    {
                        if (ens.Free) continue;
                        var func = GetExistentialFunc();
                        ens.Condition = Expr.Or(new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr>()), ens.Condition);
                        ens.Attributes = new QKeyValue(Token.NoToken, "guarded", new List<object>(), ens.Attributes);
                        newFuncs.Add(func);
                    }
                }
            }

            // Guard assertions
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    foreach (var cmd in blk.Cmds.OfType<AssertCmd>())
                    {
                        if (cmd.Expr is LiteralExpr && (cmd.Expr as LiteralExpr).IsTrue) continue;

                        var func = GetExistentialFunc();
                        cmd.Expr = Expr.Or(new NAryExpr(Token.NoToken, new FunctionCall(func), new List<Expr>()), cmd.Expr);
                        cmd.Attributes = new QKeyValue(Token.NoToken, "guarded", new List<object>(), cmd.Attributes);
                        newFuncs.Add(func);
                   }
                }
            }

            program.AddTopLevelDeclarations(newFuncs);
            return BoogieUtil.ReResolve(program);
        }

        // Convert proved asserts to assumes
        public static Program PruneProvedAsserts(Program program, Func<string,bool> proved)
        {
            var mineExpr = new Func<Expr, Tuple<Expr, bool>>(inexpr =>
                {
                    var expr = inexpr as NAryExpr;
                    Debug.Assert(expr != null);
                    Debug.Assert(expr.Fun is BinaryOperator && (expr.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Or);
                    var func = expr.Args[0] as NAryExpr;
                    Debug.Assert(func != null);
                    Debug.Assert(func.Fun is FunctionCall);
                    var prune = proved((func.Fun as FunctionCall).FunctionName);
                    return Tuple.Create(expr.Args[1], prune);
                });

            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                for (int i = 0; i < proc.Requires.Count; i++)
                {
                    var req = proc.Requires[i];
                    if (!QKeyValue.FindBoolAttribute(req.Attributes, "guarded"))
                    {
                        proc.Requires[i] = new Requires(req.tok, true, req.Condition, req.Comment, req.Attributes);
                        continue;
                    }

                    var me = mineExpr(req.Condition);
                    proc.Requires[i] = new Requires(req.tok, me.Item2, me.Item1, req.Comment, BoogieUtil.removeAttr("guarded", req.Attributes));
                }

                for (int i = 0; i < proc.Ensures.Count; i++)
                {
                    var ens = proc.Ensures[i];
                    if (!QKeyValue.FindBoolAttribute(ens.Attributes, "guarded"))
                    {
                        proc.Ensures[i] = new Ensures(ens.tok, true, ens.Condition, ens.Comment, ens.Attributes);
                        continue;
                    }

                    var me = mineExpr(ens.Condition);
                    proc.Ensures[i] = new Ensures(ens.tok, me.Item2, me.Item1, null, BoogieUtil.removeAttr("guarded", ens.Attributes));
                }
            }

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count; i++)
                    {
                        var acmd = blk.Cmds[i] as AssertCmd;
                        if (acmd == null) continue;
                        if ((acmd.Expr is LiteralExpr) && (acmd.Expr as LiteralExpr).IsTrue) continue;

                        if (!QKeyValue.FindBoolAttribute(acmd.Attributes, "guarded"))
                        {
                            blk.Cmds[i] = new AssumeCmd(acmd.tok, acmd.Expr);
                            continue;
                        }

                        var me = mineExpr(acmd.Expr);
                        if (me.Item2)
                            blk.Cmds[i] = new AssumeCmd(acmd.tok, me.Item1);
                        else
                            blk.Cmds[i] = new AssertCmd(acmd.tok, me.Item1);
                    }
                }

            }

            return BoogieUtil.ReResolve(program);
        }



        // Convert requires and ensures to "assumes"
        public static Program RemoveRequiresAndEnsures(Program program)
        {
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                RemoveRequiresAndEnsures(impl);

            return program;
        }

        static void RemoveRequiresAndEnsures(Implementation impl)
        {
            var ensures = impl.Proc.Ensures;
            var requires = impl.Proc.Requires;

            impl.Proc.Ensures = new List<Ensures>();
            impl.Proc.Requires = new List<Requires>();

            var reqCmds = new List<Cmd>();
            var ensCmds = new List<Cmd>();
            var newLocs = new List<Variable>();

            var substOld = new cba.SubstOldVars();
            foreach (Ensures e in ensures)
            {
                var expr = substOld.VisitExpr(e.Condition);
                ensCmds.Add(new AssumeCmd(Token.NoToken, expr));
            }

            foreach (Requires r in requires)
            {
                var vu = new VarsUsed();
                vu.VisitRequires(r);
                Debug.Assert(vu.oldVarsUsed.Count == 0);
                reqCmds.Add(new AssumeCmd(Token.NoToken, r.Condition));
            }

            reqCmds.AddRange(substOld.initLocVars);
            
            substOld.varMap.Values.Iter(lv => newLocs.Add(lv));

            impl.LocVars.AddRange(newLocs);

            reqCmds.AddRange(impl.Blocks[0].Cmds);
            impl.Blocks[0].Cmds = reqCmds;

            foreach (var blk in impl.Blocks)
            {
                var rc = blk.TransferCmd as ReturnCmd;
                if (rc == null) continue;
                blk.Cmds.AddRange(ensCmds);
            }
        }

        public static Program RemoveThreadIdFunc(Program program)
        {
            // create a local variable for tid
            var lv = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "$local_tid_tt", Microsoft.Boogie.Type.Int));
            var tidProc = program.TopLevelDeclarations.OfType<Procedure>().FirstOrDefault(proc => proc.Name == Driver.con.corralTidProc);
            if (tidProc == null)
            {
                tidProc = new Procedure(Token.NoToken, Driver.con.corralTidProc, new List<TypeVariable>(), new List<Variable>(),
                    new List<Variable>(new Variable[] { new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "tid", Microsoft.Boogie.Type.Int), false) }),
                    new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                program.AddTopLevelDeclaration(tidProc);
            }
            var getTid = new CallCmd(Token.NoToken, tidProc.Name, new List<Expr>(), new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(lv) }));
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                impl.LocVars.Add(lv);
                var ncmds = new List<Cmd>{getTid};
                ncmds.AddRange(impl.Blocks[0].Cmds);
                impl.Blocks[0].Cmds = ncmds;
                var rt = new ReplaceTid(lv);
                rt.VisitImplementation(impl);
            }
            return program;
        }


        public static void PrintError(Counterexample error)
        {
            if (error is CallCounterexample)
            {
                CallCounterexample err = (CallCounterexample)error;
                if (!CommandLineOptions.Clo.ForceBplErrors && err.FailingRequires.ErrorMessage != null)
                {
                    ReportBplError(err.FailingRequires, err.FailingRequires.ErrorMessage, true, false);
                }
                else
                {
                    ReportBplError(err.FailingCall, "Error BP5002: A precondition for this call might not hold.", true, true);
                    ReportBplError(err.FailingRequires, "Related location: This is the precondition that might not hold.", false, true);
                }
                if (CommandLineOptions.Clo.XmlSink != null)
                {
                    CommandLineOptions.Clo.XmlSink.WriteError("precondition violation", err.FailingCall.tok, err.FailingRequires.tok, error.Trace);
                }
            }
            else if (error is ReturnCounterexample)
            {
                ReturnCounterexample err = (ReturnCounterexample)error;
                if (!CommandLineOptions.Clo.ForceBplErrors && err.FailingEnsures.ErrorMessage != null)
                {
                    ReportBplError(err.FailingEnsures, err.FailingEnsures.ErrorMessage, true, false);
                }
                else
                {
                    ReportBplError(err.FailingReturn, "Error BP5003: A postcondition might not hold on this return path.", true, true);
                    ReportBplError(err.FailingEnsures, "Related location: This is the postcondition that might not hold.", false, true);
                }
                if (CommandLineOptions.Clo.XmlSink != null)
                {
                    CommandLineOptions.Clo.XmlSink.WriteError("postcondition violation", err.FailingReturn.tok, err.FailingEnsures.tok, error.Trace);
                }
            }
            else // error is AssertCounterexample
            {
                AssertCounterexample err = (AssertCounterexample)error;
                if (err.FailingAssert is LoopInitAssertCmd)
                {
                    ReportBplError(err.FailingAssert, "Error BP5004: This loop invariant might not hold on entry.", true, true);
                    if (CommandLineOptions.Clo.XmlSink != null)
                    {
                        CommandLineOptions.Clo.XmlSink.WriteError("loop invariant entry violation", err.FailingAssert.tok, null, error.Trace);
                    }
                }
                else if (err.FailingAssert is LoopInvMaintainedAssertCmd)
                {
                    // this assertion is a loop invariant which is not maintained
                    ReportBplError(err.FailingAssert, "Error BP5005: This loop invariant might not be maintained by the loop.", true, true);
                    if (CommandLineOptions.Clo.XmlSink != null)
                    {
                        CommandLineOptions.Clo.XmlSink.WriteError("loop invariant maintenance violation", err.FailingAssert.tok, null, error.Trace);
                    }
                }
                else
                {
                    if (!CommandLineOptions.Clo.ForceBplErrors && err.FailingAssert.ErrorMessage != null)
                    {
                        ReportBplError(err.FailingAssert, err.FailingAssert.ErrorMessage, true, false);
                    }
                    else if (err.FailingAssert.ErrorData is string)
                    {
                        ReportBplError(err.FailingAssert, (string)err.FailingAssert.ErrorData, true, true);
                    }
                    else
                    {
                        ReportBplError(err.FailingAssert, "Error BP5001: This assertion might not hold.", true, true);
                    }
                    if (CommandLineOptions.Clo.XmlSink != null)
                    {
                        CommandLineOptions.Clo.XmlSink.WriteError("assertion violation", err.FailingAssert.tok, null, error.Trace);
                    }
                }
            }
            if (CommandLineOptions.Clo.EnhancedErrorMessages == 1)
            {
                foreach (string info in error.relatedInformation)
                {
                    Console.WriteLine("       " + info);
                }
            }
            if (CommandLineOptions.Clo.ErrorTrace > 0)
            {
                Console.WriteLine("Execution trace:");
                error.Print(4, Console.Out);
            }
            if (CommandLineOptions.Clo.ModelViewFile != null)
            {
                error.PrintModel(Console.Out);
            }
        }

        static void ReportBplError(Absy node, string message, bool error, bool showBplLocation)
        {
            IToken tok = node.tok;
            string s;
            if (tok != null && showBplLocation)
            {
                s = string.Format("{0}({1},{2}): {3}", tok.filename, tok.line, tok.col, message);
            }
            else
            {
                s = message;
            }
            if (error)
            {
                ErrorWriteLine(s);
            }
            else
            {
                Console.WriteLine(s);
            }
        }

        public static void ErrorWriteLine(string s)
        {
            if (!s.Contains("Error: ") && !s.Contains("Error BP"))
            {
                Console.WriteLine(s);
                return;
            }
        }

    }

    // Adds task-local variables to a program with posts.
    // It assumes that a procedure is never called in both "async" and "sync" mode
    public class AddTaskLocalVars
    {
        // Versions of varaibles
        Dictionary<string, Formal> var_in;
        Dictionary<string, Formal> var_out_formal;
        Dictionary<string, LocalVariable> var_out_local;

        // original variable name -> name used for formal/local
        Dictionary<string, string> varNameMap;

        // All variable names
        List<string> varNames;

        // Labels of first blocks in implementation (needed for mapBack)
        // proc name -> block label
        Dictionary<string, string> firstBlockLabels;

        // Global counter
        static int counter = 0;

        HashSet<string> asyncProcs;

        public AddTaskLocalVars(HashSet<string> asyncProcs, params object[] taskLocalVars)
        {
            this.asyncProcs = asyncProcs;

            var_in = new Dictionary<string, Formal>();
            var_out_formal = new Dictionary<string, Formal>();
            var_out_local = new Dictionary<string, LocalVariable>();
            varNames = new List<string>();
            varNameMap = new Dictionary<string, string>();

            for (int i = 0; i < taskLocalVars.Length; i += 2)
            {
                Debug.Assert(taskLocalVars[i] is string);
                Debug.Assert(taskLocalVars[i + 1] is Microsoft.Boogie.Type);

                var name = (string)taskLocalVars[i];
                var typ = (Microsoft.Boogie.Type)taskLocalVars[i + 1];

                varNames.Add(name);
                var_in.Add(name, new Formal(Token.NoToken, new TypedIdent(Token.NoToken, name + "_in", typ), true));
                var_out_formal.Add(name, new Formal(Token.NoToken, new TypedIdent(Token.NoToken, name + "_out", typ), false));
                var_out_local.Add(name, new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, name + "_out", typ)));

                varNameMap.Add(name, name + "_out");
            }

            firstBlockLabels = new Dictionary<string, string>();
        }

        public string getOutVarName(string varName)
        {
            return varNameMap[varName];
        }

        public Variable getVar(string varName, string procName)
        {
            if (asyncProcs.Contains(procName))
                return var_out_local[varName];
            return var_out_formal[varName];
        }

        public Formal getInVar(string varName, string procName)
        {
            return var_in[varName];
        }

        public int getPositionFromEnd(string varName)
        {
            var pos = varNames.FindIndex(s => s == varName);
            return varNames.Count - pos;
        }

        public void run(Program program)
        {
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));

            foreach (var decl in program.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;

                // Instrument procedure
                var proc = impl.Proc;

                varNames.Iter(v => proc.InParams.Add(var_in[v]));

                if (!asyncProcs.Contains(impl.Name))
                {
                    varNames.Iter(v => proc.OutParams.Add(var_out_formal[v]));
                }

                // Instrument implementation signature
                varNames.Iter(v => impl.InParams.Add(var_in[v]));

                var var_out = new Dictionary<string, Variable>();

                if (!asyncProcs.Contains(impl.Name))
                {
                    varNames.Iter(v => impl.OutParams.Add(var_out_formal[v]));
                    varNames.Iter(v => var_out.Add(v, var_out_formal[v]));
                }
                else
                {
                    varNames.Iter(v => impl.LocVars.Add(var_out_local[v]));
                    varNames.Iter(v => var_out.Add(v, var_out_local[v]));
                }

                // Add a new block in the beginning
                var cmds = new List<Cmd>();
                varNames.Iter(v => cmds.Add(BoogieAstFactory.MkAssign(var_out[v], Expr.Ident(var_in[v]))));
                var blk = new Block(Token.NoToken, "addvars_start_" + counter.ToString(), cmds, BoogieAstFactory.MkGotoCmd(impl.Blocks[0].Label));
                counter++;
                firstBlockLabels.Add(impl.Name, impl.Blocks[0].Label);

                var newBlocks = new List<Block>();
                newBlocks.Add(blk);
                newBlocks.AddRange(impl.Blocks);

                impl.Blocks = newBlocks;

                // Change the call commands
                foreach (var block in impl.Blocks)
                {
                    for (int i = 0; i < block.Cmds.Count; i++)
                    {
                        var cmd = block.Cmds[i] as CallCmd;
                        if (cmd == null) continue;
                        if (!impls.Contains(cmd.callee)) continue;

                        var newins = new List<Expr>();
                        newins.AddRange(cmd.Ins);
                        varNames.Iter(v => newins.Add(Expr.Ident(var_out[v])));

                        var newouts = new List<IdentifierExpr>();
                        newouts.AddRange(cmd.Outs);
                        
                        if (!cmd.IsAsync)
                        {
                            varNames.Iter(v => newouts.Add(Expr.Ident(var_out[v])));
                        }

                        var newcmd = new CallCmd(Token.NoToken, cmd.callee, newins, newouts, cmd.Attributes, cmd.IsAsync);
                        block.Cmds[i] = newcmd;

                    }
                }
            }
        }
    }


    public class TemplateInstantiator
    {
        public class EExpr
        {
            public Expr expr;
            public int typ;
            public HashSet<string> mustMod;
            public HashSet<string> mustNotMod;
            public QKeyValue annotations;

            public bool IsFree
            {
                get
                {
                    return (typ == 0 || typ == 2 || typ == 4);
                }
            }

            public bool IsRequires
            {
                get
                {
                    return (typ == 2 || typ == 3);
                }
            }

            public bool IsEnsures
            {
                get
                {
                    return (typ == 0 || typ == 1);
                }
            }

            public bool IsYield
            {
                get
                {
                    return (typ == 4 || typ == 5);
                }
            }

            private EExpr()
            {
                this.expr = null;
                typ = 0;
                mustMod = new HashSet<string>();
                mustNotMod = new HashSet<string>();
            }

            public EExpr(Expr expr, bool isEnsures)
                : this()
            {
                this.expr = expr;
                typ = isEnsures ? 1 : 3;
            }

            public EExpr(Ensures ens)
                : this()
            {
                this.expr = ens.Condition;

                if (ens.Free) typ = 0;
                else typ = 1;

                if (QKeyValue.FindBoolAttribute(ens.Attributes, "yields"))
                {
                    if (ens.Free) typ = 4;
                    else typ = 5;
                }

                processAnnotations(ens.Attributes);
            }

            public EExpr(Requires req)
                : this()
            {
                this.expr = req.Condition;
                if (req.Free) typ = 2;
                else typ = 3;
                processAnnotations(req.Attributes);
            }

            private void processAnnotations(QKeyValue attr)
            {
                annotations = attr;

                for (; attr != null; attr = attr.Next)
                {
                    if (attr.Params.Count != 1)
                        continue;
                    if (!(attr.Params[0] is string))
                        continue;

                    var v = (string)attr.Params[0];

                    switch (attr.Key)
                    {
                        case "mustmod": mustMod.Add(v);
                            break;
                        case "mustnotmod": mustNotMod.Add(v);
                            break;
                    }

                }
            }

            public bool Match(Procedure proc)
            {
                var mods = new HashSet<string>();
                proc.Modifies.OfType<IdentifierExpr>()
                    .Iter(ie => mods.Add(ie.Name));

                if (!mustMod.IsSubsetOf(mods)) return false;
                if (mustNotMod.Intersection(mods).Any()) return false;
                return true;
            }

        }

        // Template
        public HashSet<Variable> templateVars;
        public HashSet<Function> templateFunctions;
        public List<EExpr> templates;
        private HashSet<string> templateVarNames;
        
        // Other info
        Dictionary<string, Variable> globals;

        // created existential functions
        List<Function> newExistentialFunctions;

        public TemplateInstantiator(Program program)
        {
            this.templates = new List<EExpr>();
            this.templateVars = new HashSet<Variable>();
            this.templateFunctions = new HashSet<Function>();
            this.templateVarNames = new HashSet<string>();
            this.globals = new Dictionary<string, Variable>();
            this.newExistentialFunctions = new List<Function>();

            // Find the template variables
            program.TopLevelDeclarations.OfType<GlobalVariable>()
                .Where(g => QKeyValue.FindBoolAttribute(g.Attributes, "template"))
                .Iter(g => templateVars.Add(g));

            // Find the template functions
            program.TopLevelDeclarations.OfType<Function>()
                .Where(f => QKeyValue.FindBoolAttribute(f.Attributes, "template"))
                .Iter(f => templateFunctions.Add(f));

            // Now the template expressions
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => QKeyValue.FindBoolAttribute(p.Attributes, "template")))
            {
                foreach (var req in proc.Requires)
                    templates.Add(new EExpr(req));

                foreach (var ens in proc.Ensures)
                    templates.Add(new EExpr(ens));
            }

            templateVars.Iter(v => templateVarNames.Add(v.Name));

            // Gather globals
            program.TopLevelDeclarations
                .OfType<Variable>()
                .Where(v => !QKeyValue.FindBoolAttribute(v.Attributes, "template"))
                .Iter(c => globals.Add(c.Name, c));

        }

        private List<Expr> InstantiateTemplate(Expr template,
            Dictionary<string, Variable> globals, Dictionary<string, Variable> formals)
        {
            var ret = new List<Expr>();

            var dup = new FixedDuplicator();
            var gused = new GlobalVarsUsed();
            gused.VisitExpr(template);

            if (gused.globalsUsed.Any(g => !globals.ContainsKey(g) && !templateVarNames.Contains(g)))
                return ret;

            var templateVarUsed = gused.globalsUsed.Intersection(templateVarNames);
            if (templateVarUsed.Count == 0)
            {
                ret.Add(dup.VisitExpr(template));
                return ret;
            }

            Debug.Assert(templateVarUsed.Count == 1, "Can only handle 1 template variable per expression");
            var tvName = templateVarUsed.First();
            var tv = templateVars.First(v => v.Name == tvName);

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

                var subst = new Dictionary<string, Variable>();
                subst.Add(tvName, kvp.Value);

                var e = dup.VisitExpr(template);
                e = (new VarSubstituter(subst, globals)).VisitExpr(e);
                ret.Add(e);
            }

            return ret;
        }


        // create new existential functions for the template ones
        private Expr InstantiateFunctions(Expr expr)
        {
            var fs = new FunctionSubstituter(new Func<Function, Function>(f => GetNewFunction(f)));
            return fs.VisitExpr(expr);
        }

        private static int Counter = 0;
        private Function GetNewFunction(Function func)
        {
            if (!templateFunctions.Contains(func))
                return null;

            var dup = new FixedDuplicator();
            var f = dup.VisitFunction(func);

            f.Name += Counter.ToString();
            f.Attributes = BoogieUtil.removeAttr("template", f.Attributes);

            newExistentialFunctions.Add(f);

            Counter++;
            return f;
        }

        public void Instantiate(Program program)
        {
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(Instantiate);

            program.AddTopLevelDeclarations(newExistentialFunctions);

            program.RemoveTopLevelDeclarations(decl => QKeyValue.FindBoolAttribute(decl.Attributes, "template"));
        }

        public void Instantiate(Implementation impl)
        {
            var proc = impl.Proc;
            var entry = QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint");

            var formals = new Dictionary<string, Variable>();
            var formalIns = new Dictionary<string, Variable>();

            proc.InParams.OfType<Formal>()
                .Iter(f => formals.Add(f.Name, f));
            proc.OutParams.OfType<Formal>()
                .Iter(f => formals.Add(f.Name, f));
            proc.InParams.OfType<Formal>()
                .Iter(f => formalIns.Add(f.Name, f));

            foreach (var template in templates)
            {
                var allExprs = InstantiateTemplate(template.expr, globals, template.IsRequires ? formalIns : formals);
                var dup = new Converter<Expr, Expr>(expr => (new FixedDuplicator(true).VisitExpr(expr)));

                if (template.IsEnsures && !entry)
                {
                    var allExprsInstantiated = allExprs.Map(new Converter<Expr, Expr>(InstantiateFunctions));
                    allExprsInstantiated.Iter(expr =>
                        proc.Ensures.Add(new Ensures(template.IsFree, expr)));
                }
                else if (template.IsRequires && !entry)
                {
                    var allExprsInstantiated = allExprs.Map(new Converter<Expr, Expr>(InstantiateFunctions));
                    allExprsInstantiated.Iter(expr =>
                        proc.Requires.Add(new Requires(template.IsFree, expr)));
                }
                else if (template.IsYield)
                {
                    foreach (var blk in impl.Blocks)
                    {
                        var ncmds = new List<Cmd>();
                        foreach (var cmd in blk.Cmds)
                        {
                            ncmds.Add(cmd);
                            if (cmd is YieldCmd)
                            {
                                var allExprsInstantiated = allExprs.Map(dup).Map(new Converter<Expr, Expr>(InstantiateFunctions));
                                allExprsInstantiated.Iter(expr =>
                                    ncmds.Add(new AssertCmd(Token.NoToken, expr)));
                            }
                        }
                        blk.Cmds = ncmds;
                    }
                }
            }
        }
    }

    public class FunctionSubstituter : FixedVisitor
    {
        private Func<Function, Function> funcs;

        public FunctionSubstituter(Func<Function, Function> funcs)
        {
            this.funcs = funcs;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                var fc = node.Fun as FunctionCall;
                if (fc.Func != null)
                {
                    var nf = funcs(fc.Func);
                    if (nf != null)
                        node.Fun = new FunctionCall(nf);
                }
            }

            return base.VisitNAryExpr(node);
        }

    }


}
