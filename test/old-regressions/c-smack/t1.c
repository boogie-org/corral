#include <stdio.h>
#include <smack.h>

int* incr(int* a) ;

int* A[10];

void func(int* x) {
	int* z = incr(x);
	int* a = A[*z];
	*a = 0;
}