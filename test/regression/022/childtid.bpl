var x: int;
var stopped: [int]bool;
  
procedure corral_getChildThreadID() returns (tid:int);
procedure corral_getThreadID() returns (tid:int);

procedure {:entrypoint} main()
{
  var ctid1, ctid2: int;

  x := 1;

  stopped[ctid1] := false;

  async call foo();
  call ctid2 := corral_getChildThreadID();
  assume ctid1 == ctid2;

  assume stopped[ctid1];

  assert x == 2;
}

procedure foo()
{
  var tid: int;
  call tid := corral_getThreadID();
  x := 2;
  stopped[tid] := true;
}

   
