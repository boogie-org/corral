using System;
using System.Diagnostics.Contracts;

class IntContainer {
    public int val;
    public IntContainer(int i) {
        val = i;
    }
}

class PoirotMain {
  public static void Main() {
      var ic = new IntContainer(3);
      F(ic);
      F(null);
  }

  public static void F(IntContainer x) {
    IntContainer ic;
    ic = x ?? new IntContainer(4);
    // ic = x != null ? x : new IntContainer(4);
    Contract.Assert(ic != null);
    Contract.Assert(x == null ? ic.val == 4 : ic.val == x.val);
  }
}
