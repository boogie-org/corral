var x: int;
var y: int;

procedure foo()
{
   assert x ==  1;
}

procedure bar()
{
  assert x == 2;
}

procedure {:entrypoint} main()
{
   y := 0;
   if(*) { assume y == 1; } else { assume y == 0; }
   havoc x;
   if(*) { call foo(); }
   else { call bar(); }
}
