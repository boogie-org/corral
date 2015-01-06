using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web.UI;
using System.Xml; 

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
            public static string AVN_ROOT = "D:\\corral-codeplex\\corral\\AddOns\\AngelicVerifierNull"; //TODO: need to change this
            //common
            public static string defectViewerDir = null;
        }

        static void Main(string[] args)
        {
            var escapeDirPath = new Func<string, string>(x => x.Replace("\\", "\\\\"));
            var findArg = new Func<string, string> (x => 
                {
                    string res = null;
                    var prefix = "/" + x + ":";
                    args.Where(s => s.StartsWith(prefix))
                        .ToList()
                        .ForEach(s => res = escapeDirPath(s.Substring(prefix.Length)));
                    return res;
                });

            if (args.Any(s => s == "/break"))
                 System.Diagnostics.Debugger.Launch();

            var dirName = findArg("dir");
            var srcPath = findArg("srcPath");
            var baselineDirName = findArg("baseline");
            Options.defectViewerDir = findArg("defectViewerDir");
 
            if (dirName == null || srcPath == null || Options.defectViewerDir == null)
            {
                Console.WriteLine("Usage:  AvnResultDashboard /dir:<path-to-avn-result> /srcPath:<path-to-sources> /defectViewerDir:<path-to-view.cmd> [/break /baseline:<path-to-baseline-avn-result>]");
                return;
            }
            var isRelativePath = new Predicate<string>(x => x != null && !x.Contains(":\\"));
            if (isRelativePath(dirName) || 
                isRelativePath(srcPath) || 
                isRelativePath(Options.defectViewerDir) || 
                isRelativePath(baselineDirName))
                throw new Exception("Specify absolute pathnames for arguments");

            var hrg = new HtmlReportGeneration("myhtmlfile.html");
            var ari = new AvnResultInfo(dirName, srcPath);
            ari.LoadResultInfo();
            hrg.WriteHtml(ari);
        }

        public class AvnResultInfo
        {
            public string ResultsDir {get; set;}
            public string SrcDir { get; set;}
            public List<string> AllTraces { get; set; }
            public List<string> AngelicTraces { get; set; }
            public string Config { get; set; }            
            /// <summary>
            /// maps an angelic trace to its annotation
            /// </summary>
            /// <returns></returns>
            public Dictionary<int, string> TraceAnnot { get; set; }

            public string Identifier() 
            {
                throw new NotImplementedException();
            }
            public AvnResultInfo(string rDir, string sDir)
            {
                ResultsDir = rDir;
                SrcDir = sDir;
            }
            public void LoadResultInfo()
            {
                LoadConfigFileInDir();
                LoadDefectTraces();
                LoadTraceAnnots();
            }
            private void LoadConfigFileInDir()
            {
                TextReader cf = new StreamReader(@ResultsDir + @"\..\config.txt");
                Config = cf.ReadToEnd();
                cf.Close();
            }
            private void LoadDefectTraces()
            {
                AllTraces     = Directory.GetFiles(ResultsDir, @"Trace*.tt").ToList();
                AngelicTraces = Directory.GetFiles(ResultsDir, @"Angelic*.tt").ToList();
                Console.WriteLine("Defects: Total/Angelic = {0}/{1}", AllTraces.Count(), AngelicTraces.Count());
            }
            private void LoadTraceAnnots()
            {
                TraceAnnot = new Dictionary<int,string>();

                XmlDocument xmlDoc = new XmlDocument();
                try
                {
                    xmlDoc.Load(ResultsDir + "\\trace_annots.xml"); //hardcoded
                } catch (FileNotFoundException _)
                {
                    return;
                }
                var processTrace = new Action<XmlNode>(x =>
                {
                    var n  = Int32.Parse(x.SelectSingleNode("tracenum").InnerText);
                    var a = x.SelectSingleNode("annot").InnerText;
                    TraceAnnot[n] = a;
                    //Console.WriteLine("t[{0}] -> {1}", n, a);
                });

                var xmlTraces = xmlDoc.SelectSingleNode("traces");
                foreach (XmlNode node in xmlTraces.SelectNodes("trace"))
                    processTrace(node);
            }
        }


        public class HtmlReportGeneration
        {
            TextWriter htmlFile;
            public HtmlReportGeneration(string s) {
                htmlFile = new StreamWriter(s);
            }
            //public void WriteHtmlOld()
            //{
            //    AddHtmlPrelude();
            //    using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
            //    {
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Html);
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Body);
            //        //reference
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, "http://www.bing.com");
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.A); //a
            //        htmlWriter.Write("Bing link");
            //        htmlWriter.RenderEndTag(); //a
            //        htmlWriter.RenderEndTag(); //p
            //        //script
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, "avnDashboard.js");
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Script);
            //        htmlWriter.RenderEndTag();
            //        //button
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick, "myFunc()");
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
            //        htmlWriter.Write("Alert button");
            //        htmlWriter.RenderEndTag(); //button
            //        //paragraph
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "demo");
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
            //        htmlWriter.Write("I will change");
            //        htmlWriter.RenderEndTag();
            //        //table
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Style, "width:50%");
            //        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Border, "1");
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Table);
            //        //heading
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
            //        htmlWriter.Write("First");
            //        htmlWriter.RenderEndTag(); //th
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
            //        htmlWriter.Write("Middle");
            //        htmlWriter.RenderEndTag(); //th
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Th);
            //        htmlWriter.Write("Last");
            //        htmlWriter.RenderEndTag(); //th
            //        htmlWriter.RenderEndTag(); //tr
            //        //row1
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("John");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("K");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("Doe");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderEndTag(); //tr
            //        //row2
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("Mark");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("L");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
            //        htmlWriter.Write("Smith");
            //        htmlWriter.RenderEndTag(); //td
            //        htmlWriter.RenderEndTag(); //tr                    
            //        htmlWriter.RenderEndTag(); //table
            //        htmlWriter.RenderEndTag(); //body
            //        htmlWriter.RenderEndTag(); //html
            //    }
            //    htmlFile.Close();
            //}
            public void WriteHtml(AvnResultInfo ari)
            {
                AddHtmlPrelude();

                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {                    
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Html);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Body);

                    //script
                    //TODO: hardcoded JS file
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, Options.AVN_ROOT + "\\AvnResultDashboard\\avnDashboard.js");
                    //htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, "..\\..\\..\\avnDashboard.js");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Script);
                    htmlWriter.RenderEndTag();
                    
                    //config location
                    //paragraph
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write("Config ==> " + ari.Config);
                    htmlWriter.RenderEndTag();

                    //paragraph
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "demo");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write("Command display");
                    htmlWriter.RenderEndTag();

                    //table
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Style, "width:50%");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Border, "1");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Table);
                    //heading
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    MkTableHeaderColumn(htmlWriter, "Example", true);
                    MkTableHeaderColumn(htmlWriter, "Num Traces", true);
                    MkTableHeaderColumn(htmlWriter, "Num Angelic Traces", true);
                    MkTableHeaderColumn(htmlWriter, "Angelic traces", true);
                    htmlWriter.RenderEndTag(); //tr

                    ////row1
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td); //need more info in this column
                    //MkTableHeaderColumn(htmlWriter, ari.ResultsDir);
                    htmlWriter.Write(ari.ResultsDir);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "displayAllAnnotsHere");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Rows, (ari.AngelicTraces.Count * 2).ToString());
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Cols, "40");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Textarea);
                    htmlWriter.Write("Display all annots here");
                    htmlWriter.RenderEndTag();
                    //button
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick, "enumAnnots()");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                    htmlWriter.Write("Generate content of annots file AND copy/paste into trace_annots.xml in the directory above");
                    htmlWriter.RenderEndTag(); //button
                    htmlWriter.RenderEndTag(); //P
                    htmlWriter.RenderEndTag(); //td

                    MkTableHeaderColumn(htmlWriter, ari.AllTraces.Count().ToString());
                    MkTableHeaderColumn(htmlWriter, ari.AngelicTraces.Count().ToString());

                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    WriteTracesInHtml(ari, ari.AngelicTraces, htmlWriter);
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderEndTag(); //tr
                    
                    htmlWriter.RenderEndTag(); //table
                    htmlWriter.RenderEndTag(); //body
                    htmlWriter.RenderEndTag(); //html
                }
                htmlFile.Close();
            }
            private static int WriteTracesInHtml(AvnResultInfo ari, List<string> traces, HtmlTextWriter htmlWriter)
            {
                int count = 0;
                foreach (var angTr in traces)
                {
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    //reference
                    var trace = ari.ResultsDir + "\\\\Angelic" + (count) + ".tt";
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, trace.Replace("\\\\", "\\"));
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.A); //a
                    htmlWriter.Write("Trace" + count);
                    htmlWriter.RenderEndTag(); //a
                    //button
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick,
                        "launchSdvDefectViewer(" +
                              "\"" + @Options.defectViewerDir + "\"" + "," +
                              "\"" + @ari.SrcDir + "\"" + "," +
                              "\"" + @trace + "\"" +
                               ")");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                    htmlWriter.Write("DefectViewer");
                    htmlWriter.RenderEndTag(); //button
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Name, "traceAnnots");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "traceId" + count);
                    if (ari.TraceAnnot.ContainsKey(count))
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Value, ari.TraceAnnot[count]);
                    else
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Value, "");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Input);
                    htmlWriter.RenderEndTag(); //textarea
                    htmlWriter.RenderEndTag();
                    count++;
                }
                return count;
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
