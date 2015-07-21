#include <stdio.h>
#include <stdlib.h>
#include <smack.h>

struct str {
	int x ;
	int * y ;
};

struct str* foo(int b, int* a) {
	if (b == 0) {
		assert (a != 0);
		return NULL;
	}
	struct str* s = malloc (sizeof(struct str));
	(*s).x = b ;
	(*s).y = a ;
	return s;
}

void func(int* w) {
	assert (w != 0);
	struct str * s = foo(*w, w);
	assert (s != 0);
	assert ((*s).y != 0);
}

int main() {
	int *m, *n, *p;
	m = NULL;
	n = malloc(sizeof(int));
	p = malloc(sizeof(int));
	*n = 0; *p = 1;
	func(m);
	func(n);
	func(p);
	return 0; 
}