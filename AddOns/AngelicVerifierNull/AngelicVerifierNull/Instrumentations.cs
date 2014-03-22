using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using Microsoft.Boogie;
using btype = Microsoft.Boogie.Type;
using cba.Util;
using PersistentProgram = cba.PersistentCBAProgram;

namespace AngelicVerifierNull
{

    /// <summary>
    /// Various source -> source transformations
    /// </summary>
    class Instrumentations
    {

        public class HarnessInstrumentation
        {
            Program prog;
            string mainName;

            public HarnessInstrumentation(Program program, string corralName)
            {
                prog = program;
                mainName = corralName;
            }
            public void DoInstrument()
            {
                //blocks 
                List<Block> succBlocks = new List<Block>();
                foreach (Implementation impl in prog.TopLevelDeclarations.Where(x => x is Implementation))
                {
                    var blk = new Block();
                    //cmds 
                    //succ
                    blk.TransferCmd = new ReturnCmd(Token.NoToken);
                    succBlocks.Add(new Block());
                }
                Block blkStart = new Block(Token.NoToken, "CorralMainStart", new List<Cmd>(), new GotoCmd(Token.NoToken, succBlocks));
                var mainProc = new Implementation(Token.NoToken, mainName, 
                    new List<TypeVariable>(),new List<Variable>(),new List<Variable>(), new List<Variable>(), 
                    new StmtList(new List<BigBlock>(), Token.NoToken));
                mainProc.AddAttribute("entrypoint", new object[] {});
                prog.TopLevelDeclarations.Add(mainProc);
            }
        }

    }
}
