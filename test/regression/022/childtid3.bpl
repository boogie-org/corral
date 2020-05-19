var x: int;

// Check that program with only ChildThreadId
// also works fine
procedure corral_getChildThreadID() returns (tid:bv32);

procedure {:entrypoint} main()
{
  var ctid: bv32;

  async call foo();
  call ctid := corral_getChildThreadID();

  assert false;
}

procedure foo()
{
  x := 2;
}

   

