using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Boogie;
using System.Diagnostics;
using cba.Util;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace cba
{
    public class CBADriver
    {
        // Did the last verification attempt reach the recursion bound?
        public static bool reachedBound = false;

        // Verify prog while tracking only variables in trackedVars.
        // Returns true if no error is found.
        // Returns false if error is found. Returns counterexample via pout
        // If returnTrace is set to false, then pout is always null 
        //     (no counterexample generation is attempted)
        // cex: the error trace in prog (if there is one)
        // tinfo: the transformation carried out in going from prog to pout
        // Call this method via: checkProgram or checkPath
        private static bool VerifyProgram(ref PersistentCBAProgram prog, VarSet trackedVars, bool returnTrace,
            out PersistentCBAProgram pout, out InsertionTrans tinfo, out ErrorTrace cex)
        {
            PersistentCBAProgram curr = prog;
            pout = null;
            cex = null;
            tinfo = null;

            //////
            // These are the compilation phases         
            //////
            
            VariableSlicePass cp1 = new VariableSlicePass(trackedVars);
            StormInstrumentationPass cp2 = null;
            var recordK = new HashSet<string>();

            if (!GlobalConfig.isSingleThreaded)
            {
                cp2 = new StormInstrumentationPass();
            }

            StaticInliningAndUnrollingPass cp3 = null;
            if (GlobalConfig.staticInlining > 0) cp3 = new StaticInliningAndUnrollingPass(new StaticSettings(CommandLineOptions.Clo.RecursionBound, CommandLineOptions.Clo.RecursionBound));

            ContractInfer ciPass = null;

            // Run the source transformations
            curr = cp1.run(curr);
            if (cp2 != null) curr = cp2.run(curr);
            if(cp3 != null) curr = cp3.run(curr);

            // infer contracts
            if (GlobalConfig.InferPass != null)
            {
                ciPass = new ContractInfer(GlobalConfig.InferPass);
                ciPass.ExtractLoops = false;
                curr = ciPass.run(curr);
                Console.WriteLine("Houdini took {0} seconds", ciPass.lastRun.TotalSeconds.ToString("F2"));
                GlobalConfig.InferPass = null;

                // add summaries to the original program
                prog = ciPass.addSummaries(prog);
            }

            // record k and tid
            if (cp2 != null)
            {
                recordK.Add(cp2.varKName); recordK.Add(cp2.tidVarName);
            }

            // Now verify  
            VerificationPass cp4 = new VerificationPass(true, recordK);
            curr = cp4.run(curr);

            reachedBound = cp4.reachedBound;

            if (cp4.success)
            {
                // Program correct.
                return true;
            }
            else if (!returnTrace)
            {
                return false;
            }
            else
            {
                // Concretize the trace and see if its a real bug

                // Concretization: map back the trace to the original program
                var trace4 = cp4.trace;
                //PrintProgramPath.print(cp4.input as PersistentCBAProgram, trace4, "temp4");

                if (ciPass != null) trace4 = ciPass.mapBackTrace(trace4);
                var trace3 = trace4;
                
                
                if (cp3 != null)
                {
                    trace3 = cp3.mapBackTrace(trace4);
                }
                //PrintProgramPath.print(cp3.input as PersistentCBAProgram, trace3, "temp3");

                var trace2 = trace3;
                if (cp2 != null) trace2 = cp2.mapBackTrace(trace3);

                var trace1 = cp1.mapBackTrace(trace2);
                //PrintProgramPath.print(cp1.input as PersistentCBAProgram, trace1, "temp1");

                cex = trace1;

                // Restrict the program to the trace
                tinfo = new InsertionTrans();
                var traceProgCons = new RestrictToTrace(cp1.input.getProgram(), tinfo);
                ErrorTrace.fillInContextSwitchInfo(trace1);
                traceProgCons.addTrace(trace1);
                
                pout =
                    new PersistentCBAProgram(traceProgCons.getProgram(),
                        traceProgCons.getFirstNameInstance(cp1.getInput().mainProcName),
                        cp1.getInput().contextBound,
                        ConcurrencyMode.FixedContext);

                //pout.writeToFile("pout.bpl");
                return false;
            }
        }

        public static bool checkProgram(ref PersistentCBAProgram prog, VarSet trackedVars, bool returnTrace,
            out PersistentCBAProgram pout, out InsertionTrans tinfo, out ErrorTrace cex)
        {
            ConfigManager.beginProgVerification();
            try
            {
                var ret = VerifyProgram(ref prog, trackedVars, returnTrace, out pout, out tinfo, out cex);
                ConfigManager.endProgVerification();
                return ret;
            }
            catch (Exception)
            {
                ConfigManager.endProgVerification();
                throw;
            }
        }

        public static bool checkPath(PersistentCBAProgram prog, VarSet trackedVars, bool returnTrace,
            out PersistentCBAProgram pout, out InsertionTrans tinfo, out ErrorTrace cex)
        {
            ConfigManager.beginPathVerification(returnTrace);
            try
            {
                var ret = VerifyProgram(ref prog, trackedVars, returnTrace, out pout, out tinfo, out cex);
                ConfigManager.endPathVerification();
                return ret;
            }
            catch (Exception)
            {
                ConfigManager.endPathVerification();
                throw;
            }
        }

        public static bool checkPath(PersistentCBAProgram pmeta, VarSet trackedVars)
        {
            PersistentCBAProgram temp;
            ErrorTrace temp2;
            InsertionTrans temp3;
            return checkPath(pmeta, trackedVars, false, out temp, out temp3, out temp2);
        }

        public static bool checkPath(PersistentCBAProgram pmeta, VarSet trackedVars, out ErrorTrace trace)
        {
            PersistentCBAProgram temp;
            InsertionTrans temp2;

            return checkPath(pmeta, trackedVars, true, out temp, out temp2, out trace);
        }
    }

    public class ConcurrentProgVerifier : GeneralVerifier
    {
        public override bool checkPath(PersistentCBAProgram prog, VarSet trackedVars)
        {
            return CBADriver.checkPath(prog, trackedVars);
        }
    }

    public class SequentialProgVerifier : GeneralVerifier
    {
        public override bool checkPath(PersistentCBAProgram prog, VarSet trackedVars)
        {
            ConfigManager.beginPathVerification(false);

            // Do variable slicing, inlining and verify
            var abs = new VariableSlicePass(trackedVars);
            prog = abs.run(prog);            

            VerificationPass verify = null;
            if (GlobalConfig.useLocalVariableAbstraction)
            {
                verify = new StaticInlineAndVerifyPass(new StaticSettings(-1, 1), false);
            }
            else
            {
                verify = new VerificationPass(false);
            }

            try
            {
                verify.run(prog);
            }
            catch (Exception)
            {
                ConfigManager.endPathVerification();
                throw;
            }

            ConfigManager.endPathVerification();
            return verify.success;
        }
    }

    public static class Stats
    {
        public static TimeSpan programVerificationTime = TimeSpan.Zero;
        public static int programVerificationQueries = 0;
        public static TimeSpan pathVerificationTime = TimeSpan.Zero;
        public static int pathVerificationQueries = 0;
        public static TimeSpan temp1 = TimeSpan.Zero;
        public static TimeSpan temp2 = TimeSpan.Zero;
        public static TimeSpan temp3 = TimeSpan.Zero;
        public static int ProgCallTreeSize = 0;
        private static List<DateTime> beginTimes = new List<DateTime>();

        public static void beginTime()
        {
            beginTimes.Add(DateTime.Now);
        }

        public static void endTime(ref TimeSpan counter)
        {
            counter += (DateTime.Now - beginTimes.Last());
            beginTimes.RemoveAt(beginTimes.Count - 1);
        }

        public static void endTime(string output)
        {
            var t = (DateTime.Now - beginTimes.Last());
            Console.WriteLine("{0}: {1} s", output, t.TotalSeconds);
            beginTimes.RemoveAt(beginTimes.Count - 1);
        }

        public static void printStats()
        {
            Log.WriteLine();
            Log.WriteLine(string.Format("Boogie verification time: {0} s", BoogieVerify.verificationTime.TotalSeconds.ToString("F2")));
            Log.WriteLine(string.Format("Time spent reading-writing programs: {0} s", PersistentCBAProgram.persistenceCost.TotalSeconds.ToString("F2")));
            Log.WriteLine();
            Log.WriteLine(string.Format("Time spent checking a program ({0}): {1} s", Stats.programVerificationQueries, Stats.programVerificationTime.TotalSeconds.ToString("F2")));
            Log.WriteLine(string.Format("Time spent checking a path ({0}): {1} s", Stats.pathVerificationQueries, Stats.pathVerificationTime.TotalSeconds.ToString("F2")));
            Log.WriteLine();
            if (temp1.TotalSeconds > 0)
            {
                Log.WriteLine(string.Format("Temp1: {0} s", Stats.temp1.TotalSeconds));
            }
            if (temp2.TotalSeconds > 0)
            {
                Log.WriteLine(string.Format("Temp2: {0} s", Stats.temp2.TotalSeconds));
            }
            if (temp3.TotalSeconds > 0)
            {
                Log.WriteLine(string.Format("Temp3: {0} s", Stats.temp3.TotalSeconds));
            }

        }
    }

    public class ConfigManager
    {
        static bool verifyingPath = false;
        static bool verifyingProg = false;
        static bool refinement = false;
        static string old_logfile = null;

        public static BoogieVerifyOptions progVerifyOptions = null;
        public static BoogieVerifyOptions refinementVerifyOptions = null;
        public static BoogieVerifyOptions pathVerifyOptions = null;

        static DateTime startTime = DateTime.Now;

        static ContractInfer ci = null;

        public static void Initialize(Configs config)
        {
            // Program
            progVerifyOptions = new BoogieVerifyOptions();
            progVerifyOptions.NonUniformUnfolding = config.NonUniformUnfolding;
            progVerifyOptions.newStratifiedInlining = config.newStratifiedInlining;
            progVerifyOptions.newStratifiedInliningAlgo = config.newStratifiedInliningAlgo;
            progVerifyOptions.CallTree = config.noCallTreeReuse ? null : new HashSet<string>();
            progVerifyOptions.UseProverEvaluate = config.useProverEvaluate;
            progVerifyOptions.StratifiedInliningWithoutModels = progVerifyOptions.UseProverEvaluate ? true : false;
            progVerifyOptions.useFwdBck = config.FwdBckSearch == 1;
            progVerifyOptions.useDI = config.useDI;
            progVerifyOptions.extraFlags.UnionWith(config.extraFlags);
            if (config.staticInlining > 0)
                progVerifyOptions.StratifiedInlining = 100;

            // Path
            pathVerifyOptions = new BoogieVerifyOptions();
            pathVerifyOptions.StratifiedInlining = 100;
            pathVerifyOptions.newStratifiedInlining = config.newStratifiedInlining;
            pathVerifyOptions.newStratifiedInliningAlgo = config.newStratifiedInliningAlgo;
            pathVerifyOptions.UseProverEvaluate = config.useProverEvaluate;
            pathVerifyOptions.StratifiedInliningWithoutModels = pathVerifyOptions.UseProverEvaluate ? true : false; ;
            pathVerifyOptions.useFwdBck = false;
            pathVerifyOptions.useDI = false;
            if (config.printData == 2)
            {
                pathVerifyOptions.StratifiedInliningWithoutModels = false;
                pathVerifyOptions.ModelViewFile = "corral_model";
            }

            if (config.printVerify)
            {
                progVerifyOptions.printProg = true;
                progVerifyOptions.progFileName = "last_query.bpl";
                pathVerifyOptions.printProg = true;
                pathVerifyOptions.progFileName = "last_query.bpl";
            }

            if (config.printFinalProg != null)
            {
                progVerifyOptions.printProg = true;
                progVerifyOptions.progFileName = config.printFinalProg;
            }

            // Refinement
            refinementVerifyOptions = pathVerifyOptions.Copy();
            //refinementVerifyOptions.UseProverEvaluate = false;
            refinementVerifyOptions.UseProverEvaluate = config.newStratifiedInlining;
            refinementVerifyOptions.StratifiedInliningWithoutModels = true;
            refinementVerifyOptions.ModelViewFile = null;
            refinementVerifyOptions.useFwdBck = false;
            refinementVerifyOptions.useDI = false;
        }

        public static void beginPathVerification(bool needPath)
        {
            Debug.Assert(!verifyingPath && !verifyingProg);

            ci = GlobalConfig.InferPass;
            GlobalConfig.InferPass = null;

            Stats.pathVerificationQueries++;

            if (refinement)
                BoogieVerify.options = refinementVerifyOptions;
            else
                BoogieVerify.options = pathVerifyOptions;

            verifyingPath = true;
            BoogieVerify.recordTempTime = true;

            
            if (GlobalConfig.explainQuantifiers != null)
            {
                old_logfile = CommandLineOptions.Clo.SimplifyLogFilePath;
                CommandLineOptions.Clo.SimplifyLogFilePath = GlobalConfig.explainQuantifiers;
            }

            startTime = DateTime.Now;
        }

        public static void endPathVerification()
        {
            Debug.Assert(verifyingPath);
            verifyingPath = false;

            GlobalConfig.InferPass = ci;
            BoogieVerify.recordTempTime = false;
            //CommandLineOptions.Clo.ModelViewFile = null;

            if (GlobalConfig.explainQuantifiers != null)
            {
                CommandLineOptions.Clo.SimplifyLogFilePath = old_logfile;
            }

            Stats.pathVerificationTime += (DateTime.Now - startTime);
        }

        public static void beginProgVerification()
        {
            Debug.Assert(!verifyingPath && !verifyingProg);
            verifyingProg = true;

            Stats.programVerificationQueries++;

            // Set timeout
            BoogieVerify.setTimeOut(GlobalConfig.getTimeLeft());

            BoogieVerify.options = progVerifyOptions;

            // AL: adding logging
            //CommandLineOptions.Clo.SimplifyLogFilePath = "logProg";
            startTime = DateTime.Now;
        }

        public static void endProgVerification()
        {
            Debug.Assert(verifyingProg);
            verifyingProg = false;
            BoogieVerify.setTimeOut(0);
            Stats.ProgCallTreeSize = BoogieVerify.CallTreeSize;
            Stats.programVerificationTime += (DateTime.Now - startTime);
        }

        public static void beginRefinement()
        {
            refinement = true;

            // AL: adding logging
            //CommandLineOptions.Clo.SimplifyLogFilePath = "logRefine";

        }

        public static void endRefinement()
        {
            refinement = false;
        }
    }

    [Serializable]
    public class CorralState
    {
        public HashSet<string> CallTree;
        public HashSet<string> TrackedVariables;

        public CorralState()
        {
            CallTree = new HashSet<string>();
            TrackedVariables = new HashSet<string>();
        }

        public static CorralState GetCorralState(string file)
        {
            if (file == null || !System.IO.File.Exists(file))
                return null;

            var serailizer = new BinaryFormatter();
            FileStream stream = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.None);
            var cs = (CorralState)serailizer.Deserialize(stream);
            stream.Close();

            return cs;
        }

        public static void AbsorbPrevState(Configs config, BoogieVerifyOptions progVerifyOptions)
        {
            var cs = GetCorralState(config.prevCorralState);
            if (cs != null)
            {
                progVerifyOptions.CallTree = cs.CallTree;
                config.trackedVars.UnionWith(cs.TrackedVariables);
            }
        }

        public static void DumpCorralState(Configs config, HashSet<string> CallTree, HashSet<string> Vars)
        {
            DumpCorralState(config.dumpCorralState, CallTree, Vars);
        }

        public static void DumpCorralState(string file, HashSet<string> CallTree, HashSet<string> Vars)
        {
            if (file != null)
            {
                var cs = new CorralState();
                cs.CallTree = CallTree;
                cs.TrackedVariables = Vars;
                BinaryFormatter serializer = new BinaryFormatter();
                FileStream stream = new FileStream(file, FileMode.Create, FileAccess.Write, FileShare.None);
                serializer.Serialize(stream, cs);
                stream.Close();
            }
        }
    }
}
