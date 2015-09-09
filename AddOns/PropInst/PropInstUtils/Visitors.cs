using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using cba.Util;
using Microsoft.Boogie;

namespace PropInstUtils
{
    /// <summary>
    /// A visitor that executes a given Substitution.
    /// the substitution makes a deep copy of the template, i.e., a new Expr/Cmd/.. is returned
    /// </summary>
    public class SubstitionVisitor : FixedVisitor
    {
        private readonly Dictionary<string, IAppliable> _funcSub;
        private readonly Dictionary<Declaration, Expr> _substitution;
        private readonly Cmd _matchCmd;

        public SubstitionVisitor(Dictionary<Declaration, Expr> psub)
            : this(psub, new Dictionary<string, IAppliable>(0), null)
        {
        }

        public SubstitionVisitor(Dictionary<Declaration, Expr> psub, Dictionary<string, IAppliable> pFuncSub, Cmd mCmd)
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
            return new SimpleAssignLhs(node.tok, (IdentifierExpr)e);
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

    public class ExprMatchVisitor : FixedVisitor
    {
        private readonly Stack<Expr> _toConsume;
        public bool Matches = true;
        public readonly Dictionary<string, IAppliable> FunctionSubstitution = new Dictionary<string, IAppliable>();
        public readonly Dictionary<Declaration, Expr> Substitution = new Dictionary<Declaration, Expr>();

        private bool _anyExprMode = false;

        public ExprMatchVisitor(Expr pToConsume)
        {
            _toConsume = new Stack<Expr>();
            _toConsume.Push(pToConsume);
        }

        public ExprMatchVisitor(Stack<Expr> pToConsume)
        {
            _toConsume = pToConsume;
        }

        public override Expr VisitNAryExpr(NAryExpr node)
        {
            //start with some negative cases
            if (!Matches
                || _toConsume.Count == 0)
            {
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            //idea: if in anyExprMode, toConsume does not change --> we eat up any NaryExpr
            // if any of the  arguments matches, the whole thing matches
            // nothing fancier now, because we only need IdentifierExpr and LiteralExpr
            if (_anyExprMode)
            {
                var anyMatches = false;
                var dispatched = new List<Expr>();
                foreach (var a in node.Args)
                {
                    Matches = true;
                    dispatched.Add(VisitExpr(a));
                    anyMatches |= Matches;
                }
                Matches = anyMatches;
                return new NAryExpr(node.tok, node.Fun, dispatched);
            }

            // check if we need to switch to anyExprMode
            if (_toConsume.Peek() is NAryExpr
                && (((NAryExpr) _toConsume.Peek()).Fun) is FunctionCall
                && BoogieUtil.checkAttrExists(BoogieKeyWords.AnyExpr, ((FunctionCall) ((NAryExpr) _toConsume.Peek()).Fun).Func.Attributes))
            {
                _anyExprMode = true;

                _toConsume.Pop();
                ((NAryExpr) _toConsume.Peek()).Args.Reverse().Iter(arg => _toConsume.Push(arg));
                var result =  VisitNAryExpr(node);

                _anyExprMode = false;

                return result;
            }

            if (!(_toConsume.Peek() is NAryExpr))
            {
                //may still be an IdentifierExp intended to match any exp
                if (_toConsume.First() is IdentifierExpr
                    && ((IdentifierExpr) _toConsume.Peek()).Decl != null
                    && !BoogieUtil.checkAttrExists(BoogieKeyWords.IdExpr, ((IdentifierExpr)_toConsume.Peek()).Decl.Attributes))
                {
                    Substitution.Add(((IdentifierExpr)_toConsume.Peek()).Decl, node);
                    _toConsume.Pop();
                    return node;
                }
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            var naeToConsume = (NAryExpr)_toConsume.Peek();

            if (((NAryExpr)_toConsume.Peek()).Args.Count != node.Args.Count)
            {
                Matches = false;
                return base.VisitNAryExpr(node);
            }

            // now the positive cases
            if (naeToConsume.Fun.Equals(node.Fun))
            {
                //_toConsume = new List<Expr>(naeToConsume.Args);
                _toConsume.Pop();
                naeToConsume.Args.Reverse().Iter(arg => _toConsume.Push(arg));
                return base.VisitNAryExpr(node);
            }
            if (naeToConsume.Fun is FunctionCall
                && ((FunctionCall)naeToConsume.Fun).Func != null
                && node.Fun is FunctionCall
                && PropInstUtils.AreAttributesASubset(
                     ((FunctionCall)naeToConsume.Fun).Func.Attributes,
                     ((FunctionCall)node.Fun).Func.Attributes))
            {
                var func = ((FunctionCall)naeToConsume.Fun).Func;

                FunctionSubstitution.Add(naeToConsume.Fun.FunctionName, node.Fun);

                _toConsume.Pop();
                naeToConsume.Args.Reverse().Iter(arg => _toConsume.Push(arg));
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

            // check if we need to switch to anyExprMode
            if (_toConsume.Peek() is NAryExpr
                && (((NAryExpr) _toConsume.Peek()).Fun) is FunctionCall
                && BoogieUtil.checkAttrExists(BoogieKeyWords.AnyExpr, ((FunctionCall) ((NAryExpr) _toConsume.Peek()).Fun).Func.Attributes))
            {
                _anyExprMode = true;

                _toConsume.Pop();
                ((NAryExpr)_toConsume.Peek()).Args.Iter(arg => _toConsume.Push(arg));
                var result = VisitIdentifierExpr(node);

                _anyExprMode = false;

                return result;
            }

            if (!(_toConsume.Peek() is IdentifierExpr))
            {
                Matches = false;
                return base.VisitIdentifierExpr(node);
            }

            var idexToConsume = (IdentifierExpr)_toConsume.Peek();

            if (idexToConsume.Decl != null)
            {
                if (PropInstUtils.AreAttributesASubset(idexToConsume.Decl.Attributes, node.Decl.Attributes))
                {
                    Substitution.Add(idexToConsume.Decl, node);
                    _toConsume.Pop();
                }
                else
                {
                    Matches = false;
                }
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

            // check if we need to switch to anyExprMode
            if (_toConsume.Peek() is NAryExpr
                && (((NAryExpr) _toConsume.Peek()).Fun) is FunctionCall
                && BoogieUtil.checkAttrExists(BoogieKeyWords.AnyExpr, ((FunctionCall) ((NAryExpr) _toConsume.Peek()).Fun).Func.Attributes))
            {
                _anyExprMode = true;

                _toConsume.Pop();
                ((NAryExpr) _toConsume.Peek()).Args.Iter(arg => _toConsume.Push(arg));
                var result =  VisitLiteralExpr(node);

                _anyExprMode = false;

                return result;
            }

            if (!(_toConsume.Peek() is LiteralExpr))
            {
                if (_toConsume.Peek() is IdentifierExpr
                    && ((IdentifierExpr) _toConsume.Peek()).Decl != null
                    && !BoogieUtil.checkAttrExists(BoogieKeyWords.IdExpr, ((IdentifierExpr)_toConsume.Peek()).Decl.Attributes))
                {
                    Substitution.Add(((IdentifierExpr)_toConsume.Peek()).Decl, node);
                    _toConsume.Pop();
                    return node;
                }
                Matches = false;
                return base.VisitLiteralExpr(node);
            }
            if (node.Val.Equals(((LiteralExpr)_toConsume.Peek()).Val))
            {
                return base.VisitLiteralExpr(node);
            }
            Matches = false;
            return base.VisitLiteralExpr(node);
        }
    }



    public class ProcedureSigMatcher
    {
        public static bool MatchSig(Implementation toMatch, DeclWithFormals dwf, Program boogieProgram, out QKeyValue toMatchAnyParamsAttributes, out int anyParamsPosition, out QKeyValue toMatchAnyParamsAttributesOut, out int anyParamsPositionOut, out Dictionary<Declaration, Expr> paramSubstitution)
        {
            toMatchAnyParamsAttributes = null;
            anyParamsPosition = int.MaxValue;
            toMatchAnyParamsAttributesOut = null;
            anyParamsPositionOut = int.MaxValue;
            paramSubstitution = new Dictionary<Declaration, Expr>();

            if (!PropInstUtils.AreAttributesASubset(toMatch.Attributes, dwf.Attributes))
            {
                return false;
            }

            // match procedure name

            if (BoogieUtil.checkAttrExists(BoogieKeyWords.AnyProcedure, toMatch.Attributes))
            {
                //do nothing
            }
            else if (BoogieUtil.checkAttrExists(BoogieKeyWords.NameMatches, toMatch.Attributes))
            {
                var nmAttrParams = BoogieUtil.getAttr(BoogieKeyWords.NameMatches, toMatch.Attributes);
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
            if (BoogieUtil.checkAttrExists(BoogieKeyWords.NoImplementation, toMatch.Attributes))
            {
                foreach (var i in boogieProgram.Implementations)
                    if (i.Name == dwf.Name)
                        return false;
            }

            if (!MatchParams(ref toMatchAnyParamsAttributes, ref anyParamsPosition, paramSubstitution, toMatch.InParams, toMatch.Proc.InParams, dwf.InParams)) return false;

            if (!MatchParams(ref toMatchAnyParamsAttributesOut, ref anyParamsPositionOut, paramSubstitution, toMatch.OutParams, toMatch.Proc.OutParams, dwf.OutParams)) return false;

            return true;
        }

        private static bool MatchParams(ref QKeyValue toMatchAnyParamsAttributes, ref int anyParamsPosition,
            Dictionary<Declaration, Expr> paramSubstitution, List<Variable> toMatchInParams, List<Variable> toMatchProcInParams, List<Variable> dwfInParams)
        {
            // match procedure parameters
            for (var i = 0; i < toMatchInParams.Count; i++)
            {
                if (i == toMatchInParams.Count - 1
                    && BoogieUtil.checkAttrExists(BoogieKeyWords.AnyParams, toMatchProcInParams[i].Attributes))
                {
                    toMatchAnyParamsAttributes = toMatchInParams[i].Attributes;
                    if (toMatchAnyParamsAttributes != null)
                        toMatchAnyParamsAttributes.Next = toMatchProcInParams[i].Attributes;
                    else
                        toMatchAnyParamsAttributes = toMatchProcInParams[i].Attributes;
                    toMatchAnyParamsAttributes = BoogieUtil.removeAttr(BoogieKeyWords.AnyParams, toMatchAnyParamsAttributes);

                    //TODO the type may also be constrained

                    anyParamsPosition = i;
                    //don't add it to the substitution
                    continue;
                }

                // not anyParams and param counts don't match..
                if (i >= dwfInParams.Count)
                    return false;
                // param types don't match
                if (!toMatchInParams[i].TypedIdent.Type.Equals(dwfInParams[i].TypedIdent.Type))
                    return false;

                paramSubstitution.Add(toMatchInParams[i], new IdentifierExpr(Token.NoToken, dwfInParams[i]));
            }
            return true;
        }
    }

    public class OccursInVisitor : FixedVisitor
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
