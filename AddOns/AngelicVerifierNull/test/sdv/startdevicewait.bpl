const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} initial: int;

axiom initial == 0;

const {:allocated} set_in_completion: int;

axiom set_in_completion == 1;

const {:allocated} STATUS_SUCCESS: int;

axiom STATUS_SUCCESS == 0;

const {:allocated} STATUS_PENDING: int;

axiom STATUS_PENDING == 1;

var {:scalar} irp_event: int;

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

procedure KeInitializeEvent();

implementation KeInitializeEvent()
{
	irp_event := initial;
}

procedure IoCallDriver({:pointer} DeviceObject: int, {:pointer} Irp: int) returns ({:scalar} Status: int);

implementation IoCallDriver(DeviceObject: int, Irp: int) returns (Status: int)
{
	Status := STATUS_PENDING;
	return;
}

procedure KeWaitForSingleObject() returns ({:scalar} Status: int);

implementation KeWaitForSingleObject() returns (Status: int)
{
	Status := STATUS_SUCCESS;
}

procedure SLIC_KeWaitForSingleObject_exit({:scalar} Status: int);

implementation SLIC_KeWaitForSingleObject_exit(Status: int)
{
	if (Status == STATUS_SUCCESS && irp_event == set_in_completion)
	{
		assert false;
	}
}

procedure sdv_IoSetCompletionRoutine();

implementation sdv_IoSetCompletionRoutine()
{
	irp_event := set_in_completion;
}

procedure ToasterSendIrpSynchronously({:pointer} DeviceObject: int, {:pointer} Irp: int) returns ({:scalar} status: int);

implementation ToasterSendIrpSynchronously(DeviceObject: int, Irp: int) returns (status: int)
{
	var {:scalar} Status: int;

	assert {:sourcefile ".\src\incomplete1.c"} {:sourceline 0} {:print "Return"} true;
	call KeInitializeEvent();
	call sdv_IoSetCompletionRoutine();
	call status := IoCallDriver(DeviceObject, Irp);
	if (status == STATUS_PENDING)
	{
		call Status := KeWaitForSingleObject();
		call SLIC_KeWaitForSingleObject_exit(Status);
	}
	return;
}