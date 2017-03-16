//Testing the following ideas
//  NameNotMatches 

procedure Free({:pointer} x : int);
procedure RtlFreeDontMatch({:pointer} x : int);
procedure BogusFree({:pointer} x : int);



var M : [int]int;

procedure {:attr "a"} foo({:pointer} p : int)
{
    call Free(p);
    assume {:nonnull} p != NULL;
    M[p] := 1;
    call bar(p, p +1, 22);
}

procedure bar({:pointer} x:int, {:pointer} y:int, z:int)
{
     M[x] := y + z;
     call RtlFreeDontMatch(y);
     call BogusFree(y);
}

const NULL : int;

procedure CorralExtraInit(){

}