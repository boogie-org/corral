using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Collections.Specialized;

namespace Program
{
    public class JsonContent : StringContent
    {
        public JsonContent(object obj) :
            base(JsonConvert.SerializeObject(obj), Encoding.UTF8, "application/json")
        { }
    }
    class program
    {
        static void Main(string[] args)
        {
            
            string fileName = args[0];
            //string program = File.ReadAllText(fileName);
            string result = VerifyProgramOnCloud(fileName);
            Console.WriteLine(result);
        }

        static string VerifyProgramOnCloud(string filename)
        {
            var multiForm = new MultipartFormDataContent();
            FileStream fs = File.OpenRead(filename);
            multiForm.Add(new StreamContent(fs), "file", Path.GetFileName(filename));
            string cloudAddress = "http://localhost:5001/";
            HttpClient client = new HttpClient();
            client.Timeout = System.Threading.Timeout.InfiniteTimeSpan;
            UriBuilder serverUri = new UriBuilder(cloudAddress);
            serverUri.Query = string.Empty;
            //JsonContent tmp = new JsonContent(string.Format("{0}", program));
            string replyFromServer = null;
            var rep = client.PostAsync(serverUri.Uri, multiForm).Result;
            replyFromServer = rep.Content.ReadAsStringAsync().Result;
            return replyFromServer;
        }
    }
}