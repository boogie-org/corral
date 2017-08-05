procedure ThisIsAnUpCallArg(x: int);
procedure TemplateSpecializedProc(x: int, y:int);
procedure IsJSArrayType(x: int, y:int, z:int);


procedure Foo(a:int) 
{
  call ThisIsAnUpCallArg(1);
  call TemplateSpecializedProc(2, 3);
  call IsJSArrayType(4, 5, 6);
}