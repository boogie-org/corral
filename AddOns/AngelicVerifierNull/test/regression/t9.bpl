const {:allocated} NULL: int;
axiom NULL == 0;

procedure {:entrypoint} foo({:pointer} a: int);

procedure {:entrypoint} Main() {
  var a: int ;
  if (*) {
    call a := unknown(1) ;
    call foo(a) ;
  }
}

implementation foo(a: int)
{
  var x: int;
  var y: int;

  y := 1;
  x := a;

  // fool alias analysis
  if(y == 0) { x := NULL; }

  assert x != NULL;
}

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);

