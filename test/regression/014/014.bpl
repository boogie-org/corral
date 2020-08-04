// EQR type reachability

var pending: int;
var x: int;
procedure corral_atomic_begin();
procedure corral_atomic_end();

procedure foo() 
{
  call corral_atomic_begin();

  assume x == 2;
  x := 3;

  pending := pending - 1;
}

procedure bar() 
{
  call corral_atomic_begin();

  assume x == 1;
  x := 2;

  pending := pending - 1;
}

procedure main() {

  pending := 0;
  x := 1;

  call corral_atomic_begin();

  pending := pending + 1;
  async call foo();

  pending := pending + 1;
  async call bar();

  call corral_atomic_end();

  assume pending == 0;
  assume x == 3;
  assert false;
}

