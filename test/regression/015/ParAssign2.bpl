procedure malloc() returns (addr: int);
modifies alloc;
ensures addr == old(alloc) && old(alloc) < alloc;

var alloc: int;
var mem: [int]int;
var lock: [int]bool;
var semaphore: [int]int;

procedure acquire(x: int)
{
  var l: bool;
  l, lock[x] := lock[x], true;
  assume !l;
}

procedure release(x: int) 
{
  lock[x] := false;
}

procedure wait(x: int) {
  assume semaphore[x] == 0;
}

procedure signal(x: int) {
  semaphore[x] := semaphore[x]-1;
}

procedure f(x: int) {
  call acquire(x);
  mem[x] := mem[x] + 10;
  call release(x);
  call signal(x);
}

procedure {:entrypoint} main() 
{
  var x: int;

  call x := malloc();
  mem[x] := 0;
  semaphore[x] := 2;
  async call f(x);
  async call f(x);
  call wait(x);
  assert mem[x] == 20;
}

