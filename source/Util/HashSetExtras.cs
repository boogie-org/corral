using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace cba.Util
{
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
