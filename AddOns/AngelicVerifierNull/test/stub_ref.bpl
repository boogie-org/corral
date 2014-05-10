procedure corral_nondet() returns (x:int);
procedure boogie_si_record_li2bpl_int(x:int);
var alloc: int;
const alloc_init: int;
procedure {:allocator} __HAVOC_malloc(size:int) returns (ret: int);
   modifies alloc;
//   free requires size >= 0;
//   free ensures ret == old(alloc);
//   free ensures alloc >= old(alloc) + size;

procedure {:allocator "full"} __HAVOC_malloc_full(size:int) returns (ret: int);
   modifies alloc;
   free requires size >= 0;
   free ensures (ret == old(alloc));
   free ensures alloc >= old(alloc) + size;

const {:allocated} NULL: int; axiom NULL == 0;
function BAND(a:int, b:int) : int;
function BOR(a:int, b:int) : int;
function BNOT(a:int) : int;
function INTDIV(a:int, b:int) : int;
function INTMOD(a:int, b:int) : int;

// ---- Globals -----
var {:scalar} yogi:int;
// ----- Procedures -------
procedure {:origName "aggregate_dynamic_initializer_sdv_static_function_1"}   aggregate_dynamic_initializer_sdv_static_function_1() {
var  {:scalar} Tmp: int;
var  {:pointer} Tmp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "Foo"}   Foo() returns (Tmp_2:int) {
var  {:scalar} d1: int;
var  {:scalar} sdv: int;
var  {:pointer} Tmp_3: int;
var  {:scalar} sdv_1: int;
var  {:scalar} sdv_2: int;
var  {:scalar} d2: int;
var  {:pointer} Tmp_4: int;
var  {:pointer} c1: int;
var  {:pointer} c2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call c1 := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L30;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L1:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 27} {:print "Return"}  true;
    goto LM2;
L7:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(4);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 13} {:print "Atomic Continuation"}  true;
  call sdv := malloc( 4);   goto L10;
L10:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 13} {:print "Atomic Assignment"}  true;
      c2 := sdv;  goto L32;
L17:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(f_S(c2));
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 18} {:print "Atomic Continuation"}  true;
  assume {:nonnull} c2 != NULL; assume c2 > 0;
call d2 := stub_ref( f_S(c2));   goto L21;
L21:
  call {:cexpr "d1"} boogie_si_record_li2bpl_int(d1);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 20} {:print "Atomic Conditional"}  true;
    if(*) { assume (d1 == NULL);  goto L22; } else { assume (d1 != NULL);  goto L23; }
L22:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 21} {:print "Atomic Assignment"}  true;
      Tmp_2 := NULL;  goto L39;
L23:
  call {:cexpr "d2"} boogie_si_record_li2bpl_int(d2);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 20} {:print "Atomic Conditional"}  true;
    if(*) { assume (d2 == NULL);  goto L22; } else { assume (d2 != NULL);  goto L24; }
L24:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 23} {:print "Atomic Assignment"}  true;
    assert /*assume*/ {:nonnull} Mem_T.PINT4[c1] != NULL; assume Mem_T.PINT4[c1] > 0;
assume {:nonnull} c1 != NULL; assume c1 > 0;
  Mem_T.INT4[Mem_T.PINT4[c1]] := 5;  goto L35;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L32:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 15} {:print "Atomic Assignment"}  true;
    assume {:nonnull} c1 != NULL; assume c1 > 0;
  Mem_T.PINT4[c1] := NULL;  goto L33;
L33:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 16} {:print "Atomic Assignment"}  true;
    assume {:nonnull} c2 != NULL; assume c2 > 0;
  Mem_T.PINT4[f_S(c2)] := NULL;  goto L34;
L34:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(c1);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 17} {:print "Atomic Continuation"}  true;
  call d1 := stub_ref( c1);   goto L17;
L35:
  call {:cexpr "c2->f"} boogie_si_record_li2bpl_int(Mem_T.PINT4[f_S(c2)]);
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 24} {:print "Atomic Assignment"}  true;
    assume {:nonnull} c2 != NULL; assume c2 > 0;
  Tmp_4 := Mem_T.PINT4[f_S(c2)];  goto L36;
L36:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 24} {:print "Atomic Assignment"}  true;
    assert /*assume*/ {:nonnull} Tmp_4 != NULL; assume Tmp_4 > 0;
  Mem_T.INT4[Tmp_4] := 6;  goto L37;
L37:
  assert {:sourcefile "e:\slam_akashl\other\akashl\smv\t9.c"} {:sourceline 26} {:print "Atomic Assignment"}  true;
      Tmp_2 := 1;  goto L38;
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L39:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "_sdv_init1"}   _sdv_init1() {
var  {:scalar} Tmp_5: int;
var  {:pointer} Tmp_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
Lfinal: return;
}
procedure {:origName "aggregate_static_initializer_sdv_static_function_1"}   aggregate_static_initializer_sdv_static_function_1() {
var  {:pointer} Tmp_7: int;
var  {:scalar} Tmp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
// ---- Stubs -----
//procedure {:origName "malloc"} malloc({:scalar}  x0:int)  returns ({:scalar} r:int);
procedure {:origName "malloc"} malloc({:scalar}  x0:int)  returns ({:scalar} r:int);
procedure {:origName "stub_ref"} stub_ref({:pointer} {:ref "Mem_T.PINT4"} x0:int)  returns ({:scalar} r:int);
// ----- Decls -------
var {:scalar} Mem_T.INT4: [int] int;
var {:scalar} Mem_T.PINT4: [int] int;
var {:pointer} Mem_T.f_S: [int] int;
procedure {:dopa "Mem_T.INT4"} dummy_for_pa();
procedure corralExtraInit() {
  assume alloc_init < alloc;
   assume (forall x : int :: {Mem_T.f_S[x]} (Mem_T.f_S[x] < alloc_init) && (Mem_T.f_S[x] > 0) );
}
function {:inline true} {:fieldmap "Mem_T.PINT4"}  {:fieldname "f"}  f_S(x:int) returns (int) {x + 0}
