procedure {:entrypoint} main() {
  var i, j, k: int;
  
  i, j, k := 0, 0, 0;

  call i, j := loop1(i, j);


  call k := loop2(k);
  
  assert false;
}

procedure loop1(in_i: int, in_j: int) returns (i:int, j: int) 
  ensures in_i == in_j ==> i == j;
{
  i := in_i;
  j := in_j;

  if(i < 10) {
     i, j := i+1, j+1;
     call i, j := loop1(i, j);
  }
}

procedure loop2(in_k: int) returns (k: int)
{
   k := in_k;
   if(k < 1) {
     k := k + 1;
     call k := loop2(k);
   }
}
