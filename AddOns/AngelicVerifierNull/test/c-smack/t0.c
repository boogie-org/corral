#include <stdio.h>
#include <smack.h>

int incr(int* a) {
	assert(a != NULL);
	*a = *a + 1;
	return *a;
}