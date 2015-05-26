//example to test EE's control based slicing
//control-flow based slicing

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
}

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


const {:allocated} NULL: int;
axiom NULL == 0;
procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
