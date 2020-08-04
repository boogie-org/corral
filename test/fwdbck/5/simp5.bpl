// simplified bpl version of CAV12

var srcs: int;

procedure C_constr()
{
}

procedure A_constr()
{
  call C_constr();
}

procedure A_param_constr()
{
  call C_constr();
  call init();
}

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

procedure makeBound()
{
}

procedure M_constr()
{
  call A_constr();
  srcs := 0;
  call makeList();
  call makeBound();
  call init();
}

procedure foo()
{
  call M_constr();
}

procedure {:entrypoint} main() 
{
   srcs := 0;
   call foo();
}
