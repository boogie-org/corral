// SMACK-PRELUDE-BEGIN
// SMACK Flat Memory Model

function $ptr(obj:int, off:int) returns (int) {obj + off}
function $size(int) returns (int);
function $obj(int) returns (int);
function $off(ptr:int) returns (int) {ptr}

var $Mem: [int] int;
var $Alloc: [int] bool;
var $CurrAddr:int;

const unique $NULL: int;
axiom $NULL == 0;
const $UNDEF: int;

function $pa(pointer: int, offset: int, size: int) returns (int);
function $trunc(p: int) returns (int);
function $p2i(p: int) returns (int);
function $i2p(p: int) returns (int);
function $p2b(p: int) returns (bool);
function $b2p(b: bool) returns (int);

axiom (forall p:int, o:int, s:int :: {$pa(p,o,s)} $pa(p,o,s) == p + o * s);
axiom (forall p:int :: $trunc(p) == p);

axiom $b2p(true) == 1;
axiom $b2p(false) == 0;
axiom (forall i:int :: $p2b(i) <==> i != 0);
axiom $p2b(0) == false;
axiom (forall i:int :: $p2i(i) == i);
axiom (forall i:int :: $i2p(i) == i);

procedure __SMACK_nondet() returns (p: int);
procedure __SMACK_nondetInt() returns (p: int);
// SMACK Arithmetic Predicates

function $add(p1:int, p2:int) returns (int) {p1 + p2}
function $sub(p1:int, p2:int) returns (int) {p1 - p2}
function $mul(p1:int, p2:int) returns (int) {p1 * p2}
function $sdiv(p1:int, p2:int) returns (int);
function $udiv(p1:int, p2:int) returns (int);
function $srem(p1:int, p2:int) returns (int);
function $urem(p1:int, p2:int) returns (int);
function $and(p1:int, p2:int) returns (int);
function $or(p1:int, p2:int) returns (int);
function $xor(p1:int, p2:int) returns (int);
function $lshr(p1:int, p2:int) returns (int);
function $ashr(p1:int, p2:int) returns (int);
function $shl(p1:int, p2:int) returns (int);
function $ult(p1:int, p2:int) returns (bool) {p1 < p2}
function $ugt(p1:int, p2:int) returns (bool) {p1 > p2}
function $ule(p1:int, p2:int) returns (bool) {p1 <= p2}
function $uge(p1:int, p2:int) returns (bool) {p1 >= p2}
function $slt(p1:int, p2:int) returns (bool) {p1 < p2}
function $sgt(p1:int, p2:int) returns (bool) {p1 > p2}
function $sle(p1:int, p2:int) returns (bool) {p1 <= p2}
function $sge(p1:int, p2:int) returns (bool) {p1 >= p2}
function $i2b(i: int) returns (bool);
function $b2i(b: bool) returns (int);

// SMACK Arithmetic Axioms

axiom $and(0,0) == 0;
axiom $and(0,1) == 0;
axiom $and(1,0) == 0;
axiom $and(1,1) == 1;

axiom $or(0,0) == 0;
axiom $or(0,1) == 1;
axiom $or(1,0) == 1;
axiom $or(1,1) == 1;

axiom $xor(0,0) == 0;
axiom $xor(0,1) == 1;
axiom $xor(1,0) == 1;
axiom $xor(1,1) == 0;

axiom $b2i(true) == 1;
axiom $b2i(false) == 0;
axiom (forall i:int :: $i2b(i) <==> i != 0);
axiom $i2b(0) == false;

procedure boogie_si_record_int(i: int);

procedure $malloc(obj_size: int) returns (new: int);
modifies $CurrAddr, $Alloc;
requires obj_size > 0;
ensures 0 < old($CurrAddr);
ensures new == old($CurrAddr);
ensures $CurrAddr > old($CurrAddr) + obj_size;
ensures $size(new) == obj_size;
ensures (forall x:int :: new <= x && x < new + obj_size ==> $obj(x) == new);
ensures $Alloc[new];
ensures (forall x:int :: {$Alloc[x]} x == new || old($Alloc)[x] == $Alloc[x]);

procedure $alloca(obj_size: int) returns (new: int);
modifies $CurrAddr, $Alloc;
requires obj_size > 0;
ensures 0 < old($CurrAddr);
ensures new == old($CurrAddr);
ensures $CurrAddr > old($CurrAddr) + obj_size;
ensures $size(new) == obj_size;
ensures (forall x:int :: new <= x && x < new + obj_size ==> $obj(x) == new);
ensures $Alloc[new];
ensures (forall x:int :: {$Alloc[x]} x == new || old($Alloc)[x] == $Alloc[x]);

procedure $free(pointer: int);
modifies $Alloc;
requires $Alloc[pointer];
requires $obj(pointer) == pointer;
ensures !$Alloc[pointer];
ensures (forall x:int :: {$Alloc[x]} x == pointer || old($Alloc)[x] == $Alloc[x]);

procedure $memcpy(dest:int, src:int, len:int, align:int, isvolatile:bool);
modifies $Mem;
ensures (forall x:int :: dest <= x && x < dest + len ==> $Mem[x] == old($Mem)[src - dest + x]);
ensures (forall x:int :: !(dest <= x && x < dest + len) ==> $Mem[x] == old($Mem)[x]);

// SMACK-PRELUDE-END
// BEGIN SMACK-GENERATED CODE
const unique free_array: int;
axiom (free_array == -1024);
const unique main: int;
axiom (main == -2048);
procedure free_array() 
  modifies $Mem, $Alloc, $CurrAddr;
{
  var a: int;
  var i.0: int;
  var cmp: bool;
  var i.1: int;
  var cmp5: bool;
  var arrayidx7: int;
  var f8: int;
  var $p: int;
  var $p1: int;
  var cmp9: bool;
  var conv: int;
  var arrayidx10: int;
  var x11: int;
  var $p2: int;
  var cmp12: bool;
  var conv13: int;
  var arrayidx14: int;
  var f15: int;
  var $p3: int;
  var cmp16: bool;
  var inc23: int;
  var arrayidx18: int;
  var f19: int;
  var $p4: int;
  var $p5: int;
  var arrayidx20: int;
  var f21: int;
  var call_: int;
  var $p6: int;
  var arrayidx: int;
  var f: int;
  var arrayidx1: int;
  var f2: int;
  var $p7: int;
  var arrayidx3: int;
  var x: int;
  var inc: int;
$bb0:
  call a := $alloca($mul(80, 1));
  assume {:sourceloc "array_free1_fail.c", 15, 0} true;
  // WARNING: ignoring llvm.debug call.
  assume true;
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  // WARNING: ignoring llvm.debug call.
  assume true;
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  i.0 := $ptr($NULL, 0);
  goto $bb1;
$bb1:
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  cmp := $slt($off(i.0), $off($ptr($NULL, 9)));
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  goto $bb4, $bb5;
$bb2:
  assume {:sourceloc "array_free1_fail.c", 18, 0} true;
  call call_ := $malloc($off($ptr($NULL, 4)));
  assume {:sourceloc "array_free1_fail.c", 18, 0} true;
  // WARNING: ignoring bitcast instruction : %"$p6" = bitcast i8* %call to i32*, !dbg !28
  $p6 := call_;
  assume {:sourceloc "array_free1_fail.c", 18, 0} true;
  arrayidx := $pa($pa(a, 0, 80), $off(i.0), 8);
  assume {:sourceloc "array_free1_fail.c", 18, 0} true;
  f := $pa($pa(arrayidx, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 18, 0} true;
  $Mem[f] := $p6;
  assume {:sourceloc "array_free1_fail.c", 19, 0} true;
  arrayidx1 := $pa($pa(a, 0, 80), $off(i.0), 8);
  assume {:sourceloc "array_free1_fail.c", 19, 0} true;
  f2 := $pa($pa(arrayidx1, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 19, 0} true;
  $p7 := $Mem[f2];
  assume {:sourceloc "array_free1_fail.c", 19, 0} true;
  $Mem[$p7] := $ptr($NULL, 1);
  assume {:sourceloc "array_free1_fail.c", 20, 0} true;
  arrayidx3 := $pa($pa(a, 0, 80), $off(i.0), 8);
  assume {:sourceloc "array_free1_fail.c", 20, 0} true;
  x := $pa($pa(arrayidx3, 0, 8), 4, 1);
  assume {:sourceloc "array_free1_fail.c", 20, 0} true;
  $Mem[x] := $ptr($NULL, 2);
  assume {:sourceloc "array_free1_fail.c", 21, 0} true;
  goto $bb16;
$bb3:
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  // WARNING: ignoring llvm.debug call.
  assume true;
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  i.1 := $ptr($NULL, 0);
  goto $bb6;
$bb4:
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  assume cmp;
  goto $bb2;
$bb5:
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  assume !(cmp);
  goto $bb3;
$bb6:
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  cmp5 := $slt($off(i.1), $off($ptr($NULL, 10)));
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  goto $bb9, $bb10;
$bb7:
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  arrayidx7 := $pa($pa(a, 0, 80), $off(i.1), 8);
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  f8 := $pa($pa(arrayidx7, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  $p := $Mem[f8];
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  $p1 := $Mem[$p];
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  cmp9 := ($p1 == $ptr($NULL, 1));
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  conv := $b2p(cmp9);
  assume {:sourceloc "array_free1_fail.c", 24, 0} true;
  assert (conv != $ptr($NULL, 0));
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  arrayidx10 := $pa($pa(a, 0, 80), $off(i.1), 8);
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  x11 := $pa($pa(arrayidx10, 0, 8), 4, 1);
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  $p2 := $Mem[x11];
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  cmp12 := ($p2 == $ptr($NULL, 2));
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  conv13 := $b2p(cmp12);
  assume {:sourceloc "array_free1_fail.c", 25, 0} true;
  assert (conv13 != $ptr($NULL, 0));
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  arrayidx14 := $pa($pa(a, 0, 80), $off(i.1), 8);
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  f15 := $pa($pa(arrayidx14, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  $p3 := $Mem[f15];
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  cmp16 := ($p3 != $ptr($NULL, 0));
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  goto $bb13, $bb14;
$bb8:
  assume {:sourceloc "array_free1_fail.c", 31, 0} true;
  return;
$bb9:
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  assume cmp5;
  goto $bb7;
$bb10:
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  assume !(cmp5);
  goto $bb8;
$bb11:
  assume {:sourceloc "array_free1_fail.c", 27, 0} true;
  arrayidx18 := $pa($pa(a, 0, 80), $off(i.1), 8);
  assume {:sourceloc "array_free1_fail.c", 27, 0} true;
  f19 := $pa($pa(arrayidx18, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 27, 0} true;
  $p4 := $Mem[f19];
  assume {:sourceloc "array_free1_fail.c", 27, 0} true;
  // WARNING: ignoring bitcast instruction : %"$p5" = bitcast i32* %"$p4" to i8*, !dbg !39
  $p5 := $p4;
  assume {:sourceloc "array_free1_fail.c", 27, 0} true;
  call $free($p5);
  assume {:sourceloc "array_free1_fail.c", 28, 0} true;
  arrayidx20 := $pa($pa(a, 0, 80), $off(i.1), 8);
  assume {:sourceloc "array_free1_fail.c", 28, 0} true;
  f21 := $pa($pa(arrayidx20, 0, 8), 0, 1);
  assume {:sourceloc "array_free1_fail.c", 28, 0} true;
  $Mem[f21] := $ptr($NULL, 0);
  assume {:sourceloc "array_free1_fail.c", 29, 0} true;
  goto $bb12;
$bb12:
  assume {:sourceloc "array_free1_fail.c", 30, 0} true;
  goto $bb15;
$bb13:
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  assume cmp16;
  goto $bb11;
$bb14:
  assume {:sourceloc "array_free1_fail.c", 26, 0} true;
  assume !(cmp16);
  goto $bb12;
$bb15:
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  inc23 := $ptr($NULL, $add($off(i.1), $off($ptr($NULL, 1))));
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  // WARNING: ignoring llvm.debug call.
  assume true;
  assume {:sourceloc "array_free1_fail.c", 23, 0} true;
  i.1 := inc23;
  goto $bb6;
$bb16:
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  inc := $ptr($NULL, $add($off(i.0), $off($ptr($NULL, 1))));
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  // WARNING: ignoring llvm.debug call.
  assume true;
  assume {:sourceloc "array_free1_fail.c", 17, 0} true;
  i.0 := inc;
  goto $bb1;
}

procedure {:entrypoint} main() 
  returns ($r: int) 
  modifies $Mem, $Alloc, $CurrAddr;
{
  
$bb0:
  assume {:sourceloc "array_free1_fail.c", 34, 0} true;
  call free_array();
  assume {:sourceloc "array_free1_fail.c", 35, 0} true;
  $r := $ptr($NULL, 0);
  return;
}
// END SMACK-GENERATED CODE
