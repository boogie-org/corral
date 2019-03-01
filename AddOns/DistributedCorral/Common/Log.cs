using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class Log
    {
        public const int Warning = 4;
        public const int Error = 3;
        public const int Normal = 1;
        public const int Verbose = 5;
        public const int Simple = 6;

        public static bool noDebuggingOutput = false;
        public static bool printMemUsage = false;
        public static int verbose_level = 0;

        public static StreamWriter debugOut;

        public static void init(string dir)
        {
            if (noDebuggingOutput)
                return;
        }

        public static void Close()
        {
            if (debugOut != null)
            {
                debugOut.Close();
            }
        }

        public static bool Write(int level, string msg)
        {
            if (level == Normal)
            {
                //level = Debug;
            }

            switch (level)
            {
                case Warning:
                    Debug.Write("Warning: " + msg);
                    break;
                case Error:
                    Debug.Write("Error: " + msg);
                    break;
                case Normal:
                    Debug.Write(msg);
                    break;
                case Verbose:
                    if (verbose_level > 0)
                    {
                        Debug.Write(msg);
                    }
                    break;
            }

            return false;
        }

        public static bool Write(string msg)
        {
            if (noDebuggingOutput)
                return true;
            return Write(Normal, msg);
        }


        public static bool WriteLine(int level, string msg,
                        [CallerFilePath] string file = "",
                        [CallerMemberName] string member = "",
                        [CallerLineNumber] int line = 0)
        {
            if (noDebuggingOutput)
                return true;
            if (level != Simple)
            {
                if (file.LastIndexOf("\\") >= 0)
                    return Write(level, file.Substring(file.LastIndexOf("\\")) + "\\" + member + ":" + line + "\t" + msg + Environment.NewLine);
                else
                    return Write(level, file + "\\" + member + ":" + line + "\t" + msg + Environment.NewLine);
            }
            else
                return Write(Normal, msg + Environment.NewLine);
        }

        public static bool WriteLine(string msg,
                        [CallerFilePath] string file = "",
                        [CallerMemberName] string member = "",
                        [CallerLineNumber] int line = 0)
        {
            if (noDebuggingOutput)
                return true;
            return Write(Normal, msg + Environment.NewLine);
        }

        public static bool WriteLine()
        {
            if (noDebuggingOutput)
                return true;
            return Write(Normal, Environment.NewLine);
        }

        public static void PrintMemUsage()
        {
            PrintMemUsage("Memory");
        }

        public static void PrintMemUsage(string msg)
        {
            var p = System.Diagnostics.Process.GetCurrentProcess();
            GC.Collect();
            double mem1 = GC.GetTotalMemory(true) / (1024.0 * 1024.0);
            double mem2 = p.VirtualMemorySize64 / (1024.0 * 1024.0);
            Console.WriteLine("{0}: {1}MB and {2}MB", msg, mem1.ToString("F"), mem2.ToString("F"));
        }
    }
}
