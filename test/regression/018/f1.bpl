procedure foo(x: int) returns (y:int)
  free requires x >= 0;
  free ensures y >= 0;
{
  y := x - 1;
  assert y >= 0;
}

procedure bar(x: int) returns (y:int)
   free ensures y == x;
{
  y := x;
}

procedure {:entrypoint} main()
{
   var x: int;
   havoc x;
   assume x >= 0;
   call x := bar(x);
   call x := foo(x);
}
