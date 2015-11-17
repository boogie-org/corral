
procedure {:entrypoint} main()
{
   var l1, l2: int;

   call init();

   call Acquire();
   while(*) {
     call Release();
     call foo();
     call Acquire();
   }
   call Release();
}

procedure foo()
{
  var i: int;
  i := 0;

   while(*) { 
     call Acquire();
     call Release();
   }
}

var s: int;

procedure init()
{
  s := 0;
}


procedure Acquire()
{
  if(s == 1) { assert false; }
  else { s := 1; }
}

procedure Release()
{
  if(s == 0) { assert false; }
  else { s := 0; }
}

procedure {:template} summaries();
  free requires s == 0 || s == 1;
  free ensures s == 0 || s == 1;
