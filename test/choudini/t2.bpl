
var l: int;
var x: int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (x:int);
procedure corral_yield(x:bool);
function CHThreadId() returns (x:int);

function {:existential true} Assert(): bool;
function {:existential true} Inv1(x:bool): bool;
function {:existential true} Inv2(x:bool): bool;
function {:existential true} Inv3(x:bool): bool;
function {:existential true} Inv4(x:bool): bool;
function {:existential true} Inv5(x:bool): bool;

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
  ensures Inv1(l == CHThreadId() && l != 0);
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
  requires Inv2(l == CHThreadId() && l != 0);
{
    call corral_yield(Inv3(l == CHThreadId() && l != 0));
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
}

procedure foo(val: int)
{
    call acquire();
    call corral_yield(Inv4(l == CHThreadId() && l != 0));
    x := val;
    call corral_yield(Inv5(l == CHThreadId() && l != 0 && x == val));
    call release();
}

