procedure corral_yield(x:bool);

var x: int;

function {:existential true} Inv1(a:bool): bool;
function {:existential true} Inv2(a:bool): bool;
function {:existential true} Inv3(a:bool): bool;

procedure {:entrypoint} mainE()
{
    assume x == 0;
    call corral_yield(Inv1(x == 0));

    call bar();

    call corral_yield(Inv1(x == 0));

    async call foo();
}

procedure foo() 
  requires Inv2(x == 0);
{
    call corral_yield(Inv2(x == 0));
    call baz();
    
    call corral_yield(Inv2(x == 0));
    x := x + 1;

    call corral_yield(Inv3(x == 1));
}

procedure bar()
{
   assume x == x;
}

procedure baz()
{
   assume x == x;
}
