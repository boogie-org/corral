var x,y,z: int;

procedure top()
modifies x;
{
   x := x + 1;
}

procedure foo()
modifies x,y;
{
   y := 1;
   call top();
}

procedure bar()
modifies x,z;
{
   z := 1;
   call top();
}


const N: int;
axiom 0 <= N;
procedure {:entrypoint} main() returns (result: int)
modifies x;
{
   var count: int;
   x := 0;
   count := 0;
   while (count < N) 
     invariant count <= N;
   {
     count := count + 1;
     result := count;
     /*if (count == 1) { 
       call foo();
     }
     else if (count == 2) {
       call bar();
     }
     else if (count == 3) { 
       call foo();
     }
     else if (count == 4) {
       call bar();
     }
     else if (count == 5) { 
       call foo();
     }
     else if (count == 6) {
       call bar();
     }
     else if (count == 7) { 
       call foo();
     }
     else if (count == 8) {
       call bar();
     }
     else if (count == 9) { 
       call foo();
     }
     else if (count == 10) {
       call bar();
     }*/
     
     if (result <= 2) {
       call foo();
     }
     else if (result >= 3) {
       call bar();
     }
   }
   assert(count >= N);
   assert(x == N);  
   //assert(false);
}
