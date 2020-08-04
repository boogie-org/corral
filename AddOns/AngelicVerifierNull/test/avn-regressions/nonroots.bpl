//Only report from roots
//Alarm when analyzing from non-root

const NULL: int;

//Only this fails with /onlyUseRootsAsEntryPoints
procedure Root(c:int) {
    var a:int;

     a := NULL;
     assert a != NULL;
  
     call Foo(a);

}

procedure Foo(a:int) {
    var b:int;
    b := NULL;  
    assert b != NULL; 
}



procedure {:allocator} malloc(a:int) returns (b:int);
procedure {:allocator "full"} malloc_full(a:int) returns (b:int);
