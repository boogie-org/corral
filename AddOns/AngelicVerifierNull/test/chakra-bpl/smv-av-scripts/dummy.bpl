procedure ThisIsAnUpcallArg(x: int);
procedure TemplateSpecializedProc(x: int, y:int);
procedure IsJSArrayType(x: int, y:int, z:int);
procedure $alloc(x:int); 

procedure Foo(a:int) 
{
  call ThisIsAnUpcallArg(1);
  call TemplateSpecializedProc(2, 3);
  call IsJSArrayType(4, 5, 6);
  call $alloc(7);
}