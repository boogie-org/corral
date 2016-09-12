#include "smack.h"
#include <stdlib.h>

void foo(int **y);

int main()
{
  int **x = (int **)malloc(sizeof(int **));
  *x = NULL;
  foo(x);
  **x = 1;
}
