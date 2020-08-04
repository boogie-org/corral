using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{

    // Checks if the program is well formed. Throws an exception if the program is not.
    // Doesn't modify the program.
    // May emits warnings (into Debug Log).
    public static class WellFormedProg
    {
        // Checks for the following:
        // -- There should be no ensures and requires on shared globals
        // -- For ensures and requires on non-shared globals, they should be "free"
        // -- One cannot use "old" versions of shared globals
        public static void check(Program prog)
        {
            // Gather the set of procs with an implementation
            var procsWithImpl = new HashSet<string>();
            foreach (var decl in prog.TopLevelDeclarations)
            {
                if (decl is Implementation)
                {
                    procsWithImpl.Add((decl as Implementation).Name);
                }
            }
            ProgramCallGraph pg = new ProgramCallGraph(prog);
            var procsNotCalled = new HashSet<string>();
            foreach (var proc in procsWithImpl)
            {
                if (!pg.isCalled(proc))
                {
                    procsNotCalled.Add(proc);
                }
            }

            foreach (Declaration decl in prog.TopLevelDeclarations)
            {
                if (decl is Procedure)
                {
                    checkProc(decl as Procedure, procsWithImpl, procsNotCalled);
                }
                else if (decl is Implementation)
                {
                    checkOld(decl as Implementation);
                }
            }
        }

        // -- There should be no ensures and requires on shared globals
        // -- For ensures and requires on non-shared globals, they should be "free"
        // -- One cannot use "old" versions of shared globals
        private static void checkProc(Procedure proc, HashSet<string> procsWithImpl, HashSet<string> procsNotCalled)
        {
            VarsUsed used = new VarsUsed();

            foreach (Requires re in proc.Requires)
            {
                used.reset();
                used.Visit(re.Condition);

                if (used.globalsUsed.Any(v => LanguageSemantics.isShared(v)))
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("Requires has a shared global");
                }

                if (used.oldVarsUsed.Any(v => LanguageSemantics.isShared(v)))
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("Requires has an \"old\" shared global");
                }

                if (used.globalsUsed.Count == 0)
                {
                    continue;
                }

                // We dont care about requires on pros that are not called
                if (procsNotCalled.Contains(proc.Name))
                {
                    continue;
                }

                if (re.Free == false)
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("A non-free requires has a non-shared global (not yet supported)");
                }

            }

            foreach (Ensures re in proc.Ensures)
            {
                used.reset();
                used.Visit(re.Condition);

                if (used.globalsUsed.Any(v => LanguageSemantics.isShared(v)))
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("Ensures has a shared global");
                }

                if (used.oldVarsUsed.Any(v => LanguageSemantics.isShared(v)))
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("Ensures has an \"old\" shared global");
                }

                /*
                if (used.globalsUsed.Count == 0)
                {
                    continue;
                }
                */

                // "Ensures" in procs without implementation are considered free
                if (re.Free == false && procsWithImpl.Contains(proc.Name))
                {
                    re.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InvalidInput("A non-free ensures is not yet supported");
                }

            }

        }

        // One cannot use "old" versions of shared globals
        private static void checkOld(Implementation impl)
        {
            VarsUsed used = new VarsUsed();

            foreach (var blk in impl.Blocks)
            {
                foreach (Cmd cmd in blk.Cmds)
                {
                    used.reset();
                    used.Visit(cmd);
                    if (used.oldVarsUsed.Any())
                    {
                        cmd.Emit(new TokenTextWriter(Console.Out), 0);
                        throw new InvalidInput("Command has an \"old\" variable");
                    }
                }
            }
        }

        // Check that the base types are only int and bool (no user defined types)
        private static void checkBaseTypes(Declaration decl)
        {
            if (decl is TypeCtorDecl)
            {
                decl.Emit(new TokenTextWriter(Console.Out), 0);
                throw new InvalidInput("Program has a user-defined type (cannot use with ArrayTheory)");
            }
        }

        public static bool checkFunctionsAreInlined(Program program)
        {
            foreach (var func in program.TopLevelDeclarations.OfType<Function>())
            {
                if (func.Body != null && !BoogieUtil.checkAttrExists("inline", func.Attributes))
                {
                    Console.WriteLine("Function {0} does not have an inline attribute", func.Name);
                    return false;
                }
            }
            return true;
        }

        public static bool checkMapTypes(Program program)
        {
            var types = ProgramTypes.FindAllTypes(program);
            if (types.Any(t => t.IsMap))
            {
                Console.WriteLine("Program uses the map type: {0}", types.Where(t => t.IsMap).First().ToString());
                return false;
            }

            return true;
        }
    }

    public class ProgramTypes : FixedVisitor
    {
        HashSet<Microsoft.Boogie.Type> types;

        ProgramTypes()
        {
            types = new HashSet<Microsoft.Boogie.Type>();
        }

        public static HashSet<Microsoft.Boogie.Type> FindAllTypes(Program program)
        {
            var visitor = new ProgramTypes();
            visitor.VisitProgram(program);
            return visitor.types;
        }

        public override Microsoft.Boogie.Type VisitType(Microsoft.Boogie.Type node)
        {
            types.Add(node);
            return base.VisitType(node);
        }

        public override Variable VisitVariable(Variable node)
        {
            if(node.TypedIdent.Type != null) types.Add(node.TypedIdent.Type);
            return base.VisitVariable(node);
        }
    }
}
