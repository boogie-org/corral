
var l: int;
var x: int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (x:int);
procedure corral_yield(x:bool);
function CHThreadId() returns (x:int);
function {:existential true} Assert(): bool;


procedure {:entrypoint} main()
{
    var val: int;

    while (*) 
    {
        havoc val;
        yield;
        async call foo(val);
    }
}

procedure acquire() 
  ensures l == CHThreadId() && l != 0;
{
    yield;
    call corral_atomic_begin();
    yield;
    assume l == 0;
    yield;
    call l := corral_getThreadID();
    call corral_atomic_end();
}

procedure release()
  requires l == CHThreadId() && l != 0;
{
    call corral_yield(l == CHThreadId() && l != 0);
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
}

procedure foo(val: int)
{
    call acquire();
    call corral_yield(l == CHThreadId() && l != 0);
    x := val;
    call corral_yield(Assert() || (l == CHThreadId() && l != 0 && x == val));
    call release();
}

