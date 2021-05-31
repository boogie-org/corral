
procedure foo() 
{
   var x:int;
   x := 1;
}

procedure bar()
{
   var x:int;
   x := 2;
}

procedure main()
{
   var x:int;
   x := 1;
   if(x == 1) {
     call foo();
   } else {
     call bar();
   }
   assert x == 0;
}

