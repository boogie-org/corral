// basic for stratified inlining

var x: int;

procedure {:entrypoint} main() 
{
   x := 0;

   call bar();

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
