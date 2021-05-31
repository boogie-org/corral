#include "stdlib.h"
#include "smack.h"

void foo(int **x) {
  int t;
  int *y = (int*)malloc(4);
  *y = 0;

  //assert(*x != 0);
  t = **x;
  t = t + 1;

  if(__SMACK_nondet() == 0)
    foo((int**)y);
  if(__SMACK_nondet() == 0)
    foo(&y);
}

int main(void) {
  foo((int**)__SMACK_nondet());
  return 0;
}

