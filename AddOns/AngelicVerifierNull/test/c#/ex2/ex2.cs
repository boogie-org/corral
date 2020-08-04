using System;
using System.Diagnostics.Contracts;

class exec
{
	public int execute(Func<int,int> f, int x) {
		return f(x) ;
	}
}

class cMain {
	public static void Main() {
		int s = 0 ;
		exec e1 = new exec();
		s = e1.execute((x => 2*x), 3);
		Contract.Assert(s == 5);
	}
}

