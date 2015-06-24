const hashsetEmpty: [Union]bool;

axiom (forall x: Union :: { hashsetEmpty[x] } !hashsetEmpty[x]);

axiom (forall x: Union :: Int2Union(Union2Int(x)) == x);

axiom (forall x: int :: Union2Int(Int2Union(x)) == x);

var hashsets: [Ref][Union]bool;

var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref)
{

  anon0:
    hashsets[$this] := hashsetEmpty;
    hashsetSize[$this] := 0;
    return;
}



implementation {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := !hashsets[$this][item$in];
    hashsets[$this][item$in] := true;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] + 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



implementation {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    hashsets[$this][item$in] := false;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] - 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



implementation {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := hashsetSize[$this];
    return;
}



implementation {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{

  anon0:
    call $result := Alloc();
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
    return;
}



var stacks: [Ref][int]Union;

var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref)
{

  anon0:
    stackPtr[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union)
{

  anon0:
    stacks[$this][stackPtr[$this]] := item$in;
    stackPtr[$this] := stackPtr[$this] + 1;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union)
{

  anon0:
    stackPtr[$this] := stackPtr[$this] - 1;
    $result := stacks[$this][stackPtr[$this]];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := stackPtr[$this];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union)
{

  anon0:
    $result := stacks[$this][stackPtr[$this] - 1];
    return;
}



var listContents: [Ref][int]Union;

var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.#ctor($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union)
{
  var size: int;

  anon0:
    size := listSize[$this];
    listContents[$this][size] := item$in;
    listSize[$this] := size + 1;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon6_LoopHead;

  anon6_LoopHead:
    goto anon6_LoopDone, anon6_LoopBody;

  anon6_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon6_LoopHead;

  anon6_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    goto anon2;

  anon2:
    goto anon7_LoopHead;

  anon7_LoopHead:
    goto anon7_LoopDone, anon7_LoopBody;

  anon7_LoopBody:
    assume {:partition} iter < listSize[$this];
    listContents[$this][iter - 1] := listContents[$this][iter];
    iter := iter + 1;
    goto anon7_LoopHead;

  anon7_LoopDone:
    assume {:partition} listSize[$this] <= iter;
    goto anon4;

  anon4:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $result;
    listSize[$this] := listSize[$this] - 1;
    return;

  anon8_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    return;
}



implementation {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := listSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.Clear($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



implementation {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union)
{

  anon0:
    $result := listContents[$this][index$in];
    return;
}



implementation {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union)
{

  anon0:
    listContents[$this][index$in] := value$in;
    return;
}



var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{

  anon0:
    $result := AllMaps[this][key$in];
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union)
{

  anon0:
    AllMaps[this][key$in] := value$in;
    return;
}



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

function T$cMain() : Ref;

const unique T$cMain: int;

var F$cMain.s: int;

var F$cMain.r: int;

procedure cMain.DoWork($this: Ref);



implementation cMain.DoWork($this: Ref)
{
  var t_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 9} true;
    t_int := F$cMain.s;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 10} true;
    t_int := t_int + 1;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 11} true;
    F$cMain.s := t_int;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 12} true;
    F$cMain.r := t_int + F$cMain.s + F$cMain.r;
    return;
}



procedure {:entrypoint} cMain.Main();



procedure cMain.#ctor($this: Ref);



implementation cMain.Main()
{
  var e1_Ref: Ref;
  var $tmp0: Ref;
  var e2_Ref: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    call T$cMain.#cctor();
    call T$System.Linq.Enumerable.SelectEnumerable`2.#cctor();
    call T$System.Linq.Enumerable.SelectEnumerator`2.#cctor();
    call T$System.Linq.Enumerable.WhereEnumerable`1.#cctor();
    call T$System.Linq.Enumerable.WhereEnumerator`1.#cctor();
    call T$System.Linq.Enumerable.#cctor();
    call T$System.Threading.ManualResetEvent.#cctor();
    call T$System.Threading.WaitHandle.#cctor();
    call T$System.Threading.AutoResetEvent.#cctor();
    call T$System.Threading.EventWaitHandle.#cctor();
    call T$System.Threading.Mutex.#cctor();
    call T$System.Random.#cctor();
    call T$System.Type.#cctor();
    call T$System.Collections.Generic.List`1.#cctor();
    call T$System.Collections.Generic.HashSet`1.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 1} true;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 16} true;
    F$cMain.s := 0;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 17} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 17} true;
    F$cMain.r := 0;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 18} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 18} true;
    call cMain.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$cMain();
    assume $TypeConstructor($DynamicType($tmp0)) == T$cMain;
    e1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 19} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 19} true;
    call cMain.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$cMain();
    assume $TypeConstructor($DynamicType($tmp1)) == T$cMain;
    e2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 20} true;
    call cMain.DoWork(e1_Ref);
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 21} true;
    call cMain.DoWork(e2_Ref);
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 22} true;
    call u_int := unknown_int();
    assert F$cMain.s == u_int;
    assert {:first} {:sourceFile "c:\Users\t-skore\Documents\msr\corral\AddOns\AngelicVerifierNull\test\c#\ex1\ex1.cs"} {:sourceLine 23} true;
    assert F$cMain.r == u_int;
    return;
}

var u_int: int;

procedure {:AngelicUnknown} unknown_int() returns (b:int);

procedure {:extern} System.Object.#ctor($this: Ref);



implementation cMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 2} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$cMain.#cctor();



implementation T$cMain.#cctor()
{

  anon0:
    F$cMain.s := 0;
    F$cMain.r := 0;
    return;
}



function {:extern} T$System.Object() : Ref;

const {:extern} unique T$System.Object: int;

axiom $TypeConstructor(T$System.Object()) == T$System.Object;

axiom (forall $T: Ref :: { $Subtype(T$cMain(), $T) } $Subtype(T$cMain(), $T) <==> T$cMain() == $T || $Subtype(T$System.Object(), $T));

function T$System.Linq.Enumerable() : Ref;

const unique T$System.Linq.Enumerable: int;

procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.Sum$System.Collections.Generic.IEnumerable$System.Int32$(source$in: Ref) returns ($result: int);



procedure System.Collections.Generic.HashSet`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure System.Collections.Generic.List`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator($this: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.IEnumerable`1.GetEnumerator($this: Ref) returns ($result: Ref);



function T$T$System.Linq.Enumerable.SelectEnumerable`2(parent: Ref) : Ref;

function U$T$System.Linq.Enumerable.SelectEnumerable`2(parent: Ref) : Ref;

function T$System.Linq.Enumerable.SelectEnumerable`2(T: Ref, U: Ref) : Ref;

const unique T$System.Linq.Enumerable.SelectEnumerable`2: int;

function T$T$System.Linq.Enumerable.WhereEnumerable`1(parent: Ref) : Ref;

function T$System.Linq.Enumerable.WhereEnumerable`1(T: Ref) : Ref;

const unique T$System.Linq.Enumerable.WhereEnumerable`1: int;

function T$T$System.Collections.Generic.List`1(parent: Ref) : Ref;

function T$System.Collections.Generic.List`1(T: Ref) : Ref;

const unique T$System.Collections.Generic.List`1: int;

function T$T$System.Collections.Generic.HashSet`1(parent: Ref) : Ref;

function T$System.Collections.Generic.HashSet`1(T: Ref) : Ref;

const unique T$System.Collections.Generic.HashSet`1: int;

procedure System.Collections.Generic.HashSet`1.Enumerator.get_Current($this: Ref) returns ($result: Ref);



procedure System.Collections.Generic.List`1.ListEnumerator.get_Current($this: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.WhereEnumerator`1.get_Current($this: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.SelectEnumerator`2.get_Current($this: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.IEnumerator`1.get_Current($this: Ref) returns ($result: Ref);



function T$T$System.Linq.Enumerable.SelectEnumerator`2(parent: Ref) : Ref;

function U$T$System.Linq.Enumerable.SelectEnumerator`2(parent: Ref) : Ref;

function T$System.Linq.Enumerable.SelectEnumerator`2(T: Ref, U: Ref) : Ref;

const unique T$System.Linq.Enumerable.SelectEnumerator`2: int;

function T$T$System.Linq.Enumerable.WhereEnumerator`1(parent: Ref) : Ref;

function T$System.Linq.Enumerable.WhereEnumerator`1(T: Ref) : Ref;

const unique T$System.Linq.Enumerable.WhereEnumerator`1: int;

function T$T$System.Collections.Generic.List`1.ListEnumerator(parent: Ref) : Ref;

function T$System.Collections.Generic.List`1.ListEnumerator(T: Ref) : Ref;

const unique T$System.Collections.Generic.List`1.ListEnumerator: int;

function T$T$System.Collections.Generic.HashSet`1.Enumerator(parent: Ref) : Ref;

function T$System.Collections.Generic.HashSet`1.Enumerator(T: Ref) : Ref;

const unique T$System.Collections.Generic.HashSet`1.Enumerator: int;

procedure System.Collections.Generic.HashSet`1.Enumerator.MoveNext($this: Ref) returns ($result: bool);



procedure System.Collections.Generic.List`1.ListEnumerator.MoveNext($this: Ref) returns ($result: bool);



procedure System.Linq.Enumerable.WhereEnumerator`1.MoveNext($this: Ref) returns ($result: bool);



procedure System.Linq.Enumerable.SelectEnumerator`2.MoveNext($this: Ref) returns ($result: bool);



procedure {:extern} System.Collections.IEnumerator.MoveNext($this: Ref) returns ($result: bool);



implementation System.Linq.Enumerable.Sum$System.Collections.Generic.IEnumerable$System.Int32$(source$in: Ref) returns ($result: int)
{
  var source: Ref;
  var local_0_int: int;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: int;
  var $tmp14: Ref;
  var $tmp15: bool;
  var $tmp16: bool;
  var $tmp17: bool;
  var $tmp18: bool;
  var $tmp19: bool;
  var local_2_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    assume {:breadcrumb 3} true;
    local_0_int := 0;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon32_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon33_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon34_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_1_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    goto IL_0017;

  IL_000c:
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp6 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_1_Ref);
    $tmp5 := $tmp6;
    goto anon18;

  anon35_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp8 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_1_Ref);
    $tmp7 := $tmp8;
    goto anon18;

  anon36_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp10 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_1_Ref);
    $tmp9 := $tmp10;
    goto anon18;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp12 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_1_Ref);
    $tmp11 := $tmp12;
    goto anon18;

  anon38_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp14 := System.Collections.Generic.IEnumerator`1.get_Current(local_1_Ref);
    $tmp13 := Union2Int($tmp14);
    goto anon18;

  anon18:
    local_0_int := local_0_int + (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then Union2Int($tmp5) else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then Union2Int($tmp7) else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then Union2Int($tmp9) else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then Union2Int($tmp11) else $tmp13))));
    goto IL_0017;

  IL_0017:
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp15 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon39_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp16 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp17 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_1_Ref);
    goto anon27;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp18 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_1_Ref);
    goto anon27;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp19 := System.Collections.IEnumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon27:
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp15 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp16 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp17 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp18 else $tmp19))));
    goto IL_000c;

  anon43_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp15 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp16 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp17 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp18 else $tmp19))));
    goto anon30;

  anon30:
    local_2_int := local_0_int;
    goto IL_0025;

  IL_0025:
    $result := local_2_int;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.Sum``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Int32$(source$in: Ref, selector$in: Ref, TSource: Ref) returns ($result: int);



procedure {:extern} System.Func`2.Invoke$`0($this: Ref, arg$in: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.Sum``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Int32$(source$in: Ref, selector$in: Ref, TSource: Ref) returns ($result: int)
{
  var source: Ref;
  var selector: Ref;
  var local_0_int: int;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: int;
  var $tmp16: Ref;
  var $tmp17: bool;
  var $tmp18: bool;
  var $tmp19: bool;
  var $tmp20: bool;
  var $tmp21: bool;
  var local_2_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    selector := selector$in;
    assume {:breadcrumb 4} true;
    local_0_int := 0;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon32_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon33_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon34_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_1_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    goto IL_001d;

  IL_000c:
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp6 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_1_Ref);
    $tmp5 := $tmp6;
    goto anon18;

  anon35_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp8 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_1_Ref);
    $tmp7 := $tmp8;
    goto anon18;

  anon36_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp10 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_1_Ref);
    $tmp9 := $tmp10;
    goto anon18;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp12 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_1_Ref);
    $tmp11 := $tmp12;
    goto anon18;

  anon38_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp14 := System.Collections.Generic.IEnumerator`1.get_Current(local_1_Ref);
    $tmp13 := $tmp14;
    goto anon18;

  anon18:
    call $tmp16 := System.Func`2.Invoke$`0(selector, (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp7 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp9 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp11 else $tmp13)))));
    $tmp15 := Union2Int($tmp16);
    local_0_int := local_0_int + $tmp15;
    goto IL_001d;

  IL_001d:
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp17 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon39_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp18 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp19 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_1_Ref);
    goto anon27;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp20 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_1_Ref);
    goto anon27;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_1_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp21 := System.Collections.IEnumerator.MoveNext(local_1_Ref);
    goto anon27;

  anon27:
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp17 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp18 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp19 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp20 else $tmp21))));
    goto IL_000c;

  anon43_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp17 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp18 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp19 else (if $TypeConstructor($DynamicType(local_1_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp20 else $tmp21))));
    goto anon30;

  anon30:
    local_2_int := local_0_int;
    goto IL_002b;

  IL_002b:
    $result := local_2_int;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.Select``2$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$``1$(source$in: Ref, selector$in: Ref, TSource: Ref, TResult: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.SelectEnumerable`2.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$`1$($this: Ref, origEnum$in: Ref, func$in: Ref);



implementation System.Linq.Enumerable.Select``2$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$``1$(source$in: Ref, selector$in: Ref, TSource: Ref, TResult: Ref) returns ($result: Ref)
{
  var source: Ref;
  var selector: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    selector := selector$in;
    assume {:breadcrumb 5} true;
    call $tmp0 := Alloc();
    call System.Linq.Enumerable.SelectEnumerable`2.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$`1$($tmp0, source, selector);
    assume $DynamicType($tmp0) == T$System.Linq.Enumerable.SelectEnumerable`2(TSource, TResult);
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    assume T$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($tmp0)) == TSource;
    assume U$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($tmp0)) == TResult;
    local_0_Ref := $tmp0;
    goto IL_000b;

  IL_000b:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.Where``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref);



procedure System.Linq.Enumerable.WhereEnumerable`1.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$System.Boolean$($this: Ref, origEnum$in: Ref, func$in: Ref);



implementation System.Linq.Enumerable.Where``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var predicate: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    predicate := predicate$in;
    assume {:breadcrumb 6} true;
    call $tmp0 := Alloc();
    call System.Linq.Enumerable.WhereEnumerable`1.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$System.Boolean$($tmp0, source, predicate);
    assume $DynamicType($tmp0) == T$System.Linq.Enumerable.WhereEnumerable`1(TSource);
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    assume T$T$System.Linq.Enumerable.WhereEnumerable`1($DynamicType($tmp0)) == TSource;
    local_0_Ref := $tmp0;
    goto IL_000b;

  IL_000b:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref);



procedure {:extern} System.InvalidOperationException.#ctor($this: Ref);



function {:extern} T$System.InvalidOperationException() : Ref;

const {:extern} unique T$System.InvalidOperationException: int;

axiom $TypeConstructor(T$System.InvalidOperationException()) == T$System.InvalidOperationException;

implementation System.Linq.Enumerable.First``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: bool;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var local_1_Ref: Ref;
  var $tmp20: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    assume {:breadcrumb 7} true;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon32_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon33_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon34_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp5 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon35_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp6 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon36_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp7 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon18;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp8 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon18;

  anon38_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp9 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon18:
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp11 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp10 := $tmp11;
    goto anon28;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp13 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp12 := $tmp13;
    goto anon28;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp15 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp14 := $tmp15;
    goto anon28;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp17 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp16 := $tmp17;
    goto anon28;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp19 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp18 := $tmp19;
    goto anon28;

  anon28:
    local_1_Ref := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp10 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp12 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp16 else $tmp18))));
    goto anon30;

  anon39_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    call $tmp20 := Alloc();
    call System.InvalidOperationException.#ctor($tmp20);
    assume $DynamicType($tmp20) == T$System.InvalidOperationException();
    assume $TypeConstructor($DynamicType($tmp20)) == T$System.InvalidOperationException;
    $Exception := $tmp20;
    return;

  anon30:
    $result := local_1_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.FirstOrDefault``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.FirstOrDefault``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: bool;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    assume {:breadcrumb 8} true;
    goto anon30_Then, anon30_Else;

  anon30_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon30_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon32_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon33_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp5 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon34_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp6 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon35_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp7 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon18;

  anon36_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp8 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon18;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp9 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon18:
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp11 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp10 := $tmp11;
    goto anon28;

  anon39_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp13 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp12 := $tmp13;
    goto anon28;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp15 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp14 := $tmp15;
    goto anon28;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp17 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp16 := $tmp17;
    goto anon28;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp19 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp18 := $tmp19;
    goto anon28;

  anon28:
    local_1_Ref := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp10 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp12 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp16 else $tmp18))));
    goto IL_002b;

  anon38_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    local_1_Ref := null;
    goto IL_002b;

  IL_002b:
    $result := local_1_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.FirstOrDefault``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.FirstOrDefault``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var predicate: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: bool;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var local_1_Ref: Ref;
  var $tmp27: bool;
  var $tmp28: bool;
  var $tmp29: bool;
  var $tmp30: bool;
  var $tmp31: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    predicate := predicate$in;
    assume {:breadcrumb 9} true;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon44_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    goto IL_0028;

  IL_000a:
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp6 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp5 := $tmp6;
    goto anon18;

  anon45_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp8 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp7 := $tmp8;
    goto anon18;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon47_Then, anon47_Else;

  anon47_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp10 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp9 := $tmp10;
    goto anon18;

  anon47_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon48_Then, anon48_Else;

  anon48_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp12 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp11 := $tmp12;
    goto anon18;

  anon48_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp14 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp13 := $tmp14;
    goto anon18;

  anon18:
    call $tmp16 := System.Func`2.Invoke$`0(predicate, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp9 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp11 else $tmp13)))));
    $tmp15 := Union2Bool($tmp16);
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} $tmp15;
    goto anon50_Then, anon50_Else;

  anon50_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp18 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp17 := $tmp18;
    goto anon28;

  anon50_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp20 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp19 := $tmp20;
    goto anon28;

  anon51_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp22 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp21 := $tmp22;
    goto anon28;

  anon52_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp24 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp23 := $tmp24;
    goto anon28;

  anon53_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp26 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp25 := $tmp26;
    goto anon28;

  anon28:
    local_1_Ref := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp17 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp19 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp21 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp23 else $tmp25))));
    goto IL_003e;

  anon49_Else:
    assume {:partition} !$tmp15;
    goto IL_0028;

  IL_0028:
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp27 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon37;

  anon54_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp28 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon37;

  anon55_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp29 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon37;

  anon56_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp30 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon37;

  anon57_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp31 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon37;

  anon37:
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp28 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp29 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp30 else $tmp31))));
    goto IL_000a;

  anon58_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp28 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp29 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp30 else $tmp31))));
    goto anon40;

  anon40:
    local_1_Ref := null;
    goto IL_003e;

  IL_003e:
    $result := local_1_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.SingleOrDefault``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.SingleOrDefault``1$System.Collections.Generic.IEnumerable$``0$(source$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $tmp5: bool;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: bool;
  var $tmp9: bool;
  var local_2_Ref: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: bool;
  var $tmp21: bool;
  var $tmp22: bool;
  var $tmp23: bool;
  var $tmp24: bool;
  var $tmp25: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    assume {:breadcrumb 10} true;
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon44_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon45_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    local_1_Ref := null;
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp5 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon47_Then, anon47_Else;

  anon47_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp6 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon47_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon48_Then, anon48_Else;

  anon48_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp7 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon18;

  anon48_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp8 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon18;

  anon49_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp9 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon18;

  anon18:
    goto anon50_Then, anon50_Else;

  anon50_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    local_2_Ref := local_1_Ref;
    goto anon41;

  anon50_Else:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp6 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp8 else $tmp9))));
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp11 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp10 := $tmp11;
    goto anon29;

  anon51_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp13 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp12 := $tmp13;
    goto anon29;

  anon52_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp15 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp14 := $tmp15;
    goto anon29;

  anon53_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp17 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp16 := $tmp17;
    goto anon29;

  anon54_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp19 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp18 := $tmp19;
    goto anon29;

  anon29:
    local_1_Ref := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp10 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp12 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp14 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp16 else $tmp18))));
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp20 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon38;

  anon55_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp21 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon38;

  anon56_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp22 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon38;

  anon57_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp23 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon38;

  anon58_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp24 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon38;

  anon38:
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp20 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp21 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp23 else $tmp24))));
    local_2_Ref := local_1_Ref;
    goto anon41;

  anon59_Else:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp20 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp21 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp23 else $tmp24))));
    call $tmp25 := Alloc();
    call System.InvalidOperationException.#ctor($tmp25);
    assume $DynamicType($tmp25) == T$System.InvalidOperationException();
    assume $TypeConstructor($DynamicType($tmp25)) == T$System.InvalidOperationException;
    $Exception := $tmp25;
    return;

  anon41:
    $result := local_2_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.Extension} System.Linq.Enumerable.SingleOrDefault``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.SingleOrDefault``1$System.Collections.Generic.IEnumerable$``0$$System.Func$``0$System.Boolean$(source$in: Ref, predicate$in: Ref, TSource: Ref) returns ($result: Ref)
{
  var source: Ref;
  var predicate: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var local_2_bool: bool;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: bool;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: bool;
  var $tmp29: bool;
  var $tmp30: bool;
  var $tmp31: bool;
  var $tmp32: bool;
  var local_3_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    source := source$in;
    predicate := predicate$in;
    assume {:breadcrumb 11} true;
    goto anon45_Then, anon45_Else;

  anon45_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator(source);
    goto anon9;

  anon45_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.HashSet`1;
    goto anon46_Then, anon46_Else;

  anon46_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1;
    call $tmp1 := System.Collections.Generic.List`1.GetEnumerator(source);
    goto anon9;

  anon46_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Collections.Generic.List`1;
    goto anon47_Then, anon47_Else;

  anon47_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1;
    call $tmp2 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon47_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.WhereEnumerable`1;
    goto anon48_Then, anon48_Else;

  anon48_Then:
    assume {:partition} $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp3 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator(source);
    goto anon9;

  anon48_Else:
    assume {:partition} $TypeConstructor($DynamicType(source)) != T$System.Linq.Enumerable.SelectEnumerable`2;
    call $tmp4 := System.Collections.Generic.IEnumerable`1.GetEnumerator(source);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.HashSet`1 then $tmp0 else (if $TypeConstructor($DynamicType(source)) == T$System.Collections.Generic.List`1 then $tmp1 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp2 else (if $TypeConstructor($DynamicType(source)) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp3 else $tmp4))));
    local_1_Ref := null;
    local_2_bool := false;
    goto IL_0043;

  IL_0014:
    goto anon49_Then, anon49_Else;

  anon49_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp6 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp5 := $tmp6;
    goto anon18;

  anon49_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon50_Then, anon50_Else;

  anon50_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp8 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp7 := $tmp8;
    goto anon18;

  anon50_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp10 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp9 := $tmp10;
    goto anon18;

  anon51_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp12 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp11 := $tmp12;
    goto anon18;

  anon52_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp14 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp13 := $tmp14;
    goto anon18;

  anon18:
    call $tmp16 := System.Func`2.Invoke$`0(predicate, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp5 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp7 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp9 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp11 else $tmp13)))));
    $tmp15 := Union2Bool($tmp16);
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} !$tmp15;
    goto IL_0043;

  anon53_Else:
    assume {:partition} $tmp15;
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} local_2_bool;
    call $tmp17 := Alloc();
    call System.InvalidOperationException.#ctor($tmp17);
    assume $DynamicType($tmp17) == T$System.InvalidOperationException();
    assume $TypeConstructor($DynamicType($tmp17)) == T$System.InvalidOperationException;
    $Exception := $tmp17;
    return;

  anon54_Else:
    assume {:partition} !local_2_bool;
    goto anon23;

  anon23:
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp19 := System.Collections.Generic.HashSet`1.Enumerator.get_Current(local_0_Ref);
    $tmp18 := $tmp19;
    goto anon32;

  anon55_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp21 := System.Collections.Generic.List`1.ListEnumerator.get_Current(local_0_Ref);
    $tmp20 := $tmp21;
    goto anon32;

  anon56_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp23 := System.Linq.Enumerable.WhereEnumerator`1.get_Current(local_0_Ref);
    $tmp22 := $tmp23;
    goto anon32;

  anon57_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp25 := System.Linq.Enumerable.SelectEnumerator`2.get_Current(local_0_Ref);
    $tmp24 := $tmp25;
    goto anon32;

  anon58_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp27 := System.Collections.Generic.IEnumerator`1.get_Current(local_0_Ref);
    $tmp26 := $tmp27;
    goto anon32;

  anon32:
    local_1_Ref := (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp18 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp20 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp24 else $tmp26))));
    local_2_bool := true;
    goto IL_0043;

  IL_0043:
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    call $tmp28 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext(local_0_Ref);
    goto anon41;

  anon59_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.HashSet`1.Enumerator;
    goto anon60_Then, anon60_Else;

  anon60_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator;
    call $tmp29 := System.Collections.Generic.List`1.ListEnumerator.MoveNext(local_0_Ref);
    goto anon41;

  anon60_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Collections.Generic.List`1.ListEnumerator;
    goto anon61_Then, anon61_Else;

  anon61_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    call $tmp30 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext(local_0_Ref);
    goto anon41;

  anon61_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.WhereEnumerator`1;
    goto anon62_Then, anon62_Else;

  anon62_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp31 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext(local_0_Ref);
    goto anon41;

  anon62_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$System.Linq.Enumerable.SelectEnumerator`2;
    call $tmp32 := System.Collections.IEnumerator.MoveNext(local_0_Ref);
    goto anon41;

  anon41:
    goto anon63_Then, anon63_Else;

  anon63_Then:
    assume {:partition} (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp28 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp29 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp30 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp31 else $tmp32))));
    goto IL_0014;

  anon63_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp28 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp29 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp30 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp31 else $tmp32))));
    goto anon44;

  anon44:
    local_3_Ref := local_1_Ref;
    goto IL_0053;

  IL_0053:
    $result := local_3_Ref;
    return;
}



var F$System.Linq.Enumerable.SelectEnumerable`2.origEnum: [Ref]Ref;

var F$System.Linq.Enumerable.SelectEnumerable`2.func: [Ref]Ref;

implementation System.Linq.Enumerable.SelectEnumerable`2.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$`1$($this: Ref, origEnum$in: Ref, func$in: Ref)
{
  var origEnum: Ref;
  var func: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    origEnum := origEnum$in;
    func := func$in;
    F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this] := null;
    F$System.Linq.Enumerable.SelectEnumerable`2.func[$this] := null;
    assume {:breadcrumb 12} true;
    call System.Object.#ctor($this);
    F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this] := origEnum;
    F$System.Linq.Enumerable.SelectEnumerable`2.func[$this] := func;
    return;
}



procedure System.Linq.Enumerable.SelectEnumerator`2.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$`1$($this: Ref, origEnum$in: Ref, func$in: Ref);



implementation System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 13} true;
    call $tmp0 := Alloc();
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Collections.Generic.HashSet`1;
    assume $this != null;
    $tmp1 := F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this];
    call $tmp2 := System.Collections.Generic.HashSet`1.GetEnumerator($tmp1);
    goto anon9;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) != T$System.Collections.Generic.HashSet`1;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Collections.Generic.List`1;
    assume $this != null;
    $tmp3 := F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this];
    call $tmp4 := System.Collections.Generic.List`1.GetEnumerator($tmp3);
    goto anon9;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) != T$System.Collections.Generic.List`1;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Linq.Enumerable.WhereEnumerable`1;
    assume $this != null;
    $tmp5 := F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this];
    call $tmp6 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator($tmp5);
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) != T$System.Linq.Enumerable.WhereEnumerable`1;
    assume $this != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Linq.Enumerable.SelectEnumerable`2;
    assume $this != null;
    $tmp7 := F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this];
    call $tmp8 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator($tmp7);
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) != T$System.Linq.Enumerable.SelectEnumerable`2;
    assume $this != null;
    $tmp9 := F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this];
    call $tmp10 := System.Collections.Generic.IEnumerable`1.GetEnumerator($tmp9);
    goto anon9;

  anon9:
    assume $this != null;
    call System.Linq.Enumerable.SelectEnumerator`2.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$`1$($tmp0, (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Collections.Generic.HashSet`1 then $tmp2 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Collections.Generic.List`1 then $tmp4 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp6 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerable`2.origEnum[$this])) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp8 else $tmp10)))), F$System.Linq.Enumerable.SelectEnumerable`2.func[$this]);
    assume $DynamicType($tmp0) == T$System.Linq.Enumerable.SelectEnumerator`2(T$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($this)), U$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($this)));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume T$T$System.Linq.Enumerable.SelectEnumerator`2($DynamicType($tmp0)) == T$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($this));
    assume U$T$System.Linq.Enumerable.SelectEnumerator`2($DynamicType($tmp0)) == U$T$System.Linq.Enumerable.SelectEnumerable`2($DynamicType($this));
    local_0_Ref := $tmp0;
    goto IL_001a;

  IL_001a:
    $result := local_0_Ref;
    return;
}



procedure System.Linq.Enumerable.SelectEnumerable`2.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.SelectEnumerable`2.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 14} true;
    call $tmp0 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator($this);
    local_0_Ref := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure T$System.Linq.Enumerable.SelectEnumerable`2.#cctor();



implementation T$System.Linq.Enumerable.SelectEnumerable`2.#cctor()
{

  anon0:
    return;
}



function {:extern} T$T$System.Collections.Generic.IEnumerable`1(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.IEnumerable`1(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.IEnumerable`1: int;

function {:extern} T$System.Collections.IEnumerable() : Ref;

const {:extern} unique T$System.Collections.IEnumerable: int;

axiom $TypeConstructor(T$System.Collections.IEnumerable()) == T$System.Collections.IEnumerable;

axiom (forall T: Ref, U: Ref, $T: Ref :: { $Subtype(T$System.Linq.Enumerable.SelectEnumerable`2(T, U), $T) } $Subtype(T$System.Linq.Enumerable.SelectEnumerable`2(T, U), $T) <==> T$System.Linq.Enumerable.SelectEnumerable`2(T, U) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerable`1(U), $T) || $Subtype(T$System.Collections.IEnumerable(), $T));

var F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator: [Ref]Ref;

var F$System.Linq.Enumerable.SelectEnumerator`2.func: [Ref]Ref;

implementation System.Linq.Enumerable.SelectEnumerator`2.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$`1$($this: Ref, origEnum$in: Ref, func$in: Ref)
{
  var origEnum: Ref;
  var func: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    origEnum := origEnum$in;
    func := func$in;
    F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this] := null;
    F$System.Linq.Enumerable.SelectEnumerator`2.func[$this] := null;
    assume {:breadcrumb 15} true;
    call System.Object.#ctor($this);
    F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this] := origEnum;
    F$System.Linq.Enumerable.SelectEnumerator`2.func[$this] := func;
    return;
}



implementation System.Linq.Enumerable.SelectEnumerator`2.MoveNext($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 16} true;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp1 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext($tmp0);
    goto anon9;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp2 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp3 := System.Collections.Generic.List`1.ListEnumerator.MoveNext($tmp2);
    goto anon9;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp4 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp5 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext($tmp4);
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp6 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp7 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext($tmp6);
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp8 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp9 := System.Collections.IEnumerator.MoveNext($tmp8);
    goto anon9;

  anon9:
    local_0_bool := (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp1 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp3 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp5 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp7 else $tmp9))));
    goto IL_000f;

  IL_000f:
    $result := local_0_bool;
    return;
}



implementation System.Linq.Enumerable.SelectEnumerator`2.get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 17} true;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.SelectEnumerator`2.func[$this];
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp1 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp3 := System.Collections.Generic.HashSet`1.Enumerator.get_Current($tmp1);
    $tmp2 := $tmp3;
    goto anon9;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp4 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp6 := System.Collections.Generic.List`1.ListEnumerator.get_Current($tmp4);
    $tmp5 := $tmp6;
    goto anon9;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp7 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp9 := System.Linq.Enumerable.WhereEnumerator`1.get_Current($tmp7);
    $tmp8 := $tmp9;
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp10 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp12 := System.Linq.Enumerable.SelectEnumerator`2.get_Current($tmp10);
    $tmp11 := $tmp12;
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp13 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call $tmp15 := System.Collections.Generic.IEnumerator`1.get_Current($tmp13);
    $tmp14 := $tmp15;
    goto anon9;

  anon9:
    call $tmp17 := System.Func`2.Invoke$`0($tmp0, (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp2 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp5 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp8 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp11 else $tmp14)))));
    $tmp16 := $tmp17;
    local_0_Ref := $tmp16;
    goto IL_001a;

  IL_001a:
    $result := local_0_Ref;
    return;
}



procedure System.Linq.Enumerable.SelectEnumerator`2.Dispose($this: Ref);



implementation System.Linq.Enumerable.SelectEnumerator`2.Dispose($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 18} true;
    return;
}



procedure System.Linq.Enumerable.SelectEnumerator`2.Reset($this: Ref);



procedure System.Collections.Generic.HashSet`1.Enumerator.Reset($this: Ref);



procedure System.Collections.Generic.List`1.ListEnumerator.Reset($this: Ref);



procedure System.Linq.Enumerable.WhereEnumerator`1.Reset($this: Ref);



procedure {:extern} System.Collections.IEnumerator.Reset($this: Ref);



implementation System.Linq.Enumerable.SelectEnumerator`2.Reset($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 19} true;
    assume $this != null;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call System.Collections.Generic.HashSet`1.Enumerator.Reset($tmp0);
    return;

  anon9_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp1 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call System.Collections.Generic.List`1.ListEnumerator.Reset($tmp1);
    return;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp2 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call System.Linq.Enumerable.WhereEnumerator`1.Reset($tmp2);
    return;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp3 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call System.Linq.Enumerable.SelectEnumerator`2.Reset($tmp3);
    return;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp4 := F$System.Linq.Enumerable.SelectEnumerator`2.currentEnumerator[$this];
    call System.Collections.IEnumerator.Reset($tmp4);
    return;
}



procedure System.Linq.Enumerable.SelectEnumerator`2.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.SelectEnumerator`2.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 20} true;
    call $tmp1 := System.Linq.Enumerable.SelectEnumerator`2.get_Current($this);
    $tmp0 := $tmp1;
    call $tmp2 := $BoxFromUnion($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure T$System.Linq.Enumerable.SelectEnumerator`2.#cctor();



implementation T$System.Linq.Enumerable.SelectEnumerator`2.#cctor()
{

  anon0:
    return;
}



function {:extern} T$T$System.Collections.Generic.IEnumerator`1(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.IEnumerator`1(T: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.IEnumerator`1: int;

function {:extern} T$System.IDisposable() : Ref;

const {:extern} unique T$System.IDisposable: int;

axiom $TypeConstructor(T$System.IDisposable()) == T$System.IDisposable;

function {:extern} T$System.Collections.IEnumerator() : Ref;

const {:extern} unique T$System.Collections.IEnumerator: int;

axiom $TypeConstructor(T$System.Collections.IEnumerator()) == T$System.Collections.IEnumerator;

axiom (forall T: Ref, U: Ref, $T: Ref :: { $Subtype(T$System.Linq.Enumerable.SelectEnumerator`2(T, U), $T) } $Subtype(T$System.Linq.Enumerable.SelectEnumerator`2(T, U), $T) <==> T$System.Linq.Enumerable.SelectEnumerator`2(T, U) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerator`1(U), $T) || $Subtype(T$System.IDisposable(), $T) || $Subtype(T$System.Collections.IEnumerator(), $T));

var F$System.Linq.Enumerable.WhereEnumerable`1.origEnum: [Ref]Ref;

var F$System.Linq.Enumerable.WhereEnumerable`1.func: [Ref]Ref;

implementation System.Linq.Enumerable.WhereEnumerable`1.#ctor$System.Collections.Generic.IEnumerable$`0$$System.Func$`0$System.Boolean$($this: Ref, origEnum$in: Ref, func$in: Ref)
{
  var origEnum: Ref;
  var func: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    origEnum := origEnum$in;
    func := func$in;
    F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this] := null;
    F$System.Linq.Enumerable.WhereEnumerable`1.func[$this] := null;
    assume {:breadcrumb 21} true;
    call System.Object.#ctor($this);
    F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this] := origEnum;
    F$System.Linq.Enumerable.WhereEnumerable`1.func[$this] := func;
    return;
}



procedure System.Linq.Enumerable.WhereEnumerator`1.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$System.Boolean$($this: Ref, origEnum$in: Ref, func$in: Ref);



implementation System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 22} true;
    call $tmp0 := Alloc();
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Collections.Generic.HashSet`1;
    assume $this != null;
    $tmp1 := F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this];
    call $tmp2 := System.Collections.Generic.HashSet`1.GetEnumerator($tmp1);
    goto anon9;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) != T$System.Collections.Generic.HashSet`1;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Collections.Generic.List`1;
    assume $this != null;
    $tmp3 := F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this];
    call $tmp4 := System.Collections.Generic.List`1.GetEnumerator($tmp3);
    goto anon9;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) != T$System.Collections.Generic.List`1;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Linq.Enumerable.WhereEnumerable`1;
    assume $this != null;
    $tmp5 := F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this];
    call $tmp6 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator($tmp5);
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) != T$System.Linq.Enumerable.WhereEnumerable`1;
    assume $this != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Linq.Enumerable.SelectEnumerable`2;
    assume $this != null;
    $tmp7 := F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this];
    call $tmp8 := System.Linq.Enumerable.SelectEnumerable`2.GetEnumerator($tmp7);
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) != T$System.Linq.Enumerable.SelectEnumerable`2;
    assume $this != null;
    $tmp9 := F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this];
    call $tmp10 := System.Collections.Generic.IEnumerable`1.GetEnumerator($tmp9);
    goto anon9;

  anon9:
    assume $this != null;
    call System.Linq.Enumerable.WhereEnumerator`1.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$System.Boolean$($tmp0, (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Collections.Generic.HashSet`1 then $tmp2 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Collections.Generic.List`1 then $tmp4 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Linq.Enumerable.WhereEnumerable`1 then $tmp6 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerable`1.origEnum[$this])) == T$System.Linq.Enumerable.SelectEnumerable`2 then $tmp8 else $tmp10)))), F$System.Linq.Enumerable.WhereEnumerable`1.func[$this]);
    assume $DynamicType($tmp0) == T$System.Linq.Enumerable.WhereEnumerator`1(T$T$System.Linq.Enumerable.WhereEnumerable`1($DynamicType($this)));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume T$T$System.Linq.Enumerable.WhereEnumerator`1($DynamicType($tmp0)) == T$T$System.Linq.Enumerable.WhereEnumerable`1($DynamicType($this));
    local_0_Ref := $tmp0;
    goto IL_001a;

  IL_001a:
    $result := local_0_Ref;
    return;
}



procedure System.Linq.Enumerable.WhereEnumerable`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.WhereEnumerable`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 23} true;
    call $tmp0 := System.Linq.Enumerable.WhereEnumerable`1.GetEnumerator($this);
    local_0_Ref := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure T$System.Linq.Enumerable.WhereEnumerable`1.#cctor();



implementation T$System.Linq.Enumerable.WhereEnumerable`1.#cctor()
{

  anon0:
    return;
}



axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Linq.Enumerable.WhereEnumerable`1(T), $T) } $Subtype(T$System.Linq.Enumerable.WhereEnumerable`1(T), $T) <==> T$System.Linq.Enumerable.WhereEnumerable`1(T) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerable`1(T), $T) || $Subtype(T$System.Collections.IEnumerable(), $T));

var F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator: [Ref]Ref;

var F$System.Linq.Enumerable.WhereEnumerator`1.func: [Ref]Ref;

implementation System.Linq.Enumerable.WhereEnumerator`1.#ctor$System.Collections.Generic.IEnumerator$`0$$System.Func$`0$System.Boolean$($this: Ref, origEnum$in: Ref, func$in: Ref)
{
  var origEnum: Ref;
  var func: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    origEnum := origEnum$in;
    func := func$in;
    F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this] := null;
    F$System.Linq.Enumerable.WhereEnumerator`1.func[$this] := null;
    assume {:breadcrumb 24} true;
    call System.Object.#ctor($this);
    F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this] := origEnum;
    F$System.Linq.Enumerable.WhereEnumerator`1.func[$this] := func;
    return;
}



implementation System.Linq.Enumerable.WhereEnumerator`1.MoveNext($this: Ref) returns ($result: bool)
{
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: bool;
  var local_0_bool: bool;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: bool;
  var $tmp27: Ref;
  var local_1_bool: bool;
  var local_2_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 25} true;
    goto IL_003a;

  IL_0003:
    assume $this != null;
    goto anon24_Then, anon24_Else;

  anon24_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp1 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext($tmp0);
    goto anon9;

  anon24_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon25_Then, anon25_Else;

  anon25_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp2 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp3 := System.Collections.Generic.List`1.ListEnumerator.MoveNext($tmp2);
    goto anon9;

  anon25_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon26_Then, anon26_Else;

  anon26_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp4 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp5 := System.Linq.Enumerable.WhereEnumerator`1.MoveNext($tmp4);
    goto anon9;

  anon26_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon27_Then, anon27_Else;

  anon27_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp6 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp7 := System.Linq.Enumerable.SelectEnumerator`2.MoveNext($tmp6);
    goto anon9;

  anon27_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp8 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp9 := System.Collections.IEnumerator.MoveNext($tmp8);
    goto anon9;

  anon9:
    local_0_bool := (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp1 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp3 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp5 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp7 else $tmp9))));
    goto anon28_Then, anon28_Else;

  anon28_Then:
    assume {:partition} !local_0_bool;
    goto anon21;

  anon28_Else:
    assume {:partition} local_0_bool;
    assume $this != null;
    $tmp10 := F$System.Linq.Enumerable.WhereEnumerator`1.func[$this];
    assume $this != null;
    goto anon29_Then, anon29_Else;

  anon29_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp11 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp13 := System.Collections.Generic.HashSet`1.Enumerator.get_Current($tmp11);
    $tmp12 := $tmp13;
    goto anon20;

  anon29_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon30_Then, anon30_Else;

  anon30_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp14 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp16 := System.Collections.Generic.List`1.ListEnumerator.get_Current($tmp14);
    $tmp15 := $tmp16;
    goto anon20;

  anon30_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp17 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp19 := System.Linq.Enumerable.WhereEnumerator`1.get_Current($tmp17);
    $tmp18 := $tmp19;
    goto anon20;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp20 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp22 := System.Linq.Enumerable.SelectEnumerator`2.get_Current($tmp20);
    $tmp21 := $tmp22;
    goto anon20;

  anon32_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp23 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp25 := System.Collections.Generic.IEnumerator`1.get_Current($tmp23);
    $tmp24 := $tmp25;
    goto anon20;

  anon20:
    call $tmp27 := System.Func`2.Invoke$`0($tmp10, (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp12 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp15 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp18 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp21 else $tmp24)))));
    $tmp26 := Union2Bool($tmp27);
    goto anon21;

  anon21:
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} (if !local_0_bool then true else $tmp26);
    local_1_bool := local_0_bool;
    goto anon23;

  anon33_Else:
    assume {:partition} !(if !local_0_bool then true else $tmp26);
    goto IL_003a;

  IL_003a:
    local_2_bool := true;
    goto IL_0003;

  anon23:
    $result := local_1_bool;
    return;
}



implementation System.Linq.Enumerable.WhereEnumerator`1.get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 26} true;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp2 := System.Collections.Generic.HashSet`1.Enumerator.get_Current($tmp0);
    $tmp1 := $tmp2;
    goto anon9;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp3 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp5 := System.Collections.Generic.List`1.ListEnumerator.get_Current($tmp3);
    $tmp4 := $tmp5;
    goto anon9;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp6 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp8 := System.Linq.Enumerable.WhereEnumerator`1.get_Current($tmp6);
    $tmp7 := $tmp8;
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp9 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp11 := System.Linq.Enumerable.SelectEnumerator`2.get_Current($tmp9);
    $tmp10 := $tmp11;
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp12 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call $tmp14 := System.Collections.Generic.IEnumerator`1.get_Current($tmp12);
    $tmp13 := $tmp14;
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator then $tmp1 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator then $tmp4 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1 then $tmp7 else (if $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2 then $tmp10 else $tmp13))));
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure System.Linq.Enumerable.WhereEnumerator`1.Dispose($this: Ref);



implementation System.Linq.Enumerable.WhereEnumerator`1.Dispose($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 27} true;
    return;
}



implementation System.Linq.Enumerable.WhereEnumerator`1.Reset($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 28} true;
    assume $this != null;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    $tmp0 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call System.Collections.Generic.HashSet`1.Enumerator.Reset($tmp0);
    return;

  anon9_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.HashSet`1.Enumerator;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    $tmp1 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call System.Collections.Generic.List`1.ListEnumerator.Reset($tmp1);
    return;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Collections.Generic.List`1.ListEnumerator;
    assume $this != null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    $tmp2 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call System.Linq.Enumerable.WhereEnumerator`1.Reset($tmp2);
    return;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.WhereEnumerator`1;
    assume $this != null;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) == T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp3 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call System.Linq.Enumerable.SelectEnumerator`2.Reset($tmp3);
    return;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this])) != T$System.Linq.Enumerable.SelectEnumerator`2;
    assume $this != null;
    $tmp4 := F$System.Linq.Enumerable.WhereEnumerator`1.currentEnumerator[$this];
    call System.Collections.IEnumerator.Reset($tmp4);
    return;
}



procedure System.Linq.Enumerable.WhereEnumerator`1.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref);



implementation System.Linq.Enumerable.WhereEnumerator`1.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 29} true;
    call $tmp1 := System.Linq.Enumerable.WhereEnumerator`1.get_Current($this);
    $tmp0 := $tmp1;
    call $tmp2 := $BoxFromUnion($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure T$System.Linq.Enumerable.WhereEnumerator`1.#cctor();



implementation T$System.Linq.Enumerable.WhereEnumerator`1.#cctor()
{

  anon0:
    return;
}



axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Linq.Enumerable.WhereEnumerator`1(T), $T) } $Subtype(T$System.Linq.Enumerable.WhereEnumerator`1(T), $T) <==> T$System.Linq.Enumerable.WhereEnumerator`1(T) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerator`1(T), $T) || $Subtype(T$System.IDisposable(), $T) || $Subtype(T$System.Collections.IEnumerator(), $T));

procedure T$System.Linq.Enumerable.#cctor();



implementation T$System.Linq.Enumerable.#cctor()
{

  anon0:
    return;
}



axiom (forall $T: Ref :: { $Subtype(T$System.Linq.Enumerable(), $T) } $Subtype(T$System.Linq.Enumerable(), $T) <==> T$System.Linq.Enumerable() == $T || $Subtype(T$System.Object(), $T));

function T$System.Threading.ManualResetEvent() : Ref;

const unique T$System.Threading.ManualResetEvent: int;

procedure System.Threading.ManualResetEvent.#ctor$System.Boolean($this: Ref, b$in: bool);



procedure System.Threading.EventWaitHandle.#ctor($this: Ref);



var F$System.Threading.EventWaitHandle.Signaled: [Ref]bool;

implementation System.Threading.ManualResetEvent.#ctor$System.Boolean($this: Ref, b$in: bool)
{
  var b: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    b := b$in;
    assume {:breadcrumb 30} true;
    call System.Threading.EventWaitHandle.#ctor($this);
    F$System.Threading.EventWaitHandle.Signaled[$this] := b;
    return;
}



procedure System.Threading.ManualResetEvent.WaitOne$System.Threading.ManualResetEvent(this$in: Ref) returns ($result: bool);



implementation System.Threading.ManualResetEvent.WaitOne$System.Threading.ManualResetEvent(this$in: Ref) returns ($result: bool)
{
  var this: Ref;
  var $tmp0: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    this := this$in;
    assume {:breadcrumb 31} true;
    $tmp0 := this;
    assume $tmp0 != null;
    assume F$System.Threading.EventWaitHandle.Signaled[$tmp0];
    local_0_bool := true;
    goto IL_0011;

  IL_0011:
    $result := local_0_bool;
    return;
}



procedure T$System.Threading.ManualResetEvent.#cctor();



implementation T$System.Threading.ManualResetEvent.#cctor()
{

  anon0:
    return;
}



function T$System.Threading.EventWaitHandle() : Ref;

const unique T$System.Threading.EventWaitHandle: int;

axiom (forall $T: Ref :: { $Subtype(T$System.Threading.ManualResetEvent(), $T) } $Subtype(T$System.Threading.ManualResetEvent(), $T) <==> T$System.Threading.ManualResetEvent() == $T || $Subtype(T$System.Threading.EventWaitHandle(), $T));

function T$System.Threading.WaitHandle() : Ref;

const unique T$System.Threading.WaitHandle: int;

procedure System.Threading.WaitHandle.WaitOne($this: Ref) returns ($result: bool);



function T$System.Threading.AutoResetEvent() : Ref;

const unique T$System.Threading.AutoResetEvent: int;

procedure System.Threading.AutoResetEvent.WaitOne$System.Threading.AutoResetEvent(this$in: Ref) returns ($result: bool);



function T$System.Threading.Mutex() : Ref;

const unique T$System.Threading.Mutex: int;

procedure System.Threading.Mutex.WaitOne$System.Threading.Mutex(this$in: Ref) returns ($result: bool);



implementation System.Threading.WaitHandle.WaitOne($this: Ref) returns ($result: bool)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var local_1_bool: bool;
  var $tmp3: bool;
  var $tmp4: bool;
  var $tmp5: bool;
  var $tmp6: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 32} true;
    call $tmp0 := System.Object.GetType($this);
    local_0_Ref := $tmp0;
    call $tmp1 := System.Type.op_Equality$System.Type$System.Type(local_0_Ref, T$System.Threading.ManualResetEvent());
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp1;
    call $tmp2 := System.Threading.ManualResetEvent.WaitOne$System.Threading.ManualResetEvent($this);
    local_1_bool := $tmp2;
    goto IL_0082;

  anon7_Else:
    assume {:partition} !$tmp1;
    call $tmp3 := System.Type.op_Equality$System.Type$System.Type(local_0_Ref, T$System.Threading.AutoResetEvent());
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp3;
    call $tmp4 := System.Threading.AutoResetEvent.WaitOne$System.Threading.AutoResetEvent($this);
    local_1_bool := $tmp4;
    goto IL_0082;

  anon8_Else:
    assume {:partition} !$tmp3;
    call $tmp5 := System.Type.op_Equality$System.Type$System.Type(local_0_Ref, T$System.Threading.Mutex());
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $tmp5;
    call $tmp6 := System.Threading.Mutex.WaitOne$System.Threading.Mutex($this);
    local_1_bool := $tmp6;
    goto IL_0082;

  anon9_Else:
    assume {:partition} !$tmp5;
    assume false;
    local_1_bool := true;
    goto IL_0082;

  IL_0082:
    $result := local_1_bool;
    return;
}



procedure System.Threading.WaitHandle.Dispose($this: Ref);



implementation System.Threading.WaitHandle.Dispose($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 33} true;
    return;
}



procedure System.Threading.WaitHandle.#ctor($this: Ref);



procedure {:extern} System.MarshalByRefObject.#ctor($this: Ref);



implementation System.Threading.WaitHandle.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 34} true;
    call System.MarshalByRefObject.#ctor($this);
    return;
}



procedure T$System.Threading.WaitHandle.#cctor();



implementation T$System.Threading.WaitHandle.#cctor()
{

  anon0:
    return;
}



function {:extern} T$System.MarshalByRefObject() : Ref;

const {:extern} unique T$System.MarshalByRefObject: int;

axiom $TypeConstructor(T$System.MarshalByRefObject()) == T$System.MarshalByRefObject;

axiom (forall $T: Ref :: { $Subtype(T$System.Threading.WaitHandle(), $T) } $Subtype(T$System.Threading.WaitHandle(), $T) <==> T$System.Threading.WaitHandle() == $T || $Subtype(T$System.MarshalByRefObject(), $T) || $Subtype(T$System.IDisposable(), $T));

procedure System.Threading.AutoResetEvent.#ctor$System.Boolean($this: Ref, b$in: bool);



implementation System.Threading.AutoResetEvent.#ctor$System.Boolean($this: Ref, b$in: bool)
{
  var b: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    b := b$in;
    assume {:breadcrumb 35} true;
    call System.Threading.EventWaitHandle.#ctor($this);
    F$System.Threading.EventWaitHandle.Signaled[$this] := b;
    return;
}



implementation System.Threading.AutoResetEvent.WaitOne$System.Threading.AutoResetEvent(this$in: Ref) returns ($result: bool)
{
  var this: Ref;
  var $tmp0: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    this := this$in;
    assume {:breadcrumb 36} true;
    call corral_atomic_begin();
    $tmp0 := this;
    assume $tmp0 != null;
    assume F$System.Threading.EventWaitHandle.Signaled[$tmp0];
    F$System.Threading.EventWaitHandle.Signaled[this] := false;
    call corral_atomic_end();
    local_0_bool := true;
    goto IL_0024;

  IL_0024:
    $result := local_0_bool;
    return;
}



procedure T$System.Threading.AutoResetEvent.#cctor();



implementation T$System.Threading.AutoResetEvent.#cctor()
{

  anon0:
    return;
}



axiom (forall $T: Ref :: { $Subtype(T$System.Threading.AutoResetEvent(), $T) } $Subtype(T$System.Threading.AutoResetEvent(), $T) <==> T$System.Threading.AutoResetEvent() == $T || $Subtype(T$System.Threading.EventWaitHandle(), $T));

procedure System.Threading.EventWaitHandle.Set($this: Ref) returns ($result: bool);



implementation System.Threading.EventWaitHandle.Set($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 37} true;
    F$System.Threading.EventWaitHandle.Signaled[$this] := true;
    local_0_bool := true;
    goto IL_000c;

  IL_000c:
    $result := local_0_bool;
    return;
}



implementation System.Threading.EventWaitHandle.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$System.Threading.EventWaitHandle.Signaled[$this] := false;
    assume {:breadcrumb 38} true;
    call System.Threading.WaitHandle.#ctor($this);
    return;
}



procedure T$System.Threading.EventWaitHandle.#cctor();



implementation T$System.Threading.EventWaitHandle.#cctor()
{

  anon0:
    return;
}



axiom (forall $T: Ref :: { $Subtype(T$System.Threading.EventWaitHandle(), $T) } $Subtype(T$System.Threading.EventWaitHandle(), $T) <==> T$System.Threading.EventWaitHandle() == $T || $Subtype(T$System.Threading.WaitHandle(), $T));

var F$System.Threading.Mutex.ReentrancyCount: [Ref]int;

var F$System.Threading.Mutex.Owner: [Ref]int;

procedure System.Threading.Mutex.#ctor($this: Ref);



implementation System.Threading.Mutex.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$System.Threading.Mutex.ReentrancyCount[$this] := 0;
    F$System.Threading.Mutex.Owner[$this] := 0;
    assume {:breadcrumb 39} true;
    call System.Threading.WaitHandle.#ctor($this);
    F$System.Threading.Mutex.ReentrancyCount[$this] := 0;
    F$System.Threading.Mutex.Owner[$this] := 0;
    return;
}



procedure System.Threading.Mutex.ReleaseMutex($this: Ref);



implementation System.Threading.Mutex.ReleaseMutex($this: Ref)
{
  var local_0_int: int;
  var $tmp0: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 40} true;
    call $tmp0 := corral_getThreadID();
    local_0_int := $tmp0;
    call corral_atomic_begin();
    assume $this != null;
    F$System.Threading.Mutex.ReentrancyCount[$this] := F$System.Threading.Mutex.ReentrancyCount[$this] - 1;
    assume $this != null;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} F$System.Threading.Mutex.ReentrancyCount[$this] == 0;
    F$System.Threading.Mutex.Owner[$this] := 0;
    goto anon3;

  anon4_Else:
    assume {:partition} F$System.Threading.Mutex.ReentrancyCount[$this] != 0;
    goto anon3;

  anon3:
    call corral_atomic_end();
    return;
}



implementation System.Threading.Mutex.WaitOne$System.Threading.Mutex(this$in: Ref) returns ($result: bool)
{
  var this: Ref;
  var local_0_int: int;
  var $tmp0: int;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_1_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    this := this$in;
    assume {:breadcrumb 41} true;
    call $tmp0 := corral_getThreadID();
    local_0_int := $tmp0;
    call corral_atomic_begin();
    $tmp2 := this;
    assume $tmp2 != null;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !(F$System.Threading.Mutex.Owner[$tmp2] != 0);
    goto anon3;

  anon4_Else:
    assume {:partition} F$System.Threading.Mutex.Owner[$tmp2] != 0;
    $tmp1 := this;
    assume $tmp1 != null;
    goto anon3;

  anon3:
    assume (if !(F$System.Threading.Mutex.Owner[$tmp2] != 0) then true else F$System.Threading.Mutex.Owner[$tmp1] == local_0_int);
    F$System.Threading.Mutex.Owner[this] := local_0_int;
    $tmp3 := this;
    assume $tmp3 != null;
    F$System.Threading.Mutex.ReentrancyCount[this] := F$System.Threading.Mutex.ReentrancyCount[$tmp3] + 1;
    call corral_atomic_end();
    local_1_bool := true;
    goto IL_0047;

  IL_0047:
    $result := local_1_bool;
    return;
}



procedure T$System.Threading.Mutex.#cctor();



implementation T$System.Threading.Mutex.#cctor()
{

  anon0:
    return;
}



axiom (forall $T: Ref :: { $Subtype(T$System.Threading.Mutex(), $T) } $Subtype(T$System.Threading.Mutex(), $T) <==> T$System.Threading.Mutex() == $T || $Subtype(T$System.Threading.WaitHandle(), $T));

function T$System.Random() : Ref;

const unique T$System.Random: int;

procedure System.Random.Next($this: Ref) returns ($result: int);



procedure {:extern} Poirot.Poirot.NondetInt() returns ($result: int);



implementation System.Random.Next($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $tmp0: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 42} true;
    call $tmp0 := Poirot.Poirot.NondetInt();
    local_0_int := $tmp0;
    assume !(0 > local_0_int);
    local_1_int := local_0_int;
    goto IL_0018;

  IL_0018:
    $result := local_1_int;
    return;
}



procedure System.Random.Next$System.Int32($this: Ref, a$in: int) returns ($result: int);



implementation System.Random.Next$System.Int32($this: Ref, a$in: int) returns ($result: int)
{
  var a: int;
  var local_0_int: int;
  var $tmp0: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    a := a$in;
    assume {:breadcrumb 43} true;
    call $tmp0 := Poirot.Poirot.NondetInt();
    local_0_int := $tmp0;
    assume !(a > local_0_int);
    local_1_int := local_0_int;
    goto IL_0018;

  IL_0018:
    $result := local_1_int;
    return;
}



procedure System.Random.Next$System.Int32$System.Int32($this: Ref, a$in: int, b$in: int) returns ($result: int);



implementation System.Random.Next$System.Int32$System.Int32($this: Ref, a$in: int, b$in: int) returns ($result: int)
{
  var a: int;
  var b: int;
  var local_0_int: int;
  var $tmp0: int;
  var local_1_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    a := a$in;
    b := b$in;
    assume {:breadcrumb 44} true;
    call $tmp0 := Poirot.Poirot.NondetInt();
    local_0_int := $tmp0;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} a > local_0_int;
    goto anon3;

  anon4_Else:
    assume {:partition} local_0_int >= a;
    goto anon3;

  anon3:
    assume (if a > local_0_int then false else local_0_int < b);
    local_1_int := local_0_int;
    goto IL_001d;

  IL_001d:
    $result := local_1_int;
    return;
}



procedure System.Random.#ctor($this: Ref);



implementation System.Random.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 45} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$System.Random.#cctor();



implementation T$System.Random.#cctor()
{

  anon0:
    return;
}



axiom (forall $T: Ref :: { $Subtype(T$System.Random(), $T) } $Subtype(T$System.Random(), $T) <==> T$System.Random() == $T || $Subtype(T$System.Object(), $T));

function T$System.Type() : Ref;

const unique T$System.Type: int;

procedure System.Type.op_Equality$System.Type$System.Type(left$in: Ref, right$in: Ref) returns ($result: bool);



implementation System.Type.op_Equality$System.Type$System.Type(left$in: Ref, right$in: Ref) returns ($result: bool)
{
  var left: Ref;
  var right: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    left := left$in;
    right := right$in;
    assume {:breadcrumb 46} true;
    local_0_bool := left == right;
    goto IL_0008;

  IL_0008:
    $result := local_0_bool;
    return;
}



procedure System.Type.op_Inequality$System.Type$System.Type(left$in: Ref, right$in: Ref) returns ($result: bool);



implementation System.Type.op_Inequality$System.Type$System.Type(left$in: Ref, right$in: Ref) returns ($result: bool)
{
  var left: Ref;
  var right: Ref;
  var local_0_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    left := left$in;
    right := right$in;
    assume {:breadcrumb 47} true;
    local_0_bool := !(left == right);
    goto IL_000b;

  IL_000b:
    $result := local_0_bool;
    return;
}



procedure System.Type.#ctor($this: Ref);



procedure {:extern} System.Reflection.MemberInfo.#ctor($this: Ref);



implementation System.Type.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 48} true;
    call System.Reflection.MemberInfo.#ctor($this);
    return;
}



procedure T$System.Type.#cctor();



implementation T$System.Type.#cctor()
{

  anon0:
    return;
}



function {:extern} T$System.Reflection.MemberInfo() : Ref;

const {:extern} unique T$System.Reflection.MemberInfo: int;

axiom $TypeConstructor(T$System.Reflection.MemberInfo()) == T$System.Reflection.MemberInfo;

axiom (forall $T: Ref :: { $Subtype(T$System.Type(), $T) } $Subtype(T$System.Type(), $T) <==> T$System.Type() == $T || $Subtype(T$System.Reflection.MemberInfo(), $T));

procedure System.Collections.Generic.List`1.#ctor$System.Boolean($this: Ref, dontCallMe$in: bool);



implementation System.Collections.Generic.List`1.#ctor$System.Boolean($this: Ref, dontCallMe$in: bool)
{
  var dontCallMe: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    dontCallMe := dontCallMe$in;
    assume {:breadcrumb 49} true;
    call System.Object.#ctor($this);
    return;
}



procedure System.Collections.Generic.List`1.ListEnumerator.#ctor$System.Collections.Generic.List$`0$($this: Ref, l$in: Ref);



procedure System.Collections.Generic.List.ListEnumerator.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation System.Collections.Generic.List`1.GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 50} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.List`1.ListEnumerator.#ctor$System.Collections.Generic.List$`0$($tmp0, $this);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.List`1.ListEnumerator(T$T$System.Collections.Generic.List`1($DynamicType($this)));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.List`1.ListEnumerator;
    assume T$T$System.Collections.Generic.List`1.ListEnumerator($DynamicType($tmp0)) == T$T$System.Collections.Generic.List`1($DynamicType($this));
    call $tmp2 := System.Collections.Generic.List.ListEnumerator.#copy_ctor($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.List`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref);



implementation System.Collections.Generic.List`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 51} true;
    call $tmp0 := System.Collections.Generic.List`1.GetEnumerator($this);
    local_0_Ref := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Ref);



procedure System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Ref);



procedure System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int);



procedure System.Collections.Generic.List.ListEnumerator.#default_ctor($this: Ref);



var F$System.Collections.Generic.List`1.ListEnumerator.parent: [Ref]Ref;

var F$System.Collections.Generic.List`1.ListEnumerator.iter: [Ref]int;

implementation {:inline 1} System.Collections.Generic.List.ListEnumerator.#default_ctor($this: Ref)
{

  anon0:
    F$System.Collections.Generic.List`1.ListEnumerator.parent[$this] := null;
    F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] := 0;
    return;
}



implementation {:inline 1} System.Collections.Generic.List.ListEnumerator.#copy_ctor(this: Ref) returns (other: Ref)
{

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$System.Collections.Generic.List`1.ListEnumerator.parent[other] := F$System.Collections.Generic.List`1.ListEnumerator.parent[this];
    F$System.Collections.Generic.List`1.ListEnumerator.iter[other] := F$System.Collections.Generic.List`1.ListEnumerator.iter[this];
    return;
}



implementation System.Collections.Generic.List`1.ListEnumerator.#ctor$System.Collections.Generic.List$`0$($this: Ref, l$in: Ref)
{
  var l: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    l := l$in;
    F$System.Collections.Generic.List`1.ListEnumerator.parent[$this] := null;
    F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] := 0;
    assume {:breadcrumb 52} true;
    F$System.Collections.Generic.List`1.ListEnumerator.parent[$this] := l;
    F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] := -1;
    return;
}



implementation System.Collections.Generic.List`1.ListEnumerator.MoveNext($this: Ref) returns ($result: bool)
{
  var local_0_bool: bool;
  var $tmp0: Ref;
  var $tmp1: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 53} true;
    assume $this != null;
    F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] := F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] + 1;
    assume $this != null;
    assume $this != null;
    $tmp0 := F$System.Collections.Generic.List`1.ListEnumerator.parent[$this];
    call $tmp1 := System.Collections.Generic.List`1.get_Count($tmp0);
    local_0_bool := F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] < $tmp1;
    goto IL_0025;

  IL_0025:
    $result := local_0_bool;
    return;
}



implementation System.Collections.Generic.List`1.ListEnumerator.get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 54} true;
    assume $this != null;
    $tmp0 := F$System.Collections.Generic.List`1.ListEnumerator.parent[$this];
    assume $this != null;
    call $tmp2 := System.Collections.Generic.List`1.get_Item$System.Int32($tmp0, F$System.Collections.Generic.List`1.ListEnumerator.iter[$this]);
    $tmp1 := $tmp2;
    local_0_Ref := $tmp1;
    goto IL_0015;

  IL_0015:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.List`1.ListEnumerator.Dispose($this: Ref);



implementation System.Collections.Generic.List`1.ListEnumerator.Dispose($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 55} true;
    return;
}



implementation System.Collections.Generic.List`1.ListEnumerator.Reset($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 56} true;
    F$System.Collections.Generic.List`1.ListEnumerator.iter[$this] := -1;
    return;
}



procedure System.Collections.Generic.List`1.ListEnumerator.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref);



implementation System.Collections.Generic.List`1.ListEnumerator.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 57} true;
    call $tmp1 := System.Collections.Generic.List`1.ListEnumerator.get_Current($this);
    $tmp0 := $tmp1;
    call $tmp2 := $BoxFromUnion($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure T$System.Collections.Generic.List`1.#cctor();



implementation T$System.Collections.Generic.List`1.#cctor()
{

  anon0:
    return;
}



axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Collections.Generic.List`1(T), $T) } $Subtype(T$System.Collections.Generic.List`1(T), $T) <==> T$System.Collections.Generic.List`1(T) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerable`1(T), $T) || $Subtype(T$System.Collections.IEnumerable(), $T));

procedure System.Collections.Generic.HashSet`1.#ctor$System.Boolean($this: Ref, dontCallMe$in: bool);



implementation System.Collections.Generic.HashSet`1.#ctor$System.Boolean($this: Ref, dontCallMe$in: bool)
{
  var dontCallMe: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    dontCallMe := dontCallMe$in;
    assume {:breadcrumb 58} true;
    call System.Object.#ctor($this);
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$($this: Ref, h$in: Ref);



procedure System.Collections.Generic.HashSet.Enumerator.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



implementation System.Collections.Generic.HashSet`1.GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 59} true;
    call $tmp0 := Alloc();
    call System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$($tmp0, $this);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.HashSet`1.Enumerator(T$T$System.Collections.Generic.HashSet`1($DynamicType($this)));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assume T$T$System.Collections.Generic.HashSet`1.Enumerator($DynamicType($tmp0)) == T$T$System.Collections.Generic.HashSet`1($DynamicType($this));
    call $tmp2 := System.Collections.Generic.HashSet.Enumerator.#copy_ctor($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.HashSet`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref);



implementation System.Collections.Generic.HashSet`1.System#Collections#IEnumerable#GetEnumerator($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 60} true;
    call $tmp0 := System.Collections.Generic.HashSet`1.GetEnumerator($this);
    local_0_Ref := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int);



procedure System.Collections.Generic.HashSet`1.Add$`0($this: Ref, t$in: Ref) returns ($result: bool);



procedure System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, t$in: Ref) returns ($result: bool);



procedure System.Collections.Generic.HashSet`1.Random($this: Ref) returns ($result: Ref);



procedure System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref);



procedure System.Collections.Generic.HashSet.Enumerator.#default_ctor($this: Ref);



var F$System.Collections.Generic.HashSet`1.Enumerator.parent: [Ref]Ref;

var F$System.Collections.Generic.HashSet`1.Enumerator.iter: [Ref]int;

var F$System.Collections.Generic.HashSet`1.Enumerator.currentElem: [Ref]Ref;

var F$System.Collections.Generic.HashSet`1.Enumerator.currentSet: [Ref]Ref;

implementation {:inline 1} System.Collections.Generic.HashSet.Enumerator.#default_ctor($this: Ref)
{

  anon0:
    F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this] := null;
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] := 0;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this] := null;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this] := null;
    return;
}



implementation {:inline 1} System.Collections.Generic.HashSet.Enumerator.#copy_ctor(this: Ref) returns (other: Ref)
{

  anon0:
    call other := Alloc();
    assume $DynamicType(other) == $DynamicType(this);
    F$System.Collections.Generic.HashSet`1.Enumerator.parent[other] := F$System.Collections.Generic.HashSet`1.Enumerator.parent[this];
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[other] := F$System.Collections.Generic.HashSet`1.Enumerator.iter[this];
    F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[other] := F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[this];
    F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[other] := F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[this];
    return;
}



implementation System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$($this: Ref, h$in: Ref)
{
  var h: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    h := h$in;
    F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this] := null;
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] := 0;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this] := null;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this] := null;
    assume {:breadcrumb 61} true;
    F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this] := h;
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] := -1;
    assume $this != null;
    $tmp0 := F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this];
    call $tmp1 := System.Collections.Generic.HashSet`1.New($tmp0);
    F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this] := $tmp1;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this] := null;
    return;
}



implementation System.Collections.Generic.HashSet`1.Enumerator.MoveNext($this: Ref) returns ($result: bool)
{
  var $tmp0: Ref;
  var $tmp1: int;
  var local_0_bool: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $tmp7: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 62} true;
    assume $this != null;
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] := F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] + 1;
    assume $this != null;
    assume $this != null;
    $tmp0 := F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this];
    call $tmp1 := System.Collections.Generic.HashSet`1.get_Count($tmp0);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] >= $tmp1;
    local_0_bool := false;
    goto IL_0082;

  anon6_Else:
    assume {:partition} $tmp1 > F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this];
    assume $this != null;
    $tmp2 := F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this];
    call $tmp4 := System.Collections.Generic.HashSet`1.Random($tmp2);
    $tmp3 := $tmp4;
    F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this] := $tmp3;
    assume $this != null;
    $tmp7 := F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this];
    assume $this != null;
    call $tmp8 := System.Collections.Generic.HashSet`1.Contains$`0($tmp7, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this]);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp8;
    assume $this != null;
    $tmp5 := F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this];
    assume $this != null;
    call $tmp6 := System.Collections.Generic.HashSet`1.Contains$`0($tmp5, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this]);
    goto anon5;

  anon7_Else:
    assume {:partition} !$tmp8;
    goto anon5;

  anon5:
    assume (if $tmp8 then !$tmp6 else false);
    assume $this != null;
    $tmp9 := F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this];
    assume $this != null;
    call $tmp10 := System.Collections.Generic.HashSet`1.Add$`0($tmp9, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this]);
    local_0_bool := true;
    goto IL_0082;

  IL_0082:
    $result := local_0_bool;
    return;
}



implementation System.Collections.Generic.HashSet`1.Enumerator.get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 63} true;
    assume $this != null;
    local_0_Ref := F$System.Collections.Generic.HashSet`1.Enumerator.currentElem[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.Dispose($this: Ref);



implementation System.Collections.Generic.HashSet`1.Enumerator.Dispose($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 64} true;
    return;
}



implementation System.Collections.Generic.HashSet`1.Enumerator.Reset($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 65} true;
    F$System.Collections.Generic.HashSet`1.Enumerator.iter[$this] := -1;
    assume $this != null;
    $tmp0 := F$System.Collections.Generic.HashSet`1.Enumerator.parent[$this];
    call $tmp1 := System.Collections.Generic.HashSet`1.New($tmp0);
    F$System.Collections.Generic.HashSet`1.Enumerator.currentSet[$this] := $tmp1;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref);



implementation System.Collections.Generic.HashSet`1.Enumerator.System#Collections#IEnumerator#get_Current($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 66} true;
    call $tmp1 := System.Collections.Generic.HashSet`1.Enumerator.get_Current($this);
    $tmp0 := $tmp1;
    call $tmp2 := $BoxFromUnion($tmp0);
    local_0_Ref := $tmp2;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure T$System.Collections.Generic.HashSet`1.#cctor();



implementation T$System.Collections.Generic.HashSet`1.#cctor()
{

  anon0:
    return;
}



axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Collections.Generic.HashSet`1(T), $T) } $Subtype(T$System.Collections.Generic.HashSet`1(T), $T) <==> T$System.Collections.Generic.HashSet`1(T) == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Collections.Generic.IEnumerable`1(T), $T) || $Subtype(T$System.Collections.IEnumerable(), $T));

axiom (forall $T: Ref :: { $Subtype(T$System.Object(), $T) } $Subtype(T$System.Object(), $T) <==> T$System.Object() == $T);

function T$System.SystemException() : Ref;

const unique T$System.SystemException: int;

axiom (forall $T: Ref :: { $Subtype(T$System.InvalidOperationException(), $T) } $Subtype(T$System.InvalidOperationException(), $T) <==> T$System.InvalidOperationException() == $T || $Subtype(T$System.SystemException(), $T));

axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Collections.Generic.IEnumerable`1(T), $T) } $Subtype(T$System.Collections.Generic.IEnumerable`1(T), $T) <==> T$System.Collections.Generic.IEnumerable`1(T) == $T || $Subtype(T$System.Collections.IEnumerable(), $T));

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.IEnumerable(), $T) } $Subtype(T$System.Collections.IEnumerable(), $T) <==> T$System.Collections.IEnumerable() == $T);

axiom (forall T: Ref, $T: Ref :: { $Subtype(T$System.Collections.Generic.IEnumerator`1(T), $T) } $Subtype(T$System.Collections.Generic.IEnumerator`1(T), $T) <==> T$System.Collections.Generic.IEnumerator`1(T) == $T || $Subtype(T$System.IDisposable(), $T) || $Subtype(T$System.Collections.IEnumerator(), $T));

axiom (forall $T: Ref :: { $Subtype(T$System.IDisposable(), $T) } $Subtype(T$System.IDisposable(), $T) <==> T$System.IDisposable() == $T);

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.IEnumerator(), $T) } $Subtype(T$System.Collections.IEnumerator(), $T) <==> T$System.Collections.IEnumerator() == $T);

axiom (forall $T: Ref :: { $Subtype(T$System.MarshalByRefObject(), $T) } $Subtype(T$System.MarshalByRefObject(), $T) <==> T$System.MarshalByRefObject() == $T || $Subtype(T$System.Object(), $T));

function T$System.Reflection.ICustomAttributeProvider() : Ref;

const unique T$System.Reflection.ICustomAttributeProvider: int;

function T$System.Runtime.InteropServices._MemberInfo() : Ref;

const unique T$System.Runtime.InteropServices._MemberInfo: int;

axiom (forall $T: Ref :: { $Subtype(T$System.Reflection.MemberInfo(), $T) } $Subtype(T$System.Reflection.MemberInfo(), $T) <==> T$System.Reflection.MemberInfo() == $T || $Subtype(T$System.Object(), $T) || $Subtype(T$System.Reflection.ICustomAttributeProvider(), $T) || $Subtype(T$System.Runtime.InteropServices._MemberInfo(), $T));

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
