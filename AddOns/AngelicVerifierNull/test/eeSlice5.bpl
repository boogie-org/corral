//example to test EE's control based slicing
//control-flow based slicing

var g1:int;
var g2:int;


procedure A(x:int,y:int,z:int) returns (r:int)
{
  var a:int, b:int;

  b := y ; 

  if(z == 55) {    //z is irrelevant since a's mod does not affect after merge
     a := b + 1;
  }

  a := b;
  assert a == 1; //we don't block this as default filter does not contain x == c
}


procedure {:allocator "full"} malloc_full(a: int) returns (b: int);
const {:allocated} NULL: int;

axiom NULL == 0;
procedure {:allocator} malloc(a:int) returns (b:int);