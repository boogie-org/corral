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
	global := 1;
}

procedure {:ProgramInitialization} init()
{
	assume {:Ebasic} global < 0;
}
  
procedure foo()
{
	assert {:sourcefile ".\src\file.c"} {:sourceline 0} {:print "Return"} true;
	if (global > 0)
	{
		call set_global();
	}
	assert global == 1;
}