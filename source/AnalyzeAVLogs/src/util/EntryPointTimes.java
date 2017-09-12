package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.PrintWriter;

/**
 * Output: For a particular module, creates a CSV file containing the time spent
 * by SMV/AV for each entry point.
 * 
 * @author t-srg
 *
 */

public class EntryPointTimes extends util.Utilities {

	private String module, pattern, outputFile;

	public EntryPointTimes() {

		module = sdxroot + getProperty("moduleForEntryPointTimes");
		pattern = "[TAG: AV_STATS] TotalTime(ms) : ";
		outputFile = outputDir + getProperty("entryPointTimesCsvFileName");

		return;
	}

	private void run() {

		PrintWriter out = getFileWriter(outputFile);

		for (File file : new File(module).listFiles()) {

			if (file.isDirectory() == false)
				continue;

			if (file.getName().equals("Bugs") || file.getName().equals("build"))
				continue;

			File stdout = new File(file.getPath() + "\\stdout.txt");

			if (stdout.exists() == false) {
				System.out.println("Warning: stdout.txt not found for the entry point " + file.getPath());
				continue;
			}

			int time = extractEntryPointTime(stdout.getPath());

			if (time == -1)
				System.out.println("Warning: pattern not found for the entry point " + file.getName());
			else
				out.println(file.getPath() + "," + time);
		}

		out.close();

		System.out.println("Completed");

		return;
	}

	private int extractEntryPointTime(String file) {

		BufferedReader in = getFileReader(file);

		int time = -1;

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			// Extract the total time in seconds
			if (line.startsWith(pattern) == true) {
				time = (int) (Double.parseDouble(line.substring(pattern.length())));
				time /= 1000;
				break;
			}
		}

		closeFileReader(in);

		return time;
	}

	public static void main(String[] args) {
		new EntryPointTimes().run();
		return;
	}

}