using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
  public class EntrypointScanner : StandardVisitor {
    List<string> entrypoints;

    private EntrypointScanner() {
      this.entrypoints = new List<string>();
    }
    public static List<string> FindEntrypoint(Program p) {
      var scanner = new EntrypointScanner();
      scanner.Visit(p);
      return scanner.entrypoints;
    }

    public override Procedure VisitProcedure(Procedure node) {
      if (QKeyValue.FindBoolAttribute(node.Attributes, "entrypoint"))
        entrypoints.Add(node.Name);
      return base.VisitProcedure(node);
    }
  }

    // Walks through the input program and stores useful information that is
    // later used by the instrumentation stage.
    public class ProgramInfo : FixedVisitor
    {
        // Are we already provided with a sample main procedure? (In which case,
        // the initialization procedure should not be given.) We use this main
        // procedure as the main for the instrumented program.
        public string mainProcName { get; private set; }
        private bool mainProcExists;

        // The set of all declared global variables
        public Dictionary<string, GlobalVariable> declaredGlobals { get; private set; }

        // The set of all global variables that are modified by at least
        // one of the thread entry procedures.
        public Dictionary<string, GlobalVariable> modifiedGlobals { get; private set; }

        // The set of thread-local variables
        public Dictionary<string, GlobalVariable> threadLocalGlobals { get; private set; }

        // Set of all procedure names in the program. Also used as 
        // "visited" information to ensure that we do not visit the
        // same procedure twice
        public HashSet<string> allProcs { get; private set; }

        // The set of procedures that have an implementation.
        // (Procedures without implementation are treated differently from other
        //  procedures)
        public HashSet<string> procsWithImplementation { get; private set; }

        // The set of all procedures that are called asynchronously
        public HashSet<string> asyncProcs { get; private set; }

        // The set of all procedures with an async call
        public HashSet<string> procsWithAsync { get; private set; }

        // The set of all procedures with an assert
        public HashSet<string> procsWithAssert { get; private set; }

        // The program call graph
        public ProgramCallGraph callGraph { get; private set; }

        // The type to use for thread IDs (Int or bv32)
        public Microsoft.Boogie.Type threadIdType { get; private set; }

        // Have we gathered program information?
        bool infoGathered;

        // Name of the procedure that acts like assert
        string assertNotReachableName;

        public ProgramInfo(string main, Program prog, string assertNotReachableName)
        {
            mainProcName = main;
            mainProcExists = false;
            this.assertNotReachableName = assertNotReachableName;

            allProcs = new HashSet<string>();
            procsWithImplementation = new HashSet<string>();
            asyncProcs = new HashSet<string>();
            procsWithAssert = new HashSet<string>();
            procsWithAsync = new HashSet<string>();

            declaredGlobals = new Dictionary<string, GlobalVariable>();
            modifiedGlobals = new Dictionary<string, GlobalVariable>();
            threadLocalGlobals = new Dictionary<string, GlobalVariable>();

            threadIdType = Microsoft.Boogie.Type.Int;
            
            infoGathered = false;

            callGraph = new ProgramCallGraph(prog);
            VisitProgram(prog);

        }

        public override Program VisitProgram(Program node)
        {
            Debug.Assert(!infoGathered);

            node.TopLevelDeclarations = this.VisitDeclarationList(node.TopLevelDeclarations.ToList());

            if (!mainProcExists)
            {
                throw new InternalError("Main proc not found");
            }

            infoGathered = true;

            return node;
        }

        public override List<Declaration> VisitDeclarationList(List<Declaration> declarationList)
        {

            var part = declarationList.Partition(x => x is GlobalVariable);
            var globals = part.fst;
            var rest = part.snd;

            List<Declaration> new_globals = new List<Declaration>();

            // Go through all the global declarations
            foreach (Declaration d in globals)
            {
                var g = (GlobalVariable)d;
                // Store declared global
                declaredGlobals.Add(g.Name, g);
                // Store thread-local global
                if (QKeyValue.FindBoolAttribute(g.Attributes, LanguageSemantics.ThreadLocalAttr))
                    threadLocalGlobals.Add(g.Name, g);
            }

            // Visit declaration other than global variable declarations
            for (int i = 0, n = rest.Count; i < n; i++)
                rest[i] = this.VisitDeclaration(rest[i]);

            return declarationList;
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            procsWithImplementation.Add(node.Name);
            
            // Build a list of async calls
            foreach (var blk in node.Blocks)
            {
                foreach (var cmd in blk.Cmds)
                {
                    if (cmd is CallCmd)
                    {
                        var ccmd = cmd as CallCmd;
                        if (ccmd.IsAsync)
                        {
                            asyncProcs.Add(ccmd.Proc.Name);
                            procsWithAsync.Add(node.Name);
                            if (ccmd.Outs.Count == 1 && ccmd.Outs[0] != null && ccmd.Outs[0].Decl.TypedIdent.Type.IsBv)
                            {
                                threadIdType = ccmd.Outs[0].Decl.TypedIdent.Type;
                            }
                        }

                        if (assertNotReachableName == (cmd as CallCmd).Proc.Name)
                        {
                            procsWithAssert.Add(node.Name);
                        }
                    }

                    if (cmd is AssertCmd)
                    {
                        procsWithAssert.Add(node.Name);
                    }
                }
            }
            
            return node;
        }

        public override Procedure VisitProcedure(Procedure node)
        {
            // Make sure not to visit the same Procedure twice
            if (allProcs.Contains(node.Name))
            {
                return node;
            }
            allProcs.Add(node.Name);

            if (node.Name.Equals(mainProcName))
            {
                mainProcExists = true;

                /*
                // Check if this guy takes input parameters
                if (node.InParams.Length != 0)
                {
                    throw new InvalidProg("main procedure " + node.Name + " has input paramters");
                }

                if (node.OutParams.Length != 0)
                {
                    Console.WriteLine("Warning: output parameters of the main procedure will be ignored");
                }
                 */
            }

            // Keep record of all modified globals
            foreach (IdentifierExpr ie in node.Modifies)
            {
                GlobalVariable g = (GlobalVariable)ie.Decl;
                if (g == null) continue;
                if (!modifiedGlobals.ContainsKey(g.Name))
                {
                    modifiedGlobals.Add(g.Name, g);
                }
            }

            // No need to go down into a procedure
            //node.Modifies = this.VisitIdentifierExprSeq(node.Modifies);
            //node.InParams = this.VisitVariableSeq(node.InParams);
            //node.OutParams = this.VisitVariableSeq(node.OutParams);

            if (node.Name == LanguageSemantics.getThreadIDName())
            {
                Debug.Assert(node.OutParams.Count == 1);
                if (node.OutParams[0].TypedIdent.Type.IsBv)
                {
                    threadIdType = node.OutParams[0].TypedIdent.Type;
                }
            }

            return node;
        }

        public bool hasModifiedGlobalVars(Absy exp)
        {
            Debug.Assert(infoGathered);

            GlobalVarsUsed usesg = new GlobalVarsUsed();

            usesg.Visit(exp);

            // If any used variable is also modified then return true
            if (usesg.Used.Any(x => modifiedGlobals.ContainsKey(x)))
                return true;

            return false;
        }

        // Return the set of all global variables
        public HashSet<GlobalVariable> getAllGlobalVars()
        {
            HashSet<GlobalVariable> ret = new HashSet<GlobalVariable>();
            foreach (var gbl in modifiedGlobals)
            {
                ret.Add(gbl.Value);
            }

            return ret;

        }

        // Does this procedure call an "assert" transitively?
        public bool procContainsAssert(string proc)
        {
            return callGraph.callsTransitive(proc, procsWithAssert);
        }

        // Does this procedure spawn a thread (i.e., makes an async call)?
        public bool procSpawnsThread(string proc)
        {
            return callGraph.callsTransitive(proc, procsWithAsync);
        }

        public void PrintInfo(TokenTextWriter writer)
        {
            if (writer == null)
                return;

            writer.WriteLine("=================================");
            writer.WriteLine("Here's what we know of the program:");



            writer.Write("Declared globals: ");
            foreach (var g in declaredGlobals)
            {
                writer.Write(g.Key + " ");
            }
            writer.Write("\n");

            writer.Write("Modified globals: ");
            foreach (var g in modifiedGlobals)
            {
                writer.Write(g.Key + " ");
            }
            writer.Write("\n");

            writer.WriteLine("Main procedure: {0}", mainProcName);

            writer.WriteLine("=================================");
        }

    }

    // Stores the call graph of a program in terms of procedure names.
    public class ProgramCallGraph : FixedVisitor
    {
        // Edges of the call graph
        Dictionary<string, HashSet<string>> succEdges;
        Dictionary<string, HashSet<string>> predEdges;

        // Current procedure being visited
        string currProc;

        public ProgramCallGraph(Program prog)
        {
            succEdges = new Dictionary<string, HashSet<string>>();
            predEdges = new Dictionary<string, HashSet<string>>();

            VisitProgram(prog);
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            currProc = node.Name;
            return base.VisitImplementation(node);
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            string callee = node.Proc.Name;
            addEdge(currProc, callee);
            return node;
        }

        private void addEdge(string from, string to)
        {
            if (!succEdges.ContainsKey(from))
            {
                succEdges.Add(from, new HashSet<string>());
            }

            if (!predEdges.ContainsKey(to))
            {
                predEdges.Add(to, new HashSet<string>());
            }

            succEdges[from].Add(to);
            predEdges[to].Add(from);
        }

        // Is proc called?
        public bool isCalled(string proc)
        {
            if (!predEdges.ContainsKey(proc))
            {
                return false;
            }

            return predEdges[proc].Any();
        }

        // Does "from" call "to"?
        public bool calls(string from, string to)
        {
            if (!succEdges.ContainsKey(from))
            {
                return false;
            }

            return succEdges[from].Contains(to);
        }

        // Does "from" call any proc in "to"?
        public bool calls(string from, HashSet<string> to)
        {
            if (!succEdges.ContainsKey(from))
            {
                return false;
            }

            return (HashSetExtras<string>.Intersection(succEdges[from], to).Count > 0);
        }

        // Does "from" call "to" transitively
        public bool callsTransitive(string from, string to)
        {
            return getAllTransitiveSucc(from).Contains(to);
        }

        // Does "from" call any proc in "to" transitively
        public bool callsTransitive(string from, HashSet<string> to)
        {
            return (HashSetExtras<string>.Intersection(getAllTransitiveSucc(from), to).Count > 0);
        }

        // Return the set of all procs called from "proc"
        private HashSet<string> getAllTransitiveSucc(string proc)
        {
            var visited = new HashSet<string>();
            var frontier = new HashSet<string>();

            frontier.Add(proc);

            while (frontier.Any())
            {
                visited.UnionWith(frontier);

                var newfrontier = new HashSet<string>();
                foreach (var str in frontier)
                {
                    if(!succEdges.ContainsKey(str))
                        continue;

                    newfrontier.UnionWith(succEdges[str]);
                }

                frontier = HashSetExtras<string>.Difference(newfrontier, visited);
            }

            return visited;
        }
    }
}
