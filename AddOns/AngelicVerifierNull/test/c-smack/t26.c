#include <stdlib.h>

void bar(int* x);

void foo(int* x)
{
  free(x);  
  bar(x);
}
