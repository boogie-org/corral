using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using cba.Util;
using Microsoft.Boogie;

namespace PropInst
{

    class FindIdentifiersVisitor : FixedVisitor
    {
        public readonly List<IdentifierExpr> Identifiers = new List<IdentifierExpr>();
        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            Identifiers.Add(node);
            return base.VisitIdentifierExpr(node);
        }
    }


    /// <summary>
    /// A visitor that executes a given Substitution.
    /// old: (Note that this visitor "consumes" the substitution template, i.e.,
    /// the replacements are not done in a copy but the template itself.)
    /// new: the substitution makes a deep copy of the template
    /// </summary>
    class SubstitionVisitor : FixedVisitor
    {
        //private readonly Dictionary<IdentifierExpr, Expr> _idSub;
        private readonly Dictionary<string, IAppliable> _funcSub;
        private readonly Dictionary<Declaration, Expr> _substitution;


        public SubstitionVisitor(Dictionary<Declaration, Expr> psub)
            : this(psub, new Dictionary<string, IAppliable>(0))
            //: this(psub, new Dictionary<string, IAppliable>(0), new Dictionary<IdentifierExpr, Expr>(0))
        {
        }

        public SubstitionVisitor(Dictionary<Declaration, Expr> psub, Dictionary<string, IAppliable> pFuncSub )
            //: this(psub, pFuncSub, new Dictionary<IdentifierExpr, Expr>())
        {
            _substitution = psub;
            _funcSub = pFuncSub;
        }

        //public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> pIdsub, Dictionary<string, IAppliable> pFuncSub, Dictionary<IdentifierExpr, Expr> pSub)
        //{
        //    _idSub = pIdsub;
        //    _funcSub = pFuncSub;
        //    _substitution = pSub;
        //}

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (node.Decl != null && _substitution.ContainsKey(node.Decl)) 
            {
                var replacement = _substitution[node.Decl];
                return replacement;
            }
            //if (_idSub.ContainsKey(node)) 
            //{
            //    var replacement = _idSub[node];
            //    return replacement;
            //}
            return new IdentifierExpr(node.tok, node.Decl, node.Immutable);
            //return base.VisitIdentifierExpr(node);
        }

        public override AssignLhs VisitSimpleAssignLhs(SimpleAssignLhs node)
        {
            Expr e = VisitIdentifierExpr(node.AssignedVariable);
            if (!(e is IdentifierExpr))
            {
                throw new InvalidExpressionException("lhs must be an identifier, also after substitution --> malformed property??");
            }
            return new SimpleAssignLhs(node.tok, (IdentifierExpr) e);
        }

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

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //we have to dispatch explicitly, here..
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
        public bool MayStillMatch = true;
        public readonly Dictionary<string, IAppliable> FunctionSubstitution = new Dictionary<string, IAppliable>();
        public readonly Dictionary<Declaration, Expr> Substitution = new Dictionary<Declaration, Expr>();


        public ExprMatchVisitor(List<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //start with some negative cases
            if (!MayStillMatch
                ||_toConsume.Count == 0)
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }

            if (!(_toConsume.First() is NAryExpr))
            {
                //TODO: may still be an IdentifierExp intended to match any exp
                if (_toConsume.First() is IdentifierExpr)
                {
                    //Substitution.Add((IdentifierExpr) _toConsume.First(), node);
                    Substitution.Add(((IdentifierExpr) _toConsume.First()).Decl, node);
                    return node;
                }
            }

            var naeToConsume = (NAryExpr) _toConsume.First();

            //var isSubstitutionStart = naeToConsume.Fun.FunctionName == "=="
            //                          && naeToConsume.Args[0] is IdentifierExpr
            //                          && ((IdentifierExpr) naeToConsume.Args[0]).Name.StartsWith("??");
            //var substIdEx = naeToConsume.Args[0] as IdentifierExpr;
            //if (isSubstitutionStart)
            //{
            //    if (naeToConsume.Args[1] is IdentifierExpr)
            //    {
            //        //for this we should have the other substitutions with ##id..
            //        // maybe unify some other time..
            //        throw new NotImplementedException(); 
            //    }
            //    naeToConsume = (NAryExpr) naeToConsume.Args[1];
            //}
            //if (isSubstitutionStart)
            //    Substitution.Add(substIdEx, node);//TODO or dispatch node first??


            if (//((naeToConsume.Fun.FunctionName != Constants.AnyArgs)
                // && (naeToConsume.Fun.FunctionName != Constants.AnySum)
                 //&& 
                 ((NAryExpr) _toConsume.First()).Args.Count != node.Args.Count)
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }

            // now the positive cases
            if (naeToConsume.Fun.Equals(node.Fun))
            //if (naeToConsume.Fun.FunctionName == node.Fun.FunctionName)
            {
                _toConsume = new List<Expr>(naeToConsume.Args);

                return base.VisitNAryExpr(node);
            } 
            if (naeToConsume.Fun is FunctionCall
                && ((FunctionCall) naeToConsume.Fun).Func != null)
            //if (naeToConsume.Fun.FunctionName.StartsWith("##"))
            {
                var func = ((FunctionCall) naeToConsume.Fun).Func; //TODO: use attributes..

                _toConsume = new List<Expr>(naeToConsume.Args);
                if (!FunctionSubstitution.ContainsKey(naeToConsume.Fun.FunctionName))
                    FunctionSubstitution.Add(naeToConsume.Fun.FunctionName, node.Fun);//TODO: understand..
                return base.VisitNAryExpr(node);
            }
            //if (naeToConsume.Fun.FunctionName == Constants.AnyArgs)
            //{
            //    throw new NotImplementedException();//TODO..
            //}
            //if (naeToConsume.Fun.FunctionName == Constants.AnySum
            //    && node.Fun.FunctionName == "+")//TODO: find out how to match the BinaryOperator nicer..
            //{
            //    //drop the AnySum from toConsume
            //    if (_toConsume.Count > 0)
            //    {
            //        _toConsume.RemoveAt(0);
            //        _toConsume.Insert(0, naeToConsume.Args[0]);
            //    }

            //    var tcTmp = _toConsume;
            //    var msmNew = false;
            //    foreach (var arg in node.Args) //we want to match one of the arguments..
            //    {
            //        MayStillMatch = true;

            //        _toConsume = tcTmp;
            //        var dispatchResult = base.VisitExpr(arg);
            //        msmNew |= MayStillMatch;
            //    }
            //    MayStillMatch = msmNew;
            //    return node; //!! node, not base.Visit(node) or so.. (because we're doing the dispatch by hand, here..)
            //}
            //if (naeToConsume.Fun.FunctionName == Constants.AnySum
            //    && node.Args.Count == 1)
            //{
            //    //we have the addition with one summand - case: just drop the AnySum from toConsume

            //    //drop the AnySum from toConsume
            //    if (_toConsume.Count > 0)
            //    {
            //        _toConsume.RemoveAt(0);
            //        _toConsume.Insert(0, naeToConsume.Args[0]);
            //    }
            //   return this.VisitNAryExpr(node);
            //}
            MayStillMatch = false;
            return base.VisitNAryExpr(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (!MayStillMatch
                || _toConsume.Count == 0)
            {
                MayStillMatch = false;
                return base.VisitIdentifierExpr(node);
            }
            // account for special keywords IDEXPR and ANYSUM
            // as we are visiting an IdentifierExpr their effect is the same
            // ANYSUM is supposed to match sums with just one summand
            // in contrast to IDEXPR it does also match complex expressions inside, 
            // but that is not asked for here (as, again: we are visitin an IdentifierExpr)
            var toConsumeIsNaryDdIdExpr = (_toConsume.First() is NAryExpr)
                                          && (((NAryExpr) _toConsume.First()).Fun.FunctionName == Constants.IdExpr);
            var toConsumeIsNaryDdAnySum = (_toConsume.First() is NAryExpr)
                                          && (((NAryExpr) _toConsume.First()).Fun.FunctionName == Constants.AnySum);

            if (//!toConsumeIsNaryDdIdExpr 
                 //   && !toConsumeIsNaryDdAnySum
               //     && 
                !(_toConsume.First() is IdentifierExpr))
            {
                MayStillMatch = false;
                return base.VisitIdentifierExpr(node);
            }

            //if (toConsumeIsNaryDdIdExpr || toConsumeIsNaryDdAnySum)
            //{
            //    var ddIdExpr = (NAryExpr) _toConsume.First();
            //    //we want to match any IdentifierExpr, and refer to it later with the given (single) argument
            //    Debug.Assert(ddIdExpr.Args.Count == 1);
            //    Debug.Assert(toConsumeIsNaryDdAnySum || ddIdExpr.Args[0] is IdentifierExpr);
            //    //just remove the function application of IDEXPR or ANYSUM here from _toConsume, then restart the method on the argument
            //    var funAp = _toConsume[0];
            //    _toConsume.RemoveAt(0);
            //    _toConsume.Insert(0, ((NAryExpr) funAp).Args[0]);
            //    var dispatchResult =  this.VisitIdentifierExpr(node); //this, not base
            //    return dispatchResult;
            //}

            var idexToConsume = (IdentifierExpr) _toConsume.First();
            //if (idexToConsume.Name == node.Name
            //    || idexToConsume.Name == Constants.IdExpr)
            //{
            //    //do nothing --> just go on matching..
            //    _toConsume.RemoveAt(0);
            //    return base.VisitIdentifierExpr(node);
            //}
            if (idexToConsume.Decl != null)
            //if (idexToConsume.Name.StartsWith("##"))
            {
                //if (!Substitution.ContainsKey(idexToConsume))//TODO: understand..
                Substitution.Add(idexToConsume.Decl, node);
                _toConsume.RemoveAt(0);
                return base.VisitIdentifierExpr(node);
            }

            MayStillMatch = false;
            return base.VisitIdentifierExpr(node);
        }
        public override Expr VisitLiteralExpr(LiteralExpr node)
        {
            if (!MayStillMatch
                || _toConsume.Count == 0)
            {
                MayStillMatch = false;
                return base.VisitLiteralExpr(node);
            }

            if (!(_toConsume.First() is LiteralExpr))
            {
                //TODO: may still be an IdentifierExp intended to match any exp
                if (_toConsume.First() is IdentifierExpr)
                {
                    Substitution.Add(((IdentifierExpr) _toConsume.First()).Decl, node);
                    return node;
                }
            }
            if (node.Val.Equals(((LiteralExpr) _toConsume.First()).Val))
            {
                return base.VisitLiteralExpr(node);
            }
            MayStillMatch = false;
            return base.VisitLiteralExpr(node);
        }
    }

     class ProcedureSigMatcher
    {
        private readonly Procedure _toMatch;
        private readonly Implementation _impl;

        // idea: if we have ##ANYPARAMS specified in toMatch, then we may chose to filter parameters through these Attributs 
        // (as usual, only params are used whose attributes are a superset of the ones specified in toMatch)
        public QKeyValue ToMatchAnyParamsAttributes;

        public ProcedureSigMatcher(Procedure toMatch, Implementation impl)
        {
            _impl = impl;
            _toMatch = toMatch;
        }

         public bool MatchSig()
         {

             if (!Driver.AreAttributesASubset(_toMatch.Attributes, _impl.Attributes)) return false;

             if (_toMatch.Name.StartsWith("##"))
             {
                 //do nothing
             }
             else if (_toMatch.Name != _impl.Name)
             {
                 return false;
             }
             if (_toMatch.InParams.Count == 1 && _toMatch.InParams[0].Name == "##ANYPARAMS")
             {
                 ToMatchAnyParamsAttributes = _toMatch.InParams[0].Attributes;
             }
             else if (_toMatch.InParams.Count != _impl.InParams.Count)
             {
                 return false;
             }
             else
             {
                 for (int i = 0; i < _toMatch.InParams.Count; i++)
                 {
                     if (_toMatch.InParams[i].GetType() != _impl.InParams[i].GetType())
                         return false;
                 }
             }
             if (_toMatch.OutParams.Count == 1 && _toMatch.OutParams[0].Name == "##ANYPARAMS")
             {
                 //do nothing
             }
             else if (_toMatch.OutParams.Count != _impl.OutParams.Count)
             {
                 return false;
             }
             return true;
        }
    }

     public class GatherMemAccesses : FixedVisitor
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
