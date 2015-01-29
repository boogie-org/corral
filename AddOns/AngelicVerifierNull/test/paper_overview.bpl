procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
const NULL: int;
axiom NULL == 0; 

var {:scalar} gs:int; //scalar global
var g:int;            //global
var m,n:[int]int;       //field m

//inconsistency
procedure Bar(x:int) {
    if (x != NULL) { gs := 1; } 
    else { gs := 2; }
    assert x != NULL;
    m[x] := 5;  //BUG due to RELAX
}
//internal bug
procedure Baz(x:int) {
    g := NULL; 
    assert g != NULL; 
    m[g] := 4; //DEFINITE BUG
}
//external call
procedure FooBar(x:int) {
    var z:int;
    call z := Lib(); 
    assert z != NULL; 
    m[z] := 4; 
}
//aliasing
procedure Alias(x:int,y:int) {
     var w:int;
     assert x != NULL; 
     m[x] := NULL; 
     assert g != NULL; 
     w := m[g]; 
     assert w != NULL; 
     n[w] := 5;
}
//library
procedure Lib() returns (r:int);
// entry point 
procedure Foo(x:int, y:int) {
    call Bar(x);     //block + relax
    call Baz(y);     //internal bug
    call FooBar(y);  //external call
    call Alias(x,y); //aliasing
}
