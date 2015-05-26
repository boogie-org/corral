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

//This Foo has structured if (compared to t5.bpl)
//Crashes ExplainError
procedure Foo (a:int) returns (s:int) {
   
   var c: int;
   var d: bool;
 
   call d := stub_bool(a);
   call c := stub_ptr(a);
   if (d) {
      assert c != NULL;
   } 
   
}


procedure stub_ptr(a:int) returns (r:int){
	call r := unknown(1) ;
}

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (x:bool);

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
