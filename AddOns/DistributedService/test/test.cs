using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
//using System.Net.Http;
using System.Text;
//using Newtonsoft.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Collections.Specialized;

namespace test
{
	class program
    {
		static void Main(string[] args)
        {
            string serveruri = "http://localhost:5001/";
            WebClient myWebClient = new WebClient();
            string fileName = args[0];
            Console.WriteLine(fileName);
            NameValueCollection myQueryStringCollection = new NameValueCollection();
            myQueryStringCollection.Add("client", "4");
            myWebClient.QueryString = myQueryStringCollection;
            byte[] responseArray = myWebClient.UploadFile(serveruri, fileName);
        }
    }
}