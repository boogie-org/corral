var x,y,z: int;


// ****************** Bubble Sort function *********************

// Bubble Sort, where the specification says the output is a permutation of
// the input.

// Introduce a constant 'N' and postulate that it is non-negative
const N: int;
axiom 0 <= N;

// Declare a map from integers to integers.  In the procedure below, 'a' will be
// treated as an array of 'N' elements, indexed from 0 to less than 'N'.
var a: [int]int;

// This procedure implements Bubble Sort.  One of the postconditions says that,
// in the final state of the procedure, the array is sorted.  The other
// postconditions say that the final array is a permutation of the initial
// array.  To write that part of the specification, the procedure returns that
// permutation mapping.  That is, out-parameter 'perm' injectively maps the
// numbers [0..N) to [0..N), as stated by the second and third postconditions.
// The final postcondition says that 'perm' describes how the elements in
// 'a' moved:  what is now at index 'i' used to be at index 'perm[i]'.
// Note, the specification says nothing about the elements of 'a' outside the
// range [0..N).  Moreover, Boogie does not prove that the program will terminate.

procedure BubbleSort() returns (perm: [int]int)
  modifies a;
  // array is sorted
  ensures (forall i, j: int :: 0 <= i && i <= j && j < N ==> a[i] <= a[j]);
  // perm is a permutation
  ensures (forall i: int :: 0 <= i && i < N ==> 0 <= perm[i] && perm[i] < N);
  ensures (forall i, j: int :: 0 <= i && i < j && j < N ==> perm[i] != perm[j]);
  // the final array is that permutation of the input array
  ensures (forall i: int :: 0 <= i && i < N ==> a[i] == old(a)[perm[i]]);
{
  var n, p, tmp: int;

  n := 0;
  while (n < N)
    invariant n <= N;
    invariant (forall i: int :: 0 <= i && i < n ==> perm[i] == i);
  {
    perm[n] := n;
    n := n + 1;
  }

  while (true)
    invariant 0 <= n && n <= N;
    // array is sorted from n onwards
    invariant (forall i, k: int :: n <= i && i < N && 0 <= k && k < i ==> a[k] <= a[i]);
    // perm is a permutation
    invariant (forall i: int :: 0 <= i && i < N ==> 0 <= perm[i] && perm[i] < N);
    invariant (forall i, j: int :: 0 <= i && i < j && j < N ==> perm[i] != perm[j]);
    // the current array is that permutation of the input array
    invariant (forall i: int :: 0 <= i && i < N ==> a[i] == old(a)[perm[i]]);
  {
    n := n - 1;
    if (n < 0) {
      break;
    }

    p := 0;
    while (p < n)
      invariant p <= n;
      // array is sorted from n+1 onwards
      invariant (forall i, k: int :: n+1 <= i && i < N && 0 <= k && k < i ==> a[k] <= a[i]);
      // perm is a permutation
      invariant (forall i: int :: 0 <= i && i < N ==> 0 <= perm[i] && perm[i] < N);
      invariant (forall i, j: int :: 0 <= i && i < j && j < N ==> perm[i] != perm[j]);
      // the current array is that permutation of the input array
      invariant (forall i: int :: 0 <= i && i < N ==> a[i] == old(a)[perm[i]]);
      // a[p] is at least as large as any of the first p elements
      invariant (forall k: int :: 0 <= k && k < p ==> a[k] <= a[p]);
    {
      if (a[p+1] < a[p]) {
        tmp := a[p];  a[p] := a[p+1];  a[p+1] := tmp;
        tmp := perm[p];  perm[p] := perm[p+1];  perm[p+1] := tmp;
      }

      p := p + 1;
    }
  }
}



// ****************** Find function *********************
// Declare a constant 'K' and a function 'f' and postulate that 'K' is
// in the image of 'f'
const K: int;
function f(int) returns (int);
axiom (exists k: int :: f(k) == K);

// This procedure will find a domain value 'k' that 'f' maps to 'K'.  It will
// do that by recursively enlarging the range where no such domain value exists.
// Note, Boogie does not prove termination.
procedure Find(a: int, b: int) returns (k: int)
  requires a <= b;
  requires (forall j: int :: a < j && j < b ==> f(j) != K);
  ensures f(k) == K;
{
  goto A, B, C;  // nondeterministically choose one of these 3 goto targets

  A:
    assume f(a) == K;  // assume we get here only if 'f' maps 'a' to 'K'
    k := a;
    return;

  B:
    assume f(b) == K;  // assume we get here only if 'f' maps 'b' to 'K'
    k := b;
    return;

  C:
    assume f(a) != K && f(b) != K;  // neither of the two above
    call k := Find(a-1, b+1);
    return;
}
// This procedure shows one way to call 'Find'
procedure main_find() returns (k: int)
  ensures f(k) == K;
{
  call k := Find(0, 0);
}



// ****************** McCarthy-91 function *********************
procedure F(n: int) returns (r: int)
  ensures 100 < n ==> r == n - 10;  // This postcondition is easy to check by hand
  ensures n <= 100 ==> r == 91;     // Do you believe this one is true?
{
  if (100 < n) {
    r := n - 10;
  } else {
    call r := F(n + 11);
    call r := F(r);
  }
}

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

var count: int;
procedure {:entrypoint} main() returns (result: int)
modifies x;
{
   var t: int;    
   var g: int;
   var sortarray: [int]int;
   x := 0;
   if (count == 0) { 
	   call foo();
   }
   if (count == 1) { 
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
	   //call sortarray:= BubbleSort();
	   call x:= F(t);
   }
   else if (count == 10) {
	   call g:= main_find();
   }
   else if (count > 10) {
	   call x:= F(t);
   }
     
   assert(x >= 0);  
   //assert(false);
}
