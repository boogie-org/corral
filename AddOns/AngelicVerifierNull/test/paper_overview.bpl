const NULL: int;
axiom NULL == 0; 

var {:scalar} gs:int; //scalar global
var g:int;            //global
var m:[int]int;       //field m
var n:[int]int;       //field n

procedure Foo(x:int, y:int)
{
    call Bar(x);     //block + relax
    call Baz(y);     //internal bug
    call FooBar(y);  //external call
    call Alias(x,y); //aliasing
}

//no evidence
procedure Bar(x:int) 
{
    assert (x != NULL);
    m[x] := 5;  //Should show up as a BUG due to RELAX
    if (x != NULL) {
      gs := 1;
    } else {
      gs := 2;
    }
}

//internal bug
procedure Baz(x:int) {
    g := NULL; 
    assert g != NULL; 
    m[g] := 4; //DEFINITE BUG
}

//external call, unknown
procedure FooBar(x:int) {
    var z:int;
    call z := Lib(); 
    assert z != NULL; 
    m[z] := 4; 
}

//alias
procedure Alias(x:int,y:int) {
     var w:int;
     assert x != NULL; 
     m[x] := NULL; 
     assert g != NULL; 
     w := m[g]; 
     assert w != NULL; 
     n[w] := 5;
}

//non-deterministic
procedure Lib() returns (r:int);

procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
