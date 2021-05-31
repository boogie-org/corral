const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} acquired: int;

axiom acquired == 0;

const {:allocated} notAcquired: int;

axiom notAcquired == 1;

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


procedure ExAllocatePoolWithTag({:scalar} x0: int, {:scalar} x1: int, {:scalar} x2: int) returns ({:pointer} r: int);

procedure ExInitializeResourceLite({:pointer} x: int)
{
  anon0:
	assert {:sourcefile ".\src\cancel.c"} {:sourceline 0} {:print "Return"} true;
	accessState := notAcquired;
	goto Lfinal;

  Lfinal:
	return;
}

procedure {:origName "ExReleaseResourceLite"} ExReleaseResourceLite({:pointer} x: int)
{
	assert {:sourcefile ".\src\cancel.c"} {:sourceline 1} {:print "Return"} true;
	if(accessState == notAcquired)
	{
	   assert false;
	}
	else
	{
	   accessState := notAcquired;
    }

}

procedure {:origName "ExAcquireResourceExclusiveLite"} ExAcquireResourceExclusiveLite(Resource: int, Wait: int)
{
  anon0:
	assert {:sourcefile ".\src\cancel.c"} {:sourceline 2} {:print "Return"} true;
	goto anon0_Then, anon0_Else;

  anon0_Then:
	assume {:partition} accessState == acquired;
	assert false;
	goto Lfinal;

  anon0_Else:
	assume {:partition} accessState != acquired;
	accessState := acquired;
	goto Lfinal;

  Lfinal:
	return;
}

procedure {:origName "CsampCleanup_exit"} CsampCleanup_exit()
{
  anon0:
	assert {:sourcefile ".\src\cancel.c"} {:sourceline 3} {:print "Return"} true;
	goto anon0_Then, anon0_Else;

  anon0_Then:
	assume {:partition} accessState == acquired;
	assert false;
	goto Lfinal;

  anon0_Else:
	assume {:partition} accessState != acquired;
	goto Lfinal;

  Lfinal:
	return;
}

procedure {:origName "CsampCleanup"} CsampCleanup(DeviceObject: int, Irp: int) returns (Status: int)
{
  var {:pointer} badResource: int;

  anon0:
	assert {:sourcefile ".\src\cancel.c"} {:sourceline 4} {:print "Return"} true;
    call badResource := ExAllocatePoolWithTag(0,4,0);
    goto L0;

  L0:
    call ExInitializeResourceLite(badResource);
	goto L1;
	
  L1:
	call ExReleaseResourceLite(badResource);
	goto L2;

  L2:
	call ExAcquireResourceExclusiveLite(badResource,0);
    call ExAcquireResourceExclusiveLite(badResource,0);

  Lfinal:
	call CsampCleanup_exit();
	Status := 1;
    return;
}
