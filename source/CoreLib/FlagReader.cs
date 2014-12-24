using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cba.Util;
using System.IO;
using System.Diagnostics;

namespace cba
{
    // For reading flags from the command line
    public static class FlagReader
    {
        // Reads the set of flags supplied on the command line. Normalizes
        // them and returns the list of flags in the order they should be 
        // processed.
        public static List<string> read(string[] args)
        {
            var ret = new List<string>();
            foreach (var str in args)
            {
                if (!isFlag(str))
                {
                    // Must be a file name
                    if (!str.EndsWith(".bpl"))
                    {
                        throw new UsageError("Unknown command line argument: " + str);
                    }
                    ret.Add(str);
                }
                else
                {
                    if (str.StartsWith("/flags:"))
                    {
                        var delimit = new char[1];
                        delimit[0] = ':';
                        var split = str.Split(delimit);
                        try
                        {
                            ret.AddRange(readFile(split[1]));
                        }
                        catch (Exception e)
                        {
                            throw new UsageError(e.Message);
                        }
                    }
                    else
                    {
                        ret.Add(str);
                    }
                }
            }

            // normalize flags
            var flags = new List<string>();
            foreach (var str in ret)
            {
                if (str.StartsWith("/trackField:"))
                {
                    flags.Add(str.Replace("/trackField:", "/track:Mem_T."));
                }
                else if (str.StartsWith("/trackResource:"))
                {
                    flags.Add(str.Replace("/trackResource:", "/track:Res_"));
                }
                else
                {
                    flags.Add(str);
                }
            }
            return flags;
        }

        public static bool isFlag(string str)
        {
            Debug.Assert(str != null && str != "");

            if (Path.DirectorySeparatorChar == '/' && File.Exists(str))
            {
                // On systems using UNIX absolute paths we should consider a string that
                // is a path to an existing file to not be a flag
                return false;
            }

            return str[0] == '/';
        }

        // Read flags from a file
        private static List<string> readFile(string file)
        {
            var ret = new List<string>();

            var spaces = new char[1];
            spaces[0] = ' ';

            // Get path
            var dirs = file.Split('\\');
            var path = "";
            for (int i = 0; i < dirs.Length - 1; i++)
            {
                path = path + dirs[i] + '\\';
            }

            StreamReader cfile = new StreamReader(file);
            string line;
            while ((line = cfile.ReadLine()) != null)
            {
                // comment
                if (line.StartsWith("#"))
                    continue;

                if (line.StartsWith("/include:"))
                {
                    var split = line.Split(':');
                    ret.Add("/include:" + path + split[1]);
                    continue;
                }

                if (line.StartsWith("/concat:"))
                {
                    var split = line.Split(':');
                    ret.Add("/concat:" + path + split[1]);
                    continue;
                }

                if (isFlag(line))
                {
                    var split = line.Split(spaces);
                    foreach (var str in split)
                    {
                        if (!isFlag(str))
                        {
                            throw new UsageError("Illegal flag in file " + file + ": " + str);
                        }

                        if (str.StartsWith("/flags:"))
                        {
                            throw new UsageError("Cannot have nested /flags");
                        }

                        ret.Add(str);
                    }
                }
                else if (line.StartsWith("TrackVars") || line.StartsWith("TrackFields") ||
                        line.StartsWith("TrackResources"))
                {
                    // Maybe its a compound command for varibles, fields, or resources

                    var prefix = "";
                    if (line.StartsWith("TrackVars"))
                    {
                        prefix = "/track:";
                    }
                    if (line.StartsWith("TrackVarsSecondary"))
                    {
                        prefix = "/trackSecondary:";
                    }
                    else if (line.StartsWith("TrackFields"))
                    {
                        prefix = "/trackField:";
                    }
                    else if (line.StartsWith("TrackResources"))
                    {
                        prefix = "/trackResource:";
                    }

                    var delimit = new char[3];
                    delimit[0] = ' ';
                    delimit[1] = '=';
                    delimit[2] = ',';

                    var opts = line.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 1; i < opts.Length; i++)
                    {
                        ret.Add(prefix + opts[i]);
                    }
                }
                else
                {
                    throw new UsageError("Illegal flag in file " + file + ": " + line);
                }

            }
            cfile.Close();
            return ret;
        }
    }
}
