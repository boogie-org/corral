const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} on: int;

axiom on == 0;

const {:allocated} off: int;

axiom off == 1;

const {:allocated} init: int;

axiom init == 0;

const {:allocated} check: int;

axiom check == 1;

const {:allocated} not_blocked: int;

axiom not_blocked == 0;

const {:allocated} blocked: int;

axiom blocked == 1;

const {:allocated} no: int;

axiom no == 0;

const {:allocated} yes: int;

axiom yes == 1;

const {:allocated} pending: int;

axiom pending == 2;

var {:scalar} irp_copy_next: int;

var {:scalar} irp_status: int;

var {:scalar} thread_status: int;

var {:scalar} return_state: int;

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

procedure IoCopyCurrentIrpStackLocationToNext();

implementation IoCopyCurrentIrpStackLocationToNext()
{
	irp_copy_next := on;
}

procedure IoSetCompletionRoutine();

implementation IoSetCompletionRoutine()
{
	irp_status := check;
}

procedure IoCallDriver();

implementation IoCallDriver()
{
	thread_status := not_blocked;
	if (irp_status == check)
	{
		return_state := yes;
	}
}

procedure sdv_stub_dispatch_end();

implementation sdv_stub_dispatch_end()
{
	if (return_state == yes)
	{
		assert false;
	}
}

procedure MouFilter_PnP({:pointer} DeviceObject: int, {:pointer} Irp: int);

implementation MouFilter_PnP(DeviceObject: int, Irp: int)
{
	assert {:sourcefile ".\src\moufiltr.c"} {:sourceline 0} {:print "Return"} true;
	call IoCopyCurrentIrpStackLocationToNext();
	call IoSetCompletionRoutine();
	call IoCallDriver();
	call sdv_stub_dispatch_end();
}
