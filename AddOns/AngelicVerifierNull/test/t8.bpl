//Example to block pointers from stubs

const NULL: int;

var b: int;
var arr: [int]int;

procedure Foo_ShowBug(a:int, c:bool) returns (s:int) {

  var r: int;
  r := NULL;

  call r := stub_ptr(a);	
  if (c) {
     assert a != NULL;
     arr[r] := NULL; //should show this warning
  } 

  call Bar(arr[r]); //nested
  s := r;
}

procedure Foo(a:int, c:bool) returns (s:int) {

  var r: int;
  r := NULL;

  call r := stub_ptr(a);	
  if (c) {
     assert a != NULL;
     //arr[r] := NULL;
  } 

  call Baz(arr[r]); //calling Baz since Bar will be suppressed
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
