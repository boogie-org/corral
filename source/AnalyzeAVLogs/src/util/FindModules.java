package util;

import java.io.File;
import java.util.Arrays;
import java.util.HashSet;
import java.util.TreeSet;

/**
 * Output: List of directories in 'basedir' which are modules. SMV can then be
 * run on these modules.
 * 
 * Note: Will go into an infinite recursion if there are symbolic links pointing
 * back to a processed directory.
 * 
 * Change 'baseDir' to process from a different directory.
 * 
 * Change 'excludeDirs' to exclude certain set of directories
 * 
 * @author t-srg
 *
 */

public class FindModules extends util.Utilities {

	private String baseDir, outputFile;

	private TreeSet<String> newModules = new TreeSet<String>();

	private HashSet<String> excludeDirs = new HashSet<String>(Arrays.asList(".git"));

	public FindModules() {

		baseDir = sdxroot;
		outputFile = outputDir + getProperty("modulesFileName");

		return;
	}

	private void run() {

		File base = new File(baseDir);

		if (base.exists() == false || base.isDirectory() == false)
			throw new RuntimeException("Base directory not present");

		processDir(base);

		writeFile(newModules, outputFile);

		System.out.println("Completed");

		return;
	}

	private void processDir(File dir) {

		if (excludeDirs.contains(dir.getName()))
			return;

		System.out.println("Processing dir " + dir.getPath());

		// This check was added due to a failure while exploring modules in
		// 'src' folder
		if (dir.listFiles() == null)
			return;

		for (File file : dir.listFiles()) {
			if (isSourcesFile(file))
				newModules.add(dir.getPath());
			else if (file.isDirectory())
				processDir(file);
		}

		return;
	}

	private boolean isSourcesFile(File file) {

		if (file.isDirectory())
			return false;

		if (file.getName().equals("sources") == false)
			return false;

		return true;
	}

	public static void main(String[] args) {
		new FindModules().run();
		return;
	}

}