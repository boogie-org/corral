var x: bv32;
var stopped: [bv32]bool;
  
procedure corral_getChildThreadID() returns (tid:bv32);
procedure corral_getThreadID() returns (tid:bv32);

procedure {:entrypoint} main()
{
  var ctid1, ctid2: bv32;

  x := 1bv32;

  stopped[ctid1] := false;

  async call foo();
  call ctid2 := corral_getChildThreadID();
  assume ctid1 == ctid2;

  assume stopped[ctid1];

  assert x == 2bv32;
}

procedure foo()
{
  var tid: bv32;
  call tid := corral_getThreadID();
  x := 2bv32;
  stopped[tid] := true;
}

   

