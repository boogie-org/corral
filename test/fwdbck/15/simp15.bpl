// simplified version of an SDV example

var x : int;
var yogi_error : int;

procedure useless()
{
  start:
    return;
}

procedure init()
{
  start:
    x := 0;
    yogi_error := 0;
}

procedure reinit()
{
  start:
    x := 0;
}

procedure inc()
{
  start:
    x := 1;
    call test();
    return;
}

procedure test()
{
  start:
    goto L1, L2;
  L1:
    assume yogi_error == 1;
    return;

  L2:
    assume yogi_error != 1;
    return;
}

procedure fail()
{
  start:
    yogi_error := 1;
    return;
}

procedure CFG()
{
  start:
    goto L1, L2;

  L1:
    assume x == 0;
    goto L3,L4;

  L2:
    assume x!=0;
    call fail();
    goto L3,L4;

  L3:
    assume yogi_error == 1;
    return;

  L4:
    assume yogi_error == 0;
    return;
}

procedure sdv_main()
{
  start:
    call reinit();
    call useless();
    call CFG();
    return;
}

procedure {:entrypoint} main();

implementation {:entrypoint} main()
{
  start:
    call init();
    call inc();
    call sdv_main();
    goto L1, L2;

  L1:
    assume yogi_error == 1;
    assert false;
    return;

  L2:
    // for fun ;-)
    goto L2, L3;

  L3:
    assume yogi_error != 1;
    return;
}

