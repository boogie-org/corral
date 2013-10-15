procedure corral_yield(x: bool);



var x: int;

procedure {:entrypoint} mainE();



implementation {:entrypoint} mainE()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    assume x == 0;
    assume Inv1(x == 0);
    yield;
    assume Inv1(x == 0);
    call bar();
    assume Inv1(x == 0);
    yield;
    assume Inv1(x == 0);
    async call foo();
    return;
}



procedure foo();



implementation foo()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    assume Inv2(x == 0);
    assume Inv2(x == 0);
    yield;
    assume Inv2(x == 0);
    call baz();
    assume Inv2(x == 0);
    yield;
    assume Inv2(x == 0);
    x := x + 1;
    assume Inv3(x == 1);
    yield;
    assume Inv3(x == 1);
    return;
}



procedure bar();



implementation bar()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    assume x == x;
    return;
}



procedure baz();



implementation baz()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    assume x == x;
    return;
}



function {:existential true} {:inline} Inv1(a: bool) : bool
{
  a
}

function {:existential true} {:inline} Inv2(a: bool) : bool
{
  a
}

function {:existential true} {:inline} Inv3(a: bool) : bool
{
  a
}

procedure corral_getThreadID() returns (tid: int);


