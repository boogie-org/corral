using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
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
        private readonly Dictionary<IdentifierExpr, Expr> _idSub;
        private readonly Dictionary<string, IAppliable> _funcSub;
        //private List<Tuple<Expr, Expr>> _complexSub;
        //private Stack<List<Tuple<Expr, Expr>>> _possibleComplexMatches = new Stack<List<Tuple<Expr, Expr>>>();
        private readonly Dictionary<IdentifierExpr, Expr> _substitution;


        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub) 
            : this(psub, new Dictionary<string, IAppliable>(0), new Dictionary<IdentifierExpr, Expr>(0))
        {
        }

        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> psub, Dictionary<string, IAppliable> pFuncSub )
            : this(psub, pFuncSub, new Dictionary<IdentifierExpr, Expr>())
        {
        }

        public SubstitionVisitor(Dictionary<IdentifierExpr, Expr> pIdsub, Dictionary<string, IAppliable> pFuncSub, Dictionary<IdentifierExpr, Expr> pSub)
        {
            _idSub = pIdsub;
            _funcSub = pFuncSub;
            _substitution = pSub;
            //_complexSub = pComplexSub;
            //_possibleComplexMatches.Push(pComplexSub);
        }

        public override Expr VisitIdentifierExpr(IdentifierExpr node)
        {
            ////Debug.Assert(_possibleComplexMatches.Peek().Count <= 1);
            //foreach (var pair in _possibleComplexMatches.Peek())
            //{
            //    IdentifierExpr idToMatch = null;
            //    if (pair.Item1 is NAryExpr)
            //    {
            //        var nae = (NAryExpr) pair.Item1;
            //        if (nae.Fun.FunctionName == Constants.IdExpr)
            //        {
            //            Debug.Assert(nae.Args.Count == 1);
            //            idToMatch = (IdentifierExpr) nae.Args[0];
            //        }
            //        else
            //        {
            //            continue;
            //        }
            //    }
            //    else if (pair.Item1 is IdentifierExpr)
            //    {
            //        idToMatch = (IdentifierExpr) pair.Item1;
            //    }
            //    else
            //    {
            //        //no match
            //        continue;
            //    }

            //    if (idToMatch.Name == node.Name)
            //    {
            //        return pair.Item2;
            //    }
            //    //if (idToMatch.Name.StartsWith("##")) --> when we do complex matching, we don't need the simple, right??..
            //    //{

            //    //    var replacement = _idSub[node];
            //    //    return replacement;
            //    //}

            //}
            //TODO
            if (_substitution.ContainsKey(node)) 
            {
                var replacement = _substitution[node];
                return replacement;
            }

            if (_idSub.ContainsKey(node)) 
            {
                var replacement = _idSub[node];
                return replacement;
            }

            return base.VisitIdentifierExpr(node);
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //we have to dispatch explicitly, here..
            var dispatchedArgs = new List<Expr>();
            foreach (var arg in node.Args)
            {
                //List<Tuple<Expr, Expr>> newPossibleComplexMatches;
                //if (node.Fun.FunctionName == Constants.AnySum)
                //{
                //    newPossibleComplexMatches = new List<Tuple<Expr, Expr>>();
                //    foreach (var complexSubPair in _possibleComplexMatches.Peek())
                //    {
                //        if (!(complexSubPair.Item1 is NAryExpr))
                //            continue; //this cannot become a match --> leave it out..
                //        var item1 = (NAryExpr) complexSubPair.Item1;
                //        if (item1.Fun.FunctionName == Constants.AnySum)
                //        {
                //            var item2 = complexSubPair.Item2;
                //            //if (item2 is NAryExpr && ((NAryExpr) item2).Fun.FunctionName == Constants.AnySum)
                //            //    item2 = ((NAryExpr) item2).Args[0];

                //            Debug.Assert(item1.Args.Count == 1, Constants.AnySum + " may get at most one argument");
                //            //Debug.Assert(item2.Args.Count == 1, Constants.AnySum + " may get at most one argument");

                //            var newPair = new Tuple<Expr, Expr>(item1.Args[0], item2);
                //            //var newPair = new Tuple<Expr, Expr>(item1.Args[0], complexSubPair.Item2);
                //            newPossibleComplexMatches.Add(newPair);
                //        }
                //    }
                //}
                //else
                //{
                //    newPossibleComplexMatches =
                //        _possibleComplexMatches.Peek();
                //}
                //_possibleComplexMatches.Push(newPossibleComplexMatches);
                dispatchedArgs.Add(VisitExpr(arg));
                //_possibleComplexMatches.Pop();
                //TODO?..
            }
 

            if (_funcSub.ContainsKey(node.Fun.FunctionName))
            {
                Debug.Assert(dispatchedArgs.Count == node.Args.Count); //otherwise use ANYFUNC or so..
                return new NAryExpr(Token.NoToken, _funcSub[node.Fun.FunctionName], dispatchedArgs);
            }

            // when putting together the result, just leave out ANYSUM and IDEXPR and so on..
            if (node.Fun.FunctionName == Constants.AnySum)
            {
                Debug.Assert(dispatchedArgs.Count == 1);
                return dispatchedArgs.First();
            }
            if (node.Fun.FunctionName == Constants.IdExpr)
            {
                Debug.Assert(dispatchedArgs.Count == 1);
                return dispatchedArgs.First();
            }

            //default: just put together the NAryExpression with the function from before
            return new NAryExpr(node.tok, node.Fun, dispatchedArgs);
        }
    }

    class ExprMatchVisitor : FixedVisitor
    {
        private List<Expr> _toConsume;
        public bool MayStillMatch = true;
        public readonly Dictionary<IdentifierExpr, Expr> IdentifierSubstitution = new Dictionary<IdentifierExpr, Expr>();
        //problem with IAppliable -> IAppliable: the hashcode function of IAppliaple refers to the function declaration, which is null for the expression from our property..
        public readonly Dictionary<string, IAppliable> FunctionSubstitution = new Dictionary<string, IAppliable>();
        //public readonly Dictionary<Expr, Expr> ComplexSubstitution = new Dictionary<Expr, Expr>();
        ////problem with Dictionary Expr -> Expr: the hashcode function of an NaryExpression refers to the function declaration, which is null for the expression from our property..
        //public readonly List<Tuple<Expr, Expr>> ComplexSubstitution = new List<Tuple<Expr, Expr>>();
        
        public readonly Dictionary<IdentifierExpr, Expr> Substitution = new Dictionary<IdentifierExpr, Expr>();


        public ExprMatchVisitor(List<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //start with some negative cases
            if (!MayStillMatch
                ||_toConsume.Count == 0
                || !(_toConsume.First() is NAryExpr)
                )
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }


            var naeToConsume = (NAryExpr) _toConsume.First();

            var isSubstitutionStart = naeToConsume.Fun.FunctionName == "=="
                                      && naeToConsume.Args[0] is IdentifierExpr
                                      && ((IdentifierExpr) naeToConsume.Args[0]).Name.StartsWith("??");
            var substIdEx = naeToConsume.Args[0] as IdentifierExpr;
            if (isSubstitutionStart)
            {
                if (naeToConsume.Args[1] is IdentifierExpr)
                {
                    //for this we should have the other substitutions with ##id..
                    // maybe unify some other time..
                    throw new NotImplementedException(); 
                }
                naeToConsume = (NAryExpr) naeToConsume.Args[1];
            }
            if (isSubstitutionStart)
                Substitution.Add(substIdEx, node);//TODO or dispatch node first??


            if (((naeToConsume.Fun.FunctionName != Constants.AnyArgs)
                 && (naeToConsume.Fun.FunctionName != Constants.AnySum)
                 && ((NAryExpr) _toConsume.First()).Args.Count != node.Args.Count))
            {
                MayStillMatch = false;
                return base.VisitNAryExpr(node);
            }

            // now the positive cases
            if (naeToConsume.Fun.Equals(node.Fun))
            {
                _toConsume = new List<Expr>(naeToConsume.Args);

                return base.VisitNAryExpr(node);
            } 
            if (naeToConsume.Fun.FunctionName.StartsWith("##"))
            {
                _toConsume = new List<Expr>(naeToConsume.Args);
                if (!FunctionSubstitution.ContainsKey(naeToConsume.Fun.FunctionName))
                    FunctionSubstitution.Add(naeToConsume.Fun.FunctionName, node.Fun);//TODO: understand..
                return base.VisitNAryExpr(node);
            }
            if (naeToConsume.Fun.FunctionName == Constants.AnyArgs)
            {
                throw new NotImplementedException();//TODO..
            }
            if (naeToConsume.Fun.FunctionName == Constants.AnySum
                && node.Fun.FunctionName == "+")//TODO: find out how to match the BinaryOperator nicer..
            {
                //_toConsume.AddRange(naeToConsume.Args);
                var dispatchResults = new List<Expr>();
                var msmNew = false;
                Expr lastMatch = null;
                foreach (var arg in node.Args) //we want to match one of the arguments..
                {
                    MayStillMatch = true;
                    _toConsume = new List<Expr>(naeToConsume.Args);
                    var dispatchResult = base.VisitExpr(arg);
                    if (MayStillMatch)
                        lastMatch = dispatchResult;
                    msmNew |= MayStillMatch;
                    dispatchResults.Add(dispatchResult);
                    
                }
                MayStillMatch = msmNew;
                if (MayStillMatch)
                {
                    //TODO
                    //ComplexSubstitution.Add(new Tuple<Expr, Expr>(naeToConsume, lastMatch));
                }
                return base.VisitNAryExpr(node);
            }
            if (naeToConsume.Fun.FunctionName == Constants.AnySum
                && node.Args.Count == 1)
            {
                //don't consume anything, just remove AnySum from toConsume
                _toConsume = new List<Expr>(naeToConsume.Args);
                //_toConsume.AddRange(naeToConsume.Args);
                var dispatchResult = this.VisitNAryExpr(node);
                //TODO
                //ComplexSubstitution.Add(new Tuple<Expr, Expr>(naeToConsume, dispatchResult));
                return dispatchResult;
            }
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

            if (!toConsumeIsNaryDdIdExpr 
                    && !toConsumeIsNaryDdAnySum
                    && !(_toConsume.First() is IdentifierExpr))
            {
                MayStillMatch = false;
                return base.VisitIdentifierExpr(node);
            }

            if (toConsumeIsNaryDdIdExpr || toConsumeIsNaryDdAnySum)
            {
                var ddIdExpr = (NAryExpr) _toConsume.First();
                //we want to match any IdentifierExpr, and refer to it later with the given (single) argument
                Debug.Assert(ddIdExpr.Args.Count == 1);
                Debug.Assert(toConsumeIsNaryDdAnySum || ddIdExpr.Args[0] is IdentifierExpr);
                //just remove the function application of IDEXPR or ANYSUM here from _toConsume, then restart the method on the argument
                var funAp = _toConsume[0];
                _toConsume.RemoveAt(0);
                _toConsume.Insert(0, ((NAryExpr) funAp).Args[0]);
                var dispatchResult =  this.VisitIdentifierExpr(node); //this, not base
                //TODO
                //ComplexSubstitution.Add(new Tuple<Expr, Expr>(funAp, dispatchResult));
                return dispatchResult;
            }

            var idexToConsume = (IdentifierExpr) _toConsume.First();
            if (idexToConsume.Name == node.Name
                || idexToConsume.Name == Constants.IdExpr)
            {
                //do nothing --> just go on matching..
                _toConsume.RemoveAt(0);
                return base.VisitIdentifierExpr(node);
            }
            if (idexToConsume.Name.StartsWith("##"))
            {
                if (!IdentifierSubstitution.ContainsKey(idexToConsume))
                    IdentifierSubstitution.Add(idexToConsume, node);//TODO: understand..
                _toConsume.RemoveAt(0);
                return base.VisitIdentifierExpr(node);
            }

            MayStillMatch = false;
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
