using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;

namespace Microsoft.Boogie
{
    public class InvalidProg : System.ApplicationException
    {
        public InvalidProg(string msg) : base(msg) { }

    };

    public class InvalidInput : System.ApplicationException
    {
        public InvalidInput(string msg) : base(msg) { }

    };

    public class InternalError : System.ApplicationException
    {
        public InternalError(string msg) : base(msg) { }

    };

    public class NormalExit : System.ApplicationException
    {
        public NormalExit(string msg) : base(msg) { }

    };

    public class UsageError : System.ApplicationException
    {
        public UsageError(string msg) : base(msg) { }

    };


    public static class InitDictionary
    {
        public static void InitAndAdd<K, V>(this Dictionary<K, HashSet<V>> map, K key, V value)
        {
            if (!map.ContainsKey(key)) map.Add(key, new HashSet<V>());
            map[key].Add(value);
        }
    }

    public static class Log
    {
        //public static bool AlwaysFlush = true;

        public const int Warning = 4;
        public const int Error = 3;
        public const int Normal = 1;
        public const int Debug = 2;

        public static bool noDebuggingOutput = false;
        public static bool printMemUsage = false;

        public static TokenTextWriter debugOut = null;

        private static void init()
        {
            if (noDebuggingOutput)
                return;

            if (debugOut == null)
            {
                debugOut = new TokenTextWriter("corraldebug.out");
            }
        }

        public static void Close()
        {
            if (debugOut != null)
            {
                debugOut.Close();
            }
        }

        public static TokenTextWriter getWriter(int level)
        {
            if (level == Debug)
            {
                if (noDebuggingOutput) return null;

                init();
                return debugOut;
            }
            return new TokenTextWriter(Console.Out);
        }

        public static bool Write(int level, string msg, params object[] args)
        {
            if (level == Log.Normal)
            {
                Write(Log.Debug, msg, args);
            }

            switch (level)
            {
                case Debug:
                    if (!noDebuggingOutput)
                    {
                        init();
                        debugOut.Write(msg, args);
                    }
                    break;
                case Warning:
                    Console.Write("Warning: " + msg, args);
                    break;
                case Error:
                    Console.Write("Error: " + msg, args);
                    break;
                case Normal:
                    Console.Write(msg, args);
                    break;
            }

            return false;
        }

        public static bool Write(string msg, params object[] args)
        {
            return Write(Normal, msg, args);
        }

        public static bool WriteLine(int level, string msg, params object[] args)
        {
            return Write(level, msg + Environment.NewLine, args);
        }

        public static bool WriteLine(string msg, params object[] args)
        {
            return Write(Normal, msg + Environment.NewLine, args);
        }

        public static bool WriteLine()
        {
            return Write(Normal, Environment.NewLine);
        }

        public static bool WriteMemUsage()
        {
            return false;
            // This takes a lot of time
            /*
            double mem = GC.GetTotalMemory(true) / (1024.0 * 1024.0);
            if (printMemUsage)
            {
                WriteLine(string.Format("Memory: {0}MB", mem.ToString("F")));
            }
            return WriteLine(Log.Debug, string.Format("Memory: {0}MB", mem.ToString("F")));
             */
        }

        public static void PrintMemUsage()
        {
            PrintMemUsage("Memory");
        }

        public static void PrintMemUsage(string msg)
        {
            var p = System.Diagnostics.Process.GetCurrentProcess();
            GC.Collect();
            double mem1 = GC.GetTotalMemory(true) / (1024.0 * 1024.0);
            double mem2 = p.VirtualMemorySize64 / (1024.0 * 1024.0);
            Console.WriteLine("{0}: {1}MB and {2}MB", msg, mem1.ToString("F"), mem2.ToString("F"));
        }
    }

    public static class ListExt
    {
        public static void Iterate<T>(this List<T> l, Action<T> f)
        {
            foreach (T t in l) { f(t); }
        }

        public static List<T> Filter<T>(this List<T> l, Predicate<T> p)
        {
            List<T> o = new List<T>(l.Count);
            foreach (T t in l) { if (p(t)) o.Add(t); }
            return o;
        }

        public static List<T2> Map<T1, T2>(this List<T1> l, Converter<T1, T2> f)
        {
            List<T2> o = new List<T2>(l.Count);
            foreach (T1 t in l) { o.Add(f(t)); }
            return o;
        }

        public static List<T> SubSeq<T>(this List<T> l, int start, int len)
        {
            System.Diagnostics.Debug.Assert(start >= 0 && start + len - 1 < l.Count);
            var ret = new List<T>();
            for (int i = start; i < start + len; i++)
            {
                ret.Add(l[i]);
            }
            return ret;
        }


        public static List<Variable> MapToVariableSeq(this List<Variable> l, Converter<Variable, Variable> f)
        {
            var vs = new List<Variable>();
            foreach (var v in l)
                vs.Add(f(v));
            return vs;
        }

        public static HDuple<List<T>> Partition<T>(this List<T> l, Predicate<T> p)
        {
            var y = new List<T>();
            var n = new List<T>();
            foreach (T t in l)
                if (p(t))
                    y.Add(t);
                else
                    n.Add(t);
            return new HDuple<List<T>>(y, n);
        }

        public static List<Variable> ToVariableSeq(this IEnumerable<Variable> l)
        {
            if (l == null)
                return null;
            var vs = new List<Variable>();
            foreach (var v in l)
                vs.Add(v);
            return vs;
        }

        public static List<Expr> ToExprSeq(this List<Expr> l)
        {
            var es = new List<Expr>();
            foreach (var e in l)
                es.Add(e);
            return es;
        }
    }

    public class Duple<T1, T2>
    {
        public Duple(T1 fst, T2 snd)
        {
            this.fst = fst;
            this.snd = snd;
        }

        public T1 fst { get; private set; }
        public T2 snd { get; private set; }

        public static bool EqFst(Duple<T1, T2> d1, Duple<T1, T2> d2)
        {
            return d1.fst.Equals(d2.fst);
        }

        public static bool EqSnd(Duple<T1, T2> d1, Duple<T1, T2> d2)
        {
            return d1.snd.Equals(d2.snd);
        }

        public override bool Equals(object obj)
        {
            var d = obj as Duple<T1, T2>;
            if (d == null)
                return false;
            return this.fst.Equals(d.fst) && this.snd.Equals(d.snd);
        }

        //this is apparently how python hashes tuples
        public override int GetHashCode()
        {
            int value = 0x345678;
            value = 1000003 * value ^ fst.GetHashCode();
            value = 1000003 * value ^ snd.GetHashCode();
            value = value ^ 2;
            return value;
        }

        public override string ToString()
        {
            return "(" + fst + ", " + snd + ")";
        }
    }

    public class Triple<T1, T2, T3>
    {
        public Triple(T1 fst, T2 snd, T3 trd)
        {
            this.fst = fst;
            this.snd = snd;
            this.trd = trd;
        }

        public T1 fst { get; private set; }
        public T2 snd { get; private set; }
        public T3 trd { get; private set; }

        public override bool Equals(object obj)
        {
            var d = obj as Triple<T1, T2, T3>;
            if (d == null)
                return false;
            return this.fst.Equals(d.fst) && this.snd.Equals(d.snd) && this.trd.Equals(d.trd);
        }

        public override int GetHashCode()
        {
            int value = 0x345678;
            value = 1000003 * value ^ fst.GetHashCode();
            value = 1000003 * value ^ snd.GetHashCode();
            value = 1000003 * value ^ trd.GetHashCode();
            value = value ^ 2;
            return value;
        }

        public override string ToString()
        {
            return "(" + fst.ToString() + ", " + snd.ToString() + ", " + trd.ToString() + ")";
        }
    }

    //homogeneous tuples
    public class HDuple<T1> : Duple<T1, T1>
    {
        public HDuple(T1 fst, T1 snd) : base(fst, snd) { }

        public static HDuple<T1> OfArray(T1[] a)
        {
            try
            {
                return new HDuple<T1>(a[0], a[1]);
            }
            catch
            {
                return null;
            }
        }
    }

    public class HashSetExtras<T>
    {
        public static HashSet<T> Difference(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.ExceptWith(b);
            return ret;
        }

        public static HashSet<T> Difference(HashSet<T> a, HashSet<T> b, HashSet<T> c)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.ExceptWith(b);
            ret.ExceptWith(c);
            return ret;
        }

        public static HashSet<T> Union(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.UnionWith(b);
            return ret;
        }

        public static HashSet<T> Intersection(HashSet<T> a, HashSet<T> b)
        {
            HashSet<T> ret = new HashSet<T>(a);
            ret.IntersectWith(b);
            return ret;
        }

        public static HashSet<T> Singleton(T v)
        {
            var ret = new HashSet<T>();
            ret.Add(v);
            return ret;
        }
    }

    public static class HashSetMethods
    {
        public static string Print<T>(this HashSet<T> s)
        {
            var ret = "{";
            int cnt = 0;
            foreach (var a in s)
            {
                ret += a.ToString();
                cnt++;
                if (cnt != s.Count)
                {
                    ret += ", ";
                }
            }

            ret += "}";
            return ret;
        }

        public static HashSet<T> Difference<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Difference(a, b);
        }

        public static HashSet<T> Union<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Union(a, b);
        }

        public static HashSet<T> Intersection<T>(this HashSet<T> a, HashSet<T> b)
        {
            return HashSetExtras<T>.Intersection(a, b);
        }

        public static bool Contains<T>(this HashSet<T> a, HashSet<T> b)
        {
            return a.IsSupersetOf(b);
        }

        public static void Partition<T>(this HashSet<T> values, out HashSet<T> part1, out HashSet<T> part2)
        {
            part1 = new HashSet<T>();
            part2 = new HashSet<T>();
            var size = values.Count;
            var crossed = false;
            var curr = 0;
            foreach (var s in values)
            {
                if (crossed) part2.Add(s);
                else part1.Add(s);
                curr++;
                if (!crossed && curr >= size / 2) crossed = true;
            }
        }
    }
}
