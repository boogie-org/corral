var l: int;

var x: int;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (x: int);



procedure corral_yield(x: bool);



function CHThreadId() : int;

function {:existential true} Assert() : bool;

procedure {:entrypoint} main();



implementation {:entrypoint} main()
{
  var val: int;

  anon0:
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
  ensures l == CHThreadId() && l != 0;



implementation acquire()
{

  anon0:
    yield;
    call corral_atomic_begin();
    yield;
    assume l == 0;
    yield;
    call l := corral_getThreadID();
    call corral_atomic_end();
    return;
}



procedure release();
  requires l == CHThreadId() && l != 0;



implementation release()
{

  anon0:
    call corral_yield(l == CHThreadId() && l != 0);
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
    return;
}



procedure foo(val: int);



implementation foo(val: int)
{

  anon0:
    call acquire();
    call corral_yield(l == CHThreadId() && l != 0);
    x := val;
    call corral_yield(l == CHThreadId() && l != 0 && x == val);
    call release();
    return;
}


