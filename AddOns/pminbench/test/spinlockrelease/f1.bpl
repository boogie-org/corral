
procedure {:entrypoint} main()
{
   call init();

   while(*) {
     call wrap_Acquire();
     call wrap_Release();
   }

   assert depth == 0;
}

var depth: int;

procedure init()
{
  depth := 0;
}

procedure wrap_Acquire()
{
   call Acquire();
}

procedure wrap_Release()
{
   call Release();
}

procedure Acquire()
{
  depth := depth + 1;
}

procedure Release()
{
  depth := depth - 1;
}

