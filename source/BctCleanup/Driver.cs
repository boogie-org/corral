using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using cba;
using Microsoft.Boogie;
using System.Diagnostics;

namespace BctCleanup
{
    public static class GlobalConfig
    {
        public static string mainProc = "";
        public static string inputFile = "";
        public static string outputFile = "";
        public static List<string> includeFiles = new List<string>();
    }

    class Driver
    {

        static void Main(string[] args)
        {
            if (!parseCommandLine(args))
            {
                usage();
                return;
            }

            // Concatenate include files
            if (GlobalConfig.includeFiles.Count != 0)
            {
                var newfilePrefix = "CorralTmpConcatFile";
                var newfile = newfilePrefix + ".bpl";
                /*
                int cnt = 0;
                while (System.IO.File.Exists(newfile))
                {
                    newfile = newfilePrefix + cnt.ToString() + ".bpl";
                    cnt++;
                }
                 * */
                StreamWriter w = null;
                try
                {
                    w = new StreamWriter(newfile);
                }
                catch (Exception e)
                {
                    Console.WriteLine("Error opening file {0}. {1}", newfile, e.Message);
                    return;
                }
                GlobalConfig.includeFiles.Add(GlobalConfig.inputFile);
                foreach (var infile in GlobalConfig.includeFiles)
                {
                    StreamReader r = null;
                    try
                    {
                        r = new StreamReader(infile);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Error opening file {0}. {1}", infile, e.Message);
                        return;
                    }
                    w.Write(r.ReadToEnd() + Environment.NewLine);
                    r.Close();
                }
                w.Close();
                GlobalConfig.inputFile = newfile;
            }


            //System.Diagnostics.Debugger.Break();

            if (!GlobalConfig.inputFile.EndsWith(".bpl"))
            {
                Console.WriteLine("Input file must have extension .bpl");
                return;
            }

            if (!GlobalConfig.outputFile.EndsWith(".bpl"))
            {
                Console.WriteLine("Output file must have extension .bpl");
                return;
            }

            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            try
            {
                //System.Diagnostics.Debugger.Break();
                var prog = cba.Util.BoogieUtil.ReadAndOnlyResolve(GlobalConfig.inputFile);
                replaceFECalls(prog);
                addInitializersToMain(prog, GlobalConfig.mainProc);
                cba.Util.BoogieUtil.PrintProgram(prog, GlobalConfig.outputFile);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        private static void replaceFECalls(Program prog) {
          prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, "corral_atomic_begin", new List<TypeVariable>(), new List<Variable>(), new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
          prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, "corral_atomic_end", new List<TypeVariable>(), new List<Variable>(), new List<Variable>(), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
          Formal id = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "id", Microsoft.Boogie.Type.Int), false);
          prog.AddTopLevelDeclaration(new Procedure(Token.NoToken, "corral_getThreadID", new List<TypeVariable>(), new List<Variable>(), new List<Variable>(new Variable[] { id }), new List<Requires>(), new List<IdentifierExpr>(), new List<Ensures>()));
          HashSet<Declaration> declsToRemove = new HashSet<Declaration>();
          foreach (Declaration decl in prog.TopLevelDeclarations) {
            Procedure proc = decl as Procedure;
            if (proc != null) {
              if (proc.Name == "Poirot.Poirot.BeginAtomic" || proc.Name == "Poirot.Poirot.EndAtomic" || proc.Name == "Poirot.Poirot.CurrentThreadId")
                declsToRemove.Add(decl);
            }
            Implementation impl = decl as Implementation;
            if (impl == null) continue;
            foreach (Block b in impl.Blocks) {
              List<Cmd> newCmds = new List<Cmd>();
              foreach (Cmd c in b.Cmds) {
                CallCmd cc = c as CallCmd;
                if (cc == null) {
                  newCmds.Add(c);
                  continue;
                }
                if (cc.callee == "Poirot.Poirot.BeginAtomic")
                  newCmds.Add(new CallCmd(cc.tok, "corral_atomic_begin", cc.Ins, cc.Outs));
                else if (cc.callee == "Poirot.Poirot.EndAtomic")
                  newCmds.Add(new CallCmd(cc.tok, "corral_atomic_end", cc.Ins, cc.Outs));
                else if (cc.callee == "Poirot.Poirot.CurrentThreadId")
                  newCmds.Add(new CallCmd(cc.tok, "corral_getThreadID", cc.Ins, cc.Outs));
                else
                  newCmds.Add(cc);
              }
              b.Cmds = newCmds;
            }
          }
          foreach (Declaration decl in declsToRemove)
            prog.RemoveTopLevelDeclaration(decl);
        }

        private static void addInitializersToMain(Program prog, string mainProcName)
        {
            if (mainProcName == "") {
              List<string> entrypoints = EntrypointScanner.FindEntrypoint(prog);
              if (entrypoints.Count == 0) {
                //throw new InternalError("Main procedure not found");
                Console.WriteLine("Main procedure not found");
                return;
              }
              mainProcName = entrypoints[0];
            }
            var mainProc = cba.Util.BoogieUtil.findProcedureImpl(prog.TopLevelDeclarations, mainProcName);
            if (mainProc == null)
            {
                Console.WriteLine("Implementation of main procedure " + mainProcName + " not found");
                return;
            }

            // Find all initializers
            List<Cmd> newCmds = new List<Cmd>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                if (impl.Name.EndsWith("cctor"))
                {
                    if (impl.InParams.Count == 0)
                    {
                        newCmds.Add(new CallCmd(Token.NoToken, impl.Name, new List<Expr>(), new List<IdentifierExpr>()));
                    }
                }
            }
          
            // Find relevant variables and constants
            GlobalVariable exceptionVariable = null;
            Constant nullConstant = null;
            foreach (var decl in prog.TopLevelDeclarations) {
              GlobalVariable globalVariable = decl as GlobalVariable;
              if (globalVariable != null) {
                if (globalVariable.Name == "$Exception")
                  exceptionVariable = globalVariable;
              }

              Constant constant = decl as Constant;
              if (constant != null) {
                if (constant.Name == "null")
                  nullConstant = constant;
              }

              if (exceptionVariable != null && nullConstant != null)
                break;
            }
            
            // Create initialization of exception variable
            if (exceptionVariable == null) {
              throw new InternalError("Variable $Exception not found");
            }
            else if (nullConstant == null) {
              throw new InternalError("Constant null not found");
            }
            else {
              List<AssignLhs> lhss = new List<AssignLhs>();
              lhss.Add(new SimpleAssignLhs(Token.NoToken, Expr.Ident(exceptionVariable)));
              List<Expr> rhss = new List<Expr>();
              rhss.Add(Expr.Ident(nullConstant));
              newCmds.Add(new AssignCmd(Token.NoToken, lhss, rhss));
            }

            // Create initialization of track variable for GetMeHere
            {
              GlobalVariable trackVariable = new GlobalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "$GetMeHereTracker", Microsoft.Boogie.Type.Int));
              prog.AddTopLevelDeclaration(trackVariable);
              List<AssignLhs> lhss = new List<AssignLhs>();
              lhss.Add(new SimpleAssignLhs(Token.NoToken, Expr.Ident(trackVariable)));
              List<Expr> rhss = new List<Expr>();
              rhss.Add(new LiteralExpr(Token.NoToken, Microsoft.BaseTypes.BigNum.ZERO));
              newCmds.Add(new AssignCmd(Token.NoToken, lhss, rhss));
            }

            // Add call to all initializers in main
            var block = mainProc.Blocks[0];
            newCmds.AddRange(block.Cmds);
            block.Cmds = newCmds;
        }

        static bool parseCommandLine(string[] args)
        {
            GlobalConfig.inputFile = "";
            GlobalConfig.outputFile = "";
            GlobalConfig.mainProc = "";

            if (args.Length < 2)
            {
                return false;
            }

            GlobalConfig.inputFile = args[0];
            GlobalConfig.outputFile = args[1];
            
            var rest = new string[args.Length - 2];
            for (int i = 2; i < args.Length; i++) {
                rest[i-2] = args[i];
            }

            var flags = FlagReader.read(rest);
            flags.Iter(f => processFlag(f));

            return true;
        }

        private static void processFlag(string flag)
        {
            var split = flag.Split(':');
            if (flag.StartsWith("/main:"))
            {
                GlobalConfig.mainProc = split[1];
            }
            else if (flag.StartsWith("/include:"))
            {
                GlobalConfig.includeFiles.Add(split[1]);
            }
        }

        static void usage()
        {
            Console.WriteLine("Usage: BctCleanup input.bpl output.bpl [Flags]");
        }


        public class InternalError : System.ApplicationException
        {
            public InternalError(string msg) : base(msg) { }

        };

    }

}
