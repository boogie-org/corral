using System;
using System.Threading;
using System.Diagnostics.Contracts;

class A {
  int f;
  public A() {
    f = 0;
    f = f + 1;
  }
}

class PoirotMain {

  public static void Main() {
    var a = new A();
    foo(a);
  }

  public static void foo(object x) {
    var a = x as A;
    Contract.Assert(a != null);
  }

}
