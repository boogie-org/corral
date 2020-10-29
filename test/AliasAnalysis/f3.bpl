var M1: [int] int;
var M2: [int] int;
var g: int;


function {:aliasingQuery} f(a:int, b:int): bool;
procedure {:allocator "full"} malloc() returns (x:int);

procedure main() 
{
   var x, y, z, w, t : int;   

   call t := malloc();
   x := t;

   y := M1[x]; 
   z := M2[y];
   w := M2[y];
   assume f(w, z);
}
