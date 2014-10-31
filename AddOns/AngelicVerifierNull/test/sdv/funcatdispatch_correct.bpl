const {:allocated} NULL: int;

axiom NULL == 0;

const {:allocated} PASSIVE_LEVEL: int;

axiom PASSIVE_LEVEL == 0;

const {:allocated} APC_LEVEL: int;

axiom APC_LEVEL == 1;

const {:allocated} DISPATCH_LEVEL: int;

axiom DISPATCH_LEVEL == 2;

var {:scalar} {:typestatevar} sdv_irql_current: int;

var {:scalar} PowerDeviceD0: int;

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

procedure {:origName "sdv_stub_power_completion_begin"} sdv_stub_power_completion_begin();

implementation {:origName "sdv_stub_power_completion_begin"} sdv_stub_power_completion_begin()
{
  anon0:
	assert {:sourcefile ".\src\power.c"} {:sourceline 0} {:print "Return"} true;
	sdv_irql_current := DISPATCH_LEVEL;
	goto Lfinal;

  Lfinal:
	return;
}

procedure {:origName "IoBuildDeviceIoControlRequest"} IoBuildDeviceIoControlRequest();

implementation {:origName "IoBuildDeviceIoControlRequest"} IoBuildDeviceIoControlRequest()
{
  anon0:
	assert {:sourcefile ".\src\power.c"} {:sourceline 0} {:print "Return"} true;
	goto anon0_Then, anon0_Else;

  anon0_Then:
	assume {:partition} sdv_irql_current != PASSIVE_LEVEL;
	goto anon1_Then, anon1_Else;

  anon1_Then:
	assume {:partition} sdv_irql_current != APC_LEVEL;
	assert false;
	goto Lfinal;

  anon1_Else:
	assume {:partition} sdv_irql_current == APC_LEVEL;
	goto Lfinal;

  anon0_Else:
	assume {:partition} sdv_irql_current == PASSIVE_LEVEL;
	goto Lfinal;

  Lfinal:
	return;
}

procedure {:origName "t1394_GetGenerationCount"} t1394_GetGenerationCount({:pointer} DeviceObject: int, {:pointer} Irp: int, {:scalar} GenerationCount: int);

implementation {:origName "t1394_GetGenerationCount"} t1394_GetGenerationCount(DeviceObject: int, Irp: int, GenerationCount: int)
{
  anon0:
	assert {:sourcefile ".\src\power.c"} {:sourceline 0} {:print "Return"} true;
	goto anon0_Then, anon0_Else;

  anon0_Then:
	assume {:partition} Irp == NULL;
	call IoBuildDeviceIoControlRequest();
	goto Lfinal;

  anon0_Else:
	assume {:partition} Irp != NULL;
	goto Lfinal;

  Lfinal:
	return;
}
  
var {:pointer} Mem_T.DeviceExtension: [int]int;

var {:pointer} Mem_T.DeviceObject: [int]int;

var {:scalar} Mem_T.DeviceState: [int]int;

var {:scalar} Mem_T.GenerationCount: [int]int;

var {:scalar} Mem_T.CurrentDevicePowerState: [int]int;

function {:inline true} {:fieldmap "Mem_T.DeviceExtension"} {:fieldname "DeviceExtension"} DeviceExtension(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject"} {:fieldname "DeviceObject"} DeviceObject(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeviceState"} {:fieldname "DeviceState"} DeviceState(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.GenerationCount"} {:fieldname "GenerationCount"} GenerationCount(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CurrentDevicePowerState"} {:fieldname "CurrentDevicePowerState"} CurrentDevicePowerState(x: int) : int
{
  x + 0
}
