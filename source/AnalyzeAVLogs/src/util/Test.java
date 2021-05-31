package util;

import java.io.BufferedReader;
import java.io.File;

/**
 * Class used for testing.
 * 
 * @author t-srg
 *
 */

public class Test extends util.Utilities {

	private String findstrLog;

	public Test() {
		findstrLog = inputDir + getProperty("findstrLog");
		return;
	}

	private void run() {
		getPrefixesFromLog();
		return;
	}

	private void getPrefixesFromLog() {

		BufferedReader in = getFileReader(findstrLog);

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			String[] tokens = line.split("\\\\");

			String prefix = new String();
			for (int i = 0; i < tokens.length - 1; i++) {
				if (i == tokens.length - 2)
					prefix += tokens[i];
				else
					prefix += tokens[i] + "\\";
			}

			String other = new File(line).getParent();

			System.out.println(prefix + ",");
			System.out.println(other + ".");
			System.out.println();
		}

		closeFileReader(in);

		return;
	}

	public static void main(String[] args) {
		new Test().run();
		return;
	}

}