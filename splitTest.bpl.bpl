var x: int;

var assertsPassed: bool;

procedure baz();
  free requires assertsPassed;



implementation baz()
{

  anon0:
    return;
}



procedure foo();
  free requires assertsPassed;
  modifies x;



implementation foo()
{

  anon0:
    x := x + 2;
    return;
}



procedure bar();
  free requires assertsPassed;
  modifies x;



implementation bar()
{

  anon0:
    x := x + 1;
    return;
}



procedure main();
  free requires assertsPassed;
  modifies x, assertsPassed;



implementation main()
{
  var c: bool;

  anon0:
    x := 1;
    goto anon4_Then, anon4_Else;

  anon4_Else:
    assume {:partition} !c;
    call {:si_unique_call 1} bar();
    goto anon3;

  anon3:
    call {:si_unique_call 2} foo();
    goto assert_rewrite_dummy_block_0, assert_rewrite_dummy_block_1;

  assert_rewrite_dummy_block_1:
    assume x > 0;
    goto assert_rewrite_dummy_block_2;

  assert_rewrite_dummy_block_2:
    return;

  assert_rewrite_dummy_block_0:
    assume {:corral_assert_pt} 0 >= x;
    assertsPassed := false;
    goto SeqInstr_1, SeqInstr_2;

  SeqInstr_2:
    assume assertsPassed;
    goto SeqInstr_3;

  SeqInstr_3:
    goto assert_rewrite_dummy_block_2;

  SeqInstr_1:
    assume !assertsPassed;
    return;

  anon4_Then:
    assume {:partition} c;
    call {:si_unique_call 0} baz();
    goto anon3;
}



procedure corral_assert_not_reachable();



procedure {:entrypoint} main_SeqInstr();
  free requires assertsPassed;
  modifies assertsPassed, x;



implementation {:entrypoint} main_SeqInstr()
{

  start:
    assertsPassed := true;
    call main();
    assume {:OldAssert} !assertsPassed;
    return;
}


