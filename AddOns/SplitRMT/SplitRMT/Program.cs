using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Boogie;
using cba.Util;
using ProgTransformation;

namespace SplitRMT
{
    class Driver
    {
        static void Main(string[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Usage: SplitRMT.exe file.bpl");
                return;
            }

            // Initialize
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            var program = BoogieUtil.ReadAndResolve(args[0]);

            // check input
            foreach (var proc in program.TopLevelDeclarations.OfType<Procedure>())
            {
                if (proc.Requires.Any(req => !req.Free))
                {
                    Console.WriteLine("Error: non-free requires not yet supported");
                    return;
                }
            }

            var eplist = program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint") || QKeyValue.FindBoolAttribute(impl.Proc.Attributes, "entrypoint"));

            if (eplist.Count() != 1)
            {
                Console.WriteLine("Error: Unique entrypoint not found");
                return;
            }

            var main = eplist.First();
            Console.WriteLine("Entrypoint: {0}", main.Name);

            // entrypoint + all assumes
            MarkAllAssumes(program, args[0]);

            // split on asserted postconditions
            var cnt = Split(program, args[0]);

            Console.WriteLine("Produced {0} file(s) after splitting", cnt);
        }

        static void MarkAllAssumes(Program program, string filename)
        {
            program = SplitOnProcedure(program, "");
            BoogieUtil.PrintProgram(program, filename.Replace(".bpl", "_split_0.bpl")); 
        }

        static int Split(Program program, string filename)
        {
            var cnt = 1;

            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (impl.Proc.Ensures.Any(ens => !ens.Free))
                {
                    var p = SplitOnProcedure(program, impl.Name);
                    MarkEntryPoint(p, impl.Name);
                    BoogieUtil.PrintProgram(p, filename.Replace(".bpl", string.Format("_split_{0}.bpl", cnt++)));
                }
            }

            return cnt;
        }

        // Split on the postconditions of procedure "proc"
        // 1. only retain its postconditions; make everything else as assumes
        // 2. drop the implementation of the procedure
        // 3. convert calls to itself to calls to a fake procedure with assumed postconditions
        static Program SplitOnProcedure(Program program, string proc)
        {
            var dup = new FixedDuplicator();
            program = dup.VisitProgram(program);
            program = BoogieUtil.ReResolveInMem(program, true);

            var toremove = new HashSet<Implementation>();
            Implementation procimpl = null;
            foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
            {
                if (impl.Name == proc)
                {
                    procimpl = impl;
                    continue;
                }

                if (impl.Proc.Ensures.All(ens => ens.Free))
                    continue;

                var newens = new List<Ensures>();
                impl.Proc.Ensures.Iter(ens => newens.Add(new Ensures(ens.tok, true, ens.Condition, ens.Comment)));
                impl.Proc.Ensures = newens;
                toremove.Add(impl);
            }

            program.RemoveTopLevelDeclarations(decl => decl is Implementation && toremove.Contains(decl));

            if (procimpl != null)
            {
                // create copy
                var proccopy = dup.VisitProcedure(procimpl.Proc);
                proccopy.Name += "_dup";

                // make assumes
                var newens = new List<Ensures>();
                proccopy.Ensures.Iter(ens => newens.Add(new Ensures(ens.tok, true, ens.Condition, ens.Comment)));
                proccopy.Ensures = newens;

                foreach (var impl in program.TopLevelDeclarations.OfType<Implementation>())
                {
                    foreach (var blk in impl.Blocks)
                    {
                        for (int i = 0; i < blk.Cmds.Count; i++)
                        {
                            var ccmd = blk.Cmds[i] as CallCmd;
                            if (ccmd == null || ccmd.callee != procimpl.Name) continue;
                            blk.Cmds[i] = new CallCmd(ccmd.tok, proccopy.Name, ccmd.Ins, ccmd.Outs, ccmd.Attributes);
                        }
                    }
                }

                program.AddTopLevelDeclaration(proccopy);
            }

            return program;
        }

        static void MarkEntryPoint(Program program, string proc)
        {
            // remove existing entrypoints
            program.TopLevelDeclarations.OfType<NamedDeclaration>()
                .Iter(decl => decl.Attributes = BoogieUtil.removeAttr("entrypoint", decl.Attributes));

            program.TopLevelDeclarations.OfType<Implementation>()
                .Where(impl => impl.Name == proc)
                .Iter(impl => impl.Proc.AddAttribute("entrypoint"));
        }
    }
}
