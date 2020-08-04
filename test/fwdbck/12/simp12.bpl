// loop

var x : int;

procedure fail()
{
  if (x==2)
  {
    assert false;
  }
}

procedure {:entrypoint} main()
{
  x := 0;
  while (x!=2)
  {
    x := x + 1;
    call fail();
  }
}

