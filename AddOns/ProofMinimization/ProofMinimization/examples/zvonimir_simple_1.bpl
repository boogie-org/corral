const {:existential true} LP1: bool;
const {:existential true} LP2: bool;
const {:existential true} LP3: bool;
const {:existential true} LP4: bool;
const {:existential true} LP5: bool;
const {:existential true} LP6: bool;
const {:existential true} LP7: bool;
const {:existential true} LP8: bool;
var {:scalar} glb: int;

procedure loop_me_baby(s: int, it: int) returns(l: int);
	ensures LP1 ==> ((it <= 0) ==> l == s); 
        ensures LP2 ==> ((it > 0) ==> l == (s + it));
	ensures LP3 ==> l >= s && l >= s;
	ensures LP4 ==> !(l == 0);
	ensures LP5 ==> (it <= 0 && it == 0) && l == s;
	ensures LP6 ==> (it <= 0 || (l == s && (l > s || l  < -1))) && (it > 0 || l > s);

implementation loop_me_baby(s: int, it: int) returns(l: int)
{
   var s1: int;
   var it1: int;
   
   if (it <= 0) {
        l := s;
	return;
   }

   s1 := s + 1;
   it1 := it - 1;

   call l := loop_me_baby(s1, it1);
   return; 
}


procedure {:nohoudini} {:origName "main"} {:osmodel} main() returns (c: int);
	modifies glb;

implementation {:origName "main"} {:osmodel} main() returns (c: int)
{
   glb := 100;
   call c := loop_me_baby(1, 3);
   c := c + 1;
   assume c != 5;
   return;
}



procedure fakeMain() returns (r: int);
	modifies glb;

implementation {:entrypoint} fakeMain() returns (r: int)
{
   call r := main();
   return;
}

