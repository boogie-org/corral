var x: int;

procedure bar()
{
   x := x + 1;
}

procedure {:inline 1} foo()
{
   call bar();
}

procedure main()
{
   x := 0;
   call foo();
   call foo();
   assert x == 0;
}
