using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;

namespace cba.Util
{
    // Useful visitors

    // This is to gather the set of all variables used in a Boogie AST.
    public class GlobalVarsUsed : VarsUsed
    {
        public HashSet<string> Used
        {
            get
            {
                return globalsUsed;
            }
        }

    }

    public class VarsUsed : FixedVisitor
    {
        // The set of all local variables used in the expression
        public HashSet<string> localsUsed { get; private set; }

        // The set of all global variables used in the expression
        public HashSet<string> globalsUsed { get; private set; }

        // The set of variables used in the expression
        public HashSet<string> varsUsed { get; private set; }
        public HashSet<Variable> Vars { get; private set; }

        // The set of functions used in the expression
        public HashSet<string> functionsUsed { get; private set; }

        // The set of variables whose "old" versions are used in the expression
        // This can only be for global variables. old(local) doesn't mean anything
        // in Boogie
        public HashSet<string> oldVarsUsed { get; private set; }

        // To keep track of whether we're in an "old" Expr
        private int inOld;

        public VarsUsed()
        {
            localsUsed = new HashSet<string>();
            globalsUsed = new HashSet<string>();
            varsUsed = new HashSet<string>();
            oldVarsUsed = new HashSet<string>();
            Vars = new HashSet<Variable>();
            functionsUsed = new HashSet<string>();
            inOld = 0;
        }

        public void reset()
        {
            localsUsed = new HashSet<string>();
            globalsUsed = new HashSet<string>();
            varsUsed = new HashSet<string>();
            oldVarsUsed = new HashSet<string>();
            Vars = new HashSet<Variable>();
            functionsUsed = new HashSet<string>();
            inOld = 0;
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            if (inOld > 0)
            {
                Log.WriteLine(Log.Warning, "Recursive \"old\" expression");
            }

            inOld++;
            Expr ret = base.VisitOldExpr(node);
            inOld--;

            return ret;
        }
        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl != null)
            {
                varsUsed.Add(node.Decl.Name);
                Vars.Add(node.Decl);

                if (node.Decl is GlobalVariable)
                {
                    foundGlobal(node.Decl.Name);
                    return node;
                }
                else if (node.Decl is LocalVariable)
                {
                    foundLocal(node.Decl.Name);
                    return node;
                }
            }

            return base.VisitIdentifierExpr(node);
        }


        public override Variable VisitVariable(Variable node)
        {
            varsUsed.Add(node.Name);
            Vars.Add(node);

            if(node is GlobalVariable) 
            {
                foundGlobal(node.Name);
                return node;
            }
            else if (node is LocalVariable)
            {
                foundLocal(node.Name);
                return node;
            }

            return base.VisitVariable(node);

        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                functionsUsed.Add((node.Fun as FunctionCall).FunctionName);
            }

            return base.VisitNAryExpr(node);
        }

        private void foundGlobal(string name)
        {
            globalsUsed.Add(name);
            if (inOld > 0)
            {
                oldVarsUsed.Add(name);
            }
        }

        private void foundLocal(string name)
        {
            localsUsed.Add(name);
            if (inOld > 0)
            {
                Log.WriteLine(Log.Warning, "old(local var) expression used");
            }
        }
    }

    // Use this class to find a variable of a particular name
    public class FindVars : FixedVisitor
    {
        // Variables found
        public Dictionary<string, Variable> varsFound { get; private set; }

        public FindVars()
        {
            varsFound = new Dictionary<string, Variable>();
        }

        public void reset()
        {
            varsFound = new Dictionary<string, Variable>();
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            if (node.Proc != null)
            {
                base.VisitIdentifierExprSeq(node.Proc.Modifies);
            }

            return base.VisitCallCmd(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl != null)
            {
                if (!varsFound.ContainsKey(node.Decl.Name))
                    varsFound.Add(node.Decl.Name, node.Decl);

                return node;
            }

            return base.VisitIdentifierExpr(node);
        }


        public override Variable VisitVariable(Variable node)
        {
            if (!varsFound.ContainsKey(node.Name))
                varsFound.Add(node.Name, node);

            return node;
        }

    }

    public class usesUserType : FixedVisitor
    {
        public bool hasUserType { get; private set; }

        public usesUserType()
        {
            hasUserType = false;
        }

        public void reset()
        {
            hasUserType = false;
        }

        public override CtorType VisitCtorType(CtorType node)
        {
            hasUserType = true;
            return base.VisitCtorType(node);
        }
    }

    public class GlobalVariableRenamer : FixedVisitor
    {
        private int k;
        private HashSet<GlobalVariable> FVisited;
        private Dictionary<string, GlobalVariable> decls;

        public GlobalVariableRenamer(int _k) 
        {
            k = _k;
            FVisited = new HashSet<GlobalVariable>();
            decls = new Dictionary<string, GlobalVariable>();
        }

        private GlobalVariable GetNewVar(GlobalVariable gbl)
        {
            // Don't create new if gbl is already a new one
            if (FVisited.Contains(gbl))
                return null;

            // Have we created a new variable for this one before?
            GlobalVariable gnew = null;
            decls.TryGetValue(gbl.Name, out gnew);
            if (gnew == null)
            {
                var newname = gbl.Name + "__" + k.ToString();
                gnew = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, newname, gbl.TypedIdent.Type));
                FVisited.Add(gnew);
            }

            return gnew;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            IdentifierExpr newNode;
            if (node.Name != node.Decl.Name || node.Name != node.Decl.TypedIdent.Name)
                Console.WriteLine("Inconsistent variable/ident naming on " + node.Name + " " + node.Decl.Name + " " + node.Decl.TypedIdent.Name);

            GlobalVariable g = node.Decl as GlobalVariable;
            if (g == null)
            {
                newNode = null;
            }
            else
            {
                g = GetNewVar(g);
                if (g == null)
                {
                    newNode = null;
                }
                else
                {
                    //newNode = Expr.Ident(g);
                    newNode = new IdentifierExpr(Token.NoToken, g);
                }
            }
            return base.VisitIdentifierExpr(newNode == null ? node : newNode);
        }


        public override Variable VisitVariable(Variable node)
        {
            Variable newg;

            GlobalVariable g = node as GlobalVariable;
            if (g == null)
            {
                newg = null;
            }
            else
            {
                newg = GetNewVar(g);

            }

            return base.VisitVariable(newg == null ? node : newg);

        }
    }

    public class VarSubstituter : FixedVisitor
    {
        private Dictionary<string, Variable> defl;
        private Dictionary<string, Variable> subst;
        private Dictionary<string, Function> funcs;

        public VarSubstituter(Dictionary<string, Variable> subst, Dictionary<string, Variable> defl)
        {
            this.subst = subst;
            this.defl = defl;
            this.funcs = new Dictionary<string, Function>();
        }

        public VarSubstituter(Dictionary<string, Variable> subst, Dictionary<string, Variable> defl, Dictionary<string, Function> funcs)
        {
            this.subst = subst;
            this.defl = defl;
            this.funcs = funcs;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (subst.ContainsKey(node.Name))
            {
                return new IdentifierExpr(Token.NoToken, subst[node.Name]);
            }
            if (defl.ContainsKey(node.Name))
            {
                return new IdentifierExpr(Token.NoToken, defl[node.Name]);
            }
            if (defl.ContainsKey(node.Name + "__0"))
            {
                return new IdentifierExpr(Token.NoToken, defl[node.Name + "__0"]);
            }
            return node;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (node.Fun is FunctionCall)
            {
                var fc = node.Fun as FunctionCall;
                if (fc.Func != null && funcs.ContainsKey(fc.Func.Name)) fc.Func = funcs[fc.Func.Name];
            }

            return base.VisitNAryExpr(node);
        }

        public override Variable VisitVariable(Variable node)
        {
            if (subst.ContainsKey(node.Name))
            {
                return subst[node.Name];
            }
            if (defl.ContainsKey(node.Name))
            {
                return defl[node.Name];
            }
            if (defl.ContainsKey(node.Name + "__0"))
            {
                return defl[node.Name + "__0"];
            }
            return node;
        }
    }


    public class VariableInstanceRenamer : FixedVisitor
    {
        private List<HDuple<string>> subs;
        private Dictionary<string, Variable> decls;

        public VariableInstanceRenamer(List<Variable> decls)
        {
            this.subs = new List<HDuple<string>>();
            this.decls = new Dictionary<string, Variable>();
            foreach (Variable v in decls)
                this.decls.Add(v.Name, v);
        }

        public VariableInstanceRenamer(List<HDuple<string>> subs, List<Variable> decls)
            : this(decls)
        {
            this.subs = (subs == null ? new List<HDuple<string>>() : subs);
        }

        public void Add(string a, string b)
        {
            this.subs.Add(new HDuple<string>(a, b));
        }

        public void AddRange(List<HDuple<string>> a)
        {
            this.subs.AddRange(a);
        }

        public void AddDecls(List<Variable> vs)
        {
            foreach (Variable v in vs)
                decls.Add(v.Name, v);
        }

        public Variable TryLookUpSub(string n)
        {
            var newN = subs.Find(x => x.fst == n);
            if (newN == null)
                return null;
            if (newN.snd == null)
                Console.WriteLine("There is no rename mapping for " + newN.fst);
            Variable v;
            decls.TryGetValue(newN.snd, out v);
            if (v == null)
                Console.WriteLine("subbed (" + newN.fst + ", " + newN.snd + ") into null in VariableInstanceRenamer");
            return v;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            IdentifierExpr newNode;
            if (node.Name != node.Decl.Name || node.Name != node.Decl.TypedIdent.Name)
                Console.WriteLine("Inconsistent variable/ident naming on " + node.Name + " " + node.Decl.Name + " " + node.Decl.TypedIdent.Name);
            var v = TryLookUpSub(node.Name);
            if (v == null)
                newNode = null;
            else
                newNode = Expr.Ident(v);

            return base.VisitIdentifierExpr(newNode == null ? node : newNode);
        }

        public override Variable VisitVariable(Variable node)
        {
            var newNode = TryLookUpSub(node.Name);
            return base.VisitVariable(newNode == null ? node : newNode);
        }
    }

    // Fixes the standard visitor by enforcing that the type hierarchy is respected.
    // VisitA can only call VisitB is B is a subtype of A. This should rule out cycles
    // from showing up.
    public class FixedVisitor : StandardVisitor
    {
        public override Declaration VisitDeclaration(Declaration node)
        {

            if (node is Axiom)
                node = this.VisitAxiom((Axiom)node);
            else if (node is Variable)
                node = this.VisitVariable((Variable)node);
            else if (node is TypeSynonymDecl)
                node = this.VisitTypeSynonymDecl((TypeSynonymDecl)node);
            else if (node is TypeCtorDecl)
                node = this.VisitTypeCtorDecl((TypeCtorDecl)node);
            else if (node is DeclWithFormals)
                node = this.VisitDeclWithFormals((DeclWithFormals)node);
            else
            {
                node.Emit(new TokenTextWriter(Console.Out), 0);
                throw new InvalidInput("Unknown declaration type");
            }

            return node;

        }

        public override DeclWithFormals VisitDeclWithFormals(DeclWithFormals node)
        {
            node.InParams = this.VisitVariableSeq(node.InParams);
            node.OutParams = this.VisitVariableSeq(node.OutParams);

            if (node is Function)
                node = this.VisitFunction((Function)node);
            else if (node is Implementation)
                node = this.VisitImplementation((Implementation)node);
            else if (node is Procedure)
                node = this.VisitProcedure((Procedure)node);
            else
            {
                node.Emit(new TokenTextWriter(Console.Out), 0);
                throw new InvalidInput("Unknown declaration type");
            }

            return node;
        }

        public override Function VisitFunction(Function node)
        {
            //node = (Function) this.VisitDeclWithFormals(node);
            if (node.Body != null)
                node.Body = this.VisitExpr(node.Body);
            return node;
        }

        public override GlobalVariable VisitGlobalVariable(GlobalVariable node)
        {
            return node;
        }

        public override GotoCmd VisitGotoCmd(GotoCmd node)
        {
            // No need to visit target blocks. Traversing the CFG should be done some other
            // way.
            //node.labelTargets = this.VisitBlockSeq((!)node.labelTargets);
            return node;
        }

        // Don't visit the called procedure
        public override Cmd VisitCallCmd(CallCmd node)
        {
            for (int i = 0; i < node.Ins.Count; ++i)
                if (node.Ins[i] != null)
                    node.Ins[i] = this.VisitExpr(node.Ins[i]);
            for (int i = 0; i < node.Outs.Count; ++i)
                if (node.Outs[i] != null)
                    node.Outs[i] = (IdentifierExpr)this.VisitIdentifierExpr(node.Outs[i]);
            //node.Proc = this.VisitProcedure(node.Proc);
            return node;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl != null)
                node.Decl = this.VisitVariable(node.Decl);
            return node;
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            node.LocVars = this.VisitVariableSeq(node.LocVars);
            node.Blocks = this.VisitBlockList(node.Blocks);
            if (node.Proc != null)
                node.Proc = this.VisitProcedure(node.Proc);
            //node = (Implementation) this.VisitDeclWithFormals(node); // do this first or last?
            node.InParams = this.VisitVariableSeq(node.InParams);
            node.OutParams = this.VisitVariableSeq(node.OutParams);
            return node;
        }

        public override Procedure VisitProcedure(Procedure node)
        {
            node.Ensures = this.VisitEnsuresSeq(node.Ensures);
            //node.InParams = this.VisitVariableSeq(node.InParams);
            node.Modifies = this.VisitIdentifierExprSeq(node.Modifies);
            //node.OutParams = this.VisitVariableSeq(node.OutParams);
            node.Requires = this.VisitRequiresSeq(node.Requires);
            return node;
        }

        public override Variable VisitVariable(Variable node)
        {
            node.TypedIdent = this.VisitTypedIdent(node.TypedIdent);
            if (node is Constant)
                node = VisitConstant((Constant)node);
            else if (node is GlobalVariable)
                node = VisitGlobalVariable((GlobalVariable)node);
            else if (node is Formal)
                node = VisitFormal((Formal)node);
            else if (node is LocalVariable)
                node = VisitLocalVariable((LocalVariable)node);
            else if (node is BoundVariable)
                node = VisitBoundVariable((BoundVariable)node);
            else
                throw new InvalidInput("Unknown variable type");

            return node;
        }

        public override TransferCmd VisitTransferCmd(TransferCmd node)
        {
            if (node is GotoCmd)
            {
                return VisitGotoCmd(node as GotoCmd);
            }
            else if (node is ReturnCmd)
            {
                return VisitReturnCmd(node as ReturnCmd);
            }
            else
            {
                return node;
            }
        }

        public override ReturnCmd VisitReturnCmd(ReturnCmd node)
        {
            return node;
        }

        public override BoundVariable VisitBoundVariable(BoundVariable node)
        {
            return node;
        }
        public override Declaration VisitTypeCtorDecl(TypeCtorDecl node)
        {
            return (Declaration)node;
        }
        public override Declaration VisitTypeSynonymDecl(TypeSynonymDecl node)
        {
            return (Declaration)node;
        }
    }

    /*
    //A boogie Absy visitor that can traverse an ast from the root ("fixes" Microsoft.Boogie.StandardVisitor Behavior)
    //this is really just patching up bizzareness in the visitor's recursive calls piece by piece.
    //TODO: just rewrite the visitor completely
    public class FixedVisitor : StandardVisitor
    {
        //standardvisitor has some completely bizarre calling patterns, 
        //this should more or less stop cycles from popping up..
        // We need one "visited" set for each type where we want to break cycles
        
        private HashSet<Declaration> DeclVisited;
        private HashSet<DeclWithFormals> DeclWithFormalsVisited;
        
        public FixedVisitor()
        {
            DeclVisited = new HashSet<Declaration>();
            DeclWithFormalsVisited = new HashSet<DeclWithFormals>();
        }

        public override Declaration VisitDeclaration(Declaration node)
        {
            if (node == null)
                Console.WriteLine("Null node in VisitDeclaration!");

            if (DeclVisited.Contains(node))
                return node;

            DeclVisited.Add(node);
            
            if (node is Axiom)
                node = this.VisitAxiom((Axiom)node);
            else if (node is Variable)
                node = this.VisitVariable((Variable)node);
            else if (node is TypeSynonymDecl)
                node = this.VisitTypeSynonymDecl((TypeSynonymDecl)node);
            else if (node is TypeCtorDecl)
                node = this.VisitTypeCtorDecl((TypeCtorDecl)node);
            else if (node is DeclWithFormals)
                node = this.VisitDeclWithFormals((DeclWithFormals)node);
            else
            {
                node.Emit(new TokenTextWriter(Console.Out), 0);
                throw new InvalidInput("Unknown declaration type");
            }

            return node;
            //return base.VisitDeclaration(node);
        }

        public override Variable VisitVariable(Variable node)
        {
            if (node == null)
                Console.WriteLine("Null node in VisitVariable!");

            //if (FVisited.Contains(node))
            //  return node;

            //FVisited.Add(node);

            if (node is Constant)
                node = VisitConstant((Constant)node);
            if (node is GlobalVariable)
                node = VisitGlobalVariable((GlobalVariable)node);
            if (node is Formal)
                node = VisitFormal((Formal)node);
            if (node is LocalVariable)
                node = VisitLocalVariable((LocalVariable)node);
            if (node is BoundVariable)
                node = VisitBoundVariable((BoundVariable)node);
            //if (node is SimpleVariable)
            //    node = VisitSimpleVariable((SimpleVariable)node);

            Variable decl = base.VisitVariable(node);
            //FVisited.Add(decl);
            return decl;
            //return base.VisitVariable(node);
        }

        public override DeclWithFormals VisitDeclWithFormals(DeclWithFormals node)
        {
            if (DeclWithFormalsVisited.Contains(node))
              return node;

            DeclWithFormalsVisited.Add(node);

            if (node is Function)
                node = this.VisitFunction((Function)node);
            if (node is Implementation)
                node = this.VisitImplementation((Implementation)node);
            if (node is Procedure)
                node = this.VisitProcedure((Procedure)node);
            return base.VisitDeclWithFormals(node);
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            node.LocVars = this.VisitVariableSeq(node.LocVars);
            node.Blocks = this.VisitBlockList(node.Blocks);
            if (node.Proc != null)                 //program transforms may visit unresolved AST
                node.Proc = this.VisitProcedure(node.Proc);
            return node;
        }

        public override BoundVariable VisitBoundVariable(BoundVariable node)
        {
            return node;
        }

        public override GlobalVariable VisitGlobalVariable(GlobalVariable node)
        {
            return node;
        }

        public override Declaration VisitTypeSynonymDecl(TypeSynonymDecl node)
        {
            return node;
        }
    }
     */
    public class AbsyVisitor : FixedVisitor
    {
        public HashSet<int> nodes;
        public Dictionary<int, Absy> m;

        public AbsyVisitor()
        {
            nodes = new HashSet<int>();
            m = new Dictionary<int, Absy>();
        }

        public void add(Absy node)
        {
            //if (node is TypedIdent) return;
            //if (node is Microsoft.Boogie.Type) return;
            m[node.UniqueId] = node;
            nodes.Add(node.UniqueId);
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            add(node);
            return base.VisitAssertCmd(node);
        }

        public override Cmd VisitAssignCmd(AssignCmd node)
        {
            add(node);
            return base.VisitAssignCmd(node);
        }

        public override Cmd VisitAssumeCmd(AssumeCmd node)
        {
            add(node);
            return base.VisitAssumeCmd(node);
        }

        public override Axiom VisitAxiom(Axiom node)
        {
            add(node);
            return base.VisitAxiom(node);
        }

        public override Microsoft.Boogie.Type VisitBasicType(BasicType node)
        {
            add(node);
            return base.VisitBasicType(node);
        }

        public override BinderExpr VisitBinderExpr(BinderExpr node)
        {
            add(node);
            return base.VisitBinderExpr(node);
        }

        public override Block VisitBlock(Block node)
        {
            add(node);
            return base.VisitBlock(node);
        }

        public override BoundVariable VisitBoundVariable(BoundVariable node)
        {
            add(node);
            return base.VisitBoundVariable(node);
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            add(node);
            return base.VisitCallCmd(node);
        }

        public override Choice VisitChoice(Choice node)
        {
            add(node);
            return base.VisitChoice(node);
        }

        public override Expr VisitCodeExpr(CodeExpr node)
        {
            add(node);
            return base.VisitCodeExpr(node);
        }

        public override Constant VisitConstant(Constant node)
        {
            add(node);
            return base.VisitConstant(node);
        }

        public override CtorType VisitCtorType(CtorType node)
        {
            add(node);
            return base.VisitCtorType(node);
        }

        public override Declaration VisitDeclaration(Declaration node)
        {
            add(node);
            return base.VisitDeclaration(node);
        }

        public override DeclWithFormals VisitDeclWithFormals(DeclWithFormals node)
        {
            add(node);
            return base.VisitDeclWithFormals(node);
        }

        public override Ensures VisitEnsures(Ensures ensures)
        {
            add(ensures);
            return base.VisitEnsures(ensures);
        }

        public override Expr VisitExistsExpr(ExistsExpr node)
        {
            add(node);
            return base.VisitExistsExpr(node);
        }

        public override Expr VisitExpr(Expr node)
        {
            add(node);
            return base.VisitExpr(node);
        }

        public override Expr VisitForallExpr(ForallExpr node)
        {
            add(node);
            return base.VisitForallExpr(node);
        }

        public override Formal VisitFormal(Formal node)
        {
            add(node);
            return base.VisitFormal(node);
        }

        public override Function VisitFunction(Function node)
        {
            add(node);
            return base.VisitFunction(node);
        }

        public override GlobalVariable VisitGlobalVariable(GlobalVariable node)
        {
            add(node);
            return base.VisitGlobalVariable(node);
        }

        public override GotoCmd VisitGotoCmd(GotoCmd node)
        {
            add(node);
            return base.VisitGotoCmd(node);
        }

        public override Cmd VisitHavocCmd(HavocCmd node)
        {
            add(node);
            return base.VisitHavocCmd(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            add(node);
            return base.VisitIdentifierExpr(node);
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            add(node);
            return base.VisitImplementation(node);
        }

        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            add(node);
            return base.VisitLiteralExpr(node);
        }

        public override LocalVariable VisitLocalVariable(LocalVariable node)
        {
            add(node);
            return base.VisitLocalVariable(node);
        }

        public override AssignLhs VisitMapAssignLhs(MapAssignLhs node)
        {
            add(node);
            return base.VisitMapAssignLhs(node);
        }

        public override MapType VisitMapType(MapType node)
        {
            add(node);
            return base.VisitMapType(node);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            add(node);
            return base.VisitNAryExpr(node);
        }

        public override Expr VisitOldExpr(OldExpr node)
        {
            add(node);
            return base.VisitOldExpr(node);
        }

        public override Procedure VisitProcedure(Procedure node)
        {
            add(node);
            return base.VisitProcedure(node);
        }

        public override Program VisitProgram(Program node)
        {
            add(node);
            return base.VisitProgram(node);
        }

        public override QuantifierExpr VisitQuantifierExpr(QuantifierExpr node)
        {
            add(node);
            return base.VisitQuantifierExpr(node);
        }

        public override Requires VisitRequires(Requires requires)
        {
            add(requires);
            return base.VisitRequires(requires);
        }

        public override ReturnCmd VisitReturnCmd(ReturnCmd node)
        {
            add(node);
            return base.VisitReturnCmd(node);
        }

        public override AssignLhs VisitSimpleAssignLhs(SimpleAssignLhs node)
        {
            add(node);
            return base.VisitSimpleAssignLhs(node);
        }

        public override Microsoft.Boogie.Type VisitType(Microsoft.Boogie.Type node)
        {
            add(node);
            return base.VisitType(node);
        }

        public override TransferCmd VisitTransferCmd(TransferCmd node)
        {
            add(node);
            return base.VisitTransferCmd(node);
        }

        public override Declaration VisitTypeCtorDecl(TypeCtorDecl node)
        {
            add(node);
            return base.VisitTypeCtorDecl(node);
        }

        public override TypedIdent VisitTypedIdent(TypedIdent node)
        {
            add(node);
            return base.VisitTypedIdent(node);
        }

        public override Microsoft.Boogie.Type VisitTypeVariable(TypeVariable node)
        {
            add(node);
            return base.VisitTypeVariable(node);
        }

        public override Microsoft.Boogie.Type VisitUnresolvedTypeIdentifier(UnresolvedTypeIdentifier node)
        {
            add(node);
            return base.VisitUnresolvedTypeIdentifier(node);
        }

        public override Variable VisitVariable(Variable node)
        {
            add(node);
            return base.VisitVariable(node);
        }

    }

}
