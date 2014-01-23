// simplified bpl version of CAV12 with emphasis on backtracking

var lstsNotNull : int;

procedure init (lsts : int, private_lsts : int)
{
  assert (lstsNotNull == 1);
}

procedure A_const(lsts : int)
{
  var private_lsts : int;
  call init(lsts, private_lsts);
}

procedure useless()
{
}

procedure T_const(lsts : int)
{
  var private_lsts : int;
  call useless();
  call init(lsts, private_lsts);
}

procedure makeList(lst : int) returns (ret : int)
{
  ret := 1;
}

procedure makeBound(lst : int)
{
}

procedure M_const (lst : int)
{
  var lsts : int;
  lstsNotNull := 0;
  lsts := 0;
  call lstsNotNull := makeList(lst);
  call makeBound(lst);
  call A_const(lsts);
}

procedure foo (lst : int)
{
  var lstsT : int;
  call M_const(lst);
  lstsNotNull := 1;
  call T_const(lstsT);
}

procedure {:entrypoint} main();

implementation {:entrypoint} main()
{
  var lst : int;
  lst := 0;
  call foo(lst);
}

