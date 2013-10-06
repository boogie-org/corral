var x: int;

procedure cba_thread1()
{
   var t: int;

   call t := corral_getThreadID();
   assert t == 1;
}


procedure cba_thread2()
{
   x := 10;
   assert x == 10;
}


procedure main(a: int)
{

  start:
    call corral_atomic_begin();
    call cba_thread1();
    call cba_thread2();
    assert a == 0;
    call corral_atomic_end();
    return;
}


procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (t:int);

