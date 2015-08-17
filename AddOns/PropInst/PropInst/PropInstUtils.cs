using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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


    class SubstitionVisitor : FixedVisitor
    {
        private readonly Dictionary<IdentifierExpr, Expr> _sub;
        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub)
        {
            _sub = psub;
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (_sub.ContainsKey(node))
            {
                var replacement = _sub[node];
                return replacement;
            }
            return base.VisitIdentifierExpr(node);
        }
    }

    class ExprMatchVisitor : FixedVisitor
    {
        private List<Expr> _toConsume;
        public bool MayStillMatch = true;
        public readonly Dictionary<IdentifierExpr, Expr> Substitution = new Dictionary<IdentifierExpr, Expr>();

        public ExprMatchVisitor(List<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            var nae = _toConsume.First() as NAryExpr;
            if (MayStillMatch
                && _toConsume.Count > 0
                && nae != null
                && nae.Fun.Equals(node.Fun))
            {
                _toConsume = new List<Expr>(nae.Args);
            }
            else
            {
                MayStillMatch = false;
            }
            return base.VisitNAryExpr(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            var idex = _toConsume.First() as IdentifierExpr;
            if (MayStillMatch
                && _toConsume.Count > 0
                && idex != null
                && (idex.Name.StartsWith("##") || idex.Name == node.Name))
            {
                if (idex.Name.StartsWith("##"))
                    Substitution.Add(idex, node);
                _toConsume.RemoveAt(0);
            }
            else
            {
                MayStillMatch = false;
            }
            return base.VisitIdentifierExpr(node);
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
}
