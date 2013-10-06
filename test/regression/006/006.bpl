
var x:int;
var Mem:[int]int;

procedure cba_thread1()
modifies Mem;
{
  var nondet:bool;
  var y:int;

  havoc nondet;
  while (nondet) {
    havoc nondet;
    call foo();
  }

  y := Mem[x];
  assert y >= 0;
}

procedure foo()
modifies Mem;
{
  var nondet: bool;

  havoc nondet;
  while (nondet) {
    havoc nondet;
    Mem := Mem[x := Mem[x] + 1];
  }
}


procedure cba_main()
modifies Mem;
{
   Mem[x] := 0;
   async call cba_thread1();
}

