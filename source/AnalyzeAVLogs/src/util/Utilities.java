package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.Properties;

/**
 * Base class containing all the commonly used methods.
 * 
 * @author t-srg
 *
 */

public abstract class Utilities {

	private static final String propertiesFile = "config.properties";

	private Properties properties;

	protected String sdxroot, inputDir, outputDir;

	protected LinkedHashSet<String> modules;

	public Utilities() {

		readPropertiesFile();

		sdxroot = getProperty("sdxroot");
		inputDir = getProperty("inputDir");
		outputDir = getProperty("outputDir");

		return;
	}

	private void readPropertiesFile() {

		properties = new Properties();

		InputStream in = null;
		try {
			in = new FileInputStream(propertiesFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		try {
			properties.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return;
	}

	protected String getProperty(String key) {
		String value = properties.getProperty(key);
		if (value == null)
			throw new RuntimeException(key + " not set in the property file");
		return value;
	}

	protected void readModules() {

		String modulesFile = inputDir + getProperty("modulesFileName");
		modules = readFile(modulesFile);

		return;
	}

	protected int grep(String pattern, String file, boolean useRegex) {

		String fileName = new File(file).getName();

		BufferedReader in = getFileReader(file);

		int count = 0;
		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			if (useRegex) {
				if (line.matches(pattern)) {
					count++;
					System.out.println(fileName + ": " + line);
				}
			} else {
				if (line.contains(pattern)) {
					count++;
					System.out.println(fileName + ": " + line);
				}
			}
		}

		closeFileReader(in);

		return count;
	}

	protected String getProcedureName(String line) {

		// Splits at '(' where the arguments start
		String[] tokens = line.split("\\(", 2);

		// Splits at ' ' and takes the last token which contains the procedure
		// name
		String[] procTokens = tokens[0].split(" ");
		String procedureName = procTokens[procTokens.length - 1];

		return procedureName;
	}

	protected String getProcedureSignature(String line) {

		// Splits at '(' where the arguments start
		String[] tokens = line.split("\\(", 2);

		// Splits at ' ' and takes the last token which contains the procedure
		// name
		String[] procTokens = tokens[0].split(" ");
		String procedureName = procTokens[procTokens.length - 1];

		// Combine procedure name with the arguments list
		String signature = procedureName + "(" + tokens[1];

		return signature;
	}

	protected LinkedHashSet<String> readFile(String path) {

		LinkedHashSet<String> lines = new LinkedHashSet<String>();
		BufferedReader in = getFileReader(path);

		String line;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			boolean changed = lines.add(line);

			if (changed == false)
				throw new RuntimeException("Duplicate line found " + line);
		}

		closeFileReader(in);

		return lines;
	}

	protected void writeFile(Collection<String> collection, String path) {
		PrintWriter out = getFileWriter(path);

		for (String str : collection)
			out.println(str);

		out.close();

		return;
	}

	protected BufferedReader getFileReader(String path) {
		BufferedReader in = null;

		try {
			in = new BufferedReader(new FileReader(path));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		return in;
	}

	protected String readNextLine(BufferedReader in) {
		String line = null;
		try {
			line = in.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return line;
	}

	protected void closeFileReader(BufferedReader in) {
		try {
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}

	protected PrintWriter getFileWriter(String path) {
		PrintWriter out = null;

		File parentFile = new File(path).getParentFile();
		if (parentFile != null)
			parentFile.mkdirs();

		try {
			out = new PrintWriter(new BufferedWriter(new FileWriter(path)));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return out;
	}

}