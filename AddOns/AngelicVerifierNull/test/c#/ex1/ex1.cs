using System.Diagnostics.Contracts;

class cMain {
  static int s;

  public void DoWork() {
    int t;
    t = s;
    t++;
    s = t;
  }

  public static void Main() {
    s = 0;
    cMain e1 = new cMain();
    cMain e2 = new cMain();
    e1.DoWork();
    e2.DoWork();
    Contract.Assert(s == 2);
  }
}