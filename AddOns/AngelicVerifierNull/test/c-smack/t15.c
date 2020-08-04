#include "smack.h"

struct foo
{
  int x;
  int *y;
};

struct foo bar(int x, int *y);

int main()
{
  struct foo baz;  
  baz = bar(0, (int*)malloc(sizeof(int)));
  *(baz.y) = 1;
}
