using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using Microsoft.Boogie.Houdini;
using cba;

namespace StaticAnalysis
{
    // TODO: update to support the type bv32 as well
    class ConstantProp : IWeight
    {
        public static Program program = null;

        bool isZero;
        Dictionary<string, Value> val;
        Implementation impl;

        public ConstantProp()
        {
            isZero = true;
            val = new Dictionary<string, Value>();
            impl = null;
        }

        private ConstantProp(Dictionary<string, Value> v, Implementation impl)
        {
            this.isZero = false;
            this.val = v;
            this.impl = impl;
        }


        public IWeight Zero(Implementation impl)
        {
            return new ConstantProp();  
        }

        public IWeight GetInitial(Implementation impl)
        {
            var domainG = program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsInt);
            var domainL = impl.LocVars.OfType<Variable>()
                .Concat(impl.OutParams.OfType<Variable>())
                .Where(v => v.TypedIdent.Type.IsInt);

            var ret = new ConstantProp();
            domainG.Iter(g => ret.val.Add(g.Name, Value.GetSingleton(g)));
            domainL.Iter(l => ret.val.Add(l.Name, Value.GetTop()));
            ret.impl = impl;
            ret.isZero = false;

            return ret;
        }

        // For precondition computation
        public IWeight Top(Implementation impl)
        {
            var domainG = program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsInt);
            var domainL = impl.LocVars.OfType<Variable>()
                .Concat(impl.OutParams.OfType<Variable>())
                .Concat(impl.InParams.OfType<Variable>())
                .Where(v => v.TypedIdent.Type.IsInt);

            var ret = new ConstantProp();
            domainG.Iter(g => ret.val.Add(g.Name, Value.GetTop()));
            domainL.Iter(l => ret.val.Add(l.Name, Value.GetTop()));
            ret.impl = impl;
            ret.isZero = false;

            return ret;
        }

        public bool Combine(IWeight iweight)
        {
            var weight = iweight as ConstantProp;
            Debug.Assert(weight != null);
            if (impl == null) impl = weight.impl;

            if (weight.isZero)
            {
                return false;
            }

            var changed = false;

            if (isZero)
                changed = true;
            isZero = false;

            foreach (var kvp in weight.val)
            {
                var key = kvp.Key;
                var value = kvp.Value;

                if (!val.ContainsKey(key))
                {
                    if (!value.IsBot())
                    {
                        val.Add(key, new Value(value));
                        changed = true;
                    }
                }
                else
                {
                    var t = val[key].UnionWith(value);
                    changed = changed || t;
                }

            }
            return changed;
        }

        public IWeight Extend(Cmd cmd)
        {
            if (BoogieUtil.isAssumeFalse(cmd) || isZero)
            {
                return new ConstantProp();
            }

            if (cmd is HavocCmd)
            {
                return ApplyHavoc(cmd as HavocCmd);
            }
            else if (cmd is AssignCmd)
            {
                return ApplyAssign(cmd as AssignCmd);
            }
            else if (cmd is CallCmd)
            {
                return ApplyCall(cmd as CallCmd);
            }

            return this;
        }

        public IWeight Extend(CallCmd cmd, IWeight summary)
        {
            if (isZero || (summary as ConstantProp).isZero) return new ConstantProp();

            return ApplyCall(cmd, summary as ConstantProp);
        }

        public IWeight ApplyCall(CallCmd cmd, Implementation callee)
        {
            if (isZero)
                return new ConstantProp();

            var domainG = program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsInt)
                .Where(g => val.ContainsKey(g.Name));

            var domainL = callee.LocVars.OfType<Variable>()
                .Concat(callee.OutParams.OfType<Variable>())
                .Concat(callee.InParams.OfType<Variable>())
                .Where(v => v.TypedIdent.Type.IsInt);

            var ret = new Dictionary<string, Value>();

            domainG.Iter(g => ret.Add(g.Name, val[g.Name].ForgetVars()));
            for (int i = 0; i < callee.InParams.Count; i++)
            {
                var formal = callee.InParams[i];
                var actual = Value.GetTop();
                if (cmd.Ins[i] != null)
                    actual = Evaluate(cmd.Ins[i]);
                ret.Add(formal.Name, actual.ForgetVars());
            }
            domainL.Where(v => !ret.ContainsKey(v.Name))
                .Iter(v => ret.Add(v.Name, Value.GetTop()));

            return new ConstantProp(ret, callee);
        }

        private ConstantProp ApplyHavoc(HavocCmd cmd)
        {
            var ret = new Dictionary<string, Value>();
            // Deep copy
            val.Iter(kvp => ret.Add(kvp.Key, new Value(kvp.Value)));

            foreach (var v in cmd.Vars.OfType<IdentifierExpr>())
            {
                if (!val.ContainsKey(v.Name)) continue;

                if (!ret.ContainsKey(v.Name))
                    ret.Add(v.Name, Value.GetTop());
                else
                    ret[v.Name] = Value.GetTop();
            }

            return new ConstantProp(ret, impl);

        }

        private ConstantProp ApplyAssign(AssignCmd assgnCmd)
        {
            var ret = new Dictionary<string, Value>();

            if (!assgnCmd.Lhss
                .Where(al => val.ContainsKey(al.DeepAssignedVariable.Name))
                .Any())
            {
                return this;
            }

            // Deep copy
            val.Iter(kvp => ret.Add(kvp.Key, new Value(kvp.Value)));

            for (int i = 0; i < assgnCmd.Lhss.Count; i++)
            {
                var v = assgnCmd.Lhss[i].DeepAssignedVariable.Name;
                if (!val.ContainsKey(v)) continue;

                var value = Evaluate(assgnCmd.Rhss[i]);
                
                if (!ret.ContainsKey(v))
                    ret.Add(v, value);
                else
                    ret[v] = value;
            }

            return new ConstantProp(ret, impl);

        }

        private ConstantProp ApplyCall(CallCmd cmd)
        {
            // this is just like havoc
            var havoc = new List<IdentifierExpr>();
            cmd.Outs.Iter(ie => havoc.Add(ie));
            cmd.Proc.Modifies.OfType<IdentifierExpr>().Iter(ie => havoc.Add(ie));

            return ApplyHavoc(new HavocCmd(Token.NoToken, havoc));
        }

        private ConstantProp ApplyCall(CallCmd cmd, ConstantProp summary)
        {            
            Debug.Assert(summary.impl != null && impl != null);

            var domainG = program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsInt)
                .Where(g => val.ContainsKey(g.Name));

            var domainL = impl.LocVars.OfType<Variable>()
                .Concat(impl.OutParams.OfType<Variable>())
                .Where(v => v.TypedIdent.Type.IsInt)
                .Where(v => val.ContainsKey(v.Name));

            var ret = new Dictionary<string, Value>();
            var subst = new Dictionary<string, Value>();

            domainG.Iter(g => subst.Add(g.Name, val[g.Name]));
            for (int i = 0; i < summary.impl.InParams.Count; i++)
            {
                var formal = summary.impl.InParams[i];
                var actual = Value.GetTop();
                if(cmd.Ins[i] != null)
                    actual = Evaluate(cmd.Ins[i]);
                subst.Add(formal.Name, actual);
            }

            foreach (var g in domainG)
            {
                Debug.Assert(summary.val.ContainsKey(g.Name));
                var value = summary.val[g.Name];
                ret.Add(g.Name, value.Subst(subst));
            }

            var assigned = new HashSet<string>();
            for (int i = 0; i < cmd.Outs.Count; i++)
            {
                var l = cmd.Outs[i];
                if (l == null) continue;
                if (!val.ContainsKey(l.Name)) continue;

                assigned.Add(l.Name);
                var formal = summary.impl.OutParams[i];
                var value = summary.val[formal.Name].Subst(subst);

                if (ret.ContainsKey(l.Name))
                {
                    ret[l.Name] = value;
                }
                else
                {
                    ret.Add(l.Name, value);
                }
            }

            foreach (var l in domainL)
            {
                if (assigned.Contains(l.Name))
                    continue;
                ret.Add(l.Name, new Value(val[l.Name]));
            }

            return new ConstantProp(ret, impl);
        }

        private Value Evaluate(Expr expr)
        {
            var lexpr = expr as LiteralExpr;
            if (lexpr != null)
            {
                // TODO: insert check for Boolean literals
                if(lexpr.Val is Microsoft.Basetypes.BigNum)
                    return Value.GetSingleton(lexpr.asBigNum.ToInt);
                if (lexpr.Val is BvConst)
                    return Value.GetSingleton((lexpr.Val as BvConst).Value.ToInt);
                return Value.GetTop();
            }

            // 0 - c
            var nexpr = expr as NAryExpr;
            if (nexpr != null
                && nexpr.Args.Count == 1
                && nexpr.Fun is UnaryOperator
                && (nexpr.Fun as UnaryOperator).Op == UnaryOperator.Opcode.Neg)
            {
                var e1 = nexpr.Args[0] as LiteralExpr;
                if (e1 != null)
                    return Value.GetSingleton((int)(System.Numerics.BigInteger.Zero - e1.asBigNum.ToBigInteger));
            }

            if (nexpr != null
                && nexpr.Args.Count == 2
                && nexpr.Fun is BinaryOperator
                && (nexpr.Fun as BinaryOperator).Op == BinaryOperator.Opcode.Sub)
            {
                var e1 = nexpr.Args[0] as LiteralExpr;
                var e2 = nexpr.Args[1] as LiteralExpr;

                if (e1 != null && e2 != null)
                {
                    return Value.GetSingleton((int)(e1.asBigNum.ToBigInteger - e2.asBigNum.ToBigInteger));
                }
            }

            var iexpr = expr as IdentifierExpr;
            if (iexpr != null)
            {
                if (val.ContainsKey(iexpr.Name))
                    return new Value(val[iexpr.Name]);

                var formal = iexpr.Decl as Formal;
                if (formal != null && formal.InComing)
                    return Value.GetSingleton(formal);
            }

            if (val.Count == 0)
                return Value.GetTop();

            return Value.Evaluate(expr, val);
        }

        public void Print()
        {
            Print(false);
        }

        public void Print(bool forSummary)
        {
            var expr = ToExpr(forSummary);
            expr.Iter(e => { e.Emit(new TokenTextWriter(Console.Out)); Console.WriteLine(); });
        }

        public IEnumerable<Expr> ToExpr(bool forSummary)
        {
            var ret = new List<Expr>();

            if (isZero)
            {
                ret.Add(Expr.False);
                return ret;
            }

            Debug.Assert(impl != null);

            var domainG = program.TopLevelDeclarations
                .OfType<GlobalVariable>()
                .Where(g => g.TypedIdent.Type.IsInt)
                .Where(g => val.ContainsKey(g.Name));

            var domainL = impl.LocVars.OfType<Variable>()
                .Concat(impl.InParams.OfType<Variable>())
                .Concat(impl.OutParams.OfType<Variable>())
                .Where(v => v.TypedIdent.Type.IsInt)
                .Where(v => val.ContainsKey(v.Name));

            if (forSummary)
            {
                domainL = domainL.Where(v => v is Formal);
            }

            var mod = new HashSet<string>();
            impl.Proc.Modifies
                .OfType<IdentifierExpr>()
                .Iter(ie => mod.Add(ie.Name));

            foreach (var v in domainG.Concat(domainL))
            {
                var removeId = false;
                if (forSummary && !mod.Contains(v.Name)) removeId = true;

                ret.Add(val[v.Name].ToExpr(v, removeId));
            }

            // Use formal variables from Proc declarations, not impl
            var subst = new Dictionary<string, Variable>();
            impl.Proc.OutParams
                .OfType<Variable>()
                .Concat(impl.Proc.InParams.OfType<Variable>())
                .Iter(v => subst.Add(v.Name, v));

            var vsubst = new VarSubstituter(subst, new Dictionary<string,Variable>());

            return ret
                .Where(e => !((e is LiteralExpr) && ((e as LiteralExpr).IsTrue)))
                .Select(expr => vsubst.VisitExpr(expr));
        }

    }

    class Value
    {
        public static int maxExprsToTrack = 2;

        HashSet<Variable> vars;
        HashSet<int> constants;

        // The size of this set is bounded by maxExprsToTrack
        HashSet<Expr> constExprs;

        bool isTrue;

        public Value()
        {
            vars = new HashSet<Variable>();
            constants = new HashSet<int>();
            constExprs = new HashSet<Expr>();
            isTrue = false;
        }

        public Value(Value that)
        {
            isTrue = that.isTrue;
            vars = new HashSet<Variable>(that.vars);
            constants = new HashSet<int>(that.constants);
            constExprs = new HashSet<Expr>(that.constExprs);
        }

        public Value ForgetVars()
        {
            if (isTrue) return this;
            
            if (vars.Any() || constExprs.Any())
                return GetTop();

            return  new Value(this);
        }


        public Value Subst(Dictionary<string, Value> subst)
        {
            if (isTrue) return this;
            var newc = new HashSet<int>(constants);
            var newv = new HashSet<Variable>();
            var newe = new HashSet<Expr>();
            foreach (var v in vars)
            {
                Debug.Assert(subst.ContainsKey(v.Name));
                if (subst[v.Name].isTrue)
                    return GetTop();
                newc.UnionWith(subst[v.Name].constants);
                newv.UnionWith(subst[v.Name].vars);
                newe.UnionWith(subst[v.Name].constExprs);
            }

            foreach (var e in constExprs)
            {
                var vused = new VarsUsed();
                vused.VisitExpr(e);

                Debug.Assert(vused.varsUsed.All(v => subst.ContainsKey(v)));

                if (vused.varsUsed.Any(v => subst[v].ToSingletonVar() == null))
                    return GetTop();

                var vsubst = new Dictionary<string, Variable>();
                vused.varsUsed.Iter(v => vsubst.Add(v, subst[v].ToSingletonVar()));

                var dup = new FixedDuplicator();
                var ne = (new VarSubstituter(vsubst, new Dictionary<string, Variable>())).VisitExpr(dup.VisitExpr(e));
                newe.Add(ne);                
            }

            newe = removeDuplicates(newe);
            if (newe.Count > maxExprsToTrack)
                return GetTop();

            var ret = new Value();
            ret.vars = newv;
            ret.constants = newc;
            ret.constExprs = newe;
            ret.isTrue = false;

            return ret;
        }

        private static HashSet<Expr> removeDuplicates(HashSet<Expr> exprs)
        {
            if (exprs.Count <= 1) return exprs;
            var hash = new HashSet<string>();
            var ret = new HashSet<Expr>();
            foreach (var e in exprs)
            {
                if (hash.Contains(e.ToString()))
                    continue;
                hash.Add(e.ToString());
                ret.Add(e);
            }
            return ret;
        }

        // Always safe to return Top
        public static Value Evaluate(Expr expr, Dictionary<string, Value> subst)
        {
            var vused = new VarsUsed();
            vused.Visit(expr);

            // Make sure we have values of all variables except in-formals
            var informals = vused.Vars.Where(v => !subst.ContainsKey(v.Name));
            if (informals.All(v => (v is Formal) && ((v as Formal).InComing))) { }
            else return Value.GetTop();

            if (vused.Vars.Any(v => subst.ContainsKey(v.Name) && subst[v.Name].ToSingletonVar() == null))
                return GetTop();

            var vsubst = new Dictionary<string, Variable>();
            subst.Keys.Iter(v => vsubst.Add(v, subst[v].ToSingletonVar()));

            var dup = new FixedDuplicator();
            var ne = (new VarSubstituter(vsubst, new Dictionary<string, Variable>())).VisitExpr(dup.VisitExpr(expr));

            return Value.GetSingleton(ne);
        }

        private Variable ToSingletonVar()
        {
            var expr = ToSingletonExpr();
            if (expr == null) return null;
            var ie = expr as IdentifierExpr;
            if (ie == null) return null;
            return ie.Decl;            
        }

        private Expr ToSingletonExpr()
        {
            if (isTrue) return null;
            if (constants.Count + vars.Count + constExprs.Count != 1) return null;

            if (constants.Any())
            {
                return Expr.Literal(constants.First());
            }

            if (vars.Any())
            {
                return Expr.Ident(vars.First());
            }

            if (constExprs.Any())
            {
                return constExprs.First();
            }

            //unreachable
            return null;
        }

        public bool IsBot()
        {
            return !isTrue && !constants.Any() && !vars.Any() && !constExprs.Any();
        }

        public override string ToString()
        {
            if (isTrue) return "true";
            var exprs = "";
            foreach (var e in constExprs)
            {
                var sb = new System.IO.StringWriter();
                e.Emit(new TokenTextWriter(sb));
                sb.Close();
                exprs += "," + sb.ToString();
            }

            return string.Format("{0} {1} {2}", vars.Print(), constants.Print(), "{" + exprs + "}");
        }

        public static Value GetTop()
        {
            var v = new Value();
            v.isTrue = true;
            return v;
        }

        public static Value GetSingleton(Variable v)
        {
            var ret = new Value();
            ret.vars.Add(v);
            return ret;
        }

        public static Value GetSingleton(int c)
        {
            var ret = new Value();
            ret.constants.Add(c);
            return ret;
        }

        public static Value GetSingleton(Expr e)
        {
            var vused = new VarsUsed();
            vused.Visit(e);

            // An expr can only mention in-formals (TODO: and Constants)
            if (vused.Vars.Any(v => !(v is Formal)))
                return GetTop();
            if (vused.Vars.OfType<Formal>().Any(f => !f.InComing))
                return GetTop();
            
            var ret = new Value();
            ret.constExprs.Add(e);
            return ret;
        }

        public bool UnionWith(Value that)
        {
            if (isTrue)
            {
                return false;
            }

            if (that.isTrue)
            {
                isTrue = true;
                constants.Clear();
                vars.Clear();
                constExprs.Clear();

                return true;
            }

            var sv = vars.Count;
            var sc = constants.Count;
            var se = constExprs.Count;

            vars.UnionWith(that.vars);
            constants.UnionWith(that.constants);
            constExprs.UnionWith(that.constExprs);
            constExprs = removeDuplicates(constExprs);

            if (constExprs.Count > maxExprsToTrack)
            {
                isTrue = true;
                constants.Clear();
                vars.Clear();
                constExprs.Clear();

                return true;
            }

            return (sv != vars.Count || sc != constants.Count || se != constExprs.Count);
        }

        public Expr ToExpr(Variable v, bool removeId)
        {
            if (isTrue) return Expr.True;
            Debug.Assert(v.TypedIdent.Type.IsInt);
            
            Expr ret = Expr.False;

            if (removeId && constants.Count == 0 && vars.Count == 1 && constExprs.Count == 0)
            {
                if (v.Name == vars.First().Name)
                    return Expr.True;
            }

            foreach (var c in constants)
            {
                ret = Expr.Or(ret, Expr.Eq(Expr.Ident(v), Expr.Literal(c)));
            }
            foreach (var x in vars)
            {
                if (x is GlobalVariable)
                {
                    ret = Expr.Or(ret, Expr.Eq(Expr.Ident(v), new OldExpr(Token.NoToken, Expr.Ident(x))));
                }
                else if (x is Formal)
                {
                    Debug.Assert((x as Formal).InComing);
                    ret = Expr.Or(ret, Expr.Eq(Expr.Ident(v), Expr.Ident(x)));
                }
                else
                {
                    Debug.Assert(false);
                }               
            }
            foreach (var e in constExprs)
            {
                ret = Expr.Or(ret, Expr.Eq(Expr.Ident(v), e));
            }
            return ret;
        }
    } // class Value
}
