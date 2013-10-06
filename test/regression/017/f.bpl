
var $Alloc: [Ref]bool;
type Ref;
const unique null: Ref;
var M: [Ref]int;

procedure A.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;

implementation  A.#copy_ctor(this: Ref) returns (other: Ref)
{
    //call other := Alloc();
    assume $Alloc[other] == false && other != null;
    $Alloc[other] := true;

    M[other] := M[this];
}


procedure {:entrypoint} PoirotMain.Main();

implementation PoirotMain.Main()
{
  var t0: Ref;
  var t1: Ref;

    // call t0 := Alloc();
    assume $Alloc[t0] == false && t0 != null;
    $Alloc[t0] := true;

    //call A.#default_ctor(t0);
    M[t0] := 0;

    call t1 := A.#copy_ctor(t0);

    M[t1] := M[t1] + 1;

    assert M[t0] == 0;
}


