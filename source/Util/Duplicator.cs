
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;

namespace cba.Util
{

    // THis is intended to be an exact copy of Duplicator, except
    // that it inherits from FixedVisitor instead of StandardVisitor
    public class MyDuplicator : FixedVisitor
    {

        public override Absy Visit(Absy node)
        {
            node = base.Visit(node);
            return node;
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            return base.VisitAssertCmd((AssertCmd)node.Clone());
        }
        public override Cmd VisitAssignCmd(AssignCmd node)
        {
            AssignCmd clone = (AssignCmd)node.Clone();
            clone.Lhss = new List<AssignLhs>(clone.Lhss);
            clone.Rhss = new List<Expr>(clone.Rhss);
            return base.VisitAssignCmd(clone);
        }
        public override Cmd VisitAssumeCmd(AssumeCmd node)
        {
            return base.VisitAssumeCmd((AssumeCmd)node.Clone());
        }
        public override AtomicRE VisitAtomicRE(AtomicRE node)
        {
            return base.VisitAtomicRE((AtomicRE)node.Clone());
        }
        public override Axiom VisitAxiom(Axiom node)
        {
            return base.VisitAxiom((Axiom)node.Clone());
        }
        public override Type VisitBasicType(BasicType node)
        {
            // do /not/ clone the type recursively
            return (BasicType)node.Clone();
        }
        public override Block VisitBlock(Block node)
        {
            return base.VisitBlock((Block)node.Clone());
        }
        public override BlockSeq VisitBlockSeq(BlockSeq blockSeq)
        {
            return base.VisitBlockSeq(blockSeq);
        }
        public override BoundVariable VisitBoundVariable(BoundVariable node)
        {
            return base.VisitBoundVariable((BoundVariable)node.Clone());
        }
        public override Type VisitBvType(BvType node)
        {
            // do /not/ clone the type recursively
            return (BvType)node.Clone();
        }
        // note: there is a bug in the recursive call: argument should be newNode
        // This is fixed in FixedDuplicator.
        public override Cmd VisitCallCmd(CallCmd node)
        {
            CallCmd newNode = (CallCmd)node.Clone();
            newNode.Ins = new List<Expr>(node.Ins);
            newNode.Outs = new List<IdentifierExpr>(node.Outs);
            return base.VisitCallCmd(node);
        }
        public override Choice VisitChoice(Choice node)
        {
            return base.VisitChoice((Choice)node.Clone());
        }
        public override CmdSeq VisitCmdSeq(CmdSeq cmdSeq)
        {
            return base.VisitCmdSeq(cmdSeq);
        }
        public override Constant VisitConstant(Constant node)
        {
            return base.VisitConstant((Constant)node.Clone());
        }
        public override CtorType VisitCtorType(CtorType node)
        {
            // do /not/ clone the type recursively
            return (CtorType)node.Clone();
        }
        public override Declaration VisitDeclaration(Declaration node)
        {
            return base.VisitDeclaration((Declaration)node.Clone());
        }
        public override List<Declaration> VisitDeclarationList(List<Declaration> declarationList)
        {
            return base.VisitDeclarationList(declarationList);
        }
        public override DeclWithFormals VisitDeclWithFormals(DeclWithFormals node)
        {
            return base.VisitDeclWithFormals((DeclWithFormals)node.Clone());
        }
        public override ExistsExpr VisitExistsExpr(ExistsExpr node)
        {
            return base.VisitExistsExpr((ExistsExpr)node.Clone());
        }
        public override Expr VisitExpr(Expr node)
        {
            return base.VisitExpr((Expr)node.Clone());
        }
        public override ExprSeq VisitExprSeq(ExprSeq list)
        {
            return base.VisitExprSeq(new ExprSeq(list));
        }
        public override ForallExpr VisitForallExpr(ForallExpr node)
        {
            return base.VisitForallExpr((ForallExpr)node.Clone());
        }
        public override Formal VisitFormal(Formal node)
        {
            return base.VisitFormal((Formal)node.Clone());
        }
        public override Function VisitFunction(Function node)
        {
            return base.VisitFunction((Function)node.Clone());
        }
        public override GlobalVariable VisitGlobalVariable(GlobalVariable node)
        {
            return base.VisitGlobalVariable((GlobalVariable)node.Clone());
        }
        public override GotoCmd VisitGotoCmd(GotoCmd node)
        {
            return base.VisitGotoCmd((GotoCmd)node.Clone());
        }
        public override Cmd VisitHavocCmd(HavocCmd node)
        {
            return base.VisitHavocCmd((HavocCmd)node.Clone());
        }
        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            return base.VisitIdentifierExpr((IdentifierExpr)node.Clone());
        }
        public override IdentifierExprSeq VisitIdentifierExprSeq(IdentifierExprSeq identifierExprSeq)
        {
            return base.VisitIdentifierExprSeq(new IdentifierExprSeq(identifierExprSeq));
        }
        public override Implementation VisitImplementation(Implementation node)
        {
            return base.VisitImplementation((Implementation)node.Clone());
        }
        public override LiteralExpr VisitLiteralExpr(LiteralExpr node)
        {
            return base.VisitLiteralExpr((LiteralExpr)node.Clone());
        }
        public override LocalVariable VisitLocalVariable(LocalVariable node)
        {
            return base.VisitLocalVariable((LocalVariable)node.Clone());
        }
        public override AssignLhs VisitMapAssignLhs(MapAssignLhs node)
        {
            return base.VisitMapAssignLhs((MapAssignLhs)node.Clone());
        }
        public override MapType VisitMapType(MapType node)
        {
            // do /not/ clone the type recursively
            return (MapType)node.Clone();
        }
        public override Expr VisitNAryExpr(NAryExpr node)
        {
            return base.VisitNAryExpr((NAryExpr)node.Clone());
        }
        public override Expr VisitOldExpr(OldExpr node)
        {
            return base.VisitOldExpr((OldExpr)node.Clone());
        }
        public override Procedure VisitProcedure(Procedure node)
        {
            return base.VisitProcedure((Procedure)node.Clone());
        }
        public override Program VisitProgram(Program node)
        {
            return base.VisitProgram((Program)node.Clone());
        }
        public override QuantifierExpr VisitQuantifierExpr(QuantifierExpr node)
        {
            return base.VisitQuantifierExpr((QuantifierExpr)node.Clone());
        }
        public override Cmd VisitRE(RE node)
        {
            return base.VisitRE((RE)node.Clone());
        }
        public override RESeq VisitRESeq(RESeq reSeq)
        {
            return base.VisitRESeq(new RESeq(reSeq));
        }
        public override ReturnCmd VisitReturnCmd(ReturnCmd node)
        {
            return base.VisitReturnCmd((ReturnCmd)node.Clone());
        }
        public override Sequential VisitSequential(Sequential node)
        {
            return base.VisitSequential((Sequential)node.Clone());
        }
        public override AssignLhs VisitSimpleAssignLhs(SimpleAssignLhs node)
        {
            return base.VisitSimpleAssignLhs((SimpleAssignLhs)node.Clone());
        }
        public override Cmd VisitStateCmd(StateCmd node)
        {
            return base.VisitStateCmd((StateCmd)node.Clone());
        }
        public override TransferCmd VisitTransferCmd(TransferCmd node)
        {
            return base.VisitTransferCmd((TransferCmd)node.Clone());
        }
        public override Trigger VisitTrigger(Trigger node)
        {
            return base.VisitTrigger((Trigger)node.Clone());
        }
        public override Type VisitType(Type node)
        {
            // do /not/ clone the type recursively
            return (Type)node.Clone();
        }
        public override TypedIdent VisitTypedIdent(TypedIdent node)
        {
            return base.VisitTypedIdent((TypedIdent)node.Clone());
        }
        public override Variable VisitVariable(Variable node)
        {
            return node;
        }
        public override VariableSeq VisitVariableSeq(VariableSeq variableSeq)
        {
            return base.VisitVariableSeq(new VariableSeq(variableSeq));
        }
        public override Cmd VisitAssertRequiresCmd(AssertRequiresCmd node)
        {
            return base.VisitAssertRequiresCmd((AssertRequiresCmd)node.Clone());
        }
        public override Cmd VisitAssertEnsuresCmd(AssertEnsuresCmd node)
        {
            return base.VisitAssertEnsuresCmd((AssertEnsuresCmd)node.Clone());
        }
        public override Ensures VisitEnsures(Ensures node)
        {
            return base.VisitEnsures((Ensures)node.Clone());
        }
        public override Requires VisitRequires(Requires node)
        {
            return base.VisitRequires((Requires)node.Clone());
        }
    }

    // This is the duplicator to use
    public class FixedDuplicator : MyDuplicator
    {
        // Retain the procedure calls made inside calls (without duplicating them)
        bool retainProcCalls;

        // For debugging cycles
        HashSet<Absy> visited;

        public FixedDuplicator()
        {
            retainProcCalls = false;
            visited = new HashSet<Absy>();
        }

        public FixedDuplicator(bool retainProcCalls)
        {
            this.retainProcCalls = retainProcCalls;
            visited = new HashSet<Absy>();
        }

        public override Declaration VisitDeclaration(Declaration node)
        {
            node = base.VisitDeclaration(node);
            node.Attributes = CopyAttr(node.Attributes);
            return node;
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            node = (Implementation)node.Clone();
            node.Proc = null; // cannot resolve this inside the duplicator
            return base.VisitImplementation(node);
        }

        public override AssignLhs VisitMapAssignLhs(MapAssignLhs node)
        {
            MapAssignLhs clone = (MapAssignLhs)node.Clone();
            clone.Indexes = new List<Expr>(node.Indexes);

            return base.VisitMapAssignLhs(clone);
        }
        
        public override Cmd VisitCallCmd(CallCmd node)
        {
            CallCmd newNode = (CallCmd)node.Clone();
            newNode.Ins = new List<Expr>(node.Ins);
            newNode.Outs = new List<IdentifierExpr>(node.Outs);
            if (!retainProcCalls)
            {
                newNode.Proc = null; // cannot resolve this from inside the duplicator
            }
            newNode.Attributes = CopyAttr(newNode.Attributes);
            return base.VisitCallCmd(newNode);
        }

        public override BlockSeq VisitBlockSeq(BlockSeq blockSeq)
        {
            return base.VisitBlockSeq(new BlockSeq(blockSeq));
        }

        public override List<Block> VisitBlockList(List<Block> blocks)
        {
            var nblocks = new List<Block>();
            for (int i = 0, n = blocks.Count; i < n; i++)
            {
                nblocks.Add(this.VisitBlock(blocks[i]));
            }
            return nblocks;
        }

        public override List<Declaration> VisitDeclarationList(List<Declaration> decls)
        {
            var ndelcs = new List<Declaration>();
            for (int i = 0, n = decls.Count; i < n; i++)
            {
                ndelcs.Add(this.VisitDeclaration(decls[i]));
            }
            return ndelcs;
        }

        public override CmdSeq VisitCmdSeq(CmdSeq cmdSeq)
        {
            var ret = new CmdSeq();
            foreach (Cmd c in cmdSeq)
            {
                ret.Add(this.Visit(c));
            }
            return ret;
        }

        public override RequiresSeq VisitRequiresSeq(RequiresSeq requiresSeq)
        {
            RequiresSeq ret = new RequiresSeq();
            foreach (Requires r in requiresSeq)
            {
                ret.Add(VisitRequires(r));
            }
            return ret;
        } 

        public override EnsuresSeq VisitEnsuresSeq(EnsuresSeq ensuresSeq)
        {
            EnsuresSeq ret = new EnsuresSeq();
            for (int i = 0, n = ensuresSeq.Length; i < n; i++)
                ret.Add(this.VisitEnsures(ensuresSeq[i]));
            return ret;
        }
        
        public override Expr VisitNAryExpr(NAryExpr node)
        {
            node = (NAryExpr)node.Clone();
            node.Args = base.VisitExprSeq(node.Args);
            if (node.Fun is FunctionCall)
            {
                var nf = node.Fun as FunctionCall;
                if (nf.Func != null)
                {
                    node.Fun = new FunctionCall(nf.Func);
                }
                else
                {
                    node.Fun = nf.createUnresolvedCopy();
                }
            }
            return node; // base.VisitNAryExpr(node);
        }
        
        public override GotoCmd VisitGotoCmd(GotoCmd node)
        {
            var gc = (GotoCmd)node.Clone();
            gc.labelNames = new StringSeq();
            gc.labelNames.AddRange(node.labelNames);
            return gc;
        }

        public override Variable VisitVariable(Variable node)
        {
            var ret = (Variable)node.Clone();
            ret.TypedIdent = VisitTypedIdent(ret.TypedIdent);
            return ret;
        }
        
        public override Function VisitFunction(Function node)
        {
            node = (Function)node.Clone();
            node.Attributes = CopyAttr(node.Attributes);
            node.doingExpansion = false;
            return base.VisitFunction(node);
        }
        
        public QKeyValue CopyAttr(QKeyValue ls)
        {
            if (ls == null) return null;
            var tail = CopyAttr(ls.Next);
            return new QKeyValue(ls.tok, ls.Key, ls.Params, tail);
        }

        // Not sure about these:
        // public override Cmd VisitCallForallCmd(CallForallCmd node)
        // public override MapType VisitMapType(MapType node)
        // public override Type VisitTypeSynonymAnnotation(TypeSynonymAnnotation! node)
    }

    // Undo the effects of Resolve
    // Doesn't do anything about type resolution effects
    public class UnResolver : FixedVisitor
    {
        public override Implementation VisitImplementation(Implementation node)
        {
            node.Proc = null;
            node.OriginalBlocks = null;
            node.OriginalLocVars = null;
            node.StructuredStmts = null;
            
            return base.VisitImplementation(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            node.Decl = null;
            return node;
        }

        public override Constant VisitConstant(Constant node)
        {
            // TODO: ??
            node = new Constant(node.tok, node.TypedIdent);

            return node;
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            node.Proc = null;

            return base.VisitCallCmd(node);
        }
        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                (node.Fun as FunctionCall).Func = null;
            }

            return base.VisitNAryExpr(node);
        }
        public override Function VisitFunction(Function node)
        {
            return base.VisitFunction(node);
        }
        public override GotoCmd VisitGotoCmd(GotoCmd node)
        {
            node.labelTargets = null;
            return node;
        }
    }
}
