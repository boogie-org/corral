#include "smack.h"

int **x ;

int foo();

int* bar(const char *fmt, ...);

int zero() {return 0;}

int func(int c)
{
  int *z = bar("xyz", "zyx");
  //c = foo();

  if (zero())
    x = (int**)z;

  *z = c;
 
  **x = 1; 

  return 0;
}
