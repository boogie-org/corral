
var x:int;

procedure cba_thread1()
modifies x;
{
   x := 1;
}

procedure cba_thread2()
modifies x;
{
   x := 2;
}

procedure cba_thread3()
modifies x;
{
   x := 3;
}

procedure cba_thread4()
{
   var v: bool;
   v := true;

   if(x != 0) {
    if(x != 1) {
     if(x != 2) {
      if(x != 3) {
         v := false;
      }
     }
    }
   }

   assert v;
}

procedure cba_init()
modifies x;
{
   x := 0;
}

implementation cba_main()
{

  mainStart:
    call corral_atomic_begin();
    call cba_init();
    call corral_atomic_end();
    async call cba_thread1();
    async call cba_thread2();
    async call cba_thread3();
    async call cba_thread4();
    return;
}



procedure cba_main();
  modifies x;

procedure corral_atomic_begin();

procedure corral_atomic_end();
