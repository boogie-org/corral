package propinst;

import java.io.BufferedReader;
import java.util.HashSet;
import java.util.LinkedHashSet;

/**
 * Input: checkirql-razzle.avp
 * 
 * Output: File containing the signature of all the procedures in the AVP file.
 * This also includes procedures which do not contain stubs. Basically a list of
 * all the procedures which have been examined so far.
 * 
 * This is further used in parse.MissingStubs.java to create the list of
 * procedures which are missing stubs.
 * 
 * Run this file every time the AVP file has been changed.
 * 
 * @author t-srg
 *
 */

public class ParseStubs extends util.Utilities {

	private String avpFile, outputFile;

	private LinkedHashSet<String> signatures = new LinkedHashSet<String>();

	public ParseStubs() {

		avpFile = sdxroot + getProperty("avpHome") + getProperty("avpFileName");
		outputFile = outputDir + getProperty("procsWithStubsFileName");

		return;
	}

	protected void run() {

		parseProcedureSignatures();

		writeFile(signatures, outputFile);

		System.out.println();
		System.out.println("Completed");

		return;
	}

	private void parseProcedureSignatures() {

		BufferedReader in = getFileReader(avpFile);

		HashSet<String> procedures = new HashSet<String>();
		boolean changed;

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			if (line.startsWith("\tprocedure") || line.startsWith("// procedure")) {

				String procedure = getProcedureName(line);
				String signature = getProcedureSignature(line);

				changed = procedures.add(procedure);
				if (changed == false)
					System.out.println("Warning: Multiple stubs found for the procedure " + procedure);

				changed = signatures.add(signature);
				if (changed == false)
					throw new RuntimeException("Error: Multiple entries found for the procedure " + procedure);
			}
		}

		closeFileReader(in);

		return;
	}

	public static void main(String[] args) {
		new ParseStubs().run();
		return;
	}

}