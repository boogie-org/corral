using CommonLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SplitParServer
{
    public class BplTask
    {
        public string author { get; set; }
        public string callTreeDir { get; set; }
        public int level { get; set; }

        public BplTask(string author, string callTreeDir, int level)
        {
            this.author = author;
            this.callTreeDir = callTreeDir;
            this.level = level;
        }
         
        public string ToString()
        {
            return string.Format("{0} >>> {1}:{2}", Utils.Indent(level), author, callTreeDir);
        }
    }
}
