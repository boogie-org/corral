//generalize from v1 given field

const NULL: int;

var v1: [int]int;
var b: [int]int;


var g1: int;
var {:scalar} g2: int;
var g3: int;
var {:scalar} g4: int;
var g5: int;


axiom (NULL == 0);

procedure {:entrypoint} Main() {
  var v1: int ;
  var r: int ;
  call g1 := unknown(1) ;
  call g2 := unknown(1) ;
  call g3 := unknown(1) ;
  call g4 := unknown(1) ;
  call g5 := unknown(1) ;
  if (*) {
    call v1 := unknown(1) ;
    call r := Foo(v1) ;
  }
}

procedure Foo(c:int) returns (d:int) {

   assert (b[g1+1] != NULL);
   assert (b[g1+2] != NULL);

   assert (b[g1] != NULL);
   assert (b[g2] != NULL);
   assert (b[g3] != NULL);
   assert (b[g4] != NULL);

}

procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
