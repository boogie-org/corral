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
            for (int i = 1; i < args.Length; i++)
            {
                if (args[i] == "/break")
                {
                    System.Diagnostics.Debugger.Launch();
                    continue;
                }

                boogieArgs += args[i] + " ";
            }
            Initalize(boogieArgs);

            var program = BoogieUtil.ReadAndResolve(file);
            var hi = new HoudiniInlining(program, null, null, CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend);
        }

        static void Initalize(string boogieOptions)
        {
            CommandLineOptions.Install(new CommandLineOptions());
            CommandLineOptions.Clo.PrintInstrumented = true;
            BoogieUtil.InitializeBoogie(boogieOptions);
            cba.Util.BoogieVerify.options = new BoogieVerifyOptions();
        }

        static void RunHoudini(Program program)
        {

        }
    }

    class HoudiniInlining : StratifiedInlining
    {
        public Function CandidateFunc;
        public Dictionary<string, Constant> CandidateConstants;
        
        public HoudiniInlining(Program program, Function CandidateFunc, Dictionary<string, Constant> CandidateConstants, 
            string logFilePath, bool appendLogFile) :
            base(program, logFilePath, appendLogFile)
        {
            this.CandidateFunc = CandidateFunc;
            this.CandidateConstants = CandidateConstants;

            implName2StratifiedInliningInfo.Iter(tup =>
                {
                    tup.Value.GenerateVC();
                    Console.WriteLine("VC of {0}: {1}", tup.Key, tup.Value.vcexpr);
                });
        }

        public static void RunHoudini(Program program)
        {
            // Gather existential constants
            var CandidateConstants = new Dictionary<string, Constant>();
            program.TopLevelDeclarations.OfType<Constant>()
                .Where(c => QKeyValue.FindBoolAttribute(c.Attributes, "existential"))
                .Iter(c => CandidateConstants.Add(c.Name, c));

            // Create a function -- for book-keeping
            var CandidateFunc = new Function(Token.NoToken, "HoudiniLiteFunc",
                new List<Variable> { BoogieAstFactory.MkFormal("a", Microsoft.Boogie.Type.Bool, true), BoogieAstFactory.MkFormal("b", Microsoft.Boogie.Type.Bool, true) },
                BoogieAstFactory.MkFormal("c", Microsoft.Boogie.Type.Bool, false));

            // Install Ensures into the program
            program.TopLevelDeclarations.OfType<Implementation>()
                .Iter(impl => InstallEnsures(impl, CandidateFunc, CandidateConstants));

            // VC Gen
            var hi = new HoudiniInlining(program,CandidateFunc, CandidateConstants,
                CommandLineOptions.Clo.SimplifyLogFilePath, CommandLineOptions.Clo.SimplifyLogFileAppend);



        }

        static void InstallEnsures(Implementation impl, Function CandidateFunc, Dictionary<string, Constant> CandidateConstants)
        {
            if (impl.Proc.Requires.Any(r => !r.Free))
                throw new Exception("HoudiniLite: Non-free requires not yet supported");

            // create unified exit block
            Block exitBlock = null;
            if (impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd).Count() != 1)
            {
                exitBlock = new Block(Token.NoToken, "exit$block$hi", new List<Cmd>(), new ReturnCmd(Token.NoToken));
                foreach (var blk in impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd))
                {
                    blk.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { exitBlock });
                }
                impl.Blocks.Add(exitBlock);
            }
            else
            {
                exitBlock = impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd).First();
            }

            // install free ensures
            foreach (var ens in impl.Proc.Ensures.Where(e => e.Free))
                exitBlock.Cmds.Add(new AssumeCmd(ens.tok, ens.Condition));

            // install non-free ensures
            foreach (var ens in impl.Proc.Ensures.Where(e => !e.Free))
            {
                string constantName = null;
                Expr expr = null;

                var match = Microsoft.Boogie.Houdini.Houdini.GetCandidateWithoutConstant(
                    ens.Condition, CandidateConstants.Keys, out constantName, out expr);

                if(!match)
                    throw new Exception("HoudiniLite: Ensures without a candidate implication not yet supported");

                var constant = CandidateConstants[constantName];

                // assume f(constant, expr);
                exitBlock.Cmds.Add(new AssumeCmd(ens.tok,
                    new NAryExpr(Token.NoToken, new FunctionCall(CandidateFunc),
                        new List<Expr> { Expr.Ident(constant), expr })));
            }
        }

        public VCExpr GetSummary(string proc)
        {
            throw new NotImplementedException();
        }
    }

    class HoudiniVC : StratifiedVC
    {
        HoudiniInlining HI;
        public Dictionary<string, VCExpr> Ensures;

        public HoudiniVC(StratifiedInliningInfo siInfo, HashSet<string> procCalls)
            : base(siInfo, procCalls)
        { 
            // Remove CandiateFunc
            var fsp = new FindSummaryPred(HI.prover.VCExprGen, HI.CandidateFunc.Name);
            vcexpr = fsp.Mutate(vcexpr, true);
            this.Ensures = fsp.summaryPreds;

            // Assume summaries of callees
            foreach (var cs in CallSites)
            {
                var summary = HI.GetSummary(cs.callSite.calleeName);
                vcexpr = HI.prover.VCExprGen.And(vcexpr,
                    HI.prover.VCExprGen.Implies(cs.callSiteExpr, summary));
            }        
        }


        class FindSummaryPred : MutatingVCExprVisitor<bool>
        {
            public Dictionary<string, VCExpr> summaryPreds;
            public string CandidateFunc;

            public FindSummaryPred(VCExpressionGenerator gen, string CandidateFunc)
                : base(gen)
            {
                summaryPreds = new Dictionary<string, VCExpr>();
                this.CandidateFunc = CandidateFunc;
            }

            protected override VCExpr/*!*/ UpdateModifiedNode(VCExprNAry/*!*/ originalNode,
                                                  List<VCExpr/*!*/>/*!*/ newSubExprs,
                // has any of the subexpressions changed?
                                                  bool changed,
                                                  bool arg)
            {
                VCExpr ret;
                if (changed)
                    ret = Gen.Function(originalNode.Op,
                                       newSubExprs, originalNode.TypeArguments);
                else
                    ret = originalNode;

                VCExprNAry retnary = ret as VCExprNAry;
                if (retnary == null) return ret;
                var op = retnary.Op as VCExprBoogieFunctionOp;
                if (op == null)
                    return ret;

                string calleeName = op.Func.Name;

                if (calleeName != CandidateFunc)
                    return ret;

                var lt = retnary[0] as VCExprConstant;
                Debug.Assert(lt != null);

                summaryPreds.Add(lt.Name, retnary[1]);

                return VCExpressionGenerator.True;
            }

        }


    }

}
