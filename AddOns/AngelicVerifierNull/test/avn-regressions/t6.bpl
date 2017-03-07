const NULL: int;

var b: int;
var arr: [int]int;

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


procedure stub_ptr(a:int) returns (r:int);

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (x:bool);

procedure {:allocator} malloc(a:int) returns (x:int);
procedure {:allocator "full"} malloc_full(a:int) returns (x:int);
