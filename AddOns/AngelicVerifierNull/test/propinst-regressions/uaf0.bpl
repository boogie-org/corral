procedure Free({:pointer} p : int);

var M : [int]int;

procedure foo({:pointer} p : int)
{
    call Free(p);
    assume {:nonnull} p != NULL;
    M[p] := 1;
}

const NULL : int;
