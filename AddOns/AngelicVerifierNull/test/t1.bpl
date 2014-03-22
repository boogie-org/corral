const NULL: int;

var b: int;
var arr: [int]int;

procedure Foo(a:int) {

  var r: int;
  r := NULL;
  if (a == 0) {
     call Bar(r);
  } else {
     r := b;
     call Bar(r);
  }
  call Baz(b);  
}

procedure Bar(a:int) {
  assert(a != NULL);
  arr[a] := 1;
}

procedure Baz(a:int) {
  assert (a != NULL);
  arr[a] := 2;
}