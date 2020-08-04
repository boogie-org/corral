const NULL: int;

procedure foo({:pointer} x: int)
{
  var ax: int;

  ax := x;
  if(*) { ax := NULL; }
  assume {:nonnull} ax != NULL; 
}


