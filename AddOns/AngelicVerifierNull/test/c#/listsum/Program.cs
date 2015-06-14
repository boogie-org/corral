using System;
using System.Diagnostics.Contracts;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

class IntContainer {
    public int val;
    public IntContainer(int i) {
        val = i;
    }
}

class PoirotMain {
  public static void Main() {
    List<IntContainer> ls = new List<IntContainer>();
    ls.Add(new IntContainer(0));
    ls.Add(new IntContainer(1));
    int sum1 = ls.Sum(x => x.val);
    Contract.Assert(sum1 == 1);

    ls.Add(new IntContainer(1));
    int sum2 = ls.Sum(x => x.val);
    Contract.Assert(sum1 < sum2);
  }
}
