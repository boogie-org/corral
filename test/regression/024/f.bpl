var x: int;

procedure {:entrypoint} A() {
   x := 0;
   call B();
   assert (x == 0);
}

procedure B();
modifies x;

