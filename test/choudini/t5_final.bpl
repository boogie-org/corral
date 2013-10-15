procedure corral_yield(x: bool);



var x: int;

procedure {:entrypoint} main();



implementation {:entrypoint} main()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    x := 0;
    assume Inv1(x == 0);
    yield;
    assume Inv1(x == 0);
    async call foo();
    x := 0;
    assume Inv2(x == 0);
    yield;
    assume Inv2(x == 0);
    async call bar();
    x := 0;
    assume Inv3(x == 0);
    yield;
    assume Inv3(x == 0);
    return;
}



procedure foo();



implementation foo()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    yield;
    x := 1;
    return;
}



procedure bar();



implementation bar()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    yield;
    x := 1;
    return;
}



function {:existential true} {:absdomain "ConstantProp"} {:inline} Inv1(a: bool) : bool
{
  a
}

function {:existential true} {:absdomain "ConstantProp"} {:inline} Inv2(a: bool) : bool
{
  true
}

function {:existential true} {:absdomain "ConstantProp"} {:inline} Inv3(a: bool) : bool
{
  true
}

procedure corral_getThreadID() returns (tid: int);


