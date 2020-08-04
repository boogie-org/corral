package util;

import java.io.BufferedReader;
import java.io.File;
import java.util.HashSet;

/**
 * Input: Modules in a directory and the output of findstr command on that
 * directory.
 * 
 * Output: File for each prefix (up to 'prefixLengthMax') containing a list of
 * modules satisfying that prefix. Ex: Prefix 0 indicates that the module itself
 * contains the pattern and prefix 1 indicates that the parent directory or a
 * sibling directory of the module contains the pattern.
 * 
 * A module will not be added to a particular prefix if it is also part of a
 * smaller prefix. Hence, each module will be associated with a single prefix.
 * 
 * This is helpful in filtering out the modules which are not interesting for
 * IRQL checking.
 * 
 * findstr command to be run inside a directory: findstr /m /s /i "irql spinlock
 * fastmutex" *.c *.cpp *.h > findstr.log 2>&1
 * 
 * Note: The output from findstr itself will not contain the directory name.
 * Hence, prefix each output line in 'findstr.log' with the directory name.
 * 
 * @author t-srg
 *
 */

public class ExtractPrefixes extends util.Utilities {

	private String findstrLog;

	private int maxPrefix;

	private HashSet<String> prefixes = new HashSet<String>();
	private HashSet<String> processedModules = new HashSet<String>();

	public ExtractPrefixes() {

		findstrLog = inputDir + getProperty("findstrLog");
		maxPrefix = Integer.valueOf(getProperty("maxPrefix"));

		return;
	}

	private void run() {

		readModules();

		getPrefixesFromLog();

		for (int i = 0; i < maxPrefix; i++) {
			HashSet<String> modulesWithPrefix = filterModulesWithPrefix(i);
			String outputFile = outputDir + i + "-" + getProperty("modulesFileName");

			writeFile(modulesWithPrefix, outputFile);
		}

		System.out.println("Completed");

		return;
	}

	private void getPrefixesFromLog() {

		BufferedReader in = getFileReader(findstrLog);

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			// Extract the parent folder name
			String prefix = new File(line).getParent();

			prefixes.add(prefix);
		}

		closeFileReader(in);

		return;
	}

	private HashSet<String> filterModulesWithPrefix(int prefixLength) {

		HashSet<String> modulesWithPrefix = new HashSet<String>();

		for (String module : modules) {

			// Loop to get the prefix of the module based on the prefix length
			String modulePrefix = new String(module);
			for (int i = 0; i < prefixLength; i++) {
				modulePrefix = new File(modulePrefix).getParent();

				if (modulePrefix == null)
					break;
			}

			if (modulePrefix == null)
				continue;

			// Check if the current module prefix is part of a prefix from
			// findstr and if the current module is not already processed
			if (prefixes.contains(modulePrefix) && processedModules.contains(module) == false) {
				modulesWithPrefix.add(module);
				processedModules.add(module);
			}
		}

		return modulesWithPrefix;
	}

	public static void main(String[] args) {
		new ExtractPrefixes().run();
		return;
	}

}