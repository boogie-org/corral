var x: int;

procedure {:entrypoint} main()
{
  var i: int;

   x := 0;
   async call foo();
   i := 0;

   while(i < 10) {
     x := x + 1;
     i := i + 1;
   }


}

procedure foo()
{
  assume x == 10;
  assert false;
}
