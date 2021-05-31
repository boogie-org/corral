#include <stdlib.h>
#include <smack.h>

int* foo(int* a) {
	*a = 1;
	return a;
}

int main() {
	int * x = NULL;
	foo(x);
	return 0;
}