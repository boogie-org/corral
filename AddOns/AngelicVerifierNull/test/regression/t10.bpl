
procedure {:entrypoint} main()
{
  var M: [int]int;

  M[0] := 1;
  call M := hv(M);
  assert M[1] != 0;

}

procedure  hv(M: [int]int) returns (Mp: [int]int)
{
   assume Mp[0] == M[0];
}
