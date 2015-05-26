//example to test EE's control based slicing

var g1:int;
var g2:int;

procedure {:entrypoint} Main() {
  var a: int ;
  var r: int ;
  call g1 := unknown(1) ;
  call g2 := unknown(1) ;
  if (*) {
    call a := unknown(1) ;
    call r := A(a) ;
  }
  if (*) {
    call a := unknown(1) ;
    call r := B(a) ;
  }
}

procedure A(x:int) returns (r:int)
{
  var a:int, b:int, c:int, d:int;
 
  a := x; //some node after start node   
  b := 1; 

  if (a == 1) { //relevant
     b := 0;
  } else { 
     if (a == 2) { //irrelevant branch
       c := 1; 
     } else {
       call d := B(a); 
     } 
  }
 if (a == 3) { //irrelevant
    d := 1;
 }
 assert b == 1;
}

procedure B(x:int) returns (r:int)
{
   if (x == 1) { //irrelevant
      g1 := x; 
   }
   r := g1;
   return; 
}

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
const {:allocated} NULL: int;
axiom NULL == 0;
