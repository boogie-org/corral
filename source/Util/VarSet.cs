using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    public class VarSet: IEnumerable<Duple<string, string>>
    {
        public static VarSet GetAllVars(Program p)
        {
            //List<GlobalVariable> globalDecls = BoogieUtil.GetGlobalVariables(p);
            var procedures = BoogieUtil.GetProcedures(p);
            var implementations = BoogieUtil.GetImplementations(p);
            var allVars = new VarSet();

            foreach (var proc in procedures)
            {
                var uses = new GlobalVarsUsed();
                uses.VisitRequiresSeq(proc.Requires);
                uses.VisitEnsuresSeq(proc.Ensures);
                // skip visiting modifies clause
                allVars.Add(new VarSet(uses.globalsUsed, proc.Name));
            }

            foreach (var impl in implementations)
            {
                var uses = new GlobalVarsUsed();
                uses.VisitBlockList(impl.Blocks);
                allVars.Add(new VarSet(uses.globalsUsed, impl.Name));
            }

            //globalDecls.Iterate(x => procedures.Iterate(y => allVars.Add(x.Name, y.Name)));
            //globalDecls.Iterate(x => implementations.Iterate(y => allVars.Add(x.Name, y.Name)));
            return allVars;
        }

        // Returns (p.allVars \intersect (vars x allProcs)
        public static VarSet ToVarSet(HashSet<string> vars, Program p)
        {
            var allVars = GetAllVars(p);
            var ret = new VarSet();
            foreach (var pair in allVars.values)
            {
                if (vars.Contains(pair.fst)) ret.values.Add(pair);
            }
            return ret;
        }

        public void ProjectOnVariables(HashSet<string> vars, out VarSet projection, out VarSet complement)
        {
            projection = new VarSet();
            complement = new VarSet();
            foreach (Duple<string, string> x in values)
            {
                if (vars.Contains(x.fst))
                    projection.Add(x);
                else
                    complement.Add(x);
            }
        }

        public void ProjectOnProcedures(HashSet<string> procs, out VarSet projection, out VarSet complement)
        {
            projection = new VarSet();
            complement = new VarSet();
            foreach (Duple<string, string> x in values)
            {
                if (procs.Contains(x.snd))
                    projection.Add(x);
                else
                    complement.Add(x);
            }
        }

        protected HashSet<Duple<string, string>> values;

        // Empty Set
        public VarSet()
        {
            values = new HashSet<Duple<string, string>>();
        }

        public VarSet(VarSet t)
        {
            values = new HashSet<Duple<string, string>>(t.values);
        }

        // Singleton set
        public VarSet(string v, string p)
        {
            values = new HashSet<Duple<string, string>>();
            values.Add(new Duple<string, string>(v, p));
        }

        public VarSet(HashSet<string> vs, string proc)
        {
            values = new HashSet<Duple<string, string>>();
            foreach (string v in vs)
            {
                values.Add(new Duple<string, string>(v, proc));
            }
        }

        public VarSet(string v, HashSet<string> procs)
        {
            values = new HashSet<Duple<string, string>>();
            foreach (string p in procs)
            {
                values.Add(new Duple<string, string>(v, p));
            }
        }

        public VarSet(HashSet<string> vs, HashSet<string> procs)
        {
            values = new HashSet<Duple<string, string>>();
            foreach (string v in vs)
            {
                foreach (string proc in procs)
                {
                    values.Add(new Duple<string, string>(v, proc));
                }
            }
        }

        private VarSet(HashSet<Duple<string, string>> x)
        {
            values = x;
        }

        public virtual void Add(string v, string proc)
        {
            values.Add(new Duple<string,string>(v, proc));
        }

        public virtual void Add(Duple<string, string> d)
        {
            values.Add(d);
        }

        public virtual void Add(HashSet<string> vs, string proc)
        {
            foreach (string v in vs)
                Add(v, proc);
        }

        public virtual void Add(VarSet second)
        {
            foreach (var x in second.values)
            {
                values.Add(x);
            }
        }
        
        public virtual void Remove(string v, string proc)
        {
            values.Remove(new Duple<string, string>(v,proc));
        }

        public virtual void Remove(HashSet<string> vs, string proc)
        {
            foreach (string v in vs)
                Remove(v, proc);
        }

        public virtual void Remove(VarSet second)
        {
            foreach (var x in second.values)
            {
                values.Remove(x);
            }
        }

        // Membership query
        public virtual bool Contains(string v, string proc)
        {
            return values.Contains(new Duple<string, string>(v, proc));
        }

        public virtual bool Contains(VarSet second)
        {
            return values.IsSupersetOf(second.values);
        }

        public virtual bool Intersects(VarSet varset)
        {
            return (values.Intersect(varset.values).Any());
        }

        public override int GetHashCode()
        {
            return values.GetHashCode();
        }
        
        public override bool Equals(object obj)
        {
            var other = obj as VarSet;
            Debug.Assert(other != null);
            if (values.Count != other.values.Count) return false;
            return values.IsSupersetOf(other.values) && other.values.IsSupersetOf(values);
        }

        // Does this set contain anything?
        public virtual bool Any()
        {
            return values.Any();
        }

        public virtual int Count
        {
            get { return values.Count; }
        }

        // Is this set singleton?
        public virtual bool IsSingleton()
        {
            return values.Count == 1;
        }

        public virtual VarSet Union(VarSet second)
        {
            return new VarSet(HashSetExtras<Duple<string, string>>.Union(values, second.values));
        }

        public virtual VarSet Difference(VarSet second)
        {
            return new VarSet(HashSetExtras<Duple<string, string>>.Difference(values, second.values));
        }

        public virtual VarSet Intersection(VarSet second)
        {
            return new VarSet(HashSetExtras<Duple<string, string>>.Intersection(values, second.values));
        }

        // Partition a set into two equal halves
        // TODO: Randomized partitioning
        public virtual void PartitionSet(out VarSet part1, out VarSet part2)
        {
            HashSet<Duple<string, string>> part1set;
            HashSet<Duple<string, string>> part2set;
            values.Partition(out part1set, out part2set);
            part1 = new VarSet(part1set);
            part2 = new VarSet(part2set);
        }

        public override string ToString()
        {
            return values.Print();
        }

        public HashSet<string> Variables
        {
            get
            {
                HashSet<string> vars = new HashSet<string>();
                foreach (var x in values)
                    vars.Add(x.fst);
                return vars;
            }
        }

        public HashSet<string> Procedures
        {
            get
            {
                HashSet<string> procs = new HashSet<string>();
                foreach (var x in values)
                    procs.Add(x.snd);
                return procs;
            }
        }

        #region IEnumerable Members
        public struct Enumerator : IEnumerator<Duple<string, string>>
        {
            private IEnumerator<Duple<string, string>> e;
            internal Enumerator(IEnumerator<Duple<string, string>> f)
            {
                e = f;
            }
            #region IEnumerator<Duple<string, string>> Members

            public Duple<string, string> Current
            {
                get { return e.Current; }
            }

            #endregion

            #region IDisposable Members

            public void Dispose()
            {
                e.Dispose();
            }

            #endregion

            #region IEnumerator Members

            object System.Collections.IEnumerator.Current
            {
                get { return e.Current; }
            }

            public bool MoveNext()
            {
                return e.MoveNext();
            }

            public void Reset()
            {
                e.Reset();
            }

            #endregion
        }

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return new Enumerator(values.GetEnumerator());
        }

        #endregion

        #region IEnumerable<Duple<string, string>> Members

        IEnumerator<Duple<string, string>> IEnumerable<Duple<string, string>>.GetEnumerator()
        {
            return new Enumerator(values.GetEnumerator());
        }

        #endregion
    }

}
