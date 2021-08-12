
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;
using SimpleHoudini = cba.SimpleHoudini;

namespace AngelicVerifierNull
{
    class Options
    {
        // Reuse tracked variables and explored call tree across corral runs
        public static bool UsePrevCorralState = true;
        // Use Corral's DeepAssert instrumentation
        public static bool DeepAsserts = false;
        // use EBasic?
        public static bool useEbasic = true;
        // Don't use EE to block paths
        public static bool useEE = true;
        // Rerun EE second time to obtain the path condition 
        public static bool repeatEEWithControlFlow = false;
        // Retry EE without map update elimination in case of timeouts
        public static bool retryEEWithoutMapUpdElimOnTimeout = false;
        // Perform trace slicing
        public static bool TraceSlicing = false;
        // Flags for EE
        public static HashSet<string> EEflags = new HashSet<string>();
        // ExplainError timeout (in seconds)
        public static int eeTimeout = 1000;
        // Flag for generalization
        public static bool generalize = true;
        // Max num. of attempts at blocking
        public static int MAX_REPEATED_BLOCK_EXPR = 2;
        // Remove axioms on alloc constants
        public static bool RemoveAllocConstantAxioms = true;
        // disable optimized deadcode detection
        public static bool disbleDeadcodeOpt = false;
        // Flag for reporting assertion when MAX_ASSERT_BLOCK_COUNT is reached
        public static bool reportOnMaxBlockCount = false;
        // Suppress when blocking on free variables?
        public static bool blockOnFreeVars = false;
        // File containing the filters for ExplainError
        public static string eeFilters = "";
        // Kill the process after these many seconds
        public static int killAfter = 0;
        // Don't use the duplicator for cloning programs -- BCT programs seem to crash as a result
        public static bool UseDuplicator
        { set { ProgTransformation.PersistentProgramIO.useDuplicator = value; } }
    }

    public class Driver
    {
        static cba.Configs corralConfig = null;
        static HashSet<string> IdentifiedEntryPoints = new HashSet<string>();
        public static ExplainError.ControlFlowDependency controlFlowDependencyInformation = null;

        static string boogieOpts = "";
        static string corralOpts = "";
        public static HashSet<string> recordVars = new HashSet<string>();
        public static bool allocateParameters = true; //allocating parameters for procedures
        public enum PRINT_TRACE_MODE { Boogie, Sdv };
        public static PRINT_TRACE_MODE printTraceMode = PRINT_TRACE_MODE.Boogie;


        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Usage: AngelicVerifierNull infile.bpl outfile.bpl");
                return;
            }
            corralConfig = InitializeCorral();
            var prog = BoogieUtil.ReadAndOnlyResolve(args[0]);
            //Console.WriteLine("the proc names");
            //prog.Implementations.Iter(x => Console.WriteLine(x.Proc.Name));

            var visitor = new PartitionAttributeAdderVisitor();
            visitor.Run(prog);

            BoogieUtil.PrintProgram(prog, args[1]);
            Console.WriteLine("The attibutes have been added to {0}", args[1]);



        }

        #region Corral related
        public static cba.Configs InitializeCorral()
        {
            // 
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;

            // Set all defaults for corral
            corralOpts += " doesntExist.bpl /track:alloc /track:$Alloc /useProverEvaluate /printVerify ";
            var config = cba.Configs.parseCommandLine(corralOpts.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
            config.boogieOpts += boogieOpts;
            cba.GlobalConfig.varsToRecord = new HashSet<string>(recordVars);
            config.trackedVars.UnionWith(recordVars);

            cba.Driver.Initialize(config);

            cba.VerificationPass.usePruning = false;

            if (!config.useProverEvaluate)
            {
                cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = true;
                if (config.NonUniformUnfolding && !config.useProverEvaluate)
                    cba.ConfigManager.progVerifyOptions.StratifiedInliningWithoutModels = false;
                if (config.printData == 0)
                    cba.ConfigManager.pathVerifyOptions.StratifiedInliningWithoutModels = true;
            }

            return config;
        }
        #endregion

    }

    public class PartitionAttributeAdderVisitor : FixedVisitor
    {
        string corralMainProcName = "CorralMain";

        public void Run(Program program)
        {
            foreach (Implementation implementation in program.Implementations)
            {
                if (implementation.Proc.Name != corralMainProcName)
                {
                    implementation.ComputePredecessorsForBlocks();
                    VisitImplementation(implementation);
                }
            }
        }

        public override Block VisitBlock(Block node)
        {
            //Console.WriteLine($"this block is being visited {node.Label}");
            if (DoAnyOfThePredecessorsHaveMultipleSucessor(node))
            {
                AddPartitionAttributeToAssume(ref node);
            }
            return node;
        }

        private bool DoAnyOfThePredecessorsHaveMultipleSucessor(Block node)
        {
            //Console.WriteLine("this is the number of predeccors {0}", node.Predecessors.Count());

            foreach (Block pre in node.Predecessors)
            {
                //Console.WriteLine($"this is the predecessor {pre.Label}");
                //pre.succCount is always 0 and hence we use the following command to find the number of successors
                if (NumSuccessors(pre) > 1)
                {
                    return true;
                }
            }
            return false;
        }

        private int NumSuccessors(Block node)
        {
            TransferCmd lastCmd = node.TransferCmd;
            if (lastCmd is GotoCmd)
            {
                return (lastCmd as GotoCmd).labelTargets.Count;
            }
            else
            {
                return 0;
            }
        }

        public void AddPartitionAttributeToAssume(ref Block node)
        {
            //Console.WriteLine($"this is called for block {node.Label}");
            Cmd firstCmd = node.cmds.ElementAt(0);
            if (firstCmd is AssumeCmd && (firstCmd as AssumeCmd).Expr != Expr.True)
            {
                //Console.WriteLine($"this is the fist cmd {firstCmd}");
                AssumeCmd assCmd = (firstCmd as AssumeCmd);
                assCmd.Attributes = new QKeyValue(Token.NoToken, "partition", new List<object>(),
                       assCmd.Attributes); ;
                node.cmds[0] = assCmd;
            }
        }
    }


}
