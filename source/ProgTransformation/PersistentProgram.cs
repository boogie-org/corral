
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;
using System.IO;
using System.Diagnostics;

namespace ProgTransformation
{

    // PersistentProgram does not allow
    // in-place modifications to its internal program. 
    public class PersistentProgram: PersistentProgramAbs
    {
        public static bool useIO = true;
        public static int memLimit = 0;
        public static bool clearTokens = false;

        PersistentProgramAbs pprog;

        public PersistentProgram(Program p)
        {
            if (useIO)
            {
                pprog = new PersistentProgramIO(p);
            }
            else
            {
                pprog = new PersistentProgramDup(p);
            }
        }

        // Write the program to a file
        public override void writeToFile(string fname)
        {
            pprog.writeToFile(fname);
        }

        // Return a new copy of the program
        public override Program getProgram()
        {
            return pprog.getProgram();
        }

        public static void FreeParserMemory()
        {
            Program temp;
            Parser.Parse("", "emptyFile", out temp);
        }

        public static void ClearTokens(Program program)
        {
            FreeParserMemory();
            program.TopLevelDeclarations
                .OfType<Implementation>()
                .Iter(impl => impl.StructuredStmts = new StmtList(new List<BigBlock>(), Token.NoToken));

            var avisitor = new AbsyVisitor();
            avisitor.VisitProgram(program);
            avisitor.m.Values.Iter(absy => absy.tok = Token.NoToken);
        }

    }

    // PersistentProgram does not allow
    // in-place modifications to its internal program. 
    abstract public class PersistentProgramAbs
    {
        public static TimeSpan persistenceCost = TimeSpan.Zero;

        public PersistentProgramAbs() { }

        // Write the program to a file
        abstract public void writeToFile(string fname);

        // Return a new copy of the program
        abstract public Program getProgram();

    }

    // PersistentProgram does not allow
    // in-place modifications to its internal program. 
    public class PersistentProgramIO : PersistentProgramAbs
    {
        public static bool useFiles = false;
        public static bool useStrings = false;

        public static bool useDuplicator = false;

        static int count = 0;

        // For moving all programs to disk under memory pressure
        static List<WeakReference> programs = new List<WeakReference>();

        static bool changedSettingsForSavingMemory = false;

        private string fileName;
        // A presistent version of the program
        // TODO: Dispose this in the destructor?
        private object programStream;

        // It is OK to make copies of unresolved programs
        private Program unresolved_program;

        public PersistentProgramIO(Program p)
        {
            readInProgram(p);
            unresolved_program = null;

            programs.Add(new WeakReference(this));
        }

        public static void CheckMemoryPressure()
        {
            if (PersistentProgram.memLimit == 0) return;
            
            // Check if we're within 80% of the limit
            var mem = BoogieUtil.GetMemUsage();
            if (mem < (0.8) * PersistentProgram.memLimit) return;

            PersistentProgram.FreeParserMemory();
            GC.Collect();

            if (changedSettingsForSavingMemory) return;
            changedSettingsForSavingMemory = true;

            // Set flags
            useFiles = true;
            useDuplicator = false;
            PersistentProgram.FreeParserMemory();

            // Move all programs to disk
            programs = programs.Filter(wr => wr.IsAlive);
            var stat = 0;
            foreach (var wr in programs)
            {
                var p = wr.Target as PersistentProgramIO;
                if (p == null) continue;
                if (p.programStream is FileStream) continue;

                p.unresolved_program = null;
                p.fileName = "temp_corral_file" + count.ToString();
                count++;

                if (p.programStream is MemoryStream)
                {
                    var fs = new FileStream(p.fileName, FileMode.Create);
                    fs.Write((p.programStream as MemoryStream).GetBuffer(), 0, (int)(p.programStream as MemoryStream).Length);
                    p.programStream = fs;
                }
                else
                {
                    Debug.Assert(p.programStream is string);
                    System.IO.File.WriteAllText(p.fileName, (string)p.programStream);
                    p.programStream = new FileStream(p.fileName, FileMode.Open);
                }
                stat++;
            }

            if(stat != 0)
                Console.WriteLine("Moved {0} files to disk to save memory", stat);

            // Force GC
            GC.Collect();
        }

        private void readInProgram(Program p)
        {
            var startTime = DateTime.Now;

            // Make a copy of p into the persistent storage

            if (useFiles)
            {
                fileName = "temp_corral_file" + count.ToString();
                programStream = new FileStream(fileName, FileMode.Create);
                count++;

                StreamWriter writer = new StreamWriter(programStream as FileStream);
                p.Emit(new TokenTextWriter(writer));
                writer.Flush();
            }
            else if (useStrings)
            {
                fileName = "";
                var sw = new StringWriter();
                p.Emit(new TokenTextWriter(sw));
                sw.Flush();
                programStream = sw.ToString();
            }
            else
            {
                fileName = "";
                programStream = new MemoryStream();

                StreamWriter writer = new StreamWriter(programStream as MemoryStream);
                p.Emit(new TokenTextWriter(writer));
                writer.Flush();
            }


            persistenceCost += (DateTime.Now - startTime);
        }

        // Write the program to a file
        public override void writeToFile(string fname)
        {
            if (programStream is FileStream)
            {
                System.Diagnostics.Debug.Assert(fname != fileName);
                System.IO.File.Copy(fileName, fname, true);
            }
            else if (programStream is MemoryStream)
            {
                
                FileStream fs = new FileStream(fname, FileMode.Create);
                fs.Write((programStream as MemoryStream).GetBuffer(), 0, (int)(programStream as MemoryStream).Length);
                fs.Close();
            }
            else 
            {
                System.Diagnostics.Debug.Assert(programStream is string);
                System.IO.File.WriteAllText(fname, (string)programStream);
            }
            
        }

        // Return a new copy of the program
        public override Program getProgram()
        {
            var startTime = DateTime.Now;
            Program ret;

            if (unresolved_program != null)
            {
                FixedDuplicator dup = new FixedDuplicator();
                ret = dup.VisitProgram(unresolved_program);
            }
            else
            {
                var progStr = "";
                if (programStream is FileStream || programStream is MemoryStream)
                {
                    var stream = programStream as Stream;
                    stream.Seek(0, SeekOrigin.Begin);
                    progStr = ParserHelper.Fill(stream, new List<string>());
                }
                else
                {
                    Debug.Assert(programStream is string);
                    progStr = (string)programStream;
                }

                var v = Parser.Parse(progStr, "PersistentProgram", out ret);

                if (v != 0)
                {
                    writeToFile("error.bpl");
                    throw new InternalError("Illegal program given to PersistentProgram");
                }

                if (PersistentProgram.clearTokens)
                    PersistentProgram.ClearTokens(ret);

                // TODO: use this always (sometimes .NET-2-Boogie programs crash)
                if (useDuplicator)
                {
                    FixedDuplicator dup = new FixedDuplicator();
                    unresolved_program = dup.VisitProgram(ret);
                }
            }

            if (ret.Resolve() != 0)
            {
                writeToFile("error.bpl");
                throw new InternalError("Illegal program given to PersistentProgram");
            }

            persistenceCost += (DateTime.Now - startTime);
            return ret;
        }

    }

    // PersistentProgram does not allow
    // in-place modifications to its internal program. 
    public class PersistentProgramDup : PersistentProgramAbs
    {
        private Program program;

        public PersistentProgramDup(Program p)
        {
            readInProgram(p);
        }

        private void readInProgram(Program p)
        {
            var startTime = DateTime.Now;

            // Make a copy of p into the persistent storage
            FixedDuplicator dup = new FixedDuplicator();
            program = dup.VisitProgram(p);

            // Unresolve the program to break any pointer links
            var unresolver = new UnResolver();
            unresolver.VisitProgram(program);

            persistenceCost += (DateTime.Now - startTime);
        }

        // Write the program to a file
        public override void writeToFile(string fname)
        {
            BoogieUtil.PrintProgram(program, fname);
        }

        // Return a new copy of the program
        public override Program getProgram()
        {
            var startTime = DateTime.Now;

            FixedDuplicator dup = new FixedDuplicator();
            Program ret = dup.VisitProgram(program);

            if (ret.Resolve() != 0 || ret.Typecheck() != 0)
            {
                BoogieUtil.PrintProgram(ret, "error.bpl");
                throw new InternalError("Illegal program given to PersistentProgram");
            }

            persistenceCost += (DateTime.Now - startTime);
            return ret;
        }

    }

}
