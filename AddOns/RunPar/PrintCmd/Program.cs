using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommonLib;

namespace PrintCmd
{
    class Program
    {
        static void Main(string[] args)
        {
            var files = Util.GetFilesForUnion(args);
            if(files != null)
            {
                var result = new List<string>();
                foreach (var file in files)
                    result.AddRange(System.IO.File.ReadAllLines(file));

                System.IO.File.WriteAllLines(GlobalConfig.util_result_file, result);
                return;
            }
            
            var ret = args.Aggregate("", (s1, s2) => s1 + " " + s2);
            
            Console.WriteLine("{0}", ret);
            System.IO.File.WriteAllLines(GlobalConfig.util_result_file, new string[] { ret });
        }
    }
}
