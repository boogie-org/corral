#include "stdlib.h"
#include "smack.h"

typedef void (*FP)(void) ;

int *x;
int y;

void P() {
  if(y == 0) {
    //assert(x != 0); 
    *x = *x + 1;
  }
}

void Q() {
  if(y == 1) {
    //assert(x != 0);
    *x = *x + 1;
  }
}

void foo(FP f) {
  (*f)();  
}

int bar(void) {
  x = malloc(4);
  foo(&P);
  foo(&Q);
  return 0;
}

