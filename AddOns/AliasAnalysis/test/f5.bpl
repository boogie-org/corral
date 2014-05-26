var M: [int] int;

function {:aliasingQuery} f(a:int, b:int): bool;
procedure {:allocator } malloc() returns (x:int);

procedure main() 
{
   var a, b, t1, t2, t3: int; 

   call a := malloc();
   call b := malloc();
   t1 := b;
   M[t1] := a;
   t2 := b;
   t3 := M[t2];

   assume f(t3, a);
}
