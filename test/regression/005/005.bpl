var alloc: int;

function Base(int) : int;

axiom (forall x: int :: { Base(x) } INT_LEQ(Base(x), x));

var Mem_T.INT4: [int]int;

var Mem_T.PACCOUNT: [int]int;

var Mem_T.PINT4: [int]int;

var Mem_T.PUINT4: [int]int;

var Mem_T.UINT4: [int]int;

var Mem_T.balance_ACCOUNT: [int]int;

var Mem_T.lock_ACCOUNT: [int]int;

function balance_ACCOUNT(int) : int;

function balance_ACCOUNTInv(int) : int;

function _S_balance_ACCOUNT([int]bool) : [int]bool;

function _S_balance_ACCOUNTInv([int]bool) : [int]bool;

axiom (forall x: int, S: [int]bool :: { _S_balance_ACCOUNT(S)[x] } _S_balance_ACCOUNT(S)[x] <==> S[balance_ACCOUNTInv(x)]);

axiom (forall x: int, S: [int]bool :: { _S_balance_ACCOUNTInv(S)[x] } _S_balance_ACCOUNTInv(S)[x] <==> S[balance_ACCOUNT(x)]);

axiom (forall x: int, S: [int]bool :: { S[x], _S_balance_ACCOUNT(S) } S[x] ==> _S_balance_ACCOUNT(S)[balance_ACCOUNT(x)]);

axiom (forall x: int, S: [int]bool :: { S[x], _S_balance_ACCOUNTInv(S) } S[x] ==> _S_balance_ACCOUNTInv(S)[balance_ACCOUNTInv(x)]);

axiom (forall x: int :: { balance_ACCOUNT(x) } balance_ACCOUNT(x) == INT_ADD(x, 0));

axiom (forall x: int :: { balance_ACCOUNTInv(x) } balance_ACCOUNTInv(x) == INT_SUB(x, 0));

axiom (forall x: int :: { balance_ACCOUNT(x) } balance_ACCOUNT(x) == PLUS(x, 1, 0));

function lock_ACCOUNT(int) : int;

function lock_ACCOUNTInv(int) : int;

function _S_lock_ACCOUNT([int]bool) : [int]bool;

function _S_lock_ACCOUNTInv([int]bool) : [int]bool;

axiom (forall x: int, S: [int]bool :: { _S_lock_ACCOUNT(S)[x] } _S_lock_ACCOUNT(S)[x] <==> S[lock_ACCOUNTInv(x)]);

axiom (forall x: int, S: [int]bool :: { _S_lock_ACCOUNTInv(S)[x] } _S_lock_ACCOUNTInv(S)[x] <==> S[lock_ACCOUNT(x)]);

axiom (forall x: int, S: [int]bool :: { S[x], _S_lock_ACCOUNT(S) } S[x] ==> _S_lock_ACCOUNT(S)[lock_ACCOUNT(x)]);

axiom (forall x: int, S: [int]bool :: { S[x], _S_lock_ACCOUNTInv(S) } S[x] ==> _S_lock_ACCOUNTInv(S)[lock_ACCOUNTInv(x)]);

axiom (forall x: int :: { lock_ACCOUNT(x) } lock_ACCOUNT(x) == INT_ADD(x, 4));

axiom (forall x: int :: { lock_ACCOUNTInv(x) } lock_ACCOUNTInv(x) == INT_SUB(x, 4));

axiom (forall x: int :: { lock_ACCOUNT(x) } lock_ACCOUNT(x) == PLUS(x, 1, 4));

function {:inline true} INT_EQ(x: int, y: int) : bool
{
  x == y
}

function {:inline true} INT_NEQ(x: int, y: int) : bool
{
  x != y
}

function {:inline true} INT_ADD(x: int, y: int) : int
{
  x + y
}

function {:inline true} INT_SUB(x: int, y: int) : int
{
  x - y
}

function {:inline true} INT_MULT(x: int, y: int) : int
{
  x * y
}

function {:inline true} INT_DIV(x: int, y: int) : int
{
  x div y
}

function {:inline true} INT_LT(x: int, y: int) : bool
{
  x < y
}

function {:inline true} INT_ULT(x: int, y: int) : bool
{
  x < y
}

function {:inline true} INT_LEQ(x: int, y: int) : bool
{
  x <= y
}

function {:inline true} INT_ULEQ(x: int, y: int) : bool
{
  x <= y
}

function {:inline true} INT_GT(x: int, y: int) : bool
{
  x > y
}

function {:inline true} INT_UGT(x: int, y: int) : bool
{
  x > y
}

function {:inline true} INT_GEQ(x: int, y: int) : bool
{
  x >= y
}

function {:inline true} INT_UGEQ(x: int, y: int) : bool
{
  x >= y
}

function {:inline true} BV32_EQ(x: bv32, y: bv32) : bool
{
  x == y
}

function {:inline true} BV32_NEQ(x: bv32, y: bv32) : bool
{
  x != y
}

function {:bvbuiltin "bvadd"} BV32_ADD(x: bv32, y: bv32) : bv32;

function {:bvbuiltin "bvsub"} BV32_SUB(x: bv32, y: bv32) : bv32;

function {:bvbuiltin "bvmul"} BV32_MULT(x: bv32, y: bv32) : bv32;

function {:bvbuiltin "bvudiv"} BV32_DIV(x: bv32, y: bv32) : bv32;

function {:bvbuiltin "bvult"} BV32_ULT(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvslt"} BV32_LT(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvule"} BV32_ULEQ(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvsle"} BV32_LEQ(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvugt"} BV32_UGT(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvsgt"} BV32_GT(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvuge"} BV32_UGEQ(x: bv32, y: bv32) : bool;

function {:bvbuiltin "bvsge"} BV32_GEQ(x: bv32, y: bv32) : bool;

function MINUS_BOTH_PTR_OR_BOTH_INT(a: int, b: int, size: int) : int;

axiom (forall a: int, b: int, size: int :: { MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size) } INT_LEQ(INT_MULT(size, MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size)), INT_SUB(a, b)) && INT_LT(INT_SUB(a, b), INT_MULT(size, INT_ADD(MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size), 1))));

axiom (forall a: int, b: int, size: int :: { MINUS_BOTH_PTR_OR_BOTH_INT(a, b, size) } MINUS_BOTH_PTR_OR_BOTH_INT(a, b, 1) == INT_SUB(a, b));

function MINUS_LEFT_PTR(a: int, a_size: int, b: int) : int;

axiom (forall a: int, a_size: int, b: int :: { MINUS_LEFT_PTR(a, a_size, b) } MINUS_LEFT_PTR(a, a_size, b) == INT_SUB(a, INT_MULT(a_size, b)));

function PLUS(a: int, a_size: int, b: int) : int;

axiom (forall a: int, a_size: int, b: int :: { PLUS(a, a_size, b) } PLUS(a, a_size, b) == INT_ADD(a, INT_MULT(a_size, b)));

function MULT(a: int, b: int) : int;

axiom (forall a: int, b: int :: { MULT(a, b) } MULT(a, b) == INT_MULT(a, b));

function DIV(a: int, b: int) : int;

axiom (forall a: int, b: int :: { DIV(a, b) } a >= 0 && b > 0 ==> b * DIV(a, b) <= a && a < b * (DIV(a, b) + 1));

axiom (forall a: int, b: int :: { DIV(a, b) } a >= 0 && b < 0 ==> b * DIV(a, b) <= a && a < b * (DIV(a, b) - 1));

axiom (forall a: int, b: int :: { DIV(a, b) } a < 0 && b > 0 ==> b * DIV(a, b) >= a && a > b * (DIV(a, b) - 1));

axiom (forall a: int, b: int :: { DIV(a, b) } a < 0 && b < 0 ==> b * DIV(a, b) >= a && a > b * (DIV(a, b) + 1));

function BINARY_BOTH_INT(a: int, b: int) : int;

function POW2(a: int) : bool;

axiom POW2(1);

axiom POW2(2);

axiom POW2(4);

axiom POW2(8);

axiom POW2(16);

axiom POW2(32);

axiom POW2(64);

axiom POW2(128);

axiom POW2(256);

axiom POW2(512);

axiom POW2(1024);

axiom POW2(2048);

axiom POW2(4096);

axiom POW2(8192);

axiom POW2(16384);

axiom POW2(32768);

axiom POW2(65536);

axiom POW2(131072);

axiom POW2(262144);

axiom POW2(524288);

axiom POW2(1048576);

axiom POW2(2097152);

axiom POW2(4194304);

axiom POW2(8388608);

axiom POW2(16777216);

axiom POW2(33554432);

function BIT_BAND(a: int, b: int) : int;

axiom (forall a: int, b: int :: { BIT_BAND(a, b) } a == b ==> BIT_BAND(a, b) == a);

axiom (forall a: int, b: int :: { BIT_BAND(a, b) } POW2(a) && POW2(b) && a != b ==> BIT_BAND(a, b) == 0);

axiom (forall a: int, b: int :: { BIT_BAND(a, b) } a == 0 || b == 0 ==> BIT_BAND(a, b) == 0);

function BIT_BOR(a: int, b: int) : int;

function BIT_BXOR(a: int, b: int) : int;

function BIT_BNOT(a: int) : int;

function choose(a: bool, b: int, c: int) : int;

axiom (forall a: bool, b: int, c: int :: { choose(a, b, c) } a ==> choose(a, b, c) == b);

axiom (forall a: bool, b: int, c: int :: { choose(a, b, c) } !a ==> choose(a, b, c) == c);

function LIFT(a: bool) : int;

axiom (forall a: bool :: { LIFT(a) } a <==> LIFT(a) != 0);

function PTR_NOT(a: int) : int;

axiom (forall a: int :: { PTR_NOT(a) } a == 0 ==> PTR_NOT(a) != 0);

axiom (forall a: int :: { PTR_NOT(a) } a != 0 ==> PTR_NOT(a) == 0);

function NULL_CHECK(a: int) : int;

axiom (forall a: int :: { NULL_CHECK(a) } a == 0 ==> NULL_CHECK(a) != 0);

axiom (forall a: int :: { NULL_CHECK(a) } a != 0 ==> NULL_CHECK(a) == 0);

procedure havoc_assert(i: int);
  free requires i != 0;



procedure havoc_assume(i: int);
  free ensures i != 0;



procedure __HAVOC_free(a: int);



function NewAlloc(x: int, y: int) : int;

procedure __HAVOC_malloc(obj_size: int) returns (new: int);
  free requires INT_GEQ(obj_size, 0);
  modifies alloc;
  free ensures new == old(alloc);
  free ensures INT_GT(alloc, INT_ADD(new, obj_size));
  free ensures Base(new) == new;



procedure nondet_choice() returns (x: int);



procedure _strdup(str: int) returns (new: int);



procedure _xstrcasecmp(a0: int, a1: int) returns (ret: int);



procedure _xstrcmp(a0: int, a1: int) returns (ret: int);



var Res_KERNEL_SOURCE: [int]int;

var Res_LOCK: [int]int;

var Res_PROBED: [int]int;

function Equal([int]bool, [int]bool) : bool;

function Subset([int]bool, [int]bool) : bool;

function Disjoint([int]bool, [int]bool) : bool;

function Empty() : [int]bool;

function SetTrue() : [int]bool;

function Singleton(int) : [int]bool;

function Union([int]bool, [int]bool) : [int]bool;

function Intersection([int]bool, [int]bool) : [int]bool;

function Difference([int]bool, [int]bool) : [int]bool;

function Dereference([int]bool, [int]int) : [int]bool;

function Inverse(f: [int]int, x: int) : [int]bool;

function AtLeast(int, int) : [int]bool;

function Rep(int, int) : int;

axiom (forall n: int, x: int, y: int :: { AtLeast(n, x)[y] } AtLeast(n, x)[y] ==> INT_LEQ(x, y) && Rep(n, x) == Rep(n, y));

axiom (forall n: int, x: int, y: int :: { AtLeast(n, x), Rep(n, x), Rep(n, y) } INT_LEQ(x, y) && Rep(n, x) == Rep(n, y) ==> AtLeast(n, x)[y]);

axiom (forall n: int, x: int :: { AtLeast(n, x) } AtLeast(n, x)[x]);

axiom (forall n: int, x: int, z: int :: { PLUS(x, n, z) } Rep(n, x) == Rep(n, PLUS(x, n, z)));

axiom (forall n: int, x: int :: { Rep(n, x) } (exists k: int :: INT_SUB(Rep(n, x), x) == INT_MULT(n, k)));

function Array(int, int, int) : [int]bool;

axiom (forall x: int, n: int, z: int :: { Array(x, n, z) } INT_LEQ(z, 0) ==> Equal(Array(x, n, z), Empty()));

axiom (forall x: int, n: int, z: int :: { Array(x, n, z) } INT_GT(z, 0) ==> Equal(Array(x, n, z), Difference(AtLeast(n, x), AtLeast(n, PLUS(x, n, z)))));

axiom (forall x: int :: !Empty()[x]);

axiom (forall x: int :: SetTrue()[x]);

axiom (forall x: int, y: int :: { Singleton(y)[x] } Singleton(y)[x] <==> x == y);

axiom (forall y: int :: { Singleton(y) } Singleton(y)[y]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Union(S, T)[x] } { Union(S, T), S[x] } { Union(S, T), T[x] } Union(S, T)[x] <==> S[x] || T[x]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Intersection(S, T)[x] } { Intersection(S, T), S[x] } { Intersection(S, T), T[x] } Intersection(S, T)[x] <==> S[x] && T[x]);

axiom (forall x: int, S: [int]bool, T: [int]bool :: { Difference(S, T)[x] } { Difference(S, T), S[x] } { Difference(S, T), T[x] } Difference(S, T)[x] <==> S[x] && !T[x]);

axiom (forall S: [int]bool, T: [int]bool :: { Equal(S, T) } Equal(S, T) <==> Subset(S, T) && Subset(T, S));

axiom (forall x: int, S: [int]bool, T: [int]bool :: { S[x], Subset(S, T) } { T[x], Subset(S, T) } S[x] && Subset(S, T) ==> T[x]);

axiom (forall S: [int]bool, T: [int]bool :: { Subset(S, T) } Subset(S, T) || (exists x: int :: S[x] && !T[x]));

axiom (forall x: int, S: [int]bool, T: [int]bool :: { S[x], Disjoint(S, T) } { T[x], Disjoint(S, T) } !(S[x] && Disjoint(S, T) && T[x]));

axiom (forall S: [int]bool, T: [int]bool :: { Disjoint(S, T) } Disjoint(S, T) || (exists x: int :: S[x] && T[x]));

axiom (forall f: [int]int, x: int :: { Inverse(f, f[x]) } Inverse(f, f[x])[x]);

axiom (forall f: [int]int, x: int, y: int :: { Inverse(f, y), f[x] } Inverse(f, y)[x] ==> f[x] == y);

axiom (forall f: [int]int, x: int, y: int :: { Inverse(f[x := y], y) } Equal(Inverse(f[x := y], y), Union(Inverse(f, y), Singleton(x))));

axiom (forall f: [int]int, x: int, y: int, z: int :: { Inverse(f[x := y], z) } y == z || Equal(Inverse(f[x := y], z), Difference(Inverse(f, z), Singleton(x))));

axiom (forall x: int, S: [int]bool, M: [int]int :: { Dereference(S, M)[x] } Dereference(S, M)[x] ==> (exists y: int :: x == M[y] && S[y]));

axiom (forall x: int, S: [int]bool, M: [int]int :: { M[x], S[x], Dereference(S, M) } S[x] ==> Dereference(S, M)[M[x]]);

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } !S[x] ==> Equal(Dereference(S, M[x := y]), Dereference(S, M)));

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } S[x] && Equal(Intersection(Inverse(M, M[x]), S), Singleton(x)) ==> Equal(Dereference(S, M[x := y]), Union(Difference(Dereference(S, M), Singleton(M[x])), Singleton(y))));

axiom (forall x: int, y: int, S: [int]bool, M: [int]int :: { Dereference(S, M[x := y]) } S[x] && !Equal(Intersection(Inverse(M, M[x]), S), Singleton(x)) ==> Equal(Dereference(S, M[x := y]), Union(Dereference(S, M), Singleton(y))));

const unique t1done: int;

axiom t1done != 0;

axiom Base(t1done) == t1done;

const unique t2done: int;

axiom t2done != 0;

axiom Base(t2done) == t2done;

procedure corral_assert_not_reachable();
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure corral_atomic_begin();
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure corral_atomic_end();
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure corral_getThreadID() returns (ret: int);
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure storm_nondet() returns (ret: int);
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure AcquireSpinLock($SpinLock$1$14.33$AcquireSpinLock_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation AcquireSpinLock($SpinLock$1$14.33$AcquireSpinLock_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $SpinLock$1$14.33$AcquireSpinLock: int;
  var $lockStatus$3$16.6$AcquireSpinLock: int;
  var $result.corral_getThreadID$15.29$1$: int;
  var $tid$2$15.6$AcquireSpinLock: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($SpinLock$1$14.33$AcquireSpinLock_.1, alloc);
    $SpinLock$1$14.33$AcquireSpinLock := $SpinLock$1$14.33$AcquireSpinLock_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_4;

  label_4:
    call $result.corral_getThreadID$15.29$1$ := corral_getThreadID();
    goto label_7;

  label_7:
    $tid$2$15.6$AcquireSpinLock := $result.corral_getThreadID$15.29$1$;
    goto label_8;

  label_8:
    goto label_9;

  label_9:
    call corral_atomic_begin();
    goto label_12;

  label_12:
    assume INT_EQ(Res_LOCK[$SpinLock$1$14.33$AcquireSpinLock], $lockStatus$3$16.6$AcquireSpinLock);
    goto label_13;

  label_13:
    goto label_13_true, label_13_false;

  label_13_true:
    assume INT_NEQ($tid$2$15.6$AcquireSpinLock, $lockStatus$3$16.6$AcquireSpinLock);
    goto label_17;

  label_13_false:
    assume !INT_NEQ($tid$2$15.6$AcquireSpinLock, $lockStatus$3$16.6$AcquireSpinLock);
    goto label_14;

  label_14:
    call corral_assert_not_reachable();
    goto label_17;

  label_17:
    assume INT_EQ($lockStatus$3$16.6$AcquireSpinLock, 0);
    goto label_18;

  label_18:
    Res_LOCK := Res_LOCK[$SpinLock$1$14.33$AcquireSpinLock := $tid$2$15.6$AcquireSpinLock];
    goto label_19;

  label_19:
    call corral_atomic_end();
    goto label_1;
}



procedure InitializeSpinLock($SpinLock$1$10.36$InitializeSpinLock_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation InitializeSpinLock($SpinLock$1$10.36$InitializeSpinLock_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $SpinLock$1$10.36$InitializeSpinLock: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($SpinLock$1$10.36$InitializeSpinLock_.1, alloc);
    $SpinLock$1$10.36$InitializeSpinLock := $SpinLock$1$10.36$InitializeSpinLock_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    Res_LOCK := Res_LOCK[$SpinLock$1$10.36$InitializeSpinLock := 0];
    goto label_1;
}



procedure ReleaseSpinLock($SpinLock$1$25.34$ReleaseSpinLock_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation ReleaseSpinLock($SpinLock$1$25.34$ReleaseSpinLock_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $SpinLock$1$25.34$ReleaseSpinLock: int;
  var $lockStatus$2$26.6$ReleaseSpinLock: int;
  var $result.corral_getThreadID$27.0$1$: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($SpinLock$1$25.34$ReleaseSpinLock_.1, alloc);
    $SpinLock$1$25.34$ReleaseSpinLock := $SpinLock$1$25.34$ReleaseSpinLock_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_4;

  label_4:
    call corral_atomic_begin();
    goto label_7;

  label_7:
    assume INT_EQ(Res_LOCK[$SpinLock$1$25.34$ReleaseSpinLock], $lockStatus$2$26.6$ReleaseSpinLock);
    goto label_8;

  label_8:
    call $result.corral_getThreadID$27.0$1$ := corral_getThreadID();
    goto label_11;

  label_11:
    goto label_11_true, label_11_false;

  label_11_true:
    assume INT_EQ($lockStatus$2$26.6$ReleaseSpinLock, $result.corral_getThreadID$27.0$1$);
    goto label_15;

  label_11_false:
    assume !INT_EQ($lockStatus$2$26.6$ReleaseSpinLock, $result.corral_getThreadID$27.0$1$);
    goto label_12;

  label_12:
    call corral_assert_not_reachable();
    goto label_15;

  label_15:
    Res_LOCK := Res_LOCK[$SpinLock$1$25.34$ReleaseSpinLock := 0];
    goto label_16;

  label_16:
    call corral_atomic_end();
    goto label_1;
}



procedure create($b$1$19.20$create_.1: int) returns ($result.create$19.9$1$: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation create($b$1$19.20$create_.1: int) returns ($result.create$19.9$1$: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$2$20.11$create: int;
  var $b$1$19.20$create: int;
  var $result.malloc$20.34$2$: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    $b$1$19.20$create := $b$1$19.20$create_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_4;

  label_4:
    call $result.malloc$20.34$2$ := __HAVOC_malloc(8);
    goto label_7;

  label_7:
    $acc$2$20.11$create := $result.malloc$20.34$2$;
    goto label_8;

  label_8:
    Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$2$20.11$create) := $b$1$19.20$create];
    goto label_9;

  label_9:
    assume Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$2$20.11$create)] == Mem_T.UINT4[lock_ACCOUNT($acc$2$20.11$create)];
    call InitializeSpinLock(lock_ACCOUNT($acc$2$20.11$create));
    Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$2$20.11$create) := Mem_T.UINT4[lock_ACCOUNT($acc$2$20.11$create)]];
    goto label_12;

  label_12:
    $result.create$19.9$1$ := $acc$2$20.11$create;
    goto label_1;
}



procedure deposit($acc$1$30.22$deposit_.1: int, $n$2$30.31$deposit_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation deposit($acc$1$30.22$deposit_.1: int, $n$2$30.31$deposit_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$30.22$deposit: int;
  var $n$2$30.31$deposit: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($acc$1$30.22$deposit_.1, alloc);
    $acc$1$30.22$deposit := $acc$1$30.22$deposit_.1;
    $n$2$30.31$deposit := $n$2$30.31$deposit_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    assume Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)];
    call AcquireSpinLock(lock_ACCOUNT($acc$1$30.22$deposit));
    Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit) := Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]];
    goto label_6;

  label_6:
    Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$30.22$deposit) := PLUS(Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$30.22$deposit)], 1, $n$2$30.31$deposit)];
    goto label_7;

  label_7:
    assume Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)];
    call ReleaseSpinLock(lock_ACCOUNT($acc$1$30.22$deposit));
    Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit) := Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]];
    goto label_1;
}



procedure deposit_test($acc$1$55.27$deposit_test_.1: int, $n$2$55.36$deposit_test_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation deposit_test($acc$1$55.27$deposit_test_.1: int, $n$2$55.36$deposit_test_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$55.27$deposit_test: int;
  var $n$2$55.36$deposit_test: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($acc$1$55.27$deposit_test_.1, alloc);
    $acc$1$55.27$deposit_test := $acc$1$55.27$deposit_test_.1;
    $n$2$55.36$deposit_test := $n$2$55.36$deposit_test_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    call deposit($acc$1$55.27$deposit_test, $n$2$55.36$deposit_test);
    goto label_6;

  label_6:
    Mem_T.INT4 := Mem_T.INT4[t2done := 1];
    goto label_1;
}



procedure main() returns ($result.main$104.5$1$: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation main() returns ($result.main$104.5$1$: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    goto label_1;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;
}



procedure read($acc$1$26.18$read_.1: int) returns ($result.read$26.4$1$: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation read($acc$1$26.18$read_.1: int) returns ($result.read$26.4$1$: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$26.18$read: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($acc$1$26.18$read_.1, alloc);
    $acc$1$26.18$read := $acc$1$26.18$read_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    $result.read$26.4$1$ := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$26.18$read)];
    goto label_1;
}



procedure storm_main();
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation storm_main()
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$70.11$storm_main: int;
  var $result.create$87.14$4$: int;
  var $result.read$100.5$5$: int;
  var $result.storm_nondet$83.18$1$: int;
  var $result.storm_nondet$84.18$2$: int;
  var $result.storm_nondet$85.18$3$: int;
  var $withdrawn$2$71.6$storm_main: int;
  var $x$3$72.6$storm_main: int;
  var $y$4$72.9$storm_main: int;
  var $z$5$72.12$storm_main: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    call $withdrawn$2$71.6$storm_main := __HAVOC_malloc(4);
    goto label_3;

  label_1:
    call __HAVOC_free($withdrawn$2$71.6$storm_main);
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_4;

  label_4:
    goto label_5;

  label_5:
    goto label_6;

  label_6:
    goto label_7;

  label_7:
    goto label_8;

  label_8:
    Mem_T.INT4 := Mem_T.INT4[$withdrawn$2$71.6$storm_main := 0];
    goto label_9;

  label_9:
    Mem_T.INT4 := Mem_T.INT4[t1done := 0];
    goto label_10;

  label_10:
    Mem_T.INT4 := Mem_T.INT4[t2done := 0];
    goto label_11;

  label_11:
    call $result.storm_nondet$83.18$1$ := storm_nondet();
    goto label_14;

  label_14:
    $x$3$72.6$storm_main := $result.storm_nondet$83.18$1$;
    goto label_15;

  label_15:
    call $result.storm_nondet$84.18$2$ := storm_nondet();
    goto label_18;

  label_18:
    $y$4$72.9$storm_main := $result.storm_nondet$84.18$2$;
    goto label_19;

  label_19:
    call $result.storm_nondet$85.18$3$ := storm_nondet();
    goto label_22;

  label_22:
    $z$5$72.12$storm_main := $result.storm_nondet$85.18$3$;
    goto label_23;

  label_23:
    call $result.create$87.14$4$ := create($x$3$72.6$storm_main);
    goto label_26;

  label_26:
    $acc$1$70.11$storm_main := $result.create$87.14$4$;
    goto label_27;

  label_27:
    goto label_28;

  label_28:
    async call deposit_test($acc$1$70.11$storm_main, $y$4$72.9$storm_main);
    goto label_31;

  label_31:
    goto label_32;

  label_32:
    async call withdraw_test($acc$1$70.11$storm_main, $z$5$72.12$storm_main, $withdrawn$2$71.6$storm_main);
    goto label_35;

  label_35:
    goto label_35_true, label_35_false;

  label_35_true:
    assume Mem_T.INT4[t1done] != 0;
    goto label_36;

  label_35_false:
    assume Mem_T.INT4[t1done] == 0;
    goto label_1;

  label_36:
    goto label_36_true, label_36_false;

  label_36_true:
    assume Mem_T.INT4[t2done] != 0;
    goto label_37;

  label_36_false:
    assume Mem_T.INT4[t2done] == 0;
    goto label_1;

  label_37:
    goto label_37_true, label_37_false;

  label_37_true:
    assume Mem_T.INT4[$withdrawn$2$71.6$storm_main] != 0;
    goto label_38;

  label_37_false:
    assume Mem_T.INT4[$withdrawn$2$71.6$storm_main] == 0;
    goto label_1;

  label_38:
    call $result.read$100.5$5$ := read($acc$1$70.11$storm_main);
    goto label_41;

  label_41:
    goto label_41_true, label_41_false;

  label_41_true:
    assume INT_EQ($result.read$100.5$5$, MINUS_BOTH_PTR_OR_BOTH_INT(PLUS($x$3$72.6$storm_main, 1, $y$4$72.9$storm_main), $z$5$72.12$storm_main, 1));
    goto label_1;

  label_41_false:
    assume !INT_EQ($result.read$100.5$5$, MINUS_BOTH_PTR_OR_BOTH_INT(PLUS($x$3$72.6$storm_main, 1, $y$4$72.9$storm_main), $z$5$72.12$storm_main, 1));
    goto label_42;

  label_42:
    call corral_assert_not_reachable();
    goto label_1;
}



procedure withdraw($acc$1$36.23$withdraw_.1: int, $n$2$36.32$withdraw_.1: int, $withdrawn$3$36.40$withdraw_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation withdraw($acc$1$36.23$withdraw_.1: int, $n$2$36.32$withdraw_.1: int, $withdrawn$3$36.40$withdraw_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$36.23$withdraw: int;
  var $n$2$36.32$withdraw: int;
  var $r$4$37.6$withdraw: int;
  var $result.read$40.10$1$: int;
  var $withdrawn$3$36.40$withdraw: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($acc$1$36.23$withdraw_.1, alloc);
    assume INT_LT($withdrawn$3$36.40$withdraw_.1, alloc);
    $acc$1$36.23$withdraw := $acc$1$36.23$withdraw_.1;
    $n$2$36.32$withdraw := $n$2$36.32$withdraw_.1;
    $withdrawn$3$36.40$withdraw := $withdrawn$3$36.40$withdraw_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_4;

  label_4:
    assume Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)];
    call AcquireSpinLock(lock_ACCOUNT($acc$1$36.23$withdraw));
    Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw) := Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]];
    goto label_7;

  label_7:
    call $result.read$40.10$1$ := read($acc$1$36.23$withdraw);
    goto label_10;

  label_10:
    $r$4$37.6$withdraw := $result.read$40.10$1$;
    goto label_11;

  label_11:
    goto label_11_true, label_11_false;

  label_11_true:
    assume INT_LEQ($n$2$36.32$withdraw, $r$4$37.6$withdraw);
    goto label_13;

  label_11_false:
    assume !INT_LEQ($n$2$36.32$withdraw, $r$4$37.6$withdraw);
    goto label_12;

  label_12:
    Mem_T.INT4 := Mem_T.INT4[$withdrawn$3$36.40$withdraw := 0];
    goto label_1;

  label_13:
    Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$36.23$withdraw) := MINUS_BOTH_PTR_OR_BOTH_INT($r$4$37.6$withdraw, $n$2$36.32$withdraw, 1)];
    goto label_14;

  label_14:
    assume Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)];
    call ReleaseSpinLock(lock_ACCOUNT($acc$1$36.23$withdraw));
    Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw) := Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]];
    goto label_17;

  label_17:
    Mem_T.INT4 := Mem_T.INT4[$withdrawn$3$36.40$withdraw := 1];
    goto label_1;
}



procedure withdraw_test($acc$1$61.28$withdraw_test_.1: int, $n$2$61.37$withdraw_test_.1: int, $withdrawn$3$61.45$withdraw_test_.1: int);
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_LOCK, Res_PROBED, Mem_T.INT4, Mem_T.PACCOUNT, Mem_T.PINT4, Mem_T.PUINT4, Mem_T.UINT4, Mem_T.balance_ACCOUNT, Mem_T.lock_ACCOUNT;
  free ensures INT_LEQ(old(alloc), alloc);



implementation withdraw_test($acc$1$61.28$withdraw_test_.1: int, $n$2$61.37$withdraw_test_.1: int, $withdrawn$3$61.45$withdraw_test_.1: int)
{
  var havoc_stringTemp: int;
  var condVal: int;
  var $acc$1$61.28$withdraw_test: int;
  var $n$2$61.37$withdraw_test: int;
  var $withdrawn$3$61.45$withdraw_test: int;
  var tempBoogie0: int;
  var tempBoogie1: int;
  var tempBoogie2: int;
  var tempBoogie3: int;
  var tempBoogie4: int;
  var tempBoogie5: int;
  var tempBoogie6: int;
  var tempBoogie7: int;
  var tempBoogie8: int;
  var tempBoogie9: int;
  var tempBoogie10: int;
  var tempBoogie11: int;
  var tempBoogie12: int;
  var tempBoogie13: int;
  var tempBoogie14: int;
  var tempBoogie15: int;
  var tempBoogie16: int;
  var tempBoogie17: int;
  var tempBoogie18: int;
  var tempBoogie19: int;

  start:
    assume INT_LT($acc$1$61.28$withdraw_test_.1, alloc);
    assume INT_LT($withdrawn$3$61.45$withdraw_test_.1, alloc);
    $acc$1$61.28$withdraw_test := $acc$1$61.28$withdraw_test_.1;
    $n$2$61.37$withdraw_test := $n$2$61.37$withdraw_test_.1;
    $withdrawn$3$61.45$withdraw_test := $withdrawn$3$61.45$withdraw_test_.1;
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    call withdraw($acc$1$61.28$withdraw_test, $n$2$61.37$withdraw_test, $withdrawn$3$61.45$withdraw_test);
    goto label_6;

  label_6:
    Mem_T.INT4 := Mem_T.INT4[t2done := 1];
    goto label_1;
}


