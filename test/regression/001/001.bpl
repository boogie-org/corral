var x: int;

var x2: int;

var Mem: [int]int;

procedure cba_thread1();
  modifies Mem;



implementation cba_thread1()
{
  var nondet: bool;
  var y: int;

  anon0:
    y := 0;
    havoc nondet;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume nondet;
    Mem := Mem[x := Mem[x] + 1];
    goto anon2;

  anon3_Else:
    assume !nondet;
    goto anon2;

  anon2:
    assert Mem[x] >= 0;
    return;
}



procedure cba_thread2();
  modifies Mem;



implementation cba_thread2()
{
  var nondet: bool;
  var y: int;

  anon0:
    y := 0;
    havoc nondet;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume nondet;
    Mem := Mem[x := Mem[x] + 1];
    goto anon2;

  anon3_Else:
    assume !nondet;
    goto anon2;

  anon2:
    assert Mem[x] >= 0;
    return;
}



procedure cba_init();
  modifies Mem;



implementation cba_init()
{

  anon0:
    Mem[x] := 0;
    return;
}



implementation cba_main()
{

  mainStart:
    call corral_atomic_begin();
    call cba_init();
    call corral_atomic_end();
    async call cba_thread1();
    async call cba_thread2();
    return;
}



procedure cba_main();
  modifies x, x2, Mem;



procedure corral_atomic_begin();



procedure corral_atomic_end();


