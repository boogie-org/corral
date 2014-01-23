// loop

var x : int;

procedure fail()
{
  assert (x < 2);
}

procedure rec (y : int)
{
  x := x + 1;
  if (y == 0)
  {
    return;
  }
  call rec (y-1);
}

procedure {:entrypoint} main();

implementation {:entrypoint} main()
{
  x := 0;
  call rec (2);
  call fail();
}

