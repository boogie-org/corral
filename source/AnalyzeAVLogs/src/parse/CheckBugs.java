package parse;

import java.io.File;

/**
 * Output: Finds the number of defect traces present in each module.
 * 
 * @author t-srg
 *
 */

public class CheckBugs extends util.Utilities {

	protected void run() {

		readModules();

		checkBugs();

		return;
	}

	private void checkBugs() {

		int totalTraces = 0;

		for (String module : modules) {

			int count = getTraceCountForModule(module);

			if (count != 0) {
				System.out.println(module + ": " + count);
				totalTraces += count;
			}
		}

		System.out.println();
		System.out.println("Total defect traces: " + totalTraces);

		return;

	}

	protected int getTraceCountForModule(String module) {

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

	public static void main(String[] args) {
		new CheckBugs().run();
		return;
	}

}