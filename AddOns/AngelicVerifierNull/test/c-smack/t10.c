#include "smack.h"

struct foo
{
  int x;
  int *y;
};

int main()
{
  struct foo bar;
  *(bar.y) = 1;
  assert(**&(bar.y) == 1);
}
