#include "smack.h"

int main()
{
  int *x = (int *)malloc(sizeof(int));
  int *y = (int *)malloc(sizeof(int));
  *x = 1;
  *y = 2;
  assert(x != y);
}
