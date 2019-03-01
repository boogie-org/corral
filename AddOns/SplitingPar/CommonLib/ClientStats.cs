using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace CommonLib
{
    [XmlType(TypeName = "ClientStats")]
    [Serializable]
    public class ClientStats
    {

        public string Name = "";
        [XmlElement(ElementName = "TotalTasks")]
        public int TotalTasks = 0;

        [XmlElement(ElementName = "MustReachParallel")]
        public MustReachParallel MustReachParallelTime; 

        [XmlElement(ElementName = "InliningCallTreesTime")]
        public double InliningCallTreesTime = 0;

        [XmlElement(ElementName = "TotalTime")]
        public ClientTotalTime TotalTime; 

        public static ClientStats DeSerialize(string file)
        {
            var x = new XmlSerializer(typeof(ClientStats));
            using (FileStream fsr = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                var ret = (ClientStats)x.Deserialize(fsr);
                return ret;
            }
        }

        public override string ToString()
        {
            return base.ToString();
        }

        [XmlRoot("MustReachParallel")]
        public class MustReachParallel
        {
            [XmlElement("SIDecisionsTime")]
            public double SIDecisionsTime { get; set; }

            [XmlElement("Z3Time")]
            public double Z3Time { get; set; }

            [XmlElement("Total")]
            public double Total { get; set; }
        }

        [XmlRoot("TotalTime")]
        public class ClientTotalTime
        {
            [XmlElement("WorkingTime")]
            public double WorkingTime { get; set; }

            [XmlElement("WaittingTime")]
            public double WaitingTime { get; set; }

            [XmlElement("Total")]
            public double Total { get; set; }
        }


        public void DumpStats()
        {
            var outf = new StreamWriter(Utils.ClientStats, false);

            outf.WriteLine(@"<?xml version=""1.0"" encoding=""utf-8"" ?>");
            outf.WriteLine(@"<ClientStats xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">");
            outf.WriteLine(@"<TotalTasks>{0}</TotalTasks>", TotalTasks);

            outf.WriteLine(@"<MustReachParallel>");
            outf.WriteLine(@"   <SIDecisionsTime>{0}</SIDecisionsTime>", MustReachParallelTime.SIDecisionsTime);
            outf.WriteLine(@"   <Z3Time>{0}</Z3Time>", MustReachParallelTime.Z3Time);
            outf.WriteLine(@"   <Total>{0}</Total>", MustReachParallelTime.Total);
            outf.WriteLine(@"</MustReachParallel>");

            outf.WriteLine(@"<InliningCallTreesTime>{0}</InliningCallTreesTime>", InliningCallTreesTime);

            outf.WriteLine(@"<TotalTime>");
            outf.WriteLine(@"   <WorkingTime>{0}</WorkingTime>", TotalTime.WorkingTime);
            outf.WriteLine(@"   <WaittingTime>{0}</WaittingTime>", TotalTime.WaitingTime);
            outf.WriteLine(@"   <Total>{0}</Total>", TotalTime.Total);
            outf.WriteLine(@"</TotalTime>");

            outf.WriteLine(@"</ClientStats>");
            outf.Close();
        }
    }
}
