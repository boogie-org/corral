using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web.UI;
using System.Xml;
using System.Text.RegularExpressions;

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

            var currDir = findArg("dir");
            var srcPath = findArg("srcPath");
            var baseDir = findArg("baseline");
            Options.defectViewerDir = findArg("defectViewerDir");
 
            if (currDir == null || srcPath == null || Options.defectViewerDir == null)
            {
                Console.WriteLine("Usage:  AvnResultDashboard /dir:<path-to-avn-result> /srcPath:<path-to-sources> /defectViewerDir:<path-to-view.cmd> [/break /baseline:<path-to-baseline-avn-result>]");
                return;
            }
            if (baseDir == null) baseDir = currDir;

            var isRelativePath = new Predicate<string>(x => x != null && !x.Contains(":\\"));
            if (isRelativePath(currDir) || 
                isRelativePath(srcPath) || 
                isRelativePath(Options.defectViewerDir) || 
                isRelativePath(baseDir))
                throw new Exception("Specify absolute pathnames for arguments");

            var getConfig = new Func<string, string>(x =>
            { 
                using (TextReader cf = new StreamReader(Directory.GetFiles(x, "config.txt")[0]))
                {
                    return cf.ReadToEnd();
                }
            }
            );
            var currConfig = getConfig(currDir);
            var baseConfig = getConfig(baseDir);

            var hrg = new HtmlReportGeneration("myhtmlfile.html");
            hrg.WriteString("Current Config ==> " + currConfig);
            hrg.WriteString("Baseline Config ==> " + baseConfig);

            var stripBplFromName = new Func<string,string> (x => 
            {
                if(x.EndsWith(".bpl")) return x.Substring(0, x.LastIndexOf(".bpl"));
                return null;
            });
            var resultSrcPairs = Directory.GetDirectories(currDir, "*.bpl")
                .Select(x => x.Substring(x.LastIndexOf("\\")+1))
                .Where(x => Directory.Exists(srcPath + "\\" + stripBplFromName(x)) 
                    && Directory.Exists(baseDir + "\\" + x))
                .Select(x => Tuple.Create(x, stripBplFromName(x)));
                    
            resultSrcPairs
                .ToList()
                .ForEach(x => ProcessSingleModule(x.Item2, currDir + "\\\\" + x.Item1, srcPath + "\\\\" + x.Item2, baseDir + "\\\\" + x.Item1, hrg));
        }

        /// <summary>
        /// name is a unique identifier (example name) for each example, currently module name
        /// </summary>
        /// <param name="name"></param>
        /// <param name="currDir"></param>
        /// <param name="srcPath"></param>
        /// <param name="baseDir"></param>
        /// <param name="hrg"></param>
        private static void ProcessSingleModule(string name, string currDir, string srcPath, string baseDir, HtmlReportGeneration hrg)
        {
            var ari1 = new AvnResultInfo(currDir, srcPath, name); ari1.LoadResultInfo();
            var ari2 = new AvnResultInfo(baseDir, srcPath, name); ari2.LoadResultInfo();
            var bi = new BaselineInfo(ari1, ari2);
            try
            {
                bi.MatchResults();
                hrg.WriteHtml(ari1, ari2, bi);
            } catch (Exception e)
            {
                Console.WriteLine(string.Format("ERROR: Skipping {0} due to exception {1}", currDir, e.Message));
            }
        }

        public class BaselineInfo
        {
            public class HashCollisionException : System.Exception
            {
                public HashCollisionException(string message) : base(message) { }
            }
            private AvnResultInfo ar1, ar2;
            public HashSet<Tuple<DefectTrace, DefectTrace>> matchedTraces; //v1 \cap v2

            public BaselineInfo(AvnResultInfo ar1, AvnResultInfo ar2) { this.ar1 = ar1; this.ar2 = ar2; matchedTraces = null; }
            public void MatchResults()
            {
                //TODO: ensure no hash collision in each version
                var checkForCollision = new Action<List<int>>(x =>
                {
                    var setHash = new HashSet<int>();
                    x.ForEach(y => setHash.Add(y));
                    if (x.Count != setHash.Count())
                    {
                        throw new HashCollisionException("Hash collision detected in version ");
                    }
                });

                //get the hashValues of each and check if there is any collision inside each version
                var hashes1 = ar1.AngelicTraces.Select(x => x.HashVal).ToList();
                var hashes2 = ar2.AngelicTraces.Select(x => x.HashVal).ToList();

                checkForCollision(hashes1);
                checkForCollision(hashes2);

                matchedTraces = new HashSet<Tuple<DefectTrace, DefectTrace>>();
                var findMatchingTrace = new Func<DefectTrace, AvnResultInfo, DefectTrace>((t, ar) =>
                {
                    var r = ar.AngelicTraces.Where(x => x.HashVal == t.HashVal);
                    if (r.Count() == 0) return null;
                    return r.First();
                });

                ar1.AngelicTraces.ForEach(x =>
                    {
                        var y = findMatchingTrace(x, ar2);
                        if (y != null)
                        {
                            //Console.WriteLine("MATCH!!: diff {0}  {1}", x.Id, y.Id);
                            matchedTraces.Add(Tuple.Create(x, y));
                        }
                    });
                Console.WriteLine("# of matches = {0}", matchedTraces.Count);
            }
        }

        public class AvnResultInfo
        {
            public string ResultsDir {get; set;}
            public string SrcDir { get; set;}
            public string Name { get; set; }
            public List<DefectTrace> AllTraces { get; set; }
            public List<DefectTrace> AngelicTraces { get; set; }
            /// <summary>
            /// maps an angelic trace to its annotation
            /// </summary>
            /// <returns></returns>
            public Dictionary<int, Tuple<string,string,string>> TraceAnnot { get; set; }

            public string Identifier() 
            {
                throw new NotImplementedException();
            }
            public AvnResultInfo(string rDir, string sDir, string name)
            {
                ResultsDir = rDir;
                SrcDir = sDir;
                Name = name;
            }
            public void LoadResultInfo()
            {
                LoadDefectTraces();
                LoadTraceAnnots();
            }
            private void LoadDefectTraces()
            {
                AllTraces = Directory.GetFiles(ResultsDir, @"Trace*.tt").ToList()
                    .Union(Directory.GetFiles(ResultsDir, @"Bug*.tt"))
                    .Select(x => new DefectTrace(x))
                    .ToList();
                AngelicTraces = Directory.GetFiles(ResultsDir, @"Angelic*.tt")
                    .Union(Directory.GetFiles(ResultsDir, @"Trace*_defect.tt")) //TODO:older dirs have Tracexx_defect.tt files for angelic
                    .Union(Directory.GetFiles(ResultsDir, @"Bug*.tt"))
                    .ToList()
                    .Union(Directory.GetFiles(ResultsDir, @"Bug*_defect.tt"))   //newer traces
                    .Select(x => new DefectTrace(x))
                    .ToList();
                Console.WriteLine("Defects: Total/Angelic = {0}/{1}", AllTraces.Count(), AngelicTraces.Count());
            }
            private void LoadTraceAnnots()
            {
                TraceAnnot = new Dictionary<int,Tuple<string,string,string>>();

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
                    //These tags should be in sync with avnDashboard.cs::enumAnnots()
                    var n  = Int32.Parse(x.SelectSingleNode("tracenum").InnerText);
                    var c = x.SelectSingleNode("category").InnerText;
                    var p = x.SelectSingleNode("prefix").InnerText;
                    var a = x.SelectSingleNode("comment").InnerText;
                    TraceAnnot[n] = Tuple.Create(c, p, a);
                    //Console.WriteLine("t[{0}] -> {1}", n, c + "," + p + "," + a);
                });

                var xmlTraces = xmlDoc.SelectSingleNode("traces");
                foreach (XmlNode node in xmlTraces.SelectNodes("trace"))
                    processTrace(node);
            }

        }

        public class DefectTrace
        {
            private List<Tuple<string,string>> trace ; //lines in the trace along with their abstraction
            static private Func<string, string> abstractionFunc = /*NoAbstract*/ AbstractConstants; //the function that creates an abstract string (e.g. line = 435 --> line = *)

            public string Id { get; set; }
            private int _hashVal;
            public int HashVal 
            { 
                get { if (trace == null) LoadTrace(); return _hashVal; } 
                set { _hashVal = value; } 
            }    //hashed value 
            public DefectTrace(string path) { Id = path; trace = null; }
            private void LoadTrace()
            {
                var hashString = "";
                trace = new List<Tuple<string, string>>();                    
                using (StreamReader sr = new StreamReader(Id))
                {
                    string str = sr.ReadLine();
                    while(str != null)
                    {
                        var aStr = abstractionFunc(str);
                        trace.Add(Tuple.Create(str, aStr));
                        hashString += aStr;
                        str = sr.ReadLine();
                    }
                }
                HashVal = hashString.GetHashCode();
            }
            #region a couple of abstraction functions
            /*
                 * 0 "?" 0 false ^ Call "OS" "main"
                 * 3 ".\src\bus.c" 1252 true ^WPP_GLOBAL_Control=151^&WPP_GLOBAL_Control=151_relevant_^====Auto===== Atomic Conditional
                 * Error 
                 */

            private static string NoAbstract(string s)
            {
                var tmp = Regex.Replace(s, @"_relevant_", "", RegexOptions.None); //older traces did not have it
                tmp = Regex.Replace(tmp, @"_irrelevant_", "", RegexOptions.None); //older traces did not have it
                return tmp;
            }
            private static string AbstractConstants(string s)
            {
                var tmp = Regex.Replace(s, @"[0-9]+ ", "", RegexOptions.None);
                return NoAbstract(tmp);
            }
            #endregion
        }


        public class HtmlReportGeneration
        {
            TextWriter htmlFile;
            public HtmlReportGeneration(string s) {
                htmlFile = new StreamWriter(s);
                AddHtmlPrelude();
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
            public void WriteString(string s)
            {
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {
                    //paragraph
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write(s);
                    htmlWriter.RenderEndTag();
                }
            }
            public void WriteHtml(AvnResultInfo ar1, AvnResultInfo ar2,  BaselineInfo bi)
            {
                var name = ar1.Name; 
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {                    
                    ////row1
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td); //need more info in this column
                    //MkTableHeaderColumn(htmlWriter, ari.ResultsDir);
                    htmlWriter.Write(ar1.ResultsDir);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "displayAllAnnotsFor_" + name);
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Rows, (ar1.AngelicTraces.Count * 2).ToString());
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Cols, "40");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Textarea);
                    htmlWriter.Write("Display annots for " + name + " here");
                    htmlWriter.RenderEndTag();
                    htmlWriter.WriteBreak();
                    //button
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, "button");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Onclick, "enumAnnots(" + "\"" + name + "\"" + ")");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                    htmlWriter.Write("Generate content of annots file AND copy/paste into trace_annots.xml in the directory above");
                    htmlWriter.RenderEndTag(); //button
                    htmlWriter.RenderEndTag(); //P
                    htmlWriter.RenderEndTag(); //td

                    MkTableHeaderColumn(htmlWriter, ar1.AllTraces.Count().ToString());
                    MkTableHeaderColumn(htmlWriter, "Total/Matched = " + ar1.AngelicTraces.Count().ToString() + 
                        "/" + bi.matchedTraces.Count);

                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    var matchedTraces = ar1.AngelicTraces.Where(t => bi.matchedTraces.Any(x => x.Item1 == t));
                    WriteTracesInHtml(ar1, ar1.AngelicTraces, matchedTraces, htmlWriter);
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    var unMatchedTraces = ar1.AngelicTraces.Where(t => !bi.matchedTraces.Any(x => x.Item1 == t));
                    WriteTracesInHtml(ar1, ar1.AngelicTraces, unMatchedTraces, htmlWriter);
                    htmlWriter.RenderEndTag(); //td
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    var missingTraces = ar2.AngelicTraces.Where(t => !bi.matchedTraces.Any(x => x.Item2 == t));
                    WriteTracesInHtml(ar2, ar2.AngelicTraces, missingTraces, htmlWriter, true); //don't update the ar1\trace_annots 
                    htmlWriter.RenderEndTag(); //td

                    htmlWriter.RenderEndTag(); //tr                    
                }
            }
            /// <summary>
            /// Important: Do not pass a subset of traces to this function, as the annotation mapping will get confused
            /// dontUpdateAnnots when true indicates that the traces are for baseline, so we don't need to persist it
            /// </summary>
            /// <param name="ari"></param>
            /// <param name="traces"></param>
            /// <param name="filter"></param>
            /// <param name="htmlWriter"></param>
            /// <returns></returns>
            private static int WriteTracesInHtml(AvnResultInfo ari, List<DefectTrace> traces, IEnumerable<DefectTrace> filter, HtmlTextWriter htmlWriter, 
                bool dontUpdateAnnots = false)    
            {
                int count = -1;
                if (!dontUpdateAnnots)
                {
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "tracesPerExample_" + ari.Name);
                }
                htmlWriter.RenderBeginTag(HtmlTextWriterTag.Div);
                foreach (var tr in traces)
                {
                    count++; //need to count before any continue, as we need to map count uniquely to a trace
                    if (!filter.Contains(tr)) continue;
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    //Form 
                    if (!dontUpdateAnnots)
                    {
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Class, "traceAnnots");
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "traceId" + count);
                    }
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Form);
                    var trace = tr.Id;
                    //Raw defect trace
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
                              "\"" + @trace.Replace("\\", "\\\\") + "\"" +
                               ")");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Button);
                    htmlWriter.Write("View");
                    htmlWriter.RenderEndTag(); //button
                    htmlWriter.WriteBreak();
                    var traceFound = ari.TraceAnnot.ContainsKey(count);
                    var addInputBoxWithVal = new Action<string, string, string>((str,c, t ) =>
                    {
                        htmlWriter.Write(c);
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Name, c);    
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Value, str);
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Type, t);
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Input);
                        htmlWriter.RenderEndTag(); //input
                        htmlWriter.WriteBreak();
                    });

                    addInputBoxWithVal(traceFound ? ari.TraceAnnot[count].Item1 : "", "Category", "text");
                    addInputBoxWithVal(traceFound ? ari.TraceAnnot[count].Item2 : "", "Prefix", "url");
                    addInputBoxWithVal(traceFound ? ari.TraceAnnot[count].Item3 : "", "Comment", "text");
                    htmlWriter.RenderEndTag(); //Form
                    htmlWriter.RenderEndTag(); //P
                }
                htmlWriter.RenderEndTag();
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

                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Html);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Body);

                    //paragraph
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "demo");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                    htmlWriter.Write("Current command is displayed here");
                    htmlWriter.RenderEndTag();

                    //script
                    string path;
                    path = System.IO.Path.GetDirectoryName(
                       System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase).Substring("file:/".Length);
                    //Console.WriteLine("path = {0}", path);
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Src, path + "\\avnDashboard.js");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Script);
                    htmlWriter.RenderEndTag();

                    //table
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Style, "width:100%");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Border, "1");
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Table);
                    //heading
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
                    MkTableHeaderColumn(htmlWriter, "Example", true);
                    MkTableHeaderColumn(htmlWriter, "Num Traces", true);
                    MkTableHeaderColumn(htmlWriter, "Num Angelic Traces", true);
                    MkTableHeaderColumn(htmlWriter, "Matched Angelic traces", true);
                    MkTableHeaderColumn(htmlWriter, "UnMatched Angelic traces", true);
                    MkTableHeaderColumn(htmlWriter, "Missing Angelic traces", true);
                    htmlWriter.RenderEndTag(); //tr
                }
            }
            public void AddHtmlPostlude()
            {
                using (HtmlTextWriter htmlWriter = new HtmlTextWriter(htmlFile))
                {

                    htmlWriter.RenderEndTag(); //table
                    htmlWriter.RenderEndTag(); //body
                    htmlWriter.RenderEndTag(); //html
                }
                htmlFile.Close();
            }
        }

    }
}
