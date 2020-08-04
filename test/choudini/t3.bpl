
var l: int;
var x: int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (x:int);
procedure corral_yield(x:bool);
function CHThreadId() returns (x:int);

function {:existential true} {:absdomain "PredicateAbs"} Inv1(x:bool,x2:bool): bool;
function {:existential true} {:absdomain "PredicateAbs"} Inv2(x:bool,x2:bool): bool;
function {:existential true} {:absdomain "PredicateAbs"} Inv3(x:bool,x2:bool): bool;
function {:existential true} {:absdomain "PredicateAbs"} Inv4(x:bool,x2:bool): bool;
function {:existential true} {:absdomain "PredicateAbs"} Inv5(x:bool,x2:bool,x3:bool): bool;

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
  ensures Inv1(l == CHThreadId(), l == 0);
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
  requires Inv2(l == CHThreadId(), l == 0);
{
    call corral_yield(Inv3(l == CHThreadId(), l == 0));
    call corral_atomic_begin();
    yield;
    l := 0;
    call corral_atomic_end();
}

procedure foo(val: int)
{
    call acquire();
    call corral_yield(Inv4(l == CHThreadId(), l == 0));
    x := val;
    call corral_yield(Inv5(l == CHThreadId(), l == 0, x == val));
    call release();
}

