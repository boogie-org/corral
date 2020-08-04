using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using cba.Util;
using Microsoft.Boogie;
using System.Diagnostics;

namespace HavocCleanup
{
    class Program
    {
        public static class GlobalConfig
        {
            public static string mainProc = "";
            public static string hwswInitProc = null;
            public static string inputFile = "";
            public static string outputFile = "";
            public static bool doHwswLevelMatch = false;
        }

        static void Main(string[] args)
        {

            if (!parseCommandLine(args))
            {
                usage();
                return;
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

            StreamReader reader = new StreamReader(GlobalConfig.inputFile);
            var input = reader.ReadToEnd();
            reader.Close();

            // override main proc name for hwsw
            if (GlobalConfig.hwswInitProc != null)
                GlobalConfig.mainProc = GlobalConfig.hwswInitProc;

            try
            {
                var output = cleanup(input);

                var reProc = new System.Text.RegularExpressions.Regex(@"procedure\s.*__havoc_heapglobal_init\(.*\).*", RegexOptions.Compiled);
                //Console.WriteLine("Cleanup done");

                if (GlobalConfig.mainProc != "" && reProc.IsMatch(output))
                {
                    var reMain = new System.Text.RegularExpressions.Regex(
                        @"procedure\s.*" + GlobalConfig.mainProc + @"\(.*\).*",
                        RegexOptions.Compiled);
                    var reBlock = new System.Text.RegularExpressions.Regex(
                        @"(\s*start:\s*)",
                        RegexOptions.Compiled);

                    var reAllocTypeBV = new System.Text.RegularExpressions.Regex(@"var alloc:bv32.*", RegexOptions.Compiled);
                    var allocTypeIsBV = false;
                    if (reAllocTypeBV.IsMatch(output))
                    {
                        allocTypeIsBV = true;
                    }


                    var match = reMain.Match(output);
                    if (match.Success)
                    {
                        if (allocTypeIsBV)
                        {
                            output = reBlock.Replace(output, "$1assume BV32_LT(0bv32,alloc);\r\ncall __havoc_heapglobal_init();\r\n", 1, match.Index);
                        }
                        else
                        {
                            output = reBlock.Replace(output, "$1assume INT_LT(0,alloc);\r\ncall __havoc_heapglobal_init();\r\n", 1, match.Index);
                        }
                    }
                }

                //if (GlobalConfig.mainProc != "" && reProc.IsMatch(output))
                //{
                //    output = addToMain(output);
                //}

                StreamWriter writer = new StreamWriter(GlobalConfig.outputFile);
                writer.Write(output);
                writer.Close();

                // change "/" to div
                // TODO

                if(GlobalConfig.doHwswLevelMatch)
                    doHwswLevelMatch(GlobalConfig.outputFile, GlobalConfig.outputFile);
            }
            catch (InternalError e)
            {
                Console.WriteLine(e.Message);
            }


        }

        static string levelCall = "hwsw_change_level";
        static string cpuCall = "hwsw_change_cpu";

        static void doHwswLevelMatch(string infile, string outfile)
        {
            var program = BoogieUtil.ParseProgram(infile);
            foreach (var decl in program.TopLevelDeclarations)
            {
                var impl = decl as Implementation;
                if (impl == null) continue;
                doHwswLevelMatch(impl);
            }

            BoogieUtil.PrintProgram(program, outfile);
        }

        // Propagate levels
        static void doHwswLevelMatch(Implementation impl)
        {
            var labelBlockMap = BoogieUtil.labelBlockMapping(impl);

            foreach (var blk in impl.Blocks)
            {
                for (int i = 0; i < blk.Cmds.Count; i++ )
                {
                    var ccmd = blk.Cmds[i] as CallCmd;
                    if (ccmd == null || (ccmd.callee != levelCall && ccmd.callee != cpuCall)) continue;

                    if (ccmd.callee == levelCall)
                    {
                        // Get level
                        if (ccmd.Ins.Count != 1) throw new InternalError("Incorrect hwsw level usage");
                        if (!(ccmd.Ins[0] is LiteralExpr)) throw new InternalError("Incorrect hwsw level usage");
                        var level = ((Microsoft.Basetypes.BigNum)(ccmd.Ins[0] as LiteralExpr).Val).ToInt;
                        // start search
                        var currBlk = blk;
                        var currCmd = i + 1;
                        var done = false;
                        while (!done)
                        {
                            for (int j = currCmd; j < currBlk.Cmds.Count && !done; j++)
                            {
                                var tc = currBlk.Cmds[j] as CallCmd;
                                if (tc == null || !tc.IsAsync) continue;
                                done = true;
                                // change attribute
                                var parameters = new List<object>(); parameters.Add(Expr.Literal(level));
                                tc.Attributes = new QKeyValue(Token.NoToken, "level", parameters, tc.Attributes);
                            }
                            if (!done)
                            {
                                var gc = currBlk.TransferCmd as GotoCmd;
                                if (gc == null || gc.labelNames.Count != 1) throw new InternalError("Incorrect hwsw level usage");
                                currBlk = labelBlockMap[gc.labelNames[0]];
                                currCmd = 0;
                            }
                        }
                    }
                    else if (ccmd.callee == cpuCall)
                    {
                        // Get level
                        if (ccmd.Ins.Count != 1) throw new InternalError("Incorrect hwsw cpu usage");
                        if (!(ccmd.Ins[0] is LiteralExpr)) throw new InternalError("Incorrect hwsw cpu usage");
                        var level = ((Microsoft.Basetypes.BigNum)(ccmd.Ins[0] as LiteralExpr).Val).ToInt;
                        // start search
                        var currBlk = blk;
                        var currCmd = i + 1;
                        var done = false;
                        while (!done)
                        {
                            for (int j = currCmd; j < currBlk.Cmds.Count && !done; j++)
                            {
                                var tc = currBlk.Cmds[j] as CallCmd;
                                if (tc == null || !tc.IsAsync) continue;
                                done = true;
                                // change attribute
                                var parameters = new List<object>(); parameters.Add(Expr.Literal(level));
                                tc.Attributes = new QKeyValue(Token.NoToken, "cpu", parameters, tc.Attributes);
                            }
                            if (!done)
                            {
                                var gc = currBlk.TransferCmd as GotoCmd;
                                if (gc == null || gc.labelNames.Count != 1) throw new InternalError("Incorrect hwsw cpu usage");
                                currBlk = labelBlockMap[gc.labelNames[0]];
                                currCmd = 0;
                            }
                        }

                    }
                }
            }
        }

        static QKeyValue removeAttr(QKeyValue attr, string name)
        {
            if (attr == null) return null;
            if (attr.Key == name) return removeAttr(attr.Next, name);
            var tail = removeAttr(attr.Next, name);
            return new QKeyValue(attr.tok, attr.Key, attr.Params, tail);
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

            for (int i = 2; i < args.Length; i++)
            {
                processFlag(args[i]);
                if (args[i].StartsWith("/flags:"))
                {
                    var split = args[i].Split(':');
                    var flags = readFile(split[1]);
                    foreach (var flag in flags)
                        processFlag(flag);
                }
            }
            return true;
        }

        private static void processFlag(string flag)
        {
            if (isFlag(flag) && flag.StartsWith("/main:"))
            {
                var split = flag.Split(':');
                GlobalConfig.mainProc = split[1];
            }
            
            if (isFlag(flag) && flag.StartsWith("/initializeHwsw:"))
            {
                // overrides main proc name for Hwsw
                var split = flag.Split(':');
                GlobalConfig.hwswInitProc = split[1];
            }

            if (isFlag(flag) && flag == "/matchLevels")
            {
                GlobalConfig.doHwswLevelMatch = true;
            }
        }

        // Read flags from a file
        private static List<string> readFile(string file)
        {
            var ret = new List<string>();

            var spaces = new char[1];
            spaces[0] = ' ';

            StreamReader cfile = new StreamReader(file);
            string line;
            while ((line = cfile.ReadLine()) != null)
            {
                // comment
                if (line.StartsWith("#"))
                    continue;

                if (isFlag(line))
                {
                    var split = line.Split(spaces);
                    foreach (var str in split)
                    {
                        if (isFlag(str)) ret.Add(str);
                    }
                }
            }
            return ret;
        }

        public static bool isFlag(string str)
        {
            return str[0] == '/';
        }

        static void usage()
        {
            Console.WriteLine("Usage: HavocCleanup input.bpl output.bpl [Flags]");
        }

        static string[] cmds = {
            @"//TAG: alloc is always > 0.*?free ensures INT_LEQ\(old\(alloc\), alloc\);", "dotall",
            @"",

            @"//TAG: alloc is always > 0.*?free ensures BV32_LEQ\(old\(alloc\), alloc\);", "dotall",
            @"",

            @"//TAG: modifies globalInSEHTry.*?modifies globalInSEHTry;", "dotall",
            @"",

            @".*globalInSEHTry := old\(globalInSEHTry\);\n", "",
            @"",

            //@"free ensures .*;\n", "",
            //@"",

            @"//TAG: havoc memory locations by default[ ]*\n", "",
            @"",

            @"//TAG: requires .*?\n", "",
            @"",

            @"requires INT_GEQ\(obj_size, 0\); //requires obj_size >= 0;\n", "",
            @"free requires INT_GEQ(obj_size, 0); //requires obj_size >= 0;\n",

            @"requires BV32_GEQ\(obj_size, 0bv32\); //requires obj_size >= 0;\n", "",
            @"free requires BV32_GEQ(obj_size, 0bv32); //requires obj_size >= 0;\n",

            @"ensures new == old\(alloc\);\n", "",
            @"free ensures new == old(alloc);\n",

            @"ensures INT_GT\(alloc, INT_ADD\(new, obj_size\)\); //ensures alloc > new \+ obj_size;\n", "",
            @"free ensures INT_GT(alloc, INT_ADD(new, obj_size)); //ensures alloc > new + obj_size;\n" +
            @"free ensures INT_GT(alloc, old(alloc)); //ensures alloc > new + obj_size;\n",

            @"ensures BV32_GT\(alloc, BV32_ADD\(new, obj_size\)\); //ensures alloc > new \+ obj_size;\n", "",
            @"free ensures BV32_GT(alloc, BV32_ADD(new, obj_size)); //ensures alloc > new + obj_size;\n" +
            @"free ensures BV32_GT(alloc, old(alloc)); //ensures alloc > new + obj_size;\n",

            @"assume ___LOOP_([a-zA-Z0-9_]*)_Res_.+ == Res_.+;\n", "",
            @"",

            @"ensures old\(alloc\) <= alloc;\n", "",
            @"",

            @"[ ]*assume[ ]+INT_LT\(.+,[ ]*alloc\)[ ]*;[ ]*\n", "",
            @"",

            @"[ ]*assume[ ]+BV32_LT\(.+,[ ]*alloc\)[ ]*;[ ]*\n", "",
            @"",

            @"/\*assert \*/ assume INT_LEQ\(.+, alloc\);\n", "",
            @"",

            @"/\*assert \*/ assume BV32_LEQ\(.+, alloc\);\n", "",
            @"",

            @"type name;\n", "",
            @"",

            @"var Mem: \[name\]\[int\]int;\n", "",
            @"",

            @"var Mem: \[name\]\[bv32\]bv32;\n", "",
            @"",

            @"function Field\(int\) returns \(name\);\n", "",
            @"",

            @"function Field\(bv32\) returns \(name\);\n", "",
            @"",

            @"const unique .*:name;\n", "",
            @"",

            @"var ___LOOP_.*_Mem:\[name\]\[int\]int;\n", "",
            @"",

            @"var ___LOOP_.*_Mem:\[name\]\[bv32\]bv32;\n", "",
            @"",

            @"___LOOP_.*_Mem := Mem;\n", "",
            @"",

            @"function Base\(int\) returns \(int\);\n", "",
            @"",

            @"function Base\(bv32\) returns \(bv32\);\n", "",
            @"",

            @"//axiom\(forall x: int :: {Base\(x\)} Base\(x\) <= x\);\n", "",
            @"",

            @"//axiom\(forall x: bv32 :: {Base\(x\)} Base\(x\) <= x\);\n", "",
            @"",

            @"axiom\(forall x: int :: {Base\(x\)} INT_LEQ\(Base\(x\), x\)\);\n", "",
            @"",

            @"axiom\(forall x: bv32 :: {Base\(x\)} BV32_LEQ\(Base\(x\), x\)\);\n", "",
            @"",

            @"axiom\(forall b:int, a:int, t:name :: {MatchBase\(b, a, T.Ptr\(t\)\)} MatchBase\(b, a, T.Ptr\(t\)\) <==> Base\(a\) == b\);\n", "",
            @"",

            @"axiom\(forall b:bv32, a:bv32, t:name :: {MatchBase\(b, a, T.Ptr\(t\)\)} MatchBase\(b, a, T.Ptr\(t\)\) <==> Base\(a\) == b\);\n", "",
            @"",

            @"axiom\(forall v:int, t:name :: {HasType\(v, T.Ptr\(t\)\)} HasType\(v, T.Ptr\(t\)\) <==> \(v == 0 \|\| \(INT_GT\(v, 0\) && Match\(v, t\) && MatchBase\(Base\(v\), v, t\)\)\)\);\n", "",
            @"",

            @"axiom\(forall v:bv32, t:name :: {HasType\(v, T.Ptr\(t\)\)} HasType\(v, T.Ptr\(t\)\) <==> \(v == 0bv32 \|\| \(BV32_GT\(v, 0bv32\) && Match\(v, t\) && MatchBase\(Base\(v\), v, t\)\)\)\);\n", "",
            @"",

            @"ensures Base\(new\) == new;\n", "",
            @"",

            @"axiom\(Base\(.+\) == .+\);\n", "",
            @"",

            @"assume \(Base\(.+\) == .+\);\n", "",
            @"",

            @"type byte;.*FourBytesToInt\(c0, c1, c2, c3\) ==> b0 == c0 && b1 == c1 && b2 == c2 && b3 == c3\);", "dotall",
            @"",

            // Get rid of MemSet
            //@"// Memset starts.*// Memset ends\n", "dotall",
            //@"",

            @"ensures \(Subset\(Empty\(\).*\n", "",
            @"",

            @"function Equal\(\[int\]bool, \[int\]bool\) returns \(bool\);.*Unified\(M\[Field\(x\) := M\[Field\(x\)\]\[x := y\]\]\) == Unified\(M\)\[x := y\]\);", "dotall",
            @"",

            @"function Equal\(\[bv32\]bool, \[bv32\]bool\) returns \(bool\);.*Unified\(M\[Field\(x\) := M\[Field\(x\)\]\[x := y\]\]\) == Unified\(M\)\[x := y\]\);", "dotall",
            @"",

            @"function Match\(a:int, t:name\) returns \(bool\);.*Field\(a\) == T.Ptr\(t\)\);", "dotall",
            @"",

            @"function Match\(a:bv32, t:name\) returns \(bool\);.*Field\(a\) == T.Ptr\(t\)\);", "dotall",
            @"",

            @"axiom\(forall a:int, b:int :: {BIT_BAND\(a,b\)}.*{BIT_BAND\(a,b\)} a == 0 \|\| b == 0 ==> BIT_BAND\(a,b\) == 0\);", "dotall",
            @"",

            @"axiom\(forall a:bv32, b:bv32 :: {BIT_BAND\(a,b\)}.*{BIT_BAND\(a,b\)} a == 0bv32 \|\| b == 0bv32 ==> BIT_BAND\(a,b\) == 0bv32\);", "dotall",
            @"",

            @"axiom\(forall a:int, b:int :: {DIV\(a,b\)}.*a > b \* \(DIV\(a,b\) \+ 1\)[ ]*\n[ ]*\);", "dotall",
            @"",

            @"axiom\(forall a:bv32, b:bv32 :: {DIV\(a,b\)}.*a > b \* \(DIV\(a,b\) \+ 1bv32\)[ ]*\n[ ]*\);", "dotall",
            @"",

            //@"function POW2\(a:int\) returns \(bool\);.*axiom POW2\(33554432\);", "dotall",
            //@"",

            //@"function POW2\(a:bv32\) returns \(bool\);.*axiom POW2\(33554432bv32\);", "dotall",
            //@"",

            @"procedure nondet_choice\(\) returns \(x:int\);.*ensures x == DetChoiceFunc\(old\(detChoiceCnt\)\);", "dotall",
            @"",

            @"procedure nondet_choice\(\) returns \(x:bv32\);.*ensures x == DetChoiceFunc\(old\(detChoiceCnt\)\);", "dotall",
            @"",

            @"function .*Inv\(int\) returns \(int\);\n", "",
            @"",

            @"function .*Inv\(bv32\) returns \(bv32\);\n", "",
            @"",

            @"function _S_.*Inv\(\[int\]bool\) returns \(\[int\]bool\);\n", "",
            @"",

            @"function _S_.*\(\[int\]bool\) returns \(\[int\]bool\);\n", "",
            @"",

            @"axiom \(forall x:int :: {.*Inv\(.*\(x\)\)} .*Inv\(.*\(x\)\) == x\);\n", "",
            @"",

            @"axiom \(forall x:int :: {.*Inv\(x\)} .*\(.*Inv\(x\)\) == x\);\n", "",
            @"",

            @"axiom \(forall x:int, S:\[int\]bool :: {_S_.*\(S\)\[x\]} _S_.*\(S\)\[x\] <==> S\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:int, S:\[int\]bool :: {_S_.*Inv\(S\)\[x\]} _S_.*Inv\(S\)\[x\] <==> S\[.*\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:int, S:\[int\]bool :: {S\[x\], _S_.*\(S\)} S\[x\] ==> _S_.*\(S\)\[.*\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:int, S:\[int\]bool :: {_S_.*\(S\)\[x\]} _S_.*\(S\)\[x\] <==> S\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:int, S:\[int\]bool :: {S\[x\], _S_.*Inv\(S\)} S\[x\] ==> _S_.*Inv\(S\)\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"//axiom \(forall x:int :: {.*Inv\(x\)} .*Inv\(x\) == x - .*\);\n", "",
            @"",

            @"axiom \(forall x:int :: {.*Inv\(x\)} .*Inv\(x\) == INT_SUB\(x,.+\)\);\n", "",
            @"",

            @"axiom \(forall x:int :: {MINUS_BOTH_PTR_OR_BOTH_INT\(x, .*, .*\)} MINUS_BOTH_PTR_OR_BOTH_INT\(x, .*, .*\) == .*Inv\(x\)\);\n", "",
            @"",

            @"axiom \(forall x:int :: {MINUS_LEFT_PTR\(x, .*, .*\)} MINUS_LEFT_PTR\(x, .*, .*\) == .*Inv\(x\)\);\n", "",
            @"",

            @"//axiom \(forall x:int :: {.+\(x\)} .+\(x\) == PLUS\(x, 1, [0-9]+\)\);\n", "",
            @"",

            @"axiom \(forall x:int :: {.+\(x\)} .+\(x\) == PLUS\(x, 1, [0-9]+\)\);\n", "",
            @"",

            @".*detChoiceCnt.*", "",
            @"",

            @"function DetChoiceFunc\(a:int\) returns \(x:int\);\n", "",
            @"",

            @"procedure det_choice\(\) returns \(x:int\);\n", "",
            @"",

            @"var globalInSEHTry: bool;\n", "",
            @"",

            // bv32 patterns
            @"function _S_.*Inv\(\[bv32\]bool\) returns \(\[bv32\]bool\);\n", "",
            @"",

            @"function _S_.*\(\[bv32\]bool\) returns \(\[bv32\]bool\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {.*Inv\(.*\(x\)\)} .*Inv\(.*\(x\)\) == x\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {.*Inv\(x\)} .*\(.*Inv\(x\)\) == x\);\n", "",
            @"",

            @"axiom \(forall x:bv32, S:\[bv32\]bool :: {_S_.*\(S\)\[x\]} _S_.*\(S\)\[x\] <==> S\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:bv32, S:\[bv32\]bool :: {_S_.*Inv\(S\)\[x\]} _S_.*Inv\(S\)\[x\] <==> S\[.*\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:bv32, S:\[bv32\]bool :: {S\[x\], _S_.*\(S\)} S\[x\] ==> _S_.*\(S\)\[.*\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:bv32, S:\[bv32\]bool :: {_S_.*\(S\)\[x\]} _S_.*\(S\)\[x\] <==> S\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"axiom \(forall x:bv32, S:\[bv32\]bool :: {S\[x\], _S_.*Inv\(S\)} S\[x\] ==> _S_.*Inv\(S\)\[.*Inv\(x\)\]\);\n", "",
            @"",

            @"//axiom \(forall x:bv32 :: {.*Inv\(x\)} .*Inv\(x\) == x - .*\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {.*Inv\(x\)} .*Inv\(x\) == BV32_SUB\(x,.+\)\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {MINUS_BOTH_PTR_OR_BOTH_INT\(x, .*, .*\)} MINUS_BOTH_PTR_OR_BOTH_INT\(x, .*, .*\) == .*Inv\(x\)\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {MINUS_LEFT_PTR\(x, .*, .*\)} MINUS_LEFT_PTR\(x, .*, .*\) == .*Inv\(x\)\);\n", "",
            @"",

            @"//axiom \(forall x:bv32 :: {.+\(x\)} .+\(x\) == PLUS\(x, 1, [0-9]+\)\);\n", "",
            @"",

            @"axiom \(forall x:bv32 :: {.+\(x\)} .+\(x\) == PLUS\(x, 1bv32, [0-9]+bv32\)\);\n", "",
            @"",

            @".*detChoiceCnt.*", "",
            @"",

            @"function DetChoiceFunc\(a:bv32\) returns \(x:bv32\);\n", "",
            @"",

            @"procedure det_choice\(\) returns \(x:bv32\);\n", "",
            @"",

            @"var globalInSEHTry: bool;\n", "",
            @"",

            @"function {:inline true} INT_DIV\(x:int, y:int\)  returns  \(int\)   {x / y}", "",
            @"function {:inline true} INT_DIV(x:int, y:int)  returns  (int)   {x div y}",

            @"call {:async}", "",
            @"async call"
                                };

        static string cleanup(string file)
        {
            // Check consistency
            for (int i = 0; i < cmds.Length; i += 3)
            {
                if (cmds[i] == "dotall" || cmds[i + 2] == "dotall")
                {
                    throw new InternalError(string.Format("Something wrong at cmds[{0} ... {1}]", i, i + 2));
                }

                if (cmds[i + 1] != "" && cmds[i + 1] != "dotall")
                {
                    throw new InternalError(string.Format("Something wrong at cmds[{0} ... {1}]", i, i + 2));
                }
            }

            // Replace \\n at the end of a string with \n
            for (int i = 0; i < cmds.Length; i++)
            {
                cmds[i] = cmds[i].Replace(@"\n", "\r\n");
            }

            for (int i = 0; i < cmds.Length; i += 3)
            {
                file = doReplace(file, cmds[i], cmds[i+2], cmds[i+1] == "dotall");
            }

            return file;
        }

        static string doReplace(string src, string from, string to, bool dotall)
        {
            Regex re;
            if (dotall)
            {
                re = new Regex(from, RegexOptions.Singleline);
            }
            else
            {
                re = new Regex(from);
            }
            
            return re.Replace(src, to);
        }

        public class InternalError : System.ApplicationException
        {
            public InternalError(string msg) : base(msg) { }

        };

    }
}
