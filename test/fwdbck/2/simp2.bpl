// basic for stratified inlining
// checks the forward phase

var x: int;

procedure {:entrypoint} main2() 
{
   x := 0;

   call bar();

   call foo2();
}

procedure foo2()
{
   call foo();
}


procedure foo()
{
   if(x == 1) {
     assert false;
   }
}


procedure bar()
{
   x := 1;
}
