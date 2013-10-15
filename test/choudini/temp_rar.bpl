procedure corral_yield(x: bool);



var x: int;

function {:existential true} Inv1(a: bool) : bool;

function {:existential true} Inv2(a: bool) : bool;

function {:existential true} Inv3(a: bool) : bool;

procedure {:single_instance} {:thread_entry} {:thread_num "mainE"} {:original_proc_name "mainE"} {:yields} {:entrypoint} mainE({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in == ch_mapconstbool(true);
  free requires permVar_in[0];
  modifies x;



implementation {:entrypoint} mainE(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool)
{
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
    assume x == 0;
    goto nlabel0, nlabel1;

  nlabel0:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_1() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    goto nlabel1;

  nlabel1:
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread1bar(tid_linear_guy_out, InAtomicBlock_out, permVar_out);
    goto nlabel2, nlabel3;

  nlabel2:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_2() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[0];
    assert Inv1(x == 0);
    goto nlabel3;

  nlabel3:
    call tid_linear_guy_child := AllocateTid();
    call permVar_out, permVarOut2 := Split(permVar_out);
    async call corralThread0foo(tid_linear_guy_child, InAtomicBlock_out, permVarOut2);
    return;
}



procedure {:single_instance} {:thread_entry} {:thread_num "foo"} {:original_proc_name "foo"} {:stable} {:yields} corralThread0foo({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool);
  requires Inv2(x == 0);
  free requires tid_linear_guy_in != 0;
  free requires !InAtomicBlock_in;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  modifies x;



implementation corralThread0foo(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool)
{
  var {:linear "Tid"} tid_linear_guy_out: int;
  var {:linear "Tid"} tid_linear_guy_child: int;
  var InAtomicBlock_out: bool;
  var {:linear "Perm"} permVar_out: [int]bool;

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

  nlabel4:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    goto nlabel5;

  nlabel5:
    call tid_linear_guy_out, InAtomicBlock_out, permVar_out := corralThread0baz(tid_linear_guy_out, InAtomicBlock_out, permVar_out);
    goto nlabel6, nlabel7;

  nlabel6:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv2(x == 0);
    goto nlabel7;

  nlabel7:
    x := x + 1;
    goto nlabel8, nlabel9;

  nlabel8:
    assume !InAtomicBlock_out;
    yield;
    assert ch_bool_3() || permVar_out == ch_mapconstbool(true);
    assume permVar_out != ch_mapconstbool(false);
    assume permVar_out[1];
    assert Inv3(x == 1);
    goto nlabel9;

  nlabel9:
    return;
}



procedure {:thread_num "mainE"} {:original_proc_name "bar"} corralThread1bar({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool) returns ({:linear "Tid"} tid_linear_guy_out: int, InAtomicBlock_out: bool, {:linear "Perm"} permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[0];
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_4() || permVar_in == permVar_out;



implementation corralThread1bar(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
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
    assume x == x;
    return;
}



procedure {:thread_num "foo"} {:original_proc_name "baz"} corralThread0baz({:linear "Tid"} tid_linear_guy_in: int, InAtomicBlock_in: bool, {:linear "Perm"} permVar_in: [int]bool) returns ({:linear "Tid"} tid_linear_guy_out: int, InAtomicBlock_out: bool, {:linear "Perm"} permVar_out: [int]bool);
  free requires tid_linear_guy_in != 0;
  free requires permVar_in != ch_mapconstbool(false);
  free requires permVar_in[1];
  free ensures tid_linear_guy_in == tid_linear_guy_in;
  ensures ch_bool_6() || permVar_in == permVar_out;



implementation corralThread0baz(tid_linear_guy_in: int, InAtomicBlock_in: bool, permVar_in: [int]bool) returns (tid_linear_guy_out: int, InAtomicBlock_out: bool, permVar_out: [int]bool)
{
  var {:linear "Tid"} tid_linear_guy_child: int;

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



procedure AllocateTid() returns ({:linear "Tid"} x: int);
  ensures x != 0;



function {:builtin "MapConst"} ch_mapconstbool(x: bool) : [int]bool;

function {:builtin "MapOr"} ch_mapunion(x: [int]bool, y: [int]bool) : [int]bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_1() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_2() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_3() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_4() : bool;

function {:chignore} {:absdomain "IA[HoudiniConst]"} {:existential true} ch_bool_6() : bool;

procedure Split({:linear "Perm"} xls: [int]bool) returns ({:linear "Perm"} xls1: [int]bool, {:linear "Perm"} xls2: [int]bool);
ensures xls == ch_mapunion(xls1, xls2) && xls1 != ch_mapconstbool(false) && xls2 != ch_mapconstbool(false);
