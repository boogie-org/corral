const NULL: int;

axiom NULL == 0;

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
 
   if (a > 1) {
	   b := 0; //this blocks a real bug in the other branch!!
	   assert b != NULL;
	   arr[b] := 1;
   } else {
           b := NULL;
	   assert b != NULL;
	   arr[b] := 1;
   }

}

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
