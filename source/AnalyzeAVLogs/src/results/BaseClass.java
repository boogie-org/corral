package results;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.TreeSet;

abstract class BaseClass extends util.Utilities {

	protected String logsDir, csvFile;

	// enum to represent the various output of running SMV/AV on a module
	protected enum ErrorLevel {
		successErrorNum, normalBuildErrorNum, interceptedBuildErrorNum, createBPLErrorNum, instrumentChecksErrorNum, checkErrorNum
	}

	protected enum Bool {
		True, False
	}

	public BaseClass() {

		logsDir = getProperty("logsDir");
		csvFile = logsDir + getProperty("resultsCsvFileName");

		return;
	}

	protected TreeSet<CSVEntry> readCSVFile(String path) {

		TreeSet<CSVEntry> entries = new TreeSet<CSVEntry>();
		BufferedReader in = getFileReader(path);

		String line = null;
		ErrorLevel[] errorLevel = ErrorLevel.values();
		Bool[] bool = Bool.values();

		boolean firstLine = true;
		while ((line = readNextLine(in)) != null) {

			// Skip reading the first header line
			if (firstLine) {
				firstLine = false;
				continue;
			}

			if (line.length() == 0)
				continue;

			String[] tokens = line.split(",");
			CSVEntry entry = new CSVEntry();

			for (int i = 0; i < tokens.length; i++) {
				switch (i) {
				case 0:
					entry.setNum(Integer.parseInt(tokens[i]));
					break;
				case 1:
					entry.setModule(tokens[i]);
					break;
				case 2:
					entry.setSmvErrorLevel(errorLevel[Integer.parseInt(tokens[i])]);
					break;
				case 3:
					entry.setBcpUsed(bool[Integer.parseInt(tokens[i])]);
					break;
				case 4:
					entry.setBcpErrorLevel(bool[Integer.parseInt(tokens[i])]);
					break;
				case 5:
					entry.setBcpSmvErrorLevel(errorLevel[Integer.parseInt(tokens[i])]);
					break;
				default:
					throw new RuntimeException("More than 6 entries found in CSV file " + line);
				}
			}

			entries.add(entry);
		}

		closeFileReader(in);

		return entries;
	}

	protected void writeCSVFile(TreeSet<CSVEntry> entries, String path) {

		PrintWriter out = getFileWriter(path);

		out.println("num,module,smvErrorLevel,bcpUsed,bcpErrorLevel,bcpSmvErrorLevel");

		for (CSVEntry entry : entries) {
			if (entry.getNum() == null || entry.getModule() == null)
				throw new RuntimeException("Empty module found " + entry.getModule());

			out.print(entry.getNum() + "," + entry.getModule());

			if (entry.getSmvErrorLevel() != null)
				out.print("," + entry.getSmvErrorLevel().ordinal());
			else
				out.print(",");

			if (entry.getBcpUsed() != null)
				out.print("," + entry.getBcpUsed().ordinal());
			else
				out.print(",");

			if (entry.getBcpErrorLevel() != null)
				out.print("," + entry.getBcpErrorLevel().ordinal());
			else
				out.print(",");

			if (entry.getBcpSmvErrorLevel() != null)
				out.print("," + entry.getBcpSmvErrorLevel().ordinal());
			else
				out.print(",");

			out.println();
		}

		out.close();

		return;
	}

}