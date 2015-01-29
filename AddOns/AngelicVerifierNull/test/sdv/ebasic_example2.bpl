const {:allocated} NULL: int;

axiom NULL == 0;

var alloc: int;

var {:scalar} global1: int;

var {:scalar} global2: int;

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
	global1 := 1;
	global2 := 2;
}

procedure {:ProgramInitialization} init()
{
   assume {:Ebasic} false;
}

procedure foo()
{
	assert {:sourcefile ".\src\file.c"} {:sourceline 0} {:print "Return"} true;
	call set_global();
	if (global1 < global2)
	{
		assert false;
	}
}