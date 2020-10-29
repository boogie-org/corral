const hashsetEmpty: [Union]bool;

axiom (forall x: Union :: { hashsetEmpty[x] } !hashsetEmpty[x]);

axiom (forall x: Union :: Int2Union(Union2Int(x)) == x);

axiom (forall x: int :: Union2Int(Int2Union(x)) == x);

var hashsets: [Ref][Union]bool;

var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);
  modifies hashsets, hashsetSize;



implementation {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref)
{

  anon0:
    hashsets[$this] := hashsetEmpty;
    hashsetSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool);
  modifies hashsets, hashsetSize;



implementation {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := !hashsets[$this][item$in];
    hashsets[$this][item$in] := true;
    goto anon2_Then, anon2_Else;

  anon2_Else:
    assume {:partition} !$result;
    return;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] + 1;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := hashsetSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref);
  modifies $Alloc, hashsets, hashsetSize;



implementation {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    call inline$Alloc$0$x := havocNonDetAvh.Ref();
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $result := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
    return;
}



var stacks: [Ref][int]Union;

var stackPtr: [Ref]int;

var listContents: [Ref][int]Union;

var listSize: [Ref]int;

var AllMaps: [Ref][Union]Union;

type Ref;

type Field;

type Union = Ref;

type HeapType = [Ref][Field]Union;

const {:allocated} unique null: Ref;

var $Alloc: [Ref]bool;

procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



var $Heap: HeapType;

function {:inline true} Read(H: HeapType, o: Ref, f: Field) : Union
{
  H[o][f]
}

function {:inline true} Write(H: HeapType, o: Ref, f: Field, v: Union) : HeapType
{
  H[o := H[o][f := v]]
}

function Union2Bool(u: Union) : bool;

function Union2Int(u: Union) : int;

function Bool2Union(boolValue: bool) : Union;

function Int2Union(intValue: int) : Union;

axiom Union2Int(null) == 0;

axiom Union2Bool(null) <==> false;

function Int2Bool(intValue: int) : bool;

axiom Int2Bool(1) <==> true;

axiom Int2Bool(0) <==> false;

axiom (forall i: int :: { Int2Union(i) } Union2Int(Int2Union(i)) == i);

axiom (forall b: bool :: { Bool2Union(b) } Union2Bool(Bool2Union(b)) <==> b);

type Type = Ref;

function $TypeConstructor(Ref) : int;

function $DynamicType(Ref) : Type;

function $Subtype(Type, Type) : bool;

axiom (forall $T: Ref, $T1: Ref :: { $Subtype($T1, $T) } $Subtype($T1, $T) && $Subtype($T, $T1) ==> $T1 == $T);

function {:extern} T$System.Object() : Ref;

const {:extern} unique T$System.Object: int;

axiom $TypeConstructor(T$System.Object()) == T$System.Object;

axiom $Subtype(T$System.Object(), T$System.Object());

function $As(a: Ref, b: Type) : Ref;

axiom (forall a: Ref, b: Type :: { $As(a, b): Ref } $As(a, b): Ref == (if $Subtype($DynamicType(a), b) then a else null));

procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



function $RefToDelegateMethod(int, Ref) : bool;

function $RefToDelegateReceiver(int, Ref) : Ref;

function $RefToDelegateTypeParameters(int, Ref) : Type;

function Type0() : Ref;

var $Exception: Ref;

var $ExceptionType: Ref;

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

axiom $TypeConstructor(T$PoirotMain()) == T$PoirotMain;

axiom (forall $T: Ref :: { $Subtype(T$PoirotMain(), $T) } $Subtype(T$PoirotMain(), $T) <==> T$PoirotMain() == $T || $Subtype(T$System.Object(), $T));

function T$System.Collections.Generic.List`1() : Ref;

const unique T$System.Collections.Generic.List`1: int;

axiom $TypeConstructor(T$System.Collections.Generic.List`1()) == T$System.Collections.Generic.List`1;

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.Generic.List`1(), $T) } $Subtype(T$System.Collections.Generic.List`1(), $T) <==> T$System.Collections.Generic.List`1() == $T || $Subtype(T$System.Object(), $T));

function T$T() : Ref;

const unique T$T: int;

axiom $TypeConstructor(T$T()) == T$T;

function T$System.Collections.Generic.List`1.Enumerator() : Ref;

const unique T$System.Collections.Generic.List`1.Enumerator: int;

axiom $TypeConstructor(T$System.Collections.Generic.List`1.Enumerator()) == T$System.Collections.Generic.List`1.Enumerator;

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.Generic.List`1.Enumerator(), $T) } $Subtype(T$System.Collections.Generic.List`1.Enumerator(), $T) <==> T$System.Collections.Generic.List`1.Enumerator() == $T || $Subtype(T$System.ValueType(), $T));

function T$System.Collections.Generic.HashSet`1() : Ref;

const unique T$System.Collections.Generic.HashSet`1: int;

axiom $TypeConstructor(T$System.Collections.Generic.HashSet`1()) == T$System.Collections.Generic.HashSet`1;

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.Generic.HashSet`1(), $T) } $Subtype(T$System.Collections.Generic.HashSet`1(), $T) <==> T$System.Collections.Generic.HashSet`1() == $T || $Subtype(T$System.Object(), $T));

function T$System.Collections.Generic.HashSet`1.Enumerator() : Ref;

const unique T$System.Collections.Generic.HashSet`1.Enumerator: int;

axiom $TypeConstructor(T$System.Collections.Generic.HashSet`1.Enumerator()) == T$System.Collections.Generic.HashSet`1.Enumerator;

axiom (forall $T: Ref :: { $Subtype(T$System.Collections.Generic.HashSet`1.Enumerator(), $T) } $Subtype(T$System.Collections.Generic.HashSet`1.Enumerator(), $T) <==> T$System.Collections.Generic.HashSet`1.Enumerator() == $T || $Subtype(T$System.ValueType(), $T));

function T$System.Random() : Ref;

const unique T$System.Random: int;

axiom $TypeConstructor(T$System.Random()) == T$System.Random;

axiom (forall $T: Ref :: { $Subtype(T$System.Random(), $T) } $Subtype(T$System.Random(), $T) <==> T$System.Random() == $T || $Subtype(T$System.Object(), $T));

function T$Poirot.Poirot() : Ref;

const unique T$Poirot.Poirot: int;

axiom $TypeConstructor(T$Poirot.Poirot()) == T$Poirot.Poirot;

axiom (forall $T: Ref :: { $Subtype(T$Poirot.Poirot(), $T) } $Subtype(T$Poirot.Poirot(), $T) <==> T$Poirot.Poirot() == $T || $Subtype(T$System.Object(), $T));

procedure PoirotMain.Main();
  modifies $Exception, $GetMeHereTracker, $Alloc, hashsets, hashsetSize, $Heap;



implementation PoirotMain.Main()
{
  var ls: Ref;
  var $r3: int;
  var $r4: bool;
  var $r6: int;
  var $r7: bool;
  var $r9: int;
  var $r10: bool;
  var sum: int;
  var product: int;
  var local_3: Ref;
  var $r17: Ref;
  var x: int;
  var $r15: Ref;
  var $r16: bool;
  var $r28: Ref;
  var $r26: int;
  var $r27: bool;
  var $temp_var_0: Ref;
  var DynamicDispatch_Type_0: Ref;
  var $temp_var_2: Ref;
  var DynamicDispatch_Type_1: Ref;
  var $temp_var_4: Ref;
  var DynamicDispatch_Type_2: Ref;
  var DynamicDispatch_Type_3: Ref;
  var $temp_var_7: Ref;
  var DynamicDispatch_Type_4: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;
  var inline$System.Object.GetType$0$this: Ref;
  var inline$System.Object.GetType$0$$result: Ref;
  var inline$System.Object.GetType$1$this: Ref;
  var inline$System.Object.GetType$1$$result: Ref;
  var inline$System.Object.GetType$2$this: Ref;
  var inline$System.Object.GetType$2$$result: Ref;
  var inline$System.Object.GetType$3$this: Ref;
  var inline$System.Object.GetType$3$$result: Ref;
  var inline$System.Object.GetType$4$this: Ref;
  var inline$System.Object.GetType$4$$result: Ref;

  anon0:
    $Exception := null;
    $GetMeHereTracker := 0;
    assert {:sourceFile "Program.cs"} {:sourceLine 8} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 9} true;
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    call inline$Alloc$0$x := havocNonDetAvh.Ref();
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    ls := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    assume $DynamicType(ls) == T$System.Collections.Generic.HashSet`1();
    assume $TypeConstructor($DynamicType(ls)) == T$System.Collections.Generic.HashSet`1;
    assert {:sourceFile "Program.cs"} {:sourceLine 9} true;
    call System.Collections.Generic.HashSet`1.#ctor(ls);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    assert {:sourceFile "Program.cs"} {:sourceLine 10} true;
    $r3 := 6;
    assert {:sourceFile "Program.cs"} {:sourceLine 10} true;
    $temp_var_0 := Int2Union($r3);
    goto inline$System.Object.GetType$0$Entry;

  inline$System.Object.GetType$0$Entry:
    inline$System.Object.GetType$0$this := ls;
    call inline$System.Object.GetType$0$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$0$anon0;

  inline$System.Object.GetType$0$anon0:
    inline$System.Object.GetType$0$$result := $DynamicType(inline$System.Object.GetType$0$this);
    goto inline$System.Object.GetType$0$Return;

  inline$System.Object.GetType$0$Return:
    DynamicDispatch_Type_0 := inline$System.Object.GetType$0$$result;
    goto anon2$1;

  anon2$1:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon35_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    call $r4 := System.Collections.Generic.HashSet`1.Add$`0(ls, $temp_var_0);
    goto anon5;

  anon5:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} $Exception == null;
    goto anon7;

  anon7:
    assert {:sourceFile "Program.cs"} {:sourceLine 11} true;
    $r6 := 1;
    assert {:sourceFile "Program.cs"} {:sourceLine 11} true;
    $temp_var_2 := Int2Union($r6);
    goto inline$System.Object.GetType$1$Entry;

  inline$System.Object.GetType$1$Entry:
    inline$System.Object.GetType$1$this := ls;
    call inline$System.Object.GetType$1$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$1$anon0;

  inline$System.Object.GetType$1$anon0:
    inline$System.Object.GetType$1$$result := $DynamicType(inline$System.Object.GetType$1$this);
    goto inline$System.Object.GetType$1$Return;

  inline$System.Object.GetType$1$Return:
    DynamicDispatch_Type_1 := inline$System.Object.GetType$1$$result;
    goto anon7$1;

  anon7$1:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_1, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon37_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_1, T$System.Collections.Generic.HashSet`1());
    call $r7 := System.Collections.Generic.HashSet`1.Add$`0(ls, $temp_var_2);
    goto anon10;

  anon10:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} $Exception == null;
    goto anon12;

  anon12:
    assert {:sourceFile "Program.cs"} {:sourceLine 12} true;
    $r9 := 2;
    assert {:sourceFile "Program.cs"} {:sourceLine 12} true;
    $temp_var_4 := Int2Union($r9);
    goto inline$System.Object.GetType$2$Entry;

  inline$System.Object.GetType$2$Entry:
    inline$System.Object.GetType$2$this := ls;
    call inline$System.Object.GetType$2$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$2$anon0;

  inline$System.Object.GetType$2$anon0:
    inline$System.Object.GetType$2$$result := $DynamicType(inline$System.Object.GetType$2$this);
    goto inline$System.Object.GetType$2$Return;

  inline$System.Object.GetType$2$Return:
    DynamicDispatch_Type_2 := inline$System.Object.GetType$2$$result;
    goto anon12$1;

  anon12$1:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_2, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon39_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_2, T$System.Collections.Generic.HashSet`1());
    call $r10 := System.Collections.Generic.HashSet`1.Add$`0(ls, $temp_var_4);
    goto anon15;

  anon15:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} $Exception == null;
    goto anon17;

  anon17:
    assert {:sourceFile "Program.cs"} {:sourceLine 13} true;
    sum := 0;
    assert {:sourceFile "Program.cs"} {:sourceLine 14} true;
    product := 1;
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    goto inline$System.Object.GetType$3$Entry;

  inline$System.Object.GetType$3$Entry:
    inline$System.Object.GetType$3$this := ls;
    call inline$System.Object.GetType$3$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$3$anon0;

  inline$System.Object.GetType$3$anon0:
    inline$System.Object.GetType$3$$result := $DynamicType(inline$System.Object.GetType$3$this);
    goto inline$System.Object.GetType$3$Return;

  inline$System.Object.GetType$3$Return:
    DynamicDispatch_Type_3 := inline$System.Object.GetType$3$$result;
    goto anon17$1;

  anon17$1:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_3, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon41_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_3, T$System.Collections.Generic.HashSet`1());
    call local_3 := System.Collections.Generic.HashSet`1.GetEnumerator(ls);
    goto anon20;

  anon20:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} $Exception == null;
    goto L_002B;

  L_002B:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    goto L_0042;

  L_0042:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    $r15 := local_3;
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    call $r16 := System.Collections.Generic.HashSet`1.Enumerator.MoveNext($r15);
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} $Exception == null;
    goto anon25;

  anon25:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} $r16 <==> false;
    goto anon27;

  anon27:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    goto L_004D;

  L_004D:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    $r28 := local_3;
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    goto inline$System.Object.GetType$4$Entry;

  inline$System.Object.GetType$4$Entry:
    inline$System.Object.GetType$4$this := $r28;
    call inline$System.Object.GetType$4$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$4$anon0;

  inline$System.Object.GetType$4$anon0:
    inline$System.Object.GetType$4$$result := $DynamicType(inline$System.Object.GetType$4$this);
    goto inline$System.Object.GetType$4$Return;

  inline$System.Object.GetType$4$Return:
    DynamicDispatch_Type_4 := inline$System.Object.GetType$4$$result;
    goto L_004D$1;

  L_004D$1:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_4, T$System.Collections.Generic.HashSet`1.Enumerator());
    assert false;
    return;

  anon46_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_4, T$System.Collections.Generic.HashSet`1.Enumerator());
    call System.Collections.Generic.HashSet`1.Enumerator.Dispose($r28);
    goto anon30;

  anon30:
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} $Exception == null;
    goto anon32;

  anon32:
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} $Exception == null;
    goto L_005C;

  L_005C:
    assert {:sourceFile "Program.cs"} {:sourceLine 16707566} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 20} true;
    $r26 := 9;
    assert {:sourceFile "Program.cs"} {:sourceLine 20} true;
    $r27 := sum != $r26;
    assert {:sourceFile "Program.cs"} {:sourceLine 20} true;
    assert $r27;
    assert {:sourceFile "Program.cs"} {:sourceLine 20} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 21} true;
    return;

  anon48_Then:
    assume {:partition} $Exception != null;
    return;

  anon47_Then:
    assume {:partition} $Exception != null;
    return;

  anon45_Then:
    assume {:partition} $r16 <==> true;
    goto L_002D;

  L_002D:
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    $r17 := local_3;
    assert {:sourceFile "Program.cs"} {:sourceLine 15} true;
    call $temp_var_7 := System.Collections.Generic.HashSet`1.Enumerator.get_Current($r17);
    x := Union2Int($temp_var_7);
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} $Exception == null;
    goto anon23;

  anon23:
    assert {:sourceFile "Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "Program.cs"} {:sourceLine 17} true;
    sum := sum + x;
    assert {:sourceFile "Program.cs"} {:sourceLine 18} true;
    product := product * x;
    assert {:sourceFile "Program.cs"} {:sourceLine 19} true;
    goto L_0042;

  anon43_Then:
    assume {:partition} $Exception != null;
    goto L_004D;

  anon44_Then:
    assume {:partition} $Exception != null;
    goto L_004D;

  anon42_Then:
    assume {:partition} $Exception != null;
    return;

  anon40_Then:
    assume {:partition} $Exception != null;
    return;

  anon38_Then:
    assume {:partition} $Exception != null;
    return;

  anon36_Then:
    assume {:partition} $Exception != null;
    return;

  anon34_Then:
    assume {:partition} $Exception != null;
    return;
}



procedure System.Collections.Generic.HashSet`1.GetEnumerator(this: Ref) returns (r: Ref);
  modifies $Alloc, $Heap, hashsets, hashsetSize;



implementation System.Collections.Generic.HashSet`1.GetEnumerator(this: Ref) returns (r: Ref)
{
  var $r1: Ref;
  var local_0: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    call inline$Alloc$0$x := havocNonDetAvh.Ref();
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $r1 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    assume $DynamicType($r1) == T$System.Collections.Generic.HashSet`1.Enumerator();
    assume $TypeConstructor($DynamicType($r1)) == T$System.Collections.Generic.HashSet`1.Enumerator;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    call System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$($r1, this);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    local_0 := $As($r1, T$System.Object());
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    goto L_000F;

  L_000F:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 100} true;
    r := local_0;
    return;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$(this: Ref, h: Ref);
  modifies $Heap, $Alloc, hashsets, hashsetSize;



implementation System.Collections.Generic.HashSet`1.Enumerator.#ctor$System.Collections.Generic.HashSet$`0$(this: Ref, h: Ref)
{
  var $r3: int;
  var $r6: Ref;
  var $r7: Ref;
  var $r9: Ref;
  var DynamicDispatch_Type_0: Ref;
  var inline$System.Object.GetType$0$this: Ref;
  var inline$System.Object.GetType$0$$result: Ref;

  anon0:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 75} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 76} true;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.parent, h);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 77} true;
    $r3 := -1;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 77} true;
    assume Union2Int(Int2Union($r3)) == $r3;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.iter, Int2Union($r3));
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 78} true;
    $r6 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.parent);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 78} true;
    goto inline$System.Object.GetType$0$Entry;

  inline$System.Object.GetType$0$Entry:
    inline$System.Object.GetType$0$this := $r6;
    call inline$System.Object.GetType$0$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$0$anon0;

  inline$System.Object.GetType$0$anon0:
    inline$System.Object.GetType$0$$result := $DynamicType(inline$System.Object.GetType$0$this);
    goto inline$System.Object.GetType$0$Return;

  inline$System.Object.GetType$0$Return:
    DynamicDispatch_Type_0 := inline$System.Object.GetType$0$$result;
    goto anon0$1;

  anon0$1:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon6_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    call $r7 := System.Collections.Generic.HashSet`1.New($r6);
    goto anon3;

  anon3:
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} $Exception == null;
    goto anon5;

  anon5:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 78} true;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentSet, $r7);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 79} true;
    $r9 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 79} true;
    assume Union2Int(Int2Union(0)) == 0;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem, Int2Union(0));
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 80} true;
    return;

  anon7_Then:
    assume {:partition} $Exception != null;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.MoveNext(this: Ref) returns (r: bool);
  modifies $Heap, hashsets, hashsetSize;



implementation System.Collections.Generic.HashSet`1.Enumerator.MoveNext(this: Ref) returns (r: bool)
{
  var $r2: int;
  var $r3: int;
  var $r4: int;
  var $r6: int;
  var $r8: Ref;
  var $r9: int;
  var $r10: bool;
  var $r11: bool;
  var local_0: bool;
  var local_1: bool;
  var $r16: Ref;
  var $r17: Ref;
  var $r19: Ref;
  var $r21: Ref;
  var $r22: bool;
  var $r27: Ref;
  var $r29: Ref;
  var $r30: bool;
  var $r31: bool;
  var $r25: bool;
  var $r33: Ref;
  var $r35: Ref;
  var $r36: bool;
  var DynamicDispatch_Type_0: Ref;
  var DynamicDispatch_Type_1: Ref;
  var DynamicDispatch_Type_2: Ref;
  var DynamicDispatch_Type_3: Ref;
  var DynamicDispatch_Type_4: Ref;
  var inline$System.Object.GetType$0$this: Ref;
  var inline$System.Object.GetType$0$$result: Ref;
  var inline$System.Object.GetType$1$this: Ref;
  var inline$System.Object.GetType$1$$result: Ref;
  var inline$System.Object.GetType$2$this: Ref;
  var inline$System.Object.GetType$2$$result: Ref;
  var inline$System.Object.GetType$3$this: Ref;
  var inline$System.Object.GetType$3$$result: Ref;
  var inline$System.Object.GetType$4$this: Ref;
  var inline$System.Object.GetType$4$$result: Ref;

  anon0:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 81} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 82} true;
    $r2 := Union2Int(Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.iter));
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 82} true;
    $r3 := 1;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 82} true;
    $r4 := $r2 + $r3;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 82} true;
    assume Union2Int(Int2Union($r4)) == $r4;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.iter, Int2Union($r4));
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    $r6 := Union2Int(Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.iter));
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    $r8 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.parent);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    goto inline$System.Object.GetType$0$Entry;

  inline$System.Object.GetType$0$Entry:
    inline$System.Object.GetType$0$this := $r8;
    call inline$System.Object.GetType$0$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$0$anon0;

  inline$System.Object.GetType$0$anon0:
    inline$System.Object.GetType$0$$result := $DynamicType(inline$System.Object.GetType$0$this);
    goto inline$System.Object.GetType$0$Return;

  inline$System.Object.GetType$0$Return:
    DynamicDispatch_Type_0 := inline$System.Object.GetType$0$$result;
    goto anon0$1;

  anon0$1:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon30_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_0, T$System.Collections.Generic.HashSet`1());
    call $r9 := System.Collections.Generic.HashSet`1.get_Count($r8);
    goto anon3;

  anon3:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} $Exception == null;
    goto anon5;

  anon5:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    $r10 := $r6 < $r9;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    $r11 := false;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 83} true;
    local_0 := $r10 <==> $r11;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 16707566} true;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} local_0 <==> true;
    goto anon7;

  anon7:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 84} true;
    local_1 := false;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 84} true;
    goto L_0084;

  L_0084:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 88} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 89} true;
    r := local_1;
    return;

  anon32_Then:
    assume {:partition} local_0 <==> false;
    goto L_002D;

  L_002D:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 84} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 85} true;
    $r16 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.parent);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 85} true;
    goto inline$System.Object.GetType$1$Entry;

  inline$System.Object.GetType$1$Entry:
    inline$System.Object.GetType$1$this := $r16;
    call inline$System.Object.GetType$1$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$1$anon0;

  inline$System.Object.GetType$1$anon0:
    inline$System.Object.GetType$1$$result := $DynamicType(inline$System.Object.GetType$1$this);
    goto inline$System.Object.GetType$1$Return;

  inline$System.Object.GetType$1$Return:
    DynamicDispatch_Type_1 := inline$System.Object.GetType$1$$result;
    goto L_002D$1;

  L_002D$1:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_1, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon33_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_1, T$System.Collections.Generic.HashSet`1());
    call $r17 := System.Collections.Generic.HashSet`1.Random($r16);
    goto anon10;

  anon10:
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} $Exception == null;
    goto anon12;

  anon12:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 85} true;
    $Heap := Write($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem, $r17);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r19 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.parent);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r21 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    goto inline$System.Object.GetType$2$Entry;

  inline$System.Object.GetType$2$Entry:
    inline$System.Object.GetType$2$this := $r19;
    call inline$System.Object.GetType$2$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$2$anon0;

  inline$System.Object.GetType$2$anon0:
    inline$System.Object.GetType$2$$result := $DynamicType(inline$System.Object.GetType$2$this);
    goto inline$System.Object.GetType$2$Return;

  inline$System.Object.GetType$2$Return:
    DynamicDispatch_Type_2 := inline$System.Object.GetType$2$$result;
    goto anon12$1;

  anon12$1:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_2, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon35_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_2, T$System.Collections.Generic.HashSet`1());
    call $r22 := System.Collections.Generic.HashSet`1.Contains$`0($r19, $r21);
    goto anon15;

  anon15:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} $Exception == null;
    goto anon17;

  anon17:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} $r22 <==> true;
    goto anon19;

  anon19:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r27 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentSet);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r29 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    goto inline$System.Object.GetType$3$Entry;

  inline$System.Object.GetType$3$Entry:
    inline$System.Object.GetType$3$this := $r27;
    call inline$System.Object.GetType$3$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$3$anon0;

  inline$System.Object.GetType$3$anon0:
    inline$System.Object.GetType$3$$result := $DynamicType(inline$System.Object.GetType$3$this);
    goto inline$System.Object.GetType$3$Return;

  inline$System.Object.GetType$3$Return:
    DynamicDispatch_Type_3 := inline$System.Object.GetType$3$$result;
    goto anon19$1;

  anon19$1:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_3, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon38_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_3, T$System.Collections.Generic.HashSet`1());
    call $r30 := System.Collections.Generic.HashSet`1.Contains$`0($r27, $r29);
    goto anon22;

  anon22:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} $Exception == null;
    goto anon24;

  anon24:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r31 := false;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r25 := $r30 <==> $r31;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    goto L_0068;

  L_0068:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    assume $r25;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 87} true;
    $r33 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentSet);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 87} true;
    $r35 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 87} true;
    goto inline$System.Object.GetType$4$Entry;

  inline$System.Object.GetType$4$Entry:
    inline$System.Object.GetType$4$this := $r33;
    call inline$System.Object.GetType$4$$result := havocNonDetAvh.Ref();
    goto inline$System.Object.GetType$4$anon0;

  inline$System.Object.GetType$4$anon0:
    inline$System.Object.GetType$4$$result := $DynamicType(inline$System.Object.GetType$4$this);
    goto inline$System.Object.GetType$4$Return;

  inline$System.Object.GetType$4$Return:
    DynamicDispatch_Type_4 := inline$System.Object.GetType$4$$result;
    goto L_0068$1;

  L_0068$1:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} !$Subtype(DynamicDispatch_Type_4, T$System.Collections.Generic.HashSet`1());
    assert false;
    return;

  anon40_Then:
    assume {:partition} $Subtype(DynamicDispatch_Type_4, T$System.Collections.Generic.HashSet`1());
    call $r36 := System.Collections.Generic.HashSet`1.Add$`0($r33, $r35);
    goto anon27;

  anon27:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} $Exception == null;
    goto anon29;

  anon29:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 88} true;
    local_1 := true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 88} true;
    goto L_0084;

  anon41_Then:
    assume {:partition} $Exception != null;
    return;

  anon39_Then:
    assume {:partition} $Exception != null;
    return;

  anon37_Then:
    assume {:partition} $r22 <==> false;
    goto L_0067;

  L_0067:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 86} true;
    $r25 := false;
    goto L_0068;

  anon36_Then:
    assume {:partition} $Exception != null;
    return;

  anon34_Then:
    assume {:partition} $Exception != null;
    return;

  anon31_Then:
    assume {:partition} $Exception != null;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.get_Current(this: Ref) returns (r: Ref);



implementation System.Collections.Generic.HashSet`1.Enumerator.get_Current(this: Ref) returns (r: Ref)
{
  var local_0: Ref;

  anon0:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 90} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 90} true;
    local_0 := Read($Heap, this, F$System.Collections.Generic.HashSet`1.Enumerator.currentElem);
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 90} true;
    goto L_000A;

  L_000A:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 90} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 90} true;
    r := local_0;
    return;
}



procedure System.Collections.Generic.HashSet`1.Enumerator.Dispose(this: Ref);



implementation System.Collections.Generic.HashSet`1.Enumerator.Dispose(this: Ref)
{

  anon0:
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 91} true;
    assert {:sourceFile "CollectionStubs.cs"} {:sourceLine 91} true;
    return;
}



function T$System.ValueType() : Ref;

const unique T$System.ValueType: int;

axiom $TypeConstructor(T$System.ValueType()) == T$System.ValueType;

axiom (forall $T: Ref :: { $Subtype(T$System.ValueType(), $T) } $Subtype(T$System.ValueType(), $T) <==> T$System.ValueType() == $T || $Subtype(T$System.Object(), $T));

procedure {:extern} System.IDisposable.Dispose(this: Ref);



procedure {:extern} System.Object.#ctor(this: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Random(this: Ref) returns ($result: Ref);



const unique F$System.Collections.Generic.List`1.Enumerator.parent: Field;

const unique F$System.Collections.Generic.List`1.Enumerator.iter: Field;

const unique F$System.Collections.Generic.HashSet`1.Enumerator.parent: Field;

const unique F$System.Collections.Generic.HashSet`1.Enumerator.iter: Field;

const unique F$System.Collections.Generic.HashSet`1.Enumerator.currentSet: Field;

const unique F$System.Collections.Generic.HashSet`1.Enumerator.currentElem: Field;

procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;

procedure havocNonDetAvh.Ref() returns (o: Ref);



procedure {:allocator "full"} {:AngelicUnknown} unknown_Ref() returns (r: Ref);



function {:ReachableStates} MustReach(x: bool) : bool;

const __block_call_PoirotMain.Main: bool;

procedure {:entrypoint} CorralMain();
  modifies $Exception, $ExceptionType, $GetMeHereTracker, $Alloc, hashsets, hashsetSize, $Heap;



implementation CorralMain()
{

  CorralMainStart:
    assume true;
    call {:ConcretizeConstantName "$Exception"} $Exception := unknown_Ref();
    call {:ConcretizeConstantName "$ExceptionType"} $ExceptionType := unknown_Ref();
    goto L_BAF_0;

  L_BAF_0:
    assume __block_call_PoirotMain.Main;
    assume MustReach(true);
    call {:AvhEntryPoint} PoirotMain.Main();
    return;
}



implementation System.Collections.Generic.HashSet`1.Random(this: Ref) returns ($result: Ref)
{

  L_BAF_1:
    call {:ConcretizeConstantName "$result"} $result := unknown_Ref();
    return;
}



implementation havocNonDetAvh.Ref() returns (o: Ref)
{

  L_BAF_2:
    call {:ConcretizeConstantName "o"} o := unknown_Ref();
    return;
}


