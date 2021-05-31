// several calls to the same function from the same block

var x : int;

procedure fail()
{
  if (x==2)
  {
    assert false;
  }
  x := x+1;
}

procedure {:entrypoint} main()
{
  x := 0;
  call fail();
  call fail();
}

