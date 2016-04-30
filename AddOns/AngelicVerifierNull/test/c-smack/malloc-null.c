#include "smack.h"
#include <stdlib.h>

void* nondet_malloc(size_t size)
{
  if(__VERIFIER_nondet_bool())
    return malloc(size); 
  else
    return NULL;
}

int main()
{
  int *x = (int *)nondet_malloc(sizeof(int));
  int *y = (int *)nondet_malloc(sizeof(int));
  *x = 1;
  *y = 2;
  assert(x != y);
}
