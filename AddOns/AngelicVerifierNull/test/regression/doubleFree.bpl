procedure {:entrypoint} main() {
 var p : int;
 call p := unknown();
 call foo(p);
}

procedure foo(p: int)
{
  assert valid[p];
  call freeingMethod(p);
  assert valid[p];
  call freeingMethod(p);
  return;
}

procedure freeingMethod(a: int) {
 valid[a] := false;
}

var {:propertyMap} valid: [int]bool;

const {:allocated} NULL : int;

procedure {:AngelicUnknown} unknown() returns (res : int);
