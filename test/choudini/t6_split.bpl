procedure corral_yield(x: bool);



var x: int;

function {:existential true} Inv1(a: bool) : bool;

function {:existential true} Inv2(a: bool) : bool;

function {:existential true} Inv3(a: bool) : bool;

procedure {:single_instance} {:thread_entry} {:thread_num "mainE"} {:original_proc_name "mainE"} {:yields} {:entrypoint} mainE();
  modifies x;



implementation {:entrypoint} mainE()
{

  anon0:
    assume x == 0;
    call corral_yield(Inv1(x == 0));
    call corralThread1bar();
    call corral_yield(Inv1(x == 0));
    async call corralThread0foo();
    return;
}



procedure {:single_instance} {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} {:yields} corralThread0foo();
  requires Inv2(x == 0);
  modifies x;



implementation corralThread0foo()
{

  anon0:
    call corral_yield(Inv2(x == 0));
    call corralThread0baz();
    call corral_yield(Inv2(x == 0));
    x := x + 1;
    call corral_yield(Inv3(x == 1));
    return;
}



procedure {:thread_num "mainE"} {:original_proc_name "bar"} corralThread1bar();



implementation corralThread1bar()
{

  anon0:
    assume x == x;
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "baz"} corralThread0baz();



implementation corralThread0baz()
{

  anon0:
    assume x == x;
    return;
}


