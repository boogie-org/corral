package parse;

import java.io.BufferedReader;
import java.io.File;
import java.io.PrintWriter;

public class GenerateStats extends util.Utilities {

	private String outputFile;

	private int blockingClausesWarnings = 0, stdoutWarnings = 0, fastAvnWarnings = 0;

	public GenerateStats() {

		outputFile = outputDir + getProperty("statsFileName");

		return;
	}

	protected void run() {

		readModules();

		generateStats();

		return;
	}

	private void generateStats() {

		PrintWriter out = getFileWriter(outputFile);

		out.println("num,module,#defect traces,#blocking clauses,time(sec),test.bpl size (in bytes)");

		int totalTraces = 0, totalBlockingClauses = 0, totalTime = 0;

		int count = 1;
		for (String module : modules) {

			System.out.println("Processing module " + count + " in " + module);

			int traces = getTracesCount(module);
			int clauses = getBlockingClausesCount(module);
			int time = getFastAVNTime(module);
			long fileSize = getBPLFileSize(module);

			out.println(count + "," + module + "," + traces + "," + clauses + "," + time + "," + fileSize);

			totalTraces += traces;
			totalBlockingClauses += clauses;
			totalTime += time;

			System.out.println();

			count++;
		}

		out.println(",,,");
		out.println(",Total," + totalTraces + "," + totalBlockingClauses + "," + totalTime + ",");

		out.close();

		System.out.println("FastAVN warnings: " + fastAvnWarnings);
		System.out.println("Blocking clauses warnings: " + blockingClausesWarnings);
		System.out.println("stdout.txt warnings: " + stdoutWarnings);

		return;
	}

	private int getTracesCount(String module) {
		File dir = new File(sdxroot + module + "\\smv\\Bugs");

		int count = 0;
		if (dir.exists()) {
			for (File file : dir.listFiles()) {
				if (file.isDirectory())
					count++;
			}
		}

		return count;
	}

	private int getBlockingClausesCount(String module) {

		String pattern = "[TAG: AV_STATS] blocked.count : ";

		int clauses = 0;

		for (File file : new File(sdxroot + module + "\\smv\\").listFiles()) {
			if (file.isDirectory() == false)
				continue;

			if (file.getName().equals("Bugs") || file.getName().equals("build"))
				continue;

			File stdout = new File(file.getPath() + "\\stdout.txt");

			if (stdout.exists() == false) {
				System.out.println("Warning: stdout.txt not found for the entry point " + file.getPath());
				stdoutWarnings++;
				continue;
			}

			BufferedReader in = getFileReader(stdout.getPath());

			boolean found = false;
			String line = null;
			while ((line = readNextLine(in)) != null) {
				if (line.length() == 0)
					continue;

				if (line.startsWith(pattern) == false)
					continue;

				found = true;
				clauses += (int) (Double.parseDouble(line.substring(pattern.length())));
			}

			// Pattern is not always printed in the stdout.txt file
			if (found == false) {
				System.out.println("Warning: blocking clauses pattern not found for the entry point " + file.getName());
				blockingClausesWarnings++;
			}

			closeFileReader(in);
		}

		return clauses;
	}

	private int getFastAVNTime(String module) {

		String path = sdxroot + module + "\\smv\\check.txt";

		if (new File(path).exists() == false)
			throw new RuntimeException("Warning: check.txt file not found for the module " + module);

		final String pattern = "[TAG: AV_STATS] fastavn(s) : ";

		int time = 0;

		BufferedReader in = getFileReader(path);

		boolean found = false;
		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			if (line.startsWith(pattern) == false)
				continue;

			found = true;
			time = (int) (Double.parseDouble(line.substring(pattern.length())));
		}

		// TODO Remove this comment later
		if (found == false) {
			time = -1;
			System.out.println("Warning: FastAVN pattern not found for module " + module);
			fastAvnWarnings++;
			// throw new RuntimeException("Pattern not found " + modulePath);
		}

		closeFileReader(in);

		return time;
	}

	private long getBPLFileSize(String module) {
		String path = sdxroot + module + "\\smv\\build\\test.bpl";

		File file = new File(path);

		if (file.exists() == false) {
			System.out.println("Warning: test.bpl file not found");
			return 0;
		}

		return file.length();
	}

	public static void main(String[] args) {
		new GenerateStats().run();
		return;
	}

}