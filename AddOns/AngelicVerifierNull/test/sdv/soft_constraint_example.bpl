const {:allocated} NULL: int;

axiom NULL == 0;

var alloc: int;

var {:scalar} global: int;

procedure {:allocator} __HAVOC_malloc(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc);
  free ensures alloc >= old(alloc) + size;



procedure {:allocator "full"} __HAVOC_malloc_full(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc);
  free ensures alloc >= old(alloc) + size;

procedure set_global()
{
	global := 2;
}

procedure foo()
{
	call set_global();
	assume {:SoftConstraint 1} global == 1;
	assume {:SoftConstraint 2} global == 2;
	assert global != 2;
}