procedure corral_yield(x: bool);



var x: int;

function {:existential true} {:absdomain "ConstantProp"} Inv1(a: bool) : bool;

function {:existential true} {:absdomain "ConstantProp"} Inv2(a: bool) : bool;

function {:existential true} {:absdomain "ConstantProp"} Inv3(a: bool) : bool;

procedure {:thread_entry} {:thread_num "main"} {:original_proc_name "main"} {:yields} {:entrypoint} main();
  modifies x;



implementation {:entrypoint} main()
{

  anon0:
    x := 0;
    call corral_yield(Inv1(x == 0));
    async call corralThread0foo();
    x := 0;
    call corral_yield(Inv2(x == 0));
    async call corralThread1bar();
    x := 0;
    call corral_yield(Inv3(x == 0));
    return;
}



procedure {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} {:yields} corralThread0foo();
  modifies x;



implementation corralThread0foo()
{

  anon0:
    yield;
    x := 1;
    return;
}



procedure {:thread_entry} {:thread_num "bar"} {:original_proc_name "bar"} {:stable} {:yields} corralThread1bar();
  modifies x;



implementation corralThread1bar()
{

  anon0:
    yield;
    x := 1;
    return;
}


