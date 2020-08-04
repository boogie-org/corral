var g: int;

procedure {:inline 1} foo() returns (x: bool)
{
  x := g == 0;
}

procedure {:entrypoint} main()
  modifies g;
{
  g := 0;
  assert |{ var b: bool; A: call b := foo(); return b; }|;
}

