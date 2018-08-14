using CommonLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SplitParClient
{
    public class WorkItem
    {
        public string args;
        public string key;
        public string root;

        public WorkItem(string key, string root, string args)
        {
            this.key = key;
            this.args = args;
            this.root = root;
        }

        public void Run()
        {
            var loc = System.IO.Path.Combine(root, Utils.CorralDir, Utils.CorralExe);

            var tmp = System.IO.Path.Combine(root, Utils.RunDir);
            System.IO.Directory.CreateDirectory(tmp); 

            Utils.run(tmp, loc, args); 
        }

        public override string ToString()
        {
            return string.Format("{0}###{1}###{2}", args, key, root);
        }
    }
}
