var x: int;
var y: int;

procedure {:entrypoint} main()
{
   havoc x;
   assert x == 2;
   assert x == 2;
}
