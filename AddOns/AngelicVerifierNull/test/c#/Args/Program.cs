using System.Diagnostics.Contracts;


class Test {

  public static void Main(string[] args) {
      Contract.Assert(args[0] != null);
      Contract.Assert(args[0] == "");
  }
}
