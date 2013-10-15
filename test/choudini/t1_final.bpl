var l: int;

var x: int;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (x: int);



procedure corral_yield(x: bool);



function CHThreadId() : int;

procedure {:entrypoint} main();



implementation {:entrypoint} main()
{
  var val: int;
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    havoc val;
    yield;
    async call foo(val);
    goto anon2_LoopHead;

  anon2_LoopDone:
    return;
}



procedure acquire();



implementation acquire()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    yield;
    call corral_atomic_begin();
    yield;
    assume l == 0;
    yield;
    call l := corral_getThreadID();
    call corral_atomic_end();
    assume l == $local_tid_tt && l != 0;
    return;
}



procedure release();



implementation release()
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    assume l == $local_tid_tt && l != 0;
    assume l == $local_tid_tt && l != 0;
    yield;
    assume l == $local_tid_tt && l != 0;
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
    return;
}



procedure foo(val: int);



implementation foo(val: int)
{
  var $local_tid_tt: int;

  anon0:
    call $local_tid_tt := corral_getThreadID();
    call acquire();
    assume l == $local_tid_tt && l != 0;
    yield;
    assume l == $local_tid_tt && l != 0;
    x := val;
    assume Assert() || (l == $local_tid_tt && l != 0 && x == val);
    yield;
    assume Assert() || (l == $local_tid_tt && l != 0 && x == val);
    call release();
    return;
}



function {:existential true} {:inline} Assert() : bool
{
  false
}
