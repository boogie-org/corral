var l: int;

var x: int;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (x: int);



procedure corral_yield(x: bool);



function CHThreadId() : int;

function {:existential true} {:absdomain "PredicateAbs"} Inv1(x: bool, x2: bool) : bool;

function {:existential true} {:absdomain "PredicateAbs"} Inv2(x: bool, x2: bool) : bool;

function {:existential true} {:absdomain "PredicateAbs"} Inv3(x: bool, x2: bool) : bool;

function {:existential true} {:absdomain "PredicateAbs"} Inv4(x: bool, x2: bool) : bool;

function {:existential true} {:absdomain "PredicateAbs"} Inv5(x: bool, x2: bool, x3: bool) : bool;

procedure {:thread_entry} {:thread_num "main"} {:original_proc_name "main"} {:yields} {:entrypoint} main();
  modifies l, x;



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
    async call corralThread0foo(val);
    goto anon2_LoopHead;

  anon2_LoopDone:
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "acquire"} {:yields} corralThread0acquire();
  modifies l;
  ensures Inv1(l == CHThreadId(), l == 0);



implementation corralThread0acquire()
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



procedure {:thread_num "foo"} {:original_proc_name "release"} {:yields} corralThread0release();
  requires Inv2(l == CHThreadId(), l == 0);
  modifies l;



implementation corralThread0release()
{

  anon0:
    call corral_yield(Inv3(l == CHThreadId(), l == 0));
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
    return;
}



procedure {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} {:yields} corralThread0foo(val: int);
  modifies l, x;



implementation corralThread0foo(val: int)
{

  anon0:
    call corralThread0acquire();
    call corral_yield(Inv4(l == CHThreadId(), l == 0));
    x := val;
    call corral_yield(Inv5(l == CHThreadId(), l == 0, x == val));
    call corralThread0release();
    return;
}


