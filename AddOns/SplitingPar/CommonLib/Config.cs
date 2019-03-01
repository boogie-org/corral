using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace CommonLib
{
    [XmlType(TypeName = "SplitParConfig")]
    [Serializable]
    public class SplitParConfig
    {
        [XmlElement(ElementName = "Root")]
        public string root;

        [XmlArrayItemAttribute("Util", typeof(SplitParUtil))]
        public List<SplitParUtil> Utils { get; set; }

        [XmlArrayItemAttribute("RemoteFolder", typeof(RemoteFolder))]
        public List<RemoteFolder> RemoteRoots { get; set; }

        [XmlArrayItemAttribute("Files", typeof(Files))]
        public List<Files> BoogieFiles { get; set; }

        [XmlElement(ElementName = "MaxThreads")]
        public string _maxthreads;

        public int MaxThreads
        {
            get
            {
                if (_maxthreads == null) return 0;
                return Int32.Parse(_maxthreads);
            }
        }

        public static SplitParConfig DeSerialize(string file)
        {
            var x = new XmlSerializer(typeof(SplitParConfig));
            using (FileStream fsr = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                var ret = (SplitParConfig)x.Deserialize(fsr);
                return ret;
            }
        }

        public void Dump()
        {
            Console.WriteLine("Root folder is {0}", root);
            foreach (var util in Utils)
                Console.WriteLine("Util: {0} {1}", util.value, util.arguments);
            foreach (var folder in RemoteRoots)
                Console.WriteLine("Remote {0}", folder.value);
            foreach (var files in BoogieFiles)
                Console.WriteLine("Files {0} ({1})", files.value, files.IsNegative() ?
                    "negative" : "positive");
        }

        public void DumpClientConfig(string root, string configfile, List<Files> files)
        {
            var outf = new StreamWriter(configfile);

            outf.WriteLine(@"<?xml version=""1.0"" encoding=""utf-8"" ?>");
            outf.WriteLine(@"<SplitParConfig xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">");
            outf.WriteLine(@"  <Root>{0}</Root>", root);
            if (_maxthreads != null) outf.WriteLine(@"  <MaxThreads>{0}</MaxThreads>", _maxthreads);
            outf.WriteLine(@"  <Utils>");
            foreach (var u in Utils)
                outf.WriteLine(@"    <Util name=""{0}"" dir=""{1}"" exe=""{2}"" arguments=""{3}""/>", u.name, u.dir, u.exe, u.arguments);
            outf.WriteLine(@"  </Utils>");
            outf.WriteLine(@"  <RemoteRoots>");
            outf.WriteLine(@"  </RemoteRoots>");
            outf.WriteLine(@"  <BoogieFiles>");
            foreach (var file in files)
            {
                string fileName = System.IO.Path.GetFileName(file.value);
                outf.WriteLine(@"    <Files value=""{0}""/>", fileName);
            }
            outf.WriteLine(@"  </BoogieFiles>");
            outf.WriteLine(@"</SplitParConfig>");

            outf.Close();
        }
    }

    [XmlRootAttribute("Util", Namespace = "")]
    public class SplitParUtil
    {
        [XmlAttributeAttribute()]
        public string name { get; set; }

        [XmlAttributeAttribute()]
        public string dir { get; set; }

        [XmlAttributeAttribute()]
        public string exe { get; set; }

        [XmlAttributeAttribute()]
        public string arguments { get; set; }

        public string value
        {
            get
            {
                return string.Format("{0}\\{1}", dir, exe);
            }
        }
    }

    [XmlRootAttribute("RemoteFolder", Namespace = "")]
    public class RemoteFolder
    {
        [XmlAttributeAttribute()]
        public string value { get; set; }
    }


    [XmlRootAttribute("Files", Namespace = "")]
    public class Files
    {
        [XmlAttributeAttribute()]
        public string value { get; set; }

        [XmlAttributeAttribute()]
        public string type { get; set; }

        public bool IsNegative()
        {
            return type != null && type == "negative";
        }
    }

    public static class GlobalConfig
    {
        //public static readonly string util_result_file = "result.db";
        //public static readonly string merge_flag = "/rpmerge";
    }
}
