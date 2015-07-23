var $M.0: int;

var $M.1: [ref]int;

var $M.2: [ref]int;

var $M.3: [ref]int;

type i1 = int;

type i2 = int;

type i4 = int;

type i8 = int;

type i16 = int;

type i32 = int;

type i64 = int;

type ref = int;

type size = int;

axiom NULL == NULL;

axiom $GLOBALS_BOTTOM == -100;

axiom $EXTERNS_BOTTOM == -32768;

axiom $MALLOC_TOP == 2136997887;

axiom $1.ref == 1;

axiom $2.ref == 2;

axiom $3.ref == 3;

axiom $4.ref == 4;

axiom $5.ref == 5;

axiom $6.ref == 6;

axiom $7.ref == 7;

function {:inline} $zext.i32.ref(p: int) : int
{
  $zext.i32.i64(p)
}

function {:inline} $p2i.i8(p: int) : int
{
  $trunc.i64.i8(p)
}

function {:inline} $i2p.i8(p: int) : int
{
  $zext.i8.i64(p)
}

function {:inline} $p2i.i16(p: int) : int
{
  $trunc.i64.i16(p)
}

function {:inline} $i2p.i16(p: int) : int
{
  $zext.i16.i64(p)
}

function {:inline} $p2i.i32(p: int) : int
{
  $trunc.i64.i32(p)
}

function {:inline} $i2p.i32(p: int) : int
{
  $zext.i32.i64(p)
}

function {:inline} $p2i.i64(p: int) : int
{
  p
}

function {:inline} $i2p.i64(p: int) : int
{
  p
}

const P: int;

const Q: int;

const __SMACK_code: int;

const __SMACK_decls: int;

const __SMACK_dummy: int;

const __SMACK_top_decl: int;

const bar: int;

const foo: int;

const llvm.dbg.declare: int;

const llvm.dbg.value: int;

const malloc: int;

const x: int;

const y: int;

procedure $static_init();
  modifies $CurrAddr, $M.0, $M.1;



implementation $static_init()
{

  anon0:
    $CurrAddr := 1024;
    $M.0 := NULL;
    assert !(x == NULL);
    $M.1[x] := NULL;
    return;
}



procedure P();
  modifies $M.3, $exn;



implementation P()
{
  var $p0: int;
  var $p1: int;
  var $p2: int;
  var $p3: int;
  var $p4: int;
  var $p5: int;

  $bb0:
    assume {:sourceloc "t6.c", 10, 6} true;
    $p0 := $M.0;
    assume {:sourceloc "t6.c", 10, 6} true;
    $p1 := $eq.i32($p0, NULL);
    assume {:sourceloc "t6.c", 10, 6} true;
    goto $bb1, $bb2;

  $bb2:
    assume {:sourceloc "t6.c", 10, 6} true;
    assume !($p1 == 1);
    goto $bb3;

  $bb3:
    assume {:sourceloc "t6.c", 14, 1} true;
    $exn := false;
    return;

  $bb1:
    assume $p1 == 1;
    assume {:sourceloc "t6.c", 12, 5} true;
    assert !(x == NULL);
    $p2 := $M.1[x];
    assume {:sourceloc "t6.c", 12, 5} true;
    assert !($p2 == NULL);
    $p3 := $M.3[$p2];
    assume {:sourceloc "t6.c", 12, 5} true;
    $p4 := $add.i32($p3, 1);
    assume {:sourceloc "t6.c", 12, 5} true;
    assert !(x == NULL);
    $p5 := $M.1[x];
    assume {:sourceloc "t6.c", 12, 5} true;
    assert !($p5 == NULL);
    $M.3[$p5] := $p4;
    assume {:sourceloc "t6.c", 13, 3} true;
    goto $bb3;
}



procedure Q();
  modifies $M.3, $exn;



implementation Q()
{
  var $p0: int;
  var $p1: int;
  var $p2: int;
  var $p3: int;
  var $p4: int;
  var $p5: int;

  $bb0:
    assume {:sourceloc "t6.c", 17, 6} true;
    $p0 := $M.0;
    assume {:sourceloc "t6.c", 17, 6} true;
    $p1 := $eq.i32($p0, 1);
    assume {:sourceloc "t6.c", 17, 6} true;
    goto $bb1, $bb2;

  $bb2:
    assume {:sourceloc "t6.c", 17, 6} true;
    assume !($p1 == 1);
    goto $bb3;

  $bb3:
    assume {:sourceloc "t6.c", 21, 1} true;
    $exn := false;
    return;

  $bb1:
    assume $p1 == 1;
    assume {:sourceloc "t6.c", 19, 5} true;
    assert !(x == NULL);
    $p2 := $M.1[x];
    assume {:sourceloc "t6.c", 19, 5} true;
    assert !($p2 == NULL);
    $p3 := $M.3[$p2];
    assume {:sourceloc "t6.c", 19, 5} true;
    $p4 := $add.i32($p3, 1);
    assume {:sourceloc "t6.c", 19, 5} true;
    assert !(x == NULL);
    $p5 := $M.1[x];
    assume {:sourceloc "t6.c", 19, 5} true;
    assert !($p5 == NULL);
    $M.3[$p5] := $p4;
    assume {:sourceloc "t6.c", 20, 3} true;
    goto $bb3;
}



procedure bar() returns ($r: int);
  modifies $CurrAddr, $Alloc, $M.1, $exn, $M.3;



implementation bar() returns ($r: int)
{
  var $p0: int;
  var $p1: int;

  $bb0:
    assume {:sourceloc "t6.c", 28, 7} true;
    call $p0 := $malloc(4);
    assume {:sourceloc "t6.c", 28, 7} true;
    $p1 := $p0;
    assume {:sourceloc "t6.c", 28, 7} true;
    assert !(x == NULL);
    $M.1[x] := $p1;
    call {:cexpr "x"} boogie_si_record_i64($p1);
    assume {:sourceloc "t6.c", 29, 3} true;
    call foo(P);
    assume {:sourceloc "t6.c", 30, 3} true;
    call foo(Q);
    assume {:sourceloc "t6.c", 31, 3} true;
    $r := NULL;
    $exn := false;
    return;
}



procedure foo(f: int);
  modifies $exn, $M.3;



implementation foo(f: int)
{

  $bb0:
    call {:cexpr "f"} boogie_si_record_ref(f);
    assume {:sourceloc "t6.c", 24, 3} true;
    goto $bb2, $bb3;

  $bb3:
    assume f == Q;
    call Q();
    goto $bb1;

  $bb1:
    assume {:sourceloc "t6.c", 25, 1} true;
    $exn := false;
    return;

  $bb2:
    assume f == P;
    call P();
    goto $bb1;
}



axiom y == -4;

axiom x == -12;

axiom P == -20;

axiom Q == -28;

axiom foo == -36;

axiom llvm.dbg.declare == -44;

axiom bar == -52;

axiom malloc == -60;

axiom __SMACK_dummy == -68;

axiom __SMACK_code == -76;

axiom __SMACK_decls == -84;

axiom __SMACK_top_decl == -92;

axiom llvm.dbg.value == -100;

axiom NULL == NULL;

axiom NULL == NULL;

axiom $1.i1 == 1;

axiom $and.i1(NULL, NULL) == NULL;

axiom $and.i1(NULL, 1) == NULL;

axiom $and.i1(1, NULL) == NULL;

axiom $and.i1(1, 1) == 1;

axiom $or.i1(NULL, NULL) == NULL;

axiom $or.i1(NULL, 1) == 1;

axiom $or.i1(1, NULL) == 1;

axiom $or.i1(1, 1) == 1;

axiom $xor.i1(NULL, NULL) == NULL;

axiom $xor.i1(NULL, 1) == 1;

axiom $xor.i1(1, NULL) == 1;

axiom $xor.i1(1, 1) == NULL;

axiom (forall f1: float, f2: float :: f1 != f2 || $foeq(f1, f2) == $1.i1);

axiom (forall f: float :: $si2fp.i16($fp2si.i16(f)) == f);

axiom (forall f: float :: $si2fp.i32($fp2si.i32(f)) == f);

axiom (forall f: float :: $si2fp.i64($fp2si.i64(f)) == f);

axiom (forall f: float :: $si2fp.i8($fp2si.i8(f)) == f);

axiom (forall f: float :: $ui2fp.i16($fp2ui.i16(f)) == f);

axiom (forall f: float :: $ui2fp.i32($fp2ui.i32(f)) == f);

axiom (forall f: float :: $ui2fp.i64($fp2ui.i64(f)) == f);

axiom (forall f: float :: $ui2fp.i8($fp2ui.i8(f)) == f);

axiom (forall i: int :: $fp2si.i16($si2fp.i16(i)) == i);

axiom (forall i: int :: $fp2ui.i16($ui2fp.i16(i)) == i);

axiom (forall i: int :: $fp2si.i32($si2fp.i32(i)) == i);

axiom (forall i: int :: $fp2ui.i32($ui2fp.i32(i)) == i);

axiom (forall i: int :: $fp2si.i64($si2fp.i64(i)) == i);

axiom (forall i: int :: $fp2ui.i64($ui2fp.i64(i)) == i);

axiom (forall i: int :: $fp2si.i8($si2fp.i8(i)) == i);

axiom (forall i: int :: $fp2ui.i8($ui2fp.i8(i)) == i);

const $0.i1: int;

const $1.i1: int;

const $0.i32: int;

const $0.ref: int;

const $1.ref: int;

const $2.ref: int;

const $3.ref: int;

const $4.ref: int;

const $5.ref: int;

const $6.ref: int;

const $7.ref: int;

const $EXTERNS_BOTTOM: int;

const $GLOBALS_BOTTOM: int;

const $MALLOC_TOP: int;

const $MOP: $mop;

function $and.i1(p1: int, p2: int) : int;

function $and.i16(p1: int, p2: int) : int;

function $and.i32(p1: int, p2: int) : int;

function $and.i64(p1: int, p2: int) : int;

function $and.i8(p1: int, p2: int) : int;

function $and.ref(p1: int, p2: int) : int;

function $ashr.i1(p1: int, p2: int) : int;

function $ashr.i16(p1: int, p2: int) : int;

function $ashr.i32(p1: int, p2: int) : int;

function $ashr.i64(p1: int, p2: int) : int;

function $ashr.i8(p1: int, p2: int) : int;

function $ashr.ref(p1: int, p2: int) : int;

function $base(int) : int;

function $extractvalue(p: int, i: int) : int;

function $fadd(f1: float, f2: float) : float;

function $fdiv(f1: float, f2: float) : float;

function $ffalse(f1: float, f2: float) : int;

function $fmul(f1: float, f2: float) : float;

function $foeq(f1: float, f2: float) : int;

function $foge(f1: float, f2: float) : int;

function $fogt(f1: float, f2: float) : int;

function $fole(f1: float, f2: float) : int;

function $folt(f1: float, f2: float) : int;

function $fone(f1: float, f2: float) : int;

function $ford(f1: float, f2: float) : int;

function $fp(ipart: int, fpart: int, epart: int) : float;

function $fp2si.i16(f: float) : int;

function $fp2si.i32(f: float) : int;

function $fp2si.i64(f: float) : int;

function $fp2si.i8(f: float) : int;

function $fp2ui.i16(f: float) : int;

function $fp2ui.i32(f: float) : int;

function $fp2ui.i64(f: float) : int;

function $fp2ui.i8(f: float) : int;

function $frem(f1: float, f2: float) : float;

function $fsub(f1: float, f2: float) : float;

function $ftrue(f1: float, f2: float) : int;

function $fueq(f1: float, f2: float) : int;

function $fuge(f1: float, f2: float) : int;

function $fugt(f1: float, f2: float) : int;

function $fule(f1: float, f2: float) : int;

function $fult(f1: float, f2: float) : int;

function $fune(f1: float, f2: float) : int;

function $funo(f1: float, f2: float) : int;

function $lshr.i1(p1: int, p2: int) : int;

function $lshr.i16(p1: int, p2: int) : int;

function $lshr.i32(p1: int, p2: int) : int;

function $lshr.i64(p1: int, p2: int) : int;

function $lshr.i8(p1: int, p2: int) : int;

function $lshr.ref(p1: int, p2: int) : int;

function $nand.i1(p1: int, p2: int) : int;

function $nand.i16(p1: int, p2: int) : int;

function $nand.i32(p1: int, p2: int) : int;

function $nand.i64(p1: int, p2: int) : int;

function $nand.i8(p1: int, p2: int) : int;

function $nand.ref(p1: int, p2: int) : int;

function $not.i1(p: int) : int;

function $not.i16(p: int) : int;

function $not.i32(p: int) : int;

function $not.i64(p: int) : int;

function $not.i8(p: int) : int;

function $not.ref(p: int) : int;

function $or.i1(p1: int, p2: int) : int;

function $or.i16(p1: int, p2: int) : int;

function $or.i32(p1: int, p2: int) : int;

function $or.i64(p1: int, p2: int) : int;

function $or.i8(p1: int, p2: int) : int;

function $or.ref(p1: int, p2: int) : int;

function $shl.i1(p1: int, p2: int) : int;

function $shl.i16(p1: int, p2: int) : int;

function $shl.i32(p1: int, p2: int) : int;

function $shl.i64(p1: int, p2: int) : int;

function $shl.i8(p1: int, p2: int) : int;

function $shl.ref(p1: int, p2: int) : int;

function $si2fp.i16(i: int) : float;

function $si2fp.i32(i: int) : float;

function $si2fp.i64(i: int) : float;

function $si2fp.i8(i: int) : float;

function $ui2fp.i16(i: int) : float;

function $ui2fp.i32(i: int) : float;

function $ui2fp.i64(i: int) : float;

function $ui2fp.i8(i: int) : float;

function $xor.i1(p1: int, p2: int) : int;

function $xor.i16(p1: int, p2: int) : int;

function $xor.i32(p1: int, p2: int) : int;

function $xor.i64(p1: int, p2: int) : int;

function $xor.i8(p1: int, p2: int) : int;

function $xor.ref(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.i1(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.i16(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.i32(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.i64(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.i8(p1: int, p2: int) : int;

function {:builtin "div"} $sdiv.ref(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.i1(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.i16(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.i32(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.i64(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.i8(p1: int, p2: int) : int;

function {:builtin "div"} $udiv.ref(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.i1(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.i16(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.i32(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.i64(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.i8(p1: int, p2: int) : int;

function {:builtin "mod"} $smod.ref(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.i1(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.i16(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.i32(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.i64(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.i8(p1: int, p2: int) : int;

function {:builtin "rem"} $srem.ref(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.i1(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.i16(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.i32(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.i64(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.i8(p1: int, p2: int) : int;

function {:builtin "rem"} $urem.ref(p1: int, p2: int) : int;

function {:inline} $add.i1(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $add.i16(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $add.i32(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $add.i64(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $add.i8(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $add.ref(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $eq.i1(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.i16(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.i32(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.i64(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.i8(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.ref(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $isExternal(p: int) : bool
{
  $slt.ref(p, $EXTERNS_BOTTOM) == $1.i1
}

function {:inline} $max.i1(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $max.i16(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $max.i32(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $max.i64(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $max.i8(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $max.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $min.i1(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $min.i16(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $min.i32(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $min.i64(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $min.i8(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $min.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $mul.i1(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $mul.i16(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $mul.i32(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $mul.i64(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $mul.i8(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $mul.ref(p1: int, p2: int) : int
{
  p1 * p2
}

function {:inline} $ne.i1(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.i16(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.i32(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.i64(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.i8(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.ref(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $neg.i1(p: int) : int
{
  NULL - p
}

function {:inline} $neg.i16(p: int) : int
{
  NULL - p
}

function {:inline} $neg.i32(p: int) : int
{
  NULL - p
}

function {:inline} $neg.i64(p: int) : int
{
  NULL - p
}

function {:inline} $neg.i8(p: int) : int
{
  NULL - p
}

function {:inline} $neg.ref(p: int) : int
{
  NULL - p
}

function {:inline} $sext.i1.i16(p: int) : int
{
  p
}

function {:inline} $sext.i1.i32(p: int) : int
{
  p
}

function {:inline} $sext.i1.i64(p: int) : int
{
  p
}

function {:inline} $sext.i1.i8(p: int) : int
{
  p
}

function {:inline} $sext.i16.i32(p: int) : int
{
  p
}

function {:inline} $sext.i16.i64(p: int) : int
{
  p
}

function {:inline} $sext.i32.i64(p: int) : int
{
  p
}

function {:inline} $sext.i8.i16(p: int) : int
{
  p
}

function {:inline} $sext.i8.i32(p: int) : int
{
  p
}

function {:inline} $sext.i8.i64(p: int) : int
{
  p
}

function {:inline} $sge.i1(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.i16(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.i32(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.i64(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.i8(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.ref(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sgt.i1(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.i16(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.i32(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.i64(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.i8(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sle.i1(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.i16(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.i32(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.i64(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.i8(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.ref(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $slt.i1(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.i16(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.i32(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.i64(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.i8(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $sub.i1(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $sub.i16(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $sub.i32(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $sub.i64(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $sub.i8(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $sub.ref(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $trunc.i16.i1(p: int) : int
{
  p
}

function {:inline} $trunc.i16.i8(p: int) : int
{
  p
}

function {:inline} $trunc.i32.i1(p: int) : int
{
  p
}

function {:inline} $trunc.i32.i16(p: int) : int
{
  p
}

function {:inline} $trunc.i32.i8(p: int) : int
{
  p
}

function {:inline} $trunc.i64.i1(p: int) : int
{
  p
}

function {:inline} $trunc.i64.i16(p: int) : int
{
  p
}

function {:inline} $trunc.i64.i32(p: int) : int
{
  p
}

function {:inline} $trunc.i64.i8(p: int) : int
{
  p
}

function {:inline} $trunc.i8.i1(p: int) : int
{
  p
}

function {:inline} $uge.i1(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.i16(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.i32(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.i64(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.i8(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.ref(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $ugt.i1(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.i16(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.i32(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.i64(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.i8(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ule.i1(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.i16(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.i32(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.i64(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.i8(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.ref(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ult.i1(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.i16(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.i32(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.i64(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.i8(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $umax.i1(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umax.i16(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umax.i32(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umax.i64(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umax.i8(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umax.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then p1 else p2)
}

function {:inline} $umin.i1(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $umin.i16(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $umin.i32(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $umin.i64(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $umin.i8(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $umin.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then p1 else p2)
}

function {:inline} $zext.i1.i16(p: int) : int
{
  p
}

function {:inline} $zext.i1.i32(p: int) : int
{
  p
}

function {:inline} $zext.i1.i64(p: int) : int
{
  p
}

function {:inline} $zext.i1.i8(p: int) : int
{
  p
}

function {:inline} $zext.i16.i32(p: int) : int
{
  p
}

function {:inline} $zext.i16.i64(p: int) : int
{
  p
}

function {:inline} $zext.i32.i64(p: int) : int
{
  p
}

function {:inline} $zext.i8.i16(p: int) : int
{
  p
}

function {:inline} $zext.i8.i32(p: int) : int
{
  p
}

function {:inline} $zext.i8.i64(p: int) : int
{
  p
}

procedure $free(p: int);
  modifies $Alloc;
  ensures !$Alloc[p];
  ensures (forall q: int :: { $Alloc[q] } q != p ==> ($Alloc[q] <==> old($Alloc[q])));



procedure {:allocator} $malloc(n: int) returns (p: int);
  modifies $CurrAddr, $Alloc;
  ensures $sgt.ref(p, NULL) == $1.i1;
  ensures p == old($CurrAddr);
  ensures $sgt.ref($CurrAddr, old($CurrAddr)) == $1.i1;
  ensures $sge.ref(n, NULL) == $1.i1 ==> $sge.ref($CurrAddr, $add.ref(old($CurrAddr), n)) == $1.i1;
  ensures $Alloc[p];
  ensures (forall q: int :: { $Alloc[q] } q != p ==> ($Alloc[q] <==> old($Alloc[q])));
  ensures $sge.ref(n, NULL) == $1.i1 ==> (forall q: int :: { $base(q) } $sle.ref(p, q) == $1.i1 && $slt.ref(q, $add.ref(p, n)) == $1.i1 ==> $base(q) == p);



procedure __SMACK_code.ref(p0: int);



procedure __SMACK_top_decl.ref(p0: int);



procedure boogie_si_record_bool(b: bool);



procedure boogie_si_record_float(f: float);



procedure boogie_si_record_i1(i: int);



procedure boogie_si_record_i16(i: int);



procedure boogie_si_record_i32(i: int);



procedure boogie_si_record_i64(i: int);



procedure boogie_si_record_i8(i: int);



procedure boogie_si_record_mop(m: $mop);



procedure boogie_si_record_ref(i: int);



procedure llvm.dbg.value(p0: int, p1: int, p2: int);



type $mop;

type float;

var $Alloc: [ref]bool;

var $CurrAddr: int;

var $exn: bool;

var $exnv: int;

const {:allocated} NULL: int;

axiom NULL == 0;

procedure {:allocator "full"} {:AngelicUnknown} unknown_int() returns (r: int);



function {:ReachableStates} MustReach(x: bool) : bool;

const __block_call_$init_funcs: bool;

const __block_call_$static_init: bool;

const __block_call_P: bool;

const __block_call_Q: bool;

const __block_call___SMACK_dummy: bool;

const __block_call_bar: bool;

const __block_call_foo: bool;

procedure {:entrypoint} CorralMain();
  modifies $M.0, $CurrAddr, $exnv, $M.1, $M.3, $exn, $Alloc;



implementation CorralMain()
{
  var v___SMACK_dummy: int;
  var $r_bar: int;
  var f_foo: int;

  CorralMainStart:
    assume true;
    call {:ConcretizeConstantName "$M.0"} $M.0 := unknown_int();
    call {:ConcretizeConstantName "$CurrAddr"} $CurrAddr := unknown_int();
    call {:ConcretizeConstantName "$exnv"} $exnv := unknown_int();
    goto L_BAF_0, L_BAF_1, L_BAF_2, L_BAF_3, L_BAF_4, L_BAF_5, L_BAF_6;

  L_BAF_6:
    assume __block_call_foo;
    call {:ConcretizeConstantName "f_foo"} f_foo := unknown_int();
    assume MustReach(true);
    call foo(f_foo);
    return;

  L_BAF_5:
    assume __block_call_bar;
    assume MustReach(true);
    call $r_bar := bar();
    return;

  L_BAF_4:
    return;

  L_BAF_3:
    assume __block_call_Q;
    assume MustReach(true);
    call Q();
    return;

  L_BAF_2:
    assume __block_call_P;
    assume MustReach(true);
    call P();
    return;

  L_BAF_1:
    assume __block_call_$static_init;
    assume MustReach(true);
    call $static_init();
    return;

  L_BAF_0:
    return;
}


