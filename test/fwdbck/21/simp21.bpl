procedure main()
{
  var x: int;
  x := 1;
  if(*) {
    assume x == 2;
    call foo();
  } else {
    call foo();
  }
}

procedure foo()
{
  assert false;
}

