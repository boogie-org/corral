#include "smack.h"
#include <stdlib.h>

void foo(int *x, int *z)
{
  int *y = (int *)malloc(sizeof(int));
  if (*y)
    *x = 1;

  if (!x) { 
    __SMACK_top_decl("function {:ReachableStates} __SMACK_MustReach(bool) returns (bool);");
    __SMACK_code("assume __SMACK_MustReach(true);");
  }
  
}
