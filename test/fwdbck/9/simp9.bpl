// checks different instantiations of a same function with different
// parameters 

procedure first()
{
  call fail(0);
}

procedure second()
{
  call fail(1);
}

procedure fail(x : int)
{
  if (x==1)
  {
    assert false;
  }
}

procedure {:entrypoint} main()
{
  call first();
  call second();
}

