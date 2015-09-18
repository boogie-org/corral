procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
procedure {:AngelicUnknown} unknown_map() returns (b:[int]int);

var M: [int]int;
const null: int;
axiom null == 0;

procedure {:entrypoint} main()
{
   var x: int;

   call x := unknown(1);
   M[x] := null;

   call M := unknown_map();

   assert M[x] != null;
} 
