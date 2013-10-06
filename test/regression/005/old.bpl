type name;
type byte;
function OneByteToInt(byte) returns (int);
function TwoBytesToInt(byte, byte) returns (int);
function FourBytesToInt(byte, byte, byte, byte) returns (int);
axiom(forall b0:byte, c0:byte :: {OneByteToInt(b0), OneByteToInt(c0)} OneByteToInt(b0) == OneByteToInt(c0) ==> b0 == c0);
axiom(forall b0:byte, b1: byte, c0:byte, c1:byte :: {TwoBytesToInt(b0, b1), TwoBytesToInt(c0, c1)} TwoBytesToInt(b0, b1) == TwoBytesToInt(c0, c1) ==> b0 == c0 && b1 == c1);
axiom(forall b0:byte, b1: byte, b2:byte, b3:byte, c0:byte, c1:byte, c2:byte, c3:byte :: {FourBytesToInt(b0, b1, b2, b3), FourBytesToInt(c0, c1, c2, c3)} FourBytesToInt(b0, b1, b2, b3) == FourBytesToInt(c0, c1, c2, c3) ==> b0 == c0 && b1 == c1 && b2 == c2 && b3 == c3);

// Memory model

// Mutable
var alloc:int;

// Immutable
function Field(int) returns (name);
function Base(int) returns (int);
//axiom(forall x: int :: {Base(x)} Base(x) <= x);
axiom(forall x: int :: {Base(x)} INT_LEQ(Base(x), x));

var Mem_T.INT4 : [int]int;
var Mem_T.PACCOUNT : [int]int;
var Mem_T.PINT4 : [int]int;
var Mem_T.PUINT4 : [int]int;
var Mem_T.UINT4 : [int]int;
var Mem_T.balance_ACCOUNT : [int]int;
var Mem_T.lock_ACCOUNT : [int]int;
function Match(a:int, t:name) returns (bool);
function MatchBase(b:int, a:int, t:name) returns (bool);
function HasType(v:int, t:name) returns (bool);

function T.Ptr(t:name) returns (name);
axiom(forall a:int, t:name :: {Match(a, T.Ptr(t))} Match(a, T.Ptr(t)) <==> Field(a) == T.Ptr(t));
axiom(forall b:int, a:int, t:name :: {MatchBase(b, a, T.Ptr(t))} MatchBase(b, a, T.Ptr(t)) <==> Base(a) == b);
axiom(forall v:int, t:name :: {HasType(v, T.Ptr(t))} HasType(v, T.Ptr(t)) <==> (v == 0 || (INT_GT(v, 0) && Match(v, t) && MatchBase(Base(v), v, t))));

// Field declarations

const unique T.balance_ACCOUNT:name;
const unique T.lock_ACCOUNT:name;

// Type declarations

const unique T.ACCOUNT:name;
const unique T.INT4:name;
const unique T.PACCOUNT:name;
const unique T.PINT4:name;
const unique T.PPACCOUNT:name;
const unique T.PPINT4:name;
const unique T.PPUINT4:name;
const unique T.PUINT4:name;
const unique T.UINT4:name;

// Field offset definitions

function balance_ACCOUNT(int) returns (int);
function balance_ACCOUNTInv(int) returns (int);
function _S_balance_ACCOUNT([int]bool) returns ([int]bool);
function _S_balance_ACCOUNTInv([int]bool) returns ([int]bool);
        
axiom (forall x:int, S:[int]bool :: {_S_balance_ACCOUNT(S)[x]} _S_balance_ACCOUNT(S)[x] <==> S[balance_ACCOUNTInv(x)]);
axiom (forall x:int, S:[int]bool :: {_S_balance_ACCOUNTInv(S)[x]} _S_balance_ACCOUNTInv(S)[x] <==> S[balance_ACCOUNT(x)]);
axiom (forall x:int, S:[int]bool :: {S[x], _S_balance_ACCOUNT(S)} S[x] ==> _S_balance_ACCOUNT(S)[balance_ACCOUNT(x)]);
axiom (forall x:int, S:[int]bool :: {S[x], _S_balance_ACCOUNTInv(S)} S[x] ==> _S_balance_ACCOUNTInv(S)[balance_ACCOUNTInv(x)]);
        
//axiom (forall x:int :: {balance_ACCOUNT(x)} balance_ACCOUNT(x) == x + 0);
axiom (forall x:int :: {balance_ACCOUNT(x)} balance_ACCOUNT(x) == INT_ADD(x, 0));
//axiom (forall x:int :: {balance_ACCOUNTInv(x)} balance_ACCOUNTInv(x) == x - 0);
axiom (forall x:int :: {balance_ACCOUNTInv(x)} balance_ACCOUNTInv(x) == INT_SUB(x,0));
//adding this additional axiom since to show Array(x, 1, n)[f(x)], we need f(x) to be a PLUS
//axiom (forall x:int :: {balance_ACCOUNT(x)} balance_ACCOUNT(x) == PLUS(x, 1, 0));
axiom (forall x:int :: {balance_ACCOUNT(x)} balance_ACCOUNT(x) == PLUS(x, 1, 0));

function lock_ACCOUNT(int) returns (int);
function lock_ACCOUNTInv(int) returns (int);
function _S_lock_ACCOUNT([int]bool) returns ([int]bool);
function _S_lock_ACCOUNTInv([int]bool) returns ([int]bool);
        
axiom (forall x:int, S:[int]bool :: {_S_lock_ACCOUNT(S)[x]} _S_lock_ACCOUNT(S)[x] <==> S[lock_ACCOUNTInv(x)]);
axiom (forall x:int, S:[int]bool :: {_S_lock_ACCOUNTInv(S)[x]} _S_lock_ACCOUNTInv(S)[x] <==> S[lock_ACCOUNT(x)]);
axiom (forall x:int, S:[int]bool :: {S[x], _S_lock_ACCOUNT(S)} S[x] ==> _S_lock_ACCOUNT(S)[lock_ACCOUNT(x)]);
axiom (forall x:int, S:[int]bool :: {S[x], _S_lock_ACCOUNTInv(S)} S[x] ==> _S_lock_ACCOUNTInv(S)[lock_ACCOUNTInv(x)]);
        
//axiom (forall x:int :: {lock_ACCOUNT(x)} lock_ACCOUNT(x) == x + 4);
axiom (forall x:int :: {lock_ACCOUNT(x)} lock_ACCOUNT(x) == INT_ADD(x, 4));
//axiom (forall x:int :: {lock_ACCOUNTInv(x)} lock_ACCOUNTInv(x) == x - 4);
axiom (forall x:int :: {lock_ACCOUNTInv(x)} lock_ACCOUNTInv(x) == INT_SUB(x,4));
//adding this additional axiom since to show Array(x, 1, n)[f(x)], we need f(x) to be a PLUS
//axiom (forall x:int :: {lock_ACCOUNT(x)} lock_ACCOUNT(x) == PLUS(x, 1, 4));
axiom (forall x:int :: {lock_ACCOUNT(x)} lock_ACCOUNT(x) == PLUS(x, 1, 4));


///////////////////////////////////
// will be replaced by:
// "//" when using bv mode
// ""   when using int mode
// main reason is to avoid using bv for constants
// or avoid translating lines that are complex or unsound
//////////////////////////////////

////////////////////////////////////////////
/////// functions for int type /////////////
// Theorem prover does not see INT_ADD etc.
////////////////////////////////////////////
function {:inline true} INT_EQ(x:int, y:int)  returns  (bool)   {x == y}
function {:inline true} INT_NEQ(x:int, y:int)  returns  (bool)   {x != y}

function {:inline true} INT_ADD(x:int, y:int)  returns  (int)   {x + y}
function {:inline true} INT_SUB(x:int, y:int)  returns  (int)   {x - y}
function {:inline true} INT_MULT(x:int, y:int) returns  (int)   {x * y}
function {:inline true} INT_DIV(x:int, y:int)  returns  (int)   {x / y}
function {:inline true} INT_LT(x:int, y:int)   returns  (bool)  {x < y}
function {:inline true} INT_ULT(x:int, y:int)   returns  (bool)  {x < y}
function {:inline true} INT_LEQ(x:int, y:int)  returns  (bool)  {x <= y}
function {:inline true} INT_ULEQ(x:int, y:int)  returns  (bool)  {x <= y}
function {:inline true} INT_GT(x:int, y:int)   returns  (bool)  {x > y}
function {:inline true} INT_UGT(x:int, y:int)   returns  (bool)  {x > y}
function {:inline true} INT_GEQ(x:int, y:int)  returns  (bool)  {x >= y}
function {:inline true} INT_UGEQ(x:int, y:int)  returns  (bool)  {x >= y}


////////////////////////////////////////////
/////// functions for bv32 type /////////////
// Theorem prover does not see INT_ADD etc.
// we are treating unsigned ops now
////////////////////////////////////////////
function {:inline true} BV32_EQ(x:bv32, y:bv32)  returns  (bool)   {x == y}
function {:inline true} BV32_NEQ(x:bv32, y:bv32)  returns  (bool)  {x != y}

function {:bvbuiltin "bvadd"}  BV32_ADD(x:bv32, y:bv32)  returns  (bv32);
function {:bvbuiltin "bvsub"}  BV32_SUB(x:bv32, y:bv32)  returns  (bv32);
function {:bvbuiltin "bvmul"}  BV32_MULT(x:bv32, y:bv32) returns  (bv32);
function {:bvbuiltin "bvudiv"} BV32_DIV(x:bv32, y:bv32)  returns  (bv32);
function {:bvbuiltin "bvult"}  BV32_ULT(x:bv32, y:bv32)   returns  (bool);
function {:bvbuiltin "bvslt"}  BV32_LT(x:bv32, y:bv32)   returns  (bool);
function {:bvbuiltin "bvule"}  BV32_ULEQ(x:bv32, y:bv32)  returns  (bool);
function {:bvbuiltin "bvsle"}  BV32_LEQ(x:bv32, y:bv32)  returns  (bool);
function {:bvbuiltin "bvugt"}  BV32_UGT(x:bv32, y:bv32)   returns  (bool);
function {:bvbuiltin "bvsgt"}  BV32_GT(x:bv32, y:bv32)   returns  (bool);
function {:bvbuiltin "bvuge"}  BV32_UGEQ(x:bv32, y:bv32)  returns  (bool);
function {:bvbuiltin "bvsge"}  BV32_GEQ(x:bv32, y:bv32)  returns  (bool);

//what about bitwise ops {BIT_AND, BIT_OR, BIT_NOT, ..}
//only enabled with bv theory
// function {:bvbuiltin "bvand"} BIT_BAND(a:int, b:int) returns (x:int);
// function {:bvbuiltin "bvor"}  BIT_BOR(a:int, b:int) returns (x:int);
// function {:bvbuiltin "bvxor"} BIT_BXOR(a:int, b:int) returns (x:int);
// function {:bvbuiltin "bvnot"} BIT_BNOT(a:int) returns (x:int);

//////////////////////////////////
// Generic C Arithmetic operations
/////////////////////////////////

//Is this sound for bv32?
function MINUS_BOTH_PTR_OR_BOTH_INT(a:int, b:int, size:int) returns (int); 
 axiom  (forall a:int, b:int, size:int :: {MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size)} 
//size * MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size) <= a - b && a - b < size * (MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size) + 1));
 INT_LEQ( INT_MULT(size, MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size)),  INT_SUB(a, b)) && INT_LT( INT_SUB(a, b),  INT_MULT(size, (INT_ADD(MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size), 1)))));

//we just keep this axiom for size = 1
axiom  (forall a:int, b:int, size:int :: {MINUS_BOTH_PTR_OR_BOTH_INT(a,b,size)}  MINUS_BOTH_PTR_OR_BOTH_INT(a,b,1) == INT_SUB(a,b));


function MINUS_LEFT_PTR(a:int, a_size:int, b:int) returns (int);
//axiom(forall a:int, a_size:int, b:int :: {MINUS_LEFT_PTR(a,a_size,b)} MINUS_LEFT_PTR(a,a_size,b) == a - a_size * b);
axiom(forall a:int, a_size:int, b:int :: {MINUS_LEFT_PTR(a,a_size,b)} MINUS_LEFT_PTR(a,a_size,b) == INT_SUB(a, INT_MULT(a_size, b)));


function PLUS(a:int, a_size:int, b:int) returns (int);
//axiom (forall a:int, a_size:int, b:int :: {PLUS(a,a_size,b)} PLUS(a,a_size,b) == a + a_size * b);
axiom (forall a:int, a_size:int, b:int :: {PLUS(a,a_size,b)} PLUS(a,a_size,b) == INT_ADD(a, INT_MULT(a_size, b)));
 
function MULT(a:int, b:int) returns (int); // a*b
//axiom(forall a:int, b:int :: {MULT(a,b)} MULT(a,b) == a * b);
axiom(forall a:int, b:int :: {MULT(a,b)} MULT(a,b) == INT_MULT(a, b));
 
function DIV(a:int, b:int) returns (int); // a/b	

// Not sure if these axioms hold for BV too, just commet them for BV 	      
 axiom(forall a:int, b:int :: {DIV(a,b)}
 a >= 0 && b > 0 ==> b * DIV(a,b) <= a && a < b * (DIV(a,b) + 1)
 ); 
 
 axiom(forall a:int, b:int :: {DIV(a,b)}
 a >= 0 && b < 0 ==> b * DIV(a,b) <= a && a < b * (DIV(a,b) - 1)
 ); 
 
 axiom(forall a:int, b:int :: {DIV(a,b)}
 a < 0 && b > 0 ==> b * DIV(a,b) >= a && a > b * (DIV(a,b) - 1)
 ); 
 
 axiom(forall a:int, b:int :: {DIV(a,b)}
 a < 0 && b < 0 ==> b * DIV(a,b) >= a && a > b * (DIV(a,b) + 1)
 ); 
 

//uninterpreted binary op
function BINARY_BOTH_INT(a:int, b:int) returns (int);


//////////////////////////////////////////
//// Bitwise ops (uninterpreted, used with int)
//////////////////////////////////////////
function POW2(a:int) returns (bool);
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

 function BIT_BAND(a:int, b:int) returns (x:int);
 axiom(forall a:int, b:int :: {BIT_BAND(a,b)} a == b ==> BIT_BAND(a,b) == a);
 axiom(forall a:int, b:int :: {BIT_BAND(a,b)} POW2(a) && POW2(b) && a != b ==> BIT_BAND(a,b) == 0);
 axiom(forall a:int, b:int :: {BIT_BAND(a,b)} a == 0 || b == 0 ==> BIT_BAND(a,b) == 0);

 function BIT_BOR(a:int, b:int) returns (x:int);
 function BIT_BXOR(a:int, b:int) returns (x:int);
 function BIT_BNOT(a:int) returns (int);


function choose(a:bool, b:int, c:int) returns (x:int);
axiom(forall a:bool, b:int, c:int :: {choose(a,b,c)} a ==> choose(a,b,c) == b);
axiom(forall a:bool, b:int, c:int :: {choose(a,b,c)} !a ==> choose(a,b,c) == c);

function LIFT(a:bool) returns (int);
axiom(forall a:bool :: {LIFT(a)} a <==> LIFT(a) != 0);

function PTR_NOT(a:int) returns (int);
axiom(forall a:int :: {PTR_NOT(a)} a == 0 ==> PTR_NOT(a) != 0);
axiom(forall a:int :: {PTR_NOT(a)} a != 0 ==> PTR_NOT(a) == 0);

function NULL_CHECK(a:int) returns (int);
axiom(forall a:int :: {NULL_CHECK(a)} a == 0 ==> NULL_CHECK(a) != 0);
axiom(forall a:int :: {NULL_CHECK(a)} a != 0 ==> NULL_CHECK(a) == 0);

procedure havoc_assert(i:int);
requires (i != 0);

procedure havoc_assume(i:int);
ensures (i != 0);

procedure __HAVOC_free(a:int);

function NewAlloc(x:int, y:int) returns (z:int);

//Comments below make HAVOC_malloc deterministic

procedure __HAVOC_malloc(obj_size:int) returns (new:int);
//requires obj_size >= 0;
requires INT_GEQ(obj_size, 0);
modifies alloc;
ensures new == old(alloc);
//ensures alloc > new + obj_size;
ensures INT_GT(alloc, INT_ADD(new, obj_size));
ensures Base(new) == new;
//ensures alloc == NewAlloc(old(alloc), obj_size);


procedure nondet_choice() returns (x:int);

//----deterministic (but arbitrary) choice
var detChoiceCnt:int;
function DetChoiceFunc(a:int) returns (x:int);

procedure det_choice() returns (x:int);
//ensures detChoiceCnt == old(detChoiceCnt) + 1;
ensures detChoiceCnt == INT_ADD(old(detChoiceCnt),1);
ensures x == DetChoiceFunc(old(detChoiceCnt));

procedure _strdup(str:int) returns (new:int);

procedure _xstrcasecmp(a0:int, a1:int) returns (ret:int);

procedure _xstrcmp(a0:int, a1:int) returns (ret:int);


/*
//bv functions
function bv8ToInt(bv8)   returns (int);
function bv16ToInt(bv16) returns (int);
function bv32ToInt(bv32) returns (int);
function bv64ToInt(bv64) returns (int);

function intToBv8(int)    returns (bv8);
function intToBv16(int)   returns (bv16);
function intToBv32(int)   returns (bv32);
function intToBv64(int)   returns (bv64);

axiom(forall a:int ::  {intToBv8(a)} bv8ToInt(intToBv8(a)) == a);
axiom(forall a:int ::  {intToBv16(a)} bv16ToInt(intToBv16(a)) == a);
axiom(forall a:int ::  {intToBv32(a)} bv32ToInt(intToBv32(a)) == a);
axiom(forall a:int ::  {intToBv64(a)} bv64ToInt(intToBv64(a)) == a);

axiom(forall b:bv8 ::  {bv8ToInt(b)} intToBv8(bv8ToInt(b)) == b);
axiom(forall b:bv16 ::  {bv16ToInt(b)} intToBv16(bv16ToInt(b)) == b);
axiom(forall b:bv32 ::  {bv32ToInt(b)} intToBv32(bv32ToInt(b)) == b);
axiom(forall b:bv64 ::  {bv64ToInt(b)} intToBv64(bv64ToInt(b)) == b);
*/



var Res_KERNEL_SOURCE:[int]int;
var Res_LOCK:[int]int;
var Res_PROBED:[int]int;

//Pointer constants

//Function pointer constants

function Equal([int]bool, [int]bool) returns (bool);
function Subset([int]bool, [int]bool) returns (bool);
function Disjoint([int]bool, [int]bool) returns (bool);

function Empty() returns ([int]bool);
function SetTrue() returns ([int]bool);
function Singleton(int) returns ([int]bool);
function Reachable([int,int]bool, int) returns ([int]bool);
function Union([int]bool, [int]bool) returns ([int]bool);
function Intersection([int]bool, [int]bool) returns ([int]bool);
function Difference([int]bool, [int]bool) returns ([int]bool);
function Dereference([int]bool, [int]int) returns ([int]bool);
function Inverse(f:[int]int, x:int) returns ([int]bool);

function AtLeast(int, int) returns ([int]bool);
function Rep(int, int) returns (int);
//axiom(forall n:int, x:int, y:int :: {AtLeast(n,x)[y]} AtLeast(n,x)[y] ==> x <= y && Rep(n,x) == Rep(n,y));
axiom(forall n:int, x:int, y:int :: {AtLeast(n,x)[y]} AtLeast(n,x)[y] ==> INT_LEQ(x, y) && Rep(n,x) == Rep(n,y));
//axiom(forall n:int, x:int, y:int :: {AtLeast(n,x),Rep(n,x),Rep(n,y)} x <= y && Rep(n,x) == Rep(n,y) ==> AtLeast(n,x)[y]);
axiom(forall n:int, x:int, y:int :: {AtLeast(n,x),Rep(n,x),Rep(n,y)} INT_LEQ(x, y) && Rep(n,x) == Rep(n,y) ==> AtLeast(n,x)[y]);
axiom(forall n:int, x:int :: {AtLeast(n,x)} AtLeast(n,x)[x]);
axiom(forall n:int, x:int, z:int :: {PLUS(x,n,z)} Rep(n,x) == Rep(n,PLUS(x,n,z)));
//axiom(forall n:int, x:int :: {Rep(n,x)} (exists k:int :: Rep(n,x) - x  == n*k));
axiom(forall n:int, x:int :: {Rep(n,x)} (exists k:int :: INT_SUB(Rep(n,x),x)  == INT_MULT(n,k)));

/*
function AtLeast(int, int) returns ([int]bool);
function ModEqual(int, int, int) returns (bool);
axiom(forall n:int, x:int :: ModEqual(n,x,x));
axiom(forall n:int, x:int, y:int :: {ModEqual(n,x,y)} ModEqual(n,x,y) ==> ModEqual(n,y,x));
axiom(forall n:int, x:int, y:int, z:int :: {ModEqual(n,x,y), ModEqual(n,y,z)} ModEqual(n,x,y) && ModEqual(n,y,z) ==> ModEqual(n,x,z));
axiom(forall n:int, x:int, z:int :: {PLUS(x,n,z)} ModEqual(n,x,PLUS(x,n,z)));
axiom(forall n:int, x:int, y:int :: {ModEqual(n,x,y)} ModEqual(n,x,y) ==> (exists k:int :: x - y == n*k));
axiom(forall x:int, n:int, y:int :: {AtLeast(n,x)[y]}{ModEqual(n,x,y)} AtLeast(n,x)[y] <==> x <= y && ModEqual(n,x,y));
axiom(forall x:int, n:int :: {AtLeast(n,x)} AtLeast(n,x)[x]);
*/

function Array(int, int, int) returns ([int]bool);
axiom(forall x:int, n:int, z:int :: {Array(x,n,z)} INT_LEQ(z,0) ==> Equal(Array(x,n,z), Empty()));
axiom(forall x:int, n:int, z:int :: {Array(x,n,z)} INT_GT(z, 0) ==> Equal(Array(x,n,z), Difference(AtLeast(n,x),AtLeast(n,PLUS(x,n,z)))));


axiom(forall x:int :: !Empty()[x]);

axiom(forall x:int :: SetTrue()[x]);

axiom(forall x:int, y:int :: {Singleton(y)[x]} Singleton(y)[x] <==> x == y);
axiom(forall y:int :: {Singleton(y)} Singleton(y)[y]);

axiom(forall x:int, S:[int]bool, T:[int]bool :: {Union(S,T)[x]}{Union(S,T),S[x]}{Union(S,T),T[x]} Union(S,T)[x] <==> S[x] || T[x]);
axiom(forall x:int, S:[int]bool, T:[int]bool :: {Intersection(S,T)[x]}{Intersection(S,T),S[x]}{Intersection(S,T),T[x]} Intersection(S,T)[x] <==>  S[x] && T[x]);
axiom(forall x:int, S:[int]bool, T:[int]bool :: {Difference(S,T)[x]}{Difference(S,T),S[x]}{Difference(S,T),T[x]} Difference(S,T)[x] <==> S[x] && !T[x]);

axiom(forall S:[int]bool, T:[int]bool :: {Equal(S,T)} Equal(S,T) <==> Subset(S,T) && Subset(T,S));
axiom(forall x:int, S:[int]bool, T:[int]bool :: {S[x],Subset(S,T)}{T[x],Subset(S,T)} S[x] && Subset(S,T) ==> T[x]);
axiom(forall S:[int]bool, T:[int]bool :: {Subset(S,T)} Subset(S,T) || (exists x:int :: S[x] && !T[x]));
axiom(forall x:int, S:[int]bool, T:[int]bool :: {S[x],Disjoint(S,T)}{T[x],Disjoint(S,T)} !(S[x] && Disjoint(S,T) && T[x]));
axiom(forall S:[int]bool, T:[int]bool :: {Disjoint(S,T)} Disjoint(S,T) || (exists x:int :: S[x] && T[x]));

axiom(forall f:[int]int, x:int :: {Inverse(f,f[x])} Inverse(f,f[x])[x]);
axiom(forall f:[int]int, x:int, y:int :: {Inverse(f,y), f[x]} Inverse(f,y)[x] ==> f[x] == y);
axiom(forall f:[int]int, x:int, y:int :: {Inverse(f[x := y],y)} Equal(Inverse(f[x := y],y), Union(Inverse(f,y), Singleton(x))));
axiom(forall f:[int]int, x:int, y:int, z:int :: {Inverse(f[x := y],z)} y == z || Equal(Inverse(f[x := y],z), Difference(Inverse(f,z), Singleton(x))));


axiom(forall x:int, S:[int]bool, M:[int]int :: {Dereference(S,M)[x]} Dereference(S,M)[x] ==> (exists y:int :: x == M[y] && S[y]));
axiom(forall x:int, S:[int]bool, M:[int]int :: {M[x], S[x], Dereference(S,M)} S[x] ==> Dereference(S,M)[M[x]]);
axiom(forall x:int, y:int, S:[int]bool, M:[int]int :: {Dereference(S,M[x := y])} !S[x] ==> Equal(Dereference(S,M[x := y]), Dereference(S,M)));
axiom(forall x:int, y:int, S:[int]bool, M:[int]int :: {Dereference(S,M[x := y])} 
     S[x] &&  Equal(Intersection(Inverse(M,M[x]), S), Singleton(x)) ==> Equal(Dereference(S,M[x := y]), Union(Difference(Dereference(S,M), Singleton(M[x])), Singleton(y))));
axiom(forall x:int, y:int, S:[int]bool, M:[int]int :: {Dereference(S,M[x := y])} 
     S[x] && !Equal(Intersection(Inverse(M,M[x]), S), Singleton(x)) ==> Equal(Dereference(S,M[x := y]), Union(Dereference(S,M), Singleton(y))));

function Unified([name][int]int) returns ([int]int);
axiom(forall M:[name][int]int, x:int :: {Unified(M)[x]} Unified(M)[x] == M[Field(x)][x]);
axiom(forall M:[name][int]int, x:int, y:int :: {Unified(M[Field(x) := M[Field(x)][x := y]])} Unified(M[Field(x) := M[Field(x)][x := y]]) == Unified(M)[x := y]);
const unique t1done : int;
axiom(t1done != 0);
axiom(Base(t1done) == t1done);
const unique t2done : int;
axiom(t2done != 0);
axiom(Base(t2done) == t2done);


procedure __storm_assert_dummy() ;
//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);


procedure __storm_atomic_begin_dummy() ;
//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);


procedure __storm_atomic_end_dummy() ;
//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);


procedure storm_getThreadID() returns (ret:int);
//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);


procedure storm_nondet() returns (ret:int);
//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);


procedure  AcquireSpinLock($SpinLock$1$14.33$AcquireSpinLock_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $SpinLock$1$14.33$AcquireSpinLock : int;
var $lockStatus$3$16.6$AcquireSpinLock : int;
var $result.storm_getThreadID$15.29$1$ : int;
var $tid$2$15.6$AcquireSpinLock : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($SpinLock$1$14.33$AcquireSpinLock_.1, alloc);
$SpinLock$1$14.33$AcquireSpinLock := $SpinLock$1$14.33$AcquireSpinLock_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(23)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(23)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(15)
label_3:
goto label_4;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(15)
label_4:
call $result.storm_getThreadID$15.29$1$ := storm_getThreadID ();
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(15)
label_7:
$tid$2$15.6$AcquireSpinLock := $result.storm_getThreadID$15.29$1$ ;
goto label_8;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(16)
label_8:
goto label_9;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_9:
call __storm_atomic_begin_dummy ();
goto label_12;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_12:
//TAG: __resource("LOCK", SpinLock) == lockStatus
assume (INT_EQ(Res_LOCK[$SpinLock$1$14.33$AcquireSpinLock], $lockStatus$3$16.6$AcquireSpinLock));
goto label_13;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_13:
goto label_13_true , label_13_false ;


label_13_true :
assume (INT_NEQ($tid$2$15.6$AcquireSpinLock, $lockStatus$3$16.6$AcquireSpinLock));
goto label_17;


label_13_false :
assume !(INT_NEQ($tid$2$15.6$AcquireSpinLock, $lockStatus$3$16.6$AcquireSpinLock));
goto label_14;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_14:
call __storm_assert_dummy ();
goto label_17;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_17:
//TAG: lockStatus == 0
assume (INT_EQ($lockStatus$3$16.6$AcquireSpinLock, 0));
goto label_18;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_18:
Res_LOCK := Res_LOCK[$SpinLock$1$14.33$AcquireSpinLock := $tid$2$15.6$AcquireSpinLock];
goto label_19;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(17)
label_19:
call __storm_atomic_end_dummy ();
goto label_1;

}



procedure  InitializeSpinLock($SpinLock$1$10.36$InitializeSpinLock_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $SpinLock$1$10.36$InitializeSpinLock : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($SpinLock$1$10.36$InitializeSpinLock_.1, alloc);
$SpinLock$1$10.36$InitializeSpinLock := $SpinLock$1$10.36$InitializeSpinLock_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(12)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(12)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(11)
label_3:
Res_LOCK := Res_LOCK[$SpinLock$1$10.36$InitializeSpinLock := 0];
goto label_1;

}



procedure  ReleaseSpinLock($SpinLock$1$25.34$ReleaseSpinLock_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $SpinLock$1$25.34$ReleaseSpinLock : int;
var $lockStatus$2$26.6$ReleaseSpinLock : int;
var $result.storm_getThreadID$27.0$1$ : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($SpinLock$1$25.34$ReleaseSpinLock_.1, alloc);
$SpinLock$1$25.34$ReleaseSpinLock := $SpinLock$1$25.34$ReleaseSpinLock_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(32)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(32)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(26)
label_3:
goto label_4;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_4:
call __storm_atomic_begin_dummy ();
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_7:
//TAG: __resource("LOCK", SpinLock) == lockStatus
assume (INT_EQ(Res_LOCK[$SpinLock$1$25.34$ReleaseSpinLock], $lockStatus$2$26.6$ReleaseSpinLock));
goto label_8;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_8:
call $result.storm_getThreadID$27.0$1$ := storm_getThreadID ();
goto label_11;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_11:
goto label_11_true , label_11_false ;


label_11_true :
assume (INT_EQ($lockStatus$2$26.6$ReleaseSpinLock, $result.storm_getThreadID$27.0$1$));
goto label_15;


label_11_false :
assume !(INT_EQ($lockStatus$2$26.6$ReleaseSpinLock, $result.storm_getThreadID$27.0$1$));
goto label_12;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_12:
call __storm_assert_dummy ();
goto label_15;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_15:
Res_LOCK := Res_LOCK[$SpinLock$1$25.34$ReleaseSpinLock := 0];
goto label_16;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\locks.h(27)
label_16:
call __storm_atomic_end_dummy ();
goto label_1;

}



procedure  create($b$1$19.20$create_.1:int) returns ($result.create$19.9$1$:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$2$20.11$create : int;
var $b$1$19.20$create : int;
var $result.malloc$20.34$2$ : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

$b$1$19.20$create := $b$1$19.20$create_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(24)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(24)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(20)
label_3:
goto label_4;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(20)
label_4:
call $result.malloc$20.34$2$ := __HAVOC_malloc (8);
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(20)
label_7:
$acc$2$20.11$create := $result.malloc$20.34$2$ ;
goto label_8;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(21)
label_8:
Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$2$20.11$create) := $b$1$19.20$create];
goto label_9;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(22)
label_9:
assume (Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$2$20.11$create)] == Mem_T.UINT4[lock_ACCOUNT($acc$2$20.11$create)]);
call InitializeSpinLock (lock_ACCOUNT($acc$2$20.11$create));
Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$2$20.11$create) := Mem_T.UINT4[lock_ACCOUNT($acc$2$20.11$create)]];
goto label_12;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(23)
label_12:
$result.create$19.9$1$ := $acc$2$20.11$create ;
goto label_1;

}



procedure  deposit($acc$1$30.22$deposit_.1:int, $n$2$30.31$deposit_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$30.22$deposit : int;
var $n$2$30.31$deposit : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($acc$1$30.22$deposit_.1, alloc);
$acc$1$30.22$deposit := $acc$1$30.22$deposit_.1;
$n$2$30.31$deposit := $n$2$30.31$deposit_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(34)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(34)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(31)
label_3:
assume (Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]);
call AcquireSpinLock (lock_ACCOUNT($acc$1$30.22$deposit));
Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit) := Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]];
goto label_6;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(32)
label_6:
Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$30.22$deposit) := PLUS(Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$30.22$deposit)], 1, $n$2$30.31$deposit)];
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(33)
label_7:
assume (Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]);
call ReleaseSpinLock (lock_ACCOUNT($acc$1$30.22$deposit));
Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$30.22$deposit) := Mem_T.UINT4[lock_ACCOUNT($acc$1$30.22$deposit)]];
goto label_1;

}



procedure  deposit_test($acc$1$55.27$deposit_test_.1:int, $n$2$55.36$deposit_test_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$55.27$deposit_test : int;
var $n$2$55.36$deposit_test : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($acc$1$55.27$deposit_test_.1, alloc);
$acc$1$55.27$deposit_test := $acc$1$55.27$deposit_test_.1;
$n$2$55.36$deposit_test := $n$2$55.36$deposit_test_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(58)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(58)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(56)
label_3:
call deposit ($acc$1$55.27$deposit_test, $n$2$55.36$deposit_test);
goto label_6;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(57)
label_6:
Mem_T.INT4 := Mem_T.INT4[t2done := 1];
goto label_1;

}



procedure  main() returns ($result.main$104.5$1$:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

goto label_1;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(104)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(104)
label_2:
assume false;
return;

}



procedure  read($acc$1$26.18$read_.1:int) returns ($result.read$26.4$1$:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$26.18$read : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($acc$1$26.18$read_.1, alloc);
$acc$1$26.18$read := $acc$1$26.18$read_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(28)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(28)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(27)
label_3:
$result.read$26.4$1$ := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$26.18$read)] ;
goto label_1;

}



procedure  storm_main()

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$70.11$storm_main : int;
var $result.create$87.14$4$ : int;
var $result.read$100.5$5$ : int;
var $result.storm_nondet$83.18$1$ : int;
var $result.storm_nondet$84.18$2$ : int;
var $result.storm_nondet$85.18$3$ : int;
var $withdrawn$2$71.6$storm_main : int;
var $x$3$72.6$storm_main : int;
var $y$4$72.9$storm_main : int;
var $z$5$72.12$storm_main : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

call $withdrawn$2$71.6$storm_main := __HAVOC_malloc(4);
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(102)
label_1:
call __HAVOC_free($withdrawn$2$71.6$storm_main);
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(102)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(70)
label_3:
goto label_4;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(71)
label_4:
goto label_5;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(72)
label_5:
goto label_6;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(72)
label_6:
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(72)
label_7:
goto label_8;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(75)
label_8:
Mem_T.INT4 := Mem_T.INT4[$withdrawn$2$71.6$storm_main := 0];
goto label_9;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(76)
label_9:
Mem_T.INT4 := Mem_T.INT4[t1done := 0];
goto label_10;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(77)
label_10:
Mem_T.INT4 := Mem_T.INT4[t2done := 0];
goto label_11;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(83)
label_11:
call $result.storm_nondet$83.18$1$ := storm_nondet ();
goto label_14;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(83)
label_14:
$x$3$72.6$storm_main := $result.storm_nondet$83.18$1$ ;
goto label_15;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(84)
label_15:
call $result.storm_nondet$84.18$2$ := storm_nondet ();
goto label_18;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(84)
label_18:
$y$4$72.9$storm_main := $result.storm_nondet$84.18$2$ ;
goto label_19;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(85)
label_19:
call $result.storm_nondet$85.18$3$ := storm_nondet ();
goto label_22;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(85)
label_22:
$z$5$72.12$storm_main := $result.storm_nondet$85.18$3$ ;
goto label_23;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(87)
label_23:
call $result.create$87.14$4$ := create ($x$3$72.6$storm_main);
goto label_26;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(87)
label_26:
$acc$1$70.11$storm_main := $result.create$87.14$4$ ;
goto label_27;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(94)
label_27:
goto label_28;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(94)
label_28:
 call {:async}deposit_test ($acc$1$70.11$storm_main, $y$4$72.9$storm_main);
goto label_31;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(95)
label_31:
goto label_32;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(95)
label_32:
 call {:async}withdraw_test ($acc$1$70.11$storm_main, $z$5$72.12$storm_main, $withdrawn$2$71.6$storm_main);
goto label_35;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(99)
label_35:
goto label_35_true , label_35_false ;


label_35_true :
assume (Mem_T.INT4[t1done] != 0);
goto label_36;


label_35_false :
assume (Mem_T.INT4[t1done] == 0);
goto label_1;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(99)
label_36:
goto label_36_true , label_36_false ;


label_36_true :
assume (Mem_T.INT4[t2done] != 0);
goto label_37;


label_36_false :
assume (Mem_T.INT4[t2done] == 0);
goto label_1;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(100)
label_37:
goto label_37_true , label_37_false ;


label_37_true :
assume (Mem_T.INT4[$withdrawn$2$71.6$storm_main] != 0);
goto label_38;


label_37_false :
assume (Mem_T.INT4[$withdrawn$2$71.6$storm_main] == 0);
goto label_1;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(100)
label_38:
call $result.read$100.5$5$ := read ($acc$1$70.11$storm_main);
goto label_41;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(100)
label_41:
goto label_41_true , label_41_false ;


label_41_true :
assume (INT_EQ($result.read$100.5$5$, MINUS_BOTH_PTR_OR_BOTH_INT( PLUS($x$3$72.6$storm_main, 1, $y$4$72.9$storm_main), $z$5$72.12$storm_main, 1)));
goto label_1;


label_41_false :
assume !(INT_EQ($result.read$100.5$5$, MINUS_BOTH_PTR_OR_BOTH_INT( PLUS($x$3$72.6$storm_main, 1, $y$4$72.9$storm_main), $z$5$72.12$storm_main, 1)));
goto label_42;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(100)
label_42:
call __storm_assert_dummy ();
goto label_1;

}



procedure  withdraw($acc$1$36.23$withdraw_.1:int, $n$2$36.32$withdraw_.1:int, $withdrawn$3$36.40$withdraw_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$36.23$withdraw : int;
var $n$2$36.32$withdraw : int;
var $r$4$37.6$withdraw : int;
var $result.read$40.10$1$ : int;
var $withdrawn$3$36.40$withdraw : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($acc$1$36.23$withdraw_.1, alloc);
assume INT_LT($withdrawn$3$36.40$withdraw_.1, alloc);
$acc$1$36.23$withdraw := $acc$1$36.23$withdraw_.1;
$n$2$36.32$withdraw := $n$2$36.32$withdraw_.1;
$withdrawn$3$36.40$withdraw := $withdrawn$3$36.40$withdraw_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(49)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(49)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(37)
label_3:
goto label_4;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(39)
label_4:
assume (Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]);
call AcquireSpinLock (lock_ACCOUNT($acc$1$36.23$withdraw));
Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw) := Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]];
goto label_7;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(40)
label_7:
call $result.read$40.10$1$ := read ($acc$1$36.23$withdraw);
goto label_10;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(40)
label_10:
$r$4$37.6$withdraw := $result.read$40.10$1$ ;
goto label_11;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(41)
label_11:
goto label_11_true , label_11_false ;


label_11_true :
assume (INT_LEQ($n$2$36.32$withdraw, $r$4$37.6$withdraw));
goto label_13;


label_11_false :
assume !(INT_LEQ($n$2$36.32$withdraw, $r$4$37.6$withdraw));
goto label_12;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(48)
label_12:
Mem_T.INT4 := Mem_T.INT4[$withdrawn$3$36.40$withdraw := 0];
goto label_1;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(43)
label_13:
Mem_T.balance_ACCOUNT := Mem_T.balance_ACCOUNT[balance_ACCOUNT($acc$1$36.23$withdraw) := MINUS_BOTH_PTR_OR_BOTH_INT( $r$4$37.6$withdraw, $n$2$36.32$withdraw, 1)];
goto label_14;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(44)
label_14:
assume (Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw)] == Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]);
call ReleaseSpinLock (lock_ACCOUNT($acc$1$36.23$withdraw));
Mem_T.lock_ACCOUNT := Mem_T.lock_ACCOUNT[lock_ACCOUNT($acc$1$36.23$withdraw) := Mem_T.UINT4[lock_ACCOUNT($acc$1$36.23$withdraw)]];
goto label_17;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(45)
label_17:
Mem_T.INT4 := Mem_T.INT4[$withdrawn$3$36.40$withdraw := 1];
goto label_1;

}



procedure  withdraw_test($acc$1$61.28$withdraw_test_.1:int, $n$2$61.37$withdraw_test_.1:int, $withdrawn$3$61.45$withdraw_test_.1:int)

//TAG: alloc is always > 0
free requires INT_LT(0, alloc);
//TAG: modifies alloc
modifies alloc;
//TAG: alloc increases
free ensures INT_LEQ(old(alloc), alloc);
modifies Res_KERNEL_SOURCE;

modifies Res_LOCK;

modifies Res_PROBED;


//TAG: havoc memory locations by default
modifies Mem_T.INT4;
modifies Mem_T.PACCOUNT;
modifies Mem_T.PINT4;
modifies Mem_T.PUINT4;
modifies Mem_T.UINT4;
modifies Mem_T.balance_ACCOUNT;
modifies Mem_T.lock_ACCOUNT;
{
var havoc_stringTemp:int;
var condVal:int;
var $acc$1$61.28$withdraw_test : int;
var $n$2$61.37$withdraw_test : int;
var $withdrawn$3$61.45$withdraw_test : int;
var tempBoogie0:int;
var tempBoogie1:int;
var tempBoogie2:int;
var tempBoogie3:int;
var tempBoogie4:int;
var tempBoogie5:int;
var tempBoogie6:int;
var tempBoogie7:int;
var tempBoogie8:int;
var tempBoogie9:int;
var tempBoogie10:int;
var tempBoogie11:int;
var tempBoogie12:int;
var tempBoogie13:int;
var tempBoogie14:int;
var tempBoogie15:int;
var tempBoogie16:int;
var tempBoogie17:int;
var tempBoogie18:int;
var tempBoogie19:int;


start:

assume INT_LT($acc$1$61.28$withdraw_test_.1, alloc);
assume INT_LT($withdrawn$3$61.45$withdraw_test_.1, alloc);
$acc$1$61.28$withdraw_test := $acc$1$61.28$withdraw_test_.1;
$n$2$61.37$withdraw_test := $n$2$61.37$withdraw_test_.1;
$withdrawn$3$61.45$withdraw_test := $withdrawn$3$61.45$withdraw_test_.1;
goto label_3;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(64)
label_1:
assume (forall m:int:: {Res_KERNEL_SOURCE[m]} INT_LEQ(old(alloc), m) ==> Res_KERNEL_SOURCE[m] == old(Res_KERNEL_SOURCE)[m]);
assume (forall m:int:: {Res_LOCK[m]} INT_LEQ(old(alloc), m) ==> Res_LOCK[m] == old(Res_LOCK)[m]);
assume (forall m:int:: {Res_PROBED[m]} INT_LEQ(old(alloc), m) ==> Res_PROBED[m] == old(Res_PROBED)[m]);
assume (forall m:int :: {Mem_T.INT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.INT4[m] == old(Mem_T.INT4)[m]);
assume (forall m:int :: {Mem_T.PACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PACCOUNT[m] == old(Mem_T.PACCOUNT)[m]);
assume (forall m:int :: {Mem_T.PINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PINT4[m] == old(Mem_T.PINT4)[m]);
assume (forall m:int :: {Mem_T.PUINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.PUINT4[m] == old(Mem_T.PUINT4)[m]);
assume (forall m:int :: {Mem_T.UINT4[m]} INT_LEQ(old(alloc), m) ==> Mem_T.UINT4[m] == old(Mem_T.UINT4)[m]);
assume (forall m:int :: {Mem_T.balance_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.balance_ACCOUNT[m] == old(Mem_T.balance_ACCOUNT)[m]);
assume (forall m:int :: {Mem_T.lock_ACCOUNT[m]} INT_LEQ(old(alloc), m) ==> Mem_T.lock_ACCOUNT[m] == old(Mem_T.lock_ACCOUNT)[m]);
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(64)
label_2:
assume false;
return;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(62)
label_3:
call withdraw ($acc$1$61.28$withdraw_test, $n$2$61.37$withdraw_test, $withdrawn$3$61.45$withdraw_test);
goto label_6;


// c$$users\akashl\documents\work\stormchecker\examples\account_example_branch\account_symbolic2.c(63)
label_6:
Mem_T.INT4 := Mem_T.INT4[t2done := 1];
goto label_1;

}

