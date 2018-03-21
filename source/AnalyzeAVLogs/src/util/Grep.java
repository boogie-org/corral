package util;

import java.io.File;

/**
 * For each module in modules.txt, greps for the pattern in the file identified
 * by 'fileSuffix'. The 'useRegex' flag tells whether the pattern to search for
 * is a regular expression.
 * 
 * @author t-srg
 *
 */

public class Grep extends util.Utilities {

	private String pattern, grepFile;
	private boolean useRegex;

	public Grep() {

		pattern = getProperty("pattern");
		grepFile = getProperty("grepFile");
		useRegex = Boolean.valueOf(getProperty("useRegex"));

		return;
	}

	private void run() {

		readModules();

		grep();

		return;
	}

	private void grep() {

		int num = 1, count = 0;
		for (String module : modules) {
			System.out.println(num + ": " + module);

			String file = sdxroot + module + "\\" + grepFile;
			String fileName = new File(file).getName();

			if (new File(file).exists() == false)
				System.out.println("Warning: " + fileName + " not found");
			else
				count += grep(pattern, file, useRegex);

			System.out.println();

			num++;
		}

		System.out.println();
		System.out.println("Total matches: " + count);

		return;
	}

	public static void main(String[] args) {
		new Grep().run();
		return;
	}

}