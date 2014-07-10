const NULL: int;

var b: int;
var arr: [int]int;

procedure Foo(a:int) returns (s:int) {

  var r: int;
  var c: bool;
  r := NULL;
  
//  call c := stub_bool(a); //crashes with a structured if and stub

  if (c) {
     call Bar(r);
    call r := stub_ptr(b);	
  } else {
     r := b;
     call Bar(r);
     call stub_noptr(r);
  }
  call Baz(b);  

  assert true; //shouldn't instrument this 
  s := r;
}

procedure Bar(a:int) {
  assert(a != NULL);
  arr[a] := 1;
}

procedure Baz(a:int) {
  assert (a != NULL);
  arr[a] := 2;
}

procedure stub_ptr(a:int) returns (r:int);

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
