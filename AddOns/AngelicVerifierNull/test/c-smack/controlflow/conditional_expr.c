#include "smack.h"
#include <stdlib.h>

struct foo
{
  int *x;
  int *p;
};

int main()
{
  struct foo* y = (struct foo*)malloc(sizeof(struct foo));
  int *z = y->x? y->p : NULL;
  *z = 1;
  return 0;
}
