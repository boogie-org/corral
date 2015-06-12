const NULL: int;

function Is(a: int, b: int) : int;

axiom (forall a: int, b: int :: { Is(a, b): int } Is(a, b): int == (if a==b then b else 0));

procedure {:entrypoint} Main() {
  var a: int ;
  var r: int ;
  if (*) {
    call a := unknown(1) ;
    call r := Foo(a) ;
  }
}

procedure Foo (a:int) returns (s:int) {
   
   var d: bool;
   var b: int ;
   b := a;
   if (d) {
      assert a != 0;
      assert Is(a,b) != 0;
   } 
   s := Is(a,b);
}


procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
