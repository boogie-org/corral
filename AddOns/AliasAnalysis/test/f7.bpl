var M1: [int] int;
var M2: [int] int;

function {:aliasingQuery "transitive"} f1(a:int, b:int): bool;
function {:aliasingQuery "transitive"} f2(a:int, b:int): bool;

procedure {:allocator "full"} malloc_full() returns (x:int);
procedure {:allocator} malloc() returns (x:int);

procedure main() 
{
   var a, b, c, d, t1, t2, t3: int; 

   call a := malloc_full();
   call b := malloc();

   c := M1[M2[a]];
   d := M1[M2[b]];

   assume f1(a, c);
   assume f2(b, d);
}
