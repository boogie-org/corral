#include <stdlib.h>
#include <smack.h>

int* foo(int* a) {
	a = malloc(sizeof(int));
	*a = 1;
	return a;
}

