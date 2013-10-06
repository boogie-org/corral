var g: int;

var assertsPassed: bool;

procedure main();
  free requires assertsPassed;
  modifies g, assertsPassed;



implementation main()
{

  anon0:
    g := 0;
    goto assert_rewrite_dummy_block_0, assert_rewrite_dummy_block_1;

  assert_rewrite_dummy_block_0:
    assume !|{

  A:
    return g == 0;

}|


;
    assertsPassed := false;
    goto SeqInstr_1, SeqInstr_2;

  SeqInstr_1:
    assume !assertsPassed;
    return;

  SeqInstr_2:
    assume assertsPassed;
    goto SeqInstr_3;

  SeqInstr_3:
    goto assert_rewrite_dummy_block_2;

  assert_rewrite_dummy_block_1:
    assume |{

  A:
    return g == 0;

}|


;
    goto assert_rewrite_dummy_block_2;

  assert_rewrite_dummy_block_2:
    return;
}



procedure corral_assert_not_reachable();



procedure {:entrypoint} main_SeqInstr();
  free requires assertsPassed;
  modifies assertsPassed, g;



implementation {:entrypoint} main_SeqInstr()
{

  start:
    assertsPassed := true;
    call main();
    assume {:OldAssert} !assertsPassed;
    return;
}


