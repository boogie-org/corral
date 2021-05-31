var M: [int] int;

function {:aliasingQuery} f1(a:int, b:int): bool;
function {:aliasingQuery "transitive"} f2(a:int, b:int): bool;
procedure {:allocator } malloc() returns (x:int);

procedure main() 
{
   var a, b, c, t1, t2, t3: int; 

   call a := malloc();
   call b := malloc();

   M[a] := b;

   assume f1(a, b);
   assume f2(a, b);
}
