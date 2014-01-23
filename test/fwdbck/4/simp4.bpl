// basic example

var srcs: int;

procedure init()
{
  if (srcs != 1)
  {
    assert false;
  }
}

procedure {:entrypoint} M_constr()
{
  srcs := 1;
  call init();
}
