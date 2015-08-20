using System;
using System.Collections.Generic;
using System.Diagnostics;
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
        private readonly Dictionary<string, IAppliable> _funcSub;
        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub) : this(psub, new Dictionary<string, IAppliable>(0))
        {
        }

        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub, Dictionary<string, IAppliable> pFuncSub)
        {
            _sub = psub;
            _funcSub = pFuncSub;
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

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (_funcSub.ContainsKey(node.Fun.FunctionName))
            {
                var dispatchedArgs = new List<Expr>();
                node.Args.Iter(arg => dispatchedArgs.Add(base.VisitExpr(arg)));
                //Debug.Assert(dispatchedArgs.Count == node.Args.Count);
                return new NAryExpr(Token.NoToken, _funcSub[node.Fun.FunctionName], dispatchedArgs);
            }
            return base.VisitNAryExpr(node);
        }
    }

    class ExprMatchVisitor : FixedVisitor
    {
        private List<Expr> _toConsume;
        public bool MayStillMatch = true;
        public readonly Dictionary<IdentifierExpr, Expr> Substitution = new Dictionary<IdentifierExpr, Expr>();
        //public readonly Dictionary<IAppliable, IAppliable> FunctionSubstitution = new Dictionary<IAppliable, IAppliable>();
        //public readonly Dictionary<string, string> FunctionSubstitution = new Dictionary<string, string>();
        public readonly Dictionary<string, IAppliable> FunctionSubstitution = new Dictionary<string, IAppliable>();

        public ExprMatchVisitor(List<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            if (!MayStillMatch
                ||_toConsume.Count == 0
                || !(_toConsume.First() is NAryExpr)
                || ((node.Fun.FunctionName != Constants.AnyArgs) 
                   && ((NAryExpr) _toConsume.First()).Args.Count != node.Args.Count)
                )
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }

            var naeToConsume = (NAryExpr) _toConsume.First();
            if (naeToConsume.Fun.Equals(node.Fun))
            {
                _toConsume = new List<Expr>(naeToConsume.Args);
            } else if (naeToConsume.Fun.FunctionName.StartsWith("##"))
            {
                _toConsume = new List<Expr>(naeToConsume.Args);
                FunctionSubstitution.Add(naeToConsume.Fun.FunctionName, node.Fun);
            }
            else
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }
            return base.VisitNAryExpr(node);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            if (!MayStillMatch
                ||_toConsume.Count == 0
                || !(_toConsume.First() is IdentifierExpr))
            {
                MayStillMatch = false;
                return base.VisitIdentifierExpr(node);
            }

            var idex = (IdentifierExpr) _toConsume.First();
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
