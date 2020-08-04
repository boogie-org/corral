const NULL: int;

axiom NULL == 0;

var b: int;
var arr: [int]int;

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


procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
