using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace FileUploader
{
    public static class MultipartParser
    {
        public static async Task<List<string>> ParseFiles(Stream data, string contentType, Action<string, Stream> fileProcessor)
        {
            var streamContent = new StreamContent(data);
            List<string> fileNames = new List<string>();
            streamContent.Headers.ContentType = MediaTypeHeaderValue.Parse(contentType);

            var provider = await streamContent.ReadAsMultipartAsync();

            foreach (var httpContent in provider.Contents)
            {
                var fileName = httpContent.Headers.ContentDisposition.FileName;
                if (string.IsNullOrWhiteSpace(fileName))
                {
                    continue;
                }

                using (Stream fileContents = await httpContent.ReadAsStreamAsync())
                {
                    fileProcessor(fileName, fileContents);
                }
                fileNames.Add(fileName);
            }
            return fileNames;
        }
    }
}