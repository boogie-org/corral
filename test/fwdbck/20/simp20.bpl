// recursion with multiple indirect calls to assert in the loop 

var x : int;

procedure check ()
{
  assert (x < 2);
}

procedure for (y : int)
{
  x := x + 1;
  if (y == 0)
  {
    call check ();
  }
  else
  {
    call for (y-1);
  }
}

procedure {:entrypoint} main();

implementation {:entrypoint} main()
{
  x := 0;
  call for (2);
}

