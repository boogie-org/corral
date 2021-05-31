using System;
using System.Collections.Generic;
using System.IO;

namespace InstrumentAVP
{
	class Program
	{

		static void Main(string[] args)
		{
			if (args.Length != 2)
			{
				Console.WriteLine("Usage: InstrumentAVP.exe checkirql.avp checkirql.prop");
				return;
			}

			String avpFile = args[0];
			String propFile = args[1];

			// Parse the .prop file and store the line number mappings
			Dictionary<string, int> lineNumberMap = ProcessPropFile(propFile);

			// Instrument AVP file with line number mappings
			ProcessAvpFile(avpFile, propFile, lineNumberMap);

			return;
		}

		static Dictionary<string, int> ProcessPropFile(string fileName)
		{
			Dictionary<string, int> map = new Dictionary<string, int>();

			StreamReader file = new StreamReader(fileName);

			int lineNum = 0;
			string line = null;
			while (true)
			{
				// Skip empty lines
				while ((line = file.ReadLine()) != null && line.Length == 0)
					lineNum++;
				lineNum++;

				// Break at the end of file 
				if (line == null)
					break;

				// Extract the function name
				var tokens = line.Split('(')[0].Trim().Split(' ');
				string functionName = tokens[tokens.Length - 1];

				// Skip till the beginning of the function body
				while ((line = file.ReadLine()) != null && line != "{")
					lineNum++;
				lineNum++;

				// Store the line number
				if (map.ContainsKey(functionName) == false)
					map.Add(functionName, lineNum);

				// Skip till the end of function body
				while ((line = file.ReadLine()) != null && line != "}")
					lineNum++;
				lineNum++;
			}

			file.Close();

			return map;
		}

		private static void ProcessAvpFile(string avpFile, string propFile, Dictionary<string, int> lineNumberMap)
		{
			string path = @"..\..\..\check\checkirql\";

			StreamReader file = new StreamReader(avpFile);

			String outputFile = Path.GetFileNameWithoutExtension(avpFile) + "-with-linenums.avp";
			StreamWriter output = new StreamWriter(outputFile);

			String line = null;
			while ((line = file.ReadLine()) != null)
			{
				output.WriteLine(line);

				// Add asserts for mapping source line numbers
				if (line.StartsWith("\tassert {:name"))
				{
					var functionName = line.Split('"')[1];
					if (lineNumberMap.ContainsKey(functionName) == false)
					{
						Console.WriteLine("Warning: No entry in prop file found for the function " + functionName);
						continue;
					}

					var lineNum = lineNumberMap[functionName];
					output.WriteLine("\tassert {:sourcefile \"" + path + propFile + "\"} {:sourceline " + lineNum + "} {:print \"Atomic Continuation\"} true;");
					output.WriteLine("\tassert {:sourcefile \"" + path + propFile + "\"} {:sourceline " + lineNum + "} {:print \"Return\"} true;");
				}
			}

			file.Close();
			output.Close();
		}
	}
}
