procedure {:entrypoint} bar()
{
  call foo(0);
}

procedure foo(a: int)
{
   if(a == 0) {
     call foo(1);
   }
   assert false;
}

const NULL: int;
axiom NULL == 0;
procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
