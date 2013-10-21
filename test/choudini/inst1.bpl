
var x: int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (x:int);
function CHThreadId() returns (x:int);


procedure {:entrypoint} main()
{
  assume x == 0;

  async call foo();

  yield;
  x := x + 1;
  assert x >= 0;

}

procedure foo() 
{
    yield;
    x := x + 1;
}

function {:template} {:existential true} {:absdomain "IA[ConstantProp]"} f(a:bool): bool;

procedure {:template} inst();
  requires f(x >= 0);
  ensures f(x >= 0);
  ensures {:yields} f(x >= 0);
