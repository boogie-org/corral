using CommonLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace SplitParClient
{
    public static class LogWithAddress
    {
        public const int Warning = 4;
        public const int Error = 3;
        public const int Normal = 1;
        public const int Debug = 2;
        public const int Verbose = 5;

        public static bool noDebuggingOutput = false;
        public static bool printMemUsage = false;
        public static int verbose_level = 0;

        public static StreamWriter debugOut;

        public static void init(string dir)
        {
            if (noDebuggingOutput)
                return;

            if (debugOut == null)
            {
                debugOut = new StreamWriter(System.IO.Path.Combine(dir, Utils.ClientLog));
            }
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
            if (level == LogWithAddress.Normal)
            {
                level = Debug;
            }

            switch (level)
            {
                case Debug:
                    if (!noDebuggingOutput)
                    { 
                        debugOut.Write(msg);
                    }
                    break;
                case Warning:
                    Console.Write("Warning: " + msg);
                    break;
                case Error:
                    Console.Write("Error: " + msg);
                    break;
                case Normal:
                    Console.Write(msg);
                    break;
                case Verbose:
                    if (verbose_level > 0)
                    {
                        Console.Write(msg);
                    }
                    debugOut.Write(msg);
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
            return Write(level, file.Substring(file.LastIndexOf("\\")) + "\\" + member + ":" + line + "\t" + msg + Environment.NewLine);
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
