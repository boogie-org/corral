//Example to block pointers from stubs

const NULL: int;

var b: int;
var arr: [int]int;

procedure {:entrypoint} Main() {
  var a: int ;
  var v2: bool ;
  var r: int ;
  call b := unknown(1) ;
  if (*) {
    call a := unknown(1) ;
    call r := Foo_ShowBug(a,v2) ;
  }
  if (*) {
    call a := unknown(1) ;
    call r := Foo(a,v2) ;
  }
  if (*) {
    call a := unknown(1) ;
    call Bar(a) ;
  }
  if (*) {
    call a := unknown(1) ;
    call Baz(a) ;
  }
}

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

procedure stub_ptr(a:int) returns (r:int) {
  call r := unknown(1) ;
}

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
 