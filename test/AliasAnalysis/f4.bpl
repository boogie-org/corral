var M1: [int] int;
const {:allocated} c1: int;
const c2: int;

function {:aliasingQuery} f(a:int, b:int): bool;
procedure {:allocator } malloc() returns (x:int);

procedure main() 
{
   var x, y, z, w, t : int;   

   call t := malloc();
   x := t;
   call y := malloc();
   M1[y] := c1;
   x := M1[y];

   assume f(x, c1);
}
