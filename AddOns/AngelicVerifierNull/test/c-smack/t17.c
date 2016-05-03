#include "smack.h"
#include <stdlib.h>

int *foo();
int *bar();

int main()
{
  int *x = foo();
  int *y = bar();

  *x = 0;
  assert(*y != 0);
}
