using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    // Performs variable slicing
    public class VariableSlicing : FixedVisitor
    {
        // The set of variables to track
        private VarSet trackedVars;
        private HashSet<string> trackedVarsVariables; // = trackedVars.Variables

        // To ensure that we don't visit the same implementation twice
        private HashSet<string> visitedImplementations;

        // The current implementation that VisitBlock is in. This implementation is
        // use to add local variables to it, if the slicing requires it.
        //
        // This is for slicing a statement Mem[x] := y
        // to havoc temp; Mem[x] := temp; when Mem and x are tracked but y is not
        private Implementation currImplementation;

        // How the transformation was performed
        public ModifyTrans tinfo;

        // A counter for generating local variables with different names
        private static int localVarCount = 0;

        // We sliced away (non-free) requires in these procedures
        private HashSet<string> slicedRequires;

        // We sliced away (non-free) ensures in these procedures
        private HashSet<string> slicedEnsures;

        // Use simple slicing for "M[x] := untracked"?
        public static bool UseSimpleSlicing = false;

        // Did we abstract parallel assignment?
        public static bool EncounteredParallelAssignment = false;

        public VariableSlicing(VarSet rmv, ModifyTrans t)
        {
            trackedVars = new VarSet(rmv);
            trackedVarsVariables = new HashSet<string>(trackedVars.Variables);
            tinfo = t;
            onlyGlobals = true;
            currImplementation = null;
            visitedImplementations = new HashSet<string>();
            slicedRequires = new HashSet<string>();
            slicedEnsures = new HashSet<string>();
        }

        private bool onlyGlobals;
        public VariableSlicing(VarSet rmv, ModifyTrans t, Implementation impl)
        {
            trackedVars = new VarSet(rmv);
            trackedVarsVariables = new HashSet<string>(trackedVars.Variables);
            tinfo = t;
            onlyGlobals = false;
            currImplementation = impl;
            visitedImplementations = new HashSet<string>();
            slicedRequires = new HashSet<string>();
            slicedEnsures = new HashSet<string>();
        }

        private bool isTracked(Absy exp)
        {
             return isTracked(exp, currImplementation.Name);
        }

        // onlyGlobals is true means assume all locals are tracked
        // onlyGlobals is false means assume all globals are tracked
        private bool isTracked(Absy exp, string name)
        {
            VarsUsed uses = new VarsUsed();
            uses.Visit(exp);
            
            if (onlyGlobals)
            {
                return trackedVars.Contains(new VarSet(uses.globalsUsed, name));
            }
            else
            {
                return trackedVars.Contains(new VarSet(uses.localsUsed, name));
            }
        }

        private bool isTrackedVariable(Variable var)
        {
            if (onlyGlobals)
            {
                if (var is GlobalVariable)
                    return trackedVarsVariables.Contains(var.Name);
                else  // assuming var is local otherwise
                    return true;
            }
            else
            {
                if (var is GlobalVariable)
                    return true;
                else // assuming var is local otherwise
                    return trackedVarsVariables.Contains(var.Name);
            }
        }

        // Remove declarations of globals that are not tracked
        public override Program VisitProgram(Program node)
        {
            /*
            Log.Write(Log.Debug, "Tracking variables: ");
            foreach (var s in trackedVars)
            {
                Log.Write(Log.Debug, s + " ");
            }
            Log.Write(Log.Debug, "\n");
            */

            HashSet<string> declaredGlobals = new HashSet<string>();

            // Partition the list into global declarations and others
            var globals = node.TopLevelDeclarations.OfType<GlobalVariable>().ToList();
            var rest = node.TopLevelDeclarations.Where(decl => !(decl is GlobalVariable)).ToList();

            // Gather all declared global variables
            foreach (Declaration d in globals)
            {
                var g = d as GlobalVariable;
                if (g == null) continue;

                // Store declared global
                declaredGlobals.Add(g.Name);
            }

            if (trackedVars.Contains(new VarSet(declaredGlobals, BoogieUtil.GetAllProcNames(node))))
                return node;

            // Make sure all the vars to track are declared
            Debug.Assert(declaredGlobals.Contains(trackedVars.Variables));

            // Visit declaration other than global variable declarations
            for (int i = 0, n = rest.Count; i < n; i++)
                rest[i] = this.VisitDeclaration(rest[i]);

            // Remove globals that are not tracked
            node.TopLevelDeclarations = globals.Where(x => isTrackedVariable(x as GlobalVariable));

            node.AddTopLevelDeclarations(rest);

            foreach (var proc in slicedEnsures)
            {
                if (visitedImplementations.Contains(proc))
                {
                    Log.WriteLine(Log.Warning, "Slicing away (non-free) ensures condition");
                }
            }

            if (slicedRequires.Any())
            {
                Log.WriteLine(Log.Warning, "Slicing away (non-free) requires condition");
            }

            // Remove annotations that won't parse because of dropped variables
            RemoveVarsFromAttributes.Prune(node);

            return node;
        }

        // Changes the modified declaration of a procedure: delete ones
        // that are not tracked
        public override Procedure VisitProcedure(Procedure node)
        {
            List<IdentifierExpr> mods = new List<IdentifierExpr>();
            foreach (IdentifierExpr ie in node.Modifies)
            {
                GlobalVariable gbl = ie.Decl as GlobalVariable;
                if (gbl == null)
                {
                    mods.Add(ie);
                    continue;
                }

                if (isTracked(new IdentifierExpr(Token.NoToken, gbl), node.Name))
                {
                    mods.Add(ie);
                }
            }

            // TODO: Currently, we abstract ensures and requires annotations by simply removing them if they
            // contain untracked variables. The correct way would be to (universally/existentially) quantify out
            // the variables

            List<Ensures> abstracted_en = new List<Ensures>();
            List<Requires> abstracted_req = new List<Requires>();

            // Check ensures annotations
            foreach (Ensures en in node.Ensures)
            {
                if (QKeyValue.FindBoolAttribute(en.Attributes, "va_keep"))
                {
                    abstracted_en.Add(en);
                    continue;
                }

                if (isTracked(en.Condition, node.Name))
                {
                    abstracted_en.Add(en);
                }
                else
                {
                    if (!en.Free)
                    {
                        //en.Emit(new TokenTextWriter(Console.Out), 0);
                        //throw new InternalError("Cannot yet abstract ensures annotations that have untracked variables");
                        slicedEnsures.Add(node.Name);
                    }                    
                }
            }
            // Check requires annotations
            foreach (Requires re in node.Requires)
            {
                if (QKeyValue.FindBoolAttribute(re.Attributes, "va_keep"))
                {
                    abstracted_req.Add(re);
                    continue;
                }

                if (isTracked(re.Condition, node.Name))
                {
                    abstracted_req.Add(re);
                }
                else
                {
                    if (!re.Free)
                    {
                        //re.Emit(new TokenTextWriter(Console.Out), 0);
                        //throw new InternalError("Cannot yet abstract requires annotations that have untracked variables");
                        slicedRequires.Add(node.Name);
                    }
                }
                
            }

            node.Modifies = mods;
            node.Ensures = abstracted_en;
            node.Requires = abstracted_req;

            return node;
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            // Don't visit the same implementation twice
            if (visitedImplementations.Contains(node.Name))
            {
                return node;
            }
            else
            {
                visitedImplementations.Add(node.Name);
            }

            currImplementation = node;

            node = base.VisitImplementation(node);

            currImplementation = null;

            return node;
        }

        // Return a new local variable. Also add it to impl if it is not null
        private static LocalVariable getNewLocal(Microsoft.Boogie.Type type, Implementation impl)
        {
            Debug.Assert(type != null);

            string name = "";
            LocalVariable lv = null;
            do
            {
                name = "vslice_dummy_var_" + (localVarCount.ToString());
                TypedIdent tid = new TypedIdent(Token.NoToken, name, type);
                lv = new LocalVariable(Token.NoToken, tid);
                localVarCount++;
            } while (impl != null && impl.LocVars.Any(v => v.Name == name));

            if (impl != null) impl.LocVars.Add(lv);
            return lv;
        }

        // This is the main place where the variable slicing is carried out.
        // The control flow of the program is not modified by variable slicing.
        public override Block VisitBlock(Block block)
        {
            // Happens with CodeExpr in global scope
            if (currImplementation == null)
                return block;

            var ret = sliceBlock(block);
            Debug.Assert(tinfo.getNumTrans(currImplementation.Name, block.Label) == block.Cmds.Count);
            return ret;
        }

        // This procedure carries out variable slicing for all commands in the block. It will add more
        // local variables (needed for slicing) if impl is not null. The flag onlyGlobals restricts attention
        // to only slicing global variables
        private Block sliceBlock(Block block)
        {
            // The new list of commands that we will construct
            List<Cmd> sliced = new List<Cmd>();

            foreach (Cmd cmd in block.Cmds)
            {
                // Eliminate trivial statements like assume true
                if (isAssumeTrue(cmd))
                {
                    // This is an assume true, don't put it in the final program
                    if (tinfo != null)
                    {
                        tinfo.add(currImplementation.Name, block.Label, new InstrTrans(cmd, new List<Cmd>()));
                    }
                    continue;
                }

                // if cmd does not refer to a un-tracked global variable, then don't
                // bother, and move on to the next cmd
                if (isTracked(cmd))
                {
                    sliced.Add(cmd);
                    if (tinfo != null)
                        tinfo.add(currImplementation.Name, block.Label, new InstrTrans(cmd, cmd));
                    continue;
                }

                List<Cmd> newcmd = new List<Cmd>();

                // Now we need to look at what sort of a command are we dealing with
                if (cmd is AssignCmd)
                {
                    newcmd = AbstractAssign(cmd as AssignCmd);
                }
                else if (cmd is AssertCmd)
                {
                    Log.WriteLine(Log.Debug, "\nWarning: An assert has an untracked variable: it'll become assert false");
                    newcmd.Add(new AssertCmd(Token.NoToken, Expr.Literal(false)));
                }
                else if (cmd is AssumeCmd)
                {
                    // Do Nothing.
                }
                else if (cmd is CallCmd)
                {
                    CallCmd ccmd = (CallCmd)cmd;

                    // Process the call arguments: if anything is untracked, then
                    // convert to a dummy variable
                    var newIns = new List<Expr>();
                    foreach (var exp in ccmd.Ins)
                    {
                        if (exp == null)
                        {
                            newIns.Add(null);
                        }
                        else if (!isTracked(exp))
                        {
                            Debug.Assert(currImplementation != null);
                            var dvar = getNewLocal(exp.Type, currImplementation);
                            newcmd.Add(new HavocCmd(Token.NoToken, new List<IdentifierExpr>(new IdentifierExpr[] { Expr.Ident(dvar) })));
                            newIns.Add(Expr.Ident(dvar));
                        }
                        else
                        {
                            newIns.Add(exp);
                        }
                    }

                    // Process the returns: if anything is untracked then simply call
                    // the procedure, without storing its return value                  
                    var newOuts = new List<IdentifierExpr>();
                    foreach (var exp in ccmd.Outs)
                    {
                        if (exp == null)
                        {
                            newOuts.Add(null);
                        }
                        else if (!isTracked(exp))
                        {
                            Debug.Assert(currImplementation != null);
                            var dvar = getNewLocal(exp.Type, currImplementation);
                            newOuts.Add(Expr.Ident(dvar));
                        }
                        else
                        {
                            newOuts.Add(exp);
                        }
                    }

                    CallCmd tmp = new CallCmd(ccmd.tok, ccmd.Proc.Name, newIns, newOuts, ccmd.Attributes, ccmd.IsAsync);
                    tmp.Proc = ccmd.Proc; // just to keep the proc declarations in sync

                    newcmd.Add(tmp);
                }
                else if (cmd is HavocCmd)
                {
                    // Remove the havoced variables that are not tracked.
                    HavocCmd hcmd = (HavocCmd)cmd;
                    var newvars = new List<IdentifierExpr>();

                    foreach (IdentifierExpr ie in hcmd.Vars)
                    {
                        if (isTrackedVariable(ie.Decl))
                        {
                            newvars.Add(ie);
                        }
                    }

                    if (newvars.Count != 0)
                        newcmd.Add(new HavocCmd(hcmd.tok, newvars));
                }
                else
                {
                    cmd.Emit(new TokenTextWriter(Console.Out), 0);
                    throw new InternalError("Unkown Cmd type encountered during variable slicing");
                }

                sliced.AddRange(newcmd);
                if (tinfo != null)
                    tinfo.add(currImplementation.Name, block.Label, new InstrTrans(cmd, newcmd));
            }

            return new Block(block.tok, block.Label, sliced, block.TransferCmd);
        }

        private List<Cmd> AbstractAssign(AssignCmd acmd)
        {
            var newcmd = new List<Cmd>();

            // !KeepSimple: then map indices are given special treatment
            var KeepSimple = UseSimpleSlicing || (currImplementation == null) || (acmd.Lhss.Count != 1);

            if (acmd.Lhss.Count != 1)
                EncounteredParallelAssignment = true;
            
            var newLhss = new List<AssignLhs>();
            var newRhss = new List<Expr>();
            var varsToHavoc = new HashSet<Variable>();

            for (int i = 0; i < acmd.Lhss.Count; i++)
            {
                AssignLhs lhs = acmd.Lhss[i];
                Expr rhs = acmd.Rhss[i];

                //IdentifierExpr assignedVar = getAssignedVariable(lhs);
                IdentifierExpr assignedVar = lhs.DeepAssignedIdentifier;

                if (isTrackedVariable(assignedVar.Decl))
                {
                    if (lhs is MapAssignLhs && !indicesAreTracked((MapAssignLhs)lhs))
                    {
                        // convert to assignedVar := *
                        varsToHavoc.Add(assignedVar.Decl);
                    }
                    else if (!isTracked(rhs))
                    {
                        // Convert to lhs := *
                        if (KeepSimple || lhs is SimpleAssignLhs)
                        {
                            varsToHavoc.Add(assignedVar.Decl);
                        }
                        else
                        {
                            // convert to "havoc lhs" as follows:
                            // havoc dummy; lhs := dummy;
                            // This is done when lhs is Mem[x]. We're not
                            // allowed to say "havoc Mem[x]".

                            // We should be doing this only when we can add new
                            // local variables
                            Debug.Assert(currImplementation != null);

                            // Get new local variable dummy
                            LocalVariable dummy = getNewLocal(lhs.Type, currImplementation);

                            // havoc dummy
                            newcmd.Add(BoogieAstFactory.MkHavocVar(dummy));

                            // lhs := dummy
                            newLhss.Add(lhs);
                            newRhss.Add(Expr.Ident(dummy));
                        }
                    }
                    else
                    {
                        // It is possible to come here because a variable may be untracked in this scope, 
                        // yet tracked globally because it is on the lhs
                        newLhss.Add(lhs);
                        newRhss.Add(rhs);
                    }
                }
            }

            if (newLhss.Count != 0)
                newcmd.Add(new AssignCmd(Token.NoToken, newLhss, newRhss));

            if (varsToHavoc.Count != 0)
            {
                var ieseq = new List<IdentifierExpr>();
                varsToHavoc.Iter(v => ieseq.Add(Expr.Ident(v)));
                newcmd.Add(new HavocCmd(Token.NoToken, ieseq));
            }

            return newcmd;
        }

        private static bool isAssumeTrue(Cmd cmd)
        {
            if (cmd is AssumeCmd)
            {
                var acmd = cmd as AssumeCmd;
                // Could be an important assume command
                if (acmd.Attributes != null) return false;
                if (acmd.Expr is LiteralExpr)
                {
                    var le = acmd.Expr as LiteralExpr;
                    if (le.IsTrue)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        // Return the variable that is being assigned to in the LHS of an assignment.
        //    id := ...  then id
        //    m[...] := ... then m
        private static IdentifierExpr getAssignedVariable(AssignLhs lhs)
        {
            if (lhs is SimpleAssignLhs)
            {
                SimpleAssignLhs sl = (SimpleAssignLhs)lhs;
                return sl.AssignedVariable;
            }
            else if (lhs is MapAssignLhs)
            {
                MapAssignLhs ml = (MapAssignLhs)lhs;
                return getAssignedVariable(ml.Map);
            }
            else
            {
                lhs.Emit(new TokenTextWriter(Console.Out));
                throw new InternalError("Unknown type of AssignLhs");
            }

        }

        private bool indicesAreTracked(MapAssignLhs lhs)
        {
            // Go through all indices of the map
            foreach (var e in lhs.Indexes)
            {
                if (!isTracked(e)) return false;
            }
            return true;
        }
    }

    // Get rid of global and local variables in a program that are never read
    public class UnReadVarEliminator : FixedVisitor
    {
        // This will contain the set of variables that are read
        VarsUsed varsRead;
        
        // The set of global variables read
        HashSet<string> globalsRead;

        // How the transformation (deletion of commands with unsed variables) was performed
        // for local variables
        public ModifyTrans ltinfo;

        // How the transformation (deletion of commands with unsed variables) was performed
        // for global variables
        public ModifyTrans gtinfo;

        // For slicing global variables (ones that are not read)
        VariableSlicing sliceGlobals;

        // Only prune local variables
        bool onlyLocals;

        public UnReadVarEliminator()
            : this(false) { }

        public UnReadVarEliminator(bool onlyLocals)
        {
            this.onlyLocals = onlyLocals;
            varsRead = null;
            globalsRead = null;
            ltinfo = new ModifyTrans();
            gtinfo = new ModifyTrans();
            sliceGlobals = null;
        }

        public ErrorTrace mapBackTrace(ErrorTrace trace)
        {
            Debug.Assert(ltinfo != null && gtinfo != null);

            if (!onlyLocals)
            {
                // First, globals
                trace = gtinfo.mapBackTrace(trace);
            }

            // Next, locals
            trace = ltinfo.mapBackTrace(trace);

            return trace;
        }

        public override Program VisitProgram(Program node)
        {
            throw new InternalError("Do not call this method");
        }

        public override Procedure VisitProcedure(Procedure node)
        {
            throw new InternalError("Do not call this method");
        }

        public override Implementation VisitImplementation(Implementation node)
        {
            throw new InternalError("Do not call this method");
        }

        public Program run(Program node)
        {
            globalsRead = new HashSet<string>();

            // Typecheck -- needed for variable abstraction
            if (node.Typecheck() != 0)
            {
                BoogieUtil.PrintProgram(node, "error.bpl");
                throw new InternalError("Type errors");
            }

            // Go through all procedures and implementations (slice locals)
            var TopLevelDeclarations = node.TopLevelDeclarations.ToList();
            for (int i = 0; i < TopLevelDeclarations.Count; i++)
            {
                if (TopLevelDeclarations[i] is Implementation)
                {
                    TopLevelDeclarations[i] = processImplementation(TopLevelDeclarations[i] as Implementation);
                }
                else if (TopLevelDeclarations[i] is Procedure)
                {
                    processProcedure(TopLevelDeclarations[i] as Procedure);
                }
            }
            node.TopLevelDeclarations = TopLevelDeclarations;

            if (onlyLocals) return node;


            sliceGlobals = new VariableSlicing(VarSet.ToVarSet(globalsRead, node), gtinfo);
            node = sliceGlobals.VisitProgram(node);
            BoogieUtil.DoModSetAnalysis(node);

            return node;
        }

        // Globals may also be read in procedures (without implementation)
        private void processProcedure(Procedure node)
        {
            varsRead = new VarsUsed();
            foreach (Requires re in node.Requires)
            {
                varsRead.Visit(re.Condition);
            }

            foreach (Ensures en in node.Ensures)
            {
                varsRead.Visit(en.Condition);
            }

            globalsRead.UnionWith(varsRead.globalsUsed);
        }

        private Implementation processImplementation(Implementation node)
        {
            varsRead = new VarsUsed();

            // Gather the set of vars used
            foreach (var b in node.Blocks)
            {
                base.VisitBlock(b);
            }

            globalsRead.UnionWith(varsRead.globalsUsed);

            // Get rid of declarations (before variable slice adds new variables)
            var newvars = new List<Variable>();
            foreach (Variable v in node.LocVars)
            {
                if (varsRead.localsUsed.Contains(v.Name))
                {
                    newvars.Add(v);
                }
            }
            node.LocVars = newvars;

            // Do VariableSlicing
            VariableSlicing slice = new VariableSlicing(new VarSet(new HashSet<string>(varsRead.localsUsed), node.Name), ltinfo, node);
            for(int i = 0; i < node.Blocks.Count; i ++) 
                node.Blocks[i] = slice.VisitBlock(node.Blocks[i]);
            
            varsRead = null;
            return node;
        }

        public override Cmd VisitAssignCmd(AssignCmd node)
        {
            for (int i = 0; i < node.Lhss.Count; ++i)
            {
                // map indices also qualify as variables read
                this.Visit(node.Lhss[i]);
                // All vars in the Rhs qualify as read
                varsRead.Visit(node.Rhss[i]);
            }

            return node;
        }

        // map indices also qualify as variables read
        public override AssignLhs VisitMapAssignLhs(MapAssignLhs node)
        {

            node.Map = (AssignLhs)this.Visit(node.Map);
            for (int i = 0; i < node.Indexes.Count; ++i)
                varsRead.Visit(node.Indexes[i]);

            return node;
        }

        public override Cmd VisitAssumeCmd(AssumeCmd node)
        {
            varsRead.VisitAssumeCmd(node);
            return node;
        }

        public override Cmd VisitAssertCmd(AssertCmd node)
        {
            varsRead.VisitAssertCmd(node);
            return node;
        }

        public override Cmd VisitCallCmd(CallCmd node)
        {
            for (int i = 0; i < node.Ins.Count; ++i)
                if (node.Ins[i] != null)
                    varsRead.VisitExpr(node.Ins[i]);

            for (int i = 0; i < node.Outs.Count; ++i)
                if (node.Outs[i] != null)
                    this.VisitIdentifierExpr(node.Outs[i]);

            return node;
        }
    }

}
