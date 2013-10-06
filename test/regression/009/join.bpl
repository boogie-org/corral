var x: int;
var stopped: [int] bool;

procedure corral_atomic_begin();
procedure corral_atomic_end();

procedure foo(tid: int) 
modifies x;
{
  var t: int;
  x := 1;
  stopped[tid] := true;
}

procedure main() 
modifies x;
{
  var t: int;

   x := 0;

   stopped[t] := false;
   async call foo(t);
   assume stopped[t];

   assert(x == 1);
}
