var x: int;
var y: int;

procedure baz()
modifies y;
{
  y := y + 1;
}

procedure foo2()
modifies x;
{
  x := x + 1;
}

procedure foo3()
modifies y;
{
  y := y + 1;
}

procedure foo1()
modifies x;
{
  var d: bool;
  x := x + 2;
  if (d) {
      call foo2();
  } else {
      call foo3();
  }  
}

procedure bar1()
modifies x;
{
  var e: bool;
  x := x + 1;
  if (e) {
      call foo2();
  } else {
      call foo3();
  }   
}

procedure {:entrypoint} main()
modifies x, y;
{
  var c: bool;
  x := 1;
  if (c) {
      call baz();
  } else {
      call bar1();
  }
  call foo1();
  assert x > 0;
}