#include <stdio.h>

void foo()
{
  FILE *x = fopen("xyz", "r");
  FILE *y = fopen("abc", "r");
  if (x)
    fclose(x);
  if (y)
    fclose(y);
}
