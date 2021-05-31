package results;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.TreeSet;

/**
 * This class is executed after running SMV/AV for a set of modules
 * 
 * Output: For each module, creates a CSV entry containing the output of SMV/AV
 * and dumps the CSV file. Also creates a "modules-bcp.txt" file containing the
 * list of modules where NormalBuild failed which is used to run 'bcp'.
 * 
 * @author t-srg
 *
 */

public class AfterSmv extends BaseClass {

	private String smvLogFile, bcpOutputFile;

	public AfterSmv() {

		smvLogFile = logsDir + getProperty("smvLogFileName");
		bcpOutputFile = logsDir + getProperty("modulesBcpFileName");

		return;
	}

	private void run() {

		TreeSet<CSVEntry> entries = readLog(smvLogFile);

		writeCSVFile(entries, csvFile);

		dumpBcpFiles(entries);

		System.out.println("Completed");

		return;
	}

	protected TreeSet<CSVEntry> readLog(String logFile) {

		TreeSet<CSVEntry> entries = new TreeSet<CSVEntry>();
		BufferedReader in = getFileReader(logFile);

		int totalModules = 0, totalOutputs = 0;

		int currNum = 0;
		String currModule = null;

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			// Remember the module name and number currently executing. Parsing
			// is very specific to the log message. Change this if the log
			// message is modified.
			if (line.startsWith("Executing SMV for module")) {
				String[] tokens = line.split(" ", 7);

				currNum = Integer.parseInt(tokens[4]);
				currModule = tokens[6].trim();

				totalModules++;
			} else {

				// If the current line is the output of SMV/AV, record the
				// output for the current module

				ErrorLevel level = null;

				// Change the text below if the output messages are modified.
				if (line.startsWith("[INFO] Total time taken"))
					level = ErrorLevel.successErrorNum;
				else if (line.startsWith("[FATAL ERROR] Action: NormalBuild, failed"))
					level = ErrorLevel.normalBuildErrorNum;
				else if (line.startsWith("[FATAL ERROR] Action: InterceptedBuild, failed"))
					level = ErrorLevel.interceptedBuildErrorNum;
				else if (line.startsWith("[FATAL ERROR] Action: CreateBPL, failed"))
					level = ErrorLevel.createBPLErrorNum;
				else if (line.startsWith("[FATAL ERROR] Action: InstrumentChecks, failed"))
					level = ErrorLevel.instrumentChecksErrorNum;
				else if (line.startsWith("[FATAL ERROR] Action: Check, failed"))
					level = ErrorLevel.checkErrorNum;

				// Create a CSVEntry object
				if (level != null) {
					CSVEntry entry = new CSVEntry();

					entry.setNum(currNum);
					entry.setModule(currModule);
					entry.setSmvErrorLevel(level);

					entries.add(entry);

					totalOutputs++;
				}
			}
		}

		// Make sure the number of outputs recorded is equal to the number of
		// modules executed
		if (totalModules != totalOutputs) {
			System.out.println("Total modules: " + totalModules + "\nTotal outputs: " + totalOutputs);
			throw new RuntimeException("Number of modules not equal to the number of outputs");
		}

		closeFileReader(in);

		return entries;
	}

	private void dumpBcpFiles(TreeSet<CSVEntry> entries) {

		PrintWriter out = getFileWriter(bcpOutputFile);

		for (CSVEntry entry : entries) {
			if (entry.getSmvErrorLevel() == ErrorLevel.normalBuildErrorNum)
				out.println(entry.getModule());
		}

		out.close();

		return;
	}

	public static void main(String[] args) {
		new AfterSmv().run();
		return;
	}

}