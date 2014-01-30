﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;
using cba.Util;

namespace cba
{
    public class Configs
    {
        public static void usage()
        {
            Console.WriteLine("Usage: cba fname [Flags]");
            Console.WriteLine();
            Console.WriteLine("-------------------------------------------------------------");
            Console.WriteLine("Flags:");
            Console.WriteLine(" /k:int             \t Sets execution context bound");
            Console.WriteLine(" /main:str          \t Sets main procedure name");

            Console.WriteLine(" /recursionBound:int\t Set recursion depth bound");

            Console.WriteLine(" /trackAllVars      \t Track all shared variables.");
            Console.WriteLine(" /track:str         \t Track variable str.");
            Console.WriteLine(" /useArrayTheory    \t Use native array theory for z3.");
            Console.WriteLine("                    \t (This doesn't allow user-defined types.)");
            Console.WriteLine(" /timeLimit:n       \t Set Z3 timeout to n sec (default 500)");
            Console.WriteLine(" /flags:file        \t Read flags from file.");
            Console.WriteLine(" /printBoogieExt \t Prints language extensions made to Boogie");
            Console.WriteLine();
            Console.WriteLine("-------------------------------------------------------------");
        }

        public void printLanguageSemantics()
        {
            Console.WriteLine("-------------------------------------------------------------");
            Console.WriteLine("Language Extensions:");
            Console.WriteLine("Thread spawn      : \"async call n := foo(...)\" \t Returns thread id");
            LanguageSemantics.print();
            Console.WriteLine("-------------------------------------------------------------");
        }

        public int contextBound { get; private set; }

        public string mainProcName { get; set; }

        public HashSet<string> trackedVars { get; private set; }
        public HashSet<string> trackedVarsSecondary { get; private set; }
        public bool trackAllVars { get; private set; }

        public HashSet<string> ignoreAssertMethods { get; private set; }

        public int staticInlining { get; private set; }
        public int recursionBound { get; private set; }

        public bool useLocalVariableAbstraction { get; private set; }

        public bool genCTrace { get; private set; }
        public bool noTrace { get; private set; }

        public bool detectConstantLoops { get; private set; }
        public bool computeStats { get; private set; }

        public bool printProgress { get; private set; }

        public string inputFile { get; private set; }
        
        private List<string> includeFiles;

        public bool newStratifiedInlining { get; private set; }

        public bool useArrayTheory { get; private set; }

        public bool printInstrumented { get; private set; }
        public bool printVerify { get; private set; }
        public int printData {get; set;}

        public string instrumentedFile { get; private set; }

        public bool noRaiseException { get; private set; }

        public int memLimit { get; private set; }

        public bool noCallTreeReuse { get; private set; }

        public string refinementAlgo { get; private set; }

        public int timeout { get; private set; }

        public string printFinalProg { get; private set; }

        public string boogieOpts { get; private set; }
        public bool cadeTiming { get; private set; }

        public bool sdvMode { get; private set; }
        public bool sdvInstrumentAssert { get; private set; }

        public int runHoudini { get; private set; }
        public string runAbsHoudini { get; private set; }
        public bool summaryComputation { get; private set; }
        public bool printBoogieFlags { get; private set; }

        public bool NonUniformUnfolding { get; private set; }

        public int verboseMode { get; private set; }
        public string houdiniQuery { get; private set; }

        public bool useInitialPruning { get; private set; }
        public bool checkStaticAnalysis { get; private set; }
        public bool siOnly { get; private set; }
        public List<string> annotations { get; private set; }
        public int FwdBckSearch;
        public string assertsPassed { get; private set; }
        public bool assertsPassedIsInt { get; private set; }
        public bool fwdBckInRef { get; private set; }

        public bool catchAllExceptions { get; private set; }
        public List<string> specialVars { get; private set; }

        public bool deepAsserts { get; private set; }

        public bool cooperativeYield { get; private set; }
        public bool unifyMaps { get; private set; }

        public bool debugMemAccesses { get; private set; }

        public HashSet<string> tryDroppingForRefinement { get; private set; }
        public string unfoldRecursion { get; private set; }

        public int houdiniTimeout { get; private set; }
        public bool fastRequiresInference { get; private set; }

        public bool useProverEvaluate { get; private set; }

        public int explainError { get; private set; }
        public int explainErrorTimeout { get; private set; }
        public int explainErrorFilters { get; private set; }

        public bool trainSummaries { get; private set; }

        public HashSet<string> recordValues { get; private set; }
        public bool printAllTraces { get; private set; }
        public int rootCause { get; private set; }
        public int maxStaticLoopBound { get; private set; }
        public bool disableStaticAnalysis { get; private set; }
	public bool useDuality { get; private set; }

        public static Configs parseCommandLine(string[] args)
        {
            var inputFlags = FlagReader.read(args);

            // Go through flags and find the bpl file and 
            // other flags

            string inputFile = null;

            List<string> flags = new List<string>();

            foreach (var str in inputFlags)
            {
                if (FlagReader.isFlag(str))
                {
                    flags.Add(str);
                    continue;
                }

                if (str.EndsWith(".bpl"))
                {
                    if (inputFile != null)
                    {
                        throw new UsageError(string.Format("Multiple input files given: {0} and {1}", inputFile, str));
                    }

                    inputFile = str;
                    continue;
                }

                throw new UsageError("Unknown argument: " + str);
            }

            if (inputFile == null)
            {
                throw new UsageError("Input file not given");
            }

            if (!System.IO.File.Exists(inputFile))
            {
                throw new UsageError(string.Format("Input file {0} does not exist", inputFile));
            }

            Configs config = new Configs();
            config.inputFile = inputFile;

            foreach (var flag in flags)
            {
                config.parseFlag(flag);
            }

            // Concatenate include files
            if (config.includeFiles.Count != 0)
            {
                var newfilePrefix = "CorralTmpConcatFile";
                var newfile = newfilePrefix + ".bpl";
                StreamWriter w = null;
                try
                {
                    w = new StreamWriter(newfile);
                }
                catch (Exception e)
                {
                    throw new UsageError(string.Format("Error opening file {0}. {1}", newfile, e.Message));
                }
                config.includeFiles.Add(config.inputFile);
                foreach (var infile in config.includeFiles)
                {
                    StreamReader r = null;
                    try
                    {
                        r = new StreamReader(infile);
                    }
                    catch (Exception e)
                    {
                        throw new UsageError(string.Format("Error opening file {0}. {1}", newfile, e.Message));
                    }
                    w.Write(r.ReadToEnd() + Environment.NewLine);
                    r.Close();
                }
                w.Close();
                config.inputFile = newfile;
            }


            if (config.contextBound <= 0)
            {
                throw new UsageError("Context bound invalid");
            }

            if (config.recursionBound < 1)
            {
                Console.WriteLine("Warning: Using default recursion bound of 1");
                config.recursionBound = 1;
            }

            if (config.explainError > 0 && !config.sdvMode)
            {
                throw new UsageError("Bug witness currently only supported in SDV mode");
            }

            return config;
        }

        private Configs()
        {
            // Set defaults
            contextBound = 2;
            mainProcName = null;
            trackAllVars = false;

            staticInlining = 0;

            useLocalVariableAbstraction = false;
            trackedVars = new HashSet<string>();
            trackedVarsSecondary = new HashSet<string>();
            ignoreAssertMethods = new HashSet<string>();
            genCTrace = false;
            noTrace = false;
            computeStats = false;
            printProgress = false;
            inputFile = null;
            includeFiles = new List<string>();
            useArrayTheory = false;
            printInstrumented = false;
            printVerify = false;
            instrumentedFile = "instrumented.bpl";
            noRaiseException = false;
            memLimit = 0;
            recursionBound = -1;
            timeout = 0;
            boogieOpts = " ";
            printFinalProg = null;
            refinementAlgo = "tttt";
            noCallTreeReuse = false;
            cadeTiming = false;

            printData = 0;

            sdvMode = false;
            sdvInstrumentAssert = false;

            runHoudini = -2;
            runAbsHoudini = null;
            summaryComputation = false;

            printBoogieFlags = false;

            verboseMode = 0;
            detectConstantLoops = false;

            houdiniQuery = null;
            useInitialPruning = true;
            checkStaticAnalysis = false;
            siOnly = false;
            annotations = new List<string>();
            maxStaticLoopBound = 10;
            NonUniformUnfolding = false;
            FwdBckSearch = 0;
            assertsPassed = "assertsPassed";
            assertsPassedIsInt = false;
            fwdBckInRef = false;

            catchAllExceptions = false;
            specialVars = new List<string>();

            cooperativeYield = false;
            unifyMaps = false;
            debugMemAccesses = false;

            tryDroppingForRefinement = new HashSet<string>();

            unfoldRecursion = null;

            houdiniTimeout = -1;
            fastRequiresInference = false;

            useProverEvaluate = false;

            explainError = 0;
            explainErrorTimeout = 0;
            explainErrorFilters = 0;
            recordValues = new HashSet<string>();
            printAllTraces = false;
            rootCause = -1;
            disableStaticAnalysis = false;

            deepAsserts = false;
        }


        private void parseFlag(string flag)
        {
            var sep = new char[1];
            sep[0] = ':';

            if (flag.StartsWith("/k:"))
            {
                var split = flag.Split(sep);
                contextBound = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/main:"))
            {
                var split = flag.Split(sep);
                mainProcName = split[1];
            }
            else if (flag == "/trackAllVars")
            {
                trackAllVars = true;
            }
            else if (flag.StartsWith("/track:"))
            {
                var split = flag.Split(sep);
                trackedVars.Add(split[1]);
            }
            else if (flag.StartsWith("/trackSecondary:"))
            {
                var split = flag.Split(sep);
                trackedVarsSecondary.Add(split[1]);
            }
            else if (flag.StartsWith("/dislike:"))
            {
                var split = flag.Split(sep);
                tryDroppingForRefinement.Add(split[1]);
            }
            else if (flag == "/unfoldRecursion")
            {
                unfoldRecursion = "unfolded.bpl";
            }
            else if (flag.StartsWith("/unfoldRecursion:"))
            {
                var split = flag.Split(sep);
                unfoldRecursion = split[1];
            }
            else if (flag.StartsWith("/ignoreAssertMethod:"))
            {
                var split = flag.Split(sep);
                ignoreAssertMethods.Add(split[1]);
            }
            else if (flag.StartsWith("/include:"))
            {
                // Ignore this file. It is for BctCleanup.
            }
            else if (flag.StartsWith("/concat:"))
            {
                var split = flag.Split(sep);
                includeFiles.Add(split[1]);
            }
            else if (flag == "/staticInlining")
            {
                staticInlining = 1;
            }
            else if (flag.StartsWith("/special"))
            {
                var split = flag.Split(sep);
                specialVars.Add(split[1]);
            }
            else if (flag == "/unifyMaps")
            {
                unifyMaps = true;
            }
            else if (flag == "/debugMemAccesses")
            {
                debugMemAccesses = true;
                printData = 1;
            }
            else if (flag == "/explainError")
            {
                explainError = 1;
                useProverEvaluate = true;
            }
            else if (flag == "/trainSummaries")
            {
                trainSummaries = true;
            }
            else if (flag.StartsWith("/rootCause"))
            {
                var split = flag.Split(sep);
                rootCause = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/explainError:"))
            {
                var split = flag.Split(sep);
                explainError = Int32.Parse(split[1]);
                if (split.Length == 3)
                    explainErrorTimeout = Int32.Parse(split[2]);
                if (split.Length == 4)
                    explainErrorFilters = Int32.Parse(split[3]);
                useProverEvaluate = true;
            }
            else if (flag.StartsWith("/recursionBound:"))
            {
                var split = flag.Split(sep);
                recursionBound = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/timeLimit:"))
            {
                var split = flag.Split(sep);
                timeout = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/memLimit:"))
            {
                var split = flag.Split(sep);
                memLimit = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/houdiniTimeLimit:"))
            {
                var split = flag.Split(sep);
                houdiniTimeout = Int32.Parse(split[1]);
            }
            else if (flag == "/fastRequiresInference")
            {
                fastRequiresInference = true;
            }
            else if (flag == "/cadeTiming")
            {
                cadeTiming = true;
            }
            else if (flag == "/useArrayTheory")
            {
                useArrayTheory = true;
            }
            else if (flag == "/useProverEvaluate")
            {
                useProverEvaluate = true;
            }
            else if (flag == "/sdv")
            {
                sdvMode = true;
            }
            else if (flag == "/sdvInstrumentAssert")
            {
                sdvInstrumentAssert = true;
            }
            else if (flag == "/noCallTreeReuse")
            {
                noCallTreeReuse = true;
            }
            else if (flag == "/printInstrumented")
            {
                printInstrumented = true;
            }
            else if (flag == "/printVerify")
            {
                printVerify = true;
            }
            else if (flag.StartsWith("/printFinalProg:"))
            {
                var split = flag.Split(sep);
                printFinalProg = split[1];
            }
            else if (flag == "/printVerify")
            {
                printVerify = true;
            }
            else if (flag.StartsWith("/printDataValues:"))
            {
                var split = flag.Split(sep);
                printData = Int32.Parse(split[1]);
            }
            else if (flag == "/printMemUsage")
            {
                Log.printMemUsage = true;
            }
            else if (flag == "/nonUniformUnfolding")
            {
                NonUniformUnfolding = true;
            }
            else if (flag == "/printAllTraces")
            {
                printAllTraces = true;
                genCTrace = true;
            }
            else if (flag.StartsWith("/printInstrumented:"))
            {
                var split = flag.Split(sep);
                printInstrumented = true;
                instrumentedFile = split[1];
            }
            else if (flag == "/disableStaticAnalysis")
            {
                disableStaticAnalysis = true;
            }
            else if (flag.StartsWith("/runHoudini:"))
            {
                var split = flag.Split(sep);
                runHoudini = Int32.Parse(split[1]);
                summaryComputation = false;
            }
            else if (flag.StartsWith("/runHoudini"))
            {
                runHoudini = -1;
                summaryComputation = false;
            }
            else if (flag.StartsWith("/runAbsHoudini:"))
            {
                var split = flag.Split(sep);
                runAbsHoudini = split[1];
            }
            else if (flag == "/computeSummary")
            {
                runHoudini = -2;
                summaryComputation = true;
            }
            // Other experimental flags
            else if (flag.StartsWith("/ann:"))
            {
                annotations.Add(flag.Substring("/ann:".Length));
            }
            else if (flag.StartsWith("/maxStaticLoopBound:"))
            {
                var split = flag.Split(sep);
                maxStaticLoopBound = Int32.Parse(split[1]);
            }
            else if (flag == "/useLocalVarAbs")
            {
                useLocalVariableAbstraction = true;
            }
            else if (flag == "/noRaiseException")
            {
                noRaiseException = true;
            }
            else if (flag == "/tryCTrace")
            {
                genCTrace = true;
            }
            else if (flag == "/noTrace")
            {
                noTrace = true;
            }
            else if (flag == "/catchAll")
            {
                catchAllExceptions = true;
            }
            else if (flag == "/noInitPruning")
            {
                useInitialPruning = false;
            }
            else if (flag.StartsWith("/printHoudiniQuery:"))
            {
                var split = flag.Split(sep);
                houdiniQuery = split[1];
            }
            else if (flag == "/doNotUseLabels")
            {
                boogieOpts += " " + flag + " ";
            }
            else if (flag.StartsWith("/v:"))
            {
                var split = flag.Split(sep);
                verboseMode = Int32.Parse(split[1]);
            }
            else if (flag.StartsWith("/refinementAlgo:"))
            {
                var split = flag.Split(sep);
                refinementAlgo = split[1];
                if (refinementAlgo.Length != 4)
                {
                    throw new UsageError("Unknown flag: " + flag);
                }
            }
            else if (flag == "/printBoogieFlags")
            {
                printBoogieFlags = true;
            }
            else if (flag == "/printProgress")
            {
                printProgress = true;
            }
            else if (flag == "/cloops")
            {
                detectConstantLoops = true;
            }
            else if (flag == "/cloops:a")
            {
                detectConstantLoops = true;
                ConstLoop.aggressive = true;
            }
            else if (flag == "/stats")
            {
                computeStats = true;
            }
            else if (flag == "/break")
            {
                System.Diagnostics.Debugger.Launch();
            }
            else if (flag == "/si")
            {
                siOnly = true;
            }
            else if (flag == "/deepAsserts")
            {
                deepAsserts = true;
            }
            else if (flag.StartsWith("/z3opt"))
            {
                boogieOpts += " " + flag + " ";
            }
            else if (flag.StartsWith("/proverLog:"))
            {
                boogieOpts += " " + flag + " ";
            }
            else if (flag == "/checkStaticAnalysis")
            {
                checkStaticAnalysis = true;
            }
            else if (flag == "/prover:smtlib")
            {
                boogieOpts += " " + flag + " ";
            }
            else if (flag.StartsWith("/bopt:"))
            {
                boogieOpts += " \"/" + flag.Substring("/bopt:".Length) + "\" ";
            }
            else if (flag == "/printBoogieExt")
            {
                printLanguageSemantics();
                throw new InvalidInput("Stopping");
            }
            else if (flag == "/newStratifiedInlining")
            {
                newStratifiedInlining = true;
            }
            else if (flag == "/fwdBck")
            {
                FwdBckSearch = 1;
            }
            else if (flag.StartsWith("/recordScalar:"))
            {
                var split = flag.Split(sep);
                recordValues.Add(split[1]);
            }
            else if (flag.StartsWith("/assertVar:"))
            {
                var split = flag.Split(sep);
                assertsPassed = split[1];
            }
            else if (flag == "/assertVarIsInt")
            {
                assertsPassedIsInt = true;
            }
            else if (flag == "/fwdBckInRef")
            {
                fwdBckInRef = true;
            }
            else if (flag == "/cooperative")
            {
                /**
                 * Normally, the sequentialization adds a context switch before every access to shared variables.
                 * When /cooperative is given, this behaviour is suppressed.
                 * context switches are only added where explictly specified by a dummy call to corral_yield. 
                 **/
                cooperativeYield = true;
            }
            else if (flag == "/useDuality")
            {
                useDuality = true;
            }
            else
            {
                throw new UsageError("Invalid flag: " + flag);
            }
        }

    }
}
