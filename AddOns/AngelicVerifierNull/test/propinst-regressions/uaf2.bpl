//Testing the following ideas
//  presence of stubs with different arity

procedure Free({:pointer} p : int);
procedure stub1({:pointer} x:int);
procedure stub3({:pointer} x:int, {:pointer} y:int, z:int);



var M : [int]int;

procedure foo({:pointer} p : int)
{
    call Free(p);
    assume {:nonnull} p != NULL;
    M[p] := 1;
    call bar(p, p +1, 22);
}

procedure bar({:pointer} x:int, {:pointer} y:int, z:int)
{
     M[x] := y + z;
     call stub1(x);
     call stub3(x, y, z);
}



const NULL : int;
