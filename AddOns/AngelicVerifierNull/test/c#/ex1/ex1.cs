using System.Diagnostics.Contracts;

class cMain {
    static int s;
    static int r;

  public void DoWork() {
    int t;
    t = s;
    t++;
    s = t;
    r = t + s + r;
  }

  public static void Main() {
    s = 0;
    r = 0;
    cMain e1 = new cMain();
    cMain e2 = new cMain();
    e1.DoWork();
    e2.DoWork();
    Contract.Assert(s == 3);
    Contract.Assert(r == 6);
  }
}