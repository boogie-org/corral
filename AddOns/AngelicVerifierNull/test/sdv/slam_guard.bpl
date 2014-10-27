const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} acquired: int;

axiom acquired == 0;

const {:allocated} notAcquired: int;

axiom notAcquired == 1;

var {:scalar} SLAM_guard: int;

var {:scalar} accessState: int;

var alloc: int;

const alloc_init: int;

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

procedure init({:pointer} resource: int);

implementation init(resource: int)
{
	if (resource == SLAM_guard)
	{
		accessState := notAcquired;
	}
}

procedure lock({:pointer} resource: int);

implementation lock(resource: int)
{
	if (resource == SLAM_guard)
	{
		assert (accessState != acquired);
		accessState := acquired;
	}
}

procedure unlock({:pointer} resource: int);

implementation unlock(resource: int)
{
	if (resource == SLAM_guard)
	{
		assert (accessState == acquired);
		accessState := notAcquired;
	}
}

procedure SLAM_guard_example();

implementation SLAM_guard_example()
{
	var {:pointer} resource1: int;
	var {:pointer} resource2: int;
	
	assert {:sourcefile ".\src\file.c"} {:sourceline 0} {:print "Return"} true;
	call resource1 := __HAVOC_malloc(1);
	call resource2 := __HAVOC_malloc(1);
	SLAM_guard := resource1;
	call init(resource1);
	call init(resource2);
	call lock(resource1);
	call lock(resource2);
	call lock(resource1);
	call unlock(resource1);
}
