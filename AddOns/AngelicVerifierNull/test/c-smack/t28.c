#include <stdlib.h>

//void bar(int* x, int* y);

void foo(int* x, int* y)
{
  free(x);
  free(y);
  //bar(x, y);
}
