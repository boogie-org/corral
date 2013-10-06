var x: int;

procedure cba_thread2()
{
   x := 10;
   assert x == 11;
}


procedure main(a: int)
{

  start:
    call cba_thread2();
    assume false;
    return;
}

