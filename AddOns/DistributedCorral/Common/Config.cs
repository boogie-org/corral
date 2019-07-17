using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Config
    {
        public static bool ShortTransaction = false;
        public static bool PreLoading = true;
        public static int CallTreeQueueSize = 1000;
        public static int CallTreeQueueRate = 10;
        public static int RecursionBound = 3;
        //public static string InliningAlgorithm = "/newStratifiedInlining:splitpar";
        public static string InliningAlgorithm = "/newStratifiedInlining:ucsplitpar";
        public static string enableUnSatCoreExtraction = "/enableUnSatCoreExtraction:1";
        public static string ConnectionType = "/connectionType:cloud";
        public static int OptimizationMode = 0;
        public static int TimeLimit = 3600;
        public static bool EnableFileRemoval = false;
        public static bool RunningExperiment = true;
        public static bool AutoRerunningExperiment = false;

        public static bool GenGraph = true;
        public static bool GenResult = true;
        public static bool BackupClient = false;
        public static bool VerifyUnsafe = false;
        public static int DefaultInterval = 50;
        public static int FirstSplitDeadline = 20;
        public static string WriteResultLocally = "Results.csv";
        public static string WriteOutcomeLocally = "Outcomes.csv";
        public static string WriteDotFilesLocally = "Dotfiles.csv";
    }
}
