#include "smack.h"

void foo(int *x)
{
  int *y = (int *)malloc(sizeof(int));
  assert(x != y);
}
