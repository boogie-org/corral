var g: int;

procedure {:entrypoint} main()
  modifies g;
{
  g := 0;
  assert |{ A: return g == 0; }|;
}

