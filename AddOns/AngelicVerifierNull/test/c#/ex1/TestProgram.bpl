// Copyright (c) 2010, Microsoft Corp.
// Bytecode Translator prelude

procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{
    $result := $DynamicType(this);
}

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
}



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in == b$in;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in != b$in;
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

procedure cMain.DoWork($this: Ref);



implementation cMain.DoWork($this: Ref)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    local_0_int := F$cMain.s;
    local_0_int := local_0_int + 1;
    F$cMain.s := local_0_int;
}






procedure cMain.#ctor($this: Ref);


procedure {:entrypoint} cMain.Main() {
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    F$cMain.s := 0;
    call $tmp0 := Alloc();
    call cMain.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$cMain();
    assume $TypeConstructor($DynamicType($tmp0)) == T$cMain;
    local_0_Ref := $tmp0;
    call $tmp1 := Alloc();
    call cMain.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$cMain();
    assume $TypeConstructor($DynamicType($tmp1)) == T$cMain;
    local_1_Ref := $tmp1;
    call cMain.DoWork(local_0_Ref);
    call cMain.DoWork(local_1_Ref);
    call u_int := unknown_int();
    assert u_int == F$cMain.s ;
}

procedure {:AngelicUnknown} unknown_int() returns (b: int);

var u_int: int ;



procedure {:extern} System.Object.#ctor($this: Ref);



implementation cMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 2} true;
    call System.Object.#ctor($this);
}



procedure T$cMain.#cctor();



implementation T$cMain.#cctor()
{
    F$cMain.s := 0;
}



function {:extern} T$System.Object() : Ref;

const {:extern} unique T$System.Object: int;

axiom $TypeConstructor(T$System.Object()) == T$System.Object;

axiom (forall $T: Ref :: { $Subtype(T$cMain(), $T) } $Subtype(T$cMain(), $T) <==> T$cMain() == $T || $Subtype(T$System.Object(), $T));

axiom (forall $T: Ref :: { $Subtype(T$System.Object(), $T) } $Subtype(T$System.Object(), $T) <==> T$System.Object() == $T);
