package util;

import java.io.File;

/**
 * Checks if all the modules have a valid directory present in the system. This
 * check was required because some modules did not exist.
 * 
 * @author t-srg
 *
 */

public class CheckDirs extends util.Utilities {

	private void run() {

		readModules();

		checkModules();

		System.out.println("Completed");

		return;
	}

	private void checkModules() {

		for (String module : modules) {
			File file = new File(sdxroot + module);

			if (file.exists() == false)
				System.out.println("Doesn't exist: " + file.getPath());
			else if (file.isDirectory() == false)
				System.out.println("Not a dir: " + file.getPath());
		}

		return;
	}

	public static void main(String[] args) {
		new CheckDirs().run();
		return;
	}

}