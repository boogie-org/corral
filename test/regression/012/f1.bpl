var {:thread_local} x: int;

procedure cba_thread1()
modifies x;
{
   assert x == 1;
}

implementation cba_main()
{

  mainStart:
    x := 1;
    async call cba_thread1();
    x := 2;
    return;
}



procedure cba_main();
  modifies x;



