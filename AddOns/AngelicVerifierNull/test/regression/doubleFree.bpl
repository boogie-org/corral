procedure {:entrypoint} main() {
 var p : int;
 call p := unknown();
 //assume(~valid[p]);
 call foo(p);
}

procedure foo(p: int)
{
  assert ~valid[p];
  call ~free(p);
  assert ~valid[p];
  call ~free(p);
  return;
}


//procedure {:~free} ~free(a: int);
// modifies ~valid;
// free ensures ~valid == old(~valid)[a := false];

procedure {:~free} ~free(a: int) {
 ~valid[a] := false;
}

var ~valid: [int]bool;

const {:allocated} NULL : int;

procedure {:AngelicUnknown} unknown() returns (res : int);
