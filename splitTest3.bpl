var x: int;

procedure foo1()
modifies x;
{
  x := x + 1;
}

procedure foo2()
modifies x;
{
  x := x + 1;
}

procedure foo3()
modifies x;
{
  x := x + 1;
}

procedure foo4()
modifies x;
{
  x := x + 1;
}

procedure bar1()
modifies x;
{
  var e: bool;
  x := x + 1;
  if (e) {
      call foo1();
  }
  call foo2();  
}

procedure {:entrypoint} main()
modifies x;
{
  var c: bool;
  var d: bool;

  x := 1;

  if (c) {
      call bar1();      
  }

  if (d) {
      call foo3();
  } else {
      call foo4();
  }  
  assert x > 1;
}

ite h1, block else mustreach
Do static analysis. For a split candidate, how different are the block and mustreach partition inlinings are going to be? Figure out from the call graph.

!c and !d
block(b1) and block(foo4)
minimal unsat core block(foo4)
f4
assert f4
b1 and !f4 and f4

maxsat(h1, h2, ... hn, s1, s2,...,sk) -> maximum number of clauses (h1,...hn, S) such that S is a subset of {s1, s2,...sk} ,i.e., maximize |S| and this is sat
and(h1, h2, ... hn, s1, s2,...,sk) is sat
M = maxsat(h1, h2, ... hn, s1, s2,...,sk)
hard constaraints are asserted pVCs
soft constraints are decisions
what are the maximum number of decisions I can drop such that this remains unsat
s1, s2, s3, s4, s5
drop s3, still unsat
drop s1, still unsat
drop anymore, it becomes sat
fresh boolean variables q1,...qk
q1 -> s1, ...., qk -> sk (these are also hard constraints)
soft constraints are q1,...,qk
if qi is false, callsite corresponding to si is overapproximated
