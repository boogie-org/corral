package util;

import java.io.File;
import java.io.PrintWriter;

/**
 * Dumps the list of modules which contain the 'slam.li' file. This is needed to
 * check if InterceptedBuild is correctly creating the slam.li file. Otherwise,
 * CreateBPL will fail.
 * 
 * @author t-srg
 *
 */

public class CheckLIFile extends util.Utilities {

	private String outputFile;

	public CheckLIFile() {

		outputFile = outputDir + getProperty("modulesWithLIFileName");

		return;
	}

	private void run() {

		readModules();

		checkLiFile();

		System.out.println("Completed");

		return;
	}

	private void checkLiFile() {

		PrintWriter out = getFileWriter(outputFile);

		for (String module : modules) {
			String path = sdxroot + module + "\\smv\\slam.li";

			if (new File(path).exists())
				out.println(module);
		}

		out.close();

		return;
	}

	public static void main(String[] args) {
		new CheckLIFile().run();
		return;
	}

}