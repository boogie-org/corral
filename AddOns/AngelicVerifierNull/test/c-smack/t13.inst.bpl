type i1 = int;

type i8 = int;

type i16 = int;

type i24 = int;

type i32 = int;

type i40 = int;

type i48 = int;

type i56 = int;

type i64 = int;

type i96 = int;

type i128 = int;

type ref = i64;

type float = i32;

var $M.0: [ref]i8;

var $M.1: [ref]i8;

axiom $GLOBALS_BOTTOM == NULL - 156;

axiom $EXTERNS_BOTTOM == NULL - 32768;

function {:builtin "bv2int"} $bv2int.64(i: bv64) : int;

function {:builtin "(_ int2bv 64)"} $int2bv.64(i: int) : bv64;

function {:inline} $p2i.ref.i8(p: int) : int
{
  p
}

function {:inline} $i2p.i8.ref(i: int) : int
{
  i
}

function {:inline} $p2i.ref.i16(p: int) : int
{
  p
}

function {:inline} $i2p.i16.ref(i: int) : int
{
  i
}

function {:inline} $p2i.ref.i32(p: int) : int
{
  p
}

function {:inline} $i2p.i32.ref(i: int) : int
{
  i
}

function {:inline} $p2i.ref.i64(p: int) : int
{
  p
}

function {:inline} $i2p.i64.ref(i: int) : int
{
  i
}

function {:inline} $eq.ref(p1: int, p2: int) : int
{
  (if p1 == p2 then 1 else NULL)
}

function {:inline} $eq.ref.bool(p1: int, p2: int) : bool
{
  p1 == p2
}

function {:inline} $ne.ref(p1: int, p2: int) : int
{
  (if p1 != p2 then 1 else NULL)
}

function {:inline} $ne.ref.bool(p1: int, p2: int) : bool
{
  p1 != p2
}

function {:inline} $ugt.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $ugt.ref.bool(p1: int, p2: int) : bool
{
  p1 > p2
}

function {:inline} $uge.ref(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $uge.ref.bool(p1: int, p2: int) : bool
{
  p1 >= p2
}

function {:inline} $ult.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $ult.ref.bool(p1: int, p2: int) : bool
{
  p1 < p2
}

function {:inline} $ule.ref(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $ule.ref.bool(p1: int, p2: int) : bool
{
  p1 <= p2
}

function {:inline} $sgt.ref(p1: int, p2: int) : int
{
  (if p1 > p2 then 1 else NULL)
}

function {:inline} $sgt.ref.bool(p1: int, p2: int) : bool
{
  p1 > p2
}

function {:inline} $sge.ref(p1: int, p2: int) : int
{
  (if p1 >= p2 then 1 else NULL)
}

function {:inline} $sge.ref.bool(p1: int, p2: int) : bool
{
  p1 >= p2
}

function {:inline} $slt.ref(p1: int, p2: int) : int
{
  (if p1 < p2 then 1 else NULL)
}

function {:inline} $slt.ref.bool(p1: int, p2: int) : bool
{
  p1 < p2
}

function {:inline} $sle.ref(p1: int, p2: int) : int
{
  (if p1 <= p2 then 1 else NULL)
}

function {:inline} $sle.ref.bool(p1: int, p2: int) : bool
{
  p1 <= p2
}

function {:inline} $add.ref(p1: int, p2: int) : int
{
  p1 + p2
}

function {:inline} $sub.ref(p1: int, p2: int) : int
{
  p1 - p2
}

function {:inline} $mul.ref(p1: int, p2: int) : int
{
  p1 * p2
}

const .str: int;

axiom .str == NULL - 16;

const .str1: int;

axiom .str1 == NULL - 32;

const .str2: int;

axiom .str2 == NULL - 46;

const .str3: int;

axiom .str3 == NULL - 60;

const __SMACK_dummy: int;

axiom __SMACK_dummy == NULL - 68;

procedure __SMACK_dummy({:scalar} v: int);



implementation __SMACK_dummy(v: int)
{

  $bb0:
    call {:cexpr "v"} boogie_si_record_i32(v);
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 97, 3} true;
    assume true;
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 98, 1} true;
    $exn := false;
    return;
}



const __SMACK_code: int;

axiom __SMACK_code == NULL - 76;

procedure __SMACK_code.ref($p0: int);



const __VERIFIER_nondet_pointer: int;

axiom __VERIFIER_nondet_pointer == NULL - 84;

procedure {:inline 1} __VERIFIER_nondet_pointer() returns ($r: int);



implementation {:inline 1} __VERIFIER_nondet_pointer() returns ($r: int)
{
  var $p0: int;

  $bb0:
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 80, 10} true;
    call $p0 := __VERIFIER_nondet();
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 80, 3} true;
    $r := $p0;
    $exn := false;
    return;
}



const __VERIFIER_nondet: int;

axiom __VERIFIER_nondet == NULL - 92;

procedure {:inline 1} __VERIFIER_nondet() returns ($r: int);



const __SMACK_decls: int;

axiom __SMACK_decls == NULL - 100;

function {:inline} $bitcast.ref.ref(i: int) : int
{
  i
}

function {:bvbuiltin "bvadd"} $add.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvadd"} $add.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvadd"} $add.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvadd"} $add.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvadd"} $add.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvadd"} $add.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvadd"} $add.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvadd"} $add.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvadd"} $add.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvadd"} $add.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvadd"} $add.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvsub"} $sub.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvsub"} $sub.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvsub"} $sub.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvsub"} $sub.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvsub"} $sub.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvsub"} $sub.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvsub"} $sub.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvsub"} $sub.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvsub"} $sub.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvsub"} $sub.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvsub"} $sub.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvmul"} $mul.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvmul"} $mul.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvmul"} $mul.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvmul"} $mul.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvmul"} $mul.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvmul"} $mul.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvmul"} $mul.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvmul"} $mul.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvmul"} $mul.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvmul"} $mul.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvmul"} $mul.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvudiv"} $udiv.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvudiv"} $udiv.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvudiv"} $udiv.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvudiv"} $udiv.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvudiv"} $udiv.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvudiv"} $udiv.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvudiv"} $udiv.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvudiv"} $udiv.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvudiv"} $udiv.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvudiv"} $udiv.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvudiv"} $udiv.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvsdiv"} $sdiv.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvsdiv"} $sdiv.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvsdiv"} $sdiv.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvsdiv"} $sdiv.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvsdiv"} $sdiv.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvsdiv"} $sdiv.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvsdiv"} $sdiv.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvsdiv"} $sdiv.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvsdiv"} $sdiv.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvsdiv"} $sdiv.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvsdiv"} $sdiv.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvsmod"} $smod.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvsmod"} $smod.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvsmod"} $smod.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvsmod"} $smod.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvsmod"} $smod.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvsmod"} $smod.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvsmod"} $smod.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvsmod"} $smod.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvsmod"} $smod.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvsmod"} $smod.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvsmod"} $smod.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvsrem"} $srem.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvsrem"} $srem.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvsrem"} $srem.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvsrem"} $srem.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvsrem"} $srem.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvsrem"} $srem.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvsrem"} $srem.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvsrem"} $srem.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvsrem"} $srem.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvsrem"} $srem.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvsrem"} $srem.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvurem"} $urem.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvurem"} $urem.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvurem"} $urem.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvurem"} $urem.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvurem"} $urem.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvurem"} $urem.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvurem"} $urem.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvurem"} $urem.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvurem"} $urem.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvurem"} $urem.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvurem"} $urem.bv1(i1: bv1, i2: bv1) : bv1;

function {:inline} $min.bv128(i1: bv128, i2: bv128) : bv128
{
  (if $slt.bv128.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv96(i1: bv96, i2: bv96) : bv96
{
  (if $slt.bv96.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv64(i1: bv64, i2: bv64) : bv64
{
  (if $slt.bv64.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv56(i1: bv56, i2: bv56) : bv56
{
  (if $slt.bv56.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv48(i1: bv48, i2: bv48) : bv48
{
  (if $slt.bv48.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv40(i1: bv40, i2: bv40) : bv40
{
  (if $slt.bv40.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv32(i1: bv32, i2: bv32) : bv32
{
  (if $slt.bv32.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv24(i1: bv24, i2: bv24) : bv24
{
  (if $slt.bv24.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv16(i1: bv16, i2: bv16) : bv16
{
  (if $slt.bv16.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv8(i1: bv8, i2: bv8) : bv8
{
  (if $slt.bv8.bool(i1, i2) then i1 else i2)
}

function {:inline} $min.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $slt.bv1.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv128(i1: bv128, i2: bv128) : bv128
{
  (if $sgt.bv128.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv96(i1: bv96, i2: bv96) : bv96
{
  (if $sgt.bv96.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv64(i1: bv64, i2: bv64) : bv64
{
  (if $sgt.bv64.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv56(i1: bv56, i2: bv56) : bv56
{
  (if $sgt.bv56.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv48(i1: bv48, i2: bv48) : bv48
{
  (if $sgt.bv48.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv40(i1: bv40, i2: bv40) : bv40
{
  (if $sgt.bv40.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv32(i1: bv32, i2: bv32) : bv32
{
  (if $sgt.bv32.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv24(i1: bv24, i2: bv24) : bv24
{
  (if $sgt.bv24.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv16(i1: bv16, i2: bv16) : bv16
{
  (if $sgt.bv16.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv8(i1: bv8, i2: bv8) : bv8
{
  (if $sgt.bv8.bool(i1, i2) then i1 else i2)
}

function {:inline} $max.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $sgt.bv1.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv128(i1: bv128, i2: bv128) : bv128
{
  (if $ult.bv128.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv96(i1: bv96, i2: bv96) : bv96
{
  (if $ult.bv96.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv64(i1: bv64, i2: bv64) : bv64
{
  (if $ult.bv64.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv56(i1: bv56, i2: bv56) : bv56
{
  (if $ult.bv56.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv48(i1: bv48, i2: bv48) : bv48
{
  (if $ult.bv48.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv40(i1: bv40, i2: bv40) : bv40
{
  (if $ult.bv40.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv32(i1: bv32, i2: bv32) : bv32
{
  (if $ult.bv32.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv24(i1: bv24, i2: bv24) : bv24
{
  (if $ult.bv24.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv16(i1: bv16, i2: bv16) : bv16
{
  (if $ult.bv16.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv8(i1: bv8, i2: bv8) : bv8
{
  (if $ult.bv8.bool(i1, i2) then i1 else i2)
}

function {:inline} $umin.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $ult.bv1.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv128(i1: bv128, i2: bv128) : bv128
{
  (if $ugt.bv128.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv96(i1: bv96, i2: bv96) : bv96
{
  (if $ugt.bv96.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv64(i1: bv64, i2: bv64) : bv64
{
  (if $ugt.bv64.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv56(i1: bv56, i2: bv56) : bv56
{
  (if $ugt.bv56.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv48(i1: bv48, i2: bv48) : bv48
{
  (if $ugt.bv48.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv40(i1: bv40, i2: bv40) : bv40
{
  (if $ugt.bv40.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv32(i1: bv32, i2: bv32) : bv32
{
  (if $ugt.bv32.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv24(i1: bv24, i2: bv24) : bv24
{
  (if $ugt.bv24.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv16(i1: bv16, i2: bv16) : bv16
{
  (if $ugt.bv16.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv8(i1: bv8, i2: bv8) : bv8
{
  (if $ugt.bv8.bool(i1, i2) then i1 else i2)
}

function {:inline} $umax.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $ugt.bv1.bool(i1, i2) then i1 else i2)
}

function {:bvbuiltin "bvshl"} $shl.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvshl"} $shl.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvshl"} $shl.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvshl"} $shl.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvshl"} $shl.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvshl"} $shl.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvshl"} $shl.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvshl"} $shl.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvshl"} $shl.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvshl"} $shl.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvshl"} $shl.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvlshr"} $lshr.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvlshr"} $lshr.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvlshr"} $lshr.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvlshr"} $lshr.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvlshr"} $lshr.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvlshr"} $lshr.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvlshr"} $lshr.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvlshr"} $lshr.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvlshr"} $lshr.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvlshr"} $lshr.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvlshr"} $lshr.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvashr"} $ashr.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvashr"} $ashr.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvashr"} $ashr.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvashr"} $ashr.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvashr"} $ashr.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvashr"} $ashr.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvashr"} $ashr.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvashr"} $ashr.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvashr"} $ashr.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvashr"} $ashr.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvashr"} $ashr.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvnot"} $not.bv128(i: bv128) : bv128;

function {:bvbuiltin "bvnot"} $not.bv96(i: bv96) : bv96;

function {:bvbuiltin "bvnot"} $not.bv64(i: bv64) : bv64;

function {:bvbuiltin "bvnot"} $not.bv56(i: bv56) : bv56;

function {:bvbuiltin "bvnot"} $not.bv48(i: bv48) : bv48;

function {:bvbuiltin "bvnot"} $not.bv40(i: bv40) : bv40;

function {:bvbuiltin "bvnot"} $not.bv32(i: bv32) : bv32;

function {:bvbuiltin "bvnot"} $not.bv24(i: bv24) : bv24;

function {:bvbuiltin "bvnot"} $not.bv16(i: bv16) : bv16;

function {:bvbuiltin "bvnot"} $not.bv8(i: bv8) : bv8;

function {:bvbuiltin "bvnot"} $not.bv1(i: bv1) : bv1;

function {:bvbuiltin "bvand"} $and.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvand"} $and.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvand"} $and.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvand"} $and.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvand"} $and.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvand"} $and.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvand"} $and.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvand"} $and.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvand"} $and.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvand"} $and.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvand"} $and.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvor"} $or.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvor"} $or.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvor"} $or.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvor"} $or.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvor"} $or.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvor"} $or.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvor"} $or.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvor"} $or.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvor"} $or.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvor"} $or.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvor"} $or.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvxor"} $xor.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvxor"} $xor.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvxor"} $xor.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvxor"} $xor.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvxor"} $xor.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvxor"} $xor.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvxor"} $xor.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvxor"} $xor.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvxor"} $xor.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvxor"} $xor.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvxor"} $xor.bv1(i1: bv1, i2: bv1) : bv1;

function {:bvbuiltin "bvnand"} $nand.bv128(i1: bv128, i2: bv128) : bv128;

function {:bvbuiltin "bvnand"} $nand.bv96(i1: bv96, i2: bv96) : bv96;

function {:bvbuiltin "bvnand"} $nand.bv64(i1: bv64, i2: bv64) : bv64;

function {:bvbuiltin "bvnand"} $nand.bv56(i1: bv56, i2: bv56) : bv56;

function {:bvbuiltin "bvnand"} $nand.bv48(i1: bv48, i2: bv48) : bv48;

function {:bvbuiltin "bvnand"} $nand.bv40(i1: bv40, i2: bv40) : bv40;

function {:bvbuiltin "bvnand"} $nand.bv32(i1: bv32, i2: bv32) : bv32;

function {:bvbuiltin "bvnand"} $nand.bv24(i1: bv24, i2: bv24) : bv24;

function {:bvbuiltin "bvnand"} $nand.bv16(i1: bv16, i2: bv16) : bv16;

function {:bvbuiltin "bvnand"} $nand.bv8(i1: bv8, i2: bv8) : bv8;

function {:bvbuiltin "bvnand"} $nand.bv1(i1: bv1, i2: bv1) : bv1;

function {:inline} $eq.bv128.bool(i1: bv128, i2: bv128) : bool
{
  i1 == i2
}

function {:inline} $eq.bv128(i1: bv128, i2: bv128) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv96.bool(i1: bv96, i2: bv96) : bool
{
  i1 == i2
}

function {:inline} $eq.bv96(i1: bv96, i2: bv96) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv64.bool(i1: bv64, i2: bv64) : bool
{
  i1 == i2
}

function {:inline} $eq.bv64(i1: bv64, i2: bv64) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv56.bool(i1: bv56, i2: bv56) : bool
{
  i1 == i2
}

function {:inline} $eq.bv56(i1: bv56, i2: bv56) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv48.bool(i1: bv48, i2: bv48) : bool
{
  i1 == i2
}

function {:inline} $eq.bv48(i1: bv48, i2: bv48) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv40.bool(i1: bv40, i2: bv40) : bool
{
  i1 == i2
}

function {:inline} $eq.bv40(i1: bv40, i2: bv40) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv32.bool(i1: bv32, i2: bv32) : bool
{
  i1 == i2
}

function {:inline} $eq.bv32(i1: bv32, i2: bv32) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv24.bool(i1: bv24, i2: bv24) : bool
{
  i1 == i2
}

function {:inline} $eq.bv24(i1: bv24, i2: bv24) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv16.bool(i1: bv16, i2: bv16) : bool
{
  i1 == i2
}

function {:inline} $eq.bv16(i1: bv16, i2: bv16) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv8.bool(i1: bv8, i2: bv8) : bool
{
  i1 == i2
}

function {:inline} $eq.bv8(i1: bv8, i2: bv8) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $eq.bv1.bool(i1: bv1, i2: bv1) : bool
{
  i1 == i2
}

function {:inline} $eq.bv1(i1: bv1, i2: bv1) : bv1
{
  (if i1 == i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv128.bool(i1: bv128, i2: bv128) : bool
{
  i1 != i2
}

function {:inline} $ne.bv128(i1: bv128, i2: bv128) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv96.bool(i1: bv96, i2: bv96) : bool
{
  i1 != i2
}

function {:inline} $ne.bv96(i1: bv96, i2: bv96) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv64.bool(i1: bv64, i2: bv64) : bool
{
  i1 != i2
}

function {:inline} $ne.bv64(i1: bv64, i2: bv64) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv56.bool(i1: bv56, i2: bv56) : bool
{
  i1 != i2
}

function {:inline} $ne.bv56(i1: bv56, i2: bv56) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv48.bool(i1: bv48, i2: bv48) : bool
{
  i1 != i2
}

function {:inline} $ne.bv48(i1: bv48, i2: bv48) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv40.bool(i1: bv40, i2: bv40) : bool
{
  i1 != i2
}

function {:inline} $ne.bv40(i1: bv40, i2: bv40) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv32.bool(i1: bv32, i2: bv32) : bool
{
  i1 != i2
}

function {:inline} $ne.bv32(i1: bv32, i2: bv32) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv24.bool(i1: bv24, i2: bv24) : bool
{
  i1 != i2
}

function {:inline} $ne.bv24(i1: bv24, i2: bv24) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv16.bool(i1: bv16, i2: bv16) : bool
{
  i1 != i2
}

function {:inline} $ne.bv16(i1: bv16, i2: bv16) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv8.bool(i1: bv8, i2: bv8) : bool
{
  i1 != i2
}

function {:inline} $ne.bv8(i1: bv8, i2: bv8) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:inline} $ne.bv1.bool(i1: bv1, i2: bv1) : bool
{
  i1 != i2
}

function {:inline} $ne.bv1(i1: bv1, i2: bv1) : bv1
{
  (if i1 != i2 then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $ule.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $ule.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $ule.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $ule.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $ule.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $ule.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $ule.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $ule.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $ule.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $ule.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $ule.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $ule.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $ule.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $ule.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $ule.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $ule.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $ule.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $ule.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $ule.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $ule.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvule"} $ule.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $ule.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $ule.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $ult.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $ult.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $ult.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $ult.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $ult.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $ult.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $ult.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $ult.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $ult.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $ult.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $ult.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $ult.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $ult.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $ult.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $ult.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $ult.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $ult.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $ult.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $ult.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $ult.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvult"} $ult.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $ult.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $ult.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $uge.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $uge.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $uge.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $uge.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $uge.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $uge.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $uge.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $uge.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $uge.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $uge.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $uge.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $uge.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $uge.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $uge.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $uge.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $uge.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $uge.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $uge.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $uge.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $uge.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvuge"} $uge.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $uge.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $uge.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $ugt.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $ugt.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $ugt.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $ugt.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $ugt.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $ugt.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $ugt.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $ugt.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $ugt.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $ugt.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $ugt.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $ugt.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $ugt.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $ugt.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $ugt.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $ugt.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $ugt.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $ugt.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $ugt.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $ugt.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvugt"} $ugt.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $ugt.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $ugt.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $sle.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $sle.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $sle.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $sle.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $sle.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $sle.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $sle.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $sle.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $sle.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $sle.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $sle.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $sle.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $sle.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $sle.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $sle.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $sle.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $sle.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $sle.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $sle.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $sle.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsle"} $sle.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $sle.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $sle.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $slt.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $slt.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $slt.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $slt.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $slt.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $slt.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $slt.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $slt.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $slt.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $slt.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $slt.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $slt.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $slt.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $slt.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $slt.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $slt.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $slt.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $slt.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $slt.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $slt.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvslt"} $slt.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $slt.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $slt.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $sge.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $sge.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $sge.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $sge.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $sge.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $sge.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $sge.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $sge.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $sge.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $sge.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $sge.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $sge.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $sge.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $sge.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $sge.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $sge.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $sge.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $sge.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $sge.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $sge.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsge"} $sge.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $sge.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $sge.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv128.bool(i1: bv128, i2: bv128) : bool;

function {:inline} $sgt.bv128(i1: bv128, i2: bv128) : bv1
{
  (if $sgt.bv128.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv96.bool(i1: bv96, i2: bv96) : bool;

function {:inline} $sgt.bv96(i1: bv96, i2: bv96) : bv1
{
  (if $sgt.bv96.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv64.bool(i1: bv64, i2: bv64) : bool;

function {:inline} $sgt.bv64(i1: bv64, i2: bv64) : bv1
{
  (if $sgt.bv64.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv56.bool(i1: bv56, i2: bv56) : bool;

function {:inline} $sgt.bv56(i1: bv56, i2: bv56) : bv1
{
  (if $sgt.bv56.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv48.bool(i1: bv48, i2: bv48) : bool;

function {:inline} $sgt.bv48(i1: bv48, i2: bv48) : bv1
{
  (if $sgt.bv48.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv40.bool(i1: bv40, i2: bv40) : bool;

function {:inline} $sgt.bv40(i1: bv40, i2: bv40) : bv1
{
  (if $sgt.bv40.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv32.bool(i1: bv32, i2: bv32) : bool;

function {:inline} $sgt.bv32(i1: bv32, i2: bv32) : bv1
{
  (if $sgt.bv32.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv24.bool(i1: bv24, i2: bv24) : bool;

function {:inline} $sgt.bv24(i1: bv24, i2: bv24) : bv1
{
  (if $sgt.bv24.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv16.bool(i1: bv16, i2: bv16) : bool;

function {:inline} $sgt.bv16(i1: bv16, i2: bv16) : bv1
{
  (if $sgt.bv16.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv8.bool(i1: bv8, i2: bv8) : bool;

function {:inline} $sgt.bv8(i1: bv8, i2: bv8) : bv1
{
  (if $sgt.bv8.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:bvbuiltin "bvsgt"} $sgt.bv1.bool(i1: bv1, i2: bv1) : bool;

function {:inline} $sgt.bv1(i1: bv1, i2: bv1) : bv1
{
  (if $sgt.bv1.bool(i1, i2) then 1bv1 else 0bv1)
}

function {:inline} $trunc.bv128.bv96(i: bv128) : bv96
{
  i[96:0]
}

function {:inline} $trunc.bv128.bv64(i: bv128) : bv64
{
  i[64:0]
}

function {:inline} $trunc.bv128.bv56(i: bv128) : bv56
{
  i[56:0]
}

function {:inline} $trunc.bv128.bv48(i: bv128) : bv48
{
  i[48:0]
}

function {:inline} $trunc.bv128.bv40(i: bv128) : bv40
{
  i[40:0]
}

function {:inline} $trunc.bv128.bv32(i: bv128) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv128.bv24(i: bv128) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv128.bv16(i: bv128) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv128.bv8(i: bv128) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv128.bv1(i: bv128) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv96.bv64(i: bv96) : bv64
{
  i[64:0]
}

function {:inline} $trunc.bv96.bv56(i: bv96) : bv56
{
  i[56:0]
}

function {:inline} $trunc.bv96.bv48(i: bv96) : bv48
{
  i[48:0]
}

function {:inline} $trunc.bv96.bv40(i: bv96) : bv40
{
  i[40:0]
}

function {:inline} $trunc.bv96.bv32(i: bv96) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv96.bv24(i: bv96) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv96.bv16(i: bv96) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv96.bv8(i: bv96) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv96.bv1(i: bv96) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv64.bv56(i: bv64) : bv56
{
  i[56:0]
}

function {:inline} $trunc.bv64.bv48(i: bv64) : bv48
{
  i[48:0]
}

function {:inline} $trunc.bv64.bv40(i: bv64) : bv40
{
  i[40:0]
}

function {:inline} $trunc.bv64.bv32(i: bv64) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv64.bv24(i: bv64) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv64.bv16(i: bv64) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv64.bv8(i: bv64) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv64.bv1(i: bv64) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv56.bv48(i: bv56) : bv48
{
  i[48:0]
}

function {:inline} $trunc.bv56.bv40(i: bv56) : bv40
{
  i[40:0]
}

function {:inline} $trunc.bv56.bv32(i: bv56) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv56.bv24(i: bv56) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv56.bv16(i: bv56) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv56.bv8(i: bv56) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv56.bv1(i: bv56) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv48.bv32(i: bv48) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv48.bv24(i: bv48) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv48.bv16(i: bv48) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv48.bv8(i: bv48) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv48.bv1(i: bv48) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv40.bv32(i: bv40) : bv32
{
  i[32:0]
}

function {:inline} $trunc.bv40.bv24(i: bv40) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv40.bv16(i: bv40) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv40.bv8(i: bv40) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv40.bv1(i: bv40) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv32.bv24(i: bv32) : bv24
{
  i[24:0]
}

function {:inline} $trunc.bv32.bv16(i: bv32) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv32.bv8(i: bv32) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv32.bv1(i: bv32) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv24.bv16(i: bv24) : bv16
{
  i[16:0]
}

function {:inline} $trunc.bv24.bv8(i: bv24) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv24.bv1(i: bv24) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv16.bv8(i: bv16) : bv8
{
  i[8:0]
}

function {:inline} $trunc.bv16.bv1(i: bv16) : bv1
{
  i[1:0]
}

function {:inline} $trunc.bv8.bv1(i: bv8) : bv1
{
  i[1:0]
}

function {:inline} $zext.bv1.bv8(i: bv1) : bv8
{
  (if i == 0bv1 then 0bv8 else 1bv8)
}

function {:inline} $zext.bv1.bv16(i: bv1) : bv16
{
  (if i == 0bv1 then 0bv16 else 1bv16)
}

function {:inline} $zext.bv1.bv24(i: bv1) : bv24
{
  (if i == 0bv1 then 0bv24 else 1bv24)
}

function {:inline} $zext.bv1.bv32(i: bv1) : bv32
{
  (if i == 0bv1 then 0bv32 else 1bv32)
}

function {:inline} $zext.bv1.bv40(i: bv1) : bv40
{
  (if i == 0bv1 then 0bv40 else 1bv40)
}

function {:inline} $zext.bv1.bv48(i: bv1) : bv48
{
  (if i == 0bv1 then 0bv48 else 1bv48)
}

function {:inline} $zext.bv1.bv56(i: bv1) : bv56
{
  (if i == 0bv1 then 0bv56 else 1bv56)
}

function {:inline} $zext.bv1.bv64(i: bv1) : bv64
{
  (if i == 0bv1 then 0bv64 else 1bv64)
}

function {:inline} $zext.bv1.bv96(i: bv1) : bv96
{
  (if i == 0bv1 then 0bv96 else 1bv96)
}

function {:inline} $zext.bv1.bv128(i: bv1) : bv128
{
  (if i == 0bv1 then 0bv128 else 1bv128)
}

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv8.bv16(i: bv8) : bv16;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv8.bv24(i: bv8) : bv24;

function {:bvbuiltin "(_ zero_extend 24)"} $zext.bv8.bv32(i: bv8) : bv32;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv8.bv40(i: bv8) : bv40;

function {:bvbuiltin "(_ zero_extend 40)"} $zext.bv8.bv48(i: bv8) : bv48;

function {:bvbuiltin "(_ zero_extend 48)"} $zext.bv8.bv56(i: bv8) : bv56;

function {:bvbuiltin "(_ zero_extend 56)"} $zext.bv8.bv64(i: bv8) : bv64;

function {:bvbuiltin "(_ zero_extend 88)"} $zext.bv8.bv96(i: bv8) : bv96;

function {:bvbuiltin "(_ zero_extend 120)"} $zext.bv8.bv128(i: bv8) : bv128;

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv16.bv24(i: bv16) : bv24;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv16.bv32(i: bv16) : bv32;

function {:bvbuiltin "(_ zero_extend 24)"} $zext.bv16.bv40(i: bv16) : bv40;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv16.bv48(i: bv16) : bv48;

function {:bvbuiltin "(_ zero_extend 40)"} $zext.bv16.bv56(i: bv16) : bv56;

function {:bvbuiltin "(_ zero_extend 48)"} $zext.bv16.bv64(i: bv16) : bv64;

function {:bvbuiltin "(_ zero_extend 80)"} $zext.bv16.bv96(i: bv16) : bv96;

function {:bvbuiltin "(_ zero_extend 112)"} $zext.bv16.bv128(i: bv16) : bv128;

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv24.bv32(i: bv24) : bv32;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv24.bv40(i: bv24) : bv40;

function {:bvbuiltin "(_ zero_extend 24)"} $zext.bv24.bv48(i: bv24) : bv48;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv24.bv56(i: bv24) : bv56;

function {:bvbuiltin "(_ zero_extend 40)"} $zext.bv24.bv64(i: bv24) : bv64;

function {:bvbuiltin "(_ zero_extend 72)"} $zext.bv24.bv96(i: bv24) : bv96;

function {:bvbuiltin "(_ zero_extend 104)"} $zext.bv24.bv128(i: bv24) : bv128;

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv32.bv40(i: bv32) : bv40;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv32.bv48(i: bv32) : bv48;

function {:bvbuiltin "(_ zero_extend 24)"} $zext.bv32.bv56(i: bv32) : bv56;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv32.bv64(i: bv32) : bv64;

function {:bvbuiltin "(_ zero_extend 64)"} $zext.bv32.bv96(i: bv32) : bv96;

function {:bvbuiltin "(_ zero_extend 96)"} $zext.bv32.bv128(i: bv32) : bv128;

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv40.bv48(i: bv40) : bv48;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv40.bv56(i: bv40) : bv56;

function {:bvbuiltin "(_ zero_extend 24)"} $zext.bv40.bv64(i: bv40) : bv64;

function {:bvbuiltin "(_ zero_extend 56)"} $zext.bv40.bv96(i: bv40) : bv96;

function {:bvbuiltin "(_ zero_extend 88)"} $zext.bv40.bv128(i: bv40) : bv128;

function {:bvbuiltin "(_ zero_extend 16)"} $zext.bv48.bv64(i: bv48) : bv64;

function {:bvbuiltin "(_ zero_extend 48)"} $zext.bv48.bv96(i: bv48) : bv96;

function {:bvbuiltin "(_ zero_extend 80)"} $zext.bv48.bv128(i: bv48) : bv128;

function {:bvbuiltin "(_ zero_extend 8)"} $zext.bv56.bv64(i: bv56) : bv64;

function {:bvbuiltin "(_ zero_extend 40)"} $zext.bv56.bv96(i: bv56) : bv96;

function {:bvbuiltin "(_ zero_extend 72)"} $zext.bv56.bv128(i: bv56) : bv128;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv64.bv96(i: bv64) : bv96;

function {:bvbuiltin "(_ zero_extend 64)"} $zext.bv64.bv128(i: bv64) : bv128;

function {:bvbuiltin "(_ zero_extend 32)"} $zext.bv96.bv128(i: bv96) : bv128;

function {:inline} $sext.bv1.bv8(i: bv1) : bv8
{
  (if i == 0bv1 then 0bv8 else 255bv8)
}

function {:inline} $sext.bv1.bv16(i: bv1) : bv16
{
  (if i == 0bv1 then 0bv16 else 65535bv16)
}

function {:inline} $sext.bv1.bv24(i: bv1) : bv24
{
  (if i == 0bv1 then 0bv24 else 16777215bv24)
}

function {:inline} $sext.bv1.bv32(i: bv1) : bv32
{
  (if i == 0bv1 then 0bv32 else 4294967295bv32)
}

function {:inline} $sext.bv1.bv40(i: bv1) : bv40
{
  (if i == 0bv1 then 0bv40 else 1099511627775bv40)
}

function {:inline} $sext.bv1.bv48(i: bv1) : bv48
{
  (if i == 0bv1 then 0bv48 else 281474976710655bv48)
}

function {:inline} $sext.bv1.bv56(i: bv1) : bv56
{
  (if i == 0bv1 then 0bv56 else 72057594037927935bv56)
}

function {:inline} $sext.bv1.bv64(i: bv1) : bv64
{
  (if i == 0bv1 then 0bv64 else 18446744073709551615bv64)
}

function {:inline} $sext.bv1.bv96(i: bv1) : bv96
{
  (if i == 0bv1 then 0bv96 else 79228162514264337593543950335bv96)
}

function {:inline} $sext.bv1.bv128(i: bv1) : bv128
{
  (if i == 0bv1 then 0bv128 else 340282366920938463463374607431768211455bv128)
}

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv8.bv16(i: bv8) : bv16;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv8.bv24(i: bv8) : bv24;

function {:bvbuiltin "(_ sign_extend 24)"} $sext.bv8.bv32(i: bv8) : bv32;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv8.bv40(i: bv8) : bv40;

function {:bvbuiltin "(_ sign_extend 40)"} $sext.bv8.bv48(i: bv8) : bv48;

function {:bvbuiltin "(_ sign_extend 48)"} $sext.bv8.bv56(i: bv8) : bv56;

function {:bvbuiltin "(_ sign_extend 56)"} $sext.bv8.bv64(i: bv8) : bv64;

function {:bvbuiltin "(_ sign_extend 88)"} $sext.bv8.bv96(i: bv8) : bv96;

function {:bvbuiltin "(_ sign_extend 120)"} $sext.bv8.bv128(i: bv8) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv16.bv24(i: bv16) : bv24;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv16.bv32(i: bv16) : bv32;

function {:bvbuiltin "(_ sign_extend 24)"} $sext.bv16.bv40(i: bv16) : bv40;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv16.bv48(i: bv16) : bv48;

function {:bvbuiltin "(_ sign_extend 40)"} $sext.bv16.bv56(i: bv16) : bv56;

function {:bvbuiltin "(_ sign_extend 48)"} $sext.bv16.bv64(i: bv16) : bv64;

function {:bvbuiltin "(_ sign_extend 80)"} $sext.bv16.bv96(i: bv16) : bv96;

function {:bvbuiltin "(_ sign_extend 112)"} $sext.bv16.bv128(i: bv16) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv24.bv32(i: bv24) : bv32;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv24.bv40(i: bv24) : bv40;

function {:bvbuiltin "(_ sign_extend 24)"} $sext.bv24.bv48(i: bv24) : bv48;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv24.bv56(i: bv24) : bv56;

function {:bvbuiltin "(_ sign_extend 40)"} $sext.bv24.bv64(i: bv24) : bv64;

function {:bvbuiltin "(_ sign_extend 72)"} $sext.bv24.bv96(i: bv24) : bv96;

function {:bvbuiltin "(_ sign_extend 104)"} $sext.bv24.bv128(i: bv24) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv32.bv40(i: bv32) : bv40;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv32.bv48(i: bv32) : bv48;

function {:bvbuiltin "(_ sign_extend 24)"} $sext.bv32.bv56(i: bv32) : bv56;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv32.bv64(i: bv32) : bv64;

function {:bvbuiltin "(_ sign_extend 64)"} $sext.bv32.bv96(i: bv32) : bv96;

function {:bvbuiltin "(_ sign_extend 96)"} $sext.bv32.bv128(i: bv32) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv40.bv48(i: bv40) : bv48;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv40.bv56(i: bv40) : bv56;

function {:bvbuiltin "(_ sign_extend 24)"} $sext.bv40.bv64(i: bv40) : bv64;

function {:bvbuiltin "(_ sign_extend 56)"} $sext.bv40.bv96(i: bv40) : bv96;

function {:bvbuiltin "(_ sign_extend 88)"} $sext.bv40.bv128(i: bv40) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv48.bv56(i: bv48) : bv56;

function {:bvbuiltin "(_ sign_extend 16)"} $sext.bv48.bv64(i: bv48) : bv64;

function {:bvbuiltin "(_ sign_extend 48)"} $sext.bv48.bv96(i: bv48) : bv96;

function {:bvbuiltin "(_ sign_extend 80)"} $sext.bv48.bv128(i: bv48) : bv128;

function {:bvbuiltin "(_ sign_extend 8)"} $sext.bv56.bv64(i: bv56) : bv64;

function {:bvbuiltin "(_ sign_extend 40)"} $sext.bv56.bv96(i: bv56) : bv96;

function {:bvbuiltin "(_ sign_extend 72)"} $sext.bv56.bv128(i: bv56) : bv128;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv64.bv96(i: bv64) : bv96;

function {:bvbuiltin "(_ sign_extend 64)"} $sext.bv64.bv128(i: bv64) : bv128;

function {:bvbuiltin "(_ sign_extend 32)"} $sext.bv96.bv128(i: bv96) : bv128;

function {:inline} $add.i128(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i96(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i64(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i56(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i48(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i40(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i32(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i24(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i16(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i8(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $add.i1(i1: int, i2: int) : int
{
  i1 + i2
}

function {:inline} $sub.i128(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i96(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i64(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i56(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i48(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i40(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i32(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i24(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i16(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i8(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $sub.i1(i1: int, i2: int) : int
{
  i1 - i2
}

function {:inline} $mul.i128(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i96(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i64(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i56(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i48(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i40(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i32(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i24(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i16(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i8(i1: int, i2: int) : int
{
  i1 * i2
}

function {:inline} $mul.i1(i1: int, i2: int) : int
{
  i1 * i2
}

function {:builtin "div"} $div(i1: int, i2: int) : int;

function {:builtin "mod"} $mod(i1: int, i2: int) : int;

function {:builtin "rem"} $rem(i1: int, i2: int) : int;

function {:inline} $min(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $max(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:builtin "div"} $sdiv.i128(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i96(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i64(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i56(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i48(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i40(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i32(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i24(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i16(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i8(i1: int, i2: int) : int;

function {:builtin "div"} $sdiv.i1(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i128(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i96(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i64(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i56(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i48(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i40(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i32(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i24(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i16(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i8(i1: int, i2: int) : int;

function {:builtin "mod"} $smod.i1(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i128(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i96(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i64(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i56(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i48(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i40(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i32(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i24(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i16(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i8(i1: int, i2: int) : int;

function {:builtin "rem"} $srem.i1(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i128(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i96(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i64(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i56(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i48(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i40(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i32(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i24(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i16(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i8(i1: int, i2: int) : int;

function {:builtin "div"} $udiv.i1(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i128(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i96(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i64(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i56(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i48(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i40(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i32(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i24(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i16(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i8(i1: int, i2: int) : int;

function {:builtin "rem"} $urem.i1(i1: int, i2: int) : int;

function {:inline} $smin.i128(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i96(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i64(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i56(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i48(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i40(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i32(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i24(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i16(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i8(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smin.i1(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $smax.i128(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i96(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i64(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i56(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i48(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i40(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i32(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i24(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i16(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i8(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $smax.i1(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umin.i128(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i96(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i64(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i56(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i48(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i40(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i32(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i24(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i16(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i8(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umin.i1(i1: int, i2: int) : int
{
  (if i1 < i2 then i1 else i2)
}

function {:inline} $umax.i128(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i96(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i64(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i56(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i48(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i40(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i32(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i24(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i16(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i8(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function {:inline} $umax.i1(i1: int, i2: int) : int
{
  (if i1 > i2 then i1 else i2)
}

function $shl.i128(i1: int, i2: int) : int;

function $shl.i96(i1: int, i2: int) : int;

function $shl.i64(i1: int, i2: int) : int;

function $shl.i56(i1: int, i2: int) : int;

function $shl.i48(i1: int, i2: int) : int;

function $shl.i40(i1: int, i2: int) : int;

function $shl.i32(i1: int, i2: int) : int;

function $shl.i24(i1: int, i2: int) : int;

function $shl.i16(i1: int, i2: int) : int;

function $shl.i8(i1: int, i2: int) : int;

function $shl.i1(i1: int, i2: int) : int;

function $lshr.i128(i1: int, i2: int) : int;

function $lshr.i96(i1: int, i2: int) : int;

function $lshr.i64(i1: int, i2: int) : int;

function $lshr.i56(i1: int, i2: int) : int;

function $lshr.i48(i1: int, i2: int) : int;

function $lshr.i40(i1: int, i2: int) : int;

function $lshr.i32(i1: int, i2: int) : int;

function $lshr.i24(i1: int, i2: int) : int;

function $lshr.i16(i1: int, i2: int) : int;

function $lshr.i8(i1: int, i2: int) : int;

function $lshr.i1(i1: int, i2: int) : int;

function $ashr.i128(i1: int, i2: int) : int;

function $ashr.i96(i1: int, i2: int) : int;

function $ashr.i64(i1: int, i2: int) : int;

function $ashr.i56(i1: int, i2: int) : int;

function $ashr.i48(i1: int, i2: int) : int;

function $ashr.i40(i1: int, i2: int) : int;

function $ashr.i32(i1: int, i2: int) : int;

function $ashr.i24(i1: int, i2: int) : int;

function $ashr.i16(i1: int, i2: int) : int;

function $ashr.i8(i1: int, i2: int) : int;

function $ashr.i1(i1: int, i2: int) : int;

function $not.i128(i: int) : int;

function $not.i96(i: int) : int;

function $not.i64(i: int) : int;

function $not.i56(i: int) : int;

function $not.i48(i: int) : int;

function $not.i40(i: int) : int;

function $not.i32(i: int) : int;

function $not.i24(i: int) : int;

function $not.i16(i: int) : int;

function $not.i8(i: int) : int;

function $not.i1(i: int) : int;

function $and.i128(i1: int, i2: int) : int;

function $and.i96(i1: int, i2: int) : int;

function $and.i64(i1: int, i2: int) : int;

function $and.i56(i1: int, i2: int) : int;

function $and.i48(i1: int, i2: int) : int;

function $and.i40(i1: int, i2: int) : int;

function $and.i32(i1: int, i2: int) : int;

function $and.i24(i1: int, i2: int) : int;

function $and.i16(i1: int, i2: int) : int;

function $and.i8(i1: int, i2: int) : int;

function $and.i1(i1: int, i2: int) : int;

function $or.i128(i1: int, i2: int) : int;

function $or.i96(i1: int, i2: int) : int;

function $or.i64(i1: int, i2: int) : int;

function $or.i56(i1: int, i2: int) : int;

function $or.i48(i1: int, i2: int) : int;

function $or.i40(i1: int, i2: int) : int;

function $or.i32(i1: int, i2: int) : int;

function $or.i24(i1: int, i2: int) : int;

function $or.i16(i1: int, i2: int) : int;

function $or.i8(i1: int, i2: int) : int;

function $or.i1(i1: int, i2: int) : int;

function $xor.i128(i1: int, i2: int) : int;

function $xor.i96(i1: int, i2: int) : int;

function $xor.i64(i1: int, i2: int) : int;

function $xor.i56(i1: int, i2: int) : int;

function $xor.i48(i1: int, i2: int) : int;

function $xor.i40(i1: int, i2: int) : int;

function $xor.i32(i1: int, i2: int) : int;

function $xor.i24(i1: int, i2: int) : int;

function $xor.i16(i1: int, i2: int) : int;

function $xor.i8(i1: int, i2: int) : int;

function $xor.i1(i1: int, i2: int) : int;

function $nand.i128(i1: int, i2: int) : int;

function $nand.i96(i1: int, i2: int) : int;

function $nand.i64(i1: int, i2: int) : int;

function $nand.i56(i1: int, i2: int) : int;

function $nand.i48(i1: int, i2: int) : int;

function $nand.i40(i1: int, i2: int) : int;

function $nand.i32(i1: int, i2: int) : int;

function $nand.i24(i1: int, i2: int) : int;

function $nand.i16(i1: int, i2: int) : int;

function $nand.i8(i1: int, i2: int) : int;

function $nand.i1(i1: int, i2: int) : int;

function {:inline} $eq.i128.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i128(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i96.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i96(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i64.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i64(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i56.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i56(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i48.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i48(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i40.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i40(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i32.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i32(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i24.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i24(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i16.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i16(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i8.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i8(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $eq.i1.bool(i1: int, i2: int) : bool
{
  i1 == i2
}

function {:inline} $eq.i1(i1: int, i2: int) : int
{
  (if i1 == i2 then 1 else NULL)
}

function {:inline} $ne.i128.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i128(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i96.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i96(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i64.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i64(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i56.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i56(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i48.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i48(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i40.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i40(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i32.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i32(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i24.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i24(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i16.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i16(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i8.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i8(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ne.i1.bool(i1: int, i2: int) : bool
{
  i1 != i2
}

function {:inline} $ne.i1(i1: int, i2: int) : int
{
  (if i1 != i2 then 1 else NULL)
}

function {:inline} $ule.i128.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i128(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i96.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i96(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i64.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i64(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i56.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i56(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i48.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i48(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i40.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i40(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i32.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i32(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i24.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i24(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i16.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i16(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i8.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i8(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ule.i1.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $ule.i1(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $ult.i128.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i128(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i96.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i96(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i64.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i64(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i56.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i56(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i48.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i48(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i40.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i40(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i32.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i32(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i24.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i24(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i16.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i16(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i8.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i8(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $ult.i1.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $ult.i1(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $uge.i128.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i128(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i96.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i96(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i64.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i64(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i56.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i56(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i48.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i48(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i40.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i40(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i32.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i32(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i24.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i24(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i16.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i16(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i8.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i8(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $uge.i1.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $uge.i1(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $ugt.i128.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i128(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i96.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i96(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i64.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i64(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i56.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i56(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i48.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i48(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i40.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i40(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i32.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i32(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i24.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i24(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i16.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i16(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i8.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i8(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $ugt.i1.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $ugt.i1(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sle.i128.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i128(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i96.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i96(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i64.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i64(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i56.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i56(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i48.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i48(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i40.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i40(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i32.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i32(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i24.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i24(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i16.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i16(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i8.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i8(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $sle.i1.bool(i1: int, i2: int) : bool
{
  i1 <= i2
}

function {:inline} $sle.i1(i1: int, i2: int) : int
{
  (if i1 <= i2 then 1 else NULL)
}

function {:inline} $slt.i128.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i128(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i96.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i96(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i64.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i64(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i56.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i56(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i48.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i48(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i40.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i40(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i32.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i32(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i24.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i24(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i16.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i16(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i8.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i8(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $slt.i1.bool(i1: int, i2: int) : bool
{
  i1 < i2
}

function {:inline} $slt.i1(i1: int, i2: int) : int
{
  (if i1 < i2 then 1 else NULL)
}

function {:inline} $sge.i128.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i128(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i96.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i96(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i64.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i64(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i56.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i56(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i48.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i48(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i40.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i40(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i32.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i32(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i24.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i24(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i16.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i16(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i8.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i8(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sge.i1.bool(i1: int, i2: int) : bool
{
  i1 >= i2
}

function {:inline} $sge.i1(i1: int, i2: int) : int
{
  (if i1 >= i2 then 1 else NULL)
}

function {:inline} $sgt.i128.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i128(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i96.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i96(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i64.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i64(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i56.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i56(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i48.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i48(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i40.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i40(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i32.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i32(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i24.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i24(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i16.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i16(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i8.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i8(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

function {:inline} $sgt.i1.bool(i1: int, i2: int) : bool
{
  i1 > i2
}

function {:inline} $sgt.i1(i1: int, i2: int) : int
{
  (if i1 > i2 then 1 else NULL)
}

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

function {:inline} $trunc.i128.i96(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i64(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i56(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i48(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i40(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i128.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i64(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i56(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i48(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i40(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i96.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i56(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i48(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i40(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i64.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i48(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i40(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i56.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i40(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i48.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i40.i32(i: int) : int
{
  i
}

function {:inline} $trunc.i40.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i40.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i40.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i40.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i32.i24(i: int) : int
{
  i
}

function {:inline} $trunc.i32.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i32.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i32.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i24.i16(i: int) : int
{
  i
}

function {:inline} $trunc.i24.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i24.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i16.i8(i: int) : int
{
  i
}

function {:inline} $trunc.i16.i1(i: int) : int
{
  i
}

function {:inline} $trunc.i8.i1(i: int) : int
{
  i
}

function {:inline} $zext.i1.i8(i: int) : int
{
  i
}

function {:inline} $zext.i1.i16(i: int) : int
{
  i
}

function {:inline} $zext.i1.i24(i: int) : int
{
  i
}

function {:inline} $zext.i1.i32(i: int) : int
{
  i
}

function {:inline} $zext.i1.i40(i: int) : int
{
  i
}

function {:inline} $zext.i1.i48(i: int) : int
{
  i
}

function {:inline} $zext.i1.i56(i: int) : int
{
  i
}

function {:inline} $zext.i1.i64(i: int) : int
{
  i
}

function {:inline} $zext.i1.i96(i: int) : int
{
  i
}

function {:inline} $zext.i1.i128(i: int) : int
{
  i
}

function {:inline} $zext.i8.i16(i: int) : int
{
  i
}

function {:inline} $zext.i8.i24(i: int) : int
{
  i
}

function {:inline} $zext.i8.i32(i: int) : int
{
  i
}

function {:inline} $zext.i8.i40(i: int) : int
{
  i
}

function {:inline} $zext.i8.i48(i: int) : int
{
  i
}

function {:inline} $zext.i8.i56(i: int) : int
{
  i
}

function {:inline} $zext.i8.i64(i: int) : int
{
  i
}

function {:inline} $zext.i8.i96(i: int) : int
{
  i
}

function {:inline} $zext.i8.i128(i: int) : int
{
  i
}

function {:inline} $zext.i16.i24(i: int) : int
{
  i
}

function {:inline} $zext.i16.i32(i: int) : int
{
  i
}

function {:inline} $zext.i16.i40(i: int) : int
{
  i
}

function {:inline} $zext.i16.i48(i: int) : int
{
  i
}

function {:inline} $zext.i16.i56(i: int) : int
{
  i
}

function {:inline} $zext.i16.i64(i: int) : int
{
  i
}

function {:inline} $zext.i16.i96(i: int) : int
{
  i
}

function {:inline} $zext.i16.i128(i: int) : int
{
  i
}

function {:inline} $zext.i24.i32(i: int) : int
{
  i
}

function {:inline} $zext.i24.i40(i: int) : int
{
  i
}

function {:inline} $zext.i24.i48(i: int) : int
{
  i
}

function {:inline} $zext.i24.i56(i: int) : int
{
  i
}

function {:inline} $zext.i24.i64(i: int) : int
{
  i
}

function {:inline} $zext.i24.i96(i: int) : int
{
  i
}

function {:inline} $zext.i24.i128(i: int) : int
{
  i
}

function {:inline} $zext.i32.i40(i: int) : int
{
  i
}

function {:inline} $zext.i32.i48(i: int) : int
{
  i
}

function {:inline} $zext.i32.i56(i: int) : int
{
  i
}

function {:inline} $zext.i32.i64(i: int) : int
{
  i
}

function {:inline} $zext.i32.i96(i: int) : int
{
  i
}

function {:inline} $zext.i32.i128(i: int) : int
{
  i
}

function {:inline} $zext.i40.i48(i: int) : int
{
  i
}

function {:inline} $zext.i40.i56(i: int) : int
{
  i
}

function {:inline} $zext.i40.i64(i: int) : int
{
  i
}

function {:inline} $zext.i40.i96(i: int) : int
{
  i
}

function {:inline} $zext.i40.i128(i: int) : int
{
  i
}

function {:inline} $zext.i48.i56(i: int) : int
{
  i
}

function {:inline} $zext.i48.i64(i: int) : int
{
  i
}

function {:inline} $zext.i48.i96(i: int) : int
{
  i
}

function {:inline} $zext.i48.i128(i: int) : int
{
  i
}

function {:inline} $zext.i56.i64(i: int) : int
{
  i
}

function {:inline} $zext.i56.i96(i: int) : int
{
  i
}

function {:inline} $zext.i56.i128(i: int) : int
{
  i
}

function {:inline} $zext.i64.i96(i: int) : int
{
  i
}

function {:inline} $zext.i64.i128(i: int) : int
{
  i
}

function {:inline} $zext.i96.i128(i: int) : int
{
  i
}

function {:inline} $sext.i1.i8(i: int) : int
{
  i
}

function {:inline} $sext.i1.i16(i: int) : int
{
  i
}

function {:inline} $sext.i1.i24(i: int) : int
{
  i
}

function {:inline} $sext.i1.i32(i: int) : int
{
  i
}

function {:inline} $sext.i1.i40(i: int) : int
{
  i
}

function {:inline} $sext.i1.i48(i: int) : int
{
  i
}

function {:inline} $sext.i1.i56(i: int) : int
{
  i
}

function {:inline} $sext.i1.i64(i: int) : int
{
  i
}

function {:inline} $sext.i1.i96(i: int) : int
{
  i
}

function {:inline} $sext.i1.i128(i: int) : int
{
  i
}

function {:inline} $sext.i8.i16(i: int) : int
{
  i
}

function {:inline} $sext.i8.i24(i: int) : int
{
  i
}

function {:inline} $sext.i8.i32(i: int) : int
{
  i
}

function {:inline} $sext.i8.i40(i: int) : int
{
  i
}

function {:inline} $sext.i8.i48(i: int) : int
{
  i
}

function {:inline} $sext.i8.i56(i: int) : int
{
  i
}

function {:inline} $sext.i8.i64(i: int) : int
{
  i
}

function {:inline} $sext.i8.i96(i: int) : int
{
  i
}

function {:inline} $sext.i8.i128(i: int) : int
{
  i
}

function {:inline} $sext.i16.i24(i: int) : int
{
  i
}

function {:inline} $sext.i16.i32(i: int) : int
{
  i
}

function {:inline} $sext.i16.i40(i: int) : int
{
  i
}

function {:inline} $sext.i16.i48(i: int) : int
{
  i
}

function {:inline} $sext.i16.i56(i: int) : int
{
  i
}

function {:inline} $sext.i16.i64(i: int) : int
{
  i
}

function {:inline} $sext.i16.i96(i: int) : int
{
  i
}

function {:inline} $sext.i16.i128(i: int) : int
{
  i
}

function {:inline} $sext.i24.i32(i: int) : int
{
  i
}

function {:inline} $sext.i24.i40(i: int) : int
{
  i
}

function {:inline} $sext.i24.i48(i: int) : int
{
  i
}

function {:inline} $sext.i24.i56(i: int) : int
{
  i
}

function {:inline} $sext.i24.i64(i: int) : int
{
  i
}

function {:inline} $sext.i24.i96(i: int) : int
{
  i
}

function {:inline} $sext.i24.i128(i: int) : int
{
  i
}

function {:inline} $sext.i32.i40(i: int) : int
{
  i
}

function {:inline} $sext.i32.i48(i: int) : int
{
  i
}

function {:inline} $sext.i32.i56(i: int) : int
{
  i
}

function {:inline} $sext.i32.i64(i: int) : int
{
  i
}

function {:inline} $sext.i32.i96(i: int) : int
{
  i
}

function {:inline} $sext.i32.i128(i: int) : int
{
  i
}

function {:inline} $sext.i40.i48(i: int) : int
{
  i
}

function {:inline} $sext.i40.i56(i: int) : int
{
  i
}

function {:inline} $sext.i40.i64(i: int) : int
{
  i
}

function {:inline} $sext.i40.i96(i: int) : int
{
  i
}

function {:inline} $sext.i40.i128(i: int) : int
{
  i
}

function {:inline} $sext.i48.i56(i: int) : int
{
  i
}

function {:inline} $sext.i48.i64(i: int) : int
{
  i
}

function {:inline} $sext.i48.i96(i: int) : int
{
  i
}

function {:inline} $sext.i48.i128(i: int) : int
{
  i
}

function {:inline} $sext.i56.i64(i: int) : int
{
  i
}

function {:inline} $sext.i56.i96(i: int) : int
{
  i
}

function {:inline} $sext.i56.i128(i: int) : int
{
  i
}

function {:inline} $sext.i64.i96(i: int) : int
{
  i
}

function {:inline} $sext.i64.i128(i: int) : int
{
  i
}

function {:inline} $sext.i96.i128(i: int) : int
{
  i
}

function $fp(ipart: int, fpart: int, epart: int) : int;

function $fadd.float(f1: int, f2: int) : int;

function $fsub.float(f1: int, f2: int) : int;

function $fmul.float(f1: int, f2: int) : int;

function $fdiv.float(f1: int, f2: int) : int;

function $frem.float(f1: int, f2: int) : int;

function $ffalse.float(f1: int, f2: int) : int;

function $ftrue.float(f1: int, f2: int) : int;

function {:inline} $foeq.float(f1: int, f2: int) : int
{
  (if $foeq.bool(f1, f2) then 1 else NULL)
}

function $foeq.bool(f1: int, f2: int) : bool;

function $foge.float(f1: int, f2: int) : int;

function $fogt.float(f1: int, f2: int) : int;

function $fole.float(f1: int, f2: int) : int;

function $folt.float(f1: int, f2: int) : int;

function $fone.float(f1: int, f2: int) : int;

function $ford.float(f1: int, f2: int) : int;

function $fueq.float(f1: int, f2: int) : int;

function $fuge.float(f1: int, f2: int) : int;

function $fugt.float(f1: int, f2: int) : int;

function $fule.float(f1: int, f2: int) : int;

function $fult.float(f1: int, f2: int) : int;

function $fune.float(f1: int, f2: int) : int;

function $funo.float(f1: int, f2: int) : int;

function $fp2si.float.i128(f: int) : int;

function $fp2ui.float.i128(f: int) : int;

function $si2fp.i128.float(i: int) : int;

function $ui2fp.i128.float(i: int) : int;

function $fp2si.float.i96(f: int) : int;

function $fp2ui.float.i96(f: int) : int;

function $si2fp.i96.float(i: int) : int;

function $ui2fp.i96.float(i: int) : int;

function $fp2si.float.i64(f: int) : int;

function $fp2ui.float.i64(f: int) : int;

function $si2fp.i64.float(i: int) : int;

function $ui2fp.i64.float(i: int) : int;

function $fp2si.float.i56(f: int) : int;

function $fp2ui.float.i56(f: int) : int;

function $si2fp.i56.float(i: int) : int;

function $ui2fp.i56.float(i: int) : int;

function $fp2si.float.i48(f: int) : int;

function $fp2ui.float.i48(f: int) : int;

function $si2fp.i48.float(i: int) : int;

function $ui2fp.i48.float(i: int) : int;

function $fp2si.float.i40(f: int) : int;

function $fp2ui.float.i40(f: int) : int;

function $si2fp.i40.float(i: int) : int;

function $ui2fp.i40.float(i: int) : int;

function $fp2si.float.i32(f: int) : int;

function $fp2ui.float.i32(f: int) : int;

function $si2fp.i32.float(i: int) : int;

function $ui2fp.i32.float(i: int) : int;

function $fp2si.float.i24(f: int) : int;

function $fp2ui.float.i24(f: int) : int;

function $si2fp.i24.float(i: int) : int;

function $ui2fp.i24.float(i: int) : int;

function $fp2si.float.i16(f: int) : int;

function $fp2ui.float.i16(f: int) : int;

function $si2fp.i16.float(i: int) : int;

function $ui2fp.i16.float(i: int) : int;

function $fp2si.float.i8(f: int) : int;

function $fp2ui.float.i8(f: int) : int;

function $si2fp.i8.float(i: int) : int;

function $ui2fp.i8.float(i: int) : int;

function $fptrunc.float.float(f: int) : int;

function $fpext.float.float(f: int) : int;

function $fp2si.float.bv128(f: int) : bv128;

function $fp2ui.float.bv128(f: int) : bv128;

function $si2fp.bv128.float(i: bv128) : int;

function $ui2fp.bv128.float(i: bv128) : int;

function $fp2si.float.bv96(f: int) : bv96;

function $fp2ui.float.bv96(f: int) : bv96;

function $si2fp.bv96.float(i: bv96) : int;

function $ui2fp.bv96.float(i: bv96) : int;

function $fp2si.float.bv64(f: int) : bv64;

function $fp2ui.float.bv64(f: int) : bv64;

function $si2fp.bv64.float(i: bv64) : int;

function $ui2fp.bv64.float(i: bv64) : int;

function $fp2si.float.bv56(f: int) : bv56;

function $fp2ui.float.bv56(f: int) : bv56;

function $si2fp.bv56.float(i: bv56) : int;

function $ui2fp.bv56.float(i: bv56) : int;

function $fp2si.float.bv48(f: int) : bv48;

function $fp2ui.float.bv48(f: int) : bv48;

function $si2fp.bv48.float(i: bv48) : int;

function $ui2fp.bv48.float(i: bv48) : int;

function $fp2si.float.bv40(f: int) : bv40;

function $fp2ui.float.bv40(f: int) : bv40;

function $si2fp.bv40.float(i: bv40) : int;

function $ui2fp.bv40.float(i: bv40) : int;

function $fp2si.float.bv32(f: int) : bv32;

function $fp2ui.float.bv32(f: int) : bv32;

function $si2fp.bv32.float(i: bv32) : int;

function $ui2fp.bv32.float(i: bv32) : int;

function $fp2si.float.bv24(f: int) : bv24;

function $fp2ui.float.bv24(f: int) : bv24;

function $si2fp.bv24.float(i: bv24) : int;

function $ui2fp.bv24.float(i: bv24) : int;

function $fp2si.float.bv16(f: int) : bv16;

function $fp2ui.float.bv16(f: int) : bv16;

function $si2fp.bv16.float(i: bv16) : int;

function $ui2fp.bv16.float(i: bv16) : int;

function $fp2si.float.bv8(f: int) : bv8;

function $fp2ui.float.bv8(f: int) : bv8;

function $si2fp.bv8.float(i: bv8) : int;

function $ui2fp.bv8.float(i: bv8) : int;

axiom (forall f1: int, f2: int :: f1 != f2 || $foeq.bool(f1, f2));

axiom (forall i: int :: $fp2ui.float.i128($ui2fp.i128.float(i)) == i);

axiom (forall f: int :: $ui2fp.i128.float($fp2ui.float.i128(f)) == f);

axiom (forall i: int :: $fp2si.float.i128($si2fp.i128.float(i)) == i);

axiom (forall f: int :: $si2fp.i128.float($fp2si.float.i128(f)) == f);

axiom (forall i: int :: $fp2ui.float.i96($ui2fp.i96.float(i)) == i);

axiom (forall f: int :: $ui2fp.i96.float($fp2ui.float.i96(f)) == f);

axiom (forall i: int :: $fp2si.float.i96($si2fp.i96.float(i)) == i);

axiom (forall f: int :: $si2fp.i96.float($fp2si.float.i96(f)) == f);

axiom (forall i: int :: $fp2ui.float.i64($ui2fp.i64.float(i)) == i);

axiom (forall f: int :: $ui2fp.i64.float($fp2ui.float.i64(f)) == f);

axiom (forall i: int :: $fp2si.float.i64($si2fp.i64.float(i)) == i);

axiom (forall f: int :: $si2fp.i64.float($fp2si.float.i64(f)) == f);

axiom (forall i: int :: $fp2ui.float.i56($ui2fp.i56.float(i)) == i);

axiom (forall f: int :: $ui2fp.i56.float($fp2ui.float.i56(f)) == f);

axiom (forall i: int :: $fp2si.float.i56($si2fp.i56.float(i)) == i);

axiom (forall f: int :: $si2fp.i56.float($fp2si.float.i56(f)) == f);

axiom (forall i: int :: $fp2ui.float.i48($ui2fp.i48.float(i)) == i);

axiom (forall f: int :: $ui2fp.i48.float($fp2ui.float.i48(f)) == f);

axiom (forall i: int :: $fp2si.float.i48($si2fp.i48.float(i)) == i);

axiom (forall f: int :: $si2fp.i48.float($fp2si.float.i48(f)) == f);

axiom (forall i: int :: $fp2ui.float.i40($ui2fp.i40.float(i)) == i);

axiom (forall f: int :: $ui2fp.i40.float($fp2ui.float.i40(f)) == f);

axiom (forall i: int :: $fp2si.float.i40($si2fp.i40.float(i)) == i);

axiom (forall f: int :: $si2fp.i40.float($fp2si.float.i40(f)) == f);

axiom (forall i: int :: $fp2ui.float.i32($ui2fp.i32.float(i)) == i);

axiom (forall f: int :: $ui2fp.i32.float($fp2ui.float.i32(f)) == f);

axiom (forall i: int :: $fp2si.float.i32($si2fp.i32.float(i)) == i);

axiom (forall f: int :: $si2fp.i32.float($fp2si.float.i32(f)) == f);

axiom (forall i: int :: $fp2ui.float.i24($ui2fp.i24.float(i)) == i);

axiom (forall f: int :: $ui2fp.i24.float($fp2ui.float.i24(f)) == f);

axiom (forall i: int :: $fp2si.float.i24($si2fp.i24.float(i)) == i);

axiom (forall f: int :: $si2fp.i24.float($fp2si.float.i24(f)) == f);

axiom (forall i: int :: $fp2ui.float.i16($ui2fp.i16.float(i)) == i);

axiom (forall f: int :: $ui2fp.i16.float($fp2ui.float.i16(f)) == f);

axiom (forall i: int :: $fp2si.float.i16($si2fp.i16.float(i)) == i);

axiom (forall f: int :: $si2fp.i16.float($fp2si.float.i16(f)) == f);

axiom (forall i: int :: $fp2ui.float.i8($ui2fp.i8.float(i)) == i);

axiom (forall f: int :: $ui2fp.i8.float($fp2ui.float.i8(f)) == f);

axiom (forall i: int :: $fp2si.float.i8($si2fp.i8.float(i)) == i);

axiom (forall f: int :: $si2fp.i8.float($fp2si.float.i8(f)) == f);

const $GLOBALS_BOTTOM: int;

const $EXTERNS_BOTTOM: int;

function $base(int) : int;

function {:inline} $isExternal(p: int) : bool
{
  p < $EXTERNS_BOTTOM
}

function {:inline} $load.i128(M: [ref]i128, p: int) : int
{
  M[p]
}

function {:inline} $load.i96(M: [ref]i96, p: int) : int
{
  M[p]
}

function {:inline} $load.i64(M: [ref]i64, p: int) : int
{
  M[p]
}

function {:inline} $load.i56(M: [ref]i56, p: int) : int
{
  M[p]
}

function {:inline} $load.i48(M: [ref]i48, p: int) : int
{
  M[p]
}

function {:inline} $load.i40(M: [ref]i40, p: int) : int
{
  M[p]
}

function {:inline} $load.i32(M: [ref]i32, p: int) : int
{
  M[p]
}

function {:inline} $load.i24(M: [ref]i24, p: int) : int
{
  M[p]
}

function {:inline} $load.i16(M: [ref]i16, p: int) : int
{
  M[p]
}

function {:inline} $load.i8(M: [ref]i8, p: int) : int
{
  M[p]
}

function {:inline} $load.bv128(M: [ref]bv128, p: int) : bv128
{
  M[p]
}

function {:inline} $load.bv96(M: [ref]bv96, p: int) : bv96
{
  M[p]
}

function {:inline} $load.bv64(M: [ref]bv64, p: int) : bv64
{
  M[p]
}

function {:inline} $load.bv56(M: [ref]bv56, p: int) : bv56
{
  M[p]
}

function {:inline} $load.bv48(M: [ref]bv48, p: int) : bv48
{
  M[p]
}

function {:inline} $load.bv40(M: [ref]bv40, p: int) : bv40
{
  M[p]
}

function {:inline} $load.bv32(M: [ref]bv32, p: int) : bv32
{
  M[p]
}

function {:inline} $load.bv24(M: [ref]bv24, p: int) : bv24
{
  M[p]
}

function {:inline} $load.bv16(M: [ref]bv16, p: int) : bv16
{
  M[p]
}

function {:inline} $load.bv8(M: [ref]bv8, p: int) : bv8
{
  M[p]
}

function {:inline} $load.bytes.bv128(M: [ref]bv8, p: int) : bv128
{
  M[p + 8 + 4 + 3] ++ M[p + 8 + 4 + 2] ++ M[p + 8 + 4 + 1] ++ M[p + 8 + 4] ++ (M[p + 8 + 3] ++ M[p + 8 + 2] ++ M[p + 8 + 1] ++ M[p + 8]) ++ (M[p + 4 + 3] ++ M[p + 4 + 2] ++ M[p + 4 + 1] ++ M[p + 4] ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p]))
}

function {:inline} $load.bytes.bv96(M: [ref]bv8, p: int) : bv96
{
  M[p + 4 + 4 + 3] ++ M[p + 4 + 4 + 2] ++ M[p + 4 + 4 + 1] ++ M[p + 4 + 4] ++ (M[p + 4 + 3] ++ M[p + 4 + 2] ++ M[p + 4 + 1] ++ M[p + 4]) ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p])
}

function {:inline} $load.bytes.bv64(M: [ref]bv8, p: int) : bv64
{
  M[p + 4 + 3] ++ M[p + 4 + 2] ++ M[p + 4 + 1] ++ M[p + 4] ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p])
}

function {:inline} $load.bytes.bv56(M: [ref]bv8, p: int) : bv56
{
  M[p + 4 + 2] ++ M[p + 4 + 1] ++ M[p + 4] ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p])
}

function {:inline} $load.bytes.bv48(M: [ref]bv8, p: int) : bv48
{
  M[p + 4 + 1] ++ M[p + 4] ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p])
}

function {:inline} $load.bytes.bv40(M: [ref]bv8, p: int) : bv40
{
  M[p + 4] ++ (M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p])
}

function {:inline} $load.bytes.bv32(M: [ref]bv8, p: int) : bv32
{
  M[p + 3] ++ M[p + 2] ++ M[p + 1] ++ M[p]
}

function {:inline} $load.bytes.bv24(M: [ref]bv8, p: int) : bv24
{
  M[p + 2] ++ M[p + 1] ++ M[p]
}

function {:inline} $load.bytes.bv16(M: [ref]bv8, p: int) : bv16
{
  M[p + 1] ++ M[p]
}

function {:inline} $load.bytes.bv8(M: [ref]bv8, p: int) : bv8
{
  M[p]
}

function {:inline} $store.i128(M: [ref]i128, p: int, v: int) : [ref]i128
{
  M[p := v]
}

function {:inline} $store.i96(M: [ref]i96, p: int, v: int) : [ref]i96
{
  M[p := v]
}

function {:inline} $store.i64(M: [ref]i64, p: int, v: int) : [ref]i64
{
  M[p := v]
}

function {:inline} $store.i56(M: [ref]i56, p: int, v: int) : [ref]i56
{
  M[p := v]
}

function {:inline} $store.i48(M: [ref]i48, p: int, v: int) : [ref]i48
{
  M[p := v]
}

function {:inline} $store.i40(M: [ref]i40, p: int, v: int) : [ref]i40
{
  M[p := v]
}

function {:inline} $store.i32(M: [ref]i32, p: int, v: int) : [ref]i32
{
  M[p := v]
}

function {:inline} $store.i24(M: [ref]i24, p: int, v: int) : [ref]i24
{
  M[p := v]
}

function {:inline} $store.i16(M: [ref]i16, p: int, v: int) : [ref]i16
{
  M[p := v]
}

function {:inline} $store.i8(M: [ref]i8, p: int, v: int) : [ref]i8
{
  M[p := v]
}

function {:inline} $store.bv128(M: [ref]bv128, p: int, v: bv128) : [ref]bv128
{
  M[p := v]
}

function {:inline} $store.bv96(M: [ref]bv96, p: int, v: bv96) : [ref]bv96
{
  M[p := v]
}

function {:inline} $store.bv64(M: [ref]bv64, p: int, v: bv64) : [ref]bv64
{
  M[p := v]
}

function {:inline} $store.bv56(M: [ref]bv56, p: int, v: bv56) : [ref]bv56
{
  M[p := v]
}

function {:inline} $store.bv48(M: [ref]bv48, p: int, v: bv48) : [ref]bv48
{
  M[p := v]
}

function {:inline} $store.bv40(M: [ref]bv40, p: int, v: bv40) : [ref]bv40
{
  M[p := v]
}

function {:inline} $store.bv32(M: [ref]bv32, p: int, v: bv32) : [ref]bv32
{
  M[p := v]
}

function {:inline} $store.bv24(M: [ref]bv24, p: int, v: bv24) : [ref]bv24
{
  M[p := v]
}

function {:inline} $store.bv16(M: [ref]bv16, p: int, v: bv16) : [ref]bv16
{
  M[p := v]
}

function {:inline} $store.bv8(M: [ref]bv8, p: int, v: bv8) : [ref]bv8
{
  M[p := v]
}

function {:inline} $store.bytes.bv128(M: [ref]bv8, p: int, v: bv128) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]][p + 5 := v[48:40]][p + 6 := v[56:48]][p + 7 := v[64:56]][p + 7 := v[72:64]][p + 8 := v[80:72]][p + 9 := v[88:80]][p + 10 := v[96:88]][p + 11 := v[104:96]][p + 12 := v[112:104]][p + 13 := v[120:112]][p + 14 := v[128:120]]
}

function {:inline} $store.bytes.bv96(M: [ref]bv8, p: int, v: bv96) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]][p + 5 := v[48:40]][p + 6 := v[56:48]][p + 7 := v[64:56]][p + 7 := v[72:64]][p + 8 := v[80:72]][p + 9 := v[88:80]][p + 10 := v[96:88]]
}

function {:inline} $store.bytes.bv64(M: [ref]bv8, p: int, v: bv64) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]][p + 5 := v[48:40]][p + 6 := v[56:48]][p + 7 := v[64:56]]
}

function {:inline} $store.bytes.bv56(M: [ref]bv8, p: int, v: bv56) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]][p + 5 := v[48:40]][p + 6 := v[56:48]]
}

function {:inline} $store.bytes.bv48(M: [ref]bv8, p: int, v: bv48) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]][p + 5 := v[48:40]]
}

function {:inline} $store.bytes.bv40(M: [ref]bv8, p: int, v: bv40) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]][p + 4 := v[40:32]]
}

function {:inline} $store.bytes.bv32(M: [ref]bv8, p: int, v: bv32) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]][p + 3 := v[32:24]]
}

function {:inline} $store.bytes.bv24(M: [ref]bv8, p: int, v: bv24) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]][p + 2 := v[24:16]]
}

function {:inline} $store.bytes.bv16(M: [ref]bv8, p: int, v: bv16) : [ref]bv8
{
  M[p := v[8:0]][p + 1 := v[16:8]]
}

function {:inline} $store.bytes.bv8(M: [ref]bv8, p: int, v: bv8) : [ref]bv8
{
  M[p := v]
}

function {:inline} $load.ref(M: [ref]ref, p: int) : int
{
  M[p]
}

function {:inline} $store.ref(M: [ref]ref, p: int, v: int) : [ref]ref
{
  M[p := v]
}

function {:inline} $load.float(M: [ref]float, p: int) : int
{
  M[p]
}

function {:inline} $store.float(M: [ref]float, p: int, v: int) : [ref]float
{
  M[p := v]
}

type $mop;

procedure boogie_si_record_mop(m: $mop);



const $MOP: $mop;

procedure boogie_si_record_bool(i: bool);



procedure boogie_si_record_i1(i: int);



procedure boogie_si_record_i8(i: int);



procedure boogie_si_record_i16(i: int);



procedure boogie_si_record_i24(i: int);



procedure boogie_si_record_i32(i: int);



procedure boogie_si_record_i40(i: int);



procedure boogie_si_record_i48(i: int);



procedure boogie_si_record_i56(i: int);



procedure boogie_si_record_i64(i: int);



procedure boogie_si_record_i96(i: int);



procedure boogie_si_record_i128(i: int);



procedure boogie_si_record_bv1(i: bv1);



procedure boogie_si_record_bv8(i: bv8);



procedure boogie_si_record_bv16(i: bv16);



procedure boogie_si_record_bv24(i: bv24);



procedure boogie_si_record_bv32(i: bv32);



procedure boogie_si_record_bv40(i: bv40);



procedure boogie_si_record_bv48(i: bv48);



procedure boogie_si_record_bv56(i: bv56);



procedure boogie_si_record_bv64(i: bv64);



procedure boogie_si_record_bv96(i: bv96);



procedure boogie_si_record_bv128(i: bv128);



procedure boogie_si_record_ref(i: int);



procedure boogie_si_record_float(i: int);



var $Alloc: [ref]bool;

var {:AllocatorVar} $CurrAddr: int;

procedure {:allocator} {:inline 1} $alloc(n: int) returns (p: int);
  modifies $CurrAddr, $Alloc;



implementation {:inline 1} $alloc(n: int) returns (p: int)
{

  anon0:
    assume $CurrAddr > NULL;
    p := $CurrAddr;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} n > NULL;
    $CurrAddr := $CurrAddr + n;
    goto anon3;

  anon4_Else:
    assume {:partition} !(n > NULL);
    $CurrAddr := $CurrAddr + 1;
    goto anon3;

  anon3:
    $Alloc[p] := true;
    return;
}



procedure {:inline 1} $free(p: int);
  modifies $Alloc;



implementation {:inline 1} $free(p: int)
{

  anon0:
    $Alloc[p] := false;
    return;
}



var $exn: bool;

var $exnv: int;

function $extractvalue(p: int, i: int) : int;

const __SMACK_top_decl: int;

axiom __SMACK_top_decl == NULL - 108;

procedure __SMACK_top_decl.ref($p0: int);



const __SMACK_init_func_memory_model: int;

axiom __SMACK_init_func_memory_model == NULL - 116;

procedure __SMACK_init_func_memory_model();



implementation __SMACK_init_func_memory_model()
{

  $bb0:
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1012, 3} true;
    $CurrAddr := 1024;
    assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1013, 1} true;
    $exn := false;
    return;
}



const main: int;

axiom main == NULL - 124;

procedure {:entrypoint} main() returns ({:scalar} $r: int);



implementation {:entrypoint} main() returns ($r: int)
{
  var $p0: int;
  var $p1: int;
  var $p2: int;

  $bb0:
    call $initialize();
    assume {:sourceloc "t13.c", 8, 21} true;
    call $p0 := malloc(8);
    assume {:sourceloc "t13.c", 8, 13} true;
    $p1 := $p0;
    call {:cexpr "x"} boogie_si_record_ref($p1);
    assume {:sourceloc "t13.c", 9, 3} true;
    assert !aliasQ0($p1, NULL);
    $M.1 := $M.1[$p1 := NULL];
    assume {:sourceloc "t13.c", 10, 3} true;
    call foo($p1);
    assume {:sourceloc "t13.c", 11, 4} true;
    assert !aliasQ1($p1, NULL);
    $p2 := $M.1[$p1];
    assume {:sourceloc "t13.c", 11, 3} true;
    assert !aliasQ2($p2, NULL);
    $M.0 := $M.0[$p2 := 1];
    assume {:sourceloc "t13.c", 12, 1} true;
    $r := NULL;
    $exn := false;
    return;
}



const malloc: int;

axiom malloc == NULL - 132;

procedure {:allocator} malloc({:scalar} $i0: int) returns ($r: int);



implementation malloc($i0: int) returns ($r: int)
{

  anon0:
    call $r := $alloc($i0);
    return;
}



const foo: int;

axiom foo == NULL - 140;

procedure foo({:ref "$M.1"} $p0: int);



const llvm.dbg.value: int;

axiom llvm.dbg.value == NULL - 148;

procedure llvm.dbg.value({:scalar} $p0: int, {:scalar} $i1: int, {:scalar} $p2: int, {:scalar} $p3: int);



const __SMACK_static_init: int;

axiom __SMACK_static_init == NULL - 156;

procedure __SMACK_static_init();



implementation __SMACK_static_init()
{

  $bb0:
    $exn := false;
    return;
}



procedure $initialize();



implementation $initialize()
{

  anon0:
    call __SMACK_static_init();
    call __SMACK_init_func_memory_model();
    return;
}



const {:allocated} NULL: int;

axiom NULL == 0;

function {:inline} {:aliasingQuery} aliasQ0(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ1(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ2(a: int, b: int) : bool
{
  a == b
}
