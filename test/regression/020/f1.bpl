var x: int;

procedure foo() 
{
   x := 1;
   assert x == 1;
}

procedure bar() 
{
   x := 0;
}

procedure {:entrypoint} main()
{
  async call foo();
  async call bar();
}
