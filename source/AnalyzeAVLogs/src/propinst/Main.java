package propinst;

/**
 * Convenience class which performs program transformation and parsing AVP file.
 * Run this every time checkirql.avp file is changed.
 * 
 * @author t-srg
 *
 */

public class Main {

	public static void main(String[] args) {
		new Transform().run();
		new ParseStubs().run();
		return;
	}

}