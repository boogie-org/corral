#include "smack.h"
#include <stdlib.h>

struct baz
{
  struct baz* self;
};

struct baz* bar();

int zero() {return 0;}

void foo(struct baz* b)
{
  struct baz *a = (struct baz*)malloc(sizeof(struct baz));

  a->self = a;

  if (zero())
    b = a;

  assert(b->self != NULL);
}

