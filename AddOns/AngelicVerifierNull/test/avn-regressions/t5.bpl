const NULL: int;

var b: int;
var arr: [int]int;

//no structured if wiht stub_bool
//see structured counterpart that crashes t6.bpl
procedure Foo(a:int) returns (s:int) {
   
   var c: int;
   var d: bool;
 
   call d := stub_bool(a);
   call c := stub_ptr(a);
   goto A,B;
A:
      assert c != NULL; assume false;
B: assume false;
}



procedure stub_ptr(a:int) returns (r:int);

procedure stub_noptr(a:int);

procedure stub_bool(a:int) returns (b:bool);

procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
