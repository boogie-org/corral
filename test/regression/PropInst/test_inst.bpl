procedure {:origName "strnlen"} strnlen({:pointer} {:ref "Mem_T.VOID"} x0: int, {:scalar} x1: int) returns ({:scalar} r: int);



var irql_current: int;

implementation strnlen(x0: int, x1: int) returns (r: int)
{

  L_BAF_0:
    assert irql_current <= 1;
    return;
}


