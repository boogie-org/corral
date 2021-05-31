procedure corral_yield(x:bool);

var x: int;

function {:existential true} {:absdomain "ConstantProp"} Inv1(a:bool): bool;
function {:existential true} {:absdomain "ConstantProp"} Inv2(a:bool): bool;
function {:existential true} {:absdomain "ConstantProp"} Inv3(a:bool): bool;

procedure {:entrypoint} main()
{
    x := 0;
    call corral_yield(Inv1(x == 0));

    async call foo();

    x := 0;
    call corral_yield(Inv2(x == 0));

    async call bar();

    x := 0;
    call corral_yield(Inv3(x == 0));

}

procedure foo() 
{
    yield;
    x := 1;
}


procedure bar() 
{
    yield;
    x := 1;
}

