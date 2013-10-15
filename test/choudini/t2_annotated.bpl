var l: int;

var x: int;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (x: int);



procedure corral_yield(x: bool);



function CHThreadId() : int;

function {:existential true} Assert() : bool;

function {:existential true} Inv1(x: bool) : bool;

function {:existential true} Inv2(x: bool) : bool;

function {:existential true} Inv3(x: bool) : bool;

function {:existential true} Inv4(x: bool) : bool;

function {:existential true} Inv5(x: bool) : bool;

procedure {:single_instance} {:thread_entry} {:thread_num "main"} {:original_proc_name "main"} {:yields} {:entrypoint} main({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in == ch_mapconstbool(true);
  free requires permVar_in[0];
  modifies l, x;



implementation {:entrypoint} main(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool)
{
  var val: int;
  var {:linear "Tid"} tid_linear_guy_out: int;
  var {:linear "Tid"} tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var {:linear "Perm"} permVar_out: [int]bool;
  var {:linear "Perm"} permVarOut2: [int]bool;

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
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    havoc val;
    goto nlabel0, nlabel1;

  nlabel0:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    goto nlabel1;

  nlabel1:
    call tid_linear_guy_child := AllocateTid();
    call permVar_out, permVarOut2 := Split(permVar_out);
    async call corralThread0foo(val, tid_linear_guy_child, InAtomicBlock_out, permVarOut2);
    goto anon2_LoopHead;

  anon2_LoopDone:
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "acquire"} {:yields} corralThread0acquire({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool) returns ({:linear "Tid"} tid_linear_guy_out: int, InAtomicBlock_out: bool, {:linear "Perm"} permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  modifies l;
  ensures Inv1(l == tid_linear_guy_out && l != 0);
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_2() || permVar_in == permVar_out;



implementation corralThread0acquire(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var {:linear "Tid"} tid_linear_guy_child: int;

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

  nlabel2:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel3;

  nlabel3:
    InAtomicBlock_out := true;
    goto nlabel4, nlabel5;

  nlabel4:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel5;

  nlabel5:
    assume l == 0;
    goto nlabel6, nlabel7;

  nlabel6:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel7;

  nlabel7:
    l := tid_linear_guy_out;
    InAtomicBlock_out := false;
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "release"} {:yields} corralThread0release({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool) returns ({:linear "Tid"} tid_linear_guy_out: int, InAtomicBlock_out: bool, {:linear "Perm"} permVar_out: [int]bool);
  requires Inv2(l == tid_linear_guy_in && l != 0);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  modifies l;
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_4() || permVar_in == permVar_out;



implementation corralThread0release(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var {:linear "Tid"} tid_linear_guy_child: int;

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

  nlabel8:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv3(l == tid_linear_guy_out && l != 0);
    goto nlabel9;

  nlabel9:
    InAtomicBlock_out := true;
    goto nlabel10, nlabel11;

  nlabel10:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_5() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    goto nlabel11;

  nlabel11:
    l := 0;
    InAtomicBlock_out := false;
    return;
}



procedure {:single_instance} {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} {:yields} corralThread0foo(val: int, {:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  modifies l, x;



implementation corralThread0foo(val: int, tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool)
{
  var {:linear "Tid"} tid_linear_guy_out: int;
  var {:linear "Tid"} tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var {:linear "Perm"} permVar_out: [int]bool;

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
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0acquire(tid_linear_guy_out, InAtomicBlock_out, permVar_out);
    goto nlabel12, nlabel13;

  nlabel12:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv4(l == tid_linear_guy_out && l != 0);
    goto nlabel13;

  nlabel13:
    x := val;
    goto nlabel14, nlabel15;

  nlabel14:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_6() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv5(l == tid_linear_guy_out && l != 0 && x == val);
    goto nlabel15;

  nlabel15:
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0release(tid_linear_guy_out, InAtomicBlock_out, permVar_out);
    return;
}



procedure AllocateTid() returns ({:linear "Tid"} x: int);
  ensures x != 0;



function {:builtin "MapConst"} ch_mapconstbool(x: bool) : [int]bool;

function {:builtin "MapOr"} ch_mapunion(x: [int]bool, y: [int]bool) : [int]bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_1() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_2() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_3() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_4() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_5() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_6() : bool;

procedure Split({:linear "Perm"} xls: [int]bool) returns ({:linear "Perm"} xls1: [int]bool, {:linear "Perm"} xls2: [int]bool);
  ensures xls == ch_mapunion(xls1, xls2) && xls1 != ch_mapconstbool(false) && xls2 != ch_mapconstbool(false);


