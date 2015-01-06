using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web.UI;

namespace AvnResultDashboard
{
    /// <summary>
    /// Performs various postprocessing on the results of a AVN run to 
    ///   - better display of the result for navigation
    ///   - support for baselining
    /// </summary>
    class Program
    {
        public static class Options
        {
            public static string dirName = null;
            public static string srcPath = null;
            public static string baselineDirName = null;
            public static string defectViewerDir = null;
        }

        static void Main(string[] args)
        {
            var escapeDirPath = new Func<string, string>(x => x.Replace("\\", "\\\\"));

            if (args.Any(s => s == "/break"))
                System.Diagnostics.Debugger.Launch();

            args.Where(s => s.StartsWith("/dir:"))
                .ToList()
                .ForEach(s => Options.dirName = escapeDirPath(s.Substring("/dir:".Length)));

            args.Where(s => s.StartsWith("/srcPath:"))
                .ToList()
                .ForEach(s => Options.srcPath = escapeDirPath(s.Substring("/srcPath:".Length)));

            args.Where(s => s.StartsWith("/baseline:"))
                .ToList()
                .ForEach(s => Options.baselineDirName = escapeDirPath(s.Substring("/baseline:".Length)));

            args.Where(s => s.StartsWith("/defectViewerDir:"))
                .ToList()
                .ForEach(s => Options.defectViewerDir = escapeDirPath(s.Substring("/defectViewerDir:".Length)));
 
            if (Options.dirName == null || Options.srcPath == null || Options.defectViewerDir == null)
            {
                Console.WriteLine("Usage:  AvnResultDashboard /dir:<path-to-avn-result> /srcPath:<path-to-sources> /defectViewerDir:<path-to-view.cmd> [/break /baseline:<path-to-baseline-avn-result>]");
                return;
            }
            var isRelativePath = new Predicate<string>(x => x != null && !x.Contains(":\\"));
            if (isRelativePath(Options.dirName) || 
                isRelativePath(Options.srcPath) || 
                isRelativePath(Options.defectViewerDir) || 
                isRelativePath(Options.baselineDirName))
                throw new Exception("Specify absolute pathnames for arguments");

            var hrg = new HtmlReportGeneration("myhtmlfile.html");
            var config = LoadConfigFileInDir(Options.dirName);
            var defects = LoadDefectTraces(Options.dirName);
            hrg.WriteHtml(Options.dirName, config, defects);
        }

        static string LoadConfigFileInDir(string dir)
        {
            TextReader cf = new StreamReader(@dir + @"\..\config.txt");
            var str = cf.ReadToEnd();
            cf.Close();
            Console.WriteLine("Config ==> {0}", str);
            return str;
        }

        static Tuple<List<string>,List<string>> LoadDefectTraces(string dir)
        {            
            var defects = Directory.GetFiles(dir, @"Trace*.tt");
            var angelicDefects = Directory.GetFiles(dir, @"Angelic*.tt");
            Console.WriteLine("Defects: Total/Angelic = {0}/{1}", defects.Count(), angelicDefects.Count());
            return Tuple.Create(defects.ToList(), angelicDefects.ToList());
        }
        public class HtmlReportGeneration
        {
            TextWriter htmlFile;

            public HtmlReportGeneration(string s) {
                htmlFile = new StreamWriter(s);
            }
            public void WriteHtmlOld()
            {
                AddHtmlPrelude();
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Html);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Body);
                    //reference
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, "http://www.bing.com");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.A); //a
                    htmlWriter.Write("Bing link");
                    htmlWriter.RenderEndTag(); //a
                    htmlWriter.RenderEndTag(); //p
                    //script
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, "avnDashboard.js");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Script);
                    htmlWriter.RenderEndTag();
                    //button
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick, "myFunc()");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                    htmlWriter.Write("Alert button");
                    htmlWriter.RenderEndTag(); //button
                    //paragraph
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "demo");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write("I will change");
                    htmlWriter.RenderEndTag();
                    //table
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Style, "width:50%");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Border, "1");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Table);
                    //heading
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
                    htmlWriter.Write("First");
                    htmlWriter.RenderEndTag(); //th
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
                    htmlWriter.Write("Middle");
                    htmlWriter.RenderEndTag(); //th
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
                    htmlWriter.Write("Last");
                    htmlWriter.RenderEndTag(); //th
                    htmlWriter.RenderEndTag(); //tr
                    //row1
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("John");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("K");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("Doe");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderEndTag(); //tr
                    //row2
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("Mark");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("L");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    htmlWriter.Write("Smith");
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderEndTag(); //tr                    
                    htmlWriter.RenderEndTag(); //table
                    htmlWriter.RenderEndTag(); //body
                    htmlWriter.RenderEndTag(); //html
                }
                htmlFile.Close();
            }
            public void WriteHtml(string dir, string config, Tuple<List<string>, List<string>> defects)
            {
                AddHtmlPrelude();
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {                    
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Html);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Body);

                    //script
                    //htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, "e:\\smv-avn-test\\nonnull-test\\REGRESS.2014.12.16-14\\avnDashboard.js");
                    //TODO: hardcoded JS file
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, "D:\\corral-codeplex\\corral\\AddOns\\AngelicVerifierNull\\AvnResultDashboard\\avnDashboard.js");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Script);
                    htmlWriter.RenderEndTag();
                                        
                    //paragraph
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "demo");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write("I will change");
                    htmlWriter.RenderEndTag();

                    //table
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Style, "width:50%");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Border, "1");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Table);
                    //heading
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    MkTableHeaderColumn(htmlWriter, "Example", true);
                    MkTableHeaderColumn(htmlWriter, "Num Angelic", true);
                    MkTableHeaderColumn(htmlWriter, "Num Traces", true);
                    MkTableHeaderColumn(htmlWriter, "Angelic traces", true);
                    htmlWriter.RenderEndTag(); //tr

                    ////row1
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    MkTableHeaderColumn(htmlWriter, Options.dirName);
                    MkTableHeaderColumn(htmlWriter, defects.Item2.Count().ToString());
                    MkTableHeaderColumn(htmlWriter, defects.Item1.Count().ToString());

                    int count = 0;
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    foreach (var angTr in defects.Item2)
                    {
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                        //reference
                        var trace = Options.dirName + "\\\\Angelic" + (count) + ".tt";
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, trace.Replace("\\\\","\\"));
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.A); //a
                        htmlWriter.Write("Trace" + count++);
                        htmlWriter.RenderEndTag(); //a
                        //button
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick,
                            "launchSdvDefectViewer(" +
                                  "\"" + @Options.defectViewerDir + "\"" + "," +
                                  "\"" + @Options.srcPath + "\"" + "," +
                                  "\"" + @trace + "\"" +
                                   ")");
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                        htmlWriter.Write("DefectViewer");
                        htmlWriter.RenderEndTag(); //button
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Textarea);
                        htmlWriter.RenderEndTag(); //textarea
                        htmlWriter.RenderEndTag();
                    }
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderEndTag(); //tr

                    ////row2
                    //htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    //htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    //htmlWriter.Write("Mark");
                    //htmlWriter.RenderEndTag(); //td
                    //htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    //htmlWriter.Write("L");
                    //htmlWriter.RenderEndTag(); //td
                    //htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    //htmlWriter.Write("Smith");
                    //htmlWriter.RenderEndTag(); //td
                    //htmlWriter.RenderEndTag(); //tr                    
                    
                    htmlWriter.RenderEndTag(); //table
                    htmlWriter.RenderEndTag(); //body
                    htmlWriter.RenderEndTag(); //html
                }
                htmlFile.Close();
            }

            private static void MkTableHeaderColumn(HtmlTextWriter htmlWriter, string str, bool header=false)
            {
                htmlWriter.RenderBeginTag(header? HtmlTextWriterTag.Th : HtmlTextWriterTag.Td);
                htmlWriter.Write(str);
                htmlWriter.RenderEndTag(); //th
            }


            private void AddHtmlPrelude()
            {
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {
                    htmlWriter.Write("<!DOCTYPE html>");
                }
            }
            private void AddHtmlPostlude() {}
        }

    }
}
