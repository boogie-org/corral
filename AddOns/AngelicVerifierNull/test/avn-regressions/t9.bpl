const {:allocated} NULL: int;
axiom NULL == 0;

procedure {:entrypoint} foo({:pointer} a: int);

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

procedure {:allocator "full"} malloc_full(s:int) returns (a:int);
procedure {:allocator}  malloc(s:int) returns (a:int);

