#include <stdio.h>

void foo()
{
  FILE *x = fopen("xyz", "r");
  if (x)
    fclose(x);
  else
    return;
}
