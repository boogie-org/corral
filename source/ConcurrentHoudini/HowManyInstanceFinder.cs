using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using bpl = Microsoft.Boogie;
namespace ConcurrentHoudini
{
    class HowManyInstanceFinder : cba.Util.FixedVisitor
    {

        public HowManyInstanceFinder(Context con, bool dbg)
        {
            this.con = con;
            this.dbg = dbg;
        }

        public override bpl.Cmd VisitCallCmd(bpl.CallCmd node)
        {
            if (callGraph[curProc].ContainsKey(node.callee))
                callGraph[curProc][node.callee]++;
            else
                callGraph[curProc][node.callee] = 1;
            visited[node.callee] = 0;
            if (con.isAsyncCall(node))
                instances[node.callee] = 0;
            return base.VisitCallCmd(node);
        }

        public override bpl.Program VisitProgram(bpl.Program node)
        {
            callGraph = new Dictionary<string, Dictionary<string, int>>();
            visited = new Dictionary<string, int>();
            instances = new Dictionary<string, int>();
            return base.VisitProgram(node);
        }

        public override bpl.Implementation VisitImplementation(bpl.Implementation node)
        {
            curProc = node.Name;
            callGraph[curProc] = new Dictionary<string, int>();
            return base.VisitImplementation(node);
        }
        string curProc;

        private void dfs(string proc)
        {
            if (!callGraph.ContainsKey(proc))
                return;
            foreach (var iter in callGraph[proc])
            {
                var callee = iter.Key;
                var numCalls = iter.Value;
                if (visited[callee] == 2)
                    continue;
                numCalls = numCalls + visited[callee];
                visited[callee] = (numCalls >= 2) ? 2 : numCalls;
                dfs(callee);
            }
        }

        private void getInstances(string main)
        {
            foreach (var proc in visited.Keys)
            {
                if (visited[proc] == 0)
                    continue;
                if (!callGraph.ContainsKey(proc))
                    continue;
                foreach (var callee in callGraph[proc].Keys)
                {
                    if (!instances.ContainsKey(callee))
                        continue;
                    if (instances[callee] == 2)
                        continue;

                    if (visited[proc] == 2)
                        instances[callee] = 2;
                    else
                    // visited[proc] == 1;
                    {
                        //over-approximating. If all calls are sync, then we should only add 1.
                        instances[callee] += callGraph[proc][callee];
                        instances[callee] = instances[callee] > 2 ? 2 : instances[callee];
                    }
                }
            }
        }

        public bpl.Program Compute(bpl.Program program)
        {
            this.program = program;

            var mains = from decl in program.TopLevelDeclarations where decl is bpl.Procedure && con.isMain(decl) select (decl as bpl.Procedure);
            if (mains.Count() != 1)
                throw new ConcurrentHoudiniException("How many mains you got?");
            var main = mains.First().Name;

            // Compute call graph etc.
            Visit(program);

            // Find loops in the call graph.
            // entry function is visited at least once
            if (!visited.ContainsKey(main))
                visited[main] = 1;
            dfs(main);

            // Find thread entries that may have multiple instances
            // entry function has one instance running
            instances[main] = 1;
            getInstances(main);

            // label thread entries that are guaranteed to have a single instance.
            var procs = from decl in program.TopLevelDeclarations where decl is bpl.Procedure select (decl as bpl.Procedure);
            foreach (var proc in procs)
            {
                if (instances.ContainsKey(proc.Name) && instances[proc.Name] < 2)
                {
                    var attr = con.getSingleInstanceAttr();
                    attr.Next = proc.Attributes;
                    proc.Attributes = attr;
                }
            }

            if (dbg)
            {
                System.Console.WriteLine("HOWMANYINSTANCEFINDER");
                System.Console.WriteLine("Visited:");
                foreach (var iter in visited)
                    System.Console.WriteLine(iter.Key + ": " + iter.Value);
                System.Console.WriteLine("Instances:");
                foreach (var iter in instances)
                    System.Console.WriteLine(iter.Key + ": " + iter.Value);

            }
            return this.program;
        }

        Context con;
        bool dbg;
        bpl.Program program;

        Dictionary<string, Dictionary<string, int>> callGraph;
        Dictionary<string, int> visited;
        public Dictionary<string, int> instances;
    }
}
