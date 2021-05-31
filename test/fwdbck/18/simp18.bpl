// recursion with assert in the loop

var x : int;

procedure rec (y : int)
{
  x := x + 1;
  if (y == 0)
  {
    assert (x < 2);
  }
  else
  {
    call rec (y-1);
  }
}

procedure {:entrypoint} main();

implementation {:entrypoint} main()
{
  x := 0;
  call rec (2);
}

