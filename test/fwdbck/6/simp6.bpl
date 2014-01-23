// main part of simplified version of CAV12

var srcs: int;

procedure init()
{
  if (srcs == 0)
  {
    assert false;
  }
}

procedure makeList()
{
  srcs := 1;
}

procedure {:entrypoint} M_constr()
{
  srcs := 0;
  call makeList();
  call init();
}
