package results;

import java.io.PrintWriter;
import java.util.TreeSet;

/**
 * Input: results.csv file and run-bcp-smv.log file containing the log of
 * running SMV/AV for modules in modules-bcp.txt.
 * 
 * Output: Updates results.csv with the output present in the log file. Also,
 * dumps a modules-success.txt file containing a list of modules where SMV/AV
 * was successful.
 * 
 * @author t-srg
 *
 */

public class AfterBcpSmv extends AfterSmv {

	String bcpSmvLogFile, successModulesFile;

	public AfterBcpSmv() {

		bcpSmvLogFile = logsDir + getProperty("bcpSmvLogFileName");
		successModulesFile = logsDir + getProperty("modulesSuccessFileName");

		return;
	}

	private void run() {

		TreeSet<CSVEntry> csvEntries = readCSVFile(csvFile);

		TreeSet<CSVEntry> newEntries = readLog(bcpSmvLogFile);

		updateCSVEntries(csvEntries, newEntries);

		writeCSVFile(csvEntries, csvFile);

		writePassedModules(csvEntries);

		System.out.println("Completed");

		return;
	}

	private void updateCSVEntries(TreeSet<CSVEntry> csvEntries, TreeSet<CSVEntry> newEntries) {

		for (CSVEntry entry : csvEntries) {
			if (entry.getSmvErrorLevel() != ErrorLevel.normalBuildErrorNum)
				continue;

			String module = entry.getModule();
			ErrorLevel bcpSmvErrorLevel = CSVEntry.getCsvEntry(newEntries, module).getSmvErrorLevel();

			if (entry.getBcpUsed() == null || entry.getBcpErrorLevel() == null)
				throw new RuntimeException("Module not processed by bcp " + module);

			entry.setBcpSmvErrorLevel(bcpSmvErrorLevel);
		}

		return;
	}

	private void writePassedModules(TreeSet<CSVEntry> entries) {

		PrintWriter out = getFileWriter(successModulesFile);

		for (CSVEntry entry : entries) {

			if (entry.getSmvErrorLevel() == ErrorLevel.successErrorNum)
				out.println(entry.getModule());
			else if (entry.getSmvErrorLevel() == ErrorLevel.normalBuildErrorNum) {
				if (entry.getBcpSmvErrorLevel() == null)
					throw new RuntimeException("Module not processed by SMV after BCP: " + entry.getModule());

				if (entry.getBcpSmvErrorLevel() == ErrorLevel.successErrorNum)
					out.println(entry.getModule());
			}
		}

		out.close();

		return;
	}

	public static void main(String[] args) {
		new AfterBcpSmv().run();
		return;
	}

}