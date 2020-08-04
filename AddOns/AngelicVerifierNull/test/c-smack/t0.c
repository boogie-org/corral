#include <stdio.h>
#include <smack.h>

int incr(int* a) {
	*a = *a + 1;
	return *a;
}
