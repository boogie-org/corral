using Microsoft.Boogie;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using cba.Util;
using btype = Microsoft.Boogie.Type;

namespace AngelicVerifierNull
{
    class DefaultModels
    {
        static Function sizeFun = null;
        static Function baseFun = null;
        static Procedure mallocProcedure = null;
        Program prog = null;

        public DefaultModels (Program _prog)
        {
            prog = _prog;
            foreach (Function func in prog.TopLevelDeclarations
                .Where(x => x is Function))
            {
                if (QKeyValue.FindBoolAttribute(func.Attributes, "buffersize"))
                    sizeFun = func;
                if (QKeyValue.FindBoolAttribute(func.Attributes, "bufferbase"))
                    baseFun = func;
            }

            if (sizeFun == null || baseFun == null)
                throw new InputProgramDoesNotMatchExn(
                    "ABORT: no size/base function declared in the input program");
        }

        public Program AddModels()
        {
            HashSet<SystemModel> models = new HashSet<SystemModel>();
            
            foreach (Procedure proc in prog.TopLevelDeclarations
                .Where(x => x is Procedure))
            {
                // locate malloc
                if (BoogieUtil.checkAttrExists("allocator", proc.Attributes))
                {
                    var attr = QKeyValue.FindStringAttribute(proc.Attributes, "allocator");
                    if (attr == null) mallocProcedure = proc;
                }
                if (mallocProcedure == null)
                    new InputProgramDoesNotMatchExn(
                        "ABORT: no malloc procedure with {:allocator} declared in the input program");

                // locate procedure without body
                switch (proc.Name)
                {
                    case "ExAllocatePoolWithTag":
                        var model = new ExAllocatePoolWithTag(proc);
                        models.Add(model);
                        break;
                    default:
                        continue;
                }
            }
            models.Iter(m => prog.TopLevelDeclarations.Add(m.impl));

            return prog;
        }

        public abstract class SystemModel
        {
            private Implementation _impl;
            public abstract string modelName { get; }
            public Implementation impl { get { return _impl; } }
            public abstract Implementation GenerateBody(Procedure proc);
            public SystemModel(Procedure p) 
            {
                _impl = GenerateBody(p);
            }

            public override bool Equals(object obj)
            {
                if ((obj is SystemModel) && ((obj as SystemModel).modelName == modelName))
                    return true;
                else return false;
            }
            public override int GetHashCode()
            {
                return modelName.GetHashCode();
            }
            protected List<Variable> DropAnnotations(List<Variable> vars)
            {
                var ret = new List<Variable>();
                var dup = new Duplicator();
                vars.Select(v => dup.VisitVariable(v)).Iter(v =>
                {
                    v.Attributes = null;
                    ret.Add(v);
                });
                return ret;
            }
        }

        public class ExAllocatePoolWithTag : SystemModel
        {
            public override string modelName
            {
                get { return "ExAllocatePoolWithTag"; }
            }

            public ExAllocatePoolWithTag(Procedure proc) : base(proc) { }

            public override Implementation GenerateBody(Procedure proc)
            {
                Debug.Assert(proc.InParams.Count == 3);
                Debug.Assert(proc.OutParams.Count == 1);

                List<Variable> locals = new List<Variable>();
                List<Block> blocks = new List<Block>();

                //var allocRet = new LocalVariable(Token.NoToken, new TypedIdent(Token.NoToken, "x", btype.Int));

                var cmds = new List<Cmd>() {
                    BoogieAstFactory.MkCall(mallocProcedure,
                    new List<Expr>() { (Expr)IdentifierExpr.Ident(proc.InParams[1]) },
                    new List<Variable>() {proc.OutParams[0]})};
                var txCmd = new ReturnCmd(Token.NoToken);
                var blk = BoogieAstFactory.MkBlock(cmds, txCmd);
                blocks.Add(blk);

                var ret = new Implementation(Token.NoToken, modelName,
                    proc.TypeParameters,
                    DropAnnotations(proc.InParams),
                    DropAnnotations(proc.OutParams), locals, blocks);
                ret.Attributes = (new FixedDuplicator(false)).CopyAttr(proc.Attributes);
                    //new QKeyValue(Token.NoToken, proc.Attributes.Key,
                    //proc.Attributes.Params.ToList(), ret.Attributes);
                ret.Proc = proc;

                return ret;
            }
        }
    }
}
