using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using Microsoft.Boogie.VCExprAST;
using VC;
using Outcome = VC.VCGen.Outcome;
using cba.Util;
using CoreLib;
using Microsoft.Boogie.GraphUtil;

namespace HoudiniLite
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: HoudiniLite.exe file.bpl [options]");
                return;
            }
            var file = args[0];
            var boogieArgs = "";
            var check = false;
            var dual = false;
            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }
                if (args[i] == "/check")
                {
                    check = true;
                    continue;
                }
                if (args[i] == "/dual")
                {
                    dual = true;
                    continue;
                }
                boogieArgs += args[i] + " ";
            }
            Initalize(boogieArgs);
            if (dual) HoudiniInlining.DualHoudini = true;

            var sw = new Stopwatch();
            sw.Start();

            var assignment = new HashSet<string>();
            try
            {
                assignment = HoudiniInlining.RunHoudini(BoogieUtil.ReadAndResolve(file), true);
            }
            catch (DualHoudiniFail e)
            {
                Console.WriteLine("DualHoudini failed to prove anything useful: {0}", e.Message);
            }

            sw.Stop();

            Console.WriteLine("HoudiniLite took: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));
            HoudiniStats.Print();
            Console.WriteLine("Num true = {0}", assignment.Count);
            if(CommandLineOptions.Clo.PrintAssignment)
              Console.WriteLine("True assignment: {0}", assignment.Concat(" "));

            if (check)
            {
                sw.Restart();

                CommandLineOptions.Install(new CommandLineOptions());
                CommandLineOptions.Clo.PrintInstrumented = true;
                CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
                CommandLineOptions.Clo.ContractInfer = true;
                BoogieUtil.InitializeBoogie(boogieArgs);

                var actual = RunBoogieHoudini(BoogieUtil.ReadAndResolve(file));

                sw.Stop();

                Console.WriteLine("Houdini took: {0} seconds", sw.Elapsed.TotalSeconds.ToString("F2"));

                if (!assignment.Equals(actual))
                {
                    Console.WriteLine("Constants proved by us but not houdini: {0}", assignment.Difference(actual).Concat(" "));
                    Console.WriteLine("Constants proved by houdini but not us: {0}", actual.Difference(assignment).Concat(" "));
                }
            }
        }

        static void Initalize(string boogieOptions)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            CommandLineOptions.Clo.UseSubsumption = CommandLineOptions.SubsumptionOption.Never;
            CommandLineOptions.Clo.ContractInfer = true;
            BoogieUtil.InitializeBoogie(boogieOptions);
            CommandLineOptions.Clo.ProverCCLimit = 1;
            cba.Util.BoogieVerify.options = new BoogieVerifyOptions();
        }

        static HashSet<string> RunBoogieHoudini(Program program)
        {
            var houdiniStats = new Microsoft.Boogie.Houdini.HoudiniSession.HoudiniStatistics();
            var houdini = new Microsoft.Boogie.Houdini.Houdini(program, houdiniStats);
            var outcome = houdini.PerformHoudiniInference();

            var ret = new HashSet<string>();
            outcome.assignment.Where(tup => tup.Value).Iter(tup => ret.Add(tup.Key));
            return ret;
        }
    }

}
