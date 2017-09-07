package propinst;

import java.io.BufferedReader;
import java.io.PrintWriter;

/**
 * A source-to-source AVP file transformation which adds certain assertions.
 * These assertions will be be used by defectviewer.exe to display the
 * preconditions present in the original AVP file.
 * 
 * Input: checkirql.avp
 * 
 * Output: checkirql-razzle.avp with assertions pointing back to checkirql.avp
 * 
 * @author t-srg
 *
 */

public class Transform extends util.Utilities {

	private String inputAvpFile, outputAvpFile;

	public Transform() {

		inputAvpFile = sdxroot + getProperty("avpHome") + getProperty("inputAvpFileName");
		outputAvpFile = sdxroot + getProperty("avpHome") + getProperty("outputAvpFileName");

		return;
	}

	protected void run() {

		BufferedReader in = getFileReader(inputAvpFile);
		PrintWriter out = getFileWriter(outputAvpFile);

		int lineNum = 0;
		String line = null;
		while ((line = readNextLine(in)) != null) {

			lineNum++;
			out.println(line);

			if (line.length() == 0)
				continue;

			// add assertions for a procedure rule
			if (line.startsWith("\tprocedure")) {
				processStub(in, out, lineNum);
				lineNum += 3;
			}
		}

		closeFileReader(in);
		out.close();

		System.out.println("Completed");

		return;
	}

	private void processStub(BufferedReader in, PrintWriter out, int lineNum) {

		String first = readNextLine(in);
		String second = readNextLine(in);
		String third = readNextLine(in);

		// Check if the next three lines match
		if ((first.equals("}") && second.equals("-->") && third.equals("{")) == false)
			throw new RuntimeException("Pattern doesn't match " + first + " " + second + " " + third);

		out.println(first);
		out.println(second);
		out.println(third);

		// Add the assertions for both call and return at the same line
		out.println("\tassert {:sourcefile \"" + inputAvpFile + "\"} {:sourceline " + (lineNum + 4)
				+ "} {:print \"Call \\\"Stub\\\" \\\"Stub\\\"\"} true;");
		out.println("\tassert {:sourcefile \"" + inputAvpFile + "\"} {:sourceline " + (lineNum + 4)
				+ "} {:print \"Return\"} true;");

		return;
	}

	public static void main(String[] args) {
		new Transform().run();
		return;
	}

}