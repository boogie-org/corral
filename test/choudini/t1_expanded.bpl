var l: int;

var x: int;

procedure corral_atomic_begin(Tid_in: [int]bool, Perm_in: [int]bool);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



procedure corral_atomic_end(Tid_in: [int]bool, Perm_in: [int]bool);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



procedure corral_getThreadID(Tid_in: [int]bool, Perm_in: [int]bool) returns (x: int);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



procedure corral_yield(x: bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires (exists partition_Tid: [int]int :: true);
  free requires (exists partition_Perm: [int]int :: true);
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



function CHThreadId() : int;

function {:existential true} Assert() : bool;

procedure {:single_instance} {:thread_entry} {:thread_num "main"} {:original_proc_name "main"} {:entrypoint} main(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in == ch_mapconstbool(true);
  free requires permVar_in[0];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies l, x;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation {:entrypoint} main(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool)
{
  var val: int;
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var permVarOut2: [int]bool;
  var og_global_old_l: int;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), l, x;
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
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    goto anon2_LoopHead;

  anon2_LoopHead:
    assume Tid_in_local == Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in);
    assume Perm_in_local == Perm_linear_MapOr(permVar_out, Perm_in);
    assume l == og_global_old_l;
    assume x == og_global_old_x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    havoc val;
    goto nlabel0, nlabel1;

  nlabel1:
    call tid_linear_guy_child := AllocateTid(Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in));
    call permVar_out, permVarOut2 := Split(permVar_out, Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_child := true], Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in)), Perm_in);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    call DummyAsyncTarget_corralThread0foo(val, tid_linear_guy_child, InAtomicBlock_out, permVarOut2, Tid_linear_MapConstBool(false), Perm_linear_MapConstBool(false));
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    goto anon2_LoopHead;

  nlabel0:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    goto nlabel1;

  anon2_LoopDone:
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "acquire"} corralThread0acquire(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies l, x;
  ensures l == tid_linear_guy_out && l != 0;
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_2() || permVar_in == permVar_out;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread0acquire(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var tid_linear_guy_child: int;
  var og_global_old_l: int;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), l, x;
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
    goto nlabel2, nlabel3;

  nlabel3:
    InAtomicBlock_out := true;
    goto nlabel4, nlabel5;

  nlabel5:
    assume l == 0;
    goto nlabel6, nlabel7;

  nlabel7:
    l := tid_linear_guy_out;
    InAtomicBlock_out := false;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    return;

  nlabel6:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel7;

  nlabel4:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel5;

  nlabel2:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel3;
}



procedure {:thread_num "foo"} {:original_proc_name "release"} corralThread0release(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool);
  requires l == tid_linear_guy_in && l != 0;
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies l, x;
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_4() || permVar_in == permVar_out;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread0release(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var tid_linear_guy_child: int;
  var og_global_old_l: int;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), l, x;
    goto addvars_start_10;

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
    goto nlabel8, nlabel9;

  nlabel9:
    InAtomicBlock_out := true;
    goto nlabel10, nlabel11;

  nlabel11:
    l := 0;
    InAtomicBlock_out := false;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    return;

  nlabel10:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel11;

  nlabel8:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert l == tid_linear_guy_out && l != 0;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume l == tid_linear_guy_out && l != 0;
    goto nlabel9;
}



procedure {:single_instance} {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} corralThread0foo(val: int, tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
  modifies l, x;
  free ensures (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free ensures (exists partition_Perm: [int]int :: Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



implementation corralThread0foo(val: int, tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var og_global_old_l: int;
  var og_global_old_x: int;
  var Tid_in_local: [int]bool;
  var Perm_in_local: [int]bool;

  og_init:
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_in), Perm_linear_MapOr(permVar_in, Perm_in), l, x;
    goto addvars_start_11;

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
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0acquire(tid_linear_guy_out, InAtomicBlock_out, permVar_out, Tid_in, Perm_in);
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    goto nlabel12, nlabel13;

  nlabel13:
    x := val;
    goto nlabel14, nlabel15;

  nlabel15:
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0release(tid_linear_guy_out, InAtomicBlock_out, permVar_out, Tid_in, Perm_in);
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    return;

  nlabel14:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Assert() || (l == tid_linear_guy_out && l != 0 && x == val);
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Assert() || (l == tid_linear_guy_out && l != 0 && x == val);
    goto nlabel15;

  nlabel12:
    assume !InAtomicBlock_out;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert l == tid_linear_guy_out && l != 0;
    call og_yield(Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x);
    havoc l, x;
    Tid_in_local, Perm_in_local, og_global_old_l, og_global_old_x := Tid_linear_MapOr(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_in), Perm_linear_MapOr(permVar_out, Perm_in), l, x;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume l == tid_linear_guy_out && l != 0;
    goto nlabel13;
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

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_5() : bool;

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

procedure {:inline 1} Impl_YieldChecker_main(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



procedure {:inline 1} Impl_YieldChecker_corralThread0acquire(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



procedure {:inline 1} Impl_YieldChecker_corralThread0release(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



procedure {:inline 1} Proc_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



procedure {:inline 1} Impl_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



implementation {:inline 1} Impl_YieldChecker_main(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{
  var val: int;
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var permVarOut2: [int]bool;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_l: int;
  var og_local_old_x: int;

  enter:
    goto exit, L0;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assume false;
    return;
}



implementation {:inline 1} Impl_YieldChecker_corralThread0acquire(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{
  var tid_linear_guy_child: int;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var tid_linear_guy_out: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var og_local_old_l: int;
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
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume false;
    return;

  L2:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume false;
    return;
}



implementation {:inline 1} Impl_YieldChecker_corralThread0release(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{
  var tid_linear_guy_child: int;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var tid_linear_guy_out: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var og_local_old_l: int;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume og_global_old_l == tid_linear_guy_out && og_global_old_l != 0;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert l == tid_linear_guy_out && l != 0;
    assume false;
    return;
}



implementation {:inline 1} Proc_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{
  var val: int;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_l: int;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume tid_linear_guy_in != 0;
    assume !InAtomicBlock_in;
    assume permVar_in != ch_mapconstbool(false);
    assume permVar_in[1];
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
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



implementation {:inline 1} Impl_YieldChecker_corralThread0foo(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{
  var tid_linear_guy_out: int;
  var tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var permVar_out: [int]bool;
  var val: int;
  var tid_linear_guy_in: int;
  var InAtomicBlock_in: bool;
  var permVar_in: [int]bool;
  var og_local_old_l: int;
  var og_local_old_x: int;

  enter:
    goto exit, L0, L1;

  exit:
    return;

  L0:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume Assert() || (og_global_old_l == tid_linear_guy_out && og_global_old_l != 0 && og_global_old_x == val);
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Assert() || (l == tid_linear_guy_out && l != 0 && x == val);
    assume false;
    return;

  L1:
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assume ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assume og_global_old_l == tid_linear_guy_out && og_global_old_l != 0;
    assume (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_out := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(1))) == Tid_linear_MapConstBool(true) && Tid_linear_MapImp(Tid_in, Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
    assume (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_out, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(1))) == Perm_linear_MapConstBool(true) && Perm_linear_MapImp(Perm_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert l == tid_linear_guy_out && l != 0;
    assume false;
    return;
}



procedure DummyAsyncTarget_corralThread0foo(val: int, tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool, Tid_in: [int]bool, Perm_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free requires (exists partition_Tid: [int]int :: Tid_linear_MapImp(Tid_linear_MapConstBool(false)[tid_linear_guy_in := true], Tid_linear_MapEq(partition_Tid, Tid_linear_MapConstInt(0))) == Tid_linear_MapConstBool(true) && true);
  free requires (exists partition_Perm: [int]int :: Perm_linear_MapImp(permVar_in, Perm_linear_MapEq(partition_Perm, Perm_linear_MapConstInt(0))) == Perm_linear_MapConstBool(true) && true);



procedure {:inline 1} og_yield(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int);



implementation {:inline 1} og_yield(Tid_in: [int]bool, Perm_in: [int]bool, og_global_old_l: int, og_global_old_x: int)
{

  enter:
    goto L_0, L_1, L_2, L_3, L_4;

  L_0:
    call Impl_YieldChecker_main(Tid_in, Perm_in, og_global_old_l, og_global_old_x);
    return;

  L_1:
    call Impl_YieldChecker_corralThread0acquire(Tid_in, Perm_in, og_global_old_l, og_global_old_x);
    return;

  L_2:
    call Impl_YieldChecker_corralThread0release(Tid_in, Perm_in, og_global_old_l, og_global_old_x);
    return;

  L_3:
    call Proc_YieldChecker_corralThread0foo(Tid_in, Perm_in, og_global_old_l, og_global_old_x);
    return;

  L_4:
    call Impl_YieldChecker_corralThread0foo(Tid_in, Perm_in, og_global_old_l, og_global_old_x);
    return;
}


