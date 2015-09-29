using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;

namespace RunEE
{
    class Driver
    {
        public static int ExplainErrorTimeout = 1000000;
        public static int ExplainErrorFilters = 0;

        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: RunEE file.bpl options");
                return;
            }

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            var program = BoogieUtil.ReadAndResolve(args[0]);

            if(program.TopLevelDeclarations.OfType<Implementation>().Count() != 1)  {
                Console.WriteLine("Error: input program must have exactly one implementation");
            }

            var flags = "";
            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }
                flags += args[i] + " ";
            }

            ExplainError.STATUS status;
            Dictionary<string, string> complexObj;
            HashSet<List<Expr>> preDisjuncts;
            List<Tuple<string, int, string>> eeSlicedSourceLines;

            var explain = ExplainError.Toplevel.Go(program.TopLevelDeclarations.OfType<Implementation>().First(),
                program, ExplainErrorTimeout, ExplainErrorFilters, flags, null, new HashSet<AssumeCmd>(),
                out status, out complexObj, out preDisjuncts, out eeSlicedSourceLines);

            if (status == ExplainError.STATUS.SUCCESS && explain.Count > 0)
            {
                var aliasingExplanation = "";

                for (int i = 0; i < explain.Count; i++)
                {
                    if (i == 0) aliasingExplanation += "\n    ";
                    else aliasingExplanation += "\nor  ";

                    aliasingExplanation += explain[i].TrimEnd(' ', '\t').Replace(' ', '_').Replace("\t", "_and_");
                }

                if (complexObj.Any())
                {
                    aliasingExplanation += "\nwhere";
                    foreach (var tup in complexObj)
                    {
                        var str = string.Format("   {0} = {1}", tup.Value, tup.Key);
                        aliasingExplanation += "^" + str.Replace(' ', '_');
                    }
                }
                Console.WriteLine("EE returned SUCCESS");
                Console.WriteLine("{0}", aliasingExplanation);
            }
            else
            {
                Console.WriteLine("EE returned status: {0}", status);
            }

        }
    }
}
