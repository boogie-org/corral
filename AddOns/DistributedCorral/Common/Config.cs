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
        public static int CallTreeQueueSize = 100;
        public static int CallTreeQueueRate = 10;
        public static int RecursionBound = 2;
        public static string InliningAlgorithm = "/newStratifiedInlining:splitpar";
        public static string ConnectionType = "/connectionType:cloud";
        public static int OptimizationMode = 2;
        public static int TimeLimit = 1000;
        public static bool EnableFileRemoval = false;
        public static bool RunningExperiment = true;
        public static bool AutoRerunningExperiment = false;

        public static bool GenGraph = false;
        public static bool BackupClient = false;
        public static bool VerifyUnsafe = false;
        public static int DefaultInterval = 50;
        public static int FirstSplitDeadline = 20;
    }
}
