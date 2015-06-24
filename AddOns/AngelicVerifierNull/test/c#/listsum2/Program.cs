using System;
using System.Diagnostics.Contracts;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

class PoirotMain {
  public static void Main() {
    List<int> ls = new List<int>();
    ls.Add(6);
    ls.Add(1);
    ls.Add(2);
    int sum = 0;
    int product = 1;
    foreach (int x in ls)
    {
        sum += x;
        product *= x;
    }
    Contract.Assert(sum != 9);
  }
}
