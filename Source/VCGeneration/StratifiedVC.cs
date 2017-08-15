using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.IO;
using Microsoft.Boogie;
using Microsoft.Boogie.GraphUtil;
using System.Diagnostics.Contracts;
using Microsoft.Basetypes;
using Microsoft.Boogie.VCExprAST;
using RefinementFuzzing;
using Common;

namespace VC {
  using Bpl = Microsoft.Boogie;
  
  public class StratifiedVC {
    public StratifiedInliningInfo info;
    public int id;
    public List<VCExprVar> interfaceExprVars;

    // boolControlVC (block -> its bool variable)
    public Dictionary<Block, VCExpr> blockToControlVar;
    // While using labels (block -> its label)
    public Dictionary<Absy, string> block2label;

    public Dictionary<Block, List<StratifiedCallSite>> callSites;
    public Dictionary<Block, List<StratifiedCallSite>> recordProcCallSites;
    public VCExpr vcexpr;

    // Must-Reach Information
    Dictionary<Block, VCExprVar> mustReachVar;
    List<VCExprLetBinding> mustReachBindings;

    public StratifiedVC(StratifiedInliningInfo siInfo, HashSet<string> procCalls) {
      info = siInfo;
      info.GenerateVC();
      var vcgen = info.vcgen;
      var prover = vcgen.prover;
      VCExpressionGenerator gen = prover.VCExprGen;
      var bet = prover.Context.BoogieExprTranslator; 
      
      vcexpr = info.vcexpr;
      id = vcgen.CreateNewId();
      interfaceExprVars = new List<VCExprVar>();
      Dictionary<VCExprVar, VCExpr> substDict = new Dictionary<VCExprVar, VCExpr>();
      foreach (VCExprVar v in info.interfaceExprVars) {
        VCExprVar newVar = vcgen.CreateNewVar(v.Type);
        interfaceExprVars.Add(newVar);
        substDict.Add(v, newVar);
      }
      foreach (VCExprVar v in info.privateExprVars) {
        substDict.Add(v, vcgen.CreateNewVar(v.Type));
      }
      if(info.controlFlowVariable != null)
          substDict.Add(bet.LookupVariable(info.controlFlowVariable), gen.Integer(BigNum.FromInt(id)));
      VCExprSubstitution subst = new VCExprSubstitution(substDict, new Dictionary<TypeVariable, Microsoft.Boogie.Type>());
      SubstitutingVCExprVisitor substVisitor = new SubstitutingVCExprVisitor(prover.VCExprGen);
      vcexpr = substVisitor.Mutate(vcexpr, subst);

      // For BoolControlVC generation
      if (info.blockToControlVar != null)
      {
          blockToControlVar = new Dictionary<Block, VCExpr>();
          foreach (var tup in info.blockToControlVar)
              blockToControlVar.Add(tup.Key, substDict[tup.Value]);
      }

      // labels
      if (info.label2absy != null)
      {
          block2label = new Dictionary<Absy, string>();
          vcexpr = RenameVCExprLabels.Apply(vcexpr, info.vcgen.prover.VCExprGen, info.label2absy, block2label);
      }

      if(procCalls != null)
         vcexpr = RemoveProcedureCalls.Apply(vcexpr, info.vcgen.prover.VCExprGen, procCalls);

      callSites = new Dictionary<Block, List<StratifiedCallSite>>();
      foreach (Block b in info.callSites.Keys) {
        callSites[b] = new List<StratifiedCallSite>();
        foreach (CallSite cs in info.callSites[b]) {
          callSites[b].Add(new StratifiedCallSite(cs, substVisitor, subst));
        }
      }

      recordProcCallSites = new Dictionary<Block, List<StratifiedCallSite>>();
      foreach (Block b in info.recordProcCallSites.Keys) {
        recordProcCallSites[b] = new List<StratifiedCallSite>();
        foreach (CallSite cs in info.recordProcCallSites[b]) {
          recordProcCallSites[b].Add(new StratifiedCallSite(cs, substVisitor, subst));
        }
      }
    }

    public VCExpr MustReach(Block block)
    {
        Contract.Assert(!CommandLineOptions.Clo.UseLabels);

        // This information is computed lazily
        if (mustReachBindings == null)
        {
            var vcgen = info.vcgen;
            var gen = vcgen.prover.VCExprGen;
            var impl = info.impl;
            mustReachVar = new Dictionary<Block, VCExprVar>();
            mustReachBindings = new List<VCExprLetBinding>();
            foreach (Block b in impl.Blocks)
                mustReachVar[b] = vcgen.CreateNewVar(Bpl.Type.Bool);

            var dag = new Graph<Block>();
            dag.AddSource(impl.Blocks[0]);
            foreach (Block b in impl.Blocks)
            {
                var gtc = b.TransferCmd as GotoCmd;
                if (gtc != null)
                    foreach (Block dest in gtc.labelTargets)
                        dag.AddEdge(dest, b);
            }
            IEnumerable sortedNodes = dag.TopologicalSort();

            foreach (Block currBlock in dag.TopologicalSort())
            {
                if (currBlock == impl.Blocks[0])
                {
                    mustReachBindings.Add(gen.LetBinding(mustReachVar[currBlock], VCExpressionGenerator.True));
                    continue;
                }

                VCExpr expr = VCExpressionGenerator.False;
                foreach (var pred in dag.Successors(currBlock))
                {
                    VCExpr controlFlowFunctionAppl = gen.ControlFlowFunctionApplication(gen.Integer(BigNum.FromInt(id)), gen.Integer(BigNum.FromInt(pred.UniqueId)));
                    VCExpr controlTransferExpr = gen.Eq(controlFlowFunctionAppl, gen.Integer(BigNum.FromInt(currBlock.UniqueId)));
                    expr = gen.Or(expr, gen.And(mustReachVar[pred], controlTransferExpr));
                }
                mustReachBindings.Add(gen.LetBinding(mustReachVar[currBlock], expr));
            }
        }

        Contract.Assert(mustReachVar.ContainsKey(block));
        return info.vcgen.prover.VCExprGen.Let(mustReachBindings, mustReachVar[block]);
    }

    public List<StratifiedCallSite> CallSites {
      get {
        var ret = new List<StratifiedCallSite>();
        foreach (var b in callSites.Keys) {
          foreach (var cs in callSites[b]) {
            ret.Add(cs);
          }
        }
        return ret;
      }
    }

    public List<StratifiedCallSite> RecordProcCallSites {
      get {
        var ret = new List<StratifiedCallSite>();
        foreach (var b in recordProcCallSites.Keys) {
          foreach (var cs in recordProcCallSites[b]) {
            ret.Add(cs);
          }
        }
        return ret;
      }
    }

    public override string ToString()
    {
        return info.impl.Name;
    }
  }

  // Rename all labels in a VC to (globally) fresh labels
  class RenameVCExprLabels : MutatingVCExprVisitor<bool>
  {
      Dictionary<int, Absy> label2absy;
      Dictionary<Absy, string> absy2newlabel;
      static int counter = 11;

      RenameVCExprLabels(VCExpressionGenerator gen, Dictionary<int, Absy> label2absy, Dictionary<Absy, string> absy2newlabel)
          : base(gen)
      {
          this.label2absy = label2absy;
          this.absy2newlabel = absy2newlabel;
      }

      public static VCExpr Apply(VCExpr expr, VCExpressionGenerator gen, Dictionary<int, Absy> label2absy, Dictionary<Absy, string> absy2newlabel)
      {
          return (new RenameVCExprLabels(gen, label2absy, absy2newlabel)).Mutate(expr, true);
      }

      // Finds labels and changes them to a globally unique label:
      protected override VCExpr/*!*/ UpdateModifiedNode(VCExprNAry/*!*/ originalNode,
                                                    List<VCExpr/*!*/>/*!*/ newSubExprs,
                                                    bool changed,
                                                    bool arg)
      {
          Contract.Ensures(Contract.Result<VCExpr>() != null);

          VCExpr ret;
          if (changed)
              ret = Gen.Function(originalNode.Op,
                                 newSubExprs, originalNode.TypeArguments);
          else
              ret = originalNode;

          VCExprLabelOp lop = originalNode.Op as VCExprLabelOp;
          if (lop == null) return ret;
          if (!(ret is VCExprNAry)) return ret;
          VCExprNAry retnary = (VCExprNAry)ret;

          // remove the sign
          var nosign = 0;
          if (!Int32.TryParse(lop.label.Substring(1), out nosign))
              return ret;

          if (!label2absy.ContainsKey(nosign))
              return ret;

          string newLabel = "SI" + counter.ToString();
          counter++;
          absy2newlabel[label2absy[nosign]] = newLabel;
          
          if (lop.pos)
          {
              return Gen.LabelPos(newLabel, retnary[0]);
          }
          else
          {
              return Gen.LabelNeg(newLabel, retnary[0]);
          }

      }
  }

  // Remove the uninterpreted function calls that substitute procedure calls
  class RemoveProcedureCalls : MutatingVCExprVisitor<bool>
  {
      HashSet<string> procNames;

      RemoveProcedureCalls(VCExpressionGenerator gen, HashSet<string> procNames)
          : base(gen)
      {
          this.procNames = procNames;
      }

      public static VCExpr Apply(VCExpr expr, VCExpressionGenerator gen, HashSet<string> procNames)
      {
          return (new RemoveProcedureCalls(gen, procNames)).Mutate(expr, true);
      }

      // Finds labels and changes them to a globally unique label:
      protected override VCExpr/*!*/ UpdateModifiedNode(VCExprNAry/*!*/ originalNode,
                                                    List<VCExpr/*!*/>/*!*/ newSubExprs,
                                                    bool changed,
                                                    bool arg)
      {
          //Contract.Ensures(Contract.Result<VCExpr>() != null);

          VCExpr ret;
          if (changed)
              ret = Gen.Function(originalNode.Op,
                                 newSubExprs, originalNode.TypeArguments);
          else
              ret = originalNode;

          if (!(ret is VCExprNAry)) return ret;
          VCExprNAry retnary = (VCExprNAry)ret;
          if (!(retnary.Op is VCExprBoogieFunctionOp))
              return ret;

          var fcall = (retnary.Op as VCExprBoogieFunctionOp).Func.Name;
          if (procNames.Contains(fcall))
              return VCExpressionGenerator.True;
          return ret;
      }
  }
		

  public class CallSite {
    public string calleeName;
    public List<VCExpr> interfaceExprs;
    public Block block;
    public int numInstr;  // for TraceLocation
    public VCExprVar callSiteVar;
    public QKeyValue Attributes; // attributes on the call cmd
    public CallSite(string callee, List<VCExpr> interfaceExprs, VCExprVar callSiteVar, Block block, int numInstr, QKeyValue Attributes)
    {
      this.calleeName = callee;
      this.interfaceExprs = interfaceExprs;
      this.callSiteVar = callSiteVar;
      this.block = block;
      this.numInstr = numInstr;
      this.Attributes = Attributes;
    }
  }

  public class StratifiedCallSite {
    public CallSite callSite;
    public List<VCExpr> interfaceExprs;
    public VCExpr callSiteExpr;

    public StratifiedCallSite(CallSite cs, SubstitutingVCExprVisitor substVisitor, VCExprSubstitution subst) {
      callSite = cs;
      interfaceExprs = new List<VCExpr>();
      foreach (VCExpr v in cs.interfaceExprs) {
        interfaceExprs.Add(substVisitor.Mutate(v, subst));
      }
      if (callSite.callSiteVar != null)
        callSiteExpr = substVisitor.Mutate(callSite.callSiteVar, subst);
    }

    public VCExpr Attach(StratifiedVC svc) {
      Contract.Assert(interfaceExprs.Count == svc.interfaceExprVars.Count);
      StratifiedInliningInfo info = svc.info;
      ProverInterface prover = info.vcgen.prover;
      VCExpressionGenerator gen = prover.VCExprGen;
      
      Dictionary<VCExprVar, VCExpr> substDict = new Dictionary<VCExprVar, VCExpr>();
      for (int i = 0; i < svc.interfaceExprVars.Count; i++) {
        VCExprVar v = svc.interfaceExprVars[i];
        substDict.Add(v, interfaceExprs[i]);
      }
      VCExprSubstitution subst = new VCExprSubstitution(substDict, new Dictionary<TypeVariable, Microsoft.Boogie.Type>());
      SubstitutingVCExprVisitor substVisitor = new SubstitutingVCExprVisitor(prover.VCExprGen);
      svc.vcexpr = substVisitor.Mutate(svc.vcexpr, subst);
      foreach (StratifiedCallSite scs in svc.CallSites) {
        List<VCExpr> newInterfaceExprs = new List<VCExpr>();
        foreach (VCExpr expr in scs.interfaceExprs) {
          newInterfaceExprs.Add(substVisitor.Mutate(expr, subst));
        }
        scs.interfaceExprs = newInterfaceExprs;
      }
      foreach (StratifiedCallSite scs in svc.RecordProcCallSites) {
        List<VCExpr> newInterfaceExprs = new List<VCExpr>();
        foreach (VCExpr expr in scs.interfaceExprs) {
          newInterfaceExprs.Add(substVisitor.Mutate(expr, subst));
        }
        scs.interfaceExprs = newInterfaceExprs;
      }
      //return gen.Implies(callSiteExpr, svc.vcexpr);
      return svc.vcexpr;
    }

    public override string ToString()
    {
        return callSite.calleeName;
    }
  }

  public class StratifiedInliningInfo {
    public StratifiedVCGenBase vcgen;
    public Implementation impl;
    public Function function;
    public Variable controlFlowVariable;
    public Cmd exitAssertCmd;
    public VCExpr vcexpr;
    public List<VCExprVar> interfaceExprVars;
    public List<VCExprVar> privateExprVars;
    public Dictionary<int, Absy> label2absy;
    public ModelViewInfo mvInfo;
    public Dictionary<Block, List<CallSite>> callSites;
    public Dictionary<Block, List<CallSite>> recordProcCallSites;
    public bool initialized { get; private set; }
    // Instrumentation to apply after PassiveImpl, but before VCGen
    Action<Implementation> PassiveImplInstrumentation;

    // boolControlVC (block -> its Bool variable)
    public Dictionary<Block, VCExprVar> blockToControlVar; 

    public StratifiedInliningInfo(Implementation implementation, StratifiedVCGenBase stratifiedVcGen, Action<Implementation> PassiveImplInstrumentation) {
      vcgen = stratifiedVcGen;
      impl = implementation;
      this.PassiveImplInstrumentation = PassiveImplInstrumentation;

      List<Variable> functionInterfaceVars = new List<Variable>();
      foreach (Variable v in vcgen.program.GlobalVariables) {
        functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
      }
      foreach (Variable v in impl.InParams) {
        functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
      }
      foreach (Variable v in impl.OutParams) {
        functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", v.TypedIdent.Type), true));
      }
      foreach (IdentifierExpr e in impl.Proc.Modifies) {
        if (e.Decl == null) continue;
        functionInterfaceVars.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", e.Decl.TypedIdent.Type), true));
      }
      Formal returnVar = new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", Bpl.Type.Bool), false);
      function = new Function(Token.NoToken, impl.Name, functionInterfaceVars, returnVar);
      vcgen.prover.Context.DeclareFunction(function, "");

      List<Expr> exprs = new List<Expr>();
      foreach (Variable v in vcgen.program.GlobalVariables) {
        Contract.Assert(v != null);
        exprs.Add(new OldExpr(Token.NoToken, new IdentifierExpr(Token.NoToken, v)));
      }
      foreach (Variable v in impl.Proc.InParams) {
        Contract.Assert(v != null);
        exprs.Add(new IdentifierExpr(Token.NoToken, v));
      }
      foreach (Variable v in impl.Proc.OutParams) {
        Contract.Assert(v != null);
        exprs.Add(new IdentifierExpr(Token.NoToken, v));
      }
      foreach (IdentifierExpr ie in impl.Proc.Modifies) {
        Contract.Assert(ie != null);
        if (ie.Decl == null)
          continue;
        exprs.Add(ie);
      }
      Expr freePostExpr = new NAryExpr(Token.NoToken, new FunctionCall(function), exprs);
      impl.Proc.Ensures.Add(new Ensures(Token.NoToken, true, freePostExpr, "", new QKeyValue(Token.NoToken, "si_fcall", new List<object>(), null)));

      initialized = false;
    }

    public void GenerateVCBoolControl()
    {
        Debug.Assert(!initialized);
        Debug.Assert(CommandLineOptions.Clo.SIBoolControlVC);

        // fix names for exit variables
        var outputVariables = new List<Variable>();
        var assertConjuncts = new List<Expr>();
        foreach (Variable v in impl.OutParams)
        {
            Constant c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, impl.Name + "_" + v.Name, v.TypedIdent.Type));
            outputVariables.Add(c);
            Expr eqExpr = Expr.Eq(new IdentifierExpr(Token.NoToken, c), new IdentifierExpr(Token.NoToken, v));
            assertConjuncts.Add(eqExpr);
        }
        foreach (IdentifierExpr e in impl.Proc.Modifies)
        {
            if (e.Decl == null) continue;
            Variable v = e.Decl;
            Constant c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, impl.Name + "_" + v.Name, v.TypedIdent.Type));
            outputVariables.Add(c);
            Expr eqExpr = Expr.Eq(new IdentifierExpr(Token.NoToken, c), new IdentifierExpr(Token.NoToken, v));
            assertConjuncts.Add(eqExpr);
        }
        exitAssertCmd = new AssumeCmd(Token.NoToken, Expr.BinaryTreeAnd(assertConjuncts));
        (exitAssertCmd as AssumeCmd).Attributes = new QKeyValue(Token.NoToken, "exitAssert", new List<object>(), null);

        // no need for label2absy
        label2absy = new Dictionary<int, Absy>();

        // Passify
        Program program = vcgen.program;
        ProverInterface proverInterface = vcgen.prover;
        vcgen.ConvertCFG2DAG(impl);
        vcgen.PassifyImpl(impl, out mvInfo);

        VCExpressionGenerator gen = proverInterface.VCExprGen;
        var exprGen = proverInterface.Context.ExprGen;
        var translator = proverInterface.Context.BoogieExprTranslator;

        // add a boolean variable at each call site
        vcgen.InstrumentCallSites(impl);

        // typecheck
        var tc = new TypecheckingContext(null);
        impl.Typecheck(tc);

        ///////////////////
        // Generate the VC
        ///////////////////

        // block -> bool variable
        blockToControlVar = new Dictionary<Block, VCExprVar>();
        foreach (var b in impl.Blocks)
            blockToControlVar.Add(b, gen.Variable(b.Label + "_holds", Bpl.Type.Bool));

        vcexpr = VCExpressionGenerator.True;
        foreach (var b in impl.Blocks)
        {
            // conjoin all assume cmds
            VCExpr c = VCExpressionGenerator.True;
            foreach (var cmd in b.Cmds)
            {
                var acmd = cmd as AssumeCmd;
                if (acmd == null)
                {
                    Debug.Assert(cmd is AssertCmd && (cmd as AssertCmd).Expr is LiteralExpr &&
                        ((cmd as AssertCmd).Expr as LiteralExpr).IsTrue);
                    continue;
                }
                var expr = translator.Translate(acmd.Expr);
                // Label the assume if it is a procedure call
                NAryExpr naryExpr = acmd.Expr as NAryExpr;
                if (naryExpr != null && naryExpr.Fun is FunctionCall)
                {
                    var id = acmd.UniqueId;
                    label2absy[id] = acmd;
                    expr = gen.LabelPos(cce.NonNull("si_fcall_" + id.ToString()), expr);
                }

                c = gen.AndSimp(c, expr);
            }          

            // block implies a disjunction of successors
            Debug.Assert(!(b.TransferCmd is ReturnExprCmd), "Not supported");
            var gc = b.TransferCmd as GotoCmd;
            if (gc != null)
            {
                VCExpr succ = VCExpressionGenerator.False;
                foreach (var sb in gc.labelTargets)
                    succ = gen.OrSimp(succ, blockToControlVar[sb]);
                c = gen.AndSimp(c, succ);
            }
            else
            {
                // nothing to do
            }
            vcexpr = gen.AndSimp(vcexpr, gen.Eq(blockToControlVar[b], c));
        }
        // assert start block
        vcexpr = gen.AndSimp(vcexpr, blockToControlVar[impl.Blocks[0]]);

        //Console.WriteLine("VC of {0}: {1}", impl.Name, vcexpr);
        // Collect other information
        callSites = vcgen.CollectCallSites(impl);
        recordProcCallSites = vcgen.CollectRecordProcedureCallSites(impl);

        // record interface variables
        privateExprVars = new List<VCExprVar>();
        foreach (Variable v in impl.LocVars)
        {
            privateExprVars.Add(translator.LookupVariable(v));
        }
        foreach (Variable v in impl.OutParams)
        {
            privateExprVars.Add(translator.LookupVariable(v));
        }
        privateExprVars.AddRange(blockToControlVar.Values);

        interfaceExprVars = new List<VCExprVar>();
        foreach (Variable v in program.GlobalVariables)
        {
            interfaceExprVars.Add(translator.LookupVariable(v));
        }
        foreach (Variable v in impl.InParams)
        {
            interfaceExprVars.Add(translator.LookupVariable(v));
        }
        foreach (Variable v in outputVariables)
        {
            interfaceExprVars.Add(translator.LookupVariable(v));
        }
    }

    public void GenerateVC() {
      if (initialized) return;
      if (CommandLineOptions.Clo.SIBoolControlVC)
      {
          GenerateVCBoolControl();
          initialized = true;
          return;
      }
      List<Variable> outputVariables = new List<Variable>();
      List<Expr> assertConjuncts = new List<Expr>();
      foreach (Variable v in impl.OutParams) {
        Constant c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, impl.Name + "_" + v.Name, v.TypedIdent.Type));
        outputVariables.Add(c);
        Expr eqExpr = Expr.Eq(new IdentifierExpr(Token.NoToken, c), new IdentifierExpr(Token.NoToken, v));
        assertConjuncts.Add(eqExpr);
      }
      foreach (IdentifierExpr e in impl.Proc.Modifies) {
        if (e.Decl == null) continue;
        Variable v = e.Decl;
        Constant c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, impl.Name + "_" + v.Name, v.TypedIdent.Type));
        outputVariables.Add(c);
        Expr eqExpr = Expr.Eq(new IdentifierExpr(Token.NoToken, c), new IdentifierExpr(Token.NoToken, v));
        assertConjuncts.Add(eqExpr);
      }
      exitAssertCmd = new AssertCmd(Token.NoToken, Expr.Not(Expr.BinaryTreeAnd(assertConjuncts)));

      Program program = vcgen.program;
      ProverInterface proverInterface = vcgen.prover;
      vcgen.ConvertCFG2DAG(impl);
      vcgen.PassifyImpl(impl, out mvInfo);

      VCExpressionGenerator gen = proverInterface.VCExprGen;
      var exprGen = proverInterface.Context.ExprGen;
      var translator = proverInterface.Context.BoogieExprTranslator;
      
      VCExpr controlFlowVariableExpr = null;
      if (!CommandLineOptions.Clo.UseLabels) {
        controlFlowVariable = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "@cfc", Microsoft.Boogie.Type.Int));
        controlFlowVariableExpr = translator.LookupVariable(controlFlowVariable);
      }

      vcgen.InstrumentCallSites(impl);

      if (PassiveImplInstrumentation != null)
          PassiveImplInstrumentation(impl);

      label2absy = new Dictionary<int, Absy>();
      VCGen.CodeExprConversionClosure cc = new VCGen.CodeExprConversionClosure(label2absy, proverInterface.Context);
      translator.SetCodeExprConverter(cc.CodeExprToVerificationCondition); 
      vcexpr = gen.Not(vcgen.GenerateVCAux(impl, controlFlowVariableExpr, label2absy, proverInterface.Context));

      if (controlFlowVariableExpr != null)
      {
          VCExpr controlFlowFunctionAppl = exprGen.ControlFlowFunctionApplication(controlFlowVariableExpr, exprGen.Integer(BigNum.ZERO));
          VCExpr eqExpr = exprGen.Eq(controlFlowFunctionAppl, exprGen.Integer(BigNum.FromInt(impl.Blocks[0].UniqueId)));
          vcexpr = exprGen.And(eqExpr, vcexpr);
      }

      callSites = vcgen.CollectCallSites(impl);
      recordProcCallSites = vcgen.CollectRecordProcedureCallSites(impl);

      privateExprVars = new List<VCExprVar>();
      foreach (Variable v in impl.LocVars) {
        privateExprVars.Add(translator.LookupVariable(v));
      }
      foreach (Variable v in impl.OutParams) {
        privateExprVars.Add(translator.LookupVariable(v));
      }

      interfaceExprVars = new List<VCExprVar>();
      foreach (Variable v in program.GlobalVariables) {
        interfaceExprVars.Add(translator.LookupVariable(v));
      }
      foreach (Variable v in impl.InParams) {
        interfaceExprVars.Add(translator.LookupVariable(v));
      }
      foreach (Variable v in outputVariables) {
        interfaceExprVars.Add(translator.LookupVariable(v));
      }

      initialized = true;
    }
  }

  public abstract class StratifiedVCGenBase : VCGen {
    public readonly static string recordProcName = "boogie_si_record";
    public readonly static string callSiteVarAttr = "callSiteVar";
    public Dictionary<string, StratifiedInliningInfo> implName2StratifiedInliningInfo;
    public ProverInterface prover;

		public StratifiedVCGenBase(StratifiedVCGenBase vcGenBase, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers, ProverInterface proverPreAllocated)
			: base(vcGenBase.program, logFilePath, appendLogFile, checkers)
		{
			// In this case, only create a new prover
			this.implName2StratifiedInliningInfo = new Dictionary<string, StratifiedInliningInfo>();
			foreach (string n in vcGenBase.implName2StratifiedInliningInfo.Keys)
				this.implName2StratifiedInliningInfo[n] = vcGenBase.implName2StratifiedInliningInfo[n];
			//this.implName2StratifiedInliningInfo[n] = new StratifiedInliningInfo(vcGenBase.implName2StratifiedInliningInfo[n]);

			if (!RefinementFuzzing.Settings.preAllocateProvers)
				prover = ProverInterface.CreateProver(program, logFilePath, appendLogFile, CommandLineOptions.Clo.ProverKillTime);
			else
			{
				Contract.Assert(proverPreAllocated != null);
				prover = proverPreAllocated;
			}
		}


    public StratifiedVCGenBase(Program program, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers, Action<Implementation> PassiveImplInstrumentation)
      : base(program, logFilePath, appendLogFile, checkers) {
      implName2StratifiedInliningInfo = new Dictionary<string, StratifiedInliningInfo>();
      prover = ProverInterface.CreateProver(program, logFilePath, appendLogFile, CommandLineOptions.Clo.ProverKillTime);
      foreach (var impl in program.Implementations) {
        implName2StratifiedInliningInfo[impl.Name] = new StratifiedInliningInfo(impl, this, PassiveImplInstrumentation);
      }
      GenerateRecordFunctions();
    }

    private void GenerateRecordFunctions() {
      foreach (var proc in program.Procedures) {
        if (!proc.Name.StartsWith(recordProcName)) continue;
        Contract.Assert(proc.InParams.Count == 1);

        // Make a new function
        TypedIdent ti = new TypedIdent(Token.NoToken, "", Bpl.Type.Bool);
        Contract.Assert(ti != null);
        Formal returnVar = new Formal(Token.NoToken, ti, false);
        Contract.Assert(returnVar != null);

        // Get record type
        var argtype = proc.InParams[0].TypedIdent.Type;

        var ins = new List<Variable>();
        ins.Add(new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "x", argtype), true));

        var recordFunc = new Function(Token.NoToken, proc.Name, ins, returnVar);
        prover.Context.DeclareFunction(recordFunc, "");

        var exprs = new List<Expr>();
        exprs.Add(new IdentifierExpr(Token.NoToken, proc.InParams[0]));

        Expr freePostExpr = new NAryExpr(Token.NoToken, new FunctionCall(recordFunc), exprs);
        proc.Ensures.Add(new Ensures(true, freePostExpr));
      }
    }

    public override void Close() {
      prover.Close();
      base.Close();
    }

    public void InstrumentCallSites(Implementation implementation) {
      var callSiteId = 0;
      foreach (Block block in implementation.Blocks) {
        List<Cmd> newCmds = new List<Cmd>();
        for (int i = 0; i < block.Cmds.Count; i++) {
          Cmd cmd = block.Cmds[i];
          newCmds.Add(cmd);
          AssumeCmd assumeCmd = cmd as AssumeCmd;
          if (assumeCmd == null) continue;
          NAryExpr naryExpr = assumeCmd.Expr as NAryExpr;
          if (naryExpr == null) continue;
          if (!implName2StratifiedInliningInfo.ContainsKey(naryExpr.Fun.FunctionName)) continue;
          Variable callSiteVar = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "SICS" + callSiteId, Microsoft.Boogie.Type.Bool));
          implementation.LocVars.Add(callSiteVar);
          var toInsert = new AssumeCmd(Token.NoToken, new IdentifierExpr(Token.NoToken, callSiteVar),
              new QKeyValue(Token.NoToken, callSiteVarAttr, new List<object>(), null));
          newCmds.Add(toInsert);
          callSiteId++;
        }
        block.Cmds = newCmds;
      }
    }

    public Dictionary<Block, List<CallSite>> CollectCallSites(Implementation implementation) {
      var callSites = new Dictionary<Block, List<CallSite>>();
      foreach (Block block in implementation.Blocks) {
        for (int i = 0; i < block.Cmds.Count; i++) {
          Cmd cmd = block.Cmds[i];
          AssumeCmd assumeCmd = cmd as AssumeCmd;
          if (assumeCmd == null) continue;
          NAryExpr naryExpr = assumeCmd.Expr as NAryExpr;
          if (naryExpr == null) continue;
          if (!implName2StratifiedInliningInfo.ContainsKey(naryExpr.Fun.FunctionName)) continue;
          List<VCExpr> interfaceExprs = new List<VCExpr>();
          foreach (Expr e in naryExpr.Args) {
            interfaceExprs.Add(prover.Context.BoogieExprTranslator.Translate(e));
          }
          int instr = i;
          i++;
          AssumeCmd callSiteAssumeCmd = (AssumeCmd)block.Cmds[i];
          IdentifierExpr iexpr = (IdentifierExpr) callSiteAssumeCmd.Expr;
          CallSite cs = new CallSite(naryExpr.Fun.FunctionName, interfaceExprs, prover.Context.BoogieExprTranslator.LookupVariable(iexpr.Decl), block, instr, assumeCmd.Attributes);
          if (!callSites.ContainsKey(block))
            callSites[block] = new List<CallSite>();
          callSites[block].Add(cs);
        }
      }
      return callSites;
    }

    public Dictionary<Block, List<CallSite>> CollectRecordProcedureCallSites(Implementation implementation) {
      var callSites = new Dictionary<Block, List<CallSite>>();
      foreach (Block block in implementation.Blocks) {
        for (int i = 0; i < block.Cmds.Count; i++) {
          AssumeCmd assumeCmd = block.Cmds[i] as AssumeCmd;
          if (assumeCmd == null) continue;
          NAryExpr naryExpr = assumeCmd.Expr as NAryExpr;
          if (naryExpr == null) continue;
          if (!naryExpr.Fun.FunctionName.StartsWith(recordProcName)) continue;
          List<VCExpr> interfaceExprs = new List<VCExpr>();
          foreach (Expr e in naryExpr.Args) {
            interfaceExprs.Add(prover.Context.BoogieExprTranslator.Translate(e));
          }
          CallSite cs = new CallSite(naryExpr.Fun.FunctionName, interfaceExprs, null, block, i, assumeCmd.Attributes);
          if (!callSites.ContainsKey(block))
            callSites[block] = new List<CallSite>();
          callSites[block].Add(cs);
        }
      }
      return callSites;
    }

    private int macroCountForStratifiedInlining = 0;
    public Macro CreateNewMacro() {
      string newName = "SIMacro@" + macroCountForStratifiedInlining.ToString();
      macroCountForStratifiedInlining++;
      return new Macro(Token.NoToken, newName, new List<Variable>(), new Formal(Token.NoToken, new TypedIdent(Token.NoToken, "", Microsoft.Boogie.Type.Bool), false));
    }
    private int varCountForStratifiedInlining = 0;
    public VCExprVar CreateNewVar(Microsoft.Boogie.Type type) {
      string newName = "SIV@" + varCountForStratifiedInlining.ToString();
      varCountForStratifiedInlining++;
      Constant newVar = new Constant(Token.NoToken, new TypedIdent(Token.NoToken, newName, type));
      prover.Context.DeclareConstant(newVar, false, null);
      return prover.VCExprGen.Variable(newVar.Name, type);
    }
    private int idCountForStratifiedInlining = 0;
    public int CreateNewId() {
      return idCountForStratifiedInlining++;
    }

    // Used inside PassifyImpl
    protected override void addExitAssert(string implName, Block exitBlock) {
      if (implName2StratifiedInliningInfo != null && implName2StratifiedInliningInfo.ContainsKey(implName)) {
        var exitAssertCmd = implName2StratifiedInliningInfo[implName].exitAssertCmd;
        if(exitAssertCmd != null) exitBlock.Cmds.Add(exitAssertCmd);
      }
    }

    public override Counterexample extractLoopTrace(Counterexample cex, string mainProcName, Program program, Dictionary<string, Dictionary<string, Block>> extractLoopMappingInfo) {
      // Construct the set of inlined procs in the original program
      var inlinedProcs = new HashSet<string>();
      foreach (var decl in program.TopLevelDeclarations) {
        // Implementations
        if (decl is Implementation) {
          var impl = decl as Implementation;
          if (!(impl.Proc is LoopProcedure)) {
            inlinedProcs.Add(impl.Name);
          }
        }

        // And recording procedures
        if (decl is Procedure) {
          var proc = decl as Procedure;
          if (proc.Name.StartsWith(recordProcName)) {
            Debug.Assert(!(decl is LoopProcedure));
            inlinedProcs.Add(proc.Name);
          }
        }
      }

      return extractLoopTraceRec(
          new CalleeCounterexampleInfo(cex, new List<object>()),
          mainProcName, inlinedProcs, extractLoopMappingInfo).counterexample;
    }

    protected override bool elIsLoop(string procname) {
      StratifiedInliningInfo info = null;
      if (implName2StratifiedInliningInfo.ContainsKey(procname)) {
        info = implName2StratifiedInliningInfo[procname];
      }

      if (info == null) return false;

      var lp = info.impl.Proc as LoopProcedure;

      if (lp == null) return false;
      return true;
    }

    public abstract Outcome FindLeastToVerify(Implementation impl, ref HashSet<string> allBoolVars);
  }

  public class StratifiedVCGen : StratifiedVCGenBase {
    public bool PersistCallTree;
    public static HashSet<string> callTree = null;
    public int numInlined = 0;
    public int vcsize = 0;
    private HashSet<string> procsThatReachedRecBound;
    private Dictionary<string, int> extraRecBound;
	private static bool useConcurrentSolver = false;


	public HashSet<string> procsToSkip;

	public StratifiedVCGen(bool usePrevCallTree, HashSet<string> prevCallTree,
			HashSet<string> procsToSkip, Dictionary<string, int> extraRecBound,
			Program program, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers)
			: this(program, logFilePath, appendLogFile, checkers)
	{
			this.procsToSkip = new HashSet<string>(procsToSkip);
			this.extraRecBound = new Dictionary<string, int>(extraRecBound);

			if (usePrevCallTree)
			{
				callTree = prevCallTree;
				PersistCallTree = true;
			}
			else
			{
				PersistCallTree = false;
			}
	}

		public StratifiedVCGen(StratifiedVCGen vcgen, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers, ProverInterface prover)
			: base(vcgen, logFilePath, appendLogFile, checkers, prover)
		{
			PersistCallTree = false;
			procsThatReachedRecBound = new HashSet<string>();
			procsToSkip = new HashSet<string>();
			extraRecBound = new Dictionary<string, int>();

			vcgen.procsThatReachedRecBound.Union(vcgen.procsThatReachedRecBound);
			vcgen.procsToSkip.Union(vcgen.procsToSkip);
			vcgen.extraRecBound.Union(vcgen.extraRecBound);
		}



    public StratifiedVCGen(bool usePrevCallTree, HashSet<string> prevCallTree, 
                           Program program, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers) 
    : this(program, logFilePath, appendLogFile, checkers)
    {          
      if (usePrevCallTree) {
        callTree = prevCallTree;
        PersistCallTree = true;
      }
      else {
        PersistCallTree = false;
      }

			this.procsToSkip = new HashSet<string>(procsToSkip);
			this.extraRecBound = new Dictionary<string, int>(extraRecBound);

    }

    public StratifiedVCGen(Program program, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers)
      : base(program, logFilePath, appendLogFile, checkers, null) {
      PersistCallTree = false;
      procsThatReachedRecBound = new HashSet<string>();

      extraRecBound = new Dictionary<string, int>();
	  procsToSkip = new HashSet<string>();
      program.TopLevelDeclarations.OfType<Implementation>()
          .Iter(impl =>
          {
              var b = QKeyValue.FindIntAttribute(impl.Attributes, "SIextraRecBound", -1);
              if (b != -1) extraRecBound.Add(impl.Name, b);
          });
    }

    // Extra rec bound for procedures
    public int GetExtraRecBound(string procName) {
      if (!extraRecBound.ContainsKey(procName))
        return 0;
      else return extraRecBound[procName];
    }

    public class ApiChecker {
      public ProverInterface prover;
      public ProverInterface.ErrorHandler reporter;

      public ApiChecker(ProverInterface prover, ProverInterface.ErrorHandler reporter) {
        this.reporter = reporter;
        this.prover = prover;
      }

      private Outcome CheckVC() {
        prover.Check();
        ProverInterface.Outcome outcome = prover.CheckOutcomeCore(reporter);

        return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
      }

      public Outcome CheckAssumptions(List<VCExpr> assumptions) {
        if (assumptions.Count == 0) {
          return CheckVC();
        }

        prover.Push();
        foreach (var a in assumptions) {
          prover.Assert(a, true);
        }
        Outcome ret = CheckVC();
        prover.Pop();
        return ret;
      }

      public Outcome CheckAssumptions(List<VCExpr> hardAssumptions, List<VCExpr> softAssumptions) {
        List<int> unsatisfiedSoftAssumptions;
        ProverInterface.Outcome outcome = prover.CheckAssumptions(hardAssumptions, softAssumptions, out unsatisfiedSoftAssumptions, reporter);
        return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
      }

      public Outcome CheckAssumptions(List<VCExpr> assumptions, out List<int> unsatCore) {
        ProverInterface.Outcome outcome = prover.CheckAssumptions(assumptions, out unsatCore, reporter);
        return ConditionGeneration.ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
      }
    }


    class FindLeastOORException : Exception
    {
        public Outcome outcome;

        public FindLeastOORException(string msg, Outcome outcome)
            : base(msg)
        {
            this.outcome = outcome;
        }
    }

    public override Outcome FindLeastToVerify(Implementation impl, ref HashSet<string> allBoolVars) {
      Contract.EnsuresOnThrow<UnexpectedProverOutputException>(true);

      // Record current time
      var startTime = DateTime.UtcNow;

      // No Max: avoids theorem prover restarts
      CommandLineOptions.Clo.MaxProverMemory = 0;

      // Initialize cache
      satQueryCache = new Dictionary<int, List<HashSet<string>>>();
      unsatQueryCache = new Dictionary<int, List<HashSet<string>>>();

      Contract.Assert(implName2StratifiedInliningInfo != null);

      // Build VCs for all procedures
      implName2StratifiedInliningInfo.Values
          .Iter(info => info.GenerateVC());

      // Get the VC of the current procedure
      VCExpr vcMain = implName2StratifiedInliningInfo[impl.Name].vcexpr;
      Dictionary<int, Absy> mainLabel2absy = implName2StratifiedInliningInfo[impl.Name].label2absy;

      // Find all procedure calls in vc and put labels on them      
      FCallHandler calls = new FCallHandler(prover.VCExprGen, implName2StratifiedInliningInfo, impl.Name, mainLabel2absy);
      calls.setCurrProcAsMain();
      vcMain = calls.Mutate(vcMain, true);

      try
      {

          // Put all of the necessary state into one object
          var vState = new VerificationState(vcMain, calls, prover, new EmptyErrorHandler());

          // We'll restore the original state of the theorem prover at the end
          // of this procedure
          vState.checker.prover.Push();

          // Do eager inlining
          while (calls.currCandidates.Count > 0)
          {
              List<int> toExpand = new List<int>();

              foreach (int id in calls.currCandidates)
              {
                  Debug.Assert(calls.getRecursionBound(id) <= 1, "Recursion not supported");
                  toExpand.Add(id);
              }
              DoExpansion(toExpand, vState);
          }

          // Find all the boolean constants
          var allConsts = new HashSet<VCExprVar>();
          foreach (var constant in program.Constants)
          {
              if (!allBoolVars.Contains(constant.Name)) continue;
              var v = prover.Context.BoogieExprTranslator.LookupVariable(constant);
              allConsts.Add(v);
          }

          // Now, lets start the algo
          var min = refinementLoop(vState.checker, new HashSet<VCExprVar>(), allConsts, allConsts);

          var ret = new HashSet<string>();
          foreach (var v in min)
          {
              //Console.WriteLine(v.Name);
              ret.Add(v.Name);
          }
          allBoolVars = ret;

          vState.checker.prover.Pop();

          return Outcome.Correct;
      }
      catch (FindLeastOORException e)
      {
          Console.WriteLine("Exception in FindLeastToVerify: {0}, {1}", e.Message, e.outcome);
          return e.outcome;
      }
    }

    private HashSet<VCExprVar> refinementLoop(ApiChecker apiChecker, HashSet<VCExprVar> trackedVars, HashSet<VCExprVar> trackedVarsUpperBound, HashSet<VCExprVar> allVars) {
      Debug.Assert(trackedVars.IsSubsetOf(trackedVarsUpperBound));

      // If we already know the fate of all vars, then we're done.
      if (trackedVars.Count == trackedVarsUpperBound.Count)
        return new HashSet<VCExprVar>(trackedVars);

      // See if we already have enough variables tracked
      var success = refinementLoopCheckPath(apiChecker, trackedVars, allVars);
      if (success) {
        // We have enough
        return new HashSet<VCExprVar>(trackedVars);
      }

      // If all that remains is 1 variable, then we know that we must track it
      if (trackedVars.Count + 1 == trackedVarsUpperBound.Count)
        return new HashSet<VCExprVar>(trackedVarsUpperBound);

      // Partition the remaining set of variables
      HashSet<VCExprVar> part1, part2;
      var temp = new HashSet<VCExprVar>(trackedVarsUpperBound);
      temp.ExceptWith(trackedVars);
      Partition<VCExprVar>(temp, out part1, out part2);

      // First half
      var fh = new HashSet<VCExprVar>(trackedVars); fh.UnionWith(part2);
      var s1 = refinementLoop(apiChecker, fh, trackedVarsUpperBound, allVars);

      var a = new HashSet<VCExprVar>(part1); a.IntersectWith(s1);
      var b = new HashSet<VCExprVar>(part1); b.ExceptWith(s1);
      var c = new HashSet<VCExprVar>(trackedVarsUpperBound); c.ExceptWith(b);
      a.UnionWith(trackedVars);

      // Second half
      return refinementLoop(apiChecker, a, c, allVars);
    }

    Dictionary<int, List<HashSet<string>>> satQueryCache;
    Dictionary<int, List<HashSet<string>>> unsatQueryCache;

    private bool refinementLoopCheckPath(ApiChecker apiChecker, HashSet<VCExprVar> varsToSet, HashSet<VCExprVar> allVars) {
      var assumptions = new List<VCExpr>();
      var prover = apiChecker.prover;
      var query = new HashSet<string>();
      varsToSet.Iter(v => query.Add(v.Name));

      if (checkCache(query, unsatQueryCache)) {
        prover.LogComment("FindLeast: Query Cache Hit");
        return true;
      }
      if (checkCache(query, satQueryCache)) {
        prover.LogComment("FindLeast: Query Cache Hit");
        return false;
      }

      prover.LogComment("FindLeast: Query Begin");

      foreach (var c in allVars) {
        if (varsToSet.Contains(c)) {
          assumptions.Add(c);
        }
        else {
          assumptions.Add(prover.VCExprGen.Not(c));
        }
      }

      var o = apiChecker.CheckAssumptions(assumptions);
      if (o != Outcome.Correct && o != Outcome.Errors)
      {
          throw new FindLeastOORException("OOR", o);
      }
      //Console.WriteLine("Result = " + o.ToString());
      prover.LogComment("FindLeast: Query End");

      if (o == Outcome.Correct) {
        insertCache(query, unsatQueryCache);
        return true;
      }

      insertCache(query, satQueryCache);
      return false;
    }

    private bool checkCache(HashSet<string> q, Dictionary<int, List<HashSet<string>>> cache) {
      if (!cache.ContainsKey(q.Count)) return false;
      foreach (var s in cache[q.Count]) {
        if (q.SetEquals(s)) return true;
      }
      return false;
    }

    private void insertCache(HashSet<string> q, Dictionary<int, List<HashSet<string>>> cache) {
      if (!cache.ContainsKey(q.Count)) {
        cache.Add(q.Count, new List<HashSet<string>>());
      }
      cache[q.Count].Add(q);
    }

    public static void Partition<T>(HashSet<T> values, out HashSet<T> part1, out HashSet<T> part2) {
      part1 = new HashSet<T>();
      part2 = new HashSet<T>();
      var size = values.Count;
      var crossed = false;
      var curr = 0;
      foreach (var s in values) {
        if (crossed) part2.Add(s);
        else part1.Add(s);
        curr++;
        if (!crossed && curr >= size / 2) crossed = true;
      }
    }

	public override Outcome VerifyImplementation(Implementation/*!*/ impl, VerifierCallback/*!*/ callback) {
		Debug.Assert(QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));

			if (false) // TODO: Read from command-line argument
				return VerifyImplementationSI(impl, callback);
			else
				return VerifyImplementationConcurrent(impl, callback);
				
	}


		public ProverStackBookkeeping proverStackBookkeeper;

		//public enum VerifyResult { Verified, Partitioned, BugFound, Errors, NoMoreConstraintPartition, Interrupted };

		public double timeTaken = 0;
		public int numCalls = 0;
		public int threadsSpawned = 0;

		/*
		 * TODO: This is the PRIMARY method. Needs to be merged with the new code in "verifyImplementationSI()"
		 */
		public VerifyResult SolvePartition(SoftPartition softPartition,
			VerificationState vState, out List<SoftPartition> partitions, out double solTime, ProverStackBookkeeping bookKeeper = null, HashSet<SoftPartition> siblingRunningPartitions = null, int maxPartitions = -1)
		{

			//lock (softPartition)
			{
				RefinementFuzzing.Settings.WritePrimaryLog(proverStackBookkeeper.id, softPartition.Id, "SolvePartition", "Entered");

				//int bound = CommandLineOptions.Clo.NonUniformUnfolding ? CommandLineOptions.Clo.RecursionBound : 1;
				int bound = CommandLineOptions.Clo.RecursionBound;

				int done = 0;

				int iters = 0;

				int state = 0;

				var computeUnderBound = true;

				FCallHandler calls = vState.calls;

				List<HashSet<int>> candidatesInCounterexamples = new List<HashSet<int>>();

				if (siblingRunningPartitions != null && siblingRunningPartitions.Count > 0)
				{
					siblingRunningPartitions.Iter<SoftPartition>(n => candidatesInCounterexamples.Add(new HashSet<int>(n.lastInlined)));
				}

				// Record current time
				var startTime = DateTime.UtcNow;
				numCalls++;

				Outcome ret = Outcome.ReachedBound;

				StratifiedInliningErrorReporter reporter = vState.checker.reporter as StratifiedInliningErrorReporter;

				partitions = new List<SoftPartition>();
				VerifyResult retval = VerifyResult.Errors;

				Random rand = new Random();

				// for blocking candidates (and focusing on a counterexample)
				var block = new HashSet<int>();

				uint total_cex_size = 0;
				uint num_cex = 0;

				VCExpr coveredCEXs = VCExpressionGenerator.True;

				// Start with an empty block in optimized case

				if (!RefinementFuzzing.Settings.useOptimizedProverStack)
					softPartition.blockedCandidates.Iter<int>(n => block.Add(n));

				reporter.currSoftPartition = softPartition;

				Contract.Assert(vState.checker.prover == proverStackBookkeeper.getMainProver());
				//Contract.Assert(vState.summaryDB.prover5 == proverStackBookkeeper.getInterpolatingProver());

				if (bookKeeper != null && bookKeeper != proverStackBookkeeper)
				{
					// This is flaky --- a better solution would have been to not use these aliases at all
					proverStackBookkeeper = bookKeeper;
					vState.checker.prover = proverStackBookkeeper.getMainProver();
					//vState.summaryDB.prover5 = proverStackBookkeeper.getInterpolatingProver();
					//Contract.Assert(false);
				}

				//lock (RefinementFuzzing.Settings.lockThis)  [removed on 15th Sept]
				{
					if (RefinementFuzzing.Settings.useOptimizedProverStack)
					{
						// assert VC
						if (proverStackBookkeeper.getProverStackStatus().Count == 0 && softPartition.prefixVC != null)
						{
							//AssertTraceVC(softPartition, vState, prover, proverStackBookkeeper);
							//proverStackBookkeeper.isTraceProver = true;
						}
						else
						{
							OptimizedAssertVC(softPartition, vState, prover, proverStackBookkeeper);
							//proverStackBookkeeper.isTraceProver = false;

							if (RefinementFuzzing.Settings.instantlyPropagateSummaries)
							{
								// In this case, summaries are not pushed with the VCs; each candidate summary is pushed separately
								// 
								//if (softPartition.Id != 0)
								{
									// main does not have summaries

									//proverStackBookkeeper.metaStack.Sync(vState);   // updates summaries -- sync the summarydb with the proverstack

									// add the candidate summaries (if any)
									/*
									foreach (int n in softPartition.activeCandidates)
									{
										lock (RefinementFuzzing.Settings.lockThis)
										{
											VCExpr candidateSummary = vState.summaryDB.get(n, SummaryDB.SummaryType.CANDIDATE_SUMMARY);

											if (candidateSummary != null)
											{
												if (proverStackBookkeeper.metaStack.Top().candidateSummaries.ContainsKey(n) &&
													proverStackBookkeeper.metaStack.Top().candidateSummaries[n] == vState.summaryDB.hasCandidateSummaryVersion(n))
													continue;
												proverStackBookkeeper.Assert(candidateSummary, StratifiedVCGen.getNameForFormula(n, StratifiedVCGen.FormulaType.CandidateSummary, vState.summaryDB.hasCandidateSummaryVersion(n)), "SummaryCandidate: " + n + "v" + vState.summaryDB.hasCandidateSummaryVersion(n));
												proverStackBookkeeper.metaStack.Top().candidateSummaries[n] = vState.summaryDB.hasCandidateSummaryVersion(n);
											}
										}
									}
									*/
									// push summaries for new candidates
									//OptimizedAssertSummaries(softPartition.activeCandidates, vState, proverStackBookkeeper);

									// push summaries for stale candidates
									//OptimizedAssertSummaries(staleAndNewCandidates, vState, proverStackBookkeeper);
								}
							}
						}
					}
					else
					{
						//lock (RefinementFuzzing.Settings.lockThis) [removed on 15th Sept]
						{
							// create VC
							VCExpr vc = CreateVC(softPartition, vState);
							prover.Push();
							prover.Assert(vc, true);
						}

					}
				}

				if (RefinementFuzzing.Settings.useConcurrentSummaryDB && RefinementFuzzing.Settings.summaryLog != null)
				{
					string nl = "";
					if (RefinementFuzzing.Settings.summaryLogHTML)
					{
						nl = "<br>";
					}

					//SummaryDB.summaryLogFile.WriteLine("---------------------------------------------" + nl);
					//SummaryDB.summaryLogFile.WriteLine("Partition: " + softPartition.Id + nl);
				}



				//lock (RefinementFuzzing.Settings.lockThis) 
				{

					HashSet<int> candidatesThatReachRecBound;

					if (RefinementFuzzing.Settings.noInterpolationOnMainProver || RefinementFuzzing.Settings.lazySummaries)
					{
						prover.Push();
						VCExpr blocked = VCExpressionGenerator.True;
						foreach (int id in softPartition.blockedCandidates)
						{
							blocked = prover.VCExprGen.AndSimp(blocked, calls.getFalseExpr(id));
						}
						prover.Assert(blocked, true);
					}

					//List<SoftPartition> newPartitionList = new List<SoftPartition>();

					// Process tasks while not done. We're done when:
					//   case 1: (correct) We didn't find a bug (either an over-approx query was valid
					//                     or we reached the recursion bound) and the task is "step"
					//   case 2: (bug)     We find a bug
					//   case 3: (internal error)   The theorem prover TimesOut of runs OutOfMemory
					while (true) // this while loop creates the partitions
					{
						// Check timeout
						if (CommandLineOptions.Clo.ProverKillTime != -1)
						{
							if ((DateTime.UtcNow - startTime).TotalSeconds > CommandLineOptions.Clo.ProverKillTime)
							{
								ret = Outcome.TimedOut;
								break;
							}
						}

						if (done > 0)
						{
							break;
						}

						//HashSet<int> partitionableSet = new HashSet<int>();
						// softPartition.activeCandidates.Iter<int>(n => partitionableSet.Add(n));
						// Stratified Step
						//lock (RefinementFuzzing.Settings.lockThis)   [removed on 15th Sept]
						{
							//Contract.Assert(vState.checker.prover == proverStackBookkeeper.getMainProver());
							//if (vState.checker.prover != proverStackBookkeeper.getMainProver())
							//    Contract.Assert(false);


							if (vState.checker.prover != proverStackBookkeeper.getMainProver())
								Contract.Assert(false);

							uint avg_cex_size = (num_cex > 0) ? total_cex_size / num_cex : 0;
							Console.WriteLine("CEX avg size: " + avg_cex_size);

							RefinementFuzzing.Settings.WritePrimaryLog(proverStackBookkeeper.id, softPartition.Id, "SolvePartition", "Calling stratifiedStep with stack " + proverStackBookkeeper.printStack());

							int tokenId = 0;

							if (num_cex < RefinementFuzzing.Settings.SoftPartitionBound)
							{
								tokenId = proverStackBookkeeper.timingStatisticsManager.StartTime(TimingStatisticManager.TimingCategories.Z3Time);
								Settings.oTimer.StartTime(OverlappingTimingStatisticManager.TimingCategories.TotalProverTime, proverStackBookkeeper.id);
							}

							reporter.vcCache = null; // The trace prefix VC is returned in this


							/***************** The Solving Step *********************/
							ret = stratifiedStep1(bound, vState, block, out candidatesThatReachRecBound, softPartition.activeCandidates, candidatesInCounterexamples, avg_cex_size, coveredCEXs);
							/********************************************************/

							if (num_cex < RefinementFuzzing.Settings.SoftPartitionBound)
							{
								proverStackBookkeeper.timingStatisticsManager.StopTime(tokenId, TimingStatisticManager.TimingCategories.Z3Time);
								Settings.oTimer.StopTime(OverlappingTimingStatisticManager.TimingCategories.TotalProverTime, proverStackBookkeeper.id);
							}
						}
						iters++;

						#region print stuff
						if (Settings.__MYCHANGES__ && false)
						{

							RF.writer.WriteLine("------------------------------- Next Round --------------------------");
							RF.writer.AutoFlush = true;
							foreach (int id in calls.id2Candidate.Keys)
							{
								RF.writer.WriteLine("Id: " + id);
								RF.writer.WriteLine("Name: " + calls.getProc(id));

								VCExpr vcForId;
								VCExprVar cvarForId;
								Dictionary<VCExprVar, VCExpr> vars;
								int parent;
								int callId;
								calls.id2VC.TryGetValue(id, out vcForId);
								calls.id2ControlVar.TryGetValue(id, out cvarForId);
								calls.id2Vars.TryGetValue(id, out vars);
								calls.candidateParent.TryGetValue(id, out parent);
								calls.candidate2callId.TryGetValue(id, out callId);

								RF.writer.WriteLine("vcForId: " + vcForId);
								RF.writer.WriteLine("cvarForId: " + cvarForId);
								RF.writer.WriteLine("vars: ");

								if (vars != null)
									foreach (VCExprVar var in vars.Keys)
									{
										VCExpr vexp;
										vars.TryGetValue(var, out vexp);
										RF.writer.WriteLine("\t " + vexp);
									}

								RF.writer.WriteLine("parent: " + parent);
								RF.writer.WriteLine("callId: " + callId);
								RF.writer.WriteLine();

								//Console.ReadKey();

							}
						}
						#endregion


						// Sorry, out of luck (time/memory)
						if (ret == Outcome.Inconclusive || ret == Outcome.OutOfMemory || ret == Outcome.TimedOut)
						{
							RefinementFuzzing.Settings.error_msg = "ProverId: " + proverStackBookkeeper.id + " " + ((ret == Outcome.Inconclusive) ? "Inconclusive" : (ret == Outcome.OutOfMemory ? "OutOfMemory" : "TimeOut"));
							timeTaken += (DateTime.UtcNow - startTime).TotalSeconds;
							solTime = (DateTime.UtcNow - startTime).TotalSeconds;
							return VerifyResult.Errors;
							//done = 3;
							//continue;
						}

						if (ret == Outcome.Errors && reporter.underapproximationMode)
						{
							timeTaken += (DateTime.UtcNow - startTime).TotalSeconds;
							solTime = (DateTime.UtcNow - startTime).TotalSeconds;
							return VerifyResult.BugFound;
							// Found a bug
							//done = 2;
						}
						else if (ret == Outcome.Correct)
						{
							// Compute Interpolant as summary -- no new partition created

							if (partitions.Count() > 0)
								retval = VerifyResult.Partitioned;
							else if (siblingRunningPartitions != null && siblingRunningPartitions.Count > 0)
							{
								// we could not find a counterexample with the constraints on the siblings
								retval = VerifyResult.NoMoreConstraintPartition;
							}
							else
							{

								retval = VerifyResult.Verified;

								HashSet<int> candidatesInUnsatCore = null;
								/*
								if (RefinementFuzzing.Settings.reduceInterpolationUsingUnsatCore)
								{
									List<string> unsatCore = prover.GetUnsatCore(); // use the interpolating prover as it has names of formulae

									// for debugging
									unsatCore.Iter<string>(n => Console.WriteLine(n));

									candidatesInUnsatCore = new HashSet<int>();
									foreach (string name in unsatCore)
									{
										StratifiedVCGen.FormulaType ftype;

										if (name.StartsWith("candidate_vc_neg"))
											Contract.Assert(false);

										if (!name.StartsWith("candidate_vc_"))
											continue;

										int id = SummaryDB.getIdFromFormulaName(name, out ftype);

										if (ftype == FormulaType.VC)
										{
											candidatesInUnsatCore.Add(id);
										}
									}
									Contract.Assert(unsatCore != null);
									Console.WriteLine("");
								}

								if (RefinementFuzzing.Settings.lazyLazySummaries)
								{
									proverStackBookkeeper.pendingInterpolation = softPartition;
									proverStackBookkeeper.deferredPartitions.Add(softPartition.Id);
									proverStackBookkeeper.candidatesInUnsatCore = candidatesInUnsatCore;
								}
								else
									RecordSummaries(softPartition, vState, candidatesInUnsatCore, calls, candidatesThatReachRecBound, block);
									*/
							}
							break;
						}
						else if (ret == Outcome.ReachedBound)
						{
							if (useConcurrentSolver)
							{
								if (partitions.Count() > 0)
								{
									retval = VerifyResult.Partitioned;
									RefinementFuzzing.Settings.reachedRecursionBound = true;
									break;
								}

								//Contract.Assert(false); // unreachable
								//Contract.Assert(useConcurrentSolver);

								// Try to see if the interpolant from the underapprox is an invariant

								//List<HoudiniPacket> checkWithHoudini = new List<HoudiniPacket>();

								/*
								lock (RefinementFuzzing.Settings.lockThis)
								{
									foreach (string procName in implName2StratifiedInliningInfo.Keys)
									{
										if (interfaceMaps.isRecorded(procName))
											continue;

										Procedure proc = implName2StratifiedInliningInfo[procName].impl.Proc;
										List<VCExprVar> vcexprList = implName2StratifiedInliningInfo[proc.Name].interfaceExprVars;
										interfaceMaps.recordForImplementation(proc, vcexprList);
									}

									HoudiniPacket.houdini_vcgen = prover.VCExprGen;
									HoudiniPacket.interfaceMaps = interfaceMaps;
								}
								*/
								/*
								if (!RefinementFuzzing.Settings.noInterpolationOnMainProver)
								{
									if (RefinementFuzzing.Settings.useOptimizedProverStack)
									{
										List<Tuple<int, VCExpr, SummaryDB.SummaryApprox>> summaryDict = vState.summaryDB.computeAllSummaries(softPartition, candidatesThatReachRecBound, this, vState, proverStackBookkeeper, null);

										bool trueSummaryPresent = false;
										int anyOneId = -1;
										foreach (Tuple<int, VCExpr, SummaryDB.SummaryApprox> summaryTuple in summaryDict)
										{
											int id = summaryTuple.Item1;

											VCExpr summary = summaryTuple.Item2;
											SummaryDB.SummaryApprox summaryApprox = summaryTuple.Item3;

											if (summary == null)
											{
												Helpers.ExtraTraceInformation("Summary generation failed. Aborting!");
												Console.WriteLine("{0}, {1}", RefinementFuzzing.Settings.vc_set.Count, RefinementFuzzing.Settings.interpolant_set.Count);
												if (RefinementFuzzing.Settings.consoleRun)
													Console.ReadLine();
												System.Environment.Exit(-1);
											}
											else if (summary == VCExpressionGenerator.True)
											{
												trueSummaryPresent = true;
												anyOneId = id;
											}
											else if (summaryApprox == SummaryDB.SummaryApprox.OverApprox)
												vState.summaryDB.record(id, summary, SummaryDB.SummaryApprox.OverApprox);
											else if (summaryApprox == SummaryDB.SummaryApprox.UnderApprox)
											{
												VCExpr abstractSummary = vState.summaryDB.mutateSummary(id, summary, SummaryDB.SummaryMutation.ABSTRACTION);
												//Expr abstractExpr = VCExprToExpr(abstractSummary, new Dictionary<VCExpr, Expr>());

												// pend it to be checked with Houdini
												checkWithHoudini.Add(new HoudiniPacket(id, calls.getProc(id), summary, abstractSummary));
											}
											else
												Contract.Assert(false);
										}

										if (trueSummaryPresent)
										{
											if (RefinementFuzzing.Settings.addInfeasibilityConstraints)
												vState.summaryDB.recordConstraint(anyOneId, softPartition, vState);
										}
									}
									else
									{
										foreach (int id in softPartition.lastInlined)
										{
											if (id == 0)
												continue;  // main() has no summaries

											VCExpr summary;
											SummaryDB.SummaryApprox summaryApprox = vState.summaryDB.computeSummary(id,
												softPartition.candidateUniverse,
												softPartition.activeCandidates,
												calls, block, candidatesThatReachRecBound, softPartition.lastInlined, out summary);

											if (summary == null)
											{
												Helpers.ExtraTraceInformation("Summary generation failed. Aborting!");
												Console.WriteLine("{0}, {1}", RefinementFuzzing.Settings.vc_set.Count, RefinementFuzzing.Settings.interpolant_set.Count);
												if (RefinementFuzzing.Settings.consoleRun)
													Console.ReadLine();
												System.Environment.Exit(-1);
											}
											else if (summaryApprox == SummaryDB.SummaryApprox.OverApprox)
												vState.summaryDB.record(id, summary, SummaryDB.SummaryApprox.OverApprox);
											else if (summaryApprox == SummaryDB.SummaryApprox.UnderApprox)
											{
												VCExpr abstractSummary = vState.summaryDB.mutateSummary(id, summary, SummaryDB.SummaryMutation.ABSTRACTION);
												//Expr abstractExpr = VCExprToExpr(abstractSummary, new Dictionary<VCExpr, Expr>());

												// pend it to be checked with Houdini
												checkWithHoudini.Add(new HoudiniPacket(id, calls.getProc(id), summary, abstractSummary));
											}
											else
												Contract.Assert(false);
										}
									}
								}

								// Call Houdini to verify the assertions
								if (RefinementFuzzing.Settings.UseHoudini)
								{
									int numCorrect = RefinementFuzzing.Settings.RunHoudini(new Tuple<object, List<HoudiniPacket>>(RefinementFuzzing.Settings.HoudiniInstance, checkWithHoudini));

									foreach (HoudiniPacket houdiniPack in checkWithHoudini)
									{
										bool houdiniResponseTrue = houdiniPack.resultFromHoudini; // TODO: if hooudini response is positive, use it as an overapprox summary (generalized proc summary) else use it as an underapprox summary (specialized candidate summary)

										if (houdiniResponseTrue)
											vState.summaryDB.record(houdiniPack.candidateId, houdiniPack.abstractSummary, SummaryDB.SummaryApprox.OverApprox);
										else
										{
											vState.summaryDB.record(houdiniPack.candidateId, houdiniPack.concreteSummary, SummaryDB.SummaryApprox.UnderApprox);
											RefinementFuzzing.Settings.reachedRecursionBound = true;
										}
									}
								}
								else
								{
									foreach (HoudiniPacket houdiniPack in checkWithHoudini)
									{
										vState.summaryDB.record(houdiniPack.candidateId, houdiniPack.concreteSummary, SummaryDB.SummaryApprox.UnderApprox);
									}

									RefinementFuzzing.Settings.reachedRecursionBound = true;
								}
								*/
								// verified under bound
								retval = VerifyResult.Verified;

								break;
							}
							else
							{
								Contract.Assert(false); // unreachable
							}
						}
						else
						{
							// Do inlining
							Debug.Assert(ret == Outcome.Errors && !reporter.underapproximationMode);
							Contract.Assert(reporter.candidatesToExpand.Count != 0);

							/*
							if (RefinementFuzzing.Settings.lazyLazySummaries && proverStackBookkeeper.pendingInterpolation != null)
							{
								RecordSummaries(proverStackBookkeeper.pendingInterpolation, vState, proverStackBookkeeper.candidatesInUnsatCore, calls, candidatesThatReachRecBound, null);
								proverStackBookkeeper.pendingInterpolation = null;
								proverStackBookkeeper.deferredPartitions.Clear();
							}
							*/

							#region expand call tree

							if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
							{
								Console.Write(">> SI Inlining: ");
								reporter.candidatesToExpand
									.Select(c => calls.getProc(c))
									.Iter(c => { if (!isSkipped(c)) Console.Write("{0} ", c); });

								Console.WriteLine();
								Console.Write(">> SI Skipping: ");
								reporter.candidatesToExpand
									.Select(c => calls.getProc(c))
									.Iter(c => { if (isSkipped(c)) Console.Write("{0} ", c); });

								Console.WriteLine();
							}

							HashSet<int> oldCurrCandidates = new HashSet<int>();
							calls.currCandidates.Iter<int>(n => oldCurrCandidates.Add(n));
							//softPartition.activeCandidates.Iter<int>(n => oldCurrCandidates.Add(n));
							//HashSet<int> oldCurrCandidates = softPartition.activeCandidates;

							//HashSet<int> currCandidates = new HashSet<int>();
							//softPartition.activeCandidates.Iter<int>(n => currCandidates.Add(n));
							//calls.currCandidates.Iter<int>(n => currCandidates.Add(n));

							// Expand and try again
							vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion begin ;;;;;;;;;;");
							//List<int> candidatesToExpand = new List<int>();
							//newPartition.activeCandidates.Iter<int>(n => candidatesToExpand.Add(n));
							//lock (RefinementFuzzing.Settings.lockThis)  [removed on 15th Sept]
							{
								DoExpansion(reporter.candidatesToExpand, vState);
							}
							vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion end ;;;;;;;;;;");

							#endregion

							// The active set is the "new" candidates now produced in calls.currCandidates
							// The blocked set is all the ones that remained (i.e. were not on the path of the error, and so were not inlined)

							/*
                             * softPartition.activeCandidates are the set of all possible candidates to do our partition.
                             * reporter.candidatesToExpand returns the candidates that are on the cex trace and are expanded.
                             * What remains in softPartition.activeCandidates other than reporter.candidatesToExpand are
                             * the candidates that were not on the cex trace and were not expanded -- this is computed 
                             * in the set nonInlinedCurrCandidates. This is exactly the set that should be blocked off
                             * this partition.
                             */
							// the new candidates are the children of the last inlined candidates
							HashSet<int> newCurrCandidates = new HashSet<int>();
							foreach (int id in reporter.candidatesToExpand)
							{
								calls.candidateChildren[id].Iter<int>(n => newCurrCandidates.Add(n));
							}


							HashSet<int> nonInlinedCurrCandidates = new HashSet<int>();
							//                    calls.currCandidates.Iter<int>(n => { if (!oldCurrCandidates.Contains(n)) newCurrCandidates.Add(n); else staleCurrCandidates.Add(n); });
							softPartition.activeCandidates.Iter<int>(n => { if (!reporter.candidatesToExpand.Contains(n) && !candidatesThatReachRecBound.Contains(n)) nonInlinedCurrCandidates.Add(n); });

							// also block the onces that were already blocked
							block.Iter<int>(n => nonInlinedCurrCandidates.Add(n));

							if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.DisjointModuleSummaries)
							{
								;
							}
							else if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.SoftBlocking)
							{
								HashSet<int> allCexCandidates = new HashSet<int>();
								candidatesInCounterexamples.Iter<HashSet<int>>(n => allCexCandidates.UnionWith(n));
								foreach (int c in allCexCandidates)
								{
									if (!reporter.candidatesToExpand.Contains(c) && !candidatesThatReachRecBound.Contains(c))
										nonInlinedCurrCandidates.Add(c);
								}

								total_cex_size += (uint)reporter.candidatesToExpand.Count;

							}
							else if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.EnumerateAll)
							{
								VCExpr v = VCExpressionGenerator.False;
								reporter.candidatesToExpand.Iter<int>(n => v = prover.VCExprGen.OrSimp(v, calls.getFalseExpr(n)));
								coveredCEXs = prover.VCExprGen.AndSimp(coveredCEXs, v);
							}
							else
								Contract.Assert(false);

							num_cex++;

							SoftPartition newPartition = new SoftPartition(softPartition, newCurrCandidates, nonInlinedCurrCandidates, reporter.candidatesToExpand, candidatesThatReachRecBound, reporter.vcCache);
							reporter.vcCache = null;
							candidatesThatReachRecBound.Clear();
							partitions.Add(newPartition);

							/*
                             * Note: A list with no activeCandidates means that it has no more function calls within it;
                             * note that it does not imply that the partition is verified (the intraprocedural paths still need
                             * to be verified).
                             */

							// block all the candidates expanded
							//reporter.candidatesToExpand.Iter<int>(n => block.Add(n));
							//reporter.candidatesToExpand.Iter<int>(n => candidatesInCounterexamples.Add(n));
							candidatesInCounterexamples.Add(new HashSet<int>(reporter.candidatesToExpand));

							//newPartitionList.Add(newPartition);

							if (Settings.traversalStyle == Settings.TraversalStyle.DepthFirst)
							{
								retval = VerifyResult.Partitioned;
								break;      // probe into this new partition lower level partition instead of creating new partitions
							}
							else if (Settings.traversalStyle == Settings.TraversalStyle.DefaultBreadthFirst)
							{
								// Don't create more partitions if you don't have the budget
								int min = Settings.SoftPartitionBound < vState.threadBudget ? Settings.SoftPartitionBound : vState.threadBudget;
								//if (partitions.Count >= Settings.SoftPartitionBound)
								if (partitions.Count >= min)
								{
									retval = VerifyResult.Partitioned;
									break;
								}

								if (maxPartitions != -1 && partitions.Count >= maxPartitions)
								{
									retval = VerifyResult.Partitioned;
									break;
								}
							}
							else if (Settings.traversalStyle == Settings.TraversalStyle.RandomizedDepthFirst)
							{
								if (partitions.Count >= Settings.enumerationBound)
								{
									retval = VerifyResult.Partitioned;
									break;
								}
							}
							else if (Settings.traversalStyle == Settings.TraversalStyle.CostBasedSelection)
							{
								if (partitions.Count >= Settings.enumerationBound)
								{
									retval = VerifyResult.Partitioned;
									break;
								}
							}
							else
								Contract.Assert(false);
						}
					}

					if (RefinementFuzzing.Settings.noInterpolationOnMainProver || RefinementFuzzing.Settings.lazySummaries)
					{
						prover.Pop();
					}

					if (RefinementFuzzing.Settings.useOptimizedProverStack)
					{
						//int top = proverStackBookkeeper.Pop(); // Pop the non-inlined candidates VC
						//Contract.Assert(top == -1);
					}
					else
					{
						prover.Pop();
					}

					solTime = (DateTime.UtcNow - startTime).TotalSeconds;

					timeTaken += solTime;

					if (RefinementFuzzing.Settings.constructExplorationGraph)
					{
						softPartition.graphNode.solutionTime.Enqueue((int)Math.Round(solTime));
					}

					string msg = "";
					if (retval == VerifyResult.Verified)
					{
						msg += "verified";
					}
					else if (retval == VerifyResult.Partitioned)
					{
						msg += "partitioned (";
						foreach (SoftPartition s in partitions)
						{
							msg += s.Id + ",";
						}
						msg += ")";
					}
					else if (retval == VerifyResult.BugFound)
					{
						msg += "bug found";
					}

					if (partitions.Count > 3)
						Console.Write("");

					RefinementFuzzing.Settings.WritePrimaryLog(proverStackBookkeeper.id, softPartition.Id, "SolvePartition", "Returning with " + msg);

					return retval;

					Contract.Assert(false);  // unreachable
					return VerifyResult.Errors;


					#region expand call tree

					foreach (SoftPartition sp in partitions)
					{
						if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
						{
							Console.Write(">> SI Inlining: ");
							reporter.candidatesToExpand
								.Select(c => calls.getProc(c))
								.Iter(c => { if (!isSkipped(c)) Console.Write("{0} ", c); });

							Console.WriteLine();
							Console.Write(">> SI Skipping: ");
							reporter.candidatesToExpand
								.Select(c => calls.getProc(c))
								.Iter(c => { if (isSkipped(c)) Console.Write("{0} ", c); });

							Console.WriteLine();
						}

						// Expand and try again
						vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion begin ;;;;;;;;;;");
						List<int> candidatesToExpand = new List<int>();
						sp.activeCandidates.Iter<int>(n => candidatesToExpand.Add(n));
						DoExpansion(candidatesToExpand, vState);
						vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion end ;;;;;;;;;;");
					}
						
					#endregion
				}
			}
		}

		public bool isSkipped(string procName)
		{
			return procsToSkip.Contains(procName);
		}
		public bool isSkipped(int candidate, FCallHandler calls)
		{
			return isSkipped(calls.getProc(candidate));
		}


		public enum BoundType { ATLEAST, ATMOST };

		// Encodes a condition to say that at most "bound" of the expressions in exprList can be true
		private VCExpr conditionWithBounds(HashSet<VCExpr> exprList, uint bound, BoundType boundType)
		{
			VCExpr bigNumBound = prover.VCExprGen.Integer(BigNum.FromUInt(bound + 1));
			VCExpr finalExpr = prover.VCExprGen.Integer(BigNum.ZERO);

			foreach (VCExpr expr in exprList)
			{
				VCExpr res = prover.VCExprGen.Function(VCExpressionGenerator.IfThenElseOp, expr, prover.VCExprGen.Integer(BigNum.ONE), prover.VCExprGen.Integer(BigNum.ZERO));
				finalExpr = prover.VCExprGen.Add(finalExpr, res);
			}

			if (boundType == BoundType.ATMOST)
				finalExpr = prover.VCExprGen.Gt(bigNumBound, finalExpr);
			else if (boundType == BoundType.ATLEAST)
				finalExpr = prover.VCExprGen.Gt(finalExpr, bigNumBound);
			else
				Contract.Assert(false);


			return finalExpr;
		}


		private VCExpr CreateVC(SoftPartition softPartition, VerificationState vState)
		{
			// add all the activeCandidates and their parents
			HashSet<int> candidatesAddedInVC = new HashSet<int>();
			Queue<int> pendingCandidates = new Queue<int>();

			softPartition.activeCandidates.Iter<int>(n => pendingCandidates.Enqueue(n));

			VCExpr vc = VCExpressionGenerator.True;

			foreach (int id in softPartition.candidateUniverse)
			{
				// impose both the inlined function as well as the summary
				// the inlined function is an overapproximation --- so the summary can still help

				vc = vState.checker.prover.VCExprGen.And(vc, vState.calls.id2VC[id]);
				//RefinementFuzzing.Settings.vc_set.Add(vc);

				//VCExpr summary = vState.summaryDB.get(id, RefinementFuzzing.Settings.SummaryTypeInUse);

				/*
				if (summary != null)
				{
					vc = vState.checker.prover.VCExprGen.And(vc, summary);
					//RefinementFuzzing.Settings.vc_set.Add(vc);
				}
				*/
			}

			/*
			foreach (int id in softPartition.activeCandidates)
			{
				// for the active candidates, inline the summary (if available)
				//VCExpr summary = vState.summaryDB.get(id, RefinementFuzzing.Settings.SummaryTypeInUse);

				if (summary != null)
				{
					vc = vState.checker.prover.VCExprGen.And(vc, summary);
					//RefinementFuzzing.Settings.vc_set.Add(vc);
				}

				if (RefinementFuzzing.Settings.FreshParamCopies)
				{
					vc = vState.checker.prover.VCExprGen.And(vc, vState.calls.id2FreshParamAsgn[id]);
				}

				// Candidates that reach recursion bound
				int idBound = vState.calls.getRecursionBound(id);
				int sd = vState.calls.getStackDepth(id);
				if (!(idBound <= CommandLineOptions.Clo.RecursionBound && (CommandLineOptions.Clo.StackDepthBound == 0 || sd <= CommandLineOptions.Clo.StackDepthBound)))
					vc = vState.checker.prover.VCExprGen.And(vc, vState.calls.getFalseExpr(id));
			}
			*/

			foreach (int id in softPartition.candidatesReachingRecBound)
			{
				// for the active candidates, inline the summary (if available)

				vc = vState.checker.prover.VCExprGen.And(vc, vState.calls.getFalseExpr(id));
				//RefinementFuzzing.Settings.vc_set.Add(vc);

			}


			/*
            while (pendingCandidates.Count > 0) {
                int id = pendingCandidates.Dequeue();
                vc = vState.checker.prover.VCExprGen.And(vc, vState.calls.id2VC[id]);
                candidatesAddedInVC.Add(id);

                if (id != 0 && !candidatesAddedInVC.Contains(id) && !pendingCandidates.Contains(id))
                    pendingCandidates.Enqueue(vState.calls.candidateParent[id]);
            }
             * */

			// TODO: Add summary for open calls in the partition

			return vc;
		}

		public enum FormulaType { VC, PartitionBlockedSet, Summary, CandidateSummary, PrefixTrace, NONE };

		public static string getNameForFormula(int id, FormulaType ftype, int minor_id = -1)
		{
			string prefix = "";

			if (ftype == FormulaType.VC)
				prefix = "candidate_vc_";
			else if (ftype == FormulaType.PartitionBlockedSet)
				prefix = "blocked_";
			else if (ftype == FormulaType.Summary)
				prefix = "summary_";
			else if (ftype == FormulaType.CandidateSummary)
				prefix = "candidate_summary_";
			else if (ftype == FormulaType.PrefixTrace)
				prefix = "prefix_trace_";
			else
				Contract.Assert(false);

			if (id < 0)
				prefix += "neg_" + (-1 * id);
			else
				prefix += id;

			if (ftype == FormulaType.Summary)
				prefix += "_v" + minor_id;
			else if (ftype == FormulaType.CandidateSummary)
				prefix += "_q" + minor_id;

			return prefix;
		}

		private void OptimizedAssertVC(SoftPartition softPartition, VerificationState vState, ProverInterface prover, ProverStackBookkeeping proverStackBookkeeper)
		{
			// add all the activeCandidates and their parents
			//HashSet<int> candidatesAddedInVC = new HashSet<int>();
			//Queue<int> pendingCandidates = new Queue<int>();

			//softPartition.activeCandidates.Iter<int>(n => pendingCandidates.Enqueue(n));

			List<int> proverStack = proverStackBookkeeper.getProverStackStatus().ToList();

			Contract.Assert(proverStack.Count == 0                  // starting with an empty stack
				|| proverStack.Contains(softPartition.Id)           // while going up --- stack needs to be popped
				|| proverStack.Contains(softPartition.parent.Id));  // while going down --- softPartition needs to be pushed

			SoftPartition s = softPartition;

			/*
            while (s != null && proverStackBookkeeper.Count() - 1 < s.level)
            {
                s = s.parent;
            }
             * */

			//Contract.Assert((s == null && proverStackBookkeeper.Count() == 0) || s.level == proverStackBookkeeper.Count() - 1);
			//Contract.Assert((s == null && proverStackBookkeeper.Count() == 0) || );

			/*
            while (s != null && proverStackBookkeeper.Count() > 0 && (s.Id != proverStackBookkeeper.Top() || proverStackBookkeeper.stalePartitions.Contains(s)))
            {
                s = s.parent;
                proverStackBookkeeper.Pop();
            }
             * */

			SoftPartition s1 = softPartition;
			List<int> spList = new List<int>(); // set of all partitions that need to be present on prover stack
			while (s1 != null)
			{
				spList.Add(s1.Id);
				s1 = s1.parent;
			}

			IEnumerable<int> remainingPartitions = spList.Except<int>(proverStack); // partitions which are not yet on prover stack

			s = null;
			// try to pop as much as we can --- search for the least common ancestor
			for (int i = 0; i < proverStack.Count; i++)
			{
				int topElem = proverStack[i];
				if (!proverStackBookkeeper.pinnedPartitions.Contains(topElem) &&
					!proverStackBookkeeper.deferredPartitions.Contains(topElem) &&
					!spList.Contains(topElem))
				{
					proverStackBookkeeper.Pop();
				}
				else
				{
					break;
				}
			}



			#if false
			SoftPartition x = s;
			// sanity check: can be removed after testing
			for (int i = 0; i < proverStackBookkeeper.getProverStackStatus().Count; i++, x = x.parent)
			{
			if (proverStackBookkeeper.getProverStackStatus().ElementAt(i) > 0 && proverStackBookkeeper.getProverStackStatus().ElementAt(i) != x.Id)
			Contract.Assert(false);
			}
			#endif

			SoftPartition t = softPartition;

			Stack<SoftPartition> vcStack = new Stack<SoftPartition>();

			// need to push in the reverse order
			while (t != null && remainingPartitions.Contains(t.Id))
			{
				vcStack.Push(t);

				//t.stale = false;
				if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
					proverStackBookkeeper.stalePartitions.Remove(s);
				t = t.parent;
			}


			while (vcStack.Count > 0)
			{
				SoftPartition sp = vcStack.Pop();

				proverStackBookkeeper.Push(sp, vState);
				//prover.Assert(vc1Tuple.Item1, true);
				//proverStackBookkeeper.Assert(sp, getNameForFormula(vc1Tuple.Item2));
				// lock (RefinementFuzzing.Settings.lockThis) // it looks like VCExprGen manipulations need locking
				{
					assertVCForPartition(sp, vState);
				}
			}

			// TODO: Add summary for open calls in the partition

			/*
            proverStackBookkeeper.Push(-1);
            prover.Assert(vc2, true);
            proverStackBookkeeper.Assert(vc2, getNameForFormula(-1));
            */
			return;
		}

		public VCExpr getVCForCandidate(int candidateId, SoftPartition sp, VerificationState vState)
		{
			VCExpr vc1 = VCExpressionGenerator.True;

			// impose both the inlined function as well as the summary
			// the inlined function is an overapproximation --- so the summary can still help

			vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.id2VC[candidateId]);
			//RefinementFuzzing.Settings.vc_set.Add(vc);


			if (RefinementFuzzing.Settings.FreshParamCopies)
			{
				Contract.Assert(candidateId == 0 || vState.calls.id2FreshParamAsgn.ContainsKey(candidateId));
				//   if (vState.calls.id2FreshParamAsgn.ContainsKey(candidateId))
				//       vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.id2FreshParamAsgn[candidateId]);
			}

			/*
			if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
			{
				VCExpr summary = vState.summaryDB.get(candidateId, RefinementFuzzing.Settings.SummaryTypeInUse);

				if (summary != null)
				{
					vc1 = vState.checker.prover.VCExprGen.And(vc1, summary);
					//RefinementFuzzing.Settings.vc_set.Add(vc);
				}
			}
			*/

			foreach (int id in sp.activeCandidates)
			{
				if (!vState.calls.candidateParent.Keys.Contains(id))
					Contract.Assert(false);

				if (vState.calls.candidateParent[id] != candidateId)
					continue;

				/*
				if (!RefinementFuzzing.Settings.instantlyPropagateSummaries)
				{
					// for the active candidates, inline the summary (if available)
					VCExpr summary1 = vState.summaryDB.get(id, RefinementFuzzing.Settings.SummaryTypeInUse);

					if (summary1 != null)
					{
						vc1 = vState.checker.prover.VCExprGen.And(vc1, summary1);
						//RefinementFuzzing.Settings.vc_set.Add(vc);
					}
				}
				*/

				if (RefinementFuzzing.Settings.FreshParamCopies)
				{
					vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.id2FreshParamAsgn[id]);
				}

				// Candidates that reach recursion bound
				int idBound = vState.calls.getRecursionBound(id);
				int sd = vState.calls.getStackDepth(id);
				if (!(idBound <= CommandLineOptions.Clo.RecursionBound && (CommandLineOptions.Clo.StackDepthBound == 0 || sd <= CommandLineOptions.Clo.StackDepthBound)))
					vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.getFalseExpr(id));
			}

			/*
            foreach (int id in sp.blockedCandidates)
            {
                if (vState.calls.candidateParent[id] != candidateId)
                    continue;

                // for the active candidates, inline the summary (if available)

                vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.getFalseExpr(id));
                //RefinementFuzzing.Settings.vc_set.Add(vc);

            }
             * */

			foreach (int id in sp.candidatesReachingRecBound)
			{
				if (vState.calls.candidateParent[id] != candidateId)
					continue;

				// for the active candidates, inline the summary (if available)
				Contract.Assert(false); // should not be reachable
				vc1 = vState.checker.prover.VCExprGen.And(vc1, vState.calls.getFalseExpr(id));
				//RefinementFuzzing.Settings.vc_set.Add(vc);

			}

			return vc1;
		}


		private void assertVCForPartition(SoftPartition sp, VerificationState vState)
		{
			VCExpr vc1 = VCExpressionGenerator.True;
			VCExpr vc2 = VCExpressionGenerator.True;
			//VCExpr vc3 = VCExpressionGenerator.True; // REMOVE IT

			//lock (RefinementFuzzing.Settings.lockThis)  [removed on 15th Sept]
			{

				// add the VC of the last inlined "layer" (the others are already asserted deeper in the prover stack)
				foreach (int id in sp.lastInlined)
				{
					//vc1 = vState.checker.prover.VCExprGen.And(vc1, getVCForCandidate(id, sp, vState));
					vc1 = getVCForCandidate(id, sp, vState);

					//vc3 = vState.checker.prover.VCExprGen.And(vc3, vc1);

					proverStackBookkeeper.Assert(vc1, getNameForFormula(id, FormulaType.VC), "Partition: " + sp.Id + "; Candidate: " + id);
				}

				// REMOVE IT!
				//proverStackBookkeeper.Assert(vc3, "Partition_" + sp.Id, "Partition: " + sp.Id + "; Candidate: ");


				/*
                foreach (int id in sp.activeCandidates)
                {
                    // for the active candidates, inline the summary (if available)
                    VCExpr summary = vState.summaryDB.get(id, RefinementFuzzing.Settings.SummaryTypeInUse);

                    if (summary != null)
                    {
                        vc1 = vState.checker.prover.VCExprGen.And(vc1, summary);
                        //RefinementFuzzing.Settings.vc_set.Add(vc);
                    }
                }
                */

				if (!RefinementFuzzing.Settings.noInterpolationOnMainProver && !RefinementFuzzing.Settings.lazySummaries)
				{
					IEnumerable<int> incrementalBlocked;

					if (sp.Id != 0)
					{
						incrementalBlocked = sp.blockedCandidates.Except(sp.parent.blockedCandidates);
					}
					else
					{
						incrementalBlocked = sp.blockedCandidates;
					}

					StringBuilder blkSet = new StringBuilder();
					//foreach (int id in sp.blockedCandidates)
					foreach (int id in incrementalBlocked)
					{
						vc2 = vState.checker.prover.VCExprGen.And(vc2, vState.calls.getFalseExpr(id));
						//RefinementFuzzing.Settings.vc_set.Add(vc);

						blkSet.Append("," + id);
					}

					proverStackBookkeeper.Assert(vc2, getNameForFormula(sp.Id, FormulaType.PartitionBlockedSet), "Partition: " + sp.Id + "; BlockedSet (incremental): " + blkSet.ToString());
				}
			}

			/*
            foreach (int id in sp.candidatesReachingRecBound)
            {
                // for the active candidates, inline the summary (if available)

                vc2 = vState.checker.prover.VCExprGen.And(vc2, vState.calls.getFalseExpr(id));
                //RefinementFuzzing.Settings.vc_set.Add(vc);
                
            }
            proverStackBookkeeper.Assert(vc2, getNameForFormula(sp.Id, FormulaType.PartitionBlockedSet), "Partition: " + sp.Id + "; BlockedSet (incremental): " + blkSet.ToString());
            */

			//return vc1;
		}



		public ConcurrentSolver solver;
		//public static InterfaceMaps interfaceMaps;
		public static PartitionSelectionHeuristics partitionSelectionHeuristics;


		static public ProverArrayManager proverManager;

		private Outcome VerifyImplementationConcurrent(Implementation/*!*/ impl, VerifierCallback/*!*/ callback)
		{
			Debug.Assert(QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));
			Debug.Assert(this.program == program);

			useConcurrentSolver = true;

			// Flush any axioms that came with the program before we start SI on this implementation
			prover.AssertAxioms();

			// Run live variable analysis
			if (CommandLineOptions.Clo.LiveVariableAnalysis == 2)
			{
				Microsoft.Boogie.InterProcGenKill.ComputeLiveVars(impl, program);
			}

			// Get the VC of the current procedure
			StratifiedInliningInfo info = implName2StratifiedInliningInfo[impl.Name];
			info.GenerateVC();
			VCExpr vc = info.vcexpr;

			var substForallDict = new Dictionary<VCExprVar, VCExpr>();
			if (info.controlFlowVariable != null)
			{
				substForallDict.Add(prover.Context.BoogieExprTranslator.LookupVariable(info.controlFlowVariable),
					prover.VCExprGen.Integer(BigNum.FromInt(0)));
			}
			VCExprSubstitution substForall = new VCExprSubstitution(substForallDict, new Dictionary<TypeVariable, Microsoft.Boogie.Type>());
			SubstitutingVCExprVisitor subst = new SubstitutingVCExprVisitor(prover.VCExprGen);
			Contract.Assert(subst != null);
			vc = subst.Mutate(vc, substForall);

			Dictionary<int, Absy> mainLabel2absy = info.label2absy;
			var reporter = new StratifiedInliningErrorReporter(implName2StratifiedInliningInfo, prover, callback, info);

			// Find all procedure calls in vc and put labels on them      
			FCallHandler calls = new FCallHandler(prover.VCExprGen, implName2StratifiedInliningInfo, impl.Name, mainLabel2absy);
			calls.setCurrProcAsMain();
			vc = calls.Mutate(vc, true);
			reporter.SetCandidateHandler(calls);
			calls.id2VC.Add(0, vc);
			calls.extraRecursion = extraRecBound;

			// We'll restore the original state of the theorem prover at the end
			// of this procedure
			//prover.Push();

			// Put all of the necessary state into one object
			ProverInterface prover2 = null;
			var vState = new VerificationState(vc, calls, prover, reporter, prover2, new EmptyErrorHandler());
			vState.vcSize += SizeComputingVisitor.ComputeSize(vc);

			// Create the interface maps
			//interfaceMaps = new InterfaceMaps();


			if (RefinementFuzzing.Settings.preAllocateProvers)
			{
				//Contract.Assert(RefinementFuzzing.Settings.useInterpolatingAsMainProver); // only done for this case
				proverManager = new ProverArrayManager(RefinementFuzzing.Settings.totalThreadBudget, program, prover);
				proverStackBookkeeper = proverManager.BorrowProver(0);

				/*
				if (RefinementFuzzing.Settings.useConcurrentSummaryDB)
				{
					vState.summaryDB = new ConcurrentSummaryDB(this, vState, proverStackBookkeeper.getInterpolatingProver());
				}
				else
				{
					vState.summaryDB = new SummaryDB(this, vState, proverStackBookkeeper.getInterpolatingProver());
				}
				*/
			}
			else
			{
				/*
				if (RefinementFuzzing.Settings.useConcurrentSummaryDB)
				{
					vState.summaryDB = new ConcurrentSummaryDB(this, vState, null);
				}
				else
				{
					vState.summaryDB = new SummaryDB(this, vState, null);
				}
				*/

				proverStackBookkeeper = new ProverStackBookkeeping(prover, 0);
			}

			/*
			if (RefinementFuzzing.Settings.useConcurrentSummaryDB && RefinementFuzzing.Settings.summaryLog != null)
			{
				SummaryDB.summaryLogFile = new StreamWriter(RefinementFuzzing.Settings.summaryLog);

				if (RefinementFuzzing.Settings.summaryLogHTML)
				{
					SummaryDB.summaryLogFile.WriteLine("<html><body>");
				}
			}
			*/

			/*
            foreach (Implementation i in program.Implementations())
            {
                Procedure proc = i.Proc;
                List<VCExprVar> vcexprList = implName2StratifiedInliningInfo[proc.Name].interfaceExprVars;
                
            }
             */

			partitionSelectionHeuristics = new PartitionSelectionHeuristics();

			if (RefinementFuzzing.Settings.timeout != 0)
			{
				int t = RefinementFuzzing.Settings.timeout * 1000;

				// Create a timer with a two second interval.
				System.Timers.Timer aTimer = new System.Timers.Timer(t);
				// Hook up the Elapsed event for the timer. 
				//aTimer.Elapsed += OnTimedEvent;
				aTimer.Enabled = true;
			}

			//SummaryDB.CollectEnvironmentVariables(program);

			if (RefinementFuzzing.Settings.DoPredAbsOnSummaries)
			{
				//Dictionary<string, VCExpr> abstractSummaries2 = LoadStroreAbstractSummaries(null, true);

				//abstractSummaries2.Keys.Iter<string>(n => vState.summaryDB.proc2Summary[n] = abstractSummaries[n]);


			}

			// Under-approx query is only needed if something was inlined since
			// the last time an under-approx query was made
			// TODO: introduce this
			// bool underApproxNeeded = true;

			// The recursion bound for stratified search

			// 0: Pull a new soft partition from queue
			// 1: Iterate on creating partitions

			solver = new ConcurrentSolver(this, vState);

			/*
			if (CommandLineOptions.Clo.asChild)
			{
				DistributedContext obj = RefinementFuzzing.Settings.ResumeFromParent(CommandLineOptions.Clo.pipeName, solver) as DistributedContext;
				Console.WriteLine("Execution of child completed!");

				if (RefinementFuzzing.Settings.consoleRun)
					Console.ReadKey();

				System.Environment.Exit(0);
			}
			*/

			List<int> entryPoints = new List<int>();
			entryPoints.Add(0); // only '0' for the moment for the "main()" function (assuming only one entry point)

			VerifyResult res = solver.Solve(entryPoints);

			/*
			if (RefinementFuzzing.Settings.summaryPrintFile != null)
			{
				vState.summaryDB.WriteSummaries();
			}

			if (RefinementFuzzing.Settings.useConcurrentSummaryDB && RefinementFuzzing.Settings.summaryLog != null)
			{
				if (RefinementFuzzing.Settings.summaryLogHTML)
				{
					SummaryDB.summaryLogFile.WriteLine("</body></html>");
				}

				SummaryDB.summaryLogFile.Close();
			}
			*/

			Console.WriteLine("Houdini Statistics (VerifiedTrue = {0} / Total = {1})", RefinementFuzzing.Settings.HoudiniVerifiedTrue, RefinementFuzzing.Settings.HoudiniVerifiedTotal);

			if (res == VerifyResult.Verified)
			{
				if (RefinementFuzzing.Settings.reachedRecursionBound)
					Console.Out.WriteLine("Correct under recursion bound!");
				else
					Console.Out.WriteLine("Proof Found!");
			}

			Console.WriteLine("SolvePartition time: {0} sec", timeTaken);
			Console.WriteLine("Number of calls to SolvePartition : {0}", numCalls);
			Console.WriteLine("Number of threads spawned : {0}", threadsSpawned);

			Console.WriteLine("Solver Times on each Thread: ");
			proverManager.PrintTimers();
			Settings.oTimer.PrintStatistics();

			//Console.WriteLine("Lock Entered {0} times, wait time {1} sec", RefinementFuzzing.Settings.timedLock.EnterCount, RefinementFuzzing.Settings.timedLock.WaitTime);

			if (RefinementFuzzing.Settings.constructExplorationGraph)
			{
				RefinementFuzzing.Settings.explorationGraph.WriteDot();

				StreamWriter sw = new StreamWriter("funcs.txt");
				foreach (int id in RefinementFuzzing.Settings.candidateNames.Keys)
				{
					sw.WriteLine(id + ": " + RefinementFuzzing.Settings.candidateNames[id]);
				}

				sw.Close();
			}

			//if (res == VerifyResult.BugFound && RefinementFuzzing.Settings.needErrorTraces)
			if (res == VerifyResult.BugFound)
			{
				Contract.Assert(RefinementFuzzing.Settings.ErrPartition != null);

				SoftPartition err = RefinementFuzzing.Settings.ErrPartition;

				int errCandidate = -1;
				HashSet<string> funcsInErrTrace = new HashSet<string>();

				/*
                err.lastInlined.Iter<int>(n => { if ("SLIC_ERROR_ROUTINE".Equals(RefinementFuzzing.Settings.candidateNames[n])) errCandidate = n; });

                while (errCandidate > 0)
                {
                    string procName = RefinementFuzzing.Settings.candidateNames[errCandidate];
                    Console.WriteLine(procName);

                    Contract.Assert(err.lastInlined.Contains(errCandidate));

                    err = err.parent;
                    errCandidate = calls.candidateParent[errCandidate];
                }

                program.Emit(new TokenTextWriter("final.bpl"));
                */

				Stack<SoftPartition> st = new Stack<SoftPartition>();
				err = RefinementFuzzing.Settings.ErrPartition;
				while (err.Id != 0)
				{
					err.lastInlined.Iter<int>(n => funcsInErrTrace.Add(RefinementFuzzing.Settings.candidateNames[n].Substring(0, RefinementFuzzing.Settings.candidateNames[n].IndexOf("["))));
					//err.lastInlined.Iter<int>(n => RefinementFuzzing.Settings.lastInliningFile.WriteLine(RefinementFuzzing.Settings.candidateNames[n]));
					//RefinementFuzzing.Settings.lastInliningFile.WriteLine("---------------");
					st.Push(err);
					err = err.parent;
				}

				if (RefinementFuzzing.Settings.lastInliningFile != null)
				{
					while (st.Count > 0)
					{
						err = st.Pop();
						err.lastInlined.Iter<int>(n => RefinementFuzzing.Settings.lastInliningFile.Write(n + ", "));
						RefinementFuzzing.Settings.lastInliningFile.WriteLine();
					}
					RefinementFuzzing.Settings.lastInliningFile.Flush();
				}

				funcsInErrTrace.Add("fakeMain"); // this method is id 0, added by Corral
				funcsInErrTrace.Add("corral_nondet");
				funcsInErrTrace.Add("__HAVOC_malloc");
				funcsInErrTrace.Add("__HAVOC_malloc_or_null");
				funcsInErrTrace.Add("boogie_si_record_li2bpl_int");
				funcsInErrTrace.Add("corralExplainErrorInit");
				funcsInErrTrace.Add("corralExtraInit");

				/*
				DeltaDebug dbg = new DeltaDebug(CommandLineOptions.Clo.Files, funcsInErrTrace);
				dbg.Transform("error.bpl", vState.summaryDB);
				*/

				#if false
				Dictionary<string, Dictionary<string, Block>> extractLoopMappingInfo = null;
				if (CommandLineOptions.Clo.ExtractLoops)
				{
				extractLoopMappingInfo = program.ExtractLoops();
				}

				List<Counterexample> errors = (callback as CounterexampleCollector).examples;
				Dictionary<string, Implementation> origProg = new Dictionary<string, Implementation>();
				calls.implName2StratifiedInliningInfo.Keys.Iter<string>(n => origProg[n] = calls.implName2StratifiedInliningInfo[n].impl);

				List<BoogieErrorTrace> allErrors = new List<BoogieErrorTrace>();

				if (errors != null)
				{
				for (int i = 0; i < errors.Count; i++)
				{
				errors[i].Print(1, Console.Out);

				/*
				// Map the trace across loop extraction
				if (this is VC.VCGen && extractLoopMappingInfo != null)
				{
				errors[i] = (this as VC.VCGen).extractLoopTrace(errors[i], impl.Name, program, extractLoopMappingInfo);
				}
				*/

				if (errors[i] is AssertCounterexample)
				{
				// Special treatment for assert counterexamples for CBA: Reconstruct
				// trace in the input program.
				BoogieErrorTrace.ReconstructImperativeTrace(errors[i], impl.Name, origProg);
				allErrors.Add(new BoogieAssertErrorTrace(errors[i] as AssertCounterexample, origProg[impl.Name], program));
				}
				else
				{
				allErrors.Add(new BoogieErrorTrace(errors[i], origProg[impl.Name], program));
				}

				allErrors[i].printLabels(new TokenTextWriter("x.bpl"));
				}
				}

				Console.WriteLine("Trace: ", allErrors);
				#endif
			}

			// Predicate abstraction on summaries
			if (RefinementFuzzing.Settings.DoPredAbsOnSummaries)
			{
				ProverStackBookkeeping bk = proverManager.BorrowProver(0);
				bk.Reset();
				//RefinementFuzzing.Settings.ProverVerbosity = 5;
				//abstractSummaries = DoPredAbsUsingEnv(bk, vState.summaryDB, TokenTextWriter.environmentVariables);

				//FCallHandler.candidateCount = 0;
				//SoftPartition.totalPartitions = 0;
				//VerifyImplementationConcurrent(impl, callback);
				//LoadStroreAbstractSummaries(abstractSummaries, false);

				/*
				foreach (Declaration decl in freshProgram.TopLevelDeclarations)
				{
					if (decl is Procedure)
					{
						string name = (decl as Procedure).Name;
						if (abstractSummaries.ContainsKey(name))
						{
							VCExpr summary = abstractSummaries[name];
							Expr exp = Common.VCExpr2Expr.VCExprToExpr(summary, interfaceMaps.getInterfacMap(name));
							(decl as Procedure).Ensures.Add(new Ensures(true, exp));
						}
					}
					//program.TopLevelDeclarations[proc];
				}


				//Program freshProgram = Microsoft.Boogie.ExecutionEngine.ParseBoogieProgram(fileNames, false);
				TokenTextWriter f = new TokenTextWriter("WithSummaries.bpl");
				freshProgram.Emit(f);
				f.Close();
				*/
			}

			program.Emit(new TokenTextWriter("dump.bpl"));

			if (res == VerifyResult.Verified)
				return Outcome.Correct;
			else if (res == VerifyResult.BugFound)
				return Outcome.Errors;
			else if (res == VerifyResult.Errors)
				return Outcome.Inconclusive;  // Outcome gives finer granuality (memory, timeout, inconclusive) --- we only return inconclusive
			else
				Contract.Assert(false); // unreachable (Partitioned should not be returned)
			return Outcome.Inconclusive; // unreachable
		}

    public Outcome VerifyImplementationSI(Implementation/*!*/ impl, VerifierCallback/*!*/ callback) {
      Debug.Assert(QKeyValue.FindBoolAttribute(impl.Attributes, "entrypoint"));

      // Record current time
      var startTime = DateTime.UtcNow;

      // Flush any axioms that came with the program before we start SI on this implementation
      prover.AssertAxioms();

      // Run live variable analysis
      if (CommandLineOptions.Clo.LiveVariableAnalysis == 2) {
        Microsoft.Boogie.InterProcGenKill.ComputeLiveVars(impl, program);
      }

      // Get the VC of the current procedure
      StratifiedInliningInfo info = implName2StratifiedInliningInfo[impl.Name];
      info.GenerateVC();
      VCExpr vc = info.vcexpr;
      Dictionary<int, Absy> mainLabel2absy = info.label2absy;
      var reporter = new StratifiedInliningErrorReporter(implName2StratifiedInliningInfo, prover, callback, info);

      // Find all procedure calls in vc and put labels on them      
      FCallHandler calls = new FCallHandler(prover.VCExprGen, implName2StratifiedInliningInfo, impl.Name, mainLabel2absy);
      calls.setCurrProcAsMain();
      vc = calls.Mutate(vc, true);
      reporter.SetCandidateHandler(calls);
      calls.id2VC.Add(0, vc);
      calls.extraRecursion = extraRecBound;
      if (CommandLineOptions.Clo.SIBoolControlVC)
      {
          calls.candiate2block2controlVar.Add(0, new Dictionary<Block, VCExpr>());
          implName2StratifiedInliningInfo[impl.Name].blockToControlVar.Iter(tup =>
              calls.candiate2block2controlVar[0].Add(tup.Key, tup.Value));
      }

      // We'll restore the original state of the theorem prover at the end
      // of this procedure
      prover.Push();

      // Put all of the necessary state into one object
      var vState = new VerificationState(vc, calls, prover, reporter);
      vState.vcSize += SizeComputingVisitor.ComputeSize(vc);

      Outcome ret = Outcome.ReachedBound;

      #region eager inlining
      for (int i = 1; i < CommandLineOptions.Clo.StratifiedInlining && calls.currCandidates.Count > 0; i++) {
        List<int> toExpand = new List<int>();

        foreach (int id in calls.currCandidates) {
          if (calls.getRecursionBound(id) <= CommandLineOptions.Clo.RecursionBound) {
            toExpand.Add(id);
          }
        }
        DoExpansion(toExpand, vState);
      }
      #endregion

      #region Repopulate call tree, if there is one
      if (PersistCallTree && callTree != null) {
        bool expand = true;
        while (expand) {
          List<int> toExpand = new List<int>();
          foreach (int id in calls.currCandidates) {
            if (callTree.Contains(calls.getPersistentId(id))) {
              toExpand.Add(id);
            }
          }
          if (toExpand.Count == 0) expand = false;
          else {
            DoExpansion(toExpand, vState);
          }
        }
      }
      #endregion

      if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1) {
        Console.WriteLine(">> SI: Size of VC after eager inlining: {0}", vState.vcSize);
      }

      // Under-approx query is only needed if something was inlined since
      // the last time an under-approx query was made
      // TODO: introduce this
      // bool underApproxNeeded = true;

      // The recursion bound for stratified search
      int bound = CommandLineOptions.Clo.NonUniformUnfolding ? CommandLineOptions.Clo.RecursionBound : 1;

      int done = 0;

      int iters = 0;

      // for blocking candidates (and focusing on a counterexample)
      var block = new HashSet<int>();

      // Process tasks while not done. We're done when:
      //   case 1: (correct) We didn't find a bug (either an over-approx query was valid
      //                     or we reached the recursion bound) and the task is "step"
      //   case 2: (bug)     We find a bug
      //   case 3: (internal error)   The theorem prover TimesOut of runs OutOfMemory
      while (true)
      {
          // Check timeout
          if (CommandLineOptions.Clo.ProverKillTime != -1)
          {
              if ((DateTime.UtcNow - startTime).TotalSeconds > CommandLineOptions.Clo.ProverKillTime)
              {
                  ret = Outcome.TimedOut;
                  break;
              }
          }

          if (done > 0)
          {
              break;
          }

          // Stratified Step
          ret = stratifiedStep(bound, vState, block);
          iters++;

          // Sorry, out of luck (time/memory)
          if (ret == Outcome.Inconclusive || ret == Outcome.OutOfMemory || ret == Outcome.TimedOut)
          {
              done = 3;
              continue;
          }

          if (ret == Outcome.Errors && reporter.underapproximationMode)
          {
              // Found a bug
              done = 2;
          }
          else if (ret == Outcome.Correct)
          {
              if (block.Count == 0)
              {
                  // Correct
                  done = 1;
              }
              else
              {
                  // reset blocked and continue loop
                  block.Clear();
              }
          }
          else if (ret == Outcome.ReachedBound)
          {
              if (block.Count == 0)
              {
                  if (CommandLineOptions.Clo.StratifiedInliningVerbose > 0)
                      Console.WriteLine(">> SI: Exhausted Bound {0}", bound);

                  // Increment bound
                  bound++;

                  if (bound > CommandLineOptions.Clo.RecursionBound)
                  {
                      // Correct under bound
                      done = 1;
                  }
              }
              else
              {
                  // reset blocked and continue loop
                  block.Clear();
              }
          }
          else
          {
              // Do inlining
              Debug.Assert(ret == Outcome.Errors && !reporter.underapproximationMode);
              Contract.Assert(reporter.candidatesToExpand.Count != 0);

              #region expand call tree
              if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1)
              {
                  Console.Write(">> SI Inlining: ");
                  reporter.candidatesToExpand
                      .Select(c => calls.getProc(c))
                      .Iter(c =>  Console.Write("{0} ", c));

                  Console.WriteLine();
              }

              // Expand and try again
              vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion begin ;;;;;;;;;;");
              DoExpansion(reporter.candidatesToExpand, vState);
              vState.checker.prover.LogComment(";;;;;;;;;;;; Expansion end ;;;;;;;;;;");

              #endregion
          }
      }

      // Pop off everything that we pushed so that there are no side effects from
      // this call to VerifyImplementation
      vState.checker.prover.Pop();

      if (CommandLineOptions.Clo.StratifiedInliningVerbose > 1) {
        Console.WriteLine(">> SI: Expansions performed: {0}", vState.expansionCount);
        Console.WriteLine(">> SI: Candidates left: {0}", calls.currCandidates.Count);
        Console.WriteLine(">> SI: VC Size: {0}", vState.vcSize);
      }

      vcsize = vState.vcSize;
      numInlined = (calls.candidateParent.Keys.Count + 1) - (calls.currCandidates.Count);

      var rbound = "Procs that reached bound: ";
      foreach (var s in procsThatReachedRecBound) rbound += "  " + s;
      if (ret == Outcome.ReachedBound) Helpers.ExtraTraceInformation(rbound);
      if (CommandLineOptions.Clo.StackDepthBound > 0 && ret == Outcome.Correct) ret = Outcome.ReachedBound;

      // Store current call tree
      if (PersistCallTree && (ret == Outcome.Correct || ret == Outcome.Errors || ret == Outcome.ReachedBound)) {
        callTree = new HashSet<string>();
        //var persistentNodes = new HashSet<int>(calls.candidateParent.Values);
        var persistentNodes = new HashSet<int>(calls.candidateParent.Keys);
        persistentNodes.Add(0);
        persistentNodes.ExceptWith(calls.currCandidates);

        foreach (var id in persistentNodes) {
          var pid = calls.getPersistentId(id);
          Debug.Assert(!callTree.Contains(pid));
          callTree.Add(pid);
        }
      }
      return ret;
    }

    // A step of the stratified inlining algorithm: both under-approx and over-approx queries
    private Outcome stratifiedStep(int bound, VerificationState vState, HashSet<int> block) {
      var calls = vState.calls;
      var checker = vState.checker;
      var prover = checker.prover;
      var reporter = checker.reporter as StratifiedInliningErrorReporter;

      reporter.underapproximationMode = true;
      prover.LogComment(";;;;;;;;;;;; Underapprox mode begin ;;;;;;;;;;");
      List<VCExpr> assumptions = new List<VCExpr>();

      foreach (int id in calls.currCandidates) {
          assumptions.Add(calls.getFalseExpr(id));
      }
      Outcome ret = checker.CheckAssumptions(assumptions);
      prover.LogComment(";;;;;;;;;;;; Underapprox mode end ;;;;;;;;;;");

      if (ret != Outcome.Correct) {
        // Either the query returned an error or it ran out of memory or time.
        // In all cases, we are done.
        return ret;
      }

      if (calls.currCandidates.Count == 0) {
        // If we didn't underapproximate, then we're done
        return ret;
      }

      prover.LogComment(";;;;;;;;;;;; Overapprox mode begin ;;;;;;;;;;");

      // Over-approx query
      reporter.underapproximationMode = false;

      // Push "true" for all, except:
      // push "false" for all candidates that have reached
      // the recursion bounds

      bool allTrue = true;
      bool allFalse = true;
      List<VCExpr> softAssumptions = new List<VCExpr>();

      assumptions = new List<VCExpr>();
      procsThatReachedRecBound.Clear();

      foreach (int id in calls.currCandidates) {

        int idBound = calls.getRecursionBound(id);
        int sd = calls.getStackDepth(id);
        if (idBound <= bound && (CommandLineOptions.Clo.StackDepthBound == 0 || sd <= CommandLineOptions.Clo.StackDepthBound)) {
          if (idBound > 1)
            softAssumptions.Add(calls.getFalseExpr(id));

          if (block.Contains(id)) {
            assumptions.Add(calls.getFalseExpr(id));
            allTrue = false;
          }
          else {
            allFalse = false;
          }
        }
        else {
          procsThatReachedRecBound.Add(calls.getProc(id));
          assumptions.Add(calls.getFalseExpr(id));
          allTrue = false;
        }
      }

      if (allFalse) {
        // If we made all candidates false, then this is the same
        // as the underapprox query. We already know the answer.
        ret = Outcome.Correct;
      }
      else {
        ret = CommandLineOptions.Clo.NonUniformUnfolding
              ? checker.CheckAssumptions(assumptions, softAssumptions)
              : checker.CheckAssumptions(assumptions);
      }

      if (ret != Outcome.Correct && ret != Outcome.Errors) {
        // The query ran out of memory or time, that's it,
        // we cannot do better. Give up!
        return ret;
      }

      if (ret == Outcome.Correct) {
        // If nothing was made false, then the program is correct
        if (allTrue) {
          return ret;
        }

        // Nothing more can be done with current recursion bound. 
        return Outcome.ReachedBound;
      }

      Contract.Assert(ret == Outcome.Errors);

      prover.LogComment(";;;;;;;;;;;; Overapprox mode end ;;;;;;;;;;");

      return ret;
    }

    // A counter for adding new variables
    static int newVarCnt = 0;

		// A step of the stratified inlining algorithm: both under-approx and over-approx queries
		// TODO: needs to be merged with the new code of stratifiedStep()
		private Outcome stratifiedStep1(int bound, VerificationState vState, HashSet<int> block, out HashSet<int> candidatesThatReachRecBound, HashSet<int> activeCandidates = null, List<HashSet<int>> candidatesInCounterexamples = null, uint cex_size = 0, VCExpr coveredCEXs = null)
		{
			var calls = vState.calls;
			var checker = vState.checker;
			var prover = checker.prover;
			var reporter = checker.reporter as StratifiedInliningErrorReporter;

			List<VCExpr> assumptions;

			Outcome ret;

			IEnumerable<int> currCandidates;

			if (useConcurrentSolver)
			{
				currCandidates = activeCandidates;
				candidatesThatReachRecBound = new HashSet<int>();
				//calls.currCandidates = activeCandidates; // Required as GenerateTraceRec() looks at calls.currCandidate to expand the trace (check "if (calls.currCandidates.Contains(calleeId))"); so important to restore calls.currCandidate
			}
			else
			{
				currCandidates = calls.currCandidates;
				candidatesThatReachRecBound = null;
			}

			// NO UNDERAPPROXIMATIONS
			if (!RefinementFuzzing.Settings.disableUnderapproxMode)
			{
				reporter.underapproximationMode = true;
				prover.LogComment(";;;;;;;;;;;; Underapprox mode begin ;;;;;;;;;;");
				assumptions = new List<VCExpr>();

				foreach (int id in currCandidates)
				{
					if (!isSkipped(id, calls))
						assumptions.Add(calls.getFalseExpr(id));
				}

				if (useConcurrentSolver)
				{
					// we don't even want an underapproximation outside our partition
					foreach (int id in block)
					{
						if (!isSkipped(id, calls))
							assumptions.Add(calls.getFalseExpr(id));
					}
				}

				//lock (RefinementFuzzing.Settings.lockThis)
				{
					ret = checker.CheckAssumptions(assumptions);
				}

				prover.LogComment(";;;;;;;;;;;; Underapprox mode end ;;;;;;;;;;");

				if (ret != Outcome.Correct)
				{
					// Either the query returned an error or it ran out of memory or time.
					// In all cases, we are done.

					return ret;
				}

				if (currCandidates.Count() == 0)
				{
					// If we didn't underapproximate, then we're done
					return ret;
				}

			}

			prover.LogComment(";;;;;;;;;;;; Overapprox mode begin ;;;;;;;;;;");

			// Over-approx query
			reporter.underapproximationMode = false;

			// Push "true" for all, except:
			// push "false" for all candidates that have reached
			// the recursion bounds

			bool allTrue = true;
			bool allFalse = true;
			List<VCExpr> softAssumptions = new List<VCExpr>();

			assumptions = new List<VCExpr>();
			procsThatReachedRecBound.Clear();

			if (RefinementFuzzing.Settings.guideOnPathFile != null)
			{
				string lineStr = RefinementFuzzing.Settings.guideOnPathFile.ReadLine();
				if (lineStr != null)
				{
					string[] line = lineStr.Split(',');
					List<int> selectedCandidates = new List<int>();
					line.Iter<string>(n => { if (!n.Equals(" ")) selectedCandidates.Add(Int32.Parse(n)); });

					Console.Write("");

					foreach (int n in currCandidates)
					{
						if (selectedCandidates.Contains(n))
							assumptions.Add(calls.getTrueExpr(n));
						else
							assumptions.Add(calls.getFalseExpr(n));
					}
				}
			}

			foreach (int id in currCandidates)
			{
				if (isSkipped(id, calls)) continue;

				int idBound = calls.getRecursionBound(id);
				int sd = calls.getStackDepth(id);
				//if (idBound <= bound && (CommandLineOptions.Clo.StackDepthBound == 0 || sd <= CommandLineOptions.Clo.StackDepthBound))
				if (idBound <= CommandLineOptions.Clo.RecursionBound && (CommandLineOptions.Clo.StackDepthBound == 0 || sd <= CommandLineOptions.Clo.StackDepthBound))
				{
					if (idBound > 1)
					{
						softAssumptions.Add(calls.getFalseExpr(id));
						//RefinementFuzzing.Settings.vc_set.Add(calls.getFalseExpr(id));
					}

					if (block.Contains(id))
					{
						Contract.Assert(useConcurrentSolver);
						assumptions.Add(calls.getFalseExpr(id));
						//RefinementFuzzing.Settings.vc_set.Add(calls.getFalseExpr(id));

						if (!useConcurrentSolver)
							allTrue = false;
					}
					else
					{
						allFalse = false;
					}
				}
				else
				{
					procsThatReachedRecBound.Add(calls.getProc(id));
					assumptions.Add(calls.getFalseExpr(id)); // Not required anymore: these are added when creating the VC
					//RefinementFuzzing.Settings.vc_set.Add(calls.getFalseExpr(id));
					allTrue = false;

					if (useConcurrentSolver)
						candidatesThatReachRecBound.Add(id);
				}
			}

			if (useConcurrentSolver)
			{
				// softly block all nodes outside our partition  (note: blocked candidates is not a subset of activeCandidates)
				foreach (int id in block)
				{
					if (!isSkipped(id, calls))
					{
						assumptions.Add(calls.getFalseExpr(id));
						//RefinementFuzzing.Settings.vc_set.Add(calls.getFalseExpr(id));
					}
				}

				if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.DisjointModuleSummaries)
				{
					HashSet<int> allCexCandidates = new HashSet<int>();
					candidatesInCounterexamples.Iter<HashSet<int>>(n => allCexCandidates.UnionWith(n));

					if (candidatesInCounterexamples.Count() == 1 && allCexCandidates.Contains(516))
						Console.Write("");

					// limit the subsequent partitions depending on the previously generated partitions
					if (candidatesInCounterexamples.Count > 0)
					{
						VCExpr limitExpr = partitionSelectionHeuristics.ExprMissingSummaries(allCexCandidates, vState);
						assumptions.Add(limitExpr);

						// If we already have a CEX that comprizes only of candidates with summaries,
						// we may end up getting the same CEX again and again --- block such cases
						foreach (HashSet<int> cex in candidatesInCounterexamples)
						{
							VCExpr e = VCExpressionGenerator.False;
							cex.Iter<int>(n => e = vState.checker.prover.VCExprGen.OrSimp(e, vState.calls.getFalseExpr(n)));
							assumptions.Add(e);
						}
					}
				}
				else if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.SoftBlocking)
				{
					HashSet<int> allCexCandidates = new HashSet<int>();
					candidatesInCounterexamples.Iter<HashSet<int>>(n => allCexCandidates.UnionWith(n));

					uint threshold;

					if (RefinementFuzzing.Settings.PartitionBoundariesSoft)
						threshold = cex_size / 2;
					//threshold = (uint)candidatesInCounterexamples.Count / 2;
					else
						threshold = 0;

					if (threshold > 0)
					{
						HashSet<VCExpr> lst1 = new HashSet<VCExpr>();
						foreach (int id in allCexCandidates)
						{
							lst1.Add(calls.getTrueExpr(id));
						}

						HashSet<VCExpr> lst2 = new HashSet<VCExpr>();
						foreach (int id in activeCandidates)
						{
							if (!allCexCandidates.Contains(id))
								lst2.Add(calls.getTrueExpr(id));
						}

						VCExpr softBlocked1 = conditionWithBounds(lst1, threshold, BoundType.ATMOST);
						VCExpr softBlocked2 = (lst2.Count == 0) ? VCExpressionGenerator.False : conditionWithBounds(lst2, threshold, BoundType.ATLEAST);
						VCExpr softBlocked = prover.VCExprGen.And(softBlocked1, softBlocked2);

						assumptions.Add(softBlocked);
					}
					else
					{
						foreach (int id in allCexCandidates)
						{
							if (!isSkipped(id, calls))
							{
								assumptions.Add(calls.getFalseExpr(id));
								//RefinementFuzzing.Settings.vc_set.Add(calls.getFalseExpr(id));
							}
						}
					}
				}
				else if (Settings.counterexampleEnumerationStrategy == Settings.CounterexampleEnumerationStrategy.EnumerateAll)
				{
					assumptions.Add(coveredCEXs);
				}
				else
					Contract.Assert(false);
			}

			if (allFalse && !RefinementFuzzing.Settings.disableUnderapproxMode)
			{
				// If we made all candidates false, then this is the same
				// as the underapprox query. We already know the answer.
				ret = Outcome.Correct;
			}
			else
			{
				if (candidatesInCounterexamples.Count > 0)
				{
					// this is not the "first" CEX --- let us generate the trace VC for it
					(checker.reporter as StratifiedInliningErrorReporter).generateTrace = true;
				}
				else
				{
					// an earlier call on this prover could have set it to true
					(checker.reporter as StratifiedInliningErrorReporter).generateTrace = false;
				}

				//lock (RefinementFuzzing.Settings.lockThis)
				{
					// some optimization
					if (assumptions.Contains(VCExpressionGenerator.False))
						ret = Outcome.Correct;
					else
						ret = CommandLineOptions.Clo.NonUniformUnfolding
							? checker.CheckAssumptions(assumptions, softAssumptions)
							: checker.CheckAssumptions(assumptions);
				}
			}

			if (RefinementFuzzing.Settings.disableUnderapproxMode)
			{
				if (reporter.candidatesToExpand.Count == 0 && ret == Outcome.Errors)
				{
					// If we didn't overapproximate, then we're done
					reporter.underapproximationMode = true; // it is an error on a concrete trace

					// a bad hack so that the counterexample trace is printed (only printed if checker.CheckAssumptions() is called with reporter.underapproximationMode as true
					ret = CommandLineOptions.Clo.NonUniformUnfolding
						? checker.CheckAssumptions(assumptions, softAssumptions)
						: checker.CheckAssumptions(assumptions);

					return ret;
				}
			}

			if (ret != Outcome.Correct && ret != Outcome.Errors)
			{
				// The query ran out of memory or time, that's it,
				// we cannot do better. Give up!
				return ret;
			}

			if (ret == Outcome.Correct)
			{
				// If nothing was made false, then the program is correct
				if (allTrue)
				{
					return ret;
				}

				/*
				if (useSummary)
				{
					// Find the set of candidates with valid over-approximations
					var assumeTrueCandidates = new HashSet<int>(currCandidates);
					assumeTrueCandidates.ExceptWith(block);
					summaryComputation.compute(assumeTrueCandidates, bound);
				}
				*/

				/*
                if (useConcurrentSolver)
                {
                    return ret;
                }*/

				// Nothing more can be done with current recursion bound. 
				return Outcome.ReachedBound;
			}

			Contract.Assert(ret == Outcome.Errors);

			prover.LogComment(";;;;;;;;;;;; Overapprox mode end ;;;;;;;;;;");

			return ret;
		}


    // Does on-demand inlining -- pushes procedure bodies on the theorem prover stack.
    private void DoExpansion(List<int>/*!*/ candidates, VerificationState vState) {
      Contract.Requires(candidates != null);
      Contract.Requires(vState.calls != null);
      Contract.Requires(vState.checker.prover != null);
      Contract.EnsuresOnThrow<UnexpectedProverOutputException>(true);

      vState.expansionCount += candidates.Count;

      var prover = vState.checker.prover;
      var calls = vState.calls;

      VCExpr exprToPush = VCExpressionGenerator.True;
      Contract.Assert(exprToPush != null);
      foreach (int id in candidates) {
        VCExprNAry expr = calls.id2Candidate[id];
        Contract.Assert(expr != null);
        string procName = cce.NonNull(expr.Op as VCExprBoogieFunctionOp).Func.Name;
        if (!implName2StratifiedInliningInfo.ContainsKey(procName)) continue;

        StratifiedInliningInfo info = implName2StratifiedInliningInfo[procName];
        info.GenerateVC();
        //Console.WriteLine("Inlining {0}", procName);
        VCExpr expansion = cce.NonNull(info.vcexpr);

        // Instantiate the "forall" variables
        Dictionary<VCExprVar, VCExpr> substForallDict = new Dictionary<VCExprVar, VCExpr>();
        Contract.Assert(info.interfaceExprVars.Count == expr.Length);
        for (int i = 0; i < info.interfaceExprVars.Count; i++) {
          substForallDict.Add(info.interfaceExprVars[i], expr[i]);
        }
        VCExprSubstitution substForall = new VCExprSubstitution(substForallDict, new Dictionary<TypeVariable, Microsoft.Boogie.Type>());

        SubstitutingVCExprVisitor subst = new SubstitutingVCExprVisitor(prover.VCExprGen);
        Contract.Assert(subst != null);
        expansion = subst.Mutate(expansion, substForall);

        // Instantiate and declare the "exists" variables
        Dictionary<VCExprVar, VCExpr> substExistsDict = new Dictionary<VCExprVar, VCExpr>();
        foreach (VCExprVar v in info.privateExprVars) {
          Contract.Assert(v != null);
          string newName = v.Name + "_si_" + newVarCnt.ToString();
          newVarCnt++;
          prover.Context.DeclareConstant(new Constant(Token.NoToken, new TypedIdent(Token.NoToken, newName, v.Type)), false, null);
          substExistsDict.Add(v, prover.VCExprGen.Variable(newName, v.Type));
        }
        if (CommandLineOptions.Clo.SIBoolControlVC)
        {
            // record the mapping for control booleans (for tracing the path later)
            calls.candiate2block2controlVar[id] = new Dictionary<Block, VCExpr>();
            foreach (var tup in info.blockToControlVar)
            {
                calls.candiate2block2controlVar[id].Add(tup.Key,
                    substExistsDict[tup.Value]);
            }
        }
        if (CommandLineOptions.Clo.ModelViewFile != null) {
          SaveSubstitution(vState, id, substForallDict, substExistsDict);
        }
        VCExprSubstitution substExists = new VCExprSubstitution(substExistsDict, new Dictionary<TypeVariable, Microsoft.Boogie.Type>());

        subst = new SubstitutingVCExprVisitor(prover.VCExprGen);
        expansion = subst.Mutate(expansion, substExists);

        if (!calls.currCandidates.Contains(id)) {
          Console.WriteLine("Don't know what we just expanded");
        }

        calls.currCandidates.Remove(id);

        // Record the new set of candidates and rename absy labels
        calls.currInlineCount = id;
        calls.setCurrProc(procName);
        expansion = calls.Mutate(expansion, true);

        //expansion = checker.VCExprGen.Eq(calls.id2ControlVar[id], expansion);
        expansion = prover.VCExprGen.Implies(calls.id2ControlVar[id], expansion);
        calls.id2VC.Add(id, expansion);

        exprToPush = prover.VCExprGen.And(exprToPush, expansion);
      }
      //vState.checker.prover.Assert(exprToPush, true);
      //vState.vcSize += SizeComputingVisitor.ComputeSize(exprToPush);

			if (useConcurrentSolver)
			{
				// create the VC (cached in id2VC) but do not assert it yet!
			}
			else
			{
				vState.checker.prover.Assert(exprToPush, true);
				vState.vcSize += SizeComputingVisitor.ComputeSize(exprToPush);
			}
    }

    private void SaveSubstitution(VerificationState vState, int id,
      Dictionary<VCExprVar, VCExpr> substForallDict, Dictionary<VCExprVar, VCExpr> substExistsDict) {
      var prover = vState.checker.prover;
      var calls = vState.calls;
      Boogie2VCExprTranslator translator = prover.Context.BoogieExprTranslator;
      VCExprVar mvStateConstant = translator.LookupVariable(ModelViewInfo.MVState_ConstantDef);
      substExistsDict.Add(mvStateConstant, prover.VCExprGen.Integer(BigNum.FromInt(id)));
      Dictionary<VCExprVar, VCExpr> mapping = new Dictionary<VCExprVar, VCExpr>();
      foreach (var key in substForallDict.Keys)
        mapping[key] = substForallDict[key];
      foreach (var key in substExistsDict.Keys)
        mapping[key] = substExistsDict[key];
      calls.id2Vars[id] = mapping;
    }

    // Uniquely identifies a procedure call (the call expr, instance)
    public class BoogieCallExpr : IEquatable<BoogieCallExpr> {
      public NAryExpr expr;
      public int inlineCnt;

      public BoogieCallExpr(NAryExpr expr, int inlineCnt) {
        this.expr = expr;
        this.inlineCnt = inlineCnt;
      }

      public override int GetHashCode() {
        return expr.GetHashCode() + 131 * inlineCnt.GetHashCode();
      }

      public override bool Equals(object obj) {
        BoogieCallExpr that = obj as BoogieCallExpr;
        return (expr == that.expr && inlineCnt == that.inlineCnt);
      }

      public bool Equals(BoogieCallExpr that) {
        return (expr == that.expr && inlineCnt == that.inlineCnt);
      }
    }

    // This class is used to traverse VCs and do the following:
    // -- collect the set of FunctionCall nodes and label them with a unique string
    // -- Rename all other labels (so that calling this on the same VC results in 
    //    VCs with different labels each time)
    public class FCallHandler : MutatingVCExprVisitor<bool> {
      public Dictionary<string/*!*/, StratifiedInliningInfo/*!*/>/*!*/ implName2StratifiedInliningInfo;
      public readonly Dictionary<int, Absy>/*!*/ mainLabel2absy;
      public Dictionary<BoogieCallExpr/*!*/, int>/*!*/ boogieExpr2Id;
      public Dictionary<BoogieCallExpr/*!*/, VCExpr>/*!*/ recordExpr2Var;
      public Dictionary<int, VCExprNAry/*!*/>/*!*/ id2Candidate;
      public Dictionary<int, VCExprVar/*!*/>/*!*/ id2ControlVar;
      public Dictionary<int, VCExpr> id2VC;
      public Dictionary<string/*!*/, int>/*!*/ label2Id;
      // candidate to block to Bool Control variable
      public Dictionary<int, Dictionary<Block, VCExpr>> candiate2block2controlVar;
      // Stores the candidate from which this one originated
      public Dictionary<int, int> candidateParent;
	  // Mapping from parents to children
	  public Dictionary<int, List<int>> candidateChildren;
	  // Mapping from candidate Id to the "si_unique_call" id that led to 
      // this candidate. This is useful for getting persistent names for
      // candidates
	  public Dictionary<int, int> candidate2callId;
      // A cache for candidate id to its persistent name
      public Dictionary<int, string> persistentNameCache;
      // Inverse of the above map
      public Dictionary<string, int> persistentNameInv;
      // Used to record candidates recently added
      public HashSet<int> recentlyAddedCandidates;
      // Name of main procedure
      private string mainProcName;
      // A map from candidate id to the VCExpr that represents its
      // first argument (used for obtaining concrete values in error trace)
      public Dictionary<int, VCExpr> argExprMap;

      // map from candidate to summary candidates
      public Dictionary<int, List<Tuple<VCExprVar, VCExpr>>> summaryCandidates;
      private Dictionary<string, List<Tuple<VCExprVar, VCExpr>>> summaryTemp;
      // set of all boolean guards of summaries
      public HashSet<VCExprVar> allSummaryConst;

      public HashSet<int> forcedCandidates;

      // User info -- to decrease/increase calculation of recursion bound
      public Dictionary<int, int> recursionIncrement;
      public Dictionary<string, int> extraRecursion;

      public HashSet<int> currCandidates;
      [ContractInvariantMethod]
      void ObjectInvariant() {
        Contract.Invariant(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
        Contract.Invariant(mainLabel2absy != null);
        Contract.Invariant(boogieExpr2Id != null);
        Contract.Invariant(cce.NonNullDictionaryAndValues(id2Candidate));
        Contract.Invariant(cce.NonNullDictionaryAndValues(id2ControlVar));
        Contract.Invariant(label2Id != null);
      }

      // Name of the procedure whose VC we're mutating
      string currProc;

      // The 0^th candidate is main
      static int candidateCount = 1;
      public int currInlineCount;

	  public int argCopyCounter = 0;
	  public Dictionary<int, VCExpr> id2FreshParamAsgn;

      public Dictionary<int, Dictionary<VCExprVar, VCExpr>> id2Vars;

      public FCallHandler(VCExpressionGenerator/*!*/ gen,
                            Dictionary<string/*!*/, StratifiedInliningInfo/*!*/>/*!*/ implName2StratifiedInliningInfo,
                            string mainProcName, Dictionary<int, Absy>/*!*/ mainLabel2absy)
        : base(gen) {
        Contract.Requires(gen != null);
        Contract.Requires(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
        Contract.Requires(mainLabel2absy != null);
        this.implName2StratifiedInliningInfo = implName2StratifiedInliningInfo;
        this.mainProcName = mainProcName;
        this.mainLabel2absy = mainLabel2absy;
        id2Candidate = new Dictionary<int, VCExprNAry>();
		id2FreshParamAsgn = new Dictionary<int, VCExpr>();
        id2ControlVar = new Dictionary<int, VCExprVar>();
        boogieExpr2Id = new Dictionary<BoogieCallExpr, int>();
        label2Id = new Dictionary<string, int>();
        currCandidates = new HashSet<int>();
        currInlineCount = 0;
        currProc = null;
        labelRenamer = new Dictionary<string, int>();
        labelRenamerInv = new Dictionary<string, string>();
        candidateParent = new Dictionary<int, int>();
        //callGraphMapping = new Dictionary<int, int>();
        recursionIncrement = new Dictionary<int, int>();
        candidate2callId = new Dictionary<int, int>();
        persistentNameCache = new Dictionary<int, string>();
        persistentNameInv = new Dictionary<string, int>();
        persistentNameCache[0] = "0";
        persistentNameInv["0"] = 0;
        recentlyAddedCandidates = new HashSet<int>();
        argExprMap = new Dictionary<int, VCExpr>();
        recordExpr2Var = new Dictionary<BoogieCallExpr, VCExpr>();
        candiate2block2controlVar = new Dictionary<int, Dictionary<Block, VCExpr>>();

        forcedCandidates = new HashSet<int>();
        extraRecursion = new Dictionary<string, int>();

        id2Vars = new Dictionary<int, Dictionary<VCExprVar, VCExpr>>();
        summaryCandidates = new Dictionary<int, List<Tuple<VCExprVar, VCExpr>>>();
        summaryTemp = new Dictionary<string, List<Tuple<VCExprVar, VCExpr>>>();
        allSummaryConst = new HashSet<VCExprVar>();
        id2VC = new Dictionary<int, VCExpr>();

		candidateChildren = new Dictionary<int, List<int>>();
		candidateChildren[0] = new List<int>();
      }

			public FCallHandler(VCExpressionGenerator/*!*/ gen,
				Dictionary<string/*!*/, StratifiedInliningInfo/*!*/>/*!*/ implName2StratifiedInliningInfo,
				FCallHandler calls)
				: base(gen)
			{
				Contract.Requires(gen != null);
				Contract.Requires(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
				Contract.Requires(mainLabel2absy != null);
				this.implName2StratifiedInliningInfo = implName2StratifiedInliningInfo;
				this.mainProcName = calls.mainProcName;
				this.mainLabel2absy = ConcurrentContext.Copy(calls.mainLabel2absy);
				id2Candidate = ConcurrentContext.Copy(calls.id2Candidate);
				id2FreshParamAsgn = ConcurrentContext.Copy(calls.id2FreshParamAsgn);
				id2ControlVar = ConcurrentContext.Copy(calls.id2ControlVar);
				boogieExpr2Id = ConcurrentContext.Copy(calls.boogieExpr2Id);
				label2Id = ConcurrentContext.Copy(calls.label2Id);
				currCandidates = ConcurrentContext.Copy(calls.currCandidates);
				this.currInlineCount = calls.currInlineCount;
				//this.candidateCount = calls.candidateCount;
				this.argCopyCounter = calls.argCopyCounter;
				currProc = calls.currProc;
				labelRenamer = ConcurrentContext.Copy(calls.labelRenamer);
				labelRenamerInv = ConcurrentContext.Copy(calls.labelRenamerInv);
				candidateParent = ConcurrentContext.Copy(calls.candidateParent);
				//callGraphMapping = new Dictionary<int, int>();
				recursionIncrement = ConcurrentContext.Copy(calls.recursionIncrement);
				candidate2callId = ConcurrentContext.Copy(calls.candidate2callId);
				persistentNameCache = ConcurrentContext.Copy(calls.persistentNameCache);
				persistentNameInv = ConcurrentContext.Copy(calls.persistentNameInv);
				//persistentNameCache[0] = "0";
				//persistentNameInv["0"] = 0;
				recentlyAddedCandidates = ConcurrentContext.Copy(calls.recentlyAddedCandidates);
				argExprMap = ConcurrentContext.Copy(calls.argExprMap);
				recordExpr2Var = ConcurrentContext.Copy(calls.recordExpr2Var);

				forcedCandidates = ConcurrentContext.Copy(calls.forcedCandidates);
				extraRecursion = ConcurrentContext.Copy(calls.extraRecursion);

				id2Vars = ConcurrentContext.Copy(calls.id2Vars, true);
				summaryCandidates = ConcurrentContext.Copy(calls.summaryCandidates, true);
				summaryTemp = ConcurrentContext.Copy(calls.summaryTemp, true);
				allSummaryConst = ConcurrentContext.Copy(calls.allSummaryConst);
				id2VC = ConcurrentContext.Copy(calls.id2VC);

				candidateChildren = ConcurrentContext.DeepCopy(calls.candidateChildren);
				candidateChildren[0] = ConcurrentContext.Copy(calls.candidateChildren[0]);
			}


      public void Clear() {
        currCandidates = new HashSet<int>();
      }

      // Return the set of all candidates
      public HashSet<int> getAllCandidates() {
        var ret = new HashSet<int>(candidateParent.Keys);
        ret.Add(0);
        return ret;
      }

      // Given a candidate "id", let proc(id) be the
      // procedure corresponding to id. This procedure returns
      // the number of times proc(id) appears as an ancestor
      // of id. This is the same as the number of times we've
      // recursed on proc(id)
      public int getRecursionBound(int id) {
        int ret = 1;
        var str = getProc(id);

        while (candidateParent.ContainsKey(id)) {
          if (recursionIncrement.ContainsKey(id)) ret += recursionIncrement[id];
          id = candidateParent[id];
          if (getProc(id) == str && !forcedCandidates.Contains(id)) ret++;
        }

        // Usual
        if (!extraRecursion.ContainsKey(str))
            return ret;

        // Usual
        if (ret <= CommandLineOptions.Clo.RecursionBound - 1)
            return ret;

        // Special
        if (ret >= CommandLineOptions.Clo.RecursionBound &&
            ret <= CommandLineOptions.Clo.RecursionBound + extraRecursion[str] - 1)
            return CommandLineOptions.Clo.RecursionBound - 1;

        // Special
        return ret - extraRecursion[str];
      }

      // This procedure returns the stack depth of the candidate
      // (distance from main)
      public int getStackDepth(int id)
      {
          int ret = 1;

          while (candidateParent.ContainsKey(id))
          {
              ret++;
              id = candidateParent[id];
          }

          return ret;
      }

      // Set user-define increment/decrement to recursionBound
      public void setRecursionIncrement(int id, int incr) {
        if (recursionIncrement.ContainsKey(id))
          recursionIncrement[id] = incr;
        else
          recursionIncrement.Add(id, incr);
      }

      // Returns the name of the procedure corresponding to candidate id
      public string getProc(int id) {
        if (id == 0) return mainProcName;

        return (id2Candidate[id].Op as VCExprBoogieFunctionOp).Func.Name;
      }

      // Get a unique id for this candidate (dependent only on the Call
      // graph of the program). The persistent id is:
      // 0: for main
      // a_b_c: where a is the persistent id of parent, and b is the procedure name
      //        and c is the unique call id (if any)
      public string getPersistentId(int top_id) {
        if (top_id == 0) return "0";
        Debug.Assert(candidateParent.ContainsKey(top_id));
        if (persistentNameCache.ContainsKey(top_id))
          return persistentNameCache[top_id];

        var parent_id = getPersistentId(candidateParent[top_id]);
        var call_id = candidate2callId.ContainsKey(top_id) ? candidate2callId[top_id] : -1;
        var ret = string.Format("{0}_131_{1}_131_{2}", parent_id, getProc(top_id), call_id);
        persistentNameCache[top_id] = ret;
        persistentNameInv[ret] = top_id;
        return ret;
      }

      public int getCandidateFromGraphNode(string n) {
        if (!persistentNameInv.ContainsKey(n)) {
          return -1;
        }
        return persistentNameInv[n];
      }

			private int GetNewId(VCExprNAry vc)
			{
				Contract.Requires(vc != null);
				int id;

				lock (RefinementFuzzing.Settings.lockThis)
					//using (RefinementFuzzing.Settings.timedLock.Lock()) 
				{
					id = candidateCount;
				}

				#if false
				if (RefinementFuzzing.Settings.FreshParamCopies)
				{
				List<VCExpr> newSubExprs = new List<VCExpr>();
				VCExpr formalActualAsgn = VCExpressionGenerator.True;
				for (int i = 0; i < vc.Count(); i++)
				{
				if (vc[i] is VCExprVar)
				{
				string name = vc[i].ToString();

				if (name.Contains("_@copy_"))
				name = name.Substring(0, name.IndexOf("_@copy_"));

				var newVar = Gen.Variable(name + "_@copy_" + argCopyCounter, vc[i].Type);

				argCopyCounter++;

				newSubExprs.Add(newVar);
				formalActualAsgn = Gen.And(formalActualAsgn, Gen.Eq(newVar, vc[i]));
				}
				else
				{
				newSubExprs.Add(vc[i]);
				Contract.Assert(vc[i] is VCExprLiteral);
				}
				}

				// Need to do this for tree interpolants
				VCExprNAry newVC = Gen.Function(vc.Op,
				newSubExprs, vc.TypeArguments) as VCExprNAry;

				id2Candidate[id] = newVC;

				id2FreshParamAsgn[id] = formalActualAsgn;

				}
				else
				id2Candidate[id] = vc;
				#endif

				if (RefinementFuzzing.Settings.FreshParamCopies)
				{
					List<VCExpr> newSubExprs = new List<VCExpr>();
					VCExpr formalActualAsgn = VCExpressionGenerator.True;
					for (int i = 0; i < vc.Count(); i++)
					{
						string name = null;

						if (vc[i] is VCExprVar)
						{
							name = vc[i].ToString();

							if (name.Contains("_@copy_"))
								name = name.Substring(0, name.IndexOf("_@copy_"));
						}
						else
						{
							name = "newtmp";

							Contract.Assert(vc[i] is VCExprLiteral);
						}

						var newVar = Gen.Variable(name + "_@copy_" + argCopyCounter, vc[i].Type);

						argCopyCounter++;

						newSubExprs.Add(newVar);
						formalActualAsgn = Gen.And(formalActualAsgn, Gen.Eq(newVar, vc[i]));
					}

					// Need to do this for tree interpolants
					VCExprNAry newVC = Gen.Function(vc.Op,
						newSubExprs, vc.TypeArguments) as VCExprNAry;

					id2Candidate[id] = newVC;

					id2FreshParamAsgn[id] = formalActualAsgn;

				}
				else
					id2Candidate[id] = vc;

				id2ControlVar[id] = Gen.Variable("si_control_var_bool_" + id.ToString(), Microsoft.Boogie.Type.Bool);

				lock (RefinementFuzzing.Settings.lockThis)
					//using (RefinementFuzzing.Settings.timedLock.Lock()) 
				{
					candidateCount++;
				}
				currCandidates.Add(id);
				recentlyAddedCandidates.Add(id);

				return id;
			}

      private string GetLabel(int id) {
        Contract.Ensures(Contract.Result<string>() != null);

        string ret = "si_fcall_" + id.ToString();
        if (!label2Id.ContainsKey(ret))
          label2Id[ret] = id;

        return ret;
      }

      public int GetId(string label) {
        Contract.Requires(label != null);
        if (!label2Id.ContainsKey(label))
          return -1;
        return label2Id[label];
      }

      Dictionary<string, int> labelRenamer;
      Dictionary<string, string> labelRenamerInv;

      public string RenameAbsyLabel(string label) {
        Contract.Requires(label != null);
        Contract.Requires(label.Length >= 1);
        Contract.Ensures(Contract.Result<string>() != null);

        // Remove the sign from the label
        string nosign = label.Substring(1);
        var ret = "si_inline_" + currInlineCount.ToString() + "_" + nosign;

        if (!labelRenamer.ContainsKey(ret)) {
          var c = labelRenamer.Count + 11; // two digit labels only
          labelRenamer.Add(ret, c);
          labelRenamerInv.Add(c.ToString(), ret);
        }
        return labelRenamer[ret].ToString();
      }

      public string ParseRenamedAbsyLabel(string label, int cnt) {
        Contract.Requires(label != null);
        if (!labelRenamerInv.ContainsKey(label)) {
          return null;
        }
        var str = labelRenamerInv[label];
        var prefix = "si_inline_" + cnt.ToString() + "_";
        if (!str.StartsWith(prefix)) return null;
        return str.Substring(prefix.Length);
      }

      public void setCurrProc(string name) {
        Contract.Requires(name != null);
        currProc = name;
        Contract.Assert(implName2StratifiedInliningInfo.ContainsKey(name));
      }

      public void setCurrProcAsMain() {
        currProc = "";
      }

      // Return the formula (candidate IFF false)
      public VCExpr getFalseExpr(int candidateId) {
        //return Gen.Eq(VCExpressionGenerator.False, id2ControlVar[candidateId]);
        return Gen.Not(id2ControlVar[candidateId]);
      }

      // Return the formula (candidate IFF true)
      public VCExpr getTrueExpr(int candidateId) {
        return Gen.Eq(VCExpressionGenerator.True, id2ControlVar[candidateId]);
      }

      public Dictionary<int, Absy> getLabel2absy() {
        Contract.Ensures(Contract.Result<Dictionary<int, Absy>>() != null);

        Contract.Assert(currProc != null);
        if (currProc == "") {
          return mainLabel2absy;
        }
        return cce.NonNull(implName2StratifiedInliningInfo[currProc].label2absy);
      }

      // Finds labels and changes them:
      //   si_fcall_id:  if "id" corresponds to a tracked procedure call, then
      //                 si_control_var_candidateId
      //   si_fcall_id:  if "id" does not corresponds to a tracked procedure call, then
      //                 delete
      //   num:          si_inline_num
      //  
      protected override VCExpr/*!*/ UpdateModifiedNode(VCExprNAry/*!*/ originalNode,
                                                    List<VCExpr/*!*/>/*!*/ newSubExprs,
        // has any of the subexpressions changed?
                                                    bool changed,
                                                    bool arg) {
        //Contract.Requires(originalNode != null);
        //Contract.Requires(cce.NonNullElements(newSubExprs));
        Contract.Ensures(Contract.Result<VCExpr>() != null);

        VCExpr ret;
        if (changed)
          ret = Gen.Function(originalNode.Op,
                             newSubExprs, originalNode.TypeArguments);
        else
          ret = originalNode;

        VCExprLabelOp lop = originalNode.Op as VCExprLabelOp;
        if (lop == null) return ret;
        if (!(ret is VCExprNAry)) return ret;

        VCExprNAry retnary = (VCExprNAry)ret;
        Contract.Assert(retnary != null);
        string prefix = "si_fcall_"; // from Wlp.ssc::Cmd(...)
        if (lop.label.Substring(1).StartsWith(prefix)) {
          int id = Int32.Parse(lop.label.Substring(prefix.Length + 1));
          Dictionary<int, Absy> label2absy = getLabel2absy();
          Absy cmd = label2absy[id] as Absy;
          //label2absy.Remove(id);

          Contract.Assert(cmd != null);
          AssumeCmd acmd = cmd as AssumeCmd;
          Contract.Assert(acmd != null);
          NAryExpr naryExpr = acmd.Expr as NAryExpr;
          Contract.Assert(naryExpr != null);

          string calleeName = naryExpr.Fun.FunctionName;

          VCExprNAry callExpr = retnary[0] as VCExprNAry;

          if (implName2StratifiedInliningInfo.ContainsKey(calleeName)) {
            Contract.Assert(callExpr != null);
            int candidateId = GetNewId(callExpr);
            boogieExpr2Id[new BoogieCallExpr(naryExpr, currInlineCount)] = candidateId;
            candidateParent[candidateId] = currInlineCount;
            candiate2block2controlVar[candidateId] = new Dictionary<Block, VCExpr>();

            string label = GetLabel(candidateId);
            var unique_call_id = QKeyValue.FindIntAttribute(acmd.Attributes, "si_unique_call", -1);
            if (unique_call_id != -1)
              candidate2callId[candidateId] = unique_call_id;

			// Handle
			candidateChildren[currInlineCount].Add(candidateId);
			candidateChildren[candidateId] = new List<int>();

            //return Gen.LabelPos(label, callExpr);
            return Gen.LabelPos(label, id2ControlVar[candidateId]);
          }
          else if (calleeName.StartsWith(recordProcName)) {
            Contract.Assert(callExpr != null);
            Debug.Assert(callExpr.Length == 1);
            Debug.Assert(callExpr[0] != null);
            recordExpr2Var[new BoogieCallExpr(naryExpr, currInlineCount)] = callExpr[0];
            return callExpr;
          }
          else {
              // callExpr can be null; this happens when the FunctionCall was on a
              // pure function (not procedure) and the function got inlined
              return retnary[0];
          }
        }

        // Else, rename label
        string newLabel = RenameAbsyLabel(lop.label);
        if (lop.pos) {
          return Gen.LabelPos(newLabel, retnary[0]);
        }
        else {
          return Gen.LabelNeg(newLabel, retnary[0]);
        }

      }

      // Upgrades summaryTemp to summaryCandidates by matching ensure clauses with
      // the appropriate candidate they came from
      public void matchSummaries() {
        var id2Set = new Dictionary<string, List<Tuple<int, HashSet<VCExprVar>>>>();
        foreach (var id in recentlyAddedCandidates) {
          var collect = new CollectVCVars();
          var proc = getProc(id);
          if (!id2Set.ContainsKey(proc)) id2Set.Add(proc, new List<Tuple<int, HashSet<VCExprVar>>>());
          id2Set[proc].Add(Tuple.Create(id, collect.Collect(id2Candidate[id], true)));
        }

        foreach (var kvp in summaryTemp) {
          Contract.Assert(id2Set.ContainsKey(kvp.Key));
          var ls = id2Set[kvp.Key];
          foreach (var tup in kvp.Value) {
            var collect = new CollectVCVars();
            var s1 = collect.Collect(tup.Item2, true);
            var found = false;
            foreach (var t in ls) {
              var s2 = t.Item2;
              if (s1.IsSubsetOf(s2)) {
                if (!summaryCandidates.ContainsKey(t.Item1))
                  summaryCandidates.Add(t.Item1, new List<Tuple<VCExprVar, VCExpr>>());
                summaryCandidates[t.Item1].Add(tup);
                allSummaryConst.Add(tup.Item1);
                found = true;
                break;
              }
            }
            Contract.Assert(found);
          }
        }
        summaryTemp.Clear();
      }

      public IEnumerable<int> getInlinedCandidates() {
        return candidateParent.Keys.Except(currCandidates).Union(new int[] { 0 });
      }

    } // end FCallHandler

    // Collects the set of all VCExprVar in a given VCExpr
    class CollectVCVars : CollectingVCExprVisitor<HashSet<VCExprVar>, bool> {
      public override HashSet<VCExprVar> Visit(VCExprVar node, bool arg) {
        var ret = new HashSet<VCExprVar>();
        ret.Add(node);
        return ret;
      }

      protected override HashSet<VCExprVar> CombineResults(List<HashSet<VCExprVar>> results, bool arg) {
        var ret = new HashSet<VCExprVar>();
        results.Iter(s => ret.UnionWith(s));
        return ret;
      }
    }

    public class FCallInliner : MutatingVCExprVisitor<bool> {
      public Dictionary<int, VCExpr/*!*/>/*!*/ subst;
      [ContractInvariantMethod]
      void ObjectInvariant() {
        Contract.Invariant(cce.NonNullDictionaryAndValues(subst));
      }


      public FCallInliner(VCExpressionGenerator gen)
        : base(gen) {
        Contract.Requires(gen != null);
        subst = new Dictionary<int, VCExpr>();
      }

      public void Clear() {
        subst = new Dictionary<int, VCExpr>();
      }

      protected override VCExpr/*!*/ UpdateModifiedNode(VCExprNAry/*!*/ originalNode,
                                                    List<VCExpr/*!*/>/*!*/ newSubExprs,
        // has any of the subexpressions changed?
                                                    bool changed,
                                                    bool arg) {
        //Contract.Requires(originalNode != null);Contract.Requires(newSubExprs != null);
        Contract.Ensures(Contract.Result<VCExpr>() != null);

        VCExpr ret;
        if (changed)
          ret = Gen.Function(originalNode.Op, newSubExprs, originalNode.TypeArguments);
        else
          ret = originalNode;

        VCExprLabelOp lop = originalNode.Op as VCExprLabelOp;
        if (lop == null) return ret;
        if (!(ret is VCExprNAry)) return ret;

        string prefix = "si_fcall_"; // from FCallHandler::GetLabel
        if (lop.label.Substring(1).StartsWith(prefix)) {
          int id = Int32.Parse(lop.label.Substring(prefix.Length + 1));
          if (subst.ContainsKey(id)) {
            return subst[id];
          }
        }
        return ret;
      }

    } // end FCallInliner



    public class StratifiedInliningErrorReporter : ProverInterface.ErrorHandler {
      Dictionary<string, StratifiedInliningInfo> implName2StratifiedInliningInfo;
      ProverInterface theoremProver;
      public VerifierCallback callback;
      FCallHandler calls;
      public StratifiedInliningInfo mainInfo;
      StratifiedVC mainVC;

	  public bool generateTrace;
	  public SoftPartition currSoftPartition;
	  public VCExpr vcCache = null;

      public bool underapproximationMode;
      public List<int> candidatesToExpand;
      public List<StratifiedCallSite> callSitesToExpand;

      [ContractInvariantMethod]
      void ObjectInvariant() {
        Contract.Invariant(candidatesToExpand != null);
        Contract.Invariant(mainInfo != null);
        Contract.Invariant(callback != null);
        Contract.Invariant(theoremProver != null);
        Contract.Invariant(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
      }


      public StratifiedInliningErrorReporter(Dictionary<string, StratifiedInliningInfo> implName2StratifiedInliningInfo,
                                             ProverInterface theoremProver, VerifierCallback callback,
                                             StratifiedInliningInfo mainInfo) {
        Contract.Requires(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
        Contract.Requires(theoremProver != null);
        Contract.Requires(callback != null);
        Contract.Requires(mainInfo != null);
        this.implName2StratifiedInliningInfo = implName2StratifiedInliningInfo;
        this.theoremProver = theoremProver;
        this.callback = callback;
        this.mainInfo = mainInfo;
        this.underapproximationMode = false;
        this.calls = null;
        this.candidatesToExpand = new List<int>();
		this.generateTrace = false;
      }

      public StratifiedInliningErrorReporter(Dictionary<string, StratifiedInliningInfo> implName2StratifiedInliningInfo,
                                             ProverInterface theoremProver, VerifierCallback callback,
                                             StratifiedVC mainVC) {
        Contract.Requires(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
        Contract.Requires(theoremProver != null);
        Contract.Requires(callback != null);
        Contract.Requires(mainVC != null);
        this.implName2StratifiedInliningInfo = implName2StratifiedInliningInfo;
        this.theoremProver = theoremProver;
        this.callback = callback;
        this.mainVC = mainVC;
        this.underapproximationMode = false;
        this.candidatesToExpand = new List<int>();
		this.generateTrace = false;
      }

			public StratifiedInliningErrorReporter(Dictionary<string, StratifiedInliningInfo> implName2StratifiedInliningInfo,
				ProverInterface theoremProver, StratifiedInliningErrorReporter parentErrReporter)
			{
				Contract.Requires(cce.NonNullDictionaryAndValues(implName2StratifiedInliningInfo));
				Contract.Requires(theoremProver != null);
				Contract.Requires(callback != null);
				Contract.Requires(mainInfo != null);
				this.implName2StratifiedInliningInfo = implName2StratifiedInliningInfo;
				this.theoremProver = theoremProver;
				this.callback = parentErrReporter.callback;
				this.mainInfo = parentErrReporter.mainInfo;
				this.underapproximationMode = false;
				this.calls = null;
				this.mainVC = parentErrReporter.mainVC;
				this.currSoftPartition = parentErrReporter.currSoftPartition;
				this.candidatesToExpand = ConcurrentContext.Copy(parentErrReporter.candidatesToExpand);
				this.callSitesToExpand = ConcurrentContext.Copy(parentErrReporter.callSitesToExpand);
				this.generateTrace = parentErrReporter.generateTrace;
			}

	  public void SetCandidateHandler(FCallHandler calls) {
        Contract.Requires(calls != null);
        this.calls = calls;
      }

      List<Tuple<int, int>> orderedStateIds;

      private Model.Element GetModelValue(Model m, Variable v, int candidateId) {
        // first, get the unique name
        string uniqueName;

        VCExprVar vvar = theoremProver.Context.BoogieExprTranslator.TryLookupVariable(v);
        if (vvar == null) {
          uniqueName = v.Name;
        }
        else {
          if (candidateId != 0) {
            Dictionary<VCExprVar, VCExpr> mapping = calls.id2Vars[candidateId];
            if (mapping.ContainsKey(vvar)) {
              VCExpr e = mapping[vvar];
              if (e is VCExprLiteral) {
                VCExprLiteral lit = (VCExprLiteral)e;
                return m.MkElement(lit.ToString());
              }
              vvar = (VCExprVar)mapping[vvar];
            }
          }
          uniqueName = theoremProver.Context.Lookup(vvar);
        }

        var f = m.TryGetFunc(uniqueName);
        if (f == null)
          return m.MkFunc("@undefined", 0).GetConstant();
        return f.GetConstant();
      }

      public readonly static int CALL = -1;
      public readonly static int RETURN = -2;

      public void PrintModel(Model model) {
        var filename = CommandLineOptions.Clo.ModelViewFile;
        if (model == null || filename == null) return;

        if (filename == "-") {
          model.Write(Console.Out);
          Console.Out.Flush();
        }
        else {
          using (var wr = new StreamWriter(filename, !Counterexample.firstModelFile)) {
            Counterexample.firstModelFile = false;
            model.Write(wr);
          }
        }
      }

      private void GetModelWithStates(Model m) {
        if (m == null) return;
        var mvInfo = mainInfo.mvInfo;
        var mvstates = m.TryGetFunc("$mv_state");
        if (mvstates == null)
          return;

        Contract.Assert(mvstates.Arity == 2);

        foreach (Variable v in mvInfo.AllVariables) {
          m.InitialState.AddBinding(v.Name, GetModelValue(m, v, 0));
        }

        int lastCandidate = 0;
        int lastCapturePoint = CALL;
        for (int i = 0; i < this.orderedStateIds.Count; ++i) {
          var s = orderedStateIds[i];
          int candidate = s.Item1;
          int capturePoint = s.Item2;
          string implName = calls.getProc(candidate);
          ModelViewInfo info = candidate == 0 ? mvInfo : implName2StratifiedInliningInfo[implName].mvInfo;

          if (capturePoint == CALL || capturePoint == RETURN) {
            lastCandidate = candidate;
            lastCapturePoint = capturePoint;
            continue;
          }

          Contract.Assume(0 <= capturePoint && capturePoint < info.CapturePoints.Count);
          VC.ModelViewInfo.Mapping map = info.CapturePoints[capturePoint];
          var prevInc = (lastCapturePoint != CALL && lastCapturePoint != RETURN && candidate == lastCandidate)
            ? info.CapturePoints[lastCapturePoint].IncarnationMap : new Dictionary<Variable, Expr>();
          var cs = m.MkState(map.Description);

          foreach (Variable v in info.AllVariables) {
            var e = (Expr)map.IncarnationMap[v];

            if (e == null) {
              if (lastCapturePoint == CALL || lastCapturePoint == RETURN) {
                cs.AddBinding(v.Name, GetModelValue(m, v, candidate));
              }
              continue;
            }

            if (lastCapturePoint != CALL && lastCapturePoint != RETURN && prevInc[v] == e) continue; // skip unchanged variables

            Model.Element elt;
            if (e is IdentifierExpr) {
              IdentifierExpr ide = (IdentifierExpr)e;
              elt = GetModelValue(m, ide.Decl, candidate);
            }
            else if (e is LiteralExpr) {
              LiteralExpr lit = (LiteralExpr)e;
              elt = m.MkElement(lit.Val.ToString());
            }
            else {
              Contract.Assume(false);
              elt = m.MkFunc(e.ToString(), 0).GetConstant();
            }
            cs.AddBinding(v.Name, elt);
          }

          lastCandidate = candidate;
          lastCapturePoint = capturePoint;
        }

        return;
      }

      public override void OnResourceExceeded(string message, IEnumerable<Tuple<AssertCmd, TransferCmd>> assertCmds = null)
      {
          //Contract.Requires(message != null);
      }

      public override void OnModel(IList<string/*!*/>/*!*/ labels, Model model, ProverInterface.Outcome proverOutcome) {
        if (CommandLineOptions.Clo.PrintErrorModel >= 1 && model != null) {
          model.Write(ErrorReporter.ModelWriter);
          ErrorReporter.ModelWriter.Flush();
        }

        // Timeout?
        if (proverOutcome != ProverInterface.Outcome.Invalid)
            return;

        candidatesToExpand = new List<int>();
        orderedStateIds = new List<Tuple<int, int>>();
        var cex = GenerateTrace(labels, model, 0, mainInfo.impl, mainInfo.mvInfo);

        if (underapproximationMode && cex != null) {
          //Debug.Assert(candidatesToExpand.All(calls.isSkipped));
          GetModelWithStates(model);
          callback.OnCounterexample(cex, null);
          this.PrintModel(model);
        }
      }

      private Counterexample GenerateTrace(IList<string/*!*/>/*!*/ labels, Model/*!*/ errModel,
                                           int candidateId, Implementation procImpl, ModelViewInfo mvInfo) {
        Contract.Requires(cce.NonNullElements(labels));
        Contract.Requires(procImpl != null);

        Hashtable traceNodes = new Hashtable();

        if (!CommandLineOptions.Clo.SIBoolControlVC)
        {
            foreach (string s in labels)
            {
                Contract.Assert(s != null);
                var absylabel = calls.ParseRenamedAbsyLabel(s, candidateId);

                if (absylabel == null) continue;

                Absy absy;

                if (candidateId == 0)
                {
                    absy = Label2Absy(absylabel);
                }
                else
                {
                    absy = Label2Absy(procImpl.Name, absylabel);
                }

                if (traceNodes.ContainsKey(absy))
                    System.Console.WriteLine("Warning: duplicate label: " + s + " read while tracing nodes");
                else
                    traceNodes.Add(absy, null);
            }
        }
        else
        {
            Debug.Assert(CommandLineOptions.Clo.UseProverEvaluate, "Must use prover evaluate option with boolControlVC");
            var block = procImpl.Blocks[0];
            traceNodes.Add(block, null);
            while (true)
            {
                var gc = block.TransferCmd as GotoCmd;
                if (gc == null) break;
                Block next = null;
                foreach (var succ in gc.labelTargets)
                {
                    var succtaken = (bool) theoremProver.Evaluate(calls.candiate2block2controlVar[candidateId][succ]);
                    if (succtaken)
                    {
                        next = succ;
                        traceNodes.Add(succ, null);
                        break;
                    }
                }
                Debug.Assert(next != null, "Must find a successor");
                Debug.Assert(traceNodes.ContainsKey(next), "CFG cannot be cyclic");
                block = next;
            }
        }

        List<Block> trace = new List<Block>();
        Block entryBlock = cce.NonNull(procImpl.Blocks[0]);
        Contract.Assert(entryBlock != null);
        Contract.Assert(traceNodes.Contains(entryBlock));
        trace.Add(entryBlock);

        var calleeCounterexamples = new Dictionary<TraceLocation, CalleeCounterexampleInfo>();
        Counterexample newCounterexample = GenerateTraceRec(labels, errModel, mvInfo, candidateId, entryBlock, traceNodes, trace, calleeCounterexamples);

        return newCounterexample;
      }

      private String GenerateTraceValue(Model.Element element) {
        var str = new StringWriter();
        if (element is Model.DatatypeValue) {
          var val = (Model.DatatypeValue) element;
          if (val.ConstructorName == "_" && val.Arguments[0].ToString() == "(as-array)") {
            var parens = val.Arguments[1].ToString();
            var func = element.Model.TryGetFunc(parens.Substring(1, parens.Length - 2));
            if (func != null) {
              str.Write("{");
              var appCount = 0;
              foreach (var app in func.Apps) {
                if (appCount++ > 0)
                  str.Write(",");
                str.Write("\"");
                var argCount = 0;
                foreach (var arg in app.Args) {
                  if (argCount++ > 0)
                    str.Write(",");
                  str.Write(GenerateTraceValue(arg));
                }
                str.Write("\":{0}", GenerateTraceValue(app.Result));
              }
              if (func.Else != null) {
                if (func.AppCount > 0)
                  str.Write(",");
                str.Write("\"*\":{0}", GenerateTraceValue(func.Else));
              }
              str.Write("}");
            }
          }
        }
        if (str.ToString() == "")
          str.Write(element.ToString().Replace(" ","").Replace("(","").Replace(")",""));
        return str.ToString();
      }

      private Counterexample GenerateTraceRec(
                            IList<string/*!*/>/*!*/ labels, Model/*!*/ errModel, ModelViewInfo mvInfo,
                            int candidateId,
                            Block/*!*/ b, Hashtable/*!*/ traceNodes, List<Block>/*!*/ trace,
                            Dictionary<TraceLocation/*!*/, CalleeCounterexampleInfo/*!*/>/*!*/ calleeCounterexamples) {
        Contract.Requires(cce.NonNullElements(labels));
        Contract.Requires(b != null);
        Contract.Requires(traceNodes != null);
        Contract.Requires(trace != null);
        Contract.Requires(cce.NonNullDictionaryAndValues(calleeCounterexamples));
        // After translation, all potential errors come from asserts.
        while (true) {
          List<Cmd> cmds = b.Cmds;
          TransferCmd transferCmd = cce.NonNull(b.TransferCmd);
          for (int i = 0; i < cmds.Count; i++) {
            Cmd cmd = cce.NonNull(cmds[i]);

            // Skip if 'cmd' not contained in the trace or not an assert
            if ((cmd is AssertCmd && traceNodes.Contains(cmd)) ||
                 (cmd is AssumeCmd && QKeyValue.FindBoolAttribute((cmd as AssumeCmd).Attributes, "exitAssert")))
            {
                var acmd = cmd as AssertCmd;
                if (acmd == null) { acmd = new AssertCmd(Token.NoToken, Expr.True); }
                Counterexample newCounterexample = AssertCmdToCounterexample(acmd, transferCmd, trace, errModel, mvInfo, theoremProver.Context);
                newCounterexample.AddCalleeCounterexample(calleeCounterexamples);
                return newCounterexample;
            }

            // Counterexample generation for inlined procedures
            AssumeCmd assumeCmd = cmd as AssumeCmd;
            if (assumeCmd == null)
              continue;
            NAryExpr naryExpr = assumeCmd.Expr as NAryExpr;
            if (naryExpr == null)
              continue;
            string calleeName = naryExpr.Fun.FunctionName;
            Contract.Assert(calleeName != null);

            BinaryOperator binOp = naryExpr.Fun as BinaryOperator;
            if (binOp != null && binOp.Op == BinaryOperator.Opcode.And) {
              Expr expr = naryExpr.Args[0];
              NAryExpr mvStateExpr = expr as NAryExpr;
              if (mvStateExpr != null && mvStateExpr.Fun.FunctionName == ModelViewInfo.MVState_FunctionDef.Name) {
                LiteralExpr x = mvStateExpr.Args[1] as LiteralExpr;
                orderedStateIds.Add(new Tuple<int, int>(candidateId, x.asBigNum.ToInt));
              }
            }

            if (calleeName.StartsWith(recordProcName) && (errModel != null || CommandLineOptions.Clo.UseProverEvaluate)) {
              var expr = calls.recordExpr2Var[new BoogieCallExpr(naryExpr, candidateId)];

              // Record concrete value of the argument to this procedure
              var args = new List<object>();
              if (errModel == null && CommandLineOptions.Clo.UseProverEvaluate)
              {
                  object exprv;
                  try
                  {
                      exprv = theoremProver.Evaluate(expr);
                  }
                  catch (Exception)
                  {
                      exprv = null;
                  }
                  args.Add(exprv);
              }
              else
              {
                  if (expr is VCExprIntLit)
                  {
                      args.Add(errModel.MkElement((expr as VCExprIntLit).Val.ToString()));
                  }
                  else if (expr == VCExpressionGenerator.True)
                  {
                      args.Add(errModel.MkElement("true"));
                  }
                  else if (expr == VCExpressionGenerator.False)
                  {
                      args.Add(errModel.MkElement("false"));
                  }
                  else if (expr is VCExprVar)
                  {
                      var idExpr = expr as VCExprVar;
                      string name = theoremProver.Context.Lookup(idExpr);
                      Contract.Assert(name != null);
                      Model.Func f = errModel.TryGetFunc(name);
                      if (f != null)
                      {
                          args.Add(GenerateTraceValue(f.GetConstant()));
                      }
                  }
                  else
                  {
                      Contract.Assert(false);
                  }
              }
              calleeCounterexamples[new TraceLocation(trace.Count - 1, i)] =
                   new CalleeCounterexampleInfo(null, args);
              continue;
            }

            if (!implName2StratifiedInliningInfo.ContainsKey(calleeName))
              continue;

            Contract.Assert(calls != null);

            int calleeId = calls.boogieExpr2Id[new BoogieCallExpr(naryExpr, candidateId)];

            if (calls.currCandidates.Contains(calleeId)) {
              candidatesToExpand.Add(calleeId);
            }
            else {
              orderedStateIds.Add(new Tuple<int, int>(calleeId, StratifiedInliningErrorReporter.CALL));
              var calleeInfo = implName2StratifiedInliningInfo[calleeName];
              calleeCounterexamples[new TraceLocation(trace.Count - 1, i)] =
                  new CalleeCounterexampleInfo(GenerateTrace(labels, errModel, calleeId, calleeInfo.impl, calleeInfo.mvInfo), new List<object>());
              orderedStateIds.Add(new Tuple<int, int>(candidateId, StratifiedInliningErrorReporter.RETURN));
            }
          }

          GotoCmd gotoCmd = transferCmd as GotoCmd;
          if (gotoCmd != null) {
            b = null;
            foreach (Block bb in cce.NonNull(gotoCmd.labelTargets)) {
              Contract.Assert(bb != null);
              if (traceNodes.Contains(bb)) {
                trace.Add(bb);
                b = bb;
                break;
              }
            }
            if (b != null) continue;
          }
          return null;
        }
      }

      public override Absy Label2Absy(string label) {
        //Contract.Requires(label != null);
        Contract.Ensures(Contract.Result<Absy>() != null);

        int id = int.Parse(label);
        Contract.Assert(calls != null);
        return cce.NonNull((Absy)calls.mainLabel2absy[id]);
      }

      public Absy Label2Absy(string procName, string label) {
        Contract.Requires(label != null);
        Contract.Requires(procName != null);
        Contract.Ensures(Contract.Result<Absy>() != null);

        int id = int.Parse(label);
        Dictionary<int, Absy> l2a = cce.NonNull(implName2StratifiedInliningInfo[procName]).label2absy;
        return cce.NonNull((Absy)l2a[id]);
      }

      public override void OnProverWarning(string msg) {
        //Contract.Requires(msg != null);
        callback.OnWarning(msg);
      }
    }

  } // class StratifiedVCGen

  public class EmptyErrorHandler : ProverInterface.ErrorHandler
  {
      public override void OnModel(IList<string> labels, Model model, ProverInterface.Outcome proverOutcome)
      { }
  }

  public class InvalidProgramForSecureVc : Exception
  {
      public InvalidProgramForSecureVc(string msg) :
          base(msg) { }
  }

  public class SecureVCGen : VCGen
  {
      // Z3
      ProverInterface prover;
      // Handler
      ErrorReporter handler;
      // dump file
      public static TokenTextWriter outfile = null;


      public SecureVCGen(Program program, string/*?*/ logFilePath, bool appendLogFile, List<Checker> checkers)
          : base(program, logFilePath, appendLogFile, checkers)
      {
          prover = null;
          handler = null;
          if (CommandLineOptions.Clo.SecureVcGen != "" && outfile == null)
          {
              outfile = new TokenTextWriter(new StreamWriter(CommandLineOptions.Clo.SecureVcGen));
              CommandLineOptions.Clo.PrintInstrumented = true;
              var implsToVerify = new HashSet<string>(
                  program.TopLevelDeclarations.OfType<Implementation>()
                  .Where(impl => !impl.SkipVerification)
                  .Select(impl => impl.Name));

              foreach (var decl in program.TopLevelDeclarations)
              {
                  if (decl is NamedDeclaration && implsToVerify.Contains((decl as NamedDeclaration).Name))
                      continue;
                  decl.Emit(outfile, 0);
              }
          }
      }

      private Block GetExitBlock(Implementation impl)
      {
          var exitblocks = impl.Blocks.Where(blk => blk.TransferCmd is ReturnCmd);
          if (exitblocks.Count() == 1)
              return exitblocks.First();
          // create a new exit block
          var eb = new Block(Token.NoToken, "SVCeb", new List<Cmd>(), new ReturnCmd(Token.NoToken));
          foreach (var b in exitblocks)
          {
              b.TransferCmd = new GotoCmd(Token.NoToken, new List<Block> { eb });
          }
          impl.Blocks.Add(eb);
          return eb;
      }

      //static int LocalVarCounter = 0;
      private LocalVariable GetNewLocal(Variable v, string suffix)
      {
          return new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken,
              string.Format("svc_{0}_{1}", v.Name, suffix), v.TypedIdent.Type));
      }

      private void GenVc(Implementation impl, VerifierCallback collector)
      {
          if (impl.Proc.Requires.Any())
              throw new InvalidProgramForSecureVc("SecureVc: Requires not supported");
          if(impl.LocVars.Any(v => isVisible(v)))
              throw new InvalidProgramForSecureVc("SecureVc: Visible Local variables not allowed");

          // Desugar procedure calls
          DesugarCalls(impl);

          // Gather spec, remove existing ensures
          var secureAsserts = new List<AssertCmd>();
          var logicalAsserts = new List<AssertCmd>();
          
          foreach (var ens in impl.Proc.Ensures)
          {
              if(ens.Free)
                  throw new InvalidProgramForSecureVc("SecureVc: Free Ensures not supported");
              var dd = new Duplicator();
              secureAsserts.Add(new AssertCmd(ens.tok, Expr.Not(ens.Condition)));
              logicalAsserts.Add(dd.VisitAssertCmd(new AssertCmd(ens.tok, ens.Condition)) as AssertCmd);
          }
          impl.Proc.Ensures.Clear();

          // Make a copy of the impl
          var dup = new Duplicator();
          var implDup = dup.VisitImplementation(impl);

          // Get exit block
          var eb = GetExitBlock(impl);

          // Create two blocks: one for secureAsserts, one for logical asserts
          var ebSecure = new Block(Token.NoToken, "svc_secure_asserts", new List<Cmd>(), new ReturnCmd(Token.NoToken));
          var ebLogical = new Block(Token.NoToken, "svc_logical_asserts", new List<Cmd>(), new ReturnCmd(Token.NoToken));

          eb.TransferCmd = new GotoCmd(eb.TransferCmd.tok, new List<Block> { ebSecure, ebLogical });
          impl.Blocks.Add(ebSecure);
          impl.Blocks.Add(ebLogical);

          // Rename spec, while create copies of the hidden variables
          var substOld = new Dictionary<Variable, Expr>();
          var substVarSpec = new Dictionary<Variable, Expr>();
          var substVarPath = new Dictionary<Variable, Expr>();
          foreach (var g in program.GlobalVariables)
          {
              if (!isHidden(g)) continue;
              var lv = GetNewLocal(g, "In");
              impl.LocVars.Add(lv);
              substOld.Add(g, Expr.Ident(lv));
          }

          for(int i = 0; i < impl.InParams.Count; i++)
          {
              var v = impl.Proc.InParams[i];
              if (!isHidden(v))
              {
                  substVarSpec.Add(impl.Proc.InParams[i], Expr.Ident(impl.InParams[i]));
                  continue;
              }

              var lv = GetNewLocal(v, "In");
              impl.LocVars.Add(lv);
              substVarSpec.Add(v, Expr.Ident(lv));
              substVarPath.Add(impl.InParams[i], Expr.Ident(lv));
          }

          for (int i = 0; i < impl.OutParams.Count; i++)
          {
              var v = impl.Proc.OutParams[i];
              if (!isHidden(v))
              {
                  substVarSpec.Add(impl.Proc.OutParams[i], Expr.Ident(impl.OutParams[i]));
                  continue;
              }

              var lv = GetNewLocal(v, "Out");
              impl.LocVars.Add(lv);
              substVarSpec.Add(v, Expr.Ident(lv));
              substVarPath.Add(impl.OutParams[i], Expr.Ident(lv));
          }

          foreach (var g in program.GlobalVariables)
          {
              if (!isHidden(g)) continue;
              if (!impl.Proc.Modifies.Any(ie => ie.Name == g.Name)) continue;

              var lv = GetNewLocal(g, "Out");
              impl.LocVars.Add(lv);
              substVarSpec.Add(g, Expr.Ident(lv));
              substVarPath.Add(g, Expr.Ident(lv));
          }

          secureAsserts = secureAsserts.ConvertAll(ac => 
              Substituter.ApplyReplacingOldExprs(
                 Substituter.SubstitutionFromHashtable(substVarSpec),
                 Substituter.SubstitutionFromHashtable(substOld),
                 ac) as AssertCmd);

          var substVarProcToImpl = new Dictionary<Variable, Expr>();
          for (int i = 0; i < impl.InParams.Count; i++)
              substVarProcToImpl.Add(impl.Proc.InParams[i], Expr.Ident(impl.InParams[i]));

          for (int i = 0; i < impl.OutParams.Count; i++)
              substVarProcToImpl.Add(impl.Proc.OutParams[i], Expr.Ident(impl.OutParams[i]));

          logicalAsserts = logicalAsserts.ConvertAll(ac =>
              Substituter.Apply(Substituter.SubstitutionFromHashtable(substVarProcToImpl), ac)
              as AssertCmd);

          // Paths
          foreach (var path in GetAllPaths(implDup))
          {
              var wp = ComputeWP(implDup, path);

              // replace hidden variables to match those used in the spec
              wp = Substituter.ApplyReplacingOldExprs(
                  Substituter.SubstitutionFromHashtable(substVarPath),
                  Substituter.SubstitutionFromHashtable(substOld),
                  wp);

              ebSecure.Cmds.Add(new AssumeCmd(Token.NoToken, Expr.Not(wp)));
          }

          ebSecure.Cmds.AddRange(secureAsserts);
          ebLogical.Cmds.AddRange(logicalAsserts);

          if (outfile != null)
          {
              impl.Proc.Emit(outfile, 0);
              impl.Emit(outfile, 0);
          }

          ModelViewInfo mvInfo;
          ConvertCFG2DAG(impl);
          var gotoCmdOrigins = PassifyImpl(impl, out mvInfo);

          var gen = prover.VCExprGen;
          var exprGen = prover.Context.ExprGen;
          var translator = prover.Context.BoogieExprTranslator;

          var label2absy = new Dictionary<int, Absy>();
          VCGen.CodeExprConversionClosure cc = new VCGen.CodeExprConversionClosure(label2absy, prover.Context);
          translator.SetCodeExprConverter(cc.CodeExprToVerificationCondition);
          var implVc = gen.Not(GenerateVCAux(impl, null, label2absy, prover.Context));

          handler = new VCGen.ErrorReporter(gotoCmdOrigins, label2absy, impl.Blocks, incarnationOriginMap, collector, mvInfo, prover.Context, program);

          prover.Assert(implVc, true);
      }

      Expr ComputeWP(Implementation impl, List<Cmd> path)
      {
          Expr expr = Expr.True;

          // create constants for out varibles
          var subst = new Dictionary<Variable, Expr>();
          foreach (var g in impl.Proc.Modifies)
          {
              var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                  "svc_out_const_" + g.Name, g.Decl.TypedIdent.Type));
              subst.Add(c, g);
              expr = Expr.And(expr, Expr.Eq(Expr.Ident(c), g));
          }

          foreach (var v in impl.OutParams)
          {
              var c = new Constant(Token.NoToken, new TypedIdent(Token.NoToken,
                  "svc_out_const_" + v.Name, v.TypedIdent.Type));
              subst.Add(c, Expr.Ident(v));
              expr = Expr.And(expr, Expr.Eq(Expr.Ident(c), Expr.Ident(v)));
          }        

          // we need this technicality
          var subst1 = new Dictionary<Variable, Expr>();
          foreach (var g in program.GlobalVariables)
          {
              subst1.Add(g, new OldExpr(Token.NoToken, Expr.Ident(g)));
          }

          // Implicitly close with havoc of all the locals and OutParams
          path.Insert(0, new HavocCmd(Token.NoToken, new List<IdentifierExpr>(
              impl.LocVars.Select(v => Expr.Ident(v)).Concat(
              impl.OutParams.Select(v => Expr.Ident(v))))));

          for (int i = path.Count - 1; i >= 0; i--)
          {
              var cmd = path[i];
              if (cmd is AssumeCmd)
              {
                  expr = Expr.And(expr, (cmd as AssumeCmd).Expr);
              }
              else if (cmd is AssignCmd)
              {
                  var h = new Dictionary<Variable, Expr>();
                  var acmd = cmd as AssignCmd;
                  for (int j = 0; j < acmd.Lhss.Count; j++)
                  {
                      h.Add(acmd.Lhss[j].DeepAssignedVariable, acmd.Rhss[j]);
                  }
                  var s = Substituter.SubstitutionFromHashtable(h);
                  expr = Substituter.Apply(s, expr);
              }
              else if (cmd is HavocCmd)
              {
                  var h = new Dictionary<Variable, Expr>();
                  var formals = new List<Variable>();

                  var vc = new VariableCollector();
                  vc.VisitExpr(expr);

                  foreach (var ie in (cmd as HavocCmd).Vars)
                  {
                      if (!vc.usedVars.Contains(ie.Decl)) continue;
                      var f = new BoundVariable(Token.NoToken, new TypedIdent(Token.NoToken,
                          ie.Decl.Name + "_formal", ie.Decl.TypedIdent.Type));
                      h.Add(ie.Decl, Expr.Ident(f));
                      formals.Add(f);
                  }
                  if (!formals.Any())
                      continue;
                  var s = Substituter.SubstitutionFromHashtable(h);
                  expr = Substituter.Apply(s, expr);
                  expr = new ExistsExpr(Token.NoToken, formals, expr);
              }
              else
              {
                  throw new InvalidProgramForSecureVc(string.Format("Unhandled cmd: {0}", cmd));
              }
          }

          // Implicitly close with havoc of all the locals and OutParams



          expr = Substituter.Apply(Substituter.SubstitutionFromHashtable(subst1), expr);
          expr = Substituter.Apply(Substituter.SubstitutionFromHashtable(subst), 
              Substituter.SubstitutionFromHashtable(new Dictionary<Variable,Expr>()), expr);
          expr.Typecheck(new TypecheckingContext(null));
          return expr;
      }

      // Generate all paths in the impl
      IEnumerable<List<Cmd>> GetAllPaths(Implementation impl)
      {
          var stk = new Stack<Tuple<Block, int>>();
          stk.Push(Tuple.Create(impl.Blocks[0], 0));

          while (stk.Any())
          {
              var tup = stk.Peek();
              if (tup.Item1.TransferCmd is ReturnCmd)
              {
                  var ret = new List<Cmd>();
                  var ls = stk.ToList();
                  ls.Iter(t => ret.AddRange(t.Item1.Cmds));
                  yield return ret;

                  stk.Pop();
                  continue;
              }

              stk.Pop();

              var gc = tup.Item1.TransferCmd as GotoCmd;
              if (gc.labelTargets.Count <= tup.Item2)
                  continue;

              stk.Push(Tuple.Create(tup.Item1, tup.Item2 + 1));
              stk.Push(Tuple.Create(gc.labelTargets[tup.Item2], 0));
          }
          yield break;
      }

      bool isHidden(Variable v)
      {
          return QKeyValue.FindBoolAttribute(v.Attributes, "hidden");
      }

      bool isVisible(Variable v)
      {
          return !isHidden(v);
      }

      public override Outcome VerifyImplementation(Implementation/*!*/ impl, VerifierCallback/*!*/ callback)
      {
          // Record current time
          var startTime = DateTime.UtcNow;

          CommandLineOptions.Clo.ProverCCLimit = 1;
          prover = ProverInterface.CreateProver(program, logFilePath, appendLogFile, CommandLineOptions.Clo.ProverKillTime);

          // Flush any axioms that came with the program before we start SI on this implementation
          prover.AssertAxioms();

          GenVc(impl, callback);

          prover.Check();
          var outcome = prover.CheckOutcomeCore(handler);
          //var outcome = ProverInterface.Outcome.Valid;
          
          prover.Close();



          //Console.WriteLine("Answer = {0}", outcome);

          return ProverInterfaceOutcomeToConditionGenerationOutcome(outcome);
      }
  }

} // namespace VC
