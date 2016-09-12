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

   //M1[x] := y;
   M1 := M1[x := y];


   assume f(M1[x],y);
}
