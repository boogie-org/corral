procedure {:entrypoint} main()
{
   var l1, l2: int;

   call init();

   call l1 := malloc(4);
   call l2 := malloc(4);

   while(*) {
     guard := l1;
     call Acquire(l1);
     call Release(l1);
   }
}

var s: int;
var guard: int;

procedure init()
{
  s := 0;
  guard := 0;
}


procedure Acquire(lock: int)
{
   if(lock == guard && guard != 0) 
   {
      if(s == 1) { assert false; }
      else { s := 1; }
   }
}

procedure Release(lock: int)
{
   if(lock == guard && guard != 0) 
   {
      if(s == 0) { assert false; }
      else { s := 0; } 
   }
}

var alloc: int;
procedure malloc(size: int) returns (r: int);
  modifies alloc;
  ensures alloc > old(alloc) + size;
  ensures r == old(alloc);
  ensures r > 0;
