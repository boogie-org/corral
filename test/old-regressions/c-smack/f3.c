#include <stdio.h>

void foo()
{
  FILE *x = fopen("xyz", "r");
  FILE *y = fopen("abc", "r");
  fclose(x);
  fclose(y);
}
