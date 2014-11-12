procedure {:allocator} unknown_half(a:int) returns (b:int);
procedure {:allocator "full"} unknown(a:int) returns (b:int);
const NULL: int;
axiom NULL == 0; 

var {:scalar} gs:int; //scalar global
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
    assert x != NULL; 
    m[x] := 4; //DEFINITE BUG
}
//external call
procedure FooBar() {
    var x, w, z:int;
    call z := Lib1(); 
    assert z != NULL; 
    m[z] := NULL; 
    call x := Lib2(); 
    assert x != NULL; 
    w := m[x];
    assert w != NULL;
    n[w] := 4;
}
// entry point 
procedure Foo(x:int, y:int) {
    call Bar(x);     //block + relax
    call Baz(NULL);  //internal bug
    call FooBar();   //external calls
}
//library
procedure Lib1() returns (r:int);
procedure Lib2() returns (r:int);
