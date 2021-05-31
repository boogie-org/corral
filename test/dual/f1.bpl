var x: int;
const {:existential true} b1: bool;
const {:existential true} b2: bool;
const {:existential true} b3: bool;

procedure foo()
  ensures (b1 && x == 0) || (b2 && x == 1) || (b3 && x == 2);
  modifies x;
{
   havoc x;
}
