function {:builtin "MapConst"} ch_mapconstbool(x: bool) : [int]bool;

var x: int;

procedure {:entrypoint} main({:linear "Perm"} permVar_in: [int]bool)
  free requires permVar_in == ch_mapconstbool(true);
{
  var {:linear "Perm"} permVar_out: [int] bool;

  permVar_out := permVar_in;
  yield;
  assert permVar_out != ch_mapconstbool(false);

  x := 0;


  async call foo();
}

procedure foo() {
  havoc x;
  yield;
}

