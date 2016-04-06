using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using Microsoft.Boogie.Houdini;
using cba;

namespace CoreLib
{
    // For SDV: Given a program (representing a path) that is SAT, add concretization
    // to determinize the trace
    public class SDVConcretizePathPass : CompilerPass
    {
        public bool success;
        readonly string recordProcNameInt = "boogie_si_record_sdvcp_int";
        readonly string recordProcNameBool = "boogie_si_record_sdvcp_bool";
        readonly string recordProcNameCtor = "boogie_si_record_sdvcp_ctor_";
        readonly string initLocProcName = "init_locals_nondet_tmp_";
        public static readonly string LocalVarInitValueAttr = "InitLocalVar";
        public Dictionary<string, int> allocConstants;

        private HashSet<string> procsWithoutBody;
        private Dictionary<string, Procedure> typeToRecordProc;
        private Dictionary<string, Procedure> typeToInitLocalsProc;
 
        public SDVConcretizePathPass()
        {
            success = false;
            procsWithoutBody = new HashSet<string>();
            allocConstants = new Dictionary<string, int>();
            typeToRecordProc = new Dictionary<string, Procedure>();
            typeToInitLocalsProc = new Dictionary<string, Procedure>();
        }

        public override CBAProgram runCBAPass(CBAProgram p)
        {
            p.Typecheck();

            p.TopLevelDeclarations.OfType<Procedure>().Iter(proc => procsWithoutBody.Add(proc.Name));
            p.TopLevelDeclarations.OfType<Implementation>().Iter(impl => procsWithoutBody.Remove(impl.Name));

            // remove malloc
            //procsWithoutBody.RemoveWhere(str => str.Contains("malloc"));

            // Make sure that procs without a body don't modify globals
            foreach (var proc in p.TopLevelDeclarations.OfType<Procedure>().Where(proc => procsWithoutBody.Contains(proc.Name)))
            {
                if (proc.Modifies.Count > 0 && !BoogieUtil.checkAttrExists("allocator", proc.Attributes))
                    throw new InvalidInput("Produce Bug Witness: Procedure " + proc.Name + " modifies globals");
            }

            // Add the boogie_si_record_int procedure
            var inpVarInt = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Int), true);
            var inpVarBool = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", Microsoft.Boogie.Type.Bool), true);

            var reProcInt = new Procedure(Token.NoToken, recordProcNameInt, new List<TypeVariable>(), new List<Variable> { inpVarInt }, new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
            var reProcBool = new Procedure(Token.NoToken, recordProcNameBool, new List<TypeVariable>(), new List<Variable> { inpVarBool }, new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());

            // Add procedures for initialization of local variables
            foreach (var impl in p.TopLevelDeclarations.OfType<Implementation>())
            {
                var ncmds = new List<Cmd>();
                foreach (var loc in (impl.LocVars.Concat(impl.OutParams)))
                {
                    var cc = new CallCmd(Token.NoToken, GetInitLocalsProc(loc.TypedIdent.Type).Name, new List<Expr>(), new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(loc) }));
                    cc.Attributes = new QKeyValue(Token.NoToken, RestrictToTrace.ConcretizeConstantNameAttr, new List<object> { LocalVarInitValueAttr }, cc.Attributes);
                    cc.Proc = GetInitLocalsProc(loc.TypedIdent.Type);
                    ncmds.Add(cc);
                }
                ncmds.AddRange(impl.Blocks[0].Cmds);
                impl.Blocks[0].Cmds = ncmds;
            }
            typeToInitLocalsProc.Values.Iter(pr => procsWithoutBody.Add(pr.Name));
            typeToInitLocalsProc.Values.Iter(pr => p.AddTopLevelDeclaration(pr));

            // save the current program
            var fd = new FixedDuplicator(true);
            var modInpProg = fd.VisitProgram(p);

            // Instrument to record stuff
            p.TopLevelDeclarations.OfType<Implementation>().Iter(impl =>
                impl.Blocks.Iter(b => instrument(b)));

            // Name clash if this assert fails
            Debug.Assert(BoogieUtil.findProcedureDecl(p.TopLevelDeclarations, recordProcNameInt) == null);
            Debug.Assert(BoogieUtil.findProcedureDecl(p.TopLevelDeclarations, recordProcNameBool) == null);
            foreach (var rp in typeToRecordProc.Values)
                Debug.Assert(BoogieUtil.findProcedureDecl(p.TopLevelDeclarations, rp.Name) == null);

            p.AddTopLevelDeclaration(reProcInt);
            p.AddTopLevelDeclaration(reProcBool);
            p.AddTopLevelDeclarations(typeToRecordProc.Values);

            var tmainimpl = BoogieUtil.findProcedureImpl(p.TopLevelDeclarations, p.mainProcName);
            if (!QKeyValue.FindBoolAttribute(tmainimpl.Attributes, "entrypoint"))
                tmainimpl.AddAttribute("entrypoint");

            var program = new PersistentCBAProgram(p, p.mainProcName, 0);
            //program.writeToFile("beforeverify.bpl");
            var vp = new VerificationPass(true);
            vp.run(program);

            success = vp.success;
            if (success) return null;

            var trace = mapBackTraceRecord(vp.trace);

            RestrictToTrace.addConcretization = true;
            RestrictToTrace.addConcretizationAsConstants = true;
            var tinfo = new InsertionTrans();
            var rt = new RestrictToTrace(modInpProg, tinfo);
            rt.addTrace(trace);
            RestrictToTrace.addConcretization = false;
            RestrictToTrace.addConcretizationAsConstants = false;

            var rtprog = rt.getProgram();

            // Build a map of where the alloc constants are from
            allocConstants = rt.concretizeConstantToCall;

            // Add symbolic constants for angelic map havocs
            var newDecls = new List<Constant>();
            rtprog.TopLevelDeclarations.OfType<Implementation>().Iter(impl =>
                impl.Blocks.Iter(b => instrumentMapHavocs(b, allocConstants, newDecls)));
            rtprog.AddTopLevelDeclarations(newDecls);

            /*
            foreach (var impl in rtprog.TopLevelDeclarations.OfType<Implementation>())
            {
                // strip _trace from the impl name
                var implName = impl.Name;
                var c = implName.LastIndexOf("_trace");
                while (c != -1)
                {
                    implName = implName.Substring(0, c);
                    c = implName.LastIndexOf("_trace");
                }

                var vu = new VarsUsed();
                vu.VisitImplementation(impl);
                vu.varsUsed.Where(s => s.StartsWith("alloc_"))
                    .Iter(s => allocConstants[s] = implName);
            }
            */
            BoogieUtil.findProcedureImpl(rtprog.TopLevelDeclarations, rt.getFirstNameInstance(p.mainProcName))
                .AddAttribute("entrypoint");

            program = new PersistentCBAProgram(rtprog, rt.getFirstNameInstance(p.mainProcName), p.contextBound);

            // Lets inline it all
            var inlp = new InliningPass(1);
            program = inlp.run(program);

            var compress = new CompressBlocks();
            var ret = program.getProgram();
            compress.VisitProgram(ret);


            return new CBAProgram(ret, program.mainProcName, 0);
        }


        private void instrument(Block block)
        {
            var newCmds = new List<Cmd>();
            foreach (Cmd cmd in block.Cmds)
            {
                newCmds.Add(cmd);
                if (cmd is HavocCmd && (cmd as HavocCmd).Vars.Count > 1)
                {
                    Console.WriteLine("{0}", cmd);
                    throw new InvalidInput("Produce Bug Witness: Havoc cmd found");
                }

                if (cmd is HavocCmd)
                {
                    var hcmd = cmd as HavocCmd;
                    var arg = hcmd.Vars[0];
                    newCmds.Add(makeRecordCall(arg));
                    continue;
                }

                if (!(cmd is CallCmd))
                {
                    continue;
                }

                var ccmd = cmd as CallCmd;

                if (ccmd.Outs.Count != 1)
                {
                    continue;
                }

                if (!procsWithoutBody.Contains(ccmd.Proc.Name))
                {
                    continue;
                }

                var retVal = ccmd.Outs[0];

                if (retVal == null || retVal.Type.IsMap) continue;

                newCmds.Add(makeRecordCall(retVal));
                                    
            }
            block.Cmds = newCmds;
        }

        private void instrumentMapHavocs(Block block, Dictionary<string, int> allocConstants, List<Constant> newDecls)
        {
            var newCmds = new List<Cmd>();
            foreach (Cmd cmd in block.Cmds)
            {
                newCmds.Add(cmd);

                if (!(cmd is CallCmd))
                {
                    continue;
                }

                var ccmd = cmd as CallCmd;

                if (ccmd.Outs.Count != 1)
                {
                    continue;
                }

                if (!procsWithoutBody.Contains(ccmd.callee))
                {
                    continue;
                }

                var retVal = ccmd.Outs[0];

                if (retVal == null) continue;

                if (retVal.Type.IsMap)
                {
                    // new constant
                    var mapconst = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, "mapconst" + newDecls.Count,
                        retVal.Type), false);
                    newDecls.Add(mapconst);

                    var id = QKeyValue.FindIntAttribute(ccmd.Attributes, RestrictToTrace.ConcretizeCallIdAttr, -1);
                    allocConstants.Add(mapconst.Name, id);

                    newCmds.Add(BoogieAstFactory.MkVarEqVar(retVal.Decl, mapconst));
                }


            }
            block.Cmds = newCmds;
        }


        private CallCmd makeRecordCall(IdentifierExpr v)
        {
            var ins = new List<Expr>();
            ins.Add(v);

            if (v.Type.IsInt)
                return new CallCmd(Token.NoToken, recordProcNameInt, ins, new List<IdentifierExpr>());
            else if (v.Type.IsBool)
                return new CallCmd(Token.NoToken, recordProcNameBool, ins, new List<IdentifierExpr>());
            else if (v.Type.IsCtor)
            {
                var t = (v.Type as CtorType).Decl.Name;
                if (!typeToRecordProc.ContainsKey(t))
                {
                    var inpVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", v.Type), true);
                    var reProc = new Procedure(Token.NoToken, recordProcNameCtor + t, new List<TypeVariable>(), new List<Variable> { inpVar }, new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                    typeToRecordProc.Add(t, reProc);
                }
                return new CallCmd(Token.NoToken, typeToRecordProc[t].Name, ins, new List<IdentifierExpr>());
            }
            else
            {
                Debug.Assert(false);
                return null;
            }
        }

        private Procedure GetInitLocalsProc(Microsoft.Boogie.Type ty)
        {
            var typeToStr = ty.ToString().Replace('[', '_').Replace(']', '_');
            if (!typeToInitLocalsProc.ContainsKey(typeToStr))
            {
                var outVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", ty), false);
                var reProc = new Procedure(Token.NoToken, initLocProcName + typeToStr, new List<TypeVariable>(), new List<Variable>(), new List<Variable> { outVar }, new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>());
                typeToInitLocalsProc.Add(typeToStr, reProc);
            }
            return typeToInitLocalsProc[typeToStr];
        }

        public ErrorTrace mapBackTraceRecord(ErrorTrace trace)
        {
            var ret = new ErrorTrace(trace.procName);

            foreach (var block in trace.Blocks)
            {
                var nb = new ErrorTraceBlock(block.blockName);
                foreach (var cmd in block.Cmds)
                {
                    if (cmd is CallInstr)
                    {
                        var ccmd = cmd as CallInstr;
                        if (ccmd.callee == recordProcNameInt || ccmd.callee == recordProcNameBool || ccmd.callee.StartsWith(recordProcNameCtor))
                        {
                            Debug.Assert(nb.Cmds.Count != 0);
                            nb.Cmds.Last().info = ccmd.info;
                            continue;
                        }

                        if (ccmd.hasCalledTrace)
                        {
                            var c = new CallInstr(mapBackTraceRecord(ccmd.calleeTrace), ccmd.asyncCall, ccmd.info);
                            nb.addInstr(c);
                        }
                        else
                        {
                            nb.addInstr(ccmd);
                        }

                    }
                    else
                    {
                        nb.addInstr(cmd.Copy());
                    }

                }
                ret.addBlock(nb);
            }

            if (trace.returns)
            {
                ret.addReturn(trace.raisesException);
            }

            return ret;
        }
    }

    public static class SdvUtils
    {
        // Mark "slic" assume statements
        // Insert captureState for driver methods and start
        // Mark "indirect" call assume statements
        public static void sdvAnnotateDefectTrace(Program trace, HashSet<string> slicVars, bool addSlicAnnotations = true)
        {
            //var slicVars = new HashSet<string>(config.trackedVars);
            //slicVars.Remove("alloc");

            var isSlicExpr = new Predicate<Expr>(expr =>
            {
                var vused = new VarsUsed();
                vused.VisitExpr(expr);
                if (vused.varsUsed.Any(v => slicVars.Contains(v)))
                    return true;
                return false;
            });
            var isSlicAssume = new Func<AssumeCmd, Implementation, bool>((ac, impl) =>
            {
                if (impl.Name.Contains("SLIC_") || impl.Name.Contains("sdv_")) return true;
                if (isSlicExpr(ac.Expr)) return true;
                return false;
            });
            var tagAssume = new Action<AssumeCmd, Implementation>((ac, impl) =>
            {
                if (isSlicAssume(ac, impl)) ac.Attributes =
                      new QKeyValue(Token.NoToken, "slic", new List<object>(), ac.Attributes);
            });

            var isDriverImpl = new Predicate<Implementation>(impl =>
            {
                return !impl.Name.Contains("sdv") && !impl.Name.Contains("SLIC");
            });


            foreach (var impl in trace.TopLevelDeclarations
                .OfType<Implementation>())
            {
                // Tag entry points of the driver
                if (isDriverImpl(impl))
                {
                    var ac = new AssumeCmd(Token.NoToken, Expr.True);
                    ac.Attributes = new QKeyValue(Token.NoToken, "captureState", new List<object>{impl.Name}, null);

                    var nc = new List<Cmd>();
                    nc.Add(ac);
                    nc.AddRange(impl.Blocks[0].Cmds);
                    impl.Blocks[0].Cmds = nc;
                }

                if (addSlicAnnotations)
                {
                    // Insert "slic" annotation
                    impl.Blocks.Iter(blk =>
                        blk.Cmds.OfType<AssumeCmd>()
                        .Iter(cmd => tagAssume(cmd, impl)));
                }

                // Insert "indirect" annotation
                foreach (var blk in impl.Blocks)
                {
                    for (int i = 0; i < blk.Cmds.Count - 1; i++)
                    {
                        var c1 = blk.Cmds[i] as AssumeCmd;
                        var c2 = blk.Cmds[i + 1] as AssumeCmd;
                        if (c1 == null || c2 == null) continue;
                        if (!QKeyValue.FindBoolAttribute(c1.Attributes, "IndirectCall")) continue;
                        c2.Attributes = new QKeyValue(Token.NoToken, "indirect", new List<object>(), c2.Attributes);
                    }
                }

                // Start captureState
                foreach (var blk in impl.Blocks)
                {
                    blk.Cmds.OfType<AssumeCmd>()
                        .Where(ac => QKeyValue.FindBoolAttribute(ac.Attributes, "mainInitDone"))
                        .Iter(ac => { ac.Attributes = new QKeyValue(Token.NoToken, "captureState", new List<object>(new string[] { "Start" }), ac.Attributes); });
                }
            }

            // Mark malloc
            foreach (var impl in trace.TopLevelDeclarations
                .OfType<Implementation>())
            {
                foreach (var blk in impl.Blocks)
                {
                    var ncmds = new List<Cmd>();
                    foreach (Cmd cmd in blk.Cmds)
                    {
                        ncmds.Add(cmd);

                        var ccmd = cmd as CallCmd;
                        if (ccmd == null || !ccmd.callee.Contains("HAVOC_malloc"))
                            continue;
                        var ac = new AssertCmd(Token.NoToken, Expr.True);
                        ac.Attributes = new QKeyValue(Token.NoToken, "malloc", new List<object>(), null);
                        ncmds.Add(ac);
                    }
                    blk.Cmds = ncmds;
                }
            }
        }

    }

    // Unify all maps of type [int]int
    public class TypeUnify : FixedVisitor
    {
        // unified map
        GlobalVariable U;
        // Input program
        Program program;

        // maps in the input program
        HashSet<string> AllMaps;

        public TypeUnify(Program program)
        {
            U = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                "Mem_T.All", BoogieAstFactory.MkMapType(Microsoft.Boogie.Type.Int, Microsoft.Boogie.Type.Int)));
            this.program = program;
        }

        public void Unify(string outfile)
        {
            // Gather all maps
            AllMaps = new HashSet<string>();

            program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsMap && (g.TypedIdent.Type as MapType).Result.IsInt)
                .Iter(g => AllMaps.Add(g.Name));

            // Fix Cmds
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl =>
                    impl.Blocks.Iter(block =>
                        block.Cmds
                        .OfType<Cmd>().Iter(cmd => Visit(cmd))));

            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(p => VisitEnsuresSeq(p.Ensures));
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(p => VisitRequiresSeq(p.Requires));
            
            var impls = new HashSet<string>();
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => impls.Add(impl.Name));
            
            program.TopLevelDeclarations.OfType<Procedure>()
                .Where(p => impls.Contains(p.Name))
                .Iter(p => p.Modifies = new List<IdentifierExpr>());
            program.TopLevelDeclarations.OfType<Procedure>()
                .Iter(p => VisitIdentifierExprSeq(p.Modifies));

            // Remove globals
            var newDecls = new List<Declaration>();
            foreach(var decl in program.TopLevelDeclarations) {
                var glob = decl as GlobalVariable;
                if(glob == null || !AllMaps.Contains(glob.Name))
                    newDecls.Add(decl);
            }

            program.TopLevelDeclarations = newDecls;
            program.AddTopLevelDeclaration(U);

            // print program
            BoogieUtil.DoModSetAnalysis(program);
            BoogieUtil.PrintProgram(program, outfile);

            program = null;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (AllMaps.Contains(node.Name))
            {
                return Expr.Ident(U);
            }
            return node;
        }

        public override Cmd VisitHavocCmd(HavocCmd node)
        {
            var cmd = base.VisitHavocCmd(node) as HavocCmd;
            var newVars = new List<IdentifierExpr>();
            var seen = new HashSet<string>();
            foreach (IdentifierExpr ie in cmd.Vars)
            {
                if (!seen.Contains(ie.Name))
                {
                    newVars.Add(ie);
                    seen.Add(ie.Name);
                }
            }
            cmd.Vars = newVars;

            return cmd;
        }
    }

    public class RecordMemoryAccesses
    {
        public static readonly string recordProc = "boogie_si_record_mem_access";
        // Variable for recording address accessed
        static LocalVariable memAccess;
        // Scalars whose value should also be recorded
        static HashSet<string> scalarGlobals;

        public static void Instrument(Program program, params string[] scalars)
        {
            var hs = new HashSet<string>(scalars);
            Instrument(program, hs);
        }

        public static void Instrument(Program program, HashSet<string> scalars)
        {
            memAccess = BoogieAstFactory.MkLocal("memAccess", Microsoft.Boogie.Type.Int) as LocalVariable;
            scalarGlobals = new HashSet<string>();
            program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => scalars.Contains(g.Name))
                .Iter(g => scalarGlobals.Add(g.Name));

            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(Instrument);

            var decl = BoogieAstFactory.MkProc(recordProc, new List<Variable>(new Variable[] { BoogieAstFactory.MkFormal("address", Microsoft.Boogie.Type.Int, true) }), new List<Variable>());
            program.AddTopLevelDeclaration(decl);
        }

        static CallCmd Read(Variable map)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new List<Expr>{Expr.Ident(memAccess)}, new List<IdentifierExpr>());
            var p = new List<object>();
            p.Add(map.Name);
            ret.Attributes = new QKeyValue(Token.NoToken, "read", p, null);
            return ret;
        }

        static CallCmd Write(Variable map)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new List<Expr>{Expr.Ident(memAccess)}, new List<IdentifierExpr>());
            var p = new List<object>();
            p.Add(map.Name);
            ret.Attributes = new QKeyValue(Token.NoToken, "write", p, null);
            return ret;
        }

        static CallCmd RecordScalar(Variable v)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new List<Expr>{Expr.Ident(v)}, new List<IdentifierExpr>());
            var p = new List<object>();
            p.Add(v.Name);
            ret.Attributes = new QKeyValue(Token.NoToken, "scalar", p, null);
            return ret;
        }

        private static void Instrument(Implementation impl)
        {            
            impl.LocVars.Add(memAccess);

            foreach (var block in impl.Blocks)
            {
                var newcmds = new List<Cmd>();
                foreach (Cmd cmd in block.Cmds)
                {
                    if (cmd is AssignCmd) newcmds.AddRange(ProcessAssign(cmd as AssignCmd));
                    else if (cmd is AssumeCmd) newcmds.AddRange(ProcessAssume(cmd as AssumeCmd));
                    else if (cmd is CallCmd) newcmds.AddRange(ProcessCall(cmd as CallCmd));
                    else newcmds.Add(cmd);
                }
                block.Cmds = new List<Cmd>();
                newcmds.Iter(cmd => block.Cmds.Add(cmd));
            }

        }

        private static List<Cmd> ProcessCall(CallCmd cmd)
        {
            var ret = new List<Cmd>();

            var gm = new GatherMemAccesses();
            cmd.Ins.Where(e => e != null).Iter(e => gm.VisitExpr(e));

            foreach (var tup in gm.accesses)
            {
                ret.Add(BoogieAstFactory.MkVarEqExpr(memAccess, tup.Item2));
                ret.Add(Read(tup.Item1));
            }
            ret.Add(cmd);

            cmd.Outs.Where(ie => ie != null && scalarGlobals.Contains(ie.Name))
                .Iter(ie => ret.Add(RecordScalar(ie.Decl)));

            return ret;
        }

        private static List<Cmd> ProcessAssume(AssumeCmd cmd)
        {
            var ret = new List<Cmd>();
            
            var gm = new GatherMemAccesses();
            gm.VisitExpr(cmd.Expr);
            foreach (var tup in gm.accesses)
            {
                ret.Add(BoogieAstFactory.MkVarEqExpr(memAccess, tup.Item2));
                ret.Add(Read(tup.Item1));
            }
            ret.Add(cmd);
            return ret;
        }

        private static List<Cmd> ProcessAssign(AssignCmd cmd)
        {
            var ret = new List<Cmd>();

            var reads = new GatherMemAccesses();
            var writes = new List<Tuple<Variable,Expr>>();
            var scalars = new List<Variable>();
            foreach (var lhs in cmd.Lhss)
            {
                if (lhs is MapAssignLhs)
                {
                    var ma = lhs as MapAssignLhs;
                    ma.Indexes.Iter(e => writes.Add(Tuple.Create(ma.DeepAssignedVariable, e)));
                    ma.Indexes.Iter(e => reads.VisitExpr(e));
                }
                else if (lhs is SimpleAssignLhs && scalarGlobals.Contains(lhs.DeepAssignedVariable.Name))
                {
                    scalars.Add(lhs.DeepAssignedVariable);
                }
            }
            cmd.Rhss.Iter(e => reads.VisitExpr(e));

            writes.Iter(tup =>
                {
                    ret.Add(BoogieAstFactory.MkVarEqExpr(memAccess, tup.Item2));
                    ret.Add(Write(tup.Item1));
                });


            reads.accesses.Iter(tup =>
            {
                ret.Add(BoogieAstFactory.MkVarEqExpr(memAccess, tup.Item2));
                ret.Add(Read(tup.Item1));
            });


            ret.Add(cmd);

            scalars.Iter(v => ret.Add(RecordScalar(v)));

            return ret;
        }

    }


    class GatherMemAccesses : FixedVisitor
    {
        public List<Tuple<Variable, Expr>> accesses;
        public GatherMemAccesses()
        {
            accesses = new List<Tuple<Variable, Expr>>();
        }

        public override Expr VisitForallExpr(ForallExpr node)
        {
            return node;
        }

        public override Expr VisitExistsExpr(ExistsExpr node)
        {
            return node;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is MapSelect && node.Args.Count == 2 && node.Args[0] is IdentifierExpr)
            {
                accesses.Add(Tuple.Create((node.Args[0] as IdentifierExpr).Decl, node.Args[1]));
            }

            return base.VisitNAryExpr(node);
        }
    }
}
