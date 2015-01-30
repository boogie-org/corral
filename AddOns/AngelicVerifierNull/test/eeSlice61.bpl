//example to test EE's control based slicing
//control-flow based slicing

var g1:int;
var g2:int;


procedure A(x:int,y:int,z:int) returns (r:int)
{
  var a:int, b:int, c:int;

  b := y ; 

  if(z == 55) {    //z is relevant
     if (x == 44) { //x is irrelevant
        a := b + 1;	
     }
     c := b;
  }

  a := c;
  b := 5;
  assert a == 1; //we don't block this as default filter does not contain x == c
}


procedure {:allocator "full"} malloc_full(a: int) returns (b: int);
const {:allocated} NULL: int;

axiom NULL == 0;
procedure {:allocator} malloc(a:int) returns (b:int);