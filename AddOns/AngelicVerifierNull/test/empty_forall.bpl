const NULL: int;

var b: int;
var arr: [int]int;

procedure Foo(a:int) returns (s:int) {
   assert (arr[42] != NULL);    

}



procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
