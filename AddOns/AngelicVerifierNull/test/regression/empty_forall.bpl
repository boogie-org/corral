const NULL: int;

var b: int;
var arr: [int]int;

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
   assert (arr[42] != NULL);    

}

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
