#include <stdlib.h>

void bar(int* x);

void foo(int* x)
{
  free(x);  
  x = NULL;
  bar(x);
}
