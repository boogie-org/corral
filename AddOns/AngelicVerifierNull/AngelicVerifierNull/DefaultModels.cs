using Microsoft.Boogie;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using cba.Util;
using btype = Microsoft.Boogie.Type;

namespace AngelicVerifierNull
{
    class DefaultModels
    {
        static Function sizeFun = null;
        static Function baseFun = null;
        static GlobalVariable allocMap = null;
        static Procedure mallocProcedure = null;
        static Procedure mallocProcedureFull = null;
        Program prog = null;

        public DefaultModels(ref Program _prog)
        {
            prog = _prog;
            allocMap = BoogieUtil.findVarDecl(prog.TopLevelDeclarations, "nonfree");

            // locate Function Size(x) and Base(x)
            foreach (Function func in prog.TopLevelDeclarations
                .Where(x => x is Function))
            {
                if (BoogieUtil.checkAttrExists("buffer", func.Attributes))
                {
                    var attr = QKeyValue.FindStringAttribute(func.Attributes, "buffer");
                    if (attr == "size")
                        sizeFun = func;
                    else if (attr == "base")
                        baseFun = func;

                    else throw new Exception("Buffer instrumentation function with unexpected attributes");
                }
            }

            if (sizeFun == null || baseFun == null || allocMap == null)
                throw new InputProgramDoesNotMatchExn(
                    "ABORT: no size/base/free function declared in the input program");
        }

        public static Program AddModels(ref Program _prog)
        {
            var dmodels = new DefaultModels(ref _prog);
            HashSet<SystemModel> models = new HashSet<SystemModel>();
            FindMalloc(dmodels);

            foreach (Procedure proc in dmodels.prog.TopLevelDeclarations
                .Where(x => x is Procedure))
            {    
                // locate procedures without body
                SystemModel model = null;
                switch (proc.Name)
                {
                    case "ExAllocatePoolWithTag":
                        model = new ExAllocatePoolWithTag(proc);
                        models.Add(model);
                        break;
                    case "ExFreePool":
                        model = new ExFreePool(proc);
                        models.Add(model);
                        break;
                    case "ExFreePoolWithTag":
                        model = new ExFreePoolWithTag(proc);
                        models.Add(model);
                        break;
                    default:
                        continue;
                }
            }
            models.Iter(m => dmodels.prog.TopLevelDeclarations.Add(m.impl));

            // Propogate Base(x) through assignments.
            // Adding assertions for buffer access.
            

            return dmodels.prog;
        }

        public static Program BufferInstrument(ref Program _prog)
        {
            return BufferAssert.InsertBufferAsserts(_prog);
        }

        // create a copy ofthe variables without annotations
        private static List<Variable> DropAnnotations(List<Variable> vars)
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

        private static void FindMalloc(DefaultModels dmodels)
        {
            foreach (var proc in dmodels.prog.TopLevelDeclarations.OfType<Procedure>()
                    .Where(p => BoogieUtil.checkAttrExists("allocator", p.Attributes)))
            {
                var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                if (attr == null) mallocProcedure = proc;
                else if (attr == "full") mallocProcedureFull = proc;
            }
            if (mallocProcedure == null)
                new InputProgramDoesNotMatchExn(
                    "ABORT: no malloc procedure with {:allocator} declared in the input program");
            if (mallocProcedureFull == null)
            {
                throw new InputProgramDoesNotMatchExn(
                    "ABORT: no malloc procedure with {:allocator \"full\"} declared in the input program");
            }

            //var mallocImpl = BoogieAstFactory.MkImpl(mallocProcedure, DropAnnotations(mallocProcedure.InParams),
            //    DropAnnotations(mallocProcedure.OutParams), new List<Variable>(){}, 
            //    new List<Block>(){
            //    BoogieAstFactory.MkBlock(
            //        BoogieAstFactory.MkMapAssign(allocMap, Expr.Ident(mallocProcedure.OutParams[0]), Expr.True)
            //        //BoogieAstFactory.MkAssert(Expr.False)
            //    )});
            //dmodels.prog.TopLevelDeclarations.Add(mallocImpl);
        }

        static Expr mkBaseFun(Variable x)
        {
            return new NAryExpr(Token.NoToken,
                new FunctionCall(baseFun), new List<Expr>() { Expr.Ident(x) });
        }

        // modified from BoogieUtils: return list of variables
        static List<Variable> extractVars(Expr expr)
        {
            List<Variable> ret = new List<Variable>();
            if (expr is IdentifierExpr)
            {
                IdentifierExpr iexpr = expr as IdentifierExpr;
                ret.Add(iexpr.Decl);
                return ret;
            }
            else if (expr is LiteralExpr)
            {
                return ret;
            }
            else if (expr is NAryExpr)
            {
                NAryExpr nexpr = expr as NAryExpr;
                for (int i = 0; i < nexpr.Args.Count; i++)
                {
                    ret.AddRange(extractVars(nexpr.Args[i]));
                }
                return ret;
            }
            throw new NotImplementedException(expr.ToString());
        }

        static List<Variable> extractVars(Cmd cmd, bool getLhs, bool getRhs)
        {
            if (cmd is AssertCmd)
                return extractVars((cmd as AssertCmd).Expr);
            if (cmd is AssumeCmd)
                return extractVars((cmd as AssumeCmd).Expr);
            if (cmd is HavocCmd)
            {
                List<Variable> ret = new List<Variable>();
                foreach (IdentifierExpr v in (cmd as HavocCmd).Vars)
                {
                    ret.Add(v.Decl);
                }
                return ret;
            }
            else if (cmd is CallCmd)
            {
                List<Variable> ret = new List<Variable>();
                CallCmd ccmd = cmd as CallCmd;
                if (getRhs)
                {
                    foreach (IdentifierExpr v in ccmd.Outs)
                    {
                        if (v != null) ret.Add(v.Decl);
                    }
                }
                return ret;
            }
            else if (cmd is AssignCmd)
            {
                List<Variable> ret = new List<Variable>();
                var acmd = cmd as AssignCmd;
                if (getLhs)
                {
                    foreach (var ae in acmd.Lhss)
                    {
                        var v = ae.DeepAssignedVariable;
                        ret.Add(v);
                    }
                }
                if (getRhs)
                {
                    foreach (var ae in acmd.Rhss)
                    {
                        ret.AddRange(extractVars(ae));
                    }
                }
                return ret;
            }

            throw new NotImplementedException("call cmd in extractvars not handled");
        }
        static bool IsPointerVariable(Variable x)
        {
            return x.TypedIdent.Type.IsInt &&
                !BoogieUtil.checkAttrExists("scalar", x.Attributes); //we will err on the side of treating variables as references
        }

        class BufferAssert : FixedVisitor
        {
            Program origprog;

            public BufferAssert(Program _prog)
            {
                origprog = _prog;
            }
            public static Program InsertBufferAsserts(Program prog)
            {
                //var iba = new BufferAssert(prog);
                //return iba.VisitProgram(prog);
                prog.TopLevelDeclarations.OfType<Implementation>()
                    .Iter(imp =>
                    {
                        //List<Variable> mapBaseVars = new List<Variable>(); // tmp vars for map
                        //List<Variable> tmpVars = new List<Variable>();
                        imp.Blocks.Iter(node =>
                        {
                            List<Cmd> cmdSeq = new List<Cmd>(); // new command sequence

                            foreach (Cmd c in node.Cmds)
                            {
                                if (c is AssignCmd)
                                {
                                    var ptrAssig = c as AssignCmd;
                                    var lhsvars = extractVars(ptrAssig, true, false); // lhs vars
                                    var rhsvars = extractVars(ptrAssig, false, true); // rhs vars
                                    
                                    cmdSeq.Add(c);
                                    if (lhsvars.Count == 1 && rhsvars.Count == 1)
                                    {
                                        //if (lhsvars[0].TypedIdent.Type.IsMap) // map
                                        //{
                                        //    var tmp = BoogieAstFactory.MkLocal("mapBaseTmp_" + (counter++), btype.Int);
                                        //    mapBaseVars.Add(tmp);

                                        //    node.Cmds.Insert(++i, BoogieAstFactory.MkAssign(tmp, lhsvars[0]));
                                        //    node.Cmds.Insert(++i, BoogieAstFactory.MkAssume(Expr.Eq(mkBaseFun(tmp),
                                        //        mkBaseFun(rhsvars[0]))));
                                        //}
                                        //else if (lhsvars[0].TypedIdent.Type.IsInt)
                                        //{
                                        //    node.Cmds.Insert(++i,
                                        //        BoogieAstFactory.MkAssume(Expr.Eq(mkBaseFun(lhsvars[0]),
                                        //        mkBaseFun(rhsvars[0]))));
                                        //}
                                        //else Console.WriteLine(ptrAssig);
                                        if (lhsvars[0].TypedIdent.Type.IsInt && rhsvars[0].TypedIdent.Type.IsInt)
                                        {
                                            cmdSeq.Add(BoogieAstFactory.MkAssume(Expr.Eq(mkBaseFun(lhsvars[0]),
                                                mkBaseFun(rhsvars[0]))));
                                        }
                                    }
                                    continue;
                                }
                                else if (c is CallCmd)
                                {
                                    var cal = c as CallCmd;
                                    if (cal.callee == "ExFreePoolWithTag" ||
                                        cal.callee == "ExFreePool")
                                    {
                                        //AssertCmd lineinfo = (AssertCmd)BoogieAstFactory.MkAssert(Expr.True);
                                        //lineinfo.Attributes = new QKeyValue(Token.NoToken, "sourcefile",
                                        //    new List<object> { ".\\models.h" },
                                        //    new QKeyValue(Token.NoToken, "sourceline",
                                        //        new List<object>() { "1" },
                                        //        new QKeyValue(Token.NoToken, "print",
                                        //            new List<object>() { "ExFreeFun" }, null)));
                                        //cmdSeq.Add(lineinfo);
                                        AssertCmd nonfreeAssert = (AssertCmd)BoogieAstFactory.MkAssert(
                                            BoogieAstFactory.MkMapAccessExpr(allocMap, cal.Ins[0]));
                                        nonfreeAssert.Attributes = new QKeyValue(Token.NoToken,
                                            "nonfree", new List<Object>() { }, null);
                                        cmdSeq.Add(nonfreeAssert);
                                        cmdSeq.Add(BoogieAstFactory.MkAssume(
                                            BoogieAstFactory.MkMapAccessExpr(allocMap, cal.Ins[0])));
                                        cmdSeq.Add(c);
                                        continue;
                                    }
                                    else if (cal.callee == mallocProcedure.Name 
                                        || cal.callee == mallocProcedureFull.Name)
                                    {
                                        cmdSeq.Add(c);
                                        //cmdSeq.Add(BoogieAstFactory.MkAssume(BoogieAstFactory.MkMapAccessExpr(
                                        //    allocMap, cal.Outs[0])));
                                        cmdSeq.Add(BoogieAstFactory.MkMapAssign(allocMap,
                                            cal.Outs[0], Expr.True));
                                        continue;
                                    }
                                }
                                cmdSeq.Add(c);
                            }
                            node.Cmds = cmdSeq;
                        });
                    });
                return prog;
            }

            public override Block VisitBlock(Block node)
            {
                for (int i = 0; i < node.Cmds.Count; ++i)
                {
                    if (node.Cmds[i] is AssignCmd)
                    {
                        var ptrAssig = node.Cmds[i] as AssignCmd;
                        var lhsvars = extractVars(ptrAssig, true, false); // lhs vars
                        var rhsvars = extractVars(ptrAssig, false, true); // rhs vars

                        if (lhsvars.Count == 1 && rhsvars.Count == 1)
                        {
                            //if (lhsvars[0].TypedIdent.Type.IsMap) // map
                            //{
                            //    var tmp = BoogieAstFactory.MkLocal("mapBaseTmp_" + (counter++), btype.Int);
                            //    node.Cmds.Insert(i + 1, BoogieAstFactory.MkAssign(tmp, lhsvars[0]));
                            //    node.Cmds.Insert(i + 2, BoogieAstFactory.MkAssume(Expr.Eq(mkBaseFun(tmp),
                            //        mkBaseFun(rhsvars[0]))));
                            //}
                            if (IsPointerVariable(lhsvars[0]) && IsPointerVariable(rhsvars[0]))
                            //if (lhsvars[0].TypedIdent.Type.IsInt && rhsvars[0].TypedIdent.Type.IsInt)
                            {
                                node.Cmds.Insert(i + 1,
                                    BoogieAstFactory.MkAssume(Expr.Eq(mkBaseFun(lhsvars[0]),
                                    mkBaseFun(rhsvars[0]))));
                            }
                            //else Console.WriteLine(ptrAssig);
                        }
                        //else Console.WriteLine(ptrAssig);
                    }
                }
                return base.VisitBlock(node);
            }
        }

        public abstract class SystemModel
        {
            private Implementation _impl;
            public abstract string modelName { get; }
            public Implementation impl { get { return _impl; } }
            public abstract Implementation GenerateBody(Procedure proc);
            public SystemModel(Procedure p)
            {
                _impl = GenerateBody(p);
            }

            public override bool Equals(object obj)
            {
                if ((obj is SystemModel) && ((obj as SystemModel).modelName == modelName))
                    return true;
                else return false;
            }
            public override int GetHashCode()
            {
                return modelName.GetHashCode();
            }
            protected List<Variable> DropAnnotations(List<Variable> vars)
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
        }

        /**
         * Nondeterministically allocate memory of given size
         * OR return NULL
         */
        class ExAllocatePoolWithTag : SystemModel
        {
            public override string modelName
            {
                get { return "ExAllocatePoolWithTag"; }
            }

            public ExAllocatePoolWithTag(Procedure proc) : base(proc) { }

            public override Implementation GenerateBody(Procedure proc)
            {
                Debug.Assert(proc.InParams.Count == 3);
                Debug.Assert(proc.OutParams.Count == 1);

                List<Variable> locals = new List<Variable>();


                //var cmds = new List<Cmd>() {
                //    BoogieAstFactory.MkCall(mallocProcedure,
                //    new List<Expr>() { (Expr)IdentifierExpr.Ident(proc.InParams[1]) },
                //    new List<Variable>() {proc.OutParams[0]})};
                //var txCmd = new ReturnCmd(Token.NoToken);
                //var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                //blocks.Add(blk);

                var mallocCall = (CallCmd)BoogieAstFactory.MkCall(mallocProcedure,
                    new List<Expr>() { (Expr)IdentifierExpr.Ident(proc.InParams[1]) },
                    new List<Variable>() {proc.OutParams[0]});
                mallocCall.Proc = mallocProcedure;

                var cmds = new List<List<Cmd>>() {
                    new List<Cmd>(){mallocCall},
                    new List<Cmd>(){BoogieAstFactory.MkAssign(proc.OutParams[0], 0)
                    }
                };
                List<Block> blocks = BoogieAstFactory.MkNondetSwitch(cmds);

                var ret = new Implementation(Token.NoToken, modelName,
                    proc.TypeParameters,
                    DropAnnotations(proc.InParams),
                    DropAnnotations(proc.OutParams), locals, blocks);
                ret.Attributes = (new FixedDuplicator(false)).CopyAttr(proc.Attributes);
                ret.Proc = proc;

                return ret;
            }
        }

        /**
         * Check the input pointer is at the base address of the
         * region. Mark the base address as NOT allocated (free).
         */
        class ExFreePoolWithTag : SystemModel
        {
            public override string modelName
            {
                get { return "ExFreePoolWithTag"; }
            }

            public ExFreePoolWithTag(Procedure proc) : base(proc) { }

            public override Implementation GenerateBody(Procedure proc)
            {
                Debug.Assert(proc.InParams.Count == 2);
                Debug.Assert(proc.OutParams.Count == 0);

                List<Variable> locals = new List<Variable>();
                List<Block> blocks = new List<Block>();

                var baseX = new NAryExpr(Token.NoToken, // Base(x0)
                    new FunctionCall(baseFun), new List<Expr>() { Expr.Ident(proc.InParams[0]) });
                Expr allocBase = BoogieAstFactory.MkMapAccessExpr(allocMap, baseX); // Allocated[Base(x0)]

                var cmds = new List<Cmd>() {
                    //BoogieAstFactory.MkAssert(Expr.Eq(Expr.Ident(proc.InParams[0]), baseX)),
                    //BoogieAstFactory.MkAssert(allocBase),
                    BoogieAstFactory.MkMapAssign(allocMap, Expr.Ident(proc.InParams[0]), Expr.False)
                };

                var txCmd = new ReturnCmd(Token.NoToken);
                var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                blocks.Add(blk);

                var ret = new Implementation(Token.NoToken, modelName,
                    proc.TypeParameters,
                    DropAnnotations(proc.InParams),
                    DropAnnotations(proc.OutParams), locals, blocks);
                ret.Attributes = (new FixedDuplicator(false)).CopyAttr(proc.Attributes);

                ret.Proc = proc;
                return ret;
            }
        }

        /**
         * Same bahaviors as ExFreePoolWithTag
         */
        class ExFreePool : SystemModel
        {
            public override string modelName
            {
                get { return "ExFreePool"; }
            }

            public ExFreePool(Procedure proc) : base(proc) { }

            public override Implementation GenerateBody(Procedure proc)
            {
                Debug.Assert(proc.InParams.Count == 1);
                Debug.Assert(proc.OutParams.Count == 0);

                List<Variable> locals = new List<Variable>();
                List<Block> blocks = new List<Block>();
                var baseX = new NAryExpr(Token.NoToken, // Base(x0)
                    new FunctionCall(baseFun), new List<Expr>() { Expr.Ident(proc.InParams[0]) });
                Expr allocBase = BoogieAstFactory.MkMapAccessExpr(allocMap, baseX); // Allocated[Base(x0)]

                var cmds = new List<Cmd>() {
                    //BoogieAstFactory.MkAssert(Expr.Eq(Expr.Ident(proc.InParams[0]), baseX)),
                    //BoogieAstFactory.MkAssert(allocBase),
                    BoogieAstFactory.MkMapAssign(allocMap, Expr.Ident(proc.InParams[0]), Expr.False)
                };

                var txCmd = new ReturnCmd(Token.NoToken);
                var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                blocks.Add(blk);

                var ret = new Implementation(Token.NoToken, modelName,
                    proc.TypeParameters,
                    DropAnnotations(proc.InParams),
                    DropAnnotations(proc.OutParams), locals, blocks);
                ret.Attributes = (new FixedDuplicator(false)).CopyAttr(proc.Attributes);

                ret.Proc = proc;
                return ret;
            }
        }
    }
}
