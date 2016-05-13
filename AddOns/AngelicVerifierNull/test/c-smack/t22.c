#include "smack.h"
#include <stdlib.h>

void foo(int *x)
{
  int *y;
  if (!x)
    y = NULL;
  else
    y = (int*)malloc(sizeof(int));
  *y = 1;
}
