var l: int;

var x: int;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (x: int);



procedure corral_yield(x: bool);



function CHThreadId() : int;

function {:existential true} Assert() : bool;

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
    assert permVar_out != ch_mapconstbool(false);
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    havoc val;
    goto nlabel0, nlabel1;

  nlabel0:
    assume !InAtomicBlock_out;
    yield;
    assert permVar_out != ch_mapconstbool(false);
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assert permVar_out[0];
    goto nlabel1;

  nlabel1:
    call tid_linear_guy_child := AllocateTid();
    call permVar_out, permVarOut2 := Split(permVar_out);
    goto anon2_LoopHead;

  anon2_LoopDone:
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


