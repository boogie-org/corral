package results;

import java.io.BufferedReader;
import java.util.HashMap;
import java.util.TreeSet;

/**
 * Input: results.csv file containing SMV/AV output and bcp-output.csv file
 * containing output from bcp.
 * 
 * Output: Updates results.csv file with the output from bcp.
 * 
 * @author t-srg
 *
 */

public class AfterBcp extends BaseClass {

	private String bcpOutputFile;

	public AfterBcp() {

		bcpOutputFile = logsDir + getProperty("bcpOutputFileName");

		return;
	}

	private void run() {

		TreeSet<CSVEntry> csvEntries = readCSVFile(csvFile);

		HashMap<String, Bool> bcpOutputMap = readLog();

		updateCsvEntries(csvEntries, bcpOutputMap);

		writeCSVFile(csvEntries, csvFile);

		System.out.println("Completed");

		return;
	}

	private HashMap<String, Bool> readLog() {

		HashMap<String, Bool> bcpOutputMap = new HashMap<String, Bool>();
		BufferedReader in = getFileReader(bcpOutputFile);

		Bool[] bool = Bool.values();

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			String[] tokens = line.split(",");
			if (tokens.length != 2)
				throw new RuntimeException("CSV entry length is not 2: " + line);

			String module = tokens[0];
			Bool bcpOutput = bool[Integer.parseInt(tokens[1].trim())];

			bcpOutputMap.put(module, bcpOutput);
		}

		closeFileReader(in);

		return bcpOutputMap;
	}

	private void updateCsvEntries(TreeSet<CSVEntry> csvEntries, HashMap<String, Bool> bcpOutputEntries) {

		for (CSVEntry csvEntry : csvEntries) {
			if (csvEntry.getSmvErrorLevel() != ErrorLevel.normalBuildErrorNum)
				continue;

			String module = csvEntry.getModule();
			Bool bcpOutput = bcpOutputEntries.get(module);

			if (bcpOutput == null)
				throw new RuntimeException("No log entry found for module " + module);

			csvEntry.setBcpUsed(Bool.True);
			csvEntry.setBcpErrorLevel(bcpOutput);
		}

		return;
	}

	public static void main(String[] args) {
		new AfterBcp().run();
		return;
	}

}