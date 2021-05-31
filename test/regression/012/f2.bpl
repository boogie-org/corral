var {:thread_local} x: int;

procedure cba_thread1()
modifies x;
{
   x := 2;
}

implementation cba_main()
{

  mainStart:
    x := 1;
    async call cba_thread1();
    assert x == 1;
    return;
}



procedure cba_main();
  modifies x;



