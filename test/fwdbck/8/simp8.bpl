// checks returned values and parameters passing

procedure change(a : int) returns (b : int)
{
  b := a + 1;
  return;
}

procedure check(c : int)
{
  if (c == 1)
  {
    assert false;
  }
}

procedure {:entrypoint} main()
{
  var a : int;
  call a := change(a);
  call check(a);
}
