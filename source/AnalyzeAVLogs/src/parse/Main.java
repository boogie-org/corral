package parse;

/**
 * Convenience class which invokes other methods in the package.
 * 
 * @author t-srg
 *
 */

public class Main {

	public static void main(String[] args) {

		new CheckBugs().run();

		new ValidateLogs().run();

		new GenerateStats().run();

		new FindMissingStubs().run();

		return;
	}

}