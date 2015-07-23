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