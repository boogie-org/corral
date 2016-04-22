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

axiom $GLOBALS_BOTTOM == NULL - 278;

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

const .str1262: int;

axiom .str1262 == NULL - 81;

const .str11263: int;

axiom .str11263 == NULL - 83;

const .str21264: int;

axiom .str21264 == NULL - 85;

const .str31265: int;

axiom .str31265 == NULL - 90;

const .str41266: int;

axiom .str41266 == NULL - 92;

const .str51267: int;

axiom .str51267 == NULL - 124;

const .str61268: int;

axiom .str61268 == NULL - 155;

const .str71269: int;

axiom .str71269 == NULL - 158;

const llvm.dbg.declare: int;

axiom llvm.dbg.declare == NULL - 166;

procedure llvm.dbg.declare({:scalar} $p0: int, {:scalar} $p1: int, {:scalar} $p2: int);



const __SMACK_dummy: int;

axiom __SMACK_dummy == NULL - 174;

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

axiom __SMACK_code == NULL - 182;

procedure __SMACK_code.ref($p0: int);



const __SMACK_decls: int;

axiom __SMACK_decls == NULL - 190;

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

axiom __SMACK_top_decl == NULL - 198;

procedure __SMACK_top_decl.ref($p0: int);



const __SMACK_init_func_memory_model: int;

axiom __SMACK_init_func_memory_model == NULL - 206;

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

axiom main == NULL - 214;

procedure {:entrypoint} main() returns ({:scalar} $r: int);



implementation {:entrypoint} main() returns ($r: int)
{
  var $p0: int;
  var $p1: int;
  var $p2: int;
  var $p3: int;
  var $p4: int;
  var $p5: int;
  var $p6: int;
  var $p7: int;
  var $p8: int;
  var $p9: int;
  var {:scalar} $i10: int;
  var {:scalar} $i11: int;
  var $p12: int;
  var $p13: int;
  var $p14: int;
  var {:scalar} $i15: int;
  var $p16: int;
  var $p17: int;
  var $p18: int;
  var {:scalar} $i19: int;
  var {:scalar} $i20: int;
  var {:scalar} $i21: int;
  var {:scalar} $i22: int;
  var $p23: int;
  var $p24: int;
  var $p25: int;
  var {:scalar} $i26: int;
  var $p27: int;
  var $p28: int;
  var {:scalar} $i29: int;
  var $p31: int;
  var $p32: int;
  var $p33: int;
  var $p34: int;
  var {:scalar} $i35: int;
  var $p36: int;
  var {:scalar} $i37: int;
  var {:scalar} $i38: int;
  var $p39: int;
  var $p40: int;
  var $p41: int;
  var $p42: int;
  var $p30: int;
  var {:scalar} $i43: int;
  var {:scalar} $i44: int;
  var $p45: int;
  var $p46: int;
  var {:scalar} $i47: int;
  var $p48: int;
  var $p49: int;
  var $p50: int;
  var $p51: int;
  var $p52: int;
  var $p53: int;
  var $p54: int;
  var $p55: int;
  var $p56: int;
  var {:scalar} $i57: int;
  var $p58: int;
  var $p59: int;
  var $p60: int;
  var $p61: int;
  var $p62: int;
  var $p63: int;
  var $p64: int;
  var $p65: int;
  var $p66: int;
  var $p67: int;
  var $p68: int;
  var $p69: int;
  var $p70: int;
  var $p71: int;
  var $p72: int;
  var $p73: int;
  var $p74: int;
  var {:scalar} $i75: int;
  var {:scalar} $i76: int;
  var $p77: int;
  var $p78: int;
  var $p79: int;
  var {:scalar} $i80: int;
  var $p81: int;
  var $p82: int;
  var $p83: int;
  var {:scalar} $i84: int;
  var {:scalar} $i85: int;
  var {:scalar} $i86: int;
  var {:scalar} $i87: int;
  var $p88: int;
  var $p89: int;
  var $p90: int;
  var {:scalar} $i91: int;
  var $p92: int;
  var $p93: int;
  var {:scalar} $i94: int;
  var $p96: int;
  var $p97: int;
  var $p98: int;
  var $p99: int;
  var {:scalar} $i100: int;
  var $p101: int;
  var {:scalar} $i102: int;
  var {:scalar} $i103: int;
  var $p104: int;
  var $p105: int;
  var $p106: int;
  var $p107: int;
  var $p95: int;
  var {:scalar} $i108: int;
  var {:scalar} $i109: int;
  var $p110: int;
  var $p111: int;
  var {:scalar} $i112: int;
  var $p113: int;
  var $p114: int;
  var $p115: int;
  var $p116: int;
  var $p117: int;
  var $p118: int;
  var $p119: int;
  var $p120: int;
  var $p121: int;
  var {:scalar} $i122: int;
  var $p123: int;
  var $p124: int;
  var $p125: int;
  var $p126: int;
  var $p127: int;
  var $p128: int;
  var $p129: int;
  var $p130: int;
  var $p131: int;
  var $p132: int;
  var $p133: int;
  var $p134: int;
  var $p135: int;
  var $p136: int;
  var $p137: int;
  var $p138: int;
  var $p139: int;
  var {:scalar} $i140: int;
  var {:scalar} $i141: int;
  var $p142: int;
  var $p143: int;
  var $p144: int;
  var {:scalar} $i145: int;
  var $p146: int;
  var $p147: int;
  var $p148: int;
  var {:scalar} $i149: int;
  var {:scalar} $i150: int;
  var {:scalar} $i151: int;
  var {:scalar} $i152: int;
  var $p153: int;
  var $p154: int;
  var $p155: int;
  var {:scalar} $i156: int;
  var $p157: int;
  var $p158: int;
  var {:scalar} $i159: int;
  var $p160: int;
  var {:scalar} $i161: int;
  var $p162: int;
  var $p163: int;
  var $p164: int;
  var {:scalar} $i165: int;
  var $p166: int;
  var $p167: int;
  var {:scalar} $i168: int;
  var {:scalar} $i169: int;
  var {:scalar} $i170: int;
  var {:scalar} $i171: int;
  var $p172: int;
  var {:scalar} $i173: int;
  var {:scalar} $i176: int;
  var $p177: int;
  var $p178: int;
  var $p179: int;
  var {:scalar} $i180: int;
  var {:scalar} $i181: int;
  var {:scalar} $i174: int;
  var $p175: int;
  var {:scalar} $i182: int;
  var {:scalar} $i183: int;
  var $p184: int;
  var $p185: int;
  var $p186: int;
  var {:scalar} $i187: int;
  var {:scalar} $i188: int;
  var {:scalar} $i189: int;
  var {:scalar} $i190: int;
  var {:scalar} $i191: int;
  var $p192: int;
  var $p193: int;
  var $p194: int;
  var {:scalar} $i195: int;
  var {:scalar} $i201: int;
  var {:scalar} $i202: int;
  var {:scalar} $i203: int;
  var $p204: int;
  var $p205: int;
  var $p206: int;
  var {:scalar} $i207: int;
  var {:scalar} $i208: int;
  var {:scalar} $i209: int;
  var $p210: int;
  var $p211: int;
  var $p212: int;
  var {:scalar} $i213: int;
  var $p214: int;
  var $p215: int;
  var $p216: int;
  var {:scalar} $i217: int;
  var {:scalar} $i196: int;
  var {:scalar} $i197: int;
  var $p198: int;
  var $p199: int;
  var $p200: int;
  var {:scalar} $i218: int;
  var $p219: int;
  var $p220: int;
  var $p221: int;
  var $p222: int;
  var $p223: int;
  var $p224: int;
  var $p225: int;
  var $p226: int;
  var $p227: int;
  var {:scalar} $i228: int;
  var $p229: int;
  var $p230: int;
  var $p231: int;
  var {:scalar} $i232: int;
  var $p233: int;
  var $p234: int;
  var $p235: int;
  var $p236: int;
  var $p237: int;
  var $p238: int;
  var $p239: int;
  var {:scalar} $i240: int;
  var {:scalar} $i241: int;
  var $p242: int;
  var $p243: int;
  var $p244: int;
  var {:scalar} $i245: int;
  var $p246: int;
  var $p247: int;
  var $p248: int;
  var {:scalar} $i249: int;
  var {:scalar} $i250: int;
  var {:scalar} $i251: int;
  var {:scalar} $i252: int;
  var $p253: int;
  var $p254: int;
  var $p255: int;
  var {:scalar} $i256: int;
  var $p257: int;
  var $p258: int;
  var {:scalar} $i259: int;
  var $p260: int;
  var $p261: int;
  var $p262: int;
  var {:scalar} $i263: int;
  var $p264: int;
  var $p265: int;
  var $p266: int;
  var $p267: int;
  var $p268: int;
  var {:scalar} $i269: int;
  var $p270: int;
  var $p271: int;
  var $p272: int;
  var $p273: int;
  var $p274: int;
  var $p275: int;
  var $p276: int;
  var $p277: int;
  var $p278: int;
  var {:scalar} $i279: int;
  var $p280: int;
  var $p281: int;
  var $p282: int;
  var $p283: int;
  var $p284: int;
  var $p285: int;
  var $p286: int;
  var $p287: int;
  var $p288: int;
  var $p289: int;
  var $p290: int;
  var $p291: int;
  var $p292: int;
  var $p293: int;
  var $p294: int;
  var $p295: int;
  var $p296: int;
  var {:scalar} $i297: int;
  var {:scalar} $i298: int;
  var $p299: int;
  var $p300: int;
  var $p301: int;
  var {:scalar} $i302: int;
  var $p303: int;
  var $p304: int;
  var $p305: int;
  var {:scalar} $i306: int;
  var {:scalar} $i307: int;
  var {:scalar} $i308: int;
  var {:scalar} $i309: int;
  var $p310: int;
  var $p311: int;
  var $p312: int;
  var {:scalar} $i313: int;

  $bb0:
    call $initialize();
    call $p0 := $alloc(8 * 1);
    assume true;
    assume {:sourceloc "list_sample.c", 31, 2} true;
    $p1 := $p0;
    assume {:sourceloc "list_sample.c", 31, 2} true;
    assert !aliasQ0($p1, NULL);
    $M.0 := $M.0[$p1 := NULL];
    assume {:sourceloc "list_sample.c", 33, 2} true;
    call $p2 := list_put($p0, 1);
    assume {:sourceloc "list_sample.c", 33, 24} true;
    call $p3 := list_put($p0, 2);
    assume {:sourceloc "list_sample.c", 33, 46} true;
    call $p4 := list_put($p0, 3);
    assume {:sourceloc "list_sample.c", 34, 2} true;
    call $p5 := list_put($p0, 4);
    assume {:sourceloc "list_sample.c", 34, 24} true;
    call $p6 := list_put($p0, 5);
    assume {:sourceloc "list_sample.c", 34, 46} true;
    call $p7 := list_put($p0, 6);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p8 := $p0;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assert !aliasQ1($p8, NULL);
    $p9 := $M.0[$p8];
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $i10 := (if $p9 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assume {:branchcond $i10} true;
    goto $bb1, $bb2;

  $bb1:
    assume $i10 == 1;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call $i11 := printf.ref(.str1262);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    goto $bb3;

  $bb2:
    assume !($i10 == 1);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p12 := $p0;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assert !aliasQ2($p12, NULL);
    $p13 := $M.0[$p12];
    call {:cexpr "arrow"} boogie_si_record_ref($p13);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p14 := $p13;
    goto $bb4;

  $bb3:
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call $i26 := printf.ref(.str41266);
    call {:cexpr "result_node"} boogie_si_record_ref(NULL);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p27 := $p0;
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assert !aliasQ3($p27, NULL);
    $p28 := $M.0[$p27];
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $i29 := (if $p28 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p30 := NULL;
    assume {:branchcond $i29} true;
    goto $bb10, $bb12;

  $bb4:
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $i15 := (if $p14 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assume {:branchcond $i15} true;
    goto $bb5, $bb6;

  $bb5:
    assume $i15 == 1;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p16 := $p14 + 8;
    $p17 := $p14 + 8;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assert !aliasQ4($p17, NULL);
    $p18 := $M.0[$p17];
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $i19 := (if $p18 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call $i20 := printf.ref(.str11263);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call smpl_print($p14);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assume {:branchcond $i19} true;
    goto $bb7, $bb8;

  $bb6:
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assume !($i15 == 1);
    goto $bb3;

  $bb7:
    assume $i19 == 1;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call $i21 := printf.ref(.str21264);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    goto $bb9;

  $bb8:
    assume !($i19 == 1);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    call $i22 := printf.ref(.str31265);
    goto $bb9;

  $bb9:
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p23 := $p14 + 8;
    $p24 := $p14 + 8;
    assume {:sourceloc "list_sample.c", 36, 2} true;
    assert !aliasQ5($p24, NULL);
    $p25 := $M.0[$p24];
    call {:cexpr "arrow"} boogie_si_record_ref($p25);
    assume {:sourceloc "list_sample.c", 36, 2} true;
    $p14 := $p25;
    goto $bb4;

  $bb10:
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assume $i29 == 1;
    goto $bb11;

  $bb11:
    assume {:sourceloc "list_sample.c", 39, 6} true;
    $i43 := (if $p30 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 39, 6} true;
    assume {:branchcond $i43} true;
    goto $bb19, $bb20;

  $bb12:
    assume !($i29 == 1);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p31 := $p0;
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assert !aliasQ6($p31, NULL);
    $p32 := $M.0[$p31];
    call {:cexpr "arrow"} boogie_si_record_ref($p32);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p33, $p34 := $p32, NULL;
    goto $bb13;

  $bb13:
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $i35 := (if $p33 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p30 := $p34;
    assume {:branchcond $i35} true;
    goto $bb14, $bb15;

  $bb14:
    assume $i35 == 1;
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p36 := $p33;
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assert !aliasQ7($p36, NULL);
    $i37 := $M.0[$p36];
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $i38 := (if $i37 == 3 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p39 := $p34;
    assume {:branchcond $i38} true;
    goto $bb16, $bb17;

  $bb15:
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assume !($i35 == 1);
    goto $bb11;

  $bb16:
    assume $i38 == 1;
    call {:cexpr "result_node"} boogie_si_record_ref($p33);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p39 := $p33;
    goto $bb18;

  $bb17:
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assume !($i38 == 1);
    goto $bb18;

  $bb18:
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p40 := $p33 + 8;
    $p41 := $p33 + 8;
    assume {:sourceloc "list_sample.c", 38, 2} true;
    assert !aliasQ8($p41, NULL);
    $p42 := $M.0[$p41];
    call {:cexpr "arrow"} boogie_si_record_ref($p42);
    assume {:sourceloc "list_sample.c", 38, 2} true;
    $p33, $p34 := $p42, $p39;
    goto $bb13;

  $bb19:
    assume $i43 == 1;
    assume {:sourceloc "list_sample.c", 40, 3} true;
    call $i44 := printf.ref(.str51267);
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p45 := $p0;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ9($p45, NULL);
    $p46 := $M.0[$p45];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $i47 := (if $p46 == $p30 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assume {:branchcond $i47} true;
    goto $bb22, $bb23;

  $bb20:
    assume {:sourceloc "list_sample.c", 39, 6} true;
    assume !($i43 == 1);
    goto $bb21;

  $bb21:
    call {:cexpr "result_node"} boogie_si_record_ref(NULL);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p92 := $p0;
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assert !aliasQ10($p92, NULL);
    $p93 := $M.0[$p92];
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $i94 := (if $p93 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p95 := NULL;
    assume {:branchcond $i94} true;
    goto $bb37, $bb39;

  $bb22:
    assume $i47 == 1;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p48 := $p0;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ11($p48, NULL);
    $p49 := $M.0[$p48];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p50 := $p49 + 8;
    $p51 := $p49 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ12($p51, NULL);
    $p52 := $M.0[$p51];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p53 := $p0;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ13($p53, NULL);
    $M.0 := $M.0[$p53 := $p52];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    goto $bb24;

  $bb23:
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assume !($i47 == 1);
    goto $bb24;

  $bb24:
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p54 := $p30 + 8;
    $p55 := $p30 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ14($p55, NULL);
    $p56 := $M.0[$p55];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $i57 := (if $p56 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assume {:branchcond $i57} true;
    goto $bb25, $bb26;

  $bb25:
    assume $i57 == 1;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p58 := $p30 + 8;
    $p59 := $p30 + 8 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ15($p59, NULL);
    $p60 := $M.0[$p59];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p61 := $p30 + 8;
    $p62 := $p30 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ16($p62, NULL);
    $p63 := $M.0[$p62];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p64 := $p63 + 8;
    $p65 := $p63 + 8 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ17($p65, NULL);
    $M.0 := $M.0[$p65 := $p60];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    goto $bb27;

  $bb26:
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assume !($i57 == 1);
    goto $bb27;

  $bb27:
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p66 := $p30 + 8;
    $p67 := $p30 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ18($p67, NULL);
    $p68 := $M.0[$p67];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p69 := $p30 + 8;
    $p70 := $p30 + 8 + 8;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ19($p70, NULL);
    $p71 := $M.0[$p70];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    assert !aliasQ20($p71, NULL);
    $M.0 := $M.0[$p71 := $p68];
    assume {:sourceloc "list_sample.c", 41, 3} true;
    $p72 := $p30;
    assume {:sourceloc "list_sample.c", 41, 3} true;
    call free_($p72);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p73 := $p0;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assert !aliasQ21($p73, NULL);
    $p74 := $M.0[$p73];
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $i75 := (if $p74 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assume {:branchcond $i75} true;
    goto $bb28, $bb29;

  $bb28:
    assume $i75 == 1;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call $i76 := printf.ref(.str1262);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    goto $bb30;

  $bb29:
    assume !($i75 == 1);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p77 := $p0;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assert !aliasQ22($p77, NULL);
    $p78 := $M.0[$p77];
    call {:cexpr "arrow"} boogie_si_record_ref($p78);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p79 := $p78;
    goto $bb31;

  $bb30:
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call $i91 := printf.ref(.str41266);
    assume {:sourceloc "list_sample.c", 43, 2} true;
    goto $bb21;

  $bb31:
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $i80 := (if $p79 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assume {:branchcond $i80} true;
    goto $bb32, $bb33;

  $bb32:
    assume $i80 == 1;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p81 := $p79 + 8;
    $p82 := $p79 + 8;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assert !aliasQ23($p82, NULL);
    $p83 := $M.0[$p82];
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $i84 := (if $p83 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call $i85 := printf.ref(.str11263);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call smpl_print($p79);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assume {:branchcond $i84} true;
    goto $bb34, $bb35;

  $bb33:
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assume !($i80 == 1);
    goto $bb30;

  $bb34:
    assume $i84 == 1;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call $i86 := printf.ref(.str21264);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    goto $bb36;

  $bb35:
    assume !($i84 == 1);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    call $i87 := printf.ref(.str31265);
    goto $bb36;

  $bb36:
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p88 := $p79 + 8;
    $p89 := $p79 + 8;
    assume {:sourceloc "list_sample.c", 42, 3} true;
    assert !aliasQ24($p89, NULL);
    $p90 := $M.0[$p89];
    call {:cexpr "arrow"} boogie_si_record_ref($p90);
    assume {:sourceloc "list_sample.c", 42, 3} true;
    $p79 := $p90;
    goto $bb31;

  $bb37:
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assume $i94 == 1;
    goto $bb38;

  $bb38:
    assume {:sourceloc "list_sample.c", 46, 6} true;
    $i108 := (if $p95 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 46, 6} true;
    assume {:branchcond $i108} true;
    goto $bb46, $bb47;

  $bb39:
    assume !($i94 == 1);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p96 := $p0;
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assert !aliasQ25($p96, NULL);
    $p97 := $M.0[$p96];
    call {:cexpr "arrow"} boogie_si_record_ref($p97);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p98, $p99 := $p97, NULL;
    goto $bb40;

  $bb40:
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $i100 := (if $p98 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p95 := $p99;
    assume {:branchcond $i100} true;
    goto $bb41, $bb42;

  $bb41:
    assume $i100 == 1;
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p101 := $p98;
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assert !aliasQ26($p101, NULL);
    $i102 := $M.0[$p101];
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $i103 := (if $i102 == 3 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p104 := $p99;
    assume {:branchcond $i103} true;
    goto $bb43, $bb44;

  $bb42:
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assume !($i100 == 1);
    goto $bb38;

  $bb43:
    assume $i103 == 1;
    call {:cexpr "result_node"} boogie_si_record_ref($p98);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p104 := $p98;
    goto $bb45;

  $bb44:
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assume !($i103 == 1);
    goto $bb45;

  $bb45:
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p105 := $p98 + 8;
    $p106 := $p98 + 8;
    assume {:sourceloc "list_sample.c", 45, 2} true;
    assert !aliasQ27($p106, NULL);
    $p107 := $M.0[$p106];
    call {:cexpr "arrow"} boogie_si_record_ref($p107);
    assume {:sourceloc "list_sample.c", 45, 2} true;
    $p98, $p99 := $p107, $p104;
    goto $bb40;

  $bb46:
    assume $i108 == 1;
    assume {:sourceloc "list_sample.c", 47, 3} true;
    call $i109 := printf.ref(.str61268);
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p110 := $p0;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ28($p110, NULL);
    $p111 := $M.0[$p110];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $i112 := (if $p111 == $p95 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assume {:branchcond $i112} true;
    goto $bb49, $bb50;

  $bb47:
    assume {:sourceloc "list_sample.c", 46, 6} true;
    assume !($i108 == 1);
    goto $bb48;

  $bb48:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p157 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ29($p157, NULL);
    $p158 := $M.0[$p157];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i159 := (if $p158 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i159} true;
    goto $bb64, $bb65;

  $bb49:
    assume $i112 == 1;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p113 := $p0;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ30($p113, NULL);
    $p114 := $M.0[$p113];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p115 := $p114 + 8;
    $p116 := $p114 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ31($p116, NULL);
    $p117 := $M.0[$p116];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p118 := $p0;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ32($p118, NULL);
    $M.0 := $M.0[$p118 := $p117];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    goto $bb51;

  $bb50:
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assume !($i112 == 1);
    goto $bb51;

  $bb51:
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p119 := $p95 + 8;
    $p120 := $p95 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ33($p120, NULL);
    $p121 := $M.0[$p120];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $i122 := (if $p121 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assume {:branchcond $i122} true;
    goto $bb52, $bb53;

  $bb52:
    assume $i122 == 1;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p123 := $p95 + 8;
    $p124 := $p95 + 8 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ34($p124, NULL);
    $p125 := $M.0[$p124];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p126 := $p95 + 8;
    $p127 := $p95 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ35($p127, NULL);
    $p128 := $M.0[$p127];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p129 := $p128 + 8;
    $p130 := $p128 + 8 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ36($p130, NULL);
    $M.0 := $M.0[$p130 := $p125];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    goto $bb54;

  $bb53:
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assume !($i122 == 1);
    goto $bb54;

  $bb54:
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p131 := $p95 + 8;
    $p132 := $p95 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ37($p132, NULL);
    $p133 := $M.0[$p132];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p134 := $p95 + 8;
    $p135 := $p95 + 8 + 8;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ38($p135, NULL);
    $p136 := $M.0[$p135];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    assert !aliasQ39($p136, NULL);
    $M.0 := $M.0[$p136 := $p133];
    assume {:sourceloc "list_sample.c", 48, 3} true;
    $p137 := $p95;
    assume {:sourceloc "list_sample.c", 48, 3} true;
    call free_($p137);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p138 := $p0;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assert !aliasQ40($p138, NULL);
    $p139 := $M.0[$p138];
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $i140 := (if $p139 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assume {:branchcond $i140} true;
    goto $bb55, $bb56;

  $bb55:
    assume $i140 == 1;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call $i141 := printf.ref(.str1262);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    goto $bb57;

  $bb56:
    assume !($i140 == 1);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p142 := $p0;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assert !aliasQ41($p142, NULL);
    $p143 := $M.0[$p142];
    call {:cexpr "arrow"} boogie_si_record_ref($p143);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p144 := $p143;
    goto $bb58;

  $bb57:
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call $i156 := printf.ref(.str41266);
    assume {:sourceloc "list_sample.c", 50, 2} true;
    goto $bb48;

  $bb58:
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $i145 := (if $p144 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assume {:branchcond $i145} true;
    goto $bb59, $bb60;

  $bb59:
    assume $i145 == 1;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p146 := $p144 + 8;
    $p147 := $p144 + 8;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assert !aliasQ42($p147, NULL);
    $p148 := $M.0[$p147];
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $i149 := (if $p148 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call $i150 := printf.ref(.str11263);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call smpl_print($p144);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assume {:branchcond $i149} true;
    goto $bb61, $bb62;

  $bb60:
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assume !($i145 == 1);
    goto $bb57;

  $bb61:
    assume $i149 == 1;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call $i151 := printf.ref(.str21264);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    goto $bb63;

  $bb62:
    assume !($i149 == 1);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    call $i152 := printf.ref(.str31265);
    goto $bb63;

  $bb63:
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p153 := $p144 + 8;
    $p154 := $p144 + 8;
    assume {:sourceloc "list_sample.c", 49, 3} true;
    assert !aliasQ43($p154, NULL);
    $p155 := $M.0[$p154];
    call {:cexpr "arrow"} boogie_si_record_ref($p155);
    assume {:sourceloc "list_sample.c", 49, 3} true;
    $p144 := $p155;
    goto $bb58;

  $bb64:
    assume $i159 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p160 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ44($p160, NULL);
    $M.0 := $M.0[$p160 := NULL];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    goto $bb66;

  $bb65:
    assume !($i159 == 1);
    call {:cexpr "insize"} boogie_si_record_i32(1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i161 := 1;
    goto $bb67;

  $bb66:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p233 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p234 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ45($p234, NULL);
    $p235 := $M.0[$p234];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p236 := $p235 + 8;
    $p237 := $p235 + 8 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ46($p237, NULL);
    $M.0 := $M.0[$p237 := $p233];
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p238 := $p0;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assert !aliasQ47($p238, NULL);
    $p239 := $M.0[$p238];
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $i240 := (if $p239 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assume {:branchcond $i240} true;
    goto $bb95, $bb96;

  $bb67:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p162 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ48($p162, NULL);
    $p163 := $M.0[$p162];
    call {:cexpr "p"} boogie_si_record_ref($p163);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p164 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ49($p164, NULL);
    $M.0 := $M.0[$p164 := NULL];
    call {:cexpr "tail"} boogie_si_record_ref(NULL);
    call {:cexpr "nmerges"} boogie_si_record_i32(NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i165, $p166, $p167 := NULL, NULL, $p163;
    goto $bb68;

  $bb68:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i168 := (if $p167 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i168} true;
    goto $bb69, $bb70;

  $bb69:
    assume $i168 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i169 := $i165 + 1;
    call {:cexpr "nmerges"} boogie_si_record_i32($i169);
    call {:cexpr "q"} boogie_si_record_ref($p167);
    call {:cexpr "psize"} boogie_si_record_i32(NULL);
    call {:cexpr "i"} boogie_si_record_i32(NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i170, $i171, $p172 := NULL, NULL, $p167;
    goto $bb71;

  $bb70:
    assume !($i168 == 1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p226 := $p166 + 8;
    $p227 := $p166 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ50($p227, NULL);
    $M.0 := $M.0[$p227 := NULL];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i228 := (if $i165 <= 1 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i228} true;
    goto $bb93, $bb94;

  $bb71:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i173 := (if $i170 < $i161 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i174, $p175 := $i171, $p172;
    assume {:branchcond $i173} true;
    goto $bb72, $bb73;

  $bb72:
    assume $i173 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i176 := $i171 + 1;
    call {:cexpr "psize"} boogie_si_record_i32($i176);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p177 := $p172 + 8;
    $p178 := $p172 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ51($p178, NULL);
    $p179 := $M.0[$p178];
    call {:cexpr "q"} boogie_si_record_ref($p179);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i180 := (if $p179 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i174, $p175 := $i176, $p179;
    assume {:branchcond $i180} true;
    goto $bb75, $bb76;

  $bb73:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume !($i173 == 1);
    goto $bb74;

  $bb74:
    call {:cexpr "qsize"} boogie_si_record_i32($i161);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i182, $i183, $p184, $p185, $p186 := $i161, $i174, $p166, $p175, $p167;
    goto $bb77;

  $bb75:
    assume $i180 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i181 := $i170 + 1;
    call {:cexpr "i"} boogie_si_record_i32($i181);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i170, $i171, $p172 := $i181, $i176, $p179;
    goto $bb71;

  $bb76:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume !($i180 == 1);
    goto $bb74;

  $bb77:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i187 := (if $i183 > NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i187} true;
    goto $bb78, $bb80;

  $bb78:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume $i187 == 1;
    goto $bb79;

  $bb79:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i191 := (if $i183 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i191} true;
    goto $bb83, $bb84;

  $bb80:
    assume !($i187 == 1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i188 := (if $i182 > NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i189 := (if $p185 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i190 := $and.i1($i188, $i189);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i190} true;
    goto $bb81, $bb82;

  $bb81:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume $i190 == 1;
    goto $bb79;

  $bb82:
    assume !($i190 == 1);
    call {:cexpr "p"} boogie_si_record_ref($p185);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i165, $p166, $p167 := $i169, $p184, $p185;
    goto $bb68;

  $bb83:
    assume $i191 == 1;
    call {:cexpr "e"} boogie_si_record_ref($p185);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p192 := $p185 + 8;
    $p193 := $p185 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ52($p193, NULL);
    $p194 := $M.0[$p193];
    call {:cexpr "q"} boogie_si_record_ref($p194);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i195 := $i182 + NULL - 1;
    call {:cexpr "qsize"} boogie_si_record_i32($i195);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i196, $i197, $p198, $p199, $p200 := $i195, $i183, $p185, $p194, $p186;
    goto $bb85;

  $bb84:
    assume !($i191 == 1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i201 := (if $i182 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i202 := (if $p185 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i203 := $and.i1($i201, $i202);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i203} true;
    goto $bb86, $bb87;

  $bb85:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i218 := (if $p184 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i218} true;
    goto $bb90, $bb91;

  $bb86:
    assume $i203 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    call $i208 := smpl_cmp($p186, $p185);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i209 := (if $i208 <= NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assume {:branchcond $i209} true;
    goto $bb88, $bb89;

  $bb87:
    assume !($i203 == 1);
    call {:cexpr "e"} boogie_si_record_ref($p186);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p204 := $p186 + 8;
    $p205 := $p186 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ53($p205, NULL);
    $p206 := $M.0[$p205];
    call {:cexpr "p"} boogie_si_record_ref($p206);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i207 := $i183 + NULL - 1;
    call {:cexpr "psize"} boogie_si_record_i32($i207);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i196, $i197, $p198, $p199, $p200 := $i182, $i207, $p186, $p185, $p206;
    goto $bb85;

  $bb88:
    assume $i209 == 1;
    call {:cexpr "e"} boogie_si_record_ref($p186);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p210 := $p186 + 8;
    $p211 := $p186 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ54($p211, NULL);
    $p212 := $M.0[$p211];
    call {:cexpr "p"} boogie_si_record_ref($p212);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i213 := $i183 + NULL - 1;
    call {:cexpr "psize"} boogie_si_record_i32($i213);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i196, $i197, $p198, $p199, $p200 := $i182, $i213, $p186, $p185, $p212;
    goto $bb85;

  $bb89:
    assume !($i209 == 1);
    call {:cexpr "e"} boogie_si_record_ref($p185);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p214 := $p185 + 8;
    $p215 := $p185 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ55($p215, NULL);
    $p216 := $M.0[$p215];
    call {:cexpr "q"} boogie_si_record_ref($p216);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i217 := $i182 + NULL - 1;
    call {:cexpr "qsize"} boogie_si_record_i32($i217);
    $i196, $i197, $p198, $p199, $p200 := $i217, $i183, $p185, $p216, $p186;
    goto $bb85;

  $bb90:
    assume $i218 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p219 := $p184 + 8;
    $p220 := $p184 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ56($p220, NULL);
    $M.0 := $M.0[$p220 := $p198];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    goto $bb92;

  $bb91:
    assume !($i218 == 1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p221 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ57($p221, NULL);
    $M.0 := $M.0[$p221 := $p198];
    goto $bb92;

  $bb92:
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p222 := $p184 + 8;
    $p223 := $p184 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p224 := $p198 + 8;
    $p225 := $p198 + 8 + 8;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ58($p225, NULL);
    $M.0 := $M.0[$p225 := $p223];
    call {:cexpr "tail"} boogie_si_record_ref($p198);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i182, $i183, $p184, $p185, $p186 := $i196, $i197, $p198, $p199, $p200;
    goto $bb77;

  $bb93:
    assume $i228 == 1;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p229 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ59($p229, NULL);
    $p230 := $M.0[$p229];
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $p231 := $p0;
    assume {:sourceloc "list_sample.c", 52, 2} true;
    assert !aliasQ60($p231, NULL);
    $M.0 := $M.0[$p231 := $p230];
    goto $bb66;

  $bb94:
    assume !($i228 == 1);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i232 := $i161 * 2;
    call {:cexpr "insize"} boogie_si_record_i32($i232);
    assume {:sourceloc "list_sample.c", 52, 2} true;
    $i161 := $i232;
    goto $bb67;

  $bb95:
    assume $i240 == 1;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call $i241 := printf.ref(.str1262);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    goto $bb97;

  $bb96:
    assume !($i240 == 1);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p242 := $p0;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assert !aliasQ61($p242, NULL);
    $p243 := $M.0[$p242];
    call {:cexpr "arrow"} boogie_si_record_ref($p243);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p244 := $p243;
    goto $bb98;

  $bb97:
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call $i256 := printf.ref(.str41266);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p257 := $p0;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ62($p257, NULL);
    $p258 := $M.0[$p257];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $i259 := (if $p258 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume {:branchcond $i259} true;
    goto $bb104, $bb106;

  $bb98:
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $i245 := (if $p244 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assume {:branchcond $i245} true;
    goto $bb99, $bb100;

  $bb99:
    assume $i245 == 1;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p246 := $p244 + 8;
    $p247 := $p244 + 8;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assert !aliasQ63($p247, NULL);
    $p248 := $M.0[$p247];
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $i249 := (if $p248 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call $i250 := printf.ref(.str11263);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call smpl_print($p244);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assume {:branchcond $i249} true;
    goto $bb101, $bb102;

  $bb100:
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assume !($i245 == 1);
    goto $bb97;

  $bb101:
    assume $i249 == 1;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call $i251 := printf.ref(.str21264);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    goto $bb103;

  $bb102:
    assume !($i249 == 1);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    call $i252 := printf.ref(.str31265);
    goto $bb103;

  $bb103:
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p253 := $p244 + 8;
    $p254 := $p244 + 8;
    assume {:sourceloc "list_sample.c", 54, 2} true;
    assert !aliasQ64($p254, NULL);
    $p255 := $M.0[$p254];
    call {:cexpr "arrow"} boogie_si_record_ref($p255);
    assume {:sourceloc "list_sample.c", 54, 2} true;
    $p244 := $p255;
    goto $bb98;

  $bb104:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume $i259 == 1;
    goto $bb105;

  $bb105:
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p295 := $p0;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assert !aliasQ65($p295, NULL);
    $p296 := $M.0[$p295];
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $i297 := (if $p296 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assume {:branchcond $i297} true;
    goto $bb116, $bb117;

  $bb106:
    assume !($i259 == 1);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p260 := $p0;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ66($p260, NULL);
    $p261 := $M.0[$p260];
    call {:cexpr "arrow"} boogie_si_record_ref($p261);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p262 := $p261;
    goto $bb107;

  $bb107:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $i263 := (if $p262 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume {:branchcond $i263} true;
    goto $bb108, $bb109;

  $bb108:
    assume $i263 == 1;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p264 := $p262 + 8;
    $p265 := $p262 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ67($p265, NULL);
    $p266 := $M.0[$p265];
    call {:cexpr "next"} boogie_si_record_ref($p266);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p267 := $p0;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ68($p267, NULL);
    $p268 := $M.0[$p267];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $i269 := (if $p268 == $p262 then 1 else NULL);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume {:branchcond $i269} true;
    goto $bb110, $bb111;

  $bb109:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume !($i263 == 1);
    goto $bb105;

  $bb110:
    assume $i269 == 1;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p270 := $p0;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ69($p270, NULL);
    $p271 := $M.0[$p270];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p272 := $p271 + 8;
    $p273 := $p271 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ70($p273, NULL);
    $p274 := $M.0[$p273];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p275 := $p0;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ71($p275, NULL);
    $M.0 := $M.0[$p275 := $p274];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    goto $bb112;

  $bb111:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume !($i269 == 1);
    goto $bb112;

  $bb112:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p276 := $p262 + 8;
    $p277 := $p262 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ72($p277, NULL);
    $p278 := $M.0[$p277];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $i279 := (if $p278 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume {:branchcond $i279} true;
    goto $bb113, $bb114;

  $bb113:
    assume $i279 == 1;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p280 := $p262 + 8;
    $p281 := $p262 + 8 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ73($p281, NULL);
    $p282 := $M.0[$p281];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p283 := $p262 + 8;
    $p284 := $p262 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ74($p284, NULL);
    $p285 := $M.0[$p284];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p286 := $p285 + 8;
    $p287 := $p285 + 8 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ75($p287, NULL);
    $M.0 := $M.0[$p287 := $p282];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    goto $bb115;

  $bb114:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assume !($i279 == 1);
    goto $bb115;

  $bb115:
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p288 := $p262 + 8;
    $p289 := $p262 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ76($p289, NULL);
    $p290 := $M.0[$p289];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p291 := $p262 + 8;
    $p292 := $p262 + 8 + 8;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ77($p292, NULL);
    $p293 := $M.0[$p292];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    assert !aliasQ78($p293, NULL);
    $M.0 := $M.0[$p293 := $p290];
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p294 := $p262;
    assume {:sourceloc "list_sample.c", 56, 2} true;
    call free_($p294);
    call {:cexpr "arrow"} boogie_si_record_ref($p266);
    assume {:sourceloc "list_sample.c", 56, 2} true;
    $p262 := $p266;
    goto $bb107;

  $bb116:
    assume $i297 == 1;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call $i298 := printf.ref(.str1262);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    goto $bb118;

  $bb117:
    assume !($i297 == 1);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p299 := $p0;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assert !aliasQ79($p299, NULL);
    $p300 := $M.0[$p299];
    call {:cexpr "arrow"} boogie_si_record_ref($p300);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p301 := $p300;
    goto $bb119;

  $bb118:
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call $i313 := printf.ref(.str41266);
    assume {:sourceloc "list_sample.c", 60, 2} true;
    $r := NULL;
    $exn := false;
    return;

  $bb119:
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $i302 := (if $p301 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assume {:branchcond $i302} true;
    goto $bb120, $bb121;

  $bb120:
    assume $i302 == 1;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p303 := $p301 + 8;
    $p304 := $p301 + 8;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assert !aliasQ80($p304, NULL);
    $p305 := $M.0[$p304];
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $i306 := (if $p305 == NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call $i307 := printf.ref(.str11263);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call smpl_print($p301);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assume {:branchcond $i306} true;
    goto $bb122, $bb123;

  $bb121:
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assume !($i302 == 1);
    goto $bb118;

  $bb122:
    assume $i306 == 1;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call $i308 := printf.ref(.str21264);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    goto $bb124;

  $bb123:
    assume !($i306 == 1);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    call $i309 := printf.ref(.str31265);
    goto $bb124;

  $bb124:
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p310 := $p301 + 8;
    $p311 := $p301 + 8;
    assume {:sourceloc "list_sample.c", 58, 2} true;
    assert !aliasQ81($p311, NULL);
    $p312 := $M.0[$p311];
    call {:cexpr "arrow"} boogie_si_record_ref($p312);
    assume {:sourceloc "list_sample.c", 58, 2} true;
    $p301 := $p312;
    goto $bb119;
}



const printf: int;

axiom printf == NULL - 222;

procedure printf.ref.i32($p0: int, p.1: int) returns ({:scalar} $r: int);



procedure printf.ref($p0: int) returns ({:scalar} $r: int);



const free_: int;

axiom free_ == NULL - 230;

procedure free_($p0: int);



implementation free_($p0: int)
{

  anon0:
    call $free($p0);
    return;
}



const calloc: int;

axiom calloc == NULL - 238;

procedure calloc({:scalar} $i0: int, {:scalar} $i1: int) returns ($r: int);



const list_put: int;

axiom list_put == NULL - 246;

procedure list_put(head: int, {:scalar} input: int) returns ($r: int);



implementation list_put(head: int, input: int) returns ($r: int)
{
  var $p0: int;
  var $p1: int;
  var $p2: int;
  var $p3: int;
  var $p4: int;
  var $p5: int;
  var $p6: int;
  var {:scalar} $i7: int;
  var $p8: int;
  var $p9: int;
  var $p10: int;
  var $p11: int;
  var $p12: int;
  var $p13: int;
  var $p14: int;
  var $p15: int;
  var $p16: int;
  var $p17: int;

  $bb0:
    call {:cexpr "head"} boogie_si_record_ref(head);
    call {:cexpr "input"} boogie_si_record_i32(input);
    assume {:sourceloc "list_sample.c", 13, 34} true;
    call $p0 := calloc(1, 24);
    assume {:sourceloc "list_sample.c", 13, 34} true;
    $p1 := $p0;
    call {:cexpr "new_node"} boogie_si_record_ref($p1);
    assume {:sourceloc "list_sample.c", 14, 2} true;
    $p2 := $p1;
    assume {:sourceloc "list_sample.c", 14, 2} true;
    assert !aliasQ82($p2, NULL);
    $M.0 := $M.0[$p2 := input];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p3 := head;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ83($p3, NULL);
    $p4 := $M.0[$p3];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p5 := $p1 + 8;
    $p6 := $p1 + 8;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ84($p6, NULL);
    $M.0 := $M.0[$p6 := $p4];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $i7 := (if $p4 != NULL then 1 else NULL);
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assume {:branchcond $i7} true;
    goto $bb1, $bb2;

  $bb1:
    assume $i7 == 1;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p8 := $p1 + 8;
    $p9 := $p1 + 8;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p10 := head;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ85($p10, NULL);
    $p11 := $M.0[$p10];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p12 := $p11 + 8;
    $p13 := $p11 + 8 + 8;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ86($p13, NULL);
    $M.0 := $M.0[$p13 := $p9];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    goto $bb3;

  $bb2:
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assume !($i7 == 1);
    goto $bb3;

  $bb3:
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p14 := head;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ87($p14, NULL);
    $M.0 := $M.0[$p14 := $p1];
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p15 := head;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    $p16 := $p1 + 8;
    $p17 := $p1 + 8 + 8;
    assume {:sourceloc "list_sample.c", 15, 2} true;
    assert !aliasQ88($p17, NULL);
    $M.0 := $M.0[$p17 := $p15];
    assume {:sourceloc "list_sample.c", 16, 2} true;
    $r := $p1;
    $exn := false;
    return;
}



const smpl_print: int;

axiom smpl_print == NULL - 254;

procedure smpl_print(a: int);



implementation smpl_print(a: int)
{
  var $p0: int;
  var {:scalar} $i1: int;
  var {:scalar} $i2: int;

  $bb0:
    call {:cexpr "a"} boogie_si_record_ref(a);
    assume {:sourceloc "list_sample.c", 24, 15} true;
    $p0 := a;
    assume {:sourceloc "list_sample.c", 24, 15} true;
    assert !aliasQ89($p0, NULL);
    $i1 := $M.0[$p0];
    assume {:sourceloc "list_sample.c", 24, 2} true;
    call $i2 := printf.ref.i32(.str71269, $i1);
    assume {:sourceloc "list_sample.c", 25, 1} true;
    $exn := false;
    return;
}



const smpl_cmp: int;

axiom smpl_cmp == NULL - 262;

procedure smpl_cmp(a: int, b: int) returns ({:scalar} $r: int);



implementation smpl_cmp(a: int, b: int) returns ($r: int)
{
  var $p0: int;
  var {:scalar} $i1: int;
  var $p2: int;
  var {:scalar} $i3: int;
  var {:scalar} $i4: int;

  $bb0:
    call {:cexpr "a"} boogie_si_record_ref(a);
    call {:cexpr "b"} boogie_si_record_ref(b);
    assume {:sourceloc "list_sample.c", 20, 9} true;
    $p0 := a;
    assume {:sourceloc "list_sample.c", 20, 9} true;
    assert !aliasQ90($p0, NULL);
    $i1 := $M.0[$p0];
    assume {:sourceloc "list_sample.c", 20, 19} true;
    $p2 := b;
    assume {:sourceloc "list_sample.c", 20, 19} true;
    assert !aliasQ91($p2, NULL);
    $i3 := $M.0[$p2];
    assume {:sourceloc "list_sample.c", 20, 9} true;
    $i4 := $i1 - $i3;
    assume {:sourceloc "list_sample.c", 20, 2} true;
    $r := $i4;
    $exn := false;
    return;
}



const llvm.dbg.value: int;

axiom llvm.dbg.value == NULL - 270;

procedure llvm.dbg.value({:scalar} $p0: int, {:scalar} $i1: int, {:scalar} $p2: int, {:scalar} $p3: int);



const __SMACK_static_init: int;

axiom __SMACK_static_init == NULL - 278;

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

function {:inline} {:aliasingQuery} aliasQ3(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ4(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ5(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ6(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ7(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ8(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ9(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ10(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ11(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ12(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ13(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ14(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ15(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ16(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ17(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ18(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ19(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ20(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ21(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ22(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ23(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ24(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ25(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ26(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ27(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ28(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ29(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ30(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ31(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ32(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ33(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ34(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ35(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ36(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ37(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ38(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ39(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ40(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ41(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ42(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ43(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ44(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ45(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ46(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ47(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ48(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ49(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ50(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ51(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ52(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ53(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ54(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ55(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ56(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ57(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ58(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ59(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ60(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ61(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ62(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ63(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ64(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ65(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ66(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ67(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ68(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ69(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ70(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ71(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ72(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ73(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ74(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ75(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ76(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ77(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ78(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ79(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ80(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ81(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ82(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ83(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ84(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ85(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ86(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ87(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ88(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ89(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ90(a: int, b: int) : bool
{
  a == b
}

function {:inline} {:aliasingQuery} aliasQ91(a: int, b: int) : bool
{
  a == b
}
