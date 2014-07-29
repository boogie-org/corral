procedure {:entrypoint} main()
{
  var x: int;
  x := 0;
  while(x < 10) {
    x := x + 1;
  }
  assert false;
}
