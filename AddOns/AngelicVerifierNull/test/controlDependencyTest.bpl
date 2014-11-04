var g1:int;
var g2:int;


procedure A(x:int) returns (r:int)
{
  var a:int, b:int, c:int, d:int;
 
  a := b; //some node after start node   

  if (x == 1) {
     a := a + 1;
  } else {
     if (x == 2) {
        b := b + 2;	
        r := 2;
     } 
     call c := B(x);
  }
 c := b; //needed, otherwise optimization returns insie if-then-else
 if (x == 3) {
    d := 1;
 }

}

procedure B(x:int) returns (r:int)
{
   g1 := x; 
}

procedure {:allocator "full"} malloc_full(a: int) returns (b: int);
const {:allocated} NULL: int;

axiom NULL == 0;
procedure {:allocator} malloc(a:int) returns (b:int);