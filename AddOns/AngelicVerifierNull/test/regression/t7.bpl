//Example with a nested dereference

const NULL: int;

var b: int;
var arr: [int]int;
var field: [int]int;

procedure {:entrypoint} Main() {
  var a: int ;
  var r: int ;
  call b := unknown(1) ;
  if (*) {
    call a := unknown(1) ;
    call r := Foo(a) ;
  }
}

procedure Foo(a:int) returns (s:int) {
   var x:int;    

   assert (a != NULL);
   x := field[a];

   assert (x != NULL);
   x := field[x]; 
}



procedure stub_ptr(a:int) returns (r:int){
	call r := unknown(1) ;
}

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
