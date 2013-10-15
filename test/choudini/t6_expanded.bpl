procedure corral_yield(x: bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



var x: int;

function {:existential true} Inv1(a: bool) : bool;

function {:existential true} Inv2(a: bool) : bool;

function {:existential true} Inv3(a: bool) : bool;

procedure {:single_instance} {:thread_entry} {:thread_num "mainE"} {:original_proc_name "mainE"} {:entrypoint} mainE(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in == ch_mapconstbool(true);
  free requires permVar_in[0];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies x;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation {:entrypoint} mainE(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var permVarOut2: [int]bool;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), x;
    goto addvars_start_8;

  addvars_start_8:
    permVar_out := permVar_in;
    goto addvars_start_4;

  addvars_start_4:
    InAtomicBlock_out := InAtomicBlock_in;
    goto addvars_start_0;

  addvars_start_0:
    tid_linear_guy_out := tid_linear_guy_in;
    goto anon0;

  anon0:
    assume x == 0;
    goto nlabel0, nlabel1;

  nlabel1:
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread1bar(tid_linear_guy_out, InAtomicBlock_out, permVar_out, Tid_in, Perm_in);
    goto nlabel2, nlabel3;

  nlabel3:
    call tid_linear_guy_child := AllocateTid(Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in));
    call permVar_out, permVarOut2 := Split(permVar_out, Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_child := true], Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in)), Perm_in);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    call DummyAsyncTarget_corralThread0foo(tid_linear_guy_child, InAtomicBlock_out, permVarOut2, Tid_linear_MapConstBool(false), Perm_linear_MapConstBool(false));
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    return;

  nlabel2:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_2() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    havoc x;
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_2() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume Inv1(x == 0);
    goto nlabel3;

  nlabel0:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    havoc x;
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume Inv1(x == 0);
    goto nlabel1;
}



procedure {:single_instance} {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} corralThread0foo(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  requires Inv2(x == 0);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies x;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread0foo(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), x;
    goto addvars_start_9;

  addvars_start_9:
    permVar_out := permVar_in;
    goto addvars_start_5;

  addvars_start_5:
    InAtomicBlock_out := InAtomicBlock_in;
    goto addvars_start_1;

  addvars_start_1:
    tid_linear_guy_out := tid_linear_guy_in;
    goto anon0;

  anon0:
    goto nlabel4, nlabel5;

  nlabel5:
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0baz(tid_linear_guy_out, InAtomicBlock_out, permVar_out, Tid_in, Perm_in);
    goto nlabel6, nlabel7;

  nlabel7:
    x := x + 1;
    goto nlabel8, nlabel9;

  nlabel9:
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    return;

  nlabel8:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv3(x == 1);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    havoc x;
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv3(x == 1);
    goto nlabel9;

  nlabel6:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    havoc x;
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv2(x == 0);
    goto nlabel7;

  nlabel4:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_x);
    havoc x;
    Tid_in_local, Perm_in_local, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv2(x == 0);
    goto nlabel5;
}



procedure {:thread_num "mainE"} {:original_proc_name "bar"} corralThread1bar(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[0];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_4() || permVar_in == permVar_out;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread1bar(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var tid_linear_guy_child: int;

  addvars_start_10:
    permVar_out := permVar_in;
    goto addvars_start_6;

  addvars_start_6:
    InAtomicBlock_out := InAtomicBlock_in;
    goto addvars_start_2;

  addvars_start_2:
    tid_linear_guy_out := tid_linear_guy_in;
    goto anon0;

  anon0:
    assume x == x;
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "baz"} corralThread0baz(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_6() || permVar_in == permVar_out;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread0baz(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var tid_linear_guy_child: int;

  addvars_start_11:
    permVar_out := permVar_in;
    goto addvars_start_7;

  addvars_start_7:
    InAtomicBlock_out := InAtomicBlock_in;
    goto addvars_start_3;

  addvars_start_3:
    tid_linear_guy_out := tid_linear_guy_in;
    goto anon0;

  anon0:
    assume x == x;
    return;
}



procedure AllocateTid(Tid_in: [int]bool, Perm_in: [int]bool) returns (x: int);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  ensures x != 0;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_linear_MapConstBool(false)[x := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



function {:builtin "MapConst"} ch_mapconstbool(x: bool) : [int]bool;

function {:builtin "MapOr"} ch_mapunion(x: [int]bool, y: [int]bool) : [int]bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_1() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_2() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_3() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_4() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_6() : bool;

procedure Split(xls: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (xls1: [int]bool, xls2: [int]bool);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(xls, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  ensures xls == ch_mapunion(xls1, xls2) && xls1 != ch_mapconstbool(false) && xls2 != ch_mapconstbool(false);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(2))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(xls2, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(xls1, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



function {:builtin "MapConst"} Tid_linear_MapConstBool(b: bool) : [int]bool;

function {:builtin "MapConst"} Tid_linear_MapConstInt(b: int) : [int]int;

function {:builtin "MapEq"} Tid_linear_MapEq(a: [int]int, b: [int]int) : [int]bool;

function {:builtin "MapImp"} Tid_linear_MapImp(a: [int]bool, b: [int]bool) : [int]bool;

function {:builtin "MapOr"} Tid_linear_MapOr(a: [int]bool, b: [int]bool) : [int]bool;

function {:builtin "MapConst"} Perm_linear_MapConstBool(b: bool) : [int]bool;

function {:builtin "MapConst"} Perm_linear_MapConstInt(b: int) : [int]int;

function {:builtin "MapEq"} Perm_linear_MapEq(a: [int]int, b: [int]int) : [int]bool;

function {:builtin "MapImp"} Perm_linear_MapImp(a: [int]bool, b: [int]bool) : [int]bool;

function {:builtin "MapOr"} Perm_linear_MapOr(a: [int]bool, b: [int]bool) : [int]bool;

procedure {:inline 1} Impl_YieldChecker_mainE(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int);



procedure {:inline 1} Proc_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int);



procedure {:inline 1} Impl_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int);



implementation {:inline 1} Impl_YieldChecker_mainE(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var permVarOut2: [int]bool;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_2() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume Inv1(og_global_old_x == 0);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_2() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume Inv1(og_global_old_x == 0);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    assume false;
    return;
}



implementation {:inline 1} Proc_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int)
{
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume Inv2(og_global_old_x == 0);
    assume tid_linear_guy_in != 0;
    assume !InAtomicBlock_in;
    assume permVar_in != ch_mapconstbool(false);
    assume permVar_in[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert Inv2(x == 0);
    assume tid_linear_guy_in != 0;
    assume !InAtomicBlock_in;
    assume permVar_in != ch_mapconstbool(false);
    assume permVar_in[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume false;
    return;
}



implementation {:inline 1} Impl_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1, L2;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv3(og_global_old_x == 1);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv3(x == 1);
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv2(og_global_old_x == 0);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    assume false;
    return;

  L2:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Inv2(og_global_old_x == 0);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    assume false;
    return;
}



procedure DummyAsyncTarget_corralThread0foo(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  requires Inv2(x == 0);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



procedure {:inline 1} og_yield(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int);



implementation {:inline 1} og_yield(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_x: int)
{

  enter:
    goto L_0, L_1, L_2;

  L_0:
    call Impl_YieldChecker_mainE(Tid_in, Perm_in, og_global_old_x);
    return;

  L_1:
    call Proc_YieldChecker_corralThread0foo(Tid_in, Perm_in, og_global_old_x);
    return;

  L_2:
    call Impl_YieldChecker_corralThread0foo(Tid_in, Perm_in, og_global_old_x);
    return;
}


