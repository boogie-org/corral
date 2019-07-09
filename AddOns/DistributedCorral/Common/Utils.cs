using cba.Util;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Common
{  
    public class Utils
    {  
        // concurrent collections
        public static string InputQueue = "inputQueue";
        public static string CallTreeQueue = "callTreeQueue";
        public static string ActiveCT = "activeCT";
        public static string CallTreeDictionary = "callTreeDictionary";
        public static string ClientStates = "clientStates";
        public static string IncomingCallTrees = "incomingCallTrees";
        public static string TaskMapper = "taskMapper";
        public static string Supporter = "supporter"; 
        public static string HandledCallTrees = "handledCT";

        // service endpoints
        public static string WebServiceEndpoint = "WebServiceEndpoint"; 
        public static string WebAPIServiceEndpoint = "WebApiServiceEndpoint";
        public static string ServerServiceEndpoint02 = "ServerServiceEndpoint02";
        public static string ServerServiceEndpoint = "ServerServiceEndpoint";
        public static string ClientServiceEndpoint = "ClientServiceEndpoint"; 

        // services
        public static string ServerService = @"fabric:/DistributedCorral/ServerStateful";
        public static string ClientStatefulService = @"fabric:/DistributedCorral/ClientStateful";
        public static string ClientStatelessService = @"fabric:/DistributedCorral/ClientStateless";

        public static int DelayTime = 100;

        //public static string BlobAddress = "DefaultEndpointsProtocol=;AccountName=;AccountKey=;EndpointSuffix=";
        //public static string BlobAddress = "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1; TableEndpoint=http://127.0.0.1:10002/devstoreaccount1; QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;";
        public static string BlobAddress = "UseDevelopmentStorage=true";
        public static string BlobFolder = "fileuploads";
        public static string DotFolder = "dotfiles";
        public static string ResultFolder = "resultfiles";
        public static string OutcomeFolder = "outcome";
        private static int MaxLen = 8;


        public static string ShortenStr(string s)
        {
            if (s.Length < MaxLen)
                return s;
            else
                return s.Substring(0, MaxLen);
        }

        public static string Indent(int i)
        {
            var ret = "";
            while (i > 0) { i--; ret += " "; }
            return ret;
        }

        public static string GetInputFileName(string s)
        {
            if (s.Contains("\\"))
                return new FileInfo(s.Replace("\"", "")).Name;
            else
                return s.Substring(s.LastIndexOf("/") + 1);
        }

        public static List<Tuple<string, int>> ParseSplitNodesMsg(string msg)
        {
            // parse nodes
            var sep01 = new char[1];
            sep01[0] = ';';
            var tokens = msg.Split(sep01);
            int pos = 0;
            List<Tuple<string, int>> ret = new List<Tuple<string, int>>();
            while (pos < tokens.Length)
            {
                ret.Add(new Tuple<string, int>(tokens[pos], Int32.Parse(tokens[pos + 1])));
                pos += 2;
            }
            return ret;
        }

        public static HashSet<string> ParseCallSitesMsg(string msg)
        {
            // parse callsites
            var sep01 = new char[1];
            sep01[0] = ';';
            var tokens = msg.Split(sep01);
            HashSet<string> ret = new HashSet<string>();
            for (int i = 0; i < tokens.Length; ++i)
                ret.Add(tokens[i]);
            return ret;
        }

        public static Dictionary<string, string> ParseMsg(string msg)
        {
            Dictionary<string, string> ret = new Dictionary<string, string>();
            var sep01 = new char[1];
            sep01[0] = '&';
            var sep02 = new char[1];
            sep02[0] = '=';
            var tokens = msg.Split(sep01);
            for(int i = 0; i < tokens.Length; ++i)
            {
                var tmp = tokens[i].Split(sep02);
                Debug.Assert(tmp.Length == 2);
                ret.Add(tmp[0], tmp[1]);
            }
            return ret;
        }

        public static int EncodeResult(BoogieVerify.ReturnStatus result)
        {
            switch (result)
            {
                case BoogieVerify.ReturnStatus.OK:
                    return 1; 
                case BoogieVerify.ReturnStatus.NOK:
                    return 2; 
                default:
                    return 0; 
            }
        }

        public static BoogieVerify.ReturnStatus DecodeResult(int result)
        {
            switch (result)
            {
                case 1:
                    return BoogieVerify.ReturnStatus.OK; 
                case 2:
                    return BoogieVerify.ReturnStatus.NOK; 
                default:
                    return BoogieVerify.ReturnStatus.ReachedBound; 
            }
        }

        public static string DecodeStatus(BoogieVerify.ReturnStatus status)
        {
            switch (status)
            {
                case BoogieVerify.ReturnStatus.OK:
                    return "OK"; 
                case BoogieVerify.ReturnStatus.NOK:
                    return "NOK"; 
                default:
                    return "ReachedBound"; 
            }
        }

        public static void ResponseHttp(HttpListenerContext context, string msg)
        {
            using (HttpListenerResponse response = context.Response)
            {
                byte[] outBytes = Encoding.UTF8.GetBytes(msg);
                response.OutputStream.Write(outBytes, 0, outBytes.Length);
            }
        }

        public static void ResponseHttp(HttpListenerContext context)
        {
            ResponseHttp(context, "ACK");
        }

        public static string GetParentTask(string callTreeName)
        {
            if (!callTreeName.Contains("_"))
                return "";
            else
                return callTreeName.Substring(0, callTreeName.LastIndexOf("_")) + "split.txt";
        }
    }
}
