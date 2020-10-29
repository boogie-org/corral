var M1: [int] int;
var M2: [int] int;
var g: int;

function {:aliasingQuery} f(a:int, b:int): bool;
procedure {:allocator} malloc() returns (x:int);

procedure main() 
{
   var x, y, z, w, t : int;   

   call t := malloc();
   x := t;
   call t := malloc();
   y := t;
   call t := malloc();
   z := t;

   //y := x; 
   //M1[x] := z;
   //w := M1[y];
   //assume f(w,z);
   assume f(x,y);
   //g := M1[x];
   //M1[x] := g;
}
