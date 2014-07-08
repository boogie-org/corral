//Example with a nested dereference

const NULL: int;

var b: int;
var arr: [int]int;
var field: [int]int;


procedure Foo(a:int) returns (s:int) {
   var x:int;    

   assert (a != NULL);
   x := field[a];

   assert (x != NULL);
   x := field[x]; 
}



procedure stub_ptr(a:int) returns (r:int);

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
