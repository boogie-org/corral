using System;
using System.Diagnostics.Contracts;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

class PoirotMain {
  public static void Main() {
    List<int> ls = new List<int>();
    ls.Add(1);
    ls.Add(0);
    int sum1 = ls.Sum(x => x);
    Contract.Assert(sum1 == 1);

    ls.Add(1);
    int sum2 = ls.Sum(x => x);
    Contract.Assert(sum1 < sum2);
  }
}
