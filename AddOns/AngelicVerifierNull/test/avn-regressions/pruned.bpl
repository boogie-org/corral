procedure corral_nondet() returns (x: int);



procedure boogie_si_record_li2bpl_int(x: int);



var alloc: int;

const alloc_init: int;

procedure {:allocator} __HAVOC_malloc(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc);
  free ensures alloc >= old(alloc) + size;



procedure {:allocator "full"} __HAVOC_malloc_or_null(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc) || ret == 0;
  free ensures alloc >= old(alloc) + size;



const {:allocated} NULL: int;

axiom NULL == 0;

function BAND(a: int, b: int) : int;

function BOR(a: int, b: int) : int;

function BNOT(a: int) : int;

function INTDIV(a: int, b: int) : int;

function INTMOD(a: int, b: int) : int;

var yogi: int;

procedure {:origName "aggregate_dynamic_initializer_sdv_static_function_1"} aggregate_dynamic_initializer_sdv_static_function_1();



implementation {:origName "aggregate_dynamic_initializer_sdv_static_function_1"} aggregate_dynamic_initializer_sdv_static_function_1()
{
  var Tmp: int;
  var {:pointer} Tmp_1: int;
  var li2bplRetTmp: int;
  var boogieTmp: int;

  anon0:
    goto L4;

  L4:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L0;

  L0:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L1;

  L1:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Return"} true;
    goto LM2;

  LM2:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto Lfinal;

  Lfinal:
    return;
}



procedure {:origName "foo"} foo();



implementation {:origName "foo"} foo()
{
  var {:pointer} x: int;
  var Tmp_2: int;
  var {:pointer} Tmp_3: int;
  var li2bplRetTmp: int;
  var boogieTmp: int;

  anon0:
    goto L7;

  L7:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L0;

  L0:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L4;

  L4:
    assert {:sourcefile "e:\slam1\other\akashl\smv\sanity.c"} {:sourceline 3} {:print "Atomic Assignment"} true;
    x := NULL;
    goto L9;

  L9:
    assert {:sourcefile "e:\slam1\other\akashl\smv\sanity.c"} {:sourceline 4} {:print "Atomic Assignment"} true;
    assert {:nonnull} !(x == NULL);
    assume x > 0;
    Mem_T.INT4[x] := 1;
    goto L10;

  L10:
    assert {:sourcefile "e:\slam1\other\akashl\smv\sanity.c"} {:sourceline 5} {:print "Return"} true;
    goto LM2;

  LM2:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto Lfinal;

  Lfinal:
    return;
}



procedure {:origName "_sdv_init1"} _sdv_init1();



implementation {:origName "_sdv_init1"} _sdv_init1()
{
  var Tmp_4: int;
  var {:pointer} Tmp_5: int;
  var li2bplRetTmp: int;
  var boogieTmp: int;

  anon0:
    goto L8;

  L8:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L6;

  L6:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L4;

  L4:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Return"} true;
    goto LM2;

  LM2:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto Lfinal;

  Lfinal:
    return;
}



procedure {:origName "aggregate_static_initializer_sdv_static_function_1"} aggregate_static_initializer_sdv_static_function_1();



implementation {:origName "aggregate_static_initializer_sdv_static_function_1"} aggregate_static_initializer_sdv_static_function_1()
{
  var {:pointer} Tmp_6: int;
  var Tmp_7: int;
  var li2bplRetTmp: int;
  var boogieTmp: int;

  anon0:
    goto L4;

  L4:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L0;

  L0:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto L1;

  L1:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Return"} true;
    goto LM2;

  LM2:
    assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"} true;
    goto Lfinal;

  Lfinal:
    return;
}



var Mem_T.INT4: [int]int;

procedure {:dopa "Mem_T.INT4"} dummy_for_pa();



procedure corralExtraInit();



implementation corralExtraInit()
{

  anon0:
    assume alloc_init < alloc;
    return;
}



function {:aliasingQuery} aliasQ0(x: int, y: int) : bool;
