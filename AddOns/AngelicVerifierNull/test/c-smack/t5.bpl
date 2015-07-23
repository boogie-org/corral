// BEGIN SMACK-GENERATED CODE

// Memory region declarations: 2
var $M.0: [ref] int;
var $M.1: [ref] int;

// Type declarations
type i1 = int;
type i2 = int;
type i4 = int;
type i8 = int;
type i16 = int;
type i32 = int;
type i64 = int;
type ref = int;
type size = int;

axiom $0.ref == 0;
axiom $GLOBALS_BOTTOM == -64;
axiom $EXTERNS_BOTTOM == -32768;
axiom $MALLOC_TOP == 2136997887;
axiom $1.ref == 1;
axiom $2.ref == 2;
axiom $3.ref == 3;
axiom $4.ref == 4;
axiom $5.ref == 5;
axiom $6.ref == 6;
axiom $7.ref == 7;

function {:inline} $zext.i32.ref(p: i32) returns (ref) {$zext.i32.i64(p)}
function {:inline}$p2i.i8(p: ref) returns (i8) {$trunc.i64.i8(p)}
function {:inline}$i2p.i8(p: i8) returns (ref) {$zext.i8.i64(p)}
function {:inline}$p2i.i16(p: ref) returns (i16) {$trunc.i64.i16(p)}
function {:inline}$i2p.i16(p: i16) returns (ref) {$zext.i16.i64(p)}
function {:inline}$p2i.i32(p: ref) returns (i32) {$trunc.i64.i32(p)}
function {:inline}$i2p.i32(p: i32) returns (ref) {$zext.i32.i64(p)}
function {:inline}$p2i.i64(p: ref) returns (i64) {p}
function {:inline}$i2p.i64(p: i64) returns (ref) {p}

const __SMACK_code: ref;
const __SMACK_decls: ref;
const __SMACK_dummy: ref;
const __SMACK_top_decl: ref;
const foo: ref;
const llvm.dbg.declare: ref;
const llvm.dbg.value: ref;
const main: ref;
procedure $init_funcs()
  modifies $Alloc, $CurrAddr, $exn, $exnv, $M.0, $M.1;
{
  return;
}
procedure $static_init()
  modifies $Alloc, $CurrAddr, $exn, $exnv, $M.0, $M.1;
{
  $CurrAddr := 1024;
  return;
}
procedure __SMACK_dummy(v: i32)
  modifies $Alloc, $CurrAddr, $exn, $exnv, $M.0, $M.1;
{
$bb0:
  call {:cexpr "v"} boogie_si_record_i32(v);
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 31, 3} true;
  assume true;
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 32, 1} true;
  $exn := false;
  return;
}
procedure foo(a: ref)
  returns ($r: ref)
  modifies $Alloc, $CurrAddr, $exn, $exnv, $M.0, $M.1;
{
$bb0:
  call {:cexpr "a"} boogie_si_record_ref(a);
  assume {:sourceloc "t5.c", 5, 2} true;
  $M.1[a] := 1;
  assume {:sourceloc "t5.c", 6, 2} true;
  $r := a;
  $exn := false;
  return;
}
procedure main()
  returns ($r: i32)
  modifies $Alloc, $CurrAddr, $exn, $exnv, $M.0, $M.1;
{
  var $p0: ref;
$bb0:
  call $static_init();
  call $init_funcs();
  call {:cexpr "x"} boogie_si_record_ref(0);
  assume {:sourceloc "t5.c", 11, 2} true;
  call $p0 := foo(0);
  assume {:sourceloc "t5.c", 12, 2} true;
  $r := 0;
  $exn := false;
  return;
}
axiom (foo == -8);
axiom (llvm.dbg.declare == -16);
axiom (main == -24);
axiom (__SMACK_dummy == -32);
axiom (__SMACK_code == -40);
axiom (__SMACK_decls == -48);
axiom (__SMACK_top_decl == -56);
axiom (llvm.dbg.value == -64);
axiom $0.i1 == 0;
axiom $0.i32 == 0;
axiom $1.i1 == 1;
axiom $and.i1(0,0) == 0;
axiom $and.i1(0,1) == 0;
axiom $and.i1(1,0) == 0;
axiom $and.i1(1,1) == 1;
axiom $or.i1(0,0) == 0;
axiom $or.i1(0,1) == 1;
axiom $or.i1(1,0) == 1;
axiom $or.i1(1,1) == 1;
axiom $xor.i1(0,0) == 0;
axiom $xor.i1(0,1) == 1;
axiom $xor.i1(1,0) == 1;
axiom $xor.i1(1,1) == 0;
axiom (forall f1, f2: float :: f1 != f2 || $foeq(f1,f2) == $1.i1);
axiom (forall f: float :: $si2fp.i16($fp2si.i16(f)) == f);
axiom (forall f: float :: $si2fp.i32($fp2si.i32(f)) == f);
axiom (forall f: float :: $si2fp.i64($fp2si.i64(f)) == f);
axiom (forall f: float :: $si2fp.i8($fp2si.i8(f)) == f);
axiom (forall f: float :: $ui2fp.i16($fp2ui.i16(f)) == f);
axiom (forall f: float :: $ui2fp.i32($fp2ui.i32(f)) == f);
axiom (forall f: float :: $ui2fp.i64($fp2ui.i64(f)) == f);
axiom (forall f: float :: $ui2fp.i8($fp2ui.i8(f)) == f);
axiom (forall i: i16 :: $fp2si.i16($si2fp.i16(i)) == i);
axiom (forall i: i16 :: $fp2ui.i16($ui2fp.i16(i)) == i);
axiom (forall i: i32 :: $fp2si.i32($si2fp.i32(i)) == i);
axiom (forall i: i32 :: $fp2ui.i32($ui2fp.i32(i)) == i);
axiom (forall i: i64 :: $fp2si.i64($si2fp.i64(i)) == i);
axiom (forall i: i64 :: $fp2ui.i64($ui2fp.i64(i)) == i);
axiom (forall i: i8 :: $fp2si.i8($si2fp.i8(i)) == i);
axiom (forall i: i8 :: $fp2ui.i8($ui2fp.i8(i)) == i);
const $0.i1, $1.i1: i1;
const $0.i32: i32;
const $0.ref, $1.ref, $2.ref, $3.ref, $4.ref, $5.ref, $6.ref, $7.ref: ref;
const $EXTERNS_BOTTOM: ref;
const $GLOBALS_BOTTOM: ref;
const $MALLOC_TOP: ref;
const $MOP: $mop;
function $and.i1(p1: i1, p2: i1) returns (i1);
function $and.i16(p1: i16, p2: i16) returns (i16);
function $and.i32(p1: i32, p2: i32) returns (i32);
function $and.i64(p1: i64, p2: i64) returns (i64);
function $and.i8(p1: i8, p2: i8) returns (i8);
function $and.ref(p1: ref, p2: ref) returns (ref);
function $ashr.i1(p1: i1, p2: i1) returns (i1);
function $ashr.i16(p1: i16, p2: i16) returns (i16);
function $ashr.i32(p1: i32, p2: i32) returns (i32);
function $ashr.i64(p1: i64, p2: i64) returns (i64);
function $ashr.i8(p1: i8, p2: i8) returns (i8);
function $ashr.ref(p1: ref, p2: ref) returns (ref);
function $base(ref) returns (ref);
function $extractvalue(p: int, i: int) returns (int);
function $fadd(f1:float, f2:float) returns (float);
function $fdiv(f1:float, f2:float) returns (float);
function $ffalse(f1:float, f2:float) returns (i1);
function $fmul(f1:float, f2:float) returns (float);
function $foeq(f1:float, f2:float) returns (i1);
function $foge(f1:float, f2:float) returns (i1);
function $fogt(f1:float, f2:float) returns (i1);
function $fole(f1:float, f2:float) returns (i1);
function $folt(f1:float, f2:float) returns (i1);
function $fone(f1:float, f2:float) returns (i1);
function $ford(f1:float, f2:float) returns (i1);
function $fp(ipart:int, fpart:int, epart:int) returns (float);
function $fp2si.i16(f:float) returns (i16);
function $fp2si.i32(f:float) returns (i32);
function $fp2si.i64(f:float) returns (i64);
function $fp2si.i8(f:float) returns (i8);
function $fp2ui.i16(f:float) returns (i16);
function $fp2ui.i32(f:float) returns (i32);
function $fp2ui.i64(f:float) returns (i64);
function $fp2ui.i8(f:float) returns (i8);
function $frem(f1:float, f2:float) returns (float);
function $fsub(f1:float, f2:float) returns (float);
function $ftrue(f1:float, f2:float) returns (i1);
function $fueq(f1:float, f2:float) returns (i1);
function $fuge(f1:float, f2:float) returns (i1);
function $fugt(f1:float, f2:float) returns (i1);
function $fule(f1:float, f2:float) returns (i1);
function $fult(f1:float, f2:float) returns (i1);
function $fune(f1:float, f2:float) returns (i1);
function $funo(f1:float, f2:float) returns (i1);
function $lshr.i1(p1: i1, p2: i1) returns (i1);
function $lshr.i16(p1: i16, p2: i16) returns (i16);
function $lshr.i32(p1: i32, p2: i32) returns (i32);
function $lshr.i64(p1: i64, p2: i64) returns (i64);
function $lshr.i8(p1: i8, p2: i8) returns (i8);
function $lshr.ref(p1: ref, p2: ref) returns (ref);
function $nand.i1(p1: i1, p2: i1) returns (i1);
function $nand.i16(p1: i16, p2: i16) returns (i16);
function $nand.i32(p1: i32, p2: i32) returns (i32);
function $nand.i64(p1: i64, p2: i64) returns (i64);
function $nand.i8(p1: i8, p2: i8) returns (i8);
function $nand.ref(p1: ref, p2: ref) returns (ref);
function $not.i1(p: i1) returns (i1);
function $not.i16(p: i16) returns (i16);
function $not.i32(p: i32) returns (i32);
function $not.i64(p: i64) returns (i64);
function $not.i8(p: i8) returns (i8);
function $not.ref(p: ref) returns (ref);
function $or.i1(p1: i1, p2: i1) returns (i1);
function $or.i16(p1: i16, p2: i16) returns (i16);
function $or.i32(p1: i32, p2: i32) returns (i32);
function $or.i64(p1: i64, p2: i64) returns (i64);
function $or.i8(p1: i8, p2: i8) returns (i8);
function $or.ref(p1: ref, p2: ref) returns (ref);
function $shl.i1(p1: i1, p2: i1) returns (i1);
function $shl.i16(p1: i16, p2: i16) returns (i16);
function $shl.i32(p1: i32, p2: i32) returns (i32);
function $shl.i64(p1: i64, p2: i64) returns (i64);
function $shl.i8(p1: i8, p2: i8) returns (i8);
function $shl.ref(p1: ref, p2: ref) returns (ref);
function $si2fp.i16(i:i16) returns (float);
function $si2fp.i32(i:i32) returns (float);
function $si2fp.i64(i:i64) returns (float);
function $si2fp.i8(i:i8) returns (float);
function $ui2fp.i16(i:i16) returns (float);
function $ui2fp.i32(i:i32) returns (float);
function $ui2fp.i64(i:i64) returns (float);
function $ui2fp.i8(i:i8) returns (float);
function $xor.i1(p1: i1, p2: i1) returns (i1);
function $xor.i16(p1: i16, p2: i16) returns (i16);
function $xor.i32(p1: i32, p2: i32) returns (i32);
function $xor.i64(p1: i64, p2: i64) returns (i64);
function $xor.i8(p1: i8, p2: i8) returns (i8);
function $xor.ref(p1: ref, p2: ref) returns (ref);
function {:builtin "div"} $sdiv.i1(p1: i1, p2: i1) returns (i1);
function {:builtin "div"} $sdiv.i16(p1: i16, p2: i16) returns (i16);
function {:builtin "div"} $sdiv.i32(p1: i32, p2: i32) returns (i32);
function {:builtin "div"} $sdiv.i64(p1: i64, p2: i64) returns (i64);
function {:builtin "div"} $sdiv.i8(p1: i8, p2: i8) returns (i8);
function {:builtin "div"} $sdiv.ref(p1: ref, p2: ref) returns (ref);
function {:builtin "div"} $udiv.i1(p1: i1, p2: i1) returns (i1);
function {:builtin "div"} $udiv.i16(p1: i16, p2: i16) returns (i16);
function {:builtin "div"} $udiv.i32(p1: i32, p2: i32) returns (i32);
function {:builtin "div"} $udiv.i64(p1: i64, p2: i64) returns (i64);
function {:builtin "div"} $udiv.i8(p1: i8, p2: i8) returns (i8);
function {:builtin "div"} $udiv.ref(p1: ref, p2: ref) returns (ref);
function {:builtin "mod"} $smod.i1(p1: i1, p2: i1) returns (i1);
function {:builtin "mod"} $smod.i16(p1: i16, p2: i16) returns (i16);
function {:builtin "mod"} $smod.i32(p1: i32, p2: i32) returns (i32);
function {:builtin "mod"} $smod.i64(p1: i64, p2: i64) returns (i64);
function {:builtin "mod"} $smod.i8(p1: i8, p2: i8) returns (i8);
function {:builtin "mod"} $smod.ref(p1: ref, p2: ref) returns (ref);
function {:builtin "rem"} $srem.i1(p1: i1, p2: i1) returns (i1);
function {:builtin "rem"} $srem.i16(p1: i16, p2: i16) returns (i16);
function {:builtin "rem"} $srem.i32(p1: i32, p2: i32) returns (i32);
function {:builtin "rem"} $srem.i64(p1: i64, p2: i64) returns (i64);
function {:builtin "rem"} $srem.i8(p1: i8, p2: i8) returns (i8);
function {:builtin "rem"} $srem.ref(p1: ref, p2: ref) returns (ref);
function {:builtin "rem"} $urem.i1(p1: i1, p2: i1) returns (i1);
function {:builtin "rem"} $urem.i16(p1: i16, p2: i16) returns (i16);
function {:builtin "rem"} $urem.i32(p1: i32, p2: i32) returns (i32);
function {:builtin "rem"} $urem.i64(p1: i64, p2: i64) returns (i64);
function {:builtin "rem"} $urem.i8(p1: i8, p2: i8) returns (i8);
function {:builtin "rem"} $urem.ref(p1: ref, p2: ref) returns (ref);
function {:inline} $add.i1(p1: i1, p2: i1) returns (i1) {p1 + p2}
function {:inline} $add.i16(p1: i16, p2: i16) returns (i16) {p1 + p2}
function {:inline} $add.i32(p1: i32, p2: i32) returns (i32) {p1 + p2}
function {:inline} $add.i64(p1: i64, p2: i64) returns (i64) {p1 + p2}
function {:inline} $add.i8(p1: i8, p2: i8) returns (i8) {p1 + p2}
function {:inline} $add.ref(p1: ref, p2: ref) returns (ref) {p1 + p2}
function {:inline} $eq.i1(p1: i1, p2: i1) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $eq.i16(p1: i16, p2: i16) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $eq.i32(p1: i32, p2: i32) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $eq.i64(p1: i64, p2: i64) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $eq.i8(p1: i8, p2: i8) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $eq.ref(p1: ref, p2: ref) returns (i1) {if p1 == p2 then 1 else 0}
function {:inline} $isExternal(p: ref) returns (bool) {$slt.ref(p,$EXTERNS_BOTTOM) == $1.i1}
function {:inline} $max.i1(p1: i1, p2: i1) returns (i1) {if p1 > p2 then p1 else p2}
function {:inline} $max.i16(p1: i16, p2: i16) returns (i16) {if p1 > p2 then p1 else p2}
function {:inline} $max.i32(p1: i32, p2: i32) returns (i32) {if p1 > p2 then p1 else p2}
function {:inline} $max.i64(p1: i64, p2: i64) returns (i64) {if p1 > p2 then p1 else p2}
function {:inline} $max.i8(p1: i8, p2: i8) returns (i8) {if p1 > p2 then p1 else p2}
function {:inline} $max.ref(p1: ref, p2: ref) returns (ref) {if p1 > p2 then p1 else p2}
function {:inline} $min.i1(p1: i1, p2: i1) returns (i1) {if p1 < p2 then p1 else p2}
function {:inline} $min.i16(p1: i16, p2: i16) returns (i16) {if p1 < p2 then p1 else p2}
function {:inline} $min.i32(p1: i32, p2: i32) returns (i32) {if p1 < p2 then p1 else p2}
function {:inline} $min.i64(p1: i64, p2: i64) returns (i64) {if p1 < p2 then p1 else p2}
function {:inline} $min.i8(p1: i8, p2: i8) returns (i8) {if p1 < p2 then p1 else p2}
function {:inline} $min.ref(p1: ref, p2: ref) returns (ref) {if p1 < p2 then p1 else p2}
function {:inline} $mul.i1(p1: i1, p2: i1) returns (i1) {p1 * p2}
function {:inline} $mul.i16(p1: i16, p2: i16) returns (i16) {p1 * p2}
function {:inline} $mul.i32(p1: i32, p2: i32) returns (i32) {p1 * p2}
function {:inline} $mul.i64(p1: i64, p2: i64) returns (i64) {p1 * p2}
function {:inline} $mul.i8(p1: i8, p2: i8) returns (i8) {p1 * p2}
function {:inline} $mul.ref(p1: ref, p2: ref) returns (ref) {p1 * p2}
function {:inline} $ne.i1(p1: i1, p2: i1) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $ne.i16(p1: i16, p2: i16) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $ne.i32(p1: i32, p2: i32) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $ne.i64(p1: i64, p2: i64) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $ne.i8(p1: i8, p2: i8) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $ne.ref(p1: ref, p2: ref) returns (i1) {if p1 != p2 then 1 else 0}
function {:inline} $neg.i1(p: i1) returns (i1) {0 - p}
function {:inline} $neg.i16(p: i16) returns (i16) {0 - p}
function {:inline} $neg.i32(p: i32) returns (i32) {0 - p}
function {:inline} $neg.i64(p: i64) returns (i64) {0 - p}
function {:inline} $neg.i8(p: i8) returns (i8) {0 - p}
function {:inline} $neg.ref(p: ref) returns (ref) {0 - p}
function {:inline} $sext.i1.i16(p: i1) returns (i16) {p}
function {:inline} $sext.i1.i32(p: i1) returns (i32) {p}
function {:inline} $sext.i1.i64(p: i1) returns (i64) {p}
function {:inline} $sext.i1.i8(p: i1) returns (i8) {p}
function {:inline} $sext.i16.i32(p: i16) returns (i32) {p}
function {:inline} $sext.i16.i64(p: i16) returns (i64) {p}
function {:inline} $sext.i32.i64(p: i32) returns (i64) {p}
function {:inline} $sext.i8.i16(p: i8) returns (i16) {p}
function {:inline} $sext.i8.i32(p: i8) returns (i32) {p}
function {:inline} $sext.i8.i64(p: i8) returns (i64) {p}
function {:inline} $sge.i1(p1: i1, p2: i1) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sge.i16(p1: i16, p2: i16) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sge.i32(p1: i32, p2: i32) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sge.i64(p1: i64, p2: i64) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sge.i8(p1: i8, p2: i8) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sge.ref(p1: ref, p2: ref) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $sgt.i1(p1: i1, p2: i1) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sgt.i16(p1: i16, p2: i16) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sgt.i32(p1: i32, p2: i32) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sgt.i64(p1: i64, p2: i64) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sgt.i8(p1: i8, p2: i8) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sgt.ref(p1: ref, p2: ref) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $sle.i1(p1: i1, p2: i1) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $sle.i16(p1: i16, p2: i16) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $sle.i32(p1: i32, p2: i32) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $sle.i64(p1: i64, p2: i64) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $sle.i8(p1: i8, p2: i8) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $sle.ref(p1: ref, p2: ref) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $slt.i1(p1: i1, p2: i1) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $slt.i16(p1: i16, p2: i16) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $slt.i32(p1: i32, p2: i32) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $slt.i64(p1: i64, p2: i64) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $slt.i8(p1: i8, p2: i8) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $slt.ref(p1: ref, p2: ref) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $sub.i1(p1: i1, p2: i1) returns (i1) {p1 - p2}
function {:inline} $sub.i16(p1: i16, p2: i16) returns (i16) {p1 - p2}
function {:inline} $sub.i32(p1: i32, p2: i32) returns (i32) {p1 - p2}
function {:inline} $sub.i64(p1: i64, p2: i64) returns (i64) {p1 - p2}
function {:inline} $sub.i8(p1: i8, p2: i8) returns (i8) {p1 - p2}
function {:inline} $sub.ref(p1: ref, p2: ref) returns (ref) {p1 - p2}
function {:inline} $trunc.i16.i1(p: i16) returns (i1) {p}
function {:inline} $trunc.i16.i8(p: i16) returns (i8) {p}
function {:inline} $trunc.i32.i1(p: i32) returns (i1) {p}
function {:inline} $trunc.i32.i16(p: i32) returns (i16) {p}
function {:inline} $trunc.i32.i8(p: i32) returns (i8) {p}
function {:inline} $trunc.i64.i1(p: i64) returns (i1) {p}
function {:inline} $trunc.i64.i16(p: i64) returns (i16) {p}
function {:inline} $trunc.i64.i32(p: i64) returns (i32) {p}
function {:inline} $trunc.i64.i8(p: i64) returns (i8) {p}
function {:inline} $trunc.i8.i1(p: i8) returns (i1) {p}
function {:inline} $uge.i1(p1: i1, p2: i1) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $uge.i16(p1: i16, p2: i16) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $uge.i32(p1: i32, p2: i32) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $uge.i64(p1: i64, p2: i64) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $uge.i8(p1: i8, p2: i8) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $uge.ref(p1: ref, p2: ref) returns (i1) {if p1 >= p2 then 1 else 0}
function {:inline} $ugt.i1(p1: i1, p2: i1) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ugt.i16(p1: i16, p2: i16) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ugt.i32(p1: i32, p2: i32) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ugt.i64(p1: i64, p2: i64) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ugt.i8(p1: i8, p2: i8) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ugt.ref(p1: ref, p2: ref) returns (i1) {if p1 > p2 then 1 else 0}
function {:inline} $ule.i1(p1: i1, p2: i1) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ule.i16(p1: i16, p2: i16) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ule.i32(p1: i32, p2: i32) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ule.i64(p1: i64, p2: i64) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ule.i8(p1: i8, p2: i8) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ule.ref(p1: ref, p2: ref) returns (i1) {if p1 <= p2 then 1 else 0}
function {:inline} $ult.i1(p1: i1, p2: i1) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $ult.i16(p1: i16, p2: i16) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $ult.i32(p1: i32, p2: i32) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $ult.i64(p1: i64, p2: i64) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $ult.i8(p1: i8, p2: i8) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $ult.ref(p1: ref, p2: ref) returns (i1) {if p1 < p2 then 1 else 0}
function {:inline} $umax.i1(p1: i1, p2: i1) returns (i1) {if p1 > p2 then p1 else p2}
function {:inline} $umax.i16(p1: i16, p2: i16) returns (i16) {if p1 > p2 then p1 else p2}
function {:inline} $umax.i32(p1: i32, p2: i32) returns (i32) {if p1 > p2 then p1 else p2}
function {:inline} $umax.i64(p1: i64, p2: i64) returns (i64) {if p1 > p2 then p1 else p2}
function {:inline} $umax.i8(p1: i8, p2: i8) returns (i8) {if p1 > p2 then p1 else p2}
function {:inline} $umax.ref(p1: ref, p2: ref) returns (ref) {if p1 > p2 then p1 else p2}
function {:inline} $umin.i1(p1: i1, p2: i1) returns (i1) {if p1 < p2 then p1 else p2}
function {:inline} $umin.i16(p1: i16, p2: i16) returns (i16) {if p1 < p2 then p1 else p2}
function {:inline} $umin.i32(p1: i32, p2: i32) returns (i32) {if p1 < p2 then p1 else p2}
function {:inline} $umin.i64(p1: i64, p2: i64) returns (i64) {if p1 < p2 then p1 else p2}
function {:inline} $umin.i8(p1: i8, p2: i8) returns (i8) {if p1 < p2 then p1 else p2}
function {:inline} $umin.ref(p1: ref, p2: ref) returns (ref) {if p1 < p2 then p1 else p2}
function {:inline} $zext.i1.i16(p: i1) returns (i16) {p}
function {:inline} $zext.i1.i32(p: i1) returns (i32) {p}
function {:inline} $zext.i1.i64(p: i1) returns (i64) {p}
function {:inline} $zext.i1.i8(p: i1) returns (i8) {p}
function {:inline} $zext.i16.i32(p: i16) returns (i32) {p}
function {:inline} $zext.i16.i64(p: i16) returns (i64) {p}
function {:inline} $zext.i32.i64(p: i32) returns (i64) {p}
function {:inline} $zext.i8.i16(p: i8) returns (i16) {p}
function {:inline} $zext.i8.i32(p: i8) returns (i32) {p}
function {:inline} $zext.i8.i64(p: i8) returns (i64) {p}
procedure $alloca(n: size) returns (p: ref);
modifies $CurrAddr, $Alloc;
ensures $sgt.ref(p, $0.ref) == $1.i1;
ensures p == old($CurrAddr);
ensures $sgt.ref($CurrAddr, old($CurrAddr)) == $1.i1;
ensures $sge.ref(n, $0.ref) == $1.i1 ==> $sge.ref($CurrAddr, $add.ref(old($CurrAddr), n)) == $1.i1;
ensures $Alloc[p];
ensures (forall q: ref :: {$Alloc[q]} q != p ==> $Alloc[q] == old($Alloc[q]));
ensures $sge.ref(n, $0.ref) == $1.i1 ==> (forall q: ref :: {$base(q)} $sle.ref(p, q) == $1.i1 && $slt.ref(q, $add.ref(p, n)) == $1.i1 ==> $base(q) == p);
procedure $free(p: ref);
modifies $Alloc;
ensures !$Alloc[p];
ensures (forall q: ref :: {$Alloc[q]} q != p ==> $Alloc[q] == old($Alloc[q]));
procedure $malloc(n: size) returns (p: ref);
modifies $CurrAddr, $Alloc;
ensures $sgt.ref(p, $0.ref) == $1.i1;
ensures p == old($CurrAddr);
ensures $sgt.ref($CurrAddr, old($CurrAddr)) == $1.i1;
ensures $sge.ref(n, $0.ref) == $1.i1 ==> $sge.ref($CurrAddr, $add.ref(old($CurrAddr), n)) == $1.i1;
ensures $Alloc[p];
ensures (forall q: ref :: {$Alloc[q]} q != p ==> $Alloc[q] == old($Alloc[q]));
ensures $sge.ref(n, $0.ref) == $1.i1 ==> (forall q: ref :: {$base(q)} $sle.ref(p, q) == $1.i1 && $slt.ref(q, $add.ref(p, n)) == $1.i1 ==> $base(q) == p);
procedure __SMACK_code.ref(p0:ref);
procedure __SMACK_top_decl.ref(p0:ref);
procedure boogie_si_record_bool(b: bool);
procedure boogie_si_record_float(f: float);
procedure boogie_si_record_i1(i: i1);
procedure boogie_si_record_i16(i: i16);
procedure boogie_si_record_i32(i: i32);
procedure boogie_si_record_i64(i: i64);
procedure boogie_si_record_i8(i: i8);
procedure boogie_si_record_mop(m: $mop);
procedure boogie_si_record_ref(i: ref);
procedure llvm.dbg.value(p0:ref, p1:i64, p2:ref);
type $mop;
type float;
var $Alloc: [ref] bool;
var $CurrAddr:ref;
var $exn: bool;
var $exnv: int;

// END SMACK-GENERATED CODE
