using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;

namespace Trainer
{
    class BoogieUtil
    {
        public static void PrintProgram(Program p, string filename)
        {
            var outFile = new TokenTextWriter(filename);
            p.Emit(outFile);
            outFile.Close();
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(string name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (attr.Key == name) return true;
            }
            return false;
        }

        // Is there a Key called "name"
        public static bool checkAttrExists(HashSet<string> name, QKeyValue attr)
        {
            for (; attr != null; attr = attr.Next)
            {
                if (name.Contains(attr.Key)) return true;
            }
            return false;
        }


        public static Program ParseProgram(string f)
        {
            Program p = new Program();

            try
            {
                if (Parser.Parse(f, new List<string>(), out p) != 0)
                {
                    Console.WriteLine("Failed to read " + f);
                    return null;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return null;
            }
            return p;
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
    }
}
