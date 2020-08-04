var x: int;

procedure foo()
{
   assert x ==  1;
}

procedure {:entrypoint} main()
{
   havoc x;
   while(*) { 
     call foo(); 
   }
}
