//example to test EE's control based slicing
//testing out params and intersection with supportPre

var g1:int;
var g2:int;


procedure A(x:int,y:int,z:int) returns (r:int)
{
  var a:int, b:int;

  b := y ; 

  call a := B(b); //modifies a, not in support of z 

  assert z == 1; //we don't block this as default filter does not contain x == c
}

procedure B(x:int) returns (r:int)
{
   if (x == NULL) { //irrelevant
      g1 := x; 
   }
   r := g1;
   return; 
}

procedure {:allocator "full"} malloc_full(a: int) returns (b: int);
const {:allocated} NULL: int;

axiom NULL == 0;
procedure {:allocator} malloc(a:int) returns (b:int);