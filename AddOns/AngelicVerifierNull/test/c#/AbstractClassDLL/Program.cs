using System.Diagnostics.Contracts;

public class Int {
	public int val;
	Int() {
		val = 0;
	}
}

abstract class Test {

	public abstract string randStr();

	public void doStuff(Int x, int y) {
		if (x.val == 0) {
			string s = randStr();
			Contract.Assert(s != null);
			Contract.Assert(s != "null");
		}
		else {
			Contract.Assert(x.val >= 0);
		}
		Contract.Assert(y == 1);
	}
}
