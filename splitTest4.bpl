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
  var e: bool;
  x := x + 1;
  if (e) {
      call foo1();
  }
  call foo2();  
}

procedure {:entrypoint} main()
modifies x;
{
  var c: bool;
  var d: bool;

  x := 1;

  if (c) {
      call bar1();      
  }

  if (d) {
      call foo3();
  } else {
      call foo4();
  }  
  assert x > 1;
}