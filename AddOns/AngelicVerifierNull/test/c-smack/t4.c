#include <stdio.h>
#include <stdlib.h>
#include <smack.h>

struct str {
	int x ;
	int * y ;
};

struct str* foo(int b, int* a) {
	if (b == 0) {
		return NULL;
	}
	struct str* s = malloc (sizeof(struct str));
	(*s).x = b ;
	(*s).y = a ;
	return s;
}

void func(int* w) {
	struct str * s = foo(*w, w);
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