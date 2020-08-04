using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using cba.Util;
using System.Diagnostics;

namespace ProgTransformation
{
    // A compiler pass can be instantiated multiple times, but each instance can be
    // used only once. The pass records (permanently) its input and output program.
    abstract public class TransformationPass
    {
        public PersistentProgram input { get; protected set; }
        public PersistentProgram output { get; protected set; }

        // To enforce that a compilerpass instance is only
        // run once
        private bool alreadyRan;

        // Name of the transformation pass
        public string passName { get; protected set; }

        // To keep track of the number of passes run
        private static int passCount = 0;

        // Debug flag: all compiler pass outputs are written to file
        public static bool writeAllFiles = false;

        public TransformationPass()
        {
            input = null;
            output = null;
            alreadyRan = false;
            passName = "Unknown";
        }

        public PersistentProgram run(PersistentProgram inp)
        {
            Debug.Assert(!alreadyRan);
            alreadyRan = true;
            passCount++;

            // Save input
            setInput(inp);

            if (writeAllFiles)
            {
                string outfile = "tr" + passCount + "intput.bpl";
                input.writeToFile(outfile);
            }

            Log.WriteMemUsage();
            Log.WriteLine(Log.Debug, "Running transformation pass " + passCount.ToString() + ": " + passName);
            //Log.WriteLine(Log.Normal, "Running transformation pass " + passCount.ToString() + ": " + passName); 

            Program outp = runPass(getInput(input)); 

            // Save output
            if (outp == null)
            {
                return input;
            }

            output = recordOutput(outp);

            if (writeAllFiles)
            {
                string outfile = "tr" + passCount + "output.bpl";
                output.writeToFile(outfile);
            }

            return output;
        }

        virtual protected Program getInput(PersistentProgram inp)
        {
            return inp.getProgram();
        }

        virtual protected PersistentProgram recordOutput(Program p)
        {
            return new PersistentProgram(p);
        }

        public void setInput(PersistentProgram p)
        {
            input = p;
        }

        abstract protected Program runPass(Program inp);
    }

}
