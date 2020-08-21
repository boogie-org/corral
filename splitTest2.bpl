var x: int;

procedure foo1()
modifies x;
{
  x := x + 1;
}

procedure foo2()
modifies x;
{
  x := x + 1;
}

procedure foo3()
modifies x;
{
  x := x + 1;
}

procedure foo4()
modifies x;
{
  x := x + 1;
}

procedure bar1()
modifies x;
{
  x := x + 1;
  call foo1();
  call foo2();
}

procedure bar2()
modifies x;
{
  x := x + 1;
  call foo1();
  call foo2();
}

procedure {:entrypoint} main()
modifies x;
{
  var c: bool;
  x := 1;
  if (c) {
      call bar1();      
  } else {
      call bar2();
  }
  call foo3();
  call foo4();
  assert x > 0;
}