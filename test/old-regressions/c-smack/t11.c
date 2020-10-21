#include "smack.h"

int **head;

void foo();

int main()
{
  //**head = 1;
  foo();
  assert(**head == 1);
}
