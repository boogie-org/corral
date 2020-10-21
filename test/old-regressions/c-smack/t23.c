#include "smack.h" 
#include <stdlib.h>
int y;
void foo()
{
  int *x = (int*)malloc(sizeof(int));
  int z;

  if (y)
    x = NULL;
  
  if (z > 0) 
    z = 1;
  else
    z = 0;


  *x = 2;
}
