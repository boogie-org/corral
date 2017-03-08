procedure Free({:pointer} p : int);

procedure foo({:pointer} p : int)
{
    call Free(p);
    call Free(p);
}

const NULL:int;
