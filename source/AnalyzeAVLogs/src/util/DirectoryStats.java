package util;

import java.util.Map.Entry;
import java.io.PrintWriter;
import java.util.TreeMap;

/**
 * Input: List of modules
 * 
 * Output: Number of modules present under each high-level directory
 * 
 * This is helpful in targeting IRQL checking on the folder containing large
 * number of modules.
 * 
 * @author t-srg
 *
 */

public class DirectoryStats extends util.Utilities {

	private TreeMap<String, Integer> frequency = new TreeMap<String, Integer>();

	private String dirStatsFile;

	public DirectoryStats() {

		dirStatsFile = outputDir + getProperty("dirStatsFileName");

		return;
	}

	private void run() {

		readModules();

		extractFreq();

		writeFreq();

		System.out.println("Completed");

		return;
	}

	private void extractFreq() {

		for (String module : modules) {
			String dir = module.split("\\\\")[0];

			Integer count = frequency.getOrDefault(dir, 0);
			count++;

			frequency.put(dir, count);
		}

		return;
	}

	private void writeFreq() {

		PrintWriter out = getFileWriter(dirStatsFile);

		out.println("Directory, # Modules, Percentage");

		for (Entry<String, Integer> entry : frequency.entrySet()) {
			double percent = ((double) entry.getValue() / (double) modules.size()) * 100;

			out.println(entry.getKey() + "," + entry.getValue() + "," + percent);
		}

		out.close();

		return;
	}

	public static void main(String[] args) {
		new DirectoryStats().run();
		return;
	}

}