using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;
using cba.Util;
using Microsoft.Boogie;

namespace PropInst
{
    /// <summary>
    /// A visitor that executes a given Substitution.
    /// the substitution makes a deep copy of the template, i.e., a new Expr/Cmd/.. is returned
    /// </summary>
    class SubstitionVisitor : FixedVisitor
    {
        private readonly Dictionary<string, IAppliable> _funcSub;
        private readonly Dictionary<Declaration, Expr> _substitution;
        private readonly Cmd _matchCmd;

        public SubstitionVisitor(Dictionary<Declaration, Expr> psub)
            : this(psub, new Dictionary<string, IAppliable>(0), null)
        {
        }

        public SubstitionVisitor(Dictionary<Declaration, Expr> psub, Dictionary<string, IAppliable> pFuncSub, Cmd mCmd )
        {
            _substitution = psub;
            _funcSub = pFuncSub;
            _matchCmd = mCmd;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl != null && _substitution.ContainsKey(node.Decl)) 
            {
                var replacement = _substitution[node.Decl];
                return replacement;
            }
            if (node.Decl != null)
                return new IdentifierExpr(node.tok, node.Decl, node.Immutable);
            else
                return new IdentifierExpr(node.tok, node.Name, node.Type, node.Immutable);
        }

        public override AssignLhs VisitSimpleAssignLhs(SimpleAssignLhs node)
        {
            var e = VisitIdentifierExpr(node.AssignedVariable);
            if (!(e is IdentifierExpr))
            {
                throw new InvalidExpressionException("lhs must be an identifier, also after substitution --> malformed property??");
            }
            return new SimpleAssignLhs(node.tok, (IdentifierExpr) e);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var dispatchedArgs = new List<Expr>();
            foreach (var arg in node.Args)
            {
                dispatchedArgs.Add(VisitExpr(arg));
            }

            if (_funcSub.ContainsKey(node.Fun.FunctionName))
            {
                Debug.Assert(dispatchedArgs.Count == node.Args.Count); //otherwise use ANYFUNC or so..
                return new NAryExpr(Token.NoToken, _funcSub[node.Fun.FunctionName], dispatchedArgs);
            }

            //default: just put together the NAryExpression with the function from before
            return new NAryExpr(node.tok, node.Fun, dispatchedArgs);
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {

            //special syntax "call this();"
            if (node.callee == "#this")
            {
                Debug.Assert(_matchCmd != null);
                return _matchCmd;
            }

            var dispatchedIns = new List<Expr>();
            node.Ins.Iter(arg => dispatchedIns.Add(VisitExpr(arg)));

            var dispatchedOuts = new List<IdentifierExpr>();
            foreach (var arg in node.Outs)
            {
                var e = VisitIdentifierExpr(arg);
                if (!(e is IdentifierExpr))
                {
                    throw new InvalidExpressionException("lhs must be an identifier, also after substitution --> malformed property??");
                }
                dispatchedOuts.Add((IdentifierExpr)e);
            }
            return new CallCmd(node.tok, node.callee, dispatchedIns, dispatchedOuts, node.Attributes, node.IsAsync);//TODO clone the attributes too??
        }

        /////////////////
        // here begin the visit overrides that are only necessary for the cloning, and have nothing to do with the substitution itself 
        // --> one might move them to a clone visitor..
        /////////////////

        public override AssignLhs VisitMapAssignLhs(MapAssignLhs node)
        {
            var dispatchedIndices = new List<Expr>();

            foreach (var ind in node.Indexes)
            {
                dispatchedIndices.Add(VisitExpr(ind));
            }

            AssignLhs newAssignLhs = null;
            if (node.Map is MapAssignLhs)
            {
                newAssignLhs = VisitMapAssignLhs(node.Map as MapAssignLhs);
            }
            else if (node.Map is SimpleAssignLhs)
            {
                newAssignLhs = VisitSimpleAssignLhs(node.Map as SimpleAssignLhs);
            }


            return new MapAssignLhs(node.tok, newAssignLhs, dispatchedIndices);
        }


        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            return new AssertCmd(node.tok, VisitExpr(node.Expr));
        }

        public override Cmd VisitAssignCmd(AssignCmd node)
        {
            var lhssDispatched = new List<AssignLhs>();
            foreach (var lhs in node.Lhss)
            {
                if (lhs is MapAssignLhs)
                {
                    lhssDispatched.Add(VisitMapAssignLhs(lhs as MapAssignLhs));
                }
                else if (lhs is SimpleAssignLhs)
                {
                    lhssDispatched.Add(VisitSimpleAssignLhs(lhs as SimpleAssignLhs));
                }
            }

            var rhssDispatched = new List<Expr>();

            foreach (var rhs in node.Rhss)
            {
                rhssDispatched.Add(VisitExpr(rhs));
            }


            return new AssignCmd(node.tok, lhssDispatched, rhssDispatched);
        }

        public override List<Cmd> VisitCmdSeq(List<Cmd> cmdSeq)
        {
            List<Cmd> dispatchedCmds = new List<Cmd>();

            foreach (var c in cmdSeq)
            {
                if (c is CallCmd)
                {
                    dispatchedCmds.Add(VisitCallCmd(c as CallCmd));
                }
                else if (c is AssignCmd)
                {
                    dispatchedCmds.Add(VisitAssignCmd(c as AssignCmd));
                }
                else if (c is AssertCmd)
                {
                    dispatchedCmds.Add(VisitAssertCmd(c as AssertCmd));
                }
                else if (c is AssumeCmd)
                {
                    dispatchedCmds.Add(VisitAssumeCmd(c as AssumeCmd));
                }
            }

            return dispatchedCmds;
        }
    }

    class ExprMatchVisitor : FixedVisitor
    {
        private List<Expr> _toConsume;
        public bool Matches = true;
        public readonly Dictionary<string, IAppliable> FunctionSubstitution = new Dictionary<string, IAppliable>();
        public readonly Dictionary<Declaration, Expr> Substitution = new Dictionary<Declaration, Expr>();

        public ExprMatchVisitor(Expr pToConsume)
        {
            _toConsume = new List<Expr>() {pToConsume};
        }

        public ExprMatchVisitor(List<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //start with some negative cases
            if (!Matches
                ||_toConsume.Count == 0)
            {
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            if (!(_toConsume.First() is NAryExpr))
            {
                //may still be an IdentifierExp intended to match any exp
                if (_toConsume.First() is IdentifierExpr
                    && !BoogieUtil.checkAttrExists(KeyWords.IdExpr, ((IdentifierExpr) _toConsume.First()).Decl.Attributes))
                {
                    Substitution.Add(((IdentifierExpr) _toConsume.First()).Decl, node);
                    _toConsume.RemoveAt(0);
                    return node;
                }
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            var naeToConsume = (NAryExpr) _toConsume.First();

            if (((NAryExpr) _toConsume.First()).Args.Count != node.Args.Count)
            {
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            // now the positive cases
            if (naeToConsume.Fun.Equals(node.Fun))
            {
                _toConsume = new List<Expr>(naeToConsume.Args);
                return base.VisitNAryExpr(node);
            } 
            if (naeToConsume.Fun is FunctionCall
                && ((FunctionCall) naeToConsume.Fun).Func != null)
            {
                var func = ((FunctionCall) naeToConsume.Fun).Func; //TODO: use attributes..

                FunctionSubstitution.Add(naeToConsume.Fun.FunctionName, node.Fun);

                _toConsume = new List<Expr>(naeToConsume.Args);
                return base.VisitNAryExpr(node);
            }
            Matches = false;
            return base.VisitNAryExpr(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (!Matches
                || _toConsume.Count == 0)
            {
                Matches = false;
                return base.VisitIdentifierExpr(node);
            }
            if (!(_toConsume.First() is IdentifierExpr))
            {
                Matches = false;
                return base.VisitIdentifierExpr(node);
            }

            var idexToConsume = (IdentifierExpr) _toConsume.First();

            if (idexToConsume.Decl != null)
            {
                Substitution.Add(idexToConsume.Decl, node);
                _toConsume.RemoveAt(0);
                return base.VisitIdentifierExpr(node);
            }
            if (idexToConsume.Name == node.Name)
            {
                return base.VisitIdentifierExpr(node);
            }

            Matches = false;
            return base.VisitIdentifierExpr(node);
        }
        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            if (!Matches
                || _toConsume.Count == 0)
            {
                Matches = false;
                return base.VisitLiteralExpr(node);
            }

            if (!(_toConsume.First() is LiteralExpr))
            {
                if (_toConsume.First() is IdentifierExpr)
                {
                    //TODO add check for the corresponding attribute which says it may match anything
                    Substitution.Add(((IdentifierExpr) _toConsume.First()).Decl, node);
                    _toConsume.RemoveAt(0);
                    return node;
                }
                Matches = false;
                return base.VisitLiteralExpr(node);
            }
            if (node.Val.Equals(((LiteralExpr) _toConsume.First()).Val))
            {
                return base.VisitLiteralExpr(node);
            }
            Matches = false;
            return base.VisitLiteralExpr(node);
        }
    }

     class ProcedureSigMatcher
    {
         public static bool MatchSig(Implementation toMatch, DeclWithFormals dwf, Program boogieProgram, out QKeyValue toMatchAnyParamsAttributes, out int anyParamsPosition, out Dictionary<Declaration, Expr> paramSubstitution)
         {
             toMatchAnyParamsAttributes = null;
             anyParamsPosition = int.MaxValue;
             paramSubstitution = new Dictionary<Declaration, Expr>();

             if (!Driver.AreAttributesASubset(toMatch.Attributes, dwf.Attributes))
             {
                 return false;
             }

             // match procedure name

             if (BoogieUtil.checkAttrExists(KeyWords.AnyProcedure, toMatch.Attributes))
             {
                 //do nothing
             }
             else if (BoogieUtil.checkAttrExists(KeyWords.NameMatches, toMatch.Attributes))
             {
                 var nmAttrParams = BoogieUtil.getAttr(KeyWords.NameMatches, toMatch.Attributes);
                 var regex = nmAttrParams.First().ToString();
                 var m = Regex.Match(dwf.Name, regex);
                 if (m.Success)
                 {
                     //do nothing
                 }
                 else
                 {
                     return false;
                 }
             }
             else if (toMatch.Name != dwf.Name)
             {
                 return false;
             }

             // if the procedure name is matched, it may still be that we are looking only for stubs
             if (BoogieUtil.checkAttrExists(KeyWords.NoImplementation, toMatch.Attributes))
             {
                 foreach (var i in boogieProgram.Implementations)
                     if (i.Name == dwf.Name)
                         return false;
             }


             // match procedure parameters
             for (var i = 0; i < toMatch.InParams.Count; i++)
             {
                 if (i >= dwf.InParams.Count)
                     return false;

                 if (i == toMatch.InParams.Count - 1
                         && BoogieUtil.checkAttrExists(KeyWords.AnyParams, toMatch.Proc.InParams[i].Attributes))
                 {
                     toMatchAnyParamsAttributes = toMatch.InParams[i].Attributes;
                     if (toMatchAnyParamsAttributes != null)
                         toMatchAnyParamsAttributes.Next = toMatch.Proc.InParams[i].Attributes;
                     else
                         toMatchAnyParamsAttributes = toMatch.Proc.InParams[i].Attributes;
                     toMatchAnyParamsAttributes = BoogieUtil.removeAttr(KeyWords.AnyParams, toMatchAnyParamsAttributes);

                     //TODO the type may also be constrained

                     anyParamsPosition = i;
                     //don't add it to the substitution
                     continue;
                 }
                 if (!toMatch.InParams[i].TypedIdent.Type.Equals(dwf.InParams[i].TypedIdent.Type))
                     return false;

                 paramSubstitution.Add(toMatch.InParams[i], new IdentifierExpr(Token.NoToken, dwf.InParams[i]));
             }

             // match procedure out parameters
             for (var i = 0; i < toMatch.OutParams.Count; i++)
             {
                 if (i == toMatch.OutParams.Count - 1
                         && BoogieUtil.checkAttrExists(KeyWords.AnyParams, toMatch.Proc.OutParams[i].Attributes))
                 {
                     //TODO: do the same stuff as for inparams?..

                     //toMatchAnyParamsAttributes = toMatch.OutParams[i].Attributes;
                     //if (toMatchAnyParamsAttributes != null)
                     //    toMatchAnyParamsAttributes.Next = toMatch.Proc.OutParams[i].Attributes;
                     //else
                     //    toMatchAnyParamsAttributes = toMatch.Proc.OutParams[i].Attributes;
                     //BoogieUtil.removeAttr(KeyWords.AnyParams, toMatchAnyParamsAttributes);

                     //TODO the type may also be constrained

                     //anyParamsPosition = i;
                 }
                 else if (!toMatch.OutParams[i].TypedIdent.Type.Equals(dwf.OutParams[i].TypedIdent.Type))
                 {
                     return false;
                 }
                 paramSubstitution.Add(toMatch.OutParams[i], new IdentifierExpr(Token.NoToken, dwf.OutParams[i]));
             }
             return true;
        }
    }

     class OccursInVisitor : FixedVisitor
     {
         private readonly Variable _toSearch;
         public bool Success = false;
         public OccursInVisitor(Variable pToSearch)
         {
             _toSearch = pToSearch;
         }

         public override Expr VisitIdentifierExpr(IdentifierExpr node)
         {
             if (node.Decl == _toSearch)
             {
                 Success = true;
             }
             return base.VisitIdentifierExpr(node);
         }
     }
}
