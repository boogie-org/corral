var x : int;

procedure change()
{
  x := 1;
}

procedure {:entrypoint} main()
{
  x := 0;
  call change();
  if(x!=0)

{
    assert false;
}}

