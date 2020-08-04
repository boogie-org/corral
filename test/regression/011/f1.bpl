var alloc: int;

function Base(int) : int;

axiom (forall x: int :: { Base(x) } INT_LEQ(Base(x), x));

var Mem_T.INT4: [int]int;
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

const unique x: int;

axiom x != 0;

axiom Base(x) == x;

procedure corral_assert_not_reachable();
  free requires INT_LT(0, alloc);
  modifies alloc;
  free ensures INT_LEQ(old(alloc), alloc);



procedure one();
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);



implementation one()
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
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    goto label_3_true, label_3_false;

  label_3_true:
    assume Mem_T.INT4[x] != 0;
    goto label_4;

  label_3_false:
    assume Mem_T.INT4[x] == 0;
    goto label_1;

  label_4:
    goto label_4_true, label_4_false;

  label_4_true:
    assume INT_EQ(Mem_T.INT4[x], 1);
    goto label_1;

  label_4_false:
    assume !INT_EQ(Mem_T.INT4[x], 1);
    goto label_5;

  label_5:
    goto label_5_true, label_5_false;

  label_5_true:
    assume INT_EQ(Mem_T.INT4[x], 2);
    goto label_1;

  label_5_false:
    assume !INT_EQ(Mem_T.INT4[x], 2);
    goto label_6;

  label_6:
    call corral_assert_not_reachable();
    goto label_1;
}




procedure two();
  free requires INT_LT(0, alloc);
  modifies alloc, Res_KERNEL_SOURCE, Res_PROBED, Mem_T.INT4;
  free ensures INT_LEQ(old(alloc), alloc);



implementation two()
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
    goto label_3;

  label_1:
    assume true;
    assume true;
    assume true;
    return;

  label_2:
    assume false;
    return;

  label_3:
    Mem_T.INT4 := Mem_T.INT4[x := 1];
    goto label_1;
}


