const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} STATUS_SUCCESS: int;

axiom STATUS_SUCCESS == 1;

const {:allocated} PASSIVE_LEVEL: int;

axiom PASSIVE_LEVEL == 0;

const {:allocated} APC_LEVEL: int;

axiom APC_LEVEL == 1;

const {:allocated} DISPATCH_LEVEL: int;

axiom DISPATCH_LEVEL == 2;

var {:scalar} {:typestatevar} sdv_irql_current: int;

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

procedure IoSetDeviceInterfaceState()
{
	if (sdv_irql_current != PASSIVE_LEVEL)
	{
		assert false;
	}
}

procedure {:entrypoint} t1394Diag_PnPRemoveDevice({:pointer} DeviceObject: int, {:scalar} Irp: int)
{	
	assert {:sourcefile ".\src\file.c"} {:sourceline 0} {:print "Return"} true;
	call IoSetDeviceInterfaceState();
}