#include "smack.h"

struct foo
{
  int x;
  int *y;
} bar;

int main()
{
  *(bar.y) = 1;
  assert(**&(bar.y) == 1);
}
