procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{

  anon0:
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
    return;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{

  anon0:
    $result := $DynamicType(this);
    return;
}



axiom Union2Int(null) == 0;

axiom Union2Bool(null) == false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
    return;
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
    return;
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
    return;
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
    return;
}



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in == b$in;
    return;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in != b$in;
    return;
}



var $ArrayContents: [Ref][int]Union;

function $ArrayLength(Ref) : int;

type Field;

type Union = Ref;

type Ref;

const unique null: Ref;

type Type = Ref;

function $TypeConstructor(Ref) : int;

type Real;

const unique $DefaultReal: Real;

procedure {:inline 1} $BoxFromBool(b: bool) returns (r: Ref);



implementation {:inline 1} $BoxFromBool(b: bool) returns (r: Ref)
{

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $BoolValueType;
    assume Union2Bool(r) == b;
    return;
}



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



implementation {:inline 1} $BoxFromInt(i: int) returns (r: Ref)
{

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $IntValueType;
    assume Union2Int(r) == i;
    return;
}



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



implementation {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref)
{

  anon0:
    call rf := Alloc();
    assume $TypeConstructor($DynamicType(rf)) == $RealValueType;
    assume Union2Real(rf) == r;
    return;
}



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



implementation {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref)
{

  anon0:
    r := u;
    return;
}



const unique $BoolValueType: int;

const unique $IntValueType: int;

const unique $RealValueType: int;

function {:inline true} $Unbox2Bool(r: Ref) : bool
{
  Union2Bool(r)
}

function {:inline true} $Unbox2Int(r: Ref) : int
{
  Union2Int(r)
}

function {:inline true} $Unbox2Real(r: Ref) : Real
{
  Union2Real(r)
}

function {:inline true} $Unbox2Union(r: Ref) : Union
{
  r
}

function Union2Bool(u: Union) : bool;

function Union2Int(u: Union) : int;

function Union2Real(u: Union) : Real;

function Bool2Union(boolValue: bool) : Union;

function Int2Union(intValue: int) : Union;

function Real2Union(realValue: Real) : Union;

function Int2Real(int) : Real;

function Real2Int(Real) : int;

function RealPlus(Real, Real) : Real;

function RealMinus(Real, Real) : Real;

function RealTimes(Real, Real) : Real;

function RealDivide(Real, Real) : Real;

function RealModulus(Real, Real) : Real;

function RealLessThan(Real, Real) : bool;

function RealLessThanOrEqual(Real, Real) : bool;

function RealGreaterThan(Real, Real) : bool;

function RealGreaterThanOrEqual(Real, Real) : bool;

function BitwiseAnd(int, int) : int;

function BitwiseOr(int, int) : int;

function BitwiseExclusiveOr(int, int) : int;

function BitwiseNegation(int) : int;

function RightShift(int, int) : int;

function LeftShift(int, int) : int;

function $DynamicType(Ref) : Type;

function $As(a: Ref, b: Type) : Ref;

axiom (forall a: Ref, b: Type :: { $As(a, b): Ref } $As(a, b): Ref == (if $Subtype($DynamicType(a), b) then a else null));

function $Subtype(Type, Type) : bool;

function $DisjointSubtree(Type, Type) : bool;

var $Alloc: [Ref]bool;

function {:builtin "MapImp"} $allocImp([Ref]bool, [Ref]bool) : [Ref]bool;

function {:builtin "MapConst"} $allocConstBool(bool) : [Ref]bool;

function $RefToDelegateMethod(int, Ref) : bool;

function $RefToDelegateReceiver(int, Ref) : Ref;

function $RefToDelegateTypeParameters(int, Ref) : Type;

var {:thread_local} $Exception: Ref;

function T$RandomGraph.RandomGraph() : Ref;

const unique T$RandomGraph.RandomGraph: int;

procedure {:entrypoint} RandomGraph.RandomGraph.Main$System.Stringarray(args$in: Ref) returns ($result: int);



procedure {:extern} System.Int32.Parse$System.String(s$in: Ref) returns ($result: int);



var F$RandomGraph.Consts.MAX_NODES: int;

var F$RandomGraph.Consts.MAX_CNXS: int;

var F$RandomGraph.Consts.REPLACEMENTS: int;

procedure {:extern} System.Random.#ctor$System.Int32($this: Ref, Seed$in: int);



function {:extern} T$System.Random() : Ref;

const {:extern} unique T$System.Random: int;

axiom $TypeConstructor(T$System.Random()) == T$System.Random;

procedure {:extern} System.Random.Next$System.Int32($this: Ref, maxValue$in: int) returns ($result: int);



procedure {:extern} System.Exception.#ctor($this: Ref);



function {:extern} T$System.Exception() : Ref;

const {:extern} unique T$System.Exception: int;

axiom $TypeConstructor(T$System.Exception()) == T$System.Exception;

procedure RandomGraph.Node.#ctor($this: Ref);



function T$RandomGraph.Node() : Ref;

const unique T$RandomGraph.Node: int;

procedure RandomGraph.RandomGraph.interconnects$System.Random$RandomGraph.Nodearray(r$in: Ref, nodes$in: Ref);



procedure RandomGraph.RandomGraph.replace$System.Random$RandomGraph.Nodearray(r$in: Ref, nodes$in: Ref);



implementation RandomGraph.RandomGraph.Main$System.Stringarray(args$in: Ref) returns ($result: int)
{
  var args: Ref;
  var $tmp0: int;
  var $tmp1: int;
  var $tmp2: int;
  var $tmp3: Ref;
  var r_Ref: Ref;
  var $tmp4: Ref;
  var nodes_Ref: Ref;
  var $tmp5: int;
  var $tmp6: Ref;
  var i_int: int;
  var $tmp7: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    call T$RandomGraph.RandomGraph.#cctor();
    call RandomGraph.Consts.#cctor();
    call T$RandomGraph.Node.#cctor();
    call T$System.Heap.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    args := args$in;
    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 92} true;
    goto anon21_Then, anon21_Else;

  anon21_Then:
    assume {:partition} !($ArrayLength(args) < 1);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 94} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 94} true;
    assume args != null;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 94} true;
    call $tmp0 := System.Int32.Parse$System.String($ArrayContents[args][0]);
    F$RandomGraph.Consts.MAX_NODES := $tmp0;
    goto anon3;

  anon21_Else:
    assume {:partition} $ArrayLength(args) < 1;
    goto anon3;

  anon3:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 96} true;
    goto anon22_Then, anon22_Else;

  anon22_Then:
    assume {:partition} !($ArrayLength(args) < 2);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 98} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 98} true;
    assume args != null;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 98} true;
    call $tmp1 := System.Int32.Parse$System.String($ArrayContents[args][1]);
    F$RandomGraph.Consts.MAX_CNXS := $tmp1;
    goto anon6;

  anon22_Else:
    assume {:partition} $ArrayLength(args) < 2;
    goto anon6;

  anon6:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 100} true;
    goto anon23_Then, anon23_Else;

  anon23_Then:
    assume {:partition} !($ArrayLength(args) < 3);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 102} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 102} true;
    assume args != null;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 102} true;
    call $tmp2 := System.Int32.Parse$System.String($ArrayContents[args][2]);
    F$RandomGraph.Consts.REPLACEMENTS := $tmp2;
    goto anon9;

  anon23_Else:
    assume {:partition} $ArrayLength(args) < 3;
    goto anon9;

  anon9:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 104} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 104} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 104} true;
    call System.Random.#ctor$System.Int32($tmp3, 42);
    assume $DynamicType($tmp3) == T$System.Random();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Random;
    r_Ref := $tmp3;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 105} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 105} true;
    call $tmp4 := Alloc();
    assume $ArrayLength($tmp4) == 1 * F$RandomGraph.Consts.MAX_NODES;
    nodes_Ref := $tmp4;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 106} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 106} true;
    call $tmp5 := System.Random.Next$System.Int32(r_Ref, F$RandomGraph.Consts.MAX_CNXS);
    goto anon24_Then, anon24_Else;

  anon24_Then:
    assume {:partition} $ArrayLength(nodes_Ref) < $tmp5;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 107} true;
    call $tmp6 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 107} true;
    call System.Exception.#ctor($tmp6);
    assume $DynamicType($tmp6) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
    $Exception := $tmp6;
    return;

  anon24_Else:
    assume {:partition} $tmp5 <= $ArrayLength(nodes_Ref);
    goto anon12;

  anon12:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 108} true;
    i_int := 0;
    goto IL_009a;

  IL_008b:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 109} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 109} true;
    call $tmp7 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 109} true;
    call RandomGraph.Node.#ctor($tmp7);
    assume $DynamicType($tmp7) == T$RandomGraph.Node();
    assume $TypeConstructor($DynamicType($tmp7)) == T$RandomGraph.Node;
    $ArrayContents := $ArrayContents[nodes_Ref := $ArrayContents[nodes_Ref][i_int := $tmp7]];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 108} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 108} true;
    i_int := i_int + 1;
    goto IL_009a;

  IL_009a:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 108} true;
    goto anon25_Then, anon25_Else;

  anon25_Then:
    assume {:partition} i_int < F$RandomGraph.Consts.MAX_NODES;
    goto IL_008b;

  anon25_Else:
    assume {:partition} F$RandomGraph.Consts.MAX_NODES <= i_int;
    goto anon15;

  anon15:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 112} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 112} true;
    call RandomGraph.RandomGraph.interconnects$System.Random$RandomGraph.Nodearray(r_Ref, nodes_Ref);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 114} true;
    i_int := 0;
    goto IL_00c6;

  IL_00b6:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 116} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 116} true;
    call RandomGraph.RandomGraph.replace$System.Random$RandomGraph.Nodearray(r_Ref, nodes_Ref);
    goto anon26_Then, anon26_Else;

  anon26_Then:
    assume {:partition} $Exception != null;
    return;

  anon26_Else:
    assume {:partition} $Exception == null;
    goto anon17;

  anon17:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 114} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 114} true;
    i_int := i_int + 1;
    goto IL_00c6;

  IL_00c6:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 114} true;
    goto anon27_Then, anon27_Else;

  anon27_Then:
    assume {:partition} i_int < F$RandomGraph.Consts.REPLACEMENTS;
    goto IL_00b6;

  anon27_Else:
    assume {:partition} F$RandomGraph.Consts.REPLACEMENTS <= i_int;
    goto anon20;

  anon20:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 118} true;
    $result := 0;
    return;
}



procedure RandomGraph.RandomGraph.interconnects__inner$System.Random$RandomGraph.Nodearray$System.Int32(r$in: Ref, nodes$in: Ref, i$in: int);



implementation RandomGraph.RandomGraph.interconnects$System.Random$RandomGraph.Nodearray(r$in: Ref, nodes$in: Ref)
{
  var r: Ref;
  var nodes: Ref;
  var i_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    r := r$in;
    nodes := nodes$in;
    assume {:breadcrumb 1} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 122} true;
    i_int := 0;
    goto IL_0014;

  IL_0005:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 124} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 124} true;
    call RandomGraph.RandomGraph.interconnects__inner$System.Random$RandomGraph.Nodearray$System.Int32(r, nodes, i_int);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 122} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 122} true;
    i_int := i_int + 1;
    goto IL_0014;

  IL_0014:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 122} true;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} i_int < F$RandomGraph.Consts.MAX_NODES;
    goto IL_0005;

  anon3_Else:
    assume {:partition} F$RandomGraph.Consts.MAX_NODES <= i_int;
    return;
}



var F$RandomGraph.Node.edges: [Ref]Ref;

procedure RandomGraph.Node.AddEdge$RandomGraph.Node$RandomGraph.Nodearray($this: Ref, to$in: Ref, edges$in: Ref);



implementation RandomGraph.RandomGraph.interconnects__inner$System.Random$RandomGraph.Nodearray$System.Int32(r$in: Ref, nodes$in: Ref, i$in: int)
{
  var r: Ref;
  var nodes: Ref;
  var i: int;
  var node_i_Ref: Ref;
  var node_i_edges_Ref: Ref;
  var $tmp0: Ref;
  var connections_int: int;
  var $tmp1: int;
  var k_int: int;
  var $tmp2: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    r := r$in;
    nodes := nodes$in;
    i := i$in;
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 133} true;
    assume nodes != null;
    node_i_Ref := $ArrayContents[nodes][i];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 134} true;
    $tmp0 := node_i_Ref;
    assume $tmp0 != null;
    node_i_edges_Ref := F$RandomGraph.Node.edges[$tmp0];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 135} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 135} true;
    call $tmp1 := System.Random.Next$System.Int32(r, F$RandomGraph.Consts.MAX_CNXS);
    connections_int := $tmp1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 136} true;
    k_int := 0;
    goto IL_0037;

  IL_001c:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 138} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 138} true;
    call $tmp2 := System.Random.Next$System.Int32(r, F$RandomGraph.Consts.MAX_NODES);
    assume nodes != null;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 138} true;
    call RandomGraph.Node.AddEdge$RandomGraph.Node$RandomGraph.Nodearray(node_i_Ref, $ArrayContents[nodes][$tmp2], node_i_edges_Ref);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 136} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 136} true;
    k_int := k_int + 1;
    goto IL_0037;

  IL_0037:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 136} true;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} k_int < connections_int;
    goto IL_001c;

  anon3_Else:
    assume {:partition} connections_int <= k_int;
    return;
}



procedure RandomGraph.Node.ReplaceWith$RandomGraph.Node($this: Ref, new_n$in: Ref);



implementation RandomGraph.RandomGraph.replace$System.Random$RandomGraph.Nodearray(r$in: Ref, nodes$in: Ref)
{
  var r: Ref;
  var nodes: Ref;
  var i_int: int;
  var $tmp0: int;
  var original_Ref: Ref;
  var new_n_Ref: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    r := r$in;
    nodes := nodes$in;
    assume {:breadcrumb 3} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 145} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 145} true;
    call $tmp0 := System.Random.Next$System.Int32(r, F$RandomGraph.Consts.MAX_NODES);
    i_int := $tmp0;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 147} true;
    assume nodes != null;
    original_Ref := $ArrayContents[nodes][i_int];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 148} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 148} true;
    call RandomGraph.Node.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$RandomGraph.Node();
    assume $TypeConstructor($DynamicType($tmp1)) == T$RandomGraph.Node;
    new_n_Ref := $tmp1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 149} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 149} true;
    call RandomGraph.Node.ReplaceWith$RandomGraph.Node(original_Ref, new_n_Ref);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 150} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 150} true;
    $ArrayContents := $ArrayContents[nodes := $ArrayContents[nodes][i_int := new_n_Ref]];
    return;
}



procedure RandomGraph.RandomGraph.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation RandomGraph.RandomGraph.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 4} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$RandomGraph.RandomGraph.#cctor();



implementation T$RandomGraph.RandomGraph.#cctor()
{

  anon0:
    return;
}



function T$RandomGraph.Consts() : Ref;

const unique T$RandomGraph.Consts: int;

procedure RandomGraph.Consts.#ctor($this: Ref);



implementation RandomGraph.Consts.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 5} true;
    call System.Object.#ctor($this);
    return;
}



procedure RandomGraph.Consts.#cctor();



implementation RandomGraph.Consts.#cctor()
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$RandomGraph.Consts.MAX_NODES := 0;
    F$RandomGraph.Consts.MAX_CNXS := 0;
    F$RandomGraph.Consts.REPLACEMENTS := 0;
    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 19} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 19} true;
    F$RandomGraph.Consts.MAX_NODES := 1000000;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 20} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 20} true;
    F$RandomGraph.Consts.MAX_CNXS := 50;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 21} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 21} true;
    F$RandomGraph.Consts.REPLACEMENTS := 8000000;
    return;
}



var F$RandomGraph.Node.head: [Ref]int;

var F$RandomGraph.Node.deleted: [Ref]int;

implementation RandomGraph.Node.AddEdge$RandomGraph.Node$RandomGraph.Nodearray($this: Ref, to$in: Ref, edges$in: Ref)
{
  var to: Ref;
  var edges: Ref;
  var otherEdges_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    to := to$in;
    edges := edges$in;
    assume {:breadcrumb 7} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 33} true;
    $tmp0 := to;
    assume $tmp0 != null;
    otherEdges_Ref := F$RandomGraph.Node.edges[$tmp0];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 34} true;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} F$RandomGraph.Node.head[$this] >= $ArrayLength(edges);
    goto anon3;

  anon10_Else:
    assume {:partition} $ArrayLength(edges) > F$RandomGraph.Node.head[$this];
    $tmp1 := to;
    assume $tmp1 != null;
    goto anon3;

  anon3:
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} (if F$RandomGraph.Node.head[$this] >= $ArrayLength(edges) then true else !(F$RandomGraph.Node.head[$tmp1] < $ArrayLength(otherEdges_Ref)));
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 35} true;
    return;

  anon11_Else:
    assume {:partition} !(if F$RandomGraph.Node.head[$this] >= $ArrayLength(edges) then true else !(F$RandomGraph.Node.head[$tmp1] < $ArrayLength(otherEdges_Ref)));
    goto anon6;

  anon6:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 37} true;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} to == $this;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 38} true;
    return;

  anon12_Else:
    assume {:partition} to != $this;
    goto anon9;

  anon9:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 39} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 39} true;
    assume $this != null;
    $ArrayContents := $ArrayContents[edges := $ArrayContents[edges][F$RandomGraph.Node.head[$this] := to]];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 40} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 40} true;
    $tmp2 := to;
    assume $tmp2 != null;
    $ArrayContents := $ArrayContents[otherEdges_Ref := $ArrayContents[otherEdges_Ref][F$RandomGraph.Node.head[$tmp2] := $this]];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 41} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 41} true;
    assume $this != null;
    F$RandomGraph.Node.head[$this] := F$RandomGraph.Node.head[$this] + 1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 42} true;
    assume to != null;
    F$RandomGraph.Node.head[to] := F$RandomGraph.Node.head[to] + 1;
    return;
}



procedure RandomGraph.Node.Substitute$RandomGraph.Node$RandomGraph.Node($this: Ref, old_n$in: Ref, new_n$in: Ref);



implementation RandomGraph.Node.Substitute$RandomGraph.Node$RandomGraph.Node($this: Ref, old_n$in: Ref, new_n$in: Ref)
{
  var old_n: Ref;
  var new_n: Ref;
  var local_edges_Ref: Ref;
  var head_local_int: int;
  var i_int: int;
  var c_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    old_n := old_n$in;
    new_n := new_n$in;
    assume {:breadcrumb 8} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 48} true;
    assume $this != null;
    local_edges_Ref := F$RandomGraph.Node.edges[$this];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 49} true;
    assume $this != null;
    head_local_int := F$RandomGraph.Node.head[$this];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 50} true;
    i_int := 0;
    goto IL_005d;

  IL_0015:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 53} true;
    assume local_edges_Ref != null;
    c_Ref := $ArrayContents[local_edges_Ref][i_int];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 55} true;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} c_Ref == old_n;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 57} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 57} true;
    $ArrayContents := $ArrayContents[local_edges_Ref := $ArrayContents[local_edges_Ref][i_int := new_n]];
    goto anon3;

  anon12_Else:
    assume {:partition} c_Ref != old_n;
    goto anon3;

  anon3:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 59} true;
    $tmp0 := c_Ref;
    assume $tmp0 != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} F$RandomGraph.Node.deleted[$tmp0] == 1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 60} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 60} true;
    call System.Exception.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Exception;
    $Exception := $tmp1;
    return;

  anon13_Else:
    assume {:partition} F$RandomGraph.Node.deleted[$tmp0] != 1;
    goto anon6;

  anon6:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 61} true;
    $tmp2 := old_n;
    assume $tmp2 != null;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} F$RandomGraph.Node.deleted[$tmp2] == 1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 62} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 62} true;
    call System.Exception.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Exception;
    $Exception := $tmp3;
    return;

  anon14_Else:
    assume {:partition} F$RandomGraph.Node.deleted[$tmp2] != 1;
    goto anon9;

  anon9:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 50} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 50} true;
    i_int := i_int + 1;
    goto IL_005d;

  IL_005d:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 50} true;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} i_int < head_local_int;
    goto IL_0015;

  anon15_Else:
    assume {:partition} head_local_int <= i_int;
    return;
}



procedure System.Heap.Delete$System.Object(obj$in: Ref);



implementation RandomGraph.Node.ReplaceWith$RandomGraph.Node($this: Ref, new_n$in: Ref)
{
  var new_n: Ref;
  var redundant_edges_Ref: Ref;
  var $tmp0: Ref;
  var original_edges_Ref: Ref;
  var i_int: int;
  var n_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    new_n := new_n$in;
    assume {:breadcrumb 9} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 69} true;
    $tmp0 := new_n;
    assume $tmp0 != null;
    redundant_edges_Ref := F$RandomGraph.Node.edges[$tmp0];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 70} true;
    assume $this != null;
    original_edges_Ref := F$RandomGraph.Node.edges[$this];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 71} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 71} true;
    F$RandomGraph.Node.edges[new_n] := original_edges_Ref;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 72} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 72} true;
    assume $this != null;
    F$RandomGraph.Node.head[new_n] := F$RandomGraph.Node.head[$this];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 74} true;
    i_int := 0;
    goto IL_003d;

  IL_002a:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 77} true;
    assume original_edges_Ref != null;
    n_Ref := $ArrayContents[original_edges_Ref][i_int];
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 78} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 78} true;
    call RandomGraph.Node.Substitute$RandomGraph.Node$RandomGraph.Node(n_Ref, $this, new_n);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} $Exception != null;
    return;

  anon6_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 74} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 74} true;
    i_int := i_int + 1;
    goto IL_003d;

  IL_003d:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 74} true;
    assume $this != null;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} i_int < F$RandomGraph.Node.head[$this];
    goto IL_002a;

  anon7_Else:
    assume {:partition} F$RandomGraph.Node.head[$this] <= i_int;
    goto anon5;

  anon5:
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 80} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 80} true;
    F$RandomGraph.Node.deleted[$this] := 1;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 82} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 82} true;
    call System.Heap.Delete$System.Object(redundant_edges_Ref);
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 83} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 83} true;
    call System.Heap.Delete$System.Object($this);
    return;
}



implementation RandomGraph.Node.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$RandomGraph.Node.edges[$this] := null;
    F$RandomGraph.Node.head[$this] := 0;
    F$RandomGraph.Node.deleted[$this] := 0;
    assume {:breadcrumb 10} true;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 26} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 26} true;
    call $tmp0 := Alloc();
    assume $ArrayLength($tmp0) == 1 * F$RandomGraph.Consts.MAX_CNXS;
    F$RandomGraph.Node.edges[$this] := $tmp0;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 27} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 27} true;
    F$RandomGraph.Node.head[$this] := 0;
    assert {:first} {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 28} true;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 28} true;
    F$RandomGraph.Node.deleted[$this] := 0;
    assert {:sourceFile "C:\Users\akashl\Documents\work\fastgc\RandomGraph\RandomGraph.cs"} {:sourceLine 28} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$RandomGraph.Node.#cctor();



implementation T$RandomGraph.Node.#cctor()
{

  anon0:
    return;
}



function T$System.Heap() : Ref;

const unique T$System.Heap: int;

implementation System.Heap.Delete$System.Object(obj$in: Ref)
{
  var obj: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    obj := obj$in;
    assume {:breadcrumb 11} true;
    return;
}



procedure System.Heap.#ctor($this: Ref);



implementation System.Heap.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 12} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$System.Heap.#cctor();



implementation T$System.Heap.#cctor()
{

  anon0:
    return;
}



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
