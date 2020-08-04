package parse;

import java.io.BufferedReader;
import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.TreeSet;

/**
 * Input:<br>
 * 1. List of modules on which SMV has completed the analysis<br>
 * 2. Current version of "checkirql-razzle.avp" which contains stubs for
 * procedures<br>
 * 
 * Output:<br>
 * 1. Procedures for which stubs are missing<br>
 * 2. A template implementation for procedures which do not have stubs<br>
 * 
 * @author t-srg
 *
 */

public class FindMissingStubs extends util.Utilities {

	private String sigForProcsWithStubsFile, outputFile;
	private int noFileWarningsCount = 0, matchPtrsWarningsCount = 0;

	public FindMissingStubs() {

		sigForProcsWithStubsFile = inputDir + getProperty("procsWithStubsFileName");
		outputFile = outputDir + getProperty("missingStubsCSVFileName");

		return;
	}

	protected void run() {

		readModules();

		readProcsWithStubs();

		PrintWriter out = getFileWriter(outputFile);

		out.println("num,module,# missing stubs");

		int num = 1;
		for (String module : modules) {
			System.out.println("\nProcessing module " + num + " " + module);

			processModule(module, num, out);

			num++;
		}

		out.close();

		System.out.println("\nTotal test.bpl not found warnings: " + noFileWarningsCount);
		System.out.println("Total MatchPtrs warnings: " + matchPtrsWarningsCount);
		System.out.println("\nCompleted");

		return;
	}

	HashSet<String> procsWithStubs = new HashSet<String>();
	HashSet<String> sigForProcsWithStubs = new HashSet<String>();

	private void readProcsWithStubs() {

		BufferedReader in = getFileReader(sigForProcsWithStubsFile);

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() == 0)
				continue;

			boolean changed = sigForProcsWithStubs.add(line);

			if (changed == false)
				throw new RuntimeException("Duplicate signature found " + line);

			String[] tokens = line.split("\\(", 2);

			String[] procTokens = tokens[0].split(" ");
			String procedure = procTokens[procTokens.length - 1];

			procsWithStubs.add(procedure);
		}

		closeFileReader(in);

		return;
	}

	final String smvDirPath = "smv";

	private void processModule(String module, int num, PrintWriter csvWriter) {

		File smvDir = new File(sdxroot + module + "\\" + smvDirPath);

		if (smvDir.exists() == false || smvDir.isDirectory() == false) {
			System.out.println("Warning: SMV folder doesn't exist for " + module);
			return;
		}

		parseBPL(module, num, csvWriter);

		return;
	}

	final String testBPLPath = smvDirPath + "\\build\\test.bpl";

	final String procsWithoutImplsFile = "procsWithoutImpls.txt";
	final String proceduresExcludedFile = "procedures-excluded.txt";
	final String proceduresNewFile = "procedures-new.txt";
	final String implementationsNewFile = "implementations-new.txt";
	final String implementationsNewMatchPtrsFile = "implementations-new-MatchPtrs.txt";

	private void parseBPL(String module, int num, PrintWriter csvWriter) {

		String bplFilePath = sdxroot + module + "\\" + testBPLPath;
		if (new File(bplFilePath).exists() == false) {
			System.out.println("Warning: test.bpl file doesn't exist for " + module);
			noFileWarningsCount++;
			return;
		}

		TreeMap<String, String> procedures = findProcedures(bplFilePath, num);
		TreeSet<String> implementations = findImplementation(bplFilePath, num);

		for (String implementation : implementations) {
			if (procsWithStubs.contains(implementation))
				System.out.println("Warning: Trying to replace implementation when already present " + implementation);
		}

		String procsWithoutImplsFilePath = outputDir + num + "\\" + procsWithoutImplsFile;
		String proceduresExcludedFilePath = outputDir + num + "\\" + proceduresExcludedFile;
		String proceduresNewFilePath = outputDir + num + "\\" + proceduresNewFile;
		String implementationsNewFilePath = outputDir + num + "\\" + implementationsNewFile;
		String implementationsNewMatchPtrsFilePath = outputDir + num + "\\" + implementationsNewMatchPtrsFile;

		PrintWriter procsWithoutImplsWriter = getFileWriter(procsWithoutImplsFilePath);
		PrintWriter proceduresExcludedWriter = getFileWriter(proceduresExcludedFilePath);
		PrintWriter proceduresNewWriter = getFileWriter(proceduresNewFilePath);
		PrintWriter implementationsNewWriter = getFileWriter(implementationsNewFilePath);
		PrintWriter implementationsNewMatchPtrsWriter = getFileWriter(implementationsNewMatchPtrsFilePath);

		HashSet<String> proceduresNew = new HashSet<String>();
		HashSet<String> proceduresNewWithMatchPtrs = new HashSet<String>();

		int newImplementations = 0;

		for (Entry<String, String> entry : procedures.entrySet()) {
			String procedure = entry.getKey();
			String signature = entry.getValue();

			if (implementations.contains(procedure) == false) {

				procsWithoutImplsWriter.println(procedure);

				if (isValidProcedure(procedure, signature)) {

					proceduresNew.add(procedure);
					proceduresNewWriter.println(procedure);

					PrintWriter writer = implementationsNewWriter;

					if (requiresMatchPtrs(procedure, signature)) {
						writer = implementationsNewMatchPtrsWriter;

						writer.println("// {:#MatchPtrs} required?");

						proceduresNewWithMatchPtrs.add(procedure);
					} else
						newImplementations++;

					writer.println("ProcedureRule");
					writer.println("{");
					writer.println("\tprocedure {:#ReplaceImplementation} " + signature);
					writer.println("}");
					writer.println("-->");
					writer.println("{");
					writer.println("\t// TODO");
					writer.println("\treturn;");
					writer.println("}");
					writer.println();

				} else
					proceduresExcludedWriter.println(procedure);
			}
		}

		System.out.println("New implementations: " + newImplementations);

		csvWriter.println(num + "," + module + "," + newImplementations);

		procsWithoutImplsWriter.close();
		proceduresExcludedWriter.close();
		proceduresNewWriter.close();
		implementationsNewWriter.close();
		implementationsNewMatchPtrsWriter.close();

		writeUpdatedProcsWithStubs(num, proceduresNew, proceduresNewWithMatchPtrs);

		return;
	}

	final String proceduresFile = "procedures.txt";
	final String signaturesFile = "signatures.txt";

	private TreeMap<String, String> findProcedures(String bplFilePath, int num) {

		TreeMap<String, String> proceduresMap = new TreeMap<String, String>();

		String proceduresFilePath = outputDir + num + "\\" + proceduresFile;
		String signaturesFilePath = outputDir + num + "\\" + signaturesFile;

		new File(proceduresFilePath).getParentFile().mkdirs();
		new File(signaturesFilePath).getParentFile().mkdirs();

		PrintWriter procedureWriter = getFileWriter(proceduresFilePath);
		PrintWriter signatureWriter = getFileWriter(signaturesFilePath);

		BufferedReader in = getFileReader(bplFilePath);

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() != 0) {

				if (line.startsWith("procedure") == false)
					continue;

				String[] tokens = line.split("\\(", 2);

				String[] procTokens = tokens[0].split(" ");
				String procedure = procTokens[procTokens.length - 1];

				String signature = procedure + "(" + tokens[1];

				String oldValue = proceduresMap.put(procedure, signature);

				if (oldValue != null)
					throw new RuntimeException("Duplicate procedure found " + procedure);

				procedureWriter.println(procedure);
				signatureWriter.println(signature);
			}
		}

		closeFileReader(in);

		procedureWriter.close();
		signatureWriter.close();

		return proceduresMap;
	}

	final String implementationsFile = "implementations.txt";

	private TreeSet<String> findImplementation(String bplFilePath, int num) {

		TreeSet<String> implementations = new TreeSet<String>();

		String implementationsFilePath = outputDir + num + "\\" + implementationsFile;

		PrintWriter writer = getFileWriter(implementationsFilePath);
		BufferedReader in = getFileReader(bplFilePath);

		String line = null;
		while ((line = readNextLine(in)) != null) {
			if (line.length() != 0) {

				if (line.startsWith("implementation") == false)
					continue;

				String[] tokens = line.split("\\(", 2)[0].split(" ");
				String implementation = tokens[tokens.length - 1];

				boolean changed = implementations.add(implementation);

				if (changed == false)
					throw new RuntimeException("Duplicate implementation found " + implementation);

				writer.println(line);
			}
		}

		closeFileReader(in);

		writer.close();

		return implementations;
	}

	private boolean isValidProcedure(String procedure, String signature) {

		if (procedure.startsWith("sdv_angelic_indirectcall_stub_"))
			return false;

		if (procedure.startsWith("sdv_hash"))
			return false;

		if (procsWithStubs.contains(procedure) == false) {
			if (sigForProcsWithStubs.contains(signature))
				throw new RuntimeException("Signature matches while procedure name is different " + procedure);

			return true;
		} else {
			if (requiresMatchPtrs(procedure, signature)) {
				System.out.println("Warning: Procedure with multiple signature " + signature);
				matchPtrsWarningsCount++;
				return true;
			}
			return false;
		}
	}

	final HashSet<String> proceduresWithMatchPtrs = new HashSet<String>(
			Arrays.asList("IoAcquireCancelSpinLock", "KeWaitForSingleObject"));

	private boolean requiresMatchPtrs(String procedure, String signature) {

		if (procsWithStubs.contains(procedure) && sigForProcsWithStubs.contains(signature) == false) {
			if (proceduresWithMatchPtrs.contains(procedure))
				return true;
		}

		return false;
	}

	final String proceduresUpdatedFile = "procedures-updated.txt";

	private void writeUpdatedProcsWithStubs(int num, HashSet<String> proceduresNew,
			HashSet<String> proceduresNewWithMatchPtrs) {

		TreeSet<String> allProcedures = new TreeSet<String>();

		for (String proc : procsWithStubs)
			allProcedures.add(proc);

		for (String proc : proceduresNew)
			allProcedures.add(proc);

		String proceduresUpdatedFilePath = outputDir + num + "\\" + proceduresUpdatedFile;

		PrintWriter proceduresUpdatedFileWriter = getFileWriter(proceduresUpdatedFilePath);

		for (String proc : allProcedures) {
			if (proceduresNewWithMatchPtrs.contains(proc))
				proceduresUpdatedFileWriter.println("\t\t" + proc);
			else if (proceduresNew.contains(proc))
				proceduresUpdatedFileWriter.println("\t" + proc);
			else
				proceduresUpdatedFileWriter.println(proc);
		}

		proceduresUpdatedFileWriter.close();

		return;
	}

	public static void main(String[] args) {
		new FindMissingStubs().run();
		return;
	}

}