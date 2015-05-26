//example to test EE's control based slicing
//testing out params and intersection with supportPre

var g1:int;
var g2:int;

procedure {:entrypoint} Main() {
  var a: int ;
  var b: int ;
  var c: int ;
  var r: int ;
  call g1 := unknown(1) ;
  call g2 := unknown(1) ;
  if (*) {
    call a := unknown(1) ;
    call b := unknown(1) ;
    call c := unknown(1) ;
    call r := A(a, b, c) ;
  }
  if (*) {
  	call a := unknown(1) ;
  	call r := B(a) ;
  }
}

procedure A(x:int,y:int,z:int) returns (r:int)
{
  var a:int, b:int;

  b := y ; 

  call a := B(b); //modifies a, so B is relevant

  assert a == 1; 
}

procedure B(x:int) returns (r:int)
{
   if (x == NULL) { //relevant
      g1 := x; 
   }
   r := g1;
   return; 
}

const {:allocated} NULL: int;
axiom NULL == 0;
procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
