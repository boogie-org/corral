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
                .Where(g => g.TypedIdent.Type.IsMap)
                .Iter(g => AllMaps.Add(g.Name));

            // Fix Cmds
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl =>
                    impl.Blocks.Iter(block =>
                        block.Cmds
                        .OfType<Cmd>().Iter(cmd => Visit(cmd))));

            // Remove globals
            var newDecls = new List<Declaration>();
            foreach(var decl in program.TopLevelDeclarations) {
                var glob = decl as GlobalVariable;
                if(glob == null || !AllMaps.Contains(glob.Name))
                    newDecls.Add(decl);
            }

            program.TopLevelDeclarations = newDecls;
            program.TopLevelDeclarations.Add(U);

            // print program
            ModSetCollector.DoModSetAnalysis(program);
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
            var newVars = new IdentifierExprSeq();
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

            var decl = BoogieAstFactory.MkProc(recordProc, new VariableSeq(BoogieAstFactory.MkFormal("address", Microsoft.Boogie.Type.Int, true)), new VariableSeq());
            program.TopLevelDeclarations.Add(decl);
        }

        static CallCmd Read(Variable map)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new ExprSeq(Expr.Ident(memAccess)), new IdentifierExprSeq());
            var p = new List<object>();
            p.Add(map.Name);
            ret.Attributes = new QKeyValue(Token.NoToken, "read", p, null);
            return ret;
        }

        static CallCmd Write(Variable map)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new ExprSeq(Expr.Ident(memAccess)), new IdentifierExprSeq());
            var p = new List<object>();
            p.Add(map.Name);
            ret.Attributes = new QKeyValue(Token.NoToken, "write", p, null);
            return ret;
        }

        static CallCmd RecordScalar(Variable v)
        {
            var ret = new CallCmd(Token.NoToken, recordProc, new ExprSeq(Expr.Ident(v)), new IdentifierExprSeq());
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
                block.Cmds = new CmdSeq();
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

        public override ForallExpr VisitForallExpr(ForallExpr node)
        {
            return node;
        }

        public override ExistsExpr VisitExistsExpr(ExistsExpr node)
        {
            return node;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is MapSelect && node.Args.Length == 2 && node.Args[0] is IdentifierExpr)
            {
                accesses.Add(Tuple.Create((node.Args[0] as IdentifierExpr).Decl, node.Args[1]));
            }

            return base.VisitNAryExpr(node);
        }
    }
}
