//

var x : int;

procedure {:entrypoint} main() 
{
  call foo();
  call bar();
}

procedure foo()
{
  x := 1;
}

procedure bar()
{
  if (x==0)
  {
    assert false;
  }
}
