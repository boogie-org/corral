const NULL: int;

var b: int;
var arr: [int]int;

//This Foo has structured if but no stub_bool calls
procedure Foo (a:int) returns (s:int) {
   
   var c: int;
   var d: bool;
 
   call c := stub_ptr(a);
   if (d) {
      assert c != NULL;
   } 
   
}


procedure stub_ptr(a:int) returns (r:int);

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:allocator} malloc(a:int) returns (b:int);