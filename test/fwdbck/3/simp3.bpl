// basic for stratified inlining
// checks the backward search

var x: int;

procedure {:entrypoint} main() 
{
   x := 0;

   call bar2();

   call foo();
}


procedure foo()
{
   if(x == 1) {
     assert false;
   }
}

procedure bar2()
{
   call bar();
}

procedure bar()
{
   x := 1;
}
